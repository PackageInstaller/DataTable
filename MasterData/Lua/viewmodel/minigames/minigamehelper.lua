




MiniGameHelper = {}

function MiniGameHelper.InitCardData()
    local Result
    local data = {}

    local Url = "monopoly/flipcard/get"
    ApiMgr.Request(Url, data, true,
    function(result)
        Result = result
        LuaMgr.ShowLuaPanel(UIName.MiniGameCardViewModel, result)
    end,
    function(failCode)
        LuaDebug.error("失败的数据")
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )
    return Result
end
function MiniGameHelper.InitFinsh()
    LuaMgr.ShowLuaPanel(UIName.MiniGameFishViewModel)
end
function MiniGameHelper.InitBomb()
    LuaMgr.ShowLuaPanel(UIName.MiniGameBombViewModel)
end
return MiniGameHelper