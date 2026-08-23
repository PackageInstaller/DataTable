local ArtifactStarUpTalentPop = class("ArtifactStarUpTalentPop", require("app.fairyGUI.artifact.UI_ArtifactStarUpTalentPop"), function()
	return fgui.GComponent:create({
		resName = "ArtifactStarUpTalentPop",
		pkgPath = "ui/artifact/artifact",
		pkgName = "artifact"
	}, ...)
end)

function ArtifactStarUpTalentPop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onTalentListRenderer))

	self._artifactStruct = arg_2_1

	self:updateBreakUpTalent()
end

function ArtifactStarUpTalentPop:updateBreakUpTalent()
	local var_3_0 = self._artifactStruct:getBreakUpTalentSkill()

	self._talentList = var_3_0

	self.m_talentList:setNumItems(#var_3_0)
end

function ArtifactStarUpTalentPop:_onTalentListRenderer(arg_4_1, arg_4_2)
	if self._talentList then
		arg_4_2:updateBreakUpTalentDesc(self._talentList[arg_4_1], self._talentList[arg_4_1 + 1], self._artifactStruct)
	end
end

return ArtifactStarUpTalentPop
