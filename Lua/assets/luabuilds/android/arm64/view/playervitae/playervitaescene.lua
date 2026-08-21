local var_0_0 = class("PlayerVitaeScene", import("..base.BaseUI"))

var_0_0.ON_PAGE_SWTICH = "PlayerVitaeScene:ON_PAGE_SWTICH"
var_0_0.PAGE_DEFAULT = 1
var_0_0.PAGE_NATIVE_SHIPS = 2
var_0_0.PAGE_RANDOM_SHIPS = 3

function var_0_0.getUIName(arg_1_0)
	return "PlayerVitaeUI"
end

function var_0_0.GetBGM(arg_2_0)
	local var_2_0 = arg_2_0:GetFlagShip()

	if var_2_0:IsBgmSkin() and getProxy(SettingsProxy):IsBGMEnable() then
		return var_2_0:GetSkinBgm()
	else
		return "main"
	end

	return
end

function var_0_0.OnPlayerNameChange(arg_3_0)
	if arg_3_0.detailPage and arg_3_0.detailPage:GetLoaded() then
		arg_3_0.detailPage:OnPlayerNameChange(arg_3_0:GetPlayer())
	end

	return
end

function var_0_0.OnShipSkinChanged(arg_4_0, arg_4_1)
	arg_4_0:UpdatePainting()

	if arg_4_0.shipsPage and arg_4_0.shipsPage:isShowing() then
		arg_4_0.shipsPage:UpdateCard(arg_4_1)
	end

	return
end

function var_0_0.ReloadPanting(arg_5_0, arg_5_1)
	if arg_5_0.displaySkinID and arg_5_0.displaySkinID == arg_5_1 then
		arg_5_0:ReturnPainting()

		local var_5_0 = arg_5_0:GetFlagShip():getPainting()

		setPaintingPrefabAsync(arg_5_0.painting, var_5_0, "kanban")

		arg_5_0.paintingName = var_5_0
	end

	return
end

function var_0_0.RefreshShips(arg_6_0)
	if arg_6_0.shipsPage and arg_6_0.shipsPage:GetLoaded() and arg_6_0.shipsPage:isShowing() then
		arg_6_0.shipsPage:RefreshShips()
	end

	return
end

function var_0_0.GetPlayer(arg_7_0)
	return getProxy(PlayerProxy):getRawData()
end

function var_0_0.GetFlagShip(arg_8_0)
	return (arg_8_0:GetPlayer():GetFlagShip())
end

