local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local qingdeng = 6170895

function M:on_skact_begin(npc, act)
  if act.role.npc ~= get_come_on_hero() then
    return
  end
  if act.role.npc ~= self.npc then
    return
  end
  if act:isHeavy() and get_npc_count_by_res_id(qingdeng) < 1 then
    local hero = act.role.npc
    local pos = {}
    local curr_energy = get_npc_attr(hero, 2)
    local max_energy = get_npc_attr(hero, 5)
    if max_energy - curr_energy <= 1 then
      pos = get_npc_pos(hero)
      add_npc2(1, qingdeng, pos.x, pos.z, pos.x, pos.z, 2, 1)
    end
  end
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  rogueMgr.level_6170835 = get_ability_level(50021) or 1
end

function M:on_room_change(npc)
  rogueMgr.level_6170835 = get_ability_level(50021) or 1
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:_init(npc)
end

return M
