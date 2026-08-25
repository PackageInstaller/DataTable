local PI = require("ejoysdk_lua.player.player_info")
local M = {}

function M.get_player_infos(player_ids, opts, cb)
  opts = opts or {}
  opts.playerid_to_info = true
  PI.get_player_infos(player_ids, opts, cb)
end

return M
