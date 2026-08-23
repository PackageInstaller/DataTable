local RedCliffStageMatchUpgradeSuccessCell = class("RedCliffStageMatchUpgradeSuccessCell", require("app.fairyGUI.redCliff.UI_RedCliffStageMatchUpgradeSuccessCell"))

function RedCliffStageMatchUpgradeSuccessCell:ctor()
	self._finalUser = nil
end

function RedCliffStageMatchUpgradeSuccessCell:updateSuccessCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)

	if not arg_2_1 then
		return
	end

	arg_2_1.avata_id = arg_2_1.avatar_id
	self._finalUser = arg_2_1

	self.m_isSelfController:setSelectedIndex(arg_2_1.id == g.core.model.User:getId() and 1 or 0)
	self.m_rankComp:updateRankIndex({
		rank = arg_2_2 + 1
	})
	self.m_nameTxt:setText(arg_2_1.name or "")
	self.m_fightValue:setText(arg_2_1.fight_value or 0)
	self.m_server:setText(arg_2_1.server_name)
	self.m_score:setText(arg_2_1.score)
	self.m_headComp:updateAsUser(arg_2_1)
end

return RedCliffStageMatchUpgradeSuccessCell
