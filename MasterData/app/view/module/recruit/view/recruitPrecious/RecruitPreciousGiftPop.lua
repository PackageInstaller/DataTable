local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.giftData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.module.ModuleManager
local RecruitPreciousGiftPop = class("RecruitPreciousGiftPop", require("app.fairyGUI.recruitPrecious.UI_RecruitPreciousGiftPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitPreciousGiftPop",
		pkgPath = "ui/recruitPrecious/recruitPrecious",
		pkgName = "recruitPrecious"
	}, ...)
end)

function RecruitPreciousGiftPop:ctor(arg_2_1)
	self:showAtCenter()

	self._activityOpenCheckFunc = arg_2_1.openCheckFunc
	self._activityValue = arg_2_1.activityValue
	self._shopValue = arg_2_1.shopValue
	self._shopList = {}

	self.m_title:setText(arg_2_1.title)

	self._giftList = {}

	self.m_closeBtn:setClickCallBack(nil)
	self:_initUI()

	self._tabSelectIdx = 0
end

function RecruitPreciousGiftPop:_initUI()
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onRenderTabList))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onShopChange))
end

function RecruitPreciousGiftPop:_initTabList()
	self._shopList = {}

	for iter_4_0 = 1, g.core.config.shop_info.getLength() do
		local var_4_0 = g.core.config.shop_info.indexOf(iter_4_0)

		if var_4_0.tab_type ~= 0 and var_4_0.shop_type == var_0_0.SHOP_TYPE.GIFT and var_4_0.shop_first == self._shopValue then
			self._shopList[#self._shopList + 1] = var_4_0
		end
	end

	self.m_tabList:setNumItems(#self._shopList)
end

function RecruitPreciousGiftPop:_updateView()
	self:_initTabList()

	self._tabSelectIdx = nil

	self.m_tabList:setSelectedIndex(self._tabSelectIdx)
	self:_onShopChange()
end

function RecruitPreciousGiftPop:_onRenderGiftList(arg_6_1, arg_6_2)
	if self._giftList and self._giftList[arg_6_1 + 1] then
		arg_6_2:updateCell(self._giftList[arg_6_1 + 1])
	end
end

function RecruitPreciousGiftPop:_onRenderTabList(arg_7_1, arg_7_2)
	arg_7_2:setTitle(self._shopList[arg_7_1 + 1].name_1)
end

function RecruitPreciousGiftPop:_onShopChange(arg_8_1)
	local var_8_0 = self.m_tabList:getSelectedIndex()

	if var_8_0 == self._tabSelectIdx then
		return
	end

	self:_updateListCell()

	self._tabSelectIdx = var_8_0
end

function RecruitPreciousGiftPop:_updateListCell()
	self:_getAndSortGiftDataList()
	self.m_giftList:setNumItems(#self._giftList)
end

function RecruitPreciousGiftPop:_getAndSortGiftDataList()
	self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, self._shopValue, handler(self, self._filterActivityGift))

	if self._giftList == nil or #self._giftList < 1 then
		var_0_1:refreshInTime()

		self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, self._shopValue, handler(self, self._filterActivityGift))
	end

	table.sort(self._giftList, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.times - arg_11_0.buyTimes

		if (arg_11_0.times - arg_11_0.buyTimes) * (arg_11_1.times - arg_11_1.buyTimes) == 0 and var_11_0 ~= arg_11_1.times - arg_11_1.buyTimes then
			return var_11_0 > 0
		end

		return arg_11_0.recharge_money < arg_11_1.recharge_money
	end)
end

function RecruitPreciousGiftPop:_filterActivityGift(arg_12_1)
	return self._activityValue == arg_12_1.activity_id
end

function RecruitPreciousGiftPop:onLoad()
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateView()
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)
end

function RecruitPreciousGiftPop:onUnload()
	return
end

function RecruitPreciousGiftPop:_recvChargeInfo(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_4.gift and arg_15_4.gift.awards then
		var_0_3:awardSummary(arg_15_4.gift.awards)
		self.m_giftList:setNumItems(#self._giftList)
	end

	if not self:_isActivityOpen() then
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function RecruitPreciousGiftPop:_recvGetRecharge(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if self:_isActivityOpen() then
		self:_updateView()
	else
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function RecruitPreciousGiftPop:_onCrossDayUpdate()
	if not self:_isActivityOpen() then
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	self:_updateView()
end

function RecruitPreciousGiftPop:_isActivityOpen()
	if self._activityOpenCheckFunc then
		return self._activityOpenCheckFunc()
	end

	return false
end

return RecruitPreciousGiftPop
