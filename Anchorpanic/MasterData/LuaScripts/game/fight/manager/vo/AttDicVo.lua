--[[
    结算属性
]]
module('fight.AttDicVo', Class.impl('lib.event.EventDispatcher'))

function ctor(self)
    self.id = 0
    -- self.heroType = 1
    -- self.heroCamp = 1
end

function setDic(self, cusAtts)
    self.mAttsDic = cusAtts
end

function getDic(self)
    return self.mAttsDic
end

function getAtt(self, cusType)
    return self.mAttsDic[cusType] or 0
end

function setAtt(self, cusType, cusValue)
    self.mAttsDic[cusType] = cusValue > 0 and cusValue or 0
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
