local ForestVacationSkinPage = class("ForestVacationSkinPage", import(".TemplatePage.SkinTemplatePage"))

function ForestVacationSkinPage:OnUpdateFlush()
	self.nday = self.activity.data3

	if self.dayTF then
		setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)
	end

	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function ForestVacationSkinPage:GetProgressColor()
	return "#A5AE90"
end

return ForestVacationSkinPage
