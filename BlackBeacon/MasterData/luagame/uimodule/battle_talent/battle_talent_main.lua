local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Talent_Cfg = require("uimodule.battle_talent.battle_talent_cfg")
local ToggleTabClass = require("ui.widget.widget_toggle_tab")
local CurrentyClass = require("uimodule.battle_shop.local_widget.shop_item_currency_view")
local SimpleListClass = require("uimodule.battle_shop.local_widget.simple_sv_list")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local StaicSv = require("ui.widget.static_scroll_view")
local Talent_Item = require("uimodule.battle_talent.talent_item")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local _tinsert = table.insert
local JOB_ICON_PREFIX = "Icon/HeroType/%s"
local Cs_color = UnityEngine.Color
local util_get_color = Util.get_unity_color_by_hex
local Toggle_select_color = Cs_color(0, 0, 0)
local Toggle_unselect_color = util_get_color(tonumber("BeBeBe", 16))
local sub_point_txt_select = util_get_color(tonumber("349ad9", 16))
local sub_point_txt_unselect = util_get_color(tonumber("595959", 16))
local btn_select = Cs_color(0, 0, 0)
local btn_unselect = Cs_color(1, 1, 1)
local TOGGLE_SETTING = {
  [1] = "CareerName",
  [2] = "CareerTalentActive",
  [3] = "CareerTalentMax",
  [4] = "line"
}
local MODEL = {
  v_talent_content_obj = {
    "Talent_content",
    BIND_TYPE.OBJECT
  },
  v_talent_template1_obj = {
    "TalentTem1",
    BIND_TYPE.OBJECT
  },
  v_talent_viewpoint_obj = {
    "Talent_viewport",
    BIND_TYPE.OBJECT
  },
  v_talent_context_obj = {
    "TalentContext",
    BIND_TYPE.OBJECT
  },
  v_talent_context_template_obj = {
    "Effect_text",
    BIND_TYPE.OBJECT
  },
  v_talent_TalentInfo_obj = {
    "TalentInfo",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnActive", function()
    self:click_active_talent()
  end)
  self:set_button("Talent_content", function()
    self:click_content_background()
  end)
  self.v_currenct_view = SimpleListClass:new(self, self.v_uiobjects.CurrList, CurrentyClass, 1, "FIGHT_TALENT_CURRENCY")
  self.v_talent_item_list = StaicSv:new(self, self.v_uiobjects.Talent_content, Talent_Item, "TALENT_ITEM")
  self:register_exist_auto_template(Talent_Cfg.BATTLE_TALENT_CONTEXT_ITEM_KEY, self.v_uiobjects.Effect_text, self.v_uiobjects.TalentContext)
end

function ui:ui_on_show()
  self:init_toggle_list()
  self.v_tree_node_list = BattleTalentMgr:get_tree_point_list()
  self.v_select_point = nil
  self.v_talent_temp_item = nil
  self.v_xoffset_num = 1
  self:response_currency_update_event()
  self:refresh_view()
  self:register_event()
end

function ui:ui_on_hide()
  self.v_talent_TalentInfo_obj:SetActive(false)
  self.v_tree_node_list = nil
  self.v_select_point = nil
  self.v_talent_temp_item = nil
  self.v_xoffset_num = nil
  self.v_talent_item_list:clear()
end

function ui:ui_on_destroy()
  self.v_job_toggle_tab = nil
  self.v_currenct_view = nil
  self.v_talent_item_list = nil
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_TALENT_UPDATE, self.update_talent_point_active_state, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self.response_currency_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_TALENT_ITEM_SELECTED, self.on_selected_item, self)
  self:bind_auto_mq(Const.MSG_ON_UNLOCK_TALENT_TREE, self.click_lock_submit, self)
end

function ui:init_toggle_list()
  local select_idx = BattleTalentMgr:get_select_idx()
  local character_job_cfg = ShareRes.create(Talent_Cfg.BUDDY_JOB_CFG_PATH)
  self.v_career_list = BattleTalentMgr:get_career_list()
  self.v_job_tag_toggles = {}
  for i = 1, 3 do
    self.v_uiobjects["Career" .. i]:SetActive(false)
  end
  for idx, career_id in pairs(self.v_career_list) do
    local job_data = character_job_cfg[career_id]
    local job_name = job_data.JobName
    local icon_path = string.format(JOB_ICON_PREFIX, job_data.JobIcon)
    local career_obj = self.v_uiobjects["Career" .. idx]
    local career_name_txt = Util.get_text("NotEmpty" .. idx .. "/CareerName" .. idx, career_obj)
    local career_icon_img = Util.get_image("NotEmpty" .. idx .. "/CareerIcon" .. idx, career_obj)
    local color = Toggle_unselect_color
    if idx == select_idx then
      color = Toggle_select_color
    end
    career_name_txt.text = job_name
    career_name_txt.color = color
    ResMgr:load_set_icon(career_icon_img, icon_path)
    for _, name in pairs(TOGGLE_SETTING) do
      Util.get_text("NotEmpty" .. idx .. "/" .. name .. idx, career_obj).color = color
    end
    career_icon_img.color = color
    self.v_uiobjects["Career" .. idx]:SetActive(true)
    _tinsert(self.v_job_tag_toggles, self.v_uicompents["Career" .. idx .. "_tog"])
  end
  self.v_job_toggle_tab = ToggleTabClass:new(self)
  self.v_job_toggle_tab:init_by_toggles(self.v_job_tag_toggles, function(cur_select, pre_select, cur_toggle, pre_toggle)
    self:select_job_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  end)
  self.v_job_toggle_tab:set_toggle_by_index(select_idx)
