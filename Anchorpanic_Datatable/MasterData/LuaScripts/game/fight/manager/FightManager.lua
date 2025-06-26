--[[   
     战斗数据管理器
]]
module('fight.FightManager', Class.impl(Manager))

-- 自动战斗状态变化
EVENT_AUTO_FIGHT_CHANGE = "EVENT_AUTO_FIGHT_CHANGE"
-- 显示buff详情的目标ID变化
EVENT_SHOW_BUFF_INFO_ID_CHANGE = 'EVENT_SHOW_BUFF_INFO_ID_CHANGE'
--构造函数
function ctor(self)
    super.ctor(self)
    self.m_uniqueIDIdx = 0
    self.m_actionIDIdx = 0
    self.m_scTrans = nil

    self.m_gmScene = nil
    self.m_gmModelTid = nil
    self.m_gmImage = nil
    self.m_gmTurn = nil
    self.m_gmTurnAngle = -130

    self.m_gmOpenEft = nil
    self.m_gmOpenAudio = nil
    self.m_gmOpenEnemyEft = nil

    self.m_gmOpenLowShader = false
    self.m_gmOpenPostprocess = nil
    self.m_gmRoleLod = nil

    self.m_showBuffInfoId = nil

    -- 战斗同步码
    self.m_SyncWord = -1

    self:initData()
end
-- Override 重置数据
function resetData(self)
    self:initData()
end

-- 重置唯一ID标识
function initUniqueID(self)
    self.m_uniqueIDIdx = 0
    self.m_uniqueIDSet = {}
    self.m_actionIDIdx = 0
    self.m_actionQueue = {}
    self.m_qteType = fight.FightDef.BATTLE_QTE_NONE
    self.m_eftPriorityDict = {}
    self.m_prioityTargetList = {}

    fight.FightEffectHandle:init()

    self.m_resultData = nil
    self.mIsAutoFight = false
    self.mIsPause = false
    self.m_timeScaleType = 1
    self.m_stopClipSkill = false
    self.m_stopClipSkillMax = false

    self.m_canGuideAuto = false
    self.m_SyncWord = -1
end
-- 转换角色唯一ID
function toUniqueID(self, side, heroID)
    for uniqueID, v in pairs(self.m_uniqueIDSet) do
        if v[1] == side and v[2] == heroID then
            return uniqueID
        end
    end

    self.m_uniqueIDIdx = self.m_uniqueIDIdx + 1
    -- local uniqueID = SnMgr:getSn()
    self.m_uniqueIDSet[self.m_uniqueIDIdx] = { side, heroID }

    -- Debug:log_error("FightAction", "side: %d heroID: %d  uID: %d", side, heroID, self.m_uniqueIDIdx)
    return self.m_uniqueIDIdx
end
-- 把唯一ID解释回原数据
function parseUniqueID(self, uniqueID)
    local data = self.m_uniqueIDSet[uniqueID]
    if data then
        return data[1], data[2]
    end
end


function parseHeroList(self, heroList)
    local tmp = {}
    for _, v in ipairs(heroList) do
        table.insert(tmp, self:toUniqueID(v.key, v.value))
    end
    return tmp
end

function initData(self)
    self.mIsAutoFight = false
    self.mIsPause = false
    self.mUseSkillAttDic = {}

    ---------------------------------------------
    -- 战场的类型
    self.m_battleType = nil
    -- 战场的ID
    self.m_battleFieldID = nil
    -- 当前回合的出手顺序列表
    self.m_curRoleList = {}
    -- 下一回合的出手顺序列表
    self.m_nextRoleList = {}
    -- 出手表现顺序列表
    self.m_actionQueue = {}

    -- 每个英雄的转制ID
    self.m_uniqueIDSet = {}
    -- 攻方信息
    self.m_teamAttr = nil
    -- 守方信息
    self.m_teamDef = nil

    -- 所有英雄的信息
    self.m_teamHeroDict = {}
    -- 保存角色技能数据
    self.m_skillTmpDict = {}
    -- 战斗结束的数据
    self.m_resultData = nil

    -- 战斗权重数据
    self.m_eftPriorityDict = {}
    self.m_prioityTargetList = {}

    self.m_heroEftPriorityDict = {}

    -- 副本设置数据
    self.m_dupSettingData = nil
    self:_parseDupSettingData()

    -- 战斗的正体速度
    self.m_timeScaleType = 1
    -- 最大回合数
    self.m_maxRound = 20
    -- 当前回合数
    self.m_curRound = 1
    -- 回放数据
    self.m_replays = {}
    -- qte类型
    self.m_qteType = fight.FightDef.BATTLE_QTE_NONE
    -- 波数
    self.m_waveCnt = 1
    -- 我方最后出手战员ID
    self.m_myAttLiveTId = nil
    -- 我方最后退出战员ID
    self.m_myDeadLiveTId = nil
    -- 单位战斗失败后是否移除
    self.m_selfModelRemove = true
    -- 是否在回放中
    self.m_isReplaying = false
    -- 是否手动退出回放
    self.m_manualExitReplay = false
    ---助战技能列表
    self.m_battleAssistList = {}
    --场景效果技能Id列表
    self.scene_skill_id_list = {}
    -- 盟约技能id列表
    self.forces_skill_id_list = {}
    -- 盟约技能能量
    self.forces_skill_energy = nil

    self.m_blockValSet = {}
    -- 角色的缓存数据
    self.m_cacheHeroSet = {}

    self.m_latestBattleType = 0
    self.m_latestBattleFieldID = 0

    -- 格挡训练格挡成功次数
    self.mQteSucCount = 0

    -- UI的打开是否通过战斗结束触发
    self.mIsByFightEnd = nil

    -- 使用技能同步了核能（记录该协议的同步码）
    self.skillSyncMP = nil
    -- 战斗单位核能上限（服务器buff控制）
    self.mHeroMaxRage = {}

    -- 是否快速结算
    self.isShortCutResult = false
end

-- 保存战斗同步码
function setSyncWord(self, cusWord)
    if self.m_SyncWord ~= -1 and (cusWord - self.m_SyncWord ~= 1) then
        logInfo("===========战斗同步码异常，重新请求同步协议: old: " .. self.m_SyncWord .. " new: " .. cusWord)
        self:reqBattleSyncWord(self.m_SyncWord)
        return false
    end
    self.m_SyncWord = cusWord
    return true
