local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User
local var_0_2 = g.core.const.ConstMgr.ShopConst
local GoToAndUseBoxPop = class("GoToAndUseBoxPop", require("app.fairyGUI.goto.UI_GoToAndUseBoxPop"), function()
	return fgui.GComponent:create({
		resName = "GoToAndUseBoxPop",
		pkgName = "goto",
		pkgPath = "ui/goto/goto"
	}, ...)
end)

function GoToAndUseBoxPop:ctor(arg_2_1, arg_2_2)
	self._boxArray = {}
	self._selectBoxData = {}
	self._limitTime = 0
	self.params = arg_2_2

	self:showAtCenter()
	self:addListen(self.m_routesList)
	self.m_routesList:setVirtual()
	self.m_routesList:setItemRenderer(handler(self, self._onListRoutesRenderer))
	self.m_boxList:setVirtual()
	self.m_boxList:setItemRenderer(handler(self, self._onBoxRenderer))
	self.m_boxList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onBoxClick))
	self.m_openBtn:addClickListener(handler(self, self._onOpenBtnClick))
end

function GoToAndUseBoxPop:onLoad(arg_3_1, arg_3_2)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, handler(self, self._onS2CItemUse), self)

	self._routes = arg_3_2

	self:_updateView()
end

function GoToAndUseBoxPop:_onListRoutesRenderer(arg_4_1, arg_4_2)
	arg_4_2:update(self._routes.routes[arg_4_1 + 1])
end

function GoToAndUseBoxPop:_onBoxRenderer(arg_5_1, arg_5_2)
	arg_5_2:getChild("icon"):updateIcon((g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = self._boxArray[arg_5_1 + 1].id,
		size = self._boxArray[arg_5_1 + 1].num
	})))
end

function GoToAndUseBoxPop:_onBoxClick(arg_6_1)
	self._selectBoxData = self._boxArray[arg_6_1:getDataValue() + 1]
end

function GoToAndUseBoxPop:_onOpenBtnClick()
	require("app.view.module.bagNew.view.popup.BagNewSelectPop").createUse(self._selectBoxData.id, handler(self, self._onUseOkHandler), nil, {
		type = self._routes.source.type,
		value = self._routes.source.value
	})
end

function GoToAndUseBoxPop:_onUseOkHandler(arg_8_1)
	if arg_8_1.count <= 0 then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Item_Use({
		id = arg_8_1.id,
		num = arg_8_1.count,
		index = arg_8_1.selectedIndex
	})
end

