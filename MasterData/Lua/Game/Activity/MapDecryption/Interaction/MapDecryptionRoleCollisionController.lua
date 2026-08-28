------------ import ------------
local support                 = require 'Frame.support'
local StatusController        = import("Game.Activity.MapDecryption.Interaction.MapDecryptionHomeNPCStatusController")
local QueryTriggerInteraction = CS.UnityEngine.QueryTriggerInteraction
local Physics                 = CS.UnityEngine.Physics
-- local Mathf                   = CS.UnityEngine.Mathf
---@type Engine.Lib.Yielders
local Yielders                = CS.Engine.Lib.Yielders
local cs_coroutine            = require "XLua.cs_coroutine"

------------ import ------------

------------ define ------------
local Radius            = 0.3
local Vector3           = Vector3
local UnityVector3      = Vector3.unity_vector3
local parse_strings     = parse_strings
local Offset            = UnityVector3.up
local MaxColliderSize   = 5
local LayerMaskFlag     = -1
local ColliderType      = typeof(CS.UnityEngine.Collider)
local IDType            = typeof(CS.Game.Native.Common.ID)
local LookAtControllerType = typeof(CS.RootMotion.FinalIK.LookAtController)
local LookAtIKType         = typeof(CS.RootMotion.FinalIK.LookAtIK)
local AnimatorType         = typeof(CS.UnityEngine.Animator)

local HumanSimpleController     = import("Game.Behaviours.HumanSimpleController")

-- local SafeUnpack = SafeUnpack
-- local NpcTag = "Avatars"

local InfoIndex = {
    NPCNode      = 1,
    NPCReference = 2,
    NPCTriggerNode = 3,
}

local IDLE0 = "idle:0"
local IDLE1 = "idle:1"

local DefDistance = 9999999
local DEBUG       = Config.DEBUG

------------ define ------------


---@class MapDecryptionRoleCollisionController
local MapDecryptionRoleCollisionController = Class('MapDecryptionRoleCollisionController')


function MapDecryptionRoleCollisionController:__init()
    -- local RoleParams = MapDecryptionConstants.RoleParams
    -- LookAtMaxAngle   = RoleParams.LookAtMaxAngle
    ---玩家操作的人物
    self._role         = nil
    ---npc id  -> {npc节点， look at参照物节点}
    self._npcId2Info  = {}
    self._npcId2Status = {}
    self._npcId2Vo = {}

    self._modelId2Action = {}
    self._modelId2Interact = {}
    self._modelId2Animator = {}
    self._modelId2AnimatorInfo = {}

    self._performCos = {}

    self._lastRolePosition = nil
    self._colliders = support.new_array(ColliderType, MaxColliderSize)

    local MapDecryptionConfMgr   = MapDecryptionConfMgr
    local MapDecryptionConstants = MapDecryptionConstants
    local ParamsIds = MapDecryptionConstants.ParamsIds
    self.lookAatFaceDistancePercentage = MapDecryptionConfMgr:GetParamById(ParamsIds.LookAtFaceDistancePercentage)
    self.dialogueDistancePercentage    = MapDecryptionConfMgr:GetParamById(ParamsIds.DialogueDistancePercentage)
    self.lookAtMaxAngle                = MapDecryptionConfMgr:GetParamById(ParamsIds.LookAtMaxAngle)

    self.isInitComplete = false

    ---主角所看的NPC id
    self._lookAtNPCId = 0

    self._isDisableStatusUpdate = false

    self.__EventPlayModelAction = Events.AddListener(MapDecryptionConstants.EventNames.PlayModelAction, Bind(self, self.OnPlayModelAction))

end

function MapDecryptionRoleCollisionController:__delete()
    for k, co in pairs(self._performCos) do
        if not isNull(co) then
            cs_coroutine.stop(co)
        end
    end
    self._performCos = nil
    if not isNull(self._co) then
        cs_coroutine.stop(self._co)
        self._co = nil
    end
    self._protagonistLookAtController.target = nil
    self._protagonistLookAtController.weight = 0
    self._protagonistLookAtIK.solver.IKPositionWeight = 0
    for npcId, animator in pairs(self._modelId2Animator) do
        local action = self._modelId2Action[npcId]
        if action and action ~= IDLE0 and not isNull(animator)  then
            local actionName = SafeUnpack(parse_strings(action, ":"))
            animator:SetInteger(actionName, 0)
        end
        
    end
    for i, v in pairs(self._npcId2Status) do
        v:Delete()
    end
    if self.__EventPlayModelAction then
        Events.RemoveListener(MapDecryptionConstants.EventNames.PlayModelAction, self.__EventPlayModelAction)
        self.__EventPlayModelAction = nil
    end
