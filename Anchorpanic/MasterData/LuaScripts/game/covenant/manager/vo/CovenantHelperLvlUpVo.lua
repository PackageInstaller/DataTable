module("covenant.CovenantHelperLvlUpVo", Class.impl())

function ctor(self)
    self:__init()
end

function __init(self)
    self.helperId = nil
    self.lvl = nil
    self.exp = nil
    self.addGene = nil
end

function parseConfigData(self, cusHelperId, cusData)
    self.helperId = cusHelperId
    self.lvl = cusData.level
    self.exp = cusData.exp
    self.addGene = cusData.gene
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
