--------------------------------
--- 地图解密活动入口界面
--- @params {
---     activityData = {
---         id: number  --- 排期id
---     }
--- }

------------ global define ------------
local CS     = CS
local typeof = typeof
local isNull = isNull
------------ global define ------------

------------ import ------------
local util                = require 'XLua.util'
local CoWait              = CS.Engine.Lib.CoWait
-- local GameObject          = CS.UnityEngine.GameObject
local FuntoyRenderFeature = CS.FuntoyRenderFeature

local Yielders            = CS.Engine.Lib.Yielders
---@type Engine.Lib.KCookie
local KCookie             = CS.Engine.Lib.KCookie
-- local Physics             = CS.UnityEngine.Physics
local sceneManagement     = SceneManagement:GetInstance()
local ETCInput            = CS.ETCInput
-- local Application         = CS.UnityEngine.Application
-- local RuntimePlatform     = CS.UnityEngine.RuntimePlatform
---@type Engine.Lib.KTool
local KTool               = CS.Engine.Lib.KTool
local Object              = CS.UnityEngine.Object
local Physics              = CS.UnityEngine.Physics
---@type Engine.UI.UIModule
local UIModule            = CS.Engine.UI.UIModule
local LayerMask           = CS.UnityEngine.LayerMask
local Input = CS.UnityEngine.Input
local URPCameraController = CS.Game.Native.URP.URPCameraController
local CinemachineBlendDefinition = CS.Cinemachine.CinemachineBlendDefinition
local cs_coroutine        = require "XLua.cs_coroutine"
local support             = require('Frame.support')
local CriWareUtils        = import('Game.Entry.CriWareUtilsFix')
local EasyTouch           = CS.HedgehogTeam.EasyTouch.EasyTouch
------------ import ------------


------------ define ------------
local yield       = cs_coroutine.yield_return

local JoystickName             = "LeftJoystick"

local SceneMaxProgress    = 60
local SceneConfProgress   = 70
local ProtagonistProgress = 80
local NPCProgress         = 95
local MaxProgress         = 100

-- local 
-- local RigidbodyType        = typeof(CS.UnityEngine.Rigidbody)
-- local ColliderType         = typeof(CS.UnityEngine.Collider)
-- local CapsuleColliderType  = typeof(CS.UnityEngine.CapsuleCollider)
local CanvasType           = typeof(CS.UnityEngine.Canvas)
-- local TransformType        = typeof(CS.UnityEngine.Transform)
-- local LookAtIKType         = typeof(CS.RootMotion.FinalIK.LookAtIK)
-- local LookAtControllerType = typeof(CS.RootMotion.FinalIK.LookAtController)
local UIArgumentType       = typeof(CS.Engine.UI.UIArgument)
local IDType               = typeof(CS.Game.Native.Common.ID)
local CinemachineBrainType = typeof(CS.Cinemachine.CinemachineBrain)
local CustomLightDirRelativeCameraType = typeof(CS.CustomLightDirRelativeCamera)
local KeyboardInputType = typeof(CS.Game.KeyboardInput)
local TouchInputType          = typeof(CS.TouchInput)


------------ define ------------

---@class MapDecryptionSceneEnter
local MapDecryptionSceneEnter = Class('MapDecryptionSceneEnter')

function MapDecryptionSceneEnter:__init()
    self._parameters     = nil
    self._layer          = LayerMask.NameToLayer("Default")
    self._roleLayer      = LayerMask.NameToLayer("role")
    self._isCloseLoading = false
end


function MapDecryptionSceneEnter:__delete()
    -- self.controller = nil
end


function MapDecryptionSceneEnter:Awake()
end

function MapDecryptionSceneEnter:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:Init_()
    end))
    return coWait
end

function MapDecryptionSceneEnter:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:RemoveListener()
        self:ClearCache()
        -- self:RemoveComponent()
    end))
    return coWait
end

function MapDecryptionSceneEnter:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
        KCookie.Set("tgtMoveDir") -- 置空

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end

---------------------------------------------------
--- init begin --
---------------------------------------------------

function MapDecryptionSceneEnter:Init_()
    self:InitData()
    self:InitListener()
    -- self:InitComponent()
    MapDecryptionMgr:RequestHome()
    -- self:TransitionScene()
    if not self._isPlayOp then
        self:PlayBGM()
    else
        CriWareUtils.StopAll()
    end
end

