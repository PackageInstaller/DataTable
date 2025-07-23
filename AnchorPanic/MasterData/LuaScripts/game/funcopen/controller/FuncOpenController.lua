--[[ 
-----------------------------------------------------
@filename       : FuncOpenController
@Description    : 功能开放控制器
@date           : 2020-10-19 15:10:24
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.funcopen.controller.FuncOpenController', Class.impl(Controller))

--构造
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
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
        SC_FUNCTION_OPEN_LIST = self.onFunctionOpenListHandler,
        SC_ADD_FUNCTION_OPEN = self.onAddFunctionOpenHandler,
    }
end

--- *s2c* 功能开启列表 12009
function onFunctionOpenListHandler(self, msg)
    funcopen.FuncOpenManager:onFunctionOpenListMsg(msg)
end

--- *s2c* 推送新功能开启 12010
function onAddFunctionOpenHandler(self, msg)
    funcopen.FuncOpenManager:onAddFunctionOpenMsg(msg)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
