local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  rogueMgr.init_time_6171125 = get_npc_time(get_god_npc())
  rogueMgr.cd_6171125 = 0
  self.level = get_ability_level(10016) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10016) or 1
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isQteInput() and get_npc_time(get_god_npc()) > rogueMgr.init_time_6171125 + rogueMgr.cd_6171125 then
    cast_magic(self.npc, self.npc, 61711251, self.level)
    rogueMgr.cd_6171125 = 10
    rogueMgr.init_time_6171125 = get_npc_time(get_god_npc())
  end
end

function M:_init(npc)
end

return M
