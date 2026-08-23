local RedCliffStageMatchUserCell = class("RedCliffStageMatchUserCell", require("app.fairyGUI.redCliff.UI_RedCliffStageMatchUserCell"))

function RedCliffStageMatchUserCell:ctor()
	self._matchUser = nil
end

function RedCliffStageMatchUserCell:updateMatchUserCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)

	if not arg_2_1 then
		return
	end

	self._matchUser = arg_2_1

	self.m_isSelfController:setSelectedIndex(arg_2_1.id == g.core.model.User:getId() and 1 or 0)
	self.m_index:setText(arg_2_2 + 1)
	self.m_nameTxt:setText(arg_2_1.name or "")
	self.m_fightValue:setText(arg_2_1.fight_value or 0)
	self.m_headComp:updateAsUser(arg_2_1)
	self.m_server:setText(arg_2_1.server_name)
end

return RedCliffStageMatchUserCell
