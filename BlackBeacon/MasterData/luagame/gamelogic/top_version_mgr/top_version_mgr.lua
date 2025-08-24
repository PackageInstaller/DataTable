local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local OPEN_STATE = {OPEN = 1, CLOSE = 2}

function M:init_sys()
  Base.init_sys(self)
end

function M:get_pass_level_amount()
end

function M:get_level_info()
end

function M:get_stage_score(stage_id)
end

function M:get_game_id()
end

return M
