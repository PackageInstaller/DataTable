local var_0_0 = g.core.model.User.explorationData
local BattleResultExplorationRecordComp = class("BattleResultExplorationRecordComp", require("app.fairyGUI.battleResult.UI_BattleResultExplorationRecordComp"))

function BattleResultExplorationRecordComp:ctor()
	self._resultList = nil

	self.m_resultList:setVirtual()
	self.m_resultList:setItemRenderer(handler(self, self._onRenderResultList))
	self.m_resultList:setScrollEnabled(false)
end

function BattleResultExplorationRecordComp:update(arg_2_1)
	if not arg_2_1.result then
		return
	end

	self._resultList = arg_2_1.result.multi_result
	self._ownUnits, self._enemyUnits = self:_arrangeUnitsByPos(arg_2_1.result.wave_units)
	self._enemyFormations = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.result.enemy_teams) do
		local var_2_0 = self._enemyFormations[iter_2_1.seq]

		if not self._enemyFormations[iter_2_1.seq] then
			var_2_0 = {}
			self._enemyFormations[iter_2_1.seq] = var_2_0
		end

		var_2_0[#var_2_0 + 1] = iter_2_1
	end

	self.m_resultList:setNumItems(#self._resultList)
end

function BattleResultExplorationRecordComp:_arrangeUnitsByPos(arg_3_1)
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

function BattleResultExplorationRecordComp:_onRenderResultList(arg_4_1, arg_4_2)
	local var_4_0 = {
		result = self._resultList[arg_4_1 + 1],
		roundNum = arg_4_1 + 1
	}

	var_4_0.myMulTeam = var_0_0:getFormationData():getFormationStruct(arg_4_1 + 1)
	var_4_0.formations = self._enemyFormations[arg_4_1 + 1]
	var_4_0.ownUnits = self._ownUnits[arg_4_1 + 1]
	var_4_0.enemyUnits = self._enemyUnits[arg_4_1 + 1]

	arg_4_2:updateCell(var_4_0)
end

return BattleResultExplorationRecordComp
