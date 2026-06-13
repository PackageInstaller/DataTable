local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:on_room_change(npc)
  self.cast_record = {}
end

function M:_init(npc)
end

function M:on_start()
  cast_magic(self.npc, self.npc, 618010301, 1)
  self.cast_record = {}
end

function M:on_force_shift_end(caster, target, magic_id, is_success)
  if not is_success then
    return
  end
  if caster ~= self.npc then
    return
  end
  local kind = get_role_kind(target)
  if 2 == kind or 3 == kind or 4 == kind then
    if get_tough_record_state(target) and (not self.cast_record[target.uuid] or get_time() > self.cast_record[target.uuid].cast_time + 1) then
      self.cast_record[target.uuid] = {
        cast_time = get_time()
      }
      cast_magic(target, target, 618010303)
    elseif not get_tough_record_state(target) and (not self.cast_record[target.uuid] or get_time() > self.cast_record[target.uuid].cast_time + 1) then
      self.cast_record[target.uuid] = {
        cast_time = get_time()
      }
      cast_magic(target, target, 618010302)
    end
  end
end

function M:on_remove()
  abort_magic_by_id(self.npc, 618010301)
end

return M
