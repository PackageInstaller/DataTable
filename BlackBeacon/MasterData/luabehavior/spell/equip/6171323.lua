local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if kind < 2 or kind > 4 then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct:isQte() then
    cast_magic(self.npc, self.npc, 61713231)
  end
end

return M
