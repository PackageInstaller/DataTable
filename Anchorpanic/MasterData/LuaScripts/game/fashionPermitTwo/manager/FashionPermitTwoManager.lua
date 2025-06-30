module("fashionPermitTwo.FashionPermitTwoManager", Class.impl(Manager))

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
    self.mViewList = {}
end

-- 析构函数
function dtor(self)
end

function setFashionPemitInfo(self, msg)
    self.mExp = msg.exp
    self.mFashionLv = msg.lv
    self.isBuyFashionPermit = msg.unlock_gear ~= 0
    self.mFashionPermitedNLvList = msg.gained_primary_reward
    self.mFashionPermitedSLvList = msg.gained_senior_reward
    self.mTaskInfo = msg.task_info

    self.mIsUnlockFashion = msg.is_unlock_fashion
    self:updateTaskMsgVo()
    self:updateBubble()
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_PERMIT_TWO_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHIONPERMIT_TWO_TASK_PANEL)
end

function getFashionIsUnlock(self)
    return self.mIsUnlockFashion == 1
end

function getFashionTaskInfo(self, id)
    for _, data in pairs(self.mTaskInfo) do
        if data.id == id then
            return data
        end
    end
    return nil
end

function setBuyFashionPermitLv(self, msg)
    self.mFashionLv = self.mFashionLv + msg.buy_lv
    self:updateBubble()
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_PERMIT_TWO_PANEL)
end

function setGainFashionPermitReward(self, msg)
    if msg.is_senior == 0 then
        table.insert(self.mFashionPermitedNLvList,msg.lv)
    else
        table.insert(self.mFashionPermitedSLvList,msg.lv)
    end
    self:updateBubble()
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_PERMIT_TWO_PANEL)
end

function updateFashionPermitTaskReceive(self, msg)
    for i = 1,#msg.task_id_list do
        for id, data in pairs(self.mTaskInfo) do
            if data.id == msg.task_id_list[i] then
                self.mTaskInfo[id].state = 2
                --data = msg.task_id_list[i]
            end
        end
    end
    self:updateTaskMsgVo()
    self:updateBubble()
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHIONPERMIT_TWO_TASK_PANEL)
end

function updateFashionPermitTask(self, msg)
    for id, data in pairs(self.mTaskInfo) do
        if data.id == msg.task_info.id then
            self.mTaskInfo[id] = msg.task_info
            --data = msg.task_info
        end
    end
    self:updateTaskMsgVo()
    self:updateBubble()
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHIONPERMIT_TWO_TASK_PANEL)
end

function getFashionPermitExp(self)
    return self.mExp
end

function getPermitedNLvList(self)
    return self.mFashionPermitedNLvList
end

function getPermitedSLvList(self)
    return self.mFashionPermitedSLvList
end

function getIsBuyFashionPermit(self)
    return self.isBuyFashionPermit
end

function getFashionPermitedLv(self)
    return self.mFashionLv
end

function getCurPermitStageData(self)
    local tempVo = nil
    if self.mFashionPermitDataList == nil then
        self:parseFashionPermitData()
    end
    for _, vo in ipairs(self.mFashionPermitDataList) do
        if (self:getFashionPermitedLv() == vo.lv) then
            tempVo = vo
        end
    end
    return tempVo
end

function getCurPermitKeyData(self)
    local tempVo = nil
    if self.mFashionPermitKeyDataList == nil then
        self:parseFashionPermitData()
    end
    for _, vo in ipairs(self.mFashionPermitKeyDataList) do
        if (self:getFashionPermitedLv() <= vo.lv) and (not vo:getIsUnlock()) then
            tempVo = vo
        elseif self:getFashionPermitedLv() >= self.mFashionPermitKeyDataList[1].lv then
            return vo
        end
    end
    return tempVo
end

-- 解析通行证配置列表
function parseFashionPermitData(self)
    self.mFashionPermitDataList = {}
    self.mFashionPermitKeyDataList = {}
    self.mFashionPermitMaxLv = 0
    local baseData = RefMgr:getData("fashion_permit2_data")
    for key, data in pairs(baseData) do
        local vo = fashionPermitTwo.FashionPermitTwoVo.new()
        if self.mFashionPermitMaxLv < key then
            self.mFashionPermitMaxLv = key
        end
        vo:parseData(key, data)
        if vo.keyReward > 0 then
            table.insert(self.mFashionPermitKeyDataList, vo)
        end
        table.insert(self.mFashionPermitDataList, vo)
    end
    table.sort(self.mFashionPermitKeyDataList, function(a, b)
        return a.lv < b.lv
    end)
    table.sort(self.mFashionPermitDataList, function(a, b)
        return a.lv < b.lv
    end)
end

function getFashionPermitList(self)
    if self.mFashionPermitDataList == nil then
        self:parseFashionPermitData()
    end
    return self.mFashionPermitDataList or {}
end

