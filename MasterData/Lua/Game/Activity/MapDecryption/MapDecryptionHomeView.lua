------------ global define ------------
local isNull  = isNull
local Bind    = Bind
local pairs   = pairs
local require = require
local import  = import
local CS      = CS
local typeof  = typeof
------------ global define ------------

------------ import ------------
local util                      = require 'XLua.util'
local cs_coroutine              = require "XLua.cs_coroutine"
local CoWait                    = CS.Engine.Lib.CoWait
local URPCameraController       = CS.Game.Native.URP.URPCameraController
---@type Engine.Lib.KTool
local KTool                     = CS.Engine.Lib.KTool
---@type Engine.Lib.KCookie
local KCookie                   = CS.Engine.Lib.KCookie
local SceneManagementIns        = SceneManagement:GetInstance()
local LayerMask                 = CS.UnityEngine.LayerMask
local GameObject                = CS.UnityEngine.GameObject
local Vector3                   = CS.UnityEngine.Vector3
local Quaternion                = CS.UnityEngine.Quaternion
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker          = CS.Engine.UI.UIRaycastBlocker.Instance
local ETCInput                  = CS.ETCInput
---@type Engine.Lib.Yielders
local Yielders                  = CS.Engine.Lib.Yielders
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule

local LuaBehaviour = CS.Engine.Modules.LuaBehaviour
local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera
local FuntoyRenderFeature = CS.FuntoyRenderFeature

local MinMapControl             = import("Game.Behaviours.MinMapControl")
-- local PlayerInput               = import("Game.Behaviours.PlayerInput")
-- local HumanSimpleController     = import("Game.Behaviours.HumanSimpleController")
local RoleCollisionController   = import("Game.Activity.MapDecryption.Interaction.MapDecryptionRoleCollisionController")
local MapDecryptionPCController = import("Game.Activity.MapDecryption.Interaction.MapDecryptionPCController")

------------ import ------------

------------ define ------------
local BehaviourActionType = typeof(CS.Engine.Lib.BehaviourAction)
local CanvasType          = typeof(CS.UnityEngine.Canvas)
local yield_return        = cs_coroutine.yield_return
local WaitScends          = Yielders.GetWaitForSeconds(.5)

local InteractionComponentType = {
    PlayerInput               = 1,
    MinMapControl             = 2,
    RoleCollisionController   = 3,
    HumanSimpleController     = 5,
    PcController              = 6,
}

local JoystickName = "LeftJoystick"

------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalHomeView.prefab
---@class MapDecryptionHomeView
---@field Env                           	MapDecryptionHomeView                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgRoleIcon                   	UnityEngine.RectTransform  
---@field ImgView                   	    UnityEngine.RectTransform              
---@field ImgMap                        	UnityEngine.RectTransform               
---@field BtnMouse                      	UnityEngine.RectTransform               
---@field BtnRemoteScene                	ETCJoystick                             
---@field BtnBack                       	UnityEngine.Animation                   
---@field BtnShop                       	UnityEngine.Animation                   
---@field LeftDownRoot                  	UnityEngine.RectTransform               
---@field RightUpRoot                   	UnityEngine.RectTransform               
---@field Container                     	UnityEngine.RectTransform               
---@field ControlNode                   	UnityEngine.RectTransform               
local MapDecryptionHomeView = Class('MapDecryptionHomeView')


function MapDecryptionHomeView:__init()
    self._interactionComps = {} --- 交互相关的组件
    self._controllerComps  = {} --- 控制相关的组件
    self._cmFreeLook = nil
    self._layer = LayerMask.NameToLayer("Default")
end


function MapDecryptionHomeView:__delete()
    self._interactionComps = nil
    self._controllerComps  = nil
    self.controller = nil
    self._behaviorAction = nil
end


function MapDecryptionHomeView:Awake()
    KTool.SetActive(self.BtnShop.gameObject , false)
    SetButtonAction(self.BtnShop, Bind(self, self.OnClickBtnShopAction))
    SetButtonAction(self.BtnBack, Bind(self, self.OnClickBtnBackAction))

    local isPCPlatform = MapDecryptionUtils.IsPCPlatform()
    KTool.SetActive(self.BtnMouse.gameObject, isPCPlatform)
    if isPCPlatform then
        SetButtonAction(self.BtnMouse, Bind(self, self.OnClickBtnMouseAction))
    end

end


function MapDecryptionHomeView:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:InitData()
        self:Preload()
        self:InitListening()

        local MapDecryptionMgr = MapDecryptionMgr
        while not MapDecryptionMgr:GetIsCloseLoading() do
            yield_return()
        end
        self:InitSceneInstance()
        self:CreatePreloadObject()
        self:InitScene()

        self:ControlPlayerInputStatus(false)
        self:FreshVirtualCameraShowState(false)

    end))
    return coWait
end

function MapDecryptionHomeView:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        MapDecryptionUtils.EnterPCTipsDialog()

    end))
    return coWait
end

