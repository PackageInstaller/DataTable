-- @FileName:   CiruitSceneController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-24 20:37:52
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ciruit.controller.CiruitSceneController', Class.impl(map.MapBaseController))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

return _M
