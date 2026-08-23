local DiscountCouponPop = class("DiscountCouponPop", require("app.fairyGUI.discountCoupon.UI_DiscountCouponPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/discountCoupon/discountCoupon",
		resName = "DiscountCouponPop",
		pkgName = "discountCoupon"
	}, ...)
end)
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.config.expirable_item_info

function DiscountCouponPop:ctor(arg_2_1)
	self._data = arg_2_1

	self.m_tickList:setVirtual()
	self.m_tickList:setItemRenderer(handler(self, self._onTickList))
	self.m_tickList:setScrollEnabled(false)
	self.m_tickList:getScrollPane():setMouseWheelEnabled(false)
	self.m_tickList:doFairyBatching(false)
	self:showAtCenter()
	self:updateView(true)
end

function DiscountCouponPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_AWARD, handler(self, self._onRechargeAward), self)
end

function DiscountCouponPop:updateView(arg_4_1)
	self._tickList = {}

	for iter_4_0, iter_4_1 in ipairs((var_0_2:getList(var_0_3.BAG_TYPE.EXPIRABLE_ITEM))) do
		if var_0_4.get(iter_4_1.base_id).item_type == 1 then
			for iter_4_2 = 1, iter_4_1.num do
				local var_4_0 = {
					type = var_0_3.BAG_TYPE.EXPIRABLE_ITEM,
					value = iter_4_1.base_id,
					size = iter_4_1.num
				}

				var_4_0.time = iter_4_1.expire_time or 0
				var_4_0.onlyId = iter_4_1.id

				table.insert(self._tickList, var_4_0)
			end
		end
	end

	self.m_tickList:setNumItems(#self._tickList)

	self._viewIndex = 0

	for iter_4_3, iter_4_4 in ipairs(self._tickList) do
		if iter_4_4.onlyId == self._data.onlyId then
			self._viewIndex = iter_4_3

			break
		end
	end

	self:_refreshTick(arg_4_1)
end

function DiscountCouponPop:_refreshTick(arg_5_1)
	if arg_5_1 then
		self.m_tickList:scrollToView(self._viewIndex - 1)

		for iter_5_0, iter_5_1 in ipairs((self.m_tickList:getChildren())) do
			iter_5_1:playEff()
		end
	else
		self.m_tickList:scrollToView(self._viewIndex - 1, true)
	end
end

function DiscountCouponPop:_onTickList(arg_6_1, arg_6_2)
	arg_6_2:updateView(self._tickList[arg_6_1 + 1])
end

function DiscountCouponPop:_onRechargeAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(arg_7_1)
end

return DiscountCouponPop