function MapDecryptionHomeView:OnFocus(focus)
    if focus then
        local isOpen = CfUtils.CookieLoad("MapDecryptionPCTipsDialogOpen")
        if isOpen and isOpen == 0 then
            CfUtils.CookieSave("MapDecryptionPCTipsDialogOpen", nil)
            self:ChangeCameraControlMode(Constants.CameraControlMode.MoveMouse)
        end
        Events.Broadcast(MapDecryptionConstants.EventNames.ReInitEasyTouch)
    end
end


function MapDecryptionHomeView:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        -- local playerInput = self._interactionComps[InteractionComponentType.PlayerInput]
        -- KCookie.Set("tgtMoveDir", playerInput.tgtMoveDir )
        ---:
        self:Clear()
    end))
    return coWait
    
end

function MapDecryptionHomeView:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:ChangeCameraControlMode(Constants.CameraControlMode.None)

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function MapDecryptionHomeView:Preload()
    local MapDecryptionUtils = MapDecryptionUtils
    -- self._optionsLoader      = MapDecryptionUtils.FixPathAndCreateLoader(MapDecryptionConstants.PrefabPath.ConversationOptions)
    self._talkingNodeLoader  = MapDecryptionUtils.LoadBundleAsync(MapDecryptionConstants.PrefabPath.TalkingNode)

end

function MapDecryptionHomeView:InitData()
    local parameters   = self.controller.Argument.parameters
    local activityData = parameters.activityData
    local activityContentId = activityData.activityContentId
    ---@type MapDecryptionPlanVo
    local planVo       = MapDecryptionConfMgr:GetPlanVoById(activityContentId)
    self._planVo       = planVo
    
    self._isInitStatus = true

end

function MapDecryptionHomeView:InitSceneInstance()
    ---@type MapDecryptionPlanVo
    local planVo = self._planVo
    
    ---@type SceneInstance
    local sceneInstance = SceneManagementIns:GetSceneInstance(planVo.sceneId)
    self._sceneInstance = sceneInstance

end

function MapDecryptionHomeView:CreatePreloadObject()
    -- self:InitDialogueOptions()
    
    self:InitTalkingNode()

end

function MapDecryptionHomeView:InitTalkingNode()
    local talkNode = MapDecryptionUtils.InstantiateByLoader(self._talkingNodeLoader, self.Container.gameObject)
    ---@type UnityEngine.Canvas
    local canvas         = talkNode:GetComponent(CanvasType)
    self._talkNode = canvas
    self._talkNode.enabled = false

    ---@type TalkingNode
    local env = CfUtils.GetLuaScr(self._talkNode, MapDecryptionConstants.EnvPath.TalkingNode)
    if isNull(env) then return end
    self._talkEnv = env
    env:Init(MapDecryptionConstants.EventNames.PlayModelAction)
end

