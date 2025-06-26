module("hero.HeroCuteManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__init()
end

function __init(self)
    self.mHeroCuteConfigDic = nil
end

-- 初始化英雄配置表
function parseConfigData(self)
    self.mHeroCuteConfigDic = {}
    local baseData = RefMgr:getData("hero_cute_model_data")
    for heroTid, data in pairs(baseData) do
        local vo = hero.HeroCuteConfigVo.new()
        vo:parseConfigData(heroTid, data)
        self.mHeroCuteConfigDic[vo.tid] = vo
    end
end

-- 根据英雄tid获取对应Q版配置数据
function getHeroCuteConfigVo(self, tid)
    if(not self.mHeroCuteConfigDic)then
        self:parseConfigData()
    end
    return self.mHeroCuteConfigDic[tid]
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
