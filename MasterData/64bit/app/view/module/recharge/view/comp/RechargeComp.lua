local var_0_0 = g.core.const.ConstMgr.RechargeConst
local var_0_1 = g.core.const.ConstMgr.ActivityConst
local var_0_2 = g.core.model.User.activityPermanentRechargeData
local RechargeComp = class("RechargeComp", require("app.fairyGUI.recharge.UI_RechargeComp"))

function RechargeComp:ctor()
	self._productList = nil
	self._lastScrollPos = 0

	self.m_goodsList:setVirtual()
	self.m_goodsList:doFairyBatching(false)
	self.m_goodsList:setItemRenderer(handler(self, self._onGoodsListRender))
	self.m_compBg:setURL("bg/shop/bg_hongse_0.jpg")
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmClick))
	self.m_confirmBtn2:addClickListener(handler(self, self._onConfirm2Click))
	self.m_loaderBtn:addClickListener(handler(self, self._onTipsClick))
	self.m_permanentRechargeBtn:addClickListener(handler(self, self._onGoRechargeClick))

	if not device.isWindowsDebug() then
		self.m_confirmBtn:setVisible(config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN)
		self.m_confirmBtn2:setVisible(config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN)
	end

	self.m_permanentRechargeBtn:setVisible((var_0_2:isShowEntrance()))
end

function RechargeComp:_onGoodsListRender(arg_2_1, arg_2_2)
	if self._productList and self._productList[arg_2_1 + 1] then
		arg_2_2:updateCell(self._productList[arg_2_1 + 1], true)
	end
end

function RechargeComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvChargeInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMFIRSTRECHARGEINFO, handler(self, self._recvChargeInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO, handler(self, self._recvChargeInfo), self)
	self.m_permanentRechargeBtn:updateProgress()
end

function RechargeComp:_onConfirmClick()
	g.core.platform.PlatformProxy:openWebView("https://events.gtarcade.com/common/index.html?cid=jzj&site_id=309&lang_id=16")
end

function RechargeComp:_onConfirm2Click()
	g.core.platform.PlatformProxy:openWebView("https://events.gtarcade.com/common/index.html?cid=jyf&site_id=309&lang_id=16")
end

function RechargeComp:_onTipsClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeCompTipsPop").new())
end

function RechargeComp:_recvChargeInfo()
	self._productList = self:_getList()

	self.m_goodsList:setNumItems(#self._productList)

	local var_7_0 = var_0_2:isShowEntrance() and g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PERMANENT_RECHARGE)

	self.m_permanentRechargeBtn:setVisible(var_7_0)

	if var_7_0 then
		self.m_permanentRechargeBtn:updateProgress()
	end
end

function RechargeComp:updateComp()
	self._productList = self:_getList()

	if not self._hasUpdate then
		self:newScheduleOnce(handler(self, self._updateGoodsList), 0.2)

		self._hasUpdate = true
	else
		self:_updateGoodsList()
	end
end

function RechargeComp:_updateGoodsList()
	self.m_goodsList:setNumItems(0)
	self.m_goodsList:setNumItems(#self._productList)
	self.m_goodsList:transitionShowCells("listCardAUiLeftIn", 0.03, 1)

	if self._lastScrollPos > 0 then
		self.m_goodsList:getScrollPane():setPosX(self._lastScrollPos)
	end
end

function RechargeComp:onUnload()
	self._lastScrollPos = self.m_goodsList:getScrollPane():getPosX()
end

function RechargeComp:_getList()
	local var_11_0 = g.core.model.User.rechargeData:getIdsByType(var_0_0.RECHARGE_TYPE.GOLD)
	local var_11_1 = {}

	if var_11_0 then
		for iter_11_0 = 1, #var_11_0 do
			local var_11_2 = g.core.model.User.rechargeData:getRechargeInfoById(var_11_0[iter_11_0])

			if var_11_2 and var_11_2.seen == 1 then
				table.insert(var_11_1, var_11_2)
			end
		end
	end

	return var_11_1
end

function RechargeComp:_onGoRechargeClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ACTIVITY, {
			activityValue = 0,
			activityType = var_0_1.ACTIVITY_TYPE.PERMANENT_RECHARGE
		})
	end
end

return RechargeComp
