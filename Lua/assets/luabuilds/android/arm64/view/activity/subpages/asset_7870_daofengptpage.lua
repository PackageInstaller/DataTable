local DaofengPTPage = class("DaofengPTPage", import(".TemplatePage.PtTemplatePage"))

function DaofengPTPage:OnUpdateFlush()
	DaofengPTPage.super.OnUpdateFlush(self)

	local var_1_0, var_1_1, var_1_2 = self.ptData:GetResProgress()

	setText(self.progress, setColorStr(var_1_0, "#915167") .. "/" .. var_1_1)
	LoadImageSpriteAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = self.ptData.resId
	}):getIcon(), self._tf:Find("AD/icon"), false)

	return
end

return DaofengPTPage
