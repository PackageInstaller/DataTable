
module("Storage", Class.impl())
--快速调用的处理封装类

function ctor(self)
    self.m_uniqueKey = nil
end

--设置唯一键
function setUniqueKey(self, key)
    self.m_uniqueKey = key
end

function _getUnique(self, key)
    if self.m_uniqueKey == nil then
        logError("uniqueKey is nil")
        return nil
    end
    return self.m_uniqueKey..key
    -- return key
end

--为玩家在key里保存一个number值
function saveNumber0(self, key, num)
    gs.StorageUtil.SaveFloat(key, num)
end

function saveNumber1(self, key, num)
    key = self:_getUnique(key)
    if key then
        gs.StorageUtil.SaveFloat(key, num)
    end
end

--为玩家在key里保存一个bool值
function saveBool0(self, key, value)
    gs.StorageUtil.SaveBool(key, value)
end
function saveBool1(self, key, value)
    key = self:_getUnique(key)
    if key then
        -- print("saveBool1", key, value)
        gs.StorageUtil.SaveBool(key, value)
    end
end

--为玩家在key里保存一个string值
function saveString0(self, key, str)
    gs.StorageUtil.SaveString(key, str)
end
function saveString1(self, key, str)
    key = self:_getUnique(key)
    if key then
        gs.StorageUtil.SaveString(key, str)
    end
end

--为玩家在key里保存一个tabele值
function saveTable0(self, key, tVal)
    local jsonStr = JsonUtil.encode0(tVal)
    if jsonStr then
        gs.StorageUtil.SaveString(key, jsonStr)
    end
end
function saveTable1(self, key, tVal)
    key = self:_getUnique(key)
    if key then
        self:saveTable0(key, tVal)
    end
end

--为玩家获取key对应的number值
function getNumber0(self, key)
    return gs.StorageUtil.GetFloat(key)
end
function getNumber1(self, key)
    key = self:_getUnique(key)
    if key then
        return gs.StorageUtil.GetFloat(key)
    end
end

--为玩家获取key对应的bool值
function getBool0(self, key)
    return gs.StorageUtil.GetBool(key)
end
function getBool1(self, key)
    key = self:_getUnique(key)
    if key then
        -- print("getBool1", key, gs.StorageUtil.GetBool(key))
        return gs.StorageUtil.GetBool(key)
    end
end

--为玩家获取key对应的string值
function getString0(self, key)
    return gs.StorageUtil.GetString(key)
end
function getString1(self, key)
    key = self:_getUnique(key)
    if key then
        return gs.StorageUtil.GetString(key)
    end
end

--为玩家获取key对应的table值, json转table失败时返回nil
function getTable0(self, key)
    local jsonStr = gs.StorageUtil.GetString(key)
    return JsonUtil.decode0(jsonStr)
end

function getTable1(self, key)
    key = self:_getUnique(key)
    if key then
        return self:getTable0(key)
    end
end

--  查询一个key是否存在
function hasKey0(self, key)
    return gs.StorageUtil.HasKey(key)
end
function hasKey1(self, key)
    key = self:_getUnique(key)
    if key then
        return gs.StorageUtil.HasKey(key)
    end
end

--  删除一个key
function deleteKey0(self, key)
    gs.StorageUtil.DeleteKey(key)
end
function deleteKey1(self, key)
    key = self:_getUnique(key)
    if key then
        gs.StorageUtil.DeleteKey(key)
    end
end

-- 非管理人员,不建议使用此方法
function deleteAll(self)
    gs.StorageUtil.DeleteAll()
end

return _M
