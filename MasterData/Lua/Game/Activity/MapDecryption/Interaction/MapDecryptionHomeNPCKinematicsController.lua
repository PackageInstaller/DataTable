------------ import ------------
------------ import ------------

------------ define ------------
local isNull = isNull
local Quaternion = Quaternion
-- local Vector2 = Vector2
-- local Math = CS.System.Math

-- local Time = CS.UnityEngine.Time
-- local Mathf = CS.UnityEngine.Mathf
-- local Vector3 = CS.UnityEngine.Vector3

-- local Debug = CS.UnityEngine.Debug
-- local Color = CS.UnityEngine.Color

local LookAtControllerType = typeof(CS.RootMotion.FinalIK.LookAtController)
local LookAtIKType         = typeof(CS.RootMotion.FinalIK.LookAtIK)
local AnimatorType         = typeof(CS.UnityEngine.Animator)

local TurnLeftFlag  = 1
local TurnRightFlag = 2

local TurnName = "turn"
local identity = Quaternion.identity

------------ define ------------

---@class MapDecryptionHomeNPCKinematicsController
local MapDecryptionHomeNPCKinematicsController = Class('MapDecryptionHomeNPCKinematicsController')


function MapDecryptionHomeNPCKinematicsController:__init()
    self._npcNode = nil
    self._lookAtTarget = nil
    self._isTurning = false
    self._lookAtAngle = 0
    self._turnAngle = 0
    self._turnClockwise = nil

    self.lookAtMaxAngle = MapDecryptionConfMgr:GetParamById(MapDecryptionConstants.ParamsIds.LookAtMaxAngle)
    self.turnMinAngle   = MapDecryptionConfMgr:GetParamById(MapDecryptionConstants.ParamsIds.TurnMinAngle)
end


function MapDecryptionHomeNPCKinematicsController:__delete()
    if self.__EventShowOptions then
        Events.RemoveListener(MapDecryptionConstants.EventNames.ShowOptions, self.__EventShowOptions)
        self.__EventShowOptions = nil
    end
    self._npcLookAtController.target = nil
    self._npcLookAtController.weight = 0
    -- if self.__EventPlayNpcAction then
    --     Events.RemoveListener(MapDecryptionConstants.EventNames.PlayNpcAction, self.__EventPlayNpcAction)
    --     self.__EventPlayNpcAction = nil
    -- end

end

---Init
---@param npcNode                UnityEngine.Transform
---@param lookAtTarget           UnityEngine.Transform
---@param role                   UnityEngine.Transform
---@param mainSceneInteractionVo MapDecryptionMainSceneInteractionVo
function MapDecryptionHomeNPCKinematicsController:Init(npcNode, lookAtTarget, role, mainSceneInteractionVo)
    self._npcNode          = npcNode
    self._lookAtTarget     = lookAtTarget
    self._role             = role
    self._npcId            = mainSceneInteractionVo.id

    local npcGo            = npcNode.gameObject
    ---@type RootMotion.FinalIK.LookAtController
    self._npcLookAtController = npcGo:GetComponentInChildren(LookAtControllerType)
    ---@type RootMotion.FinalIK.LookAtIK
    self._npcLookAtController.weight = 0
    self._npcAni           = npcGo:GetComponentInChildren(AnimatorType)
    local npcLookAtIK         = npcGo:GetComponentInChildren(LookAtIKType)
    npcLookAtIK.enabled = true

    self._disableTurn      = mainSceneInteractionVo.disableTurn == 1
    self._forward          = npcNode.parent.forward
   
    self._npcLookAtTarget  = role:Find(MapDecryptionConstants.SceneDefine.NPCLookAtTarget)
    self._turnSeconds      = self._npcAni:GetTimeByAniName("turn_L")

    self.__EventShowOptions = Events.AddListener(MapDecryptionConstants.EventNames.ShowOptions, Bind(self, self.OnShowOptions))
    -- self.__EventPlayNpcAction = Events.AddListener(MapDecryptionConstants.EventNames.PlayNpcAction, Bind(self, self.OnPlayNpcAction))
