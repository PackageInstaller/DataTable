--[[ 
-----------------------------------------------------
@filename       : ConvertController
@Description    : 兑换控制器
@date           : 2020-10-26 15:04:42
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.convert.controller.ConvertController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_CONVERT_VIEW, self.__onOpenConvertView, self)
    GameDispatcher:addEventListener(EventName.OPEN_CONVERT_TITANIUM_VIEW, self.__onOpenConvertView2, self)
    GameDispatcher:addEventListener(EventName.REQ_CONVERT_GOIN, self.__onReqConvertDo, self)
    GameDispatcher:addEventListener(EventName.REQ_CONVERT_TITANIUM, self.__onReqPayTitaniumConvert, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_TITANIUM_EXCHANGE_GOLD_COIN_INFO = self.__onConverInfoMsgHandler,
        --- *s2c* 货币兑换 12064
        SC_COIN_EXCHANGE_COIN = self.__onBuyTitumResHandler
    }
end

--- *s2c* 钛金石兑换金币信息 12055
function __onConverInfoMsgHandler(self, msg)
    convert.ConvertManager:parseConvertInfoMsg(msg)
end
--- *s2c* 货币兑换 12064
function __onBuyTitumResHandler(self, msg)
    if msg.result == 1 then
        convert.ConvertManager:updateBuyTitum()
    end
end


--- *c2s* 确定钛金石兑换金币 12056
function __onReqConvertDo(self, args)
    SOCKET_SEND(Protocol.CS_TITANIUM_EXCHANGE_GOLD_COIN_DO, { buy_times = args.buy_times })
end

--- *c2s* 货币兑换（货币A兑换成货币B） 12063
function __onReqPayTitaniumConvert(self, args)
    SOCKET_SEND(Protocol.CS_COIN_EXCHANGE_COIN, { coin_a_tid = args.aTid, coin_b_tid = args.bTid, exchange_num = args.num })
end


-- 打开金币兑换界面
function __onOpenConvertView(self, id)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CONVERT, true) == false then
        return
    end
    if self.mConvertView == nil then
        self.mConvertView = UI.new(convert.ConvertView)
        self.mConvertView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyConvertViewHandler, self)
    end
    self.mConvertView:open()
end
-- ui销毁
function onDestroyConvertViewHandler(self)
    self.mConvertView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyConvertViewHandler, self)
    self.mConvertView = nil
end


-- 打开钛金石兑换界面
function __onOpenConvertView2(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PURCHASE, true) == false then
        return
    end
    if self.mConvertView2 == nil then
        self.mConvertView2 = UI.new(convert.ConvertView2)
        self.mConvertView2:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyConvert2ViewHandler, self)
    end
    self.mConvertView2:open(args)
end
-- ui销毁
function onDestroyConvert2ViewHandler(self)
    self.mConvertView2:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyConvert2ViewHandler, self)
    self.mConvertView2 = nil
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]