function MapDecryptionHomeView:InitScene()
    local SceneDefine    = MapDecryptionConstants.SceneDefine
    local sceneInstance  = self._sceneInstance
    local mainCamera     = URPCameraController.Instance.mainCamera

    -- self:InitVirtualCamera()
    self:InitCanvas()

    local joystick = ETCInput.GetControlJoystick(JoystickName)
    if MapDecryptionUtils.IsPCPlatform() then
        ---@type MapDecryptionPCController
        local pcController = MapDecryptionPCController.New()
        pcController:SetEnabled(true)
        self._interactionComps[InteractionComponentType.PcController] = pcController
    else
        ---@type ETCJoystick
        local Env = CfUtils.GetLuaScr(joystick.transform.parent.gameObject, MapDecryptionConstants.EnvPath.ETCJoystick)
        Env:Active()
        self._etcJoystick = Env
    end

    local ScenePlayerNodeTrans = sceneInstance:GetCacheObjectByName(SceneDefine.ScenePlayerNode).transform
    local cmFreeLook = ScenePlayerNodeTrans:Find(SceneDefine.CMFreeLook)
    self._cmFreeLook = cmFreeLook
    self:ChangeCameraControlMode(Constants.CameraControlMode.MoveMouse)

    --- 初始化 玩家输入输出组件
    -- local BtnRemoteScene = self.BtnRemoteScene
    
    -- ---@type PlayerInput
    -- local playerInput
    -- if not isNull(joystick) then
    --     playerInput = PlayerInput.New()
    --     playerInput:Init(mainCamera, joystick)
    --     self._interactionComps[InteractionComponentType.PlayerInput] = playerInput

    -- end

    --- 初始化 小地图控制组件
    local playerCharacterNode = ScenePlayerNodeTrans:Find(SceneDefine.HumanPlayer)
    local role                = playerCharacterNode:Find(SceneDefine.Human)
    if not isNull(role) then
        ---@type MinMapControl
        local minMapControl = MinMapControl.New()
        local uiMinMap      = self.ImgMap
        local uiRole        = self.ImgRoleIcon
        local uiView        = self.ImgView
        minMapControl:Init(uiMinMap, uiRole, role.transform, mainCamera.transform, uiView.transform )
        self._interactionComps[InteractionComponentType.MinMapControl] = minMapControl

        self._protagonistTarget = role:Find(SceneDefine.NPCLookAtTarget) -- 此值暂未被使用
        self._protagonistCenter = role:Find(SceneDefine.Center)

    end

    --- 初始化 全息投影 物体:
    local holographicDitherManagerGO = GameObject.Find("HolographicDitherManager")
    if holographicDitherManagerGO and not isNull(role) then
        local holographicDitherComp = KTool.GetComponent(holographicDitherManagerGO, typeof(LuaBehaviour)).Env -- MapDecryptionHolographicDither
        assert( holographicDitherComp )
        holographicDitherComp:Init( role.transform )
    end

    --- 初始化 角色碰撞控制组件
    ---@type MapDecryptionRoleCollisionController
    local roleCollisionController = RoleCollisionController.New()
    self._interactionComps[InteractionComponentType.RoleCollisionController] = roleCollisionController
    roleCollisionController:Init(role, self._worldSpaceCanvas, ScenePlayerNodeTrans, mainCamera)

    --- 初始化 人物地面控制器组件
    -- ---@type HumanSimpleController
    -- local humanSimpleController = HumanSimpleController.New()
    -- self._interactionComps[InteractionComponentType.HumanSimpleController] = humanSimpleController
    -- humanSimpleController:Init(role.gameObject, playerInput)
    -- roleCollisionController:InitHumanSimpleController( humanSimpleController )
    
    self:InitBehaviorAction(role.gameObject)

    local uiCameraParamsContoller = sceneInstance:GetCacheObjectByName(SceneDefine.UICameraParamsContoller)
    if not isNull(uiCameraParamsContoller) then
        ---@type CameraParamsController
        local env = CfUtils.GetLuaScr(uiCameraParamsContoller, MapDecryptionConstants.EnvPath.CameraParamsController)
        if not isNull(env) then
            env:OnEnableAction()
        end
    end

    ---------------------------------
    --- 修改主场景 阴影配置:
    --- 开启 maincamera 的 PlaneShadow 开关
    local customData = KTool.GetComponent(mainCamera.gameObject, typeof(CS.CameraCustomData))
    assert( not isNull(customData) )
    self._cachedPlaneShadowOpenType = customData.PlaneShadow
    -- customData.PlaneShadow = CS.CameraCustomData.BaseSettingEnum.Open
    
    --- 整个 春节主场景 的 阴影, 强制使用 低端阴影;
    -- self._cachedPlaneShadowQuality = FuntoyRenderFeature.planeShadowQuality
    print("FuntoyRenderFeature.planeShadowQuality", FuntoyRenderFeature.planeShadowQuality)
    print("FuntoyRenderFeature.planeShadowScene", FuntoyRenderFeature.planeShadowScene)
    -- FuntoyRenderFeature.planeShadowQuality = FuntoyRenderFeature.PlaneShadowQuality.Low
    
    -- 低端阴影参数选项: Cultivate 这个选项从来没被使用过, 暂时用到这里:
    -- self._cachedPlaneShadowScene = FuntoyRenderFeature.planeShadowScene
    -- FuntoyRenderFeature.planeShadowScene = FuntoyRenderFeature.PlaneShadowScene.Cultivate


    -- ---------------------------------
    -- --- 修改主场景 点光源 Per Object Limit 
    -- xTry(function ()
    --     XGraphicSetup.SetMaxAdditionalLightsCount( 2, 4, 6, 8, 8 )
    -- end)

end


function MapDecryptionHomeView:InitCanvas()
    local worldSpaceCanvas = self._sceneInstance:GetCacheObjectByName(MapDecryptionConstants.SceneDefine.WorldSpaceCanvasName)
    ---@field worldSpaceCanvas UnityEngine.Transform
    self._worldSpaceCanvas = worldSpaceCanvas

end

--- InitBehaviorAction
---@param role UnityEngine.GameObject
function MapDecryptionHomeView:InitBehaviorAction(role)
    ---@type Engine.Lib.BehaviourAction
    local behaviorAction            = KTool.GetOrAddComponent(role, BehaviourActionType)
    behaviorAction.UpdateAction     = Bind(self, self.OnUpdateAction)
    behaviorAction.LateUpdateAction = Bind(self, self.OnLateUpdateAction)
    self._behaviorAction            = behaviorAction
end

function MapDecryptionHomeView:InitListening()
    local EventNames = MapDecryptionConstants.EventNames
    self._listeningConf = {
        [EventNames.ChangeRoleStatus]        = Bind(self, self.OnChangeRoleStatus),
        -- [EventNames.ShowBubble]              = Bind(self, self.OnShowBubble),
        -- [EventNames.HideBubble]              = Bind(self, self.OnHideBubble),
        [EventNames.RestoreBubble]           = Bind(self, self.OnRestoreBubble),
        [EventNames.RestoreNpcStatus]        = Bind(self, self.OnRestoreNpcStatus),
        [EventNames.ShowOptions]             = Bind(self, self.OnShowOptions),
        [EventNames.Gossip]                  = Bind(self, self.OnGossip),
        [EventNames.SelectGossip]            = Bind(self, self.OnEventSelectGossip),
        [EventNames.HandleFunctionEnter]     = Bind(self, self.OnHandleFunctionEnter),
        -- [EventNames.HideOptions]             = Bind(self, self.OnHideOptions),
        -- [EventNames.QuitOptions]             = Bind(self, self.OnQuitOptions),
        -- [EventNames.ChangeCameraControlMode] = Bind(self, self.OnChangeCameraControlMode),
    }

    for eventName, func in pairs(self._listeningConf) do
        Events.AddListener(eventName, func)
    end

