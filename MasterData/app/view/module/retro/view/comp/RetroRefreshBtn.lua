local var_0_0 = g.core.model.User.retroData
local var_0_1 = g.core.model.User.dayNotifyTool
local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.const.ConstMgr.RetroConst
local var_0_6 = g.core.common.Goods
local RetroRefreshBtn = class("RetroRefreshBtn", require("app.fairyGUI.retro.UI_RetroRefreshBtn"))

function RetroRefreshBtn:ctor()
	self.m_costComp:setLackColor(cc.c3b(244, 78, 78))
	self:addClickListener(handler(self, self.onClick))
end

function RetroRefreshBtn:updateBtn(arg_2_1)
	self._isOneKey = arg_2_1
	self._retroConfig = var_0_0:getRetroActivityCfg()

	if not self._isOneKey then
		self.m_isFreeController:setSelectedIndex(var_0_0:isFreeTime() and 1 or 0)
		self.m_freeTxt:setText(g.core.lang:get(430301, {
			cur = var_0_0:getRetroOpenBoxFreeTime(),
			max = self._retroConfig.refresh_free_times
		}))
		self.m_costComp:updateByTVS({
			showLack = true,
			type = self._retroConfig.refresh_type,
			value = self._retroConfig.refresh_value,
			size = self._retroConfig.refresh_size
		})
	else
		self.m_isFreeController:setSelectedIndex(0)

		self._oneKeyCost = var_0_0:getOneKeyCost()

		if self._oneKeyCost and next(self._oneKeyCost) then
			self.m_costComp:updateByTVS({
				showLack = true,
				type = self._oneKeyCost[1].type,
				value = self._oneKeyCost[1].value,
				size = self._oneKeyCost[1].size
			})
		end
	end
end

function RetroRefreshBtn:onClick()
	if self._isOneKey then
		local var_3_0 = var_0_4:getOwnNum(self._oneKeyCost[1].type, self._oneKeyCost[1].value)

		if var_3_0 < self._oneKeyCost[1].size then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._oneKeyCost[1].type,
				value = self._oneKeyCost[1].value,
				curSize = var_3_0,
				needSize = self._oneKeyCost[1].size - var_3_0
			})

			return
		end

		g.core.network.GameNetProxy:send_C2S_Retro_BoxAward({
			tp = 2
		})
	elseif var_0_0:isHaveSuperBoxNoAwards() and not var_0_1:isTodayHasRecord(DayNotifyToolConst.TYPE_RETRO_GIVEUP_SUPERBOX_TIP) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(430304),
			onConfirm = handler(self, self._onConfirmToRefresh),
			tip = {
				txt = g.core.lang:get(408110)
			},
			onCheck = function(arg_4_0)
				var_0_1:saveTodayRecord(DayNotifyToolConst.TYPE_RETRO_GIVEUP_SUPERBOX_TIP, arg_4_0)
			end
		})
	else
		self:_onConfirmToRefresh()
	end
end

function RetroRefreshBtn:_onConfirmToRefresh()
	if not var_0_0:isFreeTime() and g.core.model.User.bagData:getOwnNum(self._retroConfig.refresh_type, self._retroConfig.refresh_value) < self._retroConfig.refresh_size then
		if not var_0_0:isNotifyBuyCostTips() then
			self:showBuyCostItemPop()
		else
			self:_buyCostItem()
		end

		return
	end

	g.core.network.GameNetProxy:send_C2S_Retro_RefreshBox({})
end

function RetroRefreshBtn:showBuyCostItemPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(100039),
		desc = g.core.lang:get(108027, {
			itemNum = self._retroConfig.refresh_size,
			itemName = var_0_6:convert({
				type = self._retroConfig.refresh_type,
				value = self._retroConfig.refresh_value
			}).name,
			coinNum = var_0_3:getBuyPrice(var_0_5.BUY_PRICE_ID, var_0_3:getPlayBuyCount(var_0_5.BUY_PRICE_ID) + 1),
			coinName = var_0_6:convert({
				value = 0,
				type = 999
			}).name
		}),
		tip = {
			txt = g.core.lang:get(108045)
		},
		onCheck = function(arg_7_0)
			var_0_0:setNotifyBuyCostTips(arg_7_0)
		end,
		onConfirm = handler(self, self._buyCostItem)
	}), {
		touchDisappear = true
	})
end

function RetroRefreshBtn:_buyCostItem()
	local var_8_0 = var_0_3:getBuyPrice(var_0_5.BUY_PRICE_ID, var_0_3:getPlayBuyCount(var_0_5.BUY_PRICE_ID) + 1)
	local var_8_1 = g.core.model.User:getFreeGold()
	local var_8_2 = g.core.model.User:getGold()

	if var_8_1 < var_8_0 then
		if not var_0_0:isNotifyState() then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(111026),
				desc1 = g.core.lang:get(409601, {
					num = var_8_0 - var_8_1,
					name = var_0_6:convert({
						value = 1,
						type = var_0_6.TYPE_GOLD
					}).name
				}),
				tip = {
					txt = g.core.lang:get(108045),
					isChecked = var_0_0:isNotifyState()
				},
				onConfirm = handler(self, function()
					if var_8_1 + var_8_2 < var_8_0 then
						g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
							value = 1,
							addFree = true,
							type = var_0_6.TYPE_GOLD,
							needSize = var_8_0,
							curSize = var_8_1 + var_8_2
						})
					else
						g.core.network.GameNetProxy:send_C2S_Gold_Exchange({
							gold = var_8_0 - var_8_1
						})
					end
				end),
				onCheck = function(arg_10_0)
					var_0_0:setNotifyState(arg_10_0)
				end
			}))

			return
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._retroConfig.refresh_type,
				value = self._retroConfig.refresh_value,
				curSize = g.core.model.User.bagData:getOwnNum(self._retroConfig.refresh_type, self._retroConfig.refresh_value),
				needSize = self._retroConfig.refresh_size
			})

			return
		end
	end

	g.core.network.GameNetProxy:send_C2S_Shop_Shopping({
		cost_idx = 0,
		shop_id = 1,
		info = {
			id = var_0_5.REFRESH_COST_SHOP_ID,
			num = self._retroConfig.refresh_size
		}
	})
end

return RetroRefreshBtn
