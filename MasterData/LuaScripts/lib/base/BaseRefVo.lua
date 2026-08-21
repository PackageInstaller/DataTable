--[[
****************************************************************************
Brief  :自定义的引用数据包装基类
Author :James Ou
Date   :2020-02-20
****************************************************************************
]]
local BaseRefVo = Class.class("BaseRefVo")

BaseRefVo.s_tablename = nil
BaseRefVo.s_tablekey = nil

function create(cls, refID)
    if not cls.s_tablename then return false end
    local refs = RefMgr:getData(cls.s_tablename)
    if refs then
        local ref = refs[refID]
        if ref then
            local dataRo = cls.new()
            dataRo:onParse(refID, ref)
            dataRo.s_isEmpty = false
            return dataRo
        else
            Debug:log_warn("BaseRefVo", "table[%s] no ID[%s] value",cls.s_tablename, refID)
        end
    end
end

--构造函数
function ctor(self, refID)
    -- print("s_tablename", refID)
    self.s_isEmpty = true
    if refID then
        self:load(refID)
    end
end

-- 解释引用的配置数据
function onParse(self, refID, refData)
    self.m_refID = refID
    -- print("s_tablekey", self.s_tablekey)
    if self.s_tablekey then
        for field, key in pairs(self.s_tablekey) do
            local valname = "m_"..key
            self[valname] = refData[field]
            -- print(valname, string.first2Upper(key))
            self["get"..string.first2Upper(key)] = function()
                return self[valname]
            end
        end
    end
end
-- 虽然为空 但统一实现方法 都返回nil
function _loadNilFunct(self)
    if self.s_tablekey then
        for field, key in pairs(self.s_tablekey) do
            -- print(valname, string.first2Upper(key))
            self["get"..string.first2Upper(key)] = function()
                return nil
            end
        end
    end
end
-- 通过引用ID 直接加载数据 (前提是s_tablename 和 s_tablekey 有配置)
function load(self, refID)
    -- print("s_tablename", self.s_tablename)
    if not self.s_tablename then return false end
    local refs = RefMgr:getData(self.s_tablename)
    if refs then
        local ref = refs[refID]
        if ref then
            self:onParse(refID, ref)
            self.s_isEmpty = false
        else
            self.s_isEmpty = true
            self:_loadNilFunct()
            Debug:log_warn("BaseRefVo", "table[%s] no ID[%s] value",self.s_tablename, refID)
        end
    end
end

-- 判断数据对象的内容是否为nil
function isEmpty(self)
    return self.s_isEmpty
end
-- 打印数据类内的字段信息
function printKV(self)
    for key,v in pairs(self) do
        print("printKV", key, v)
    end
end

return BaseRefVo