function getFashionPermitKeyData(self,curIndex)
    if self.mFashionPermitDataList == nil then
        self:parseFashionPermitData()
    end
    for i = 1, #self.mFashionPermitKeyDataList do
        local vo  = self.mFashionPermitKeyDataList[i]
        if vo.lv >= curIndex then
            return vo
        end
    end
    return self.mFashionPermitKeyDataList[#self.mFashionPermitKeyDataList]
end

function getFashionPermitMaxLv(self)
    if self.mFashionPermitMaxLv == nil then
        self:parseFashionPermitData()
    end
    return self.mFashionPermitMaxLv
end

function parseFashionPermitTaskData(self)
    self.mFashionPermitTaskList = {}
    local baseData = RefMgr:getData("fashion2_task_data")
    for id, data in pairs(baseData) do
        local vo = fashionPermitTwo.FashionPermitTwoTaskVo.new()
        local msgData = self:getFashionTaskInfo(id)
        vo:parseTaskVo(id, data, msgData)
        table.insert(self.mFashionPermitTaskList, vo)
    end
    table.sort(self.mFashionPermitTaskList, function(a, b)
        if a.msgData.state == b.msgData.state then
            return a.id < b.id
        else
            return a.msgData.state < b.msgData.state
        end
    end)
end

function updateTaskMsgVo(self)
    if self.mFashionPermitTaskList == nil then
        self:parseFashionPermitTaskData()
    else
        for _, vo in pairs(self.mFashionPermitTaskList) do
            local msgData = self:getFashionTaskInfo(vo.id)
            vo:updateMsgData(msgData)
        end
    end
    table.sort(self.mFashionPermitTaskList, function(a, b)
        if a.msgData.state == b.msgData.state then
            return a.id < b.id
        else
            return a.msgData.state < b.msgData.state
        end
    end)
end

function getFashionPermitTaskData(self)
    if self.mFashionPermitTaskList == nil then
        self:parseFashionPermitTaskData()
    end
    return self.mFashionPermitTaskList
end

-- 获取当前等级至X级之间的奖励列表
function getFashionPermitLvStageAwardList(self, endLv)
    local awardList = {}
    local tempList = {}
    local temp2List = {}
    local tempListDic = {}
    for _, permitVo in pairs(self:getFashionPermitList()) do
        if permitVo.lv > self:getFashionPermitedLv() and permitVo.lv <= endLv then
            for _, propsVo in ipairs(permitVo:getNoamlAwardList()) do
                table.insert(tempList, propsVo)
                table.insert(temp2List, propsVo)
            end
            if self:getIsBuyFashionPermit() then
                for _, propsVo1 in ipairs(permitVo:getSeniorAwardList()) do
                    table.insert(tempList, propsVo1)
                    table.insert(temp2List, propsVo1)
                end
            end
        end
    end
    for _, voL in ipairs(tempList) do
        for k, voR in ipairs(temp2List) do
            if voR.tid == voL.tid then
                if tempListDic[voR.tid] then
                    tempListDic[voR.tid].num = tempListDic[voR.tid].num + voR.num
                else
                    tempListDic[voR.tid] = {
                        num = voR.num,
                        tid = voR.tid
                    }
                end
                table.remove(temp2List, k)
                voR = nil
            end
        end
    end
    for _, Vo in pairs(tempListDic) do
        table.insert(awardList, Vo)
    end
    return awardList or {}
end

function getCanReciveNum(self)
    local toIndex = 0
    for _, permitVo in ipairs(self:getFashionPermitList()) do
        if permitVo:getIsUnlock() then
            if ((not permitVo:getIsNomalRecived()) or ((not permitVo:getIsSeniorRecived()) and permitVo:getIsBuy())) then
                toIndex = toIndex + 1
            end
        end
    end
    return toIndex
end

function getPermitIndex(self)
    local toIndex = 0
    for _, permitVo in ipairs(self:getFashionPermitList()) do
        if permitVo:getIsUnlock() then
            if (not permitVo:getIsNomalRecived()) then
                toIndex = permitVo.lv - 1
                return toIndex
            elseif ((not permitVo:getIsSeniorRecived()) and permitVo:getIsBuy()) then
                toIndex = permitVo.lv - 1
                return toIndex
            end
        end
    end
    if toIndex < 1 then
        toIndex = self:getFashionPermitedLv() - 1
    end
    return toIndex
end

function canGetTask(self)


    local isRed = false

    if self.mFashionLv < self:getFashionPermitMaxLv() then
        if self.mTaskInfo ~= nil then
            for _, data in pairs(self.mTaskInfo) do
                if data.state == 0 then
                    isRed = true
                end
            end
        end
    end
    
    return isRed
end

function updateBubble(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FASHIONPERMITTWO)
    if not isOpen then
        return false
    end

    -- if not activity.ActivityManager:checkIsOpenByFuncId(funcopen.FuncOpenConst.FUNC_ID_FASHIONPERMITTWO) then
    --     return false
    -- end

    local isFlag = self:getCanReciveNum() >= 1 or self:canGetTask()

    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_FASHIONPERMITTWO, isFlag)
    --GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_PERMIT_TWO_RED)
end

-- 显示状态（主UI使用）
function checkShowState(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FASHIONPERMITTWO)
    if not isOpen then
        return false
    end

    if not activity.ActivityManager:checkIsOpenByFuncId(funcopen.FuncOpenConst.FUNC_ID_FASHIONPERMITTWO) then
        return false
    end

    return true
end

return _M