function MapDecryptionSceneEnter:InitData()
    local parameters = self.controller.Argument.parameters
    ---@type ActivityDojo
    local activityData      = parameters.activityData
    local isPlayOp          = parameters.isPlayOp
    local activityContentId = activityData.activityContentId

    --- 进入活动前要使用 自己import
    ---@type MapDecryptionConstants
    MapDecryptionConstants = import("Game.Activity.MapDecryption.MapDecryptionConstants")
    ---@type MapDecryptionConfMgr
    MapDecryptionConfMgr   = import("Game.Activity.MapDecryption.MapDecryptionConfMgr").New()
    ---@type MapDecryptionMgr
    MapDecryptionMgr       = import("Game.Activity.MapDecryption.MapDecryptionMgr").New()
    ---@type MapDecryptionUtils
    MapDecryptionUtils     = import("Game.Activity.MapDecryption.MapDecryptionUtils")

    MapDecryptionMgr:Initialize(activityData)
    MapDecryptionConfMgr:InitActivityContentId(activityContentId)
    MapDecryptionConfMgr:InitActivityPrefabId(activityData.prefab)

    SetSFButtonAction = function(go,cb)
        SetButtonAction(go, function ()
            ---@type MapDecryptionComponent
            local component = MapDecryptionMgr:GetComponent()
            if component:CheckActivityIsClose() then
                GameUtils.Toast(localize("活动已关闭"))
                return
            end
            if cb then
                cb()
            end   

        end)
    end

    ---@type MapDecryptionPlanVo
    local planVo = MapDecryptionConfMgr:GetPlanVoById(activityContentId)
    self._planVo = planVo

    self._activityData = activityData
    self._isPlayOp = isPlayOp
end

function MapDecryptionSceneEnter:InitListener()
    local EventNames = MapDecryptionConstants.EventNames
    local Bind = Bind
    self._listenerConf = {
        [Constants.EventNames.FightPreHandle]    = Bind(self, self.OnFightPreHandle),
        -- [Constants.EventNames.FightEndPreHandle] = Bind(self, self.OnFightEndPreHandle),
        [EventNames.HideOptions]                 = Bind(self, self.OnHideOptions),
        [EventNames.ChangeCameraControlMode]     = Bind(self, self.OnChangeCameraControlMode),
        [EventNames.MaidCoffee_Change_Run_State] = Bind(self, self.OnChangeRunState),
        [EventNames.ControlPlayerInputStatus]    = Bind(self, self.OnControlPlayerInputStatus),
        [EventNames.ChangeCamController]         = Bind(self, self.OnChangeCamController),
        [EventNames.UpdateRoleInputStatus]       = Bind(self, self.OnUpdateRoleInputStatus),
        [EventNames.RestoreBrainBlend]           = Bind(self, self.SetDefaultBlend),
        [EventNames.ReInitEasyTouch]             = Bind(self, self.OnReInitEasyTouch),

    }

    for k, v in pairs(self._listenerConf) do
        Events.AddListener(k, v)
    end

    FightPreWarMgr:GetInstance():SetFightEndPreHandle(Bind(self, self.OnFightEndPreHandle))
end
function MapDecryptionSceneEnter:RemoveListener()
    for k, v in pairs(self._listenerConf) do
        Events.RemoveListener(k, v)
    end
    FightPreWarMgr:GetInstance():SetFightEndPreHandle(nil)
end


function MapDecryptionSceneEnter:AsyncLoadingResources()
    ---@type UILoadingPanel
    local loadingUI = self._loadingUI

    --- 加载逻辑
    --- 视频播完
    if self._isPlayOp then
        loadingUI:Play(function ()
            if self._isLoadComplete then
                self:CloseLoading(loadingUI)

            end
            return not self._isLoadComplete
        end)
    end

    self:Preload()

    ---自定义加载进度的逻辑在此处
    local displayProgress = 0
    local toProgress      = SceneMaxProgress
    local sceneId         = self._planVo.sceneId
    sceneManagement:Transition({ identifier = sceneId, isCache = true })
    while sceneManagement:IsTransition() do
        displayProgress = self:UpdateProgress(loadingUI, displayProgress, toProgress)
    end

    self:CreatePreloadObject(loadingUI, displayProgress)

    --- 给个场景加载完成 
    MapDecryptionMgr:SetIsLoadSceneComplete(true)
    
    --- 放开 home 接口为请求完成这时候 需要等待请求完成
    local MapDecryptionMgr = MapDecryptionMgr
    while not MapDecryptionMgr:GetIsRequestHomeComplete() do
        yield(Yielders.EndOfFrame)
    end

    --- story3 不播放暂时关闭
    -- ---@type MapDecryptionComponent
    -- local component = MapDecryptionMgr:GetComponent()
    -- ---@type MapDecryptionDojo
    -- local dojo = component:GetMapDecryptionDojo()
    -- local isFirst = checkNumber(dojo.isFirst) == 1
    -- if isFirst then
    --     MapDecryptionUtils.PlayStory(self._planVo.story3, "Game.Activity.MapDecryption.OP.MapDecryptionPlayer", function ()
    --         while not self._isCloseLoading do
    --             yield()
    --         end
    --     end)

    -- end

    --- 古物模型控制依赖于home date
    ---@type SceneInstance
    local sceneInstance = sceneManagement:GetSceneInstance(sceneId)
    MapDecryptionMgr:InitControllerComps(sceneInstance)

    sceneManagement:SetActive(sceneId, true)

    self._isLoadComplete = true
    if not self._isPlayOp or loadingUI:GetLoopTimes() > 0 then
        self:CloseLoading(loadingUI)
        self._isCloseLoading = true
    end
    yield()

end

