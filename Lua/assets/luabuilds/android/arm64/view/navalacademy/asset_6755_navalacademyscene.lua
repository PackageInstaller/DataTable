local NavalAcademyScene = class("NavalAcademyScene", import("..base.BaseUI"))

NavalAcademyScene.WARP_TO_TACTIC = "WARP_TO_TACTIC"

function NavalAcademyScene:getUIName()
	local var_1_0 = pg.activity_banner[_.filter(pg.activity_banner.get_id_list_by_type[GAMEUI_BANNER_13], function(arg_2_0)
		return pg.TimeMgr.GetInstance():inTime(pg.activity_banner[arg_2_0].time)
	end)[1]]

	return (pg.naval_academy_theme[var_1_0 and var_1_0.pic] or nil) and (pg.naval_academy_theme[var_1_0 and var_1_0.pic].resource_path or "NavalAcademyUI")
end

function NavalAcademyScene:ResUISettings()
	return true
end

function NavalAcademyScene:SetOilResField(arg_4_1)
	self.oilResField = arg_4_1

	return
end

function NavalAcademyScene:SetGoldResField(arg_5_1)
	self.goldResField = arg_5_1

	return
end

function NavalAcademyScene:SetClassResField(arg_6_1)
	self.classResField = arg_6_1

	return
end

function NavalAcademyScene:SetPlayer(arg_7_1)
	self.player = arg_7_1

	return
end

function NavalAcademyScene:UpdatePlayer(arg_8_1)
	self.player = arg_8_1

	return
end

function NavalAcademyScene:onUILoaded(arg_9_1)
	arg_9_1.name = "NavalAcademyUI"

	NavalAcademyScene.super.onUILoaded(self, arg_9_1)

	return
end

function NavalAcademyScene:init()
	self.backBtn = self._tf:Find("blur_container/adapt/top/title/back")
	self._blurLayer = self._tf:Find("blur_container")
	self._topPanel = self._blurLayer:Find("adapt/top")
	self.bg = self._tf:Find("academyMap/map")
	self.buildings = {
		ShopBuiding.New(self),
		CanteenBuiding.New(self),
		ClassRoomBuilding.New(self),
		FountainBuiding.New(self),
		TacticRoomBuilding.New(self),
		CommanderBuilding.New(self),
		SupplyShopBuilding.New(self),
		MinigameHallBuilding.New(self)
	}
	self.shipsView = NavalAcademyShipsView.New(self)
	self.resPage = ResourcePage.New(self._tf, self.event)

	return
end

function NavalAcademyScene:didEnter()
	onButton(self, self.backBtn, function()
		self:ExitAnim()
		self:emit(NavalAcademyScene.ON_BACK, nil, 0.3)

		return
	end, SFX_CANCEL)
	self:InitBuildings()
	self.shipsView:BindBuildings(self.buildings)
	self:UpdatePlayer(self.player)
	self:LoadEffects()
	self:OpenDefaultLayer()
	self:EnterAnim()
	self:InitChars()

	self.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(self)

	return
end

function NavalAcademyScene:InitBuildings()
	for iter_13_0, iter_13_1 in ipairs(self.buildings) do
		iter_13_1:Init()
	end

	return
end

function NavalAcademyScene:EnterAnim()
	setAnchoredPosition(self._topPanel, {
		y = 84
	})
	shiftPanel(self._topPanel, nil, 0, 0.3, 0, true, true)

	return
end

function NavalAcademyScene:ExitAnim()
	shiftPanel(self._topPanel, nil, self._topPanel.rect.height, 0.3, 0, true, true)

	return
end

function NavalAcademyScene:OpenDefaultLayer()
	self.warp = self.contextData.warp
	self.contextData.warp = nil

	if self.warp == NavalAcademyScene.WARP_TO_TACTIC then
		self:emit(NavalAcademyMediator.ON_OPEN_TACTICROOM)
	end

	return
end

