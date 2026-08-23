local ArtifactHandBookAchievementPop = class("ArtifactHandBookAchievementPop", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookAchievementPop"), function()
	return fgui.GComponent:create({
		resName = "ArtifactHandBookAchievementPop",
		pkgPath = "ui/artifactHandbook/artifactHandbook",
		pkgName = "artifactHandbook"
	}, ...)
end)

function ArtifactHandBookAchievementPop:ctor()
	self:showAtCenter()
	self.m_showComp:updateArtifactAchievementCell()
end

function ArtifactHandBookAchievementPop:playTouchCloseAnimAndCallBack(arg_3_1)
	self.m_bgPanel:getCloseTransition():play(function()
		arg_3_1()
	end)
end

return ArtifactHandBookAchievementPop
