--[[
    author:luqucheng
    time:2021-12-17 14:06:55
]]
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local KTool = CS.Engine.Lib.KTool
local gameUtils = CS.GameUtils
local SettingMgr = SettingMgr:GetInstance()
local UIEventProxy = CS.Engine.UI.UIEventProxy
local EventDragProxy = CS.Engine.UI.EventDragProxy
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
local MonoHelper = CS.Engine.Lib.MonoHelper
local ResourceModule = CS.Engine.Modules.ResourceModule
local Animator = CS.UnityEngine.Animator
local UIModule = CS.Engine.UI.UIModule
local GameInitScene = 13
local KCookie = CS.Engine.Lib.KCookie
local cs_coroutine = require 'XLua.cs_coroutine'
local GameObject = CS.UnityEngine.GameObject
local RolesShowMgr = import('Game.Robot.RolesShowMgr')
local CriWareUtils =  import('Game.Entry.CriWareUtilsFix')
local QTEConstants = import('Game.QTE.QTEConstants')
local QTEShared = import('Game.QTE.QTEShared')

------------ import ------------
local UINavigationBarRoot = CS.UINavigationBarRoot
------------ import ------------

------------ define ------------
------------ define ------------

---@class QTEMgr
---@field op4                           	UnityEngine.Playables.PlayableDirector  
---@field op3                           	UnityEngine.Playables.PlayableDirector  
---@field op2                           	UnityEngine.Playables.PlayableDirector  
---@field op1                           	UnityEngine.Transform                   
---@field director                      	UnityEngine.Playables.PlayableDirector  
---@field Canvas                        	UnityEngine.Canvas                      
---@field TouchHandler                  	UnityEngine.RectTransform               
       
         

local QTEMgr = Class("QTEMgr")

local DragState = {
    None = 0,
    Start = 1,
    End = 2,
}

local LongTouchState = {
    None = 0,
    Start = 1,
    End = 2,
}

QTEMgr.enableClick = false
QTEMgr.clickRect = nil

QTEMgr.enableDrag = false
QTEMgr.dragState = DragState.None
QTEMgr.overrideTime = 0
QTEMgr.loaderDic = nil

QTEMgr.enableLongTouch = false
QTEMgr.longTouchState = LongTouchState.None

function QTEMgr:__init()
    print("QTEMgr __init")
    self.director = nil
    self.enableClick = false
    self.clickRect = nil
    self.enableDrag = false
end

function QTEMgr:__delete()
    print("QTEMgr __delete")
    self.timelineNotificationReceiver:CustomOnNotify("-", self.__ProcessNofity)
    self.__ProcessNofity = nil

    if self.__lateUpdateHandle then
        MonoHelper.RemoveLateUpdateListener(self.__lateUpdateHandle)
        self.__lateUpdateHandle = nil
    end

    
    
    self.controller = nil
end

