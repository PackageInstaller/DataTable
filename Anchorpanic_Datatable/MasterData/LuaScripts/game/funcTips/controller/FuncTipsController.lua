--[[ 
-----------------------------------------------------
@filename       : FuncTipsController
@Description    : 功能说明控制器
@date           : 2021-02-23 11:27:54
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.funcTips.controller.FuncTipsController', Class.impl(Controller))

--构造函数
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
    GameDispatcher:addEventListener(EventName.OPEN_FUNCTIPS_VIEW, self.onOpenFuncTips, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 打开界面
function onOpenFuncTips(self, args)
    if self.mFuncTipsView == nil then
        self.mFuncTipsView = UI.new(funcTips.FuncTipsView)
        self.mFuncTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.mFuncTipsView:open({ id = args.id })
end
-- ui销毁
function onDestroyViewHandler(self)
    self.mFuncTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mFuncTipsView = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