end

--- Init
---@param role UnityEngine.Transform
---@param uiParent UnityEngine.GameObject
---@param ScenePlayerNodeTrans UnityEngine.Transform
---@param camera UnityEngine.Camera 跟随主角的相机
function MapDecryptionRoleCollisionController:Init(role, uiParent, ScenePlayerNodeTrans, camera)
    self._role = role
    self._lastRolePosition = role.position

    ---@type RootMotion.FinalIK.LookAtController
    self._protagonistLookAtController = role.gameObject:GetComponentInChildren(LookAtControllerType)
    self._protagonistLookAtIK = role.gameObject:GetComponentInChildren(LookAtIKType)

    local MapDecryptionConstants = MapDecryptionConstants
    local SceneDefine = MapDecryptionConstants.SceneDefine
    ---@type MapDecryptionMainSceneInteractionVo[]
    local mainSceneInteractionVos = MapDecryptionConfMgr:GetAllMainSceneInteractions()

    local performCos = self._performCos
    local npcRoot =  ScenePlayerNodeTrans:Find(SceneDefine.NonPlayerCharacters)
    local rootNode, npcNode, npcReference, triggerNode
    ---@param v MapDecryptionMainSceneInteractionVo
    for i, v in ipairs(mainSceneInteractionVos) do
        local npcId  = v.id
        rootNode     = npcRoot:Find(SceneDefine.NpcRoot .. npcId)
        npcNode      = rootNode:Find(SceneDefine.NpcName)
        npcReference = rootNode:Find(SceneDefine.NpcTargetName)
        triggerNode  = rootNode:Find(SceneDefine.NpcTriggerNode)

        self:AddNpc(v, npcNode, npcReference, triggerNode, uiParent, camera)

        local co = self:StartPerformCheck(npcId)
        table.insert(performCos, co)
    end

    self:RestoreNpcStatus()

    self.isInitComplete = true

    self._protagonistLookAtControllerTgtWeight = 0.0
end


function MapDecryptionRoleCollisionController:InitHumanSimpleController(humanSimpleController_)
    assert( not isNull(humanSimpleController_) )
    -- self.humanSimpleController = humanSimpleController_
end 


--- AddNpc
---@param mainSceneInteractionVo MapDecryptionMainSceneInteractionVo
---@param npcNode UnityEngine.Transform
---@param npcReference UnityEngine.Transform
---@param triggerNode UnityEngine.Transform
---@param uiParent UnityEngine.GameObject
---@param camera UnityEngine.Camera
function MapDecryptionRoleCollisionController:AddNpc(mainSceneInteractionVo, npcNode, npcReference, triggerNode, uiParent, camera)
    ---@type MapDecryptionHomeNPCStatusController
    local statusController = StatusController.New()
    statusController:Init(mainSceneInteractionVo, npcNode, npcReference, triggerNode, uiParent, camera, self._role)

    local npcId               = mainSceneInteractionVo.id
    self._npcId2Status[npcId] = statusController
    self._npcId2Info[npcId]   = {npcNode, npcReference, triggerNode}
    self._npcId2Vo[npcId]     = mainSceneInteractionVo

    self._modelId2Action[npcId] = IDLE0
    self._modelId2Interact[npcId] = false

end

