local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_start()
  rogueMgr.ExQTETimes = 0
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_room_change(npc)
  rogueMgr.ExQTETimes = 0
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isExQte() then
    self.isExQte = true
    if rogueMgr.ExQTETimes < 10 then
      rogueMgr.ExQTETimes = rogueMgr.ExQTETimes + 1
    end
    cast_magic(self.npc, self.npc, 61713131, rogueMgr.ExQTETimes)
  end
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if kind < 2 or kind > 4 then
    return
  end
  if rogueMgr.ExQTETimes < 1 then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isExQte() then
    cast_magic(self.npc, self.npc, 61713131, rogueMgr.ExQTETimes)
  end
end

return M
