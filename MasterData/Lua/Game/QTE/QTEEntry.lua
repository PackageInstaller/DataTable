--[[
    author:luqucheng
    time:2021-12-20 18:24:25
]]
local ResourceModule = CS.Engine.Modules.ResourceModule
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local cs_coroutine = import("XLua.cs_coroutine")
local KTool = CS.Engine.Lib.KTool
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
local WaitForTimelineFinish = CS.WaitForTimelineFinish
local BLOCK_NAME = 'QTEEntry:StartQTE'
local KCookie = CS.Engine.Lib.KCookie
local Yielders = CS.Engine.Lib.Yielders
local UIModule = CS.Engine.UI.UIModule
local ChapterProcessor = CS.Playables.ChapterProcessor
local CoWait = CS.Engine.Lib.CoWait
local support = require 'Frame.support'
local QTEConstants = import('Game.QTE.QTEConstants')
local QTEShared = import('Game.QTE.QTEShared')

local QTEEntry = {}

function QTEEntry:StartQTE()
    Start()
    UIRaycastBlocker:AddCondition(BLOCK_NAME)
    xTry(function()
        CS.Engine.Modules.SpriteAtlasLoader.LoadAtlas('uiatlas/common/common.spriteatlas', function(isOk, atlas)
            QTEEntry:QTECo()
        end, true)
        UIRaycastBlocker:RemoveCondition(BLOCK_NAME)
    end, function()
        UIRaycastBlocker:RemoveCondition(BLOCK_NAME)
    end)
end

function QTEEntry:StartQTE2()
    UIRaycastBlocker:AddCondition(BLOCK_NAME)
    cs_coroutine.start(function()
        xTry(function()
            local loader = ResourceModule.LoadBundleAsync("Timeline/Prefab/QTE_OP_TL.prefab", nil, true)
            while not loader.IsSuccess do
                coroutine.yield()
            end
            if not loader.IsError then
                local go = CS.UnityEngine.GameObject.Instantiate(loader.ResultObject)
                -- go.transform:SetParent(CS.Engine.UI.UIRootCanvas.main.transform)
                local director = KTool.GetComponent(go, typeof(CS.UnityEngine.Playables.PlayableDirector))
                director.playOnAwake = false
                KTool.SetActive(go, true)

                coroutine.yield(WaitForTimelineFinish(director))

                QTEEntry:FinishQTE()
                KTool.SafeDelete(go)
                loader:Release()
            end
            UIRaycastBlocker:RemoveCondition(BLOCK_NAME)
        end, function()
            UIRaycastBlocker:RemoveCondition(BLOCK_NAME)
        end)
    end)

end

function QTEEntry:TestQTE2()
    QTETest = true
    local loader = ResourceModule.LoadBundleAsync("Timeline/Prefab/QTE_OP_TL.prefab", nil, true)
    while not loader.IsSuccess do
        coroutine.yield()
    end
    if not loader.IsError then
        local go = CS.UnityEngine.GameObject.Instantiate(loader.ResultObject)
        -- go.transform:SetParent(CS.Engine.UI.UIRootCanvas.main.transform)
        local director = KTool.GetComponent(go, typeof(CS.UnityEngine.Playables.PlayableDirector))
        director.playOnAwake = false
        KTool.SetActive(go, true)
    end
end

function QTEEntry:TestQTE()
    QTETest = true
    Start()

    QTEEntry:QTECo()

end

