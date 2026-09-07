local IslandInfoPage = class("IslandInfoPage", import("...base.IslandBasePage"))

function IslandInfoPage:getUIName()
	return "IslandInfoUI"
end

function IslandInfoPage:OnLoaded()
	self.backBtn = self._tf:Find("frame/back")
	self.levelTxt = self._tf:Find("frame/left/level"):GetComponent(typeof(Text))
	self.expTxt = self._tf:Find("frame/left/objective/exp"):GetComponent(typeof(Text))
	self.goldTxt = self._tf:Find("frame/left/objective/gold"):GetComponent(typeof(Text))
	self.expProgress = self._tf:Find("frame/left/exp/bar")
	self.preViewBtn = self._tf:Find("frame/left/preview")
	self.prosperityLevel = self._tf:Find("frame/right/prosperity/level"):GetComponent(typeof(Text))
	self.prosperityExp = self._tf:Find("frame/right/prosperity/exp"):GetComponent(typeof(Text))
	self.prosperityIcon = self._tf:Find("frame/right/prosperity/icon")
	self.nameTxt = self._tf:Find("frame/left/name/Text"):GetComponent(typeof(Text))
	self.editNameBtn = self._tf:Find("frame/left/name")
	self.uiShipList = UIItemList.New(self._tf:Find("frame/right/ships/list"), self._tf:Find("frame/right/ships/list/tpl"))
	self.upgradePreviewPanel = self._tf:Find("frame/left/upgrade_preview")
	self.upgradeAwardList = UIItemList.New(self._tf:Find("frame/left/upgrade_preview/content/awards/list/content"), self._tf:Find("frame/left/upgrade_preview/content/awards/list/content/tpl"))
	self.upgradeUnlockList = UIItemList.New(self._tf:Find("frame/left/upgrade_preview/content/unlock/list/content"), self._tf:Find("frame/left/upgrade_preview/content/awards/list/content/tpl"))
	self.prosperityLevelList = UIItemList.New(self._tf:Find("frame/right/prosperity/objective/content"), self._tf:Find("frame/right/prosperity/objective/content/tpl"))
	self.prosperityAwardList = UIItemList.New(self._tf:Find("frame/right/prosperity/objective/awards"), self._tf:Find("frame/right/prosperity/objective/awards/tpl"))
	self.getProsperityBtn = self._tf:Find("frame/right/prosperity/objective/get_btn")
	self.goProsperityBtn = self._tf:Find("frame/right/prosperity/objective/go_btn")
	self.goProsperityBtnTxt = self._tf:Find("frame/right/prosperity/objective/go_btn/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("frame/left/preview/Text"), i18n("island_upgrade_preview"))
	setText(self._tf:Find("frame/left/objective/label_exp"), i18n("island_upgrade_exp"))
	setText(self._tf:Find("frame/left/objective/label_gold"), i18n("island_upgrade_res"))
	setText(self._tf:Find("frame/left/upgrade_preview/content/awards/label"), i18n("island_word_award"))
	setText(self._tf:Find("frame/left/upgrade_preview/content/unlock/label"), i18n("island_word_unlock"))
	setText(self._tf:Find("frame/right/prosperity/objective/get_btn/Text"), i18n("island_word_get"))

	return
end

function IslandInfoPage:OnInit()
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.editNameBtn, function()
		self:OpenPage(IslandEditNamePage)

		return
	end, SFX_PANEL)

	self.showPreviewPanel = false
	self.displayPreviewLevel = -1

	onButton(self, self.preViewBtn, function()
		local var_7_0 = getProxy(IslandProxy):GetIsland()

		if var_7_0:IsMaxLevel() then
			return
		end

		self.showPreviewPanel = not self.showPreviewPanel

		setActive(self.upgradePreviewPanel, self.showPreviewPanel)

		local var_7_1 = var_7_0:GetLevel()

		if self.showPreviewPanel and self.displayPreviewLevel ~= var_7_1 then
			self.displayPreviewLevel = var_7_1

			self:InitUpgradeAwards(var_7_0)
		end

		return
	end, SFX_PANEL)

	return
end

function IslandInfoPage:AddListeners()
	self:AddListener(GAME.ISLAND_UPGRADE_DONE, self.OnUpgrade)
	self:AddListener(GAME.ISLAND_PROSPERITY_AWARD_DONE, self.OnGetAward)
	self:AddListener(GAME.ISLAND_SET_NAME_DONE, self.OnModifyName)

	return
end

function IslandInfoPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_UPGRADE_DONE, self.OnUpgrade)
	self:RemoveListener(GAME.ISLAND_PROSPERITY_AWARD_DONE, self.OnGetAward)
	self:RemoveListener(GAME.ISLAND_SET_NAME_DONE, self.OnModifyName)

	return
end

function IslandInfoPage:OnUpgrade()
	self:UpdateLevel((getProxy(IslandProxy):GetIsland()))

	return
end

function IslandInfoPage:OnGetAward()
	self:UpdateProsperity((getProxy(IslandProxy):GetIsland()))

	return
end

function IslandInfoPage:OnModifyName()
	self:UpdateName((getProxy(IslandProxy):GetIsland()))

	return
end

