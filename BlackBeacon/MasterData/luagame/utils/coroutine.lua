local xutil = require("xlua.util")
return {
  start = function(...)
    return CS.Game.Service.Instance:StartCoroutine(xutil.cs_generator(...))
  end,
  stop = function(coroutine)
    CS.Game.Service.Instance:StopCoroutine(coroutine)
  end
}
