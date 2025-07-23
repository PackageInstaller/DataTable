module("game.cycle.manager.CycleManager", Class.impl(Manager))
------------------------------------------------------------
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
    self.mGroupClassCopy = {}
    self.mMapClassCopy = {}
    self.mMapIdClassCopy = {}
    self.lastEventId = 0
    self.mHisCollageList = {}
    self.mCollageList = {}
    self.mGoodsMsgDic = {}
    self.mCollectSelected = 0
    self.firstLineIds = {}
    self.mUnLockStory = {}
    self.mNowEventTrans = nil
    self.mEndFight = false
end

-- 析构函数
function dtor(self)
end

function setNowEventTrans(self, trans)
    self.mNowEventTrans = trans
end

function getNowEventTrans(self)
    return self.mNowEventTrans
end

function setFightEnd(self, isFightEnd)
    self.mEndFight = isFightEnd
end

function getFightEnd(self)
    return self.mEndFight
end
------------------------------------------------------------server data------------------------------------

-- 解析剧情数据
function updateStoryServerInfo(self, args)
    self.mUnLockStory = args.story_list
end

-- 获取剧情是否解锁
function getStoryIsLock(self, storyId)
    local storyDic = self:getCycleStoryData()

    for k, v in pairs(storyDic) do
        if v.storyId == storyId and self.mUnLockStory and table.indexof01(self.mUnLockStory, storyId) > 0 then
            return true
        end
    end

    return false
end

-- 解析任务信息
function parseCycleTaskInfo(self, args)
    -- self.mTaskDic = args.task_info
    cusLog("获取任务数据")
    self.mResetTime = args.reset_time
    self.mRefreshTimes = args.refresh_times
    self.mServerTaskDic = {}
    for i = 1, #args.task_info do
        self.mServerTaskDic[args.task_info[i].id] = args.task_info[i]
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_TASK_ALL_PANEL)
end

function setLastIndex(self, lastIndex,taskId)
    self.mLastIndex = lastIndex
    self.mLastTaskId = taskId
   
end

function getLastIndex(self)
    return self.mLastIndex
end

-- 获取任务刷新时间
function getResetTime(self)
    return self.mResetTime
end

-- 获取任务刷新次数
function getTaskRefreshTimes(self)
    return self.mRefreshTimes
end

-- 获取所有任务信息
function getServerTaskDic(self)
    return self.mServerTaskDic
end

-- 获取任务进度
function getServerTaskProgress(self)
    local overCount = 0
    local allCount = 0
    for _, taskVo in pairs(self.mServerTaskDic) do
        allCount = allCount + 1
        local taskData = cycle.CycleManager:getCycleTaskData(taskVo.id)
        if taskVo.count >= taskData.times then
            overCount = overCount + 1
        end
    end
    return overCount, allCount
end

-- 更新任务
function updateCycleTaskInfo(self, args)
    cusLog("单独更新")

    for k,v in pairs(self.mServerTaskDic) do
        if k == self.mLastTaskId then
            self.mServerTaskDic[k] = nil
        end
    end

    self.mServerTaskDic[args.task_info.id] = args.task_info
    self.mRefreshTimes = args.refresh_times

    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_TASK_PANEL, {
        info = args.task_info
    })
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_TASK_PANEL)
end

function disposeStepEvent(self)
    -- GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)
    -- 关闭所有的步骤界面
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_STEP_PANEL_ALL)

    if self.mStep == CYCLE_STEP.SELECT_DIFFICULT then
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_LEVEL_SELECT_PANEL)
    elseif self.mStep == CYCLE_STEP.SELECT_BUFF then
        self.mHeroList = {}
        self.mCollageList = {}
        GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_COLLECTION)
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_BUFF_SELECT_PANEL)
    elseif self.mStep == CYCLE_STEP.SELECT_COMBO then
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_COMBO_PANEL)
    elseif self.mStep == CYCLE_STEP.SELECT_TICKET then
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_RECRUIT_PANEL) --
    elseif self.mStep == CYCLE_STEP.SELECT_RECRUIT then
        self:setCurTicketAndType(self.mCurTicket, RECUIT_TYPE.STEP)
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_HERO_SELECT_PANEL) --
    elseif self.mStep == CYCLE_STEP.FINISH then
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_RECRUIT_PANEL)
    elseif self.mStep == CYCLE_STEP.ENTER_MAP then
        local function openMapPanel()
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_MAP_PANEL)
        end

        if table.indexof01(self.firstLineIds, self.mLineId) > 0 then
            openMapPanel()
        else
            table.insert(self.firstLineIds, self.mLineId)
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_SHOW_LAYER_PANEL, {
                id = self.mLineId,
                callback = openMapPanel
            })
        end
    end
end

-- 解析资源数据
function parseResourceInfo(self, args)
    cusLog("资源数据更新")
    if self.mResourceInfo == nil then
        self.oldResourceInfo = {}
    else
        self.oldResourceInfo = self.mResourceInfo
    end

    self.mResourceInfo = args.resource_info

    GameDispatcher:dispatchEvent(EventName.UPDA_CYCLE_TOP_PANEL)
