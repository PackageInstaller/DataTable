local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User
local var_0_2 = g.core.const.ConstMgr.ShopConst
local GoToPop = class("GoToPop", require("app.fairyGUI.goto.UI_GoToPop"), function()
	return fgui.GComponent:create({
		resName = "GoToPop",
		pkgPath = "ui/goto/goto",
		isFullScreen = true,
		pkgName = "goto"
	}, ...)
end)

function GoToPop:ctor(arg_2_1, arg_2_2)
	self._limitTime = 0
	self.params = arg_2_2

	self:showAtCenter()
	self:setPosByParams(arg_2_2)
	self:addListen(self.m_routesList)
	self.m_routesList:setVirtual()
	self.m_routesList:setItemRenderer(handler(self, self._onListRoutesRenderer))
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouch))
end

function GoToPop:setPosByParams(arg_3_1)
	if arg_3_1 and arg_3_1.positionL and arg_3_1.positionC and arg_3_1.positionR then
		local var_3_0 = arg_3_1.positionL
		local var_3_1 = arg_3_1.positionC
		local var_3_2 = arg_3_1.positionR
		local var_3_3 = self.m_bgPanel:getSize()
		local var_3_4 = display.height - (arg_3_1.positionL.y + var_3_3.height + 35)

		var_3_4 = display.height - (arg_3_1.positionL.y + var_3_3.height + 35) < 0 and var_3_4 or 0

		if var_3_1.x < display.width / 2 then
			var_3_2.y = var_3_2.y + var_3_4

			if var_3_2.x + var_3_3.width - display.width + 35 > 0 then
				var_3_2.x = var_3_2.x - (var_3_2.x + var_3_3.width - display.width + 35)
			end

			self.m_AllGroup:setPosition(var_3_2)
		else
			var_3_0.y = var_3_0.y + var_3_4
			var_3_0.x = var_3_0.x - var_3_3.width

			if var_3_0.x < 35 then
				var_3_0.x = 35
			end

			self.m_AllGroup:setPosition(var_3_0)
		end
	end
end

function GoToPop:onLoad(arg_4_1, arg_4_2)
	self._routes = arg_4_2

	self:_updateView()
end

function GoToPop:_onListRoutesRenderer(arg_5_1, arg_5_2)
	arg_5_2:update(self._routes.routes[arg_5_1 + 1])
end

