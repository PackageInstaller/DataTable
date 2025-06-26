--[[****************************************************************************
Brief  :BuffRoMgr 数据对象的管理
Author :James Ou
Date   :2020-04-10
****************************************************************************
]]
module("Buff.BuffRoMgr", Class.impl())
-------------------------------
--[[ buff组字段 fid
23 麻痹 72-冰冻 4-眩晕 40-混乱 (目标无法使用技能和奥义)
26 封技(目标无法使用魂玉技能)
27 封印(目标无法释放奥义)
41 凝重(目标使用魂玉技能消耗增加固定值)
]]
-- 构造函数
function ctor(self)
    self.m_buffDic = nil
    self.m_buffEleDic = nil

    self:_parseBuffData()

    -- 删除元素反应
    -- self:_parseEleBuffData()
end

-- 初始化配置表
function _parseEleBuffData(self)
    self.m_buffEleDic = {}
    local baseData = RefMgr:getData('ele_reaction_data')
    for id, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(Buff.EleReactionDataRo)
        ro:parseData(id, data)
        local buffRefD = ro:getOldBuffId()
        if not self.m_buffEleDic[buffRefD] then
            self.m_buffEleDic[buffRefD] = {}
        end
        self.m_buffEleDic[buffRefD][ro:getAddBuffId()] = ro
    end
end

-- 初始化配置表
function _parseBuffData(self)
    self.m_buffDic = {}
    local baseData = RefMgr:getData('buff_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(Buff.BuffDataRo)
        ro:parseData(key, data)
        self.m_buffDic[key] = ro
    end
end

function buffRos(self)
    if self.m_buffDic == nil then
        self:_parseBuffData()
    end
    return self.m_buffDic
end

-- 取基础数据
function getBuffRo(self, buffRefD)
    local dic = self:buffRos()
    buffRefD = tonumber(buffRefD)
    if dic[buffRefD] == nil then
        Debug:log_error("BuffRoMgr", "不存在buffRefD:" .. buffRefD)
    end
    return dic[buffRefD]
end

function isEleBuffRo(self, buffRefD)
    -- 取消元素反应机制
    return false
    -- if self.m_buffEleDic == nil then
    --     self:_parseEleBuffData()
    -- end
    -- local dict = self.m_buffEleDic[buffRefD]
    -- if dict == nil then
    --     return false
    -- end
    -- return true
end

function getEleBuffRo(self, buffRefID1, buffRefID2)
    if self.m_buffEleDic == nil then
        self:_parseEleBuffData()
    end
    local dict = self.m_buffEleDic[buffRefID1]
    if dict == nil then
        Debug:log_error("BuffRoMgr", "不存在buffRefID1:" .. buffRefID1)
        return
    end
    local ro = dict[buffRefID2]
    if ro == nil then
        Debug:log_error("BuffRoMgr", buffRefID1 .. "不存在eleType1:" .. buffRefID2 .. " 的反应元素 ")
    end
    return ro
end

function tryGetEleBuffRo(self, buffRefID1, buffRefID2)
    if self.m_buffEleDic == nil then
        self:_parseEleBuffData()
    end
    local dict = self.m_buffEleDic[buffRefID1]
    if dict == nil then
        return
    end
    return dict[buffRefID2]
end

-- function createBuffRo(self, refID)
-- 	local ref = RefMgr:getRefData("buff_perform_data", refID)
-- 	if ref then
-- 		local ro = Buff.BuffPerformDataRo.new()
-- 		ro:parseData(refID, ref)
-- 		return ro
-- 	end
-- end

-- function createBuffOverRo(self, refID)
-- 	local ref = RefMgr:getRefData("buff_data",refID)
-- 	if ref then
-- 		local ro = Buff.BuffOverlyingRo.new()
-- 		ro:parseData(refID, ref)
-- 		return ro
-- 	end
-- end

return _M



--[[ 替换语言包自动生成，请勿修改！
]]