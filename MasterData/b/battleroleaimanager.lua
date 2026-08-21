require "class"
---@class BattleRoleAIManager:BaseClass
local BattleRoleAIManager = class("BattleRoleAIManager")
local BattleCore = require "BattleCore"
local BattleRoleAI = require "BattleRoleAI"

local funcName = "ActiveStateAction%s"
local noTargetMoveFuncName = "getNoTargetMoveBlock%s"

---@class PrepareUseSkillData
---@field skillId integer 技能ID
---@field targetRoleId integer? 目标角色ID，目标为角色时才会有数据
---@field targetBlockId integer 技能目标地格Id

function BattleRoleAIManager:ctor()

end

function BattleRoleAIManager:initManager()
    self._instance = nil
    ---@type table<MonsterActiveEventType, AIEventData[]>
    self._registerEvent = {}

    self._hasActiveGroupIDList = {
        [0] = 1, -- 默认groupId为0的角色已激活，避免未配置groupId的角色无法被激活
    }

    ---@type table<integer, PrepareUseSkillData>
    self._prepareUseSkill = {}

    ---@type table<integer, integer> 仅移动角色的目标地格索引
    self._onlyMoveRoleTargetIndex = {}
    ---@type table<integer, integer[]> 仅移动角色的目标地格ID列表
    self._onlyMoveRoleTargetBlockIds = {}

    ---@type table<integer, integer> 按顺序释放技能的角色技能索引
    self._roleskillOrderIndex = {}
    ---@type table<integer, integer[]> 按顺序释放技能的角色技能ID列表
    self._roleskillOrderSkillIds = {}

    ---@class AIActionData
    ---@field [1] integer 未激活状态的AI动作ID
    ---@field [2] integer 已激活状态的AI动作ID

    ---@type table<integer, AIActionData> AI动作ID字典，通过角色ID索引
    self._aiActionIDDic = {
        [0] = {
            [1] = 1001,
            [2] = 1002,
        },
    }

    ---@type table<integer, integer[]> AI释放技能的字典，包含技能释放优先级和目标寻找逻辑，通过角色ID索引
    self._aiDoSkillDataDic ={}
    ---@type table<MonsterActiveEventType, fun(self:BattleRoleAIManager, data:table, role:BattleRole?)>
    self._aiActiveEvent = {
        [GE.MonsterActiveEventType.NoCondition] = self._checkEvent1,
        [GE.MonsterActiveEventType.TargetInAtkRange] = self._checkEvent2,
        [GE.MonsterActiveEventType.BeHurt] = self._checkEvent3,
        [GE.MonsterActiveEventType.FightRound] = self._checkEvent4,
        [GE.MonsterActiveEventType.RoleDie] = self._checkEvent5,
    }

    self._roleAI = BattleRoleAI:instance()
end

---@return BattleRoleAIManager
function BattleRoleAIManager:instance()
    if self._instance == nil then
        self._instance = BattleRoleAIManager:new()
    end
    return self._instance
end

