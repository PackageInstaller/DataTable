local var_0_0 = g.core.model.User.explorationData
local var_0_1 = g.core.config.knight_info
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local BattleResultExplorationRecordCell = class("BattleResultExplorationRecordCell", require("app.fairyGUI.battleResult.UI_BattleResultExplorationRecordCell"))

function BattleResultExplorationRecordCell:ctor()
	self.m_myTeamList:setVirtual()
	self.m_myTeamList:setItemRenderer(handler(self, self._onRenderMyTeamList))
	self.m_myTeamList:setScrollEnabled(false)
	self.m_rivalTeamList:setVirtual()
	self.m_rivalTeamList:setItemRenderer(handler(self, self._onRenderRivalTeamList))
	self.m_rivalTeamList:setScrollEnabled(false)
end

function BattleResultExplorationRecordCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._params = arg_2_1

	if not arg_2_1.roundNum then
		-- block empty
	end

	self._mulFormationStruct = arg_2_1.myMulTeam
	self._ownUnits = arg_2_1.ownUnits
	self._rivalTeamList = arg_2_1.formations
	self._enemyUnits = arg_2_1.enemyUnits

	self.m_roundTxt:setText(arg_2_1.roundNum or "")
	self.m_resultController:setSelectedIndex(arg_2_1.result == 1 and 1 or 0)
	self.m_myTeamList:setNumItems(6)
	self.m_rivalTeamList:setNumItems(6)
end

function BattleResultExplorationRecordCell:_onRenderMyTeamList(arg_3_1, arg_3_2)
	local var_3_0 = self._mulFormationStruct:getKnightSid(arg_3_1 + 1)
	local var_3_1

	if var_3_0 ~= 0 then
		local var_3_2 = {}

		var_3_2.struct = var_0_0:getFormationData():getKnightByServerId(var_3_0)
		var_3_1 = var_3_2
	end

	if var_3_1 then
		arg_3_2:getController("isDie"):setSelectedIndex((self._ownUnits[arg_3_1 + 1] or 1) > 0 and 0 or 1)
	end

	arg_3_2:updateComp(arg_3_1 + 1, var_3_1, nil, false)
end

function BattleResultExplorationRecordCell:_onRenderRivalTeamList(arg_4_1, arg_4_2)
	local var_4_1

	if self._rivalTeamList[arg_4_1 + 1] and self._rivalTeamList[arg_4_1 + 1].id ~= 0 then
		var_4_1 = self:_getKnightStructByBaseId(self._rivalTeamList[arg_4_1 + 1].id)
	end

	if var_4_1 then
		arg_4_2:getController("isDie"):setSelectedIndex((self._enemyUnits[arg_4_1 + 1] or 1) > 0 and 0 or 1)
	end

	if var_4_1 then
		arg_4_2:updateComp(arg_4_1 + 1, {
			struct = var_4_1
		}, true)
	else
		arg_4_2:updateComp(arg_4_1 + 1, nil, true)
	end
end

function BattleResultExplorationRecordCell:_getKnightStructByBaseId(arg_5_1)
	local var_5_0

	if arg_5_1 > 0 then
		local var_5_1 = var_0_1.get(arg_5_1)

		var_5_0 = KnightStruct.new(var_5_1.advance_id)

		var_5_0:addCfgInfo(var_5_1)
	end

	return var_5_0
end

return BattleResultExplorationRecordCell
