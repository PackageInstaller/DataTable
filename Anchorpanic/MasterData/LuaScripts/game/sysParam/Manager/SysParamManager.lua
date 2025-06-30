module('sysParam.SysParamManager', Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.mConfigDic = {}
    self:parseConfigData()
end

-- 初始化配置表
function parseConfigData(self)
    self.mConfigDic = {}
    local baseData = RefMgr:getData("system_param")
    for key, data in pairs(baseData) do
        self.mConfigDic[key] = data.parameter
    end
end

function getValue(self, cusTid, defVal)
    local val = self.mConfigDic[cusTid]
    if val==nil then
        return defVal
    end
    return val
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