function QTEMgr:Awake()
    xRecord.record('1-010')
    print("QTEMgr Awake")
    -- self.director = KTool.GetComponent(self.gameObject, typeof(CS.UnityEngine.Playables.PlayableDirector))
    self.binder = self.controller.gameObject:AddComponent( typeof(CS.Game.Native.Timeline.TimelineBinder) )
    self.binder2 = self.op2.gameObject:AddComponent( typeof(CS.Game.Native.Timeline.TimelineBinder) )
    self.binder3 = self.op3.gameObject:AddComponent( typeof(CS.Game.Native.Timeline.TimelineBinder) )
    self.binder4 = self.op4.gameObject:AddComponent( typeof(CS.Game.Native.Timeline.TimelineBinder) )
    -- self.mainCanvas = CS.Engine.UI.UIRootCanvas.main.gameObject
    -- self.mainCanvas:SetActive(false);



    
    -- if not QTETest then
    UIModule.CloseDialogById(GameInitScene)
    UIModule.CloseDialogById(Constants.UITypeIds.PassportDialog)
    UIModule.CloseDialogById(Constants.UITypeIds.GameCreateRole)
    -- end
   

    self.timelineNotificationReceiver =  KTool.GetComponent(self.controller.gameObject, typeof(CS.TimelineNotificationReceiver))
    self.__ProcessNofity = Bind(self, self.ProcessNofity)
    self.timelineNotificationReceiver:CustomOnNotify("+", self.__ProcessNofity)



    self.letter = self.director.gameObject:GetComponentInChildren(typeof(CS.LetterTyperComp))
    KTool.SetActive(self.letter, false)
    if not self.letter.Inited then
        self.letter:Init()
        self.letter.Inited = false
    end

    local proxy = UIEventProxy.Create(self.TouchHandler.gameObject)
    proxy.onPointerClick = Bind(self, self.OnClick)
    proxy.onPointerDown = Bind(self, self.OnPointerDown)
    proxy.onPointerUp = Bind(self, self.OnPointerUp)

    local dragProxy = EventDragProxy.Create(self.TouchHandler.gameObject)
    dragProxy.onPointerDrag = Bind(self, self.OnDrag)

    self.director.playOnAwake = false

   

    -- for i=0,self.director.playableAsset.outputs.Length do
    --     print("??????", i)
    -- end
    -- for k, playableAsset in support.dictionary_ipairs(self.director.playableAsset.outputs) do
    --     local track = playableAsset.sourceObject
    --     if track.streamName == "Control Track" then
    --         for k2, clip in support.dictionary_ipairs(track:GetClips()) do
    --             if clip.displayName == "fx_OP_part02" then
    --                 print("fx_OP_part02", clip.start, clip["end"], clip.duration)
    --             end
    --         end
    --     end
    -- end
    
    local parent = self.director.transform.parent
    local Camera = CS.UnityEngine.Camera
    local Canvas = CS.UnityEngine.Canvas
    self.uiBaseCam = parent:Find("UIBaseCam").gameObject:GetComponent(typeof(Camera))
    self.uiTopCam = parent:Find("UICameraTop").gameObject:GetComponent(typeof(Camera))
    self.baseTopCam = parent:Find("Camera").gameObject:GetComponent(typeof(Camera))
    self.arrCanvas = parent.gameObject:GetComponentsInChildren(typeof(Canvas), true)

    KCookie.Set("QTEShow", 1)
    -- self.director.time = 60
    self.needLoading = false

    local step = QTEShared:GetInstance():GetCurrentStep()
    
    self.director.initialTime = QTEConstants.QTEInitTime[step]

    if step == QTEConstants.QTESavePoint.Door then
        self:OnSound({ soundId = "bgm_prologue_malu", isBGM = true, isStop = false})
    elseif step == QTEConstants.QTESavePoint.DianFanBao then
        self:OnSound({ soundId = "bgm_prologue_coffee", isBGM = true, isStop = false})
    end
    
    local op2Clip = self.binder:FindClipByTrackAndClipName("Control Track", "fx_OP_part02")
    local op3Clip = self.binder:FindClipByTrackAndClipName("Control Track (1)", "OP_part03")
    self.op2StartTime = 64
    if op2Clip then
        print("fx_OP_part02", op2Clip.start, op2Clip["end"], op2Clip.duration)
        print("init time", self.director.initialTime)
        self.needLoading = self.director.initialTime >= op2Clip.start
        self.op2StartTime = op2Clip.start
    end
    self.mainSceneEnterTime = op3Clip and op3Clip["end"] or 78
    
    print("openTime ", self.mainSceneEnterTime)
    print("need loading ", self.needLoading)
    
    CriWareUtils.StopAll()

    self:OnInitialize()

end

function QTEMgr:OnShow()
    print("QTEMgr OnShow")

    --- @type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
    end))
    return coWait
end

