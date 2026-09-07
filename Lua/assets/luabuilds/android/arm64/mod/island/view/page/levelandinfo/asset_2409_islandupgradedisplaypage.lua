local IslandUpgradeDisplayPage = class("IslandUpgradeDisplayPage", import("...base.IslandBasePage"))

function IslandUpgradeDisplayPage:getUIName()
	return "IslandCommonUpgradeDisplayUI"
end

function IslandUpgradeDisplayPage:OnLoaded()
	self.onlnyLevelTr = self._tf:Find("small")
	self.dropPanelTr = self._tf:Find("module")
	self.unlockUIList = UIItemList.New(self.dropPanelTr:Find("Board/Content/award/content"), self.dropPanelTr:Find("Board/Content/award/content/tpl"))
	self.canvasGroup = GetOrAddComponent(self._tf, typeof(CanvasGroup))

	setText(self._tf:Find("module/tip"), i18n("island_3Dshop_close"))
	setText(self._tf:Find("small/tip"), i18n("island_3Dshop_close"))
	GetComponent(self._tf:Find("module/bg/Top/title"), "Image"):SetNativeSize()
	GetComponent(self._tf:Find("module/bg/Top/title/title_item"), "Image"):SetNativeSize()
	GetComponent(self._tf:Find("module/bg/Top/star"), "Image"):SetNativeSize()
	GetComponent(self._tf:Find("module/bg/Top/star/title_item"), "Image"):SetNativeSize()

	return
end

function IslandUpgradeDisplayPage:OnInit()
	onButton(self, self._tf, function()
		self:PlayExitAnimation(function()
			self:Hide()

			if self.callback then
				self.callback()
			end

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function IslandUpgradeDisplayPage:PlayExitAnimation(arg_6_1)
	local var_6_0 = self.targetTr:GetComponent(typeof(Animation))
	local var_6_1 = self.targetTr:GetComponent(typeof(DftAniEvent))

	self.canvasGroup.blocksRaycasts = false

	var_6_1:SetEndEvent(function()
		var_6_1:SetEndEvent(nil)

		self.canvasGroup.blocksRaycasts = true

		arg_6_1()

		return
	end)

	if self.targetTr == self.onlnyLevelTr then
		var_6_0:Play("anim_Island_commonget_onlylv_out")
	else
		var_6_0:Play("anim_Island_commonget_single_out")
	end

	return
end

function IslandUpgradeDisplayPage:Show(arg_8_1, arg_8_2)
	IslandUpgradeDisplayPage.super.Show(self)

	self.callback = arg_8_2

	local var_8_0 = self:GetIsland()
	local var_8_1 = arg_8_1 and #arg_8_1 > 0

	if arg_8_1 and #arg_8_1 > 0 then
		self:CommonSettings(var_8_0, self.dropPanelTr)
		self:UpdateUnlockList(arg_8_1)
	else
		self:CommonSettings(var_8_0, self.onlnyLevelTr)
	end

	setActive(self.onlnyLevelTr, not var_8_1)
	setActive(self.dropPanelTr, var_8_1)

	if var_8_1 then
		self.targetTr = self.dropPanelTr or self.onlnyLevelTr
	end

	local var_8_2 = self.targetTr:GetComponent(typeof(Animation))

	if self.targetTr == self.onlnyLevelTr then
		var_8_2:Play("anim_Island_commonget_onlylv_in")
	else
		var_8_2:Play("anim_Island_commonget_single_in")
	end

	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function IslandUpgradeDisplayPage:Hide()
	self.callback = nil

	IslandUpgradeDisplayPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandUpgradeDisplayPage:OnShow()
	self.canvasGroup.interactable = true
	self.canvasGroup.blocksRaycasts = true

	return
end

function IslandUpgradeDisplayPage:OnHide()
	self.canvasGroup.interactable = false
	self.canvasGroup.blocksRaycasts = false

	return
end

function IslandUpgradeDisplayPage:CommonSettings(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:GetLevel()

	setText(arg_12_2:Find("Board/Top/LV/prev/prev_1"), "<size=50>" .. var_12_0 - 1 .. "</size>")
	setText(arg_12_2:Find("Board/Top/LV/next/next_1"), "<size=50>" .. var_12_0 .. "</size>")

	return
end

function IslandUpgradeDisplayPage:UpdateUnlockList(arg_13_1)
	self.unlockUIList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_14_2, arg_13_1[arg_14_1 + 1])
			setText(arg_14_2:Find("icon_bg/name_bg/Text"), shortenString(arg_13_1[arg_14_1 + 1]:getConfigTable().unlock_text, 5))
			GetImageSpriteFromAtlasAsync("ui/islandupgradedisplayui_atlas", "ability_type" .. arg_13_1[arg_14_1 + 1]:getConfigTable().show_type, arg_14_2:Find("icon_bg/type"))
		end

		return
	end)
	self.unlockUIList:align(#arg_13_1)

	return
end

function IslandUpgradeDisplayPage:OnDestroy()
	return
end

return IslandUpgradeDisplayPage
