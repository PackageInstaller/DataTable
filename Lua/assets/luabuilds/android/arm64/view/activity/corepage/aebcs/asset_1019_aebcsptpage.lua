local AEBCSPtPage = class("AEBCSPtPage", import("view.activity.CorePage.CorePtTemplatePage"))

function AEBCSPtPage:OnInit()
	self.bg = self._tf:Find("AD/task_bg")
	self.progress = self.bg:Find("progress")
	self.progres = self.bg:Find("progres")
	self.slider = self.bg:Find("slider")
	self.step = self.bg:Find("step")
	self.displayBtn = self.bg:Find("display_btn")
	self.awardTF = self.bg:Find("award")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.battleBtn = self.bg:Find("battle_btn")

	setText(self.displayBtn:Find("Text"), i18n("other_world_temple_award"))
	setText(self.bg:Find("Text"), i18n("Outpost_20250904_Progress"))

	return
end

function AEBCSPtPage:OnFirstFlush()
	self.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function AEBCSPtPage:OnUpdateFlush()
	AEBCSPtPage.super.OnUpdateFlush(self)

	local var_4_0, var_4_1, var_4_2 = self.ptData:GetResProgress()

	setText(self.progress, "/" .. var_4_1)
	setText(self.progres, var_4_2 >= 1 and setColorStr(var_4_0, "#6ef0ff") or var_4_0)

	return
end

return AEBCSPtPage
