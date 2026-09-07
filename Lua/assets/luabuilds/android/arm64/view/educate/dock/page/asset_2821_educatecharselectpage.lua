local EducateCharSelectPage = class("EducateCharSelectPage", import("view.base.BaseSubView"))

function EducateCharSelectPage:getUIName()
	return "EducateCharDockSelectUI"
end

function EducateCharSelectPage:OnLoaded()
	self.titleTxt = self._tf:Find("title/Text"):GetComponent(typeof(Text))
	self.labelTxt = self._tf:Find("left/label/icon"):GetComponent(typeof(Image))
	self.paintingTr = self._tf:Find("left/print/mask/painting")
	self.scrollrect = self._tf:Find("list")
	self.uiItemList = UIItemList.New(self._tf:Find("list/content"), self._tf:Find("list/content/tpl"))
	self.dotUIItemList = UIItemList.New(self._tf:Find("list/dots"), self._tf:Find("list/dots/tpl"))
	self.confirmBtn = self._tf:Find("confirm_btn")
	self.nextArr = self._tf:Find("prints/next")
	self.prevArr = self._tf:Find("prints/prev")
	self.nextPrint = self._tf:Find("prints/print1")
	self.prevPrint = self._tf:Find("prints/print2")
	self.animation = self._tf:GetComponent(typeof(Animation))
	self.dftAniEvent = self._tf:GetComponent(typeof(DftAniEvent))

	return
end

function EducateCharSelectPage:OnInit()
	onButton(self, self.confirmBtn, function()
		if self.doAnim then
			return
		end

		if not self.selectedId then
			return
		end

		self:emit(EducateCharDockScene.ON_SELECTED, self.selectedId)

		self.doAnim = true

		self:Back(function()
			self.doAnim = nil

			self:emit(EducateCharDockScene.ON_CONFIRM, self.selectedId)

			return
		end)

		return
	end, SFX_PANEL)
	self:bind(EducateCharDockScene.MSG_CLEAR_TIP, function(arg_6_0, arg_6_1)
		return
	end)

	return
end

function EducateCharSelectPage:Back(arg_7_1)
	self.dftAniEvent:SetEndEvent(function(arg_8_0)
		self.dftAniEvent:SetEndEvent(nil)
		arg_7_1()

		return
	end)
	self.animation:Play("anim_educate_chardockselect_out")

	return
end

function EducateCharSelectPage:Update(arg_9_1, arg_9_2)
	self.group = arg_9_1

	if arg_9_1:IsSelected(arg_9_2) then
		self.selectedId = arg_9_2
	end

	self.timers = {}

	self:FlushPainting(arg_9_1:GetShowPainting())
	self:InitLabel()
	self:UpdateTitle()
	self:InitList()
	self:UpdateDots()
	self:Show()

	return
end

function EducateCharSelectPage:UpdateTitle()
	self.titleTxt.text = self.group:GetTitle()

	return
end

function EducateCharSelectPage:InitLabel()
	self.labelTxt.sprite = GetSpriteFromAtlas("ui/EducateDockUI_atlas", self.group:GetSpriteName())

	self.labelTxt:SetNativeSize()

	return
end

function EducateCharSelectPage:FlushPainting(arg_12_1)
	self:ReturnPainting()
	setPaintingPrefabAsync(self.paintingTr, arg_12_1, "tb1")

	self.paintingName = arg_12_1

	return
end

