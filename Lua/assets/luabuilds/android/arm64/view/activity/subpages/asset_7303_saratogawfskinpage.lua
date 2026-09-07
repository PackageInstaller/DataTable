local SaratogaWFSkinPage = class("SaratogaWFSkinPage", import(".TemplatePage.PtTemplatePage"))

function SaratogaWFSkinPage:OnFirstFlush()
	onButton(self, self.displayBtn, function()
		self:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			type = self.ptData.type,
			dropList = self.ptData.dropList,
			targets = self.ptData.targets,
			level = self.ptData.level,
			count = self.ptData.count,
			resId = self.ptData.resId
		})

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		local var_4_0, var_4_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_4_1
		})

		return
	end, SFX_PANEL)

	return
end

function SaratogaWFSkinPage:OnUpdateFlush()
	SaratogaWFSkinPage.super.OnUpdateFlush(self)

	local var_5_0, var_5_1, var_5_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_5_0, "#F294B8FF") .. "/" .. var_5_1)

	return
end

return SaratogaWFSkinPage
