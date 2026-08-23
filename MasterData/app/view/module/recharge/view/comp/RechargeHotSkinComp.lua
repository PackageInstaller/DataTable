local var_0_0 = g.core.model.User
local var_0_1 = g.core.const.ConstMgr.RechargeConst
local var_0_2 = g.core.const.ConstMgr.ShopConst
local RechargeHotSkinComp = class("RechargeHotSkinComp", require("app.fairyGUI.recharge.UI_RechargeHotSkinComp"))

function RechargeHotSkinComp:ctor()
	self._showSkin = var_0_0.hotSaleData:getShowHotSkinInfo()

	self.m_videoComp:addClickListener(handler(self, self._onShowVideo))
	self.m_gotoBtn:addClickListener(handler(self, self._onClickGoto))
end

function RechargeHotSkinComp:updateComp()
	if self._showSkin then
		self.m_picLoader:setURL("pic/hotSaleSkin/" .. self._showSkin.res .. ".png")

		if self._showSkin.movie ~= "0" then
			self.m_videoComp:setVisible(true)
			self.m_videoComp:setIcon("icon/hot_sale_skin_movie/" .. self._showSkin.pic .. ".png")
		else
			self.m_videoComp:setVisible(false)
		end

		local var_2_0 = self._showSkin.price_value

		if self._showSkin.price_type == var_0_1.SKIN_GOODS_SALE_VALUE.RECHARGE then
			self.m_scaleValueController:setSelectedIndex(0)

			local var_2_1 = var_0_0.rechargeData:getRechargeInfoByTypeAndPrice(self._showSkin.recharge_type, self._showSkin.recharge_money)

			var_2_0 = var_2_1.realMoney

			self.m_symbolTxt:setText(var_2_1.moneyUnit)
		else
			self.m_scaleValueController:setSelectedIndex(1)
			self.m_costIcon:setURL((g.core.common.Path:getIconByTypeValue(1, 51, true)))
		end

		self.m_priceTxt:setText(var_2_0)

		if self._showSkin.discount > 0 and self._showSkin.discount < 100 then
			self.m_isDiscountController:setSelectedIndex(1)
			self.m_oldPriceTitle:setTitle(math.ceil(var_2_0 / self._showSkin.discount * 100))
			self.m_discountTxt:setText(100 - self._showSkin.discount .. "%OFF")
		else
			self.m_isDiscountController:setSelectedIndex(0)
		end
	end
end

function RechargeHotSkinComp:_onShowVideo()
	if self._showSkin and self._showSkin.movie ~= "0" then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeHotSaleSkinMoviePop").new(self._showSkin.movie))
	end
end

function RechargeHotSkinComp:_onClickGoto()
	if self._showSkin then
		self:dispatchCompEvent(var_0_2.SHOP_EVENT_GO_TO, {
			tabType = var_0_2.SHOP_INFO_TAB_TYPE.SKIN_TAB_TYPE,
			shopType = var_0_2.SHOP_TYPE.RECHARGE_SKIN,
			shopValue = (self._showSkin.price_type == var_0_1.SKIN_GOODS_SALE_VALUE.FRAGMENT or nil) and var_0_2.RECHARGE_SKIN_VALUE.FRAGMENT
		})
	end
end

return RechargeHotSkinComp
