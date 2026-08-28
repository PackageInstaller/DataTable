-------------------------------------------------------------------------------
-- 社团 - 社团大厅 - 场景控制器
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-23 13:56:33
-------------------------------------------------------------------------------

local Time = CS.UnityEngine.Time
local Vector3 = CS.UnityEngine.Vector3
local Physics                  = CS.UnityEngine.Physics
local LayerMask                = CS.UnityEngine.LayerMask
local Input                    = CS.UnityEngine.Input
local Canvas                   = CS.UnityEngine.Canvas
local CanvasGroup              = CS.UnityEngine.CanvasGroup
local GameObject = CS.UnityEngine.GameObject
local EasyTouch                = CS.HedgehogTeam.EasyTouch.EasyTouch
local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera
local KTool                    = CS.Engine.Lib.KTool
local ResourceModule           = CS.Engine.Modules.ResourceModule
local Quaternion          = CS.UnityEngine.Quaternion
local FuntoyRenderFeature      = CS.FuntoyRenderFeature
local GlobalsInDreamSpace      = CS.DreamSpace.GlobalsInDreamSpace
local MaidCoffeeUtils          = import('Game.MaidCoffee.MaidCoffeeUtils')
---@type MaidCoffeeConstants
local MaidCoffeeConstants      = import('Game.MaidCoffee.MaidCoffeeConstants')
local DreamSpaceStates         = import('Game.DreamSpace.Tools.DreamSpaceStates')
local InputManager             = import('Game.DreamSpace.CharacterController.InputManager')
local sceneManagement          = SceneManagement:GetInstance()

---@type Game.Native.URP.URPCameraController
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance

---@type RoleControllerRootCanvasMgr
local RoleControllerRootCanvasMgr = import('Game.DreamSpace.UI.RoleControllerRootCanvasMgr'):GetInstance()


-------------------------------------------------
-- defines

local ClubHallSceneId  = Constants.IdSceneSetting46
local DefaultLayerMask = LayerMask.NameToLayer('Default')
local RoleLayerMask    = LayerMask.NameToLayer('role') -- "Human", "Cat" 所在层

local MemberCatSpace  = 0.7  -- 猫咪每格间距
local MemberCatRangeX = {min = -5, max = 5}  -- 格子X轴范围
local MemberCatRangeZ = {min = -3, max = 3}  -- 格子Z轴范围

local CatControllerPath = 'Game.UI.Club.UIOverseaClubHallCatController'
local PlayerControllerPrefabPath  = 'Prefabs/OverClub/OverseaClubPlayerController.prefab'
local ScenePrefabDefine = {
    Position = {key = MaidCoffeeConstants.SceneDefine.ScenePositionsNode, path = MaidCoffeeConstants.PrefabPath.ScenePositions}, -- 位置信息prefab
    Addition = {key = 'SceneAddition', path = 'Prefabs/OverClub/OverseaClubHallSceneAddition.prefab'},                           -- 附加内容prefab
    FeedCat  = {key = 'SceneFeedCat', path = 'Prefabs/OverClub/OverseaClubHallSceneFeedCat.prefab'},                             -- 喂食神兽prefab
}

local SyncPositionDuration = 1


---@class UIOverseaClubHallSceneController
local UIOverseaClubHallSceneController = Class('UIOverseaClubHallSceneController')


