local var_0_0 = g.core.model.User.crossServerArenaData
local var_0_1 = g.core.model.User.mulFormationData
local BattleResultCSArenaRecordComp = class("BattleResultCSArenaRecordComp", require("app.fairyGUI.battleResult.UI_BattleResultCSArenaRecordComp"))

function BattleResultCSArenaRecordComp:ctor()
	self._resultList = nil
	self._battleInfo = nil

	self.m_resultList:setVirtual()
	self.m_resultList:setItemRenderer(handler(self, self._onRenderResultList))
	self.m_resultList:setScrollEnabled(false)
	self.m_resultList:setTouchable(false)

	if require("app.view.battle.const.BattleConst").TYPE_FRIEND_PVP == g.core.battle.BattleProxy:getType() then
		self.m_hideRankController:setSelectedIndex(1)
	end
end

function BattleResultCSArenaRecordComp:update(arg_2_1)
	self._resultList = arg_2_1.multiResult
	self._battleInfo = g.core.model.User.crossServerArenaData:getCacheBattleInfo()
	self._ownUnits, self._enemyUnits = self:_arrangeUnitsByPos(arg_2_1.waveUnits)

	self.m_resultList:setNumItems(#self._resultList)

	local var_2_0 = var_0_0:getCurRank()

	if var_2_0 < var_0_0:getCachedRank().oldRank then
		self.m_stateController:setSelectedIndex(0)
		self.m_rankTxt:setText(var_2_0)
	else
		self.m_stateController:setSelectedIndex(1)
		self.m_rankTxt:setText(g.core.lang:get(411009))
	end
end

function BattleResultCSArenaRecordComp:_arrangeUnitsByPos(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_3_0[iter_3_0] = {}

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.own_units) do
			var_3_0[iter_3_0][iter_3_3.pos] = iter_3_3.hp
		end

		var_3_1[iter_3_0] = {}

		for iter_3_4, iter_3_5 in ipairs(iter_3_1.enemy_units) do
			var_3_1[iter_3_0][iter_3_5.pos] = iter_3_5.hp
		end
	end

	return var_3_0, var_3_1
end

function BattleResultCSArenaRecordComp:_onRenderResultList(arg_4_1, arg_4_2)
	arg_4_2:updateCell({
		result = self._resultList[arg_4_1 + 1],
		roundNum = arg_4_1 + 1,
		myMulTeam = var_0_1:getFormationStructDict(g.core.const.ConstMgr.LineUpConst.MulTeamType.CROSS_SERVER_ARENA),
		formations = var_0_0:getCacheBattleInfo().rivalTeam.formations,
		ownUnits = self._ownUnits[arg_4_1 + 1],
		enemyUnits = self._enemyUnits[arg_4_1 + 1]
	})
end

return BattleResultCSArenaRecordComp