function QTEEntry:QTECo()
    return cs_coroutine.start(function()


        local step = QTEShared:GetInstance():GetCurrentStep()

        local camCtrl = CS.Game.Native.URP.URPCameraController.Instance

        local curloader, preloader, preGo

        KCookie.Set("SkipOP2", 0)

        KCookie.Set("QTEShow", 1)

        if step >= QTEConstants.QTESavePoint.NotStart and step <= QTEConstants.QTESavePoint.DianFanBao then
            curloader = ResourceModule.LoadBundleAsync("ChapterNew/QTE_OP1_TL.prefab", nil, true)
            UIRaycastBlocker:AddCondition("blockClick")
            if QTEReview then

                local MainSceneID = QTEConstants.QTECacheKey.MainSceneID
                local id = KCookie.Get(Constants.UICacheDataKeys.MainSceneID)
                if not isNull(id) then
                    KCookie.Set(MainSceneID, id)
                end
                local wait = true
                GameUtils.ShowBlackOverlay(nil, function()

                    --UIModule.AddUIPage({id = 2320})
                    -- UICultivateRoleMgr:GetInstance():DestroyRoleLoader()
                    
                    coroutine.yield(UIModule.CloseDialog(UIModule.CurrentScreen))

                    while not curloader.IsCompleted do
                        coroutine.yield(Yielders.EndOfFrame)
                    end

                    --coroutine.yield()

                    wait = false

                    printInfo("close black")
                end)

                while wait do
                    coroutine.yield(wait)
                end

            end

            --if step == QTEConstants.QTESavePoint.NotStart then
            --    QTEShared:GetInstance():IncreaseStep()
            --end

            while not curloader.IsCompleted do
                coroutine.yield()
            end

            if not curloader.IsSuccess then
                return
            end

            KTool.SetActive(camCtrl.uiCamera, false)

            local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
            CriWareUtils.StopAll()

            local curGo = CS.UnityEngine.GameObject.Instantiate(curloader.ResultObject)
            -- go.transform:SetParent(CS.Engine.UI.UIRootCanvas.main.transform)
            QTEEntry.CalculateScreenFit(curGo)
            KTool.SetActive(curGo, true)
            KTool.ResetTransform(curGo.transform)
            
            CS.UnityEngine.GameObject.DontDestroyOnLoad(curGo)
            local trans = curGo.transform
            local opGo = trans:Find("QTE_OP_TL").gameObject
            local director = KTool.GetComponent(opGo, typeof(CS.UnityEngine.Playables.PlayableDirector))
            local raycasts = curGo:GetComponentsInChildren(typeof(CS.UnityEngine.UI.GraphicRaycaster))
            --director.playOnAwake = false
            --KTool.SetActive(opGo, true)
            for i = 1, raycasts.Length do
                raycasts[i - 1].enabled = false
            end

            preloader = curloader

            if step == QTEConstants.QTESavePoint.NotStart then
                QTEShared:GetInstance():IncreaseStep()
            end
            
            coroutine.yield(Yielders.GetWaitForSeconds(0.5))
            UIRaycastBlocker:RemoveCondition("blockClick")
            for i = 1, raycasts.Length do
                raycasts[i - 1].enabled = true
            end

            curloader = ResourceModule.LoadBundleAsync("ChapterNew/QTE_OP2_TL.prefab", nil, true)

            coroutine.yield(WaitForTimelineFinish(director))

            local value = KCookie.Get("SkipOP2")

            print("op2 skip ", value)
            if value ~= 1 then
                coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP2_TL.prefab", function(loader, go)
                    preGo = go
                    KTool.ResetTransform(go.transform)
                    --preloader:Release()
                    KTool.SafeDelete(curGo)
                    --预加载了一次
                    --loader:Release()
                end, function(go)
                    local behavior = GetLuaBehaviour(go, "Game.QTE.QTE2Mgr")
                    if isNull(behavior) then
                        printInfo("qte2 behavior not found")
                        return
                    end

                    if isNull(behavior.Env) then
                        behavior:Init()
                    end

                    local env = behavior.Env
                    env:Initialize()

                    env:StartPlay()
                end))
            else
                
                curloader:Release()
                KTool.SafeDelete(curGo)
            end

            printInfo("next 2")
        end
        --old Timeline/Prefab/QTE_OP_TL.prefab







        --processor:PlayDirector()
        GameUtils.OpenLoadingPanel()

        --op1 end 处理
        coroutine.yield(Yielders.EndOfFrame)

        KTool.SetActive(camCtrl.uiCamera, true)
        
        local co = KCookie.Get(QTEConstants.QTECacheKey.OpenMainCo)
        KCookie.RemoveAllListener(QTEConstants.QTECacheKey.OpenMainCo)
        
        if isNull(co) and (isNull(UIModule.CurrentScreen) or UIModule.CurrentScreen.Argument.id ~= Constants.UITypeIds.UISceneHome) then
            printInfo("load main")
            local MainSceneID = QTEConstants.QTECacheKey.MainSceneID
            local id = KCookie.Get(MainSceneID)
            printInfo("Get %s", tostring(id))
            if isNull(id) then
                id = Constants.IdSceneSetting3
            end
            --local ins = sceneManagement:GetSceneInstance(sceneData.id)
            --ins:RemoveCacheObjectByName("Role")
            
            local sceneManagement = SceneManagement:GetInstance()
            local sceneData = sceneManagement:GetScenePathInfo(id)
            sceneManagement:Transition({ identifier = sceneData.id, isCache = true })

            while sceneManagement:IsTransition() do

                coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
            end

            --local ins = sceneManagement:GetSceneInstance(sceneData.id)
            --ins:RemoveCacheObjectByName("Role")

            CS.Engine.UI.UIModule.OpenScreen({ id = Constants.UITypeIds.UISceneHome }, true, {})

        end

        QTEEntry:CheckSceneLoaded()

        if not isNull(co) then
            cs_coroutine.stop(co)
            co = nil
        end
        
        --Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)

        KTool.SafeDelete(preGo)
        if not isNull(preloader) then
            preloader:Release()
        end

        --KTool.SafeDelete(go)
        --loader:Release()



        if QTETest or step > QTEConstants.QTESavePoint.DianFanBao then

            UIModule.CloseDialogById(13)
            UIModule.CloseDialogById(Constants.UITypeIds.PassportDialog)
        end

        printInfo("next 3")



        --KTool.SetActive(CS.UnityEngine.Camera.main.gameObject, true)

        KTool.SetActive(camCtrl.mainCamera, true)

        local fightPreWarMgr = FightPreWarMgr:GetInstance()
        coroutine.yield(fightPreWarMgr:GuideFightEnter())

        --loader = ResourceModule.LoadBundleAsync("ChapterNew/QTE_OP3_TL.prefab", nil, true)
        --while not loader.IsCompleted do
        --    coroutine.yield()
        --end
        --
        --if not loader.IsSuccess then
        --    return
        --end






        --KTool.SafeDelete(preGo)
        --
        --preloader:Release()

        if not BattleViewMgr then
            
            return
        end


        --coroutine.yield()
        local battleWait = true
        BattleViewMgr:Start(function()
            battleWait = false
        end, true)

        while battleWait do
            coroutine.yield()
        end

        UIModule.CurrentScreen.Argument = {
            parameters = {
                questId = Constants.QUEST_DOUBLE_GUIDE[1], path = Interfaces.FightBonus, body = { questId = Constants.QUEST_DOUBLE_GUIDE[1] }
            }
        }
        --BattleViewMgr:FindLoadingUI(responseData)
        --BattleViewMgr.loadingUI

        local SceneManagement = CS.UnityEngine.SceneManagement
        local sceneName = "fightmap08"
        --  coroutine.yield(WaitForSeconds(1))
        local scene = SceneManagement.SceneManager.GetSceneByName(sceneName)
        local objs = scene:GetRootGameObjects()
        for i = 1, objs.Length do
            KTool.SetActive(objs[i - 1], true)
        end

        QTEShared:GetInstance():SetStep(QTEConstants.QTESavePoint.BeforeGuideFight)

        printInfo("UIModule.CurrentScreen %s", UIModule.CurrentScreen.gameObject.name)

        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })
        
        coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP3_TL.prefab", function(loader, go)
            preGo = go
            preloader = loader
            KTool.ResetTransform(go.transform)
            KTool.SetActive(go, true)
            KTool.SetActive(BattleViewMgr.loadingUI.controller.gameObject, false)
            CS.UnityEngine.GameObject.DontDestroyOnLoad(go)
        end, function(go)
            local behavior = GetLuaBehaviour(go, "Game.QTE.QTE3Mgr")
            if isNull(behavior) then
                printInfo("qte3 behavior not found")
                return
            end

            if isNull(behavior.Env) then
                behavior:Init()
            end

            local env = behavior.Env
            env:Initialize()

            KTool.SetActive(camCtrl.uiCamera, false)

            env:StartPlay()
        end))

        KTool.SafeDelete(preGo)
        preloader:Release()
        KTool.SetActive(camCtrl.mainCamera, true)
        KTool.SetActive(camCtrl.uiCamera, true)

        

        BattleViewMgr:StartBattle()

        --if not QTETest then
        --    wait = true
        --    local overHandler = Events.AddListener(Constants.EventNames.BattleGameOverShow, function()
        --        wait = false
        --    end)
        --
        --    while wait do
        --        coroutine.yield()
        --    end
        --
        --    Events.RemoveListener(Constants.EventNames.BattleGameOverShow, overHandler)
        --
        --    QTEEntry:FinishQTE()
        --end

        printInfo("before battle all end")

    end)