--- UpdateProgress
---@param loadingUI SpecifySceneLoadingPanel
---@param displayProgress number 
---@param toProgress number
function MapDecryptionSceneEnter:UpdateProgress(loadingUI, displayProgress, toProgress)
    if displayProgress < toProgress then
        while displayProgress < toProgress do
            displayProgress = displayProgress + 1.5
            if not self._isPlayOp then
                loadingUI:__Progress(displayProgress * 0.01)
            end
            yield(Yielders.EndOfFrame)
        end
    else
        yield(Yielders.EndOfFrame)
    end
    return displayProgress
end

--- Preload
--- 创建场景附加loader
function MapDecryptionSceneEnter:Preload()
    local MapDecryptionUtils = MapDecryptionUtils
    local MapDecryptionConstants = MapDecryptionConstants
    local PrefabPath         = MapDecryptionConstants.PrefabPath
    local SceneDefine         = MapDecryptionConstants.SceneDefine
    ---------------------------------
    --- 场景相关loader

    --- 场景参数配置
    local t = {
        [SceneDefine.ScenePlayerNode]        = PrefabPath.ScenePlayer,
        [SceneDefine.SceneVirtualCameraNode] = PrefabPath.SceneVirtualCamera,
        [SceneDefine.ScenePositionsNode]     = PrefabPath.ScenePositions,
    }
    self._sceneConfigLoaders = {}
    for nodeName, nodePath in pairs(t) do
        self._sceneConfigLoaders[nodeName] = MapDecryptionUtils.FixPathAndCreateLoader(nodePath)
    end
    
    local MaidCoffeeUtils = import("Game.MaidCoffee.MaidCoffeeUtils")
    local settingVo =  MaidCoffeeUtils.GetMaidCoffeeSettingVo()
    local protagonistModePrefab   = CfUtils.IsWoman() and settingVo.woman or settingVo.man
    self._protagonistLoader = MapDecryptionUtils.LoadBundleAsync(protagonistModePrefab)

    -- --- todo 更换成正式动画路径    
    -- if CfUtils.IsWoman() then 
    --     self._protagonistControllerLoader = MapDecryptionUtils.LoadBundleAsync(MapDecryptionConstants.PrefabPath.GirlProtagonistController) 
    -- else
    --     self._protagonistControllerLoader = MapDecryptionUtils.LoadBundleAsync(MapDecryptionConstants.PrefabPath.BoyProtagonistController) 
    -- end
    -- assert( not isNull(self._protagonistControllerLoader) )

    
    local allNpcLoader = {}
    local allNpcControllerLoader = {}
    --- 创建npc loader path
    ---@type MapDecryptionMainSceneInteractionVo[]
    local mainSceneInteractionVos = MapDecryptionConfMgr:GetAllMainSceneInteractions()
    for i, vo in ipairs(mainSceneInteractionVos) do
        -- table.insert(rolePrefabPaths, vo.modelPath)
        table.insert(allNpcLoader, MapDecryptionUtils.LoadBundleAsync(vo.modelPath))
        table.insert(allNpcControllerLoader, MapDecryptionUtils.LoadBundleAsync(vo.action))
        -- allNpcLoader[vo.id] = MapDecryptionUtils.LoadBundleAsync(vo.modelPath)
    end
    
    self._mainSceneInteractionVos = mainSceneInteractionVos
    self._allNpcLoader = allNpcLoader
    self._allNpcControllerLoader = allNpcControllerLoader

    ---------------------------------
    --- UI loader

    self._optionsLoader      = MapDecryptionUtils.FixPathAndCreateLoader(MapDecryptionConstants.PrefabPath.ConversationOptions)
    -- self._talkingNodeLoader  = MapDecryptionUtils.LoadBundleAsync(MapDecryptionConstants.PrefabPath.TalkingNode)

    ---------------------------------
    --- mainCamera 的 虚拟相机 BlenderSettings 配置文件:
    self._vCameraBlenderSettingsLoader = MapDecryptionUtils.LoadBundleAsync(MapDecryptionConstants.VCameraBlenderSettingsPath)

    ---------------------------------
    --- UIRoot/UIBlack_Manual.prefab 
    -- self._UIRootGO = GameObject.Find("UIRoot") -- GameObject
    -- self._UIRootGO = UIModule.RootCanvas.transform.parent.gameObject
    -- self._UIBlack_ManualGO = self._UIRootGO.transform:Find("UIBlack_Manual")
    -- if isNull(self._UIBlack_ManualGO) then -- Transform
    --     self._UIBlack_ManualLoader = MapDecryptionUtils.LoadBundleAsync(MapDecryptionConstants.UIBlack_ManualPath)
    -- end
end

