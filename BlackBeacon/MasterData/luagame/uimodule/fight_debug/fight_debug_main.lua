local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_toggle("Create_Monster", function(isOn)
    self:_onclick_create_tog(isOn)
  end, true)
  self:set_toggle("Add_Magic", function(isOn)
    self:_onclick_magic_tog(isOn)
  end, false)
  self:set_button("Timer", function()
    self:_onclick_timer_btn()
  end, false)
  self:set_toggle("Change_Attr", function(isOn)
    self:_onclick_attr_tog(isOn)
  end, false)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:set_button("RemoveAllNpcBtn", function()
    self:_remove_all_npcs()
  end)
  self.v_cur_view = self.v_panels.create_npc
end

function ui:_onclick_create_tog(isOn)
  self.v_cur_view:set_enable(false)
  self.v_panels.create_npc:set_enable(isOn)
  if true == isOn then
    self.v_cur_view = self.v_panels.create_npc
  end
end

function ui:_onclick_magic_tog(isOn)
  self.v_cur_view:set_enable(false)
  self.v_panels.add_magic:set_enable(isOn)
  if true == isOn then
    self.v_cur_view = self.v_panels.add_magic
  end
end

function ui:_onclick_timer_btn()
  local debug_fight_timer = UIMgr:get_ui("debug_fight_timer")
  if not debug_fight_timer:visible() then
    debug_fight_timer:ui_show()
  else
    debug_fight_timer:ui_hide()
  end
end

function ui:_onclick_attr_tog(isOn)
end

function ui:_remove_all_npcs()
  local npcs = SceneMgr:get_all_npc()
  local npc_tbl = {}
  for _, npc in pairs(npcs) do
    npc_tbl[npc] = true
  end
  for npc in pairs(npc_tbl) do
    SceneMgr:remove_npc(npc)
  end
  MsgGame:mq_publish2(Const.MSG_DEBUG_NPC_REFRESH)
end

return ui
