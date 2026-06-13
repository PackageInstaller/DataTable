local M = Util.create_class()
local time_sphere = get_god_npc()
local time_sphere_skill = 617069104
local is_ready = false
local tool = import("common.tool")

function M:_init(npc)
end

function M:on_magic_begin(npc, target, magic_id, is_self, magic_level)
  if 6170691002 == magic_id then
    is_ready = true
  end
end

function M:listen_perfect_dash()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.insert(role, "onPdashSlomo", self.onPerfectDash)
end

function M.onPerfectDash(role)
  if true == is_ready then
    cast_skill(time_sphere, time_sphere, time_sphere_skill)
    is_ready = false
  end
end

function M:on_start()
  self:listen_perfect_dash()
end

return M
