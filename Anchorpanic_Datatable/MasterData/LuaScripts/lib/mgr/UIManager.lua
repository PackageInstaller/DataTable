--[[ 
-----------------------------------------------------
@Description    : UI加载管理
@Author         : Jacob
-----------------------------------------------------
]]
module('lib.mgr.UIManager', Class.impl())

function new(cusPath)
    return require(cusPath).new()
end

return _M