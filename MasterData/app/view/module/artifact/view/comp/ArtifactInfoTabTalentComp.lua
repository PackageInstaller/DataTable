local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_1 = g.core.model.User.artifactData
local ArtifactInfoTabTalentComp = class("ArtifactInfoTabTalentComp", require("app.fairyGUI.artifact.UI_ArtifactInfoTabTalentComp"))

function ArtifactInfoTabTalentComp:ctor()
	self.m_skillList:setIniter()
	self.m_skillList:setItemRenderer(handler(self, self._onStarUpSkillListRenderer))
	self.m_talentList:setIniter()
	self.m_talentList:setItemRenderer(handler(self, self._onTalentListRenderer))
	self.m_talentList2:setIniter()
	self.m_talentList2:setItemRenderer(handler(self, self._onBreakUpTalentListRenderer))
	self.m_talentList3:setIniter()
	self.m_talentList3:setItemRenderer(handler(self, self._onSpiritTalentListRenderer))
end

function ArtifactInfoTabTalentComp:updateShow(arg_2_1)
	self._artifactStruct = arg_2_1.artifactData

	if self._artifactStruct then
		self._artifactBaseId = self._artifactStruct:getArtifactBaseId()

		self:_updateStarUpSkillInfo()
		self:_updateStrengthTalentInfo()
	end
end

function ArtifactInfoTabTalentComp:_updateStarUpSkillInfo()
	local var_3_0, var_3_1, var_3_2 = var_0_1:getArtifactShowAllSkillsByBaseId(self._artifactBaseId)

	self._skillShowInfo = var_3_0

	self.m_skillList:setNumItems(#var_3_0)

	if var_3_2 > 0 then
		self.m_skillList:scrollToView(var_3_2 - 1)
	end

	self.m_skillList:resizeToFit(#var_3_0)
end

function ArtifactInfoTabTalentComp:_updateStrengthTalentInfo()
	local var_4_0, var_4_1 = var_0_1:getCurArtifactAllEnhanceTalentInfo(self._artifactStruct:getUpgradeCodeId(), (self._artifactStruct:getLevel()))

	self._strengthTalentList = var_4_0

	self.m_talentList:setNumItems(#self._strengthTalentList)
	self.m_talentList:resizeToFit(#self._strengthTalentList)

	self._breakUpTalentList = self._artifactStruct:getBreakUpTalentSkill()

	if #self._breakUpTalentList > 0 then
		self.m_talentList2:setVisible(true)
		self.m_talentList2:setNumItems(#self._breakUpTalentList)
		self.m_talentList2:resizeToFit(#self._breakUpTalentList)
		self.m_breakUpTitleComp:setVisible(true)
	else
		self.m_breakUpTitleComp:setVisible(false)
		self.m_talentList2:setVisible(false)
	end

	self._spiritTalentList = self._artifactStruct:getSpiritFullTalentSkill()

	if #self._spiritTalentList > 0 then
		self.m_talentList3:setNumItems(#self._spiritTalentList)
		self.m_talentList3:resizeToFit(#self._spiritTalentList)
		self.m_talentList3:setVisible(true)
		self.m_spiritTitleComp:setVisible(true)
	else
		self.m_spiritTitleComp:setVisible(false)
		self.m_talentList3:setVisible(false)
	end
end

function ArtifactInfoTabTalentComp:_onStarUpSkillListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateDesc(self._skillShowInfo[arg_5_1 + 1])
end

function ArtifactInfoTabTalentComp:_onTalentListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateDesc(self._strengthTalentList[arg_6_1 + 1], true)
end

function ArtifactInfoTabTalentComp:_onBreakUpTalentListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateBreakUpTalentDesc(self._breakUpTalentList[arg_7_1], self._breakUpTalentList[arg_7_1 + 1], self._artifactStruct)
end

function ArtifactInfoTabTalentComp:_onSpiritTalentListRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateSpiritTalentDesc(self._spiritTalentList[arg_8_1], self._spiritTalentList[arg_8_1 + 1], self._artifactStruct)
end

return ArtifactInfoTabTalentComp
