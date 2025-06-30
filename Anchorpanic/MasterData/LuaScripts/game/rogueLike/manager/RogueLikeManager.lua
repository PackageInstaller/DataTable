module("rogueLike.RogueLikeManager", Class.impl(Manager))

function ctor(self)
    super.ctor(self)
    self:__init()
    self.mActiveViewList = {}
    self.mPassDifficuty = nil
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self:resetDatas()

end

function resetDatas(self)

    -- 难度
    self.mDifficuty = nil
    -- 当前肉鸽层数
    self.mCurrentLayer = nil
    -- 服务器下发的地图数据
    self.mServerMap = nil
    -- 当前的列数
    self.mNowCol = nil
    -- 已经通过的格子
    self.mPassCell = nil
    -- 当前BUFF
    self.mBuffList = nil
    --旧的buff
    self.mOldBuffList = nil
    -- 当前负面BUFF
    self.mDebuffList = nil
    -- 当前触发格子id-0未触发任何事件
    self.mTriggerCell = nil
    -- 当前战员状态
    self.heroInfoDic = nil
    -- 积分点数
    self.mPoint = nil
    -- 结算积分点数
    self.mSettPoint = nil
    -- 结算数据
    self.mSettData = nil

    -- 重置的时间戳
    self.mResetTime = nil

    -- 服务器下发的任务分数
    -- self.mTaskScore = nil
    -- 服务器下发的已领取奖励
    -- self.mScoreTaskReward = nil
    -- 服务器下发的任务数据
    self.mServerTaskData = nil
    -- 服务器下发的刷新时间
    -- self.mEndTime = nil
    -- 收藏品数据
    self.mServerCollectionList = nil
end

-------------------------------------------------------------server start------------------------------------

function updateRougueLikePreDataInfo(self, msg)
    self.mLayerId = msg.layer_id
    self.mPreDifficulty = msg.difficulty
    self.mLayerStats = msg.layer_stats
    self.mBattleStatistic = msg.battle_statistic

    GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_PRE_DATA_PANEL)
end

function getRogueLikePreData(self)
    local data = {}
    data.id = self.mLayerId
    data.difficulty = self.mPreDifficulty
    data.stats = self.mLayerStats
    data.battleStatistic = self.mBattleStatistic
    return data
end

-- 更新难度通关信息
function updateDifficultInfo(self, msg)
    -- self.mResRogueLikeTime = msg.end_time
    self.mPassDifficuty = msg.difficulty_list
end

-- 获取肉鸽重置的时间
-- function getResRogueLikeTime(self)
--     return self.mResRogueLikeTime
-- end

-- 获取难度通关信息
function getDifficultInfo(self)
    return self.mPassDifficuty
end

-- 获取地图信息
function parseRogueLikeMap(self, msg)
    -- 如果是0 就表示已经全通了
    self.mCurrentLayer = msg.layer
    self.mDifficuty = msg.difficulty
    self.mIsLogin = msg.is_login
    self.mIsAllPass = msg.is_all_pass
    self.isWeekReset = msg.is_week_reset
    self.mServerMap = msg.map_cells_data
   

    if self.mIsLogin == 0 then
        -- formation.FormationRogueLikeController:customCloseFormationPanel()
        GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_MAP_PANEL)
        GameDispatcher:dispatchEvent(EventName.CLOSE_ROGUELIKE_LEVEL_SELECT_PANEL)
    end

    if self.isWeekReset == 1 then
        GameDispatcher:dispatchEvent(EventName.RES_ROGUELIKE_ALL)
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAIN_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAP_PANEL)
    cusLog("收到地图信息")
end

