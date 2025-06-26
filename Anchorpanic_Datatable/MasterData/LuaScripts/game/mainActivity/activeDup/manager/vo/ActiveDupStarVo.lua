module('mainActivity.ActiveDupStarVo', Class.impl())
--[[ 
    主线关卡城池数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.starId = cusId
    self.type = cusData.type
    self.subtype = cusData.subtype
    self.des = cusData.des
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]