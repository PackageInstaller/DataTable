local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.InfoConst.UseBuyPopType
local var_0_2 = 11
local var_0_3 = {
	DAY = 2,
	SEASON_102 = 102,
	SEASON_103 = 103,
	SEASON_101 = 101,
	LIFETIME = 1,
	WEEK = 3,
	NO = 0
}
local var_0_4 = {
	[var_0_3.LIFETIME] = {
		enough = 106017,
		lack = 106018
	},
	[var_0_3.DAY] = {
		enough = 106003,
		lack = 106004
	},
	[var_0_3.WEEK] = {
		enough = 106013,
		lack = 106014
	},
	[var_0_3.SEASON_101] = {
		enough = 106015,
		lack = 106016
	},
	[var_0_3.SEASON_102] = {
		enough = 106015,
		lack = 106016
	},
	[var_0_3.SEASON_103] = {
		enough = 106015,
		lack = 106016
	}
}
local var_0_5 = g.core.config.shop_score_info
local var_0_6 = g.core.config.play_num_info
local var_0_7 = g.core.common.Path
local var_0_8 = g.core.event.EventManager
local var_0_9 = g.core.common.Goods
local var_0_10 = g.core.network.GameNetProxy
local var_0_11 = g.core.common.Drops
local var_0_12 = g.core.model.User.shopData
local var_0_13 = g.core.model.User.bagData
local BaseUseBuyPop = class("BaseUseBuyPop", require("app.fairyGUI.infoPop.UI_BaseUseBuyPop"), function()
	return fgui.GComponent:create({
		resName = "BaseUseBuyPop",
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop"
	})
end)

function BaseUseBuyPop:ctor(arg_2_1)
	self._hasPop = false
	self._useBuyGoodsInf = var_0_9:convert(arg_2_1)

	if self._useBuyGoodsInf.size > 0 then
		self._type = var_0_1.USE or var_0_1.BUY_USE
	end

	self._convertName, self._convertRate = self:_getConvertNameRate(self._useBuyGoodsInf.info)
	self._shopScoreInf = var_0_5.get(arg_2_1.shopId)
	self._limitLeft = var_0_12:getBuyLimitLeft(self._shopScoreInf)
	self._maxBuyNum = self:_getBuyMaxNum(self._shopScoreInf)

	self:_initView()
	self:_addUIEventListeners()
end

function BaseUseBuyPop:onLoad()
	var_0_8:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onRcvShopping, self, 1)
	var_0_8:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, self._onRcvItemUse, self)
	var_0_8:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, self._updateMaxBuyNum, self)
end

function BaseUseBuyPop:_updateMaxBuyNum()
	self._maxBuyNum = self:_getBuyMaxNum(self._shopScoreInf)

	self.m_currencyComp:updateHaveNum()
	self.m_addNumComp:setMaxNum(self._maxBuyNum)
end

function BaseUseBuyPop:_onClickBtn()
	if self._type == var_0_1.USE then
		self:_onClickUseBtn()
	elseif self._type == var_0_1.BUY_USE then
		self:_onClickBuyUseBtn()
	end
end

function BaseUseBuyPop:_onClickUseBtn()
	local var_6_0 = self.m_addNumComp:getCurNum()

	if var_6_0 <= self._useBuyGoodsInf.size then
		var_0_10:send_C2S_Item_Use({
			id = self._useBuyGoodsInf.value,
			num = var_6_0
		})
	else
		g.core.module.ModuleManager:tip((g.core.lang:get(106009)))
	end
end

function BaseUseBuyPop:_onClickBuyUseBtn()
	local var_7_0 = self.m_addNumComp:getCurNum()
	local var_7_1 = var_0_12:getBuyItemPrice(self._shopScoreInf, var_7_0)
	local var_7_2 = var_0_13:getOwnNum(self._shopScoreInf.price_type_1, self._shopScoreInf.price_value_1)

	if var_7_2 < var_7_1 then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._shopScoreInf.price_type_1,
			value = self._shopScoreInf.price_value_1,
			size = var_7_2,
			needSize = var_7_1,
			curSize = var_7_2
		})
	elseif self:_isBuyLimit() and var_7_0 > self._maxBuyNum then
		g.core.module.ModuleManager:tip(g.core.lang:get(106008))
	else
		var_0_10:send_C2S_Shop_Shopping({
			cost_idx = 0,
			shop_id = 0,
			info = {
				id = self._shopScoreInf.id,
				num = var_7_0
			}
		})
	end
