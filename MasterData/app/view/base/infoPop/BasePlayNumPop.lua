local BasePlayNumPop = class("BasePlayNumPop", require("app.fairyGUI.infoPop.UI_BasePlayNumPop"), function()
	return fgui.GComponent:create({
		resName = "BasePlayNumPop",
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop"
	})
end)

BasePlayNumPop.SHOP_ID = {
	101,
	[25] = 104,
	[20] = 102,
	[16] = 103,
	[70] = 20
}

function BasePlayNumPop:ctor(arg_2_1)
	self:showAtCenter()

	self._info = arg_2_1
	self._useFinishFunc = nil
	self._useItemNumLeft = 0

	self.m_buyBtn:addClickListener(handler(self, self._onBuyClick))
	self.m_useBtn:addClickListener(handler(self, self._onUseClick))
	self:_initItem()
end

function BasePlayNumPop:_initItem()
	local var_3_0 = g.core.common.Goods:convert(self._info)
	local var_3_1 = g.core.model.User.bagData:getOwnNum(g.core.const.ConstMgr.BAG_TYPE.ITEM, self._info.value)
	local var_3_2 = g.core.config.item_info.get(self._info.value)
	local var_3_3 = g.core.config.shop_score_info.get(BasePlayNumPop.SHOP_ID[self._info.value])
	local var_3_4 = g.core.model.User.shopData:getBuyLimitLeft(var_3_3)
	local var_3_5 = g.core.model.User.shopData:getBuyLimit(var_3_3)
	local var_3_6 = 0
	local var_3_7 = ""

	if var_3_2.item_type ~= 11 then
		if var_3_2.item_value ~= 0 then
			local var_3_8 = g.core.common.Drops:getGoodsArray(var_3_2.item_value)

			var_3_6 = var_3_8[1].size
			var_3_7 = var_3_8[1].name
		end
	else
		var_3_6 = var_3_2.item_value
		var_3_7 = g.core.config.play_num_info.get(var_3_2.item_play_num).direction
	end

	if not self._info.nameRow then
		self._info.changeControllers = true
		self._info.nameRow = 2
	end

	local var_3_9 = g.core.lang:get(2053, {
		name = var_3_0.name
	})
	local var_3_10 = self.m_popPanel:getChild("leftTitle")

	if var_3_10 then
		var_3_10:setText(var_3_9)
	end

	self.m_baseIcon:updateIcon(self._info)

	if self._info.desc then
		self.m_desc:setText(self._info.desc)
	else
		self.m_desc:setText(var_3_7 .. "：" .. "+" .. tostring(var_3_6))
	end

	self.m_timesTxt:setText("")

	if var_3_4 then
		self.m_timesTxt:setText(g.core.lang:get(107031, {
			num = var_3_4,
			maxNum = var_3_5
		}))
	end

	if var_3_4 and var_3_4 == 0 then
		self.m_timesController:setSelectedIndex(1)
		self.m_buyBtn:setGrayed(true)
		self.m_overTxt:setText((g.core.lang:get(107032)))
	else
		self.m_timesController:setSelectedIndex(0)
		self.m_buyBtn:setTouchable(true)
		self.m_buyBtn:setGrayed(false)
	end

	self.m_numTxt:setText(g.core.lang:get(107041, {
		num = var_3_1
	}))

	self._useItemNumLeft = var_3_1
end

function BasePlayNumPop:_onBuyClick()
	if self.m_timesController:getSelectedIndex() == 0 then
		g.core.module.ModuleManager:popComponent()
	end

	require("app.view.base.component.BaseBuyPop").createPlayNum(g.core.config.shop_score_info.get(BasePlayNumPop.SHOP_ID[self._info.value]), false)
end

function BasePlayNumPop:_onUseClick()
	if self._useItemNumLeft < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(107034, {
			name = g.core.config.item_info.get(self._info.value).name
		}))

		return
	end

	local BaseUsePop = require("app.view.base.infoPop.BaseUsePop")

	g.core.module.ModuleManager:popComponent()
	BaseUsePop.createPlayNumItemUse(self._info.value, self._useFinishFunc)
end

function BasePlayNumPop:setUseFinishFunc(arg_6_1)
	self._useFinishFunc = arg_6_1
end

function BasePlayNumPop:create()
	local var_7_0 = BasePlayNumPop.new(self)

	g.core.module.ModuleManager:pushPopup(var_7_0, {
		touchDisappear = true
	})

	return var_7_0
end

function BasePlayNumPop:createPlayNum(arg_8_1)
	BasePlayNumPop.create({
		type = g.core.const.ConstMgr.BAG_TYPE.ITEM,
		value = self
	}):setUseFinishFunc(arg_8_1)
end

function BasePlayNumPop:isCanBuy()
	if g.core.model.User.shopData:checkBuyBan(self) then
		return false
	end

	local var_9_0 = g.core.model.User.shopData:getBuyLimitLeft(self)

	if var_9_0 and var_9_0 < 1 then
		return false
	end

	for iter_9_0 = 1, 2 do
		if self["price_type_" .. iter_9_0] > 0 and g.core.model.User.shopData:getBuyItemPrice(self, nil, iter_9_0) > g.core.model.User.bagData:getOwnNum(self["price_type_" .. iter_9_0], self["price_value_" .. iter_9_0]) then
			return false
		end
	end

	return true
end

function BasePlayNumPop:createBuy(arg_10_1)
	require("app.view.base.component.BaseBuyPop").createPlayNum(g.core.config.shop_score_info.get(self), false, arg_10_1)
end

return BasePlayNumPop
