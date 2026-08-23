local ArtifactSkillShowComp = class("ArtifactSkillShowComp", require("app.fairyGUI.artifact.UI_ArtifactSkillShowComp"))

function ArtifactSkillShowComp:ctor(arg_1_1)
	self._data = nil

	self.m_starUpList:setIniter()
	self.m_starUpList:setItemRenderer(handler(self, self._onStarUpListRenderer))
end

function ArtifactSkillShowComp:onLoad()
	return
end

function ArtifactSkillShowComp:updateView(arg_3_1, arg_3_2)
	self._skillShowInfo = arg_3_1
	self._isStage = arg_3_2

	self.m_starUpList:setNumItems(#self._skillShowInfo)
	self.m_starUpList:resizeToFit(#self._skillShowInfo)
end

function ArtifactSkillShowComp:scrollView(arg_4_1)
	self.m_starUpList:scrollToView(arg_4_1)
end

function ArtifactSkillShowComp:setSkillText(arg_5_1)
	self.m_skillDescTxt:setText(arg_5_1)
end

function ArtifactSkillShowComp:_onStarUpListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateDesc(self._skillShowInfo[arg_6_1 + 1], nil, self._isFrag, self._isStage)
end

return ArtifactSkillShowComp