function UIOverseaClubHallSceneController:__init()

    ---@type boolean @ 是否场景加载成功
    self.isSceneLoaded_ = false

    ---@type UnityEngine.Coroutine @ 加载场景协程
    self.loadSceneCo_ = nil

    ---@type table<string, table<string, table>> @ 预加载定义
    self.preloaderMap_ = {
        prefab = {},  -- 预制体
        avatar = {},  -- 餐厅家具
        member = {},  -- 猫模型
    }

    ---@type table<string, UnityEngine.GameObject>> @ 实例对象定义
    self.loadedModels_ = {
        prefab = {},  -- 预制体
        avatar = {},  -- 餐厅家具
        member = {},  -- 猫模型
    }

    ---@type table<string, UIOverseaClubHallCatController> @ 猫咪控制器
    self.catControllers_ = {}

    ---@type UnityEngine.Transform @ 社团名字文本
    self.clubNameTxt_ = nil

    ---@type UnityEngine.Transform @ 社团头像图片
    self.clubHeadImg_ = nil

    ---@type UnityEngine.Transform @ 猫地板父节点
    self.catPosParent_ = nil

    ---@type Cinemachine.CinemachineVirtualCamera @ 切换猫的虚拟相机
    self.exchangeVcam_ = nil

    ---@type UnityEngine.Transform @ 场景中的UI画布
    self.sceneUICanvas_ = nil

    ---@type UnityEngine.Transform @ 原始气泡节点
    self.baseBubbleNode_ = nil

    ---@type boolean @ 是否处于切换模式
    self.isExchangeMode_ = false

    ---@type table<integer, table<integer, table>> @ 猫咪位置定义
    self.catPosDefines_ = {}

    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [ClubUtils.EventName.ENTER_SCENE] = function (packetData)
            self:PlayerEnter(packetData)
        end,
        [ClubUtils.EventName.SYNC_POSITION] = function (packetData)
            self:SyncPositionFromServer(packetData)
        end,
        [ClubUtils.EventName.EXIT_SCENE] = function (playerId)
            self:PlayerExit(playerId)
        end,
        [ClubUtils.EventName.DO_INTERACTION] = function (playerId, index)
            self:SyncPlayerInteractionFromServer(playerId, index)
        end
    })

    self.connectToServer = false
    self.syncPositionTime = 0
end


function UIOverseaClubHallSceneController:__delete()
end


-------------------------------------------------------------------------------
-- lifecycle
-------------------------------------------------------------------------------

function UIOverseaClubHallSceneController:OnStart()
    local posIndex = 1
    for posX = MemberCatRangeX.min, MemberCatRangeX.max do
        for posZ = MemberCatRangeZ.min, MemberCatRangeZ.max do
            self.catPosDefines_[posX] = self.catPosDefines_[posX] or {}
            self.catPosDefines_[posX][posZ] = {
                index    = posIndex, -- 格子索引数
                posX     = posX,      -- 格子x位置
                posZ     = posZ,      -- 格子z位置
                playerId = 0,         -- 占据的玩家
            }
            posIndex = posIndex + 1
        end
    end
end


function UIOverseaClubHallSceneController:OnDestroy()
    CfUtils.EventsUndecorated(self.eventsDecorated_)
    self:Delete()
end


function UIOverseaClubHallSceneController:OnUpdate()
    if not self:IsSceneLoaded() then return end

    -- check member loaded
    for signboarId, defineMap in pairs(self.preloaderMap_.member) do
        if isNotNull(defineMap.loader) and defineMap.loader.IsCompleted then
            for playerId, memberCatGo in pairs(self:CreateAndPopupLoader_('member', signboarId, self.catPosParent_)) do

                -- check exist
                if self:IsExitSignboardCat(playerId) then
                    self:SignboardCatUninstall_(playerId)
                end

                -- install cat
                self:SignboardCatInstall_(playerId, memberCatGo, true)

                -- check hide
                if self.isExchangeMode_ and not GameUtils.IsMySelfPlayerId(playerId) then
                    CfUtils.SetActive(memberCatGo, false)
                elseif GameUtils.IsMySelfPlayerId(playerId) then
                    local catController = self.catControllers_[playerId]
                    

                    if not self.isExchangeMode_ then
                        self.cameraControllerScr:SetFollowTarget(catController.controller.gameObject.transform)
                        self.playerInputScr.catController = catController
                    
                        catController.transform:SetPositionAndRotation(self.catOriginPosition, self.catOriginRotation)
                        -- catController:SwitchToAutoMode()
                    else
                        catController.transform:SetPositionAndRotation(self.loadedModels_.prefab[ScenePrefabDefine.Position.key].transform.position, self.loadedModels_.prefab[ScenePrefabDefine.Position.key].transform.rotation)
                    end
                    
                end

            end
        end
    end

    -- update cats
    ---@param catController UIOverseaClubHallCatController
    for playerId, catController in pairs(self.catControllers_) do
        catController:OnUpdate()
    end

    if self.syncPositionTime > SyncPositionDuration then
        if self.connectToServer then
            if self:SyncPositionToServer() then
                self.syncPositionTime = 0
            end
        else
            --- 尝试连接到 server
            local catController = self.catControllers_[checkNumber(GameUtils.GetPlayerId())]
            if catController ~= nil then
                catController:ConnectToServer()
            end
            self.syncPositionTime = 0
        end
    end

    self.syncPositionTime = self.syncPositionTime + Time.deltaTime
