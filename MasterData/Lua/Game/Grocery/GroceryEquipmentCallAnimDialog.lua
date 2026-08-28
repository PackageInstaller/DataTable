-------------------------------------------------------------------------------
-- 杂货铺 - 装备抽取 - 抽取动画表现弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-28 11:34:49
-------------------------------------------------------------------------------

local UIModule = CS.Engine.UI.UIModule
local CameraComp = CS.UnityEngine.Camera
local PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local CameraExtensions = CS.UnityEngine.Rendering.Universal.CameraExtensions
local AssetFileLoader = CS.Engine.Modules.AssetFileLoader
local ResourceModule = CS.Engine.Modules.ResourceModule
---@type Game.Native.URP.URPCameraController
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local sceneManagement = SceneManagement:GetInstance()
---@type GroceryConstants
local GroceryConstants = import('Game.Grocery.GroceryConstants')
---@type GachaponUtils
local GachaponUtils = import('Game.Gachapon.GachaponUtils')
---@type GroceryUtils
local GroceryUtils = import('Game.Grocery.GroceryUtils')
---@type GoodsConfMgr
local goodsConfMgr = GoodsConfMgr:GetInstance()
---@type BackpackComponent
local backpackComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.BackpackComponent)

local ANIM_PLAY_BLOCKER  = 'GroceryEquipmentCallAnimDialog_ANIM_PLAY_BLOCKER'
local ANIM_CACHE_GO_NAME = '_CallEquipCache_'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverseaStore/OverseaStoreEquipDrawOpenDialog.prefab
---@class GroceryEquipmentCallAnimDialog
---@field Env                           	GroceryEquipmentCallAnimDialog          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field StopButton                    	UnityEngine.RectTransform               @ 停止连续按钮
---@field HandNode                      	UnityEngine.RectTransform               @ 点击提醒节点
---@field ScreenBtn                     	UnityEngine.UI.Button                   @ 全屏点击区域
---@field Container                     	UnityEngine.RectTransform               @ 
local GroceryEquipmentCallAnimDialog = Class('GroceryEquipmentCallAnimDialog')


function GroceryEquipmentCallAnimDialog:__init()
    ---@type table @ 装备商店数据
    self.groceryData_ = nil
    ---@type integer @ 抽取类型（1：单抽，2：十连）
    self.equipCallType_ = 0
    ---@type integer @ 当前抽取的次数
    self.currentCallTimes_ = 0
    ---@type integer @ 目标抽取的次数（-1：无限模式）
    self.targetCallTimes_ = 0
    ---@type boolean @ 是否分解模式
    self.isDecomposeMode_ = false
    ---@type table<integer, table> @ 累计的奖励数据（key：道具id，value：道具数据）
    self.callRewardMap_ = {}
    ---@type table<integer, table> @ 累计的消耗数据（key：道具id，value：道具数据）
    self.callConsumeMap_ = {}
    ---@type table<integer, table> @ 累计的分解数据（key：道具id，value：道具数据）
    self.callDecomposeMap_ = {}
    ---@type table[] @ 每次抽到的显示数据
    self.callDisplayDatas_ = nil
    ---@type integer[] @ 需要显示的货币id列表
    self.currencyIdList_ = nil
    ---@type boolean @ 是否终止连续抽取
    self.isStopContinue_ = false
    ---@type GroceryConstants.GroceryType @ 进入的商店类型
    self.openGroceryType_ = nil
    ---@type integer @ 装备背包数量
    self.oldQquipPackNum_ = 0
    ---@type integer @ 装备背包数量
    self.oldGoodsPackNum_ = 0
    ---@type UICommonMainlineTaskTipsNode
    self.taskTipsNode_ = nil
    ---@type UnityEngine.Coroutine
    self.showRewardPopupCo_ = nil
    ------------------------------------------------- [cache about]
    ---@type table<string, UnityEngine.Coroutine> @ 资源预加载的协程map（key：资源路径，value：加载协程）
    self.assetsPreloadCoMap_ = {}
    ---@type table<string, UnityEngine.Coroutine> @ 资源加载的协程map（key：资源路径，value：加载协程）
    self.assetsLoadCoMap_ = {}
    ---@type table<string, Engine.Modules.AbstractResourceLoader> @ 资源加载器的map（key：资源路径，value：加载器）
    self.assetsLoaderMap_ = {}
    ---@type table<string, UnityEngine.GameObject> @ 加载的对象实例map（key：资源路径，value：对象实例）
    self.assetsModelGoMap_ = {}
    ------------------------------------------------- [anim about]
    ---@type UnityEngine.Coroutine @ 播放动画的协程
    self.playAnimCo_ = nil
    ---@type SceneInstance @ 表现动画的场景
    self.animSceneIns_ = nil
    ---@type UnityEngine.GameObject @ 动画加载的缓存节点
    self.animCacheGo_ = nil
    ---@type UnityEngine.SceneManagement.Scene @ 记录进入前的场景
    self.beforeScene_ = nil
    ---@type boolean @ 是否有背包放满
    self.isFulledPack_ = false
    ---@type table @ 当前播放的timeline定义
    self.playingTlDefine_ = nil
    ---@type table<integer, UnityEngine.Transform> @ 播放时控制的宝箱对象（key：宝箱类型，value：宝箱对象）
    self.tlCallChestMap_ = {}
    ---@type boolean @ 是否允许交互控制
    self.isControllable_ = false
end


