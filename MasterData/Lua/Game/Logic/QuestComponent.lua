---
--- Created by THL.
---

local ECSComponent = import("Frame.ECS.ECSComponent")
---@class QuestComponent
local QuestComponent = Class("QuestComponent", ECSComponent)

function QuestComponent:__init()
    self._curQuestId = 0         --当前通关的questid 普通关卡
    self._rewardShowData = nil   --待展示的奖励数据   
    self._starInfo = {}          --所有的三星信息
    self._drawReardInfo = {}     --已领取的奖励

    self._mainTaskInfo = {}      --任务

    self._sideInfo = {}      --支线信息
    self._allDrawChapterIds = {}  --所有领取的奖励
end

function QuestComponent:__delete()
    self._curQuestId = 0         --当前通关的questid
    self._rewardShowData = nil   --待展示的奖励数据   
    self._starInfo = {}                  --所有的三星信息
    self._drawReardInfo = {}     --已领取的奖励
    self._mainTaskInfo = {}      --任务
    self._sideInfo = {}      --支线信息
    self._allDrawChapterIds = {}  --所有领取的奖励
end

function QuestComponent:Initial(newQuestId, mainTaskInfo, sideStory, chapterReward)
    local t = checkTable(chapterReward)
    self._allDrawChapterIds = {}
    for k, v in pairs(t) do
        self._allDrawChapterIds[checkString(v)] = 1
    end

    self._curQuestId = checkNumber(newQuestId)
    self._sideInfo = checkTable(sideStory)
    self:RefreshQuestInfo(mainTaskInfo)
    --[[
    --if self._curQuestId == 0 then
    --    self._curQuestId = 10000
    --end
    -- --- 检查小队评级
    -- ---@type CardComponent
    -- local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    -- cardComp:CalcRatingId(self._curQuestId)
    
    self._starInfo = {}    
    self._challengeQuestMap = {}       
    local t = checkTable(stareInfo)
    if t then
        self._starInfo = {}
        for k, v in pairs(t) do
            local _, conditions = QuestConfMgr:GetInstance():GetQuestConditions(checkString(k))
            if conditions then
                local _t = {}
                local count = 0
                v = table.values(v)
                for m, cdt in pairs(conditions) do
                    count = count + 1
                    _t[checkString(cdt.id)] = (table.keyof(v, count) and 1 or 0) 
                end
                self._starInfo[checkString(k)] = _t
            end
            self._challengeQuestMap[checkString(k)] = 1
        end
    end

    self._drawReardInfo = {}    
    t = checkTable(drawRewardInfo)
    for k, v in pairs(t) do
        self._drawReardInfo[checkString(k)] = checkTable(v)
    end
    ]]

    -- print("1!!!!!!!!!!!!!!!!!!!!!")
    -- print(table.dump(self._mainTaskInfo))
    -- print(table.dump(self._sideInfo))
    -- print(table.dump(self._sideInfo))

    -- print(table.dump(self._drawReardInfo))
    -- print(table.dump(self._challengeQuestMap))
    -- print(table.dump(self._starInfo))
    -- print(self._curQuestId)
end

function QuestComponent:InitialHardQuest(hardQuestId,hardQuestPassedTimes)
    self._curChallengeQuestId = checkNumber(hardQuestId)
    self._curChallengePassedTimes = checkNumber(hardQuestPassedTimes)
end

--当前的任务状态
function QuestComponent:GetCurTaskInfo()
    return self._mainTaskInfo
end

--是否领取了章节奖励
function QuestComponent:IsDrawChapterReward(chapterId, pos)
    local t = self._drawReardInfo[checkString(chapterId)]
    if not t then
        return false
    end
    for k, v in pairs(t) do
        if checkNumber(v) == checkNumber(pos) then
            return true
        end
    end
    return false 
end

--获取星级
function QuestComponent:GetStarInfo()
    return self._starInfo
end

function QuestComponent:GetQuestStarInfo(questId)
    return self._starInfo[checkString(questId)]
end