end


-------------------------------------------------------------------------------
-- scene
-------------------------------------------------------------------------------

--- 是否 场景已加载
---@return boolean
function UIOverseaClubHallSceneController:IsSceneLoaded()
    return self.isSceneLoaded_
end


--- 加载 社团场景
---@param loadedCb fun():void
function UIOverseaClubHallSceneController:LoadScene(loadedCb)
    if self.isSceneLoaded_ then return end

    -------------------------------------------------
    -- init env
    do
        self.isIgnoreRoleToDefault_ = Physics.GetIgnoreLayerCollision(RoleLayerMask, DefaultLayerMask)
        if self.isIgnoreRoleToDefault_ then
            Physics.IgnoreLayerCollision(RoleLayerMask, DefaultLayerMask, false)   -- 让两层相互参与碰撞
        end
        --
        self.originIsOpenPlaneShadow_          = FuntoyRenderFeature.isOpenPlaneShadow
        self.originPlaneShadowQuality_         = FuntoyRenderFeature.planeShadowQuality
        FuntoyRenderFeature.planeShadowQuality = FuntoyRenderFeature.PlaneShadowQuality.Low
        FuntoyRenderFeature.isOpenPlaneShadow  = true
        --
        EasyTouch.instance.enableUIMode = false
        EasyTouch.SetUICompatibily(true)
        --
        Physics.autoSimulation  = true
        Input.multiTouchEnabled = true
        DreamSpaceStates.CheckPlatform()
        DreamSpaceStates.InitInputLock()
        -- DreamSpaceStates.SetRoleMoveFlag(false)  -- 移动禁止
    end

    -------------------------------------------------
    -- start coroutine
    self.loadSceneCo_  = CoStart(function()
        local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
        local SceneDefine  = MaidCoffeeConstants.SceneDefine

        -- config prefabs
        for _, prefabDefine in pairs(ScenePrefabDefine) do
            self.preloaderMap_.prefab[prefabDefine.key] = {path = prefabDefine.path}
        end

        -- config avatars
        for _, avatarId in pairs(clubHomeDojo.presidentAvatars) do
            local avatarInfoVo = MaidCoffeeUtils.GetRenovateInfoVo(avatarId)
            if avatarInfoVo.furnitureType ~= MaidCoffeeConstants.AvatarType.TABLE_CHAIRS then
                self.preloaderMap_.avatar[avatarId] = {path = avatarInfoVo.prefab}
            end
        end

        -------------------------------------------------
        -- preload assert

        for type, defineMap in pairs(self.preloaderMap_) do
            for key, path in pairs(defineMap) do
                local loaderData = self.preloaderMap_[type][key]
                if not loaderData.loader then
                    loaderData.loader = ResourceModule.LoadBundleAsync(loaderData.path, nil, true)
                end
            end
        end

        for _, memberDojo in ipairs(clubHomeDojo.memberList) do
            self:SignboardCatAppend(memberDojo.playerId, memberDojo.clubSignboarId)
        end

        -- 等完全屏幕黑了再关闭主场景（现在好像不用了）
        -- init scene status
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShow = false})     -- 主场景 角色关
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false) -- 主场景 场景关
        -- CoYield() -- wait event invoke

        xTry(function()
            -------------------------------------------------
            -- load scene
            sceneManagement:Transition({identifier = ClubHallSceneId, isCache = false})
            while sceneManagement:IsTransition() do
                CoYield()
            end

            -------------------------------------------------
            -- load avatars
            local sceneInstance = sceneManagement:GetSceneInstance(ClubHallSceneId)
            local scenePartRoot = sceneInstance:GetSceneElement('Scene/ScenePartRoot')
            local sceneShowRoot = sceneInstance:GetSceneElement('Scene/SceneShowRoot')
            for avatarKey, _ in pairs(self.preloaderMap_.avatar) do
                local avatarGo = self:CreateAndPopupLoader_('avatar', avatarKey, scenePartRoot)[avatarKey]
                self.loadedModels_.avatar[avatarKey] = avatarGo
            end

            -------------------------------------------------
            -- load tvNode
            local tvNodePath = 'Scene/MaidCoffee_easy/BgTvNode/OverseaManageMenuSetting/BtnTVGroup/'
            local cafeTvNode  = sceneInstance:GetSceneElement(tvNodePath .. 'BtnTV')
            local clubTvNode  = sceneInstance:GetSceneElement(tvNodePath .. 'TVClubNode')
            self.clubNameTxt_ = clubTvNode.transform:Find('TxtClubName')
            self.clubHeadImg_ = clubTvNode.transform:Find('ImgClubHead')
            CfUtils.SetActive(cafeTvNode, false)
            CfUtils.SetActive(clubTvNode, true)

            -------------------------------------------------
            -- load prefabs
            for prefabKey, _ in pairs(self.preloaderMap_.prefab) do
                local prefabGo = self:CreateAndPopupLoader_('prefab', prefabKey, nil)[prefabKey]
                self.loadedModels_.prefab[prefabKey] = prefabGo
                sceneInstance:AddCacheObject(prefabGo)
            end

            -------------------------------------------------
            -- load controller
            RoleControllerRootCanvasMgr:ShowOrHide(true)
            URPCameraController:SetMainCameraActive(true)

            ---@type OverseaClubFeedCatMgr
            local feedCatMgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()

            -- 配置切换猫的虚拟相机
            local additionPrefab      = self.loadedModels_.prefab[ScenePrefabDefine.Addition.key]
            local exchangeVcamNode    = additionPrefab.transform:Find('ExchangeVcam')
            self.baseBubbleNode_      = additionPrefab.transform:Find('BubbleNode')
            self.exchangeVcam_        = CfUtils.GetOrAddComponent(exchangeVcamNode, CinemachineVirtualCamera)
            -- self.exchangeVcam_.LookAt = GlobalsInDreamSpace.FindComponent('vTargetLookAt2').transform  -- @see CreatePlayer
    
            ---@type OverseaClubFeedCatUtils
            local OverseaClubFeedCatUtils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

            -- 社团喂食神兽
            local curPhase = OverseaClubFeedCatUtils.CalPetPhase(feedCatMgr.Server.dojo.petsLevel)
            local feedCatHeight = curPhase>2 and 0.0 or 0.2   -- 前2型态浮空, 后2型态落地
            ---            
            local feedCatPrefab = self.loadedModels_.prefab[ScenePrefabDefine.FeedCat.key]
            local feedCatVcamNode = feedCatPrefab.transform:Find('FeedCatVcam')
            feedCatPrefab.transform.position = Vector3(-1.993,feedCatHeight,-2.587)
            feedCatPrefab.transform.rotation = Quaternion.Euler(0, 4.112, 0)
            self.feedCatVcam_ = CfUtils.GetOrAddComponent(feedCatVcamNode, CinemachineVirtualCamera)
            feedCatMgr:LoadCat(feedCatPrefab)
            --社团里没有桌子,但桌子的collider阻挡了点击  先关掉
            local collider = GameObject.Find("COL/Cube");
            if collider then
                CfUtils.SetActive(collider, false)
            end
            collider = GameObject.Find("COL/Cube (1)");
            if collider then
                CfUtils.SetActive(collider, false)
            end

            -------------------------------------------------
            -- init uiCanvas
            self.sceneUICanvas_ = sceneInstance:GetCacheObjectByName(SceneDefine.WorldSpaceCanvasName).transform
            KTool.SetLayer(DefaultLayerMask, self.sceneUICanvas_.gameObject, true)

            ---@type UnityEngine.Canvas
            local worldSpaceCanvas       = CfUtils.GetOrAddComponent(self.sceneUICanvas_, Canvas)
            worldSpaceCanvas.worldCamera = URPCameraController.mainCamera
            CfUtils.GetOrAddComponent(self.sceneUICanvas_, CanvasGroup)

            -------------------------------------------------
            -- member cats
            local scenePositionsNode = self.loadedModels_.prefab[ScenePrefabDefine.Position.key]
            self.catPosParent_ = scenePositionsNode.transform:Find(SceneDefine.CatNodeName)
            if self.catPosParent_ then
                for signboarKey, _ in pairs(self.preloaderMap_.member) do
                    for playerId, memberCatGo in pairs(self:CreateAndPopupLoader_('member', signboarKey, self.catPosParent_)) do
                        self:SignboardCatInstall_(playerId, memberCatGo, false)
                    end
                end
            end

            InputManager.Init() -- 重置, 必须在 装配 角色控制器 之前!!!  否则角色的初始朝向会被 InputManager 里的残余值修改
            self:LoadPlayerController()
            while not self.playerControllerloadFinish do
                CoYield()
            end

            -------------------------------------------------
            -- load managerModel

            -------------------------------------------------
            -- load clerkModel

            -------------------------------------------------
            -- scene loaded
            CfUtils.ChangeMainCamDefalultBlend(0.5) -- 设置融合速度
            sceneManagement:SetActive(ClubHallSceneId, true)
            self:UpdateTvClubName()
            self:UpdateTvClubHead()
            
            self.isSceneLoaded_ = true
            if loadedCb then
                loadedCb()
            end
            
        end, function(e)
            printError(e)

            -- 为了不卡外部的加载
            self.isSceneLoaded_ = true
            if loadedCb then
                loadedCb()
            end
        end)
    end)
