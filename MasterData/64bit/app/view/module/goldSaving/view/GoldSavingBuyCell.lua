local var_0_0 = g.core.model.User.goldSavingData
local GoldSavingConst = require("app.view.module.goldSaving.const.GoldSavingConst")
local var_0_2 = g.core.common.Goods
local GoldSavingBuyCell = class("GoldSavingBuyCell", require("app.fairyGUI.goldSaving.UI_GoldSavingBuyCell"))

function GoldSavingBuyCell:ctor()
	self._canBuy = false
	self._thisGiftCfg = nil

	self.m_buyBtn:addClickListener(handler(self, self._onClickBuy))
	self.m_dataIcon:addClickListener(handler(self, self.onClickIcon))
end

function GoldSavingBuyCell:onClickIcon()
	g.core.common.GlobalFunc.pushInfoPop({
		type = 1,
		value = g.core.common.Goods.RESOURCE.GOLD_SAVING_SCORE
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_AccessWindow)
end

function GoldSavingBuyCell:updateGoldSavingCell(arg_3_1)
	self._thisGiftCfg = arg_3_1.giftCfg

	local var_3_0 = var_0_0:getGiftAwards(arg_3_1.giftCfg.id)

	for iter_3_0 = 1, 2 do
		self["m_itemIcon" .. iter_3_0]:setVisible(false)

		if var_3_0[iter_3_0] then
			self["m_itemIcon" .. iter_3_0]:updateItem(var_3_0[iter_3_0])
			self["m_itemIcon" .. iter_3_0]:setVisible(true)
		end
	end

	local var_3_1 = var_0_0:getGiftScore(arg_3_1.giftCfg.id)

	self.m_progress:setVisible(false)
	self.m_progress1:setVisible(false)
	self.m_needScoreTxt:setText(var_3_1)

	if arg_3_1.giftCfg.id == 1 then
		self._progressComp = self.m_progress1

		self._progressComp:setMax(var_3_1)
		self._progressComp:setValue(var_0_0:getProgress())
	else
		self._progressComp = self.m_progress

		self._progressComp:setMax(var_3_1 - var_0_0:getGiftScore(arg_3_1.giftCfg.id - 1))
		self._progressComp:setValue(var_0_0:getProgress() - var_0_0:getGiftScore(arg_3_1.giftCfg.id - 1))
	end

	self._progressComp:setVisible(true)
	self:_updateButton(arg_3_1.giftCfg)
end

function GoldSavingBuyCell:_onClickBuy()
	if not self._canBuy then
		if self._thisGiftCfg.id ~= var_0_0:getGiftId() then
			g.core.module.ModuleManager:tip(g.core.lang:get(407917))
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(407914))
		end

		return
	end

	local var_4_0 = var_0_0:getGiftCfg()

	if var_4_0.buy_type == GoldSavingConst.DIAMOND_TYPE then
		local var_4_1 = g.core.model.User:getFreeGold()
		local var_4_2

		if var_4_1 < var_4_0.diamond then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				value = 0,
				type = var_0_2.TYPE_GOLD,
				needSize = var_4_0.diamond - var_4_1
			})

			do return end

			var_4_2 = {}
		end

		var_4_2.gift_id = var_0_0:getGiftId()

		g.core.network.GameNetProxy:send_C2S_GoldSaving_Pay(var_4_2)
	elseif var_4_0.buy_type == GoldSavingConst.MONEY_TYPE then
		g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.GOLD_SAVING, var_4_0.price), var_0_0:getGiftId(), 0)
	elseif var_4_0.buy_type == GoldSavingConst.FREE_TYPE then
		g.core.network.GameNetProxy:send_C2S_GoldSaving_Pay({
			gift_id = var_0_0:getGiftId()
		})
	elseif var_4_0.buy_type == GoldSavingConst.RECHARGE_DIAMOND then
		local var_4_3

		if var_4_0.diamond > g.core.model.User:getGold() then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				value = 1,
				type = var_0_2.TYPE_GOLD
			})

			do return end

			var_4_3 = {}
		end

		var_4_3.gift_id = var_0_0:getGiftId()

		g.core.network.GameNetProxy:send_C2S_GoldSaving_Pay(var_4_3)
	end
end

function GoldSavingBuyCell:_updateButton(arg_5_1)
	if arg_5_1.buy_type == GoldSavingConst.DIAMOND_TYPE then
		self.m_buyBtn:setText(g.core.lang:get(406503, {
			price = arg_5_1.diamond
		}))
	elseif arg_5_1.buy_type == GoldSavingConst.MONEY_TYPE then
		local var_5_0 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.GOLD_SAVING, arg_5_1.price)

		if var_5_0 then
			self.m_buyBtn:setTitle(var_5_0.moneyUnit .. var_5_0.realMoney)
		else
			self.m_buyBtn:setTitle("")
		end
	elseif arg_5_1.buy_type == GoldSavingConst.FREE_TYPE then
		self.m_buyBtn:setTitle(g.core.lang:get(407913))
	elseif arg_5_1.buy_type == GoldSavingConst.RECHARGE_DIAMOND then
		self.m_buyBtn:setTitle(g.core.lang:get(407912, {
			price = arg_5_1.diamond
		}))
	end

	local var_5_1 = var_0_0:getGiftId()

	if var_5_1 == 0 then
		self.m_stateController:setSelectedIndex(2)
	elseif var_0_0:isCanBuyGift(arg_5_1.id) then
		self.m_stateController:setSelectedIndex(1)

		self._canBuy = true
	elseif var_5_1 > arg_5_1.id then
		self.m_stateController:setSelectedIndex(2)
	else
		if var_0_0:getProgress() >= var_0_0:getGiftScore(arg_5_1.id) then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(0)
		end

		self._canBuy = false
	end
end

return GoldSavingBuyCell
