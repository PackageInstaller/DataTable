local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.ShopConst
local BaseResItemComp = class("BaseResItemComp", require("app.fairyGUI.base_new.UI_BaseResItemComp"))

function BaseResItemComp:ctor()
	self._type = 0
	self._value = 0
	self._size = 0
	self._clickFunc = nil
	self._runChangeAni = false

	self:addClickListener(handler(self, self._onClickResBtn))

	if self.m_addBtnLoader then
		self.m_addBtnLoader:setTouchable(false)
		self.m_addBtnLoader:addClickListener(handler(self, self._onClickVitResBtn))
	end

	self._needCheckVit = true
	self._vitCfg = g.core.model.User.resourceData:getRecoverCfg(g.core.common.Goods.RESOURCE.TYPE_STAMINA)

	if g.core.model.User.activityLifeTimeCardData:isSubscription() then
		self._maxVit = self._vitCfg.privi_time_limit
		self._needCheckVit = false
	else
		self._maxVit = self._vitCfg.time_limit
	end
end

function BaseResItemComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CUSTOM_FLUSH_RESOURCE, handler(self, self._onRcvResourceFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECOVER_NOTIFY, handler(self, self._onRcvResourceFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GOLD_FLUSH, handler(self, self._onRcvResourceFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RESOURCE, handler(self, self._onRcvResourceFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BUY_COMMON_PLAY_NUM, handler(self, self._onRcvResourceFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, handler(self, self._onTouchFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETINFO, handler(self, self._onRcvResourceFlush), self)
end

function BaseResItemComp:_onTouchFinish()
	if self.m_vitRecoverComp:isVisible() then
		self.m_vitRecoverComp:setVisible(false)
	end
end

function BaseResItemComp:updateResBtn(arg_4_1)
	self._type = arg_4_1.type or var_0_0.TYPE_RESOURCE
	self._value = arg_4_1.value or var_0_0.RESOURCE.TYPE_COIN
	self._runChangeAni = arg_4_1.runChangeAni
	self._clickFunc = arg_4_1.clickFunc
	self._updateResFunc = arg_4_1.updateResFunc

	self:setIcon((var_0_1:getIconByTypeValue(self._type, self._value, true)))
	self:updateResNum(false)

	if self._type ~= var_0_0.TYPE_ITEM or self._value ~= var_0_0.ITEM.TYPE_STAMINA_PILL then
		self.m_addBtnLoader:setTouchable(false)
	end
end

function BaseResItemComp:updateResNum(arg_5_1)
	if self._isStopRcvResourceFlush then
		return
	end

	if self._type <= 0 then
		return
	end

	if self._updateResFunc then
		self._size = self._updateResFunc()
	elseif self._type == var_0_0.TYPE_GOLD then
		if self._value == 0 then
			self._size = g.core.model.User:getFreeGold()
		elseif self._value == 1 then
			self._size = g.core.model.User:getGold()
		end
	else
		self._size = self._type == var_0_0.TYPE_FUNCTION_NUM and g.core.model.User.shopData:getLeftCount(self._value) or self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_WUSH_TOWER_STEP and g.core.model.User.wushTowerData:getCanChallengeCount() or self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_OUTPOST_VIT and g.core.model.User.outpostData:getLastShowVit() or self._type == var_0_0.TYPE_OUTPOST_ITEM and g.core.model.User.outpostData:getBagData():getOwnNum(self._value) or g.core.model.User.bagData:getCountById(self._type, self._value)
	end

	local var_5_0 = arg_5_1 and self._runChangeAni

	if self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_STAMINA then
		self.m_isShowVitController:setSelectedIndex(1)

		if self._needCheckVit then
			if g.core.model.User.activityLifeTimeCardData:isSubscription() then
				self._maxVit = self._vitCfg.privi_time_limit
				self._needCheckVit = false
			else
				self._maxVit = self._vitCfg.time_limit
			end
		end

		self:setTitle("/" .. self._maxVit)

		if var_5_0 then
			self.m_vitLabel:runChangeAni(checknumber(self.m_vitLabel:getText()), self._size, false)
		else
			self.m_vitLabel:setText(self._size)
		end
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_OUTPOST_VIT then
		self.m_isShowVitController:setSelectedIndex(1)
		self:setTitle("/" .. g.core.model.User.outpostData:getBuildData():getMainCity():getCfg().brawn_level)

		if var_5_0 then
			self.m_vitLabel:runChangeAni(checknumber(self.m_vitLabel:getText()), self._size, false)
		else
			self.m_vitLabel:setText(self._size)
		end
	else
		if var_5_0 then
			self:runChangeAni(checknumber(self:getTitle()), self._size, false)
		else
			self:setTitle(self._size)
		end

		self.m_isShowVitController:setSelectedIndex(0)
	end

	if self.m_vitRecoverComp then
		self.m_vitRecoverComp:setVisible(false)
	end
end

function BaseResItemComp:_onClickResBtn(arg_6_1)
	arg_6_1:stopPropagation()

	if self._clickFunc then
		self._clickFunc()

		return
	end

	if self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_STAMINA then
		if self.m_vitRecoverComp then
			self.m_addBtnLoader:setTouchable(true)
			self.m_vitRecoverComp:updateVitRecover()

			if not self.m_vitRecoverComp:isVisible() then
				self.m_vitRecoverComp:setVisible(true)
			end
		else
			self:_onClickVitResBtn()
		end
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_OUTPOST_VIT then
		if self.m_vitRecoverComp then
			self.m_addBtnLoader:setTouchable(true)
			self.m_vitRecoverComp:updateOutpostVitRecover()

			if not self.m_vitRecoverComp:isVisible() then
				self.m_vitRecoverComp:setVisible(true)
			end
		else
			self:_onClickVitResBtn()
		end
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_OUTPOST_POINT then
		if self.m_vitRecoverComp then
			self.m_addBtnLoader:setTouchable(true)
			self.m_vitRecoverComp:updateOutpostTodayPoint()

			if not self.m_vitRecoverComp:isVisible() then
				self.m_vitRecoverComp:setVisible(true)
			end
		else
			self:_onClickVitResBtn()
		end
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_ROB_NUM then
		require("app.view.base.infoPop.BasePlayNumPop").createPlayNum(var_0_0.ITEM.TYPE_ROB_TOKEN)
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_REBEL_ATTACK then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = var_0_0.TYPE_ITEM,
			value = var_0_0.ITEM.TYPE_REBEL_TOKEN,
			shopId = var_0_2.SHOP_ITEM_ID.REBEL_TOKEN
		}), {
			touchDisappear = true
		})
	elseif self._type == var_0_0.TYPE_GOLD then
		if self._value == 0 then
			if g.core.model.User:getGold() <= 0 then
				local var_6_0 = g.core.module.ModuleManager:getCurModule()

				if var_6_0 and var_6_0.module == g.view.entrance.RECHARGE then
					if var_6_0.display.gotoShopByType then
						var_6_0.display:gotoShopByType({
							tabType = 1,
							shopType = var_0_2.SHOP_TYPE.RECHARGE
						})
					end
				else
					g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
						shopType = 19
					})
				end
			else
				g.core.module.ModuleManager:pushModule(g.view.entrance.PAID_DIAMOND_EXCHANGE)
			end
		else
			local var_6_1 = g.core.module.ModuleManager:getCurModule()

			if var_6_1 and var_6_1.module == g.view.entrance.RECHARGE then
				if var_6_1.display.gotoShopByType then
					var_6_1.display:gotoShopByType({
						tabType = 1,
						shopType = var_0_2.SHOP_TYPE.RECHARGE
					})
				end
			else
				g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
					shopType = 19
				})
			end
		end
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_BIOGRAPHIE then
		require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.BIOGRAPHIE)
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_GUILD_DUN_TIME then
		require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_SCORE.GUILD_DUNGEON_NUM)
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_COIN then
		require("app.view.base.component.BaseBuyPop").createShop((g.core.config.shop_score_info.get(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.COIN)))
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_GRAIN then
		require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.GRAIN)
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_ARMY_TOKEN then
		require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.ARMY_TOKEN)
	elseif self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_VOUCHER_COIN_RESOURCE then
		local var_6_2 = tonumber((g.core.platform.PlatformProxy:getGameId()))
		local var_6_3

		for iter_6_0, iter_6_1 in ipairs(g.core.config.voucher_info.match(function(arg_7_0)
			if arg_7_0.country_id == var_6_2 then
				return true
			end
		end) or {}) do
			if g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, iter_6_1.item_id) > 0 then
				var_6_3 = {
					type = g.core.common.Goods.TYPE_ITEM,
					value = iter_6_1.item_id
				}

				break
			end
		end

		if var_6_3 then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.bagNew.view.popup.BagNewVoucherPop").new({
				size = 1,
				value = var_6_3.value,
				type = var_6_3.type,
				callback = handler(self, self.updateResNum)
			}), {
				touchDisappear = true
			})
		else
			local var_6_4 = g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION]

			if g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and var_6_4.VOUCHER_GET_URL then
				g.core.platform.PlatformProxy:openWebView(var_6_4.VOUCHER_GET_URL)
			else
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = self._type,
					value = self._value,
					size = g.core.model.User.bagData:getOwnNum(self._type, self._value)
				})
			end
		end
	else
		local var_6_5 = g.core.module.ModuleManager:getCurModule()

		if not var_6_5 then
			return
		end

		local var_6_6 = var_6_5.module

		if not var_6_5.module then
			return
		end

		if (var_6_6 == g.view.entrance.RECRUIT or var_6_6 == g.view.entrance.RECRUIT_GENERAL or var_6_6 == g.view.entrance.RECRUIT_ADVANCE) and self._type == var_0_0.TYPE_ITEM and self._value == var_0_0.ITEM.TYPE_ADVANCE_RECRUIT_ITEM then
			g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
				shopType = 1
			})
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._type,
				value = self._value,
				size = g.core.model.User.bagData:getOwnNum(self._type, self._value)
			})
		end
	end