function GroceryEquipmentCallAnimDialog:__delete()
    self.groceryData_        = nil
    self.equipCallType_      = nil
    self.currentCallTimes_   = nil
    self.targetCallTimes_    = nil
    self.isDecomposeMode_    = nil
    self.callRewardMap_      = nil
    self.callConsumeMap_     = nil
    self.callDecomposeMap_   = nil
    self.callDisplayDatas_   = nil
    self.currencyIdList_     = nil
    self.isStopContinue_     = nil
    self.openGroceryType_    = nil
    self.oldQquipPackNum_    = nil
    self.oldGoodsPackNum_    = nil
    self.taskTipsNode_       = nil
    self.showRewardPopupCo_  = nil
    self.assetsPreloadCoMap_ = nil
    self.assetsLoadCoMap_    = nil
    self.assetsLoaderMap_    = nil
    self.assetsModelGoMap_   = nil
    self.playAnimCo_         = nil
    self.animSceneIns_       = nil
    self.animCacheGo_        = nil
    self.beforeScene_        = nil
    self.isFulledPack_       = nil
    self.playingTlDefine_    = nil
    self.tlCallChestMap_     = nil
    self.isControllable_     = nil
    self.controller          = nil
end


function GroceryEquipmentCallAnimDialog:Awake()
    self.beforeScene_ = SceneManager:GetActiveScene()
    SetButtonAction(self.ScreenBtn, Bind(self, self.OnClickScreenButtonHandler_))
    SetButtonAction(self.StopButton, Bind(self, self.OnClickStopButtonHandler_))
    self.eventCommonMainlineTaskTipsNode_ = Events.AddListener(Constants.EventNames.UICommonMainlineTaskTipsNodeEventName, Bind(self, self.OnCommonMainlineTaskTipsNodeHandler_))
end


function GroceryEquipmentCallAnimDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams      = self.controller.Argument.parameters or {}
        self.currencyIdList_  = checkTable(initParams.currencyIdList)
        self.groceryData_     = checkTable(initParams.groceryData)
        self.equipCallType_   = checkInt(initParams.equipCallType)
        self.targetCallTimes_ = checkInt(initParams.equipCallTimes)
        self.openGroceryType_ = tostring(initParams.openGroceryType)
        self.isDecomposeMode_ = checkBool(initParams.isDecomposeMode)

        for prefabPath, loader in pairs(checkTable(initParams.assetsLoaderMap)) do
            self.assetsLoaderMap_[prefabPath] = loader
        end

        -- mark last groceryType
        CfUtils.CookieSave(Constants.UICacheDataKeys.GROCERY_LAST_SELECT_TYPE, self.openGroceryType_)

        -- init view status
        self:SetShowClickTips(false)
        self:SetShowContinueStop(false)

        -- show scene rt
        URPCameraController.alwaysShowSceneRT = true
    end)
end


function GroceryEquipmentCallAnimDialog:OnFinalize()
    return CoWaitDo(function()

        -- close scene rt
        URPCameraController.alwaysShowSceneRT = false

        -- stop anim loop
        self:StopCallAnimLoop_()

        -- stop all preloadCo
        if self.assetsPreloadCoMap_ then
            for _, preloadCo in pairs(self.assetsPreloadCoMap_) do
                CoStop(preloadCo)
            end
            self.assetsPreloadCoMap_ = nil
        end

        -- stop all loadCo
        if self.assetsLoadCoMap_ then
            for _, loadCo in pairs(self.assetsLoadCoMap_) do
                CoStop(loadCo)
            end
            self.assetsLoadCoMap_ = nil
        end

        -- release all loader
        if self.assetsLoaderMap_ then
            for _, loader in pairs(self.assetsLoaderMap_) do
                loader:Release()
            end
            self.assetsLoaderMap_ = nil
        end

        -- destory all modelGo
        if self.assetsModelGoMap_ then
            for _, modelGo in pairs(self.assetsModelGoMap_) do
                CfUtils.SafeDelete(modelGo)
            end
            self.assetsModelGoMap_ = nil
        end

        -- clean cache gameObject
        if self.animCacheGo_ then
            self:DestorySceneCacheGo(self.animSceneIns_, ANIM_CACHE_GO_NAME)
            self.animCacheGo_ = nil
        end

        -- unload anim scene
        if self.animSceneIns_ then
            self.animSceneIns_:Disable()  -- 如果这个场景是cache状态的话，不用了就全关掉
            local sceneId = self.animSceneIns_.identifier
            coroutine.yield(sceneManagement:UnloadAppendedSceneById(sceneId))
            self.animSceneIns_ = nil
        end

        -- recover before scene
        if self.beforeScene_ then
            sceneManagement:SetSceneActive(self.beforeScene_)
            self.beforeScene_ = nil
        end

        -- stop showRewardPopupCo
        if self.showRewardPopupCo_ then
            CoStop(self.showRewardPopupCo_)
            self.showRewardPopupCo_ = nil
        end

        -- recover mainCamera
        CfUtils.SetActive(URPCameraController.mainCamera, true)

        -- 恢复主界面场景
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)

        -- remove event listen
        Events.RemoveListener(Constants.EventNames.UICommonMainlineTaskTipsNodeEventName, self.eventCommonMainlineTaskTipsNode_)

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function GroceryEquipmentCallAnimDialog:OnShow()
    return CoWaitDo(function()
        self:PlayCallAnimLoop_()
    end)
end


-------------------------------------------------
-- get / set

---@return boolean
function GroceryEquipmentCallAnimDialog:IsShowClickTips()
    return checkBool(self.isShowClickTips_)
end
function GroceryEquipmentCallAnimDialog:SetShowClickTips(isShow)
    self.isShowClickTips_ = checkBool(isShow)
    CfUtils.SetActive(self.HandNode, self:IsShowClickTips())
end


---@return boolean
function GroceryEquipmentCallAnimDialog:IsShowContinueStop()
    return checkBool(self.isShowContinueStop_)
