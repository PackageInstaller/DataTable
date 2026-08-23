local ArtifactSpiritTalentTip = class("ArtifactSpiritTalentTip", require("app.fairyGUI.artifact.UI_ArtifactSpiritTalentTip"), function()
	return fgui.GComponent:create({
		resName = "ArtifactSpiritTalentTip",
		pkgPath = "ui/artifact/artifact",
		pkgName = "artifact"
	}, ...)
end)

function ArtifactSpiritTalentTip:ctor(arg_2_1)
	self:showAtCenter()
	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onTalentListRenderer))

	self._artifactStruct = arg_2_1
	self._curStage = arg_2_1:getSpiritStage()

	self:updateSpiritTalent()
end

function ArtifactSpiritTalentTip:updateSpiritTalent()
	local var_3_0 = self._artifactStruct:getSpiritFullTalentSkill()

	self._talentList = var_3_0

	self.m_talentList:setNumItems(#var_3_0)
end

function ArtifactSpiritTalentTip:_onTalentListRenderer(arg_4_1, arg_4_2)
	if self._talentList then
		arg_4_2:updateSpiritTalentDesc(self._talentList[arg_4_1], self._talentList[arg_4_1 + 1], self._artifactStruct)
	end
end

return ArtifactSpiritTalentTip
