local RedCliffMatchRankResultPop = class("RedCliffMatchRankResultPop", require("app.fairyGUI.redCliff.UI_RedCliffMatchRankResultPop"), function()
	return fgui.GComponent:create({
		resName = "RedCliffMatchRankResultPop",
		pkgPath = "ui/redCliff/redCliff",
		pkgName = "redCliff"
	})
end)

function RedCliffMatchRankResultPop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_rank:setText(arg_2_1.rank)
end

return RedCliffMatchRankResultPop
