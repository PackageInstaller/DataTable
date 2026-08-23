local ArtifactSkillShowPop = class("ArtifactSkillShowPop", require("app.fairyGUI.artifact.UI_ArtifactSkillShowPop"), function()
	return fgui.GComponent:create({
		resName = "ArtifactSkillShowPop",
		pkgPath = "ui/artifact/artifact",
		pkgName = "artifact"
	}, ...)
end)

function ArtifactSkillShowPop:ctor(arg_2_1)
	self:showAtCenter()

	if arg_2_1 then
		self._artifactBaseId = arg_2_1.artifactBaseId or nil
	end

	if arg_2_1 then
		self._advanceId = arg_2_1.advanceId or nil
	end

	if arg_2_1 then
		self._isNextSkill = arg_2_1.isNextSkill or nil
	end

	self._data = arg_2_1

	if arg_2_1 then
		self._isStage = arg_2_1.isStage or false
	end
end

function ArtifactSkillShowPop:onLoad()
	if not self._data then
		return
	end

	self._isFrag = self._data.isFrag

	if self._artifactBaseId then
		self.m_typeController:setSelectedIndex(0)

		local var_3_0, var_3_1, var_3_2 = g.core.model.User.artifactData:getArtifactShowAllSkillsByBaseId(self._artifactBaseId)

		self:updateSkillShow(var_3_0, var_3_1, var_3_2)
	elseif self._advanceId then
		self.m_typeController:setSelectedIndex(1)

		local var_3_3, var_3_4, var_3_5 = g.core.model.User.artifactData:getArtifactSpiritShowAllSkills(self._advanceId, self._isNextSkill)

		self:updateSkillShow(var_3_3, var_3_4, var_3_5)
	end
end

function ArtifactSkillShowPop:updateSkillShow(arg_4_1, arg_4_2, arg_4_3)
	self._skillShowInfo = arg_4_1

	local var_4_0 = arg_4_2 or arg_4_1[1]

	if #arg_4_1 > 0 then
		self._data.overClick = true

		if self._isStage then
			self.m_skillIconComp:updateSpiritSkillIcon(self._data)
		else
			self.m_skillIconComp:updateIcon(self._data)
		end

		self.m_nameTxt:setText(var_4_0.name)
		self.m_skillComp:setSkillText(var_4_0.desc)
		self:_updateBuffDesc(var_4_0.buffDesc)
		self.m_bgPanel:setQuality(var_4_0.quality + 1)

		if self._isFrag then
			self.m_skillComp:setSkillText(arg_4_1[#arg_4_1].desc)
		end

		self.m_skillComp:updateView(arg_4_1, self._isStage)

		if not self._isFrag and arg_4_3 > 0 then
			self.m_skillComp:scrollView(arg_4_3 - 1)
		end
	end
end

function ArtifactSkillShowPop:_updateBuffDesc(arg_5_1)
	arg_5_1 = arg_5_1 or ""

	if #arg_5_1 == 0 or arg_5_1 == "0" then
		self.m_buffDescLabel:setVisible(false)
	else
		self.m_buffDescLabel:getChild("title"):enableRich()
		self.m_buffDescLabel:setTitle(arg_5_1)
		self.m_buffDescLabel:setVisible(true)
	end
end

return ArtifactSkillShowPop