--书信任务信息
function QuestComponent:RefreshQuestInfo(data)
    if not data then
        return
    end

    self._mainTaskInfo = checkTable(data)
end

--检测物品
function QuestComponent:HandleGoodsInfo(data)
    if not data then
        return
    end

    if checkNumber(self._mainTaskInfo.id) > 0 then 
        local taskVo = QuestConfMgr:GetInstance():GetMainTaskQuestVo(self._mainTaskInfo.id)
        if taskVo then
            if checkNumber(taskVo.taskContentType) == Constants.TaskType.Submittals then
                local isHasTargetGoodsId = false
                for k, v in pairs(data) do
                    if checkNumber(v.goodsId) == checkNumber(taskVo.taskContentId) then
                        isHasTargetGoodsId = true
                        break
                    end
                end

                if isHasTargetGoodsId then
                    self:UpdateTaskInfo({
                        questId = QuestConfMgr:GetInstance():GetCurNeedQuestId(),
                        progress = GoodsUtils.GetThingNo(taskVo.taskContentId),
                    })
                end
            end
        end
    end
end

--更新任务状态
function QuestComponent:UpdateTaskInfo(data)
    self._mainTaskInfo.progress = checkNumber(data.progress)

    local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
    ActionUtils.ShowMaintQestTaskNode(data)
end

---TaskMainTaskReceivingReq 主线任务接取
function QuestComponent:TaskMainTaskReceivingReq(taskId, questId, cb)
    GameUtils.Request(Interfaces.TaskMainTaskReceiving, {taskId = taskId}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            self._mainTaskInfo = {}
            self._mainTaskInfo.progress = 0
            self._mainTaskInfo = checkTable(responseData.mainTaskInfo)
            self._mainTaskInfo.id = taskId

            local taskVo = QuestConfMgr:GetInstance():GetMainTaskQuestVo(taskId)
            if taskVo then
                local isSpecialType = checkNumber(taskVo.taskContentType) == Constants.TaskType.Submittals
                --特殊类型任务直接取背包
                if isSpecialType then 
                    self._mainTaskInfo.progress = GoodsUtils.GetThingNo(taskVo.taskContentId)
                end
            end
            
            local FishingUtils = import('Game.UI.Fishing.FishingUtils')
            FishingUtils.HandleMainQuestPass(questId)

            if cb then
                cb()
            end
        end
    end)
end

---TaskMainTaskSubmitReq 主线任务完成
function QuestComponent:TaskMainTaskSubmitReq(questId, cb)
    GameUtils.Request(Interfaces.TaskMainTaskSubmit, {}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            self._mainTaskInfo = {}
            if #responseData.rewards > 0 then
                GoodsUtils.DrawRewards(responseData.rewards)
            end
            self:UpdateMainQuestInfo(questId)

            if cb then
                cb(responseData.rewards)
            end
        end
    end)
end

---OverseaMainQuestSideStoryReq 支线剧情
function QuestComponent:OverseaMainQuestSideStoryReq(questId, cb)
    GameUtils.Request(Interfaces.OverseaMainQuestSideStory, {questId = questId}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            if #responseData.rewards > 0 then
                GoodsUtils.DrawRewards(responseData.rewards)
            end

            local vo = QuestConfMgr:GetInstance():GetQuestSideVo(questId)
            if vo then
                local lastId = self._sideInfo[checkString(vo.group)]
                if checkNumber(questId) > checkNumber(lastId) then
                    self._sideInfo[checkString(vo.group)] = checkNumber(questId)
                end
            end

            if cb then
                cb(responseData.rewards)
            end
        end
    end)
end

---IsCompleteCondition 根据星的条件id判断是否已达成
---@param levelId string 关卡id
---@param conditionId string 条件id
function QuestComponent:IsCompleteCondition(levelId, conditionId)
    local levelStarInfo = self._starInfo[checkString(levelId)]
    if levelStarInfo then
        if checkNumber(levelStarInfo[conditionId]) == 1 then
            return true
        end
    end
    return false
end

