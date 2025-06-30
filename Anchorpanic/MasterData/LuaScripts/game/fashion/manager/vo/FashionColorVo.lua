module("fashion.FashionColorVo", Class.impl())

function parseData(self, cusId, cusData)
    self.id = cusId

    self.posList = cusData.pos
    self.materials = cusData.materials
    self.sort = cusData.sort
    self.icon = cusData.icon
    self.uicode = cusData.uicode
    self.dissolves = cusData.dissolves
    self.costTid = cusData.cost_tid
    self.fashionIcon = cusData.fashionIcon
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]