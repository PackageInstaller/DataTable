local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.retroData
local ShopRetroLayer = class("ShopRetroLayer", require("app.fairyGUI.shop.UI_ShopRetroLayer"), function()
	return fgui.GComponent:create({
		resName = "ShopRetroLayer",
		pkgPath = "ui/shop/shop",
		isFullScreen = true,
		pkgName = "shop"
	}, ...)
end)

function ShopRetroLayer:ctor(arg_2_1)
	self._actId = type(arg_2_1) ~= "table" and arg_2_1 or arg_2_1.route1
	self._shopShowParam = nil
	self._shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RETRO
	self._shopTabType = var_0_0.SHOP_INFO_TAB_TYPE.RETRO_TAB_TYPE
	self._shopFirst = self._actId
	self._uiShopName = nil

	self:initShop()
end

function ShopRetroLayer:initShop()
	self:_initShopData()
	self:_initShopUI()
end

function ShopRetroLayer:onLoad()
	self:_initRegisterMSG()
	self:_refreshShopItem()
	self.m_enterTransition:play()
end

function ShopRetroLayer:_initShopData()
	self._shopShowParam = nil

	for iter_5_0, iter_5_1 in pairs(g.core.model.User.shopData:getShopInfoGroup()[self._shopTabType][self._shopType]) do
		if iter_5_1.shop_first == self._shopFirst then
			self._uiShopName = self._uiShopName or iter_5_1.tab_name

			self:_addToOpenShopPage(iter_5_1)
		end
	end
end

function ShopRetroLayer:_initShopUI()
	local var_6_0 = var_0_1:getRetroDisplayInfo()

	self.m_topBarComp:setResInfoById(var_6_0.interface_shop)
	self.m_topBarComp:setTitle(var_6_0.shop_name)
	self:addBg("bg/retro/bg_chenfengyiji.jpg")
	self:updateActTime()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Switch_Paper)
end

function ShopRetroLayer:updateActTime()
	self.m_timeComp:updateTime()
end

function ShopRetroLayer:_initRegisterMSG()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
end

function ShopRetroLayer:_refreshShopItem()
	if self._shopShowParam == nil then
		return
	end

	self._shopShowParam.hideAll = true
	self._shopShowParam.bgStyle = 1

	self.m_childComp:updateComp(self._shopShowParam)
end

function ShopRetroLayer:_checkShopIsOpen(arg_10_1)
	return (arg_10_1.function_id ~= 0 or nil) and g.core.common.ModuleUnlock:isModuleUnlock(arg_10_1.function_id, nil, true) and g.core.model.User.shopData:checkShopOpen(arg_10_1.shop_type, arg_10_1.shop_first)
end

function ShopRetroLayer:_addToOpenShopPage(arg_11_1)
	if not self:_checkShopIsOpen(arg_11_1) then
		return
	end

	if not self._shopShowParam then
		self._shopShowParam = {}
		self._shopShowParam.info = arg_11_1
	end

	if arg_11_1.shop_second > 0 then
		self._shopShowParam.subInfo = self._shopShowParam.subInfo or {}

		table.insert(self._shopShowParam.subInfo, arg_11_1)
	end
end

function ShopRetroLayer:_onCrossDayUpdate()
	self:_refreshShopItem()

	if not var_0_1:isActOpen() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	if self._actId then
		g.core.network.GameNetProxy:send_C2S_Retro_GetInfo({})
	end
end

return ShopRetroLayer
