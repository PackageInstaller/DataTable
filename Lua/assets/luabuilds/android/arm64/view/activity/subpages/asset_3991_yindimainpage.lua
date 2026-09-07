local YinDiMainPage = class("YinDiMainPage", import(".TemplatePage.PreviewTemplatePage"))

function YinDiMainPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnList = self.bg:Find("btn_list")

	return
end

function YinDiMainPage:OnFirstFlush()
	YinDiMainPage.super.OnFirstFlush(self)
	onButton(self, findTF(self.bg, "btn_list/shop"), function()
		self:emit(ActivityMediator.GO_SHOPS_LAYER, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = self.activity.id
		})

		return
	end)

	return
end

return YinDiMainPage
