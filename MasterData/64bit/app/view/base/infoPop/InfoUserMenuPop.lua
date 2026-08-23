local var_0_0 = g.core.model.User.friendData
local AutoButtonConst = require("app.view.common.const.AutoButtonConst")
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_5 = AutoButtonConst.getButtonConst()
local var_0_6 = AutoButtonConst.getButtonConstCfg()
local var_0_7 = 50
local InfoUserMenuPop = class("InfoUserMenuPop", require("app.fairyGUI.infoPop.UI_InfoUserMenuPop"), function()
	return fgui.GComponent:create({
		pkgName = "infoPop",
		isFullScreen = true,
		resName = "InfoUserMenuPop"
	})
end)

function InfoUserMenuPop:ctor(arg_2_1)
	self:showAtCenter()

	self._params = arg_2_1 or {}
	self._clickWorldPos = self._params.clickWorldPos or cc.p(display.width / 2 - 170, display.height / 2 - 75)
	self._showPos = self._params.showPos
	self._isRightPos = self._params.isRightPos
	self._playerInfo = self._params.playerInfo
	self._btnCfgList = {}

	self.m_touchBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClick))
end

function InfoUserMenuPop:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GET_USER_DETAIL_INFO, handler(self, self._onSynchronizePlayerInfo), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_FRIEND_ADDFRIEND, handler(self, self._onAddRequestSuc), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_FRIEND_DELFRIEND, handler(self, self._onDeleteSuc), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_FRIEND_ADDBLACKLIST, handler(self, self._onBlackSuc), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_FRIEND_DUEL, self._onDuel, self)

	self._isShowPersonBtn = true

	if self._params.showPersonInfo == false then
		self._isShowPersonBtn = false
	end

	self:_requestPlayerInfo()
end

function InfoUserMenuPop:_requestPlayerInfo()
	self.m_menuGroup:setVisible(false)
	g.core.network.GameNetProxy:send_C2S_GetUserDetailInfo({
		tp = 0,
		player_id = self._playerInfo.user.id
	})
end

function InfoUserMenuPop:_getUserBtnListCfg()
	self._btnCfgList = {}

	for iter_5_0, iter_5_1 in ipairs(var_0_5) do
		local var_5_0 = clone(AutoButtonConst.getButtonCfg(iter_5_1))

		if iter_5_1 == var_0_6.ADD_FRIEND and self._playerInfo.user and self._playerInfo.user.isFriend then
			var_5_0 = clone(var_5_0)
			var_5_0.title = g.core.lang:get(102524)
			var_5_0.icon = "ui://infoPop/icon_qingli"
		end

		if iter_5_1 ~= var_0_6.PERSON_INFO then
			table.insert(self._btnCfgList, var_5_0)
		elseif self._isShowPersonBtn then
			table.insert(self._btnCfgList, var_5_0)
		end
	end
end

function InfoUserMenuPop:_onSynchronizePlayerInfo()
	if self._playerInfo.user and (not self._playerInfo.user.robot_type or self._playerInfo.user.robot_type == 0) then
		local var_6_1 = var_0_0:getPlayerInfo()

		self._playerInfo.user = var_6_1.user
		self._playerInfo.user.isFriend = var_6_1.isFriend
		self._playerInfo.user.isBlack = var_6_1.isBlack
	end

	self:_updateView()
end

function InfoUserMenuPop:_updateView()
	self:_getUserBtnListCfg()
	self:_showMenuComp()
end

function InfoUserMenuPop:_showMenuComp()
	self.m_menuGroup:setVisible(true)

	local var_8_0 = true
	local var_8_1 = {
		x = self._clickWorldPos.x + var_0_7,
		y = self._clickWorldPos.y
	}

	self.m_menuComp:updateMenu(self._btnCfgList, self._playerInfo)

	if self._showPos ~= nil then
		var_8_1 = self._showPos
	else
		local var_8_2 = self.m_menuComp:getSize()

		if self._clickWorldPos.x + var_8_2.width > display.width then
			var_8_1.x = self._clickWorldPos.x - var_0_7 - var_8_2.width
			var_8_0 = false
		end

		if self._clickWorldPos.y + var_8_2.height > display.height then
			var_8_1.y = self._clickWorldPos.y - var_8_2.height
		end
	end

	if self._isRightPos ~= nil then
		var_8_0 = self._isRightPos
	end

	self.m_menuComp:setPosition(var_8_1)
	self.m_menuComp:setDir(var_8_0)
end

function InfoUserMenuPop:_onAddRequestSuc()
	g.core.module.ModuleManager:tip(g.core.lang:get(102517))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function InfoUserMenuPop:_onDeleteSuc()
	g.core.module.ModuleManager:tip(g.core.lang:get(102518))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function InfoUserMenuPop:_onBlackSuc()
	g.core.module.ModuleManager:tip(g.core.lang:get(102519))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function InfoUserMenuPop:_onDuel(arg_12_1, arg_12_2, arg_12_3)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	local var_12_0 = {}

	var_12_0.battle_id = 0
	var_12_0.atk_type = 2
	var_12_0.is_auto = false
	var_12_0.random_seeds = {}

	for iter_12_0 = 1, 50 do
		var_12_0.random_seeds[iter_12_0] = math.random(1000) - 1
	end

	var_12_0.own_teams = {
		arg_12_3.self
	}
	var_12_0.enemy_teams = {
		arg_12_3.enemy
	}

	g.core.battle.BattleProxy:enterBattle({
		noShare = true,
		soundType = 2,
		report = var_12_0,
		type = BattleConst.TYPE_FRIEND_PVP,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		skip = BattleConst.SKIP_TYPE.ACTIVE
	})
end

function InfoUserMenuPop:_onClick(arg_13_1, arg_13_2, arg_13_3)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return InfoUserMenuPop
