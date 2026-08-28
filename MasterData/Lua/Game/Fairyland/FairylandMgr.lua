---
--- 乱流幻境单例管理器
--- Author: dawanfan
--- Date: 2024-1-9 11:13:36
---


local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require "XLua.cs_coroutine"
local Yielders = CS.Engine.Lib.Yielders
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")
local PlayerLoader = import('Game.DreamSpace.CharacterController.PlayerLoader')
local GlobalsInDreamSpace = CS.DreamSpace.GlobalsInDreamSpace
local URPCameraController = CS.Game.Native.URP.URPCameraController
local CursorLockMode = CS.UnityEngine.CursorLockMode
local Cursor = CS.UnityEngine.Cursor

---@type FairylandComponent
local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
local FairylandUtils = import("Game.Fairyland.FairylandUtils")
---@type DreamSpaceStates
local DreamSpaceStates = import('Game.DreamSpace.Tools.DreamSpaceStates')
local KeyboardInfo = DreamSpaceStates.KeyboardInfo
local KeyboardInputMap = import("Game.DreamSpace.CharacterController.KeyboardInputMap")

local RoleControllerLoader = import('Game.DreamSpace.CharacterController.RoleControllerLoader')
local InputManager = import('Game.DreamSpace.CharacterController.InputManager')

local CriWareUtils = import('Game.Entry.CriWareUtilsFix')


---@type FairylandMgr
local instance = nil

--- from:  > name: Manager
---@class FairylandMgr
---@field Env                           	FairylandMgr                            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Balls                         	UnityEngine.Transform                   	@ 0    
---@field Mirror                        	UnityEngine.Transform                   	@ 1    
---@field PathFinder                    	UnityEngine.Transform                   	@ 2    
---@field LevelSettlementVM             	Cinemachine.CinemachineVirtualCamera    	@ 3    
---@field WorldSpaceCanvas              	UnityEngine.RectTransform               	@ 4    
---@field PlayerInitTransform           	UnityEngine.Transform                   	@ 5    
local FairylandMgr = Class("FairylandMgr")

function FairylandMgr:__init()
    self.ballScrs = {}
    self.ballNodeScrs = {}
    self.nodeInit = false
end

function FairylandMgr:__delete()
    self.ballScrs = {}
    self.ballNodeScrs = {}
    self.nodeInit = true
end

function FairylandMgr:Awake()
    if instance == nil then 
        instance = self
        FairylandUtils.CurrentNearIndex = 0
    else
        assert( false, "不允许存在 第二个 FairylandMgr 实例" )
    end

    self.globalsInDreamSpace = GlobalsInDreamSpace.Instance.gameObject
    DreamSpaceStates.InitInputLock()


    local questId = checkTable(UIModule.CurrentScreen.Argument.parameters).questId
    if questId ~= nil then
        FairylandUtils.CurrentEnterQuestId = questId
    end

    if not FairylandComponent.dojo:IsQuestFinished(FairylandUtils.CurrentEnterQuestId) then
        self.__OnCreateNodeUI = Bind(self, self.CreateNodeUI)
        self.__OnFairylandLevelDetailDialogLoad = Bind(self, self.OnFairylandLevelDetailDialogLoad)
        Events.AddListener(Constants.EventNames.FairylandSceneDialogLoad, self.__OnCreateNodeUI)
        Events.AddListener(Constants.EventNames.FairylandLevelDetailDialogLoad, self.__OnFairylandLevelDetailDialogLoad)
    end

    self.co = cs_coroutine.start(function ()
        CriWareUtils.StopAll()

        local canvas = KTool.GetComponent(self.WorldSpaceCanvas.gameObject, typeof(CS.UnityEngine.Canvas))
        canvas.worldCamera = URPCameraController.Instance.mainCamera

        cs_coroutine.yield_return(self:InitCat())

        -- init ball
        for i = 1, 5 do
            local ball = self.Balls.transform:Find(string.format("QuestBall%s", i))
            if ball then
                local ballScr = CfUtils.GetLuaScr(ball, "Game.Fairyland.FairylandBall")
                if ballScr then
                    self.ballScrs[i] = ballScr
                    cs_coroutine.yield_return(self.ballScrs[i]:Init(i))
                end
            end
        end

        local mirrorScr = CfUtils.GetLuaScr(self.Mirror, "Game.Fairyland.FairylandMirror")
        if mirrorScr then
            self.ballScrs[ConstantsFairyland.SelectNodeIndex.Mirror] = mirrorScr
            cs_coroutine.yield_return(self.ballScrs[ConstantsFairyland.SelectNodeIndex.Mirror]:Init(ConstantsFairyland.SelectNodeIndex.Mirror))
        end

        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(2))
        cs_coroutine.yield_return(self:PlayLevelSettlement())

        cs_coroutine.yield_return(UIModule.OpenDialog({id=Constants.UITypeIds.FairylandSceneDialog}, {id=Constants.UITypeIds.FairylandLevelDetailsDialog}))
        
        CriWareUtils.PlayMusicById("bgm_teamfight_secretarea_inter")

        local UINavigationBarRoot = CS.UINavigationBarRoot
        UINavigationBarRoot.Instance:SetActive(true)
    end)
   
    self.PathFinderScr = CfUtils.GetLuaScr(self.PathFinder, "Game.DreamSpace.AutoWalk.PathFinder")
    assert(self.PathFinderScr)