function QTEMgr:OnInitialize()
    print("Entrance 0")
    print("QTEMgr OnInitialize")
    
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
    print("QTEMgr OnInitialize coWait")
        self.loaderDic = {}
        --加载手
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        local isFemale = not isNull(playerComponent) and playerComponent.playerDojo and (checkInt(playerComponent.playerDojo.gender) == Constants.PLAYER_GENDER.FEMALE)

        -- print("isFemale", isFemale, playerComponent.playerDojo.gender, typeof(playerComponent.playerDojo.gender))


        local handPath = "Arts/Prefab_home/Prefab_runtime_item/100_hand_m.prefab" --"Arts/Prefab_item/100_hand_f.prefab"
        if isFemale then
            handPath = "Arts/Prefab_home/Prefab_runtime_item/100_hand_f.prefab"
        end
        local handLoader = ResourceModule.LoadBundleAsync(handPath, nil, true)
        self.loaderDic["hand"] = handLoader

        local handCardPath = "Arts/Prefab_home/Prefab_runtime_item/100_handcard_m.prefab" 
        if isFemale then
            handCardPath = "Arts/Prefab_home/Prefab_runtime_item/100_handcard_f.prefab" 
        end
        local handCardLoader = ResourceModule.LoadBundleAsync(handCardPath, nil, true)
        self.loaderDic["handCard"] = handCardLoader

        local isAllFinish = false
        while not isAllFinish do
            isAllFinish = true
            for k,loader in pairs(self.loaderDic) do
                if not loader.IsSuccess then
                    isAllFinish = false
                end
            end
            coroutine.yield()
        end

        if not handLoader.IsError then
            self.hand = CS.UnityEngine.GameObject.Instantiate(handLoader.ResultObject, self.op1)
            self.binder3:SetTrackDynamic("HandTrack3", self.hand)
            self.binder4:SetTrackDynamic("HandTrack4", self.hand)
            KTool.SetActive(self.hand, false)

            self.binder3:SetTrackDynamic("HandActiveTrack3", self.hand)
            self.binder4:SetTrackDynamic("HandActiveTrack4", self.hand)
        end
        if not handCardLoader.IsError then
            self.handCard = CS.UnityEngine.GameObject.Instantiate(handCardLoader.ResultObject, self.op1)
            self.binder:SetTrackDynamic("HandcardTrack1", self.handCard)
            if self.needLoading then
                KTool.SetActive(self.handCard, false)
            end
        end

        local camCtrl = CS.Game.Native.URP.URPCameraController.Instance

        local loadingUI = nil
        if self.needLoading then
            local mainCanvas = CS.Engine.UI.UIRootCanvas.main.canvas
            self.Canvas.renderMode = mainCanvas.renderMode  --CS.UnityEngine.RenderMode.ScreenSpaceCamera
            self.prevCam = self.Canvas.worldCamera
            self.Canvas.worldCamera = mainCanvas.worldCamera
            self.Canvas.sortingOrder = mainCanvas.sortingOrder - 1
            self.Canvas.sortingLayerName = mainCanvas.sortingLayerName

            local loadingGo = GameObject.Find("LoginLoadingPanel")
            if not loadingGo then
                GameUtils.OpenLoadingPanel(nil, nil, Constants.LoadingType.MainHome, true)
                --GameUtils.OpenLoadingPanel()
                loadingGo = GameObject.Find("LoginLoadingPanel")
                
                --self.mainCamera
                KTool.SetActive(camCtrl.uiCamera, true)
            end
            ---@type LoginLoadingPanel
            loadingUI = GetLuaBehaviour(loadingGo, "Game.Behaviours.LoginLoadingPanel").Env
            coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
            coroutine.yield(loadingUI._animator:WaitUntilAniCompleted())

            
        end

        --准备所有视频
        -- local cris = self.controller.gameObject:GetComponentsInChildren(typeof(CS.CriWare.CriManaMovieControllerForUI), true)
        -- for i = 1, cris.Length do
        --     print("Prepare", i)
        --     cris[i - 1]:PlayerManualInitialize()
        --     cris[i - 1].player:Prepare()
        -- end

        -- while not loader.IsSuccess do
        --     coroutine.yield()
        -- end
        -- if not loader.IsError then
        --     CS.UnityEngine.GameObject.Instantiate(loader.ResultObject)
        -- end
        self.displayProgress = 0

        local MainSceneID = QTEConstants.QTECacheKey.MainSceneID
        local id = KCookie.Get(MainSceneID)
        printInfo("Get %s", tostring(id))
        if isNull(id) then
            id = Constants.IdSceneSetting3
        end
        
        local sceneManagement = SceneManagement:GetInstance()
        local sceneData = sceneManagement:GetScenePathInfo(id)
        sceneManagement:Transition({ identifier = sceneData.id, isCache = true })

        while sceneManagement:IsTransition() do
            self.displayProgress = self.displayProgress + 10
            -- loadingUI:__Progress(self.displayProgress * 0.01)
            -- coroutine.yield(Yielders.GetWaitForSeconds(0.02))
            if loadingUI then
                loadingUI:__Progress(self.displayProgress * 0.01)
            end

            coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
        end

        --local ins = sceneManagement:GetSceneInstance(sceneData.id)
        --ins:RemoveCacheObjectByName("Role")
        
        -- sceneManagement:SetActiveScene(sceneManagement:GetSceneInstance(sceneData.id))
        --QTEMgr:CheckSceneLoaded()

        self.sceneId = id
        -- local camObj = GameObject.Find("Camera")
        -- if camObj then
        --     local urpCamera = KTool.GetComponent(camObj, typeof(CS.Game.Native.URP.URPBaseCamera))
        --     urpCamera.enabled = false
        -- end

        
        
        if not self.needLoading then
            sceneManagement:SetActive(sceneData.id, false)
        else
            KTool.SetRenderFeatureActiveByName(Constants.RenderFeatureNames.BLUR, false)
            sceneManagement:SetActive(sceneData.id, true)
            
        end

        if not QTETest then
            ---@type PlayerComponent
            local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
            if playerComponent ~= nil and playerComponent.playerDojo.partyCatInfo and isSet(playerComponent.playerDojo.partyCatInfo, "catId") then
                ---加载一只猫
                local catInfo = playerComponent.playerDojo.partyCatInfo
                
                local isFinish = false
                cs_coroutine.start(function()
                    cs_coroutine.yield_return(CS.Game.Native.Corder.AutoPNGWriter.LoadCatAsync(2, tostring(catInfo.catId), false, catInfo.genes, nil, function(go)
                        ---@type UnityEngine.Transform
                        local trans = go.transform
                        go.name = "CatHouseCat"
                        KTool.ResetTransform(trans)
                        self.cat = go
                        isFinish = true

                        self.binder3:SetTrackDynamic("CatTrack1", self.cat)
                        -- self.binder4:SetTrackDynamic("CatTrack2", self.cat)

                        sceneManagement:GetSceneInstance(sceneData.id):AddCacheObject(go)
                    end))
                end)
                while not isFinish do
                    coroutine.yield()
                end
            end

            -- local parGo = sceneManagement:GetSceneInstance(sceneData.id):GetCacheObjectByName("Role")
            -- local cameraRootGo = sceneManagement:GetSceneInstance(sceneData.id):GetCacheObjectByName("CameraRoot")
            -- -- sceneManagement:GetSceneInstance(sceneData.id):RemoveCacheObjectByName("Role")
            -- if isNull(parGo) then
            --     parGo = GameObject("Role")
            -- end
            -- if not isNull(parGo) then
            --     --sceneManagement:GetSceneInstance(sceneData.id):AddCacheObject(parGo)
            --     coroutine.yield(RolesShowMgr:GetInstance():InitData(parGo, cameraRootGo))
            -- end
            -- -- KTool.SetActive(parGo, true)
            -- local r = RolesShowMgr:GetInstance():GetRoleInstance("108")
            -- -- Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShow = true})
            -- if r then
            --     local w = GameObject.Instantiate(r._modelGo)
            --     -- KTool.SetActive(r._parGo, true)
            --     self.binder2:SetTrackDynamic("RoleTrack1", w)
            --     self.binder2:SetTrackDynamic("RoleActiveTrack1", w)
            --     -- self.binder4:SetTrackDynamic("RoleTrack2", w)
            --     self.role = w
            -- end
        end

        if loadingUI then
            loadingUI:__Progress(1)
            coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
            coroutine.yield(loadingUI:PlayAndWaitFinish())
            loadingUI:Close()
            coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
            --self.Canvas.renderMode = CS.UnityEngine.RenderMode.ScreenSpaceOverlay



            self.Canvas.worldCamera = self.prevCam
            self.Canvas.sortingOrder = 0
        end

        -- local isFirstStartGame = checkNumber(KCookie.Get('isFirstStartGame'))
        -- if isFirstStartGame == 0 then
        --     Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShow = true})
        -- end

        -- Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShow = true})
        self.mainCamera = camCtrl.mainCamera
        KTool.SetActive(self.mainCamera.gameObject, false)
        KTool.SetActive(camCtrl.uiCamera, false)
        
        KTool.SetActive(self.letter.transform.parent, false)
        GameUtils.SetBodyShadow(false)
        
        self.director:Play()
        
        printInfo("play")

        self.__lateUpdateHandle = Bind(self, self.LateUpdate)
        MonoHelper.AddLateUpdateListener(self.__lateUpdateHandle)
    end))
    return coWait
