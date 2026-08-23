local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.giftData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.module.ModuleManager
local BountyGiftPop = class("BountyGiftPop", require("app.fairyGUI.bounty.UI_BountyGiftPop"), function()
	return fgui.GComponent:create({
		resName = "BountyGiftPop",
		pkgPath = "ui/bounty/bounty",
		pkgName = "bounty"
	}, ...)
end)

function BountyGiftPop:ctor(arg_2_1)
	self:showAtCenter()

	self._activityOpenCheckFunc = arg_2_1.openCheckFunc
	self._activityValue = arg_2_1.activityValue
	self._shopValue = arg_2_1.shopValue

	self.m_title:setText(arg_2_1.title)

	self._giftList = {}

	self.m_closeBtn:setClickCallBack(nil)
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
end

function BountyGiftPop:_updateView()
	self:_getAndSortGiftDataList()
	self.m_giftList:setNumItems(#self._giftList)
end

function BountyGiftPop:_getAndSortGiftDataList()
	self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, self._shopValue, handler(self, self._filterActivityGift)) or {}

	if self._giftList == nil or #self._giftList < 1 then
		self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, self._shopValue, handler(self, self._filterActivityGift))
	end

	table.sort(self._giftList, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.times - arg_5_0.buyTimes

		if (arg_5_0.times - arg_5_0.buyTimes) * (arg_5_1.times - arg_5_1.buyTimes) == 0 then
			if var_5_0 ~= arg_5_1.times - arg_5_1.buyTimes then
				return var_5_0 ~= 0
			elseif arg_5_0.times * arg_5_1.times == 0 then
				return arg_5_0.times == 0
			end
		end

		return arg_5_0.recharge_money < arg_5_1.recharge_money
	end)
end

function BountyGiftPop:_filterActivityGift(arg_6_1)
	return self._activityValue == arg_6_1.activity_id
end

function BountyGiftPop:_onRenderGiftList(arg_7_1, arg_7_2)
	if self._giftList and self._giftList[arg_7_1 + 1] then
		arg_7_2:updateCell(self._giftList[arg_7_1 + 1])
	end
end

function BountyGiftPop:onLoad()
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self:_updateView()
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)
end

function BountyGiftPop:onUnload()
	return
end

function BountyGiftPop:_recvChargeInfo(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_4.gift and arg_10_4.gift.awards then
		var_0_3:awardSummary(arg_10_4.gift.awards)
		self.m_giftList:setNumItems(#self._giftList)
	end

	if not self:_isActivityOpen() then
		var_0_3:tip(g.core.lang:get(1005))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function BountyGiftPop:_recvGetRecharge(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if self:_isActivityOpen() then
		self:_updateView()
	else
		var_0_3:tip(g.core.lang:get(1005))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function BountyGiftPop:_onCrossDayUpdate()
	if not self:_isActivityOpen() then
		var_0_3:tip(g.core.lang:get(1005))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	self:_updateView()
end

function BountyGiftPop:_isActivityOpen()
	return g.core.model.User.bountyData:isActivityInOpenTime()
end

return BountyGiftPop