end

function UIOverseaClubHallSceneController:LoadPlayerController()

    self.playerControllerloadFinish = false

    ResourceModule.LoadGameObjectAsync(PlayerControllerPrefabPath, function (go)
        local catController = self.catControllers_[tonumber(GameUtils.GetPlayerId())]
        if catController == nil then
            printError("[UIOverseaClubHallSceneController][LoadPlayerController] player catController not found")
            self.playerControllerloadFinish = true
            return
        end

        local playerInput = go.transform:Find("PlayerInput")
        self.playerInputScr = CfUtils.GetLuaScr(playerInput, "Game.UI.Club.Controller.OverseaClubPlayerInput")
        self.playerInputScr:Init(catController, true, false, 400, Vector3(364, 360, 0))

        local cameraController = go.transform:Find("3rdPersonCamera")
        self.cameraControllerScr = CfUtils.GetLuaScr(cameraController, "Game.UI.Club.Controller.OverseaClub3rdPersonVCam")

        self.cameraControllerScr:Init(
            {initLookDir=Vector3( 0, -0.1, -1 ), 
            vcamHeight= 0.25,
            vcamRadius= 2.7,
            vcamShoulderOffset=Vector3.zero}, catController.controller.gameObject.transform, true)

        self.playerControllerloadFinish = true
    end)

