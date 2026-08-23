local var_0_0 = {
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO] = "bg/mine/bg_jiaoguo.jpg",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LIN_DONG] = "bg/mine/bg_lindong.jpg",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DONG_XI] = "bg/mine/bg_dongxi.jpg",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LI_JIN] = "bg/mine/bg_lijin.jpg"
}
local var_0_1 = {
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO] = {
		"ui://base_new/icon_jiaoguo_07",
		"ui://base_new/icon_jiaoguo_03"
	},
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LIN_DONG] = {
		"ui://base_new/icon_lindong_07",
		"ui://base_new/icon_lindong_03"
	},
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DONG_XI] = {
		"ui://base_new/icon_dongxi_07",
		"ui://base_new/icon_dongxi_03"
	},
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LI_JIN] = {
		"ui://base_new/icon_lijin_07",
		"ui://base_new/icon_lijin_03"
	}
}
local var_0_2 = 3
local MineConst = require("app.view.module.mine.const.MineConst")
local MineCityLayer = class("MineCityLayer", require("app.fairyGUI.mine.UI_MineCityLayer"), function()
	return fgui.GComponent:create({
		resName = "MineCityLayer",
		pkgPath = "ui/mine/mine",
		isFullScreen = true,
		pkgName = "mine"
	})
end)

function MineCityLayer:ctor(arg_2_1)
	self._params = arg_2_1
	self._cityStruct = arg_2_1.struct
	self._cityInfo = self._cityStruct:getCfg()
	self._cityData = self._cityStruct:getServerData()
	self._isCapital = self._cityInfo.type == 1
	self._page = arg_2_1.page or 1
	self._totalPage = 1
	self._filterType = arg_2_1.fliterType
	self._playGroup = {}
	self._movePath = {}
	self._isFirstEnter = true
	self._frontClickTime = 0

	self:addBg(var_0_0[tonumber(self._cityInfo.camp)])

	self._playingSound = false

	local var_2_0 = var_0_1[tonumber(self._cityInfo.camp)]

	self.m_bgIcon:setURL(var_2_0[2])
	self.m_cityIcon:setURL(var_2_0[1])
	self.m_leftBtn:addClickListener(handler(self, self._onClickLeft))
	self.m_rightBtn:addClickListener(handler(self, self._onClickRight))
	self.m_refreshBtn:addClickListener(handler(self, self._onRefreshPage))
	self.m_leftBtn:setVisible(false)
	self.m_descTxt:setText(self._cityInfo.des)
	self.m_rightBtn:setVisible(false)
	self.m_buffComp:setVisible(false)
	self:initView()
end

function MineCityLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETCITYINFO, self._onRcvCityInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_ATTACKUSERFINISH, self._onRcvAttackFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onRcvShopping, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECOVER_NOTIFY, self._onRecover, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINE_PLAYER_DEAD, self._onRcvDead, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_BUYPOWER, self._onRcvBuyPower, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_USERSHIELDNOTIFY, self._onUserShieldChange, self)
	self:_updatePage()
	self:updatePlayer(self._page)

	self._curcity = g.core.model.User.mineData:getOwnCity()
	self._movePath = g.core.model.User.mineData:getMovePath(self._curcity, self._cityInfo.id)
end

function MineCityLayer:_onRefreshPage()
	local var_4_0 = os.time()

	if var_4_0 - self._frontClickTime < var_0_2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(307532))

		return
	end

	self._frontClickTime = var_4_0

	self:_updatePage()
end

function MineCityLayer:_updateCountDown()
	if g.core.model.User.mineData:getSeasonEndTime() - g.core.common.ServerTime:getTime() <= 0 then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.MINE_RESULT)
	end
end

function MineCityLayer:_updatePage(arg_6_1)
	arg_6_1 = arg_6_1 or self._page

	g.core.network.GameNetProxy:send_C2S_Mine_GetCityInfo({
		cityId = self._cityInfo.id,
		page = arg_6_1,
		filterType = self._filterType
	})
end

function MineCityLayer:updatePlayer(arg_7_1)
	self.m_playerComp:updatePlayerList({
		playerGroup = self._playGroup[arg_7_1 + 1],
		struct = self._cityStruct,
		isCapital = self._isCapital
	})
end

