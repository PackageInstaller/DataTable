module("task.AchievementManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 配置字典
    self.mAchievementConfigDic = nil
    -- 配置的积分列表
    self.mAchievementScoreList = nil

    --点数
    self.point = nil
    -- 服务器成就列表
    self.mAchievementList = nil
    -- 已领取的积分id列表
    self.hadRecScoreIdList = nil
    -- 对应类型完成的成就数
    self.mAchievementTypeDic = nil
    -- 对应类型可领取奖励数
    self.mAchievementAwardTypeDic = nil

    -- 新增的成就id列表
    self.mActiveAchievementIdList = nil
    -- 当前显示类型
    self.mCurShowType = nil
    -- 当前滑动框长度
    self.mCurScrollHeight = 0
    -- 成就上一次值
    self.mLastvalue = 0
end

-- 解析成就配置表
function parseConfig(self)
    self.mAchievementConfigDic = {}
    local baseData = RefMgr:getData("achievement_data")
    for id, data in pairs(baseData) do
        for _, voData in pairs(data.achievement_reward) do
            local vo = LuaPoolMgr:poolGet(task.AchievementConfigVo)
            vo:parseData(id, data.tab_type, voData)
            vo.uicode = data.ui_code
            if (not self.mAchievementConfigDic[id]) then
                self.mAchievementConfigDic[id] = {}
            end
            self.mAchievementConfigDic[id][vo.step] = vo
        end
    end
end

-- 解析成就配置表
function parseScoreConfig(self)
    self.mAchievementScoreList = {}
    local baseData = RefMgr:getData("achievement_stage_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(task.AchievementScoreConfigVo)
        vo:parseData(id, data.target_num, data.reward)
        table.insert(self.mAchievementScoreList, vo)
    end
    local function sortScore(scoreConfigVo_1, scoreConfigVo_2)
        -- 积分从小到大
        if (scoreConfigVo_1.score ~= scoreConfigVo_2.score) then
            return scoreConfigVo_1.score < scoreConfigVo_2.score
        else
            -- id从小到大
            if (scoreConfigVo_1.id ~= scoreConfigVo_2.id) then
                return scoreConfigVo_1.id < scoreConfigVo_2.id
            end
        end
        return false
    end
    table.sort(self.mAchievementScoreList, sortScore)
end

-- 获取成就积分列表
function getAchieveScoreConfigList(self)
    if (not self.mAchievementScoreList) then
        self:parseScoreConfig()
        table.sort(self.mAchievementScoreList,
        function(config1, config2)
            if (config1.score ~= config2.score) then
                return config1.score < config2.score
            end
        end)
    end
    return self.mAchievementScoreList
end

-- 获取成就当前配置表最大积分
function getAchieveMaxScoreByConfig(self)
    if (not self.mAchievementScoreList) then
        self:parseScoreConfig()
        table.sort(self.mAchievementScoreList,
        function(config1, config2)
            if (config1.score ~= config2.score) then
                return config1.score < config2.score
            end
        end)
    end
    return self.mAchievementScoreList[#self.mAchievementScoreList].score
end

-- 获取成就积分配置
function getAchieveScoreConfigVo(self, scoreId)
    local list = self:getAchieveScoreConfigList()
    for i = 1, #list do
        if (list[i].id == scoreId) then
            return list[i]
        end
    end
    return nil
end

-- 根据成就id和成就阶段获取配置
function getAchievementConfigVo(self, id, step)
    if (not self.mAchievementConfigDic) then
        self:parseConfig()
    end

    if (self.mAchievementConfigDic[id]) then
        if self.mAchievementConfigDic[id][step] == nil then
            logInfo("任务空id.." .. id .. "阶段====" .. step)
        end
        return self.mAchievementConfigDic[id][step]
    else 
        logInfo("任务空id.." .. id)
    end
end

-- 根据类型获取成就配置列表
function getAchievementConfigList(self, tabType)
    if (not self.mAchievementConfigDic) then
        self:parseConfig()
    end
    local list = {}
    for id, stepDic in pairs(self.mAchievementConfigDic) do
        for step, configVo in pairs(stepDic) do
            if (tabType == nil or configVo.tabType == tabType) then
                table.insert(list, configVo)
            end
        end
    end
    return list
end

-- 根据类型获取成就配置点数
function getAchievementConfigPointNum(self, tabType)
    if (not self.mAchievementConfigDic) then
        self:parseConfig()
    end
    local point = 0
    for id, stepDic in pairs(self.mAchievementConfigDic) do
        for step, configVo in pairs(stepDic) do
            if (tabType == nil or configVo.tabType == tabType) then
                point = point + configVo.achievementPoint
            end
        end
    end
    return point
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 解析服务器成就列表
function parseAchievementListMsg(self, msg)
    -- 已领取的积分id列表
    self.hadRecScoreIdList = msg.had_gain_stage_reward_list
    --拥有的点数
    self.point = msg.point
    -- 对应类型完成的成就数
    self.mAchievementTypeDic = {}
    self.mAchievementAwardTypeDic = {}
    for i = 1, #msg.complete_achieve_info do
        self.mAchievementTypeDic[msg.complete_achieve_info[i].type] = msg.complete_achieve_info[i].gain_point
        self.mAchievementAwardTypeDic[msg.complete_achieve_info[i].type] = msg.complete_achieve_info[i].draw_times
    end

    self.mAchievementList = {}
    self.mActiveAchievementIdList = {}
    for i = 1, #msg.achievement_info do
        local vo = task.AchievementVo.new()
        vo:parseData(msg.achievement_info[i])
        table.insert(self.mAchievementList, vo)
    end
    self:sortAchievementList()

    self:updateRedFlag()
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACHIEVEMENT_LIST)
end

-- 更新单个成就数据
function updateAchievementListMsg(self, msg)
    if (self.mAchievementList) then
        local achievementVo = nil
        local oldState = nil
        local isHas = false
        for i = 1, #self.mAchievementList do
            achievementVo = self.mAchievementList[i]
            if (achievementVo.id == msg.id) then
                oldState = achievementVo:getState()
                achievementVo:parseData(msg)
                isHas = true
                break
            end
        end

        if (not self.mActiveAchievementIdList) then
            self.mActiveAchievementIdList = {}
        end
        if (not isHas) then
            achievementVo = task.AchievementVo.new()
            achievementVo:parseData(msg)
            table.insert(self.mAchievementList, achievementVo)
        end
        if (achievementVo:getState() == task.AwardRecState.CAN_REC and table.indexof(self.mActiveAchievementIdList, achievementVo.id) == false) then
            if (oldState ~= achievementVo:getState()) then -- 新增 / 更新
                table.insert(self.mActiveAchievementIdList, achievementVo.id)
                table.sort(self.mActiveAchievementIdList,
                function(id1, id2)
                    if (id1 ~= id2) then
                        return id1 < id2
                    end
                end)
            end
        end
        if #self.mActiveAchievementIdList >= 3 then
            table.remove(self.mActiveAchievementIdList, 1)
        end
        self:sortAchievementList()
        self:updateRedFlag()
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACHIEVEMENT_LIST)
    end
end

-- 领取单个成就奖励
function updateAchievementAward(self, msg)
    if (msg.result == 1) then
        self.point = msg.point
        local achievementVo = self:getAchievementVo(msg.achievement_id)
        local achievementConfigVo = self:getAchievementConfigVo(achievementVo.id, achievementVo.step)
        if (achievementConfigVo) then
            ShowAwardPanel:showPropsList(achievementConfigVo:getAwardList())
            GameDispatcher:dispatchEvent(EventName.UPDATE_ACHIEVEMENT_AWARD, { achievementVo = achievementVo, achievementConfigVo = achievementConfigVo })
        end
    else
        gs.Message.Show(_TT(36516))
    end
end

-- 领取所有成就奖励更新
function updateAllAchievementAward(self, msg)
    if (msg.result == 1) then
        self.point = msg.point
        self:updateRedFlag()
    else
        gs.Message.Show(_TT(36516))
    end
end

-- 更新已完成成就总数
function parseUpdateCompleteInfoMsg(self, msg)
    -- 对应类型完成的成就数
    self.mAchievementTypeDic = {}
    if self.mAchievementAwardTypeDic == nil then
        self.mAchievementAwardTypeDic = {}
    end
    for i = 1, #msg.complete_achieve_info do
        self.mAchievementTypeDic[msg.complete_achieve_info[i].type] = msg.complete_achieve_info[i].gain_point
        self.mAchievementAwardTypeDic[msg.complete_achieve_info[i].type] = msg.complete_achieve_info[i].draw_times
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACHIEVEMENT_LIST)
end

