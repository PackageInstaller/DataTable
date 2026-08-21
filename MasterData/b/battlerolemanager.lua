require "class"
---@class BattleRoleManager:BaseClass
local BattleRoleManager = class("BattleRoleManager")
local BattleRole = require "BattleRole"
local BattleCore = require "BattleCore"

function BattleRoleManager:ctor()
    BattleCore.ds("BattleRoleManager:ctor")
    self:initManager()
end

---实例化
---@return BattleRoleManager BattleRoleManager
function BattleRoleManager.instance()
	if (BattleRoleManager._instance == nil) then
		BattleRoleManager._instance = BattleRoleManager:new()
	end
	return BattleRoleManager._instance
end

---初始化管理器
function BattleRoleManager:initManager()
    self._tmpId = 1
    ---@type BattleRole[]
    self._roleList = {}
    self._tmpActionCompletedRoles = {}
    self._camps = {GE.BattleCampType.Friend, GE.BattleCampType.FriendNPC, GE.BattleCampType.Enemy}
    self._actionCampIndex = 1
    self._manualCamp = GE.BattleCampType.Friend

    self._formationRolesCount = 0
    self._defeatRoleList = {}
    ---@type BattleRole[]
    self._curRoundDefeatRoleList = {}
    ---@type BattleTimeDefeatRoleData[]
    self.curBattleTimeDefeatRoles = {}
    self._roundIndex = 1
    self._lockRole = nil
end

---重置基本角色信息
---@param mainRole integer
---@param rolesData BaseRolesData
function BattleRoleManager:resetBaseRolesData(mainRole, rolesData)
    self._roleList = {}
    self._defeatRoleList = {}
    self._curRoundDefeatRoleList = {}
	local battleMgr = BattleCore:getBattleMgr()
    local roleAIMgr = battleMgr:getBattleRoleAIManager()
    local hasActiveGroupIDList = roleAIMgr:getActiveGroupList()
    for _, roleData in ipairs(rolesData.roleList) do
        local block = battleMgr:getBlockById(roleData.blockId)
        local groupId = roleData.group
        ---@type LevelRoleData
        local data = {
            block = block,
            id = roleData.id,
			cid = roleData.cid,
            camp = roleData.camp,
            isFormationState = false,
            isMonster = roleData.isMonster,
            level = roleData.level,
			showLevel = roleData.showLevel,
            direction = roleData.direction,
            group = groupId,
            isShowEffect = false,
        }
        ---@type BattleRole
        local role = BattleRole:new(data, self, true)
        table.insert(self._roleList, role)
        role:resetBaseData(roleData)
        role:SetActiveState(hasActiveGroupIDList[groupId] ~= nil)
        local summonEffectId = roleData.summonEffectId
        if summonEffectId > 0 then
            local attribList = battleMgr:GetSummonRoleBaseAttribList(summonEffectId, role.id)
            if attribList then
                for key, value in pairs(attribList) do
                    role:setBaseAttrib(key, value)
                end
            end
        end
    end
    for _, roleData in ipairs(rolesData.defeatRoleList) do
        --- 被击败角色不需要设置格子信息
        -- local block = battleMgr:getBlockById(roleData.blockId)
        local groupId = roleData.group
        ---@type LevelRoleData
        local data = {
            block = nil,
            id = roleData.id,
			cid = roleData.cid,
            camp = roleData.camp,
            isFormationState = false,
            isMonster = roleData.isMonster,
            level = roleData.level,
			showLevel = roleData.showLevel,
            direction = roleData.direction,
            group = groupId,
        }
        ---@type BattleRole
        local role = BattleRole:new(data, self, true)
        table.insert(self._defeatRoleList, role)
        role:resetBaseData(roleData)
        -- role:SetActiveState(hasActiveGroupIDList[groupId] ~= nil)
    end

    self._tmpActionCompletedRoles = tablex.copy(rolesData.tmpActionCompletedRoles)
    -- self._camps = tablex.copy(rolesData.camps)
    self._actionCampIndex = rolesData.actionCampIndex

    if (mainRole) then
        local role = self:getRole(mainRole)
        local showMgr = battleMgr:getShowManager()
        if (showMgr) then
            showMgr:lookAtBlock(role:getShowBlock().id, {time = 1})
        end
    end
end

---重置后刷新光环和Buff
function BattleRoleManager:resetRoleBlockEffectAndBuff()
    for _, role in ipairs(self._roleList) do
        role:checkBlockEffect()
        role:UpdateAllBuff()
    end
end

function BattleRoleManager:confirmResetRoleData()
    self:calculateAllRolesActionRange()
end

---@class BaseRolesData
---@field tmpActionCompletedRoles integer[] 完成行动的BattleRole的id
-- ---@field camps BattleCampType[]
---@field actionCampIndex BattleCampType
---@field roleList RoleBaseData[]
---@field defeatRoleList RoleBaseData[] 被击败的舰船信息

