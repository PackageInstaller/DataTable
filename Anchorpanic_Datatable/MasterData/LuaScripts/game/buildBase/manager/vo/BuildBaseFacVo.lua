module("buildBase.BuildBaseFacVo", Class.impl())

function parseData(self, id, data)
    self.type = id 
    -- 类型icon
    self.icon = data.icon
    -- 类型名称
    self.name = data.name
    self.items = {}
    for k,v in pairs(data.factory_item) do
        local vo = buildBase.BuildBaseFacItemVo.new()
        vo:parseData(k, v)
        table.insert(self.items, vo)
    end
    table.sort(self.items, function(a, b)
        return a.id < b.id
    end )
    self.needLevel = data.need_level
end

function getItemVo(self, id)
    for k,v in pairs(self.items) do
        if v.id == id then 
            return v
        end
    end
end

return _M
