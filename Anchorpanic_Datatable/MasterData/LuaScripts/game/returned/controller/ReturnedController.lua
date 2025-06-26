--[[ 
-----------------------------------------------------
@filename       : ReturnedController
@Description    : 常驻回归活动控制器
@date           : 2023-10-31 17:26:16
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.returned.controller.ReturnedController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_RETURNED_MAIN_PANEL, self.onOpenPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_RETURNED_SIGN_GAIN, self.onReqSignGainHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_REC_RETURNED_TASK_AWARD, self.onReqRecTaskHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_RETURNED_SHOP_BUY_PANEL, self.onOpenBuyPanel, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_RETURNED_INFO = self.onReturnedInfoHandler,
        SC_RETURNED_SIGN_PANEL_INFO = self.onReturnedSignInfoHandler,
        SC_RETURNED_TASK_PANEL = self.onReturnedTaskInfoHandler,
        SC_RETURNED_TASK_RECEIVE = self.onReturnedTaskReceiveHandler,
        SC_RETURNED_TASK_UPDATE = self.onReturnedTaskUpdateHandler,
    }
end

--- *s2c* 回归活动开启信息 24320
function onReturnedInfoHandler(self, msg)
    self.mMgr:parseReturnedInfoHandler(msg)
end
--- *s2c* 签到信息 24322
function onReturnedSignInfoHandler(self, msg)
    self.mMgr:parseReturnedSignInfoHandler(msg)
end
--- *s2c* 任务面板 24323
function onReturnedTaskInfoHandler(self, msg)
    self.mMgr:parseReturnedTaskInfoHandler(msg)
end
--- *s2c* 任务领取奖励 24325
function onReturnedTaskReceiveHandler(self, msg)
    if msg.result == 1 then
        self.mMgr:parseReturnedTaskReceiveHandler(msg)
    end
end
--- *s2c* 更新任务进度 24326
function onReturnedTaskUpdateHandler(self, msg)
    self.mMgr:parseReturnedTaskUpdateHandler(msg)
end

--- *c2s* 领取签到奖励 24321
function onReqSignGainHandler(self, args)
    SOCKET_SEND(Protocol.CS_GAIN_RETURNED_SIGN_REWARD, { day = args }, Protocol.SC_RETURNED_SIGN_PANEL_INFO)
end

--- *c2s* 任务领取奖励 24324
function onReqRecTaskHandler(self, args)
    SOCKET_SEND(Protocol.CS_RETURNED_TASK_RECEIVE, { task_id_list = { args.taskId } }, Protocol.SC_RETURNED_TASK_RECEIVE)
end

---------------------------UI界面----------------------

function onOpenPanel(self, args)
    if self.mReturnedMainPanel == nil then
        self.mReturnedMainPanel = UI.new(returned.ReturnedMainPanel)
        self.mReturnedMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    end
    self.mReturnedMainPanel:open(args)
end

-- ui销毁
function onDestroyPanelHandler(self)
    self.mReturnedMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    self.mReturnedMainPanel = nil
end

-- 购买界面
function onOpenBuyPanel(self, cusShopVo)
    if self.mBuyView == nil then
        self.mBuyView = UI.new(returned.ReturnedBuyMoneyView)
        self.mBuyView:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyShopBuyViewHandler, self)
    end
    self.mBuyView:open(cusShopVo)
end

-- ui销毁
function __onDestroyShopBuyViewHandler(self)
    self.mBuyView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mBuyView = nil
end


return _M