end
-- 获取当前战斗同步码
function getSyncWord(self)
    return self.m_SyncWord
end

-- 结算清除同步码
function clearSyncWord(self)
    logInfo("================clearSyncWord")
    self.m_SyncWord = 0
end

-- 请求协议同步返回
function reqBattleSyncWord(self, syncWord)
    logInfo("==================reqBattleSyncWord")
    SOCKET_SEND(Protocol.CS_BATTLE_SYNC, { sync_word = syncWord })
end

function addHeroCache(self, heroLogicID, heroData)
    self.m_cacheHeroSet[heroLogicID] = heroData
end

function getHeroCache(self, heroLogicID)
    return self.m_cacheHeroSet[heroLogicID]
end

-- 获取能源立场格挡值
function getBlockVal(self, side)
    return self.m_blockValSet[side]
end

-- 设置能源立场格挡值
function setBlockVal(self, val, side)
    self.m_blockValSet[side] = val
end

--获取助战技能列表
function getBattleAssistList(self, side)
    return self.m_battleAssistList[side] or {}
end

--设置助战技能列表
function setBattleAssistList(self, val, side)
    if not self.m_battleAssistList[side] then
        self.m_battleAssistList[side] = {}
    end

    for i = 1, #val do
        local tab = { hero_tid = val[i].hero_tid, skill_id_list = {}, hero_lv = val[i].hero_lv, hero_evolution = val[i].hero_evolution }
        local skill_id_list = val[i].skill_id_list
        for j = 1, #skill_id_list do
            table.insert(tab.skill_id_list, { skill_id = skill_id_list[j] })
        end
        table.insert(self.m_battleAssistList[side], tab)
    end
end

--设置场景效果技能列表
function setSceneSkillList(self, ids)
    self.scene_skill_id_list = ids
end

--获取场景效果技能列表
function getSceneSkillList(self)
    return self.scene_skill_id_list
end

--盟约技能解锁列表
function setForcesSkillList(self, ids)
    self.forces_skill_id_list = ids
end

--获取盟约技能解锁列表
function getForcesSkillList(self)
    return self.forces_skill_id_list
end

--盟约技能能量
function setForcesSkillEnergy(self, value)
    self.forces_skill_energy = value
    GameDispatcher:dispatchEvent(EventName.FORCRES_SKILL_ENERGY_UPDATE)
end

--获取盟约技能能量
function getForcesSkillEnergy(self)
    return self.forces_skill_energy
end

-- 服务器buff改变的奥义怒气上限(按战斗单位存)
function setMaxRage(self, liveId, value)
    self.mHeroMaxRage[liveId] = value
end

-- 获取奥义怒气上限（有服务器发过来的就读服务器的，没有就读杂项配置的固定值）
function getMaxRage(self, liveId)
    if self.mHeroMaxRage[liveId] and self.mHeroMaxRage[liveId] > 0 then
        return self.mHeroMaxRage[liveId]
    end
    return sysParam.SysParamManager:getValue(SysParamType.MAX_RATE)
end

function setManualExitReplay(self, beExit)
    self.m_manualExitReplay = beExit
end

function setBeReplaying(self, beReplaying)
    self.m_isReplaying = beReplaying
end

function isReplaying(self)
    return self.m_isReplaying
end

function setSelfModelRemove(self, beRemove)
    self.m_selfModelRemove = beRemove
end
function getSelfModelRemove(self)
    return self.m_selfModelRemove
end

-- 设置己方最后攻击的战员唯一id
function setMyAttLiveId(self, tid)
    self.m_myAttLiveId = tid
end

-- 获取己方最后攻击的战员唯一id
function getMyAttLiveId(self)
    return self.m_myAttLiveId
end

-- 设置己方最后攻击的战员tid
function setMyAttLiveTId(self, tid)
    self.m_myAttLiveTId = tid
end

-- 设置己方最后死亡的战员tid
function setMyDeadLiveTId(self, tid)
    self.m_myDeadLiveTId = tid
end

function setWaveCnt(self, wave)
    self.m_waveCnt = wave
    GameDispatcher:dispatchEvent(EventName.START_WAVE)
end

function getWaveCnt(self)
    return self.m_waveCnt
end
function setQteType(self, qteType)
    if self.m_qteType == fight.FightDef.BATTLE_QTE_NONE or qteType == fight.FightDef.BATTLE_QTE_NONE then
        self.m_qteType = qteType
        -- print("setQteType============", qteType)
        if qteType ~= fight.FightDef.BATTLE_QTE_NONE then
            self:setQteSucCount(self:getQteSucCount() + 1) -- 本地先维护+1
            GameDispatcher:dispatchEvent(EventName.BLOCK_SUC_COUNT_UPDATE)
        end
        return true
    end
end
function getQteType(self)
    return self.m_qteType
end

function updateReplayData(self, type, replayData)
    self.m_replays[type] = self.m_replays[type] or {}
    replayData.type = type
    self.m_replays[type][replayData.id] = replayData
end
function removeReplayData(self, type, replayID)
    if self.m_replays[type] then
        self.m_replays[type][replayID] = nil
    end
end
function getReplayData(self)
    local ret = {}
    for k, rep in pairs(self.m_replays) do
        for k, v in pairs(rep) do
            table.insert(ret, v)
        end
    end
    return ret
end
function setMaxRound(self, maxRound)
    self.m_maxRound = maxRound
end
function setCurRound(self, curRound)
    self.m_curRound = curRound
end
function getMaxRound(self)
    return self.m_maxRound or 0
end
function getCurRound(self)
    return self.m_curRound
end

-- 设置qte格挡成功次数
function setQteSucCount(self, value)
    self.mQteSucCount = value
end

-- 获取qte格挡成功次数
function getQteSucCount(self)
    return self.mQteSucCount
end

