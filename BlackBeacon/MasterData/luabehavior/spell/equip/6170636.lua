local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local rogueMgr = import("common.rogueManager")

function M:on_target_self_magic_end(npc, magic_id, magic_kind, magic_type, is_break)
  if 61706361 == magic_id and check_magic(self.npc, rogueMgr.weilai) and check_magic(self.npc, rogueMgr.huisu) then
    cast_magic(self.npc, self.npc, 61706362)
    cast_magic(self.npc, self.npc, 61706361)
    if self.level > 1 then
      cast_magic(self.npc, self.npc, 61706363)
    end
  end
end

function M:on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
  if magic_id == rogueMgr.weilai and not check_magic(self.npc, 61706361) and check_magic(self.npc, rogueMgr.huisu) then
    cast_magic(self.npc, self.npc, 61706362)
    cast_magic(self.npc, self.npc, 61706361)
  elseif magic_id == rogueMgr.huisu and not check_magic(self.npc, 61706361) and check_magic(self.npc, rogueMgr.weilai) then
    cast_magic(self.npc, self.npc, 61706362)
    cast_magic(self.npc, self.npc, 61706361)
    if self.level > 1 then
      cast_magic(self.npc, self.npc, 61706363)
    end
  end
end

function M:on_start()
  self.level = get_ability_level(20022) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(20022) or 1
end

function M:_init(npc)
  self.tool = roleTool
end

return M