end

function QTEEntry:AfterBattleQTE()
    return cs_coroutine.start(function()
        local curloader, preloader, preGo

        local camCtrl = CS.Game.Native.URP.URPCameraController.Instance

        coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP4_TL.prefab", function(loader, go)
            -- preloader = ResourceModule.LoadBundleAsync("ChapterNew/QTE_OP5_TL.prefab", nil, true)
            curloader = loader
            preGo = go
            KTool.ResetTransform(go.transform)
            CS.UnityEngine.GameObject.DontDestroyOnLoad(go)

            if not QTEReview then

                --ResourceModule.LoadBundleAsync("ChapterNew/OP6_101008_enter_d_1_timeline.prefab", nil, true)

                xTry(function()
                    ---强制触发引导   触发加载 qte5
                    ---@type GuideUtils
                    local GuideUtils = import('Game.UI.Guide.GuideUtils')
                    GuideUtils.SetIsForcedTrigger(true)
                end)

            end

        end, function(go)
            local behavior = GetLuaBehaviour(go, "Game.QTE.QTE4Mgr")
            if isNull(behavior) then
                printInfo("qte4 behavior not found")
                return
            end

            if isNull(behavior.Env) then
                behavior:Init()
            end

            local env = behavior.Env
            env:Initialize()
            env:StartPlay()

            KTool.SetActive(camCtrl.mainCamera, false)
            KTool.SetActive(camCtrl.uiCamera, false)
        end))

       
        -- KTool.SetActive(camCtrl.mainCamera, true)

        if not QTEReview then
            ---@type GuideUtils
            local GuideUtils = import('Game.UI.Guide.GuideUtils')
            --等待 qte5 开始播放
            GuideUtils.SetIsWaitTimeLinePlay(true)
            ---强制触发引导 播放 qte5
            GuideUtils.SetIsForcedTrigger(true)

            while GuideUtils.GetIsWaitTimeLinePlay() do
            -- while not GuideUtils.GetIsWaitExecuteNextStep() do
                coroutine.yield()
            end

            
            --- 交给引导控制
            -- Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })

            -- local MainSceneID = QTEConstants.QTECacheKey.MainSceneID
            -- local id = KCookie.Get(MainSceneID)
            -- printInfo("Get %s", tostring(id))
            -- if isNull(id) then
            --     id = Constants.IdSceneSetting3
            -- end
            -- local ins = SceneManagement:GetInstance():GetSceneInstance(id)
            
            
            -- KTool.SetActive(ins:GetRootObjByName("Role"), true)
            -- KTool.SetActive(ins:GetRootObjByName("DynamicNode"), true)
        end

        --KTool.SetActive(camCtrl.uiCamera, true)
        
        --op4 后停止bgm 取消
        --local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
        --CriWareUtils.StopAll()
        --GameUtils.PlayMainBGM()

        -- coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP5_TL.prefab", function(loader, go)
        --     KTool.SafeDelete(preGo)
        --     curloader:Release()
        --     curloader = loader
        --     preGo = go
        --     --KTool.ResetTransform(go.transform)
        --     --预加载了一次
        --     --loader:Release()
        -- end))

        -- coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP6_TL.prefab", function(loader, go)
        --     KTool.SafeDelete(preGo)
        --     curloader:Release()
        --     KTool.ResetTransform(go.transform)

        --     curloader = loader
        --     preGo = go
        -- end))

        -- coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP7_TL.prefab", function(loader, go)
        --     KTool.SafeDelete(preGo)
        --     curloader:Release()
        --     KTool.ResetTransform(go.transform)

        --     curloader = loader
        --     preGo = go
        -- end))

        -- coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP8_TL.prefab", function(loader, go)
        --     KTool.SafeDelete(preGo)
        --     curloader:Release()
        --     --KTool.ResetTransform(go.transform)

        --     curloader = loader
        --     preGo = go
        -- end))


        KTool.SafeDelete(preGo)
        curloader:Release()

        if QTEReview then

            QTEEntry:FinishQTE()

            KTool.SetActive(camCtrl.mainCamera, true)
            KTool.SetActive(camCtrl.uiCamera, true)

            Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)
            Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = true })

            local cameraRootGo = CS.UnityEngine.GameObject.Find("CameraRoot")
            if not isNull(cameraRootGo) then
                local rollingGo = cameraRootGo.transform:Find("Rolling")
                KTool.SetActive(rollingGo, true)
            end

            local RolesShowMgr = import('Game.Robot.RolesShowMgr')
            local r = RolesShowMgr:GetInstance():GetRoleInstance("108")
            if not isNull(r) then
                r = r._modelGo
                KTool.SetActive(r, true)
            end

            local arguments = UIModule.PopPage()
            if not isNull(arguments) and arguments.Count > 0 then
                for i, v in support.list_ipairs(arguments) do
                    cs_coroutine.yield_return(UIModule.OpenDialog(v.id, v))
                end
            else
                ---初始需要打包主界面
                --cs_coroutine.yield_return(UIModule.OpenDialog({ id = Constants.UITypeIds.UIHomeView }))
            end

            local MainSceneID = QTEConstants.QTECacheKey.MainSceneID
            local id = KCookie.Get(MainSceneID)
            printInfo("Get %s", tostring(id))
            if isNull(id) then
                id = Constants.IdSceneSetting3
            end
            local ins = SceneManagement:GetInstance():GetSceneInstance(id)

            KTool.SetActive(ins:GetRootObjByName("Role"), true)
            KTool.SetActive(ins:GetRootObjByName("DynamicNode"), true)

            x_record_event('CHAPTER_STORE_END')

            printInfo("end after battle")
        end

        QTEReview = false
    end)
