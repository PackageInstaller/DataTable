module('dup.DupClimbTowerAreaVo', Class.impl())
--[[ 
    爬塔副本区域数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.areaId = cusId
    self.name = cusData.name
    self.mDupList = cusData.dup_list
    self.background = cusData.background
    self.position = cusData.position
    self.level = cusData.level
    self.awardList = cusData.area_award
end

-- 获取区域副本列表
function dups(self)
    return self.mDupList
end

function getName(self)
    return _TT(self.name)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
