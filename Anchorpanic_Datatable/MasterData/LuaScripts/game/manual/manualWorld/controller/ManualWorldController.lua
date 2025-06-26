--[[ 
-----------------------------------------------------
@filename       : ManualWorldController
@Description    : 世界观控制器
@date           : 2023-3-17 14:53:00
@Author         : Shuai 
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualWorldController", Class.impl(manual.ManualController))

--模块间事件监听
function listNotification(self)
end
function registerMsgHandler(self)
    return {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]