local FulankelinPtPage = class("FulankelinPtPage", import(".TemplatePage.NewPtTemplatePage"))

function FulankelinPtPage:OnInit()
	FulankelinPtPage.super.OnInit(self)
	setActive(self.shopBtn, false)

	return
end

return FulankelinPtPage