end


--- 卸载 社团场景
function UIOverseaClubHallSceneController:UnloadScene()
    self.isSceneLoaded_ = false

    -------------------------------------------------
    -- reset env
    do
        if self.isIgnoreRoleToDefault_ ~= nil then
            Physics.IgnoreLayerCollision(RoleLayerMask, DefaultLayerMask, self.isIgnoreRoleToDefault_) -- 恢复旧设置
        end
        --
        if self.originIsOpenPlaneShadow_ ~= nil and self.originPlaneShadowQuality_ ~= nil then
            FuntoyRenderFeature.isOpenPlaneShadow  = self.originIsOpenPlaneShadow_
            FuntoyRenderFeature.planeShadowQuality = self.originPlaneShadowQuality_
        end
        --
        EasyTouch.instance.enableUIMode = true
        EasyTouch.SetUICompatibily(false)
        EasyTouch.SetEnable2FingersGesture(false)
        --
        Physics.autoSimulation  = false
        Input.multiTouchEnabled = false
    end

    -------------------------------------------------
    -- remove coroutine
    if self.loadSceneCo_ then
        CoStop(self.loadSceneCo_)
        self.loadSceneCo_ = nil
    end

    -- clear cache
    RoleControllerRootCanvasMgr:CheckAndRemove()  -- 删除 ui canvas
    self.catControllers_ = {}

    -- clear loader
    for type, defineMap in pairs(self.preloaderMap_ or {}) do
        for key, path in pairs(defineMap) do
            local loader = self.preloaderMap_[type][key].loader
            if isNotNull(loader) then
                loader:Release()
            end
            self.preloaderMap_[type][key] = nil
        end
    end

    ---@type OverseaClubFeedCatMgr
    local feedCatMgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
    feedCatMgr:ReleaseCat()

    -- unload modules
    for type, defineMap in pairs(self.loadedModels_ or {}) do
        for key, modelGo in pairs(defineMap) do
            CfUtils.SafeDelete(modelGo)
            self.loadedModels_[type][key] = nil
        end
    end

    -- unload scene
    local sceneInstance = sceneManagement:GetSceneInstance(ClubHallSceneId)
    if sceneInstance then
        CoYield(sceneManagement:UnloadScene(sceneInstance))
    end

    CfUtils.ChangeMainCamDefalultBlend(2) -- 还原一下融合时间