-- 更新地图信息
function updateRougueLikeInfo(self, msg)
    self.mNowCol = msg.now_col
    self.mTriggerCell = msg.trigger_cell_id
    -- 拓展buff上限消耗
    -- self.mExpandBuffCoin = msg.expand_buff_coin
    -- 是否达到上限
    -- self.mIsExpandMax = msg.is_expand_max
    -- buff上限数量
    self.mBuffLimit = msg.buff_limit
    self.mPassCell = msg.pass_cells
    self.mCanWalkCell = msg.can_walk_cells

    self.mBuffList = msg.buff_list
    self.mLastChangeBuff, self.mLastAdd = self:getLastChangeBuff()
    self.mOldBuffList = msg.buff_list

    self.mDebuffList = msg.debuff_list

    -- 分数
    self.mPoint = msg.point

    self.mResetTime = msg.can_reset_time
    -- 队伍战力
    self.mTeamPower = msg.team_power

    if self:canShowBuffChange() then
        GameDispatcher:dispatchEvent(EventName.ROGUE_SHOW_CHANGE_BUFF)
        rogueLike.RogueLikeManager:setCanShowBuffChange(false)
    end

    cusLog("收到地图更新信息")
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAIN_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAP_PANEL)
end

function getLastChangeBuff(self)

    if self.mBuffList == nil then
        self.mBuffList = {}
    end

    if self.mOldBuffList == nil then
        self.mOldBuffList = {}
    end

    local retId = 0
    local retAdd = true

    if #self.mBuffList == #self.mOldBuffList then
        return retId, retAdd
    end

    local maxList = {}
    local minList = {}
    if #self.mBuffList > #self.mOldBuffList then
        maxList = self.mBuffList
        minList = self.mOldBuffList
        retAdd = true
    else
        maxList = self.mOldBuffList
        minList = self.mBuffList
        retAdd = false
    end

    local function _sort(buff1, buff2)
        return buff1 < buff2
    end

    table.sort(maxList, _sort)
    table.sort(minList, _sort)

    for i = 1, #maxList do
        if maxList[i] ~= minList[i] then
            retId = maxList[i]
            return retId, retAdd
        end
    end

    -- end
    -- for i = 1, #self.mBuffList do

    --     if self.mBuffList[i] == nil and self.mOldBuffList[i] ~= nil then
    --         return self.mOldBuffList[i], false
    --     end

    --     if self.mBuffList[i] ~= nil and self.mOldBuffList[i] == nil then
    --         return self.mBuffList[i], true
    --     end

    --     if self.mBuffList[i] ~= self.mOldBuffList[i] and self.mBuffList[i] ~= nil and self.mOldBuffList[i] ~= nil then
    --         return self.mOldBuffList[i], false
    --     end

    --     if self.mBuffList[i] ~= self.mOldBuffList[i] and self.mBuffList[i] ~= nil and self.mOldBuffList[i] ~= nil then
    --         return self.mBuffList[i], true
    --     end
    -- end

    -- return 0, true
end

function getLastChangeBuffId(self)
    return self.mLastChangeBuff
end

function getLastChangeIsAdd(self)
    return self.mLastAdd
end

function setCanShowBuffChange(self, canShow)
    self.mNeedShowChange = canShow
end

function canShowBuffChange(self)
    return self.mNeedShowChange
end

-- 获取队伍战力
function getTeamPower(self)
    return self.mTeamPower
end

function getCanWalk(self, cellId)
    if #self.mCanWalkCell == 0 then
        return true
    end

    return table.indexof01(self.mCanWalkCell, cellId) > 0
end
-- 解析服务器发来的战员数据
function parseHeroInfo(self, msg)
    self.layer_id = msg.layer_id
    self.hero_info = msg.hero_info

    self.heroInfoDic = {}

    for i = 1, #self.hero_info do
        local vo = rogueLike.RogueLikeHeroVo.new()
        vo:parseData(self.hero_info[i])
        self.heroInfoDic[self.hero_info[i].hero_id] = vo
    end
    cusLog("收到角色更新信息")
end

-- 更新当前格子信息
function updateCurrentCell(self, msg)
    self.mTriggerCell = msg.cell_id
    self.mCanWalkCell = msg.can_walk_cells
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAP_PANEL)
    cusLog("收到当前地图点更新信息")
end

