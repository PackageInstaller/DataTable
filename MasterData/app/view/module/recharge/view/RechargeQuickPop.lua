local RechargeQuickPop = class("RechargeQuickPop", require("app.fairyGUI.recharge.UI_RechargeQuickPop"), function()
	return fgui.GComponent:create({
		resName = "RechargeQuickPop",
		pkgPath = "ui/recharge/recharge",
		pkgName = "recharge"
	})
end)
local var_0_1 = g.core.const.ConstMgr.ShopConst
local var_0_2 = g.core.const.ConstMgr.RechargeConst
local var_0_3 = g.core.model.User.rechargeData
local var_0_4 = g.core.common.Goods

function RechargeQuickPop:ctor(arg_2_1)
	self._type = arg_2_1.type
	self._needSize = arg_2_1.needSize
	self._func = arg_2_1.func
	self._funcParams = arg_2_1.funcParams
	self._addFree = arg_2_1.addFree

	self:showAtCenter()
	self:_initComp()
	self.m_confirmBtn:addClickListener(handler(self, self._onQuickBuy))
	self.m_otherBtn:addClickListener(handler(self, self._onShowOther))
	self.m_checkBtn:addClickListener(handler(self, self._onClickCheckBtn))
end

function RechargeQuickPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECV_ROLE_INFO, handler(self, self._onOpRecharge), self)
end

function RechargeQuickPop:_initComp(arg_4_1)
	self.m_needText:setText(g.core.lang:get(409605, {
		name = var_0_4:convert({
			value = 1,
			type = 999
		}).name,
		num = self._needSize
	}))

	local var_4_0 = g.core.model.User.rechargeData:getIdsByType(var_0_2.RECHARGE_TYPE.GOLD)
	local var_4_1 = {}

	self._info = nil

	local var_4_2
	local var_4_3
	local var_4_4 = true

	if var_4_0 then
		for iter_4_0 = 1, #var_4_0 do
			local var_4_5 = g.core.model.User.rechargeData:getRechargeInfoById(var_4_0[iter_4_0])

			if var_4_5 and var_4_5.seen == 1 then
				if self._type == 0 then
					if var_4_5.gold_gift_first >= self._needSize and not var_4_2 and var_4_4 then
						var_4_4 = false

						if not var_0_3:hasRecharge(var_4_5.id) or var_0_3:hasDoubleRechargeById(var_4_5.id) then
							var_4_2 = var_4_5
						end
					end

					if var_4_5.gold_gift + var_4_5.gold_recharge >= self._needSize and not var_4_3 then
						var_4_3 = var_4_5
					end
				elseif self._addFree then
					if var_4_5.gold_gift_first >= self._needSize and not var_4_2 and var_4_4 then
						var_4_4 = false

						if not var_0_3:hasRecharge(var_4_5.id) or var_0_3:hasDoubleRechargeById(var_4_5.id) then
							var_4_2 = var_4_5
						end
					end

					if var_4_5.gold_gift + var_4_5.gold_recharge >= self._needSize and not var_4_3 then
						var_4_3 = var_4_5
					end
				elseif var_4_5.gold_recharge >= self._needSize then
					var_4_2 = var_4_2 or var_4_5
				end

				table.insert(var_4_1, var_4_5)
			end
		end

		self._info = var_4_2 and var_4_2 or var_4_3 and var_4_3 or var_4_1[#var_4_1]
	end

	self.m_confirmBtn:setText(self._info.moneyUnit .. self._info.realMoney)

	if self._func then
		self.m_showAutoBuyController:setSelectedIndex(1)
	else
		self.m_showAutoBuyController:setSelectedIndex(0)
	end

	self._isAuto = self.m_checkBtn:isSelected()

	self.m_rechargeComp:updateCell(self._info)
end

function RechargeQuickPop:_onQuickBuy(arg_5_1)
	g.core.common.GlobalFunc.doRechargeById(self, self._info.id)
end

function RechargeQuickPop:_onShowOther(arg_6_1)
	g.core.module.ModuleManager:popAllPopup()

	local var_6_0 = g.core.module.ModuleManager:getFirstFullModule()

	if var_6_0 and var_6_0.module == g.view.entrance.RECHARGE then
		if var_6_0.display.gotoShopByType then
			var_6_0.display:gotoShopByType({
				tabType = 1,
				shopType = var_0_1.SHOP_TYPE.RECHARGE
			})
		end
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
			shopType = 19
		})
	end
end

function RechargeQuickPop:_onClickCheckBtn()
	self._isAuto = self.m_checkBtn:isSelected()
end

function RechargeQuickPop:_onOpRecharge()
	if not self._isClose then
		g.core.module.ModuleManager:popComponent()

		if self._func and self._isAuto then
			self._func(self._funcParams)
		end

		self._isClose = true
	end
end

return RechargeQuickPop
