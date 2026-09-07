local SaratogaSkinPage = class("SaratogaSkinPage", import(".TemplatePage.PreviewTemplatePage"))

function SaratogaSkinPage:OnInit()
	SaratogaSkinPage.super.OnInit(self)

	self.shopBtn = self.bg:Find("btn_list/shop")
	self.fightBtn = self.bg:Find("btn_list/fight")

	return
end

function SaratogaSkinPage:OnFirstFlush()
	SaratogaSkinPage.super.OnFirstFlush(self)
	onButton(self, self.shopBtn, function()
		self:emit(ActivityMediator.GO_SHOPS_LAYER, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = self.activity.id
		})

		return
	end)
	onButton(self, self.fightBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end)

	return
end

return SaratogaSkinPage