end


--- 更新 电视的社团名字
function UIOverseaClubHallSceneController:UpdateTvClubName()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    if self.clubNameTxt_ then
        CfUtils.FillText(self.clubNameTxt_, clubHomeDojo.name)
    end
end


--- 更新 电视的社团头像
function UIOverseaClubHallSceneController:UpdateTvClubHead()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    local clubHeadVo   = ClubUtils.GetClubHeadVo(clubHomeDojo.avatar)
    if self.clubHeadImg_ then
        CfUtils.FillImage(self.clubHeadImg_, clubHeadVo.photoPath)
    end
end


--- 实例化对象 并 销毁加载器
---@param type string
---@param key string
---@param parent UnityEngine.GameObject
---@return table<string, UnityEngine.GameObject>
function UIOverseaClubHallSceneController:CreateAndPopupLoader_(type, key, parent)
    local define = self.preloaderMap_[type][key]
    local path   = define.path
    local loader = define.loader
    local insMap = define.insMap
    if isNull(loader) then return nil end

    while not loader.IsCompleted do
        CoYield()
    end

    local instanceMap = insMap or { [key] = false }
    if loader.IsSuccess then
        for insKey, _ in pairs(instanceMap) do

            local instance = loader:Instantiate()
            if isNotNull(instance) then

                -- init infos
                instance.name = string.stripExtension(string.stripFileName(path))
                instance.transform.localPosition = Vector3(0, 0, 0)

                -- init parent
                if isNotNull(parent) then
                    KTool.SetParent(instance, parent.gameObject, false)
                end

                instanceMap[insKey] = instance
            end
        end
    end

    -- release loader
    loader:Release()

    -- clear define
    self.preloaderMap_[type][key] = nil

    return instanceMap
end

function UIOverseaClubHallSceneController:FocusFeedCatVcam()
    CfUtils.SetActive(self.feedCatVcam_, true)
    CfUtils.SetCanvasGroupAlpha(self.sceneUICanvas_, 0)
    DreamSpaceStates.LockViewRotate_ByFlag(DreamSpaceStates.InputLockState.Lock)
end

function UIOverseaClubHallSceneController:UnfocusFeedCatVcam()
    CfUtils.SetActive(self.feedCatVcam_, false)
    CfUtils.SetCanvasGroupAlpha(self.sceneUICanvas_, 1)
    DreamSpaceStates.LockViewRotate_ByFlag(DreamSpaceStates.InputLockState.Unlock)
end


--- 聚焦 切换猫的虚拟相机
function UIOverseaClubHallSceneController:FocusExchangeVcam()
    CfUtils.SetActive(self.exchangeVcam_, true)
    CfUtils.SetCanvasGroupAlpha(self.sceneUICanvas_, 0)
    DreamSpaceStates.LockViewRotate_ByFlag(DreamSpaceStates.InputLockState.Lock)
    self.playerInputScr:SetLock(true)

    -- mark exchangeMode
    self.isExchangeMode_ = true

    -- hide other cats
    for playerId, catModelGo in pairs(self.loadedModels_.member) do
        if not GameUtils.IsMySelfPlayerId(playerId) then
            CfUtils.SetActive(catModelGo, false)
        else 
            ---@type UIOverseaClubHallCatController
            local catController = self.catControllers_[playerId] 
            catController:BeginFocusCat( Vector3.forward )

            self.catOriginPosition = catController.transform.position
            self.catOriginRotation = catController.transform.rotation
            self.catOriginForward = catController.transform.forward
            -- 更换猫形象的时候会删除原有 gameObject，先设置成其他的 target
            self.cameraControllerScr:SetFollowTarget(self.loadedModels_.prefab[ScenePrefabDefine.Position.key].transform)

            catController.transform:SetPositionAndRotation(self.loadedModels_.prefab[ScenePrefabDefine.Position.key].transform.position, self.loadedModels_.prefab[ScenePrefabDefine.Position.key].transform.rotation)
        end
    end
end