function MineCityLayer:_updateView()
	local var_8_0 = self._cityStruct:getCityOccuState()

	self.m_buffComp:setVisible(true)
	self.m_buffComp:updateBuffComp(self._params, self._cityStruct:getCityOccuState())

	if not self._isCapital then
		self.m_occu_stateController:setSelectedIndex(var_8_0)
		self.m_capitalController:setSelectedIndex(1)
	else
		self.m_capitalController:setSelectedIndex(0)
	end

	self.m_stateEffectComp:removeAllEffect()

	if var_8_0 == g.core.const.ConstMgr.MineConst.UNIQUE_STATE then
		self.m_occu_stateController:setSelectedIndex(2)

		local var_8_1, var_8_2 = g.core.lang:getFormatServerName(self._cityStruct:getGuildData().server_name)

		self.m_occuStateTxt:setText(self._cityStruct:getGuildName() .. var_8_2)
		self.m_stateEffectComp:addEffectSpine({
			anim = "play_1",
			name = "eff_ui_mine_minestate",
			isLoop = true
		})
	elseif var_8_0 == g.core.const.ConstMgr.MineConst.OCCU_STATE then
		self.m_occu_stateController:setSelectedIndex(1)

		local var_8_3, var_8_4 = g.core.lang:getFormatServerName(self._cityStruct:getGuildData().server_name)

		self.m_occuStateTxt:setText(self._cityStruct:getGuildName() .. var_8_4)
		self.m_stateEffectComp:addEffectSpine({
			anim = "play_2",
			name = "eff_ui_mine_minestate",
			isLoop = true
		})
	elseif var_8_0 == g.core.const.ConstMgr.MineConst.NOT_OCCU then
		self.m_occu_stateController:setSelectedIndex(0)
	end

	local var_8_5 = g.core.model.User.mineData:getOwnCity()
	local var_8_6 = var_8_5 == self._cityInfo.id

	if var_8_5 ~= self._cityInfo.id then
		self:_updateCostTxt()
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.MINE_PRODUCT_START)

		self._playingSound = true
	end

	self.m_typeController:setSelectedIndex(var_8_6 and (self._isCapital and 1 or 0) or self._isCapital and 3 or 2)
end

function MineCityLayer:_updateCostTxt()
	if g.core.model.User.mineData:getOwnCity() ~= self._cityInfo.id then
		self.m_costTxt:setText(g.core.model.User.resourceData:getResourceById(g.core.common.Goods.RESOURCE.TYPE_GRAIN) .. "/" .. g.core.config.mine_parameter_info.indexOf(1).move_spend * (#self._movePath - 1))
		self.m_costIcon:setURL(g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_GRAIN
		}).icon)
	end
end

function MineCityLayer:initView()
	self.m_cityNameTxt:setText(self._cityInfo.name)
	self.m_moveInBtn:addClickListener(handler(self, self._onMoveInClick))
end

function MineCityLayer:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "Mine_Click_Player_enter" then
		self:_onMoveInClick()
	end
end

function MineCityLayer:_onMoveInClick()
	local var_12_0 = g.core.config.mine_parameter_info.indexOf(1)

	if g.core.model.User.mineData:getCityObjById((g.core.model.User.mineData:getOwnCity())):isCapital() then
		local var_12_1 = var_12_0.move_hp
		local var_12_2 = g.core.model.User.mineData:getCurPower()
		local var_12_3 = (var_12_0.move_hp - var_12_2) / var_12_0.conversion_rate
		local var_12_4 = (100 - var_12_2) / var_12_0.conversion_rate
		local var_12_5 = g.core.model.User.resourceData:getResourceById(g.core.common.Goods.RESOURCE.TYPE_GRAIN)

		if var_12_2 < var_12_0.move_hp then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(307501),
				desc = g.core.lang:get(307502, {
					power = var_12_0.move_hp
				}),
				onConfirm = function()
					if var_12_5 >= var_12_3 then
						g.core.network.GameNetProxy:send_C2S_Mine_BuyPower({
							num = var_12_1 - var_12_2
						})
					else
						require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.GRAIN, {
							initNum = var_12_4 - var_12_5
						})
					end
				end
			}), {
				touchDisappear = true
			})

			return
		end
	end

	local var_12_6 = g.core.model.User.resourceData:getResourceById(g.core.common.Goods.RESOURCE.TYPE_GRAIN)
	local var_12_7 = var_12_0.move_spend * (#self._movePath - 1)
	local var_12_8 = var_12_0.move_spend * (#self._movePath - 1) <= var_12_6
	local var_12_9 = var_12_0.move_spend * (#self._movePath - 1)
	local var_12_10, var_12_11

	if var_12_0.move_spend * (#self._movePath - 1) > var_12_6 then
		var_12_9 = var_12_7 - var_12_6
		var_12_10 = {
			title = g.core.lang:get(307504)
		}
		var_12_11 = {
			num = var_12_7,
			city = self._cityInfo.name
		}
	end

	var_12_11.name = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_GRAIN
	}).name
	var_12_10.desc = g.core.lang:get(307505, var_12_11)

	function var_12_10.onConfirm()
		if var_12_8 then
			if g.core.model.User.mineData:getSeasonEndTime() - g.core.common.ServerTime:getTime() <= 0 then
				g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.MINE_RESULT)
			else
				g.core.model.User.mineData:setMoveReqPath(self._movePath)
				g.core.module.ModuleManager:popModule()
			end
		else
			require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.GRAIN, {
				initNum = var_12_9
			})
		end
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_12_10), {
		touchDisappear = true
	})