function var_0_0.init(arg_9_0)
	arg_9_0.bg = arg_9_0._tf:Find("bg")
	arg_9_0.backBtn = arg_9_0._tf:Find("top/frame/back")
	arg_9_0.mainViewCg = arg_9_0._tf:Find("adapt"):GetComponent(typeof(CanvasGroup))
	arg_9_0.mainTr = arg_9_0.mainViewCg.gameObject.transform
	arg_9_0.painting = arg_9_0._tf:Find("adapt/paint")
	arg_9_0.btnContainer = arg_9_0._tf:Find("adapt/btns")
	arg_9_0.switchSkinBtn = arg_9_0._tf:Find("adapt/btns/swichSkin_btn")
	arg_9_0.replaceBtn = arg_9_0._tf:Find("adapt/btns/replace_btn")
	arg_9_0.replaceBtnTip = arg_9_0.replaceBtn:Find("tip")
	arg_9_0.cryptolaliaBtn = arg_9_0._tf:Find("adapt/btns/cryptolalia_btn")
	arg_9_0.switchSkinBtnTag = arg_9_0.switchSkinBtn:Find("Tag")
	arg_9_0.titlt = arg_9_0._tf:Find("top/frame/title")
	arg_9_0.titltNative = arg_9_0._tf:Find("top/frame/title_native")
	arg_9_0.titltRandom = arg_9_0._tf:Find("top/frame/title_random")

	local var_9_0 = arg_9_0._tf:Find("detail")

	arg_9_0.detailCg = GetOrAddComponent(var_9_0, typeof(CanvasGroup))

	local var_9_1 = arg_9_0._tf:Find("adapt/tpl")

	setActive(var_9_1, false)

	arg_9_0.btns = {
		PlayerVitaeSpineBtn.New(var_9_1, PlayerVitaeBaseBtn.HRZ_TYPE),
		PlayerVitaeBGBtn.New(var_9_1, PlayerVitaeBaseBtn.HRZ_TYPE),
		PlayerVitaeBMGBtn.New(var_9_1, PlayerVitaeBaseBtn.HRZ_TYPE),
		PlayerVitaeLive2dBtn.New(var_9_1, PlayerVitaeBaseBtn.HRZ_TYPE)
	}

	for iter_9_0 = 1, #arg_9_0.btns do
		arg_9_0.btns[iter_9_0]:setParent(arg_9_0._tf:Find("adapt/toggleBtns"), #arg_9_0.btns - iter_9_0)
	end

	arg_9_0.btnLive2dReset = arg_9_0._tf:Find("adapt/btnLive2dReset")

	GetComponent(findTF(arg_9_0.btnLive2dReset, "img"), typeof(Image)):SetNativeSize()
	GetComponent(arg_9_0.btnLive2dReset, typeof(Image)):SetNativeSize()
	SetParent(arg_9_0.btnLive2dReset, arg_9_0._tf:Find("adapt/toggleBtns"))

	arg_9_0.shipsPage = PlayerVitaeShipsPage.New(arg_9_0._tf, arg_9_0.event, arg_9_0.contextData)
	arg_9_0.detailPage = PlayerVitaeDetailPage.New(var_9_0, arg_9_0.event, arg_9_0.contextData)

	setParent(arg_9_0._tf:Find("adapt/toggleBtns"), arg_9_0._tf:Find("detail"), true)

	arg_9_0.contextData.renamePage = PlayerVitaeRenamePage.New(arg_9_0._tf, arg_9_0.event)
	arg_9_0.topFrame = arg_9_0._tf:Find("top/frame")
	arg_9_0.detailPosx = arg_9_0._tf.rect.width * 0.5 - 937 * PlayerVitaeDetailPage.PreCalcAspect(var_9_0, 1080)

	LoadSpriteAsync("CommonBG/bg_admiral", function(arg_10_0)
		if IsNil(arg_9_0.bg) then
			return
		end

		local var_10_0 = arg_9_0.bg:GetComponent(typeof(Image))

		var_10_0.sprite = arg_10_0
		var_10_0.color = Color.New(1, 1, 1, 1)

		return
	end)

	return
end

function var_0_0.didEnter(arg_11_0)
	onButton(arg_11_0, arg_11_0.backBtn, function()
		if arg_11_0.shipsPage:GetLoaded() and arg_11_0.shipsPage:isShowing() then
			arg_11_0.shipsPage:Hide()
			arg_11_0:ShowOrHideMainView(true)
		else
			arg_11_0:emit(var_0_0.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	onButton(arg_11_0, arg_11_0.switchSkinBtn, function()
		arg_11_0:emit(PlayerVitaeMediator.CHANGE_SKIN, (arg_11_0:GetFlagShip()))

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.replaceBtn, function()
		arg_11_0.shipsPage:ExecuteAction("Update")
		arg_11_0:ShowOrHideMainView(false)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.cryptolaliaBtn, function()
		arg_11_0:emit(PlayerVitaeMediator.OPEN_CRYPTOLALIA, arg_11_0:GetFlagShip():getGroupId())

		return
	end, SFX_PANEL)
	arg_11_0:bind(var_0_0.ON_PAGE_SWTICH, function(arg_16_0, arg_16_1)
		setActive(arg_11_0.titlt, arg_16_1 == var_0_0.PAGE_DEFAULT)
		setActive(arg_11_0.titltNative, arg_16_1 == var_0_0.PAGE_NATIVE_SHIPS)
		setActive(arg_11_0.titltRandom, arg_16_1 == var_0_0.PAGE_RANDOM_SHIPS)

		return
	end)

	local var_11_0 = false

	if arg_11_0.contextData.showSelectCharacters then
		arg_11_0.contextData.showSelectCharacters = nil

		triggerButton(arg_11_0.replaceBtn)
	else
		arg_11_0:DoEnterAnimation()

		var_11_0 = true
	end

	arg_11_0:UpdatePainting()
	arg_11_0:UpdateReplaceTip()
	arg_11_0.detailPage:ExecuteAction("Show", arg_11_0:GetPlayer(), var_11_0)
	arg_11_0:emit(var_0_0.ON_PAGE_SWTICH, var_0_0.PAGE_DEFAULT)
	arg_11_0:checkShowResetL2dBtn()

	return
end

function var_0_0.UpdateReplaceTip(arg_17_0)
	local var_17_0 = getProxy(SettingsProxy):ShouldEducateCharTip()

	var_17_0 = var_17_0 or getProxy(ActivityProxy):IsTipLoveLetterMail()

	setActive(arg_17_0.replaceBtnTip, var_17_0)

	return
end

function var_0_0.DoEnterAnimation(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs({
		arg_18_0.btnContainer,
		arg_18_0.painting
	}) do
		(function(arg_19_0)
			local var_19_0 = arg_19_0.anchoredPosition3D

			arg_19_0.anchoredPosition3D = Vector3(arg_19_0.anchoredPosition3D.x - 1200, arg_19_0.anchoredPosition3D.y, 0)

			LeanTween.value(arg_19_0.gameObject, arg_19_0.anchoredPosition3D.x - 1200, arg_19_0.anchoredPosition3D.x, 0.2):setOnUpdate(System.Action_float(function(arg_20_0)
				arg_19_0.anchoredPosition3D = Vector3(arg_20_0, var_19_0.y, 0)

				return
			end)):setDelay(0.1):setEase(LeanTweenType.easeInOutSine)

			return
		end)(iter_18_1)
	end

	;(function(arg_21_0)
		arg_21_0.localPosition = Vector3(arg_21_0.localPosition.x, arg_21_0.localPosition.y + 22, 0)

		LeanTween.moveLocalY(arg_21_0.gameObject, arg_21_0.localPosition.y, 0.2):setDelay(0.1):setEase(LeanTweenType.easeInOutSine)

		return
	end)(arg_18_0.topFrame)

	return
end

function var_0_0.ShowOrHideMainView(arg_22_0, arg_22_1)
	arg_22_0.mainViewCg.alpha = arg_22_1 and 1 or 0
	arg_22_0.mainViewCg.blocksRaycasts = arg_22_1
	arg_22_0.detailCg.alpha = arg_22_1 and 1 or 0
	arg_22_0.detailCg.blocksRaycasts = arg_22_1

	if arg_22_1 then
		arg_22_0:UpdatePainting()
		arg_22_0:UpdateReplaceTip()
	end

	return
end

function var_0_0.UpdatePainting(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetFlagShip()
	local var_23_1 = false

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.btns) do
		local var_23_2 = iter_23_1:IsActive(var_23_0)

		if var_23_2 then
			table.insert({}, iter_23_1)
		end

		iter_23_1:Update(var_23_2, #{}, var_23_0)

		if var_23_2 and not var_23_1 and iter_23_1:IsOverlap(arg_23_0.detailPosx) then
			var_23_1 = true
		end
	end

	if var_23_1 then
		for iter_23_2, iter_23_3 in ipairs({}) do
			iter_23_3:SwitchToVecLayout()
		end
	end

	if not arg_23_0.displaySkinID or arg_23_0.displaySkinID ~= var_23_0:getSkinId() or arg_23_1 then
		arg_23_0:ReturnPainting()

		local var_23_3 = var_23_0:getPainting()

		setPaintingPrefabAsync(arg_23_0.painting, var_23_3, "kanban")

		arg_23_0.paintingName = var_23_3

		local var_23_4 = not HXSet.isHxSkin() and getProxy(ShipSkinProxy):HasFashion(var_23_0)

		setActive(arg_23_0.switchSkinBtn, var_23_4 and not isa(var_23_0, VirtualEducateCharShip))

		arg_23_0.displaySkinID = var_23_0:getSkinId()
	end

	setActive(arg_23_0.cryptolaliaBtn, getProxy(PlayerProxy):getRawData():ExistCryptolalia((var_23_0:getGroupId())))
	arg_23_0:updateSwitchSkinBtnTag()
	arg_23_0:checkShowResetL2dBtn()

	return
end

function var_0_0.ReturnPainting(arg_24_0)
	if arg_24_0.paintingName then
		retPaintingPrefab(arg_24_0.painting, arg_24_0.paintingName)
	end

	arg_24_0.paintingName = nil

	return
end

function var_0_0.updateSwitchSkinBtnTag(arg_25_0)
	setActive(arg_25_0.switchSkinBtnTag, #PaintingGroupConst.GetPaintingNameListByShipVO((arg_25_0:GetFlagShip())) > 0)

	return
end

function var_0_0.onBackPressed(arg_26_0)
	if arg_26_0.shipsPage and arg_26_0.shipsPage:GetLoaded() and arg_26_0.shipsPage:isShowing() then
		triggerButton(arg_26_0.backBtn)

		return
	end

	if arg_26_0.contextData.renamePage and arg_26_0.contextData.renamePage:GetLoaded() and arg_26_0.contextData.renamePage:isShowing() then
		arg_26_0.contextData.renamePage:Hide()

		return
	end

	var_0_0.super.onBackPressed(arg_26_0)

	return
end

function var_0_0.checkShowResetL2dBtn(arg_27_0)
	local var_27_0 = arg_27_0:GetFlagShip()

	if var_27_0 and var_27_0:GetSkinConfig().spine_use_live2d == 1 then
		setActive(arg_27_0.btnLive2dReset, false)

		return
	end

	if not checkABExist((HXSet.autoHxShiftPath("live2d/" .. string.lower(var_27_0:getPainting()), nil, true))) then
		setActive(arg_27_0.btnLive2dReset, false)

		return
	end

	setActive(arg_27_0.btnLive2dReset, true)
	onButton(arg_27_0, arg_27_0.btnLive2dReset, function()
		if arg_27_0:GetFlagShip() then
			local var_28_0 = arg_27_0:GetFlagShip()

			Live2dConst.ClearLive2dSave(var_28_0:getSkinId(), var_28_0.id)
			Live2dConst.SetLive2dDirty(var_28_0:getSkinId(), var_28_0.id)
		end

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.willExit(arg_29_0)
	arg_29_0:ReturnPainting()

	if LeanTween.isTweening(arg_29_0.painting.gameObject) then
		LeanTween.cancel(arg_29_0.painting.gameObject)
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.btns) do
		iter_29_1:Dispose()
	end

	arg_29_0.btns = nil

	if arg_29_0.shipsPage then
		arg_29_0.shipsPage:Destroy()

		arg_29_0.shipsPage = nil
	end

	if arg_29_0.detailPage then
		arg_29_0.detailPage:Destroy()

		arg_29_0.detailPage = nil
	end

	if arg_29_0.contextData.renamePage then
		arg_29_0.contextData.renamePage:Destroy()

		arg_29_0.contextData.renamePage = nil
	end

	return
end

return var_0_0
