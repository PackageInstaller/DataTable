local ChangFengSkinPage = class("ChangFengSkinPage", import(".TemplatePage.SkinTemplatePage"))

function ChangFengSkinPage:OnUpdateFlush()
	self.nday = self.activity.data3

	self:PlayStory()
	SetActive(self.dayTF, false)
	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function ChangFengSkinPage:GetProgressColor()
	return "#34424b"
end

return ChangFengSkinPage
