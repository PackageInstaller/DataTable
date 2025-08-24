local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ILLUSTARATED_ORN_SCREEN_TEMP = "ILLUSTARATED_ORN_SCREEN_TEMP"
local ILLUSTARATED_ORN_TEMP = "ILLUSTARATED_ORN_TEMP"
local ORNAMENT_ITEM_CLASS = require("uimodule.ornaments.ornament_item")
local SaticSv = require("ui.widget.static_scroll_view")
local TOTAL_GROUP_ID = -1

function ui:on_select_group(isOn, group_id)
  if not isOn or self.v_group_id == group_id then
    return
  end
  self.v_group_id = group_id
  self:refresh_select_group_info()
end

function ui:on_select_ornament(msg)
  local item = msg.mm_obj
  if self.v_select_orn_id == item.v_ornament_id then
    return
  end
  self.v_select_orn_id = item.v_ornament_id
  if self.v_static_sv and msg then
    local items = self.v_static_sv:get_items()
    for key, orn_item in pairs(items) do
      orn_item:set_selected(orn_item.v_ornament_id == self.v_select_orn_id)
    end
  end
  self:refresh_select_orn_info(item)
end

function ui:ui_finish_load()
  self:set_button("BtnAward", function()
    local task_group_id = ShareRes.get_curse_illustrated_task_group_by_type_id(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.ORNAMENT)
    UIMgr:get_ui("chapter_task"):ui_show(nil, task_group_id, "收集进度")
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self.v_group_obj_map = {}
  self:register_exist_auto_template(ILLUSTARATED_ORN_SCREEN_TEMP, self.v_uiobjects.ScreenTem, self.v_uiobjects.ScreenGroup)
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.OrnContent, ORNAMENT_ITEM_CLASS, ILLUSTARATED_ORN_TEMP)
  self.v_static_sv:set_batch_refresh(12, 0.1)
  self.v_static_sv:set_select_first_item(true)
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_redpoint, self)
  self:bind_auto_mq(Const.MSG_ON_ORNAMENT_SELECT, self.on_select_ornament, self)
  self.v_is_in_init = true
  self:refresh_group_tog()
  self:refresh_task_redpoint()
end

function ui:ui_on_hide()
  self.v_group_id = nil
  self.v_select_orn_id = nil
  UtilTable.clear_map(self.v_group_obj_map)
end

function ui:ui_on_destroy()
end

function ui:refresh_group_tog()
  local all_group_cfg = ShareRes.get_ornaments_group()
  local temp_list = {}
  local group_data
  for key, cfg in pairs(all_group_cfg) do
    group_data = ShareRes.get_ornaments_group_data(cfg.Id)
    if group_data and next(group_data) then
      table.insert(temp_list, cfg)
    end
  end
  temp_list[#temp_list + 1] = {Id = TOTAL_GROUP_ID, Priority = -1}
  table.sort(temp_list, function(a, b)
    if a.Priority ~= b.Priority then
      return a.Priority < b.Priority
    end
  end)
  self:give_back_auto_cache(ILLUSTARATED_ORN_SCREEN_TEMP)
  local obj, tog, icon, redpoint, first_tog, group_id
  for _, gruop_cfg in ipairs(temp_list) do
    group_id = gruop_cfg.Id
    if group_id == TOTAL_GROUP_ID then
      obj = self.v_uiobjects.ScreenAll
    else
      obj = self:get_auto_cache(ILLUSTARATED_ORN_SCREEN_TEMP)
    end
    tog = self:get_toggle(nil, obj)
    first_tog = first_tog or tog
    self:set_toggle_listener(tog, function(isOn)
      self:on_select_group(isOn, gruop_cfg.Id)
    end)
    tog.isOn = false
    if group_id ~= TOTAL_GROUP_ID then
      icon = self:get_image("Icon", obj)
      ResMgr:load_set_icon(icon, gruop_cfg.Icon)
    end
    redpoint = self:get_child_gameobj("RedPoint", obj)
    redpoint.gameObject:SetActive(false)
    self.v_group_obj_map[group_id] = obj
    self:refresh_tog_redpoint(obj, group_id)
  end
  self.v_is_in_init = false
  first_tog.isOn = false
  first_tog.isOn = true
end

function ui:refresh_all_tog_redpoint()
  for group_id, obj in pairs(self.v_group_obj_map) do
    self:refresh_tog_redpoint(obj, group_id)
  end
end

function ui:refresh_tog_redpoint(obj, group_id)
  local redpoint = self:get_child_gameobj("RedPoint", obj)
  redpoint.gameObject:SetActive(false)
end

function ui:refresh_task_redpoint()
  local task_group_id = ShareRes.get_curse_illustrated_task_group_by_type_id(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.ORNAMENT)
  local have_red = TaskMgr:get_task_group_red(task_group_id)
  local bg = self:get_child_gameobj("ActBg", self.v_uiobjects.BtnAward)
  if bg then
    bg.gameObject:SetActive(have_red)
  end
  self.v_uiobjects.RedPoint:SetActive(have_red)
end

function ui:refresh_select_group_info()
  local gourp_cfg = ShareRes.get_ornaments_group(self.v_group_id)
  local gourp_data = ShareRes.get_ornaments_group_data(self.v_group_id)
  self.v_uicompents.GroupName_txt.text = self.v_group_id == TOTAL_GROUP_ID and "全部" or gourp_cfg.Name
  local total_count = #gourp_data
  local unlock_total_count = 0
  local temp_list = {}
  local orn_unlock_data = FateBookMgr:get_illustrated_data(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.ORNAMENT)
  if not gourp_data then
    return
  end
  local cfg, orn_id
  for index = 1, total_count do
    orn_id = gourp_data[index]
    cfg = ShareRes.get_ornaments(orn_id)
    temp_list[#temp_list + 1] = cfg
    if orn_unlock_data[cfg.Id] then
      unlock_total_count = unlock_total_count + 1
    end
  end
  local srt = "（%d/%d）"
  self.v_uicompents.Progress_txt.text = string.format(srt, unlock_total_count, total_count)
  self.v_static_sv:update_list(temp_list)
end

function ui:refresh_select_orn_info(select_orn)
  local cfg = ShareRes.get_ornaments(select_orn.v_ornament_id)
  local is_unlock = select_orn.v_is_unlock
  self.v_uiobjects.OrnIconLock:SetActive(not is_unlock)
  self.v_uiobjects.OrnLock:SetActive(not is_unlock)
  self.v_uiobjects.OrnEffect:SetActive(is_unlock)
  self.v_uiobjects.OrnWorldDesc:SetActive(is_unlock)
  ResMgr:load_set_icon(self.v_uicompents.OrnIcon_img, cfg.Icon)
  Util.set_color(self.v_uicompents.OrnIcon_img, is_unlock and "FFFFFF" or "8E8E8E")
  self.v_uicompents.OrnName_txt.text = is_unlock and cfg.Name or "？？？"
  self.v_uicompents.OrnEffect_txt.text = cfg.Desc
  self.v_uicompents.OrnWorldDesc_txt.text = cfg.WorldDesc
end

function ui:cache_ui()
  return true
end

return ui
