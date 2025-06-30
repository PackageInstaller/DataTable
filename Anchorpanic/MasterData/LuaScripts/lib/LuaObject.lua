--[[
****************************************************************************
Brief  :cs的派生类会继承该对象
Author :龙二
Date   :2019-6-13
Copyright (c) 2019 x游戏. All rights reserved
****************************************************************************
]]
module('core.base.LuaObject', Class.impl())

--销毁时，重写c#
function OnDestroy(self)
end

return _M