require "class"
---@class BattleRoleAI
local BattleRoleAI = class("BattleRoleAI")
local BattleCore = require "BattleCore"

local targetFuncName = "getRoleList%s"
local blockFuncName = "getMoveBlock%s"

local skillDir = {
	{-1, 0}, -- 上
	{1, 0}, -- 下
	{0, -1}, -- 左
	{0, 1} -- 右
}

--战斗地块
function BattleRoleAI:ctor()
	-- LuaLogger.ds("BattleRoleAI ctor")
end

---实例化
---@return BattleRoleAI BattleRoleAI
function BattleRoleAI:instance()
	if (self._instance == nil) then
		self._instance = self:new()
	end
	return self._instance
end

---检查并使用预备技能
---@param role BattleRole
---@return BattleBlock?, integer[]?, BattleBlock?
function BattleRoleAI:checkAndUsePrepareSkill(role)
    local actionRoleId = role.id
    local battleMgr = BattleCore:getBattleMgr()
    local roleAIMgr = battleMgr:getBattleRoleAIManager()
    local prepareData = roleAIMgr:getPrepareUseSkillData(actionRoleId)
    local chooseBlock, skillTarget, moveBlock = nil, nil, nil
    if prepareData then
        local roleBlock = role:getShowBlock()
        local targetRoleId = prepareData.targetRoleId
        skillTarget = {}
        if targetRoleId then
            local roleMgr = battleMgr:getRoleManager()
            local targetRole = roleMgr:getRole(targetRoleId)
            if targetRole then
                local targetBlock = targetRole:getShowBlock()
                chooseBlock = targetBlock
            end
        else
            local targetBlockId = prepareData.targetBlockId
            chooseBlock = battleMgr:getBlockById(targetBlockId)
        end
        ---预备类技能释放时，检测范围内的目标
        local skillID = prepareData.skillId
        local map = battleMgr:getMap()
        local skillMgr = battleMgr:getSkillManager()
        local skillConfig = Config.GetSkillInfo(skillID)
        local skillEffectRange = skillMgr:GetSkillEffectRangeByRole(skillConfig, role)
        local skillRangeType = skillConfig.rangeSelectType
        local blockDataList = map:getDiffuseRange(skillRangeType, chooseBlock, skillEffectRange, roleBlock)
        for i, v in ipairs(blockDataList) do
            skillTarget[i] = v.blockId
        end
        moveBlock = roleBlock
        role.selectedSkill = skillID
        roleAIMgr:clearPrepareUseSkillData(actionRoleId)
        return chooseBlock, skillTarget, moveBlock
    end
end

---未激活状态
---@param role BattleRole
---@return boolean
function BattleRoleAI:ActiveStateAction0(role)
    local delayTime = 0
    role:doAction(GE.ActionType.Standby, delayTime)
    return true
end

---激活状态，默认行动逻辑
---@param role BattleRole 当前行动的角色
---@return boolean
function BattleRoleAI:ActiveStateAction1(role)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:setIsAutoAction(true)
    local delayTime = 0
    if role:checkCanDoAction() == false then
        role:doAction(GE.ActionType.Standby, delayTime)
        return true
    end
    local chooseBlock, skillTarget, moveBlock, path = nil, nil, nil, nil
    chooseBlock, skillTarget, moveBlock = self:checkAndUsePrepareSkill(role)
    if chooseBlock == nil then
        local battleMgr = BattleCore:getBattleMgr()
        local roleAIMgr = battleMgr:getBattleRoleAIManager()
        local moveRange = role:getRoleMoveRange()
        local checkList = roleAIMgr:getAIDoSkillData(role.id)
        local skillCfgList, skillSearchData = self:getSkillConfigList(role, checkList)
        chooseBlock, skillTarget, moveBlock, path = self:CheckSkillToUse(role, moveRange, skillCfgList, skillSearchData)
    end
    if chooseBlock and skillTarget and moveBlock then
        role:setTargetAuto(skillTarget, chooseBlock, moveBlock, path)
        -- role:faceToBlock(chooseBlock, true)
        role:doAction(GE.ActionType.DoSkill, delayTime)
        return true
    end
    return false
end

---仅移动型ai
---@param role BattleRole
---@return boolean
function BattleRoleAI:ActiveStateAction2(role)
    local delay = 0
    if role:checkCanDoAction() == false then
        role:doAction(GE.ActionType.Standby, delay)
        return true
    end
    local battleMgr = BattleCore:getBattleMgr()
    local roleAIMgr = battleMgr:getBattleRoleAIManager()
    local map = battleMgr:getMap()
    local roleId = role.id
    local blockId = roleAIMgr:getOnlyMoveRoleCurTargetBlockId(roleId)
    if blockId then
        local moveType = role.moveType
        local moveRange = map:getCanMoveRangeByMoveType(moveType)
        local offsetCostDic = role:getMoveCostOffset()
        local movePath1 = map:getAStarPath(role:getShowBlock().id, blockId, moveRange, moveType, role:getRoleKVMoveRange(), offsetCostDic)
        if movePath1 and next(movePath1) then
            self:roleMoveByPath(role, movePath1, delay)
        end
        return true
    end
    return false
end

---按顺序释放技能型ai
---@param role BattleRole
function BattleRoleAI:ActiveStateAction3(role)
    local roleId = role.id
    local battleMgr = BattleCore:getBattleMgr()
    local roleAIMgr = battleMgr:getBattleRoleAIManager()
    local delay = 0
    local curSkillId = roleAIMgr:getSkillInOrderCurSkillTypeId(roleId)
    local moveRange = role:getRoleMoveRange()
    if curSkillId then
        local checkList = {curSkillId}
        local skillCfglist, skillSearchData = self:getSkillConfigList(role, checkList)
        local chooseBlock, skillTarget, moveBlock, path = self:CheckSkillToUse(role, moveRange, skillCfglist, skillSearchData)
        if chooseBlock and skillTarget and moveBlock then
            -- role:faceToBlock(chooseBlock)
            role:setTargetAuto(skillTarget, chooseBlock, moveBlock, path)
            role:doAction(GE.ActionType.DoSkill, delay)
            roleAIMgr:doSkillInOrderFinish(roleId)
            return true
        end
    end
    return false
end

