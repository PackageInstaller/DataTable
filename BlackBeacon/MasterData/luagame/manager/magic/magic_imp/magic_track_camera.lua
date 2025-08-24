local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  if self.owner ~= Global.hero then
    return
  end
  if 2 == self.cfg[4] then
    self.v_play_idx = Cinemachine:play(self.cfg[1], self.cfg[2], self.cfg[3], 1, self.magic_info.attacker)
  else
    self.v_play_idx = Cinemachine:play(self.cfg[1], self.cfg[2], self.cfg[3], self.cfg[4] or 0, self.owner)
  end
  if self.owner:is_hero() then
    self.owner:start_time_line()
    self.owner:set_circle_effect_visible(false)
  end
  SceneMgr:hide_npc_hp_obj(nil, self.cfg[5])
end

function M:on_remove()
  Cinemachine:stop(self.cfg[1], self.v_play_idx)
  if self.owner:is_hero() then
    self.owner:stop_time_line()
    self.owner:set_circle_effect_visible(true)
  end
  SceneMgr:show_npc_hp_obj()
end

return M