end
function GroceryEquipmentCallAnimDialog:SetShowContinueStop(isStop)
    self.isShowContinueStop_ = checkBool(isStop)
    CfUtils.SetActive(self.StopButton, self:IsShowContinueStop())
end


-------------------------------------------------
-- public

---@param sceneInstance SceneInstance
---@param cacheGoName string
---@return UnityEngine.GameObject
function GroceryEquipmentCallAnimDialog:ReceiveSceneCacheGo(sceneInstance, cacheGoName)
    local cacheGameObject = nil
    if not isNull(sceneInstance) then
        cacheGameObject = sceneInstance:GetCacheObjectByName(cacheGoName)
        if isNull(cacheGameObject) then
            cacheGameObject = CfUtils.EmptyGo(cacheGoName)
            sceneInstance:AddCacheObject(cacheGameObject)
            SceneManager.MoveGameObjectToScene(cacheGameObject, sceneInstance:GetScene())
        end
    end
    return cacheGameObject
end


---@param sceneInstance SceneInstance
---@param cacheGoName string
function GroceryEquipmentCallAnimDialog:DestorySceneCacheGo(sceneInstance, cacheGoName)
    if not isNull(sceneInstance) then
        local cacheGameObject = sceneInstance:GetCacheObjectByName(cacheGoName)
        if not isNull(cacheGameObject) then
            sceneInstance:RemoveCacheObjectByName(cacheGoName)
            CfUtils.SafeDelete(cacheGameObject)
        end
    end
end


function GroceryEquipmentCallAnimDialog:PreloadAnimAssets()
    if isNull(self.animCacheGo_) then return end
    local preloadDict = {}

    -- all timelien prefabs
    for defineKey, tlDefine in pairs(GroceryConstants.CallEquipAnimTimelineDefine) do
        if tlDefine.PREFAB then
            preloadDict[tlDefine.PREFAB] = true
        end
    end

    -- to preload assets
    for prefabPath, _ in pairs(preloadDict) do
        local hasLoader = self.assetsLoaderMap_[prefabPath] ~= nil
        local hasLoadCo = self.assetsPreloadCoMap_[prefabPath] ~= nil
        local isExisted = CfUtils.IsBundleResourceExist(prefabPath)
        if not hasLoadCo and not hasLoader and isExisted then
            self.assetsPreloadCoMap_[prefabPath] = CoStart(function()
                printInfo("<EquipmentCall> pre-loader toLoad : " .. prefabPath)
                ResourceModule.LoadBundleAsync(prefabPath, function(loader, isOk, resultObject)
                    if isOk then
                        printInfo("<EquipmentCall> pre-loader finish : " .. prefabPath)
                        self.assetsLoaderMap_[prefabPath] = loader
                        self.assetsPreloadCoMap_[prefabPath] = nil
                    end
                end)
            end)
        end
    end 
end


---@param assetPath string
---@param parentGo UnityEngine.GameObject
---@return boolean
function GroceryEquipmentCallAnimDialog:LoadAnimAssetModel(assetPath, parentGo)
    -- check has assetsGo : don't load
    if self.assetsModelGoMap_[assetPath] then return false end

    -- check loadCo runing : to wait
    if self.assetsLoadCoMap_[assetPath] then return true end

    self.assetsLoadCoMap_[assetPath] = CoStart(function()
        -- check is preload
        if isNull(self.assetsLoaderMap_[assetPath]) then
            printInfo("<EquipmentCall> loader toLoad : " .. assetPath)
            local assetLoader = ResourceModule.LoadBundleAsync(assetPath, nil)
            while not assetLoader.IsCompleted do
                CoYield()
            end
            self.assetsLoaderMap_[assetPath] = assetLoader
            printInfo("<EquipmentCall> loader finish : " .. assetPath)
        end
        -- instantiate loader
        local asyncLoader = self.assetsLoaderMap_[assetPath]
        self.assetsModelGoMap_[assetPath] = asyncLoader:Instantiate(false, parentGo.transform, false)
        printInfo("<EquipmentCall> loader instantiate : " .. assetPath .. ' in ' .. tostring(parentGo))
        -- erase loadeCo key
        self.assetsLoadCoMap_[assetPath] = nil
    end)
    return true
end


---@param timelineDefine table
---@param initCallback fun(director:UnityEngine.Playables.PlayableDirector):void
---@param finishCallback fun(director:UnityEngine.Playables.PlayableDirector):void
function GroceryEquipmentCallAnimDialog:LoadAndPlayTimeline(timelineDefine, initCallback, finishCallback)
    if not timelineDefine then return end
    
    local timelinePath = timelineDefine.PREFAB
    if not timelinePath then return end

    -- wait load timeline
    while self:LoadAnimAssetModel(timelinePath, self.animCacheGo_) do
        coroutine.yield()
    end

    -- take timeline
    local timelineGo = self.assetsModelGoMap_[timelinePath]
    if isNull(timelineGo) then return end
    
    ---@type UnityEngine.Playables.PlayableDirector
    local tlDirector = timelineGo:GetComponent(typeof(PlayableDirector))
    if isNull(tlDirector) then return end
    
    -- init callback
    if initCallback then
        initCallback(tlDirector)
    end

    -- take camear
    local tlCameraPath = timelineDefine.CAMERA
    local tlCameraTran = timelineGo.transform:Find(tlCameraPath)
    ---@type UnityEngine.Camera
    local tlCameraComp = tlCameraTran.gameObject:GetComponent(typeof(CameraComp))

    -- reset cameraStack
    local tlCameraData = CameraExtensions.GetUniversalAdditionalCameraData(tlCameraComp)
    tlCameraData.cameraStack:Clear()

    -- close mainCamera
    CfUtils.SetActive(URPCameraController.mainCamera, false)

    -- init cameraStack
    URPCameraController:InitCameraStack(tlCameraComp)

    -- active timeline
    CfUtils.SetActive(timelineGo, true)

    -- close scene rt
    URPCameraController.alwaysShowSceneRT = false

    -- reset timeline
    tlDirector.time = 0

    -- play timeline
    tlDirector:Play()

    -- play init sound
    local initSoundId = timelineDefine.SOUND
    if initSoundId then
        GameUtils.GetCriWareUtils().PlaySeById(initSoundId)
    end
    
    -- wait finish
    local waitTime = tlDirector.duration
    printInfo("<EquipmentCall> play timeline : " .. timelinePath .. ' | ' .. tostring(waitTime))
    if not timelineDefine.BREAK then
        CoYield(waitTime)
    end

    -- finish callback
    if finishCallback then
        finishCallback(tlDirector)
    end
