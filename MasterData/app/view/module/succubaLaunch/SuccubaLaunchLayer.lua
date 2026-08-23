local var_0_0 = g.core.model.User.shopData
local var_0_1 = g.core.const.ConstMgr.ShopConst
local var_0_2 = g.core.model.User.succubaLaunchData
local DrawKnight = require("app.view.common.DrawKnight")
local SuccubaLaunchLayer = class("SuccubaLaunchLayer", require("app.fairyGUI.succubaLaunch.UI_SuccubaLaunchLayer"), function()
	return fgui.GComponent:create({
		resName = "SuccubaLaunchLayer",
		pkgPath = "ui/succubaLaunch/succubaLaunch",
		isFullScreen = true,
		pkgName = "succubaLaunch"
	}, ...)
end)

function SuccubaLaunchLayer:ctor()
	self:addBg("bg/succubaLaunch/bg_nwsd_shangdianbg.jpg")

	self._goods = {}
	self._tabList = {}
	self._curOpenStage = 1
	self._canShowStage = 1
	self._curTabStage = 1
	self._oldLockState = {}
	self._tipFunc = nil

	self.m_giftBtn:addClickListener(handler(self, self._onGiftClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskClick))
	self.m_shopTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onChangeFloor))
	self.m_shopTabList:setVirtual()
	self.m_shopTabList:setItemRenderer(handler(self, self._onTabRenderer))
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemRenderer))
	self:updateSuccubaGoods(true)
	self.m_knightHolder:addChild((DrawKnight.new({
		scale = 0.8,
		resId = 700460,
		isShowBg = false
	})))
	self.m_topBarComp:setResInfoById(368)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA_LAUNCH)
end

function SuccubaLaunchLayer:onLoad()
	if var_0_2:getActivityEndTime() < g.core.common.ServerTime:getTime() then
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		end, 0)

		return
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onShop, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_ACTIVITY_GETINFO, self.onUpdateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_ACTIVITY_FINISHTASK, self.onUpdateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, self.onUpdateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self.onCrossDayNotify, self)
	g.core.network.GameNetProxy:send_C2S_Succuba_Activity_GetInfo({})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_giftBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	self:newSchedule(handler(self, self._onUpdateTime), 1)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_WitchShop)
end

function SuccubaLaunchLayer:onCrossDayNotify()
	g.core.network.GameNetProxy:send_C2S_Succuba_Activity_GetInfo({})
end

function SuccubaLaunchLayer:_onUpdateTime()
	local var_6_0, var_6_1, var_6_2, var_6_3 = g.core.common.ServerTime:getLeftTimeParts((var_0_2:getActivityEndTime()))

	self.m_timeTxt:setText(g.core.lang:get(431504, {
		day = var_6_0,
		hour = var_6_1
	}))

	if var_6_0 + var_6_1 + var_6_2 + var_6_3 <= 0 then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function SuccubaLaunchLayer:_onShop(arg_7_1, arg_7_2, arg_7_3)
	g.core.module.ModuleManager:awardSummary(arg_7_3.awards, nil, nil, nil, self._tipFunc)

	self._tipFunc = nil

	self:onUpdateView()
end

function SuccubaLaunchLayer:onUpdateView()
	self:_onUpdateTime()
	self:updateSuccubaGoods()
end

function SuccubaLaunchLayer:updateSuccubaGoods(arg_9_1)
	local var_9_0 = 0

	for iter_9_0 = 1, 20 do
		local var_9_1 = var_0_0:getInfo(var_0_1.SHOP_TYPE.SUCCUBA_LAUNCH, iter_9_0, true)

		if #var_9_1 == 0 then
			break
		else
			local var_9_2 = var_0_0:checkBuyBan(var_9_1[1])
			local var_9_3 = {
				index = iter_9_0,
				isUnlock = not var_9_2
			}

			var_9_3.banString = var_0_0:getShopBuyBanText(var_9_1[1].buy_ban_type, var_9_1[1].buy_ban_value, var_9_1[1].buy_ban_key)

			if not var_9_2 then
				local var_9_4 = 0

				for iter_9_1, iter_9_2 in ipairs(var_9_1) do
					var_9_4 = var_9_4 + (var_0_0:getBuyLimitLeft(iter_9_2) or 0)
				end

				if var_9_4 == 0 then
					var_9_3.isFinish = true
				end

				if arg_9_1 then
					var_9_0 = iter_9_0 - 1
				end

				self._canShowStage = iter_9_0
			end

			self._tabList[iter_9_0] = var_9_3
			self._goods[iter_9_0] = var_9_1
		end
	end

	if next(self._oldLockState) then
		for iter_9_3, iter_9_4 in ipairs(self._tabList) do
			if self._oldLockState[iter_9_3] ~= iter_9_4.isUnlock then
				local var_9_5 = iter_9_4.index

				function self._tipFunc()
					g.core.module.ModuleManager:tip(g.core.lang:get(431506, {
						num = var_9_5
					}))
				end
			end
		end
	end

	for iter_9_5, iter_9_6 in ipairs(self._tabList) do
		self._oldLockState[iter_9_5] = iter_9_6.isUnlock
	end

	self.m_shopTabList:setNumItems(#self._tabList)

	if arg_9_1 then
		self.m_shopTabList:setSelectedIndex(var_9_0)

		self._curTabStage = var_9_0
	end

	self:updateShopItems()
	self:updateAllCost()
end

function SuccubaLaunchLayer:updateAllCost()
	local var_11_0

	if not next(self._goods) then
		do return end

		var_11_0 = {
			type = self._goods[2][1].price_type_1,
			value = self._goods[2][1].price_value_1
		}
	end

	var_11_0.size = self._goods[2][1].price_size_1

	self.m_costItemIcon:setURL(g.core.common.Goods:convert(var_11_0).icon_mini)
	self.m_numTxt:setText((var_0_0:getBanTask(self._goods[2][1])))
end

function SuccubaLaunchLayer:onChangeFloor()
	local var_12_0 = self.m_shopTabList:getSelectedIndex()

	if var_12_0 <= self._canShowStage then
		self._curTabStage = var_12_0
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(431505))
		self.m_shopTabList:setSelectedIndex(self._curTabStage)

		return
	end

	self:updateShopItems()
end

function SuccubaLaunchLayer:_onItemRenderer(arg_13_1, arg_13_2)
	arg_13_2:updateSuccubaItem(self._goods[self._curTabStage + 1][arg_13_1 + 1], self._tabList[self._curTabStage + 1])
end

function SuccubaLaunchLayer:updateShopItems()
	if not self._goods[self._curTabStage + 1] then
		return
	end

	self.m_itemList:setNumItems(#self._goods[self._curTabStage + 1])
end

function SuccubaLaunchLayer:_onTabRenderer(arg_15_1, arg_15_2)
	arg_15_2:updateTab(self._tabList[arg_15_1 + 1])
end

function SuccubaLaunchLayer:_onGiftClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.shopSuccubaLaunch.ShopSuccubaLaunchPop").new()))
end

function SuccubaLaunchLayer:_onTaskClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.succubaLaunch.SuccubaLaunchTaskPop").new()))
end

return SuccubaLaunchLayer