-- 更新战斗倍速
-- local TimeScaleList = { { 1, 1 }, { 2, 1.5 }, { 3, 2 }, { 4, 3 } }--{2,1.3}
local TimeScaleList = { { 1, 1 }, { 2, 1.5 }, { 3, 2 } }
function updateTimeScale(self, tscale)
    if GameManager.IS_DEBUG then
        TimeScaleList = { { 1, 1 }, { 2, 1.5 }, { 3, 2 }, { 4, 5 }, { 5, 8 }, { 6, 20 } }
    end
    if tscale then
        for i, v in ipairs(TimeScaleList) do
            if v[1] == tscale then
                self.m_timeScaleType = v[1]
                self:setupTimeScale(v[2])
                AudioManager:setFightAudioSpeed(v[2])
                return
            end
        end
        self.m_timeScaleType = TimeScaleList[1][1]
        self:setupTimeScale(TimeScaleList[1][2])
        AudioManager:setFightAudioSpeed(TimeScaleList[1][2])
        return
    end
    local toGetNext = false
    for i, v in ipairs(TimeScaleList) do
        if toGetNext == true then
            self.m_timeScaleType = v[1]
            self:setupTimeScale(v[2])
            AudioManager:setFightAudioSpeed(v[2])
            return
        end
        if v[1] == self.m_timeScaleType then
            local lvl = sysParam.SysParamManager:getValue(SysParamType.FIGHT_SETUP_TIMES_3)
            if self.m_timeScaleType == 2 and role.RoleManager:getRoleVo():getPlayerLvl() < lvl then
                gs.Message.Show(_TT(3082, lvl)) --"链尉官等级达到{0}级开启3倍速"
                break
            end
            -- if self.m_timeScaleType == 3 and role.RoleManager:getRoleVo():getPlayerLvl() < 40 then
            --     gs.Message.Show("链尉官等级达到40级开启4倍速")
            --     break
            -- end
            toGetNext = true
        end
    end
    self.m_timeScaleType = TimeScaleList[1][1]
    self:setupTimeScale(TimeScaleList[1][2])
    AudioManager:setFightAudioSpeed(TimeScaleList[1][2])

end

function setupTimeScale(self, timeScale)
    if timeScale == 0 then
        AudioManager:setFightAudioSpeed(timeScale)
    elseif gs.Time.timeScale == 0 and timeScale > 0 then
        AudioManager:setFightAudioSpeed(self:getTimeScale())
    else
        AudioManager:setFightAudioSpeed(timeScale)
    end
    gs.Time.timeScale = timeScale
end

function getTimeScaleType(self)
    return self.m_timeScaleType
end

function getTimeScale(self)
    for _, v in ipairs(TimeScaleList) do
        if v[1] == self.m_timeScaleType then
            self.m_timeScaleType = v[1]
            return v[2]
        end
    end
    return TimeScaleList[1][2]
end

function _setGmData(self, gmScene, gmModelTid)
    self.m_gmScene = gmScene
    self.m_gmModelTid = gmModelTid
end