end


---@param timelineDefine table
function GroceryEquipmentCallAnimDialog:StopAndCloseTimeline(timelineDefine)
    if not timelineDefine then return end
    
    local timelinePath = timelineDefine.PREFAB
    if not timelinePath then return end

    -- take timeline
    local timelineGo = self.assetsModelGoMap_[timelinePath]
    if isNull(timelineGo) then return end

    ---@type UnityEngine.Playables.PlayableDirector
    local tlDirector = timelineGo:GetComponent(typeof(PlayableDirector))
    if isNull(tlDirector) then return end
    
    -- show scene rt
    URPCameraController.alwaysShowSceneRT = true
    
    -- stop timeline
    tlDirector:Stop()
    tlDirector:Evaluate()

    -- reset timeline
    tlDirector.time = 0

    -- deactive track models
    if timelineDefine.trackModelMap then
        for _, trackModels in pairs(timelineDefine.trackModelMap) do
            for _, modelObj in ipairs(trackModels) do
                CfUtils.SetActive(modelObj, false)
            end
        end
        timelineDefine.trackModel = nil
    end

    -- unbinding tracks
    if timelineDefine.trackBindMap then
        for _, trackBinds in pairs(timelineDefine.trackBindMap) do
            for _, bindSources in ipairs(trackBinds) do
                tlDirector:ClearGenericBinding(bindSources)
            end
        end
        timelineDefine.trackBindMap = nil
    end

    -- remove notifies
    if timelineDefine.customNotifies then
        for _, callback in ipairs(timelineDefine.customNotifies) do
            GachaponUtils.RemoveTimelineCustomNotify(tlDirector, callback)
        end
        timelineDefine.customNotifies = nil
    end

    -- deactive timeline
    CfUtils.SetActive(timelineGo, false)
end


function GroceryEquipmentCallAnimDialog:Close()
    CfUtils.DialogBack()
end


-------------------------------------------------
-- private

---@return boolean
function GroceryEquipmentCallAnimDialog:CheckContinueCall_()
    local isCanContinueCall = true

    -- check stopContinue
    if self.isStopContinue_ then
        isCanContinueCall = false
    end

    -- check call times
    if isCanContinueCall then
        if self.targetCallTimes_ ~= -1 and self.currentCallTimes_ >= self.targetCallTimes_ then
            isCanContinueCall = false
        end
    end

    -- check backpack full
    if isCanContinueCall then
        if self.isFulledPack_ then
            isCanContinueCall = false
        end
    end

    -- check currency num
    if isCanContinueCall then
        local callConsumeDatas = GroceryUtils.GetCallEquipConsumeDatas(self.equipCallType_, self.groceryData_)
        for _, callConsumeData in ipairs(callConsumeDatas) do
            local haveConsumeNum = GoodsUtils.GetThingNo(callConsumeData.goodsId)
            if haveConsumeNum < checkInt(callConsumeData.num) then
                local goodsVo = goodsConfMgr:GetGoodsVoById(callConsumeData.goodsId)
                isCanContinueCall = false
                break
            end
        end
    end

    return isCanContinueCall
end


function GroceryEquipmentCallAnimDialog:StopCallAnimLoop_()
    -- remove scene blocker
    CfUtils.ConditionRemove(ANIM_PLAY_BLOCKER)
    if self.playAnimCo_ ~= nil then
        CoStop(self.playAnimCo_)
        self.playAnimCo_ = nil
    end
    if self.playingTlDefine_ then
        self:StopAndCloseTimeline(self.playingTlDefine_)
        self.playingTlDefine_ = nil
    end
    CfUtils.DialogClose(Constants.UITypeIds.OverseaStoreEquipDrawResultDialog)
end


function GroceryEquipmentCallAnimDialog:PlayCallAnimLoop_()
    self.playingTlDefine_ = nil

    local isChestOpened = false

    self.playAnimCo_ = CoStart(function()

        self:PlayCallAnimStepByInitial_()

        self:PlayCallAnimStepByChestShow_()

        self:PlayCallAnimStepByChestWait_()

        self:PlayCallAnimStepByChestFocus_()
        
        while self:CheckContinueCall_() do

            if isChestOpened then
                self:PlayCallAnimStepByChestReset_()
            end

            self:PlayCallAnimStepByRequest_()
    
            self:PlayCallAnimStepByChestOpen_()

            isChestOpened = true
        end

        self.playAnimCo_ = nil
        
        self:ShowCallRewardPopup_()
    end)
end