---MainQuestChapterStartRewardReq 三星领奖
---@param questId string 关卡id
function QuestComponent:MainQuestChapterStartRewardReq(chapterId, pos, cb)
    chapterId = checkNumber(chapterId) 
    GameUtils.Request(Interfaces.MainQuestChapterStartReward, {id = chapterId, position = pos}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            
            if #responseData.rewards > 0 then
                GoodsUtils.DrawRewards(responseData.rewards)
            end
            if not self._drawReardInfo[checkString(chapterId)] then
                self._drawReardInfo[checkString(chapterId)] = {}
            end
            table.insert(self._drawReardInfo[checkString(chapterId)], pos)

            CS.Engine.UI.UIModule.OpenDialog({id = Constants.UITypeIds.UICommonRewardPop, parameters = {rewards = responseData.rewards}})
            if cb then
                cb()
            end
            local uploadchapters = {1,2,3,7,8,9,12,15}
            local index = chapterId - 100 
            for k, v in pairs(uploadchapters) do
                if v == index then
                    xRecord.af_internal("chapter" .. index )    
                end
            end
        end
    end)
end

---StoryEnterReq 看完剧情领奖
---@param questId string 关卡id
function QuestComponent:StoryEnterReq(questId, cb)
    GameUtils.Request(Interfaces.StoryEnter, {questId = checkNumber(questId)}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            
            if #responseData.rewards > 0 then
                GoodsUtils.DrawRewards(responseData.rewards)
                self:SetShowRewardData(responseData.rewards)
            end
            self:UpdateMainQuestInfo(questId, true)
            if cb then
                cb()
            end
        end
    end)
end

