local Base = require("ui.uibase")
local HeroClass = require("uimodule.fight_bag.hero_item")
local EquipItemClass = require("uimodule.fight_bag.equip_item")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local FightDefine = require("cs_share.fight_define")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local SaticSv = require("ui.widget.static_scroll_view")
local SvItem = require("uimodule.battle_skill.skill_show_item")
local commonDef = require("cs_share.common_define")
local CHAL_TYPE2FORMN_TYPE = commonDef.CHAL_TYPE2FORMN_TYPE
local NOT_PROGRESS_BATTLE_TYPE = Config.NOT_PROGRESS_BATTLE_TYPE
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local _tsort = table.sort
local BIND_TYPE = Config.BIND_TYPE
local TEMPLATE_KEY = {
  ATTR_ITEM = "ATTR_ITEM",
  CURRENCY_ITEM = "CURRENCY_ITEM",
  JOB_ITEM = "JOB_ITEM"
}
local ORDER = {
  [1] = "st",
  [2] = "nd",
  [3] = "rd"
}
local Talent_Tree = {
  [1] = "Talent_tree1",
  [2] = "Talent_tree2",
  [3] = "Talent_tree3"
}
local Skill_Type = {normal = 1, mastery = 2}
local HERO_ITEM_NUM = 6
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local ATTR_TYPE = FightDefine.ATTR_TYPE
local SHOW_HERO_ATTR = {
  [1] = FightDefine.ATTR_TYPE.CHAR_HP_MAX,
  [2] = FightDefine.ATTR_TYPE.CHAR_SP_MAX,
  [3] = FightDefine.ATTR_TYPE.CHAR_ATTACK,
  [4] = FightDefine.ATTR_TYPE.CHAR_PENETRATE,
  [5] = FightDefine.ATTR_TYPE.CHAR_DEFENSE
}
local SHOW_RES_TYPE = CHAPTER_CONFIG.FIGHT_RES_TYPE

local function skill_sort(a, b)
  if a.pos_id == b.pos_id then
    return a.idx > b.idx
  else
    return a.pos_id < b.pos_id
  end