--- CreatePreloadObject
---@param loadingUI SpecifySceneLoadingPanel
---@param displayProgress number
function MapDecryptionSceneEnter:CreatePreloadObject(loadingUI, displayProgress)
    ---@type SceneInstance
    local sceneInstance = sceneManagement:GetSceneInstance(self._planVo.sceneId)

    local SceneDefine = MapDecryptionConstants.SceneDefine
    
    --- 创建 场景参数配置
    local toProgress = SceneConfProgress

    self._nodeName2node = {}
    for nodeName, loader in pairs(self._sceneConfigLoaders) do
        local node = MapDecryptionUtils.InstantiateByLoader(loader, nil, function ()
            displayProgress = self:UpdateProgress(loadingUI, displayProgress, toProgress)
        end)
        if not IsNull(node) then
            node.name = nodeName
            sceneInstance:AddCacheObject(node)

            self._nodeName2node[nodeName] = node
        end
    end
    displayProgress = toProgress
    --- 创建 主角
    toProgress = ProtagonistProgress
    local loader
    local scenePlayerNode      = self._nodeName2node[SceneDefine.ScenePlayerNode]
    local scenePlayerNodeTrans = scenePlayerNode.transform
    local playerCharacterNode  = scenePlayerNodeTrans:Find(SceneDefine.PlayerCharacter)
    local humanPlayerNode      = scenePlayerNodeTrans:Find(SceneDefine.HumanPlayer)
    if not isNull(playerCharacterNode) then
        loader = self._protagonistLoader
        local protagonistGo = MapDecryptionUtils.InstantiateByLoader(loader, playerCharacterNode.gameObject, function ()
            displayProgress = self:UpdateProgress(loadingUI, displayProgress, toProgress)
        end)
    
        local go = protagonistGo
        if not IsNull(go) then
            protagonistGo.name = SceneDefine.Protagonist
            -- KTool.SetParent(playerCharacterNode:Find(SceneDefine.Center).gameObject, go.gameObject, false)
            -- KTool.SetParent(playerCharacterNode:Find(SceneDefine.NPCLookAtTarget).gameObject, go.gameObject, false)
            
            self:InitProtagonistProp(go, playerCharacterNode, humanPlayerNode)
    
            -- local cmFreeLook = scenePlayerNodeTrans:Find(SceneDefine.CMFreeLook)
            -- self._cmFreeLook = cmFreeLook
            -- self:AddCMFollowAndLookAt(cmFreeLook, go.transform)
    
        end
    end

    displayProgress = toProgress
    --- 创建 所有NPC
    toProgress = NPCProgress
    for i, loader in ipairs(self._allNpcLoader) do
        ---@type MapDecryptionMainSceneInteractionVo
        local vo = self._mainSceneInteractionVos[i]
        local nonPlayerCharacterNode = scenePlayerNodeTrans:Find(SceneDefine.NonPlayerCharacters)
        local npcRoot   = nonPlayerCharacterNode:Find(SceneDefine.NpcRoot .. i)
        npcRoot.name = SceneDefine.NpcRoot..vo.id
        local go = MapDecryptionUtils.InstantiateByLoader(loader, npcRoot.gameObject, function ()
            displayProgress = self:UpdateProgress(loadingUI, displayProgress, toProgress)
        end)
        if not IsNull(go) then
            local triggerNode = npcRoot:Find(SceneDefine.NpcTriggerNode)
            if not isNull(triggerNode) then
                local idComp = KTool.GetOrAddComponent(triggerNode.gameObject, IDType)
                idComp.id = vo.id
            end
            go.name = SceneDefine.NpcName
            KTool.ResetLocalTransform(go.transform)

            ---@type UnityEngine.Animator
            MapDecryptionUtils.FillController(go, self._allNpcControllerLoader[i])

            local npcParamsNode = npcRoot:Find(SceneDefine.NPCParams) 
            self:InitNpcParams(go, npcParamsNode)

            local lookAtIKNode   = npcRoot:Find(SceneDefine.LookAtIK)
            if not isNull(lookAtIKNode) then
                MapDecryptionUtils.CopyLookAtIKGoParams(go, lookAtIKNode.gameObject)
            end
        end

    end
    
    displayProgress = toProgress
    toProgress = MaxProgress
    local mainCamera     = URPCameraController.Instance.mainCamera
    self:InitDialogueOptions(scenePlayerNode)
    -- self:InitTalkingNode()
    -- self:InitLocationCamera(scenePlayerNode)
    self:InitCanvas(sceneInstance, mainCamera)

    ---------------------------------
    --- mainCamera 的 虚拟相机 BlenderSettings 配置文件:
    self._vCameraBlenderSettings = MapDecryptionUtils.GetAssetByLoader( self._vCameraBlenderSettingsLoader )
    assert( not isNull(self._vCameraBlenderSettings) )
    printInfo( "_vCameraBlenderSettings = " .. self._vCameraBlenderSettings.name )

    ---:
    self:InitSceneSettings(sceneInstance, mainCamera)

    --- 缓存一些 gameobjs
    MapDecryptionMgr:CacheGameObjects()
end

--- InitNpcParams
--- 初始化Npc参数
---@param go UnityEngine.GameObject
---@param paramsNode UnityEngine.Transform
function MapDecryptionSceneEnter:InitNpcParams(go, paramsNode)
    ---@type CustomLightDirRelativeCamera
    local customLightNode = KTool.GetOrAddComponent(go, CustomLightDirRelativeCameraType)
    if not isNull(paramsNode) then
        ---@type CustomLightDirRelativeCamera
        local lightComp = paramsNode.gameObject:GetComponent(CustomLightDirRelativeCameraType)
        if not isNull(lightComp) then
            customLightNode.CustomLightDirection = lightComp.CustomLightDirection
            customLightNode.DelayUpdate = lightComp.DelayUpdate
            customLightNode.UsrCustomLightColor = lightComp.UsrCustomLightColor
            customLightNode.RelativeRole = lightComp.RelativeRole
            customLightNode.DoNotIncludeFace = lightComp.DoNotIncludeFace
        end
    end
    
