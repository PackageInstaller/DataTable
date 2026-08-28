--------------------------------
--- 地图解密活动(春节活动)工具类
--- 提供界面跳转之类的方法

------------ global define ------------
local CS          = CS
local Events      = Events
local UIArgs      = UIArgs
local isNull      = isNull
local typeof      = typeof
local checkNumber = checkNumber
------------ global define ------------

------------ import ------------
local cs_coroutine     = require "XLua.cs_coroutine"
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type Engine.Lib.KCookie
local KCookie          = CS.Engine.Lib.KCookie
local GameObject       = CS.UnityEngine.GameObject
local ResourceModule   = CS.Engine.Modules.ResourceModule
local Object           = CS.UnityEngine.Object
local Vector3          = CS.UnityEngine.Vector3
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
---@type SceneManagement
local sceneManagement  = SceneManagement:GetInstance()
---@type ChapterUtils
local ChapterUtils     = import('Game.Chapter.ChapterUtils')

local AppEngine         = CS.Engine.Lib.AppEngine
local CriWareUtils        = import('Game.Entry.CriWareUtilsFix')


---@type MazeLoadScene
local MazeLoadScene = import('Game.Behaviours.Maze.MazeLoadScene'):GetInstance()

---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')


------------ import ------------

------------ define ------------
local yield_return                 = cs_coroutine.yield_return 
local AnimatorType                 = typeof(CS.UnityEngine.Animator)
local LookAtIKType                 = typeof(CS.RootMotion.FinalIK.LookAtIK)
local URPBaseCameraType            = typeof(CS.Game.Native.URP.URPBaseCamera)
local CinemachineVirtualCameraType = typeof(CS.Cinemachine.CinemachineVirtualCamera)

local IsActiveControlJoystick   = AppEngine.GetConfig("Engine.Dev", "IsActiveControlJoystick", false)
------------ define ------------
---@class MapDecryptionUtils
local MapDecryptionUtils = {}

local DialogType = {
    Home               = 1, --- 主界面
    EventResult        = 2, --- 事件结果
    ExploreTrack       = 3, --- 探索追踪
    AntiqueRestoration = 4, --- 古物修复
    Turntable          = 5, --- 转盘
    Store              = 6, --- 商店
    Maze2D             = 7, --- 2D 探索迷宫
}
MapDecryptionUtils.DialogType = DialogType

local UITypeIds = Constants.UITypeIds
local DialogDefine = {
    
    -- key 解密活动排期表 changeId
    [121401] = {
         [DialogType.Home]               = UITypeIds.MapDecryptionHomeView,
         [DialogType.EventResult]        = UITypeIds.MapDecryptionEventResultPopup,
         [DialogType.ExploreTrack]       = UITypeIds.MapDecryptionExploreTracking,
         [DialogType.AntiqueRestoration] = UITypeIds.MapDecryptionAntiqueRestorationDialog,
         [DialogType.Turntable]          = UITypeIds.MapDecryptionRotaryTableDialog,
         [DialogType.Store]              = UITypeIds.MapDecryptionStoreDialog,
         [DialogType.Maze2D]             = UITypeIds.MapDecryption2DMazeUI,
    },

}

-- local PrefabId2Dialog

--- GetDialogId
---@param dialogType integer @ 弹窗类型 DialogType
function MapDecryptionUtils.GetDialogId(dialogType)
    local prefabId = MapDecryptionConfMgr:GetPrefabId()
    local Define = DialogDefine[prefabId]
    return Define[dialogType]
   
end

function MapDecryptionUtils.GetPrefabPath(prefabPath)
    local prefabId = MapDecryptionConfMgr:GetPrefabId()
    return string.format(prefabPath, prefabId)
end

--- EnterTeamChoose
--- 进入战斗选中界面
---@param questId number             关卡id
---@param activityUuid number        活动id
---@param excludeDialogs table       互斥界面
function MapDecryptionUtils.EnterTeamChoose(questId, activityUuid, excludeDialogs)
    UIModule.OpenDialog(
        UIArgs(Constants.UITypeIds.UIFightTeamChoose, { levelId = questId, activityUuid = activityUuid }), 
        excludeDialogs
    )
    
end