function MapDecryptionRoleCollisionController:Update()
    if not self.isInitComplete then return end

    --- 检查人物坐标是否变化
    local curRolePosition = self._role.position
    local isMove = Vector3.Distance(curRolePosition, self._lastRolePosition) > 0.0001
    self._isMove = isMove
    if isMove and not self._isDisableStatusUpdate then
        self._lastRolePosition = curRolePosition
        curRolePosition.y = curRolePosition.y + Offset.y
        self:HandleAllRoleStatus(curRolePosition)

    end

    -- 因为目前 HumanSimpleController 的转身功能 与 lookAt 系统存在冲突, 故: 只要 role 开始运动, lookat 系统就会被强制关闭:
    -- todo: 未来优化: weight 值不变时, 不要每帧都去重设...

    --- 务必在 HandleAllRoleStatus() 后调用, 确保自己是本帧中 最后改写 _protagonistLookAtControllerTgtWeight 的地方:
    if isMove then 
        -- 只要 role 在运动, lookat 系统就要被强关为 0
        self._protagonistLookAtControllerTgtWeight = 0.0
    end
    
    --- 强制设置 lookAtController 和 lookAtIK 的 weight 值;
    local towardSpeed = (self._protagonistLookAtController.weight < self._protagonistLookAtControllerTgtWeight) and 0.2 or 0.9
    self._protagonistLookAtController.weight = Mathf.MoveTowards( self._protagonistLookAtController.weight, self._protagonistLookAtControllerTgtWeight, towardSpeed )
    -- 选择性设置 lookAtIK 的 weight 值 (只往低值设):
    if self._protagonistLookAtController.weight < self._protagonistLookAtIK.solver.IKPositionWeight  then 
        self._protagonistLookAtIK.solver.IKPositionWeight = self._protagonistLookAtController.weight
    end
end


function MapDecryptionRoleCollisionController:LateUpdate()
    if not self.isInitComplete then
        return
    end

    ---@param status MapDecryptionHomeNPCStatusController
    for i, status in pairs(self._npcId2Status) do
        status:LateUpdate(self._isMove)
    end
end

function MapDecryptionRoleCollisionController:RestoreNpcStatus()

    local curRolePosition = self._role.position
    curRolePosition.y = curRolePosition.y + Offset.y
    self:HandleAllRoleStatus(curRolePosition, true)
end

function MapDecryptionRoleCollisionController:HandleAllRoleStatus(curRolePosition, isForce)
    local numFound = Physics.OverlapSphereNonAlloc(curRolePosition, Radius, self._colliders, LayerMaskFlag, QueryTriggerInteraction.Collide)
    
    local eventInfos
    local closetNpcId, foundNpcId2Info = self:GetClosestNPCId(numFound)
    
    if closetNpcId then
        if closetNpcId ~= self._lookAtNPCId then
            --- 设置look
            self._lookAtNPCId = closetNpcId
        end
        local info = self._npcId2Info[closetNpcId]
        local npcTarget = info[InfoIndex.NPCReference]
        local roleAngle = SafeUnpack(foundNpcId2Info[closetNpcId])
        self:SetProtagonistLookAt(false, roleAngle, npcTarget)

    elseif self._lookAtNPCId > 0 then
        self:SetProtagonistLookAt(true)
        self._lookAtNPCId = 0

    end

    local Normal = MapDecryptionConstants.NPCStatus.Normal
    ---@param npcId number
    ---@param statusController MapDecryptionHomeNPCStatusController
    for npcId, statusController in pairs(self._npcId2Status) do
        local info = foundNpcId2Info[npcId]
        local oldStatus = statusController:GetStatus()
        local status
        if info == nil then
            status = Normal
        else
            status    = self:CheckNpcStatus(info, statusController, npcId)
        end

        if (status and oldStatus ~= status) or isForce then
            local eventName = statusController:HandleStatusChange(status, oldStatus, isForce)
            if eventName then
                eventInfos = eventInfos or {}
                table.insert(eventInfos, {
                    npcId     = npcId,
                    eventName = eventName,
                    vo        = self._npcId2Vo[npcId],
                })
            end
        end
    end

    if eventInfos then
        Events.Broadcast(MapDecryptionConstants.EventNames.ChangeRoleStatus, eventInfos)
    end
end