---UnlockFishPlaceState
---鱼场解锁状态的逻辑
function QuestComponent:UnlockFishPlaceState()
    xTry(function()
        local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
        ---鱼场总览是否开始
        ---@type RegionEntryVo
        local regionEntryVo = ActionUtils.GetRegionEntryVo(10)
        if regionEntryVo then
            local isUnlock, err = GameUtils.IsUnlockedSingle(regionEntryVo.unlockType, regionEntryVo.unlockNum, regionEntryVo.unlockId)
            if isUnlock then
                ---功能解锁后再判断鱼场的解锁
                local placeVos = CfUtils.GetCf(AutoIds.IdSetting1840, "FishingPlaceVo", true)
                local storeData = CfUtils.GetLocalData("FISHING_PLACE_UNLOCKED", "")
                local t = {}
                if not string.isEmpty(storeData) then
                    t = table.deserialize(storeData)
                end
                --- {['1] = 1, num = 1} example
                local hasChanged = false
                for i, placeVo in pairs(placeVos) do
                    ---@type FishingPlaceVo
                    local vo = placeVo
                    local isUnlock = GameUtils.IsUnlocked(vo.unlockType, vo.unlockNum, vo.unlockId)
                    ---如果本地记录中不存在这个鱼场 并且是解锁状态时
                    if not t[tostring(vo.id)] and isUnlock then
                        hasChanged = true
                        t[tostring(vo.id)] = 1
                        t.num = checkNumber(t.num) + 1
                    end
                end
                if hasChanged then
                    CfUtils.WriteLocalData("FISHING_PLACE_UNLOCKED", table.serialize(t))
                end
                GameUtils.SetRedPointNum(Constants.RedPointConst.PhoneFishPlaceUnlocked , checkNumber(t.num))
                GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.PhoneFishPlaceUnlocked)
            end
        end
    end)
end

---UpdateMainQuestInfo 更新主线关卡通关信息
---@param levelId string 关卡id
function QuestComponent:UpdateMainQuestInfo(levelId, isEventsBroadcast)
    levelId = checkNumber(levelId)
    --print("====>>", levelId)
    if levelId == 0 then
        return
    end
    self:UnlockFishPlaceState()
    local type = GoodsUtils.GetIdType(levelId, Constants.IDArea.Quests)

    local isChallenge = (type == Constants.IDType.QuestMainChallenge)
    if not isChallenge then
        --大于之前的关卡才更新  会有复刷
        if levelId <= checkNumber(self._curQuestId) then
            return
        end

        --- 检查并插入功能解锁
        -- ---@type PlayerComponent
        -- local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        -- playerComponent:InsertFunctionUnlockDialogData({refId = levelId, unlockType = Constants.CommonUnlockType.PassQuest})

        --- 检查小队评级
        ---@type CardComponent
        --local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
        --cardComp:UpdateRatingIdByQuestId(levelId)

        self._curQuestId = checkNumber(levelId)
        self:SetLastPassQuestId(self._curQuestId)

        local isOnlineUnlocked = SystemToggleMgr:GetInstance():IsUnLockModel(Constants.SystemToggleIds.Id9004, true)
        --print('====>>', isOnlineUnlocked)
        if isOnlineUnlocked then
            ---@type PlayerComponent
            local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
            if playerComponent and checkNumber(playerComponent.playerDojo.onlineTaskInfo.unlockStatus) == 0 and table.count(checkTable(playerComponent.playerDojo.onlineTaskInfo.taskList)) == 0 then
                local playerDojo = playerComponent.playerDojo
                GameUtils.Request(Interfaces.OverseaOnlineTask, { }, function(request, response)
                    local code = checkNumber(response.errCode)
                    if code == 0 then
                        playerDojo.onlineTaskInfo.unlockStatus = 1
                        playerDojo.onlineTaskInfo.taskList = checkTable(response.data.taskList)
                        ---修改为解锁的状态,更新主界面按钮状态
                        Events.Broadcast("ONLINE_REWARD_BUTTON_EVENT")
                    end
                end)
            end
        end
        CfUtils.WriteLocalData("MainChapterNew", 1)

        ---@type IllustratedHandbookComponent
        local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)
        illustratedHandbookComp:UpdateKeywordEncyProgress(self._curQuestId)
        illustratedHandbookComp:UpdateRegionMapEncyProgress()

        --剧情的通关时候才需要
        if isEventsBroadcast then
            Events.Broadcast(Constants.EventNames.MainQuestPass, { questId = levelId })
        end
    else
        if not self:IsPassChallengeLevelById(levelId) then 
            self:SetLastPassQuestId(levelId)
            self._curChallengeQuestId = levelId
        end
        
        local vo = QuestConfMgr:GetInstance():GetQuestVoById(self._curChallengeQuestId)
        if not isNull(vo) and (checkNumber(vo.monsteType) == Constants.RoleClass.Boss) then
            self:UpdateChallengePassedTimes()
        end
        
        --self:UpdateQuestStarInfo(levelId, starInfo)
    end 
end

---UpdateDailyQuestStarInfo 更新主线副本的星级信息
---@param starInfo table 星级信息
---@param questId string 关卡id
function QuestComponent:UpdateQuestStarInfo(questId, starInfo)
    if not questId or not starInfo then
        return
    end

    --如果已经三星全满直接退出
    if QuestConfMgr:GetInstance():IsCompleteAllCondition(questId) then
        return
    end

    local isCanChange = true
    if self._starInfo[checkString(questId)] then
        local count1 = 0
        for k, v in pairs(self._starInfo[checkString(questId)]) do
            if checkNumber(v) == 1 then 
                count1 = count1 + 1
            end
        end

        local count2 = 0
        for k, v in pairs(starInfo) do
            if checkNumber(v) == 1 then 
                count2 = count2 + 1
            end
        end

        --新的比旧的多
        isCanChange = count2 > count1
    end

    --达成三星的不刷新
    --if not QuestConfMgr:GetInstance():IsCompleteAllCondition(questId) then
    if isCanChange then
        --直接覆盖
        self._starInfo[checkString(questId)] = checkTable(starInfo)
    end
end

---SetLastPassQuestId 更新主线关卡通关信息
---@param levelId string 关卡id
function QuestComponent:SetLastPassQuestId(levelId)
    CS.Engine.Lib.KCookie.Set("LastPassQuestId", levelId)
end

--记一次选择
function QuestComponent:GetSelectChapterId()
    local id = self._selectChapterId
    return id
end

