module("purchase.GrowthFundController", Class.impl(Controller))

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
    -- 打开成长基金界面
    GameDispatcher:addEventListener(EventName.OPEN_GROWTH_FUND_PANEL, self.onOpenGrowthFundPanelHandler, self)
    -- 请求领取基金
    GameDispatcher:addEventListener(EventName.REQ_RECIVE_GROWTH_FUND, self.onReqGrowthFundHandler, self)
    -- 请求领取全部基金
    GameDispatcher:addEventListener(EventName.REQ_RECIVE_ALL_GROWTH_FUND, self.onReqGrowthFundAllHandler, self)
    --监听等级变化
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.onResGrowthFundBubbleHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 基金面板 24206
        SC_FUND_PANEL = self.onResGrowthFundInfoHandler,
        --- *s2c* 领取基金返回结果 24208
        SC_GAIN_FUND = self.onResGrowthFundHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 更新领取基金返回结果
function onResGrowthFundHandler(self, msg)
    purchase.GrowthFundManager:parseReciveGrowthFundMsg(msg)
end
-- 更新基金面板信息
function onResGrowthFundInfoHandler(self, msg)
    purchase.GrowthFundManager:parseGrowthFundInfoMsg(msg)
end
-- 更新红点
function onResGrowthFundBubbleHandler(self)
    purchase.GrowthFundManager:updateBublle()
end
---------------------------------------------------------------请求------------------------------------------------------------------
-- 领取基金 id 基金id type 类型
function onReqGrowthFundHandler(self, args)
    --- *c2s* 领取基金 24207
    SOCKET_SEND(Protocol.CS_GAIN_FUND, { fund_id = args.id, fund_type = args.type })
end

--- *c2s* 领取全部基金 24207
function onReqGrowthFundAllHandler(self)
    SOCKET_SEND(Protocol.CS_GAIN_ALL_FUND, {})
end

---------------------------------------------------------------界面创建------------------------------------------------------------------
function onOpenGrowthFundPanelHandler(self, args)
    if self.mGrowthFundPanel == nil then
        self.mGrowthFundPanel = purchase.GrowthFundPanel.new()
        self.mGrowthFundPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGrowthFundPanel, self)
    end
    self.mGrowthFundPanel:open(args)
end

function onDestroyGrowthFundPanel(self)
    self.mGrowthFundPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGrowthFundPanel, self)
    self.mGrowthFundPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]