end


--- InitProtagonistProp
---@param protagonistGo UnityEngine.GameObject
function MapDecryptionSceneEnter:InitProtagonistProp(protagonistGo, playerCharacterNode, humanPlayerNode)
    local SceneDefine = MapDecryptionConstants.SceneDefine

    ---先删除人物身上带的collider
    -- local protagonistCollider = KTool.GetComponent(protagonistGo, ColliderType)
    -- if not isNull(protagonistCollider) then
    --     Object.DestroyImmediate(protagonistCollider)
    -- end


    -- ---先删除人物身上带Rigidbod
    -- local rigidbody = KTool.GetComponent(protagonistGo, RigidbodyType)
    -- if not isNull(rigidbody) then
    --     Object.DestroyImmediate(rigidbody)
    -- end

    -- local protagonistTrans = protagonistGo.transform
    ---@type UnityEngine.Transform
    local roleParamsTrans = playerCharacterNode:Find(SceneDefine.RoleParams)
    local roleParamsNode  = roleParamsTrans.gameObject
    -- ---@type UnityEngine.CapsuleCollider
    -- local collider = KTool.GetComponent(roleParamsNode, CapsuleColliderType)
    -- if not isNull(collider) then

    --     -- ---先删除原先的collider
    --     -- local protagonistCollider = KTool.GetComponent(protagonistGo, ColliderType)
    --     -- if not isNull(protagonistCollider) then
    --     --     Object.DestroyImmediate(protagonistCollider)
    --     -- end

    --     ---根据预设类型创建对应的collider
    --     ---@type UnityEngine.CapsuleCollider
    --     protagonistCollider = KTool.GetOrAddComponent(protagonistGo, collider:GetType())
    --     protagonistCollider.center = collider.center
    --     protagonistCollider.radius = collider.radius
    --     protagonistCollider.height = collider.height
    --     protagonistCollider.direction = collider.direction
    --     protagonistCollider.isTrigger = collider.isTrigger
    --     protagonistCollider.material = collider.material

    --     -- --- 复制后销毁
    --     -- Object.Destroy(collider)
    -- end

    -- ---@type UnityEngine.Rigidbody
    -- local rigidBody = KTool.GetComponent(roleParamsNode, RigidbodyType)
    -- if not isNull(rigidBody) then
        
    --     ---@type UnityEngine.Rigidbody
    --     local protagonistRigidBody = KTool.GetOrAddComponent(protagonistGo, RigidbodyType)
    --     protagonistRigidBody.mass = rigidBody.mass
    --     protagonistRigidBody.drag = rigidBody.drag
    --     protagonistRigidBody.angularDrag = rigidBody.angularDrag
    --     protagonistRigidBody.useGravity = rigidBody.useGravity
    --     protagonistRigidBody.isKinematic = rigidBody.isKinematic

    --     --protagonistRigidBody.interpolation = rigidBody.interpolation
    --     -- 2020_0113, 为了克服相机旋转时的抖动问题, 目前的 mainCamera 的 cinemachineBrain 的 Update Method 被设为了 Smart Update
    --     -- 这反过来导致了 角色移动时的抖动; 
    --     -- 解决方案是将此处的 interpolation 模式强制设置为 Interpolate:
    --     protagonistRigidBody.interpolation = CS.UnityEngine.RigidbodyInterpolation.Interpolate
        
    --     protagonistRigidBody.collisionDetectionMode = rigidBody.collisionDetectionMode
    --     protagonistRigidBody.constraints = rigidBody.constraints

    --     -- --- 复制后销毁
    --     -- Object.Destroy(rigidBody)

    -- end

    local ControllerSetup = CS.Game.CharacterController.ControllerSetup
    local controllerSetUp = KTool.GetComponent(humanPlayerNode.gameObject, typeof(ControllerSetup))
    local humanPlayerNodeTrans = humanPlayerNode.transform
    local humanNode            = humanPlayerNodeTrans:Find(SceneDefine.Human)
    -- self:InitBehaviorAction(humanNode)
    self:InitLocationCamera(humanNode.gameObject)
    controllerSetUp:Setup(protagonistGo)
    -- controllerSetUp.humanCharacter:SetRotation(Quaternion.Euler(0,180,0))
    local cameraInput = humanPlayerNodeTrans:Find(SceneDefine.CameraInput)
    ---@type CameraInput
    local cameraInputEnv = CfUtils.GetLuaScr(cameraInput, MapDecryptionConstants.EnvPath.CameraInput)
    cameraInputEnv:InitVCam(controllerSetUp.vcamController, controllerSetUp.follow, controllerSetUp.lookAt, true)
    self._cmFreeLook = cameraInput
    self._controllerSetUp = controllerSetUp

    local playerInput = humanPlayerNodeTrans:Find(SceneDefine.PlayerInput)
    self._playerInput = playerInput

    -- local playerInputComp
    -- if MapDecryptionUtils.IsPCPlatform() then
    --     playerInputComp = KTool.GetComponent(playerInput.gameObject, KeyboardInputType)
    -- else
    --     playerInputComp = KTool.GetComponent(playerInput.gameObject, TouchInputType)
        
    -- end
    -- self._playerInput = playerInputComp
    
    local protagonistTrans         = protagonistGo.transform
    protagonistTrans.localPosition = roleParamsTrans.localPosition
    protagonistTrans.localRotation = roleParamsTrans.localRotation
    protagonistTrans.localScale    = roleParamsTrans.localScale

