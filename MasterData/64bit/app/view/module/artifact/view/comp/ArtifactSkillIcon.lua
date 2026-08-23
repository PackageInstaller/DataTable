local var_0_0 = g.core.model.User
local ArtifactSkillIcon = class("ArtifactSkillIcon", require("app.fairyGUI.artifact.UI_ArtifactSkillIcon"))

function ArtifactSkillIcon:ctor()
	self:addClickListener(handler(self, self._onSkillClick))
end

function ArtifactSkillIcon:updateIcon(arg_2_1)
	self._data = arg_2_1
	self._isOverClick = not not arg_2_1.overClick
	self._artifactData = arg_2_1.artifact
	self._knightPos = arg_2_1.knightPos
	self._artifactBaseId = self._artifactData:getArtifactBaseId()

	if self._artifactData then
		local var_2_1 = self._artifactBaseId

		if arg_2_1.isNextSkill then
			var_2_1 = self._artifactData:getNextArtifactBaseId()
			self._artifactBaseId = var_2_1
		end

		local var_2_2 = g.core.config.artifact_info.get(var_2_1)
		local var_2_3 = var_2_2.star
		local var_2_4 = g.core.common.Path:getSkillIconById(var_2_2.skill_icon_1)

		if not cc.FileUtils:getInstance():isFileExist(var_2_4) then
			var_2_4 = g.core.common.Path:getSkillIconById(2)
		end

		self:setIcon(var_2_4)
		self.m_skillStateController:setSelectedIndex(var_2_3 and var_2_3 or 0)
		self.m_isRelatedController:setSelectedIndex(var_0_0.artifactData:isRelatedByAdvanceId(self._artifactData, self._knightPos) and 1 or 0)
		self.m_isLineUpController:setSelectedIndex(arg_2_1.isLineUpModel and 1 or 0)
	end
end

function ArtifactSkillIcon:setRelatedController(arg_3_1)
	self.m_isRelatedController:setSelectedIndex(arg_3_1)
end

function ArtifactSkillIcon:updateSpiritSkillIcon(arg_4_1)
	self._data = arg_4_1
	self._isOverClick = not not arg_4_1.overClick
	self._artifactData = arg_4_1.artifact

	local var_4_0 = arg_4_1.isLineUpModel

	arg_4_1.advanceId = self._artifactData:getAdvanceId()

	self.m_isRelatedController:setSelectedIndex(1)

	if self._artifactData then
		local var_4_1 = self._artifactData:getArtifactBaseId()

		if arg_4_1.isNextSkill then
			local var_4_2 = self._artifactData:getNextArtifactBaseId()
		end

		local var_4_3 = self._artifactData:getSpiritStage()
		local var_4_4 = self._artifactData:getCurSpiritSkillStar()
		local var_4_5 = self._artifactData:getSpiritAdjointSkillIcon((arg_4_1.isNextSkill or nil) and (var_4_3 + 1 or var_4_3))

		if not self._artifactData:isAdjointSkillActive() then
			var_4_5 = self._artifactData:getSpiritAdjointSkillIcon(self._artifactData:getFirstActiveAdjointStage())
		end

		var_4_4 = arg_4_1.isNextSkill and var_4_4 + 1 or var_4_4

		local var_4_6 = g.core.common.Path:getSkillIconById(var_4_5)

		if not cc.FileUtils:getInstance():isFileExist(var_4_6) then
			var_4_6 = g.core.common.Path:getSkillIconById(2)
		end

		self:setIcon(var_4_6)

		var_4_4 = var_4_4 > 5 and 5 or var_4_4

		self.m_skillStateController:setSelectedIndex(var_4_4 and var_4_4 or 0)
		self.m_isLineUpController:setSelectedIndex(var_4_0 and 1 or 0)
	end
end

function ArtifactSkillIcon:_onSkillClick()
	if not self._isOverClick then
		if self._artifactBaseId then
			local var_5_0 = clone(self._data)

			var_5_0.artifactBaseId = self._artifactBaseId

			g.core.module.ModuleManager:pushPopup(require("app.view.module.artifact.view.ArtifactSkillShowPop").new(var_5_0), {
				touchDisappear = true
			})
		elseif self._artifactData then
			local var_5_1 = clone(self._data)

			var_5_1.isStage = true

			g.core.module.ModuleManager:pushPopup(require("app.view.module.artifact.view.ArtifactSkillShowPop").new(var_5_1), {
				touchDisappear = true
			})
		end
	end
end

return ArtifactSkillIcon