function GroceryEquipmentCallAnimDialog:PlayCallAnimStepByInitial_()
    -- append scene blocker
    CfUtils.ConditionAppend(ANIM_PLAY_BLOCKER)

    -- FIXME：这个界面会先执行的初始化，然后入口界面才会执行销毁。
    -- 所以如果这里不延迟等一帧的话，会出现：本界面已经开始执行了加载，而下一帧入口界面释放时会带走以加载的资源，从而报错。
    -- PS：这段抄 GachaponGuideAnim 的，不知道现在还有没有这个问题
    CoYield()

    -- 隐藏主界面场景
    Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)

    -- check scene load
    local sceneSettingId = GroceryConstants.CallEquipAnimSceneDefine.SCENE_ID
    if isNull(sceneManagement:GetSceneInstance(sceneSettingId)) then

        -- load scene
        coroutine.yield(sceneManagement:AppendScene(sceneSettingId, true))

        -- trans scene
        local sceneData = sceneManagement:GetScenePathInfo(sceneSettingId)
        sceneManagement:Transition({ identifier = sceneData.id, isCache = true })
        while sceneManagement:IsTransition() do
            CoYield()
        end
    end
    
    -- switch active scene
    self.animSceneIns_ = sceneManagement:GetSceneInstance(sceneSettingId)
    sceneManagement:SetSceneActive(self.animSceneIns_:GetScene())

    -- check cache gameObject
    self.animCacheGo_ = self:ReceiveSceneCacheGo(self.animSceneIns_, ANIM_CACHE_GO_NAME)

    -- deactive scene children
    self.animSceneIns_:Disable()

    -- remove scene blocker
    CfUtils.ConditionRemove(ANIM_PLAY_BLOCKER)
end


function GroceryEquipmentCallAnimDialog:PlayCallAnimStepByChestShow_()
    -- visible anim scene
    self:UpdateAnimSceneVisible_(true)
    
    -- 播放：宝箱出现
    local beforebTlDefine = self.playingTlDefine_
    self.playingTlDefine_ = GroceryConstants.CallEquipAnimTimelineDefine.TIMELINE_1
    coroutine.yield(self:LoadAndPlayTimeline(self.playingTlDefine_,
        ------------------------------------------------- init
        function(tlDirector)
            self:StopAndCloseTimeline(beforebTlDefine)
            self.playingTlDefine_.trackBindMap  = {}
            self.playingTlDefine_.trackModelMap = {}

            -- 显示：对应类型的宝箱
            local tlPoolType  = checkInt(self.groceryData_.poolType)
            local timelineGo  = self.assetsModelGoMap_[self.playingTlDefine_.PREFAB]
            local chestParent = timelineGo.transform:Find(self.playingTlDefine_.CHEST)
            for poolType, chestPath in pairs(self.playingTlDefine_.POOL_TYPE) do
                local callChest = self.tlCallChestMap_[poolType]
                if isNull(callChest) then
                    -- take
                    callChest = timelineGo.transform:Find(chestPath)
                    self.tlCallChestMap_[poolType] = callChest
                else
                    -- 转移位置
                    callChest:SetParent(chestParent, false)
                end
                CfUtils.SetActive(callChest, tlPoolType == poolType)
            end

            local callChest   = self.tlCallChestMap_[tlPoolType]
            if not isNull(callChest) then
                -- 绑定宝箱
                local chestTrackPath   = self.playingTlDefine_.CHEST_TRACK
                local chestBindSources = GachaponUtils.BindTimeline(tlDirector, chestTrackPath, callChest.gameObject)
                self.playingTlDefine_.trackBindMap['chest']  = chestBindSources
                self.playingTlDefine_.trackModelMap['chest'] = {callChest}
            end

            -- 旋转scene到合适位置
            local scene  = timelineGo.transform:Find(self.playingTlDefine_.SCENE)
            local isGold = tlPoolType == GroceryConstants.EquipmentPoolType.Gold
            scene.localRotation = Quaternion.Euler(0, isGold and 180 or 0, 0)
        end,
        ------------------------------------------------- finish
        function(tlDirector)
        end
    ))
end


function GroceryEquipmentCallAnimDialog:PlayCallAnimStepByChestWait_()
--[[
    -- 播放：等待打开（循环）
    local beforebTlDefine = self.playingTlDefine_
    self.playingTlDefine_ = GroceryConstants.CallEquipAnimTimelineDefine.TIMELINE_1_LOOP
    coroutine.yield(self:LoadAndPlayTimeline(self.playingTlDefine_,
        ------------------------------------------------- init
        function(tlDirector)
            self:StopAndCloseTimeline(beforebTlDefine)
            self.playingTlDefine_.trackBindMap  = {}
            self.playingTlDefine_.trackModelMap = {}

            -- 显示：对应类型的宝箱
            local tlPoolType  = checkInt(self.groceryData_.poolType)
            local timelineGo  = self.assetsModelGoMap_[self.playingTlDefine_.PREFAB]
            local chestParent = timelineGo.transform:Find(self.playingTlDefine_.CHEST)
            local callChest   = self.tlCallChestMap_[tlPoolType]
            if not isNull(callChest) then
                -- 转移位置
                callChest:SetParent(chestParent, false)
                CfUtils.SetActive(callChest, true)
                -- 绑定宝箱
                local chestTrackPath   = self.playingTlDefine_.CHEST_TRACK
                local chestBindSources = GachaponUtils.BindTimeline(tlDirector, chestTrackPath, callChest.gameObject)
                self.playingTlDefine_.trackBindMap['chest']  = chestBindSources
                self.playingTlDefine_.trackModelMap['chest'] = {callChest}
            end
        end,
        ------------------------------------------------- finish
        function(tlDirector)
        end
    ))

    -- open controllable
    self.isControllable_ = true

    -- show touch tips
    self:SetShowClickTips(true)
    
    -- preload assets
    self:PreloadAnimAssets()

    -- wait close clickTips
    while self:IsShowClickTips() do
        CoYield()
    end
]]
    -- open controllable
    self.isControllable_ = true

    -- preload assets
    self:PreloadAnimAssets()
