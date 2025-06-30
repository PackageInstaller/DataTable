module("equipBuild.EquipRemakeShowDataVo", Class.impl())

function parseData(self,id,cusData)
    self.id = id 

    self.attr = cusData.attr
end

return _M