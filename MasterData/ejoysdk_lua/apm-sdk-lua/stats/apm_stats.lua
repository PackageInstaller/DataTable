local Stats = require("ejoysdk_lua.apm-sdk-lua.stats.stats")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local apm_stats = Stats.new("apm_stats", Global.namespace_apm_stats)
return apm_stats