-- 副本设置数据配置表
function _parseDupSettingData(self)
    self.m_dupSettingData = {}
    local baseData = RefMgr:getData('dup_fight_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(fight.DupFightDataRo)
        ro:parseData(key, data)
        self.m_dupSettingData[key] = ro
    end
end

function getDupSettingData(self, dupType)
    if self.m_dupSettingData[dupType] == nil then
        Debug:log_warn("FightManager", "不存在此类型副本:" .. tostring(dupType))
        return
    end
    return self.m_dupSettingData[dupType]
end

-- 是否战斗中
function setIsFighting(self, cusB)
    if self.mIsFighting ~= cusB then
        self.mIsFighting = cusB
    end
    if cusB == false then
        self:setIsBattleing(cusB)
    end
end

-- 是否战斗中（结算后才算结束）
function getIsFighting(self)
    return self.mIsFighting
end

-- 是否对战中（一方死亡就结束）
function setIsBattleing(self, cusB)
    if self.mIsBattleing ~= cusB then
        self.mIsBattleing = cusB
    end
end
-- 是否对战中（一方死亡就结束）
function getIsBattleing(self)
    return self.mIsBattleing
end

-- 设置自动战斗
function setIsAutoFight(self, cusB)
    --    print("setIsAutoFight", cusB)
    if self.mIsAutoFight ~= cusB then
        self.mIsAutoFight = cusB
        self:dispatchEvent(EVENT_AUTO_FIGHT_CHANGE)
    end
end

function getIsAutoFight(self)
    return self.mIsAutoFight
end

-- 设置暂停
function setIsPause(self, cusB)
    if self.mIsPause ~= cusB then
        self.mIsPause = cusB

        if cusB then
            fight.SceneManager:suspend(self)
        else
            fight.SceneManager:restore(self)
        end
    end
end

function getIsPause(self)
    return self.mIsPause
end

function setBattleData(self, battleType, fieldID)
    self.m_battleType = battleType
    self.m_battleFieldID = fieldID
    self:setLatestBattleData(battleType, fieldID)
end

function setLatestBattleData(self, battleType, fieldID)
    self.m_latestBattleType = battleType
    self.m_latestBattleFieldID = fieldID
end

function getLatestBattleType(self)
    return tonumber(self.m_latestBattleType)
end

function getLatestBattleFieldID(self)
    return tonumber(self.m_latestBattleFieldID)
end

function getLatestBattleFieldIDStr(self)
    return self.m_latestBattleFieldID
end

--Net function-----BEGIN---------------------------------------
-- 请求进入战斗
-- battleType: 战场类型 
-- fieldID: 战场ID
function reqBattleEnter(self, battleType, fieldID, multiTimes, assaultType)
    --logError(string.format("reqBattleEnter %s %s", battleType, fieldID))
    self:setBattleData(battleType, fieldID)
    local function _startBattleCall()
        logInfo("CS_BATTLE_FIELD_ENTER1===", battleType, fieldID)
        --loginLoad.LoginLoadController:showLoading()
        local msg = {
            battle_type = self.m_battleType,
            battle_field_id = tostring(self.m_battleFieldID),
            multi_times = multiTimes or 1,
            assault_type = assaultType or fight.FightDef.HAND_NORMAL
        }
        SOCKET_SEND(Protocol.CS_BATTLE_FIELD_ENTER, msg, Protocol.SC_BATTLE_FIELD_INFO)
    end

    storyTalk.StoryTalkCondition:condition01(_startBattleCall)
end

-- 请求战斗开始
function reqBattleStart(self)
    logInfo("CS_BATTLE_START")
    SOCKET_SEND(Protocol.CS_BATTLE_START)
end

-- 发送回合结束
function reqBattleVideoEnd(self)
    if self.m_videoEnding == true then return end
    -- 下一个action在 暂时不用请求 避免跳过出战角色的数据
    for _, v in ipairs(self.m_actionQueue) do
        if v._actType == fight.FightDef.ACTION_TYPE_NOR then
            return
        end
    end
    self.m_videoEnding = true
    -- print("CS_BATTLE_VIDEO_END =========== ", self.m_qteType)
    -- 删除QTE机制
    -- SOCKET_SEND(Protocol.CS_BATTLE_VIDEO_END, { qte_val = self.m_qteType, sync_word = self:getSyncWord() })
    SOCKET_SEND(Protocol.CS_BATTLE_VIDEO_END, { sync_word = self:getSyncWord() })
end

function reqBattleQuit(self)
    logInfo("CS_BATTLE_QUIT")
    SOCKET_SEND(Protocol.CS_BATTLE_QUIT)
end

function reqBattleSkip(self)
    -- print("CS_BATTLE_SKIP")
    SOCKET_SEND(Protocol.CS_BATTLE_SKIP)
end

-- 请求使用技能
function reqUseSkill(self, skillID)
    -- print("CS_BATTLE_USE_SKILL", skillID)
    SOCKET_SEND(Protocol.CS_BATTLE_USE_SKILL, { skill_id = skillID })
end

-- 请求跳过战斗
function reqSkip(self)
    -- print("CS_BATTLE_SKIP")
    SOCKET_SEND(Protocol.CS_BATTLE_SKIP)
end

-- 1:是,0:否"
function reqAuto(self, autoType)
    -- print("CS_BATTLE_AUTO", autoType)
    SOCKET_SEND(Protocol.CS_BATTLE_AUTO, { is_auto = autoType })
end

-- 请求回放
function reqReplay(self, battleType, replayID,teamId)
    if teamId == nil then
        teamId = 0
    end
    SOCKET_SEND(Protocol.CS_BATTLE_REPLAY, { type = battleType, id = replayID,team_id = teamId })
end

-- 请求释放盟约技能
function reqUseForcesSkill(self, skillID)
    SOCKET_SEND(Protocol.CS_BATTLE_FORCES_SKILL, { skill_id = skillID })
end

-- 请求更改战员自动战斗技能
function reqAutoFightSkillChange(self, liveId, ruleType)
    local side, heroId = fight.FightManager:parseUniqueID(liveId)
    -- print("================reqAutoFightSkillChange ", heroId, ruleType)
    SOCKET_SEND(Protocol.CS_HERO_AUTO_RULE_CHANGE, { hero_id = heroId, rule_type = ruleType })
end

--Net function-----END---------------------------------------
-- 战斗结束，状态还原
function exitBattleLogic(self)
    self:setIsFighting(false)
    fight.FightAction:stop()
    fight.FightCamera:removeSCamera()
    AudioManager:stopAllFightSoundEffect()

    STravelHandle:removeAllTravel()
    BuffHandler:removeAllBuff()

    self:setupTimeScale(1)
    self.m_battleType = nil
    self.m_battleFieldID = nil
    self.m_actionQueue = {}

    self.m_SyncWord = 0
end

function getBattleType(self)
    return self.m_battleType or 0
end
function getBattleFieldID(self)
    return self.m_battleFieldID
end

function setRoleList(self, curList, nextList)
    self.m_curRoleList = curList or {}
    self.m_nextRoleList = nextList or {}
end

-- 获取当前回合队列
function getCurRoleList(self)
    return self.m_curRoleList
end

-- 获取下回合队列
function getNextRoleList(self)
    return self.m_nextRoleList
end

-- 更新当前队列
function updateCurRoleList(self, state, liveID, index)
    if not table.empty(self.m_curRoleList) then
        if state == 1 then
            for i, v in ipairs(self.m_curRoleList) do
                if v == liveID then
                    table.remove(self.m_curRoleList, i)
                    table.insert(self.m_curRoleList, index, liveID)
                    return
                end
            end
            table.insert(self.m_curRoleList, index, liveID)
        elseif state == 2 then
            for i, v in ipairs(self.m_curRoleList) do
                if v == liveID then
                    table.remove(self.m_curRoleList, i)
                    return
                end
            end
        end
    end
end

-- 更新下回合队列
function updateNextRoleList(self, state, liveID, index)
    if not table.empty(self.m_nextRoleList) then
        if state == 1 then
            for i, v in ipairs(self.m_nextRoleList) do
                if v == liveID then
                    table.remove(self.m_nextRoleList, i)
                    table.insert(self.m_nextRoleList, index, liveID)
                    return
                end
            end
            table.insert(self.m_nextRoleList, index, liveID)
        elseif state == 2 then
            for i, v in ipairs(self.m_nextRoleList) do
                if v == liveID then
                    table.remove(self.m_nextRoleList, i)
                    return
                end
            end
        end
    end
end

-- action里result 相关的战员列表
function actionResultHeroList(self, actionData)
    if actionData and actionData.result_list then
        local result = nil
        for _, resultData in ipairs(actionData.result_list) do
            if resultData.qte_val == self.m_qteType then
                return resultData.hero_list
            end
            if resultData.qte_val == 0 then
                result = resultData.hero_list
            end
        end
        if result then
            return result
        end
        for _, resultData in ipairs(actionData.result_list) do
            -- 回放结果（只有记录的一条qte结果）
            return resultData.hero_list
        end
    end
end

-- 技能受击的战员列表（包括施法者）
function actionHeroList(self, actionData)
    -- if actionData and actionData.result_list then
    --     local result = nil
    --     for _, resultData in ipairs(actionData.result_list) do
    --         if resultData.qte_val == self.m_qteType then
    --             return resultData.hero_list
    --         end
    --         if resultData.qte_val == 0 then
    --             result = resultData.hero_list
    --         end
    --     end
    --     if result then
    --         return result
    --     end
    --     for _, resultData in ipairs(actionData.result_list) do
    --         -- 回放结果（只有记录的一条qte结果）
    --         return resultData.hero_list
    --     end
    -- end
    if actionData and actionData.target_list then
        return actionData.target_list
    end
end

-- 获取对应qte的结果
function actionResultData(self, actionData)
    if actionData and actionData.result_list then
        local result = nil
        for _, resultData in ipairs(actionData.result_list) do
            if resultData.qte_val == self.m_qteType then
                return resultData
            end
            if resultData.qte_val == 0 then
                result = resultData
            end
        end
        if result then
            return result
        end
        for _, resultData in ipairs(actionData.result_list) do
            -- 回放结果
            return resultData
        end
    end
end

-- 新增一个action
function addRoleAction(self, actionData)
    self.m_videoEnding = false
    actionData.actionID = self.m_actionIDIdx + 1
    self.m_actionIDIdx = actionData.actionID

    self.m_heroEftPriorityDict = self.m_heroEftPriorityDict or {}
    self.m_heroEftPriorityDict[actionData.actionID] = {}

    for i, v in ipairs(actionData.hero_list) do
        local pDataDict = {}
        local pDic = {}
        for _, eft in ipairs(v.effect_list) do

            pDataDict[eft.priority] = pDataDict[eft.priority] or {}

            self.m_heroEftPriorityDict[actionData.actionID][eft.priority] = self.m_heroEftPriorityDict[actionData.actionID][eft.priority] or {}

            local bVo = fight.BattlePriorityVo.new()
            eft.actionID = actionData.actionID
            bVo:setData(eft)
            bVo:setTargetLiveID(v.hero_id)
            table.insert(pDataDict[eft.priority], bVo)

            table.insert(self.m_heroEftPriorityDict[actionData.actionID][eft.priority], bVo)
        end
    end

    actionData.m_canBlock = false
    actionData.m_totalDamage = {}
    actionData.m_totalCure = {}
    actionData.priorityList = {}
    actionData.maxPriorityID = {}
    self.m_eftPriorityDict[actionData.actionID] = {}
    self.m_prioityTargetList[actionData.actionID] = {}

    for _, resultData in ipairs(actionData.result_list) do
        -- 表示有挡格数据 可以进行挡格
        -- if resultData.qte_val == 1 or resultData.qte_val == 2 or resultData.qte_val == 3 then
        --     actionData.m_canBlock = true
        -- end
        -- 当前英雄所出手技能的总伤害
        local totalDamage = 0
        local totalCure = 0 -- 总治疗
        -- 当前英雄所在的出手级
        local priorityList = {}
        -- 记录最大的优先级
        local maxPriorityID = 0
        local eftPriorityDict = {}

        local targetList = {}

        for _, hero in ipairs(resultData.hero_list) do
            local pDataDict = {}
            eftPriorityDict[hero.hero_id] = pDataDict
            for _, v in ipairs(hero.effect_list) do

                if v.priority > maxPriorityID then
                    maxPriorityID = v.priority
                end
                -- 一小段行动的开始(按效果9分段)
                if actionData.hero_id == hero.hero_id and v.type == fight.FightDef.BATTLE_TYPE_ATT then
                    table.insert(priorityList, v.priority)
                else
                    -- 小段行动的具体内容（效果9之间的行动和受击帧挂钩）
                    if pDataDict[v.priority] == nil then
                        pDataDict[v.priority] = {}
                    end
                    local bVo = fight.BattlePriorityVo.new()
                    v.actionID = actionData.actionID
                    bVo:setData(v)
                    bVo:setTargetLiveID(hero.hero_id)
                    table.insert(pDataDict[v.priority], bVo)
                    table.insert(targetList, hero.hero_id)
                    if fight.FightDef.DAMAGE_TYPE_SET[v.type] then
                        totalDamage = totalDamage + v.count
                    end
                    if v.type == fight.FightDef.BATTLE_TYPE_CURE then
                        totalCure = totalCure + v.count
                    end
                end
            end
        end
        -- 确保出手级是升序的
        table.sort(priorityList)

        actionData.maxPriorityID[resultData.qte_val] = maxPriorityID
        actionData.priorityList[resultData.qte_val] = priorityList
        actionData.m_totalDamage[resultData.qte_val] = totalDamage
        actionData.m_totalCure[resultData.qte_val] = totalCure
        self.m_eftPriorityDict[actionData.actionID][resultData.qte_val] = eftPriorityDict

        self.m_prioityTargetList[actionData.actionID][resultData.qte_val] = targetList
    end

    if not actionData._actType then
        actionData._actType = fight.FightDef.ACTION_TYPE_NOR
    end
    self:pushAction(actionData)
end

-- 判断Action中是否只有qte成功的数据
function isOnlyQteAction(self, actionID)
    local eftDict = self.m_eftPriorityDict[actionID]
    if eftDict then
        if table.nums(eftDict) == 1 and eftDict[fight.FightDef.BATTLE_QTE_PERFECT] then
            return true
        end
    end
    return false
end

function getPriorityDict(self, actionID, heroID)
    local eftDict = self.m_eftPriorityDict[actionID]
    if eftDict then
        if eftDict[self.m_qteType] then
            return eftDict[self.m_qteType][heroID]
        end
        if eftDict[0] then
            return eftDict[0][heroID]
        end
        for _, v in pairs(eftDict) do
            return v[heroID]
        end
    end
end


function getPriorityVoList(self, actionID, heroID, priorityID)
    local pDict = self:getPriorityDict(actionID, heroID)
    if pDict then
        return pDict[priorityID]
    end
end

-- 获取QTE之前的效果列表，按优先级分组
function getBeforePriorityVoList(self, actionID)-- heroID, priorityID)
    local eftDict = self.m_heroEftPriorityDict[actionID]
    if eftDict then
        return eftDict
    end