end

function MapDecryptionHomeNPCKinematicsController:LateUpdate(status)
    -- if self._disableTurn then return end

    local MapDecryptionConstants = MapDecryptionConstants
    --- npc 视线归正 不在处理
    if status == MapDecryptionConstants.NPCStatus.Normal then
        if self._turnClockwise then
            self:CheckTurn(self._turnClockwise * -1, identity)
            self._turnAngle = 0
            self._turnClockwise = nil
            self:SetLookAtStatus()
        end
        self._lookAtAngle = 0

        return
    end

    ---@type UnityEngine.Transform
    local lookAtTarget = self._lookAtTarget
    ---@type UnityEngine.Transform
    local npcNode      = self._npcNode
    ---@type UnityEngine.Transform
    local role         = self._role
    if isNull(lookAtTarget) or isNull(npcNode) or isNull(role) then
        return
    end

    local npcPosition            = npcNode.position
    local rolePosition           = role.position
    if not self._disableTurn then
        local angle, clockwise = MapDecryptionUtils.CalcAngleAndClockwise(self._forward, rolePosition, npcPosition)
        if angle >= 90 then
            self._turnClockwise = clockwise
            self._turnAngle     = angle
        else
            self._turnClockwise = nil
            self._turnAngle     = 0
        end
    end

    self._lookAtAngle = MapDecryptionUtils.CalcAngleAndClockwise(npcNode.forward, rolePosition, npcPosition)
    self:SetLookAtStatus()

end



--- SetLookAtStatus
--- 设置NPC要看向的方向（人脸位置）
function MapDecryptionHomeNPCKinematicsController:SetLookAtStatus()
    --- 在NPC前方向180度以内，4米半径内，才会开启LookAt
    --- 顺逆时针 90 指 NPC前方向120度以内 
    if self._lookAtAngle < self.lookAtMaxAngle then
        self._npcLookAtController.target = self._npcLookAtTarget
        self._npcLookAtController.weight = 1
        
    else
        self._npcLookAtController.target = nil
        self._npcLookAtController.weight = 0

    end
    
end

function MapDecryptionHomeNPCKinematicsController:ResetTurn(turnComplete)
    if self._turnClockwise then
        
        local isTurning = self:CheckTurn(self._turnClockwise * -1, identity, turnComplete)
        if isTurning then
            self._lookAtAngle = self.lookAtMaxAngle
            self:SetLookAtStatus()
        end
        -- self._turnAngle = 0
        -- self._turnClockwise = nil
        return isTurning
    end
    return false
end

function MapDecryptionHomeNPCKinematicsController:CheckTurn(clockwise, endTargetQuaternion, turnComplete)
    local clockwise = clockwise or self._turnClockwise
    local npcAni    = self._npcAni
    local npcNode   = self._npcNode
    
    if clockwise == nil or isNull(npcAni) or isNull(npcNode) then
        return false
    end
    local turnFlag = clockwise == -1 and TurnLeftFlag or TurnRightFlag
    npcAni:SetInteger(TurnName, turnFlag)
    local targetQuaternion = endTargetQuaternion or Quaternion.Euler(0, self._turnAngle * clockwise, 0)
    npcNode:DOLocalRotateQuaternion(targetQuaternion, self._turnSeconds):OnComplete(function ()
        npcAni:SetInteger(TurnName, 0)
        if turnComplete then
            turnComplete(self._npcId)
        end

    end)
        
    return true
end

function MapDecryptionHomeNPCKinematicsController:CheckNpcIsTurn()
    return self._turnClockwise ~= nil
end

function MapDecryptionHomeNPCKinematicsController:GetAngle()
    return self._lookAtAngle
end

function MapDecryptionHomeNPCKinematicsController:OnShowOptions(optionData)
    local npcId = optionData.npcId
    if npcId == self._npcId then
        self:CheckTurn()
    end
end


return MapDecryptionHomeNPCKinematicsController