--- 离开 切换猫的虚拟相机
function UIOverseaClubHallSceneController:UnfocusExchangeVcam()
    CfUtils.SetActive(self.exchangeVcam_, false)
    CfUtils.SetCanvasGroupAlpha(self.sceneUICanvas_, 1)
    DreamSpaceStates.LockViewRotate_ByFlag(DreamSpaceStates.InputLockState.Unlock)
    self.playerInputScr:SetLock(false)

    -- cancel exchangeMode
    self.isExchangeMode_ = false

    -- show other cats
    for playerId, catModelGo in pairs(self.loadedModels_.member) do
        CfUtils.SetActive(catModelGo, true)

        ---@type UIOverseaClubHallCatController
        local catController = self.catControllers_[playerId] 
        catController:EndFocusCat()

        if GameUtils.IsMySelfPlayerId(playerId) then
            
            self.cameraControllerScr:SetFollowTarget(catController.controller.gameObject.transform)
            self.playerInputScr.catController = catController
            catController.transform.position = self.catOriginPosition
            catController.transform.rotation = self.catOriginRotation
        end

    end
end


-------------------------------------------------------------------------------
-- signboar cat
-------------------------------------------------------------------------------

--- 是否 存在猫看板形象
---@param playerId integer
---@return boolean
function UIOverseaClubHallSceneController:IsExitSignboardCat(playerId)
    return isNotNull(self.loadedModels_.member[playerId])
end


--- 添加 看板猫形象
---@param appendPlayerId integer
---@param signboarId integer
function UIOverseaClubHallSceneController:SignboardCatAppend(appendPlayerId, signboarId)
    if not self.preloaderMap_.member[signboarId] then
        local modelPath = ClubUtils.GetCatModelPath(signboarId)
        local catLoader = ResourceModule.LoadBundleAsync(modelPath, nil, true)
        self.preloaderMap_.member[signboarId] = {path = modelPath, loader = catLoader, insMap = {}}
    end
    self.preloaderMap_.member[signboarId].insMap[appendPlayerId] = false
end


--- 移除 看板猫形象
---@param removePlayerId integer
function UIOverseaClubHallSceneController:SignboardCatRemove(removePlayerId)
    -- clear loader
    for signboarId, defineMap in pairs(self.preloaderMap_.member) do
        for playerId, _ in pairs(defineMap.insMap) do
            if playerId == removePlayerId then
                defineMap.insMap[playerId] = nil
                break
            end
        end
        if next(defineMap.insMap) == nil then
            if isNotNull(defineMap.loader) then
                defineMap.loader:Release()
            end
            self.preloaderMap_.member[signboarId] = nil
        end
    end
    -- uninstall model
    self:SignboardCatUninstall_(removePlayerId)
end


