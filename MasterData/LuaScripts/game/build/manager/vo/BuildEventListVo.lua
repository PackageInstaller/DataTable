



module('build.BuildEventListVo', Class.impl())

-- 解析关卡事件配置，记录事件 id 与对应图标资源 id
function parseData(self, id, cusData)
    self.id = id
    self.icon_id = cusData.icon_id 
end

return _M