--- GetClosestNPCId
--- 获取距离主角最近的 NPC Id
---@param numFound number 主角身边有多少个碰撞器
---@return number closetNpcId 距离人物最近的 NPC Id
---@return table foundNpcId2Trans 人物附近的npcId -> npc transform
function MapDecryptionRoleCollisionController:GetClosestNPCId(numFound)
    local colliders      = self._colliders
    local NpcTriggerNode = MapDecryptionConstants.SceneDefine.NpcTriggerNode
    local role           = self._role
    local closetNpcId
    local closetDistance       = DefDistance
    local foundNpcId2Info    = {}
    -- local foundNpcId2Trans    = {}
    local lookAtMaxAngle = self.lookAtMaxAngle
    for i = 0, numFound - 1, 1 do
        local hitCollider = colliders[i]
        if hitCollider.name == NpcTriggerNode then
            local idComp      = hitCollider.gameObject:GetComponent(IDType)
            if not isNull(idComp) then
                local npcId   = idComp.id
                local info    = self._npcId2Info[npcId]

                ---@type UnityEngine.Transform
                local npcNode = info[InfoIndex.NPCNode]
                local roleAngle = MapDecryptionUtils.CalcAngleAndClockwise(role.forward, npcNode.position, role.position)
                local dis = Vector3.Distance(npcNode.position, role.position)
                --- 距离最近 并且 
                if dis < closetDistance and roleAngle < lookAtMaxAngle then
                    closetDistance = dis
                    closetNpcId = npcId
                end

                foundNpcId2Info = foundNpcId2Info or {}
                foundNpcId2Info[npcId] = {roleAngle, dis }
                -- table.insert(foundNpcId2Trans, npcId)
            end
        end
    end

    return closetNpcId, foundNpcId2Info
end

--- CheckNpcStatus
---@param info table
---@param nodeStatus MapDecryptionHomeNPCStatusController
function MapDecryptionRoleCollisionController:CheckNpcStatus(info, nodeStatus, npcId)
    local roleAngle, distance = SafeUnpack(info)
    local NpcStatus = MapDecryptionConstants.NPCStatus
    local status = NpcStatus.Normal
            
    -- local distance = Vector3.Distance(node.position, self._role.position)
    local radius = nodeStatus:GetRadius()
    if distance <= self.dialogueDistancePercentage * radius then
        -- local angle     = UnityVector3.Angle(node.forward, self._role.forward)
        -- print("angle", roleAngle)
        if roleAngle < self.lookAtMaxAngle then
            status = NpcStatus.Dialogue
        else
            status = NpcStatus.LookUpFace
        end
    elseif distance <= self.lookAatFaceDistancePercentage * radius then
        status = NpcStatus.LookUpFace
    elseif distance <= radius then
        status = NpcStatus.Display
    end

    return status;
end

--- GetNpcModelInfo
---@param npcId number 
---@return table {npcNode, npcReference, triggerNode}
function MapDecryptionRoleCollisionController:GetNpcModelInfo(npcId)
    return self._npcId2Info[npcId]
end

--- SetProtagonistLookAt
--- 设置主角look at
---@param isClear any
---@param roleAngle any
---@param lookAtTarget any
function MapDecryptionRoleCollisionController:SetProtagonistLookAt(isClear, roleAngle, lookAtTarget)
    local lookAtController = self._protagonistLookAtController
    if isClear then
        lookAtController.target = nil
        lookAtController.weight = 0
    else
        if roleAngle < self.lookAtMaxAngle then
            lookAtController.target = lookAtTarget
            self._protagonistLookAtControllerTgtWeight = 1.0
        else
            lookAtController.target = nil
            self._protagonistLookAtControllerTgtWeight = 0.0
        end
    end
end

function MapDecryptionRoleCollisionController:OnPlayModelAction(id, action, face)
    --- 0: 主角 >0 npc
    if id == 0 then
        ---todo 未来可能会加 主角无动作
    else
        self:PlayNpcAction(id, action, face)
    end

end

function MapDecryptionRoleCollisionController:StartPerformCheck(npcId)
    -- 当超过10秒不互动，就开始播idle演出
    -- 这个“10秒”，可以是一个在10~15之间的随机数
    return cs_coroutine.start(function ()
        local random = math.random
        while true do
            local seconds = random(10, 15)
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(seconds))
            --- 交互过在等10~15s
            if not self._modelId2Interact[npcId] then
                self:PlayNpcAction(npcId, IDLE1)
            else
                self._modelId2Interact[npcId] = false
            end
        end
    end)
end