end

--- AddCMFollowAndLookAt
---@param cmFreeLook UnityEngine.Transform
---@param transform UnityEngine.Transform 主角 transform
function MapDecryptionSceneEnter:AddCMFollowAndLookAt(cmFreeLook, transform)
    ---@type CameraInput
    local cameraInput = CfUtils.GetLuaScr(cmFreeLook, MapDecryptionConstants.EnvPath.CameraInput)
    if not isNull(cameraInput) then
        cameraInput:SetTarget(transform, transform:Find("_center_"))
    end
end

--- InitDialogueOptions
--- 初始化对话选项
---@param parent UnityEngine.GameObject
function MapDecryptionSceneEnter:InitDialogueOptions(parent)
    local dialogueOptionsGo = MapDecryptionUtils.InstantiateByLoader(self._optionsLoader, parent)
    
    if isNull(dialogueOptionsGo) then
       return 
    end

    -- self._sceneInstance:AddCacheObject(dialogueOptionsGo)
    ---@type UnityEngine.Canvas
    local canvas         = dialogueOptionsGo:GetComponent(CanvasType)
    canvas.enabled       = false
    canvas.worldCamera   = URPCameraController.Instance.uiCamera

    local transform      = canvas.transform
    transform.position   = Vector3.New(0, 0, 90)
    transform.localScale = UIModule.RootCanvas.transform.localScale
    transform.sizeDelta  = Vector2.New(1920, 1080)
    dialogueOptionsGo.name = MapDecryptionConstants.SceneDefine.DialogueOptions

    -- self._interactionControllerComp:SetDialogueOptions(canvas)
    self._dialogueOptionsCanvas = canvas

end

function MapDecryptionSceneEnter:InitLocationCamera(parent)
    local vCameraComp = MapDecryptionUtils.CreateVirtualCamera(MapDecryptionConstants.SceneDefine.LocationVirtualCamera)
    -- assert( not isNull(vCameraComp) )
    -- 设置 fov 值, 要比 mcamera 更加靠近角色
    -- local lens = vCameraComp.m_Lens
    -- lens.FieldOfView = 27.0
    -- vCameraComp.m_Lens = lens
    -- vCameraComp.Priority = 110
    KTool.SetParent(vCameraComp.gameObject, parent, false)
    -- self._interactionControllerComp:SetLocationCamera(go.transform)
    -- self._locationCamera = go.transform
end

--- InitCanvas
---@param sceneInstance SceneInstance
---@param mainCamera UnityEngine.Camera
function MapDecryptionSceneEnter:InitCanvas(sceneInstance, mainCamera)
    local worldSpaceCanvas = sceneInstance:GetCacheObjectByName(MapDecryptionConstants.SceneDefine.WorldSpaceCanvasName)
    KTool.SetLayer(self._layer, worldSpaceCanvas.gameObject, true)
    local canvas           = worldSpaceCanvas.gameObject:GetComponent(CanvasType)
    canvas.worldCamera     = mainCamera

end

--- InitSceneSettings
---@param sceneInstance SceneInstance
---@param mainCamera UnityEngine.Camera
function MapDecryptionSceneEnter:InitSceneSettings(sceneInstance, mainCamera)
    local mainCameraBrain         = mainCamera.gameObject:GetComponent(CinemachineBrainType)
    self._mainCameraBrain = mainCameraBrain
    self._originBrainDefaultBlend = mainCameraBrain.m_DefaultBlend
    self._originBrainCustomBlends = mainCameraBrain.m_CustomBlends
    -- local curSceneMainCameraGo    = sceneInstance:GetCacheObjectByName(MapDecryptionConstants.SceneDefine.MainCamera)
    -- local curSceneMainCameraBrain = curSceneMainCameraGo:GetComponent(CinemachineBrainType)
    -- self._brainDefaultBlend       = curSceneMainCameraBrain.m_DefaultBlend
    -- self._brainDefaultBlend.m_Time = 0.7
    self._originBlendTime = mainCameraBrain.m_DefaultBlend.m_Time
    -- mainCameraBrain.m_DefaultBlend = CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 0.7)
    self:SetDefaultBlend()
    mainCameraBrain.m_CustomBlends = self._vCameraBlenderSettings


    ---------------------------------
    --- 修改主场景 阴影配置:
    --- 开启 maincamera 的 PlaneShadow 开关
    local customData = KTool.GetComponent(mainCamera.gameObject, typeof(CS.CameraCustomData))
    assert( not isNull(customData) )
    self._cachedPlaneShadowOpenType = customData.PlaneShadow
    customData.PlaneShadow = CS.CameraCustomData.BaseSettingEnum.Open
    
    --- 整个 春节主场景 的 阴影, 强制使用 低端阴影;
    self._cachedPlaneShadowQuality = FuntoyRenderFeature.planeShadowQuality
    FuntoyRenderFeature.planeShadowQuality = FuntoyRenderFeature.PlaneShadowQuality.Low
    
    -- 低端阴影参数选项: Cultivate 这个选项从来没被使用过, 暂时用到这里:
    self._cachedPlaneShadowScene = FuntoyRenderFeature.planeShadowScene
    FuntoyRenderFeature.planeShadowScene = FuntoyRenderFeature.PlaneShadowScene.Cultivate


    ---------------------------------
    --- 修改主场景 点光源 Per Object Limit 
    xTry(function ()
        XGraphicSetup.SetMaxAdditionalLightsCount( 2, 4, 6, 8, 8 )
    end)