--- EnterPCTipsDialog
function MapDecryptionUtils.EnterPCTipsDialog(isSkip)
    if not MapDecryptionUtils.IsPCPlatform() then
        return
    end
    local activityDojo = MapDecryptionMgr:GetActivityData()
    local key = table.concat({"IsPopPcTips", activityDojo.id, activityDojo.activityContentId}, "_")
    if not isSkip then
        ---@type ActivityDojo
        local result = checkNumber(CfUtils.GetLocalData(key))
        if result == 1 then
            return
        end
    end
    UIModule.OpenDialog(
        UIArgs(Constants.UITypeIds.MapDecryptionPCTipsDialog, { key = key }), 
        nil
    )
    
end

--- EnterConversationOptionDialog
--- 进入选项卡界面
---@param data table{
---@    refId,        所需配表id 具体看 MapDecryptionConstants.EventResult注释
---@    eventResType, MapDecryptionConstants.EventResult
---@    stage,        仅限EventResult.CompleteMapExploration
---@}
---@param excludeDialogs table   可选    互斥界面
function MapDecryptionUtils.EnterEventResultPopup(data, excludeDialogs)
    UIModule.OpenDialog(
        UIArgs(MapDecryptionUtils.GetDialogId(DialogType.EventResult), { data = data }), 
        excludeDialogs
    )

end

function MapDecryptionUtils.SetBgmPlayStatus(isPlay)
    local activityContentId = MapDecryptionConfMgr:GetActivityContentId()
    local planVo = MapDecryptionConfMgr:GetPlanVoById(activityContentId)
    ---@type MapDecryptionPlanVo
    local music  = planVo.music
    if not string.isEmpty(music) then
        if isPlay then
            CriWareUtils.PlayMusicById(music)
        else
            CriWareUtils.StopById(music)
        end

    end
end

--- HandleFunctionEnterType
---@param enterType MapDecryptionConstants.FunctionEnterType 1探索、2追踪、3古物修复、4新年转盘、5新年商店，6闲聊、7返回
---@param params table
---@param excludeDialogs table 互斥界面列表
function MapDecryptionUtils.HandleFunctionEnterType(enterType, params, excludeDialogs)
    enterType = checkNumber(enterType)
    ---@type MapDecryptionFunctionEnterVo
    local vo = MapDecryptionConfMgr:GetFunctionEnterVoById(enterType)
    Events.Broadcast(MapDecryptionConstants.EventNames.HandleFunctionEnter, vo, enterType, params, excludeDialogs)
    
end

--- PopDialogByEnterType
---@param enterType MapDecryptionConstants.FunctionEnterType 1探索、2追踪、3古物修复、4新年转盘、5新年商店，6闲聊、7返回
function MapDecryptionUtils.PopDialogByEnterType(enterType, params, excludeDialogs)
    enterType = checkNumber(enterType)
    local MapDecryptionConstants = MapDecryptionConstants
    local FunctionEnterType      = MapDecryptionConstants.FunctionEnterType
    local EventNames             = MapDecryptionConstants.EventNames

    if enterType == FunctionEnterType.Explore then
        Events.Broadcast(EventNames.HideOptions)
        ---探索
        UIModule.OpenDialog(
            UIArgs(MapDecryptionUtils.GetDialogId(DialogType.ExploreTrack), {viewType = MapDecryptionConstants.ExploreTrackingSubViewType.Explore}), 
            {UIArgs(MapDecryptionUtils.GetDialogId(DialogType.Home))}
        )
    elseif enterType == FunctionEnterType.Tracking then
        Events.Broadcast(EventNames.HideOptions)
        ---追踪
        UIModule.OpenDialog(
            UIArgs(MapDecryptionUtils.GetDialogId(DialogType.ExploreTrack), {viewType = MapDecryptionConstants.ExploreTrackingSubViewType.Tracking}), 
            {UIArgs(MapDecryptionUtils.GetDialogId(DialogType.Home))}
        )
    elseif enterType == FunctionEnterType.AntiqueRestoration then
        Events.Broadcast(EventNames.HideOptions)
        ---古物修复
        UIModule.OpenDialog(
            UIArgs(MapDecryptionUtils.GetDialogId(DialogType.AntiqueRestoration), params),
                {UIArgs(MapDecryptionUtils.GetDialogId(DialogType.Home))}
        )
    elseif enterType == FunctionEnterType.Turntable then
        Events.Broadcast(EventNames.HideOptions)
        ---新年转盘
        UIModule.OpenDialog(
                UIArgs(MapDecryptionUtils.GetDialogId(DialogType.Turntable), params),
                excludeDialogs
        )
    elseif enterType == FunctionEnterType.Store then
        ---新年大促
        Events.Broadcast(EventNames.HideOptions)
        ---新年转盘
        UIModule.OpenDialog(
                UIArgs(MapDecryptionUtils.GetDialogId(DialogType.Store), params),
                {UIArgs(MapDecryptionUtils.GetDialogId(DialogType.Home))}
        )
        
    elseif enterType == FunctionEnterType.Gossip then
        ---闲聊
        Events.Broadcast(EventNames.Gossip, params)
        
    elseif enterType == FunctionEnterType.Quit then
        ---再见
        Events.Broadcast(EventNames.RestoreBubble)
        
    end