end

function BaseUseBuyPop:_onTabChanged()
	local var_8_0 = self.m_tabController:getSelectedIndex()

	if self._type == var_8_0 then
		return
	end

	self._type = var_8_0

	self.m_purchaseLimitTxt:setVisible((self:_isPurchaseLimitTxtShow()))
	self:_initAddNumComp()
end

function BaseUseBuyPop:_onRcvShopping(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = var_0_5.get(arg_9_3.info.id)

	if var_9_0.type == var_0_9.TYPE_ITEM then
		var_0_10:send_C2S_Item_Use({
			id = var_9_0.value,
			num = arg_9_3.info.num
		})
	end
end

function BaseUseBuyPop:_onRcvItemUse(arg_10_1, arg_10_2, arg_10_3)
	if self._useBuyGoodsInf.type == var_0_9.TYPE_ITEM and self._useBuyGoodsInf.value == var_0_9.ITEM.TYPE_STAMINA_PILL then
		g.core.module.ModuleManager:tip(g.core.lang:get(106012))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(106006))
	end

	if not self._hasPop then
		self._hasPop = true

		g.core.module.ModuleManager:popModule()
	end
end

function BaseUseBuyPop:_initView()
	self.m_placeComp:setSize(display.width, display.height)
	self.m_tabController:setSelectedIndex(self._type)
	self.m_purchaseLimitTxt:setVisible(self:_isPurchaseLimitTxtShow())

	local var_11_0 = self._useBuyGoodsInf
	local var_11_1 = self._useBuyGoodsInf.quality or var_0_0.QUALITY_TYPE.NONE

	self.m_buyItemNameTxt:setText(var_11_0.name)
	self.m_buyItemNameBg:setURL((var_0_7:getBaseBuyPopNameBg(var_11_1)))
	self.m_buyItemIcon:setURL(var_11_0.bigIcon)
	self.m_buyItemIconBg:setURL((var_0_7:getBaseBuyPopItemBg(var_11_1)))

	if var_11_0.type == var_0_9.TYPE_ITEM and var_11_0.value == var_0_9.ITEM.TYPE_STAMINA_PILL then
		self.m_isVitController:setSelectedIndex(1)
		self.m_vitResItemComp:updateResBtn({
			type = var_0_9.TYPE_RESOURCE,
			value = var_0_9.RESOURCE.TYPE_STAMINA
		})
	else
		self.m_isVitController:setSelectedIndex(0)
	end

	local var_11_2 = var_11_0.size

	if var_11_0.size > 0 then
		self.m_buyItemLeftNumTxt:setText(g.core.lang:get(106005, {
			num = var_11_2
		}))
	else
		self.m_buyItemLeftNumTxt:setText(g.core.lang:get(106001, {
			num = var_11_2
		}))
	end

	self.m_addTimesNameTxt:setText(self._convertName)

	if self:_isBuyLimit() then
		local var_11_3 = var_0_12:getBuyLimit(self._shopScoreInf) or 0
		local var_11_4 = var_0_4[self._shopScoreInf.num_ban_type]

		if var_0_4[self._shopScoreInf.num_ban_type] then
			self.m_purchaseLimitTxt:setText((g.core.lang:get((self._limitLeft > 0 or nil) and (var_11_4.enough or var_11_4.lack), {
				limitLeft = self._limitLeft,
				limit = var_11_3
			})))
		else
			self.m_purchaseLimitTxt:setText("")
		end
	end

	self:showAtCenter()

	local var_11_5 = cc.Director:getInstance():getSafeAreaRect()
	local var_11_6 = display.width

	if var_11_5.x > 0 then
		var_11_6 = var_11_6 - var_11_5.x * 2
	end

	self.m_placeComp:setSize(var_11_6, display.height)
	self:_initAddNumComp()
end

