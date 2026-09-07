local CygentSwimsuitPage = class("CygentSwimsuitPage", import(".TemplatePage.SkinTemplatePage"))

function CygentSwimsuitPage:OnFirstFlush()
	CygentSwimsuitPage.super.OnFirstFlush(self)
	PoolMgr.GetInstance():GetSpineChar("xiaotiane_2", false, function(arg_2_0)
		arg_2_0.transform.localScale = Vector3(0.7, 0.7, 1)

		arg_2_0.transform:SetParent(self.bg:Find("char"), false)
		arg_2_0:GetComponent(typeof(SpineAnimUI)):SetAction("stand", 0)

		self.model = arg_2_0

		return
	end)

	return
end

function CygentSwimsuitPage:OnUpdateFlush()
	CygentSwimsuitPage.super.OnUpdateFlush(self)
	GetImageSpriteFromAtlasAsync("numbericon/t1/" .. self.nday, "", self.bg:Find("day1"))
	setText(self.bg:Find("progress"), "進度:" .. self.nday .. "/10")

	return
end

function CygentSwimsuitPage:OnDestroy()
	CygentSwimsuitPage.super.OnDestroy(self)

	if self.model then
		self.model.transform.localScale = Vector3.one

		PoolMgr.GetInstance():ReturnSpineChar("xiaotiane_2", self.model)

		self.model = nil
	end

	return
end

return CygentSwimsuitPage