end

function QTEMgr:OnDestroy()

    MonoHelper.RemoveLateUpdateListener(self.__lateUpdateHandle)
    
    for k,loader in pairs(self.loaderDic) do
        loader:Release()
    end
end

function QTEMgr:TypeLetter(notification)
    local id = notification.letterId
    local appearDuration = notification.appearDuration
    local pendingTime = notification.pendingTime
    local duration = notification.duration
    local isPauseTimeline = notification.isPauseTimeline

    --读取文字配置
    local data = SettingMgr:Get(AutoIds.IdSetting3000)
    local row = data:GetByPrimaryKey(id)
    assert(row, '找不到对应的战斗参数'..id)
    local word = parse_string(row,"desc", '')
    print("QTEMgr", word)

    if not QTETest then
        if isNull(self.playerName) then
            local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
            self.playerName = playerComponent ~= nil and playerComponent.playerDojo.playerName or ""
        end
        word = string.gsub(word, "#playerName", self.playerName)
    end
   
    local voiceKey = parse_string(row,"voice", '')
    print("voiceKey", voiceKey)
    print("ifXiaobai", parse_number(row,"ifXiaobai", 0))

    if not Tools.isNullKey(voiceKey) then
        local lipObj = nil
        if parse_number(row,"ifXiaobai", 0) == 1 then
            lipObj = self:FindLipObj()
        end
        CriWareUtils.PlayVoiceById(voiceKey, lipObj)
    end

    local letter = self.letter
    letter.TextWillFill = word
    letter.AppearDuration = appearDuration
    letter.PendingTime = pendingTime
    letter:StartType()
    if self.typeCo then
        cs_coroutine.stop(self.typeCo)
    end
    if isPauseTimeline then
        self:Pause()
    end
    self.typeCo = cs_coroutine.start(function()
        coroutine.yield(CS.UnityEngine.WaitForSecondsRealtime(duration))
        self:ClearLetter()
        self.typeCo = nil
        if isPauseTimeline then
            self:Resume()
        end 
    end)
