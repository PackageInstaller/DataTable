module('preFight.PreFightDupOldEquipController', Class.impl(preFight.BaseController))

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
    super.gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    super.listNotification(self)
end

--注册server发来的数据
function registerMsgHandler(self)
    local msgHandlerList = super.registerMsgHandler(self)
    return msgHandlerList
end

function getPanelClass(self)
    return preFight.PreFightDupOldEquipPanel
end

function getManager(self)
    return preFight.PreFightDupOldEquipManager
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