end

function BaseResItemComp:_onClickVitResBtn()
	if self._type == var_0_0.TYPE_RESOURCE and self._value == var_0_0.RESOURCE.TYPE_STAMINA then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = var_0_0.TYPE_ITEM,
			value = var_0_0.ITEM.TYPE_STAMINA_PILL,
			shopId = var_0_2.SHOP_ITEM_ID.STAMINA_PILL
		}), {
			touchDisappear = true
		})
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._type,
			value = self._value,
			size = g.core.model.User.bagData:getOwnNum(self._type, self._value)
		})
	end
end

function BaseResItemComp:_onRcvResourceFlush()
	self:updateResNum(true)
end

function BaseResItemComp:playIconEffect(arg_10_1, arg_10_2)
	self.m_eff:addEffectSpine({
		remove = true,
		isLoop = false,
		name = arg_10_1,
		anim = arg_10_2
	})
end

function BaseResItemComp:isMatchRes(arg_11_1)
	if arg_11_1 and self._type == arg_11_1.type and self._value == arg_11_1.value then
		return true
	end

	return false
end

function BaseResItemComp:onClickOutpostVit()
	return
end

function BaseResItemComp:setStopRcvResourceFlush(arg_13_1)
	self._isStopRcvResourceFlush = arg_13_1

	if not arg_13_1 then
		self._runChangeAni = true

		self.m_effValueUp:addEffectSpine({
			remove = true,
			name = "eff_ui_anniversary_toplight",
			anim = "play",
			isLoop = false
		})
		self:updateResNum(true)
	end
end

return BaseResItemComp