end

function QTEMgr:FindLipObj()
    local tlLip = self.controller:GetComponentInChildren(typeof(CS.CriWare.CriLipsDeformerForAtomSource))
    if not isNull(tlLip) and tlLip.gameObject.activeInHierarchy then
        return tlLip.gameObject
    end
    
    local roleRoot = GameObject.Find("Role")
    if isNull(tlLip) then
        return
    end
    tlLip = roleRoot:GetComponentInChildren(typeof(CS.CriWare.CriLipsDeformerForAtomSource))
    if not isNull(tlLip) and tlLip.gameObject.activeInHierarchy then
        return tlLip.gameObject
    end
end

function QTEMgr:ClearLetter()
    local letter = self.letter
    if isNull(letter:GetTextComp()) then
        return
    end
    letter:ResetArgs()
    letter.TextWillFill = ""
    --letter:StartType()
    letter:SetText("")
end

function QTEMgr:PlayHandAndBadgeIdle()
    if self.handCard then
        self.binder:SetTrackDynamic("HandcardTrack1", nil)
        local anim = self.handCard:GetComponent(typeof(Animator))
        anim:CrossFade("OP_part01_100_handcard_idle", 0.1, 0)
    end
end

function QTEMgr:BindHandAndBadge()
    if self.handCard then
        self.binder:SetTrackDynamic("HandcardTrack1", self.handCard)
    end
