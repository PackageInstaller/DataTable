--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2020-11-11 16:14:26
]]
local cs_coroutine = import('XLua.cs_coroutine')
--local AudioManager = CS.Engine.Wwise.AudioManager
local ChangeSceneWithCG = {}

function ChangeSceneWithCG:BeforeWaveChange( datas )
    local finishChangeScene = false
    local finishPlay = false
    local sceneId = datas[1]
    local CGPath = datas[2]
    --local loader = CS.Engine.Modules.ResourceModule.LoadBundleAsync(CGPath .. ".mp4")
    --local wait = cs_coroutine.start(function()
    --    while loader.IsFinish do
    --        coroutine.yield()
    --    end
    --end)

    local fullPath = CS.Engine.Modules.ResourceModule.GetVideoFilePath(CGPath)
    
    printInfo(fullPath)
    
    GameUtils.ShowVideoPlayer(fullPath, 
    function (  )
        cs_coroutine.start(function (  )
            coroutine.yield(BattleViewMgr:ChangeScene(sceneId))
            finishChangeScene = true
        end)
    end,
    function (  )
        finishPlay = true
    end,
    function (  )

    end,
    true
    )
    
    --while not loader.IsCompleted do
    --    coroutine.yield()
    --end
    
    --GameUtils.ShowVideoPlayerWithClip(loader.ResultObject, 
    --function (  )
    --    cs_coroutine.start(function (  )
    --        coroutine.yield(BattleViewMgr:ChangeScene(sceneId))
    --        finishChangeScene = true
    --    end)
    --end,
    --function (  )
    --    finishPlay = true
    --end,
    --function (  )
    --
    --end,
    --true
    --)
    

    while not finishChangeScene or not finishPlay do
        coroutine.yield()
    end
    --AudioManager.Instance:PlayMusic(BattleViewMgr.sceneVo.sceneMusic, BattleMusicTag)

end

return ChangeSceneWithCG