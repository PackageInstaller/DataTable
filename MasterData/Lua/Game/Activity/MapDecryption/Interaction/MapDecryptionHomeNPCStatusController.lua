------------ import ------------
local support = require 'Frame.support'
local NPCKinematicsController = import("Game.Activity.MapDecryption.Interaction.MapDecryptionHomeNPCKinematicsController")
local cs_coroutine     = require "XLua.cs_coroutine"
local Quaternion = CS.UnityEngine.Quaternion
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------
local isNull  = isNull
local Vector3 = Vector3
local SphereColliderType   = typeof(CS.UnityEngine.SphereCollider)
------------ define ------------


---@class MapDecryptionHomeNPCStatusController
local MapDecryptionHomeNPCStatusController = Class('MapDecryptionHomeNPCStatusController')


function MapDecryptionHomeNPCStatusController:__init()
    self._npcNode      = nil
    self._npcReference = nil
    self._radius       = nil
    self._status       = MapDecryptionConstants.NPCStatus.Normal
end


function MapDecryptionHomeNPCStatusController:__delete()
    self._IKController:Delete()
    if not isNull(self._co) then
        cs_coroutine.stop(self._co)
    end
    self:RemoveListener()
    if not isNull(self._bubbleGo) then
        KTool.SafeDelete(self._bubbleGo)
    end
end


--- Init
---@param mainSceneInteractionVo    MapDecryptionMainSceneInteractionVo
---@param npcNode                   UnityEngine.Transform
---@param npcReference              UnityEngine.Transform
---@param triggerNode               UnityEngine.Transform
---@param uiParent                  UnityEngine.GameObject
---@param camera                    UnityEngine.Camera
---@param role                      UnityEngine.Transform
function MapDecryptionHomeNPCStatusController:Init(mainSceneInteractionVo, npcNode, npcReference, triggerNode, uiParent, camera, role)
    self._mainSceneInteractionVo = mainSceneInteractionVo
    self._npcNode                = npcNode
    self._npcReference           = npcReference
    self._triggerNode            = triggerNode
    self._camera                 = camera
    self._role                   = role

    ---@type MapDecryptionHomeNPCKinematicsController
    self._IKController = NPCKinematicsController.New()
    self._IKController:Init(npcNode, npcReference, role, mainSceneInteractionVo)

    ---@type UnityEngine.SphereCollider
    local collider = triggerNode.gameObject:GetComponent(SphereColliderType)
    self._collider = collider
    self._radius   = collider.radius

    self.__EventCreateBubbleSuccess = Events.AddListener(MapDecryptionConstants.EventNames.CreateBubbleSuccess, Bind(self, self.OnEventCreateBubbleSuccess))
    
    self._co = MapDecryptionUtils.CreateBubbleNode(uiParent, mainSceneInteractionVo.id)

    self._isInitComplete = true
end

-- function MapDecryptionHomeNPCStatusController:Update()
    
-- end

function MapDecryptionHomeNPCStatusController:LateUpdate(isMove)
    if not self._isInitComplete then
        return
    end
    if isNull(self._bubbleGo) then
        return
    end
    if isMove then
        self._IKController:LateUpdate(self:GetStatus())
    end

    local isVisible = UICommonUtils.IsObjectVisible(self._camera, self._collider.bounds)
    GameUtils.UpdateUIShowState(self._bubbleGo, isVisible)
    if isVisible then
        self:FreshBubbleNodePosition()
    end

    self:FadeInAndOutBubbleNode()
    
    -- self._IKController:SetLookAtStatus()
end

function MapDecryptionHomeNPCStatusController:HandleStatusChange(status, oldStatus, isForce)
    -- print("status", status)
    -- Events.
    self:SetStatus(status)

    self:FreshBubbleNodeStatus(status)

    if isForce then
        self._IKController:LateUpdate(self:GetStatus())
    end

    ---@warn: 如果出现在地图上随意行走的人 这里需要修改
    local MapDecryptionConstants = MapDecryptionConstants
    local eventName
    local Dialogue = MapDecryptionConstants.NPCStatus.Dialogue
    if status == Dialogue and (oldStatus ~= Dialogue or isForce) then
        eventName = MapDecryptionConstants.EventNames.ShowBubble
        -- Events.Broadcast(MapDecryptionConstants.EventNames.ShowBubble, self._mainSceneInteractionVo, self._npcReference, self._npcNode)
    elseif status ~= Dialogue and oldStatus == Dialogue then
        eventName = MapDecryptionConstants.EventNames.HideBubble
        -- Events.Broadcast(MapDecryptionConstants.EventNames.HideBubble, self._mainSceneInteractionVo)
    end

    -- local trans = status >= MapDecryptionConstants.NPCStatus.LookUpFace and playerNode or nil
    -- self._IKController:SetLookAtTarget(trans)
    
    return eventName
end 

-- function MapDecryptionHomeNPCStatusController:SetProtagonistLookAt(isClear)
--     self._IKController:SetProtagonistLookAt(isClear)
-- end

