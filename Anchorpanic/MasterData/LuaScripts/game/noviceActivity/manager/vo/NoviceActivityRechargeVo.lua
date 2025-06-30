
module("noviceActivity.NoviceActivityRechargeVo",Class.impl())

function parseData(self,curId,cusData)
    self.index=curId
    self.maxNum=cusData.get_num
    self.rewardList = cusData.reward
end


function getDes(self)
    return _TT(121012,self:getMaxNum())
end

function getTitle(self)
    return _TT(130021,self.index,#noviceActivity.NoviceActivityManager:getRechargeList())
end

function getMaxNum(self)
    return self.maxNum/100
end

function getState(self)
    if noviceActivity.NoviceActivityManager:checkRechargeIsRecivedAward(self.index) then
        return 2
    elseif noviceActivity.NoviceActivityManager:getRechargeNum()>=self:getMaxNum() then
        return 0
    end
    return 1
end

function getAwardList(self)
    return self.rewardList
end


return _M