--[[    
    副本Up数据
    @author Jacob
]]
module("dup.DupUpVo", Class.impl())

function parseData(self, key, cusData)
    -- 副本总入口id
    self.id = key
    self.typeList = cusData.type
    self.uicode = cusData.uicode
end

function getUiCode(self)
    return self.uicode
end

function getDupId(self)
    return self.id
end

function getTypeList(self)
    return self.typeList
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]