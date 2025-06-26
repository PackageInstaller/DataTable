
module("fashionPermit.FashionPermitController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_FASHIONPERMIT_PANEL,self.onOpenFashionPermitPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_FASHIONPERMIT_BUY_PANEL,self.onOpenFashionPermitBuyPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_FASHIONPERMIT_TASK_PANEL,self.onOpenFashionPermitTaskPanel,self)
    GameDispatcher:addEventListener(EventName.REQ_FASHION_PERMIT_BUY_LV,self.onReqFashionPermitByLv,self)
    GameDispatcher:addEventListener(EventName.REQ_GAIN_FASHION_PERMIT_REWARD,self.onReqGainFashionPermitReward,self)
    
    GameDispatcher:addEventListener(EventName.REQ_GAON_FASHION_PERMIT_REWARD_ALL,self.onReqGainAllFashionPermitReward,self)
    
    GameDispatcher:addEventListener(EventName.REQ_GAIN_FASHION_PERMIT_TASK,self.onReqFashionPermitTaskReceive,self)
   
    
    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_HIS_RED,self.onUpdateFashionHisRed,self)
    
    GameDispatcher:addEventListener(EventName.ACTIVITY_OPEN_UPDATE,self.onUpdateFashionHisRed,self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE,self.onUpdateFashionHisRed,self)
end

--模块间事件监听
function listNotification(self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_FASHION_PERMIT_PANEL = self.onFashionPemitInfoHandler,
        SC_BUY_FASHION_PERMIT_LV = self.onFashionPermitBuyLvHandler,
        SC_GAIN_FASHION_PERMIT_REWARD = self.onGainFashionPermitRewardHandler,
        SC_FASHION_PERMIT_TASK_RECEIVE = self.onFashionPermitTaskHandler,
        SC_FASHION_PERMIT_TASK_UPDATE = self.onUpdateFashionPermitHandler,
    }
end

function onFashionPemitInfoHandler(self,msg)
    fashionPermit.FashionPermitManager:setFashionPemitInfo(msg)
end

function onFashionPermitBuyLvHandler(self,msg)
    if msg.result == 1 then
        fashionPermit.FashionPermitManager:setBuyFashionPermitLv(msg)
    else
        gs.Message.Show("购买失败")
    end
end

function onGainFashionPermitRewardHandler(self,msg)
    if msg.result == 1 then
        fashionPermit.FashionPermitManager:setGainFashionPermitReward(msg)
    else
        gs.Message.Show("领取失败")
    end
end

function onFashionPermitTaskHandler(self,msg)
    if msg.result == 1 then
        fashionPermit.FashionPermitManager:updateFashionPermitTaskReceive(msg)
    else
        gs.Message.Show("领取失败")
    end
end

function onUpdateFashionPermitHandler(self,msg)
    fashionPermit.FashionPermitManager:updateFashionPermitTask(msg)
end

function onReqFashionPermitByLv(self,args)
    SOCKET_SEND(Protocol.CS_BUY_FASHION_PERMIT_LV, {buy_lv = args.buyLv},Protocol.SC_BUY_FASHION_PERMIT_LV)
end

function onReqGainFashionPermitReward(self,args)
    SOCKET_SEND(Protocol.CS_GAIN_FASHION_PERMIT_REWARD, {lv = args.lv,is_senior = args.isSenior},Protocol.SC_GAIN_FASHION_PERMIT_REWARD)
end

function onReqGainAllFashionPermitReward(self,args)
    SOCKET_SEND(Protocol.CS_GAIN_ALL_FASHION_PERMIT_REWARD,{},Protocol.SC_FASHION_PERMIT_PANEL)
end

function onReqFashionPermitTaskReceive(self,args)
    local list = {}
    if args.taskId == 0 then
        local taskList = fashionPermit.FashionPermitManager:getFashionPermitTaskData()
        for _, data in pairs(taskList) do
            if data.msgData.state == 0 then
                table.insert(list,data.msgData.id)
            end
        end
    else
        table.insert(list,args.taskId)
    end
    
    SOCKET_SEND(Protocol.CS_FASHION_PERMIT_TASK_RECEIVE,{task_id_list = list},Protocol.SC_FASHION_PERMIT_TASK_RECEIVE)
end

function onUpdateFashionHisRed(self)
    fashionPermit.FashionPermitManager:updateBubble()
end


function onOpenFashionPermitPanel(self,args)
    if self.mFashionPermitPanel == nil then
        self.mFashionPermitPanel = fashionPermit.FashionPermitPanel.new()
        self.mFashionPermitPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryFashionPermitHandler,self)
    end
    self.mFashionPermitPanel:open(args)
end

function onDestoryFashionPermitHandler(self)
    self.mFashionPermitPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryFashionPermitHandler,self)
    self.mFashionPermitPanel = nil
end


function onOpenFashionPermitBuyPanel(self,args)
    if self.mFashionPermitBuyPanel == nil then
        self.mFashionPermitBuyPanel = fashionPermit.FashionPermitBuyPanel.new()
        self.mFashionPermitBuyPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryFashionPermitBuyHandler,self)
    end
    self.mFashionPermitBuyPanel:open(args)
end

function onDestoryFashionPermitBuyHandler(self)
    self.mFashionPermitBuyPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryFashionPermitBuyHandler,self)
    self.mFashionPermitBuyPanel = nil
end

function onOpenFashionPermitTaskPanel(self,args)
    if self.mFashionPermitTaskPanel == nil then
        self.mFashionPermitTaskPanel = fashionPermit.FashionPermitTaskPanel.new()
        self.mFashionPermitTaskPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryFashionPermitTaskHandler,self)
    end
    self.mFashionPermitTaskPanel:open(args)
end

function onDestoryFashionPermitTaskHandler(self)
    self.mFashionPermitTaskPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryFashionPermitTaskHandler,self)
    self.mFashionPermitTaskPanel = nil
end

return _M