function MapDecryptionRoleCollisionController:PlayNpcAction(id, action, face)
    -- print("PlayNpcAction--->>>>>", id, action)
    --- 不配不处理
    -- if string.isEmpty(action) then
    --     return
    -- end

    ---@type UnityEngine.Animator
    local animator = self:GetAnimatorById(id)
    local clipInfo = animator:GetCurrentAnimatorClipInfo(0)
    local idleValue = animator:GetInteger("idle")
    
    ---只有idle0 才会切下一个动作
    -- local oldAction = self._modelId2Action[id]
    local isIdle = clipInfo[0].clip.name == "idle"
    -- print(clipInfo[0].clip.name, idleValue, not isIdle or (isIdle and idleValue ~= 0), "clipInfo")
    if not isIdle or (isIdle and idleValue ~= 0)  then
        return face
    end

    --- 进入交互状态
    if action ~= IDLE1 and action ~= IDLE0 then
        self._modelId2Interact[id] = true
    end
    
    self._modelId2Action[id] = action
    local actionName, actionFlag = SafeUnpack(parse_strings(action, ":"))
    self._co = cs_coroutine.start(function ()
        local seconds = self:GetClipSeconds(id, actionName, animator)
        animator:SetInteger(actionName, checkNumber(actionFlag))
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(seconds * 0.5))
        -- cs_coroutine.yield_return(animator:WaitUntilAniCompleted())
        animator:SetInteger(actionName, 0)
        self._modelId2Action[id] = IDLE0
        if DEBUG then
            ---@type MapDecryptionMainSceneInteractionVo
            local vo = self._npcId2Vo[id]
            -- print(string.format("%s正在播放%s", vo.name, IDLE0))
        end
    end)
    
    if DEBUG then
        ---@type MapDecryptionMainSceneInteractionVo
        local vo = self._npcId2Vo[id]
        -- print(string.format("%s正在播放%s", vo.name, action))
    end

    return true
end

--- GetAnimatorById
---@param id number
---@return UnityEngine.Animator
function MapDecryptionRoleCollisionController:GetAnimatorById(id)
    local animator = self._modelId2Animator[id]
    if isNull(animator) then
        local info    = self._npcId2Info[id]
        local npcNode = info[InfoIndex.NPCNode]
        animator = npcNode.gameObject:GetComponent(AnimatorType)
        self._modelId2Animator[id] = animator

    end
    return animator
end

--- GetClipSeconds
--- 获取动画片段时间
---@param npcId number   npc 唯一id
---@param clipName string 片段名称
---@param animator UnityEngine.Animator
function MapDecryptionRoleCollisionController:GetClipSeconds(npcId, clipName, animator)
    self._modelId2AnimatorInfo[npcId] = self._modelId2AnimatorInfo[npcId] or {}
    local seconds = self._modelId2AnimatorInfo[npcId][clipName]
    if seconds == nil then
        seconds = animator:GetTimeByAniName(clipName)
        self._modelId2AnimatorInfo[npcId][clipName] = seconds
    end

    return seconds
end


-- function MapDecryptionRoleCollisionController:OnForceFreshBubblePositions()
--     for i, v in pairs(self._npcId2Status) do
--         v:FreshBubbleNodePosition()
--     end
-- end

function MapDecryptionRoleCollisionController:SetIsDisableStatusUpdate(isDisable)
    self._isDisableStatusUpdate = isDisable
end

function MapDecryptionRoleCollisionController:CheckNpcIsTurn(npcId)
    ---@type MapDecryptionHomeNPCStatusController
    local status = self._npcId2Status[npcId]
    if status then
        return status:CheckNpcIsTurn()
    end
end

function MapDecryptionRoleCollisionController:ResetTurn(npcId, turnComplete)
    ---@type MapDecryptionHomeNPCStatusController
    local status = self._npcId2Status[npcId]
    if not status:ResetTurn(turnComplete) and turnComplete then
        turnComplete(npcId)
    end
    
end

function MapDecryptionRoleCollisionController:GetNPCStatus(npcId)
    ---@type MapDecryptionHomeNPCStatusController
    local status = self._npcId2Status[npcId]
    if status then
        return status:GetStatus()
    end
end

return MapDecryptionRoleCollisionController
