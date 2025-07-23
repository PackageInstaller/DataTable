--[[    
    芯片副本总览配置
    @author Sxt
]]
module("dup.DupEquipConfigVo", Class.impl())

function parseData(self, cusId, cusData)
    self.id = cusId
    self.type = cusId
    self.name = cusData.name
    self.funcId = cusData.function_id
    self.des = cusData.describe
    self.suitList = cusData.suit_list
end

function getName(self)
    return _TT(self.name)
end

function getDes(self)
    return _TT(self.des)
end

function getSuitList(self)
    return self.suitList
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]