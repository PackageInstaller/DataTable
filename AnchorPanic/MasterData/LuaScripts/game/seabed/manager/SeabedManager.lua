module("seabed.SeabedManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()

end

function __initData(self)
    self.mSelectHeroList = {}
    self.mActiveViewList = {}

    self.mAddBuffList = {}
    self.mRemoveBuffList = {}

    self.mAddCollList = {}
    self.mRemoveCollList = {}
end

-- 析构函数
function dtor(self)
end

--- 判断当前是否是调试模式
function getIsDebug(self)
    return false
end

function getSeabedEndIsPass(self)
    return self:getSeabedStoryListIsUnLock(101002)
end

--- 判断是否可以显示红点
-- @return 如果可以显示红旗，则返回true，否则返回false
function getRedFlag(self)
    local canRed = false
    -- 检查是否满足获取任务、剧情、BUFF或收藏平、天赋的条件
    if self:canGetTask() or self:canGetStory() or self:canGetBuffOrColl() or self:canGetTalent() then
        canRed = true
    end
    return canRed
end

--- 判断是否能够获取某个天赋
-- @return 如果可以获取天赋则返回true，否则返回false
function canGetTalent(self)
    -- 获取海底天赋数据字典
    local dic = self:getSeabedTalentData()
    -- 获取当前拥有的天赋点数量
    -- local hasTalentPoint = seabed.SeabedManager:getSeabedTalentPoint()

    -- 遍历字典中的每个天赋项
    for id, vo in pairs(dic) do
        if self:canGetTalentSingle(vo) then
            return true
        end
        -- -- 初始化预设解锁状态为true
        -- local isPreUnLock = true 

        -- -- 检查前置条件是否全部满足
        -- for i = 1, #vo.preId, 1 do
        --     isPreUnLock = isPreUnLock and self:getSeabedTalentMsgDataById(vo.preId[i])
        -- end

        -- -- 检查当前天赋是否未解锁
        -- local isUnLock = self:getSeabedTalentMsgDataById(vo.id)

        -- -- 如果拥有的天赋点足够，且当前天赋未解锁，且前置条件全部满足，则可以获取该天赋
        -- if hasTalentPoint >= vo.needTalent and isUnLock == false and isPreUnLock == true then
        --     return true
        -- end
    end

    -- 如果没有可以获取的天赋，则返回false
    return false
end

function canGetTalentSingle(self, vo)
    local hasTalentPoint = seabed.SeabedManager:getSeabedTalentPoint()
    local isPreUnLock = true
    for i = 1, #vo.preId, 1 do
        isPreUnLock = isPreUnLock and self:getSeabedTalentMsgDataById(vo.preId[i])
    end
    local isUnLock = self:getSeabedTalentMsgDataById(vo.id)
    if hasTalentPoint >= vo.needTalent and isUnLock == false and isPreUnLock == true then
        return true
    end
    return false
end

-- 判断是否可以获取任务
-- @return 如果存在未开始的任务，则返回true，否则返回false
function canGetTask(self)
    -- 没有可以获取的任务
    return self:canGetTaskByType(seabed.SeabedTaskType.Def) or self:canGetTaskByType(seabed.SeabedTaskType.High)
end

function canGetTaskByType(self, type)
    local taskList = self:getSeabedTaskDataByType(type)
    for i = 1, #taskList do
        local msg = self:getSeabedTaskMsgData(taskList[i].id)
        if msg and msg.state == 0 then
            return true
        end
    end
    return false
end

--- 判断是否能够获取增益或收藏品奖励
-- @return 如果可以获取任一类型的奖励，则返回true，否则返回false
function canGetBuffOrColl(self)
    local can = false
    -- 检查是否可以获取收藏品或增益奖励
    can = can or self:canGetGain(seabed.SeabedBattleType.Collage) or self:canGetGain(seabed.SeabedBattleType.Buff)

    return can

end

--- 判断是否能够获取特定类型的增益或收藏品奖励
-- @param type 奖励类型，应为seabed.SeabedBattleType.Collage或seabed.SeabedBattleType.Buff
-- @return 如果可以获取指定类型的奖励，则返回true，否则返回false
function canGetGain(self, type)
    local hasNum = 0
    local dic = {}
    local rewardData = seabed.SeabedManager:getSeabedCollectionRewardData()
    -- 根据类型获取已有的数量
    if type == seabed.SeabedBattleType.Collage then
        hasNum = self:getHisCollNum()
    else
        hasNum = self:getHisBuffNum()
    end

    local filterList = {}
    -- 遍历奖励数据，检查是否有未获取且已解锁的奖励

    for i = 1, #rewardData, 1 do
        if rewardData[i].type == type then
            local isGet = seabed.SeabedManager:getCollageOrBuffIsHas(rewardData[i].id)
            local isUnLock = rewardData[i].num <= hasNum
            if isGet == false and isUnLock == true then
                return true
            end
        end
    end

    return false

end

-- 判断是否可以获取故事
-- @param self 当前对象实例
-- @return 如果存在未获取但已解锁的故事，则返回true，否则返回false
function canGetStory(self)
    -- 获取海底世界展示厅的数据
    local storyData = self:getSeabedSeabedShowroomData()
    -- 遍历故事数据
    for id, vo in pairs(storyData) do
        -- 判断指定ID的故事是否已获取
        local isGet = self:getSeabedStoryAwardIsGet(id)
        -- 判断指定ID的故事是否已解锁
        local isUnLock = self:getSeabedStoryListIsUnLock(vo.storyId)
        -- 如果故事未获取且已解锁，则可以获取故事
        if isGet == false and isUnLock == true then
            return true
        end
    end
    -- 没有可以获取的故事
    return false
end

function parseSeabedTaskMsg(self, msg)
    self.taskInfo = msg.task_info
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)
end

