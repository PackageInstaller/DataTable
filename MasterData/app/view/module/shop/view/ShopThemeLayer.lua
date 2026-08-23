local DrawKnight = require("app.view.common.DrawKnight")
local var_0_1 = g.core.const.ConstMgr.ShopConst
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local var_0_3 = g.core.config.activity_theme_display_info
local var_0_4 = g.core.model.User.themeData
local var_0_5 = g.core.const.ConstMgr.ActivityConst
local ShopThemeLayer = class("ShopThemeLayer", require("app.fairyGUI.shop.UI_ShopThemeLayer"), function()
	local var_1_0 = ({
		...
	})[1].themeValue or var_0_2.THEME_VALUE.GRYPH

	return fgui.GComponent:create({
		pkgPath = "ui/shop/shop",
		isFullScreen = true,
		pkgName = "shop",
		resName = var_0_2.THEME_ACTIVITY_SHOP_LAYER[var_1_0]
	})
end)

function ShopThemeLayer:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_2.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_2.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._shopTabType = var_0_1.SHOP_INFO_TAB_TYPE.THEME_TAB_TYPE
	self._shopType = self._activeThemeType
	self._shopFirst = self._activeThemeValue
	self._shopShowParam = nil
	self._uiShopName = nil

	self:initShopTheme()

	if self.m_jumpShopBtn then
		self.m_jumpShopBtn:addClickListener(handler(self, self._onThemeGiftBtnClick))
	end
end

function ShopThemeLayer:onLoad()
	self:_initRegisterMSG()
	self:_refreshShopItem()
	self.m_enterTransition:play()
end

function ShopThemeLayer:onUnload()
	g.core.model.User.themeData:redDoNewShopScoreOpen(self._shopType, self._shopFirst)
end

function ShopThemeLayer:initShopTheme()
	self:_initShopThemeData()
	self:_initShopThemeUI()
	self:_initChangePhaseList()
	g.core.model.User.themeData:redDoNewThemeShopOpen(self._activeThemeValue)
end

function ShopThemeLayer:_initShopThemeData()
	self._shopShowParam = nil

	for iter_6_0, iter_6_1 in pairs(g.core.model.User.shopData:getShopInfoGroup()[self._shopTabType][self._shopType]) do
		if iter_6_1.shop_first == self._shopFirst then
			self._uiShopName = self._uiShopName or iter_6_1.tab_name

			self:_addToOpenShopPage(iter_6_1)
		end
	end
end

function ShopThemeLayer:_initShopThemeUI()
	self:addBg(var_0_2.THEME_SHOP_BG[self._activeThemeValue] or "bg/shop/bg_wanfasd.jpg", true)

	self._displayInfo = var_0_3.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.shop_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.shop_name)

	if self.m_jumpShopBtn then
		self.m_jumpShopBtn:setTitle(self._displayInfo.gift_name)
	end

	self:_addAssistant((self._shopShowParam or nil) and self._shopShowParam.info.spine)
end

function ShopThemeLayer:_initRegisterMSG()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
end

function ShopThemeLayer:_addAssistant(arg_9_1)
	self.m_knightComp:removeChildren()

	local var_9_0 = {
		resId = arg_9_1 > 0 and arg_9_1 or 700060
	}

	var_9_0.isShowBg = false
	var_9_0.isAlphaNode = true

	local var_9_1 = var_0_3.fetch(self._activeThemeValue)

	if var_9_1 then
		var_9_0.isShowBg = var_9_1.show_shop_bg == 1
	end

	local var_9_2 = DrawKnight.new(var_9_0)

	var_9_2:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-150, -10, 390, 100), 300)
	self.m_knightComp:addChild(var_9_2)
end

function ShopThemeLayer:_refreshShopItem()
	if self._shopShowParam == nil then
		return
	end

	self.m_childComp:updateComp(self._shopShowParam)
end

function ShopThemeLayer:_checkShopIsOpen(arg_11_1)
	return (arg_11_1.function_id ~= 0 or nil) and g.core.common.ModuleUnlock:isModuleUnlock(arg_11_1.function_id, nil, true) and g.core.model.User.shopData:checkShopOpen(arg_11_1.shop_type, arg_11_1.shop_first)
end

function ShopThemeLayer:_addToOpenShopPage(arg_12_1)
	if not self:_checkShopIsOpen(arg_12_1) then
		return
	end

	if not self._shopShowParam then
		self._shopShowParam = {}
		self._shopShowParam.info = arg_12_1
	end

	if arg_12_1.shop_second > 0 then
		self._shopShowParam.subInfo = self._shopShowParam.subInfo or {}

		table.insert(self._shopShowParam.subInfo, arg_12_1)
	end