function MapDecryptionHomeNPCStatusController:FreshBubbleNodeStatus(status)
    local node = self._bubbleGo
    if isNull(node) then return end

    local MapDecryptionConstants = MapDecryptionConstants
    ---@type MapDecryptionRoleDialogueBubble
    local env = CfUtils.GetLuaScr(node, MapDecryptionConstants.EnvPath.BubbleNode)
    if not isNull(env) then
        --env:FreshRoleInfoShowState(status > MapDecryptionConstants.NPCStatus.Normal)
        env:FreshBubbleShowState(status == MapDecryptionConstants.NPCStatus.Dialogue)
    end
end


-- bubble node 淡入淡出效果
function MapDecryptionHomeNPCStatusController:FadeInAndOutBubbleNode()

    local node = self._bubbleGo
    if isNull(node) then return end

    local MapDecryptionConstants = MapDecryptionConstants
    ---@type MapDecryptionRoleDialogueBubble
    local env = CfUtils.GetLuaScr(node, MapDecryptionConstants.EnvPath.BubbleNode)
    if not isNull(env) then
        env:FadeInAndOut(self._status > MapDecryptionConstants.NPCStatus.Normal)
    end
end

function MapDecryptionHomeNPCStatusController:GetRadius()
    ---todo 方便测试 待移除
    -- return self._collider.radius
    return self._radius
end

function MapDecryptionHomeNPCStatusController:GetStatus()
    return self._status
end
function MapDecryptionHomeNPCStatusController:SetStatus(status)
    self._status = status
end


function MapDecryptionHomeNPCStatusController:GetAngle()
    return self._IKController:GetAngle()
end

function MapDecryptionHomeNPCStatusController:OnEventCreateBubbleSuccess(npcId, go)
    local mainSceneInteractionVo = self._mainSceneInteractionVo
    if self._mainSceneInteractionVo.id ~= npcId then
        return
    end
    -- print("OnEventCreateBubbleSuccess")
    -- self:RemoveListener()
    self._bubbleGo = go
    self:FreshBubbleNodePosition()

    local status = self._status
    local MapDecryptionConstants = MapDecryptionConstants
    ---@type MapDecryptionRoleDialogueBubble
    local env = CfUtils.GetLuaScr(go, MapDecryptionConstants.EnvPath.BubbleNode)
    if not isNull(env) then
        env:InitUI(mainSceneInteractionVo)
        --env:FreshRoleInfoShowState(status > MapDecryptionConstants.NPCStatus.Normal)
        env:FreshBubbleShowState(status == MapDecryptionConstants.NPCStatus.Dialogue)
    end
    
end

function MapDecryptionHomeNPCStatusController:FreshBubbleNodePosition()    
    -- local npcNode = self._npcNode
    local target  = self._npcReference

    local bubbleTrans = self._bubbleGo.transform
    local position = target.position
    position.y = position.y + 0.7
    local isChange = Vector3.Distance(bubbleTrans.position, position) > 0.001
    if isChange then
        bubbleTrans.position = position

        local fwd = self._role.forward
        local transform = self._bubbleGo.transform
        transform.localRotation = Quaternion.LookRotation(fwd)
    end


    -- 让 ui元素始终朝向 mainCamera
    local mainCamera = CS.Game.Native.URP.URPCameraController.Instance.mainCamera
    local lookAtPos = bubbleTrans.position + mainCamera.transform.rotation * Vector3.unity_vector3.back
    local worldUpDir = mainCamera.transform.rotation * Vector3.unity_vector3.up
    bubbleTrans:LookAt( lookAtPos, worldUpDir )
    bubbleTrans:Rotate( 0.0, 180.0, 0.0 )

    return isChange
end

function MapDecryptionHomeNPCStatusController:FreshBubbleNodeShowState()
    local node = self._bubbleGo
    if isNull(node) then return  end

    local MapDecryptionConstants = MapDecryptionConstants
    ---@type MapDecryptionRoleDialogueBubble
    local env = CfUtils.GetLuaScr(node, MapDecryptionConstants.EnvPath.BubbleNode)
    if not isNull(env) then
        env:FreshBubbleShowState(self._status == MapDecryptionConstants.NPCStatus.Dialogue)
    end

end

function MapDecryptionHomeNPCStatusController:RemoveListener()
    if self.__EventCreateBubbleSuccess then
        Events.RemoveListener(MapDecryptionConstants.EventNames.CreateBubbleSuccess, self.__EventCreateBubbleSuccess)
        self.__EventCreateBubbleSuccess = nil
    end

end

function MapDecryptionHomeNPCStatusController:ResetTurn(turnComplete)
    return self._IKController:ResetTurn(turnComplete)
end

function MapDecryptionHomeNPCStatusController:CheckNpcIsTurn()
    return self._IKController:CheckNpcIsTurn()
end

return MapDecryptionHomeNPCStatusController
