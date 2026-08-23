local var_0_0 = g.core.model.User.serverPassActivityData
local var_0_1 = g.core.const.ConstMgr.ServerPassActivityConst
local ServerPassBuyLayer = class("ServerPassBuyLayer", require("app.fairyGUI.serverPassActivity.UI_ServerPassBuyLayer"), function()
	return fgui.GComponent:create({
		resName = "ServerPassBuyLayer",
		pkgPath = "ui/serverPassActivity/serverPassActivity",
		isFullScreen = true,
		pkgName = "serverPassActivity"
	}, ...)
end)

function ServerPassBuyLayer:ctor()
	self._needUpdateMain = false

	local var_2_0 = {
		resId = g.core.config.knight_info.get(600030).res_id
	}

	var_2_0.isShowBg = true
	var_2_0.isAlphaNode = true

	local var_2_1 = require("app.view.common.DrawKnight").new(var_2_0)

	var_2_1:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-150, -10, 390, 100), 300)
	self.m_knightHoldNode:addChild(var_2_1)
end

function ServerPassBuyLayer:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, self._onS2CRechargeOpRecharge, self)
end

function ServerPassBuyLayer:onLoad()
	self:_addCustomListener()
	self:updateView()
end

function ServerPassBuyLayer:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SERVER_PASS_BUY_LAYER_POP, false, {
		needRefresh = self._needUpdateMain
	})
end

function ServerPassBuyLayer:updateView()
	for iter_6_0 = var_0_1.PAY_TYPE.PAY_TYPE_NORMAL, var_0_1.PAY_TYPE.PAY_TYPE_ADVANCE do
		self[g.core.common.GlobalFunc.contactParamByString("m_", "passItem", iter_6_0)]:updateRechargeItem(var_0_0:getPayInfo(iter_6_0), iter_6_0)
	end
end

function ServerPassBuyLayer:_onS2CRechargeOpRecharge(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3.server_pass then
		g.core.module.ModuleManager:awardSummary(arg_7_3.server_pass.awards, true, nil, g.core.lang:get(300001))
		self:updateView()

		self._needUpdateMain = true
	end
end

return ServerPassBuyLayer
