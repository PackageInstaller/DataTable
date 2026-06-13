local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_start()
  self.missile_list = {
    [2] = 61713910401,
    [3] = 61713910402,
    [4] = 61713910403,
    [5] = 61713910404,
    [6] = 61713910405
  }
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if not is_showup then
    return
  end
  local last_role = roleTool.lastRole.npc
  if last_role == self.npc then
    local relay_num = get_magic_num(self.npc, rogueMgr.relay)
    if relay_num >= 3 then
      local element = get_active_char_element(self.npc)
      local pos = get_npc_pos(self.npc)
      cast_missile3(npc, nil, pos.x, pos.z, self.missile_list[element])
      print("换手！")
    end
  end
end

return M