-- 解析服务器发来的商店信息
function parseShopData(self, msg)
    -- self.mShopLevel = msg.shop_level
    -- self.mIsMaxLevel = msg.is_max_level
    self.mRefreshTimes = msg.refresh_times
    self.mRefreshCoin = msg.refresh_cost_coin
    -- self.mLevelUpCoin = msg.level_up_cost_coin
    self.mGoodList = msg.goods_list

    table.sort(self.mGoodList, self.__byGroove)

    GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_SHOP_PANEL, { id = self.lastMapId })
    cusLog("收到商店的信息")
end

-- 随格子Id排序
function __byGroove(shopItem1, shopItem2)
    return shopItem1.groove_id < shopItem2.groove_id
end

-- 获取商店信息
function getShopData(self)
    return { shopLevel = self.mShopLevel, maxLv = self.mIsMaxLevel, refreshTimes = self.mRefreshTimes, refreshCoin = self.mRefreshCoin, lvUpCoin = self.mLevelUpCoin, goodList = self.mGoodList }
end

-- 更新商品数据 购买
function updateShopDataByBuy(self, msg)
    self.mBuffList = msg.buff_list
    self.mDebuffList = msg.debuff_list

    for i = 1, #msg.goods_list do
        self.mGoodList[msg.goods_list[i].groove_id] = msg.goods_list[i]
    end
    -- =
    cusLog("收到商店购买成功的返回")

    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAP_PANEL)
end

-- 更新商品数据 出售
function updateShopDataBySell(self, msg)
    self.mBuffList = msg.buff_list
    self.mDebuffList = msg.debuff_list
    cusLog("收到商店出售成功的返回")
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_REPLACE_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAP_PANEL)
end

-- 更新buff数据 刷新
function updateShopDataByReset(self, msg)
    self.mGoodList = msg.goods_list
    self.mRefreshCoin = msg.refresh_cost_coin
    self.mRefreshTimes = msg.refresh_times
    table.sort(self.mGoodList, self.__byGroove)

    cusLog("收到商店刷新成功的返回")
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAP_PANEL)
end

-- 更新buff数据 升级
function updateShopDataByLevelUp(self, msg)
    self.mGoodList = msg.goods_list
    self.mShopLevel = msg.shop_level
    self.mIsMaxLevel = msg.is_max_level
    -- self.mLevelUpCoin = msg.level_up_cost_coin

    table.sort(self.mGoodList, self.__byGroove)

    cusLog("收到商店升级成功的返回")
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAP_PANEL)
end

-- 更新buff上限
function updateBuffLimit(self, msg)
    self.mBuffLimit = msg.buff_limit
    self.mExpandBuffCoin = msg.expand_buff_coin
    self.mIsExpandMax = msg.is_expand_max
    cusLog("收到buff上限升级成功的返回")
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_REPLACE_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAP_PANEL)
end

-- 更新地图格子信息
function updateMap(self, msg)
    for i = 1, #self.mServerMap do
        if self.mServerMap[i].cell_id == msg.update_cell_data[1].cell_id then
            self.mServerMap[i] = msg.update_cell_data[1]
        end
    end

    local eventType = rogueLike.RogueLikeManager:getRogueLikeEventData(msg.update_cell_data[1].event_id).eventType
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_MAP_PANEL)

    if eventType == 2 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_BUFF_SELECT, msg.update_cell_data[1])
    elseif eventType == 8 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_SPECIAL_PANEL, msg.update_cell_data[1])
    end

    cusLog("收到更新地图格子信息的返回")
end

-- 更新结算面板信息
function updateSettleData(self, msg)
    self.mSettPoint = msg.point
    self.mSettData = msg.mission_stats

    if msg.is_active == 1 then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_SETT_PANEL)
    end
    -- 打开结算界面
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_ROGUELIKE_SPECIAL_RESULT_PANEL)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_SETT_PANEL, {point = self.mSettPoint, data = self.mSettData})
    cusLog("收到结算信息的返回")
end

function getServerSettleData(self)
    return self.mSettPoint, self.mSettData
end

-- 解析服务端下发的成就信息
function parseServerTaskData(self, msg)
    -- self.mTaskScore = msg.task_score
    if msg == nil then
        return
    end
    -- self.mScoreTaskReward = msg.gain_task_reward
    self.mServerTaskData = msg.task_list
    -- self.mEndTime = msg.end_time
    cusLog("收到的服务器的任务返回")
    self:setIsFlag()
