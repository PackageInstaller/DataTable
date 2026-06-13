local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local MAX_NUM = 50
local PAGE_COUNT = 5
local INFO_ITEM_TEMP = "INFO_ITEM_TEMP"

local function srot(a, b)
  if a.id ~= b.id then
    return a.id < b.id
  elseif a.missile_id ~= b.missile_id then
    return a.missile_id < b.missile_id
  else
    return false
  end
end

function ui:ui_finish_load()
  self:register_exist_auto_template(INFO_ITEM_TEMP, self.v_uiobjects.MissileInfoItem, self.v_uiobjects.Content)
  self:set_button("LeftBtn", function()
    self.v_select = math.max(1, self.v_select - 1, 1)
    self:refresh_start_end_count()
    self:clear_obj()
    self:refresh_view()
  end)
  self:set_button("RightBtn", function()
    self.v_select = math.min(self.v_select + 1, MAX_NUM)
    self:refresh_start_end_count()
    self:clear_obj()
    self:refresh_view()
  end)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self.v_missile_list = {}
  self.v_obj_list = {}
end

function ui:ui_on_show()
  self.v_select = 1
  self:refresh_start_end_count()
  self:build_missile_list()
  self:refresh_view()
end

function ui:ui_on_hide()
  self:clear_obj()
  UtilTable.clear_list(self.v_missile_list)
  UtilTable.clear_list(self.v_obj_list)
  self:give_back_auto_cache(INFO_ITEM_TEMP)
end

function ui:ui_on_update()
  self:build_missile_list()
  self:refresh_view()
end

function ui:build_missile_list()
  UtilTable.clear_list(self.v_missile_list)
  local map = SceneMgr:get_missile_map()
  for key, missile in pairs(map) do
    table.insert(self.v_missile_list, missile)
  end
  table.sort(self.v_missile_list, srot)
end

function ui:refresh_view()
  local obj
  local active_count = 0
  for index, missile in ipairs(self.v_missile_list) do
    if index >= self.v_start_count and index <= self.v_end_count then
      obj = self:get_obj(index)
      obj:SetActive(true)
      self:refresh_missile_info_obj(obj, missile)
      active_count = active_count + 1
    elseif index > self.v_end_count then
      break
    end
  end
  self:give_back_useless_obj(active_count)
end

function ui:refresh_start_end_count()
  self.v_start_count = (self.v_select - 1) * PAGE_COUNT
  self.v_end_count = self.v_select * PAGE_COUNT
  self.v_uicompents.AmountTxt_txt.text = string.format("%s/%s", self.v_select, MAX_NUM)
end

function ui:give_back_useless_obj(active_count)
  local cur_count = #self.v_obj_list
  if active_count < cur_count then
    for index = cur_count, active_count + 1, -1 do
      self.v_obj_list[index]:SetActive(false)
    end
  end
end

function ui:clear_obj()
  local cur_count = #self.v_obj_list
  for index = 1, cur_count do
    self.v_obj_list[index]:SetActive(false)
  end
end

function ui:get_obj(index)
  if not self.v_obj_list[index] then
    self.v_obj_list[index] = self:get_auto_cache(INFO_ITEM_TEMP)
  end
  return self.v_obj_list[index]
end

function ui:refresh_missile_info_obj(obj, missile)
  local target = missile:get_target()
  local owner = missile:get_owner()
  local time = missile:get_missile_remain_time()
  local magic = missile.missile_cfg.magic
  local MissileId = Util.get_text("MissileId", obj)
  MissileId.text = missile.missile_id
  local UUid = Util.get_text("UUid", obj)
  UUid.component.text = missile.id
  local Owner = Util.get_text("Owner", obj)
  Owner.component.text = owner and owner:get_npc_id()
  local Target = Util.get_text("Target", obj)
  Target.component.text = target and (target:is_missile() and target.missile_id or target:get_npc_id())
  local Time = Util.get_text("Time", obj)
  Time.component.text = time
  local Magic = Util.get_text("Magic", obj)
  Magic.component.text = table.concat(magic, ",")
end

function ui:refresh_journal()
end

return ui