end

-- 获取资源数据
function getResourceInfo(self)
    return self.mResourceInfo
end

-- 获取旧的数据资源
function getOldResourceInfo(self)
    return self.oldResourceInfo
end

-- 更新步骤数据
function parseCycleMapInfo(self, args)
    cusLog("服务器更新步骤数据")
    self.mMapInfos = args.prewar_info

    -- 是否主动打开页面
    self.mOpenPanel = args.open_panel == 1
    -- 步骤id
    self.mStep = self.mMapInfos.step

    -- 清空当前
    if self.mStep == 0 then
        self.firstLineIds = {}
    end
    -- 放弃时间戳
    self.mAbandonTime = args.abandon_time
    -- 难度
    self.mOldDiff = self.mDifficult
    self.mDifficult = self.mMapInfos.difficulty
    -- 当前招募卷id
    self.mCurTicket = self.mMapInfos.cur_ticket
    -- 招募卷列表
    self.mTicketList = self.mMapInfos.ticket_info
    -- 策略id
    self.mStrategy = self.mMapInfos.strategy

    -- 解析持有的战员
    self:parseCycleHeroDic(self.mTicketList)

    -- 如果后端推送需要打开页面
    if self.mOpenPanel then
        self:disposeStepEvent()
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_MAIN_PANEL)
end

function getCycleHistoryDifficult(self)
    return self.mOldDiff
end

-- 获取招募策略
function getCycleStrategy(self)
    return self.mStrategy
end

-- 获取难度
function getCycleDifficult(self)
    return self.mDifficult
end

-- 获取放弃时间戳
function getCycleAbandonTime(self)
    return (self.mAbandonTime) and self.mAbandonTime or 0
end

-- 获取受限的最大等级
function getMaxDifficultyVo(self)
    local maxDifficultyNum = self:getMaxCycleDifficultyNum()
    local minValue = math.min(self:getMaxDifficulty() + 1, maxDifficultyNum)
    return self:getDifficultVoById(minValue)
end

-- 解析结算数据
function parseCycleSettleInfo(self, args)

    cusLog("获取了结算数据")
    -- 旧的等级
    self.mOldLv = args.old_lv
    -- 新的等级
    self.mNewLv = args.new_lv
    -- 添加的天赋点
    self.mAddTalentPoint = args.add_talent_point
    -- 是否通关
    self.mIsPass = args.is_pass

    self.mPoint = args.point
    self.mAddExp = args.add_exp
    self.mStatsInfo = {}
    for k, v in pairs(args.stats_info) do
        self.mStatsInfo[v.id] = v.count
    end
    -- self.mStatsInfo = args.stats_info
    self:closeUpdateOtherPanel()
end

-- 是否通关
function getCycleSettIsPass(self)
    local isPass = self.mIsPass
    self.mIsPass = 0
    return isPass == 1
end

-- 获取结算数据
function getCycleSettleInfo(self)
    return self.mPoint, self.mAddExp, self.mStatsInfo, self.mOldLv, self.mNewLv, self.mAddTalentPoint
end

-- 重置结算数据
function resetCycleSettleInfo(self)
    self.mPoint = nil
    self.mAddExp = nil
    self.mStatsInfo = nil
    self.mOldLv = nil
    self.mNewLv = nil
    self.mAddTalentPoint = nil
end

-- 解析历史数据
function parseHistoryInfo(self, args)
    self.mHistoryInfo = args.history_info
    self.mHisCollageList = self.mHistoryInfo.collage_list
    -- 最大
    self.mMaxDifficulty = self.mHistoryInfo.max_difficulty
    self.mUnlockStrategy = self.mHistoryInfo.unlock_strategy

    -- 奖励相关
    -- 等级
    self.mGainLvRewardList = self.mHistoryInfo.gained_lv_reward_list
    -- 收藏品 
    self.mGainedCollageRewardList = self.mHistoryInfo.gained_collage_reward_list
    -- 剧情
    self.mShowroomRewardList = self.mHistoryInfo.gained_showroom_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_RED)
end

function getRedFlag(self)
    local canRed = false
    if self:canGetCollection() or self:canGetStory() or self:canReceiveAward() then
        canRed = true
    end
    return canRed
end

function canGetCollection(self)
    local canGet = false
    local count = #cycle.CycleManager:getCycleHasCollection()
    local list = cycle.CycleManager:getCycleCollageAwardData()

    for i = 1, #list do
        local state = cycle.CycleManager:getGainedCollageReward(list[i].id)
        if state == false and count >= list[i].num then
            canGet = true
            break
        end
    end
    return canGet
end

