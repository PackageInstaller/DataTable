module("lottery.LotteryManager", Class.impl(Manager))

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

end

function isShowRed(self)
    local round = self:getCurRound()
    local maxRound = lottery.LotteryManager:getMaxLotteryRound()
    if round > maxRound then
        round = maxRound
    end

    self.lotteryDataVo = lottery.LotteryManager:getLotteryDataByRound(round)
    local tid = self.lotteryDataVo.costOneId
    local num = self.lotteryDataVo.costOneNum
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(tid, num, true, true)
    if tips == "" and result then
        return true
    end
    return false
end

function parseLotteryPanelData(self,msg)
    self.curRound = msg.cur_grade
    self.curTimes = msg.cur_times
    self.showCardList = msg.show_card_list

    if self.showCardListResult == nil then
        GameDispatcher:dispatchEvent(EventName.UPDATE_LOTTERY_PANEL)
    else
        GameDispatcher:dispatchEvent(EventName.UPDATE_LOTTERY_GAME_PANEL)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
end

function parseLotteryResultData(self,msg)
    self.pos = msg.pos 
    self.showCardListResult = msg.show_card_list
end

function getLotteryResultData(self)
    local result = self.showCardListResult
    self.showCardListResult = nil
    return result
end

function getCurRound(self)
    return self.curRound and self.curRound or 1
end

function getCurTimes(self)
    return self.curTimes and self.curTimes or 0
end

function getShowCardList(self)
    return self.showCardList and self.showCardList or {}
end


function parseLotteryDataVo(self)
    self.lotteryData = {}
    self.lotteryMaxRound = 0
    local baseData = RefMgr:getData("scratch_card_data")
    for id, data in pairs(baseData) do
        local dataVo = LuaPoolMgr:poolGet(lottery.LotteryDataVo)
        dataVo:parseData(id, data)
        self.lotteryData[id] = dataVo

        if id > self.lotteryMaxRound then
            self.lotteryMaxRound = id
        end
    end
end

function getMaxLotteryRound(self)
    if self.lotteryData == nil then
        self:parseLotteryDataVo()
    end
    return self.lotteryMaxRound
end

function getLotteryDataVo(self)
    if self.lotteryData == nil then
        self:parseLotteryDataVo()
    end
    return self.lotteryData
end

function getLotteryDataByRound(self, round)
    if self.lotteryData == nil then
        self:parseLotteryDataVo()
    end
    return self.lotteryData[round]
end

return _M