function GoToPop:_updateView()
	self._limitTime = 0

	self:_updateGood()

	local var_6_0 = self._routes.routes

	if #self._routes.routes > 0 then
		self.m_hasRouteController:setSelectedIndex(0)
	else
		self.m_hasRouteController:setSelectedIndex(1)
	end

	if #var_6_0 > 0 then
		self.m_routesList:setNumItems(#var_6_0)
	end

	if self._limitTime > 0 then
		local var_6_1 = g.core.common.ServerTime:getDateObject(self._limitTime)

		self.m_limitedTimeTxt:setText((string.format("%04d/%02d/%02d %02d:%02d", var_6_1.year, var_6_1.month, var_6_1.day, var_6_1.hour, var_6_1.min)))
		self.m_showTimeController:setSelectedIndex(1)
	else
		self.m_showTimeController:setSelectedIndex(0)
	end

	local var_6_2 = self._routes.source

	if self._routes.source.type == 3 and (var_6_2.value == 88 or var_6_2.value == 89) then
		self.m_showTimeController:setSelectedIndex(0)
	end

	local var_6_3

	if var_0_0.CFG[var_6_2.type] then
		var_6_3 = var_0_0.CFG[var_6_2.type].get(var_6_2.value)
	end

	local var_6_4 = 0

	if var_6_2.type == var_0_0.TYPE_EXPIRABLE_ITEM then
		var_6_4 = var_6_3.limited_time
	elseif (var_6_2.type == var_0_0.TYPE_AVATAR or var_6_2.type == var_0_0.TYPE_AVATAR_FRAME) and var_6_3.time_type == 2 then
		var_6_4 = var_6_3.time_value
	end

	if var_6_4 > 0 then
		self.m_timeIconTypeController:setSelectedIndex(1)
		self.m_showTimeController:setSelectedIndex(1)
		self.m_limitedTimeTxt:setText(g.core.lang:get(2082, {
			num = math.floor(var_6_4 / 86400)
		}))
	else
		self.m_timeIconTypeController:setSelectedIndex(0)
		self.m_showTimeController:setSelectedIndex(0)
	end
end

function GoToPop:_updateGood()
	self._routes.source.overrideClick = true

	self.m_baseItem:updateIcon(self._routes.source)

	local var_7_0 = g.core.common.Goods:convert(self._routes.source)

	if self._routes.source.type == 1 and self._routes.source.value >= 2000 then
		self.m_showNumController:setSelectedIndex(1)
	elseif self._routes.source.type == 1 and (self._routes.source.value == var_0_0.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION or self._routes.source.value == var_0_0.RESOURCE.TYPE_NEW_SLG_SCORE) then
		self.m_showNumController:setSelectedIndex(1)
	elseif self._routes.source.type == g.core.common.Goods.TYPE_REDPACKET then
		self.m_showNumController:setSelectedIndex(1)
	end

	self.m_showNumController:setSelectedIndex(0)
	self.m_numTxt:setText((self:_getNum()))
	self.m_descComp:setText(var_7_0.desc or "", true)
	self.m_itemNameTxt:setText(var_7_0.name or "")
end

function GoToPop:_getNum()
	local var_8_0 = self._routes.source

	if self._routes.source.type == var_0_0.TYPE_SKIN then
		return var_0_1.skinData:getSkinState(g.core.config.skin_info.get(var_8_0.value).id) == 1 and 1 or 0
	elseif var_8_0.type == var_0_0.TYPE_OUTPOST_ITEM then
		if self.params and self.params.num then
			return self.params.num
		else
			return (g.core.model.User.outpostData:getBagData():getOwnNum(var_8_0.value))
		end
	elseif var_8_0.type == var_0_0.TYPE_OUTPOST_ITEM then
		return (g.core.model.User.outpostData:getBagData():getOwnNum(var_8_0.value))
	else
		local var_8_1 = g.core.model.User.bagData

		self._limitTime = g.core.model.User.bagData:getItemTimeLimit(var_8_0.type, var_8_0.value)

		if var_8_1:isItemExpired(var_8_0.type, var_8_0.value) then
			return 0
		end

		if var_8_0.type == var_0_0.TYPE_RESOURCE then
			if var_8_0.value == var_0_0.RESOURCE.TYPE_OUTPOST_VIT then
				return g.core.model.User.outpostData:getLastShowVit()
			elseif var_8_0.value == var_0_0.RESOURCE.TYPE_OUTPOST_POINT then
				return g.core.model.User.bagData:getOwnNum(var_8_0.type, var_8_0.value)
			end
		end

		return g.core.common.Goods:convert(var_8_0).size
	end
end

function GoToPop:_onTouch()
	if not self._hasPop then
		self._hasPop = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function GoToPop:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "GotoCell_goto" then
		if g.core.guide.GuideProxy:isGuideRunning() or g.core.battle.BattleProxy:isInBattle() then
			g.core.module.ModuleManager:tip(g.core.lang:get(2601))

			return
		end

		if g.core.module.ModuleManager:getModuleByDisplayName("MysteryBossMainLayer") then
			g.core.module.ModuleManager:tip(g.core.lang:get(423526))

			return
		end

		local var_10_0 = g.view.entrance.ModuleGotoProxy
		local var_10_1, var_10_2 = g.view.entrance.ModuleGotoProxy:getModule(arg_10_2.route.route_id)

		if not var_10_1 then
			if type(var_10_2) == "string" then
				g.core.module.ModuleManager:tip(var_10_2)
			end

			return
		end

		local var_10_3 = g.core.module.ModuleManager:getCurModule()

		if not var_10_3 then
			return
		end

		local var_10_4 = var_10_3.module

		if not var_10_3.module then
			return
		end

		local var_10_5 = g.core.module.ModuleManager:getCurRootModule() or {}

		if var_10_1 == g.view.entrance.OUT_POST_STAGE then
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			var_10_0:gotoModule(arg_10_2.route.route_id, false, nil, self._routes.source)

			return
		end

		if var_10_1 ~= var_10_4 and var_10_1 ~= var_10_5 then
			if var_10_1.routeType and var_10_5.routeType and var_10_1.routeType == var_10_5.routeType then
				g.core.module.ModuleManager:tip(g.core.lang:get(1143))
			else
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
				var_10_0:gotoModule(arg_10_2.route.route_id, false, nil, self._routes.source)
			end
		else
			local var_10_6 = g.core.module.ModuleManager:getPreviousModule()

			if self._routes.source.type == var_0_0.TYPE_GOLD then
				if g.core.model.User:getGold() <= 0 and var_10_6 and var_10_6.module == g.view.entrance.RECHARGE and var_10_6.display.gotoShopByType then
					g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
					var_10_6.display:gotoShopByType({
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

return GoToPop
