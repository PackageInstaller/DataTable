module('drop.DropDupDataVo', Class.impl())

-- 解析星级条件配置，缓存达成星级所需分数和描述文本
function parseData(self, key, cusData)
    self.id = key 
    self.star = cusData.star
    self.point = cusData.point
    self.des = cusData.des
end

return _M