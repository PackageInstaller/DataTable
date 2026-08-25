local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local M = {}
M._STRATEGY_MAP = {
  [NS.STRATEGY.BOTH_MOBILE_WIFI_NETWORK] = NS,
  [NS.STRATEGY.WIFI_ONLY] = NS
}

function M.get_strategy_processor(strategy_name)
  return M._STRATEGY_MAP[strategy_name]
end

return M
