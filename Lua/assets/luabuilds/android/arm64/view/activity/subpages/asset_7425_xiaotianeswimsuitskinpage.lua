local XiaotianeSwimsuitSkinPage = class("XiaotianeSwimsuitSkinPage", import(".TemplatePage.SkinTemplatePage"))

function XiaotianeSwimsuitSkinPage:OnInit()
	XiaotianeSwimsuitSkinPage.super.OnInit(self)

	self.rtDayImage = self.bg:Find("day_image")
	self.rtCharacter = self.bg:Find("character")

	return
end

function XiaotianeSwimsuitSkinPage:OnUpdateFlush()
	XiaotianeSwimsuitSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, i18n("activity_permanent_progress") .. self.nday .. "/" .. #self.taskGroup)
	GetImageSpriteFromAtlasAsync("ui/activityuipage/xiaotianeswimsuitskinpage_atlas", tostring(self.nday), self.rtDayImage, true)

	if not self.model then
		PoolMgr.GetInstance():GetSpineChar("xiaotiane_2", true, function(arg_3_0)
			if self.model then
				return
			end

			self.model = arg_3_0
			tf(arg_3_0).localScale = Vector3(1, 1, 1)

			arg_3_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
			setParent(arg_3_0, self.rtCharacter)

			return
		end)
	end

	return
end

function XiaotianeSwimsuitSkinPage:OnDestroy()
	if self.model then
		PoolMgr.GetInstance():ReturnSpineChar("xiaotiane_2", self.model)

		self.prefab1 = nil
		self.model1 = nil
	end

	XiaotianeSwimsuitSkinPage.super.OnDestroy(self)

	return
end

return XiaotianeSwimsuitSkinPage