end

function getPriorityTargets(self, actionID, priorityID)
    local pData = self.m_prioityTargetList[actionID]
    if pData then
        if pData[self.m_qteType] then
            return pData[self.m_qteType][priorityID]
        end
        if pData[0] then
            return pData[0][priorityID]
        end
        for _, v in pairs(pData) do
            return v[priorityID]
        end
    end
end

function getPriorityTargets1(self, actionID)
    local pData = self.m_prioityTargetList[actionID]
    if pData then
        if pData[self.m_qteType] then
            return pData[self.m_qteType]
        end
        if pData[0] then
            return pData[0]
        end
        for _, v in pairs(pData) do
            return v
        end
    end
end

function getPriorityList(self, actionData)
    local prioritys = actionData.priorityList[self.m_qteType]
    if not prioritys then
        prioritys = actionData.priorityList[0]
        if not prioritys then
            for _, v in pairs(actionData.priorityList) do
                prioritys = v
                break
            end
        end
    end
    return prioritys
end

function getInitPriorityID(self, actionData)
    local prioritys = self:getPriorityList(actionData)
    if prioritys then
        return prioritys[1]
    end
end

function getMaxPriorityID(self, actionData)
    local maxPriorityID = actionData.maxPriorityID[self.m_qteType]
    if not maxPriorityID then
        maxPriorityID = actionData.maxPriorityID[0]
        if not maxPriorityID then
            for _, v in pairs(actionData.maxPriorityID) do
                maxPriorityID = v
                break
            end
        end
    end
    return maxPriorityID