---获取基本角色信息
---@return BaseRolesData
function BattleRoleManager:getBaseRolesData()
    local roleList = {}
    local defeatRoleList = {}
    for _, role in ipairs(self._roleList) do
        table.insert(roleList, role:getBaseData())
    end
    for _, role in ipairs(self._defeatRoleList) do
        table.insert(defeatRoleList, role:getBaseData())
    end

    ---@type BaseRolesData
	local data = {
        tmpActionCompletedRoles = tablex.copy(self._tmpActionCompletedRoles),
        -- camps = tablex.copy(self._camps),
        actionCampIndex = self._actionCampIndex,
        roleList = roleList,
        defeatRoleList = defeatRoleList,
    }
	return data
end

---@class LevelRoleData
---@field id integer?
---@field block BattleBlock?
---@field camp BattleCampType
---@field cid integer
---@field isFormationState boolean?
---@field isMonster boolean
---@field level integer?
---@field showLevel integer?
---@field group integer?
---@field serverData HeroInfo?
---@field activeAIId integer?
---@field unactiveAIId integer?
---@field baseMaxHp integer?
---@field isShowEffect boolean? 是否播放粒子特效和声音

---@param levelConfig PveLevelTable
---@return BattleRole[]
function BattleRoleManager:createEnemies(levelConfig)
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    local result = {}
    local hasRegisterAIEventGroupIdList = {}
    local levelCfg = battleMgr:getLevelConfig()
    local aiActiveData = levelCfg.aiWakeCondition
    if aiActiveData then
        for _, data in ipairs(aiActiveData) do
            local groupId = data.group
            hasRegisterAIEventGroupIdList[groupId] = 1
        end
    end
	for _, enemyInfo in ipairs(levelConfig.monsterInfo) do
        local roleCfgId = enemyInfo.id
        local roleCfg = Config.GetMonsterInfo(roleCfgId)
        local checkBlock = mapMgr:getBlockByCid(enemyInfo.position)
        local block = mapMgr:getNearsetNoOneBlockByBlock(checkBlock, roleCfg.moveType)
        if block then
            local roleGroupId = enemyInfo.group
            if roleGroupId then
                ---防止出现未配置激活事件的角色组id，导致角色无法被激活
                if not hasRegisterAIEventGroupIdList[roleGroupId] then
                    roleGroupId = 0
                    BattleCore.ds("怪物组id", enemyInfo.group, "未配置AI激活事件，已默认设置为0，检查配置")
                end
            end
            ---@type LevelRoleData
            local data = {
                block = block,
                camp = GE.BattleCampType.Enemy,
                cid = roleCfgId,
                isFormationState = false,
                isMonster = true,
                level = enemyInfo.level or levelConfig.level,
                showLevel = levelConfig.showLevel,
                group = roleGroupId,
                direction = enemyInfo.direction,
                delay = enemyInfo.delay or 0,
                activeAIId = enemyInfo.active or 1002,
                unactiveAIId = enemyInfo.unactive or 1001,
                isShowEffect = false,
            }
            local role = self:createRole(data)
            table.insert(result, role)
        else
            BattleCore.es("未能找到人物初始生成格子，检查配置")
        end
	end
    return result
end

---@param levelConfig PveLevelTable
---@return BattleRole[]
function BattleRoleManager:createNpcs(levelConfig)
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    local result = {}
	for _, npcInfo in ipairs(levelConfig.npcInfo) do
        local roleCfgId = npcInfo.id
        local roleCfg = nil
        if npcInfo.is_hero == 2 then
            roleCfg = Config.GetMonsterInfo(roleCfgId)
        else
            roleCfg = Config.GetCharacterInfo(roleCfgId)
        end
        local checkBlock = mapMgr:getBlockByCid(npcInfo.position)
        local block = mapMgr:getNearsetNoOneBlockByBlock(checkBlock, roleCfg.moveType)
        local camp = npcInfo.calltype
        if block then
            ---@type LevelRoleData
            local data = {
                block = block,
                camp = camp,
                cid = roleCfgId,
                isMonster = npcInfo.is_hero == 2,
                level = npcInfo.level or levelConfig.level,
                showLevel = levelConfig.showLevel,
                direction = npcInfo.direction,
                delay = npcInfo.delay or 0,
                group = npcInfo.group,
                activeAIId = roleCfg.baseAi or 1002,
                unactiveAIId = 1001,
                isShowEffect = false,
            }
            local role = self:createRole(data)
            table.insert(result, role)
        else
            BattleCore.es("未能找到人物初始生成格子，检查配置")
        end
    end
    return result
end

---创建验证角色，玩家自身角色(上阵地格中的角色)
---@param list ReportHeroData[]
function BattleRoleManager:createReportRoles(list)
    local battleMgr = BattleCore:getBattleMgr()
    for _, roleInfo in ipairs(list) do
        if roleInfo.isOnFormationBlock then
            local block = battleMgr:getBlockByCid(roleInfo.blockCid)
            ---@type LevelRoleData
            local data = {
                block = block,
                camp = roleInfo.camp,
                cid = roleInfo.cid,
                isFormationState = false,
                isMonster = roleInfo.isMonster,
                level = roleInfo.level,
                showLevel = roleInfo.showLevel,
                activeAIId = roleInfo.activeAIId or 1002,
                unactiveAIId = roleInfo.unactiveAIId or 1001,
                id = roleInfo.id
            }
            self:createRole(data)
        end
	end
