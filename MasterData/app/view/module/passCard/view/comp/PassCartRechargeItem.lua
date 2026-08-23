local PassCardConst = require("app.view.module.passCard.const.PassCardConst")
local PassCartRechargeItem = class("PassCartRechargeItem", require("app.fairyGUI.passCard.UI_PassCartRechargeItem"))

PassCartRechargeItem.specialType = 1
PassCartRechargeItem.specialValue = 2010

function PassCartRechargeItem:ctor()
	self._bigRewards = nil

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRenderer))
	self.m_rechargeBtn:addClickListener(handler(self, self._onRechargeClick))
	self.m_itemLoader2:addClickListener(handler(self, self._onClickBigRewards))
end

function PassCartRechargeItem:_onRechargeClick()
	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, g.core.model.User.passCardData:getCurPassCardId(), self._cardData.cfg.type)
end

function PassCartRechargeItem:onLoad()
	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function PassCartRechargeItem:onInitData(arg_4_1)
	self._index = arg_4_1

	self:updateView()
end

function PassCartRechargeItem:_onRewardItemRenderer(arg_5_1, arg_5_2)
	self._rewardItems[arg_5_1 + 1].scaleIndex = 3

	arg_5_2:updateIcon(self._rewardItems[arg_5_1 + 1])
end

function PassCartRechargeItem:updateView()
	local var_6_0, var_6_1 = g.core.model.User.passCardData:getCardInfoByIndex(self._index)

	self._cardData = var_6_0

	local var_6_2 = var_6_0.cfg.show_type
	local var_6_3 = var_6_0.cfg.show_value
	local var_6_4 = var_6_0.cfg.show_type_2
	local var_6_5 = var_6_0.cfg.show_value_2
	local var_6_6 = {}

	if self._index == 1 then
		local var_6_7 = clone(g.core.model.User.passCardData:getRewardPoolDataByType(PassCardConst.RewardType.SENIOR))

		for iter_6_0 = 1, #var_6_7 do
			if var_6_7[iter_6_0].type == var_6_2 and var_6_7[iter_6_0].value == var_6_3 then
				table.remove(var_6_7, iter_6_0)

				break
			end
		end

		var_6_6 = var_6_7
	else
		local var_6_8 = clone(var_6_0.rewards)

		if var_6_0.cfg.type ~= PassCardConst.RechargeIdType.SENIOR_SUPER then
			for iter_6_1 = 1, #var_6_8 do
				if var_6_8[iter_6_1].type == var_6_2 and var_6_8[iter_6_1].value == var_6_3 then
					table.remove(var_6_8, iter_6_1)

					break
				end
			end
		end

		for iter_6_2 = 1, #var_6_8 do
			if var_6_8[iter_6_2].type == PassCartRechargeItem.specialType and var_6_8[iter_6_2].value == PassCartRechargeItem.specialValue then
				table.remove(var_6_8, iter_6_2)

				break
			end
		end

		var_6_6 = var_6_8

		self.m_passCardTextTip:getChild("desc"):setText(var_6_0.cfg.des)
		self.m_showImage:setURL("icon/" .. var_6_0.cfg.icon)
	end

	self._isRecharge = var_6_1
	self._rewardItems = var_6_6
	self._rechargeInfo = var_6_0.rechargeInfo

	self.m_rewardList:setNumItems(#self._rewardItems)
	self.m_stateController:setSelectedIndex(var_6_1 and 1 or 0)
	self.m_rechargeBtn:setTitle(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)

	local var_6_9 = g.core.common.Goods:convert({
		size = 1,
		type = var_6_2,
		value = var_6_3
	})

	self.m_showName1:setText(var_6_9.name)
	self.m_showIcon:updateIcon(var_6_9)
	self.m_discount:setText(var_6_0.cfg.discount .. "%")

	if var_6_4 > 0 then
		self:updateBigRewardIcon(var_6_4, var_6_5)
	end
end

function PassCartRechargeItem:updateBigRewardIcon(arg_7_1, arg_7_2)
	self._bigRewards = nil

	local var_7_0 = g.core.common.Goods:convert({
		size = 1,
		type = arg_7_1,
		value = arg_7_2
	})

	if var_7_0 then
		self._bigRewards = var_7_0

		self.m_itemLoader2:setURL(var_7_0.bigIcon)
		self.m_showName2:setText(var_7_0.name)
	end
end

function PassCartRechargeItem:_onClickBigRewards()
	if self._bigRewards then
		g.core.common.GlobalFunc.pushInfoPop(self._bigRewards)
	end
end

return PassCartRechargeItem