end

function QTEEntry:PlayOP6Enter()

end

function QTEEntry:FinishBattle()

    cs_coroutine.start(function()
        local coWait = CoWait.Start()
        for i, v in support.list_ipairs(UIModule.CurrentScreen.dialogs) do
            coWait:Coroutine(UIModule.CloseDialog(v, true))
            printInfo(v.Argument.id)
        end
        while not coWait.IsFinish do
            coroutine.yield()
        end

        QTEEntry:FinishQTE()

        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)

        --GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome, hasExcluded = false }, nil, Constants.LoadingType.MainHome)
        --CS.Engine.UI.UIModule.CloseDialogById(Constants.UITypeIds.BattleScene)
        BattleViewMgr:OnDestroy()
        CS.UnityEngine.LightmapSettings.lightProbes = nil

        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = true })

        local cameraRootGo = CS.UnityEngine.GameObject.Find("CameraRoot")
        if not isNull(cameraRootGo) then
            local rollingGo = cameraRootGo.transform:Find("Rolling")
            KTool.SetActive(rollingGo, true)
        end

    end)

end

function QTEEntry:StartGuideFight()
    cs_coroutine.start(function()


        GameUtils.OpenLoadingPanel()

        coroutine.yield(Yielders.GetWaitForSeconds(0.2))

        UIModule.CloseDialogById(13)
        UIModule.CloseDialogById(Constants.UITypeIds.PassportDialog)

        KCookie.Set("QTEShow", 1)

        local loader, preloader, preGo

        printInfo("next 3")
        local camCtrl = CS.Game.Native.URP.URPCameraController.Instance


        --KTool.SetActive(CS.UnityEngine.Camera.main.gameObject, true)

        KTool.SetActive(camCtrl.mainCamera, true)
        KTool.SetActive(camCtrl.uiCamera, true)

        local sceneManagement = SceneManagement:GetInstance()
        local sceneData = sceneManagement:GetScenePathInfo(Constants.IdSceneSetting3)
        sceneManagement:Transition({ identifier = sceneData.id, isCache = true })

        while sceneManagement:IsTransition() do
            coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
        end

        local wait = true

        CS.Engine.UI.UIModule.OpenScreen({ id = Constants.UITypeIds.UISceneHome }, true, {})
        ---op1 end - op1 part03 end qteShow == 1的时候 mainHome 停在 OnInitialize
        --coroutine.yield(Yielders.GetWaitForSeconds(7))
        QTEEntry:CheckSceneLoaded()
        --QTEEntry:StopLoadCat()

        local fightPreWarMgr = FightPreWarMgr:GetInstance()
        coroutine.yield(fightPreWarMgr:GuideFightEnter())

        BattleViewMgr:Start(function()
            wait = false
        end, true)

        while wait do
            coroutine.yield()
        end

        UIModule.CurrentScreen.Argument = {
            parameters = {
                questId = Constants.QUEST_DOUBLE_GUIDE[1], path = Interfaces.FightBonus, body = { questId = Constants.QUEST_DOUBLE_GUIDE[1] }
            }
        }

        --BattleViewMgr:FindLoadingUI(responseData)
        --BattleViewMgr.loadingUI

        printInfo("UIModule.CurrentScreen %s", UIModule.CurrentScreen.gameObject.name)

        --coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP3_TL.prefab", function(loader, go)
        --    preGo = go
        --    preloader = loader
        --    KTool.SetActive(go, true)
        --    KTool.ResetTransform(go.transform)
        --    KTool.SetActive(BattleViewMgr.loadingUI.controller.gameObject, false)
        --    CS.UnityEngine.GameObject.DontDestroyOnLoad(go)
        --end, function(go)
        --    local behavior = GetLuaBehaviour(go, "Game.QTE.QTE3Mgr")
        --    if isNull(behavior) then
        --        printInfo("qte3 behavior not found")
        --        return
        --    end
        --
        --    if isNull(behavior.Env) then
        --        behavior:Init()
        --    end
        --
        --    local env = behavior.Env
        --    env:Initialize()
        --
        --    env:StartPlay()
        --end))



        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })

        printInfo("loading finish")

        --BattleViewMgr:BindRoleInEnterTimeline()

        KTool.SetActive(camCtrl.mainCamera, true)
        KTool.SetActive(camCtrl.uiCamera, true)

        BattleViewMgr:StartBattle()
    end)

