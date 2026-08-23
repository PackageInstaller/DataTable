local RedCliffStageRankCell = class("RedCliffStageRankCell", require("app.fairyGUI.redCliff.UI_RedCliffStageRankCell"))

function RedCliffStageRankCell:updateRankCell(arg_1_1, arg_1_2)
	self.m_rank:setText(arg_1_2)

	if arg_1_1 then
		self.m_name:setText(arg_1_1.name or "")
		self.m_score:setText(arg_1_1.score or 0)
	end
end

return RedCliffStageRankCell