end

function MapDecryptionSceneEnter:SetDefaultBlend()
    self._mainCameraBrain.m_DefaultBlend = CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 0.7)
end


function MapDecryptionSceneEnter:CloseLoading(loadingUI)
    if not self._isPlayOp then
        loadingUI:__Progress(1)
    else
        self:PlayBGM()
    end
    loadingUI:Close()
    local UINavigationBarRoot = CS.UINavigationBarRoot
    UINavigationBarRoot.Instance:SetActive(true)
    --- 打开摇杆 windows平台不开 使用鼠标控制镜头
    if not MapDecryptionUtils.IsPCPlatform() then
        local joystick = ETCInput.GetControlJoystick(JoystickName)
        local luaBehaviour = GetLuaBehaviour(joystick.transform.parent.gameObject, MapDecryptionConstants.EnvPath.ETCJoystick)
        luaBehaviour.Env:Active()
    end
    Physics.autoSimulation = true
    Input.multiTouchEnabled = true
    EasyTouch.SetEnable2FingersGesture(true)
    Physics.IgnoreLayerCollision( self._layer, self._roleLayer, false )
    MapDecryptionMgr:SetIsCloseLoading(true)

end

---------------------------------------------------
--- init end --
---------------------------------------------------

---------------------------------------------------
--- logic begin --
---------------------------------------------------


function MapDecryptionSceneEnter:PlayBGM()
    MapDecryptionUtils.SetBgmPlayStatus(true)
    -----@type MapDecryptionPlanVo
    --local planVo = self._planVo
    --local music  = planVo.music
    --if not string.isEmpty(music) then
    --    CriWareUtils.PlayMusicById(music)
    --    
    --end
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function MapDecryptionSceneEnter:SetLoadingUI(loadingUI)
    self._loadingUI = loadingUI
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function MapDecryptionSceneEnter:OnFightPreHandle()
    ---@type MapDecryptionExploreTrackingController
    local exploreTrackingControllerComp = MapDecryptionMgr:GetControllerCompByType(MapDecryptionConstants.ControllerCompType.ExploreTracking)
    exploreTrackingControllerComp:ShowVirtualCameraBySubType(nil)

    self._oldShowLoadedScenesState = sceneManagement:GetShowLoadedScenesState(true)
    local cmFreeLook = self._cmFreeLook
    KTool.SetActive(cmFreeLook.gameObject, false)

    local ScreenHistory = UIModule.ScreenHistory
    local list = support.new_list(UIArgumentType)
    -- ScreenHistory:CopyTo(list)
    for i, v in support.list_ipairs(ScreenHistory) do
        list:Add(v)
    end
    
    self._ScreenHistory = list
    Physics.autoSimulation = false
    Input.multiTouchEnabled = false
    EasyTouch.SetEnable2FingersGesture(false)
    Physics.IgnoreLayerCollision( self._layer, self._roleLayer, true )
    --printInfo(" --2-- IgnoreLayerCollision")
end

function MapDecryptionSceneEnter:OnFightEndPreHandle()
    self:PlayBGM()
    ---@type MapDecryptionExploreTrackingController
    local exploreTrackingControllerComp = MapDecryptionMgr:GetControllerCompByType(MapDecryptionConstants.ControllerCompType.ExploreTracking)
    exploreTrackingControllerComp:SetBackFromFight(true)

    Input.multiTouchEnabled = true
    EasyTouch.SetEnable2FingersGesture(true)
    Physics.autoSimulation  = true
    Physics.IgnoreLayerCollision( self._layer, self._roleLayer, false )

    --printInfo(" --3-- IgnoreLayerCollision")
    -- cs_coroutine.start(function ()
    local scenesState = self._oldShowLoadedScenesState
    if scenesState then
        for identifier, enable in pairs(scenesState) do
            sceneManagement:SetActive(identifier, enable)
        end

        self._oldShowLoadedScenesState = nil

    end

    local cmFreeLook = self._cmFreeLook
    KTool.SetActive(cmFreeLook.gameObject, true)   

    local ScreenHistory = UIModule.ScreenHistory
    local list = self._ScreenHistory
    for i, v in support.list_ipairs(list) do
        ScreenHistory:Add(v)
    end

    --- 修正当前场景参数
    UIModule.CurrentScreen.Argument = {id = Constants.UITypeIds.UISceneMapDecryption}

    -- end)

    