end
-- 判断角色是否在当前的行动中
function isRoleAction00(self, sideID, heroID)
    if table.empty(self.m_actionQueue) then
        return false
    end
    local actionData = self.m_actionQueue[1]
    if actionData._actType == fight.FightDef.ACTION_TYPE_NOR then
        if actionData.side == sideID and actionData.hero_id == heroID then
            return true
        end
    end
    return false
end
function isRoleAction01(self, liveVo)
    return self:isRoleAction00(liveVo:isAttacker(), liveVo:getLiveID())
end

function checkFirstRoleAction(self)
    if table.empty(self.m_actionQueue) then
        return nil
    end
    return self.m_actionQueue[1]
end

-- 取出最早的一条行动
function popRoleAction(self)
    local actionData = self:checkFirstRoleAction()
    if actionData then
        table.remove(self.m_actionQueue, 1)
    end
    return actionData
end

-- 清空当前action
function clearRoleAciton(self)
    self.m_actionQueue = {}
end

-- 表示某角色过了一个回合 刷新技能数据
function skillTurn(self, heroID)
    local tmpList = self.m_skillTmpDict[heroID]
    if tmpList then
        for _, tmpVo in ipairs(tmpList) do
            tmpVo:roleTurn()
        end
    end
end
-- 设置新的技能剩余CD
function setSkillNewCD(self, heroID, skillID, newCD)
    local tmpVo = self:getHeroSkill(heroID, skillID)
    if tmpVo then
        tmpVo:setCD(newCD)
        GameDispatcher:dispatchEvent(EventName.UPDATE_SKILL_ROUNT, skillID)
    end
end

-- 获取技能数据
function getHeroSkillList(self, heroID)
    return self.m_skillTmpDict[heroID]
end

function getHeroSkill(self, heroID, skillID)
    local tmplist = self.m_skillTmpDict[heroID]
    if tmplist then
        for _, v in ipairs(tmplist) do
            local sRo = v:skillRo()
            if sRo and sRo:getRefID() == skillID then
                return v
            end
        end
    end
end
function getHeroSkill02(self, skillID)
    for k, tmplist in pairs(self.m_skillTmpDict) do
        for _, v in ipairs(tmplist) do
            local sRo = v:skillRo()
            if sRo and sRo:getRefID() == skillID then
                return v
            end
        end
    end
end


-- 保存出场队伍
function setTeamData(self, attTeam, defTeam)
    self.m_teamAttr = attTeam
    self.m_teamDef = defTeam
    self.m_teamHeroDict = {}
    --保存攻方的技能数据
    self.m_skillTmpDict = {}
    for _, v in ipairs(attTeam.hero_list) do
        v.side = 1
        v.rage = v.rage / 10
        self.m_teamHeroDict[v.id] = v
        self:setHeroSkillTmpData(v, v.skill_list)
    end

    for _, v in ipairs(defTeam.hero_list) do
        v.side = 2
        v.rage = v.rage / 10
        self.m_teamHeroDict[v.id] = v
    end
end

-- 插入战员信息（中途加入）
function addTeamData(self, id, data)
    if self.m_teamHeroDict then
        self.m_teamHeroDict[id] = data
    end
end

function setHeroSkillTmpData(self, heroInfo, skillList)
    local skillLst = {}
    self.m_skillTmpDict[heroInfo.id] = skillLst
    if not table.empty(skillList) then
        for _, skillTmp in ipairs(skillList) do
            local skillTmpVo = fight.SkillTmpVo.new()
            skillTmpVo:setSkillData(heroInfo.id, skillTmp)
            table.insert(skillLst, skillTmpVo)
        end
    end
    local heroVo = hero.HeroManager:getHeroConfigVo(heroInfo.tid)
    if heroVo and heroVo.baseSkillIdList then
        for _, baseSkillID in ipairs(heroVo.baseSkillIdList) do
            local beLock = true
            for _, skillTmpVo in ipairs(skillLst) do
                if baseSkillID == skillTmpVo:skillRo():getRefID() then
                    beLock = false
                    break
                end
            end
            if beLock then
                local skillTmpVo = fight.SkillTmpVo.new()
                skillTmpVo:setSkillData02(heroInfo.id, baseSkillID)
                skillTmpVo:setLock(true)
                table.insert(skillLst, skillTmpVo)
            end
        end
    end
end

-- 插入一条新的行动同时检查下一步
function pushAction(self, act)
    table.insert(self.m_actionQueue, act)
    fight.FightAction:moveNext()
end

function getHero(self, heroID)
    return self.m_teamHeroDict[heroID]
end

function getHeroList(self, sideID)
    local tmp = {}
    for _, v in pairs(self.m_teamHeroDict) do
        if v.side == sideID then
            table.insert(tmp, v)
        end
    end
    return tmp
end

function getHeroBySideAndId(self, sideID, id)
    for _, v in pairs(self.m_teamHeroDict) do
        local d1, d2 = fight.FightManager:parseUniqueID(v.id)
        if d1 == sideID and d2 == id then
            return v
        end
    end

    return nil
end

function getAllHero(self)
    return self.m_teamHeroDict
end

