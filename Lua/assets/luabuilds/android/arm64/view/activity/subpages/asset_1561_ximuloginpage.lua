local XimuLoginPage = class("XimuLoginPage", import(".TemplatePage.LoginTemplatePage"))

function XimuLoginPage:OnInit()
	XimuLoginPage.super.OnInit(self)

	self.items2 = self.bg:Find("items2")

	return
end

function XimuLoginPage:OnUpdateFlush()
	XimuLoginPage.super.OnUpdateFlush(self)
	removeAllChildren(self.items2)
	eachChild(self.items, function(arg_3_0)
		local var_3_0 = arg_3_0:Find("day/Text")

		setText(var_3_0, setColorStr(getText(var_3_0), (arg_3_0:GetSiblingIndex() < self.nday or nil) and (COLOR_GREY or COLOR_WHITE)))

		return
	end)

	for iter_2_0 = self.Day, 4, -1 do
		local var_2_0 = self.items:GetChild(iter_2_0 - 1)

		setParent(var_2_0, self.items2, false)
		var_2_0:SetAsFirstSibling()
	end

	return
end

return XimuLoginPage
