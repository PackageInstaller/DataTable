local SectionThreeStarBar = class("SectionThreeStarBar", ReduxView)

function SectionThreeStarBar:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.enabledController_ = self.controllerEx_:GetController("enabled")
end

function SectionThreeStarBar:SetData(arg_2_1)
	self.enabledController_:SetSelectedState(tostring(arg_2_1))
end

function SectionThreeStarBar:Dispose()
	SectionThreeStarBar.super.Dispose(self)
end

function SectionThreeStarBar:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

return SectionThreeStarBar