end


---------------------------------------------------
--- init end --
---------------------------------------------------

---------------------------------------------------wwwwwwd
--- logic begin --
---------------------------------------------------

function MapDecryptionHomeView:OnUpdateAction()
    for k, v in pairs(self._interactionComps) do
        if v.Update then
            v:Update()
        end
    end

end

function MapDecryptionHomeView:OnLateUpdateAction()
    for k, v in pairs(self._interactionComps) do
        if v.LateUpdate then
            v:LateUpdate()
        end
    end

end

function MapDecryptionHomeView:ControlPlayerInputStatus(isStop)
    Events.Broadcast(MapDecryptionConstants.EventNames.ControlPlayerInputStatus, not isStop)
    -- Events.Broadcast(MapDecryptionConstants.EventNames.UpdateRoleInputStatus, not isStop)
    --- 开启用户输入
    -- ---@type PlayerInput
    -- local playerInput = self._interactionComps[InteractionComponentType.PlayerInput]
    -- if isStop then
    --     playerInput:StopInput()
    -- else
    --     playerInput:ResumeInput()
    -- end
end

function MapDecryptionHomeView:UpdateRoleInputStatus(isActive)
    Events.Broadcast(MapDecryptionConstants.EventNames.UpdateRoleInputStatus, isActive)
end

---@param mode number Constants.CameraControlMode
function MapDecryptionHomeView:ChangeCameraControlMode(mode)
    -- local cmFreeLook = self._cmFreeLook
    -- ---@type CameraInput
    -- local cameraInput = CfUtils.GetLuaScr(cmFreeLook, MapDecryptionConstants.EnvPath.CameraInput)
    -- if not isNull(cameraInput) then
    --     cameraInput:SetControlMode(mode)
    -- end
    Events.Broadcast(MapDecryptionConstants.EventNames.ChangeCameraControlMode, mode)
end

function MapDecryptionHomeView:FreshDialogueOptionsShowState(enabled)
    local canvas = self:GetDialogueOptionsCanvas()
    canvas.enabled = enabled
end

function MapDecryptionHomeView:FreshVirtualCameraShowState(isShow)
    local camera = self:GetLocationVirtualCamera()
    KTool.SetActive(camera.gameObject, isShow)
end


---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function MapDecryptionHomeView:GetLocationVirtualCamera()
    if self._locationVirtualCamera == nil then
        self._locationVirtualCamera = self:GetScenePlayerNodeSpecifyNode(MapDecryptionConstants.SceneDefine.LocationVirtualCameraPath)
        local vCameraComp = KTool.GetComponent(self._locationVirtualCamera.gameObject, typeof(CinemachineVirtualCamera))
        assert( not isNull(vCameraComp) )
        -- 设置 fov 值, 要比 mcamera 更加靠近角色
        local lens = vCameraComp.m_Lens 
        lens.FieldOfView = 27.0 
        vCameraComp.m_Lens = lens
    end
    return self._locationVirtualCamera
    
end

function MapDecryptionHomeView:GetDialogueOptionsCanvas()
    if self._dialogueOptionsCanvas == nil then
        local dialogueOptionsTrans  = self:GetScenePlayerNodeSpecifyNode(MapDecryptionConstants.SceneDefine.DialogueOptions)
        local canvas                = dialogueOptionsTrans.gameObject:GetComponent(CanvasType)
        self._dialogueOptionsCanvas = canvas
    end
    return self._dialogueOptionsCanvas
end

function MapDecryptionHomeView:GetScenePlayerNodeSpecifyNode(name)
    local SceneDefine   = MapDecryptionConstants.SceneDefine
    local trans         = self._sceneInstance:GetCacheObjectByName(SceneDefine.ScenePlayerNode).transform
    local node          = trans:Find(name)
    return node
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function MapDecryptionHomeView:OnClickBtnShopAction()
    self:SetETCJoystickShowState(false)
    UIModule.OpenDialog(
            { 
                id = Constants.UITypeIds.MapDecryptionClothesDialog, 
                parameters = {}
            }, 
            {
                {id = MapDecryptionUtils.GetDialogId(MapDecryptionUtils.DialogType.Home)}
            }
    )
end