function NavalAcademyScene:LoadEffects()
	self:LoadWaveEffect()
	self:LoadMainEffect()

	return
end

function NavalAcademyScene:LoadWaveEffect()
	self:GetEffect("xueyuan02", function(arg_19_0)
		setParent(arg_19_0, self.bg)

		self.waveEffect = arg_19_0

		return
	end)

	return
end

function NavalAcademyScene:LoadMainEffect()
	return
end

function NavalAcademyScene:InitChars()
	self.shipsView:Init()

	return
end

function NavalAcademyScene:OpenGoldResField()
	self.resPage:ExecuteAction("Flush", self.goldResField)

	return
end

function NavalAcademyScene:OpenOilResField()
	self.resPage:ExecuteAction("Flush", self.oilResField)

	return
end

function NavalAcademyScene:OnAddLayer()
	self.layerCnt = (self.layerCnt or 0) + 1

	if self.layerCnt == 1 then
		self:EnableEffects(false)
	end

	return
end

function NavalAcademyScene:OnRemoveLayer(arg_25_1)
	self.layerCnt = (self.layerCnt or 0) - 1

	if self.layerCnt <= 0 then
		self.layerCnt = 0

		self:EnableEffects(true)
	end

	if arg_25_1.context.mediator == NewNavalTacticsMediator then
		self.buildings[5]:RefreshTip()
	end

	return
end

function NavalAcademyScene:EnableEffects(arg_26_1)
	if self.waveEffect then
		setActive(self.waveEffect, arg_26_1)
	end

	if self.mainEffect then
		setActive(self.mainEffect, arg_26_1)
	end

	return
end

function NavalAcademyScene:OnGetRes(arg_27_1, arg_27_2)
	if self.buildings[arg_27_1] then
		self.buildings[arg_27_1]:PlayGetResAnim(arg_27_2)
	end

	return
end

function NavalAcademyScene:OnStartUpgradeResField(arg_28_1)
	local var_28_0

	if isa(arg_28_1, OilResourceField) then
		var_28_0 = self.buildings[2]
		page = self.resPage
	elseif isa(arg_28_1, GoldResourceField) then
		var_28_0 = self.buildings[1]
		page = self.resPage
	elseif isa(arg_28_1, ClassResourceField) then
		var_28_0 = self.buildings[3]
	end

	if var_28_0 then
		var_28_0:UpdateResField()
	end

	if page and page:GetLoaded() and page:isShowing() and page.resourceField and page.resourceField:GetKeyWord() == arg_28_1:GetKeyWord() then
		page:Update(arg_28_1)
	end

	return
end

function NavalAcademyScene:OnResFieldLevelUp(arg_29_1)
	self:OnStartUpgradeResField(arg_29_1)

	return
end

function NavalAcademyScene:OnCollectionUpdate()
	self.buildings[4]:RefreshTip()

	return
end

function NavalAcademyScene:RefreshChars()
	self.shipsView:Refresh()

	return
end

function NavalAcademyScene:willExit()
	for iter_32_0, iter_32_1 in ipairs(self.buildings) do
		iter_32_1:Dispose()
	end

	self.buildings = nil

	if self.resPage then
		self.resPage:Destroy()

		self.resPage = nil
	end

	if self.mainEffect then
		Destroy(self.mainEffect)

		self.mainEffect = nil
	end

	if self.waveEffect then
		Destroy(self.waveEffect)

		self.waveEffect = nil
	end

	if self.bulinTip then
		self.bulinTip:Destroy()

		self.bulinTip = nil
	end

	if self.shipsView then
		self.shipsView:Dispose()

		self.shipsView = nil
	end

	return
end

function NavalAcademyScene:GetEffect(arg_33_1, arg_33_2)
	ResourceMgr.Inst:getAssetAsync("ui/" .. arg_33_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_34_0)
		if self.exited then
			return
		end

		arg_33_2(Instantiate(arg_34_0))

		return
	end), true, true)

	return
end

return NavalAcademyScene
