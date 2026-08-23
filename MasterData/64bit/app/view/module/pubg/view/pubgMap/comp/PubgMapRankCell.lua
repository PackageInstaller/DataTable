local PubgMapRankCell = class("PubgMapRankCell", require("app.fairyGUI.pubg.UI_PubgMapRankCell"))

function PubgMapRankCell:ctor()
	return
end

function PubgMapRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_rankText:setText(arg_2_2)

	if arg_2_1 then
		self.m_nameText:setText(arg_2_1:getName())
		self.m_scoreText:setText(arg_2_1:getScore())
	end
end

return PubgMapRankCell