end

function QTEMgr:ProcessNofity(origin, notification, context)
    local notifyType = notification:GetType();
    print("ProcessNofity", notifyType)

    if notifyType == typeof(CS.Game.Native.QTE.QTEFullScreenTouchMarker) then
        self.enableClick = true
      
        self:Pause()
    elseif notifyType == typeof(CS.Game.Native.QTE.QTEDragMarker) and self.dragState ~= DragState.End then
        self:PlayHandAndBadgeIdle()
        
        -- print(origin)
        self.dragStartRect = notification.startRect:Resolve(self.director)
        self.dragEndRect = notification.endRect:Resolve(self.director)
        self.dragStartTimelineTime = notification.time
        self.dragEndTimelineTime = notification.endTimelineTime + self.dragStartTimelineTime
        self.enableDrag = true
        -- print(self.dragStartRect)
        self.overrideTime = self.dragStartTimelineTime
        self.stopSoundId = notification.stopSoundId
        self:Pause()
        self:InvokeUICtrlCall(false)
    elseif notifyType == typeof(CS.Game.Native.QTE.QTEShowMainSceneMarker) then
        local sceneManagement = SceneManagement:GetInstance()
        local sceneData = sceneManagement:GetScenePathInfo(self.sceneId)
        sceneManagement:SetActive(sceneData.id, true)
        CfUtils.ChangeMainCamDefalultBlend(0)
        KTool.SetRenderFeatureActiveByName(Constants.RenderFeatureNames.BLUR, false)
        -- self.brain = URPCameraController.mainCamera.gameObject:GetComponent(typeof(CinemachineBrain))
    elseif notifyType == typeof(CS.Game.Native.QTE.QTERectTouchMarker) then
        self.enableClick = true
        self.clickRect = notification.touchRect:Resolve(self.director)
        self:Pause()
        self:InvokeUICtrlCall(false)
    elseif notifyType == typeof(CS.Game.Native.QTE.QTELongTouchMarker) and self.longTouchState ~= LongTouchState.End then
        self.enableLongTouch = true
        self.touchTotalTime = notification.touchTime
        self.touchStartTime = notification.time
        self.touchRect = notification.touchRect:Resolve(self.director)
        self.overrideTime = self.touchStartTime
        self.stopSoundId = notification.stopSoundId
        self:Pause()
        self:InvokeUICtrlCall(false)
    elseif notifyType == typeof(CS.Game.Native.QTE.QTEShowLetterMarker) then
        self:TypeLetter(notification)
    elseif notifyType == typeof(CS.Game.Native.QTE.QTESoundPlayMarker) then
        self:OnSound(notification)
    end
end

function QTEMgr:OnSound(notification)
    local soundId = notification.soundId
    if notification.isStop then
        CriWareUtils.StopById(soundId)
        return
    end
    if notification.isBGM then
        CriWareUtils.PlayMusicById(soundId)
    else
        CriWareUtils.PlaySeById(soundId)
    end
end

function QTEMgr:OnClick(eventData)
    if self.enableClick then
        print(self.clickRect)
        if isNull(self.clickRect) or self:IsInTouchArea(eventData, self.clickRect) then
            self:Resume();
            self.controller:BroadcastMessage("Finish")
            self.enableClick = false
            self.clickRect = nil
            if self.typeCo then
                cs_coroutine.stop(self.typeCo)
            end
            self:ClearLetter()
            xRecord.record('1-012')
        end
    end
    
end

function QTEMgr:OnPointerDown(eventData)
    if self.enableDrag and not isNull(self.dragStartRect) then
        if self:IsInTouchArea(eventData, self.dragStartRect) then
            self:BindHandAndBadge()
            self.dragStartPos = self:GetUIPos(eventData)
            self.dragState = DragState.Start
            print("in")
        else
            print("out")
            self.dragState = DragState.None
        end
    end

    if self.enableLongTouch and self.touchRect then
        if self:IsInTouchArea(eventData, self.touchRect) then
            self.longTouchState = LongTouchState.Start
            CriWareUtils.PlaySeById(self.stopSoundId)
        end
    end