---@param role BattleRole
---@param path integer[]?
---@param delay number
function BattleRoleAI:roleMoveByPath(role, path, delay)
    local battleMgr = BattleCore:getBattleMgr()
    local map = battleMgr:getMap()
    local roleMgr = battleMgr:getRoleManager()
    if (path) then
        local selfBlockId = role:getShowBlock().id
        local roleMoveRange = role:getRoleKVMoveRange()
        local ignoreEnemyBlock = role.buffController:checkHasIgnoreEnemyBlock()
		local targetBlock = nil
        ---@type integer[]
		local movePath = {}
        local canMovePathIndex = 0
        for _, blockId in ipairs(path) do
            local block = map:getBlockById(blockId)
            if blockId ~= selfBlockId then
                if roleMoveRange[blockId] == nil then
                    break
                end
            end
            local blockRole = block:tryGetRole()
            if blockRole == nil or blockRole.id == role.id or not roleMgr:isEnemyCamp(role, blockRole) or ignoreEnemyBlock == true then
                table.insert(movePath, blockId)
                ---移动的终点必须是没有人的格子
                if blockRole == nil then
                    targetBlock = block
                    canMovePathIndex = #movePath
                end
            end
        end
		if targetBlock and canMovePathIndex > 0 then
            local finialPath = map:getShortestPath(selfBlockId, targetBlock.id, roleMoveRange)
            role:setChooseMoveBlock(targetBlock, finialPath)
		end
	end
	role:doAction(GE.ActionType.Standby, delay)
end