--- 随机一个空闲的位置
---@return table
function UIOverseaClubHallSceneController:RandomFreePosDefine_()
    local catPosDefineList = {}

    for posX = MemberCatRangeX.min, MemberCatRangeX.max do
        for posZ = MemberCatRangeZ.min, MemberCatRangeZ.max do
            local catPosDefine = self.catPosDefines_[posX][posZ]
            if posX ~= 0 and posZ ~= 0 and catPosDefine.playerId == 0 then
                table.insert(catPosDefineList, catPosDefine)
            end
        end
    end

    if #catPosDefineList > 0 then
        return catPosDefineList[math.random(1, #catPosDefineList)]
    else
        printError('[OverseaClubHall] nonempty position')
        return self.catPosDefines_[0][0]
    end
end


---@param posDefine table
---@return number
function UIOverseaClubHallSceneController:ConvertPosDefineAngle_(posDefine)
    local x = checkInt(posDefine.posZ)
    local y = checkInt(posDefine.posX)

    if x == 0 and y == 0 then
        return 0
    end

    -- 计算向量长度，用于确定角度的比例
    local length = math.sqrt(x * x + y * y)
    
    -- 计算角度的余弦值
    local cosTheta = x / length
    local sinTheta = y / length
    
    -- 计算角度（弧度），使用 atan2 的逻辑，因为 Lua 5.4 中没有 atan2
    local angleRadians = math.acos(cosTheta)
    
    -- 如果 y 为负，角度应该在 180 度到 360 度之间
    if y < 0 then
        angleRadians = -angleRadians
    end
    
    -- 将弧度转换为度数
    local angleDegrees = math.deg(angleRadians)
    
    return angleDegrees
end


--- 安装 看板猫形象
---@param playerId integer
---@param catModelGo UnityEngine.GameObject
---@param isManualModeSit boolean @ true: 初始状态时猫是坐着的; false: 猫自由行动状态
function UIOverseaClubHallSceneController:SignboardCatInstall_(playerId, catModelGo, isManualModeSit )
    local catPosDefine = self:RandomFreePosDefine_()

    -- 占据格子
    catPosDefine.playerId = checkInt(playerId)

    -- 初始位置和角度
    catModelGo.transform.localRotation = Quaternion.Euler(0, 180 + self:ConvertPosDefineAngle_(catPosDefine), 0)
    catModelGo.transform.localPosition = Vector3(
        checkNumber(catPosDefine.posX) * MemberCatSpace, 0, 
        checkNumber(catPosDefine.posZ) * MemberCatSpace
    )

    -- 添加组件
    AddLuaBehaviour(catModelGo, CatControllerPath)

    ---@type UIOverseaClubHallCatController
    local catController = CfUtils.GetLuaScr(catModelGo, CatControllerPath)
    
    local clubComp = ClubUtils.GetClubComp()
    local pos = nil
    if GameUtils.IsMySelfPlayerId(playerId) then
        pos = clubComp.scenePositionData[tostring(playerId)]
    end
    local playerConnect = pos ~= nil and type(pos) == "table"
    pos = checkTable(pos)
    
    catController:OnInitEnv({
        playerId   = playerId,
        cellPosX   = catPosDefine.posX,
        cellPosZ   = catPosDefine.posZ,
        bubbleNode = self.baseBubbleNode_,
        parentNode = self.sceneUICanvas_,
        isManualModeSit = (isManualModeSit == true),
        playerConnect = playerConnect,
        initPos = pos.pos,
        initRot = pos.rot,
    })

    -- 记录模型
    self.loadedModels_.member[playerId] = catModelGo
    self.catControllers_[playerId] = catController
end


--- 卸载 看板猫形象
---@param playerId integer
function UIOverseaClubHallSceneController:SignboardCatUninstall_(playerId)
    local catModelGo = self.loadedModels_.member[playerId]
    if catModelGo then

        ---@type UIOverseaClubHallCatController
        local catController = self.catControllers_[playerId]
        if catController then
            -- 释放格子
            local catPosDefine = self.catPosDefines_[catController:GetCellPosX()][catController:GetCellPosZ()]
            if catPosDefine then
                catPosDefine.playerId = 0
            end
        end

        -- 清除模型
        self.catControllers_[playerId] = nil
        CfUtils.SafeDelete(catModelGo)
    end

    self.loadedModels_.member[playerId] = nil
end


function UIOverseaClubHallSceneController:SyncPositionToServer()
    if not self.connectToServer then
        return
    end

    if self.isExchangeMode_ then
        return
        -- uploadData["pos"] = {self.catOriginPosition.x, self.catOriginPosition.y, self.catOriginPosition.z}
        -- uploadData["rot"] = {self.catOriginForward.x, self.catOriginForward.y, self.catOriginForward.z}
    end

    local catController = self.catControllers_[tonumber(GameUtils.GetPlayerId())]

    return catController:SyncPositionToServer()
end

function UIOverseaClubHallSceneController:SyncPositionFromServer(packetData)
    local positionData = packetData.clubHallInfo

    for playerId, data in pairs(positionData) do
        local catController = self.catControllers_[tonumber(playerId)]
        if catController ~= nil then
            catController:SyncCatPosition(data)
        end
    end
end

function UIOverseaClubHallSceneController:PlayerEnter(packetData)
    local positionData = packetData.clubHallInfo

    for playerId, data in pairs(positionData) do
        data = checkTable(data)
        local catController = self.catControllers_[tonumber(playerId)]
        if catController ~= nil then
            if not GameUtils.IsMySelfPlayerId(playerId) then
                catController:SetCatPos(data.pos)
                catController:SetCatRot(data.rot)
                catController:SwitchToServerMode()
            else
                self.connectToServer = true
            end
        end
    end
end

function UIOverseaClubHallSceneController:PlayerExit(playerId)
    local catController = self.catControllers_[playerId]

    if catController == nil then
        return
    end

    catController:SwitchToAutoMode()
end

function UIOverseaClubHallSceneController:SyncPlayerInteractionFromServer(playerId, index)
    local catController = self.catControllers_[checkNumber(playerId)]

    if catController == nil then
        return
    end

    catController:PlayAnimation(index)
end

return UIOverseaClubHallSceneController
