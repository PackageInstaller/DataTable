local TeamBattleActiveResultPop = class("TeamBattleActiveResultPop", require("app.fairyGUI.teamBattle.UI_TeamBattleActiveResultPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleActiveResultPop",
		pkgName = "teamBattle"
	})
end)

function TeamBattleActiveResultPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._endcall = arg_2_1.endcall
	end

	self:showAtCenter()
end

function TeamBattleActiveResultPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMRANK, handler(self, self._onS2CTeamBattleTeamRank), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._checkAllTeam), self)
	g.core.network.GameNetProxy:send_C2S_TeamBattle_TeamRank({})
end

function TeamBattleActiveResultPop:_onS2CTeamBattleTeamRank()
	self:_checkAllTeam()
end

function TeamBattleActiveResultPop:_checkAllTeam()
	self._rankDatas = g.core.model.User.teamBattleData:getRankInfo().list

	local var_5_0 = true

	for iter_5_0 = 1, math.min(3, #self._rankDatas) do
		if not g.core.model.User.teamBattleData:getTeamUpData():checkTeamMemberSnapShot(self._rankDatas[iter_5_0]) then
			var_5_0 = false
		end
	end

	if var_5_0 then
		self:_updateTopThree()
	end
end

function TeamBattleActiveResultPop:_updateTopThree()
	if self._rankDatas[1] and self._rankDatas[1].members then
		for iter_6_0 = 1, 3 do
			if self._rankDatas[1].members[iter_6_0] then
				self._rankDatas[1].user = self._rankDatas[1].snapShotDic[self._rankDatas[1].members[iter_6_0]] or {}

				if g.core.config.knight_info.fetch(self._rankDatas[1].snapShotDic[self._rankDatas[1].members[iter_6_0]].base_id) then
					local var_6_0 = {}

					if self._rankDatas[1].snapShotDic[self._rankDatas[1].members[iter_6_0]].show_knight_dress > 0 then
						var_6_0.resId = self._rankDatas[1].snapShotDic[self._rankDatas[1].members[iter_6_0]].show_knight_dress or self._rankDatas[1].snapShotDic[self._rankDatas[1].members[iter_6_0]].show_knight_id
					end

					self["m_knightLoader" .. iter_6_0]:updateMaskComp(var_6_0)
				end

				self["m_rank" .. iter_6_0]:updateKnight(self._rankDatas[1].snapShotDic[self._rankDatas[1].members[iter_6_0]])
			else
				self["m_knightLoader" .. iter_6_0]:setVisible(false)
				self["m_rank" .. iter_6_0]:setVisible(false)
			end
		end
	end
end

function TeamBattleActiveResultPop:homeLayerAutoPopup()
	if self._endcall then
		self._endcall()
	end
end

return TeamBattleActiveResultPop