function canGetStory(self)
    local canGet = false
    local storyData = cycle.CycleManager:getCycleStoryData()
    for k, v in pairs(storyData) do
        local state = cycle.CycleManager:getShowroomReward(k)
        local isUnLock = cycle.CycleManager:getStoryIsLock(v.storyId)
        if state == false and isUnLock == true then
            canGet = true
            break
        end
    end
    return canGet
end

--可领奖励
function canReceiveAward(self)
    return self.mHistoryInfo and #self.mHistoryInfo.gained_lv_reward_list < self.mHistoryInfo.lv or false
end

-- 判断收藏品是否已经领奖
function getGainedCollageReward(self, id)
    if self.mGainedCollageRewardList then
        return table.indexof01(self.mGainedCollageRewardList, id) > 0
    end
    return false
end

-- 更新收藏品领奖状态
function updateCycleCollageAwardInfo(self, id)
    if self.mGainedCollageRewardList == nil then
        self.mGainedCollageRewardList = {}
    end

    table.insert(self.mGainedCollageRewardList, id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_COLLECTION_AWARD_PANEL)
end

function getShowroomReward(self, id)
    if self.mShowroomRewardList then
        return table.indexof01(self.mShowroomRewardList, id) > 0
    end
    return false
end

function updateCycleStoryAwardInfo(self, id)
    if self.mShowroomRewardList == nil then
        self.mShowroomRewardList = {}
    end
    table.insert(self.mShowroomRewardList, id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_STORY_AWARD_PANEL)
end

-- 获取最大难度
function getMaxDifficulty(self)
    return self.mMaxDifficulty
end

-- 获取解锁的策略
function getUnLockStrategy(self)
    return self.mUnlockStrategy
end

-- 获取服务器格子数据
function parseCycleLineInfo(self, args)
    cusLog("获取服务器全部格子数据")
    self.mLineInfo = args.line_info

    self.mLineId = self.mLineInfo.id
    self.mLayer = self.mLineInfo.layer
    self.mCurCell = self.mLineInfo.cur_cell
    self.mHeroList = self.mLineInfo.hero_list
    self.mPassCell = self.mLineInfo.pass_cell

    self.mCellInfo = self.mLineInfo.cell_info

    self:parseCellData()

    self:closeUpdateOtherPanel()
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_MAP_PANEL)
    GameDispatcher:dispatchEvent(EventName.CHANGE_LAYER)
end

function getLayerCollageList(self)
    local collageList = {}
    if self.mCollageList then
        for i = 1, #self.mCollageList do
            local vo = self:getCycleCollectionDataById(self.mCollageList[i])
            table.insert(collageList, vo)
        end
    end
    return collageList
end

-- 获取当前的层数
function getCurrentLayer(self)
    return self.mLayer
end

-- 解析投资商店数据
function parseCycleInvestInfo(self, args)
    cusLog("获取了投资商店的数据")
    self.mInvestInfo = args.shop_info

    -- 等级
    self.mInvestLv = self.mInvestInfo.lv
    -- 经验
    self.mInvestExp = self.mInvestInfo.exp
    -- 可使用资产
    self.mInvestUseCoin = self.mInvestInfo.use_coin
    -- 总投资硬币数
    self.mInvestAllCoin = self.mInvestInfo.all_coin
    -- 已经投了的钱
    self.mInvestDepositCoinLimit = self.mInvestInfo.deposit_coin_limit
    -- 已经取了的钱
    self.mInvestWithdrawCoinLimit = self.mInvestInfo.withdraw_coin_limit
    -- 是否可以取款
    self.mCanWithdraw = self.mInvestInfo.can_withdraw
    -- 刷新次数
    self.mRefeshTimes = self.mInvestInfo.refresh_times

    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_SHOP_PANEL)
end

-- 总投资数
function getInvestMaxValue(self)
    return self.mInvestAllCoin
end

-- 可以使用的资产
function getInvestCurrentCoin(self)
    return self.mInvestUseCoin
end
-- 可以已经投资的钱
function getInvestDepositCoinLimit(self)
    return self.mInvestDepositCoinLimit
end
-- 已经取出的钱
function getInvestWithdrawCoinLimit(self)
    return self.mInvestWithdrawCoinLimit
end

-- 是否可以取钱
function getCanWithdraw(self)
    return self.mCanWithdraw
end

-- 获取商店剩余的刷新次数
function getCycleShopRefeshTimes(self)
    return self.mRefeshTimes
end

-- 解析商品数据
function parseCycleShopInfo(self, args)

    cusLog("收到了商品数据=============================")
    self.mShopInfo = args.shop_info
    self.mCurTicket = self.mShopInfo.cur_ticket
    -- 商品列表
    local goodsList = self.mShopInfo.goods_list
    -- 清空之前的数据
    self.mGoodsMsgDic = {}
    for i = 1, #goodsList do
        local goodMsgVo = cycle.CycleGoodMsgVo.new()
        goodMsgVo:parseGoodMsgVo(goodsList[i])
        self.mGoodsMsgDic[goodMsgVo.id] = goodMsgVo
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_SHOP_PANEL)
end