function parseSeabedTaskRewardMsg(self, msg)
    for i = 1, #self.taskInfo, 1 do
        for j = 1, #msg.task_ids, 1 do
            if self.taskInfo[i].id == msg.task_ids[j] then
                self.taskInfo[i].state = 2
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_TASK_PANEL)

end

function parseSeabedTaskMsgUpdate(self, msg)
    for i = 1, #self.taskInfo, 1 do
        if self.taskInfo[i].id == msg.task_info.id then
            self.taskInfo[i] = msg.task_info
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_TASK_PANEL)
end

function parseSeabedStoryListMsg(self, msg)
    for i = 1, #msg.story_list do
        table.insert(self.storyList, msg.story_list[i])
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)
end

function getSeabedStoryListIsUnLock(self, id)
    if self.storyList then
        return table.indexof01(self.storyList, id) > 0
    else
        return false
    end
end

function getSeabedStoryAwardIsGet(self, id)
    if self.gainedShowroomReward then
        return table.indexof01(self.gainedShowroomReward, id) > 0
    end
    return false
end

function parseSeabedStoryAwardMsg(self, msg)
    table.insert(self.gainedShowroomReward, msg.id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_STORY_AWARD_PANEL)
end

function parseSeabedRankListMsg(self, msg)
    self.rankId = msg.rankId
    self.myRank = msg.my_rank
    self.myRankValue = msg.my_rank_val
    self.rankList = msg.rank_list

    GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_RANK_PANEL)
end

function getMySeabedRank(self)
    return self.myRank
end

function getMySeabedRankValue(self)
    return self.myRankValue
end

function getSeabedRankList(self)
    return self.rankList
end

function parseSeabedTalentMsg(self, msg)
    self.talentInfo = msg.talent_info
    self.talentAttr = msg.talent_attr

    self.talentPoint = self.talentInfo.talent_point
    self.talentList = self.talentInfo.talent_list
end

function getTalentAttr(self)
    return self.talentAttr
end

function getSeabedTalentMsgDataById(self, id)
    if self.talentList then
        return table.indexof01(self.talentList, id) > 0
    else
        return false
    end
end

function getSeabedTalentUnlockNum(self)
    return #self.talentList
end

function parseSeabedTalentPointMsg(self, msg)
    self.talentPoint = msg.talent_point

    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_TALENT_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)
end

function getSeabedTalentPoint(self)
    return self.talentPoint and self.talentPoint or 0
end

function parseSeabedUnlockTalentMsg(self, msg)
    table.insert(self.talentList, msg.talent_id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_TALENT_PANEL, {
        id = msg.talent_id
    })
end

function getSeabedTaskMsgData(self, id)
    if self.taskInfo then
        for i = 1, #self.taskInfo, 1 do
            if self.taskInfo[i].id == id then
                return self.taskInfo[i]
            end
        end
    end

    return {
        id = id,
        count = 0,
        state = 1
    }
end

function getCurBuffList(self)
    table.sort(self.buffList, function(a, b)
        return a < b
    end)
    return self.buffList
end

function getCurCollectionList(self)
    table.sort(self.collageList, function(a, b)
        return a < b
    end)
    return self.collageList
end

function parseSeabedPrewarMsg(self, msg)
    self.prewarInfo = msg.prewar_info
    self.abandonTime = msg.abandon_time
    self.isLogin = msg.is_login
    self.collageList = msg.collage_list
    self.buffList = msg.buff_list
    self.curStep = self.prewarInfo.step
    self.difficulty = self.prewarInfo.difficulty
    self.teaserId = self.prewarInfo.teaser_id
    self.skillId = self.prewarInfo.skill_id

    if self.isLogin == 0 then
        GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_ALL_PANEL)
        if self.curStep == seabed.SeabedStepType.Skill then
            GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_SKILL_PANEL)
        elseif self.curStep == seabed.SeabedStepType.Finish then
            local function openMapPanel()
                self:setIsFirstShowMap()
                GameDispatcher:dispatchEvent(EventName.SHOW_SEABED_TOP_PANEL)
                GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_MAP_PANEL)
            end
            self:resetNeedShowFirstLayer()
            GameDispatcher:dispatchEvent(EventName.OPEB_SEABED_SHOW_LAYER_PANEL, {
                callback = openMapPanel
            })
        end
    end