end


function GroceryEquipmentCallAnimDialog:PlayCallAnimStepByChestFocus_()
    -- 播放：特写聚焦
    local beforebTlDefine = self.playingTlDefine_
    self.playingTlDefine_ = GroceryConstants.CallEquipAnimTimelineDefine.TIMELINE_2
    coroutine.yield(self:LoadAndPlayTimeline(self.playingTlDefine_,
        ------------------------------------------------- init
        function(tlDirector)
            self:StopAndCloseTimeline(beforebTlDefine)
            self.playingTlDefine_.trackBindMap  = {}
            self.playingTlDefine_.trackModelMap = {}

            -- 显示：对应类型的宝箱
            local tlPoolType  = checkInt(self.groceryData_.poolType)
            local timelineGo  = self.assetsModelGoMap_[self.playingTlDefine_.PREFAB]
            local chestParent = timelineGo.transform:Find(self.playingTlDefine_.CHEST)
            local callChest   = self.tlCallChestMap_[tlPoolType]
            if not isNull(callChest) then
                -- 转移位置
                callChest:SetParent(chestParent, false)
                CfUtils.SetActive(callChest, true)
                -- 绑定宝箱
                local chestTrackPath   = self.playingTlDefine_.CHEST_TRACK
                local chestBindSources = GachaponUtils.BindTimeline(tlDirector, chestTrackPath, callChest.gameObject)
                self.playingTlDefine_.trackBindMap['chest']  = chestBindSources
                self.playingTlDefine_.trackModelMap['chest'] = {callChest}
            end

            -- 旋转scene到合适位置
            local scene  = timelineGo.transform:Find(self.playingTlDefine_.SCENE)
            local isGold = tlPoolType == GroceryConstants.EquipmentPoolType.Gold
            scene.localRotation = Quaternion.Euler(0, isGold and 180 or 0, 0)
        end,
        ------------------------------------------------- finish
        function(tlDirector)
        end
    ))
end


function GroceryEquipmentCallAnimDialog:PlayCallAnimStepByRequest_()
    -- clear displayData
    self.callDisplayDatas_ = nil
    
    -- close controllable
    self.isControllable_ = false

    -- save oldPackNum
    self.oldQquipPackNum_ = backpackComp:GetGoodsNumByPacketId(Constants.BackpackTypeId.EQUIP)
    self.oldGoodsPackNum_ = backpackComp:GetGoodsNumByPacketId(Constants.BackpackTypeId.MATERIAL)
    
    -- call request
    local isRequesting = true
    local requestData  = {poolId = self.groceryData_.poolId, type = self.equipCallType_}
    if self.isDecomposeMode_ then
        requestData.isContinuousCall = 1
    end
    GameUtils.Request(Interfaces.GroceryCallEquipment, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- update cache data
            if self.equipCallType_ == 1 and checkInt(self.groceryData_.dailyFreeCall) == 1 then
                self.groceryData_.dailyFreeCall = 2  -- 2已抽取

                ---@type GroceryConstants.GroceryNodeConfig
                local groceryConfig = GroceryConstants.GroceryNodeConfigs[self.openGroceryType_]
                if groceryConfig and groceryConfig.redPoint then
                    -- update redPoint
                    GameUtils.SetRedPointNum(groceryConfig.redPoint, 0)
                    Events.Broadcast(Constants.EventNames.GROCERY_REDPOINT_CHANGE)
                end
            end

            -- consume goods
            local consumeList = checkTable(responseData.consume)
            GoodsUtils.ConsumeGoods(consumeList, true)

            -- rewards goods
            local rewardList = checkTable(responseData.rewards)
            GoodsUtils.DrawRewards(rewardList)

            -- check pack isFulled
            self.isFulledPack_ = false
            if not self.isFulledPack_ then
                self.isFulledPack_ = GoodsUtils.IsPacketFilledById(Constants.BackpackTypeId.EQUIP)
            end
            if not self.isFulledPack_ then
                self.isFulledPack_ = GoodsUtils.IsPacketFilledById(Constants.BackpackTypeId.MATERIAL)
            end

            -- merge consume data
            for _, consumeData in ipairs(consumeList) do
                local consumeId  = checkInt(consumeData.goodsId)
                local consumeNum = checkInt(consumeData.num)
                if consumeNum > 0 then
                    if not self.callConsumeMap_[consumeId] then
                        self.callConsumeMap_[consumeId] = {goodsId = consumeId, num = 0}
                    end
                    self.callConsumeMap_[consumeId].num = self.callConsumeMap_[consumeId].num + consumeNum
                end
            end

            local displayList = checkTable(responseData.displayRewards)
            if self.isDecomposeMode_ then
                -- merge rewards data
                for _, rewardData in ipairs(rewardList) do
                    local rewardId  = checkInt(rewardData.goodsId)
                    local rewardNum = checkInt(rewardData.num)
                    local goodsType = GoodsUtils.GetIdType(rewardId)
                    if goodsType == Constants.IDType.Equipment then
                        local equipmentData = checkTable(rewardData.playerEquipment)
                        self.callRewardMap_[tostring(equipmentData.id)] = rewardData
                    else
                        if not self.callRewardMap_[rewardId] then
                            self.callRewardMap_[rewardId] = {goodsId = rewardId, num = 0}
                        end
                        self.callRewardMap_[rewardId].num = self.callRewardMap_[rewardId].num + rewardNum
                    end
                end
    
                -- merge decompose data
                for _, displayData in ipairs(displayList) do
                    for _, decomposeData in ipairs(checkTable(displayData.decompose)) do
                        local decomposeId  = checkInt(decomposeData.goodsId)
                        local decomposeNum = checkInt(decomposeData.num)
                        if not self.callDecomposeMap_[decomposeId] then
                            self.callDecomposeMap_[decomposeId] = {goodsId = decomposeId, num = 0}
                        end
                        self.callDecomposeMap_[decomposeId].num = self.callDecomposeMap_[decomposeId].num + decomposeNum
                        -- deduct reward num
                        if self.callRewardMap_[decomposeId] then
                            self.callRewardMap_[decomposeId].num = self.callRewardMap_[decomposeId].num - decomposeNum
                            if self.callRewardMap_[decomposeId].num <= 0 then
                                self.callRewardMap_[decomposeId] = nil
                            end
                        end
                    end
                end
            else
                displayList = rewardList
                for rewardIndex, rewardData in ipairs(rewardList) do
                    self.callRewardMap_[rewardIndex] = rewardData
                end
            end

            -- save displayData
            self.callDisplayDatas_ = displayList

            -- update callTimes
            self.currentCallTimes_ = self.currentCallTimes_ + (self.equipCallType_ == 2 and 10 or 1)

        else
            self:StopCallAnimLoop_()

            self:Close()
        end

        isRequesting = false
    end)

    -- wait request data
    while isRequesting do
        CoYield()
    end

    -- check show stopBtn
    if self.isStopContinue_ or self.isFulledPack_ then
        self:SetShowContinueStop(false)
    else
        if self.targetCallTimes_ == -1 or self.currentCallTimes_ < self.targetCallTimes_ then
            self:SetShowContinueStop(true)
        else
            -- last times close
            self:SetShowContinueStop(false)
        end
    end

    -- open controllable
    self.isControllable_ = true