-- 获取商店数据
function getGoodsMsgData(self)
    return self.mGoodsMsgDic, self.mCurTicket
end

--获取对应商品的实际价格
function getGoodsMsgDataPrice(self,id)
    return self.mGoodsMsgDic[id].price
end

-- 更新商品购买
function parseCycleBuyUpdateInfo(self, args)
    if args.result == 1 then
        -- 前端自己修改购买
        self.mGoodsMsgDic[args.goods_id].isBuy = 1
        self.mCurTicket = args.cur_ticket
        GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_SHOP_PANEL)
        self:setCurTicketAndType(self.mCurTicket, RECUIT_TYPE.SHOP)
        if args.cur_ticket > 0 then
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_HERO_SELECT_PANEL) --
        end
    end
end

-- 更新收藏品
function parseCollageUpdateInfo(self, args)
    -- cusLog("获得收藏品数据")
    if args.show_windows == 1 then
        local mNewCollectTid = -1
        -- 招募战员品质消耗    
        for _, colletionTid in pairs(args.collage_list) do
            if not table.indexof(self.mCollageList, colletionTid) then
                mNewCollectTid = colletionTid
            end
        end
        if mNewCollectTid > 0 then
            cycle.CycleShowAwardPanel:showPropsAwardMsg(mNewCollectTid)
        end
    end

    -- 收藏品信息
    self.mCollageList = args.collage_list
    self.mColorCost = args.color_cost
    -- 招募战员属性消耗
    self.mEleCost = args.ele_cost
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_MAP_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_COLLECTION)
end

-- 获取战员品质消耗
function getColorCostByColor(self, color)
    for i = 1, #self.mColorCost do
        if self.mColorCost[i].color == color then
            return self.mColorCost[i].hope
        end
    end
end

-- 获取战员属性消耗
function getEleCost(self, ele)
    for i = 1, #self.mEleCost do
        if self.mEleCost[i].ele == ele then
            if self.mEleCost[i].type == 1 then
                return self.mEleCost[i].hope * -1
            else
                return self.mEleCost[i].hope
            end
        end
    end
    return 0
end

function getCycleHasCollection(self)
    local hasList = {}
    for k, v in pairs(self.mHisCollageList) do
        local vo = self:getCycleCollectionDataById(v)
        table.insert(hasList, vo)
    end
    return hasList
end

-- 判断历史是否获得过收藏品
function getCycleCollageCanHas(self, id)
    local list = self:getCycleHasCollection()
    for i = 1, #list do
        if list[i].id == id then
            return true
        end
    end
    return false
    -- return table.indexof01(list,id)>0
end

-- 获取当前已经有的收藏品
function getCycleCurrentCollectionList(self)
    local hasList = {}
    local dic = self:getCycleCollectionData()
    for k, v in pairs(dic) do
        if self.mHisCollageList then
            local vo = v
            if table.indexof(self.mHisCollageList, v.id) then
                vo.has = true
            else
                vo.has = false
            end
            table.insert(hasList, vo)
        end

    end

    table.sort(hasList, function(a, b)
        local mWitghA = 0
        local mWitghB = 0
        if a.has then
            mWitghA = 1
        end
        if b.has then
            mWitghB = 1
        end
        return mWitghA > mWitghB
    end)

    return hasList
end

-- 获取所有收藏品列表
-- function getCycleAllColletionList(self)
--     if self.mCollageDic == nil then
--         self:parseCycleCollageData()
--     end
--     local list = {}
--     for _, v in pairs(self.mCollageDic) do
--         table.insert(list, v)
--     end
--     return list
-- end

-- 获取未拥有收藏收藏品列表
function getCycleLackColletionList(self)
    if self.mCollageDic == nil then
        self:parseCycleCollageData()
    end
    local lackList = {}
    for _, v in pairs(self.mCollageDic) do
        if not table.indexof(self.mHisCollageList, v.id) then
            v.has = false
            table.insert(lackList, v)
        end
    end
    return lackList
end

--
function checkIsCollectionSelected(self, id)
    return self.mCollectSelected == id
end

function setCollectionSelect(self, data)
    self.mCollectSelected = data.id
    GameDispatcher:dispatchEvent(EventName.COLLETION_ITEM_SELECTED, data)
end

function setCollectTabViewType(self, type)
    self.mCollectType = type
end

function getCollectTabViewType(self)
    return self.mCollectType
end

-- 获取当前所在的格子
function getCurrentCell(self)
    return self.mCurCell
end

-- 获取战员列表
function getHeroList(self)
    if self.mHeroList == nil then
        self.mHeroList = {}
    end
    return self.mHeroList
end

-- 解析格子数据
function parseCellData(self)
    self.mCellData = {}

    for i = 1, #self.mCellInfo do
        local msgVo = cycle.CycleCellMsgVo.new()
        msgVo:parseCellMsgVo(self.mCellInfo[i])
        self.mCellData[self.mCellInfo[i].id] = msgVo
    end
