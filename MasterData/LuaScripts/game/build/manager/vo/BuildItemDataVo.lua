

module('build.BuildItemDataVo', Class.impl())

-- 解析可生成物件配置，缓存图标、尺寸和得分信息
function parseData(self, id, cusData)
    self.id = id
    self.icon = cusData.icon
    self.size = cusData.size
   
    self.score = cusData.score
end

return _M