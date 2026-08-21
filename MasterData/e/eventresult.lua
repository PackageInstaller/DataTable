---@class EventManager
local EventResult = require "EventManager"
local BattleCore = require "BattleCore"

--事件触发条件方法注册
function EventResult:registerBattleEventResult()

    --生成NPC(我方角色、剧情NPC等)  该方法不使用了，待删除
    local function doResultCreatNPC(param)
        --TODO
        -- local roleCamp = 1--param.camp
        -- local roleID = 10003--param.roleID
        -- local x, y = 5, 5--param.x, param.y
        -- local battleManager = BattleCore:getBattleMgr()
        -- local block = battleManager:getBlock(x, y)
        -- local battleRoleManager = BattleCore:getBattleRoleMgr()
        -- battleRoleManager:createRole(block, roleCamp, roleID, false)
    end

    --通过cid移除NPC(我方角色，敌方怪物、剧情NPC等)
    local function doResultRemoveNPC(param)
        local roleIDs = param.id
        local isDefeat = false--param.isDefeat
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        for _, roleID in ipairs(roleIDs) do
            local battleRole = battleRoleManager:getRoleByCidNoCamp(roleID)
            if battleRole then
                battleRoleManager:removeRole(battleRole, isDefeat, false)
                battleRole:roleRemoveReport()
            end
        end
    end

    --移动NPC(我方角色，敌方怪物、剧情NPC等)
    local function doResultMoveNPC(param)
        local roleID = param.id
        local pos = param.position
        local battleManager = BattleCore:getBattleMgr()
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        local battleRole = battleRoleManager:getRoleByCidNoCamp(roleID, false)
        if not battleRole then
            BattleCore.es("角色不存在场上doResultMoveNPC: role not found, roleID:", roleID)
            return
        end
        local mapMgr = battleManager:getMap()
        local checkBlock = mapMgr:getBlockByCid(pos)
        local block = mapMgr:getNearsetNoOneBlockByBlock(checkBlock, battleRole.moveType)
        if block then
            if battleRole.block.id ~= block.id then
                --先移动到目标点
                battleRole:LookAtBlockReport(battleRole.block.id, true)
                local battleMgr = BattleCore:getBattleMgr()
                battleMgr:getReporter():packStep()
                --再相机跟随 移动
                local moveRange = mapMgr:getCanMoveRangeByMoveType(battleRole.roleConfig.moveType)
                local movePath = mapMgr:getShortestPath(battleRole.block.id, block.id, moveRange)
                if movePath and next(movePath) then
                    battleRole:move(block, movePath)
                end
                -- battleRole:changeBlock(block)
                -- battleRole:resetPos()
            end
        end
    end

    --结束战斗(胜利/失败)
    local function doResultBattleIsOver(param)
        local isWin = param.finlvl == 1 and true or false
        if isWin then
            self.haveEventLevelTarget.isWin = true
        else
            self.haveEventLevelTarget.isLose = true
        end
    end

    --给指定id的单位增加(或移除)effect(或effectGroup)
    local function doResultSetEffectByRoleId(param)
        local roleCidList = param.ids
        local effectIdList = param.tiggerid
        local battleMgr = BattleCore:getBattleMgr()
        local battleRoleManager = battleMgr:getRoleManager()
        local skillManager = battleMgr:getSkillManager()
        local roleList = battleRoleManager:getRolesList()
        for _, cid in ipairs(roleCidList) do
            for _, battleRole in ipairs(roleList) do
                if battleRole.cid == cid then
                    local block = battleRole:getShowBlock()
                    local tragetList = { block.id }
                    for _, effectId in ipairs(effectIdList) do
                        skillManager:checkEffect(effectId, battleRole, tragetList)
                    end
                end
            end
        end
    end

    --给指定范围的单位施加单个(或多个)Effect
    local function doResultSetEffectByRange(param)
        local effectIdList = param.tiggerid
        local blockCid = param.tileKey
        local length = param.length or 1
        local width = param.width or 1
        local needCamp = param.targettype
        --获取范围格子
        local battleManager = BattleCore:getBattleMgr()
        local battleMap = battleManager:getMap()
        local idList = battleMap:selectRangeByBlockIdAndTrain(blockCid, width, length)
        --获取对应阵容角色
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        local battleRoleList = nil
        if needCamp == 5 then
            battleRoleList = battleRoleManager:getRolesList()
        else
            battleRoleList = battleRoleManager:getRolesByCamp(needCamp)
        end
        --判断角色是否在范围中
        local haveRoleList = {}
        local haveRoleBlockList = {}
        for _, battleRole in pairs(battleRoleList) do
            local nowRoleAtBlockId = battleRole.block.id
            for _, blockId in pairs(idList) do
                if blockId == nowRoleAtBlockId then
                    table.insert(haveRoleBlockList, blockId)
                    table.insert(haveRoleList, battleRole)
                end
            end
        end
        --施加Effect
        local sourceRole = next(haveRoleList) and haveRoleList[1]
        local skillManager = BattleCore:getSkillMgr()
        for _, effectId in pairs(effectIdList) do
            if sourceRole then
                skillManager:checkEffect(effectId, sourceRole, haveRoleBlockList)
            end
        end
    end

    --增加(移除)战斗事件
    local function doResultSetBattleEvent(param)
        local opType = param.changetype
        local eventId = param.id
        local eventConfig = Config.GetPveLevelTriggerInfo(eventId)
        local timingPoint = eventConfig.timingPoint
        local eventId = eventConfig.id
        if opType == 1 then --增加事件
            self:_setBattleEvent(timingPoint, eventId, {
                count = eventConfig.createBaseinfo.cnt
            })
            --有初始化表现效果的事件
            if eventConfig.preEffect then
                self.eventPlayList[eventId] = eventConfig.preEffect
            end
        else
            --移除表现
            local battleMgr = BattleCore:getBattleMgr()
            local eventMgr = battleMgr:getBattleEventManager()
            eventMgr:doEventCompleted(timingPoint, eventId)
            --移除事件
            if self.battleEventList[timingPoint] and self.battleEventList[timingPoint][eventId] then
                self:_removeBattleEvent(timingPoint, eventId)
            end
        end
    end

    --根据配置id计数
    local function doResultSaveDataById(param)
        local saveId = param.id
        local addNum = param.num
        if not self.eventSaveData[saveId] then
            self.eventSaveData[saveId] = 0
        end
        self.eventSaveData[saveId] = self.eventSaveData[saveId] + addNum
    end

    --修改事件计数单位(对应EventCondition 8 的事件)
    local function doResultRewriteInterval(param)
        local eventId = param.id
        local newInterval = param.interval
        local eventConfig = Config.GetPveLevelTriggerInfo(eventId)
        local timingPoint = eventConfig.timingPoint
        local eventData = self.battleEventList[timingPoint][eventConfig.id]
        eventData.interval = newInterval
    end

    --添加一个成就id
    local function doResultAddAchievementID(param)
        local achievementID = param.id
        if not self.eventSaveData.achievementIdList then
            self.eventSaveData.achievementIdList = {}
        end
        tablex.insertproxy(self.eventSaveData.achievementIdList, achievementID)
    end

    --移除一个成就id
    local function doResultRemoveAchievementID(param)
        local achievementID = param.id
        if not self.eventSaveData.achievementIdList then
            return
        end
        for key, id in pairs(self.eventSaveData.achievementIdList) do
            if id == achievementID then
                tablex.removeproxy(self.eventSaveData.achievementIdList, key)
                break
            end
        end
    end

    --扣除一颗关卡星级
    local function doResultRemoveLevelStar(param)
        if self.eventSaveData.star > 0 then
            local eventConfig = self.nowEventConfig
            if not self.eventSaveData.deductStarIdList then
                self.eventSaveData.deductStarIdList = {}
            end
            tablex.insertproxy(self.eventSaveData.deductStarIdList, eventConfig.id)

            self.eventSaveData.star = self.eventSaveData.star - 1
        end
    end

    --生成角色
    local function doResultCreatERole(param)
        local npcInfo = param.npcInfo
        local monsterInfo = param.monsterInfo
        local battleManager = BattleCore:getBattleMgr()
        local levelConfig = battleManager:getLevelConfig()
        local creatLevelConfig = {
            npcInfo = npcInfo,
            monsterInfo = monsterInfo,
            level = levelConfig.level,
			showLevel = levelConfig.showLevel,
        }
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        local roleList = nil
        if npcInfo then
            roleList = battleRoleManager:createNpcs(creatLevelConfig)
        elseif monsterInfo then
            roleList = battleRoleManager:createEnemies(creatLevelConfig)
        end
        if roleList then
            for _, role in ipairs(roleList) do
                role:checkInitEffects()
            end
        end
    end

    --播放AVG剧情
    local function doResultPlayAVG(param)
        local battleMgr = BattleCore:getBattleMgr()
        if battleMgr:isVerifyMode() or battleMgr:IsLocalBattle() then
            battleMgr:setAVGEndTimingForVerify()
            return
        end
        battleMgr:getReporter():packStep()
        local reportData = {
            id = param.id,
        }
        battleMgr:getReporter():addReport(GE.BattleReportType.PlayAVG, reportData)
        battleMgr:getReporter():packStep()
    end

    --切换单位阵营
    local function doResultChangeCamp(param)
        local roleCid = param.id
        local newCamp = param.camp
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        local battleRole = battleRoleManager:getRoleByCidNoCamp(roleCid)
        battleRole:switchRoleCamp(newCamp)
        battleRole:SetActiveState(true)
    end

    --设置胜利条件的激活状态
    local function changeLevelTarget(param)
        local d = param.data
        local battleMgr = BattleCore:getBattleMgr()
        local levelTagetMgr = battleMgr:getLevelTargetsManager()
        for _, paramData in ipairs(d) do
            levelTagetMgr:SetLevelTargetActive(paramData.type, paramData.value == 0)
        end
    end

    --通过block的cid移除NPC(我方角色，敌方怪物、剧情NPC等)
    local function doResultRemoveNPCByBlockCid(param)
        local blockCidList = param.iposition
        local isDefeat = false--param.isDefeat
        local mapMgr = BattleCore:getBattleMgr():getMap()
        for _, blockCid in ipairs(blockCidList) do
            local block = mapMgr:getBlockByCid(blockCid)
            if block then
                local battleRole = block:tryGetRole()
                if battleRole then
                    local battleRoleManager = BattleCore:getBattleRoleMgr()
                    battleRoleManager:removeRole(battleRole, isDefeat, false)
                    battleRole:roleRemoveReport()
                end
            end
        end
    end

    --登场timeline
    local function DoResultTimeline(param)
        local cid = param.id
        local timeline = param.value
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        local battleRole = battleRoleManager:getRoleByCidNoCamp(cid)
        if battleRole then
            local battleMgr = BattleCore:getBattleMgr()
            battleMgr:getReporter():packStep()
            local id = battleRole.id
            local skinConfig = battleRole.skinConfig
            local reportData = {
                id = id,
                timeline = timeline,
                skinConfig = skinConfig,
                delay = 0,
                name = param.name
            }
            battleMgr:getReporter():addReport(GE.BattleReportType.RoleTimeline, reportData)
            battleMgr:getReporter():packStep()
        end
    end

    --1 生成NPC(我方角色、剧情NPC等)
    -- self.resultFunc[GE.EventResult.DoResultCreatNPC] = doResultCreatNPC
    --2 移除NPC(我方角色，敌方怪物、剧情NPC等)
    self.resultFunc[GE.EventResult.DoResultRemoveNPC] = doResultRemoveNPC
    --3 移动NPC(我方角色，敌方怪物、剧情NPC等)
    self.resultFunc[GE.EventResult.DoResultMoveNPC] = doResultMoveNPC
    --4 结束战斗(胜利/失败)
    self.resultFunc[GE.EventResult.DoResultBattleIsOver] = doResultBattleIsOver
    --5 给指定id的单位增加(或移除)effect(或effectGroup)
    self.resultFunc[GE.EventResult.DoResultSetEffectByRoleId] = doResultSetEffectByRoleId
    --6 给指定范围的单位施加单个(或多个)Effect
    self.resultFunc[GE.EventResult.DoResultSetEffectByRange] = doResultSetEffectByRange
    --7 增加(移除)战斗事件
    self.resultFunc[GE.EventResult.DoResultSetBattleEvent] = doResultSetBattleEvent
    --8 根据配置id计数
    self.resultFunc[GE.EventResult.DoResultSaveDataById] = doResultSaveDataById
    --9 修改事件计数单位(对应EventCondition 8 的事件)
    self.resultFunc[GE.EventResult.DoResultRewriteInterval] = doResultRewriteInterval
    --10 添加一个成就id
    self.resultFunc[GE.EventResult.DoResultAddAchievementID] = doResultAddAchievementID
    --11 移除一个成就id
    self.resultFunc[GE.EventResult.DoResultRemoveAchievementID] = doResultRemoveAchievementID
    --12 扣除一颗关卡星级
    self.resultFunc[GE.EventResult.DoResultRemoveLevelStar] = doResultRemoveLevelStar
    --13 生成角色
    self.resultFunc[GE.EventResult.DoResultCreatERole] = doResultCreatERole
    --14 播放AVG剧情
    self.resultFunc[GE.EventResult.DoResultPlayAVG] = doResultPlayAVG
    --15 切换单位阵营
    self.resultFunc[GE.EventResult.DoResultChangeCamp] = doResultChangeCamp
    --16 设置胜利条件的激活状态
    self.resultFunc[GE.EventResult.ChangeLevelTargetActive] = changeLevelTarget
    --17 通过格子的cid移除角色
    self.resultFunc[GE.EventResult.doResultRemoveNPCByBlockCid] = doResultRemoveNPCByBlockCid
    --18 timeline特写
    self.resultFunc[GE.EventResult.DoResultTimeline] = DoResultTimeline
end

return EventResult