end

function MineCityLayer:_onRcvCityInfo(arg_15_1, arg_15_2, arg_15_3)
	local var_15_1 = math.max(1, arg_15_3.page or 1)
	local var_15_2 = math.max(1, arg_15_3.totalPage or 1)

	if var_15_2 < var_15_1 then
		var_15_1 = var_15_2
	end

	self._playGroup[self._page] = arg_15_3.users or {}
	self._page = var_15_1
	self._totalPage = var_15_2

	self:_updateView()

	if self._isFirstEnter then
		self:_updateBtnVisible()

		if self._cityStruct:isCapital() and self._cityStruct:getEventId() == MineConst.EVENT_ID.CAPITAL then
			-- block empty
		end
	end

	self.m_playerComp:updatePlayerList({
		playerGroup = self._playGroup[self._page],
		struct = self._cityStruct,
		isCapital = self._isCapital
	})
	self:_updatePageNum()

	self._isFirstEnter = false
end

function MineCityLayer:_onUserShieldChange(arg_16_1, arg_16_2, arg_16_3)
	for iter_16_0, iter_16_1 in ipairs(self._playGroup) do
		for iter_16_2, iter_16_3 in ipairs(iter_16_1) do
			if iter_16_3.user.id == arg_16_3.user then
				iter_16_3.shield_end_time = arg_16_3.shield_end_time
			end
		end
	end
end

function MineCityLayer:_onClickLeft()
	self._page = math.max(1, self._page - 1)

	self:_updatePage()
	self:_updateBtnVisible()
	self:_updatePageNum()
end

function MineCityLayer:_onClickRight()
	self._page = math.min(self._totalPage, self._page + 1)

	self:_updatePage()
	self:_updateBtnVisible()
	self:_updatePageNum()
end

function MineCityLayer:_updateBtnVisible()
	self.m_leftBtn:setVisible(true)
	self.m_rightBtn:setVisible(true)

	if self._page <= 1 then
		self.m_leftBtn:setVisible(false)
	end

	if self._page >= self._totalPage then
		self.m_rightBtn:setVisible(false)
	end
end

function MineCityLayer:_updatePageNum()
	self.m_pageTxt:setText(self._page .. "/" .. self._totalPage)
end

function MineCityLayer:_onRcvAttackFinish(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = self._playGroup[self._page] or {}

	for iter_21_0 = 1, #var_21_0 do
		if var_21_0[iter_21_0].user.id == arg_21_3.user_id then
			var_21_0[iter_21_0].power = arg_21_3.enemyBattleResult.powerAfter
		elseif var_21_0[iter_21_0].user.id == g.core.model.User:getId() then
			var_21_0[iter_21_0].power = g.core.model.User.mineData:getCurPower()
		end
	end

	self.m_playerComp:updatePlayerList({
		playerGroup = self._playGroup[self._page],
		struct = self._cityStruct,
		isCapital = self._isCapital
	})
end

function MineCityLayer:_onRcvShopping()
	self:_updateCostTxt()
end

function MineCityLayer:_onRecover(arg_23_1, arg_23_2)
	if arg_23_2.info.id == g.core.const.ConstMgr.BasicFigureConst.GRAIN then
		self:_updateCostTxt()
	end
end

function MineCityLayer:_onRcvDead()
	local var_24_0 = {}

	var_24_0.isRecord = false

	g.core.common.Storage:save("mine.json", var_24_0)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function MineCityLayer:_onRcvBuyPower()
	self:_updateCostTxt()
end

function MineCityLayer:onUnload()
	if self._playingSound then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.MINE_PRODUCT_STOP)
	end
end

return MineCityLayer