end


function GroceryEquipmentCallAnimDialog:PlayCallAnimStepByChestOpen_()
    -- mark result state
    local isResultFinish = false
--[[
    -- 随机品质特效（玄学）
    local rareVfxIdx = 0
    local tlPoolType = checkInt(self.groceryData_.poolType)
    local rareDefine = GroceryConstants.CallEquipAnimVfxRareDefine[tlPoolType]
    if rareDefine then
        local totalRate = 0
        for _, define in ipairs(rareDefine) do
            totalRate = totalRate + define.rate
        end
        local countRate  = 0
        local targetIdx  = 0
        local targetRate = math.random(1, totalRate)
        for defIndex, define in ipairs(rareDefine) do
            countRate = countRate + define.rate
            if countRate >= targetRate then
                targetIdx = defIndex
                break
            end
        end
        rareVfxIdx = rareDefine[targetIdx].vfx
    end
]]
    -- 找到最高品质
    local topRate = 1
    for _, goodsData in ipairs(self.callDisplayDatas_ or {}) do
        local goodsId = checkInt(goodsData.goodsId)
        local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
        topRate = math.max(checkInt(goodsVo.quality), topRate)
    end
    topRate = math.min(topRate, 5)  -- 因为道具可能有6品质的，但是tl特效只做到了5，所以需要限制一下（说不补tl）

    -- 播放：打开宝箱
    local beforebTlDefine = self.playingTlDefine_
    self.playingTlDefine_ = GroceryConstants.CallEquipAnimTimelineDefine.TIMELINE_3
    coroutine.yield(self:LoadAndPlayTimeline(self.playingTlDefine_,
        ------------------------------------------------- init
        function(tlDirector)
            self:StopAndCloseTimeline(beforebTlDefine)
            self.playingTlDefine_.trackBindMap   = {}
            self.playingTlDefine_.trackModelMap  = {}
            self.playingTlDefine_.customNotifies = {}

            -- 显示：对应类型的宝箱
            local tlPoolType  = checkInt(self.groceryData_.poolType)
            local timelineGo  = self.assetsModelGoMap_[self.playingTlDefine_.PREFAB]
            local chestParent = timelineGo.transform:Find(self.playingTlDefine_.CHEST)
            local callChest   = self.tlCallChestMap_[tlPoolType]
            if not isNull(callChest) then
                -- 转移位置
                callChest:SetParent(chestParent, false)
                CfUtils.SetActive(callChest, true)
                -- 绑定宝箱
                local chestTrackPath   = self.playingTlDefine_.CHEST_TRACK
                local chestBindSources = GachaponUtils.BindTimeline(tlDirector, chestTrackPath, callChest.gameObject)
                self.playingTlDefine_.trackBindMap['chest']  = chestBindSources
                self.playingTlDefine_.trackModelMap['chest'] = {callChest}
            end

            -- 切换品质特效
            for vfxIndex, vfxDefine in ipairs(self.playingTlDefine_.RARE_VFX) do
                -- local isTargetIndex = rareVfxIdx == vfxIndex
                local isTargetIndex = vfxDefine.rate == topRate
                CfUtils.SetActive(timelineGo.transform:Find(vfxDefine.place), isTargetIndex)
                GachaponUtils.SetRootTrackMute(tlDirector, vfxDefine.track, not isTargetIndex)
            end

            -- 旋转scene到合适位置
            local scene  = timelineGo.transform:Find(self.playingTlDefine_.SCENE)
            local isGold = tlPoolType == GroceryConstants.EquipmentPoolType.Gold
            scene.localRotation = Quaternion.Euler(0, isGold and 180 or 0, 0)

            --- listen showUI notify
            ---@param origin UnityEngine.Playables.Playable
            ---@param notification Markers.UIActiveMarker
            ---@param context System.Object
            local onUIActiveMarker = GachaponUtils.AppendTimelineCustomNotify(tlDirector, function(origin, notification, context)
                if notification:GetType() == typeof(CS.Markers.UIActiveMarker) then
                    -- if self.isDecomposeMode_ then
                        -- show result preview
                        CfUtils.DialogOpen(Constants.UITypeIds.OverseaStoreEquipDrawResultDialog, {
                            currencyIdList  = self.currencyIdList_,
                            displayList     = self.callDisplayDatas_,
                            oldQquipPackNum = self.oldQquipPackNum_,
                            oldGoodsPackNum = self.oldGoodsPackNum_,
                            isAutoMode      = true,
                            closeCb         = function()
                                isResultFinish = true
                            end
                        })
                    -- else
                    --     isResultFinish = true
                    -- end
                end
            end)
            table.insert(self.playingTlDefine_.customNotifies, onUIActiveMarker)
        end,
        ------------------------------------------------- finish
        function(tlDirector)
        end
    ))

    -- wait show result
    while not isResultFinish do
        CoYield()
    end