end

function ShopThemeLayer:_onThemeGiftBtnClick()
	if g.core.model.User.activityDataManager:getShowActivityDataByCfg(self._activeThemeType, self._activeThemeValue):getActivityState() ~= g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.START then
		g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.shopThemeGift.ShopThemeGiftPop").new({
		activityValue = self._activeThemeValue
	})))
end

function ShopThemeLayer:_initChangePhaseList()
	self.m_changePhaseList = self:getChild("changePhaseList")

	if not self.m_changePhaseList then
		return
	end

	self._mergedValues = var_0_4:getThemeMergeConfigValueList(self._activeThemeValue)

	if #self._mergedValues <= 1 then
		self.m_changePhaseList:setVisible(false)

		return
	end

	self.m_changePhaseList:setVisible(true)
	self.m_changePhaseList:setVirtual()
	self.m_changePhaseList:setItemRenderer(handler(self, self._onChangePhaseItemRender))
	self.m_changePhaseList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangePhaseListClick))
	self.m_changePhaseList:setNumItems(#self._mergedValues)
end

function ShopThemeLayer:_onChangePhaseItemRender(arg_15_1, arg_15_2)
	local var_15_0 = self._mergedValues[arg_15_1 + 1]

	arg_15_2:setTitle(var_0_3.get(self._mergedValues[arg_15_1 + 1]).shop_tab)
	arg_15_2:updateTabCell(var_15_0)
	arg_15_2:setSelected(self._activeThemeValue == var_15_0)
end

function ShopThemeLayer:_onChangePhaseListClick(arg_16_1)
	local var_16_0 = arg_16_1:getDataValue()

	if var_16_0 >= 0 and self._mergedValues[var_16_0 + 1] then
		local var_16_1 = self._mergedValues[var_16_0 + 1]
		local var_16_2 = var_0_4:getActivityData(self._mergedValues[var_16_0 + 1])
		local var_16_3 = var_16_2 and var_16_2:getActivityState()

		if var_16_3 == var_0_5.ACTIVITY_STATE.START or var_16_3 == var_0_5.ACTIVITY_STATE.END then
			self:_onChangePhaseItemClick(self._mergedValues[var_16_0 + 1])

			return
		end

		if var_16_3 == var_0_5.ACTIVITY_STATE.EXPIRE then
			g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		else
			local var_16_4 = g.core.model.User.activityDataManager:getActivityDataListByFilter(function(arg_17_0)
				if arg_17_0:getActivityType() == var_0_5.ACTIVITY_TYPE.SUMMER_ACTIVITY then
					return arg_17_0:getConfigActivityValue() == var_16_1
				end
			end)
			local var_16_5 = var_16_4 and var_16_4[1]

			if not (var_16_4 and var_16_4[1]) then
				g.core.module.ModuleManager:tip(g.core.lang:get(1005))
			else
				local var_16_6 = var_16_5:getStartTime() or 0

				if var_16_6 > g.core.common.ServerTime:getTime() then
					local var_16_7, var_16_8, var_16_9, var_16_10 = g.core.common.ServerTime:getLeftTimeParts(var_16_6)

					if var_16_9 > 0 or var_16_10 > 0 then
						var_16_8 = var_16_8 + 1
					end

					g.core.module.ModuleManager:tip(g.core.lang:get(500125, {
						day = var_16_7,
						hour = var_16_8
					}))
				else
					g.core.module.ModuleManager:tip(g.core.lang:get(1008))
				end
			end
		end
	end
end

function ShopThemeLayer:_onChangePhaseItemClick(arg_18_1)
	if arg_18_1 == self._activeThemeValue then
		return
	end

	self._activeThemeValue = arg_18_1
	self._shopFirst = arg_18_1
	self._displayInfo = var_0_3.get(arg_18_1)

	self.m_topBarComp:setResInfoById(self._displayInfo.shop_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.shop_name)

	self._shopShowParam = nil
	self._uiShopName = nil

	self:_initShopThemeData()
	self:_refreshShopItem()
	self.m_changePhaseList:setNumItems(#self._mergedValues)
end

function ShopThemeLayer:_onCrossDayUpdate()
	if not var_0_4:getThemeMergeEntranceActivityData(self._activeThemeValue):isMergedShopOpen() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

return ShopThemeLayer