function MapDecryptionHomeView:OnClickBtnBackAction()

    -- --- 恢复缓存的数据: 
    -- -- 1. mainCamera 的 PlaneShadow 开关
    -- -- 2. 是否使用 低端阴影
    -- -- 3. 原来使用的 低端阴影配置参数
    -- local mainCamera = URPCameraController.Instance.mainCamera
    -- local customData = KTool.GetComponent(mainCamera.gameObject, typeof(CS.CameraCustomData))
    -- assert( not isNull(customData) )
    -- customData.PlaneShadow                  = self._cachedPlaneShadowOpenType
    -- FuntoyRenderFeature.planeShadowQuality  = self._cachedPlaneShadowQuality
    -- FuntoyRenderFeature.planeShadowScene    = self._cachedPlaneShadowScene

    ---:
    -- KCookie.Set('BackToHomeScene', 1)
    -- GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome }, { { id = Constants.UITypeIds.UIHomeView } }, Constants.LoadingType.HomeScene, false)

    GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome }, { { id = Constants.UITypeIds.UIHomeView } }, Constants.LoadingType.Others, false)
end

function MapDecryptionHomeView:OnClickBtnMouseAction()
    MapDecryptionUtils.EnterPCTipsDialog(true)
end

--- OnChangeRoleStatus
---@param eventInfos table {
---@    {
    ---@    npcId： number
    ---@    eventName: string  ShowBubble || HideBubble
    ---@    vo: MapDecryptionMainSceneInteractionVo
    ---@    modelInfo: table {npcNode, npcReference, triggerNode}
---@    }
---@}
function MapDecryptionHomeView:OnChangeRoleStatus(eventInfos)
    local isShowDialogueOptions = false
    local ShowBubble = MapDecryptionConstants.EventNames.ShowBubble
    -- print("eventInfos", table.toString(eventInfos))
    for i, v in ipairs(eventInfos) do
        local eventName       = v.eventName
        local isShowBubble    = eventName == ShowBubble
        isShowDialogueOptions = isShowDialogueOptions or isShowBubble
        if isShowBubble then
            self:AddDialogue(v)
        else
            self:RemoveDialogue(v)
        end
    end

    if isShowDialogueOptions then
        self:FreshDialogueOptions(true)
    else
        self:ClearDialogueOptionsData()
        
    end

    -- local function ChangeRoleStatus()
        self:ChangeCameraControlMode(Constants.CameraControlMode.MoveMouse)
    
        --- 开启用户输入
        self:ControlPlayerInputStatus(false)
        self:SetETCJoystickShowState(true)
        
        self:SetIsOpenPCInteract(isShowDialogueOptions)
        KTool.SetActive(self.RightUpRoot.gameObject, not isShowDialogueOptions)
    -- end

    --- 如果是初始化的话
    --- 人物状态改变
    if self._isInitStatus then
        self:ResetTurn(function (npcId)
            if npcId then
                ---@type MapDecryptionRoleCollisionController
                local roleCollisionController = self._interactionComps[InteractionComponentType.RoleCollisionController]
                if roleCollisionController and roleCollisionController:GetNPCStatus(npcId) == MapDecryptionConstants.NPCStatus.Dialogue then
                    self:FreshDialogueOptionsShowState(true)
                end
            else
                self:FreshDialogueOptionsShowState(isShowDialogueOptions)
            end
        end)
        self._isInitStatus = false
    else
        -- ChangeRoleStatus()    
        self:FreshDialogueOptionsShowState(isShowDialogueOptions)
    end

    
    
    -- self:RestoreBubble()
end

function MapDecryptionHomeView:GetDialogueData()
    local DialogueOptions = self:GetDialogueOptionsCanvas()
    ---@type MapDecryptionConversationOptions
    local env = CfUtils.GetLuaScr(DialogueOptions, MapDecryptionConstants.EnvPath.ConversationOptionNodes)
    if not isNull(env) then
        return env:GetDialogueData()
    end
end

function MapDecryptionHomeView:AddDialogue(dialogueData)
    local DialogueOptions = self:GetDialogueOptionsCanvas()
    ---@type MapDecryptionConversationOptions
    local env = CfUtils.GetLuaScr(DialogueOptions, MapDecryptionConstants.EnvPath.ConversationOptionNodes)
    if not isNull(env) then
        env:AddDialogue(dialogueData)
    end
end

function MapDecryptionHomeView:RemoveDialogue(dialogueData)
    local DialogueOptions = self:GetDialogueOptionsCanvas()
    ---@type MapDecryptionConversationOptions
    local env = CfUtils.GetLuaScr(DialogueOptions, MapDecryptionConstants.EnvPath.ConversationOptionNodes)
    if not isNull(env) then
        env:RemoveDialogue(dialogueData)
    end
end


function MapDecryptionHomeView:OnRestoreNpcStatus()
    --- 关闭虚拟相机
    self:FreshVirtualCameraShowState(false)

    ---@type MapDecryptionRoleCollisionController
    local roleCollisionController = self._interactionComps[InteractionComponentType.RoleCollisionController]
    roleCollisionController:RestoreNpcStatus()

end

function MapDecryptionHomeView:ResetTurn(turnComplete, isSkip)
    local dialogueData = self:GetDialogueData()
    if dialogueData then
        local npcId = dialogueData.npcId
        ---@type MapDecryptionRoleCollisionController
        local roleCollisionController = self._interactionComps[InteractionComponentType.RoleCollisionController]
        if roleCollisionController and roleCollisionController:GetNPCStatus(npcId) == MapDecryptionConstants.NPCStatus.Dialogue then
            local isTurn = roleCollisionController:CheckNpcIsTurn(npcId)
            if isTurn then
                roleCollisionController:ResetTurn(npcId, turnComplete)
            elseif turnComplete then
                turnComplete(npcId)       
            end
        elseif turnComplete then
            turnComplete(npcId)        
        end
    elseif turnComplete then
        turnComplete()
    end