end

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:close_ui()
  end)
  self:set_button("BtnTalent", function()
    UIMgr:get_ui("uibattle_talent"):ui_show()
  end)
  self:set_button("BtnRetreat", function()
    self:_onclick_retreat_btn()
  end)
  self:set_button("touch_reciver", function()
    self.v_choose_panel_list:on_select_change(nil)
    self.v_uiobjects.touch_reciver:SetActive(false)
  end)
  self:set_button("BtnSetting", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
  self:_init_hero_list_view()
  self:_init_attr_list_view()
  self:_init_currency_view()
  self.v_item_tips = self.v_panels.item_tip_view
  self.v_equip_tips = self.v_panels.equip_tip_view
  self.v_choose_panel_list = SaticSv:new(self, self.v_uiobjects.SkillList, SvItem, "BATTLE_SKILL_ITEM")
  self:register_exist_auto_template(TEMPLATE_KEY.JOB_ITEM, self.v_uiobjects.JobAttrItem, self.v_uiobjects.JobAttrs)
end

function ui:update_skill_show_list()
  self.v_skill_list = BattleSkillBookMgr:get_skill_list()
  local all_skill_cfg = ShareRes.create("battle.battle_skill")
  local _, team_list = FormationMgr:get_formation_info_by_id(self.v_formation_type)
  local buddyid2pos = {}
  for _, pos_data in pairs(team_list) do
    local pos = pos_data.pos
    local buddy_id = pos_data.buddy_id
    buddyid2pos[buddy_id] = pos
  end
  local skill_group = {}
  for idx, skill_id in pairs(self.v_skill_list) do
    local skill_cfg = all_skill_cfg[skill_id]
    local group_num = skill_cfg.SkillGroup
    local now_level = skill_cfg.SkillLevel
    local buddy_id = skill_cfg.BuddyId
    if group_num then
      skill_group[buddy_id] = skill_group[buddy_id] or {}
      local group = skill_group[buddy_id][group_num]
      if not group then
        skill_group[buddy_id][group_num] = {
          skill_id = skill_id,
          idx = idx,
          level = now_level
        }
      elseif now_level > group.level then
        group.skill_id = skill_id
        group.idx = idx
        group.level = now_level
      end
    end
  end
  local show_point = {}
  for _, now_group in pairs(skill_group) do
    for _, skill_point in pairs(now_group) do
      local skill_id = skill_point.skill_id
      local skill_cfg = all_skill_cfg[skill_id]
      local skill_type = skill_cfg.SkillType
      local skill_buddy_id = skill_cfg.BuddyId
      if skill_type == Skill_Type.mastery then
        local temp = {
          idx = skill_point.idx,
          skill_id = skill_id,
          pos_id = buddyid2pos[skill_buddy_id]
        }
        _tinsert(show_point, temp)
      end
    end
  end
  _tsort(show_point, skill_sort)
  local list = {}
  for i = 1, 20 do
    if not show_point[i] then
      break
    end
    local skill_id = show_point[i].skill_id
    local pos_id = show_point[i].pos_id
    local temp = {}
    if i <= 10 then
      temp.list_idx = 1
    else
      temp.list_idx = 2
    end
    temp.pos_id = pos_id
    temp.skill_cfg = all_skill_cfg[skill_id]
    _tinsert(list, temp)
  end
  self.v_choose_panel_list:update_list(list)
end

function ui:select_skill_item(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local data = msg.mm_obj
  local idx = data.idx
  local selected_item
  self.v_uiobjects.touch_reciver:SetActive(true)
  selected_item = self.v_choose_panel_list:get_item_by_idx(idx)
  self.v_choose_panel_list:on_select_change(selected_item)
end

function ui:_init_hero_list_view()
  self.v_hero_list = {}
  local str
  for i = 1, HERO_ITEM_NUM do
    str = "Hero" .. i
    self.v_hero_list[i] = HeroClass:ui_wrap(self, self.v_uiobjects[str], false)
  end
end

function ui:_init_attr_list_view()
  self.old_attr_list = {}
  local parent = self.v_uiobjects.AttrItem.transform.parent
  self:register_exist_auto_template(TEMPLATE_KEY.ATTR_ITEM, self.v_uiobjects.AttrItem, parent.gameObject)
end

function ui:_init_equip_view()
  local MODEL = {
    v_hero_id = {
      "HeroNum",
      BIND_TYPE.TEXT
    },
    v_hero_id_2 = {
      "HeroNum2",
      BIND_TYPE.TEXT
    },
    v_hero_icon = {
      "HeroChooseIcon",
      BIND_TYPE.IMAGE
    }
  }
  self:init_model(MODEL)
  self.v_equip_list = {}
  local str
  for i = 1, 6 do
    str = "HeroEquip" .. i
    self.v_equip_list[i] = EquipItemClass:ui_wrap(self, self.v_uiobjects[str], false)
  end
  self:set_button("BtnYuan", function()
    self:_onclick_case_btn()
  end)
end

function ui:_init_currency_view()
  self.v_currency_list = {}
  self:register_exist_auto_template(TEMPLATE_KEY.CURRENCY_ITEM, self.v_uiobjects.CurrTem, self.v_uiobjects.CurrTem.transform.parent.gameObject)
end

function ui:ui_on_show(formation_type)
  local fight_info = TowerMgr:get_fight_info()
  if not formation_type and fight_info then
    formation_type = CHAL_TYPE2FORMN_TYPE[fight_info.type]
  end
  self.v_formation_type = formation_type or commonDef.FORMATION_TYPE.NORMAL_TEAMS
  self:_refresh_hero_list()
  self:_regist_client_event()
  self:_refresh_currency_list()
  self:update_skill_show_list()
  self.v_uiobjects.HightLight:SetActiveEx(false)
  self:_pasue_game()
end

function ui:ui_on_hide()
  self.v_currency_list = {}
  self:_restart_game()
  self.v_choose_panel_list:clear()
  self.v_skill_list = nil
  self.v_select_hero = nil
end

function ui:ui_on_destroy()
  self.v_choose_panel_list = nil
end

function ui:close_ui()
  self:ui_hide()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_CLICK_HERO, self.response_click_hero_event, self)
  self:bind_auto_mq(Const.MSG_ON_CLICK_FIGHT_ITEM_TIPS, self.response_click_item_event, self)
  self:bind_auto_mq(Const.MSG_ON_TALENT_UPDATE, self.response_hero_attr_change_event, self)
  self:bind_auto_mq(Const.MSG_ON_CLOSE_FIGHT_ITEM_TIPS, self.response_close_item_tip_event, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self._refresh_currency_list, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_BAG_UPDATE, self.response_wear_equip_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_PAUSE_SKILL_ITEM_SELECTED, self.select_skill_item, self)
end

function ui:response_click_hero_event(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  self.v_select_hero_idx = msg.mm_obj.fight_pos
  self.v_select_hero = msg.mm_obj.hero
  self:_refresh_attr_list()
  if self.v_uiobjects.HightLight.activeSelf then
    for i = 1, 6 do
      local idx = 0 == i % 3 and 3 or i % 3
      self.v_hero_list[i]:onclick_hero(idx == self.v_select_hero_idx)
    end
  else
    for i = 1, 3 do
      self.v_hero_list[i]:onclick_hero(i == self.v_select_hero_idx)
    end
  end
end

function ui:response_click_item_event(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  self.v_uiobjects.HightLight:SetActiveEx(true)
  self.v_uiobjects.HeroEquipPanel:SetActiveEx(false)
  local index = self:get_show_hero_index(self.v_select_hero_idx)
  for i = 4, 6 do
    self.v_hero_list[i]:set_content_show(true)
    self.v_hero_list[i]:set_can_click()
    self.v_hero_list[i]:onclick_hero(index == i or index + 3 == i)
  end
  self.v_item_tips:set_enable(true, {
    item = msg.mm_obj.item_data,
    hero = self.v_select_hero,
    bag_pos = msg.mm_obj.bag_pos
  })
end

function ui:response_close_item_tip_event(msg)
  self.v_uiobjects.HightLight:SetActiveEx(false)
end

function ui:response_wear_equip_update_event(msg)
  if not self.v_select_hero then
    return
  end
  self:_refresh_attr_list()
end

function ui:get_show_hero_index(team_pos)
  local cur_fight_pos, team_list = FormationMgr:get_formation_info_by_id(self.v_formation_type)
  local come_on = {}
  for k, v in pairs(team_list) do
    if v.buddy_id and 0 ~= v.buddy_id then
      table.insert(come_on, v.pos)
    end
  end
  table.sort(come_on, function(a, b)
    return a < b
  end)
  for index, pos in ipairs(come_on) do
    if pos == team_pos then
      return index
    end
  end
end

function ui:_refresh_hero_list()
  for _, ui in pairs(self.v_hero_list) do
    ui:set_enable(false)
  end
  local list = SceneMgr:get_hero_list()
  self.v_hero_num = UtilTable.hash_lenth(list)
  local cur_fight_pos, team_list = FormationMgr:get_formation_info_by_id(self.v_formation_type)
  for uuid, hero in pairs(list) do
    for _, team in pairs(team_list) do
      if team.buddy_id == hero.buddy_cfg.ModelId and self.v_hero_list[team.pos] ~= nil then
        self.v_hero_list[team.pos]:set_enable(true, {
          fight_pos = team.pos,
          hero = hero
        })
        local index = self:get_show_hero_index(team.pos)
        self.v_hero_list[index + 3]:set_enable(true, {
          fight_pos = team.pos,
          hero = hero,
          copy = true
        })
      end
    end
  end
end

function ui:_refresh_attr_list()
  if not self.v_select_hero then
    return
  end
  local buddy_cfg = self.v_select_hero.buddy_cfg
  local cur_char_id = buddy_cfg.ModelId
  local attr_list = self.v_select_hero.attr_mgr.attrs
  local equip_attr = FightBagMgr:get_hero_equip_attr_list()
  self:give_back_auto_cache(TEMPLATE_KEY.ATTR_ITEM, false)
  self.old_attr_list = {}
  local character_cfg = ShareRes.create("buddy.buddy", buddy_cfg.Id)
  local show_fight_res_type = character_cfg.ShowFightResType
  if show_fight_res_type == SHOW_RES_TYPE.FIGHT_ENERGY then
    SHOW_HERO_ATTR[2] = ATTR_TYPE.CHAR_SP_MAX
  elseif show_fight_res_type == SHOW_RES_TYPE.FIGHT_ANGER then
    SHOW_HERO_ATTR[2] = ATTR_TYPE.CHAR_FIGHT_LINE_BAR_MAX
  end
  local show_list = {}
  for k, v in pairs(SHOW_HERO_ATTR) do
    show_list[v] = {attr_id = v, sort_id = k}
  end
  local count = 6
  for k, v in pairs(equip_attr) do
    if nil == show_list[k] then
      count = count + 1
      show_list[k] = {attr_id = k, sort_id = count}
    end
  end
  local tb = {}
  for k, v in pairs(show_list) do
    table.insert(tb, v)
  end
  table.sort(tb, function(a, b)
    return a.sort_id < b.sort_id
  end)
  for _, v in pairs(tb) do
    local attrId = v.attr_id
    local attrValue = attr_list[attrId]
    local obj = self:get_auto_cache(TEMPLATE_KEY.ATTR_ITEM)
    local attrNameTxt = self:get_text("Name", obj)
    local attrValueTxt = self:get_text("Date", obj)
    attrNameTxt.text = ShareRes.equip_attr_str(attrId) or "XX"
    attrValueTxt.text = math.ceil(attrValue)
    self.old_attr_list[attrId] = attrValue
  end
end

function ui:_refresh_currency_list()
  for idx, v in pairs(bagConfig.SHOW_CURRENCY) do
    if not self.v_currency_list[idx] then
      local obj = self:get_auto_cache(TEMPLATE_KEY.CURRENCY_ITEM)
      self.v_currency_list[idx] = obj
    end
    self:_set_currency(self.v_currency_list[idx], idx)
  end
end

function ui:_set_currency(obj, index)
  if nil == obj then
    Log.Error("获取货币item对象失败！！！")
    return
  end
  obj:SetActiveEx(true)
  local data = bagConfig.SHOW_CURRENCY[index]
  local cfg = FightBagMgr:get_cfg_by_id(data)
  local moneyIcon = self:get_image("CurrIcon", obj)
  ResMgr:load_set_icon(moneyIcon, string.format(ITEM_ICON_PATH, cfg.Icon))
  local moneyNum = self:get_text("CurrAmount", obj)
  moneyNum.text = CharacterMgr:get_res_val(data)
end

function ui:_onclick_case_btn()
end

function ui:_onclick_retreat_btn()
  local fight_info = TowerMgr:get_fight_info()
  if fight_info and fight_info.type == commonDef.CHALLENGE_TYPE.BEST_CONF then
    self:_exit_top_ver_tower()
  else
    self:_exit_tower(fight_info)
  end
end

function ui:_pasue_game()
  SceneMgr:set_game_pause(true)
end

function ui:_restart_game()
  if UIMgr:try_get_visible_ui("floor_settle") then
    return
  end
  SceneMgr:set_game_pause(false)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_formation_type
end

function ui:_set_job_attr(obj, cfg, attr_id)
  local icon = self:get_image("Icon", obj)
  ResMgr:load_set_icon(icon, string.format("UIChar/%s", cfg.IconName))
  local name = self:get_text("Name", obj)
  local attr_name = ShareRes.get_buddy_attr_name(attr_id)
  name.text = attr_name
  local amount = self:get_text("Amount", obj)
  local val = 0
  local list = SceneMgr:get_hero_list()
  for _, hero in pairs(list) do
    local attrs = hero.attr_mgr.attrs
    val = val + attrs[cfg.AttrId]
  end
  amount.text = val
end

function ui:_exit_top_ver_tower()
  local tip = Util.format_str("是否立即退出关卡")
  local sure_btn = Util.format_str("直接结算")
  
  local function sure_callback()
    UIMgr:get_ui("top_ver_settlement"):ui_show()
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip, sure_btn)
end

function ui:_exit_tower(fight_info)
  local tip = Util.format_str("是否立即退出关卡")
  local sure_btn = Util.format_str("中继保存")
  local cancel_btn = Util.format_str("直接结算")
  
  local function sure_callback()
    self:close_ui()
    
    local function cb()
      Global.scene_mgr:on_enter_main_scene()
      UIMgr:revert_cache_ui()
    end
    
    if TowerMgr then
      TowerMgr:on_exit_tower(cb)
    end
  end
  
  local function cancel_callback()
    if fight_info and NOT_PROGRESS_BATTLE_TYPE[fight_info.type] then
      UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
    else
      UIMgr:get_ui("fight_settlement"):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
    end
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, tip, sure_btn, cancel_btn)
end

return ui
