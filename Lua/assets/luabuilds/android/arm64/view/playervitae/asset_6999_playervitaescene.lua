local PlayerVitaeScene = class("PlayerVitaeScene", import("..base.BaseUI"))

PlayerVitaeScene.ON_PAGE_SWTICH = "PlayerVitaeScene:ON_PAGE_SWTICH"
PlayerVitaeScene.PAGE_DEFAULT = 1
PlayerVitaeScene.PAGE_NATIVE_SHIPS = 2
PlayerVitaeScene.PAGE_RANDOM_SHIPS = 3

function PlayerVitaeScene:getUIName()
	return "PlayerVitaeUI"
end

function PlayerVitaeScene:GetBGM()
	local var_2_0 = self:GetFlagShip()

	if var_2_0:IsBgmSkin() and getProxy(SettingsProxy):IsBGMEnable() then
		return var_2_0:GetSkinBgm()
	else
		return "main"
	end

	return
end

function PlayerVitaeScene:OnPlayerNameChange()
	if self.detailPage and self.detailPage:GetLoaded() then
		self.detailPage:OnPlayerNameChange(self:GetPlayer())
	end

	return
end

function PlayerVitaeScene:OnShipSkinChanged(arg_4_1)
	self:UpdatePainting()

	if self.shipsPage and self.shipsPage:isShowing() then
		self.shipsPage:UpdateCard(arg_4_1)
	end

	return
end

function PlayerVitaeScene:ReloadPanting(arg_5_1)
	if self.displaySkinID and self.displaySkinID == arg_5_1 then
		self:ReturnPainting()

		local var_5_0 = self:GetFlagShip():getPainting()

		setPaintingPrefabAsync(self.painting, var_5_0, "kanban")

		self.paintingName = var_5_0
	end

	return
end

function PlayerVitaeScene:RefreshShips()
	if self.shipsPage and self.shipsPage:GetLoaded() and self.shipsPage:isShowing() then
		self.shipsPage:RefreshShips()
	end

	return
end

function PlayerVitaeScene:GetPlayer()
	return getProxy(PlayerProxy):getRawData()
end

function PlayerVitaeScene:GetFlagShip()
	return (self:GetPlayer():GetFlagShip())
end

