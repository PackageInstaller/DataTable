local TeamBattleAllLordLayer = class("TeamBattleAllLordLayer", require("app.fairyGUI.teamBattle.UI_TeamBattleAllLordLayer"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleAllLordLayer",
		pkgPath = "ui/teamBattle/teamBattle",
		isFullScreen = true,
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleAllLordLayer:ctor()
	self:addBg("bg/teamBattle/bg_hjtj_jszhanshi.jpg")
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
end

function TeamBattleAllLordLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMRANK, handler(self, self._onS2CTeamBattleTeamRank), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._checkAllTeam), self)
	g.core.network.GameNetProxy:send_C2S_TeamBattle_TeamRank({})
end

function TeamBattleAllLordLayer:_onS2CTeamBattleTeamRank(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self:_checkAllTeam()
end

function TeamBattleAllLordLayer:_checkAllTeam()
	local var_5_0 = g.core.model.User.teamBattleData:getRankInfo()

	if not var_5_0 or not var_5_0.list or #var_5_0.list < 1 then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	end

	local var_5_1 = var_5_0.list
	local var_5_2 = true

	for iter_5_0 = 1, math.min(3, #var_5_0.list) do
		if not g.core.model.User.teamBattleData:getTeamUpData():checkTeamMemberSnapShot(var_5_1[iter_5_0]) then
			var_5_2 = false
		end
	end

	if var_5_2 then
		self.m_allUserComp:updateRankLordComp()
		self.m_enterTransition:play()
	end

	self.m_isEmptyController:setSelectedIndex(0)
end

function TeamBattleAllLordLayer:_onRankBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_RANK_LAYER)
end

function TeamBattleAllLordLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.TEAM_BATTLE
	})
end

return TeamBattleAllLordLayer
