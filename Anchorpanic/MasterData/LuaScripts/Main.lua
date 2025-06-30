if jit then
    jit.off()       --关闭 jit 模式
    jit.flush()     --打开 interpreter 模式
end

function main()
    require("translate")
    require("translate_type")
    require("utils/Require")
    require("utils/LuaVMSetting")
    initLuaVMSetting()

    GCUtil.setLuaGCParam(150, 400)

    math.randomseed(tostring(os.time()):reverse():sub(1, 6));
    Debug:log_info("Main", "LUA版本：" .. _VERSION)
    require('game/download/Init')
    require('game/sdk/Init')
    require('game/web/Init')
    LuaPoolMgr:setCheckInterval(gs.ApplicationUtil.IsEditorRun and 30 or 180)
end