-- 缓存战斗结算
function setResultData(self, msg)
    self.m_resultData = msg

    -- 缓存结算时的角色数据和出战英雄数据，用于做结算表现
    local playerLvl = role.RoleManager:getRoleVo():getPlayerLvl()
    local playerExp = role.RoleManager:getRoleVo():getPlayerExp()
    local playerMaxExp = role.RoleManager:getRoleVo():getPlayerMaxExp()
    local heroData = {}
    if #msg.hero_id_list > 0 then

        -- +P：这里的英雄列表都以后端为主
        for i, data in ipairs(msg.hero_id_list) do
            local id = data.key
            local fromType = data.value
            if (fromType == 0) then -- 英雄
                local heroVo = hero.HeroManager:getHeroVo(id)
                if heroVo then
                    table.insert(heroData, { heroId = heroVo.id, lvl = heroVo.lvl, exp = heroVo.exp, favorableLevel = heroVo.favorableLevel })
                end
            elseif (fromType == 1) then -- 怪物
                local monsterTidVo = monster.MonsterManager:getMonsterVo(id)
                if monsterTidVo then
                    local monsterVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
                    monsterVo.lvl = monsterTidVo.lvl
                    monsterVo.exp = 0 -- 经验策划需求固定为0
                    monsterVo.evolutionLvl = monsterTidVo.evolutionLvl
                    table.insert(heroData, { heroData = monsterVo })
                end
            else
                Debug:log_error("FightManager", "战斗结算后端发来的英雄类型未定义：" .. fromType)
            end
        end
    else
        if (msg.is_replay == 1) then  --表示是战斗回放
            local heroDic = fight.SceneManager:getSideThingIDs(1)
            for i, id in ipairs(heroDic) do
                local thingVo = fight.SceneManager:getThing(id)
                if thingVo:getRaceType() == 0 then --英雄
                    local heroVo = hero.HeroVo.new()
                    heroVo:setConfigData(hero.HeroManager:getHeroConfigVo(thingVo.tid))
                    heroVo.lvl = thingVo:getAtt(AttConst.LV)
                    heroVo.evolutionLvl = thingVo.evolutionLvl
                    table.insert(heroData, { heroData = heroVo })
                    --怪物
                else
                    local monsterVo = monster.MonsterManager:getMonsterVo01(thingVo.tid)
                    monsterVo.lvl = thingVo:getAtt(AttConst.LV)
                    monsterVo.evolutionLvl = thingVo.evolutionLvl
                    table.insert(heroData, { heroData = monsterVo })

                end
            end
        end
    end
    self.m_preResultData = { playerLvl = playerLvl, playerExp = playerExp, playerMaxExp = playerMaxExp, heroData = heroData }
end

-- 获取战斗结算
function getResultData(self)
    return self.m_resultData
end

-- 获取结算前的缓存数据
function getPreResultData(self)
    return self.m_preResultData
end

function battleFinish(self)
    guide.GuideCondition:condition16()
    fight.SceneItemManager:closeAllHeadBar()
    self:setupTimeScale(1)
    -- logError("battleFinish============")
    local function _timeOutCall()
        local function _finishCall()
            LoopManager:setTimeout(0.05, self, self._battleFinish)
        end
        local allSide1 = fight.SceneManager:getSideNoDead(1)
        -- 已方全灭
        if table.empty(allSide1) then
            storyTalk.StoryTalkCondition:condition04(_finishCall)
            return
        end

        -- 敌方全灭
        local allSide2 = fight.SceneManager:getSideNoDead(2)
        if table.empty(allSide2) then
            storyTalk.StoryTalkCondition:condition05(_finishCall)
            return
        end
        self:_battleFinish()
    end
    LoopManager:setTimeout(1.1, self, _timeOutCall)
end

function _battleFinish(self)
    if not fight.FightManager:getIsFighting() then
        return
    end
    BuffHandler:removeAllBuff()
    AudioManager:stopAllFightSoundEffect()

    -- if self:getBattleType() == PreFightBattleType.ArenaChallenge then
    --     if self.m_resultData.result == 3 then
    --         self.m_resultData.result=2
    --     end
    -- end
    if self.m_resultData then
        if self.m_resultData.result == 1 then
            GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_SHOW)
            -- 胜利音乐在胜利镜头那边播
            -- guide.GuideCondition:condition04()
        elseif self.m_resultData.result == 2 or self.m_resultData.result == 3 then
            -- 2正常退出，3主动退出
            GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_SHOW)
            local liveId = self.m_myDeadLiveTId
            if self.m_myDeadLiveTId == nil then
                local index = math.random(1, #self.m_teamAttr.hero_list)
                liveId = self.m_teamAttr.hero_list[index].tid
            end

            fight.FightCamera:checkReturnCamera()
            -- AudioManager:playHeroCVByFieldName(liveId, "fail_voice")
            -- AudioManager:pauseMusicByFade(2, function()
            AudioManager:playMusicById(31, false) --胜利音乐
            -- end)
        elseif self.m_resultData.result == 4 then
            GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_SHOW)
        else
            GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, { isWin = true })
        end
    end
end

