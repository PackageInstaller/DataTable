module("lottery.LotteryController", Class.impl(Controller))
-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

-- 游戏开始的回调
function gameStartCallBack(self)

end

-- 模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.REQ_LOTTERY_SELECT, self.onReqLotterySelectHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_LOTTERY_NEXT, self.onReqLotteryNextHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_LOTTERY_RULE_PANEL, self.onOpenLotteryPanel, self)
end

function registerMsgHandler(self)
    return {
        SC_SCRATCH_CARD_PANEL = self.onLotteryPanelHandler,
        SC_SCRATCH_CARD = self.onLotteryResultHandler,
    }
end

function onLotteryPanelHandler(self,msg)
    lottery.LotteryManager:parseLotteryPanelData(msg)
end

function onLotteryResultHandler(self,msg)
    if msg.result == 1 then
        lottery.LotteryManager:parseLotteryResultData(msg)
    else
        gs.Message.Show("抽奖失败")
    end
end

function onReqLotterySelectHandler(self,args)
    SOCKET_SEND(Protocol.CS_SCRATCH_CARD,{pos = args.pos},Protocol.SC_SCRATCH_CARD_PANEL)
end



function onReqLotteryNextHandler(self,args)
    SOCKET_SEND(Protocol.CS_SCRATCH_CARD_NEXT_GRADE,{},Protocol.SC_SCRATCH_CARD_PANEL)
end


function onOpenLotteryPanel(self,args)
    if self.mLotteryPanel == nil then
        self.mLotteryPanel = lottery.LotteryRulePanel.new()
        self.mLotteryPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryLotteryPanel, self)
    end
    self.mLotteryPanel:open(args)
end

function onDestoryLotteryPanel(self)
    self.mLotteryPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryLotteryPanel, self)
    self.mLotteryPanel = nil
end

return _M
