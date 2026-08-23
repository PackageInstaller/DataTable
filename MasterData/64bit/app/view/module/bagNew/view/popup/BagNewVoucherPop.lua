local var_0_0 = g.core.config.voucher_info
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.common.Path
local BagNewVoucherPop = class("BagNewVoucherPop", require("app.fairyGUI.bagNew.UI_BagNewVoucherPop"), function()
	return fgui.GComponent:create({
		resName = "BagNewVoucherPop",
		pkgPath = "ui/bagNew/bagNew",
		pkgName = "bagNew"
	}, ...)
end)

function BagNewVoucherPop:ctor(arg_2_1)
	self._params = arg_2_1
	self._exchangeNum = 1
	self._callBack = arg_2_1.callback
	self._costInfo = nil

	self.m_subAddNumComp:initMinMaxNum({
		max = 1,
		min = 1,
		cur = 1,
		callback = handler(self, self._onSelectNumChanged)
	})
	self.m_sellBtn:addClickListener(handler(self, self._onSellBtnClicked))
	self:showAtCenter()
end

function BagNewVoucherPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_VOUCHER_SALE, self._onSellSucceed, self)
	self:_updateView()
end

function BagNewVoucherPop:onUnload()
	if self._callBack then
		self._callBack()
	end
end

function BagNewVoucherPop:_updateView()
	local var_5_0 = {
		type = tonumber(self._params.type),
		value = tonumber(self._params.value)
	}

	var_5_0.size = self._params.size or 1

	local var_5_1 = var_0_1:convert(var_5_0)

	self.m_baseItem:setURL(var_5_1.bigIcon or var_5_1.icon)
	self.m_itemBg:setURL(var_0_3:getBaseBuyPopItemBg(var_5_1.quality))
	self.m_nameTxt:setText(var_5_1.name)

	if self.m_nameTxt:getWidth() > 436 then
		self.m_nameTxt:setWidth(436)
		self.m_nameTxt:setAutoSize(3)
	end

	self.m_nameBg:setURL(var_0_3:getBaseBuyPopNameBg(var_5_1.quality or 0))

	local var_5_2 = var_0_2:getOwnNum(self._params.type, self._params.value)

	if var_5_2 == 0 then
		g.core.module.ModuleManager:popByDisplay(self)

		return
	end

	self.m_ownTxt:setText(g.core.lang:get(106005, {
		num = var_5_2
	}))
	self.m_subAddNumComp:setMaxNum(var_5_2)

	self._itemInfo = g.core.config.item_info.get(self._params.value)

	self:_updateRightUI()
	self.m_subAddNumComp:setCurNum(1)
end

function BagNewVoucherPop:_updateRightUI()
	local var_6_0 = var_0_0.match(function(arg_7_0)
		if arg_7_0.item_id == self._params.value then
			return true
		end

		return false
	end)
	local var_6_1 = {
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_VOUCHER_COIN_RESOURCE
	}

	var_6_1.size = g.core.model.User.resourceData:getResourceById(var_6_1.value)

	self.m_leftCostComp:updateByTVS(var_6_1)

	var_6_1.size = var_6_1.size + var_6_0[1].cost_value * self._exchangeNum

	self.m_rightCostComp:updateByTVS(var_6_1)

	var_6_1.size = var_6_0[1].cost_value * self._exchangeNum

	self.m_ownResComp:updateByTVS(var_6_1)

	self._costInfo = var_6_0[1]
end

function BagNewVoucherPop:_onSelectNumChanged(arg_8_1, arg_8_2)
	self._exchangeNum = arg_8_1

	self:_updateRightUI()
end

function BagNewVoucherPop:_onSellBtnClicked()
	if tonumber((g.core.platform.PlatformProxy:getGameId())) == self._costInfo.country_id then
		g.core.network.GameNetProxy:send_C2S_Voucher_Sale({
			item_id = self._params.value,
			item_num = self._exchangeNum
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(200528))
	end
end

function BagNewVoucherPop:_onSellSucceed()
	g.core.module.ModuleManager:tip(g.core.lang:get(200527))
	self:_updateView()
end

return BagNewVoucherPop