end

function setIsFirstShowMap(self)
    self.firstShowMap = true
end

function getIsFirstShowMap(self)
    local firstShowMap = self.firstShowMap
    self.firstShowMap = false
    return firstShowMap
end

function getHeroList(self)
    return self.heroInfo
end

function getHeroIdList(self)
    local idList = {}
    for i = 1, #self.heroInfo, 1 do
        table.insert(idList, self.heroInfo[i].hero_id)
    end
    return idList
end

function getHpRate(self, id)
    for i = 1, #self.heroInfo do
        if self.heroInfo[i].hero_id == id then
            return self.heroInfo[i].hp_radio
        end
    end
    return 0
end

function parseSeabedResourceMsg(self, msg)
    self.oldCoin = self.coin and self.coin or 0
    self.oldActionPoint = self.actionPoint and self.actionPoint or 0
    self.coin = msg.resource_info.coin
    self.actionPoint = msg.resource_info.action_point
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_TOP_PANEL)
end

function getOldSeabedResource(self)
    return self.oldActionPoint, self.oldCoin
end

function getSeabedResource(self)
    return self.actionPoint, self.coin
end

function parseSeabedLineMsg(self, msg)
    self.lineInfo = msg.line_info
    self.lineId = self.lineInfo.id
    self.layer = self.lineInfo.layer
    self.cellList = self.lineInfo.cell_list

    self.needShowFirstLayer = true
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_TOP_PANEL)
    cusLog("获得了初始化的线段数据|线段id:" .. self.lineId .. " 层数:" .. self.layer)
end

function resetNeedShowFirstLayer(self)
    self.needShowFirstLayer = nil
end

function getNeedShowFirstLayer(self)
    return self.needShowFirstLayer
end

function getCurEventType(self)
    return self.eventType
end

function getMsgCellDataById(self, cellId)
    for i = 1, #self.cellList do
        if self.cellList[i].id == cellId then
            return self.cellList[i]
        end
    end
end

function parseSeabedUpdateCellMsg(self, msg)
    if self.cellList then
        for i = 1, #self.cellList do
            if self.cellList[i].id == msg.cell_info.id then
                self.cellList[i] = msg.cell_info
            end
        end
    end
    self.curCell = msg.cur_cell
    self.eventType = msg.event_type
    self.hisEventType = msg.history_event_type
    self.battleInfo = msg.battle_info
    self.shopInfo = msg.shop_info
    self.passCell = msg.pass_cell
    self.passBranchCell = msg.pass_branch_cell
    self.eventSelectBuff = msg.event_select_buff
    self.battleStep = self.battleInfo.battle_step
    self.battleDupId = self.battleInfo.battle_dup_id
    self.postwarArgs = self.battleInfo.postwar_args
    self.freeResetBuffTimes = self.battleInfo.free_reset_buff_times
    self.costCount = self.battleInfo.cost_coin
    self.postwarBuffReset = self.battleInfo.postwar_buff_reset
    self.heroInfo = self.battleInfo.hero_list

    LoopManager:addFrame(1, 1, self, function()
        GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_SHOP_PANEL)
        GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_MAP_PANEL)
    end)
    cusLog("更新了格子数据| 当前格子:" .. self.curCell .. " 事件类型:" .. self.eventType)
end

function getIsFirstBranchCell(self)
    return #self.passBranchCell == 0
end

function getEventSelectBuff(self)
    return self.eventSelectBuff
end

function getCanResest(self)
    return self.postwarBuffReset == 0
end