end

function MapDecryptionHomeView:OnRestoreBubble()
    UICommonUtils.BlockerAndStartCo("MapDecryptionHomeView.OnRestoreBubble", function() 
        --- 关闭虚拟相机
        self:FreshVirtualCameraShowState(false)
        
        UICommonUtils.WaitBrainBlendingComplete()
        self:SetIsOpenPCInteract(true)
        self:SetETCJoystickShowState(true)
    
        --- 开启用户输入
        self:ControlPlayerInputStatus(false)
        self:ChangeCameraControlMode(Constants.CameraControlMode.MoveMouse)
     
        ---@type MapDecryptionRoleCollisionController
        local roleCollisionController = self._interactionComps[InteractionComponentType.RoleCollisionController]
        roleCollisionController:SetIsDisableStatusUpdate(false)
    
        self:ResetTurn(function (npcId)
            if  npcId 
                and roleCollisionController 
                and roleCollisionController:GetNPCStatus(npcId) == MapDecryptionConstants.NPCStatus.Dialogue then
    
                self:RestoreBubble()
                
            end
            
        end)
    end)
    
end

--- RestoreBubble
function MapDecryptionHomeView:RestoreBubble()
    local DialogueOptions = self:GetDialogueOptionsCanvas()
    ---@type MapDecryptionConversationOptions
    local env = CfUtils.GetLuaScr(DialogueOptions, MapDecryptionConstants.EnvPath.ConversationOptionNodes)
    if not isNull(env) then
        env:FreshUIShowState(true)
    end
    self:FreshDialogueOptionsShowState(true)
    
end

--- OnShowOptions
--@param optionData   {
    ---@    npcId： number
    ---@    eventName: string  ShowBubble || HideBubble
    ---@    vo: MapDecryptionMainSceneInteractionVo
---@    }
function MapDecryptionHomeView:OnShowOptions(optionData)
    self._optionData = optionData
    UIRaycastBlocker:AddCondition("MapDecryptionHomeView.OnShowOptions")

    self:SetIsOpenPCInteract(false)
    self:SetETCJoystickShowState(false)
    --- 停止用户输入
    self:ControlPlayerInputStatus(true)
    self:ChangeCameraControlMode(Constants.CameraControlMode.DragMouse)
    ---@type MapDecryptionRoleCollisionController
    local roleCollisionController = self._interactionComps[InteractionComponentType.RoleCollisionController]
    roleCollisionController:SetIsDisableStatusUpdate(true)

    cs_coroutine.start(function ()
        UIRaycastBlocker:RemoveCondition("MapDecryptionHomeView.OnShowOptions")
        
        local npcId = optionData.npcId
        ---@type table {npcNode, npcReference, triggerNode}
        local npcModelInfo = roleCollisionController:GetNpcModelInfo(npcId)
        local npcNode, npcReference = SafeUnpack(npcModelInfo)
        -- optionData[]
        --- 设置虚拟相机参数 并 开启虚拟相机
        self:Location(npcReference)
        
        self:FreshVirtualCameraShowState(true)

        self:FreshDialogueOptionsShowState(false)
        self._talkNode.enabled = true
        self:Talking(MapDecryptionUtils.InitTalkDataByInteractVo(optionData.vo, MapDecryptionConstants.TalkSceneType.ClickBubble, npcNode))  
        yield_return(WaitScends)
        self._talkNode.enabled = false
        
        --- 显示对话选项
        self:FreshDialogueOptions(false)
        self:FreshDialogueOptionsShowState(true)
        -- self:FreshVirtualCameraShowState(false)
    end)


end

