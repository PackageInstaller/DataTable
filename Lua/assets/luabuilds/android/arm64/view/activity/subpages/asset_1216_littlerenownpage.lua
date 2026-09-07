local LittleRenownPage = class("LittleRenownPage", import(".TemplatePage.PtTemplatePage"))

function LittleRenownPage:OnInit()
	LittleRenownPage.super.OnInit(self)

	self.heartTpl = self.bg:Find("HeartTpl")
	self.heartContainer = self.bg:Find("HeartContainer")
	self.heartUIItemList = UIItemList.New(self.heartContainer, self.heartTpl)

	self.heartUIItemList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			setActive(arg_2_2:Find("Full"), not (self.ptData:GetLevelProgress() < arg_2_1 + 1))
		end

		return
	end)

	return
end

function LittleRenownPage:OnUpdateFlush()
	LittleRenownPage.super.OnUpdateFlush(self)

	local var_3_0, var_3_1 = self.ptData:GetLevelProgress()

	self.heartUIItemList:align(var_3_1)

	return
end

return LittleRenownPage