end

--获取是否有红点
function getRedData(self, filterType)
    local data = self:getTaskData()
    for i = 1, #data do
        if filterType == nil then
            if data[i].serverVo.state == 0 then
                return true
            end
        else
            if data[i].taskVo.page == filterType and data[i].serverVo.state == 0 then
                return true
            end
        end
    end
end

--更新红点
function setIsFlag(self)
    local isFlag = self:getRedData()
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, isFlag, funcopen.FuncOpenConst.FUNC_ID_ROGUE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_TASK_RED)
end

-- 更新任务状态
function updateServerTaskData(self, msg)
    -- self.mTaskScore = msg.task_score
    -- self.mServerTaskData[msg.update_list[1].id] = msg.update_list[1]

    for i = 1, #msg.update_list do
        for j = 1, #self.mServerTaskData do
            if self.mServerTaskData[j].id == msg.update_list[i].id then
                self.mServerTaskData[j] = msg.update_list[i]
            end
        end
    end
    self:setIsFlag()
    cusLog("收到的单独更新任务的返回")
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_TASK_PANEL_TASK)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_TASK_PANEL_SCORE)
end

-- 更新任务积分领取状态
function updateServerScoreData(self, msg)
    -- self.mScoreTaskReward = msg.gain_task_reward
    -- cusLog("收到的单独更新积分的返回")
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_TASK_PANEL_SCORE)
end

-- 获取肉鸽收藏品数据
function updateCollectionData(self, msg)
    self.mServerCollectionList = msg.collection_list
    GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_COLLECTION_PANEL, { type = rogueLike.CollectionType.All, showHas = false })
end

function getServerCollectionData(self)
    return self.mServerCollectionList
end

function updatePoint(self, msg)
    self.mPoint = msg.point

    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_POINT)
end

-- 获取重置的时间
function getResetTime(self)
    return self.mResetTime == nil and 0 or self.mResetTime
end

-- 积分奖励是否已经领取
function scoreIsPass(self, id)
    return table.indexof01(self.mScoreTaskReward, id) > 0
end

-- 获取服务端下发的任务分数
function getServerTaskScore(self)
    -- return self.mTaskScore
end

-- 获取任务完成数据
function getServerTaskInfo(self, id)
    for i = 1, #self.mServerTaskData do
        if self.mServerTaskData[i].id == id then
            return self.mServerTaskData[i]
        end
    end
end

-- 获取任务结束的时间
function getEndTime(self)
    return self.mEndTime
end

-- 获取统计数据
function getSettleData(self, key)
    for i = 1, #self.mSettData do
        if self.mSettData[i] == nil then
            return 0
        end

        if key == self.mSettData[i].id then
            return self.mSettData[i].times
        end
    end
    return 0
end

-- 获取战员信息
function getHeroInfo(self, heroId)
    if self.heroInfoDic == nil then
        local vo = rogueLike.RogueLikeHeroVo.new()
        vo.nowHp = 99999
        vo.maxHp = 99999
        return vo
    end

    if (self.heroInfoDic[heroId] == nil) then
        -- 如果不存在默认为还未上阵 满血
        local vo = rogueLike.RogueLikeHeroVo.new()
        vo.nowHp = 99999
        vo.maxHp = 99999
        return vo
    else
        return self.heroInfoDic[heroId]
    end
end

-- 获取个地图层数
function getRogueLayout(self)
    return self.mCurrentLayer
end

-- 获取地图难度
function getRogueDifficulty(self)
    return self.mDifficuty
end

-- 获取地图是否已经通过
function getRogueIsAllPass(self)
    return self.mIsAllPass
end

-- 获取格子信息
function getRogueLikeMap(self)
    return self.mServerMap
end

function getRogueLikeSingleMap(self, id)
    if self.mServerMap then

        for i = 1, #self.mServerMap do
            if self.mServerMap[i].cell_id == id then
                return self.mServerMap[i]
            end
        end
        return nil
    else
        return nil
    end

