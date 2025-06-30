--[[ 
    怪物数据管理器
    @author Jacob
]]
module('monster.MonsterManager', Class.impl(Manager))

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
    self.m_configDic = nil
    self.m_tidConfigDic = nil
end

-- 初始化怪物基础配置表
function parseConfigData(self)
    self.m_configDic = {}
    local baseData = RefMgr:getData("mon_base_data")
    for key, data in pairs(baseData) do
        local vo = monster.MonsterConfigVo.new()
        vo:parseData(key, data)
        self.m_configDic[vo.tid] = vo
    end
end

-- 初始化怪物tid配置表
function parseTidConfigData(self)
    self.m_tidConfigDic = {}
    local baseData = RefMgr:getData("mon_data")
    for uniqueTid, data in pairs(baseData) do
        local vo = monster.MonsterTidConfigVo.new()
        vo:parseData(uniqueTid, data)
        self.m_tidConfigDic[vo.uniqueTid] = vo
    end
end

-- 取怪物基础配置数据
function getMonsterVo(self, cusUniqueTid)
    if(not self.m_tidConfigDic)then
        self:parseTidConfigData()
    end
    return self.m_tidConfigDic[cusUniqueTid]
end

function getMonsterVo01(self, tid)
    if(not self.m_configDic)then
        self:parseConfigData()
    end
    return self.m_configDic[tid]
end

function getMonsterConfigVoByModel(self, model)
    if(not self.m_configDic)then
        self:parseConfigData()
    end
    for tid, configVo in pairs(self.m_configDic) do
        if(configVo.model == model)then
            return configVo
        end
    end
end

--根据mon_data中的uniqueTid获得mon_base_data中的 配置
function getMonsterVoByUniqueTid(self,uniqueTid)
    local m_dataHelper = self:getMonsterVo(uniqueTid)
    if m_dataHelper and m_dataHelper.tid then 
       return  self:getMonsterVo01(m_dataHelper.tid)
    end 
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
