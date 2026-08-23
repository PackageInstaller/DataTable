local var_0_0 = g.core.model.User.shopData
local var_0_1 = g.core.const.ConstMgr.ShopConst
local SuccubaLaunchItemCell = class("SuccubaLaunchItemCell", require("app.fairyGUI.succubaLaunch.UI_SuccubaLaunchItemCell"))

function SuccubaLaunchItemCell:ctor()
	self:addClickListener(handler(self, self._onBuyClick))
end

function SuccubaLaunchItemCell:_onBuyClick()
	if self.m_stateController:getSelectedIndex() == 1 then
		return
	end

	require("app.view.base.component.BaseBuyPop").createShop(self._info)
end

function SuccubaLaunchItemCell:updateSuccubaItem(arg_3_1, arg_3_2)
	self._info = arg_3_1

	local var_3_0 = g.core.common.Goods:convert({
		type = arg_3_1.type,
		value = arg_3_1.value
	})

	self.m_nameTxt:setText(var_3_0.name)
	self.m_itemIcon:setURL(var_3_0.icon)
	self.m_qualityIcon:setURL("ui://base_new/pic_nwsd_wupinpinzhi" .. var_3_0.quality + 1)
	self.m_numTxt:setText(arg_3_1.size)
	self.m_limitDesc:setText(self:getLimitType(arg_3_1))

	local var_3_1 = g.core.common.Goods:convert({
		type = arg_3_1.price_type_1,
		value = arg_3_1.price_value_1,
		size = arg_3_1.price_size_1
	})

	self.m_costIcon:setURL(var_3_1.icon_mini)
	self.m_isEnouchController:setSelectedIndex(g.core.model.User.bagData:getOwnNum(arg_3_1.price_type_1, arg_3_1.price_value_1) >= arg_3_1.price_size_1 and 0 or 1)
	self.m_costNumTxt:setText(var_3_1.size)

	if arg_3_2.isUnlock then
		local var_3_2 = var_0_0:getBuyLimitLeft(arg_3_1)

		if var_3_2 then
			self.m_limitNumTxt:setText(var_3_2 .. "/" .. arg_3_1.buy_num)
			self.m_stateController:setSelectedIndex(var_3_2 <= 0 and 1 or 0)
		else
			self.m_stateController:setSelectedIndex(2)
		end
	else
		self.m_stateController:setSelectedIndex(3)
		self.m_lockStr:setText(arg_3_2.banString)
	end
end

function SuccubaLaunchItemCell:getLimitType(arg_4_1)
	local var_4_0 = 107061

	if arg_4_1.num_ban_type == var_0_1.NUM_BAN_TYPE.LIFELONG then
		var_4_0 = 107063
	elseif arg_4_1.num_ban_type == var_0_1.NUM_BAN_TYPE.WEEK then
		var_4_0 = 107062
	elseif arg_4_1.num_ban_type == var_0_1.NUM_BAN_TYPE.MONTH then
		var_4_0 = 107064
	elseif arg_4_1.num_ban_type == var_0_1.NUM_BAN_TYPE.SUCCUBA_LAUNCH then
		var_4_0 = 431502
	end

	return g.core.lang:get(var_4_0)
end

return SuccubaLaunchItemCell
