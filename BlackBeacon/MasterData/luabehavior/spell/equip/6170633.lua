local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local is_init = false

function M.onPerfectDash(role)
  cast_magic(role.npc, role.npc, rogueMgr.huisu)
  local level = get_ability_level(20019) or 1
  if level > 1 then
    cast_magic(role.npc, role.npc, rogueMgr.huisu_heal)
  end
end

function M.red_skill_counter_fragile(role, attackerNpc, victimNpc)
  if attackerNpc.id == role.id then
    cast_magic(attackerNpc, attackerNpc, rogueMgr.huisu)
    local level = get_ability_level(20019) or 1
    if level > 1 then
      cast_magic(attackerNpc, attackerNpc, rogueMgr.huisu_heal)
    end
  end
end

function M:on_fate_book_battle_start()
  if not is_init then
    local unit = self.npc:get_behavior()
    if not unit then
      return
    end
    tool.insert(unit, "onPdashSlomo", self.onPerfectDash)
    tool.insert(unit, "on_red_skill_countered", self.red_skill_counter_fragile)
    is_init = true
  end
end

function M:on_remove()
  local unit = self.npc:get_behavior()
  if not unit then
    return
  end
  tool.remove(unit, "on_red_skill_countered", self.red_skill_counter_fragile)
  tool.remove(unit, "onPdashSlomo", self.onPerfectDash)
end

function M:_init(npc)
end

return M
