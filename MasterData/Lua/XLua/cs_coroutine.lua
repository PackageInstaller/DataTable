local util = require "XLua.util"

local KTool = CS.Engine.Lib.KTool

local GameObject = CS.UnityEngine.GameObject

local gameObject = GameObject.Find('CoroutineRunner')
if KTool.IsNull(gameObject) then
    gameObject = CS.UnityEngine.GameObject("CoroutineRunner")
    CS.UnityEngine.Object.DontDestroyOnLoad(gameObject)
end

---@type Engine.Modules.CoroutineRunner
local cs_coroutine_runner = KTool.GetOrAddComponent(gameObject, typeof(CS.Engine.Modules.CoroutineRunner))

return {
    ---@return UnityEngine.Coroutine
    start = function(...)
        return cs_coroutine_runner:StartCoroutine(util.cs_generator(...))
    end,
    ---@param coroutine UnityEngine.Coroutine
    stop = function(coroutine)
        cs_coroutine_runner:StopCoroutine(coroutine)
    end,
    yield_return = coroutine.yield
}
