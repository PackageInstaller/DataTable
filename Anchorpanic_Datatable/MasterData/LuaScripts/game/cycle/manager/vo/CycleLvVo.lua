module("cycle.CycleLvVo", Class.impl())

function parseLvVo(self, id, data)
    self.id = id

    self.needExp = data.need_exp
    self.reward = data.reward
    self.isCore = data.is_core
    self.describe = data.describe
    self.title = data.title
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