function PlayerVitaeScene:init()
	self.bg = self._tf:Find("bg")
	self.backBtn = self._tf:Find("top/frame/back")
	self.mainViewCg = self._tf:Find("adapt"):GetComponent(typeof(CanvasGroup))
	self.mainTr = self.mainViewCg.gameObject.transform
	self.painting = self._tf:Find("adapt/paint")
	self.btnContainer = self._tf:Find("adapt/btns")
	self.switchSkinBtn = self._tf:Find("adapt/btns/swichSkin_btn")
	self.replaceBtn = self._tf:Find("adapt/btns/replace_btn")
	self.replaceBtnTip = self.replaceBtn:Find("tip")
	self.cryptolaliaBtn = self._tf:Find("adapt/btns/cryptolalia_btn")
	self.switchSkinBtnTag = self.switchSkinBtn:Find("Tag")
	self.titlt = self._tf:Find("top/frame/title")
	self.titltNative = self._tf:Find("top/frame/title_native")
	self.titltRandom = self._tf:Find("top/frame/title_random")

	local var_9_0 = self._tf:Find("detail")

	self.detailCg = GetOrAddComponent(var_9_0, typeof(CanvasGroup))

	local var_9_1 = self._tf:Find("adapt/tpl")

	setActive(var_9_1, false)

	self.btns = {
		PlayerVitaeSpineBtn.New(var_9_1, PlayerVitaeBaseBtn.HRZ_TYPE),
		PlayerVitaeBGBtn.New(var_9_1, PlayerVitaeBaseBtn.HRZ_TYPE),
		PlayerVitaeBMGBtn.New(var_9_1, PlayerVitaeBaseBtn.HRZ_TYPE),
		PlayerVitaeLive2dBtn.New(var_9_1, PlayerVitaeBaseBtn.HRZ_TYPE)
	}

	for iter_9_0 = 1, #self.btns do
		self.btns[iter_9_0]:setParent(self._tf:Find("adapt/toggleBtns"), #self.btns - iter_9_0)
	end

	self.btnLive2dReset = self._tf:Find("adapt/btnLive2dReset")

	GetComponent(findTF(self.btnLive2dReset, "img"), typeof(Image)):SetNativeSize()
	GetComponent(self.btnLive2dReset, typeof(Image)):SetNativeSize()
	SetParent(self.btnLive2dReset, self._tf:Find("adapt/toggleBtns"))

	self.shipsPage = PlayerVitaeShipsPage.New(self._tf, self.event, self.contextData)
	self.detailPage = PlayerVitaeDetailPage.New(var_9_0, self.event, self.contextData)

	setParent(self._tf:Find("adapt/toggleBtns"), self._tf:Find("detail"), true)

	self.contextData.renamePage = PlayerVitaeRenamePage.New(self._tf, self.event)
	self.topFrame = self._tf:Find("top/frame")
	self.detailPosx = self._tf.rect.width * 0.5 - 937 * PlayerVitaeDetailPage.PreCalcAspect(var_9_0, 1080)

	LoadSpriteAsync("CommonBG/bg_admiral", function(arg_10_0)
		if IsNil(self.bg) then
			return
		end

		local var_10_0 = self.bg:GetComponent(typeof(Image))

		var_10_0.sprite = arg_10_0
		var_10_0.color = Color.New(1, 1, 1, 1)

		return
	end)

	return
end

function PlayerVitaeScene:didEnter()
	onButton(self, self.backBtn, function()
		if self.shipsPage:GetLoaded() and self.shipsPage:isShowing() then
			self.shipsPage:Hide()
			self:ShowOrHideMainView(true)
		else
			self:emit(PlayerVitaeScene.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.switchSkinBtn, function()
		self:emit(PlayerVitaeMediator.CHANGE_SKIN, (self:GetFlagShip()))

		return
	end, SFX_PANEL)
	onButton(self, self.replaceBtn, function()
		self.shipsPage:ExecuteAction("Update")
		self:ShowOrHideMainView(false)

		return
	end, SFX_PANEL)
	onButton(self, self.cryptolaliaBtn, function()
		self:emit(PlayerVitaeMediator.OPEN_CRYPTOLALIA, self:GetFlagShip():getGroupId())

		return
	end, SFX_PANEL)
	self:bind(PlayerVitaeScene.ON_PAGE_SWTICH, function(arg_16_0, arg_16_1)
		setActive(self.titlt, arg_16_1 == PlayerVitaeScene.PAGE_DEFAULT)
		setActive(self.titltNative, arg_16_1 == PlayerVitaeScene.PAGE_NATIVE_SHIPS)
		setActive(self.titltRandom, arg_16_1 == PlayerVitaeScene.PAGE_RANDOM_SHIPS)

		return
	end)

	local var_11_0 = false

	if self.contextData.showSelectCharacters then
		self.contextData.showSelectCharacters = nil

		triggerButton(self.replaceBtn)
	else
		self:DoEnterAnimation()

		var_11_0 = true
	end

	self:UpdatePainting()
	self:UpdateReplaceTip()
	self.detailPage:ExecuteAction("Show", self:GetPlayer(), var_11_0)
	self:emit(PlayerVitaeScene.ON_PAGE_SWTICH, PlayerVitaeScene.PAGE_DEFAULT)
	self:checkShowResetL2dBtn()

	return
end

function PlayerVitaeScene:UpdateReplaceTip()
	local var_17_0 = getProxy(SettingsProxy):ShouldEducateCharTip()

	var_17_0 = var_17_0 or getProxy(ActivityProxy):IsTipLoveLetterMail()

	setActive(self.replaceBtnTip, var_17_0)

	return
end

function PlayerVitaeScene:DoEnterAnimation()
	local function var_18_0(arg_19_0)
		local var_19_0 = arg_19_0.anchoredPosition3D

		arg_19_0.anchoredPosition3D = Vector3(arg_19_0.anchoredPosition3D.x - 1200, arg_19_0.anchoredPosition3D.y, 0)

		LeanTween.value(arg_19_0.gameObject, arg_19_0.anchoredPosition3D.x - 1200, arg_19_0.anchoredPosition3D.x, 0.2):setOnUpdate(System.Action_float(function(arg_20_0)
			arg_19_0.anchoredPosition3D = Vector3(arg_20_0, var_19_0.y, 0)

			return
		end)):setDelay(0.1):setEase(LeanTweenType.easeInOutSine)

		return
	end

	for iter_18_0, iter_18_1 in ipairs({
		self.btnContainer,
		self.painting
	}) do
		var_18_0(iter_18_1)
	end

	;(function(arg_21_0)
		arg_21_0.localPosition = Vector3(arg_21_0.localPosition.x, arg_21_0.localPosition.y + 22, 0)

		LeanTween.moveLocalY(arg_21_0.gameObject, arg_21_0.localPosition.y, 0.2):setDelay(0.1):setEase(LeanTweenType.easeInOutSine)

		return
	end)(self.topFrame)

	return
end

function PlayerVitaeScene:ShowOrHideMainView(arg_22_1)
	self.mainViewCg.alpha = arg_22_1 and 1 or 0
	self.mainViewCg.blocksRaycasts = arg_22_1
	self.detailCg.alpha = arg_22_1 and 1 or 0
	self.detailCg.blocksRaycasts = arg_22_1

	if arg_22_1 then
		self:UpdatePainting()
		self:UpdateReplaceTip()
	end

	return
end

function PlayerVitaeScene:UpdatePainting(arg_23_1)
	local var_23_0 = self:GetFlagShip()
	local var_23_1 = false
	local var_23_2 = {}

	for iter_23_0, iter_23_1 in ipairs(self.btns) do
		local var_23_3 = iter_23_1:IsActive(var_23_0)

		if var_23_3 then
			table.insert(var_23_2, iter_23_1)
		end

		iter_23_1:Update(var_23_3, #var_23_2, var_23_0)

		if var_23_3 and not var_23_1 and iter_23_1:IsOverlap(self.detailPosx) then
			var_23_1 = true
		end
	end

	if var_23_1 then
		for iter_23_2, iter_23_3 in ipairs(var_23_2) do
			iter_23_3:SwitchToVecLayout()
		end
	end

	if not self.displaySkinID or self.displaySkinID ~= var_23_0:getSkinId() or arg_23_1 then
		self:ReturnPainting()

		local var_23_4 = var_23_0:getPainting()

		setPaintingPrefabAsync(self.painting, var_23_4, "kanban")

		self.paintingName = var_23_4

		setActive(self.switchSkinBtn, not HXSet.isHxSkin() and getProxy(ShipSkinProxy):HasFashion(var_23_0) and not isa(var_23_0, VirtualEducateCharShip))

		self.displaySkinID = var_23_0:getSkinId()
	end

	setActive(self.cryptolaliaBtn, getProxy(PlayerProxy):getRawData():ExistCryptolalia((var_23_0:getGroupId())))
	self:updateSwitchSkinBtnTag()
	self:checkShowResetL2dBtn()

	return
end

function PlayerVitaeScene:ReturnPainting()
	if self.paintingName then
		retPaintingPrefab(self.painting, self.paintingName)
	end

	self.paintingName = nil

	return
end

function PlayerVitaeScene:updateSwitchSkinBtnTag()
	setActive(self.switchSkinBtnTag, #PaintingGroupConst.GetPaintingNameListByShipVO((self:GetFlagShip())) > 0)

	return
end

function PlayerVitaeScene:onBackPressed()
	if self.shipsPage and self.shipsPage:GetLoaded() and self.shipsPage:isShowing() then
		triggerButton(self.backBtn)

		return
	end

	if self.contextData.renamePage and self.contextData.renamePage:GetLoaded() and self.contextData.renamePage:isShowing() then
		self.contextData.renamePage:Hide()

		return
	end

	PlayerVitaeScene.super.onBackPressed(self)

	return
end

function PlayerVitaeScene:checkShowResetL2dBtn()
	local var_27_0 = self:GetFlagShip()

	if var_27_0 and var_27_0:GetSkinConfig().spine_use_live2d == 1 then
		setActive(self.btnLive2dReset, false)

		return
	end

	if not checkABExist((HXSet.autoHxShiftPath("live2d/" .. string.lower(var_27_0:getPainting()), nil, true))) then
		setActive(self.btnLive2dReset, false)

		return
	end

	setActive(self.btnLive2dReset, true)
	onButton(self, self.btnLive2dReset, function()
		if self:GetFlagShip() then
			local var_28_0 = self:GetFlagShip()

			Live2dConst.ClearLive2dSave(var_28_0:getSkinId(), var_28_0.id)
			Live2dConst.SetLive2dDirty(var_28_0:getSkinId(), var_28_0.id)
		end

		return
	end, SFX_CONFIRM)

	return
end

function PlayerVitaeScene:willExit()
	self:ReturnPainting()

	if LeanTween.isTweening(self.painting.gameObject) then
		LeanTween.cancel(self.painting.gameObject)
	end

	for iter_29_0, iter_29_1 in ipairs(self.btns) do
		iter_29_1:Dispose()
	end

	self.btns = nil

	if self.shipsPage then
		self.shipsPage:Destroy()

		self.shipsPage = nil
	end

	if self.detailPage then
		self.detailPage:Destroy()

		self.detailPage = nil
	end

	if self.contextData.renamePage then
		self.contextData.renamePage:Destroy()

		self.contextData.renamePage = nil
	end

	return
end

return PlayerVitaeScene
