module("cycle.CycleTalentVo", Class.impl())

function parseData(self, id, data)
    self.id = id 
    self.preId = data.pre_id 
    self.type = data.type 
    self.needTalent = data.need_talent
    self.title = data.title
    self.des = data.des
    self.icon = data.icon
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
