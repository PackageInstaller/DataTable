local NewPtAccuPage = class("NewPtAccuPage", import(".TemplatePage.PtTemplatePage"))

NewPtAccuPage.TIME = 300

function NewPtAccuPage:OnInit()
	NewPtAccuPage.super.OnInit(self)

	self.value2 = self._tf:Find("AD/value2")
	self.sliderTxt = self._tf:Find("AD/slider/Text")

	return
end

function NewPtAccuPage:OnUpdateFlush()
	NewPtAccuPage.super.OnUpdateFlush(self)
	setText(self.value2, self.ptData:GetValue2())

	local var_2_0, var_2_1, var_2_2 = self.ptData:GetResProgress()

	setText(self.sliderTxt, math.floor(math.min(var_2_2, 1) * 100) .. "%")
	self:GetWorldPtData(NewPtAccuPage.TIME)

	return
end

return NewPtAccuPage