function getTodoSomeEvent(self, call)
    cusLog("执行格子事件 当前格子:" .. self.curCell .. " 事件类型:" .. self.eventType ..
               " 历史事件类型:" .. self.hisEventType)

    if self.needShowFirstLayer then
        local function openMapPanel()
            seabed.SeabedManager:setIsFirstShowMap()
            GameDispatcher:dispatchEvent(EventName.SHOW_SEABED_TOP_PANEL)
            GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_MAP_PANEL)
        end

        GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_ALL_PANEL)

        seabed.SeabedManager:resetNeedShowFirstLayer()
        GameDispatcher:dispatchEvent(EventName.OPEB_SEABED_SHOW_LAYER_PANEL, {
            callback = openMapPanel
        })
        return
    end

    -- 以前是默认的地图界面
    if self.hisEventType == seabed.SeabedEventType.Def or self.hisEventType == seabed.SeabedEventType.Cycle then
        -- 地图->地图 默认触发完成
        if self.eventType == seabed.SeabedEventType.Def then
            if self.eventType == seabed.SeabedEventType.Def then
                -- 无需执行任何操作
                if self:canShowAddBuff() or self:canShowRemoveBuff() or self:canShowAddColl() or
                    self:canShowRemoveColl() then
                    GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_BUFF_CHANGE_PANEL)
                end
            end
            -- 地图->编队 循环事件 继续执行
        elseif self.eventType == seabed.SeabedEventType.Cycle then
            call()
            -- 地图->编队
        elseif self.eventType == seabed.SeabedEventType.Fight then
            local battleStep = seabed.SeabedManager:getSeabedBattleStep()
            if battleStep == seabed.SeabedBattleStep.Formation then
                seabed.SeabedManager:setIsDefFormation(true)

                -- LoopManager:setTimeout(0.1, self, function()
                formation.checkFormationFight(PreFightBattleType.Seabed, DupType.Seaded,
                    seabed.SeabedManager:getSeabedBattleDupId(), formation.TYPE.SEABED, nil, nil)
                -- end)

            end
            -- 地图->商店
        elseif self.eventType == seabed.SeabedEventType.Shop then
            GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_SHOP_PANEL)
        elseif self.eventType == seabed.SeabedEventType.SelectBuff then
            GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_BATTLE_BUFF, {
                type = seabed.SeabedBattleType.SelectBuff
            })
        end
    end

    if self.hisEventType == seabed.SeabedEventType.Fight then
        -- 从战斗直接跳到地图界面
        if self.eventType == seabed.SeabedEventType.Def then
            -- -- 如果有变更的buff需要先显示
            -- if self:canShowAddBuff() or self:canShowRemoveBuff() then
            --     GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_BUFF_CHANGE_PANEL)
            -- end
        end

        -- 如果是之前战斗类事件 现在还是战斗类界面事件 
        if self.eventType == seabed.SeabedEventType.Fight then
            GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_BATTLE_BUFF)
            local battleStep = seabed.SeabedManager:getSeabedBattleStep()
            if battleStep == seabed.SeabedBattleStep.Formation then

            elseif battleStep == seabed.SeabedBattleStep.Buff then
                GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_BATTLE_BUFF, {
                    type = seabed.SeabedBattleType.Buff
                })
            elseif battleStep == seabed.SeabedBattleStep.Collage then
                GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_BATTLE_BUFF, {
                    type = seabed.SeabedBattleType.Collage
                })
            end
        elseif self.eventType == seabed.SeabedEventType.Shop then
            GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_SHOP_PANEL)
        end
    end

    if self.hisEventType == seabed.SeabedEventType.Shop then
        if self.eventType == seabed.SeabedEventType.Def then
            GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_SHOP_PANEL)
        end
    end

    if self.hisEventType == seabed.SeabedEventType.SelectBuff then
        if self.eventType == seabed.SeabedEventType.SelectBuff then
            GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_BATTLE_BUFF, {
                type = seabed.SeabedBattleType.SelectBuff
            })
        end
    end

end

function getCurCellId(self)
    return self.curCell
end

function getSeabedBattleStep(self)
    return self.battleStep
end

function getFreeResetTimes(self)
    return self.freeResetBuffTimes
end

function getBattleCostCount(self)
    return self.costCount
end

function getSeabedBattleDupId(self)
    return self.battleDupId
end

function getSeabedBattlePostwar(self)
    return self.postwarArgs
end

function parseSeabedAddBuffMsg(self, msg)
    for i = 1, #msg.buff_list, 1 do
        table.insert(self.buffList, msg.buff_list[i])
        if self.eventType == seabed.SeabedEventType.Def or self.eventType == seabed.SeabedEventType.Cycle or
            self.eventType == seabed.SeabedEventType.Fight then
            table.insert(self.mAddBuffList, msg.buff_list[i])
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_BUFF_OPT)
end

function parseSeabedDelectBuffMsg(self, msg)
    for i = #self.buffList, 1, -1 do
        for j = 1, #msg.buff_list, 1 do
            if self.buffList[i] == msg.buff_list[j] then
                table.remove(self.buffList, i)
                if self.eventType == seabed.SeabedEventType.Def or self.eventType == seabed.SeabedEventType.Cycle or
                    self.eventType == seabed.SeabedEventType.Fight then
                    table.insert(self.mRemoveBuffList, msg.buff_list[j])
                end
            end
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_BUFF_OPT)
end

function canShowAddBuff(self)
    return #self.mAddBuffList > 0
end

function canShowRemoveBuff(self)
    return #self.mRemoveBuffList > 0
end

function getAddBuffList(self)
    return self.mAddBuffList
end

function getRemoveBuffList(self)
    return self.mRemoveBuffList
end

function resetAddBuffList(self)
    self.mAddBuffList = {}
end

function resetRemoveBuffList(self)
    self.mRemoveBuffList = {}
end

function parseSeabedAddCollectionMsg(self, msg)
    for i = 1, #msg.collage_list, 1 do
        table.insert(self.collageList, msg.collage_list[i])
        if self.eventType == seabed.SeabedEventType.Def or self.eventType == seabed.SeabedEventType.Cycle or
            self.eventType == seabed.SeabedEventType.Fight then
            table.insert(self.mAddCollList, msg.collage_list[i])
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_BUFF_OPT)
end