function EducateCharSelectPage:InitList()
	local var_13_0 = self.group:GetCharIdList()

	self:ReturnCardList()

	self.cards = {}

	self:RemoveAllTimer()
	self.uiItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			self:UpdateCard(arg_14_2, var_13_0[arg_14_1 + 1], arg_14_1)

			self.cards[var_13_0[arg_14_1 + 1]] = arg_14_2
		end

		return
	end)
	self.uiItemList:align(#var_13_0)

	local var_13_1 = #var_13_0 > 2

	setActive(self.nextArr, #var_13_0 > 2)
	setActive(self.prevArr, var_13_1)
	setActive(self.nextPrint, not var_13_1)
	setActive(self.prevPrint, not var_13_1)
	scrollTo(self.scrollrect, 0, 0)

	return
end

function EducateCharSelectPage:UpdateDots()
	local var_15_0 = self.group:GetCharIdList()

	self.dotUIItemList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			setActive(arg_16_2:Find("Image"), var_15_0[arg_16_1 + 1] == self.selectedId)
		end

		return
	end)
	self.dotUIItemList:align(#var_15_0)

	return
end

function EducateCharSelectPage:IsLockCard(arg_17_1)
	return not table.contains(NewEducateHelper.GetAllUnlockSecretaryIds(), arg_17_1)
end

function EducateCharSelectPage:UpdateCard(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_1:Find("anim_root")
	local var_18_1 = pg.secretary_special_ship[arg_18_2]

	setPaintingPrefab(var_18_0:Find("mask/painting"), pg.secretary_special_ship[arg_18_2].prefab, "tb")
	setActive(var_18_0:Find("lock"), self:IsLockCard(pg.secretary_special_ship[arg_18_2].id))
	setScrollText(var_18_0:Find("lock/desc/Text"), pg.secretary_special_ship[arg_18_2].unlock_desc)

	local function var_18_2()
		setActive(var_18_0:Find("tip"), getProxy(SettingsProxy):_ShouldEducateCharTip(arg_18_2))

		return
	end

	var_18_2()

	local function var_18_3()
		setActive(var_18_0:Find("mark"), true)

		self.selectedId = arg_18_2

		self:UpdateDots()
		self:FlushPainting(var_18_1.painting)

		self.prevSelected = var_18_0

		self.animation:Stop()
		self.animation:Play("anim_educate_chardockselect_change")

		return
	end

	onButton(self, var_18_0, function()
		if self:IsLockCard(arg_18_2) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_special_lock_tip"))

			return
		end

		if getProxy(SettingsProxy):ClearEducateCharTip(arg_18_2) then
			var_18_2()
		end

		self:ClearPrevSelected()

		if self.selectedId == arg_18_2 then
			self.selectedId = 0

			self:UpdateDots()

			return
		end

		var_18_3()

		return
	end, SFX_PANEL)

	if self.selectedId == arg_18_2 then
		var_18_3()
	end

	setActive(var_18_0, false)

	self.timers[arg_18_3] = Timer.New(function()
		setActive(var_18_0, true)
		var_18_0:GetComponent(typeof(Animation)):Play("anim_educate_chardockselect_tpl")

		return
	end, math.max(1e-05, arg_18_3 * 0.066), 1)

	self.timers[arg_18_3]:Start()

	return
end

function EducateCharSelectPage:RemoveAllTimer()
	for iter_23_0, iter_23_1 in pairs(self.timers) do
		iter_23_1:Stop()

		iter_23_1 = nil
	end

	self.timers = {}

	return
end

function EducateCharSelectPage:ClearPrevSelected()
	if self.prevSelected then
		setActive(self.prevSelected:Find("mark"), false)

		self.prevSelected = nil
	end

	return
end

function EducateCharSelectPage:ReturnPainting()
	if self.paintingName then
		retPaintingPrefab(self.paintingTr, self.paintingName)

		self.paintingName = nil
	end

	return
end

function EducateCharSelectPage:ReturnCardList()
	for iter_26_0, iter_26_1 in pairs(self.cards or {}) do
		retPaintingPrefab(iter_26_1:Find("mask/painting"), pg.secretary_special_ship[iter_26_0].prefab)
	end

	self.cards = {}

	return
end

function EducateCharSelectPage:Hide()
	EducateCharSelectPage.super.Hide(self)
	self:ClearPrevSelected()

	self.selectedId = nil

	self:ReturnCardList()
	self:RemoveAllTimer()

	return
end

function EducateCharSelectPage:OnDestroy()
	self:RemoveAllTimer()
	self:ReturnPainting()
	self:ReturnCardList()
	self.dftAniEvent:SetEndEvent(nil)

	return
end

return EducateCharSelectPage
