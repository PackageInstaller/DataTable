local ActiveStarlightHomepage = class("ActiveStarlightHomepage", import("...base.BaseActivityPage"))

function ActiveStarlightHomepage:OnInit()
	self.bg = self._tf:Find("bg")
	self.Build = self._tf:Find("bg/Build"):GetComponent("Button")
	self.Level = self._tf:Find("bg/Level"):GetComponent("Button")
	self.Shop = self._tf:Find("bg/Shop"):GetComponent("Button")
	self.Manual = self._tf:Find("bg/Manual"):GetComponent("Button")
	self.image = self._tf:Find("bg/Manual/image")

	return
end

function ActiveStarlightHomepage:OnDataSetting()
	local var_2_0 = self.activity:getConfig("time")

	return
end

function ActiveStarlightHomepage:OnFirstFlush()
	onButton(self, self.Build, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_NEWSERVER
		})

		return
	end, SFX_PANEL)
	onButton(self, self.Level, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.Shop, function()
		self:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = StarLightMedalAlbumView
		})))

		return
	end, SFX_PANEL)

	return
end

return ActiveStarlightHomepage
