local TeamBattleBuffBagPop = class("TeamBattleBuffBagPop", require("app.fairyGUI.teamBattle.UI_TeamBattleTeamListPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleTeamListPop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	})
end)

function TeamBattleBuffBagPop:ctor(arg_2_1)
	self:showAtCenter()

	self._teamList = nil

	self:_initView()
end

function TeamBattleBuffBagPop:_initView()
	self.m_searchBtn:addClickListener(handler(self, self._onClickedSearchBtn))
	self.m_refreshBtn:addClickListener(handler(self, self._onClickedRefreshBtn))
	self.m_teamList:setVirtual()
	self.m_teamList:setItemRenderer(handler(self, self._onTeamItemRender))
	self.m_teamList:doFairyBatching(false)
	self.m_nameInput:setPrompt(g.core.lang:get(427005))
end

function TeamBattleBuffBagPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMLIST, handler(self, self.onS2CTeamBattleTeamList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_JOINTEAM, handler(self, self.onS2CTeamBattleJoinTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_FINDTEAM, handler(self, self.onS2CTeamBattleFindTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.onS2CGetUserSnapShot, self)

	if not self._teamList then
		g.core.network.GameNetProxy:send_C2S_TeamBattle_TeamList({})
	end
end

function TeamBattleBuffBagPop:_onTeamItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._teamList[arg_5_1 + 1])
end

function TeamBattleBuffBagPop:_onClickedSearchBtn()
	local var_6_0 = self.m_nameInput:getInputStr()

	if #var_6_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_TeamBattle_FindTeam({
			name = var_6_0
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(427005))
	end
end

function TeamBattleBuffBagPop:_onClickedRefreshBtn()
	g.core.network.GameNetProxy:send_C2S_TeamBattle_TeamList({})
end

function TeamBattleBuffBagPop:onS2CGetUserSnapShot(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = true
	local var_8_1 = g.core.model.User.teamBattleData:getTeamUpData()

	for iter_8_0, iter_8_1 in ipairs(self._teamList) do
		if not var_8_1:checkTeamMemberSnapShot(iter_8_1) then
			var_8_0 = false

			break
		end
	end

	if var_8_0 then
		self:_updateView()
	end
end

function TeamBattleBuffBagPop:_updateView()
	self.m_teamList:setNumItems(#self._teamList)

	if #self._teamList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
	elseif #self.m_nameInput:getInputStr() < 1 then
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function TeamBattleBuffBagPop:onS2CTeamBattleTeamList(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self._teamList = g.core.model.User.teamBattleData:getTeamUpData():getTeamList() or {}

	self.m_nameInput:setInputStr("")
	self:onS2CGetUserSnapShot(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
end

function TeamBattleBuffBagPop:onS2CTeamBattleFindTeam(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self._teamList = {
		g.core.model.User.teamBattleData:getTeamUpData():getSearchTeam()
	}

	if #self._teamList == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(427119))
	end

	self:onS2CGetUserSnapShot(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
end

function TeamBattleBuffBagPop:onS2CTeamBattleJoinTeam(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_TEAM_UP_LAYER)
end

return TeamBattleBuffBagPop