function GoToAndUseBoxPop:_onS2CItemUse(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if not ({
		[g.view.entrance.MAIN_BAG] = true,
		[g.view.entrance.EQUIP_BAG] = true,
		[g.view.entrance.TREASURE_BAG] = true,
		[g.view.entrance.ARTIFACT_BAG] = true
	})[g.core.module.ModuleManager:getFirstFullModule().module] then
		g.core.module.ModuleManager:awardSummary(arg_9_4.awards)
	end

	g.core.module.ModuleManager:updateCurRootAndPopModule()
end

function GoToAndUseBoxPop:_updateView()
	self._limitTime = 0

	self:_updateGood()

	local var_10_0 = self._routes.routes

	if #self._routes.routes > 0 then
		self.m_hasRouteController:setSelectedIndex(0)
	else
		self.m_hasRouteController:setSelectedIndex(1)
	end

	if #var_10_0 > 0 then
		self.m_routesList:setNumItems(#var_10_0)
	end

	self._boxArray = g.core.model.User.bagData:getContainSpecificPropSelectBox(self._routes.source.type, self._routes.source.value)

	if #self._boxArray > 0 then
		self.m_hasBoxRouteController:setSelectedIndex(1)
		self.m_boxList:setNumItems(#self._boxArray)
		self.m_boxList:setSelectedIndex(0)

		self._selectBoxData = self._boxArray[1]
	else
		self.m_hasBoxRouteController:setSelectedIndex(0)
	end

	if self._limitTime > 0 then
		local var_10_1 = g.core.common.ServerTime:getDateObject(self._limitTime)

		self.m_limitedTimeTxt:setText((string.format("%04d/%02d/%02d %02d:%02d", var_10_1.year, var_10_1.month, var_10_1.day, var_10_1.hour, var_10_1.min)))
		self.m_showTimeController:setSelectedIndex(1)
	else
		self.m_showTimeController:setSelectedIndex(0)
	end

	local var_10_2 = self._routes.source

	if self._routes.source.type == 3 and (var_10_2.value == 88 or var_10_2.value == 89) then
		self.m_showTimeController:setSelectedIndex(0)
	end

	local var_10_3

	if var_0_0.CFG[var_10_2.type] then
		var_10_3 = var_0_0.CFG[var_10_2.type].get(var_10_2.value)
	end

	local var_10_4 = 0

	if var_10_2.type == var_0_0.TYPE_EXPIRABLE_ITEM then
		var_10_4 = var_10_3.limited_time
	elseif (var_10_2.type == var_0_0.TYPE_AVATAR or var_10_2.type == var_0_0.TYPE_AVATAR_FRAME) and var_10_3.time_type == 2 then
		var_10_4 = var_10_3.time_value
	end

	if var_10_4 > 0 then
		self.m_timeIconTypeController:setSelectedIndex(1)
		self.m_showTimeController:setSelectedIndex(1)
		self.m_limitedTimeTxt:setText(g.core.lang:get(2082, {
			num = math.floor(var_10_4 / 86400)
		}))
	else
		self.m_timeIconTypeController:setSelectedIndex(0)
		self.m_showTimeController:setSelectedIndex(0)
	end
end

function GoToAndUseBoxPop:_updateGood()
	self._routes.source.overrideClick = true
	self._routes.source.size = g.core.model.User.bagData:getCountById(self._routes.source.type, self._routes.source.value)

	self.m_baseItem:updateIcon(self._routes.source)

	local var_11_0 = g.core.common.Goods:convert(self._routes.source)

	if self._routes.source.type == 1 and self._routes.source.value >= 2000 then
		self.m_showNumController:setSelectedIndex(1)
	elseif self._routes.source.type == 1 and (self._routes.source.value == var_0_0.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION or self._routes.source.value == var_0_0.RESOURCE.TYPE_NEW_SLG_SCORE) then
		self.m_showNumController:setSelectedIndex(1)
	elseif self._routes.source.type == g.core.common.Goods.TYPE_REDPACKET then
		self.m_showNumController:setSelectedIndex(1)
	end

	self.m_showNumController:setSelectedIndex(0)
	self.m_numTxt:setText((self:_getNum()))
	self.m_descComp:setText(var_11_0.desc or "", true)
	self.m_itemNameTxt:setText(var_11_0.name or "")
end

function GoToAndUseBoxPop:_getNum()
	local var_12_0 = self._routes.source

	if self._routes.source.type == var_0_0.TYPE_SKIN then
		return var_0_1.skinData:getSkinState(g.core.config.skin_info.get(var_12_0.value).id) == 1 and 1 or 0
	elseif var_12_0.type == var_0_0.TYPE_OUTPOST_ITEM then
		if self.params and self.params.num then
			return self.params.num
		else
			return (g.core.model.User.outpostData:getBagData():getOwnNum(var_12_0.value))
		end
	elseif var_12_0.type == var_0_0.TYPE_OUTPOST_ITEM then
		return (g.core.model.User.outpostData:getBagData():getOwnNum(var_12_0.value))
	else
		local var_12_1 = g.core.model.User.bagData

		self._limitTime = g.core.model.User.bagData:getItemTimeLimit(var_12_0.type, var_12_0.value)

		if var_12_1:isItemExpired(var_12_0.type, var_12_0.value) then
			return 0
		end

		if var_12_0.type == var_0_0.TYPE_RESOURCE then
			if var_12_0.value == var_0_0.RESOURCE.TYPE_OUTPOST_VIT then
				return g.core.model.User.outpostData:getLastShowVit()
			elseif var_12_0.value == var_0_0.RESOURCE.TYPE_OUTPOST_POINT then
				return g.core.model.User.bagData:getOwnNum(var_12_0.type, var_12_0.value)
			end
		end

		return (g.core.model.User.bagData:getCountById(var_12_0.type, var_12_0.value))
	end
end

function GoToAndUseBoxPop:receiveCompEvent(arg_13_1, arg_13_2)
	if arg_13_1 == "GotoCell_goto" then
		if g.core.guide.GuideProxy:isGuideRunning() or g.core.battle.BattleProxy:isInBattle() then
			g.core.module.ModuleManager:tip(g.core.lang:get(2601))

			return
		end

		if g.core.module.ModuleManager:getModuleByDisplayName("MysteryBossMainLayer") then
			g.core.module.ModuleManager:tip(g.core.lang:get(423526))

			return
		end

		local var_13_0 = g.view.entrance.ModuleGotoProxy
		local var_13_1, var_13_2 = g.view.entrance.ModuleGotoProxy:getModule(arg_13_2.route.route_id)

		if not var_13_1 then
			if type(var_13_2) == "string" then
				g.core.module.ModuleManager:tip(var_13_2)
			end

			return
		end

		local var_13_3 = g.core.module.ModuleManager:getCurModule()

		if not var_13_3 then
			return
		end

		local var_13_4 = var_13_3.module

		if not var_13_3.module then
			return
		end

		local var_13_5 = g.core.module.ModuleManager:getCurRootModule() or {}

		if var_13_1 == g.view.entrance.OUT_POST_STAGE then
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			var_13_0:gotoModule(arg_13_2.route.route_id, false, nil, self._routes.source)

			return
		end

		if var_13_1 ~= var_13_4 and var_13_1 ~= var_13_5 then
			if var_13_1.routeType and var_13_5.routeType and var_13_1.routeType == var_13_5.routeType then
				g.core.module.ModuleManager:tip(g.core.lang:get(1143))
			else
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
				var_13_0:gotoModule(arg_13_2.route.route_id, false, nil, self._routes.source)
			end
		else
			local var_13_6 = g.core.module.ModuleManager:getPreviousModule()

			if self._routes.source.type == var_0_0.TYPE_GOLD then
				if g.core.model.User:getGold() <= 0 and var_13_6 and var_13_6.module == g.view.entrance.RECHARGE and var_13_6.display.gotoShopByType then
					g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
					var_13_6.display:gotoShopByType({
						tabType = 1,
						shopType = var_0_2.SHOP_TYPE.RECHARGE
					})
				end
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(1143))
			end
		end
	end
end

return GoToAndUseBoxPop
