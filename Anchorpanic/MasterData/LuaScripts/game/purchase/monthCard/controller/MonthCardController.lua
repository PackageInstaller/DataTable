module("purchase.MonthCardController", Class.impl(Controller))

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
    -- 请求月卡面板信息
    GameDispatcher:addEventListener(EventName.REQ_MONTH_CARD_INFO, self.__onReqPanelInfoHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_STRENGTH_CARD_INFO,self.__onReqStrengthCardInfoHandler,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 月卡面板信息 24095
        SC_MONTH_CARD_PANEL = self.__onResMonthCardPanelInfoHandler,
        SC_STAMINA_MONTH_CARD_PANEL = self.__onResStaminaCardInfoHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 更新月卡面板信息
function __onResMonthCardPanelInfoHandler(self, msg)
    purchase.MonthCardManager:parsePanelInfoMsg(msg)
end
-- 更新体力月卡面板信息
function __onResStaminaCardInfoHandler(self,msg)
    purchase.MonthCardManager:parseStrengthInfoMsg(msg)
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求月卡面板信息
function __onReqPanelInfoHandler(self, args)
    --- *c2s* 月卡面板信息 24094
    SOCKET_SEND(Protocol.CS_MONTH_CARD_PANEL, {}, Protocol.SC_MONTH_CARD_PANEL)
end

-- 请求体力月卡面板信息
function __onReqStrengthCardInfoHandler(self,args)
    SOCKET_SEND(Protocol.CS_STAMINA_MONTH_CARD_PANEL, {}, Protocol.SC_STAMINA_MONTH_CARD_PANEL)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]