end


--- CreateLoaderAsync
---@param path string
function MapDecryptionUtils.FixPathAndCreateLoader(path)
    local prefabPath = MapDecryptionUtils.GetPrefabPath(path)
    return MapDecryptionUtils.LoadBundleAsync(prefabPath)
end

function MapDecryptionUtils.LoadBundleAsync(prefabPath)
    return ResourceModule.LoadBundleAsync(prefabPath, nil, true)
end

function MapDecryptionUtils.CreateGameObjectByPath(path, parent)
    local prefabPath = MapDecryptionUtils.GetPrefabPath(path)
    return GameUtils.LoadBundleAsync(prefabPath, parent, false)
end

--- InstantiateByLoader
---@param loader Engine.Modules.AbstractResourceLoader
---@param parent UnityEngine.GameObject
---@param customYieldFunc fun()
function MapDecryptionUtils.InstantiateByLoader(loader, parent, customYieldFunc)
    if isNull(loader) then
        return
    end

    while not loader.IsCompleted do
        if customYieldFunc then
            customYieldFunc()
        else
            yield_return()
        end
    end

    local go
    if loader.IsSuccess then
        go = loader:Instantiate()
        if not IsNull(go) and not isNull(parent) then
            KTool.SetParent(go, parent, false)
        end
    end

    loader:Release()

    return go
end


--- GetAssetByLoader
---@param loader Engine.Modules.AbstractResourceLoader
function MapDecryptionUtils.GetAssetByLoader(loader)
    if isNull(loader) then
        return
    end

    while not loader.IsCompleted do
        yield_return()
    end

    local ret = nil
    if loader.IsSuccess then
        ret = loader.ResultObject
    end
    loader:Release()
    return ret 
end