end

-- --本地备份最后触发格子的事件Id
-- function copyLastCellEventId(self, lastEventId)
--     self.lastEventId = lastEventId
-- end

-- --获取本地备份最后触发格子的事件Id
-- function getCopyLastCellEventId(self)
--     local retValue = self.lastEventId
--     return retValue
-- end

function setLastSelectChildEvent(self, childEvent)
    self.lastEventData = cycle.CycleManager:getCycleEventData(childEvent)
end

function getLastSelectChildEvent(self)
    return self.lastEventData
end

-- 更新格子信息
function parseCellUpdateInfo(self, args)
    -------------------------历史数据处理--------------------
    local oldCellId = cycle.CycleManager:getCurrentCell()
    local cellMsgVo = nil
    local oldEventData = nil

    if oldCellId > 0 then
        local cellMsgVo = cycle.CycleManager:getCellDataById(oldCellId)
        local oldEventId = cellMsgVo.eventId
        oldEventData = cycle.CycleManager:getCycleEventData(oldEventId)
    end
    -------------------------更替为最新的数据--------------------
    self.mCurCell = args.cur_cell
    cusLog("更新格子信息 当前格子变更为:" .. args.cur_cell)

    local msgVo = cycle.CycleCellMsgVo.new()
    msgVo:parseCellMsgVo(args.cell_info)
    self.mCellData[msgVo.id] = msgVo
    cusLog("更新格子信息 修改格子id为:" .. msgVo.id .. "的格子数据")
    self.mPassCell = args.pass_cell

    local currentEventData = cycle.CycleManager:getCycleEventData(msgVo.eventId)
    -- msgVo
    -------------------------如果有历史数据在此处理--------------------
    if oldEventData and self.mCurCell ~= 0 then
        -- 如果历史是战斗 但现在是战后选择 (只更新战后选择面板)
        if oldEventData.eventType == EVENT_TYPE.FIGHT and msgVo.postwarArgs and #msgVo.postwarArgs > 1 then
            GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_POSTWAR_PANEL)
            -- 如果历史是事件 现在也是事件 
        elseif oldEventData.eventType ~= EVENT_TYPE.FIGHT and oldEventData.eventType ~= EVENT_TYPE.SHOP and
        currentEventData.eventType ~= EVENT_TYPE.FIGHT and currentEventData.eventType ~= EVENT_TYPE.SHOP and
        currentEventData.eventType ~= EVENT_TYPE.RANDOM_RECRUIT then
            -- 如果最后选择的是赌徒或者赌场(打开结算的面板)
            if self.lastEventData.eventType == EVENT_TYPE.RETURN or self.lastEventData.eventType ==
            EVENT_TYPE.GET_COIN_RETURN or self.lastEventData.eventType == EVENT_TYPE.GET_HOPE_RETURN or
            self.lastEventData.eventType == EVENT_TYPE.RANDOM_ANY_COLLAGE_RETURN then
                GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_EVENT_END_PANEL, {
                    oldEventData = self.lastEventData,
                    endCall = self.closeUpdateOtherPanel
                })
            else
                GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_EVENT_PANEL)
            end
        else
            self:closeUpdateOtherPanel()
        end
    elseif oldEventData and self.mCurCell == 0 then
        if oldEventData.eventType ~= EVENT_TYPE.FIGHT and oldEventData.eventType ~= EVENT_TYPE.SHOP and
        self.lastEventData and self.lastEventData.optionDes > 0 and oldEventData.eventType ~= EVENT_TYPE.RANDOM_RECRUIT then
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_EVENT_END_PANEL, {
                oldEventData = self.lastEventData,
                endCall = self.closeUpdateOtherPanel
            })
        else
            self:closeUpdateOtherPanel()
        end
        --
    else
        self:closeUpdateOtherPanel()
    end
end

function closeUpdateOtherPanel(self)
    -- cusLog("关闭所有UI")
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_HERO_SURE_PANEL)
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_HERO_SELECT_PANEL)
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_POSTWAR_PANEL)
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_SHOP_PANEL)
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_EVENT_PANEL)
    -- -- GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_RECRUIT_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_GAME_VIEW)
    
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_MAP_PANEL)

    cusLog("更新地图界面")
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_MAIN_PANEL)

end

-- 更新战员列表
function parseHeroUpdateInfo(self, args)
    cusLog("更新了战员列表")

    for i = 1, #args.hero_list do
        -- 历史中不存在的 新增的战员
        if table.indexof01(self.mHeroList, args.hero_list[i]) == 0 then
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_SHOW_ONE_PANEL, {
                heroId = args.hero_list[i]
            })
        end
    end
    --默认只要更新了战员就消耗了卷
    self.mCurTicket = 0

    self.mHeroList = args.hero_list
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_SHOP_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_HERO_SURE_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_HERO_SELECT_PANEL)
end

-- 获取格子信息
function getCellDataById(self, id)
    return self.mCellData[id]
end

