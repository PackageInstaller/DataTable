--[[ 
-----------------------------------------------------
@filename       : MiniFactoryController
@Description    : 迷你工厂
@date           : 2022-2-28 
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('miniFac.MiniFactoryController', Class.impl(Controller))
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
    GameDispatcher:addEventListener(EventName.OPEN_MINIFAC_PANEL, self.onOpenMiniFactoryPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_WORK_SHOP_VIEW, self.onOpenMiniFactoryInfoViewHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_PRODUCE_LIST_PANEL, self.onOpenProduceView, self)
    GameDispatcher:addEventListener(EventName.OPEN_CONVERT_CAPACITY_VIEW, self.onOpenConvertView, self)

    GameDispatcher:addEventListener(EventName.REQ_FACTORY_INFO, self.onReqFactoryInfoHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_FACTORY_BUYSM, self.onReqFactoryBuySmHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_FACTORY_ORDER, self.onReqFactoryOrderHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_FACTORY_RECEIVE, self.onReciveHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_FACTORY_ALLRECEIVE, self.onRecAllHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_FACTORY_STOP, self.onReqFactoryStopHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
    }
end

---------------------------------------------------------响应--------------------------------------------------------------
--返回加工厂信息
function onFactoryInfoHandler(self, msg)
    local data = msg
    miniFac.MiniFactoryManager:updateFactoryInfo(data)
end

--购买产能结果
function onFactoryBuyHandler(self, msg)
    if msg.result == 1 then
        miniFac.MiniFactoryManager:updateFactoryBuyInfo(msg)
        gs.Message.Show(_TT(60526))
    else
        print("购买失败")
    end
end

--加工厂生产订单结果
function onFactoryOrdersHandler(self, msg)
    if msg.result == 1 then
        miniFac.MiniFactoryManager:updateFactoryOrdersInfo(msg)
    end
end

--加工厂领取订单返回
function onFactoryReceiveHandler(self, msg)
    if (msg.result == 1) then
        miniFac.MiniFactoryManager:updateFactoryReceiveInfo(msg)
    else
        print("领取失败")
    end
end

--加工厂一键领取订单返回
function onFactoryOneKeyReceiveHandler(self, msg)
    if msg.result == 0 then
        print("加工厂一键领取订单失败")
    else
        miniFac.MiniFactoryManager:updateFactoryOneKeyReceiveInfo(msg)
    end
end

--加工厂终止订单返回
function onFactoryStopHandler(self, msg)
    if msg.result == 1 then
        miniFac.MiniFactoryManager:updateFactoryStopInfo(msg)
    else
        print("中止失败")
    end
end

--加工厂订单完成
function onFactoryCompleteHandler(self, msg)
    miniFac.MiniFactoryManager:updateFactoryCompleteInfo(msg)
end

--产能更新
function onFactoryCapacityHandler(self, msg)
    miniFac.MiniFactoryManager:updateFactoryCapacityInfo(msg)
end

---------------------------------------------------------请求--------------------------------------------------------------

--请求加工厂信息
function onReqFactoryInfoHandler(self)
   -- SOCKET_SEND(Protocol.CS_FACTORY_INFO)
end

--请求加工厂购买产能值
function onReqFactoryBuySmHandler(self, args)
end

--请求加工厂生产订单
function onReqFactoryOrderHandler(self, args)
    
end

--请求加工厂终止订单
function onReqFactoryStopHandler(self, id)
  
end

--请求加工厂领取已完成的订单
function onReciveHandler(self, args)

end

--请求加工厂一键领取已完成的订单
function onRecAllHandler(self)

end

---------------------------------------------------------界面-------------------------------------------------------------
--打开工坊物品信息页面
function onOpenMiniFactoryInfoViewHandler(self, index)
    if self.mMiniFactoryInfoView == nil then
        self.mMiniFactoryInfoView = miniFac.MiniFactoryInfoView.new()
        self.mMiniFactoryInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiniFactoryInfoViewHandler, self)
    end
    self.mMiniFactoryInfoView:open(index)
end

function onDestroyMiniFactoryInfoViewHandler(self)
    self.mMiniFactoryInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiniFactoryInfoViewHandler, self)
    self.mMiniFactoryInfoView = nil
end

-- 打开迷你工厂界面
function onOpenMiniFactoryPanelHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MINIFACTORY, true) == false then
        return
    end
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MINIFACTORY)
    GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_INFO)
end

-- 打开生产列表界面
function onOpenProduceView(self)
    if self.mProduceView == nil then
        self.mProduceView = miniFac.MiniProduceView.new()
        self.mProduceView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyProduceViewHandler, self)
    end
    self.mProduceView:open()
end

-- ui销毁
function onDestroyProduceViewHandler(self)
    self.mProduceView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyProduceViewHandler, self)
    self.mProduceView = nil
end

-- 打开兑换界面
function onOpenConvertView(self)
    if self.mConvertView == nil then
        self.mConvertView = miniFac.MiniConvertView.new()
        self.mConvertView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyConvertViewHandler, self)
    end
    self.mConvertView:open()
end

-- ui销毁
function onDestroyConvertViewHandler(self)
    self.mConvertView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyConvertViewHandler, self)
    self.mConvertView = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]