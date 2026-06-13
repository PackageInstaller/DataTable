--关键节点管理器
local GameKeyNodeMgr = BaseClass("GameKeyNodeMgr", Singleton)
local M = GameKeyNodeMgr

function M:__init()
    self._allHandlers = {}
end

--记录
function M:Record(egameKeyNode, ...)
    if egameKeyNode == nil or type(egameKeyNode) ~= "number" then
        return
    end
    local arr = self._allHandlers[egameKeyNode]
    if arr == nil then
        return
    end
    for _, fun in ipairs(arr) do
        -- body
        if fun then
            fun(...)
        end
    end
end

--添加处理
function M:AddHandler(egameKeyNode, func)
    if egameKeyNode == nil or type(egameKeyNode) ~= "number" or func == nil then
        return
    end
    local arr = self._allHandlers[egameKeyNode]
    if arr == nil then
        arr = {}
        self._allHandlers[egameKeyNode] = arr
    end
    --已经添加
    if table.indexof(arr, func) then
        return
    end
    table.insert(arr, func)
end

--移除处理
function M:RemoveHandler(egameKeyNode, func)
    if egameKeyNode == nil or type(egameKeyNode) ~= "number" or func == nil then
        return
    end
    local arr = self._allHandlers[egameKeyNode]
    if arr == nil then
        return
    end
    table.removeValue(egameKeyNode, func)
end

function M:Cleanup()
    self._allHandlers = {}
end

function M:Dispose()

end

return GameKeyNodeMgr