end

function QTEEntry:TestOP3Fight()
    Start()
    QTETest = true
    cs_coroutine.start(function()
        if QTETest then

            UIModule.CloseDialogById(13)
            UIModule.CloseDialogById(Constants.UITypeIds.PassportDialog)
        end

        local loader, preloader, preGo

        printInfo("next 3")
        local camCtrl = CS.Game.Native.URP.URPCameraController.Instance


        --KTool.SetActive(CS.UnityEngine.Camera.main.gameObject, true)

        KTool.SetActive(camCtrl.mainCamera, true)

        local fightPreWarMgr = FightPreWarMgr:GetInstance()
        coroutine.yield(fightPreWarMgr:GuideFightEnter())

        --loader = ResourceModule.LoadBundleAsync("ChapterNew/QTE_OP3_TL.prefab", nil, true)
        --while not loader.IsCompleted do
        --    coroutine.yield()
        --end
        --
        --if not loader.IsSuccess then
        --    return
        --end

        GameUtils.OpenLoadingPanel()





        --KTool.SafeDelete(preGo)
        --
        --preloader:Release()



        --coroutine.yield()
        local wait = true
        BattleViewMgr:Start(function()
            wait = false
        end, true)

        while wait do
            coroutine.yield()
        end

        UIModule.CurrentScreen.Argument = {
            parameters = {
                questId = Constants.QUEST_DOUBLE_GUIDE[1], path = Interfaces.FightBonus, body = { questId = Constants.QUEST_DOUBLE_GUIDE[1] }
            }
        }
        --BattleViewMgr:FindLoadingUI(responseData)
        --BattleViewMgr.loadingUI

        printInfo("UIModule.CurrentScreen %s", UIModule.CurrentScreen.gameObject.name)

        coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP3_TL.prefab", function(loader, go)
            preGo = go
            preloader = loader
            KTool.SetActive(go, true)
            KTool.ResetTransform(go.transform)
            KTool.SetActive(BattleViewMgr.loadingUI.controller.gameObject, false)
            CS.UnityEngine.GameObject.DontDestroyOnLoad(go)
        end, function(go)
            local behavior = GetLuaBehaviour(go, "Game.QTE.QTE3Mgr")
            if isNull(behavior) then
                printInfo("qte3 behavior not found")
                return
            end

            if isNull(behavior.Env) then
                behavior:Init()
            end

            local env = behavior.Env
            env:Initialize()

            env:StartPlay()
        end))

        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })

        printInfo("loading finish")

        --BattleViewMgr:BindRoleInEnterTimeline()

        KTool.SetActive(camCtrl.mainCamera, true)

        KTool.SafeDelete(preGo)
        preloader:Release()

        BattleViewMgr:StartBattle()
    end)