function postGmDebugInit(self)
    local cameraCom = gs.CameraMgr:GetSceneCamera()
    if not cameraCom then return end
    local postProcess = cameraCom:GetComponent(ty.PostProcessing)
    if not postProcess then return end
    if fight.FightDef.GM_POST1.val == nil then
        fight.FightDef.GM_POST1.val = postProcess.enabled
    else
        postProcess.enabled = fight.FightDef.GM_POST1.val
    end
    if postProcess.PostProcessToggle ~= nil then
        if fight.FightDef.GM_POST2.val == nil then
            fight.FightDef.GM_POST2.val = postProcess.PostProcessToggle
        else
            postProcess.PostProcessToggle = fight.FightDef.GM_POST2.val
        end
    end
    if postProcess.GlowToggle ~= nil then
        if fight.FightDef.GM_POST3.val == nil then
            fight.FightDef.GM_POST3.val = postProcess.GlowToggle
        else
            postProcess.GlowToggle = fight.FightDef.GM_POST3.val
        end
    end
    if postProcess.BloomToggle ~= nil then
        if fight.FightDef.GM_POST4.val == nil then
            fight.FightDef.GM_POST4.val = postProcess.BloomToggle
        else
            postProcess.BloomToggle = fight.FightDef.GM_POST4.val
        end
    end
    if postProcess.ToneMapToggle ~= nil then
        if fight.FightDef.GM_POST5.val == nil then
            fight.FightDef.GM_POST5.val = postProcess.ToneMapToggle
        else
            postProcess.ToneMapToggle = fight.FightDef.GM_POST5.val
        end
    end
    if postProcess.LUTToggle ~= nil then
        if fight.FightDef.GM_POST6.val == nil then
            fight.FightDef.GM_POST6.val = postProcess.LUTToggle
        else
            postProcess.LUTToggle = fight.FightDef.GM_POST6.val
        end
    end
    if postProcess.RadialBlurToggle ~= nil then
        if fight.FightDef.GM_POST7.val == nil then
            fight.FightDef.GM_POST7.val = postProcess.RadialBlurToggle
        else
            postProcess.RadialBlurToggle = fight.FightDef.GM_POST7.val
        end
    end
    if postProcess.BlurToggle ~= nil then
        if fight.FightDef.GM_POST8.val == nil then
            fight.FightDef.GM_POST8.val = postProcess.BlurToggle
        else
            postProcess.BlurToggle = fight.FightDef.GM_POST8.val
        end
    end
    if postProcess.ToggleSunShaft ~= nil then
        if fight.FightDef.GM_POST9.val == nil then
            fight.FightDef.GM_POST9.val = postProcess.ToggleSunShaft
        else
            postProcess.ToggleSunShaft = fight.FightDef.GM_POST9.val
        end
    end
    if postProcess.NoiseToggle ~= nil then
        if fight.FightDef.GM_POST10.val == nil then
            fight.FightDef.GM_POST10.val = postProcess.NoiseToggle
        else
            postProcess.NoiseToggle = fight.FightDef.GM_POST10.val
        end
    end
    if postProcess.FXAA3Toggle ~= nil then
        if fight.FightDef.GM_POST11.val == nil then
            fight.FightDef.GM_POST11.val = postProcess.FXAA3Toggle
        else
            postProcess.FXAA3Toggle = fight.FightDef.GM_POST11.val
        end
    end

    if fight.FightDef.GM_POST12.val == nil then
        fight.FightDef.GM_POST12.val = true
    else
        local fixedDirection = cameraCom:GetComponent(ty.FixedDirection)
        if fixedDirection then
            fixedDirection.enabled = fight.FightDef.GM_POST12.val
        end
    end
end

function postGmDebugSetup(self, postData)
    if postData and postData.val == nil then return end
    local cameraCom = gs.CameraMgr:GetSceneCamera()
    if not cameraCom then return end
    local postProcess = cameraCom:GetComponent(ty.PostProcessing)
    if not postProcess then return end
    if fight.FightDef.GM_POST1 == postData then
        postProcess.enabled = postData.val
    elseif fight.FightDef.GM_POST2 == postData and postProcess.PostProcessToggle ~= nil then
        postProcess.PostProcessToggle = postData.val
    elseif fight.FightDef.GM_POST3 == postData and postProcess.GlowToggle ~= nil then
        postProcess.GlowToggle = postData.val
    elseif fight.FightDef.GM_POST4 == postData and postProcess.BloomToggle ~= nil then
        postProcess.BloomToggle = postData.val
    elseif fight.FightDef.GM_POST5 == postData and postProcess.ToneMapToggle ~= nil then
        postProcess.ToneMapToggle = postData.val
    elseif fight.FightDef.GM_POST6 == postData and postProcess.LUTToggle ~= nil then
        postProcess.LUTToggle = postData.val
    elseif fight.FightDef.GM_POST7 == postData and postProcess.RadialBlurToggle ~= nil then
        postProcess.RadialBlurToggle = postData.val
    elseif fight.FightDef.GM_POST8 == postData and postProcess.BlurToggle ~= nil then
        postProcess.BlurToggle = postData.val
    elseif fight.FightDef.GM_POST9 == postData and postProcess.ToggleSunShaft ~= nil then
        postProcess.ToggleSunShaft = postData.val
    elseif fight.FightDef.GM_POST10 == postData and postProcess.NoiseToggle ~= nil then
        postProcess.NoiseToggle = postData.val
    elseif fight.FightDef.GM_POST11 == postData and postProcess.FXAA3Toggle ~= nil then
        postProcess.FXAA3Toggle = postData.val
    elseif fight.FightDef.GM_POST12 == postData then
        local fixedDirection = cameraCom:GetComponent(ty.FixedDirection)
        if fixedDirection then
            fixedDirection.enabled = postData.val
        end
    end
end

function setShowBuffInfoId(self, id, data)
    if self.m_showBuffInfoId ~= id then
        self.m_showBuffInfoId = id
        self.m_showBuffInfoData = data
    else
        self.m_showBuffInfoId = nil
        self.m_showBuffInfoData = nil
    end
    self:dispatchEvent(EVENT_SHOW_BUFF_INFO_ID_CHANGE)
end

function setShowSkillInfo(self, heroID, skillList)
    if self.m_showHeroID ~= heroID then
        self.m_showHeroID = heroID
        self.m_showHeroSkill = skillList
    else
        self.m_showHeroID = nil
        self.m_showHeroSkill = nil
    end
    self:dispatchEvent(EVENT_SHOW_BUFF_INFO_ID_CHANGE)
end

-- 获取战斗血条显示状态
function getFightHpBarShow(self)
    local val = sysParam.SysParamManager:getValue(SysParamType.FIGHT_SHOW_HP) == 1
    if StorageUtil:hasKey1(gstor.FIGHT_SHOW_HP) == true then
        val = StorageUtil:getBool1(gstor.FIGHT_SHOW_HP)
    else
        StorageUtil:saveBool1(gstor.FIGHT_SHOW_HP, val)
    end
    return val
end

function setIsUIByFightEnd(self, isByFightEnd)
    self.mIsByFightEnd = isByFightEnd
end

function getIsUIByFightEnd(self)
    return self.mIsByFightEnd
end

function setLastReqInfoBattleType(self,battleType)
    self.mLastReqInfoBattleType = battleType
end

function getLastReqInfoBattleType(self)
    return self.mLastReqInfoBattleType
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]