function QuestComponent:SetSelectChapterId(chapterId)
    self._selectChapterId = chapterId
end

---IsPassLevelById 关卡是否通关
---@param levelId string 关卡id
function QuestComponent:IsPassLevelById(levelId)
    return checkNumber(self._curQuestId) >= checkNumber(levelId)
end

---IsPassChallengeLevelById 关卡是否通关
---@param levelId string 关卡id
function QuestComponent:IsPassChallengeLevelById(levelId)
    if checkNumber(levelId) == 0 then
        return true
    end

    return checkNumber(self._curChallengeQuestId) >= checkNumber(levelId)
end

--设置剧情关奖励缓存
function QuestComponent:SetShowRewardData(rewardData)
    self._rewardShowData = rewardData
end

function QuestComponent:GetCurQuestId()
    return self._curQuestId
end

--取一次就清空
function QuestComponent:GetShowRewardData()
    local t = clone(self._rewardShowData)
    self:SetShowRewardData()
    return t
end

--支线信息
function QuestComponent:GetSideInfoById(id)
    local t = checkTable(self._sideInfo)
    return t[checkString(id)]
end

function QuestComponent:GetAllDrawChapterIds()
    return checkTable(self._allDrawChapterIds)
end

function QuestComponent:ChapterRewardDrawReq(rewardId, cb)
    GameUtils.Request(Interfaces.OverseaMainQuestChapterReward, {id = rewardId}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local jsonData = response.data

        --一键
        if checkNumber(rewardId) == 0 then
            local t = QuestConfMgr:GetInstance():GetCanDrawChapterRewardIds()
            if t then
                for _, _id in pairs(t) do
                    self._allDrawChapterIds[checkString(_id)] = 1
                end
            end
        else
            self._allDrawChapterIds[checkString(rewardId)] = 1
        end
        
        GoodsUtils.DrawRewards(jsonData.rewards)
        CS.Engine.UI.UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = jsonData.rewards , cb = function()
            if cb then
                cb(jsonData.rewards)
            end
            Events.Broadcast(Constants.EventNames.TriggerGiftCachePop , {})
        end} })
        local uploadchapters = {1,2,3,7,8,9,12}
        rewardId = checkInt(rewardId) 
        local index = rewardId - 100 
        for k, v in pairs(uploadchapters) do
            if v == index then
                xRecord.af_internal("chapter" .. index )    
            end
        end
    end)
end

function QuestComponent:GetChallengePassedTimes()
    return checkNumber(self._curChallengePassedTimes)
end

function QuestComponent:UpdateChallengePassedTimes(num)
    local addNum = 1
    if not isNull(num) and checkNumber(num) > 0 then
        addNum = checkNumber(num)
    end
    self._curChallengePassedTimes = checkNumber(self._curChallengePassedTimes) + addNum

    self:UpdateChallengeRedPoint()
end

function QuestComponent:UpdateChallengeRedPoint()
    local isUnlock = GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id245)
    if isUnlock then
        local totalTimes = self:GetChallengeTotalTimes()
        local leaveTimes = totalTimes - self:GetChallengePassedTimes()
        GameUtils.SetRedPointNum(Constants.RedPointConst.MainHardQuest , leaveTimes > 0 and 1 or 0)
    else
        GameUtils.SetRedPointNum(Constants.RedPointConst.MainHardQuest ,  0)
    end
end

function QuestComponent:GetChallengeTotalTimes()
    local globalTalentMgr = GlobalTalentMgr:GetInstance()
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6127,"MainQuestHardParamVo",1)
    if not isNull(vo) then
        local baseNum = checkNumber(vo.num)
        baseNum = globalTalentMgr:CalcNum(baseNum, Constants.GlobalTalentEffectId.Id_18, false, function(data)
            return true
        end)
        return baseNum
    end
    return 3
end

function QuestComponent:IsCanEnterHardChapter()
    local totalTime = self:GetChallengeTotalTimes()
    local havePassTime = self:GetChallengePassedTimes()
    local leaveTime = totalTime - havePassTime
    return leaveTime > 0
end

return QuestComponent