end

function QTEEntry:TestOP68()
    Start()
    QTETest = true
    cs_coroutine.start(function()

        local preloader, preGo

        printInfo("next 3")
        local camCtrl = CS.Game.Native.URP.URPCameraController.Instance

        KTool.SetActive(camCtrl.mainCamera, false)

        coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP6_TL.prefab", function(loader, go)
            preloader = loader
            preGo = go
            KTool.ResetTransform(go.transform)
        end))

        coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP7_TL.prefab", function(loader, go)

            KTool.SafeDelete(preGo)
            preloader:Release()

            preloader = loader
            preGo = go
            KTool.ResetTransform(go.transform)
        end))

        coroutine.yield(QTEEntry:LoadAndPlayTL("ChapterNew/QTE_OP8_TL.prefab", function(loader, go)

            KTool.SafeDelete(preGo)
            preloader:Release()

            preloader = loader
            preGo = go
            KTool.ResetTransform(go.transform)
        end))

        KTool.SafeDelete(preGo)
        preloader:Release()

        KTool.SetActive(camCtrl.mainCamera, true)
    end)
end

---@param onStart fun(loader:Engine.Modules.AbstractResourceLoader, go:UnityEngine.GameObject)
---@param customPlay fun(go:UnityEngine.GameObject)
function QTEEntry:LoadAndPlayTL(path, onStart, customPlay)
    return cs_coroutine.start(function()
        local loader = ResourceModule.GetLoaderByURL(path)

        if isNull(loader) then
            loader = ResourceModule.LoadBundleAsync(path, nil, true)
        end

        while not loader.IsCompleted do
            coroutine.yield(Yielders.EndOfFrame)
        end

        if not loader.IsSuccess then
            loader:Release()
            return
        end

        local go = CS.UnityEngine.GameObject.Instantiate(loader.ResultObject)
        local processor = go:GetComponentInChildren(typeof(ChapterProcessor))

        QTEEntry.CalculateScreenFit(go)

        if onStart ~= nil then
            onStart(loader, go)
        end

        if customPlay ~= nil then
            customPlay(go)
        else
            processor:PlayDirector()
        end

        local wait = true
        processor.OnChapterFinish = function()
            wait = false
        end

        while wait do
            coroutine.yield(Yielders.EndOfFrame)
        end
    end)