end

function ui:refresh_view()
  self.v_uiobjects.TalentInfo:SetActive(false)
  local talent_tree_cfg = ShareRes.create("fight_talent.fight_talent_tree")
  local career_tree = BattleTalentMgr:get_career_tree()
  local career_list = self.v_career_list
  local select_idx = BattleTalentMgr:get_select_idx()
  for idx, career_id in pairs(career_list) do
    local tree_data = career_tree[career_id]
    Util.get_text("NotEmpty" .. idx .. "/CareerTalentActive" .. idx, self.v_uiobjects["Career" .. idx]).text = tree_data.active_point_num
    Util.get_text("NotEmpty" .. idx .. "/CareerTalentMax" .. idx, self.v_uiobjects["Career" .. idx]).text = tree_data.max_height
  end
  local career_id = career_list[select_idx]
  local now_career_tree = career_tree[career_id]
  local tree_height = now_career_tree.max_height
  local display_tree = now_career_tree.display_tree
  local temp = {}
  local tree_not_lock = now_career_tree.Not_Lock
  local active_tree_num = BattleTalentMgr:get_active_tree_num()
  if not tree_not_lock then
    local lock_point = {}
    for _, tree_cfg in pairs(talent_tree_cfg) do
      local tree_career = tree_cfg.Career
      if tree_career == career_id then
        lock_point.ItemCount = tree_cfg.Cost[active_tree_num].ItemCount or 0
        lock_point.lock = true
        break
      end
    end
    for i = 1, 9 do
      if 5 == i then
        _tinsert(temp, {point_cfg = lock_point})
      else
        _tinsert(temp, {})
      end
    end
  end
  for i = 1, tree_height do
    for j = 1, 9 do
      local layer = display_tree[i]
      if not layer then
        _tinsert(temp, {})
      else
        local point = layer[j]
        if point then
          point.Not_Lock = tree_not_lock
          _tinsert(temp, point)
        else
          _tinsert(temp, {})
        end
      end
    end
  end
  self.v_talent_temp_item = temp
  self.v_talent_item_list:update_list(temp)
end

function ui:refresh_talent_context(data)
  local tree_not_lock = BattleTalentMgr:is_talent_tree_unlock()
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local root_is_acess = true
  local point_cfg = data.point_cfg
  local talent_name = point_cfg.Name
  local cost_amount = point_cfg.ItemCount
  local talent_content = point_cfg.EffectDesc
  local sub_list = data.sub_list
  local state = data.state
  local talent_info_obj = uobj.TalentInfo
  local talent_name_txt = ucom.TalentName_txt
  local cost_amount_txt = ucom.CostAmount_txt
  local talent_content_txt = ucom.TalentContent_txt
  local active_btn_obj = uobj.BtnActive
  local active_btn = ucom.BtnActive_btn
  local active_img = ucom.BtnActive_img
  local active_button_txt = Util.get_text("Text", active_btn_obj)
  talent_info_obj:SetActive(true)
  active_btn_obj:SetActive(true)
  active_img.enabled = true
  talent_name_txt.text = Util.format_str(talent_name)
  cost_amount_txt.text = cost_amount
  talent_content_txt.text = talent_content
  active_button_txt.text = Util.format_str("激活")
  active_button_txt.color = btn_unselect
  active_btn.interactable = true
  if not tree_not_lock then
    active_btn.interactable = false
    active_img.enabled = false
    active_button_txt.text = Util.format_str("不可激活")
    active_button_txt.color = btn_select
  end
  if state == Talent_Cfg.TALENT_POINT_STATE.ACTIVE then
    root_is_acess = false
  end
  if state == Talent_Cfg.TALENT_POINT_STATE.UNSELECT then
    active_btn_obj:SetActive(false)
  end
  self:give_back_auto_cache(Talent_Cfg.BATTLE_TALENT_CONTEXT_ITEM_KEY)
  local active_num = 0
  local first_acess = false
  for height, sub_point in pairs(sub_list) do
    local item = self:get_auto_cache(Talent_Cfg.BATTLE_TALENT_CONTEXT_ITEM_KEY)
    local desc_txt = Util.get_text(nil, item)
    local sub_state = sub_point.state
    cost_amount = sub_point.point_cfg.ItemCount
    local desc = Util.format_str(sub_point.point_cfg.EffectDesc)
    local pre_txt = Util.format_str("{1}级:", height)
    desc_txt.text = pre_txt .. desc
    local color = sub_point_txt_unselect
    if sub_state == Talent_Cfg.TALENT_POINT_STATE.ACTIVE then
      root_is_acess = false
      color = sub_point_txt_select
      active_num = active_num + 1
    elseif sub_state == Talent_Cfg.TALENT_POINT_STATE.ACESS and not first_acess and not root_is_acess then
      first_acess = true
      cost_amount_txt.text = cost_amount
    end
    desc_txt.color = color
  end
  if state == Talent_Cfg.TALENT_POINT_STATE.ACESS then
    return
  end
  local list_length = UtilTable.hash_lenth(sub_list)
  if active_num < list_length then
    active_button_txt.text = Util.format_str("升级")
  else
    active_btn.interactable = false
    active_img.enabled = false
    active_button_txt.text = Util.format_str("不可激活")
    active_button_txt.color = btn_select
  end
