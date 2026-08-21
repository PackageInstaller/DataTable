--[[--Lua 对象缓存池管理类
只针对lua对象！！！！
cls中可以实现以下方法，用于还原初始化和销毁
onAwake --对象唤醒时回调
onRecover --对象回收时回调
onDelete --对象删除时回调
]]
module("LuaPoolMgr", Class.impl())

function ctor(self)
    --缓存池记录对象
    self.m_pool = {}
    self.m_elapsedTime = 0
    self.m_recoverInterval = 150
    self.m_checkInterval = 180
end

function onDelete(self)
    self:clearAll()
end

--外部公共方法 *********************************************************

--[[@todo: 从缓存池中获取对象
@param: cls 获取对象类
@return: cls的实例对象
]]
function poolGet(self, cls)
    if cls == nil then
        Debug:log_warn("LuaPoolMgr", "poolGet cls is nil !!!")
        return
    end
    return self:_getClassObj(cls)
end

--[[@todo: 回收对象
@param: sourceObj 回收的对象
@param: cls 获取对象类
@return: void
]]
function poolRecover(self, sourceObj)
    if sourceObj == nil then
        Debug:log_error("LuaPoolMgr", "sourceObj is nil !!!")
        return
    end
    if sourceObj.__inLuaPool == true then
        Debug:log_error("LuaPoolMgr", "cls %s [%s] is already in lua pool !!!", tostring(sourceObj.class._NAME), sourceObj)
        return
    end
    sourceObj.__inLuaPool = true
    if sourceObj.onRecover then
        sourceObj:onRecover()
    end
    if sourceObj.class == nil then
        logError("回收的对象, 并不非通过class创建, 回收失败")
        -- Debug:log_warn("LuaPoolMgr", "cls is nil !!!")
        return
    end

    local bufferPool = self.m_pool[sourceObj.class]
    if bufferPool == nil then
        Debug:log_warn("LuaPoolMgr", "no cls [%s] in pool !!!!", tostring(sourceObj.class._NAME))
        return
    end

    --总记录
    local totalQuoteCount = bufferPool.totalQuoteCount - 1
    if totalQuoteCount <= 0 then
        totalQuoteCount = 0
        --没有引用
        bufferPool.noQuoteTime = os.time()
    else
        bufferPool.noQuoteTime = 0
    end

    bufferPool.totalQuoteCount = totalQuoteCount

    --放回原池对象
    table.insert(bufferPool.pool, sourceObj)
end

--[[@todo: 获取某个类在对象池的引用数量
@param: cls 获取对象类
@return: 引用数量，如果不存在该池则返回nil
]]
function getPoolQuoteCount(self, cls)
    local bufferPool = self.m_pool[cls]
    if bufferPool == nil then
        return nil
    end
    return bufferPool.totalQuoteCount
end


function setRecoverInterval(self, interval)
    self.m_recoverInterval = interval
end

function setCheckInterval(self, interval)
    self.m_checkInterval = interval
end


function poolInfos()
    for cls, bufferPool in pairs(self.m_pool) do
        if cls.__cname then
            Debug:log_info("LuaPoolMgr", "%s obj Quote count %d", cls.__cname, bufferPool.totalQuoteCount)
        end
    end
end
--[[@todo: 清空某个类池中的对象
@param: cls 要清空的对象类
]]
function clearClsPool(self, cls)
    if not cls then return end

    local bufferPool = self.m_pool[cls]
    if bufferPool then
        if not table.empty(bufferPool.pool) then
            for _, v in ipairs(bufferPool.pool) do
                self:_removePoolObj(v)
            end
        end
        self.m_pool[cls] = nil
    else
        Debug:log_warn("LuaPoolMgr", "cls [%s] no buffer in pool", cls.__cname)
    end
end
--[[@todo: 清空对象池
@return: void
]]
function clearAll(self)
    for _, bufferPool in pairs(self.m_pool) do
        for _, v in ipairs(bufferPool.pool) do
            self:_removePoolObj(v)
        end
    end
    self.m_pool = {}
end


function tick(self, deltaTime)
    self.m_elapsedTime = self.m_elapsedTime + deltaTime
    if self.m_elapsedTime > self.m_checkInterval then
        self.m_elapsedTime = 0
        self:_checkQuoteCls()
    end
end

--外部公共方法 END *********************************************************

--获取类对象
--@param cls 源类对象
function _getClassObj(self, cls)
    local sourceObj = nil

    local bufferPool = self.m_pool[cls]
    if bufferPool == nil then
        bufferPool = {}
        bufferPool.pool = {} --储存对象缓存池
        bufferPool.totalQuoteCount = 0 --总共引用的数量
        bufferPool.noQuoteTime = 0 --未引用时间，便于在未被引用的一段时间内统一GC
        self.m_pool[cls] = bufferPool
    end

    local len = #bufferPool.pool
    if len > 0 then
        --从池对象中取第一个并移除
        sourceObj = table.remove(bufferPool.pool)
    else
        sourceObj = cls.new()
    end

    --记录引用的数量
    bufferPool.totalQuoteCount = bufferPool.totalQuoteCount + 1

    if sourceObj.onAwake then
        sourceObj:onAwake()
    end
    sourceObj.__inLuaPool = false
    return sourceObj
end

--移除缓存池对象
--@param pool 池对象
function _removePoolObj(self, sourceObj)
    --销毁
    if sourceObj then
        Class.delete(sourceObj)
        -- if sourceObj.onDelete then
        -- 	sourceObj:onDelete()
        -- end
    end
end

--检查间隔时间
function _checkQuoteCls(self)
    local currTime = os.time()
    local sourceObj = nil
    local poolCnt = 0
    for cls, bufferPool in pairs(self.m_pool) do
        --没有被任何引用
        if bufferPool.totalQuoteCount <= 0 then
            --大于间隔时间，则销毁
            if (currTime - bufferPool.noQuoteTime) >= self.m_recoverInterval then
                --销毁
                poolCnt = #bufferPool.pool
                while (poolCnt > 0) do
                    sourceObj = table.remove(bufferPool.pool)
                    self:_removePoolObj(sourceObj)
                    poolCnt = poolCnt - 1
                end

                self.m_pool[cls] = nil
            end
        else
            --移除多余实例化对象
            poolCnt = #bufferPool.pool
            while (poolCnt > 60) do
                poolCnt = poolCnt - 1
                sourceObj = table.remove(bufferPool.pool)
                self:_removePoolObj(sourceObj)
            end
        end
    end
end

return _M