end

---创建角色
---@param roleData LevelRoleData
---@return BattleRole 角色
function BattleRoleManager:createRole(roleData)
    if roleData.id then
        self._tmpId = roleData.id
    else
        roleData.id = self._tmpId
    end
    ---@type BattleRole
    local role = BattleRole:new(roleData, self, false)
    local battleMgr = BattleCore:getBattleMgr()
    local roleAIMgr = battleMgr:getBattleRoleAIManager()
    local hasActiveGroupIDList = roleAIMgr:getActiveGroupList()
    local groupId = roleData.group
    local activeState = hasActiveGroupIDList[groupId] ~= nil
    role:SetActiveState(activeState)
    local activeId = roleData.activeAIId or 1002
    local unactiveId = roleData.unactiveAIId or 1001
    roleAIMgr:setAIActionID(role.id, unactiveId, activeId)
    -- role:showHpReport()
    self._tmpId = self._tmpId + 1
    table.insert(self._roleList, role)
    ---创建出来的角色需要检测是否有进入攻击范围激活的AI事件
    if groupId and activeState ~= true then
        local roleList = self:getRolesList()
        for _, value in ipairs(roleList) do
            roleAIMgr:CheckAIEvent(GE.MonsterActiveEventType.TargetInAtkRange, value)
            if value:getActiveState() then
                break
            end
        end
    end
    local isVerifyMode = battleMgr:isVerifyMode()
    local isLocalBattle = battleMgr:IsLocalBattle()
    if not (isVerifyMode == true or isLocalBattle == true) then
        local block = roleData.block
        if block and roleData.camp == GE.BattleCampType.Friend then
            ---增加角色埋点日志
            ---@type BattleRoleLogData
            local d = {
                roleId = roleData.cid,
                totalDamage = 0,
                totalDamageTaken = 0,
                totalHeal = 0,
                activeSkillCount = 0,
                criticalHitCount = 0,
                roleStartPositions = { block.col, block.row },
            }
            battleMgr:SetBattleRoleLogData(role.id, d)
        end
    end
    --LuaLogger.es("BattleRoleManager:createRole", "id", role.id, "cid", role.cid, "camp", role.camp, "id", role.id, "name", role.roleConfig.name)
    return role
end

