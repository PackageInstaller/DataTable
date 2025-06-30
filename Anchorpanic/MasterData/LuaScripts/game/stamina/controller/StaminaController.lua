--[[ 
    玩家体力控制器
    @author Jacob
]]
module("stamina.StaminaController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_ADD_STAMINA_PANEL, self.__onOpenAddStaminaPanelHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_BUY_STAMINA, self.onReqBuyStaminaHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 玩家体力信息 12014
        SC_PLAYER_STAMINA_INFO = self.onPlayerStaminaInfoHandler
    }
end

------------------------------------------------------------------------ 响应 ------------------------------------------------------------------------
---体力更新返回
function onPlayerStaminaInfoHandler(self, msg)
    stamina.StaminaManager:parseMsg(msg)
end

------------------------------------------------------------------------ 请求 ------------------------------------------------------------------------
---请求购买体力
function onReqBuyStaminaHandler(self)
    --- *c2s* 购买体力 12015
    SOCKET_SEND(Protocol.CS_BUY_STAMINA, {})
end

------------------------------------------------------------------------ 打开增加体力面板 ------------------------------------------------------------------------
function __onOpenAddStaminaPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_ADDSTAMINA, true) == false then
        return
    end
    if self.m_addStaminaPanel == nil then
        self.m_addStaminaPanel = stamina.AddStaminaPanel.new()
        self.m_addStaminaPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAddStaminaPanelHandler, self)
    end
    self.m_addStaminaPanel:open(args)

    -- local isByProps = args.isByProps
    -- local needCost = args.needCost
    -- local callFun = args.callFun
    -- local callObj = args.callObj
    -- self.m_addStaminaPanel:setData(isByProps, needCost, callFun, callObj)
end

function onDestroyAddStaminaPanelHandler(self)
    self.m_addStaminaPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAddStaminaPanelHandler, self)
    self.m_addStaminaPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
