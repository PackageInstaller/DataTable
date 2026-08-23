local ArtifactSpiritStageInfoComp = class("ArtifactSpiritStageInfoComp", require("app.fairyGUI.artifact.UI_ArtifactSpiritStageInfoComp"))

function ArtifactSpiritStageInfoComp:updateInfoAttr(arg_1_1, arg_1_2, arg_1_3)
	self.m_nameTxt:setText(arg_1_1)
	self.m_oldAttrTxt:setText(arg_1_2)
	self.m_attrTxt:setText(arg_1_3)
end

return ArtifactSpiritStageInfoComp
