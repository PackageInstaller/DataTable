
module('fashionPermit.FashionPermitVo', Class.impl())

function parseData(self, key, cusMsg)
    self.lv = key
    self.needExp = cusMsg.need_exp
    self.keyReward = cusMsg.key_reward
    self.seniorDrop = cusMsg.senior_reward
    self.primaryDrop = cusMsg.primary_reward
end

function getNoamlAwardList(self)
    return AwardPackManager:getAwardListById(self.primaryDrop)
end

function getSeniorAwardList(self)
    return AwardPackManager:getAwardListById(self.seniorDrop)
end

--是否已领取-普通
function getIsNomalRecived(self)
    local isRecive = table.indexof01(fashionPermit.FashionPermitManager:getPermitedNLvList(), self.lv) > 0
    return isRecive
end

--是否已领取-高级
function getIsSeniorRecived(self)
    local isRecive = table.indexof01(fashionPermit.FashionPermitManager:getPermitedSLvList(), self.lv) > 0
    return isRecive
end

--是否已解锁
function getIsUnlock(self)
    return fashionPermit.FashionPermitManager:getFashionPermitedLv() >= self.lv
end

--是否已购买
function getIsBuy(self)
    return fashionPermit.FashionPermitManager:getIsBuyFashionPermit()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]