function IslandInfoPage:Show()
	IslandInfoPage.super.Show(self)

	local var_13_0 = getProxy(IslandProxy):GetIsland()

	self:UpdateLevel(var_13_0)
	self:UpdateProsperity(var_13_0)
	self:UpdateName(var_13_0)
	self:UpdateShips(var_13_0)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf, {
		pbList = {
			self._tf:Find("frame/right")
		}
	})

	return
end

function IslandInfoPage:Hide()
	IslandInfoPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandInfoPage:InitUpgradeAwards(arg_15_1)
	local var_15_0 = arg_15_1:GetUpgradeAwards()

	self.upgradeAwardList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_16_2, (Drop.Create(var_15_0[arg_16_1 + 1])))
		end

		return
	end)
	self.upgradeAwardList:align(#var_15_0)

	local var_15_1 = arg_15_1:GetUnlockBuildingList()

	self.upgradeUnlockList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_17_2, (Drop.Create(var_15_1[arg_17_1 + 1])))
		end

		return
	end)
	self.upgradeUnlockList:align(#var_15_1)

	return
end

function IslandInfoPage:UpdateLevel(arg_18_1)
	self.levelTxt.text = arg_18_1:GetLevel()

	local var_18_0 = arg_18_1:GetExp()
	local var_18_1 = arg_18_1:GetTargeExp()

	customColorCount(self.expTxt, var_18_0, var_18_1, "#39bfff", "#f36c6e")
	setFillAmount(self.expProgress, Mathf.Clamp01(var_18_0 / var_18_1))

	return
end

function IslandInfoPage:UpdateProsperity(arg_19_1)
	local var_19_0 = {}

	self.prosperityLevelList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			self:UpdateProsperityCard(arg_20_2, pg.island_prosperity.all[arg_20_1 + 1], arg_19_1)

			var_19_0[pg.island_prosperity.all[arg_20_1 + 1]] = arg_20_2
		end

		return
	end)
	self.prosperityLevelList:align(#pg.island_prosperity.all)

	local var_19_1 = var_19_0[arg_19_1:GetProsperityLevel()] or var_19_0[1]

	if var_19_1 then
		triggerToggle(var_19_1, true)
	end

	return
end

function IslandInfoPage:UpdateProsperityCard(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_3:CanGetProsperityAwards(arg_21_2)
	local var_21_1 = arg_21_3:IsReceiveProsperityAwards(arg_21_2)
	local var_21_2 = arg_21_3:GetProsperityLevel() == arg_21_2

	setActive(arg_21_1:Find("line"), arg_21_3:GetMaxProsperityLevel() ~= arg_21_2)
	setActive(arg_21_1:Find("got"), var_21_1)
	setActive(arg_21_1:Find("get"), var_21_0)
	setActive(arg_21_1:Find("lock"), not var_21_0 and not var_21_1 and not var_21_2)
	setActive(arg_21_1:Find("curr"), var_21_2 and not var_21_1)
	onToggle(self, arg_21_1, function()
		self:FlushProsperity(arg_21_3, arg_21_2, var_21_0, var_21_1)

		return
	end, SFX_PANEL)

	return
end

function IslandInfoPage:FlushProsperity(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	self.prosperityLevel.text = ArabicToRoman(arg_23_2)

	local var_23_0 = arg_23_1:GetTargetProsperityByLevel(arg_23_2)

	self.prosperityExp.text = i18n("island_prosperity_level_display", arg_23_1:GetProsperity() .. "/" .. var_23_0)

	local var_23_1 = arg_23_1:GetProsperityAward(arg_23_2)

	self.prosperityAwardList:make(function(arg_24_0, arg_24_1, arg_24_2)
		if arg_24_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_24_2, (Drop.Create(var_23_1[arg_24_1 + 1])))
		end

		return
	end)
	self.prosperityAwardList:align(#var_23_1)
	setActive(self.getProsperityBtn, arg_23_3)
	setActive(self.goProsperityBtn, not arg_23_4 and not arg_23_3)

	self.goProsperityBtnTxt.text = i18n("island_prosperity_value_display", var_23_0)

	onButton(self, self.getProsperityBtn, function()
		self:emit(IslandMediator.GET_PROSPERITY_AWARD, arg_23_2)

		return
	end, SFX_PANEL)
	GetImageSpriteFromAtlasAsync("island/IslandProsperityIcon/" .. arg_23_2, "", self.prosperityIcon)

	return
end

function IslandInfoPage:UpdateName(arg_26_1)
	self.nameTxt.text = arg_26_1:GetName()

	return
end

function IslandInfoPage:UpdateShips(arg_27_1)
	local var_27_0 = arg_27_1:GetCharacterAgency():GetShips()

	self.uiShipList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			self:UpdateShipCard(arg_28_2, var_27_0[arg_28_1 + 1])
		end

		return
	end)
	self.uiShipList:align(5)

	return
end

function IslandInfoPage:UpdateShipCard(arg_29_1, arg_29_2)
	local var_29_0 = arg_29_2 == nil

	setActive(arg_29_1:Find("add"), arg_29_2 == nil)
	setActive(arg_29_1:Find("ship"), not var_29_0)

	if not var_29_0 then
		GetImageSpriteFromAtlasAsync("SquareIcon/" .. arg_29_2:GetPrefab(), "", arg_29_1:Find("ship/mask/icon"))
	end

	onButton(self, arg_29_1, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("word_comingSoon"))

		return
	end, SFX_PANEL)

	return
end

function IslandInfoPage:OnDestroy()
	return
end

return IslandInfoPage