end

function QTEMgr:OnPointerUp()
    if self.enableDrag then
        print("up")
        self.dragState = DragState.None
        self.overrideTime = self.dragStartTimelineTime
        self:PlayHandAndBadgeIdle()
        CriWareUtils.StopById(self.stopSoundId)
        -- self.stopSoundId = nil
    end
    if self.enableLongTouch then
        self.longTouchState = LongTouchState.None
        self.overrideTime = self.touchStartTime
        CriWareUtils.StopById(self.stopSoundId)
        -- self.stopSoundId = nil
    end
end

---@param eventData UnityEngine.EventSystems.PointerEventData
function QTEMgr:OnDrag(eventData)
    if self.enableDrag and self.dragState == DragState.Start then
        --找到出发点到当前点的向量在拖拽方向上的投影
        local pos = self:GetUIPos(eventData)
        local v1 = Vector2.New(pos.x - self.dragStartPos.x, pos.y - self.dragStartPos.y)
        local v2 = Vector2.New(self.dragEndRect.anchoredPosition.x - self.dragStartPos.x, self.dragEndRect.anchoredPosition.y - self.dragStartPos.y)
        local l = Vector2.Dot(v1, v2)

        local percent = math.range( l / Vector2.Magnitude(v2) / Vector2.Magnitude(v2), 0, 1)
        print(l, Vector2.Magnitude(v2), percent)
        self.overrideTime = percent * (self.dragEndTimelineTime - self.dragStartTimelineTime) + self.dragStartTimelineTime

        if percent >= 1 then
            self:EndDrag()
        end
    end
end

function QTEMgr:Pause()
    self.isPaused = true
    self.director:Pause()
end

function QTEMgr:Resume()
    self.isPaused = false
    self.director:Resume()
end

function QTEMgr:EndDrag()
    local t = self.dragEndTimelineTime
    self.enableDrag = false
    self.director.time = t
    self.dragState = DragState.End
    self.director:Evaluate()
    self:Resume()
    self.controller:BroadcastMessage("Finish")
    xRecord.record('1-014')
end

function QTEMgr:GetUIPos(eventData)
    local void, pos = CS.UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.Canvas.transform,
        eventData.position, eventData.enterEventCamera);
    -- local void, pos = CS.UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.Canvas.transform,
    --     eventData.position, self.Canvas.worldCamera);
    return pos
end

function QTEMgr:LateUpdate(dt)
    if self.enableDrag or self.enableLongTouch then
        self.director.time = self.overrideTime
    end
    if self.enableLongTouch and self.longTouchState == LongTouchState.Start then
        self.overrideTime = self.overrideTime + CS.UnityEngine.Time.deltaTime
        if self.overrideTime >= self.touchStartTime + self.touchTotalTime then
            self.enableLongTouch = false
            self.longTouchState = LongTouchState.End
            xRecord.record('1-015')
            self.director:Evaluate()
            self:Resume()
        end
    end

    if self.director.time >= self.mainSceneEnterTime and not self.openMain then
        print("openMain")
        if QTEReview then
            CS.Engine.UI.UIModule.Clear()
        end
        self.openMainCo = cs_coroutine.start(function() 
            coroutine.yield(CS.Engine.UI.UIModule.OpenScreen({ id = Constants.UITypeIds.UISceneHome }, true, {}))
            self.openMainCo = nil
        end)
        KCookie.Set(QTEConstants.QTECacheKey.OpenMainCo, self.openMainCo)
        
        self.openMain  = true
    end

    if self.director.time >= QTEConstants.QTEInitTime[QTEConstants.QTESavePoint.Door] and not self.changeCam then

        for i = 1, self.arrCanvas.Length do
            self.arrCanvas[i - 1].worldCamera = self.uiTopCam
        end
        
        --KTool.SetActive(self.baseTopCam, true)
        
        self.changeCam = true
    end

    if self.director.time >= self.op2StartTime and not isNull(self.handCard) then
        local h = self.handCard
        self.handCard = nil
        KTool.SetActive(h, false)
    end

    if self.isPaused then
        self.director:Evaluate()
    end
    
    local step = QTEShared:GetInstance():GetCurrentStep()
    if step >= QTEConstants.QTESavePoint.Door and step <= QTEConstants.QTESavePoint.DianFanBao then
        if self.recordPass == nil then
            self.recordPass = {}
        end
        if not isSet(self.recordPass, step) and self.director.time >= QTEConstants.QTEInitTime[step] then
            self.recordPass[step] = step
            QTEShared:GetInstance():IncreaseStep()
        end
    end
    

    if self.director.duration <= self.director.time then
        print("OnFinish", self.director.duration, self.director.time)
        self:OnFinish()
    end
