local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= get_come_on_hero() then
    return
  end
  if act:deemDash() then
    local function missile()
      cast_missile3(act.role.npc, nil, nil, nil, 61712910405, self.level)
    end
    
    local hero = act.role.npc:get_behavior()
    hero:doAfter(missile, 0.05)
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(70006) or 1
end

function M:on_start()
  tool:castMagicToTeam(rogueMgr.fragment_control)
  self.level = get_ability_level(70006) or 1
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

return M
