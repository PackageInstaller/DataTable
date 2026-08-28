local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
local ActivityConstants = import("Game.Activity.ActivityConstants")

--- 歼灭战活动
local AnnihilationActivityPrefabId = {
    ConstractFood = 12000801
}

---@class AnnihilationUtils
local AnnihilationUtils = {}

--- 判断关卡类型是否是歼灭战
---@param questType any
function AnnihilationUtils.QuestTypeIsAnnihilation(questType)
    if questType == Constants.IDType.QuestAnnihilation
    or questType == Constants.IDType.QuestConstractFoodAnnihilation then
        return true
    end
    return false
end

--- 获取组件
---@param activityType any
function AnnihilationUtils.GetComponent(activityPrefabId)
    local comp
    if activityPrefabId == 0 then
        comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActionComponent)
    elseif activityPrefabId == AnnihilationActivityPrefabId.ConstractFood then
        comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityLinkageBossComponent)
    end
    return comp
end

--- 获取最后打过的boss类型id
---@param activityId any
function AnnihilationUtils.GetLastBossTypeId(activityPrefabId, activityContentId)
    local bossTypeId = GameUtils.LoadInt(string.format("AnnihilationLastBoss_%s_%d_%d", GameUtils.GetPlayerId(), activityPrefabId, activityContentId), 1)
    return bossTypeId
end

--- 获取最后打过的关卡id
---@param activityId any
---@param bossTypeId any
function AnnihilationUtils.GetLastQuestId(activityPrefabId, activityContentId, bossTypeId)
    local questId = GameUtils.LoadInt(string.format("AnnihilationLastBossQuest_%s_%d_%d_%d", GameUtils.GetPlayerId(), activityPrefabId, activityContentId, bossTypeId), -1)
    return questId
end

--- 获取最后解锁的关卡
---@param activityType any
---@param activityId any
---@param bossTypeId any
function AnnihilationUtils.GetLastUnlockedQuestId(activityPrefabId, activityContentId, bossTypeId)
    local lastQuestId
    local comp = AnnihilationUtils.GetComponent(activityPrefabId)
    local vo = comp:GetTypeVo(bossTypeId)
    local questIdList = parse_strings(vo.contentLevel, ";")
    for i, questId in ipairs(questIdList) do
        questId = checkNumber(questId)
        local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        local isUnlocked = AnnihilationUtils.IsUnlockBossQuest(activityPrefabId, activityContentId, questVo.monsterType, questVo.id)
        if isUnlocked then
            lastQuestId = questId
        end
    end
    return lastQuestId
end

--是否解锁了这个关卡
function AnnihilationUtils.IsUnlockBossQuest(activityPrefabId, activityContentId, bossTypeId, questId)
    local vo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
    if not vo then
        return false, localize("没有找到对应的关卡信息")
    end
    
    local comp = AnnihilationUtils.GetComponent(activityPrefabId)

    -- 如果有主线关卡条件
    if isNotNull(vo.mainQuestUnlockLevel) then
        local curMainQuestId = comp:GetActivityMainQuestId()
        local targetMainQuestId = checkNumber(vo.mainQuestUnlockLevel)
        if curMainQuestId < targetMainQuestId then
            local mainQuestVo = QuestConfMgr:GetInstance():GetQuestVoById(targetMainQuestId)
            return false, localize("通关_name_后解锁", {_name_ = mainQuestVo.name})
        end
    end

    local bossInfo = comp:GetBossQuestData(bossTypeId)
    if isNull(bossInfo) then
        -- 如果没有boss数据，那么说明还没打过。看配表前置关卡是否为0，为0则说明这关默认是解锁的
        return checkNumber(vo.unlockNum) == 0, localize("请先解锁当前boss")
    end

    -- 关卡是默认解锁的
    if checkNumber(vo.unlockNum) == 0 then
        return true, ""
    end

    return checkNumber(bossInfo.openQuestId) > checkNumber(vo.unlockNum), localize("需要先通关上一难度")
end


--- 是否解锁了boss
---@param typeId integer
---@return boolean, string
function AnnihilationUtils.CheckAnnihilationBossUnlocked(activityPrefabId, activityContentId, bossTypeId)
    local comp = AnnihilationUtils.GetComponent(activityPrefabId)
    local vo = comp:GetTypeVo(bossTypeId)
    if not vo then
        return false
    end

    local isUnlocked = GameUtils.IsUnlockedSingle(vo.unlockType, vo.unlockNum, vo.unlockId)
    if not isUnlocked then
        local desc = GameUtils.GetUnlockDescr(vo.unlockType, vo.unlockNum, vo.unlockId)
        return false, desc
    end

    return true
end

--- 服务器报错内容
---@param errCode any
function AnnihilationUtils.GetServerErrorMgr(errCode)
    local msg = ""
    if errCode == 1 then
        msg = localize("房间不存在")
    elseif errCode == 2 then
        msg = localize("房间已经开始战斗")
    elseif errCode == 3 then
        msg = localize("房间内已经有人")
    elseif errCode == 4 then
        msg = localize("请求参数异常")
    elseif errCode == 5 then
        msg = localize("不能邀请自己")
    elseif errCode == 6 then
        msg = localize("对方不在线")
    elseif errCode == 7 then
        msg = localize("对方已有归属房间或者上一场的战斗还未完成结算")
    elseif errCode == 8 then
        msg = localize("关卡未解锁")
    elseif errCode == 9 then
        msg = localize("双方不是好友")
    elseif errCode == 10 then
        msg = localize("对方已被别人邀请，请等待10秒再尝试")
    elseif errCode == 11 then
        msg = localize("加入失败，已有房间归属")
    elseif errCode == 12 then
        msg = localize("队伍有问题，请尝试重新编队")
    elseif errCode == 13 then
        msg = localize("可能已经不在这个房间，请尝试退出房间重新加入房间")
    elseif errCode == 14 then
        msg = localize("请先取消准备然后再调整队伍")
    elseif errCode == 15 then
        msg = localize("不是房主，不能开始战斗")
    elseif errCode == 16 then
        msg = localize("对方还未准备")
    elseif errCode == 17 then
        msg = localize("对方已掉线，不能开始")
    elseif errCode == 20 then
        msg = localize("房间还未结算，暂不允许翻牌")
    elseif errCode == 21 then
        msg = localize("房主还未翻牌")
    elseif errCode == 22 then
        msg = localize("邀请次数已达上限")
    elseif errCode == 201 then
        msg = localize("消耗道具不足")
    end
    return msg .. " T_T"
end

return AnnihilationUtils