end

function QTEMgr:OnFinish()
    -- CfUtils.WriteLocalData("QTESTATUS", 1)
    -- CS.UnityEngine.GameObject.Destroy(self.controller.gameObject)
    -- self.controller = nil
    -- self:Delete()
    -- self.mainCanvas:SetActive(true);
    -- CS.Engine.UI.UIModule.OpenScreen({ id = Constants.UITypeIds.UISceneHome }, true, {})

    -- self.cat.transform.position = Vector3.New(2.948, 1.034, -2.316)
    -- self.cat.transform.localRotation = Quaternion.Euler(0, -62.533, 0)
    -- CS.UnityEngine.GameObject.Destroy(self.role.gameObject)
    --CfUtils.ChangeMainCamDefalultBlend(2)
    --KCookie.Set('QTEShow', 0)
    --KCookie.Set('QTEEnd', 1)
    --CfUtils.WriteLocalData("QTEOPEN", 0)

   

    xTry(function()
        local camObj = GameObject.Find("Camera")
        if camObj then
            local opCam = self.op4:GetComponentInChildren(typeof(CS.UnityEngine.Camera))
            if not isNull(opCam) then
                camObj.transform.position = opCam.transform.position
                camObj.transform.rotation = opCam.transform.rotation
                local camObjCamera = camObj:GetComponent(typeof(CS.UnityEngine.Camera))
                if not isNull(camObjCamera) then
                    camObjCamera.fieldOfView =  opCam.fieldOfView
                end
                -- print(--------------------------)
                print("--------------------------", opCam.transform.position)
                print("--------------------------", opCam.transform.rotation)
                print("--------------------------", camObj.transform.position)
                print("--------------------------", camObj.transform.rotation)
            end

            local urpCamera = KTool.GetComponent(camObj, typeof(CS.Game.Native.URP.URPBaseCamera))
            urpCamera:CopyCamera()
            -- urpCamera.enabled = true
        end
    end)

    --KTool.SetActive(self.mainCamera.gameObject, true)

    --CS.UnityEngine.GameObject.Destroy(self.controller.gameObject)
    self.controller = nil
    self:Delete()
end

function QTEMgr:IsInTouchArea(eventData, touchRect)
    return RectTransformUtility.RectangleContainsScreenPoint(touchRect, eventData.position, eventData.enterEventCamera)
    -- local pos = self:GetUIPos(eventData)
    -- local dis = Vector2.New(pos.x - touchRect.anchoredPosition.x, pos.y - touchRect.anchoredPosition.y)
end

function QTEMgr:RegisterUICtrlCall(uiCtrlCall)
    self.uiCtrlCall = uiCtrlCall
end

function QTEMgr:InvokeUICtrlCall(param)
    if self.uiCtrlCall ~= nil then
        self.uiCtrlCall(param)
    end
end

function QTEMgr:EndOP1()
    self:Pause()
    self.enableClick = false
    self.enableDrag = false
    self.enableLongTouch = false
    self.changeCam = true
    
    self.director.time = self.director.duration
end

function QTEMgr:CheckSceneLoaded()
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
        coroutine.yield()

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

return QTEMgr