local NewCommanderSkillLayer = class("NewCommanderSkillLayer", import(".CommanderSkillLayer"))

function NewCommanderSkillLayer:getUIName()
	return "NewCommanderSkillUI"
end

function NewCommanderSkillLayer:didEnter()
	NewCommanderSkillLayer.super.didEnter(self)

	self.commonFlag = defaultValue(self.contextData.commonFlag, true)

	local var_2_0 = self._tf:Find("panel/bg/tags")

	onToggle(self, var_2_0, function(arg_3_0)
		self.commonFlag = arg_3_0

		self:UpdateList()

		return
	end, SFX_PANEL)
	triggerToggle(var_2_0, self.commonFlag)

	return
end

function NewCommanderSkillLayer:SetLocaliza()
	return
end

function NewCommanderSkillLayer:GetColor(arg_5_1)
	return arg_5_1 and "#66472a" or "#a3a2a2"
end

return NewCommanderSkillLayer
