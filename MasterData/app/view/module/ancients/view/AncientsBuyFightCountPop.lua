local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.common.Path
local AncientsBuyFightCountPop = class("AncientsBuyFightCountPop", require("app.fairyGUI.ancients.UI_AncientsBuyFightCountPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsBuyFightCountPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)

function AncientsBuyFightCountPop:ctor()
	self:getView():center(true)

	local var_2_0 = var_0_1:convert({
		type = var_0_1.TYPE_ITEM,
		value = var_0_1.ITEM.TYPE_ANCIENTS_PLAY_NUM
	})

	self.m_baseItem:setURL(var_2_0.bigIcon or var_2_0.icon)
	self.m_itemBg:setURL(var_0_2:getBaseBuyPopItemBg(var_2_0.quality))
	self.m_nameBg:setURL(var_0_2:getBaseBuyPopNameBg(var_2_0.quality or 0))
	self.m_nameTxt:setText(var_2_0.name)
	self.m_btn_ok:addClickListener(handler(self, self._onClickBtnOk))

	self._unitPrice = g.core.model.User.ancientsData:getParamById(35)
	self._count = 1

	self.m_subAddNumComp:initMinMaxNum({
		min = 1,
		cur = 1,
		max = g.core.model.User.ancientsData:getCanBuyFightTimes(),
		callback = handler(self, self._setCount),
		reachMaxAddTipGetFunc = handler(self, self._getReachMaxAddTip)
	})
end

function AncientsBuyFightCountPop:_setCount(arg_3_1)
	self._count = arg_3_1

	self:_updateBuyCount()
end

function AncientsBuyFightCountPop:_getReachMaxAddTip(arg_4_1)
	return g.core.lang:get(433323)
end

function AncientsBuyFightCountPop:onLoad()
	self:_updateView()
end

function AncientsBuyFightCountPop:_updateView()
	self.m_Txt_own:setText(g.core.model.User.ancientsData:getLeftFightTimes())
	self.m_priceCostComp:updateByTVS({
		value = 0,
		type = g.core.common.Goods.TYPE_GOLD,
		size = self._unitPrice
	})
	self.m_Txt_buy_desc:setText(g.core.model.User.ancientsData:getCanBuyFightTimes())
	self:_updateBuyCount()
end

function AncientsBuyFightCountPop:_updateBuyCount()
	self.m_resNumComp:updateByTVS({
		value = 0,
		type = g.core.common.Goods.TYPE_GOLD,
		size = self._unitPrice * self._count
	})
end

function AncientsBuyFightCountPop:_onClickBtnOk()
	local var_8_0

	if g.core.model.User.ancientsData:getCanBuyFightTimes() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433323))

		do return end

		var_8_0 = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_GOLD, 0)
	end

	if var_8_0 < self._unitPrice * self._count then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 0,
			type = g.core.common.Goods.TYPE_GOLD,
			size = var_8_0
		})

		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_BuyFightTimes({
		count = self._count
	})
	g.core.module.ModuleManager:popModule()
end

return AncientsBuyFightCountPop
