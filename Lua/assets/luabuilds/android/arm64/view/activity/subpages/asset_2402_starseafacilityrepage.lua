local StarSeaFacilityRePage = class("StarSeaFacilityRePage", import(".TemplatePage.SkinTemplatePage"))

function StarSeaFacilityRePage:OnUpdateFlush()
	self.nday = self.activity.data3

	self:PlayStory()

	if self.dayTF then
		setText(self.dayTF, tostring(self.nday) .. "/7")
	end

	self.uilist:align(#self.taskGroup[self.nday])

	return
end

return StarSeaFacilityRePage