-- 更新领取积分奖励
function parseUpdateScoreMsg(self, msg)
    if (msg.result == 1) then
        if (not self.hadRecScoreIdList) then
            self.hadRecScoreIdList = {}
        end
        table.insert(self.hadRecScoreIdList, msg.stage_award_id)
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACHIEVEMENT_SCORE_AWARD, {})
        local scoreConfigVo = self:getAchieveScoreConfigVo(msg.stage_award_id)
        local awardlist = {}
        for i, vo in ipairs(scoreConfigVo:getAwardList()) do
            local vo1 = { tid = vo.tid, count = vo.num }
            table.insert(awardlist, vo1)
        end
        ShowAwardPanel:showPropsList(awardlist)

        self:updateRedFlag()
    else
        gs.Message.Show(_TT(36516))
    end
end

-- 获取积分状态
function getScoreAwardState(self, scoreId)
    if (not self.hadRecScoreIdList) then
        return task.AwardRecState.UN_REC
    end
    if (table.indexof(self.hadRecScoreIdList, scoreId) ~= false) then
        return task.AwardRecState.HAS_REC
    else
        local scoreConfigVo = self:getAchieveScoreConfigVo(scoreId)
        if (scoreConfigVo) then
            if (self:getCompleteNum(nil) >= scoreConfigVo.score) then
                return task.AwardRecState.CAN_REC
            else
                return task.AwardRecState.UN_REC
            end
        else
            return task.AwardRecState.UN_REC
        end
    end
