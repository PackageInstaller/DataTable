local MineResultLayer = class("MineResultLayer", require("app.fairyGUI.mine.UI_MineResultLayer"), function()
	local var_1_0 = fgui.GComponent:create({
		pkgPath = "ui/mine/mine",
		resName = "MineResultLayer",
		pkgName = "mine",
		isFullScreen = true
	})

	var_1_0:setName("MineMainLayer")

	return var_1_0
end)

MineResultLayer.DELAY_TIME = 5

function MineResultLayer:ctor()
	self:addBg("bg/mine/bg_zhanbao.jpg")

	self._closeTime = g.core.model.User.mineData:getCloseTime()

	self.m_topBar:setResInfoById(95)
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankRenderer))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_enterTransition:play()
	self.m_hasGuildController:setSelectedIndex(2)
end

function MineResultLayer:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO, self._onRcvMineGetInfo, self)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.MINE)
	g.core.network.GameNetProxy:send_C2S_Mine_GetInfo({})
end

function MineResultLayer:_onRcvMineGetInfo(arg_4_1, arg_4_2, arg_4_3)
	if self._closeTime - g.core.common.ServerTime:getTime() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(307535))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	self:_updateView()
end

function MineResultLayer:_updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})

	self._cityList = g.core.model.User.mineData:getNotCapitalCityList(true)
	self._endTime = g.core.model.User.mineData:getSeasonEndTime()

	local var_5_0 = 0
	local var_5_1
	local var_5_2 = g.core.model.User:getUserData()

	for iter_5_0, iter_5_1 in ipairs(self._cityList) do
		local var_5_3 = iter_5_1:getGuildData()

		if var_5_3 and var_5_3.id == var_5_2.guild_id then
			var_5_1 = iter_5_1
			var_5_0 = iter_5_0

			break
		end
	end

	if var_5_1 then
		self.m_myRankTxt:setText(var_5_0)
	else
		self.m_myRankTxt:setText(g.core.lang:get(307518))
	end

	self.m_rankList:setNumItems(#self._cityList)
	self.m_rankList:transitionShowCells("enter_right", 0.03, 1)

	local var_5_4

	for iter_5_2, iter_5_3 in ipairs(self._cityList) do
		if iter_5_3:isCityOccu() and iter_5_3:getGuildData() then
			var_5_4 = iter_5_3

			break
		end
	end

	if var_5_4 then
		local var_5_5 = var_5_4:getGuildData()

		if var_5_5 then
			local var_5_6 = g.core.config.knight_info.get(var_5_5.leader_base_id)
			local var_5_7 = 0

			var_5_7 = var_5_5.leader_dress_id and var_5_5.leader_dress_id > 0 and (var_5_6.sex == 0 and g.core.config.dress_info.get(var_5_5.leader_dress_id).woman_res_id or g.core.config.dress_info.get(var_5_5.leader_dress_id).man_res_id) or var_5_5.leader_show_knight_id and g.core.model.User.knightsData:getKnightResInfo({
				knightId = var_5_5.leader_show_knight_id,
				skinId = var_5_5.leader_show_knight_dress
			}).id or g.core.config.knight_base_info.get(var_5_6.res_id).painted_id

			self.m_topGuildIcon:setURL(g.core.common.Path:getGuildSignOrFrameById(var_5_5.icon))
			self.m_knightPicComp:updateKnight({
				resId = var_5_7
			})
			self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250 / 2, 0, 250 * 2, 0), 250)

			local var_5_8, var_5_9 = g.core.lang:getFormatServerName(var_5_5.server_name)

			self.m_guildNameTxt:setText(var_5_5.name .. var_5_9)
			self.m_guildLeaderName:setText(var_5_5.leader_name)
			self.m_cityName:setText(var_5_4:getCfg().name)
		end
	end

	self.m_hasGuildController:setSelectedIndex(var_5_4 and 1 or 0)
	self:newSchedule(handler(self, self._updateCountdown), 1)
	self:_updateCountdown()
end

function MineResultLayer:_updateCountdown()
	local var_6_0 = self._closeTime - g.core.common.ServerTime:getTime()

	self.m_timeTxt:setText((g.core.common.ServerTime:getCountDownBySecond(var_6_0)))

	if var_6_0 <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(307535))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end
end

function MineResultLayer:_onRankRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._cityList[arg_7_1 + 1], arg_7_1 + 1)
end

function MineResultLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.MINE
	})
end

function MineResultLayer:_onTaskBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mine.view.pop.MineTaskPop").new(), {
		touchDisappear = true
	})
end

function MineResultLayer:_onRankBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mine.view.pop.MineRankPop").new(), {
		touchDisappear = true
	})
end

function MineResultLayer:onUnload()
	self:cancelAllSchedule()
end

return MineResultLayer