---@param role BattleRole
---@param orderList integer[]? 
---@return SkillTable[], table<integer, AiSearchAndMoveTable>?
function BattleRoleAI:getSkillConfigList(role, orderList)
    if role:getMoveAgainType() ~= nil then
        return {}, nil
    end
    ---@type SkillTable[]
    local skillConfigList = {}
    ---@type table<integer, AiSearchAndMoveTable>?
    local skillSearchData = nil
    local skillOrderList = nil
    if orderList then
        skillSearchData = {}
        skillOrderList = {}
        for i, v in ipairs(orderList) do
            local d = Config.GetAiSearchAndMoveInfo(v)
            if d then
                skillOrderList[v] = i
                skillSearchData[v] = d
            end
        end
    end
    ---@type integer[]
    local skillList = nil
    if role:checkHasCanNotUseActiveSkill() == false then
        skillList = role:getActiveSkillList()
    else
        skillList = {}
    end
    if skillOrderList == nil or next(skillOrderList) then
        skillList[#skillList + 1] = role.normalSkill
        for _, skillId in ipairs(skillList) do
            local skillConfig = Config.GetSkillInfo(skillId)
            if skillConfig then
                local id = skillConfig.skillTypeId
                if skillOrderList == nil or skillOrderList[id] then
                    skillConfigList[#skillConfigList + 1] = skillConfig
                end
            end
        end

        if skillOrderList and next(skillOrderList) then
            table.sort(skillConfigList, function(a, b)
                local aIndex = skillOrderList[a.skillTypeId]
                local bIndex = skillOrderList[b.skillTypeId]
                if aIndex == bIndex then
                    return a.id < b.id
                end
                return aIndex < bIndex
            end)
        end
    end
    return skillConfigList, skillSearchData
end

---@param role BattleRole
---@param moveRange BlockData[]
---@param skillConfigList SkillTable[]
---@param skillSearchData table<integer, AiSearchAndMoveTable>?
---@return BattleBlock?, integer[]?, BattleBlock?, integer[]?
function BattleRoleAI:CheckSkillToUse(role, moveRange, skillConfigList, skillSearchData)
    if next(skillConfigList) == nil then
        return nil, nil, nil, nil
    end
	local battleMgr = BattleCore:getBattleMgr()
    local map = battleMgr:getMap()
    local skillMgr = battleMgr:getSkillManager()
	
	---@type BattleBlock[]
    local targets = {}
    local chooseBlock, skillTarget, chooseMoveBlock, path = nil, nil, nil, nil
    for _, skillConfig in ipairs(skillConfigList) do
        local skillID = skillConfig.id
		local canBeUse = role:checkSkillCanBeUse(skillID)
        if skillConfig and canBeUse == true and (skillConfig.skillType == GE.SkillType.Active
            or skillConfig.skillType == GE.SkillType.Normal) then
            local searchData = nil
            if skillSearchData then
                searchData = skillSearchData[skillConfig.skillTypeId]
            end
            local chooseRange = map:getChooseRangeByMoveRange(moveRange, skillID, role)
            ---@type integer[]
            local blockIdList = {}
            for i, v in ipairs(chooseRange) do
                blockIdList[i] = v.blockId
            end
            targets = skillMgr:GetAllSelectTarget(role, blockIdList, skillConfig)
            chooseBlock, skillTarget, chooseMoveBlock, path = self:checkSkillCanUse(skillConfig, targets, role, searchData)
            if chooseBlock then
                BattleCore.ds(role.id, "当前角色可以使用技能", skillID, skillConfig.name)
				role.selectedSkill = skillID
                break
            end
		end
    end

	return chooseBlock, skillTarget, chooseMoveBlock, path
end

---@param skillConfig SkillTable
---@param targets BattleBlock[]
---@param role BattleRole
---@param searchData AiSearchAndMoveTable?
---@return BattleBlock?, integer[]?, BattleBlock?, integer[]?
function BattleRoleAI:checkSkillCanUse(skillConfig, targets, role, searchData)
	local findSkillTargetFunc = nil
    local skillTargetFuncIds = searchData and searchData.targetList
    local moveBlockFuncId = searchData and searchData.movetype or 1
    ---@type BattleBlock[]
    local searchTarget = targets
    if skillConfig.skillOperateType == GE.SkillOperateType.Direction then
        local siftCondition = nil
        if skillTargetFuncIds then
            local funcId = skillTargetFuncIds[1]
            local d = Config.GetAiParameterInfo(funcId)
            if d then
                siftCondition = d.siftCondition
            end
        end
        return self:getRoleList6(role, targets, skillConfig, siftCondition)
    end
    ---@type boolean
    local hasSearchMoveList = false
    local passIndex = 1
    local hasSkillTargetFuncIds = skillTargetFuncIds ~= nil and next(skillTargetFuncIds)
    if hasSkillTargetFuncIds then
        for _, funId in ipairs(skillTargetFuncIds) do
            local d = Config.GetAiParameterInfo(funId)
            if d then
                local name = string.format(targetFuncName, d.siftType)
                ---@type fun(self:BattleRoleAI,role:BattleRole,blockList:BattleBlock[],skillCfg:SkillTable?,param:table?):BattleBlock[],boolean?
                findSkillTargetFunc = self[name]
                if findSkillTargetFunc then
                    local r, hasMove = findSkillTargetFunc(self, role, searchTarget, skillConfig, d.siftCondition)
                    if next(r) then
                        passIndex = passIndex + 1
                        searchTarget = r
                        if not hasSearchMoveList and hasMove then
                            hasSearchMoveList = hasMove
                        end
                        ---如果只有一个搜索目标，则直接使用
                        if #searchTarget == 1 then
                            break
                        end
                    else
                        break
                    end
                end
            end
        end
    end

    ---如果有筛选目标条件，但是没有筛选到目标，则清空搜索目标，跳过该技能释放
    if hasSkillTargetFuncIds and passIndex == 1 then
        searchTarget = {}
    end

    if hasSearchMoveList == false and #searchTarget > 1 then
        searchTarget = self:getRoleList0(role, searchTarget)
    end

    if next(searchTarget) then
        local name = string.format(blockFuncName, moveBlockFuncId)
        ---@type fun(self:BattleRoleAI,role:BattleRole,target:BattleBlock,skillConfig:SkillTable,moveList:table<integer, BlockData>):BattleBlock?,integer[]?
        local findMoveBlockFunc = self[name]
        if findMoveBlockFunc then
            local roleBlock = role:getShowBlock()
            local targetBlock = hasSearchMoveList == false and searchTarget[1] or roleBlock
            local useSkillToSelf = roleBlock.id == targetBlock.id
            ---@type table<integer, BlockData>
            local moveList = nil
            if hasSearchMoveList then
                moveList = {}
                for _, value in ipairs(searchTarget) do
                    local id = value.id
                    ---@type BlockData
                    local d = {
                        blockId = id,
                    }
                    moveList[id] = d
                end
            else
                moveList = role:getRoleKVMoveRange()
            end
            local moveBlock, movePath = findMoveBlockFunc(self, role, targetBlock, skillConfig, moveList)
            if moveBlock then
                if useSkillToSelf then
                    targetBlock = moveBlock
                end
                role:setTmpBlockForAI(moveBlock)
                local battleMgr = BattleCore:getBattleMgr()
                local skillMgr = battleMgr:getSkillManager()
                local skillBlocks = skillMgr:GetBlockDataListInSkillRangeByBlock(targetBlock, role, skillConfig)
                ---@type integer[]
                local skillTargetList = {}
                if skillBlocks then
                    local skillTargets = skillMgr:GetAllTarget(role, skillBlocks, skillConfig)
                    if next(skillTargets) then
                        for index, value in ipairs(skillTargets) do
                            skillTargetList[index] = value.id
                        end
                    end
                end
                role:setTmpBlockForAI(nil)
                return targetBlock, skillTargetList, moveBlock, movePath
            end
        end
    end
end

---获取可以被敌方攻击到的格子数据
---@param role BattleRole
---@return table<integer, integer>
function BattleRoleAI:getCanBeAttackBlockList(role)
	local block = role:getShowBlock()
    local battleMgr = BattleCore:getBattleMgr()
	local roleMgr = battleMgr:getRoleManager()
    local skillMgr = battleMgr:getSkillManager()
	local enemyCamps = roleMgr:getEnemyCamp(role.camp)
	---@type BattleRole[]
	local enemyList = {}
    local listIndex = 1
    local roleLit = roleMgr:getRolesList()
    for _, curRole in ipairs(roleLit) do
        local camp = curRole.camp
        if tablex.contains(enemyCamps, camp) then
            enemyList[listIndex] = curRole
            listIndex = listIndex + 1
        end
    end

	local result = {}
    local mapMgr = BattleCore:getBattleMgr():getMap()
    for _, v in ipairs(enemyList) do
        local roleShowBlock = v:getShowBlock()
        local dis = mapMgr:checkDistanceBetweenTwoBlock(roleShowBlock, block)
        local movePower = v:getAttrib(GE.AttribType.MovePower)
        local roleConfig = v.roleConfig
        local skillConfig = Config.GetSkillInfo(roleConfig.normalSkill)
        local range = skillMgr:GetSkillSelectRangeByRole(skillConfig, role)
        local totalRange = movePower + range[1]
        if dis <= totalRange then
            local chooseRangeIdList = v:getRoleAtkRange()
            for _, blockData in ipairs(chooseRangeIdList) do
                local curBlockId = blockData.blockId
                local curBlock = mapMgr:getBlockById(curBlockId)
                if mapMgr:getDistance(block, curBlock) <= totalRange then
                    result[curBlockId] = 1
                end
            end
        end
    end

	return result
end

function BattleRoleAI:checkPrepareSkillCanUse(role)
    local battleMgr = BattleCore:getBattleMgr()
    local map = battleMgr:getMap()
    local skillMgr = battleMgr:getSkillManager()
    local roleAIMgr = battleMgr:getBattleRoleAIManager()
    local showBlock = role:getShowBlock()
    ---@type BlockData
    local blockData = {
        blockId = showBlock.id,
        lap = 0,
    }
    local moveRange = { blockData }
    local checkList = roleAIMgr:getAIDoSkillData(role.id)
    local skillCfgList, skillSearchData = self:getSkillConfigList(role, checkList)
	---@type BattleBlock[]
    local targets = {}
    local chooseBlock, skillTarget, chooseMoveBlock = nil, nil, nil
    ---@type PrepareUseSkillData?
    local prepareData = nil
    for _, skillConfig in ipairs(skillCfgList) do
        local skillID = skillConfig.id
		local canBeUse = role:checkSkillCanBeUse(skillID)
        if skillConfig and canBeUse == true and (skillConfig.skillType == GE.SkillType.Preparatory
            or skillConfig.skillType == GE.SkillType.PreparatoryRole) then
            local chooseRange = map:getChooseRangeByMoveRange(moveRange, skillID, role)
            local blockIdList = {}
            for i, v in ipairs(chooseRange) do
                blockIdList[i] = v.blockId
            end
            local searchData = nil
            if skillSearchData then
                searchData = skillSearchData[skillConfig.skillTypeId]
            end
            targets = skillMgr:GetAllSelectTarget(role, blockIdList, skillConfig)
            chooseBlock, skillTarget, chooseMoveBlock = self:checkSkillCanUse(skillConfig, targets, role, searchData)
            if chooseBlock then
                local skillType = skillConfig.skillType
                if skillType == GE.SkillType.Preparatory or skillType == GE.SkillType.PreparatoryRole then
                    local _targetRoleId = nil
                    if skillType == GE.SkillType.PreparatoryRole then
                        _targetRoleId = chooseBlock:getTmpRoleId()
                    end
                    prepareData = {
                        skillId = skillID,
                        targetRoleId = _targetRoleId,
                        targetBlockId = chooseBlock.id,
                    }
                end
                break
            end
		end
    end
    if prepareData then
        local sourceId = role.id
        local roleAIMgr = battleMgr:getBattleRoleAIManager()
        roleAIMgr:setPrepareUseSkillData(sourceId, prepareData, true)
    end
end

---获取所处地格的cid最小的角色(保底筛选，确保目标只有一个，保证AI目标的确定性)
---@param role BattleRole
---@param blockList BattleBlock[]
---@param skillConfig SkillTable?
---@param param number[]? 技能筛选参数
---@return BattleBlock[]
function BattleRoleAI:getRoleList0(role, blockList, skillConfig, param)
    ---@type BattleBlock[]
   local result = {}
   local minId = nil
   for _, block in ipairs(blockList) do
       local id = block.cid
       if minId == nil or id < minId then
           minId = id
           result = {block}
       end
   end
   return result
end

---获取距离最近的角色
---@param role BattleRole
---@param blockList BattleBlock[]
---@param skillConfig SkillTable
---@param param number[]? 技能筛选参数
---@return BattleBlock[]
function BattleRoleAI:getRoleList1(role, blockList, skillConfig, param)
    ---@type BattleBlock[]
    local result = {}
    local minDistance = math.huge
    local map = BattleCore:getBattleMgr():getMap()
    local roleBlock = role:getShowBlock()
    for _, value in ipairs(blockList) do
        local dis = map:getDistance(roleBlock, value)
        if dis <= minDistance then
            if dis < minDistance then
                result = {}
                minDistance = dis
            end
            result[#result + 1] = value
        end
    end
    return result
end

---获取克制修正最大的角色列表
---@param role BattleRole
---@param blockList BattleBlock[]
---@param skillConfig SkillTable
---@param param number[]? 技能筛选参数
---@return BattleBlock[]
function BattleRoleAI:getRoleList2(role, blockList, skillConfig, param)
    ---@type number
    local maxNum = 0
    ---@type table<number, BattleBlock[]>
    local targetRatioList = {}
    local attribute = role.roleConfig.attribute
    local charRestraintConfig = Config.GetCharacterRestraintInfo(attribute)
    if not charRestraintConfig then
        return blockList
    end

    local ratio = charRestraintConfig.ratio
    for _, block in ipairs(blockList) do
        local r = block:tryGetRole()
        local blockList = { block }
        local isPass = self:compareTargetHpPrecent(blockList, param)
        if isPass then
            local restraintCorrect = ratio[r.restraintType] --克制修正
            if targetRatioList[restraintCorrect] == nil then
                targetRatioList[restraintCorrect] = {}
            end
            local l = targetRatioList[restraintCorrect]
            l[#l + 1] = block
            maxNum = math.max(maxNum, restraintCorrect)
        end
    end
    local checkList = targetRatioList[maxNum] or {}
    return checkList
end

---获取血量最少的角色列表
---@param role BattleRole
---@param blockList BattleBlock[]
---@param skillConfig SkillTable
---@param param number[]? 技能筛选参数
---@return BattleBlock[]
function BattleRoleAI:getRoleList3(role, blockList, skillConfig, param)
    ---@type BattleBlock[]
    local result = {}
    ---@type number
    local minNum = 1
    for _, block in ipairs(blockList) do
        local curRole = block:tryGetRole()
        local blockList = {block}
        local isPass = self:compareTargetHpPrecent(blockList, param)
        if isPass then
            local curHpPrecent = curRole:GetCurHPPrecent()
            if curHpPrecent <= minNum then
                if curHpPrecent < minNum then
                    result = {}
                    minNum = curHpPrecent
                end
                result[#result + 1] = block
            end
        end
    end
    return result
end

---获取到AOE可以覆盖到最多目标的技能释放角色列表(目标为角色的技能)
---@param role BattleRole
---@param blockList BattleBlock[]
---@param skillConfig SkillTable
---@param param number[]? 技能筛选参数
---@return BattleBlock[]
function BattleRoleAI:getRoleList4(role, blockList, skillConfig, param)
    local battleMgr = BattleCore:getBattleMgr()
    local skillMgr = battleMgr:getSkillManager()
    local maxPassNum = 0
    local maxTargetNum = 0
    local result = {}
    for _, block in ipairs(blockList) do
        local blockRole = block:tryGetRole()
        local skillBlocks = skillMgr:GetBlockDataListInSkillRange(blockRole, role, skillConfig)
        if skillBlocks then
            local skillTargets = skillMgr:GetAllTarget(role, skillBlocks, skillConfig)
            local isPass, targetCount, passNum = self:compareTargetHpPrecent(skillTargets, param)
            if isPass and targetCount >= maxTargetNum then
                ---更新最大目标数量
                if targetCount > maxTargetNum then
                    result = {}
                    maxTargetNum = targetCount
                    maxPassNum = passNum
                ---当最大目标相等时，取最大通过数量的地格，并更新最大通过数量
                elseif targetCount == maxTargetNum then
                    if passNum > maxPassNum then
                        result = {}
                        maxPassNum = passNum
                    end
                end
                result[#result + 1] = block
            end
        end
    end
    return result
end

---获取直接释放类技能覆盖到最多目标的方法，因直接释放类技能会直接在自身所处位置释放技能，故无需寻找移动位置
---@param role BattleRole
---@param blockList BattleBlock[]
---@param skillConfig SkillTable
---@param param number[]? 技能筛选参数
---@return BattleBlock[], boolean 是否包含移动地格
function BattleRoleAI:getRoleList5(role, blockList, skillConfig, param)
    local battleMgr = BattleCore:getBattleMgr()
    local skillMgr = battleMgr:getSkillManager()

    local moveRange = role:getRoleMoveRange()

    local maxPassNum = 0
    local result = {}

    for _, blockData in ipairs(moveRange) do
        local blockId = blockData.blockId
        local block = battleMgr:getBlockById(blockId)
        if block then
            local blockRoleId = block:getTmpRoleId()
            if blockRoleId == nil or blockRoleId == role.id then
                ---将角色模拟移动到当前位置获取相关技能覆盖范围信息，方便后续技能筛选目标
                role:setTmpBlockForAI(block)
                local skillBlocks = skillMgr:GetBlockDataListInSkillRangeByBlock(block, role, skillConfig)
                if skillBlocks then
                    local skillTargets = skillMgr:GetAllTarget(role, skillBlocks, skillConfig)
                    local isPass, targetCount = self:compareTargetHpPrecent(skillTargets, param)
                    if isPass and targetCount >= maxPassNum then
                        if targetCount > maxPassNum then
                            result = {}
                            maxPassNum = targetCount
                        end
                        result[#result + 1] = block
                    end
                end
            end
        end
    end
    ---查询结束后清理临时状态，防止后续计算出错，影响表现
    role:setTmpBlockForAI(nil)
    return result, true
end

---获取到指向类技能的目标列表
---@param role BattleRole
---@param blockList BattleBlock[]
---@param skillConfig SkillTable
---@param param number[]? 技能筛选参数
---@return BattleBlock? 技能选择地格
---@return integer[]? 技能目标列表
---@return BattleBlock? 技能移动地格
---@return integer[]? 移动地格经过路径
function BattleRoleAI:getRoleList6(role, blockList, skillConfig, param)
    ---@type BattleBlock?
    local chooseBlock = nil
    ---@type BattleBlock?
    local moveBlock = nil
    ---@type integer[]?
    local skillTargets = nil
    ---@type integer[]?
    local path = nil
    local battleMgr = BattleCore:getBattleMgr()
    local skillMgr = battleMgr:getSkillManager()
    local mapMgr = battleMgr:getMap()
    ---@type BattleRole[]
    local checkRoleList = {}
    for _, value in ipairs(blockList) do
        local r = value:tryGetRole()
        if r then
            checkRoleList[#checkRoleList + 1] = r
        end
    end
    local checkRoleBlockIdList = {}
    local skillEffectRange = skillMgr:GetSkillEffectRangeByRole(skillConfig, role)
    local width = skillEffectRange[1]
    if not width or width <= 0 then
        return nil
    end
    local skillWidth = (width - 1) / 2
    local skillLength = skillEffectRange[2]
    if not skillLength or skillLength <= 0 then
        return nil
    end
    local moveRangeKVList = role:getRoleKVMoveRange()
    local roleBlock = role:getShowBlock()
    local checkNum = 1
    if param and param[2] then
        checkNum = param[2]
    end
    local count = #checkRoleList
    ---如果当前角色周围可覆盖目标数量大于等于最小检测数量，则进行后续检测
    if count >= checkNum then
        ---@class chooseAndMoveBlockData
        ---@field chooseBlock BattleBlock 选择的格子
        ---@field moveBlock BattleBlock 移动的格子
        ---@field skillTargets integer[] 技能目标列表
        ---@field recoverRoleNum integer 技能覆盖的目标数量

        ---@type chooseAndMoveBlockData[]
        local chooseAndMoveBlockList = {}
        ---@type table<integer, integer>
        local roundRoleNumList = {}
        local compareWight = width - 1
        local compareLength = skillLength - 1
        for i = 1, count, 1 do
            local checkRole = checkRoleList[i]
            local roleId = checkRole.id
            roundRoleNumList[roleId] = 1
            local roleBlock1 = checkRole:getShowBlock()
            checkRoleBlockIdList[roleBlock1.id] = 1
            for _, blockRole in ipairs(checkRoleList) do
                if blockRole.id ~= checkRole.id then
                    local targetBlock = blockRole:getShowBlock()
                    local absRow = math.abs(roleBlock1.row - targetBlock.row)
                    local absCol = math.abs(roleBlock1.col - targetBlock.col)
                    local checkOutLIst = {
                        {compareWight, compareLength},
                        {compareLength, compareWight},
                    }
                    local isInRect = false
                    for _, value in ipairs(checkOutLIst) do
                        local widthValue = value[1]
                        local lengthValue = value[2]
                        if (absRow <= widthValue and absCol <= lengthValue) or
                            (absRow <= lengthValue and absCol <= widthValue) then
                            isInRect = true
                            break
                        end
                    end
                    if isInRect then
                        roundRoleNumList[roleId] = roundRoleNumList[roleId] + 1
                    end
                end
            end
        end

        ---对目标进行排序，按周围角色数量从大到小排序
        ---如果数量相同，则按距离从近到远排序
        ---如果距离相同，则按实例化id从小到大排序
        table.sort(checkRoleList, function(a, b)
            local aId = a.id
            local bId = b.id
            local aNum = roundRoleNumList[aId] or 0
            local bNum = roundRoleNumList[bId] or 0
            if aNum == bNum then
                local aDis = mapMgr:checkDistanceBetweenTwoBlock(roleBlock, a:getShowBlock())
                local bDis = mapMgr:checkDistanceBetweenTwoBlock(roleBlock, b:getShowBlock())
                if aDis == bDis then
                    return aId < bId
                end
                return aDis < bDis
            end
            return aNum > bNum
        end)

        local maxRecoverRoleNum = 0

        for i = 1, count, 1 do
            local checkRole = checkRoleList[i]
            --如果当前角色可以覆盖的目标数量已经不大于最大数量，则不需要继续检测
            if maxRecoverRoleNum >= roundRoleNumList[checkRole.id] then
                break
            end
            local roleBlock1 = checkRole:getShowBlock()
            local blockRow = roleBlock1.row
            local blockCol = roleBlock1.col
            local curRoleMaxRecoverRoleNum = 0

            for _, dirValue in ipairs(skillDir) do
                for i = skillLength, 1, -1 do
                    local minRowOffset = -skillWidth
                    for j = skillWidth, minRowOffset, -1 do
                        local newRow, newCol = 0, 0
                        if dirValue[2] ~= 0 then
                            newRow = dirValue[2] * (i - 1) + blockRow
                            newCol = j + blockCol
                        else
                            newCol = dirValue[1] * (i - 1) + blockCol
                            newRow = j + blockRow
                        end
                        local chooseBlockId = mapMgr:getBlockId(newCol, newRow)
                        local chooseBlock = mapMgr:getBlockById(chooseBlockId)
                        local isPass = false
                        if chooseBlockId > -1 then
                            isPass = true
                            local needCheck = skillConfig.isTorpdeo == 1
                            if needCheck then
                                ---鱼雷类技能需要检测当前地格是否阻挡鱼雷
                                if chooseBlock and chooseBlock:GetBlockCanBlockTorpedo() then
                                    isPass = false
                                end
                            end
                        end
                        if isPass then
                            local moveBlockRow = newRow + dirValue[2]
                            local moveBlockCol = newCol + dirValue[1]
                            local moveBlockId = mapMgr:getBlockId(moveBlockCol, moveBlockRow)
                            local moveBlock = mapMgr:getBlockById(moveBlockId)
                            ---如果移动格子在可移动范围内，获取到当前选中格子可以覆盖的目标数量
                            if moveBlockId > -1 and moveRangeKVList[moveBlockId]
                                and (moveBlock:getTmpRoleId() == nil or moveBlock:getTmpRoleId() == role.id) then
                                local recoverRoleNum = 0
                                ---@type integer[] 技能可以覆盖到的地格id列表
                                local recoverRoleidList = {}
                                local skillRangeList = mapMgr:getDirectionDiffuseRange(moveBlock, chooseBlock, skillEffectRange)
                                for _, value in ipairs(skillRangeList) do
                                    if checkRoleBlockIdList[value.blockId] then
                                        recoverRoleNum = recoverRoleNum + 1
                                    end
                                    recoverRoleidList[#recoverRoleidList + 1] = value.blockId
                                end
                                if recoverRoleNum > 0 and recoverRoleNum >= curRoleMaxRecoverRoleNum then
                                    if recoverRoleNum > curRoleMaxRecoverRoleNum then
                                        chooseAndMoveBlockList = {}
                                        curRoleMaxRecoverRoleNum = recoverRoleNum
                                    end

                                    chooseAndMoveBlockList[#chooseAndMoveBlockList + 1] = {
                                        chooseBlock = chooseBlock,
                                        moveBlock = moveBlock,
                                        skillTargets = recoverRoleidList,
                                        recoverRoleNum = recoverRoleNum,
                                    }
                                end
                            end
                        end
                    end
                end
            end
            if next(chooseAndMoveBlockList) and curRoleMaxRecoverRoleNum > maxRecoverRoleNum then
                table.sort(chooseAndMoveBlockList, function(a, b)
                    local aMovePath = mapMgr:getDistance(roleBlock, a.moveBlock)
                    local bMovePath = mapMgr:getDistance(roleBlock, b.moveBlock)
                    if aMovePath == bMovePath then
                        return a.moveBlock.id < b.moveBlock.id
                    end
                    return aMovePath < bMovePath
                end)
                local chooseData = chooseAndMoveBlockList[1]
                chooseBlock = chooseData.chooseBlock
                moveBlock = chooseData.moveBlock
                skillTargets = chooseData.skillTargets
                path = mapMgr:getShortestPath(roleBlock.id, moveBlock.id, moveRangeKVList)
                maxRecoverRoleNum = curRoleMaxRecoverRoleNum
            end
        end
    end
    if skillTargets and next(skillTargets) then
        local checkList = {}
        for _, value in ipairs(skillTargets) do
            local block = mapMgr:getBlockById(value)
            if block then
                checkList[#checkList + 1] = block
            end
        end
        local isPass = self:compareTargetHpPrecent(checkList, param)
        if isPass then
            return chooseBlock, skillTargets, moveBlock, path
        end
    end
end

---比较目标列表的血量百分比,如果目标列表中有超过指定血量百分比的目标数量大于等于指定数量，则返回true
---否则返回false
---@param targetList BattleBlock[]
---@param param number[]?
---@return boolean 是否满足技能额外需求
---@return integer 当前技能覆盖的目标数量
---@return integer 符合当前技能额外要求的数量
function BattleRoleAI:compareTargetHpPrecent(targetList, param)
    local targetCount = #targetList
    if not param then
        return true, targetCount, targetCount
    end
    local checkNum = param[1] or 1
    local checkPassNum = param[2] or 1
    local maxPassNum = 0
    for _, block in ipairs(targetList) do
        local r = block:tryGetRole()
        local hpPrecent = r ~= nil and r:GetCurHPPrecent() or 2
        if hpPrecent <= checkNum then
            maxPassNum = maxPassNum + 1
        end
    end
    return maxPassNum >= checkPassNum, targetCount, maxPassNum
end

---获取所有可以攻击目标地格的地格列表
---@param sourceBlock BattleBlock
---@param targetBlock BattleBlock
---@param skillConfig SkillTable
---@param moveList table<integer, BlockData>
---@return BattleBlock[]
function BattleRoleAI:getAllCanAttackTargetBlock(sourceBlock, targetBlock, skillConfig, moveList)
    local sourceRole = sourceBlock:tryGetRole()
    local mapMgr = BattleCore:getBattleMgr():getMap()
    ---@type BattleBlock[]
    local checkList = {}
    if targetBlock.id == sourceBlock.id then
        for _, value in pairs(moveList) do
            local block = mapMgr:getBlockById(value.blockId)
            local blockRoleId = block:getTmpRoleId()
            if not blockRoleId or blockRoleId == sourceRole.id then
                checkList[#checkList + 1] = block
            end
        end
        return checkList
    end

    local skillMgr = BattleCore:getSkillMgr()
    local skillRange = skillMgr:GetSkillSelectRangeByRole(skillConfig, sourceRole)
    local endIndex = skillConfig.deleteRange
    local list = nil
    local listIndex = 1
    list = mapMgr:getDiffuseRange(skillConfig.skillSelectType, targetBlock, skillRange, targetBlock, 0, endIndex)
    for _, data in ipairs(list) do
        local blockId = data.blockId
        if moveList[blockId] ~= nil then
            local block = mapMgr:getBlockById(blockId)
            if not block:getTmpRoleId() or blockId == sourceBlock.id then
                local isPass = true
                local lineBlock = nil
                if skillConfig.isTorpdeo == 1 then
                    lineBlock = skillMgr:checkTorpedoSkillCanAttack(block, targetBlock)
                    isPass = lineBlock == nil
                end
                if isPass then
                    checkList[listIndex] = block
                    listIndex = listIndex + 1
                end
            end
        end
    end
    return checkList
end

---在目标列表里找到距离自身最近的地格
---@param sourceBlock BattleBlock 起始点地格
---@param blockList BattleBlock[] 检测的地格列表
---@return BattleBlock[] 最近的地格
function BattleRoleAI:getShortestPathBlock(sourceBlock, blockList)
    if #blockList == 1 then
        return blockList
    end
    local mapMgr = BattleCore:getBattleMgr():getMap()
    local minPathCount = math.huge
    ---@type BattleBlock[]
    local checkBlockList = {}
    for _, block in ipairs(blockList) do
        if block.id == sourceBlock.id then
            checkBlockList = {block}
            break
        end
        local dis = mapMgr:getDistance(sourceBlock, block)
        if dis <= minPathCount then
            if dis < minPathCount then
                checkBlockList = {}
                minPathCount = dis
            end
            checkBlockList[#checkBlockList + 1] = block
        end
    end
    return checkBlockList
end

---获得自身往技能目标移动消耗最小的格子
---@param role BattleRole
---@param target BattleBlock
---@param skillConfig SkillTable
---@param moveList table<integer, BlockData>
---@return BattleBlock?, integer[]?
function BattleRoleAI:getMoveBlock1(role, target, skillConfig, moveList)
    local sourceBlock = role:getShowBlock()
    ---对自身释放技能，不需要移动
    if sourceBlock.id == target.id then
        return sourceBlock, {}
    end
    local checkList = self:getAllCanAttackTargetBlock(sourceBlock, target, skillConfig, moveList)
    local result = self:getShortestPathBlock(sourceBlock, checkList)
    local minCid = math.huge
    local r = nil
    for _, value in ipairs(result) do
        if value.cid < minCid then
            minCid = value.cid
            r = value
        end
    end
    if r then
        local map = BattleCore:getBattleMgr():getMap()
        local path = map:getShortestPath(sourceBlock.id, r.id, moveList)
        return r, path
    end
end

---获得距离技能目标目标最近的格子
---@param role BattleRole
---@param target BattleBlock
---@param skillConfig SkillTable
---@param moveList table<integer, BlockData>
---@return BattleBlock?, integer[]?
function BattleRoleAI:getMoveBlock2(role, target, skillConfig, moveList)
    local sourceBlock = role:getShowBlock()
    ---对自身释放技能，不需要移动
    if sourceBlock.id == target.id then
        return sourceBlock, {}
    end
    local checkList = self:getAllCanAttackTargetBlock(sourceBlock, target, skillConfig, moveList)
    local result = self:getShortestPathBlock(sourceBlock, checkList)
    local minCid = math.huge
    local r = nil
    for _, value in ipairs(result) do
        if value.cid < minCid then
            minCid = value.cid
            r = value
        end
    end
    if r then
        local map = BattleCore:getBattleMgr():getMap()
        local path = map:getShortestPath(sourceBlock.id, r.id, moveList)
        return r, path
    end
end

---获得距离自身所处格子的移动距离最近的指定阵营角色,无视敌方占据的格子 
---@param role BattleRole
---@param campDic table<BattleCampType, integer> 阵营字典
---@param moveList table<integer, BlockData> 可移动范围
---@return BattleRole? 最近的角色, integer[]? 移动路径
function BattleRoleAI:getNearestRoleByCamp(role, campDic, moveList)
    local battleMgr = BattleCore:getBattleMgr()
    local roleMgr = battleMgr:getRoleManager()
    local sourceBlock = role:getShowBlock()
    ---@type BattleRole[]
    local roleList = {}
    local allRoleList = roleMgr:getRolesList()
    local camps = roleMgr:getEnemyCamp(role.camp)
    local isEnemyCamp = not (tablex.contains(camps, role.camp))
    for _, r in ipairs(allRoleList) do
        if campDic[r.camp] ~= nil and r.id ~= role.id then
            local canBeSelect = true
            if isEnemyCamp then
                canBeSelect = battleMgr:compareRoleskillSelectState(r, isEnemyCamp)
            end
            if canBeSelect then
                roleList[#roleList + 1] = r
            end
        end
    end
    local minMoveCost = nil
    ---@class checkRoleData
    ---@field [1] BattleRole 角色
    ---@field [2] integer[] 移动路径

    ---@type checkRoleData[]?
    local checkRoleList = nil
    local listIndex = 0
    local sourceBlockId = sourceBlock.id
    local map = battleMgr:getMap()
    for _, r in ipairs(roleList) do
        local block = r:getShowBlock()
        local blockId = block.id
        local movePath = map:getShortestPath(sourceBlockId, blockId, moveList)
        local pathCount = #movePath
        if next(movePath) and (minMoveCost == nil or minMoveCost >= pathCount) then
            if minMoveCost == nil or pathCount < minMoveCost then
                checkRoleList = {}
                listIndex = 0
                minMoveCost = pathCount
            end
            listIndex = listIndex + 1
            checkRoleList[listIndex] = {r, movePath}
        end
    end
    if not checkRoleList then
        return nil
    elseif listIndex > 1 then
        table.sort(checkRoleList, function (a, b)
            local aBlock = a[1]:getShowBlock()
            local bBlock = b[1]:getShowBlock()
            return aBlock.cid < bBlock.cid
        end)
    end
    local r = checkRoleList[1]
    return r[1], r[2]
end

---获得距离自身所处格子的移动距离最近的友方移动距离最近的格子
---@param role BattleRole
---@param target BattleBlock
---@param skillConfig SkillTable
---@param moveList table<integer, BlockData>
---@return BattleBlock?, integer[]?
function BattleRoleAI:getMoveBlock3(role, target, skillConfig, moveList)
    local battMgr = BattleCore:getBattleMgr()
    local sourceBlock = role:getShowBlock()
    local roleMgr = battMgr:getRoleManager()
    local camps = roleMgr:getFriendCamp(role.camp)
    local map = battMgr:getMap()
    ---@type table<BattleCampType, integer>
    local campDic = {}
    for _, camp in ipairs(camps) do
        campDic[camp] = 1
    end
    local moveType = role.moveType
    local moveRange = map:getCanMoveRangeByMoveType(moveType)
    local minMoveRole = self:getNearestRoleByCamp(role, campDic, moveRange)
    if not minMoveRole then
        return nil
    end
    local minMoveBlock = minMoveRole:getShowBlock()
    local checkList = self:getAllCanAttackTargetBlock(sourceBlock, target, skillConfig, moveList)
    local moveBlocks = self:getShortestPathBlock(minMoveBlock, checkList)
    if next(moveBlocks) then
        local result = self:getShortestPathBlock(sourceBlock, moveBlocks)
        local minCid = math.huge
        local r = nil
        if next(result) then
            for _, value in ipairs(result) do
                if value.cid < minCid then
                    minCid = value.cid
                    r = value
                end
            end
            if r then
                local map = BattleCore:getBattleMgr():getMap()
                local roleMoveRange = role:getRoleKVMoveRange()
                local movePath1 = map:getShortestPath(sourceBlock.id, r.id, roleMoveRange)
                return r, movePath1
            end
        end
    end
end

---获得距离自身所处格子的移动距离最近的敌方，的移动距离最近的格子
---@param role BattleRole
---@param target BattleBlock
---@param skillConfig SkillTable
---@param moveList table<integer, BlockData> 当前自身移动范围
---@return BattleBlock?, integer[]?
function BattleRoleAI:getMoveBlock4(role, target, skillConfig, moveList)
    local battMgr = BattleCore:getBattleMgr()
    local sourceBlock = role:getShowBlock()
    local roleMgr = battMgr:getRoleManager()
    local camps = roleMgr:getEnemyCamp(role.camp)
    ---@type table<BattleCampType, integer>
    local campDic = {}
    for _, camp in ipairs(camps) do
        campDic[camp] = 1
    end
    local map = battMgr:getMap()
    local moveType = role.moveType
    local moveRange = map:getCanMoveRangeByMoveType(moveType)
    local minMoveRole = self:getNearestRoleByCamp(role, campDic, moveRange)
    if not minMoveRole then
        return nil
    end
    local minMoveBlock = minMoveRole:getShowBlock()
    local checkList = self:getAllCanAttackTargetBlock(sourceBlock, target, skillConfig, moveList)
    local moveBlocks = self:getShortestPathBlock(minMoveBlock, checkList)
    if next(moveBlocks) then
        local result = self:getShortestPathBlock(sourceBlock, moveBlocks)
        local minCid = math.huge
        local r = nil
        if next(result) then
            for _, value in ipairs(result) do
                if value.cid < minCid then
                    minCid = value.cid
                    r = value
                end
            end
            if r then
                local map = BattleCore:getBattleMgr():getMap()
                local roleMoveRange = role:getRoleKVMoveRange()
                local movePath1 = map:getShortestPath(sourceBlock.id, r.id, roleMoveRange)
                return r, movePath1
            end
        end
    end
end

--region 没有可释放技能，查询移动目标格子

---@param role BattleRole
---@return BattleBlock?, integer[]?
function BattleRoleAI:getNoTargetMoveBlock1(role)
    local battMgr = BattleCore:getBattleMgr()
    local roleMgr = battMgr:getRoleManager()
    local camps = roleMgr:getEnemyCamp(role.camp)
    ---@type table<BattleCampType, integer>
    local campDic = {}
    for _, camp in ipairs(camps) do
        campDic[camp] = 1
    end
    local moveType = role.moveType
    local map = battMgr:getMap()
    local moveList = map:getCanMoveRangeByMoveType(moveType)
    local minMoveRole = self:getNearestRoleByCamp(role, campDic, moveList)
    if minMoveRole then
        local withoutEnemyMoveList = map:getCanMoveRangeByMoveType(moveType, role.camp)
        local startBlock = role:getShowBlock()
        local block = map:getNearsetNoEnemyBlockByBlock(minMoveRole:getShowBlock(), role, moveList)
        if block then
            local curMoveKVRange = role:getRoleKVMoveRange()
            local offsetCostDic = role:getMoveCostOffset()
            local path = map:getAStarPath(startBlock.id, block.id, withoutEnemyMoveList, moveType, curMoveKVRange, offsetCostDic)
            if path then
                return block, path
            end
        end
    end
end

---@param role BattleRole
---@return BattleBlock?, integer[]?
function BattleRoleAI:getNoTargetMoveBlock2(role)
    return nil, nil
end

---获取仅移动角色的移动路径
---@param role BattleRole
---@return BattleBlock?, integer[]?
function BattleRoleAI:getNoTargetMoveBlock3(role)
    local battleMgr = BattleCore:getBattleMgr()
    local roleAIMgr = battleMgr:getBattleRoleAIManager()
    local map = battleMgr:getMap()
    local roleId = role.id
    local blockId = roleAIMgr:getOnlyMoveRoleCurTargetBlockId(roleId)
    if blockId then
        local moveType = role.moveType
        local withoutEnemyMoveList = map:getCanMoveRangeByMoveType(moveType)
        local startBlock = role:getShowBlock()
        local targetBlock = map:getBlockById(blockId)
        if targetBlock then
            local block = map:getNearsetNoEnemyBlockByBlock(targetBlock, role, withoutEnemyMoveList)
            if block then
                local path = map:getAStarPath(startBlock.id, block.id, withoutEnemyMoveList)
                if path then
                    return block, path
                end
            end
        end
    end
end

---朝最近的友军移动
---@param role BattleRole
---@return BattleBlock?, integer[]?
function BattleRoleAI:getNoTargetMoveBlock4(role)
    local battMgr = BattleCore:getBattleMgr()
    local roleMgr = battMgr:getRoleManager()
    local camps = roleMgr:getFriendCamp(role.camp)
    ---@type table<BattleCampType, integer>
    local campDic = {}
    for _, camp in ipairs(camps) do
        campDic[camp] = 1
    end
    local moveType = role.moveType
    local map = battMgr:getMap()
    local moveList = map:getCanMoveRangeByMoveType(moveType)
    local minMoveRole = self:getNearestRoleByCamp(role, campDic, moveList)
    if minMoveRole then
        local withoutEnemyMoveList = map:getCanMoveRangeByMoveType(moveType, role.camp)
        local startBlock = role:getShowBlock()
        local block = minMoveRole:getShowBlock()
        local curMoveKVRange = role:getRoleKVMoveRange()
        local path = map:getAStarPath(startBlock.id, block.id, withoutEnemyMoveList, moveType, curMoveKVRange)
        if path then
            return block, path
        end
    end
end

---朝离敌军最近的友军移动
---@param role BattleRole
---@return BattleBlock?, integer[]?
function BattleRoleAI:getNoTargetMoveBlock5(role)
    local battMgr = BattleCore:getBattleMgr()
    local roleMgr = battMgr:getRoleManager()
    local roleCamp = role.camp
    local camps = roleMgr:getEnemyCamp(roleCamp)
    ---@type table<BattleCampType, integer>
    local campDic = {}
    for _, camp in ipairs(camps) do
        campDic[camp] = 1
    end
    local roleList = roleMgr:getRolesList()
    ---@type BattleRole[]
    local friendRoleList = {}
    for _, curRole in ipairs(roleList) do
        if curRole.id ~= role.id then
            local isEnemyCamp = (roleMgr:isEnemyCampByCamp(roleCamp, curRole.camp))
            if isEnemyCamp == false then
                friendRoleList[#friendRoleList + 1] = curRole
            end
        end
    end
    ---@type BattleBlock[]
    local checkResultList = {}
    local minNum = math.huge
    local map = battMgr:getMap()
    ---@type table<integer, table<integer, BlockData>>
    local moveRangeByMoveTypeDic = {}
    for _, friendRole in ipairs(friendRoleList) do
        local moveType = friendRole.moveType
        if not moveRangeByMoveTypeDic[moveType] then
            moveRangeByMoveTypeDic[moveType] = map:getCanMoveRangeByMoveType(moveType)
        end
        local moveList = moveRangeByMoveTypeDic[moveType]
        local _, roleMovePath = self:getNearestRoleByCamp(friendRole, campDic, moveList)
        if roleMovePath then
            local count = #roleMovePath
            if count < minNum then
                checkResultList = {}
                minNum = count
            end
            if count == minNum then
                local roleBlock = friendRole:getShowBlock()
                checkResultList[#checkResultList + 1] = roleBlock
            end
        end
    end
    if tablex.next(checkResultList) then
        local moveType = role.moveType
        local blockList = self:getRoleList0(role, checkResultList)
        local minRoleBlock = blockList[1]
        local minMoveRole = minRoleBlock and minRoleBlock:tryGetRole()
        if minMoveRole then
            local withoutEnemyMoveList = map:getCanMoveRangeByMoveType(moveType, role.camp)
            local startBlock = role:getShowBlock()
            local block = minMoveRole:getShowBlock()
            local curMoveKVRange = role:getRoleKVMoveRange()
            local path = map:getAStarPath(startBlock.id, block.id, withoutEnemyMoveList, moveType, curMoveKVRange)
            if path then
                return block, path
            end
        end
    end
end

--endregion

return BattleRoleAI