end

function QTEEntry:FinishQTE()
    KCookie.Set('QTEShow', 0)
    KCookie.Set('QTEEnd', 1)
    CfUtils.WriteLocalData("QTEOPEN", 0)
    xRecord.record('1-011')

end

function QTEEntry:StopLoadCat()
    --printInfo(UIModule.CurrentScreen.gameObject.name)
    local behavior = UIModule.CurrentScreen.gameObject:GetComponent(typeof(CS.Engine.UI.UILuaScreen))
    if not isNull(behavior) and not isNull(behavior.Env) then
        local co = behavior.Env._coLoadCat
        if not isNull(co) then
            cs_coroutine.stop(co)
        end

        co = behavior.Env.pngWriteCo
        if co then
            cs_coroutine.stop(co)
        end

        printInfo("StopCat")

    end

end

function QTEEntry:CheckSceneLoaded()
    local MainSceneID = QTEConstants.QTECacheKey.MainSceneID
    local id = KCookie.Get(MainSceneID)
    printInfo("Get %s", tostring(id))
    if isNull(id) then
        id = Constants.IdSceneSetting3
    end
    local tb = {}
    table.insert(tb, id)
    table.insert(tb, Constants.IdSceneSetting29)
    -- table.insert(tb, Constants.IdSceneSetting1)
    table.insert(tb, Constants.IdSceneSetting21)

    local allLoad = true
    while true do
        coroutine.yield(Yielders.EndOfFrame)

        allLoad = true
        for i, v in ipairs(tb) do

            if not SceneManagement:GetInstance():IsSceneLoaded(tostring(v)) then
                allLoad = false
                break
            end

        end

        if allLoad then
            break
        end
    end
    
end

function QTEEntry.CalculateScreenFit(go)
    local tmp = go:GetComponentsInChildren(typeof(CS.UnityEngine.UI.CanvasScaler), true)
    if isNull(tmp) then
        return
    end

    for i = 1, tmp.Length do
        local scaler = tmp[i - 1]
        KTool.CalculateScreenFit(scaler)
    end
    printInfo("calc")
end

return QTEEntry