end

-- 获取单个格子信息
function getRogueLikeSingeMap(self, cellId)
    for i = 1, #self.mServerMap do
        if self.mServerMap[i].cell_id == cellId then
            return self.mServerMap[i]
        end
    end
end

-- 获取已经通关的格子信息
function getPassMap(self)
    return self.mPassCell
end

-- 地图是否已经通过
function getRogueLikeIsPass(self, cellId)
    if self.mPassCell then
        return table.indexof01(self.mPassCell, cellId) > 0
    else
        return false
    end

end

-- 当前所在列
function getRogueLikeCol(self)
    return self.mNowCol
end

-- 持有的buff
function getBuffList(self)
    return self.mBuffList
end

-- 判断是否持有buff
function hasBuff(self, skillId)
    for i = 1, #self.mBuffList do
        local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(self.mBuffList[i])
        if goodsConfigVo.skillId == skillId then
            return true
        end
    end
    return false
    -- return table.indexof01(self.mBuffList, buffId) > 0
end

-- 是否持有buff组
function hasBuffList(self, list)
    local result = false
    for i = 1, #list do
        if self:hasBuff(list[i]) then
            result = true
        else
            return false
        end
    end
    return result
end

-- 持有类型buff数量
function hasTypeBuffNum(self, buffType)
    -- local num = 0
    -- for i = 1, #self.mBuffList do
    --     local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(self.mBuffList[i])
    --     if goodsConfigVo.type == buffType then
    --         num = num + 1
    --     end
    -- end
    -- return num
    return #self.mBuffList
end

-- 持有的debuff
function getDebuffList(self)
    return self.mDebuffList
end

-- 获取Buff的战力提升
function getBuffPowerUp(self, value, heroVolist)
    -- if #self.mBuffList == 0 then
    --     return value
    -- end

    local allPower = 0
    -- if self.mBuffList and #heroVolist > 0 then
    --     for x = 1, #self.mBuffList do
    --         local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(self.mBuffList[x])
    --         for y = 1, #goodsConfigVo.heroList do
    --             local singlePow = heroVolist[y].power
    --             for z = 1, #heroVolist do
    --                 if goodsConfigVo.heroList[y] == heroVolist[z].professionType then
    --                     add = add * (1+goodsConfigVo.efficiency / 1000)
    --                 end
    --             end
    --         end
    --     end
    -- end

    if #heroVolist > 0 and self.mBuffList and #self.mBuffList > 0 then
        for i = 1, #heroVolist do
            local heroVo = hero.HeroManager:getHeroVo(heroVolist[i].heroId)
            local singlePower = heroVo.power
            local add = 1

            for j = 1, #self.mBuffList do
                local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(self.mBuffList[j])
                for k = 1, #goodsConfigVo.heroList do
                    if goodsConfigVo.heroList[k] == heroVo.professionType then
                        add = add * (1 + goodsConfigVo.efficiency / 1000)
                    end
                end
            end

            allPower = allPower + math.ceil(singlePower * add)
        end
        return allPower
    else
        return value
    end
end

-- 当前所在的格子
function getCurrentCell(self)
    return self.mTriggerCell
end

-- 获取buff上限升级消耗
function getExpandBuffCoin(self)
    -- return self.mExpandBuffCoin
end

-- 获取是否达到上限
function getIsExpandMax(self)
    -- return self.mIsExpandMax
end

-- 获取buff上限
function getBuffLimit(self)
    return self.mBuffLimit
end

-- 设置地图的buff
function setMapBuff(self, args)
    self.cellId = args.cell_id
    self.buffList = args.buff_list
end

-- 获取当前格子和buff
function getMapIdAndBuff(self)
    return self.cellId, self.buffList
end

-- 清理当前格子和buff
function clearMapBuff(self)
    self.buffList = {}
end

-- 设置最后地图Id
function setLastMapId(self, cellId)
    self.lastMapId = cellId
end

-- 获取最后的地图id
function getLastMapId(self)
    return self.lastMapId
end

