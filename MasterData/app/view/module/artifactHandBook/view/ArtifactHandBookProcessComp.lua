local var_0_0 = g.core.model.User.artifactHandBookData
local ArtifactHandBookProcessComp = class("ArtifactHandBookProcessComp", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookProcessComp"))

function ArtifactHandBookProcessComp:ctor()
	self:updateView()
end

function ArtifactHandBookProcessComp:updateView()
	self:_setProgressShow()
end

function ArtifactHandBookProcessComp:_setProgressShow()
	local var_3_0 = var_0_0:getURHandBookScore()
	local var_3_1 = var_0_0:getCurAndNextScoreInfo()
	local var_3_2 = 0
	local var_3_3 = 0
	local var_3_4 = 0

	if not var_3_1.cur then
		var_3_4 = 0
		var_3_3 = var_3_0
		var_3_2 = var_3_1.next.score
	elseif not var_3_1.next then
		var_3_4 = var_3_1.cur.id
		var_3_3 = var_3_1.cur.score
		var_3_2 = var_3_1.cur.score
	else
		var_3_4 = var_3_1.cur.id
		var_3_3 = var_3_0 - var_3_1.cur.score
		var_3_2 = var_3_1.next.score - var_3_1.cur.score
	end

	self.m_levelTxt:setText(g.core.lang:get(205526, {
		num = var_3_4
	}))

	self._curLevel = var_3_4

	self.m_progressTxt:setText(g.core.lang:get(111510, {
		frontNum = var_3_3,
		behindNum = var_3_2
	}))
	self.m_bookProcess:setMax(var_3_2)
	self.m_bookProcess:setValue(var_3_3)
end

return ArtifactHandBookProcessComp