end

function FairylandMgr:InitCat()

    InputManager.Init() -- 重置, 必须在 装配 角色控制器 之前!!!  否则角色的初始朝向会被 InputManager 里的残余值修改;

    -- 正式装配 角色控制器:
    cs_coroutine.yield_return( RoleControllerLoader.AssembleRole({
        switchablePlayerPrefabPath  = "DreamSpace/Gameplay/SwitchablePlayeForLua.prefab",
        humanPrefabPath             = "Arts/Prefab_human/103008_human.prefab",
        ---
        initPos = self.PlayerInitTransform.position,
        initRoleDir = self.PlayerInitTransform.forward,
        initLookDir = self.PlayerInitTransform.forward,
        initHumanScale = self.PlayerInitTransform.localScale,
        humanCapsuleRadius = 0.5,
        isCat = true, 
        isUseManualViwRotateInPCMode = true,
        isIgnoreJumpHint = true,
        isIgnoreHuman180TurnBack = true,
        isUsePiecesCollector = false,
    }))
    ---
    RoleControllerLoader.ClearLoaders() 

    -- 设置相机参数
    local vCam3rdPersonFollowComp = GlobalsInDreamSpace.FindComponent("vcam3rdPersonFollow")
    local lens = vCam3rdPersonFollowComp.m_Lens
    lens.FarClipPlane = 3000
    vCam3rdPersonFollowComp.m_Lens = lens
end

function FairylandMgr:OnDestroy()
    CriWareUtils.StopAll()
    if self.co then
        cs_coroutine.stop(self.co)
    end
    Events.RemoveListener(Constants.EventNames.FairylandSceneDialogLoad, self.__OnCreateNodeUI)
    Events.RemoveListener(Constants.EventNames.FairylandLevelDetailDialogLoad, self.__OnFairylandLevelDetailDialogLoad)

    local keyboardInputMap = KeyboardInputMap:GetInstance()
    keyboardInputMap:UnRegisterInput(KeyboardInfo.PcTipsKey)

    if not isNull(self.canvasManager) and not isNull(self.canvasManager.gameObject) then
        CS.UnityEngine.Object.Destroy( self.canvasManager.gameObject )
    end

    if not isNull(self.globalsInDreamSpace) and not isNull(self.globalsInDreamSpace.gameObject) then
        CS.UnityEngine.Object.Destroy( self.globalsInDreamSpace.gameObject )
    end

    for _, ballScr in pairs(self.ballScrs) do
        CS.UnityEngine.GameObject.Destroy(ballScr.controller.gameObject)
    end

    instance = nil
    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
end