end

-- 获取已领取的积分id列表
function getHadRecScoreIdList(self)
    return self.hadRecScoreIdList
end

-- 获取已完成成就数量
function getCompleteNum(self, tabType)
    if (self.mAchievementTypeDic) then
        if (tabType) then
            return self.mAchievementTypeDic[tabType] or 0
        else
            local allNum = 0
            for tabType, num in pairs(self.mAchievementTypeDic) do
                allNum = allNum + num
            end
            return allNum
        end
    else
        return 0
    end
end

-- 新增的成就id列表
function getActiveAchievementId(self)
    if (self.mActiveAchievementIdList and #self.mActiveAchievementIdList > 0) then
        return table.remove(self.mActiveAchievementIdList, 1)
    else
        return nil
    end
end

function getAchievementVo(self, id)
    for i = 1, #self.mAchievementList do
        if (self.mAchievementList[i].id == id) then
            return self.mAchievementList[i]
        end
    end
end

function getAchievementList(self, tabType)
    local list = {}
    if (self.mAchievementList) then
        for i = 1, #self.mAchievementList do
            local vo = self.mAchievementList[i]
            if (tabType == nil or self:getAchievementConfigVo(vo.id, vo.step).tabType == tabType) then
                table.insert(list, vo)
            end
        end
    end
    return list
end
-- 获取全部成就列表（如果单个成就有多个阶段，则每个阶段是一条数据）
function getTotalAchievementList(self, tabType)
    local list = {}
    if (self.mAchievementList) then
        for i = 1, #self.mAchievementList do
            local vo = self.mAchievementList[i]
            if (tabType == nil or self:getAchievementConfigVo(vo.id, vo.step).tabType == tabType) then
                table.insert(list, vo)
                local childs = vo:getChilds()
                for j = 1, #childs do
                    table.insert(list, childs[j])
                end
            end
        end
    end
    table.sort(list, self.__sortAchievementList)
    return list
end

function sortAchievementList(self)
    table.sort(self.mAchievementList, self.__sortAchievementList)
end

function __sortAchievementConfigList(self, achievementConfigVo_1, achievementConfigVo_2)
    local achievementVo_1 = task.AchievementManager:getAchievementVo(achievementConfigVo_1.id)
    local achievementVo_2 = task.AchievementManager:getAchievementVo(achievementConfigVo_2.id)
    return self:__sortAchievementList(achievementVo_1, achievementVo_2)
end

function __sortAchievementList(achievementVo_1, achievementVo_2)
    if (achievementVo_1 and achievementVo_2) then
        if (achievementVo_1:getState() > achievementVo_2:getState()) then
            return false
        end
        if (achievementVo_1:getState() < achievementVo_2:getState()) then
            return true
        end
    else
        if (achievementVo_1 and not achievementVo_2) then
            return true
        end
        if (not achievementVo_1 and achievementVo_2) then
            return false
        end
    end
    if achievementVo_1:getFinishTime() ~= achievementVo_2:getFinishTime() then
        return achievementVo_1:getFinishTime() > achievementVo_2:getFinishTime()
    end
    -- id从小到大
    if (achievementVo_1.id ~= achievementVo_2.id) then
        return achievementVo_1.id < achievementVo_2.id
    else
        -- step从小到大
        if (achievementVo_1.step ~= achievementVo_2.step) then
            return achievementVo_1.step > achievementVo_2.step
        end
    end
    return false
end

function updateRedFlag(self)
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_HOME_ACHIEVEMENT, self:judgeIsCanRec())
end