function BattleRoleAIManager:RegisterAIEvent(tableIdList, groupId)
    for _, id in ipairs(tableIdList) do
        local tbData = Config.GetMonsterActivationInfo(id)
        local eventID = tbData.type
        local param = tablex.clone(tbData.value, true)
        if self._registerEvent[eventID] == nil then
            self._registerEvent[eventID] = {}
        end
        ---@class AIEventData
        ---@field [1] number 事件ID
        ---@field [2] number 关联人物的组ID
        ---@field [3] table 事件激活参数
        local t = {}
        t[1] = id
        t[2] = groupId
        t[3] = param
        local l = self._registerEvent[eventID]
        l[#l + 1] = t
    end
end

---@param eventID MonsterActiveEventType
---@param role BattleRole?
function BattleRoleAIManager:CheckAIEvent(eventID, role)
    local groupId = nil
    ---只有敌方角色才会有groupId，友方角色的AI事件不区分groupId
    if role and role.camp == GE.BattleCampType.Enemy then
        groupId = role.groupId
    end

    if groupId and self._hasActiveGroupIDList[groupId] ~= nil then
        return
    end

    local eventDatas = self._registerEvent[eventID]
    if eventDatas == nil then
        return
    end

    local event = self._aiActiveEvent[eventID]
    if event == nil then
        return
    end

    local battleMgr = BattleCore:getBattleMgr()
    local r = false
    local dataCount = #eventDatas
    for i = dataCount, 1, -1 do
        local data = eventDatas[i]
        local id = data[2]
        if self._hasActiveGroupIDList[id] == nil then
            r = event(self, data, role)
            if r == true then
                self._hasActiveGroupIDList[id] = 1
                local roleMgr = battleMgr:getRoleManager()
                local roleList = roleMgr:getRoleByGroupId(id)
                for _, curRole in ipairs(roleList) do
                    curRole:SetActiveState(true)
                end
            end
        end
    end
end

function BattleRoleAIManager:getActiveGroupList()
    return tablex.clone(self._hasActiveGroupIDList, true)
end

---回退回合时重置已记录的激活group
function BattleRoleAIManager:setActiveGroupList(list)
    self._hasActiveGroupIDList = list
end

--- 无条件激活
---@param data table
---@param role BattleRole
function BattleRoleAIManager:_checkEvent1(data, role)
    return true
end

--- 进入敌方攻击范围
---@param data table
---@param role BattleRole
function BattleRoleAIManager:_checkEvent2(data, role)
    local r = false
    local battleMgr = BattleCore:getBattleMgr()
    local roleMgr = battleMgr:getRoleManager()
    local groupId = data[2]
    local roleList = roleMgr:getEnemiesCanHitRole(role)
    for _, curRole in ipairs(roleList) do
        if curRole.groupId == groupId then
            r = true
            break
        end
    end
    return r
end

--- 受到伤害时激活
---@param data table
---@param role BattleRole
function BattleRoleAIManager:_checkEvent3(data, role)
    local r = false

    local groupId = data[2]
    if role.groupId == groupId then
        r = role:CheckHasTag(GE.ActionTagType.HasBeHurt)
    end

    return r
end

--- 到达某个回合激活
---@param data table
---@param role BattleRole
function BattleRoleAIManager:_checkEvent4(data, role)
    local battleMgr = BattleCore:getBattleMgr()
    local curRound = battleMgr:getCurrentRound()
    local param = data[3][1]
    return curRound >= param
end

--- 单位死亡时激活
---@param data table
---@param role BattleRole
function BattleRoleAIManager:_checkEvent5(data, role)
    local r = false

    local groupId = data[2]
    if role.groupId == groupId then
        r = role:getIsAlive() == false
    end

    return r
end

---@param roleId integer
---@param nonactiveList integer
---@param activeList integer
function BattleRoleAIManager:setAIActionID(roleId, nonactiveList, activeList)
    self._aiActionIDDic[roleId] = {
        [1] = nonactiveList,
        [2] = activeList,
    }
    local checkList = {nonactiveList, activeList}
    for _, activeId in ipairs(checkList) do
        local d = Config.GetAiOperateInfo(activeId)
        if d then
            if d.skillList and next(d.skillList) then
                if d.aiType == 3 then
                    self:setSkillInOrderData(roleId, d.skillList)
                else
                    self:setAIDoSkillData(roleId, d.skillList)
                end
            end

            if d.moveType == 3 and d.moveTypeValue and next(d.moveTypeValue) then
                local battleMgr = BattleCore:getBattleMgr()
                local map = battleMgr:getMap()
                local blockIds = {}
                for _, mapCid in ipairs(d.moveTypeValue) do
                    local block = map:getBlockByCid(mapCid)
                    if block then
                        blockIds[#blockIds + 1] = block.id
                    end
                end
                self:setOnlyMoveRoleData(roleId, blockIds)
            end
        end
    end
end

---设置巡逻类型角色的目标地格ID数据
---@param roleId integer
---@param data integer[]
function BattleRoleAIManager:setOnlyMoveRoleData(roleId, data)
    self._onlyMoveRoleTargetBlockIds[roleId] = data
end

---设置按顺序释放技能的角色技能ID数据
---@param roleId integer
---@param data integer[]
function BattleRoleAIManager:setSkillInOrderData(roleId, data)
    self._roleskillOrderSkillIds[roleId] = data
end

---设置AI释放技能优先度数据
---@param roleId integer
---@param data integer[]
function BattleRoleAIManager:setAIDoSkillData(roleId, data)
    self._aiDoSkillDataDic[roleId] = data
end

function BattleRoleAIManager:getAIDoSkillData(roleId)
    return self._aiDoSkillDataDic[roleId]
end

---检测AI的自动行动
---@param role BattleRole
---@param actionId integer?
function BattleRoleAIManager:checkAutoAction(role, actionId)
    local roleId = role.id
    role._isMyTurn = true
    if actionId == nil then
        local actionDataList = self._aiActionIDDic[roleId] or self._aiActionIDDic[0]
        local isActive = role:getActiveState()
        local index = isActive and 2 or 1
        actionId = actionDataList[index]
    end
    local finishAction = false
    local _aiActionData = Config.GetAiOperateInfo(actionId)
    if not _aiActionData then
        self._roleAI:ActiveStateAction0(role)
        return
    end
    local _aiType = _aiActionData.aiType
    local s = string.format(funcName, _aiType)
    ---@type fun(self:BattleRoleAI, role:BattleRole):boolean
    local func = self._roleAI[s]
    if func then
        finishAction = func(self._roleAI, role)
    end
    if not finishAction then
        local noTargetMoveId = _aiActionData.moveType
        local s = string.format(noTargetMoveFuncName, noTargetMoveId)
        ---@type fun(self:BattleRoleAI, role:BattleRole):BattleBlock?, integer[]?
        local func = self._roleAI[s]
        local moveBlock, path = nil, nil
        if func then
            moveBlock, path = func(self._roleAI, role)
        end
        if moveBlock and path then
            self._roleAI:roleMoveByPath(role, path, 1)
        else
            self._roleAI:ActiveStateAction0(role)
        end
    end
end

function BattleRoleAIManager:checkPrepareSkillCanUse(role)
    self._roleAI:checkPrepareSkillCanUse(role)
end

function BattleRoleAIManager:getRoleAI()
    return self._roleAI
end

---@param sourceId integer
---@param prepareData PrepareUseSkillData
---@param playInReport boolean? 是否在战报中播放
function BattleRoleAIManager:setPrepareUseSkillData(sourceId, prepareData, playInReport)
    self._prepareUseSkill[sourceId] = prepareData
    local roleId = prepareData.targetRoleId
    local battleMgr = BattleCore:getBattleMgr()
    if roleId then
        local skillId = prepareData.skillId
        local blockId = prepareData.targetBlockId
        battleMgr:setPrepareSkillFollowList(sourceId, roleId, skillId, blockId, playInReport)
    else
        battleMgr:showPrepareSkillRange(sourceId, prepareData, playInReport)
    end
end

function BattleRoleAIManager:getPrepareUseSkillData(sourceId)
    return self._prepareUseSkill[sourceId]
end

function BattleRoleAIManager:clearPrepareUseSkillData(sourceId)
    local d = self._prepareUseSkill[sourceId]
    if d then
        local battleMgr = BattleCore:getBattleMgr()
        local roleId = d.targetRoleId
        if roleId then
            battleMgr:clearPrepareSkillFollowList(roleId, sourceId)
        end
        battleMgr:removePrepareSkillRange(sourceId)
    end
    self._prepareUseSkill[sourceId] = nil
end

function BattleRoleAIManager:getClonePrepareUseSkillData()
    return tablex.clone(self._prepareUseSkill, true)
end

function BattleRoleAIManager:resetPrepareUseSkillData(data)
    self._prepareUseSkill = {}
    for soureId, prepareData in pairs(data) do
        self:setPrepareUseSkillData(soureId, prepareData)
    end
end

---仅移动角色抵达目标地格，切换至下一个目标地格
function BattleRoleAIManager:onlyMoveRoleArriveTargetBlock(roleId)
    local index = self._onlyMoveRoleTargetIndex[roleId] or 1
    local nextIndex = index + 1
    local blockIds = self._onlyMoveRoleTargetBlockIds[roleId]
    if nextIndex > #blockIds then
        nextIndex = 1
    end
    self._onlyMoveRoleTargetIndex[roleId] = nextIndex
end

---检测仅移动角色下一个目标地格的ID
---@param roleId integer
function BattleRoleAIManager:getOnlyMoveRoleCurTargetBlockId(roleId)
    local index = self._onlyMoveRoleTargetIndex[roleId] or 1
    local blockIds = self._onlyMoveRoleTargetBlockIds[roleId]
    if blockIds and next(blockIds) then
        local blockId = blockIds[index]
        return blockId
    end
    return nil
end

---技能释放成功后，切换至下一个技能
---@param roleId integer
function BattleRoleAIManager:doSkillInOrderFinish(roleId)
    local index = self._roleskillOrderIndex[roleId] or 1
    local nextIndex = index + 1
    local skillIds = self._roleskillOrderSkillIds[roleId]
    if nextIndex > #skillIds then
        nextIndex = 1
    end
    self._roleskillOrderIndex[roleId] = nextIndex
end

---检测按顺序释放技能的下一个技能的类型ID
---@param roleId integer
function BattleRoleAIManager:getSkillInOrderCurSkillTypeId(roleId)
    local index = self._roleskillOrderIndex[roleId] or 1
    local skillIds = self._roleskillOrderSkillIds[roleId]
    if skillIds and next(skillIds) then
        local skillId = skillIds[index]
        return skillId
    end
    return nil
end

function BattleRoleAIManager:getOnlyMoveRoleCurTargetBlockIds()
    return tablex.clone(self._onlyMoveRoleTargetBlockIds, true)
end

---@param data table<integer, integer[]>
function BattleRoleAIManager:resetOnlyMoveRoleTargetBlockIds(data)
    self._onlyMoveRoleTargetBlockIds = data
end

function BattleRoleAIManager:getSkillInOrderCurSkillIds()
    return tablex.clone(self._roleskillOrderSkillIds, true)
end

---@param data table<integer, integer[]>
function BattleRoleAIManager:resetSkillInOrderSkillIds(data)
    self._roleskillOrderSkillIds = data
end

function BattleRoleAIManager:clear()
    self._instance = nil
    self._registerEvent = {}
    self._hasActiveGroupIDList = {
        [0] = 1,
    }
    self._prepareUseSkill = {}
end

return BattleRoleAIManager