---移除角色
---@param role BattleRole 角色
---@param isDefeat boolean 是否被击败
---@param isFormationState boolean 是否布阵状态
---@param delay integer? 播放延迟
---@param source BattleRole? 击败当前角色
function BattleRoleManager:removeRole(role, isDefeat, isFormationState, delay, source)
    for i = #self._roleList, 1, -1 do
        if (self._roleList[i].id == role.id) then
            table.remove(self._roleList, i)
            break
        end
	end
    if (isDefeat) then
        table.insert(self._defeatRoleList, role)
        self._curRoundDefeatRoleList[#self._curRoundDefeatRoleList + 1] = role
    else
        role.block:setRoleId(nil)
    end
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    mapMgr:removeAllBlockEffectGroupByRoleId(role.id, true)
    role:destroy(isFormationState, delay)
    if isFormationState == false and isDefeat == true then
        self:setCurBattleTimeDefeatRole(role, source, delay)
    end
end

---战斗开始时检测角色实例化id，防止与验证战报中角色id冲突
function BattleRoleManager:checkInstanceTmpId()
    local maxId = 0
    for _, role in ipairs(self._roleList) do
        maxId = math.max(maxId, role.id)
    end
    self._tmpId = maxId + 1
end

function BattleRoleManager:getCurRoleTmpId()
    return self._tmpId
end

function BattleRoleManager:setCurRoleTmpId(tmpId)
    self._tmpId = tmpId
end

---开始战斗前根据服务器数据初始化角色属性
---@param serverDataDic table<number, BattleHeroInfo> 服务器角色数据字典，key为角色id
function BattleRoleManager:initAllRoleServerData(serverDataDic)
    if not serverDataDic then
        return
    end
    for _, role in ipairs(self._roleList) do
        local roleCid = role.cid
        local serverData = serverDataDic[roleCid]
        if role.isMonster ~= true and serverData then
            role:initServerData(serverData)
        end
    end
end

---检测当前时机被击败的角色数据，播放被击败战报
function BattleRoleManager:checkCurBattleTimeDefeatRole()
    if tablex.next(self.curBattleTimeDefeatRoles) == nil then
        return
    end
    for index, value in ipairs(self.curBattleTimeDefeatRoles) do
        local delayAnim = value[3] or 0
        local source = nil
        if index == 1 then
            source = value[2]
        end
        local role = value[1]
        role:showDefeatReport(source, delayAnim)
        role:roleRemoveReport(delayAnim + 1)
    end
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:getReporter():packStep()
    self.curBattleTimeDefeatRoles = {}
end

---设置当前被击败的角色,当前行动阶段被击败的角色统一播放击败战报
---@param defeatRole BattleRole 被击败的角色
---@param source BattleRole? 发起行动角色
---@param delay integer? 播放延迟
function BattleRoleManager:setCurBattleTimeDefeatRole(defeatRole, source, delay)
    ---@class BattleTimeDefeatRoleData
    ---@field [1] BattleRole 被击败的角色
    ---@field [2] BattleRole? 发起行动角色
    ---@field [3] integer? 播放延迟
    local d = {defeatRole, source, delay}
    table.insert(self.curBattleTimeDefeatRoles, d)
end

---布阵状态创建角色(前端专用)
---@param block any
---@param camp any
function BattleRoleManager:createRoleOnFormationState(block, camp, cid)
    local isOnMap = self:getRoleByCid(cid)
    local orgBlock = nil
    local changeCid = nil
    if (isOnMap) then
        orgBlock = isOnMap.block
        changeCid = isOnMap.cid
        self:removeRole(isOnMap, false, true)
    end
    local blockRole = self:getRole(block.roleId)
    if (blockRole) then
        --格子上的角色下阵
        self:removeRole(blockRole, false, true)
        if (orgBlock) then
            local roleCid = blockRole.cid
            local roleConfig = Config.GetCharacterInfo(roleCid)
            --交换位置
            ---@type LevelRoleData
            local data = {
                block = orgBlock,
                camp = camp,
                cid = roleCid,
                isMonster = false,
                isFormationState = true,
                activeAIId = roleConfig.baseAi or 1002,
                unactiveAIId = 1001,
            }
            self:createRole(data)
        end
    else
        if (camp == GE.BattleCampType.Friend) then
            local onMapRoles = self:getRolesByCamp(camp)
            local battleMgr = BattleCore:getBattleMgr()
            local levelConfig = battleMgr:getLevelConfig()
            local maxPerson = levelConfig.maxPerson
            if (#onMapRoles >= maxPerson) then
                --上阵人数已满
                UICommonUtils.PopToast("上阵人数已达上限")
                return
            end
        end
    end
    local roleConfig = Config.GetCharacterInfo(cid)
    ---@type LevelRoleData
    local roleData = {
        block = block,
        camp = camp,
        cid = cid,
        isFormationState = true,
        isMonster = false,
        activeAIId = roleConfig.baseAi or 1002,
        unactiveAIId = 1001,
    }
    return self:createRole(roleData)
end

---检查角色初始阶段技能效果
function BattleRoleManager:checkRolesInitEffects()
    for _, role in ipairs(self._roleList) do
        role:checkInitEffects()
    end
end

---检查角色所属阵营方开始行动时技能效果
function BattleRoleManager:checkRolesInitMyCampAction()
    local curCamp = self:actionCamp()
    local roleList = self:getActionRolesByCamp(curCamp)
    for _, role in ipairs(roleList) do
        role:checkInitMyCampActionEffects()
    end
end

---设置锁定角色
---@param role BattleRole|nil 角色
function BattleRoleManager:setLockRole(role)
    self._lockRole = role
end

---获取锁定角色
---@return BattleRole self._lockRole 锁定角色
function BattleRoleManager:getLockRole()
    return self._lockRole
end

---通过id获取角色
---@param roleId integer 角色id
---@param needFindDefeat boolean?
---@return BattleRole? role 角色
function BattleRoleManager:getRole(roleId, needFindDefeat)
    for _, role in ipairs(self._roleList) do
        if (role.id == roleId) then
            return role
        end
    end
    if needFindDefeat then
        for _, role in ipairs(self._defeatRoleList) do
            if (role.id == roleId) then
                return role
            end
        end
    end
    return nil
end

---通过cid获取角色，不包含敌方
---@param roleCid number 角色cid
---@return BattleRole? role 角色
function BattleRoleManager:getRoleByCid(roleCid)
    for _, role in ipairs(self._roleList) do
        if (role.cid == roleCid and role.camp == GE.BattleCampType.Friend) then
            return role
        end
    end
    return nil
end

---通过cid获取单位(怪物或角色)
---@param cid integer 单位cid
---@param findDefeatRole boolean? 是否查找被击败的角色
---@return BattleRole? role 角色
function BattleRoleManager:getRoleByCidNoCamp(cid, findDefeatRole)
    for _, role in ipairs(self._roleList) do
        if (role.cid == cid) then
            return role
        end
    end
    if findDefeatRole ~= false then
        for _, role in ipairs(self._defeatRoleList) do
            if (role.cid == cid) then
                return role
            end
        end
    end
    return nil
end

---设置阵营
---@param camps table 阵营列表
function BattleRoleManager:setCamps(camps)
    -- self._camps = camps
end

---切换行动阵营
function BattleRoleManager:switchActionCamp()
    self._roundIndex = 1
    self._tmpActionCompletedRoles = {}
    self._actionCampIndex = self._actionCampIndex + 1
	local battleMgr = BattleCore:getBattleMgr()
    if (self._actionCampIndex > #self._camps) then
        self._actionCampIndex = 1
        battleMgr:setBattleState(GE.BattleState.RoundEnd)
        return
    end
    if (battleMgr:checkWinLose()) then
        return
    end
    battleMgr:setBattleState(GE.BattleState.SwitchCamp)
end

---当前行动阵营
---@return BattleCampType 阵营
function BattleRoleManager:actionCamp()
    return self._camps[self._actionCampIndex]
end

---是否可行动
---@param role BattleRole 角色
function BattleRoleManager:isCanAction(role)
    if (self._lockRole ~= nil and self._lockRole.id ~= role.id) then
        return false
    end
    return self:isActionCamp(role.camp) and (not self:isActionCompleted(role)) and role:checkCanDoAction()
end

---是否当前行动阵营
---@param camp integer 阵营
---@return boolean
function BattleRoleManager:isActionCamp(camp)
    return camp == self:actionCamp()
end

---是否可操作阵营
---@return boolean
function BattleRoleManager:isManualCamp()
    return self._manualCamp == self:actionCamp()
end

---获取手动操作阵营
---@return BattleCampType camp 阵营
function BattleRoleManager:getManualCamp()
    return self._manualCamp
end

---获取敌对阵营
---@param camp BattleCampType 阵营
---@return BattleCampType[] enemyCamps 敌对阵营列表
function BattleRoleManager:getEnemyCamp(camp)
    local enemyCamps = {}
    if (camp == GE.BattleCampType.Friend or camp == GE.BattleCampType.FriendNPC) then
        table.insert(enemyCamps, GE.BattleCampType.Enemy)
    elseif (camp == GE.BattleCampType.Enemy) then
        enemyCamps = {GE.BattleCampType.Friend, GE.BattleCampType.FriendNPC}
    end
    return enemyCamps
end

---获取友方阵营
---@param camp BattleCampType 阵营
---@return BattleCampType[] 友方阵营列表
function BattleRoleManager:getFriendCamp(camp)
    local friendCamps = {}
    if (camp == GE.BattleCampType.Friend or camp == GE.BattleCampType.FriendNPC) then
        friendCamps = {GE.BattleCampType.Friend, GE.BattleCampType.FriendNPC}
    elseif (camp == GE.BattleCampType.Enemy) then
        friendCamps = {GE.BattleCampType.Enemy}
    end
    return friendCamps
end

---@param role BattleRole
function BattleRoleManager:setRoleInCompleteActionList(role)
    if tablex.contains(self._tmpActionCompletedRoles, role.id) then
        BattleCore.es("BattleRoleManager:setRoleInCompleteActionList role has in completed list, check it", role.id)
    end
    table.insert(self._tmpActionCompletedRoles, role.id)
end

---@param role BattleRole
function BattleRoleManager:removeRoleInCompleteActionList(role)
    local count = #self._tmpActionCompletedRoles
    for i = count, 1, -1 do
        local roleId = self._tmpActionCompletedRoles[i]
        if roleId == role.id then
            table.remove(self._tmpActionCompletedRoles, i)
        end
    end
end

---角色行动完成
function BattleRoleManager:completeAction()
	local battleMgr = BattleCore:getBattleMgr()
    -- battleMgr:setSelectRole(nil)
    if (battleMgr:checkWinLose()) then
        return
    end
    if (self:isAllActionCompleted()) then
        battleMgr._isEndCurRound = false
        self:switchActionCamp()
    else
        self._roundIndex = self._roundIndex + 1
        if self:isAllRoleCanNotDoAction() then
            self:checkRoleCanActionBeforeChangeCamp()
        else
            self:roleActionStart()
        end
    end
end

---角色行动开始
function BattleRoleManager:roleActionStart()
    -- self:calculateAllRolesActionRange()
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:setTiming(GE.BattleTiming.BeforeRoleTurn)
    battleMgr:setIsAutoAction(false)
    if battleMgr._isCancelBackTarce ~= true then
        if (self:isManualCamp()) then
            battleMgr:saveHistroyData()
        end
    else
        battleMgr._isCancelBackTarce = nil
    end
    local report = battleMgr:getReporter()
    report:packStep()
    local beforeSelectRoleId = battleMgr:getBeforeBackTranceSelectRoleId()
    local hasSelectedRole = false
    if beforeSelectRoleId then
        local beforeSelectRole = self:getRole(beforeSelectRoleId)
        if beforeSelectRole and self:isCanAction(beforeSelectRole) then
            self:selectRole(beforeSelectRole)
            hasSelectedRole = true
        end
    end
    if not hasSelectedRole then
        self:autoSelectRole()
    end
end

---检测自动行动
---@param role BattleRole
function BattleRoleManager:checkAutoAction(role)
    local battleMgr = BattleCore:getBattleMgr()
    -- LuaLogger.ds("checkAutoAction",battleMgr._isEndCurRound)
    local showMgr = battleMgr:getShowManager()
    local isShowMgrAutoHide = false
    -- LuaLogger.ds("checkAutoAction isManualCamp",self:isManualCamp())
    if role:checkCanDoAction() == false then
        BattleCore.ds("checkAutoAction role can not do action", role.cid)
        role:doAction(GE.ActionType.Standby)
    else
        if (battleMgr._isEndCurRound) then
            self:campStandup(role)
        elseif (not self:isManualCamp()) then
            -- if (not self:isActionCompleted(role)) then
            BattleCore.ds("checkAutoAction getActiveState", role:getActiveState())
            local mAIMgr = battleMgr:getBattleRoleAIManager()
            mAIMgr:checkAutoAction(role)
            -- end
        elseif self:isManualCamp() and battleMgr._isAutoMode then
            self:campAutoAction(role)
        else
            isShowMgrAutoHide = true
        end
    end

    if (showMgr) then
        showMgr:showAutoModeHideGroup(isShowMgrAutoHide)
    end
end

function BattleRoleManager:checkUsePrepareSkill(role)
    if (not self:isManualCamp()) then
        local battleMgr = BattleCore:getBattleMgr()
        local roleAIMgr = battleMgr:getBattleRoleAIManager()
        roleAIMgr:checkPrepareSkillCanUse(role)
    end
end

---角色是否已完成行动
---@param role BattleRole 角色
---@return boolean
function BattleRoleManager:isActionCompleted(role)
    if (not role) then
        return true
    end
    return tablex.contains(self._tmpActionCompletedRoles, role.id)
end

---是否所有角色都已完成行动
---@return boolean
function BattleRoleManager:isAllActionCompleted()
    local actionCamp = self:actionCamp()
    local roleList = self._roleList
    for index = 1, #roleList do
        local role = roleList[index]
        if role.camp == actionCamp and not self:isActionCompleted(role) then
            return false
        end
    end
    return true
end

---是否仅剩下不可行动的角色
---@return boolean
function BattleRoleManager:isAllRoleCanNotDoAction()
    local actionCamp = self:actionCamp()
    local roleList = self._roleList
    for index = 1, #roleList do
        local role = roleList[index]
        if role.camp == actionCamp and self:isActionCompleted(role) == false and role:checkCanDoAction() == true then
            return false
        end
    end
    return true
end

function BattleRoleManager:UpdateAllRoleBuff()
    for _, role in ipairs(self._roleList) do
        role:UpdateAllBuff()
    end
end

---计算所有角色行动范围
---@param camps BattleCampType[]? 阵营列表
function BattleRoleManager:calculateAllRolesActionRange(camps)
    for _, role in ipairs(self._roleList) do
        if (not camps or tablex.contains(camps, role.camp)) then
            role:calculateActionRange()
        end
    end
end

---获取能攻击到当前角色的所有敌人
---@param targetRole BattleRole
---@return BattleRole[]
function BattleRoleManager:getEnemiesCanHitRole(targetRole)
    local list = {}
    local enemyCamps = self:getEnemyCamp(targetRole.camp)
    local targetBlockId = targetRole:getShowBlock().id
    for _, role in ipairs(self._roleList) do
        if (tablex.contains(enemyCamps, role.camp)) then
            local atkRange = role:getRoleKVAtkRange()
            if atkRange[targetBlockId] ~= nil then
                table.insert(list, role)
            end
        end
    end
    return list
end

---获取危险范围
---@param camp BattleCampType 阵营
---@return table list 格子信息列表
function BattleRoleManager:getDangerRange(camp)
    local list = {}
    local checkList = {}
    local enemyCamps = self:getEnemyCamp(camp)
    for _, role in ipairs(self._roleList) do
        if (tablex.contains(enemyCamps, role.camp)) then
            local atkRange = role:getRoleAtkRange()
            for _, blockData in ipairs(atkRange) do
                local blockId = blockData.blockId
                if checkList[blockId] == nil then
                    checkList[blockId] = blockData
                end
            end
            -- list = tablex.combine(list, role:getRoleAtkRange())
        end
    end
    local listIndex = 1
    for _, v in pairs(checkList) do
        list[listIndex] = v
        listIndex = listIndex + 1
    end
    return list
end

---是否敌对阵营
---@param role1 BattleRole 角色1
---@param role2 BattleRole	角色2
---@return boolean
function BattleRoleManager:isEnemyCamp(role1, role2)
    local camp1 = role1.camp
    local camp2 = role2.camp
	local r = self:isEnemyCampByCamp(camp1, camp2)
    return r
end

---是否敌对阵营（通过阵营判断）
---@param camp1 BattleCampType 阵营1
---@param camp2 BattleCampType 阵营2
---@return boolean
function BattleRoleManager:isEnemyCampByCamp(camp1, camp2)
    local enemyCamps = self:getEnemyCamp(camp1)
	return tablex.contains(enemyCamps, camp2)
end

---通过阵营获取角色
---@param camp BattleCampType 阵营
---@return BattleRole[] 角色列表
function BattleRoleManager:getRolesByCamp(camp)
    local result = {}
    local listIndex = 1
    local roleList = self._roleList
    for index = 1, #roleList do
        local role = roleList[index]
        if role.camp == camp then
            result[listIndex] = role
            listIndex = listIndex + 1
        end
    end
    return result
end

---通过阵营获取可行动角色
---@param camp BattleCampType 阵营
---@return BattleRole[] roleList 角色列表
function BattleRoleManager:getActionRolesByCamp(camp)
    local result = {}
    local listIndex = 1
    local roleList = self._roleList
    for index = 1, #roleList do
        local role = roleList[index]
        if role.camp == camp and self:isCanAction(role) then
            result[listIndex] = role
            listIndex = listIndex + 1
        end
    end
    return result
end

---通过阵营获取被击败角色
---@param camp BattleCampType 阵营
---@return BattleRole[] roleList 角色列表
function BattleRoleManager:getDefeatRolesByCamp(camp)
    local result = {}
    local listIndex = 1
    local defeatRoleList = self._defeatRoleList
    for index = 1, #defeatRoleList do
        local role = defeatRoleList[index]
        if role.camp == camp then
            result[listIndex] = role
            listIndex = listIndex + 1
        end
    end
    return result
end

--- 修改我方角色行动顺序
---@param actionRoleList integer[] 角色cid列表
function BattleRoleManager:changeRoleList(actionRoleList)
    self:SortRoleList(self._roleList, actionRoleList)
end

function BattleRoleManager:SortRoleList(roleList, actionRoleList)
    local actionRoleKVList = {}
    for index, value in ipairs(actionRoleList) do
        actionRoleKVList[value] = index
    end
    table.sort(roleList, function(a, b)
        local aIndex = 0
        if a.camp == GE.BattleCampType.Friend then
            aIndex = actionRoleKVList[a.cid] or 0
        end
        local bIndex = 0
        if b.camp == GE.BattleCampType.Friend then
            bIndex = actionRoleKVList[b.cid] or 0
        end
        if aIndex == bIndex then
            return a.id < b.id
        end
        return aIndex < bIndex
    end)
    
end

---获取角色列表
---@return BattleRole[] roleList 角色列表
function BattleRoleManager:getRolesList()
    return self._roleList
end

---获取被击败角色列表
---@return BattleRole[] roleList 角色列表
function BattleRoleManager:getDefeatRolesList()
    return self._defeatRoleList
end

---阵营回合结束前处理不能行动的角色
function BattleRoleManager:checkRoleCanActionBeforeChangeCamp()
    local actionCamp = self:actionCamp()
    local roleList = self._roleList
    for index = 1, #roleList do
        local role = roleList[index]
        if role.camp == actionCamp and not self:isActionCompleted(role) and role:checkCanDoAction() == false then
            role:doAction(GE.ActionType.Standby)
        end
    end
end

---选中角色
---@param role BattleRole 角色
function BattleRoleManager:selectRole(role)
    local battleMgr = BattleCore:getBattleMgr()
    -- battleMgr:setSelectRole(role)
    battleMgr:refreshRoleActionState(role, true)
end

---自动选中未行动角色
---@return BattleRole?
function BattleRoleManager:autoSelectRole()
    if self._lockRole then
        self:selectRole(self._lockRole)
        return self._lockRole
    end
    while not next(self:getRolesByCamp(self:actionCamp())) do
        self:switchActionCamp()
    end
    local roles = self:getRolesByCamp(self:actionCamp())
    for _, role in ipairs(roles) do
        if (not self:isActionCompleted(role) and role:checkCanDoAction()) then
            self:selectRole(role)
            return role
        end
    end
end

---选中下一个未行动角色
function BattleRoleManager:selectNextRole()
    --如果有锁定角色，则直接选中锁定角色
    if (self._lockRole) then
        self:selectRole(self._lockRole)
        return
    end

    local battleMgr = BattleCore:getBattleMgr()
    local curRole = battleMgr:getSelectedRole()
    local roles = self:getRolesByCamp(self:actionCamp())
    local isNext = false
    local firstRole = nil
    for _, role in ipairs(roles) do
        if (not self:isActionCompleted(role) and role:checkCanDoAction()) then
            if (isNext) then
                self:selectRole(role)
                return
            elseif (not firstRole) then
                firstRole = role
            end
        end
        if (not curRole or role.id == curRole.id) then
            isNext = true
        end
    end

    if (firstRole) then
        self:selectRole(firstRole)
    end
end

---自动行动
---@param role BattleRole
function BattleRoleManager:campAutoAction(role)
    local battleMgr = BattleCore:getBattleMgr()
    if (battleMgr:isVerifyMode()) then
		return
	end
    local roleAIMgr = battleMgr:getBattleRoleAIManager()
    local actionId = role.roleConfig.baseAi or 1002
    roleAIMgr:checkAutoAction(role, actionId)
end

---自动待机
---@param role BattleRole?
function BattleRoleManager:campStandup(role)
    local battleMgr = BattleCore:getBattleMgr()
    if (battleMgr:isVerifyMode()) then
		return
	end
    if role == nil then
        local roles = self:getRolesByCamp(self:actionCamp())
        for _, curRole in ipairs(roles) do
            if (not self:isActionCompleted(curRole)) then
                role = curRole
                break
            end
        end
    end
    role:doAction(GE.ActionType.Standby)
end

---设置上阵角色数量
---@param count integer 上阵角色数
function BattleRoleManager:setFormationRolesCount(count)
    BattleCore.ds("BattleRoleManager:setFormationRolesCount",count)
    self._formationRolesCount = count
end

---获取上阵角色数量
---@return integer _formationRolesCount 上阵角色数
function BattleRoleManager:getFormationRolesCount()
    return self._formationRolesCount
end

function BattleRoleManager:resetRoundIndex(roundIndex)
    self._roundIndex = roundIndex
end

---获取回合序号
function BattleRoleManager:getRoundIndex()
    return self._roundIndex
end

---获取面向地块的朝向
---@param block BattleBlock 所在地块
---@param targetBlock BattleBlock 目标地块
function BattleRoleManager:getFaceToBlockDirection(block, targetBlock, nowDir)
    if (nowDir and (block == targetBlock)) then
        return nowDir
    end
	local colOffset = block.col - targetBlock.col
	local rowOffset = block.row - targetBlock.row
	local isHorizontal = math.abs(colOffset) == math.max(math.abs(colOffset), math.abs(rowOffset))
	if (isHorizontal) then
		return colOffset > 0 and GE.RoleDirectionType.Down or GE.RoleDirectionType.Up
	else
		return rowOffset > 0 and GE.RoleDirectionType.Left or GE.RoleDirectionType.Right
	end
end

function BattleRoleManager:clearAllRoleTagList()
    for _, role in ipairs(self._roleList) do
        role:ClearTagList()
    end
    for _, role in ipairs(self._defeatRoleList) do
        role:ClearTagList()
    end
end

---回合结束后清理自身的技能目标和效果目标列表
function BattleRoleManager:clearAllRoleActionList()
    for _, role in ipairs(self._roleList) do
        role:ClearRoleActionList()
        role:ClearRoleEffectActionList()
    end
end

---部分效果需要取到被击败角色的信息，故需要记录本回合被击败的角色，在回合结束后地格信息中清除roleId
function BattleRoleManager:changeBlockInfo()
    for _, role in ipairs(self._curRoundDefeatRoleList) do
        local block = role.block
        ---防止再移动时移动到被击败角色的地块上导致自身格子人物id被清除
        if block and block:getTmpRoleId() == role.id then
            block:setRoleId(nil)
        end
    end
    self._curRoundDefeatRoleList = {}
end

function BattleRoleManager:getCurRoundDefeatRoleList()
    return self._curRoundDefeatRoleList
end

---检查所有角色被动效果
---@param excludeRoleID integer?
function BattleRoleManager:chcekAllPassiveEffects(excludeRoleID)
    for _, role in ipairs(self._roleList) do
        if role.id ~= excludeRoleID then
            role:checkSkills(nil)
        end
    end
end

---检测所有角色buff变化时的战报
function BattleRoleManager:checkAllRoleBuffChangeReport()
    for _, role in ipairs(self._roleList) do
        if role:getBuffChangeChangeFlag() == true then
            role:refreshBuffStateReport()
            role:setBuffChangeChangeFlag(nil)
        end
    end
end

---检测所有角色血量变化条件判定的结果
function BattleRoleManager:checkAllRoleOnHPChangeEffect()
    local battleMgr = BattleCore:getBattleMgr()
    local timing = battleMgr:getTiming()
    for _, role in ipairs(self._roleList) do
        if role:CheckHasTag(GE.ActionTagType.HpHasChange) then
            local buffController = role:getBuffController()
            local buffAffixes = buffController:getPendingBuffAffixes(timing, 0)
            role:doAffixes(buffAffixes)
            role:checkSkills(nil)
        end
    end
end

---@param groupId integer
---@return BattleRole[]
function BattleRoleManager:getRoleByGroupId(groupId)
    local r = {}
    local listIndex = 1
    for _, role in ipairs(self._roleList) do
        if role.groupId == groupId then
            r[listIndex] = role
            listIndex = listIndex + 1
        end
    end
    return r
end

---刷新所有角色属性值
function BattleRoleManager:updateAllRoleAllAttributeValue()
    for _, value in ipairs(self._roleList) do
        value:updateAttributeBaseValue()
        value:updateAttributeTotalValue()
    end
end

---清理所有角色护卫id
function BattleRoleManager:clearAllRoleGuardID()
    for _, value in ipairs(self._roleList) do
        value:setGuardRoleId(nil)
    end
end

function BattleRoleManager:clear()
    self:initManager()
end

return BattleRoleManager