end

function ui:update_talent_point_active_state()
  self:refresh_view()
end

function ui:click_active_talent()
  local point = self.v_select_point
  if nil == point then
    Util.show_message_tip(2134)
    return
  end
  local state = point.state
  if state == Talent_Cfg.TALENT_POINT_STATE.UNSELECT then
    Util.show_message_tip(2135)
    return
  end
  local sub_list = point.sub_list
  local is_acess = false
  local talent_id
  if state == Talent_Cfg.TALENT_POINT_STATE.ACESS then
    talent_id = point.point_cfg.TalentId
  elseif state == Talent_Cfg.TALENT_POINT_STATE.ACTIVE then
    for _, sub_point in pairs(sub_list) do
      local sub_state = sub_point.state
      if sub_state == Talent_Cfg.TALENT_POINT_STATE.ACESS then
        is_acess = true
        talent_id = sub_point.point_id
        break
      end
    end
    if not is_acess then
      Util.show_message_tip(2136)
      return
    end
  end
  local talent_tree_id, career_id = BattleTalentMgr:get_select_tree_data()
  local temp = {
    talent_tree_id = talent_tree_id,
    career = career_id,
    talent_id = talent_id
  }
  BattleTalentMgr:on_activate_battle_talent(temp)
end

function ui:click_content_background()
  self.v_talent_TalentInfo_obj:SetActive(false)
  self.v_talent_item_list:on_select_change(false)
end

function ui:select_job_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  self.v_talent_TalentInfo_obj:SetActive(false)
  BattleTalentMgr:set_select_idx(cur_select)
  local pre_toggle_obj = pre_toggle.gameObject
  local cur_toggle_obj = cur_toggle.gameObject
  for _, name in pairs(TOGGLE_SETTING) do
    Util.get_text("NotEmpty" .. pre_select .. "/" .. name .. pre_select, pre_toggle_obj).color = Toggle_unselect_color
    Util.get_text("NotEmpty" .. cur_select .. "/" .. name .. cur_select, cur_toggle_obj).color = Toggle_select_color
  end
  Util.get_image("NotEmpty" .. pre_select .. "/CareerIcon" .. pre_select, pre_toggle_obj).color = Toggle_unselect_color
  Util.get_image("NotEmpty" .. cur_select .. "/CareerIcon" .. cur_select, cur_toggle_obj).color = Toggle_select_color
  self.v_talent_item_list:clear()
  self:refresh_view()
end

function ui:response_currency_update_event()
  local tb = BagCfg.SHOW_CURRENCY
  self.v_currenct_view:update_list(tb)
end

function ui:on_selected_item(msg)
  local data = msg.mm_obj
  local select_idx = data.idx
  local select_item = self.v_talent_item_list:get_item_by_idx(select_idx)
  self.v_talent_item_list:on_select_change(select_item)
  self:refresh_talent_context(data)
  self:refresh_context()
  self.v_select_point = data
end

function ui:click_lock_submit()
  Util.show_conform_tip("确认后将不可撤销，是否确认？", nil, nil, nil, function()
    local talent_tree_id = BattleTalentMgr:get_select_tree_data()
    BattleTalentMgr:on_activate_talent_tree(talent_tree_id)
  end)
end

function ui:refresh_context()
  local rect = Util.get_rect_transform(nil, self.v_uiobjects.TalentContext)
  LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
end

return ui
