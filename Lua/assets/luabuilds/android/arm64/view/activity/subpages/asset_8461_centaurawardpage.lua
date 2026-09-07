local CentaurAwardPage = class("CentaurAwardPage", import(".TemplatePage.SkinTemplatePage"))

function CentaurAwardPage:OnUpdateFlush()
	CentaurAwardPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)
	eachChild(self.items, function(arg_2_0)
		local var_2_0 = arg_2_0:Find("get_btn")
		local var_2_1 = arg_2_0:Find("got_btn")
		local var_2_2 = isActive(var_2_1)

		setButtonEnabled(var_2_1, false)
		setButtonEnabled(var_2_0, not var_2_2)

		if var_2_2 then
			setActive(var_2_0, true)
		end

		return
	end)

	return
end

return CentaurAwardPage
