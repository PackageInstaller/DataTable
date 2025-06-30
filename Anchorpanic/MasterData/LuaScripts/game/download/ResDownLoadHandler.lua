module("download.ResDownLoadHandler", Class.impl())

--构造函数
function ctor(self)
    CS.Lylibs.ResDownLoadHandler.LuaHandler = self
end

function onResStateHandler(...)
    local params = nil
    if select("#", ...) > 0 then
        params = { ... }
    end
    
    local updateState = params[1]
    local data = {}
    for i = 2, #params do
        table.insert(data, params[i])
    end
    download.ResDownLoadManager:setResState(updateState, data)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
