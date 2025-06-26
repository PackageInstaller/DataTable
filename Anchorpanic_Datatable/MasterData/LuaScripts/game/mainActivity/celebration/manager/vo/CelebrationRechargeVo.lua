module('Celebration.CelebrationRechargeVo', Class.impl())
--[[ 
    主线关卡城池数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self,curId, cusData)
    self.index=curId
    self.maxNum=cusData.get_num
    self.rewardList = cusData.reward
end

function getDes(self)
    return _TT(121012,self:getMaxNum())
end

function getTitle(self)
    return _TT(121011,self.index,#Celebration.CelebrationManager:getRechargeList())
end

function getMaxNum(self)
    return self.maxNum/100
end

function getState(self)
    if Celebration.CelebrationManager:checkRechargeIsRecivedAward(self.index) then
        return 2
    elseif Celebration.CelebrationManager:getRechargeNum()>=self:getMaxNum() then
        return 0
    end
    return 1
end

function getAwardList(self)
    return self.rewardList
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]