--- Location
---@param npcNode UnityEngine.Transform
function MapDecryptionHomeView:Location(npcTarget)

    local mainCamera     = URPCameraController.Instance.mainCamera
    local transform      = mainCamera.transform
    local cameraPos      = transform.position
    --local protagonist    = self._protagonistTarget
    local protagonist    = self._protagonistCenter -- 不要瞄准 "NPCLookAtTarget", 因为这个点会被调整
    local protagonistPos = protagonist.position
    local npcPos         = npcTarget.position
    
    --- 向量 相机_主角
    local camera2role = Vector3(protagonistPos.x - cameraPos.x, 0.0, protagonistPos.z - cameraPos.z)
    --- 向量 主角_NPC
    local role2npc    = Vector3(npcPos.x - protagonistPos.x, 0.0, npcPos.z - protagonistPos.z)

    -- angle: [0,180]
    -- clockwise: c位于右侧为 1, 位于左侧为 -1
    local angle, clockwise   = MapDecryptionUtils.CalcAngleAndClockwiseByVector(camera2role, role2npc)

    local virtualCamera = self:GetLocationVirtualCamera() -- "LocationVirtualCamera"

    -- 夹角小于 angleThreshold 时, 需要将夹角扩大到 tgtThreshold:
    local angleThreshold = 30.0 
    local tgtThreshold = 35.0

    local centerPos = (npcPos + protagonistPos) * 0.5
    local vecLen = (centerPos - cameraPos).magnitude -- 保持向量长度
    local tgtPos = cameraPos

    if  ( angle <= angleThreshold and clockwise > 0.0 ) or 
        ( angle >= (180.0-angleThreshold) and clockwise < 0.0 )
    then 
        --printInfo("逆时针旋A")
        local rot = Quaternion.Euler( 0.0, -tgtThreshold, 0.0 )
        local newvec = rot * (-1.0 * clockwise * role2npc.normalized)
        tgtPos = centerPos + newvec * vecLen
    elseif  
        ( angle <= angleThreshold and clockwise < 0.0 ) or
        ( angle >= (180.0-angleThreshold) and clockwise > 0.0 )
    then 
        --printInfo("顺时针旋B")
        local rot = Quaternion.Euler( 0.0, tgtThreshold, 0.0 )
        local newvec = rot * (clockwise * role2npc.normalized)
        tgtPos = centerPos + newvec * vecLen
    end

    tgtPos.y = cameraPos.y -- 保持相机高度
    virtualCamera.position = tgtPos

    virtualCamera:LookAt( centerPos )
    ---:
end



function MapDecryptionHomeView:Talking(talkData)
    ---@type TalkingNode
    local env = self._talkEnv
    if isNull(env) then return end
    env:FreshUI(talkData)

    while not env:IsFinish() do
        yield_return()
    end

end

function MapDecryptionHomeView:IsCanPlayNextTalk()
    if isNull(self._talkEnv) then
        return true
    end
    return self._talkEnv:IsCanPlayNext()
end

function MapDecryptionHomeView:SetTalkingEnd(isEnd)
    if not isNull(self._talkEnv) then
        self._talkEnv:SetIsEnd(isEnd)
    end
end

function MapDecryptionHomeView:GetTalkingEnd()
    if isNull(self._talkEnv) then
        return true
    end
    return self._talkEnv:GetIsEnd()
end

function MapDecryptionHomeView:OnHideOptions()
    -- self:FreshDialogueOptionsShowState(false)
    -- self:ChangeCameraControlMode(Constants.CameraControlMode.None)
    -- ---@type MapDecryptionPCController
    -- local pcController = self._interactionComps[InteractionComponentType.PcController]
    -- if pcController then
    --     pcController:SetIsOpenInteract(false)
    -- end


end

--- FreshDialogueOptions
---@param isShowDialogue boolean
function MapDecryptionHomeView:FreshDialogueOptions(isShowDialogue)
    local DialogueOptions = self:GetDialogueOptionsCanvas()
    ---@type MapDecryptionConversationOptions
    local env = CfUtils.GetLuaScr(DialogueOptions, MapDecryptionConstants.EnvPath.ConversationOptionNodes)
    if not isNull(env) then
        env:FreshUI(isShowDialogue)
    end
    
end

--- FreshGossipOptions
function MapDecryptionHomeView:FreshGossipOptions(choices)
    local DialogueOptions = self:GetDialogueOptionsCanvas()
    ---@type MapDecryptionConversationOptions
    local env = CfUtils.GetLuaScr(DialogueOptions, MapDecryptionConstants.EnvPath.ConversationOptionNodes)
    if not isNull(env) then
        env:FreshGossipOptions(choices)
    end
    
end

function MapDecryptionHomeView:ClearDialogueOptionsData()
    local DialogueOptions = self:GetDialogueOptionsCanvas()
    ---@type MapDecryptionConversationOptions
    local env = CfUtils.GetLuaScr(DialogueOptions, MapDecryptionConstants.EnvPath.ConversationOptionNodes)
    if not isNull(env) then
        env:ClearCache()
    end

end

function MapDecryptionHomeView:SetIsOpenPCInteract(isOpenInteract)
    ---@type MapDecryptionPCController
    local pcController = self._interactionComps[InteractionComponentType.PcController]
    if pcController then
        pcController:SetIsOpenInteract(isOpenInteract)
    end
end

function MapDecryptionHomeView:SetETCJoystickShowState(isActive)
    if isNull(self._etcJoystick) then
        return
    end
    if isActive then
        self._etcJoystick:Active()
    else
        self._etcJoystick:Deactive()
    end
end

--- OnChangeCameraControlMode
---@param mode number Constants.CameraControlMode
function MapDecryptionHomeView:OnChangeCameraControlMode(mode)
    self:ChangeCameraControlMode(mode)
    
end