-- 判断格子是否已经走过了
function getCellIsPass(self, id)
    if self.mPassCell then
        return table.indexof01(self.mPassCell, id) > 0
    else
        return false
    end
end

-- 获取最后行走的格子Id
function getLastCellId(self)
    local maxId = -1
    for i = 1, #self.mPassCell do
        if self.mPassCell[i] > maxId then
            maxId = self.mPassCell[i]
        end
    end
    return maxId
end

-- 获取走线id
function getLineId(self)
    return self.mLineId
end

-- 获取格子信息
function getCellData(self)
    return self.mCellData
end

-- (客户端主动)修改招募卷id和招募类型
function setCurTicketAndType(self, ticket, type)
    self.mCurTicket = ticket
    self.mTicketType = type
end

-- 获取当前的招募卷id和招募类型
function getCurTicketAndType(self)
    return self.mCurTicket, self.mTicketType
end

-- 获取招募卷List
function getCycleTicketList(self)
    return self.mTicketList
end

-- 解析持有战员
function parseCycleHeroDic(self, ticketList)
    self.mHeroDic = {}

    for i = 1, #ticketList do
        self.mHeroDic[ticketList[i].pos] = {
            posId = ticketList[i].pos,
            ticketId = ticketList[i].ticket_id,
            heroId = ticketList[i].hero_id,
            isUsed = ticketList[i].is_used == 1,
        }
    end
end

-- 获取战员数据
function getCycleHeroData(self, id)
    return self.mHeroDic[id]
end

------------------------------------------------------------local data------------------------------------