-- 更新锁定状态
function updateLockState(self, id, state)
    if self.mUpdateDic == nil then
        self.mUpdateDic = {}
    end
    self.mUpdateDic[id] = state
end

-- 获取锁定状态
function getUpdateLockState(self)
    return self.mUpdateDic
end

-- 清楚锁定状态
function clearLockState(self)
    self.mUpdateDic = {}
end

-- 获取地图状态
function getMapState(self, cellId)
    -- 当前触发
    local isCurrent = self:getCurrentCell() == cellId
    local isLast = self.mPassCell[1] == cellId
    local linkNum = self:getRogueMapNum(cellId)
    local isPass = self:getRogueLikeIsPass(cellId)

    return isCurrent, isLast, linkNum, isPass
end

function getIsLast(self, cellId)
    if self.mPassCell then
        return self.mPassCell[1] == cellId
    else
        return false
    end
end

-- 获取格子是不是当前
function getMapIsCurrent(self, cellId)
    return self:getCurrentCell() == cellId
end

-- 获取格子是否已经通过了
function getMapIsPass(self, cellId)
    return self:getRogueLikeIsPass(cellId)
end

-- 获取是否是特殊连线规则
function getLinkNum(self, cellId)
    return self:getRogueMapNum(cellId)
end

-- 获取当前积分点数
function getPoint(self)
    if self.mPoint == nil then
        self.mPoint = 0
    end
    return self.mPoint
end
-------------------------------------------------------------server end------------------------------------

-------------------------------------------------------------local start------------------------------------

--设置最后的推荐战斗力
function setLastMapPowerFight(self, power)
    self.lastPower = power
end

--获取最后的推荐战斗力
function getLastMapPowerFight(self)
    return self.lastPower
end

--解析分数数据
function parseRogueLikeScoreData(self)
    self.roguelikeScoreDic = {}
    local baseData = RefMgr:getData("roguelike_score_tips")
    for id, data in pairs(baseData) do
        local vo = rogueLike.RogueLikeScoreVo.new()
        vo:parseData(id, data)
        if self.roguelikeScoreDic[vo.difficulty] == nil then
            self.roguelikeScoreDic[vo.difficulty] = {}
        end
        table.insert(self.roguelikeScoreDic[vo.difficulty], vo)
    end
end

--获取分数数据
function getRogueLikeScoreData(self, difficulty)
    if self.roguelikeScoreDic == nil then
        self:parseRogueLikeScoreData()
    end

    return self.roguelikeScoreDic[difficulty]
end

-- 解析肉鸽战斗数据
function parseRogueLikeDupData(self)
    self.goulikeDupDic = {}
    local baseData = RefMgr:getData("roguelike_dup_data")
    for id, data in pairs(baseData) do
        local vo = rogueLike.RogueLikeDupVo.new()
        vo:parseData(id, data)
        self.goulikeDupDic[id] = vo
    end
end

-- 获取格子信息
function parseRogueLikeData(self)
    self.rogueLikeCellData = {}
    local baseData = RefMgr:getData("roguelike_data")
    for id, data in pairs(baseData) do
        local vo = rogueLike.RogueLikeDataMapVo.new()
        vo:parseData(data)
        self.rogueLikeCellData[id] = vo
    end
end

-- 解析肉鸽物资配置
function parseGoodsConfig(self)
    self.mGoodsConfigDic = {}
    local baseData = RefMgr:getData("roguelike_supplies_data")
    for key, data in pairs(baseData) do
        local configVo = LuaPoolMgr:poolGet(rogueLike.RogueLikeGoodsConfigVo)
        configVo:parseData(key, data)
        self.mGoodsConfigDic[key] = configVo
    end
end