--- OnGossip
--- 闲聊
function MapDecryptionHomeView:OnGossip()
    UIRaycastBlocker:AddCondition("MapDecryptionHomeView.OnGossip")
    cs_coroutine.start(function ()
        UIRaycastBlocker:RemoveCondition("MapDecryptionHomeView.OnGossip")
        local optionData = self._optionData

        ---@type MapDecryptionComponent
        local component = MapDecryptionMgr:GetComponent()
        ---@type MapDecryptionDojo
        local dojo = component:GetMapDecryptionDojo()
        local npcId = optionData.npcId
        ---@type MapDecryptionRoleCollisionController
        local roleCollisionController = self._interactionComps[InteractionComponentType.RoleCollisionController]
        ---@type table {npcNode, npcReference, triggerNode}
        local npcModelInfo = roleCollisionController:GetNpcModelInfo(npcId)
        local npcNode = SafeUnpack(npcModelInfo)
        self._talkNode.enabled = true
        self:FreshDialogueOptionsShowState(false)

        local co = cs_coroutine.start(function ()
            self:SetTalkingEnd(false)
            ---@type MapDecryptionMainSceneInteractionVo
            local mainSceneInteractionVo = optionData.vo
            local gossipData = MapDecryptionUtils.InitGossipData(dojo.talk, npcId, optionData.vo, npcNode)
            while not gossipData.isEnd do
                self:Talking(gossipData)
                
                while not self:IsCanPlayNextTalk() do
                    yield_return()
                end

                ---@type MapDecryptionGossipPlotVo[]
                local gossipPlotVos = gossipData.gossipPlotVos
                local index         = gossipData.index
                ---@type MapDecryptionGossipPlotVo
                local gossipPlotVo  = gossipPlotVos[index]
                local choices     = gossipPlotVo.choices
                local isShowGossipOptions = next(choices) ~= nil
                if isShowGossipOptions then
                    self:FreshGossipOptions(choices)
                    self._gossipsIndex = index
                else
                    self._gossipsIndex = gossipPlotVo.jumpId
                end
                while self._gossipsIndex == index do
                    yield_return()
                end

                gossipData = MapDecryptionUtils.InitTalkDataByIndex(self._gossipsIndex, gossipPlotVos, mainSceneInteractionVo, npcNode)
            end
            self:Talking(gossipData)
            while not self:IsCanPlayNextTalk() do
                yield_return()
            end
            self:SetTalkingEnd(true)
        end)

        while not self:GetTalkingEnd() do
            yield_return()
        end
        cs_coroutine.stop(co)
        self:SetTalkingEnd(false)
        self._gossipsIndex     = nil
        --- 显示对话选项
        self._talkNode.enabled = false
        self:OnRestoreBubble()
        

    end)

end

function MapDecryptionHomeView:OnEventSelectGossip(gossipsIndex)
    self._gossipsIndex = gossipsIndex
end

--- OnHandleFunctionEnter
---@param vo MapDecryptionFunctionEnterVo
---@param enterType MapDecryptionConstants.FunctionEnterType 1探索、2追踪、3古物修复、4新年转盘、5新年商店，6闲聊、7返回
---@param params table
---@param excludeDialogs table 互斥界面列表
function MapDecryptionHomeView:OnHandleFunctionEnter(vo, enterType, params, excludeDialogs)
    local interactType = vo.scene
    if interactType <= 0 then
        MapDecryptionUtils.PopDialogByEnterType(enterType, params, excludeDialogs)
        return
    end

    local dialogueData = params.dialogueData
    local npcId     = dialogueData.npcId
    ---@type MapDecryptionMainSceneInteractionVo
    local vo        = dialogueData.vo
    ---@type MapDecryptionRoleCollisionController
    local roleCollisionController = self._interactionComps[InteractionComponentType.RoleCollisionController]
    ---@type table {npcNode, npcReference, triggerNode}
    local npcModelInfo = roleCollisionController:GetNpcModelInfo(npcId)
    local npcNode = SafeUnpack(npcModelInfo)

    local talkData = MapDecryptionUtils.InitTalkDataByInteractVo(vo, interactType, npcNode)
    UIRaycastBlocker:AddCondition("MapDecryptionHomeView.OnHandleFunctionEnter")
    cs_coroutine.start(function ()
        UIRaycastBlocker:RemoveCondition("MapDecryptionHomeView.OnHandleFunctionEnter")
        self:FreshDialogueOptionsShowState(false)
        self._talkNode.enabled = true
        self:Talking(talkData)  
        yield_return(WaitScends)
        self._talkNode.enabled = false
        MapDecryptionUtils.PopDialogByEnterType(enterType, params, excludeDialogs)
    end)

    -- print(table.toString(params))
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------

---------------------------------------------------
--- clear begin --
---------------------------------------------------

function MapDecryptionHomeView:Clear()
    for eventName, func in pairs(self._listeningConf) do
        Events.RemoveListener(eventName, func)
    end
    
    if not isNull(self._behaviorAction) then
        self._behaviorAction.UpdateAction     = nil
        self._behaviorAction.LateUpdateAction = nil
    end 

    --- 清理交互相关的组件
    for k, v in pairs(self._interactionComps) do
        v:Delete()
    end

    --- 清理控制相关的组件
    for k, v in pairs(self._controllerComps) do
        v:Delete()
    end

    if not isNull(self.DialogueOptionsCo) then
        cs_coroutine.stop(self.DialogueOptionsCo)
    end

end


---------------------------------------------------
--- clear end --
---------------------------------------------------

return MapDecryptionHomeView