function FairylandMgr:CreateNodeUI()

    CfUtils.SetActive(self.WorldSpaceCanvas.gameObject, true)

    local fairylandSceneDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.FairylandSceneDialog)
    assert(fairylandSceneDialog, "[FairylandMgr][CreateNodeUI] FairylandSceneDialog not found")

    -- init ball
    for _, ballScr in pairs(self.ballScrs) do
        ballScr:Reset()
        -- if not self.nodeInit then
            self.ballNodeScrs[ballScr.index] = fairylandSceneDialog.Env:InitBallNode(ballScr.index, ballScr)
        -- else
        --     fairylandSceneDialog.Env.selectNodeScrs[ballScr.index] = self.ballNodeScrs[ballScr.index]
        -- end
    end

    -- self.nodeInit = true
    Cursor.lockState = CursorLockMode.None
end

function FairylandMgr:OnFairylandLevelDetailDialogLoad(index)
    if self.ballScrs[index] == nil then
        return
    end

    CfUtils.SetActive(self.WorldSpaceCanvas.gameObject, false)

    local fairylandLevelDetailsDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.FairylandLevelDetailsDialog)
    assert(fairylandLevelDetailsDialog, "[FairylandMgr][OnFairylandLevelDetailDialogLoad] FairylandLevelDetailsDialog not found")

    fairylandLevelDetailsDialog.Env:InitDynamicNode(self.ballScrs[index])

    -- 打开关卡详情界面时，停止自动寻路
    self.PathFinderScr:StopWalking()
end

---@return FairylandMgr
function FairylandMgr.GetInstance()
    return instance
end

function FairylandMgr:GoToPosition(index, maxDistance, stopCallback)
    if IsNull(index) then
        printError("[FairylandMgr][GoToPosition] param index is nil")
        return
    end

    local ballScr = self.ballScrs[index]

    if IsNull(ballScr) then
        printError(string.format("[FairylandMgr][GotoPosition] ballScr is nil, index: %s", index))
        return
    end

    self.PathFinderScr:MoveTo(ballScr:GetAutoMovePosition(), maxDistance, stopCallback)
end

function FairylandMgr:WalkAroundBall(index)
    if IsNull(index) then
        printError("[FairylandMgr][WalkAroundBall] param index is nil")
        return
    end

    local ballScr = self.ballScrs[index]

    if IsNull(ballScr) then
        printError(string.format("[FairylandMgr][WalkAroundBall] ballScr is nil, index: %s", index))
        return
    end

    self.PathFinderScr:WalkAround(ballScr:GetAutoMovePosition(), 1, 0.5)
end

function FairylandMgr:CheckNeedMoveToPosition(index, maxDistance)
    local ballScr = self.ballScrs[index]
    if ballScr == nil then
        return
    end

    local targetPosition = ballScr:GetAutoMovePosition()
    local distance = (self.PathFinderScr:GetRolePos() - targetPosition).magnitude

    return distance > maxDistance
end

function FairylandMgr:PlayLevelSettlement()
    if not FairylandUtils.PlayLevelSettlement then
        return
    end

    DreamSpaceStates.LockInput_ByCount(DreamSpaceStates.InputLockState.Lock)
    DreamSpaceStates.LockViewRotate_ByFlag(DreamSpaceStates.InputLockState.Lock)

    self.LevelSettlementVM.Priority = 105

    print("start play settlement")

    local ballScr = self.ballScrs[FairylandUtils.LastCombatIndex]
    ballScr.Animator.enabled = true
    cs_coroutine.yield_return()
    cs_coroutine.yield_return(CfUtils.WaitPlayAnimatorTo(ballScr.BallLocation, string.format("QuestBall%s_run", FairylandUtils.LastCombatIndex)))

    local color = FairylandUtils.GetBallColor(FairylandUtils.LastLevelId)
    local mirrorScr = self.ballScrs[ConstantsFairyland.SelectNodeIndex.Mirror]
    local go = mirrorScr[string.format("FX%s", color)]
    CfUtils.SetActive(go, true)

    cs_coroutine.yield_return(ballScr:ChangeToNewBall())
    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))

    self.LevelSettlementVM.Priority = 0

    cs_coroutine.yield_return(mirrorScr:PlayMirrorLevelSettlement())

    FairylandUtils.ResetLevelCache()

    DreamSpaceStates.LockInput_ByCount(DreamSpaceStates.InputLockState.Unlock)
    DreamSpaceStates.LockViewRotate_ByFlag(DreamSpaceStates.InputLockState.Unlock)
end

return FairylandMgr