end


function GroceryEquipmentCallAnimDialog:PlayCallAnimStepByChestReset_()
    -- 播放：镜头重置
    local beforebTlDefine = self.playingTlDefine_
    self.playingTlDefine_ = GroceryConstants.CallEquipAnimTimelineDefine.TIMELINE_4
    coroutine.yield(self:LoadAndPlayTimeline(self.playingTlDefine_,
        ------------------------------------------------- init
        function(tlDirector)
            self:StopAndCloseTimeline(beforebTlDefine)
            self.playingTlDefine_.trackBindMap  = {}
            self.playingTlDefine_.trackModelMap = {}

            -- 显示：对应类型的宝箱
            local tlPoolType  = checkInt(self.groceryData_.poolType)
            local timelineGo  = self.assetsModelGoMap_[self.playingTlDefine_.PREFAB]
            local chestParent = timelineGo.transform:Find(self.playingTlDefine_.CHEST)
            local callChest   = self.tlCallChestMap_[tlPoolType]
            if not isNull(callChest) then
                -- 转移位置
                callChest:SetParent(chestParent, false)
                CfUtils.SetActive(callChest, true)
                -- 绑定宝箱
                local chestTrackPath   = self.playingTlDefine_.CHEST_TRACK
                local chestBindSources = GachaponUtils.BindTimeline(tlDirector, chestTrackPath, callChest.gameObject)
                self.playingTlDefine_.trackBindMap['chest']  = chestBindSources
                self.playingTlDefine_.trackModelMap['chest'] = {callChest}
            end

            -- 旋转scene到合适位置
            local scene  = timelineGo.transform:Find(self.playingTlDefine_.SCENE)
            local isGold = tlPoolType == GroceryConstants.EquipmentPoolType.Gold
            scene.localRotation = Quaternion.Euler(0, isGold and 180 or 0, 0)
        end,
        ------------------------------------------------- finish
        function(tlDirector)
        end
    ))
end


---@param isVisible boolean
function GroceryEquipmentCallAnimDialog:UpdateAnimSceneVisible_(isVisible)
    local sceneInstance = self.animSceneIns_
    if isNull(sceneInstance) then return end

    if isVisible then
        sceneInstance:Enable()
    else
        sceneInstance:Disable()
    end

    -- appear scene element
    for _, appearData in ipairs(GroceryConstants.CallEquipAnimSceneDefine.APPEARS or {}) do
        local nodeGo = sceneInstance:GetSceneElement(appearData.path)
        if not isNull(nodeGo) then
            CfUtils.SetActive(nodeGo, appearData.state == true)
        end
    end
end


function GroceryEquipmentCallAnimDialog:ShowCallRewardPopup_()
    -- show reward popup
    local rewardPopupUiTypeId = Constants.UITypeIds.UICommonRewardPop2
    self.showRewardPopupCo_   = CoStart(function()
        CoYield(CfUtils.DialogOpen(rewardPopupUiTypeId, {
            rewards     = table.values(self.callRewardMap_),
            consumes    = table.values(self.callConsumeMap_),
            decomposes  = table.values(self.callDecomposeMap_),
            continueNum = self.currentCallTimes_,
            isDecompose = self.isDecomposeMode_,
            -- isOnCapture = self.isDecomposeMode_,
            isFulled    = self.isDecomposeMode_ and self.isFulledPack_, -- 分解模式不让显示背包已满，所以需要：非分解模式，并且真的背包满了
            cb          = function()
                self:Close()
            end
        }))
        ---@type Engine.UI.UIDialog
        local dialog = UIModule.CurrentScreen:LastDialog()
        if self.taskTipsNode_ and checkInt(dialog.Argument.id) == rewardPopupUiTypeId then
            self.taskTipsNode_.controller.transform:SetParent(dialog.transform)
            CfUtils.SetActive(self.taskTipsNode_.controller.transform, true)
            self.taskTipsNode_ = nil
        end
        self.showRewardPopupCo_ = nil
    end)
end


-------------------------------------------------
-- handler

function GroceryEquipmentCallAnimDialog:OnClickScreenButtonHandler_()
    if not self.isControllable_ then return end

    if self:IsShowClickTips() then
        self:SetShowClickTips(false)
    end
end


function GroceryEquipmentCallAnimDialog:OnClickStopButtonHandler_()
    if not self.isControllable_ then return end

    self.isStopContinue_ = true

    GameUtils.Toast(localize('连续抽取装备已终止'))

    self:SetShowContinueStop(false)
end


function GroceryEquipmentCallAnimDialog:OnCommonMainlineTaskTipsNodeHandler_(data)
    ---@type UICommonMainlineTaskTipsNode
    self.taskTipsNode_ = data and data.luaEnv or nil
    if self.taskTipsNode_ then
        CfUtils.SetActive(self.taskTipsNode_.controller.transform, false)
    end
end


return GroceryEquipmentCallAnimDialog
