local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local TEMPLATE_KEY = {
  CREATE_MONSTER_ITEM = "CREATE_MONSTER_ITEM",
  CUR_MONSTER_ITEM = "CUR_MONSTER_ITEM"
}

function M:ui_finish_load()
  local create_temp = self.v_uiobjects.Create_Npc_Item
  self:register_exist_auto_template(TEMPLATE_KEY.CREATE_MONSTER_ITEM, create_temp, create_temp.transform.parent.gameObject)
  local cur_temp = self.v_uiobjects.Cur_Npc_Item
  self:register_exist_auto_template(TEMPLATE_KEY.CUR_MONSTER_ITEM, cur_temp, cur_temp.transform.parent.gameObject)
  self:set_button("AddMonsterBtn", function()
    self:on_click_add_monster_btn()
  end)
end

function M:ui_on_show()
  self:_refresh_create_npc_list()
  self:_refresh_cur_npc_list()
  self:bind_auto_mq(Const.MSG_DEBUG_NPC_REFRESH, self._refresh_cur_npc_list, self)
end

function M:ui_on_hide()
end

function M:_regist_client_event()
end

function M:_refresh_create_npc_list()
  local list = ShareRes.create("fight_debug.monster")
  for _, v in pairs(list) do
    local obj = self:get_auto_cache(TEMPLATE_KEY.CREATE_MONSTER_ITEM)
    local name = self:get_text("Npc_Name", obj)
    name.text = v.monster_name
    local lv_input = self:get_inputfield("Level_Input", obj)
    local num_input = self:get_inputfield("Num_Input", obj)
    local magic_input = self:get_inputfield("Magic_Input", obj)
    local tag_input = self:get_inputfield("Tag_Input", obj)
    local add = self:get_button("AddBtn", obj)
    self:set_button_listener(add, function()
      local hero_x, hero_y, hero_z = Global.hero:get_pos()
      local num = tonumber(num_input.text) or 1
      local lv = tonumber(lv_input.text)
      local magic_id = tonumber(magic_input.text)
      local tag = tonumber(tag_input.text)
      for _ = 1, num do
        local npc = SceneMgr:create_npc(v.monster_id, hero_x + 5, hero_y, hero_z + 5, 10, 10, Config.CAMPS.ENEMY, lv)
        if nil ~= magic_id then
          npc.magic_mgr:add_magic(npc, magic_id, nil, nil)
        end
        if tag then
          npc:special_tag(tag)
        end
      end
      self:_refresh_cur_npc_list()
    end)
  end
end

function M:_refresh_cur_npc_list()
  local list = SceneMgr:get_all_npc()
  self:give_back_auto_cache(TEMPLATE_KEY.CUR_MONSTER_ITEM, false)
  if nil == list or nil == next(list) then
    return
  end
  for _, npc in pairs(list) do
    local obj = self:get_auto_cache(TEMPLATE_KEY.CUR_MONSTER_ITEM)
    local name = self:get_text("Npc_Name", obj)
    name.text = npc:get_name()
    local removeAll = self:get_button("RemoveAllBtn", obj)
    self:set_button_listener(removeAll, function()
      self:_remove_all_npc(npc)
      self:_refresh_cur_npc_list()
    end)
    local remove = self:get_button("RemoveBtn", obj)
    self:set_button_listener(remove, function()
      SceneMgr:remove_npc(npc)
      self:_refresh_cur_npc_list()
    end)
  end
end

function M:_remove_all_npc(npc)
  local list = SceneMgr:get_all_npc()
  for k, v in pairs(list) do
    if v.character_cfg.ModelId == npc.character_cfg.ModelId then
      SceneMgr:remove_npc(v)
    end
  end
end

function M:on_click_add_monster_btn()
  local input = self:get_inputfield(nil, self.v_uiobjects.MonsterID)
  local x, y, z = Global.hero:get_pos()
  if not Util.is_empty(input.text) then
    SceneMgr:create_npc(tonumber(input.text), x + 1, y, z + 1, 10, 10, Config.CAMPS.ENEMY)
  end
end

return M