-- 解析等级数据
function parseCycleLevelData(self)
    self.mCycleLevelDic = {}
    self.mMaxLv = 0
    local baseData = RefMgr:getData("event_cycle_exp_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleExpVo:new()
        vo:parseExpVo(k, v)
        if self.mMaxLv < k then
            self.mMaxLv = k
        end
        self.mCycleLevelDic[k] = vo
    end
end

-- 获得最大等级
function getCycleLevelMax(self)
    if self.mMaxLv == nil then
        self:parseCycleLevelData()
    end
    return self.mMaxLv
end

-- 获取等级数据
function getCycleLevelData(self)
    if self.mCycleLevelDic == nil then
        self:parseCycleLevelData()
    end
    return self.mCycleLevelDic
end

function getCycleLevelDataByLv(self, lv)
    if self.mCycleLevelDic == nil then
        self:parseCycleLevelData()
    end
    return self.mCycleLevelDic[lv]
end

-- 解析难度数据
function parseDifficultData(self)
    self.mDifficultDic = {}
    self.mMaixCycleDifficultyNum = 0
    local baseData = RefMgr:getData("event_cycle_difficulty_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleDifficultyVo.new()
        vo:parseCycleDifficuty(k, v)
        self.mDifficultDic[k] = vo
        if k > self.mMaixCycleDifficultyNum then
            self.mMaixCycleDifficultyNum = k
        end

    end
end

-- 获取配置表里面最大的关卡
function getMaxCycleDifficultyNum(self)
    if self.mDifficultDic == nil then
        self:parseDifficultData()
    end
    return self.mMaixCycleDifficultyNum
end

-- 获取难度数据
function getDifficultData(self)
    if self.mDifficultDic == nil then
        self:parseDifficultData()
    end
    return self.mDifficultDic
end

function getDifficultVoById(self, id)
    return self:getDifficultData()[id]
end

-- 解析层数相关数据
function parseCycleLayerData(self)
    self.mLayerDic = {}
    local baseData = RefMgr:getData("event_cycle_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleLayerVo.new()
        vo:parseLayerVo(k, v)
        self.mLayerDic[k] = vo
    end
end

function getCycleLayerDataByDiffAndLayer(self, diff, layer)
    if self.mLayerDic == nil then
        self:parseCycleLayerData()
    end
    for k, v in pairs(self.mLayerDic) do
        if v.difficulty == diff and v.layer == layer then
            return v
        end
    end
end

-- 获取层数相关数据
function getCycleLayerData(self, id)
    if self.mLayerDic == nil then
        self:parseCycleLayerData()
    end
    return self.mLayerDic[id]
end

-- 解析战略数据
function parseCycleStrategyData(self)
    self.mCycleStrategyDic = {}
    local baseData = RefMgr:getData("event_cycle_strategy_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleStrategyVo.new()
        vo:parseStrategy(k, v)
        self.mCycleStrategyDic[k] = vo
    end
end

-- 获取战略数据
function getCycleStrategyData(self)
    if self.mCycleStrategyDic == nil then
        self:parseCycleStrategyData()
    end
    return self.mCycleStrategyDic
end

-- 获取单个战略数据
function getCycleStrategyDataById(self, id)
    if self.mCycleStrategyDic == nil then
        self:parseCycleStrategyData()
    end
    return self.mCycleStrategyDic[id]
end

-- 解析招募数据
function parseCycleComboData(self)
    self.mCycleComboDic = {}
    local baseData = RefMgr:getData("event_cycle_combo_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleComboVo.new()
        vo:parseCombo(k, v)
        self.mCycleComboDic[k] = vo
    end
end

-- 获取招募数据
function getCycleComboData(self)
    if self.mCycleComboDic == nil then
        self:parseCycleComboData()
    end
    return self.mCycleComboDic
end

-- 解析招募数据
function parseCycleRecruitData(self)
    self.mCycleRecruitDic = {}
    local baseData = RefMgr:getData("event_cycle_recruit_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleRecruitVo.new()
        vo:parseRecruit(k, v)
        self.mCycleRecruitDic[k] = vo
    end
end

-- 获取招募数据
function getCycleRecruitData(self, id)
    if self.mCycleRecruitDic == nil then
        self:parseCycleRecruitData()
    end

    return self.mCycleRecruitDic[id]
end

-- 解析地图数据
function parseCycleLineData(self)
    self.mCycleLineDic = {}
    local baseData = RefMgr:getData("event_cycle_line_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleLineVo.new()
        vo:parseLineVo(k, v)
        self.mCycleLineDic[k] = vo
    end
end

-- 获取地图数据
function getCycleLineData(self, id)
    if self.mCycleLineDic == nil then
        self:parseCycleLineData()
    end
    return self.mCycleLineDic[id]
end

-- 获取当前地图数据
function getCurrentCycleLineData(self)
    if self.mCycleLineDic == nil then
        self:parseCycleLineData()
    end
    return self.mCycleLineDic[self.mLineId]
end

-- 获取当前地图中单独一个地图节点的数据
function getCurrentCycleSingleMapData(self, id)
    if self.mCycleLineDic == nil then
        self:parseCycleLineData()
    end
    local lineData = self.mCycleLineDic[self.mLineId]
    local cellData = lineData:getCellData()

    for k, v in pairs(cellData) do
        if v.id == id then
            return v
        end
    end
end

-- 解析事件数据
function parseCycleEventData(self)
    self.mEventDic = {}
    local baseData = RefMgr:getData("event_cycle_event_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleEventVo.new()
        vo:parseCycleEvent(k, v)
        self.mEventDic[k] = vo
    end
end

-- 获取事件数据
function getCycleEventData(self, id)
    if self.mEventDic == nil then
        self:parseCycleEventData()
    end
    return self.mEventDic[id]
end

-- 解析战斗数据
function parseCycleDupData(self)
    self.mDupDic = {}
    local baseData = RefMgr:getData("event_cycle_dup_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleDupVo.new()
        vo:parseDupVo(k, v)
        self.mDupDic[k] = vo
    end
end
-- 获取战斗数据
function getCycleDupData(self, id)
    if self.mDupDic == nil then
        self:parseCycleDupData()
    end
    return self.mDupDic[id]
end

-- 解析收藏品数据
function parseCycleCollageData(self)
    self.mCollageDic = {}
    local baseData = RefMgr:getData("event_cycle_collage_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleCollageVo.new()
        vo:parseCollageCombo(k, v)
        self.mCollageDic[k] = vo
    end
end

-- 获取所有收藏品数据
function getCycleCollectionData(self)
    if self.mCollageDic == nil then
        self:parseCycleCollageData()
    end
    return self.mCollageDic
end

-- 获取收藏品数据
function getCycleCollectionDataById(self, id)
    if self.mCollageDic == nil then
        self:parseCycleCollageData()
    end

    return self.mCollageDic[id]
end

-- 解析商店数据
function parseCycleShopData(self)
    self.mShopDic = {}
    local baseData = RefMgr:getData("event_cycle_shop_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleShopVo.new()
        vo:parseShop(k, v)
        self.mShopDic[k] = vo
    end
end
-- 获取商店数据
function getCycleShopData(self, id)
    if self.mShopDic == nil then
        self:parseCycleShopData()
    end
    return self.mShopDic[id]
end
-- 解析点数数据
function parseCyclePointData(self)
    self.mPointDic = {}
    local baseData = RefMgr:getData("event_cycle_point_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CyclePointVo.new()
        vo:parseData(k, v)
        self.mPointDic[k] = vo
    end
end

function getAllPointData(self)
    if self.mPointDic == nil then
        self:parseCyclePointData()
    end
    return self.mPointDic
end

-- 获取点数数据
function getCyclePointData(self, id)
    return self:getAllPointData()[id]
end

-- 解析等级数据
function parseCycleLvData(self)
    self.mLvDic = {}
    local baseData = RefMgr:getData("event_cycle_lv_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleLvVo.new()
        vo:parseLvVo(k, v)
        self.mLvDic[k] = vo
    end
end

-- 求最大值
function getMaxLv(self)
    if self.mLvDic == nil then
        self:parseCycleLvData()
    end
    local maxLv = 0
    for _, v in pairs(self.mLvDic) do
        if v.id > maxLv then
            maxLv = v.id
        end
    end
    return maxLv
end

-- 获取等级数据列表
function getCycleLvDataList(self, lv)
    if self.mLvDic == nil then
        self:parseCycleLvData()
    end
    return self.mLvDic
end

-- 获取等级数据
function getCycleLvData(self, lv)
    if self.mLvDic == nil then
        self:parseCycleLvData()
    end
    return self.mLvDic[lv]
end

-- 解析任务数据
function parseCycleTaskData(self)
    self.mTaskDic = {}
    local baseData = RefMgr:getData("event_cycle_task_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleTaskVo.new()
        vo:parseTaskVo(k, v)
        self.mTaskDic[k] = vo
    end
end

-- 获取任务数据
function getCycleTaskData(self, id)
    if self.mTaskDic == nil then
        self:parseCycleTaskData()
    end

    return self.mTaskDic[id]
end

-- 解析无限投资数据
function parseCycleInvestShopData(self)
    self.mInvestShopDic = {}
    local baseData = RefMgr:getData("event_cycle_invest_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleInvestVo.new()
        vo:parseInvestVo(k, v)
        self.mInvestShopDic[k] = vo
    end
end

-- 解析剧情数据
function parseCycleStoryData(self)
    self.mStoryDic = {}
    local baseData = RefMgr:getData("event_cycle_showroom_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleStoryVo.new()
        vo:parseStoryVo(k, v)
        self.mStoryDic[k] = vo
    end
end

-- 获取剧情数据
function getCycleStoryData(self)
    if self.mStoryDic == nil then
        self:parseCycleStoryData()
    end
    return self.mStoryDic
end

-- 获取无限投资数据
function getCycleInvestShopData(self)
    if self.mInvestShopDic == nil then
        self:parseCycleInvestShopData()
    end
    return self.mInvestShopDic
end

-- 点击领奖请求
function onClickReceiveItem(self, Lv)
    if next(self.mHistoryInfo) then
        if next(self.mHistoryInfo.gained_lv_reward_list) then
            for _, v in pairs(self.mHistoryInfo.gained_lv_reward_list) do
                if Lv == v then
                    return
                end
            end
        end
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_RECEIVE, {
            level = Lv
        })
    end
end

-- 解析收藏品奖励
function parseCycleCollageAwardData(self)
    self.mCyclceCollageAwardList = {}
    local baseData = RefMgr:getData("event_cycle_collage_reward_data")
    for k, v in pairs(baseData) do
        local vo = cycle.CycleCollageAwardVo.new()
        vo:parseAwardVo(k, v)
        table.insert(self.mCyclceCollageAwardList, vo)
        -- self.mCyclceCollageAwardList[k] = vo
    end

    table.sort(self.mCyclceCollageAwardList, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

-- 获取收藏品奖励
function getCycleCollageAwardData(self)
    if self.mCyclceCollageAwardList == nil then
        self:parseCycleCollageAwardData()
    end
    return self.mCyclceCollageAwardList
end

------------------------------------------------------------copy data------------------------------------
-- 备份容器引用类
function setGroupClassCopyData(self, groupItems)
    self.mGroupClassCopy = groupItems
end

-- 备份地图行引用类
function setMapClassCopyData(self, row, mapItems)
    self.mMapClassCopy[row] = mapItems
end

-- 备份地图Id引用类
function setMapClassIdCopyData(self, id, mapItem)
    self.mMapIdClassCopy[id] = mapItem
end

function getMapClassIdCopyData(self, id)
    return self.mMapIdClassCopy[id]
end

function updateFilterData(self, data)
    self.isDesc = data.isDesc
    self.filter = data.currentFilter
    self.isShowHas = data.isShowHas
end

function getFilterData(self)
    return self.isDesc, self.filter, self.isShowHas
end

--设置事件是否可以点击
function setEventClicked(self,isClicked)
    self.isClicked = isClicked
end

--获取事件是否可以点击
function getEventClicked(self)
    return self.isClicked
end

--设置招募点击完成
function setRecuritClicked(self,isClicked)
    self.isRecuritClicked = isClicked
end

--获取招募点击完成
function getRecuritClicked(self)
    return self.isRecuritClicked
end

--设置战后点击完成
function setPostwarClicked(self,isClicked)
    self.isPostwarClicked = isClicked
end

--获取战后点击完成
function getPostwarClicked(self)
    return self.isPostwarClicked
end

--设置是否预览
function setIsPre(self,bool,isForm)
    self.isPre = bool 
    self.isForm = isForm
end
--获取是否预览
function getIsPre(self)
    return self.isPre, self.isForm
end

------------------------------------------------------------result data------------------------------------

-- 战斗结算面板显示的名字
function getDupName(self, tileId)
    return ""
end

function getRecommandFight(self, tileId)
    return nil
end

-- 获取额外上阵的战员列表
function getExtraHeros(self, cusId)
    local dupVo = self:getCycleDupData(cusId)
    return dupVo.extraHeros
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]