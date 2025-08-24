local Base = require("obj.state.manager.char_state_manager_base")
local M = Util.create_child_mt(Base)

function M:register_all_state()
  require("obj.state.state_monster_idle"):new(self.v_owner, self)
  require("obj.state.state_beattack"):new(self.v_owner, self)
  require("obj.state.state_die"):new(self.v_owner, self)
  require("obj.state.state_anim"):new(self.v_owner, self)
  require("obj.state.state_monster_move"):new(self.v_owner, self)
  require("obj.state.state_attack"):new(self.v_owner, self)
  require("obj.state.state_relive"):new(self.v_owner, self)
  require("obj.state.state_jump"):new(self.v_owner, self)
  require("obj.state.state_behitfly"):new(self.v_owner, self)
  require("obj.state.state_stun"):new(self.v_owner, self)
end

return M