end

function MapDecryptionSceneEnter:OnHideOptions()
    self._dialogueOptionsCanvas.enabled = false
    self:OnChangeCameraControlMode(Constants.CameraControlMode.None)

    ---@type MapDecryptionConversationOptions
    local env = CfUtils.GetLuaScr(self._dialogueOptionsCanvas, MapDecryptionConstants.EnvPath.ConversationOptionNodes)
    if not isNull(env) then
        env:ClearCache()
    end

end

--- OnChangeCameraControlMode
---@param mode number Constants.CameraControlMode
function MapDecryptionSceneEnter:OnChangeCameraControlMode(mode)
    local cmFreeLook = self._cmFreeLook
    ---@type CameraInput
    local cameraInput = CfUtils.GetLuaScr(cmFreeLook, MapDecryptionConstants.EnvPath.CameraInput)
    if not isNull(cameraInput) then
        cameraInput:SetControlMode(mode)
    end
    
end

function MapDecryptionSceneEnter:OnChangeCamController(isActive)
    local controllerSetUp = self._controllerSetUp
    if isNotNull(controllerSetUp) then
        CfUtils.SetActive(controllerSetUp.vcamController, isActive)
    end
end

--- OnChangeRunState
function MapDecryptionSceneEnter:OnChangeRunState(mode)
    if isNotNull(self._controllerSetUp) and self._controllerSetUp.humanCharacter then
        self._controllerSetUp.humanController.canRun = not self._controllerSetUp.humanController.canRun
        GameUtils.Toast(self._controllerSetUp.humanController.canRun and localize("已切换至跑步状态") or localize("已切换至走路状态"))
    end
    
end

function MapDecryptionSceneEnter:OnControlPlayerInputStatus(isActive)
    local controllerSetUp = self._controllerSetUp
    if not isActive and isNotNull(controllerSetUp) and self._controllerSetUp.humanController then
        self._controllerSetUp.humanController:MoveEnd()
    end
    CfUtils.SetActive(self._playerInput, isActive)
    
end

function MapDecryptionSceneEnter:OnUpdateRoleInputStatus(isActive)
    -- self:OnChangeRunState(isActive)
    self:OnControlPlayerInputStatus(isActive)
    self:OnChangeCamController(isActive)

end

function MapDecryptionSceneEnter:OnReInitEasyTouch()
    if MapDecryptionUtils.IsPCPlatform() then
        return
    end
    local cmFreeLook = self._cmFreeLook
    ---@type CameraInput
    local cameraInput = CfUtils.GetLuaScr(cmFreeLook, MapDecryptionConstants.EnvPath.CameraInput)
    if not isNull(cameraInput) then
        cameraInput:InitEasyTouch()
    end
end


---------------------------------------------------
--- handler end ---
---------------------------------------------------

---------------------------------------------------
--- clear begin ---
---------------------------------------------------

function MapDecryptionSceneEnter:ClearCache()
    MapDecryptionConfMgr:Delete()
    MapDecryptionConfMgr   = nil
    MapDecryptionMgr:Delete()
    MapDecryptionMgr       = nil
    MapDecryptionConstants = nil
    MapDecryptionUtils     = nil
    SetSFButtonAction       = nil

    local mainCamera      = URPCameraController.Instance.mainCamera
    local mainCameraBrain = mainCamera.gameObject:GetComponent(CinemachineBrainType)
    mainCameraBrain.m_DefaultBlend = self._originBrainDefaultBlend
    mainCameraBrain.m_CustomBlends = self._originBrainCustomBlends
    
    Physics.autoSimulation = false
    Input.multiTouchEnabled = false
    EasyTouch.SetEnable2FingersGesture(false)
    Physics.IgnoreLayerCollision( self._layer, self._roleLayer, true )
    --printInfo(" --4-- IgnoreLayerCollision")

    --- 恢复缓存的数据: 
    -- 1. mainCamera 的 PlaneShadow 开关
    -- 2. 是否使用 低端阴影
    -- 3. 原来使用的 低端阴影配置参数
    local mainCamera = URPCameraController.Instance.mainCamera
    local customData = KTool.GetComponent(mainCamera.gameObject, typeof(CS.CameraCustomData))
    assert( not isNull(customData) )
    customData.PlaneShadow                  = self._cachedPlaneShadowOpenType
    FuntoyRenderFeature.planeShadowQuality  = self._cachedPlaneShadowQuality
    FuntoyRenderFeature.planeShadowScene    = self._cachedPlaneShadowScene

    ---------------------------------
    --- 修改主场景 点光源 Per Object Limit 
    xTry(function ()
        XGraphicSetup.SetMaxAdditionalLightsCount( 2, 4, 6, 8, 8 )
    end)

    self:UnloadScene()

end

function MapDecryptionSceneEnter:UnloadScene()
    local sceneInstance = sceneManagement:GetSceneInstance(self._planVo.sceneId)
    if sceneInstance then
        coroutine.yield(sceneManagement:UnloadScene(sceneInstance))
    end

end
---------------------------------------------------
--- clear end ---
---------------------------------------------------


return MapDecryptionSceneEnter