function BaseUseBuyPop:_addUIEventListeners()
	self.m_useBtn:addClickListener(handler(self, self._onClickBtn))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
end

function BaseUseBuyPop:_getConvertNameRate(arg_13_1)
	local var_13_0 = ""
	local var_13_1 = 0

	if arg_13_1.item_type == var_0_2 then
		var_13_0 = var_0_6.get(arg_13_1.item_play_num).direction
		var_13_1 = arg_13_1.item_value
	elseif arg_13_1.item_value == 0 then
		g.core.log:info("-------    Error! item_value == 0  ---------")
	else
		local var_13_2 = var_0_11:getGoodsArray(arg_13_1.item_value)[1]

		var_13_0 = var_13_2.name
		var_13_1 = var_13_2.size
	end

	return var_13_0, var_13_1
end

function BaseUseBuyPop:_initAddNumComp()
	local var_14_0 = {
		min = 1,
		cur = 1,
		max = 1,
		callback = handler(self, self._onNumChanged),
		reachMaxAddTipGetFunc = handler(self, self._getReachMaxAddTip)
	}

	if self._type == var_0_1.USE then
		local var_14_1 = self:getMaxUseCount()

		if var_14_1 > 0 then
			var_14_0.max = var_14_1
		end
	elseif self._type == var_0_1.BUY_USE then
		var_14_0.max = self:_isBuyLimit() and math.max(var_14_0.min, self._maxBuyNum) or 1000000
	end

	self.m_addNumComp:initMinMaxNum(var_14_0)
end

function BaseUseBuyPop:getMaxUseCount()
	if self._useBuyGoodsInf.type == var_0_9.TYPE_ITEM and self._useBuyGoodsInf.value == var_0_9.ITEM.TYPE_STAMINA_PILL then
		return math.min(self._useBuyGoodsInf.size, (math.floor((g.core.model.User.resourceData:getRecoverCfg(var_0_9.RESOURCE.TYPE_STAMINA).max_limit - g.core.model.User.bagData:getCountById(var_0_9.TYPE_RESOURCE, var_0_9.RESOURCE.TYPE_STAMINA)) / self._convertRate)))
	else
		return self._useBuyGoodsInf.size
	end
end

function BaseUseBuyPop:_isPurchaseLimitTxtShow()
	if self._type == var_0_1.BUY_USE then
		return self:_isBuyLimit()
	else
		return false
	end
end

function BaseUseBuyPop:_onNumChanged(arg_17_1)
	self:_updateTimesItemNum(arg_17_1)

	if self._type == var_0_1.BUY_USE then
		self:_updateCurrencyComps(arg_17_1)
	end
end

function BaseUseBuyPop:_updateTimesItemNum(arg_18_1)
	self.m_addTimesTxt:setText(g.core.lang:get(106002, {
		num = self._convertRate * arg_18_1
	}))
end

function BaseUseBuyPop:_isBuyLimit()
	return checkbool(self._limitLeft)
end

function BaseUseBuyPop:_getBuyMaxNum(arg_20_1)
	local var_20_0 = math.floor(var_0_13:getOwnNum(arg_20_1.price_type_1, arg_20_1.price_value_1) / var_0_12:getBuyItemPrice(arg_20_1, 1))

	if self:_isBuyLimit() then
		var_20_0 = math.min(self._limitLeft, var_20_0)
	end

	return (math.max(var_20_0, 0))
end

function BaseUseBuyPop:_updateCurrencyComps(arg_21_1)
	self.m_currencyComp:updateByTVS({
		type = self._shopScoreInf.price_type_1,
		value = self._shopScoreInf.price_value_1,
		size = var_0_12:getBuyItemPrice(self._shopScoreInf, arg_21_1)
	})
end

function BaseUseBuyPop:_getReachMaxAddTip(arg_22_1)
	if self._type == var_0_1.USE then
		if self._useBuyGoodsInf.size < 1 then
			return g.core.lang:get(106009)
		else
			return g.core.lang:get(106007)
		end
	elseif self._type == var_0_1.BUY_USE then
		if arg_22_1 >= self._limitLeft then
			return g.core.lang:get(106008)
		else
			return g.core.lang:get(106010)
		end
	end
end

return BaseUseBuyPop