function parseSeabedDelectCollectionMsg(self, msg)
    for i = #self.collageList, 1, -1 do
        for j = 1, #msg.collage_list, 1 do
            if self.collageList[i] == msg.collage_list[j] then
                table.remove(self.collageList, i)
                if self.eventType == seabed.SeabedEventType.Def or self.eventType == seabed.SeabedEventType.Cycle or
                    self.eventType == seabed.SeabedEventType.Fight then
                    table.insert(self.mRemoveCollList, msg.collage_list[j])
                end
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_BUFF_OPT)
end

function canShowAddColl(self)
    return #self.mAddCollList > 0
end

function canShowRemoveColl(self)
    return #self.mRemoveCollList > 0
end

function getAddCollList(self)
    return self.mAddCollList
end

function getRemoveCollList(self)
    return self.mRemoveCollList
end

function resetAddCollList(self)
    self.mAddCollList = {}
end

function resetRemoveCollList(self)
    self.mRemoveCollList = {}
end

function parseSeabedSettleMsg(self, msg)
    self.isPass = msg.is_pass
    self.point = msg.point
    self.statsList = msg.stats_list
    self.addTalentPoint = msg.talent_point
    self.hasSettleData = true

    self.pointMultiple = msg.point_multiple
    self.difficulty = msg.difficulty
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_TALENT_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_MAIN_PANEL)
end

function getSeabedHasSettleData(self)
    return self.hasSettleData == true
end

function getSeabedIsPass(self)
    local isPass = self.isPass
    self.isPass = 0
    return isPass == 1
end

function getSeabedSettInfo(self)
    return self.point, self.addTalentPoint, self.statsList
end

function getSeabedPointMultipleData(self)
    return self.difficulty, self.pointMultiple
end

function resSeabedSettInfo(self)
    self.point = 0
    self.addTalentPoint = 0
    self.statsList = {}
    self.hasSettleData = false
end

function parseSeabedHistoryMsg(self, msg)
    self.historyInfo = msg.history_info
    self.hisMaxDifficulty = self.historyInfo.max_difficulty
    self.hisCollageList = self.historyInfo.collage_list
    self.hisBuffList = self.historyInfo.buff_list
    self.storyList = self.historyInfo.story_list
    self.gainCollageOrBuffRewardList = self.historyInfo.gain_collage_or_buff_reward_list
    self.gainedShowroomReward = self.historyInfo.gained_showroom_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)

end

function parseSeabedGetCollectionOrBuffMsg(self, msg)
    table.insert(self.gainCollageOrBuffRewardList, msg.id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_COLLECTION_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_COLLECTION_AWARD_PANEL)

end

function getHisBuffNum(self)
    if self.hisBuffList ~= nil then
        return #self.hisBuffList
    else
        return 0 
    end
end

function getHisCollNum(self)
    if self.hisCollageList ~= nil then
        return #self.hisCollageList
    else 
        return 0
    end
end

function getCollageOrBuffIsHas(self, id)
    if self.gainCollageOrBuffRewardList then
        return table.indexof01(self.gainCollageOrBuffRewardList, id) > 0
    else
        return false
    end
   
end

function getHisBuffIsHas(self, id)
    if self.hisBuffList then
        return table.indexof01(self.hisBuffList, id) > 0
    else
        return false
    end
end

function getHisCollectionIsHas(self, id)
    if self.hisCollageList then
        return table.indexof01(self.hisCollageList, id) > 0
    else
        return false
    end
end

function parseSeabedBuyGoodsMsg(self, msg)
    for i = 1, #self.shopInfo.goods_list, 1 do
        if self.shopInfo.goods_list[i].id == msg.goods_id then
            self.shopInfo.goods_list[i].is_buy = 1
        end
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_SEABED_SHOP_PANEL, {
        id = msg.goods_id
    })
end

function getSeabedShopInfo(self)
    return self.shopInfo
end

function getCanClickCell(self)
    if self.curCell == 0 and #self.passCell == 0 then
        return {1}
    else
        local lastId = self:getLastCellId()
        if lastId == 0 then
            return {1}
        else
            local lineVo = seabed.SeabedManager:getCurSeabedLineData()
            local cellVo = lineVo:getSingleCellData(lastId)
            return cellVo.nextIds
        end
    end
end

function getCellIsPass(self, id)
    return table.indexof01(self.passCell, id) > 0
end

function getLastCellId(self)
    if #self.passCell > 0 then
        return self.passCell[1]
    else
        return 0
    end
end

function getCurMapName(self)
    local lineId = self:getLineId()
    if lineId > 0 then
        return _TT(self:getSeabedLineData(lineId).name)
    else
        return ""
    end
end

-- 获取解锁的难度
function getDifficultyIsLock(self, id)
    if id <= self:getHisUnLockMaxDifficulty() then
        return false
    else
        return true
    end
