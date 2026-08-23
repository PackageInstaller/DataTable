local var_0_0 = g.core.model.User.shopData
local var_0_1 = g.core.const.ConstMgr.ShopConst
local var_0_2 = g.core.model.User.anniversaryData
local var_0_3 = g.core.const.ConstMgr.AnniversaryConst
local AnniversaryShopCell = class("AnniversaryShopCell", require("app.fairyGUI.anniversary.UI_AnniversaryShopCell"))

function AnniversaryShopCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
	self:addClickListener(handler(self, self._onBuyClick))
end

function AnniversaryShopCell:updateShopItem(arg_2_1, arg_2_2)
	self._info = arg_2_1

	self.m_bg:setURL(var_0_2:getActivityResource("ui_cocos", "pic_xmhy_shopkuang.png"))
	self.m_zhezhao:setURL(var_0_2:getActivityResource("ui_cocos", "pic_xmhy_shopkuang_zhezhao.png"))
	self.m_nameText:setColor(var_0_3.hexToRgb(var_0_2:getAnniversaryInfo().shop_item_color))
	self.m_costNumText:setColor(var_0_3.hexToRgb(var_0_2:getAnniversaryInfo().shop_item_color))
	self.m_lockText:setColor(var_0_3.hexToRgb(var_0_2:getAnniversaryInfo().shop_item_color))

	local var_2_0 = g.core.common.Goods:convert({
		type = arg_2_1.type,
		value = arg_2_1.value
	})

	self.m_nameText:setText(var_2_0.name)
	self.m_itemIcon:setURL(var_2_0.icon)
	self.m_qualityIcon:setURL("ui://base_new/pic_xmhy_shoppinzhi" .. var_2_0.quality + 1)
	self.m_numText:setText(arg_2_1.size)
	self.m_limitDescText:setText(self:getLimitType(arg_2_1))

	local var_2_1 = g.core.common.Goods:convert({
		type = arg_2_1.price_type_1,
		value = arg_2_1.price_value_1,
		size = arg_2_1.price_size_1
	})

	self.m_costIcon:setURL(var_2_1.icon_mini)

	local var_2_2 = g.core.model.User.bagData:getOwnNum(arg_2_1.price_type_1, arg_2_1.price_value_1)

	if var_2_2 >= arg_2_1.price_size_1 then
		self.m_isEnouchController:setSelectedIndex(0)
		self.m_costNumText:setColor(var_0_3.hexToRgb(var_0_2:getAnniversaryInfo().shop_item_color))
	else
		self.m_isEnouchController:setSelectedIndex(1)
		self.m_costNumText:setColor(var_0_3.hexToRgb(var_0_2:getAnniversaryInfo().shop_not_enough))
	end

	self.m_isEnouchController:setSelectedIndex(var_2_2 >= arg_2_1.price_size_1 and 0 or 1)
	self.m_costNumText:setText(var_2_1.size)

	if var_0_2:getCurScore() >= arg_2_2.openScoreNum then
		local var_2_3 = var_0_0:getBuyLimitLeft(arg_2_1)

		if var_2_3 then
			self.m_limitNumText:setText(var_2_3 .. "/" .. arg_2_1.buy_num)
			self.m_stateController:setSelectedIndex(var_2_3 <= 0 and 1 or 0)
		else
			self.m_stateController:setSelectedIndex(2)
		end
	else
		self.m_stateController:setSelectedIndex(3)
		self.m_lockText:setText(g.core.lang:get(431608, {
			targetNum = arg_2_2.openScoreNum
		}))
	end
end

function AnniversaryShopCell:getLimitType(arg_3_1)
	local var_3_0 = 107061

	if arg_3_1.num_ban_type == var_0_1.NUM_BAN_TYPE.LIFELONG then
		var_3_0 = 107063
	elseif arg_3_1.num_ban_type == var_0_1.NUM_BAN_TYPE.WEEK then
		var_3_0 = 107062
	elseif arg_3_1.num_ban_type == var_0_1.NUM_BAN_TYPE.MONTH then
		var_3_0 = 107064
	elseif arg_3_1.num_ban_type == var_0_1.NUM_BAN_TYPE.ANNIVERSARY then
		var_3_0 = 431502
	end

	return g.core.lang:get(var_3_0)
end

function AnniversaryShopCell:_onBuyClick(arg_4_1)
	if self.m_itemIcon:containPoint((arg_4_1:getInput():getTouch():getLocation())) then
		g.core.common.GlobalFunc.pushInfoPop((g.core.common.Goods:convert({
			type = self._info.type,
			value = self._info.value
		})))

		return
	end

	local var_4_0 = self.m_stateController:getSelectedIndex()

	if var_4_0 == 1 or var_4_0 == 3 then
		return
	end

	require("app.view.base.component.BaseBuyPop").createShop(self._info, false)
end

return AnniversaryShopCell
