local var_0_0 = g.core.common.Path
local TeamBattleLimitBossDiffComp = class("TeamBattleLimitBossDiffComp", require("app.fairyGUI.teamBattle.UI_TeamBattleLimitBossDiffComp"))

function TeamBattleLimitBossDiffComp:updateBossInfo(arg_1_1)
	local var_1_0 = arg_1_1:getBossLeftHpRatio()

	self._hp = math.floor(var_1_0 / 10)

	local var_1_1 = arg_1_1:getEventInfo().monsterInfo

	self._maxHp = 100

	self.m_isDeadController:setSelectedIndex(var_1_0 <= 1 and 1 or 0)
	self.m_hpProgress:setPercent({
		cur = self._hp,
		max = self._maxHp
	})
	self.m_progressTxt:setText(g.core.lang:get(2073, {
		num = self._hp
	}))

	if var_1_1.killUid > 0 then
		local var_1_2 = g.core.model.User.teamBattleData:getMapData():getPlayerStruct(var_1_1.killUid)
		local var_1_3

		if not var_1_2 then
			do return end

			var_1_3 = {}
		end

		var_1_3.name = var_1_2:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER).name

		self.m_killerTxt:setText(g.core.lang:get(427149, var_1_3))
	else
		self.m_killerTxt:setText("")
	end

	self.m_diffLoader:setURL(var_0_0:getTeamBattleDiffIcon(var_1_1.diff))
end

return TeamBattleLimitBossDiffComp
