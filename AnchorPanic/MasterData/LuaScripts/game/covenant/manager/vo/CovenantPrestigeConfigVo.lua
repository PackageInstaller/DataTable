module("CovenantPrestigeConfigVo", Class.impl())

function parseConfigData(self, id, cusData)
    self.id  = id
    self.reward = cusData.reward
    self.next_exp = cusData.next_exp
    self.describe_list = cusData.describe_list
    self.helperLimitLvl = cusData.helper_level
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