local function PrepareWeightedRandom(values, weights)
    local tInsert = table.insert
    local ipairs = ipairs

    local sorted_indices  = {}      -- 排序的权重索引
    for i, _ in ipairs(weights) do
        tInsert(sorted_indices, i)
    end
    table.sort(sorted_indices, function(a, b)
        return weights[a] > weights[b]
    end)

    local sorted_weights = {}   -- 排序的权重列表
    for _, i in ipairs(sorted_indices) do
        tInsert(sorted_weights, weights[i])
    end

    local totals = {}       -- 总和列表
    local sum = 0
    for i, w in ipairs(sorted_weights) do
        sum = sum + w
        totals[i] = sum
    end

    -- 返回选择器函数
    return function()
        local n = math.random() * sum
        local idx = 1
        local distance, weight, sIdx
        while true do
            if totals[idx] > n then     -- 找到
                sIdx = sorted_indices[idx]
                return values[sIdx]
            end
            weight = sorted_weights[idx]
            distance = n - totals[idx]
            idx = idx + (1 + distance // weight)
        end
    end
end
function MapDecryptionUtils.RandomTalk(talkList, people)
    local unlockTalks = {}
    local weights     = {}
    local curTime     = os.time()
    local tInsert     = table.insert
    people           = checkNumber(people)
    local lastWeight
    for i, v in pairs(talkList) do
        local unlockTime = checkNumber(v.time)
        if curTime >= unlockTime and people == checkNumber(v.people) then
            tInsert(unlockTalks, v.talkId)
            tInsert(weights, lastWeight == unlockTime and (unlockTime - 1) or unlockTime)
            lastWeight = unlockTime
        end
    end
    local func = PrepareWeightedRandom(unlockTalks, weights)
    return func()
end

function MapDecryptionUtils.InitGossipData(talkList, people, mainSceneInteractionVo, presenterModel)
    local talkId = MapDecryptionUtils.RandomTalk(talkList, people)
    return MapDecryptionUtils.InitGossipDataByTalkId(talkId, mainSceneInteractionVo, presenterModel)
end

--- InitGossipDataByTalkId
--- 根据对话id 初始化闲聊数据
---@param talkId number
---@param mainSceneInteractionVo MapDecryptionMainSceneInteractionVo
---@param presenterModel UnityEngine.Transform
function MapDecryptionUtils.InitGossipDataByTalkId(talkId, mainSceneInteractionVo, presenterModel)
    ---@type MapDecryptionGossipPlotVo[]
    local gossipPlotVos = MapDecryptionConfMgr:GetGossipPlotVosById(talkId)
    local index         = 1
    return MapDecryptionUtils.InitTalkDataByIndex(index, gossipPlotVos, mainSceneInteractionVo, presenterModel)
end

--- InitTalkDataByGossipPlotVo
---@param gossipPlotVos           MapDecryptionGossipPlotVo[]
---@param index                   number
---@param mainSceneInteractionVo  MapDecryptionMainSceneInteractionVo
---@param presenterModel          UnityEngine.Transform
function MapDecryptionUtils.InitTalkDataByIndex(index, gossipPlotVos, mainSceneInteractionVo, presenterModel)
    local gossipPlotVo = gossipPlotVos[index]
    local isNpc = gossipPlotVo.people == 1
    local isWoman
    if isNpc then
        isWoman = mainSceneInteractionVo.sex == 2
    else
        isWoman = CfUtils.IsWoman()
    end
    return {
        playerName    = isNpc and mainSceneInteractionVo.name or MapDecryptionUtils.GetPlayerName(),
        talkContent   = gossipPlotVo.desc,
        voiceId       = isWoman and gossipPlotVo.voiceLady or gossipPlotVo.voice,
        modelGo       = presenterModel,
        action        = gossipPlotVo.action,
        face          = gossipPlotVo.faceId,
        id            = isNpc and mainSceneInteractionVo.id or 0,
        -- modelAni      = presenterModel.gameObject:GetComponent(AnimatorType),
        gossipPlotVos = gossipPlotVos,
        index         = index,
        isEnd         = gossipPlotVo.endFlag == 1,
    }
end

--- GetPlayerName
--- 获取玩家名称
function MapDecryptionUtils.GetPlayerName()
    ---@type PlayerComponent
    local playerComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    return playerComp.playerDojo.playerName
end

--- InitTalkDataByInteractVo
---@param mainSceneInteractionVo MapDecryptionMainSceneInteractionVo
---@param presenterModel         UnityEngine.Transform
function MapDecryptionUtils.InitTalkDataByInteractVo(mainSceneInteractionVo, interactType, presenterModel)
    ---@type MapDecryptionInteractiveLinesVo
    local interactiveLinesVo = MapDecryptionUtils.RandomInteractionTalk(mainSceneInteractionVo.id, interactType)
    return {
        playerName  = mainSceneInteractionVo.name,
        talkContent = interactiveLinesVo.text,
        voiceId     = mainSceneInteractionVo.sex == 1 and interactiveLinesVo.voicecode or interactiveLinesVo.voicecodeLady,
        modelGo     = presenterModel,
        action      = interactiveLinesVo.action,
        face        = interactiveLinesVo.face,
        id          = mainSceneInteractionVo.id,
        -- modelAni    = presenterModel.gameObject:GetComponent(AnimatorType)
    }
end

--- RandomInteractionTalk
--- 从互动台词表随机出一个对话
---@param interactId number 交互Id 即: NPCId
---@param interactType number MapDecryptionConstants.TalkSceneType 互动台词场景表 id
---@return MapDecryptionInteractiveLinesVo
function MapDecryptionUtils.RandomInteractionTalk(interactId, interactType)
    ---@type MapDecryptionInteractiveLinesVo[]
    local vos = MapDecryptionConfMgr:GetAllInteractiveLinesVo(interactId, interactType)
    local randomId = math.random(1, #vos)
    return vos[randomId]
end

--- CreateBubbleNode
--- 创建气泡
---@param parent UnityEngine.GameObject
---@param npcId number 
function MapDecryptionUtils.CreateBubbleNode(parent, npcId)
    return cs_coroutine.start(function ()
        local bubbleName = "Bubble" .. npcId
        local go = parent.transform:Find(bubbleName)
        if not isNull(go) then
            Events.Broadcast(MapDecryptionConstants.EventNames.CreateBubbleSuccess, npcId, go)
            return
        end
        local MapDecryptionConstants = MapDecryptionConstants
        go = MapDecryptionUtils.CreateGameObjectByPath(MapDecryptionConstants.PrefabPath.RoleDialogueBubble, parent)
        if not isNull(parent) and not isNull(go) then
            go.name = bubbleName
            KTool.SetLayer(parent.gameObject, go, true)

            if MapDecryptionConstants then
                Events.Broadcast(MapDecryptionConstants.EventNames.CreateBubbleSuccess, npcId, go)
                
            end
            
        end
    end)
end


function MapDecryptionUtils.CreateVirtualCamera(name, isActive)
    local go = MapDecryptionUtils.CreateGameObject(name, isActive)
    return go:EnsureComponent(CinemachineVirtualCameraType)
end

function MapDecryptionUtils.CreateGameObject(name, isActive)
    local go = GameObject()
    go.name = name
    KTool.ResetTransform(go.transform)
    KTool.SetActive(go, checkBool(isActive))
    return go
end

function MapDecryptionUtils.LoadAppendScene()
    -- cs_coroutine.yield_return(sceneManagement:AppendScene(v, false))
end

-- 卸载 2D迷宫 场景, 回到 3D场景:
function MapDecryptionUtils.QuitMaze()
    
    -- local sceneId_2d = KCookie.Get(MapDecryptionConstants.EventNames.ExploreMapId) -- "39"
    -- if sceneId_2d == nil then
    --     printError("忘记设置 ExploreMapId 了")
    --     return
    -- end

    -- local activityContentId = MapDecryptionMgr:GetActivityData().activityContentId
    -- ---@type MapDecryptionPlanVo
    -- local planVo = MapDecryptionConfMgr:GetPlanVoById(activityContentId)
    -- local sceneId_3d = planVo.sceneId -- "37"


    -- ============= 新版实现 =================
    UIRaycastBlocker:AddCondition("MapDecryptionUtils.QuitMaze")
    cs_coroutine.start(function()
        UIRaycastBlocker:RemoveCondition("MapDecryptionUtils.QuitMaze")

        Maze2DStates.Clear() -- 清空 2D迷宫的公共数据

        Events.Broadcast(MapDecryptionConstants.EventNames.RestoreBrainBlend)

        -- 恢复 3D主场景 bgm
        MapDecryptionUtils.SetBgmPlayStatus(true)

        MazeLoadScene:BackTo3DScene()
        while MazeLoadScene.isLoadFinished == false do
            cs_coroutine.yield_return()
        end
        
        
    end)

end

--- FillController
---@param go UnityEngine.GameObject
---@param loader any
function MapDecryptionUtils.FillController(go, loader, applyRootMotion)
    ---@type UnityEngine.Animator
    local animator = KTool.GetOrAddComponent(go, AnimatorType)

    while not loader.IsCompleted do
        yield_return()
    end
    if loader.IsSuccess then
        animator.runtimeAnimatorController = loader.ResultObject
        if applyRootMotion ~= nil then
            animator.applyRootMotion = applyRootMotion
        end
        loader:Retain(go)
    end
    loader:Release()
    return animator
end

--- PlayStory
---@param story string 剧情路径
---@param luaEnvPath string lua路径
---@param onWaitStart function 
function MapDecryptionUtils.PlayStory(story, luaEnvPath, onWaitStart)
    local plotLoader, plotGo
    --print("tpr - MapDecryptionUtils.PlayStory")
    return ChapterUtils.StartExternalChapter(story, function(loader, go)
        if onWaitStart then
            onWaitStart()
        end

        plotLoader, plotGo = loader, go

        local lastDialog = UIModule.CurrentScreen:LastDialog()
        if not isNull(lastDialog) then
            lastDialog.transform.localPosition = Vector3(9999, 9999, 9999)
            
        end
    end, function()
        KTool.SafeDelete(plotGo)
        if plotLoader then
            plotLoader:Release(true)
        end
        local lastDialog = UIModule.CurrentScreen:LastDialog()
        if not isNull(lastDialog) then
            lastDialog.transform.localPosition = Vector3.zero
        end

    end, function (go)
        local env = CfUtils.GetLuaScr(go, luaEnvPath)
        if not isNull(env) then
            env:Initialize()
            env:StartPlay()
        end
    end)
end

--- CopyLookAtIKParams
---@param dstGo UnityEngine.GameObject
---@param srcGo UnityEngine.GameObject
function MapDecryptionUtils.CopyLookAtIKGoParams(dstGo, srcGo)
    if isNull(srcGo) then return end
    local srcLookAtIK = srcGo:GetComponent(LookAtIKType)
    if isNull(srcLookAtIK) then return end
    local dstLookAtIK = dstGo:GetComponent(LookAtIKType)
    MapDecryptionUtils.CopyLookAtIKParams(dstLookAtIK, srcLookAtIK)

end

--- CopyLookAtIKParams
---@param dstLookAtIK RootMotion.FinalIK.LookAtIK
---@param srcLookAtIK RootMotion.FinalIK.LookAtIK
function MapDecryptionUtils.CopyLookAtIKParams(dstLookAtIK, srcLookAtIK)
    if isNull(dstLookAtIK) then return end

    local dstSolver = dstLookAtIK.solver
    local srcSolver = srcLookAtIK.solver

    dstSolver:SetLookAtWeight(
        srcSolver.IKPositionWeight,
        srcSolver.bodyWeight,
        srcSolver.headWeight,
        srcSolver.eyesWeight,
        srcSolver.clampWeight,
        srcSolver.clampWeightHead,
        srcSolver.clampWeightEyes
    )
    dstSolver.clampSmoothing = srcSolver.clampSmoothing

end

--- CopyLookAtControllerParams
---@param dstLookAtIK RootMotion.FinalIK.LookAtController
---@param srcLookAtIK RootMotion.FinalIK.LookAtController
function MapDecryptionUtils.CopyLookAtControllerParams(dstLookAtController, srcLookAtController)
    if isNull(srcLookAtController) then return end

    dstLookAtController.weight                  = srcLookAtController.weight
    dstLookAtController.offset                  = srcLookAtController.offset
    dstLookAtController.targetSwitchSmoothTime  = srcLookAtController.targetSwitchSmoothTime
    dstLookAtController.weightSmoothTime        = srcLookAtController.weightSmoothTime
    dstLookAtController.smoothTurnTowardsTarget = srcLookAtController.smoothTurnTowardsTarget
    dstLookAtController.maxRadiansDelta         = srcLookAtController.maxRadiansDelta
    dstLookAtController.maxMagnitudeDelta       = srcLookAtController.maxMagnitudeDelta
    dstLookAtController.slerpSpeed              = srcLookAtController.slerpSpeed
    dstLookAtController.pivotOffsetFromRoot     = srcLookAtController.pivotOffsetFromRoot
    dstLookAtController.minDistance             = srcLookAtController.minDistance
    dstLookAtController.maxRootAngle            = srcLookAtController.maxRootAngle

end

--- CalcAngleAndClockwise 
--- 计算两个人物的角度与时针方向
---@param forward UnityEngine.Vector3
---@param pos1 UnityEngine.Vector3
---@param pos2 UnityEngine.Vector3
function MapDecryptionUtils.CalcAngleAndClockwise(forward, pos1, pos2)
    local direction  = Vector3(pos1.x - pos2.x, pos1.y - pos2.y, pos1.z - pos2.z)
    return MapDecryptionUtils.CalcAngleAndClockwiseByVector(forward, direction)
end

--- CalcAngleAndClockwise 
--- 计算两个向量的角度与时针方向
---@param v1 UnityEngine.Vector3 向量1
---@param v2 UnityEngine.Vector3 向量2
function MapDecryptionUtils.CalcAngleAndClockwiseByVector(v1, v2)
    -- 顺时针为 1, 逆时针为 -1
    local clockwise = 1
    if Vector3.Cross(v1, v2).y < 0 then
        clockwise = -1
    end
    local angle     = Vector3.Angle(v1, v2)

    return angle, clockwise
end


function MapDecryptionUtils.IsPCPlatform()
    if tonumber(IsActiveControlJoystick) == 1 then
        return false
    end
    return GameUtils.IsPCPlatform()
end

return MapDecryptionUtils