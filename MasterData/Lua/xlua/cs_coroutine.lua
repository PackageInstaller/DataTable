local util = require("xlua/util")
local cs_coroutine_runner = CS.LuaManager.Instance
return {
  start = function(...)
    return cs_coroutine_runner:StartCoroutine(util.cs_generator(...))
  end,
  stop = function(coroutine)
    cs_coroutine_runner:StopCoroutine(coroutine)
  end
}