function judgeIsCanRec(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_ACHIEVEMENT)
    if not isOpen then
        return false
    end
    local isCanRec = self:judgeIsTypeCanRes(task.AchievementTab.PREVIEW)
    if (not isCanRec) then
        isCanRec = self:judgeIsTypeCanRes(task.AchievementTab.STORY)
    end
    if (not isCanRec) then
        isCanRec = self:judgeIsTypeCanRes(task.AchievementTab.DEVELOPMENT)
    end
    if (not isCanRec) then
        isCanRec = self:judgeIsTypeCanRes(task.AchievementTab.HERO)
    end
    if (not isCanRec) then
        isCanRec = self:judgeIsTypeCanRes(task.AchievementTab.OTHER)
    end
    return isCanRec
end

function judgeIsTypeCanRes(self, tabType)
    if (tabType == task.AchievementTab.PREVIEW) then
        local list = self:getAchieveScoreConfigList()
        for i = 1, #list do
            local state = self:getScoreAwardState(list[i].id)
            if (state == task.AwardRecState.CAN_REC) then
                return true
            end
        end
    else
        local list = self:getAchievementList(tabType)
        for i = 1, #list do
            local achievementVo = list[i]
            if (achievementVo:getState() == task.AwardRecState.CAN_REC) then
                return true
            end
        end
    end
    return false
end

function getCanResCountByType(self, tabType)
    -- local count = 0

    -- local list = self:getAchievementList(tabType)
    -- for i = 1, #list do
    --     local achievementVo = list[i]
    --     if (achievementVo:getState() == task.AwardRecState.CAN_REC) then
    --         count = count + achievementVo.drawTimes
    --     end
    -- end

    -- return count

    return self.mAchievementAwardTypeDic[tabType]
end

function getCurCanResCountByType(self, tabType)
    local count = 0
    local list = self:getAchievementList(tabType)
    for i = 1, #list do
        local achievementVo = list[i]
        if (achievementVo:getState() == task.AwardRecState.CAN_REC) then
            count = count + 1
        end
    end
    return count
end

--当前滑动框高度
function setScrollHeight(self, tabType)
    self.mCurScrollHeight = tabType
end

--获取滑动框高度
function getScrollHeight(self)
    return self.mCurScrollHeight
end

--保存成就上一次值
function setLastValue(self, lastValue)
    self.mLastvalue = lastValue
end
--获取滑动框高度
function getLastValue(self)
    return self.mLastvalue
end

--当前显示类型
function setShowType(self, tabType)
    self.mCurShowType = tabType
end
--获取当前显示类型
function getShowType(self)
    return self.mCurShowType
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]