-- 解析肉鸽事件数据
function parseEventData(self)
    self.rogueLikeEventDic = {}
    local baseData = RefMgr:getData("roguelike_event_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(rogueLike.RogueLikeEventVo)
        vo:parseData(key, data)
        self.rogueLikeEventDic[key] = vo
    end
end

-- 解析肉鸽难度
function parseDifficultyData(self)
    self.mDifficutyData = {}
    local baseData = RefMgr:getData("roguelike_difficulty_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(rogueLike.RogueLikeDifficultyVo)
        vo:parseData(data)
        self.mDifficutyData[key] = vo
    end
end

-- 解析肉鸽统计数据
function parseSettData(self)
    self.mSettPointData = {}
    local baseData = RefMgr:getData("roguelike_point_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(rogueLike.RogueLikeSettPointVo)
        vo:parseData(data)
        self.mSettPointData[key] = vo
    end
end

-- 解析肉鸽任务数据
function parseTaskData(self)
    self.mTaskData = {}
    local baseData = RefMgr:getData("roguelike_task_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(rogueLike.RogueLikeTaskVo)
        vo:parseData(key, data)
        self.mTaskData[key] = { taskVo = vo }
    end
end

-- 解析肉鸽任务分数数据
function parseTaskScoreData(self)
    self.mTaskScoreData = {}
    local baseData = RefMgr:getData("roguelike_task_score_award_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(rogueLike.RogueLikeTaskScoreVo)
        vo:parseData(key, data)
        self.mTaskScoreData[key] = vo
    end
end

-- 解析肉鸽排行版奖励
function parseRankAwardConfig(self)
    self.mRankAwardList = {}
    local baseData = RefMgr:getData("maze_reward_data")
    for key, data in pairs(baseData) do
        local rewardVo = LuaPoolMgr:poolGet(rank.RankRewardVo)
        rewardVo:parseData(key, data)
        table.insert(self.mRankAwardList, rewardVo)
    end
    table.sort(self.mRankAwardList, function(a, b)
        return a.leftRank < b.leftRank
    end)
end

-- 获取排行榜奖励
function getRankAwardList(self)
    if self.mRankAwardList == nil then
        self:parseRankAwardConfig()
    end
    return self.mRankAwardList
end

-- 获取收藏品数据
function getCollectionData(self)
    if self.mCollectionList == nil then
        if self.mGoodsConfigDic == nil then
            self:parseGoodsConfig()
        end
        self.mCollectionList = {}
        for key, vo in pairs(self.mGoodsConfigDic) do
            if vo.collectionShow == 0 then
                table.insert(self.mCollectionList, { vo = vo, key = key })
            end
        end
    end
    return self.mCollectionList
end

function getCurrentHasCollectionData(self)

    if self.mGoodsConfigDic == nil then
        self:parseGoodsConfig()
    end
    self.mCurrentCollectionList = {}

    local hasBuff = self:getBuffList()
    for key, vo in pairs(self.mGoodsConfigDic) do
        if table.indexof01(hasBuff, key) > 0 then
            table.insert(self.mCurrentCollectionList, { vo = vo, key = key })
        end
    end

    return self.mCurrentCollectionList
end

-- 获取任务积分数据
function getTaskScoreData(self)
    if self.mTaskScoreData == nil then
        self:parseTaskScoreData()
    end

    return self.mTaskScoreData
end

-- 获取任务数据
function getTaskData(self)
    if self.mTaskData == nil then
        self:parseTaskData()
    end

    local list = {}
    for id, data in pairs(self.mTaskData) do
        local serverVo = self:getServerTaskInfo(id)
        self.mTaskData[id].serverVo = serverVo
        table.insert(list, self.mTaskData[id])
    end
    table.sort(list, self.__byState)
    return list
end

function __byState(vo1, vo2)
    if vo1.serverVo.state ~= vo2.serverVo.state then
        return vo1.serverVo.state < vo2.serverVo.state
    else
        return vo1.taskVo.id < vo2.taskVo.id
    end
end

-- 获取肉鸽统计数据
function getSettData(self)
    if self.mSettPointData == nil then
        self:parseSettData()
    end

    return self.mSettPointData
end

-- 获取肉鸽难度表
function getDifficultyDic(self)
    if self.mDifficutyData == nil then
        self:parseDifficultyData()
    end
    return self.mDifficutyData
end

-- 获取单个难度表
function getSingleDifficulty(self, key)
    if self.mDifficutyData == nil then
        self:parseDifficultyData()
    end
    return self.mDifficutyData[key]
end

-- 获取肉鸽事件数据
function getRogueLikeEventData(self, key)
    if self.rogueLikeEventDic == nil then
        self:parseEventData()
    end

    return self.rogueLikeEventDic[key]
end

-- 获取物资数据
function getGoodsConfigVo(self, buffId)
    if (not self.mGoodsConfigDic) then
        self:parseGoodsConfig()
    end
    return self.mGoodsConfigDic[buffId]
end

--获取提升量
function getSpEffString(self)
    if self.rogueLikeCellData == nil then
        self:parseRogueLikeData()
    end
    local index = self.mDifficuty * 100 + self.mCurrentLayer
    return self.rogueLikeCellData[index]:getSpEffString()
end

-- 获取格子行列信息
function getRogueMapColRow(self, id)
    if self.rogueLikeCellData == nil then
        self:parseRogueLikeData()
    end

    local index = self.mDifficuty * 100 + self.mCurrentLayer
    return self.rogueLikeCellData[index]:getColRow(id)
end

-- 获取地图格子生成规则
function getRogueMapRule(self, id)
    if self.rogueLikeCellData == nil then
        self:parseRogueLikeData()
    end
    local index = self.mDifficuty * 100 + self.mCurrentLayer
    return self.rogueLikeCellData[index]:getRule(id)
end

-- 获取地图格子被派生规则
function getRogueMapChildRule(self, id)
    if self.rogueLikeCellData == nil then
        self:parseRogueLikeData()
    end
    local index = self.mDifficuty * 100 + self.mCurrentLayer
    return self.rogueLikeCellData[index]:getChildRule(id)
end

-- 获取最后格子的行列
function getLastMapColRow(self)
    if self.mCurrentLayer == 0 then
        return 0, 0
    end

    if (self.mPassCell == nil or #self.mPassCell < 1) then
        return 0, 0
    end

    if self.rogueLikeCellData == nil then
        self:parseRogueLikeData()
    end
    local index = self.mDifficuty * 100 + self.mCurrentLayer
    return self.rogueLikeCellData[index]:getColRow(self.mPassCell[1])
end

-- 特殊连线规则连接的地图Id
function getRogueMapNum(self, id)
    if self.rogueLikeCellData == nil then
        self:parseRogueLikeData()
    end
    local index = self.mDifficuty * 100 + self.mCurrentLayer
    return self.rogueLikeCellData[index]:getNum(id)
end

-- 获取最后格子特殊连线规则
function getLastMapIsLinkNum(self)
    if (self.mPassCell == nil or #self.mPassCell < 1) then
        return 0
    else
        return self:getRogueMapNum(self.mPassCell[1])
    end
end

-- 获取肉鸽战斗数据
function getRogueLikeDupData(self, dupId)
    if self.goulikeDupDic == nil then
        self:parseRogueLikeDupData()
    end
    return self.goulikeDupDic[dupId]
end

-- 活动是否开启（功能开启及活动时间）
function isOpen(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_ROGUE, false) == false then
        return false
    end
    -- if activity.ActivityManager:checkIsOpenByFuncId(funcopen.FuncOpenConst.FUNC_ID_ROGUE, false) == false then
    --     return false
    -- end
    return true
end

function updateFilterData(self, data)
    self.isDesc = data.isDesc
    self.filter = data.currentFilter
    self.isShowHas = data.isShowHas

    GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_COLLECTION_FILTER)
end

function getFilterData(self)
    return self.isDesc, self.filter, self.isShowHas
end
------------------------------------------------------------local end------------------------------------
-- 战斗结算面板显示的名字
function getDupName(self, tileId)
    local data = self:getRogueLikeSingleMap(tileId)
    if data then
        local dupVo = self:getRogueLikeDupData(data.args[1].key)
        return dupVo.name
    else
        return ""
    end
end

function getRecommandFight(self, tileId)
    local data = self:getRogueLikeSingleMap(tileId)
    local dupVo = self:getRogueLikeDupData(data.args[1].key)
    if (dupVo) then
        return dupVo.recommandFight
    end
    return nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]