end

function getHisUnLockMaxDifficulty(self)
    return gs.Mathf.Clamp(self.hisMaxDifficulty + 1, 0, self.mSeabedMaxDifficulty)
end

function getHisMaxDifficulty(self)
    return self.hisMaxDifficulty
end

function getLineId(self)
    return self.lineId ~= nil and self.lineId or 0
end

function getSeabedStart(self)
    return self.curStep > seabed.SeabedStepType.Dif
end

function getSeabedCurStep(self)
    return self.curStep
end

------------------------------------------难度相关------------------------------------------
-- 解析海底难度数据，并存储到实例的mSeabedDifficultyData表中。
-- 同时更新最大的海底难度值mSeabedMaxDifficulty。
function parseSeabedDifficultyData(self)
    self.mSeabedDifficultyData = {} -- 存储解析后的海底难度数据
    self.mSeabedMaxDifficulty = 0 -- 记录最大的海底难度值
    local baseData = RefMgr:getData("seabed_difficulty_data") -- 获取基础的海底难度数据
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedDifficultyVo.new() -- 创建一个新的难度对象
        vo:parseData(id, data) -- 解析数据并填充到难度对象中
        if id > self.mSeabedMaxDifficulty then
            self.mSeabedMaxDifficulty = id -- 更新最大难度值
        end
        table.insert(self.mSeabedDifficultyData, vo) -- 将解析后的难度对象插入到列表中
    end
    -- 对难度数据进行排序，确保按照难度ID升序排列
    table.sort(self.mSeabedDifficultyData, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

-- 获取已解析的海底难度数据列表。如果数据尚未解析，则先调用parseSeabedDifficultyData进行解析。
function getSeabedDifficultyData(self)
    if self.mSeabedDifficultyData == nil then
        self:parseSeabedDifficultyData()
    end
    return self.mSeabedDifficultyData
end

-- 获取记录的最大海底难度值。如果数据尚未解析，则先调用parseSeabedDifficultyData进行解析。
function getSeabedMaxDifficulty(self)
    if self.mSeabedMaxDifficulty == nil then
        self:parseSeabedDifficultyData()
    end
    return self.mSeabedMaxDifficulty
end

-- 根据指定的难度ID获取对应的海底难度数据对象。如果数据尚未解析，则先调用parseSeabedDifficultyData进行解析。
function getSeabedDifficultyDataById(self, id)
    if self.mSeabedDifficultyData == nil then
        self:parseSeabedDifficultyData()
    end
    for i = 1, #self.mSeabedDifficultyData do
        if self.mSeabedDifficultyData[i].id == id then
            return self.mSeabedDifficultyData[i]
        end
    end
end

------------------------------------------难题相关------------------------------------------

-- 解析海底挑战者数据，并存储到实例中
function parseSeabedTeaserData(self)
    -- 初始化数据表和最大挑战者ID
    self.mSeabedTeaserData = {}
    self.mSeabedMaxTeaser = 0

    -- 从引用管理器获取基础数据
    local baseData = RefMgr:getData("seabed_teaser_data")

    -- 遍历基础数据，创建并解析每个挑战者数据对象
    for k, v in pairs(baseData) do
        local vo = seabed.SeabedTeaserVo.new()
        vo:parseData(k, v)
        -- 更新最大挑战者ID
        if self.mSeabedMaxTeaser < vo.id then
            self.mSeabedMaxTeaser = vo.id
        end

        -- 将解析后的数据对象插入到数据表中
        table.insert(self.mSeabedTeaserData, vo)
    end

    -- 根据ID对数据表进行排序
    table.sort(self.mSeabedTeaserData, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

-- 根据难度等级获取对应的海底难题描述列表
function getSeabedTeaserDesByTeaser(self, teaser)
    local des = {} -- 用于存放符合条件的难题描述
    -- 如果数据未解析，则先解析数据
    if self.mSeabedTeaserData == nil then
        self:parseSeabedTeaserData()
    end
    -- 遍历数据表，将难度等级小于等于指定难度的难题描述添加到列表中
    for i = 1, #self.mSeabedTeaserData do
        if self.mSeabedTeaserData[i].id <= teaser then
            table.insert(des, self.mSeabedTeaserData[i].des)
        end
    end
    return des
end

-- 获取最大的海底挑战者ID
function getSeabedMaxTeaser(self)
    -- 如果数据未解析，则先解析数据
    if self.mSeabedMaxTeaser == nil then
        self:parseSeabedTeaserData()
    end
    return self.mSeabedMaxTeaser
end

-- 获取额外的行动点
function getExtraActionPoint(self)
    local extra = 0
    if self.teaserId ~= nil then
        if self.mSeabedTeaserData == nil then
            self:parseSeabedTeaserData()
        end
        for i = 1, #self.mSeabedTeaserData do
            if self.mSeabedTeaserData[i].id <= self.teaserId then
                extra = self.mSeabedTeaserData[i].extraActionPoint + extra
            end
        end
    end
    return extra
end

------------------------------------------指挥官技能相关------------------------------------------

-- 解析海底技能数据并存储在类的成员变量中
function parseSeabedSkillData(self)
    self.mSeabedSkillData = {}
    local baseData = RefMgr:getData("seabed_skill_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedSkillVo.new()
        vo:parseData(id, data)
        table.insert(self.mSeabedSkillData, vo)
    end

    table.sort(self.mSeabedSkillData, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

-- 获取已解析的海底技能数据，如果尚未解析则先进行解析
function getSeabedSkillData(self)
    if self.mSeabedSkillData == nil then
        self:parseSeabedSkillData()
    end
    return self.mSeabedSkillData
end

------------------------------------------关卡相关------------------------------------------

function parseSeabedData(self)
    self.mSeabedData = {}
    local baseData = RefMgr:getData("seabed_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedVo.new()
        vo:parseData(id, data)
        self.mSeabedData[id] = vo
    end
end

function getSeabedData(self, id)
    if self.mSeabedData == nil then
        self:parseSeabedData()
    end
    return self.mSeabedData[id]
end

function parseSeabedLineData(self)
    self.mSeabedLineData = {}
    local baseData = RefMgr:getData("seabed_line_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedLineVo.new()
        vo:parseData(id, data)
        self.mSeabedLineData[id] = vo
    end
end

function getSeabedLineData(self, id)
    if self.mSeabedLineData == nil then
        self:parseSeabedLineData()
    end

    return self.mSeabedLineData[id]
end

function getCurSeabedLineData(self)
    if self.mSeabedLineData == nil then
        self:parseSeabedLineData()
    end
    return self.mSeabedLineData[self:getLineId()]
end

------------------------------------------buff相关------------------------------------------
function parseSeabedBuffData(self)
    self.mSeabedBuffData = {}
    local baseData = RefMgr:getData("seabed_buff_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedBuffVo.new()
        vo:parseData(id, data)
        self.mSeabedBuffData[id] = vo
    end
end

function getSeabedBuffDataById(self, id)
    if self.mSeabedBuffData == nil then
        self:parseSeabedBuffData()
    end
    return self.mSeabedBuffData[id]
end

function getSeabedBuffData(self)
    if self.mSeabedBuffData == nil then
        self:parseSeabedBuffData()
    end
    return self.mSeabedBuffData
end

------------------------------------------收藏品相关------------------------------------------
function parseSeabedCollectionData(self)
    self.mSeabedCollectionData = {}
    local baseData = RefMgr:getData("seabed_collage_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedCollectionVo.new()
        vo:parseData(id, data)
        self.mSeabedCollectionData[id] = vo
    end
end

function getSeabedCollectionDataById(self, id)
    if self.mSeabedCollectionData == nil then
        self:parseSeabedCollectionData()
    end
    return self.mSeabedCollectionData[id]
end

function getSeabedCollectionData(self)
    if self.mSeabedCollectionData == nil then
        self:parseSeabedCollectionData()
    end
    return self.mSeabedCollectionData
end

------------------------------------------事件相关------------------------------------------
function parseSeabedEventData(self)
    self.mSeabedEventData = {}
    local baseData = RefMgr:getData("seabed_event_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedEventVo.new()
        vo:parseData(id, data)
        self.mSeabedEventData[id] = vo
    end
end

function getSeabedEventDataById(self, id)
    if self.mSeabedEventData == nil then
        self:parseSeabedEventData()
    end
    return self.mSeabedEventData[id]
end

------------------------------------------点数相关------------------------------------------
function parseSeabedPointData(self)
    self.mSeabedPointData = {}
    local baseData = RefMgr:getData("seabed_point_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedPointVo.new()
        vo:parseData(id, data)
        self.mSeabedPointData[id] = vo
    end
end

function getSeabedPointDataById(self, id)
    if self.mSeabedPointData == nil then
        self:parseSeabedPointData()
    end
    return self.mSeabedPointData[id]
end

function getSeabedPointData(self)
    if self.mSeabedPointData == nil then
        self:parseSeabedPointData()
    end
    return self.mSeabedPointData
end

------------------------------------------商店相关------------------------------------------

function parseSeabedShopData(self)
    self.mSeabedShopData = {}
    local baseData = RefMgr:getData("seabed_shop_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedShopVo.new()
        vo:parseData(id, data)
        self.mSeabedShopData[id] = vo
    end
end

function getSeabedShopDataById(self, id)
    if self.mSeabedShopData == nil then
        self:parseSeabedShopData()
    end
    return self.mSeabedShopData[id]
end

------------------------------------------剧情相关------------------------------------------

function parseSeabedShowroomData(self)
    self.mSeabedShowroomData = {}
    local baseData = RefMgr:getData("seabed_showroom_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedShowroomVo.new()
        vo:parseData(id, data)
        self.mSeabedShowroomData[id] = vo
    end
end

function getSeabedShowroomDataById(self, id)
    if self.mSeabedShowroomData == nil then
        self:parseSeabedShowroomData()
    end
    return self.mSeabedShowroomData[id]
end

function getSeabedSeabedShowroomData(self)
    if self.mSeabedShowroomData == nil then
        self:parseSeabedShowroomData()
    end
    return self.mSeabedShowroomData
end

------------------------------------------天赋相关------------------------------------------
function parseSeabedTalentData(self)
    self.mSeabedTalentData = {}
    local baseData = RefMgr:getData("seabed_talent_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedTalentVo.new()
        vo:parseData(id, data)
        self.mSeabedTalentData[id] = vo
    end
end

function getSeabedTalentDataById(self, id)
    if self.mSeabedTalentData == nil then
        self:parseSeabedTalentData()
    end
    return self.mSeabedTalentData[id]
end

function getSeabedTalentData(self)
    if self.mSeabedTalentData == nil then
        self:parseSeabedTalentData()
    end
    return self.mSeabedTalentData
end

------------------------------------------任务相关------------------------------------------
function parseSeabedTaskData(self)
    self.mSeabedTaskData = {}
    local baseData = RefMgr:getData("seabed_task_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedTaskVo.new()
        vo:parseData(id, data)
        self.mSeabedTaskData[id] = vo
    end
end

function getSeabedTaskDataById(self, id)
    if self.mSeabedTaskData == nil then
        self:parseSeabedTaskData()
    end
    return self.mSeabedTaskData[id]
end

function getSeabedTaskDataByType(self, type)
    if self.mSeabedTaskData == nil then
        self:parseSeabedTaskData()
    end

    local typeList = {}
    for id, vo in pairs(self.mSeabedTaskData) do
        if vo.tagType == type then
            table.insert(typeList, vo)
        end
    end
    return typeList
end

------------------------------------------关卡相关------------------------------------------
function parseSeabedDupData(self)
    self.mSeabedDupData = {}
    local baseData = RefMgr:getData("seabed_dup_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedDupVo.new()
        vo:parseData(id, data)
        self.mSeabedDupData[id] = vo
    end
end

function getSeabedDupDataById(self, dupId)
    if self.mSeabedDupData == nil then
        self:parseSeabedDupData()
    end
    return self.mSeabedDupData[dupId]
end

------------------------------------------收藏奖励相关------------------------------------------
function parseSeabedCollectionRewardData(self)
    self.mSeabedCollectionRewardData = {}
    local baseData = RefMgr:getData("seabed_collage_reward_data")
    for id, data in pairs(baseData) do
        local vo = seabed.SeabedCollectionRewardVo.new()
        vo:parseData(id, data)
        self.mSeabedCollectionRewardData[id] = vo
    end
end

function getSeabedCollectionRewardData(self)
    if self.mSeabedCollectionRewardData == nil then
        self:parseSeabedCollectionRewardData()
    end
    return self.mSeabedCollectionRewardData
end

------------------------------------------本地临时存储数据------------------------------------------

function addSelectHeroId(self, heroId)
    if #self.mSelectHeroList >= 5 then
        gs.Message.Show("已满员")
        return
    end

    if table.indexof01(self.mSelectHeroList, heroId) <= 0 then
        table.insert(self.mSelectHeroList, heroId)
    end
end

function removeSelectHeroId(self, heroId)
    local index = table.indexof01(self.mSelectHeroList, heroId)
    if index > 0 then
        table.remove(self.mSelectHeroList, index)
    end
end

function getHeroInSelect(self, heroId)
    return table.indexof01(self.mSelectHeroList, heroId) > 0
end

function getHeroSelectList(self)
    return self.mSelectHeroList
end

function clearSelectHeroList(self)
    self.mSelectHeroList = {}
end

function getHeroInAssist(self, heroId)
    return false
end

function setSelectDifficulty(self, difficulty, difficult)
    self.selectDifficulty = difficulty
    self.selectDifficult = difficult
end

function getSelectDifficulty(self)
    return self.selectDifficulty, self.selectDifficult
end

function setIsDefFormation(self, isDef)
    self.isDefFormation = isDef
end

function getIsDefFormation(self)
    return self.isDefFormation
end

function setOpenIsPass(self, isPass)
    self.openIsPass = isPass
end

function getOpenIsPass(self)
    return self.openIsPass
end

function setNeedShowTips(self, isNeed)
    self.isNeedShowTips = isNeed
end

function getNeedShowTips(self)
    return self.isNeedShowTips and self:getIsFirstShowTips()
end

function setFirstShowTips(self, isShow)
    self.isFirstShow = isShow
end

function getIsFirstShowTips(self)
    return self.isFirstShow == nil
end

function getDupName(self, cusId)
    return ""
end

function setLastTeaser(self, teaser)
    self.lastTeaser = teaser
end

function getLastTeaser(self)
    return self.lastTeaser and self.lastTeaser or 0
end

return _M
