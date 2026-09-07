local AEBCSHestiaPage = class("AEBCSHestiaPage", import("view.activity.CorePage.BRS.HeiYanPtPage"))

function AEBCSHestiaPage:OnInit()
	AEBCSHestiaPage.super.OnInit(self)
	setText(self.displayBtn:Find("Text"), i18n("other_world_temple_award"))
	setText(self.task_bg:Find("schedule"), i18n("Outpost_20250904_Progress"))

	return
end

function AEBCSHestiaPage:OnUpdateFlush()
	self.super.OnUpdateFlush(self)

	local var_2_0, var_2_1, var_2_2 = self.ptData:GetResProgress()

	setText(self.progress, "/" .. var_2_1)
	setText(self.progres, var_2_2 >= 1 and setColorStr(var_2_0, "#2572ff") or var_2_0)
	setSlider(self.slider, 0, 1, var_2_2)

	return
end

return AEBCSHestiaPage
