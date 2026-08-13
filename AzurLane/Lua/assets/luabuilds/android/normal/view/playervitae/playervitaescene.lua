class = var_0_10000

local var_0_0 = "PlayerVitaeScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.ON_PAGE_SWTICH = "PlayerVitaeScene:ON_PAGE_SWTICH"
var_0_1.PAGE_DEFAULT = 1
var_0_1.PAGE_NATIVE_SHIPS = 2
var_0_1.PAGE_RANDOM_SHIPS = 3

function var_0_1.getUIName(arg_1_0)
	return "PlayerVitaeUI"
end

function var_0_1.GetBGM(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetFlagShip(var_2_0)

	getProxy = var_2_0
	SettingsProxy = var_1_10003

	local var_2_2 = var_2_0(var_1_10003)
	local var_2_3 = var_2.IsBGMEnable(var_2_2)

	if var_2_1:IsBgmSkin() and var_2_3 then
		return var_2_1:GetSkinBgm()
	else
		return "main"
	end

	return
end

function var_0_1.OnPlayerNameChange(arg_3_0)
	if arg_3_0.detailPage then
		local var_3_0 = arg_3_0.detailPage

		if var_1.GetLoaded(var_3_0) then
			local var_3_1 = arg_3_0.detailPage

			var_1.OnPlayerNameChange(var_3_1, arg_3_0:GetPlayer())
		end
	end

	return
end

function var_0_1.OnShipSkinChanged(arg_4_0, arg_4_1)
	arg_4_0:UpdatePainting()

	if arg_4_0.shipsPage then
		local var_4_0 = arg_4_0.shipsPage

		if var_2.isShowing(var_4_0) then
			local var_4_1 = arg_4_0.shipsPage

			var_2.UpdateCard(var_4_1, arg_4_1)
		end
	end

	return
end

function var_0_1.ReloadPanting(arg_5_0, arg_5_1)
	if arg_5_0.displaySkinID and arg_5_0.displaySkinID == arg_5_1 then
		local var_5_0 = arg_5_0:GetFlagShip()

		arg_5_0:ReturnPainting()

		local var_5_1 = var_5_0
		local var_5_2 = var_5_0.getPainting(var_5_1)

		setPaintingPrefabAsync = var_5_1

		var_5_1(arg_5_0.painting, var_5_2, "kanban")

		arg_5_0.paintingName = var_5_2
	end

	return
end

function var_0_1.RefreshShips(arg_6_0)
	if arg_6_0.shipsPage then
		local var_6_0 = arg_6_0.shipsPage

		if var_1.GetLoaded(var_6_0) then
			local var_6_1 = arg_6_0.shipsPage

			if var_1.isShowing(var_6_1) then
				local var_6_2 = arg_6_0.shipsPage

				var_1.RefreshShips(var_6_2)
			end
		end
	end

	return
end

function var_0_1.GetPlayer(arg_7_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)

	return var_1.getRawData(var_7_0)
end

function var_0_1.GetFlagShip(arg_8_0)
	local var_8_0 = arg_8_0:GetPlayer()

	return (var_1.GetFlagShip(var_8_0))
end

function var_0_1.init(arg_9_0)
	local var_9_0 = arg_9_0._tf

	arg_9_0.bg = var_1.Find(var_9_0, "bg")

	local var_9_1 = arg_9_0._tf

	arg_9_0.backBtn = var_1.Find(var_9_1, "top/frame/back")

	local var_9_2 = arg_9_0._tf
	local var_9_3 = var_1.Find(var_9_2, "adapt")
	local var_9_4 = var_1.GetComponent

	typeof = var_3
	CanvasGroup = var_1_10004
	arg_9_0.mainViewCg = var_9_4(var_9_3, var_3(var_1_10004))
	arg_9_0.mainTr = arg_9_0.mainViewCg.gameObject.transform

	local var_9_5 = arg_9_0._tf

	arg_9_0.painting = var_1.Find(var_9_5, "adapt/paint")

	local var_9_6 = arg_9_0._tf

	arg_9_0.btnContainer = var_1.Find(var_9_6, "adapt/btns")

	local var_9_7 = arg_9_0._tf

	arg_9_0.switchSkinBtn = var_1.Find(var_9_7, "adapt/btns/swichSkin_btn")

	local var_9_8 = arg_9_0._tf

	arg_9_0.replaceBtn = var_1.Find(var_9_8, "adapt/btns/replace_btn")

	local var_9_9 = arg_9_0.replaceBtn

	arg_9_0.replaceBtnTip = var_1.Find(var_9_9, "tip")

	local var_9_10 = arg_9_0._tf

	arg_9_0.cryptolaliaBtn = var_1.Find(var_9_10, "adapt/btns/cryptolalia_btn")

	local var_9_11 = arg_9_0.switchSkinBtn

	arg_9_0.switchSkinBtnTag = var_1.Find(var_9_11, "Tag")

	local var_9_12 = arg_9_0._tf

	arg_9_0.titlt = var_1.Find(var_9_12, "top/frame/title")

	local var_9_13 = arg_9_0._tf

	arg_9_0.titltNative = var_1.Find(var_9_13, "top/frame/title_native")

	local var_9_14 = arg_9_0._tf

	arg_9_0.titltRandom = var_1.Find(var_9_14, "top/frame/title_random")

	local var_9_15 = arg_9_0._tf
	local var_9_16 = var_1.Find(var_9_15, "detail")

	GetOrAddComponent = var_9_15

	local var_9_17 = var_9_16

	typeof = var_1_10004
	CanvasGroup = var_1_10005
	arg_9_0.detailCg = var_9_15(var_9_17, var_1_10004(var_1_10005))

	local var_9_18 = arg_9_0._tf
	local var_9_19 = var_2.Find(var_9_18, "adapt/tpl")

	setActive = var_9_18

	var_9_18(var_9_19, false)

	local var_9_20 = {}

	PlayerVitaeSpineBtn = var_4

	local var_9_21 = var_4.New
	local var_9_22 = var_9_19

	PlayerVitaeBaseBtn = var_1_10006
	var_9_20[1] = var_9_21(var_9_22, var_1_10006.HRZ_TYPE)
	PlayerVitaeBGBtn = var_4

	local var_9_23 = var_4.New
	local var_9_24 = var_9_19

	PlayerVitaeBaseBtn = var_6
	var_9_20[2] = var_9_23(var_9_24, var_6.HRZ_TYPE)
	PlayerVitaeBMGBtn = var_4

	local var_9_25 = var_4.New
	local var_9_26 = var_9_19

	PlayerVitaeBaseBtn = var_6
	var_9_20[3] = var_9_25(var_9_26, var_6.HRZ_TYPE)
	PlayerVitaeLive2dBtn = var_4

	local var_9_27 = var_4.New
	local var_9_28 = var_9_19

	PlayerVitaeBaseBtn = var_6
	var_9_20[4] = var_9_27(var_9_28, var_6.HRZ_TYPE)
	arg_9_0.btns = var_9_20

	for iter_9_0 = 1, #arg_9_0.btns do
		local var_9_29 = arg_9_0.btns[iter_9_0]
		local var_9_30 = var_7.setParent
		local var_9_31 = arg_9_0._tf

		var_9_30(var_9_29, var_9.Find(var_9_31, "adapt/toggleBtns"), #arg_9_0.btns - iter_9_0)
	end

	local var_9_32 = arg_9_0._tf

	arg_9_0.btnLive2dReset = var_3.Find(var_9_32, "adapt/btnLive2dReset")
	GetComponent = var_3
	findTF = var_9_32

	local var_9_33 = var_9_32(arg_9_0.btnLive2dReset, "img")

	typeof = var_5
	Image = var_6

	local var_9_34 = var_3(var_9_33, var_5(var_6))

	var_3.SetNativeSize(var_9_34)

	GetComponent = var_3

	local var_9_35 = arg_9_0.btnLive2dReset

	typeof = var_5
	Image = var_6

	local var_9_36 = var_3(var_9_35, var_5(var_6))

	var_3.SetNativeSize(var_9_36)

	SetParent = var_3

	local var_9_37 = arg_9_0.btnLive2dReset
	local var_9_38 = arg_9_0._tf

	var_3(var_9_37, var_5.Find(var_9_38, "adapt/toggleBtns"))

	PlayerVitaeShipsPage = var_3
	arg_9_0.shipsPage = var_3.New(arg_9_0._tf, arg_9_0.event, arg_9_0.contextData)
	PlayerVitaeDetailPage = var_3
	arg_9_0.detailPage = var_3.New(var_9_16, arg_9_0.event, arg_9_0.contextData)
	setParent = var_3

	local var_9_39 = arg_9_0._tf
	local var_9_40 = var_4.Find(var_9_39, "adapt/toggleBtns")
	local var_9_41 = arg_9_0._tf

	var_3(var_9_40, var_5.Find(var_9_41, "detail"), true)

	local var_9_42 = arg_9_0.contextData

	PlayerVitaeRenamePage = var_9_40
	var_9_42.renamePage = var_9_40.New(arg_9_0._tf, arg_9_0.event)

	local var_9_43 = arg_9_0._tf

	arg_9_0.topFrame = var_3.Find(var_9_43, "top/frame")
	PlayerVitaeDetailPage = var_3

	local var_9_44 = var_3.PreCalcAspect(var_9_16, 1080)

	arg_9_0.detailPosx = arg_9_0._tf.rect.width * 0.5 - 937 * var_9_44
	LoadSpriteAsync = var_4

	var_4("CommonBG/bg_admiral", function(arg_10_0)
		IsNil = var_2_10001

		if var_2_10001(arg_9_0.bg) then
			return
		end

		local var_10_0 = arg_9_0.bg
		local var_10_1 = var_1.GetComponent

		typeof = var_2_10003
		Image = var_2_10004

		local var_10_2 = var_10_1(var_10_0, var_2_10003(var_2_10004))

		var_10_2.sprite = arg_10_0
		Color = var_10_0
		var_10_2.color = var_10_0.New(1, 1, 1, 1)

		return
	end)

	return
end

function var_0_1.didEnter(arg_11_0)
	onButton = var_1_10001

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.backBtn

	local function var_11_2()
		local var_12_0 = arg_11_0.shipsPage

		if var_0.GetLoaded(var_12_0) then
			local var_12_1 = arg_11_0.shipsPage

			if var_0.isShowing(var_12_1) then
				local var_12_2 = arg_11_0.shipsPage

				var_0.Hide(var_12_2)

				local var_12_3 = arg_11_0

				var_0.ShowOrHideMainView(var_12_3, true)

				goto label_12_0
			end
		end

		do
			local var_12_4 = arg_11_0

			var_0.emit(var_12_4, var_0_1.ON_BACK)
		end

		::label_12_0::

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_11_0, var_11_1, var_11_2, var_1_10005)

	onButton = var_1_10001

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.switchSkinBtn

	local function var_11_5()
		local var_13_0 = arg_11_0
		local var_13_1 = var_0.GetFlagShip(var_13_0)
		local var_13_2 = arg_11_0
		local var_13_3 = var_1.emit

		PlayerVitaeMediator = var_2_10003

		var_13_3(var_13_2, var_2_10003.CHANGE_SKIN, var_13_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_11_3, var_11_4, var_11_5, var_1_10005)

	onButton = var_1_10001

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.replaceBtn

	local function var_11_8()
		local var_14_0 = arg_11_0.shipsPage

		var_0.ExecuteAction(var_14_0, "Update")

		local var_14_1 = arg_11_0

		var_0.ShowOrHideMainView(var_14_1, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_11_6, var_11_7, var_11_8, var_1_10005)

	onButton = var_1_10001

	local var_11_9 = arg_11_0
	local var_11_10 = arg_11_0.cryptolaliaBtn

	local function var_11_11()
		local var_15_0 = arg_11_0
		local var_15_1 = var_0.GetFlagShip(var_15_0)
		local var_15_2 = arg_11_0
		local var_15_3 = var_1.emit

		PlayerVitaeMediator = var_2_10003

		var_15_3(var_15_2, var_2_10003.OPEN_CRYPTOLALIA, var_15_1:getGroupId())

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_11_9, var_11_10, var_11_11, var_1_10005)
	arg_11_0:bind(var_0_1.ON_PAGE_SWTICH, function(arg_16_0, arg_16_1)
		setActive = var_2_10002

		var_2_10002(arg_11_0.titlt, arg_16_1 == var_0_1.PAGE_DEFAULT)

		setActive = var_2_10002

		var_2_10002(arg_11_0.titltNative, arg_16_1 == var_0_1.PAGE_NATIVE_SHIPS)

		setActive = var_2_10002

		var_2_10002(arg_11_0.titltRandom, arg_16_1 == var_0_1.PAGE_RANDOM_SHIPS)

		return
	end)

	local var_11_12 = false

	if arg_11_0.contextData.showSelectCharacters then
		local var_11_13 = arg_11_0.contextData

		var_11_13.showSelectCharacters = nil
		triggerButton = var_11_13

		var_11_13(arg_11_0.replaceBtn)
	else
		arg_11_0:DoEnterAnimation()

		var_11_12 = true
	end

	arg_11_0:UpdatePainting()
	arg_11_0:UpdateReplaceTip()

	local var_11_14 = arg_11_0.detailPage

	var_2.ExecuteAction(var_11_14, "Show", arg_11_0:GetPlayer(), var_11_12)
	arg_11_0:emit(var_0_1.ON_PAGE_SWTICH, var_0_1.PAGE_DEFAULT)
	arg_11_0:checkShowResetL2dBtn()

	return
end

function var_0_1.UpdateReplaceTip(arg_17_0)
	setActive = var_1_10001

	local var_17_0 = arg_17_0.replaceBtnTip

	getProxy = var_1_10003
	SettingsProxy = var_1_10004

	local var_17_1 = var_1_10003(var_1_10004)
	local var_17_3

	if not var_3.ShouldEducateCharTip(var_17_1) then
		getProxy = var_17_3
		ActivityProxy = var_17_1

		local var_17_2 = var_17_3(var_17_1)

		var_17_3 = var_17_3.IsTipLoveLetterMail(var_17_2)
	end

	var_1_10001(var_17_0, var_17_3)

	return
end

function var_0_1.DoEnterAnimation(arg_18_0)
	local function var_18_0(arg_19_0)
		local var_19_0 = arg_19_0.anchoredPosition3D

		Vector3 = var_2_10002
		arg_19_0.anchoredPosition3D = var_2_10002(var_19_0.x - 1200, var_19_0.y, 0)
		LeanTween = var_2

		local var_19_1 = var_2.value(arg_19_0.gameObject, var_19_0.x - 1200, var_19_0.x, 0.2)
		local var_19_2 = var_2.setOnUpdate

		System = var_4

		local var_19_3 = var_19_2(var_19_1, var_4.Action_float(function(arg_20_0)
			local var_20_0 = arg_19_0

			Vector3 = var_3_10002
			var_20_0.anchoredPosition3D = var_3_10002(arg_20_0, var_19_0.y, 0)

			return
		end))
		local var_19_4 = var_2.setDelay(var_19_3, 0.1)
		local var_19_5 = var_2.setEase

		LeanTweenType = var_4

		var_19_5(var_19_4, var_4.easeInOutSine)

		return
	end

	local var_18_1 = {
		arg_18_0.btnContainer,
		arg_18_0.painting
	}

	ipairs = var_3

	for iter_18_0, iter_18_1 in var_3(var_18_1) do
		var_18_0(iter_18_1)
	end

	;(function(arg_21_0)
		local var_21_0 = arg_21_0.localPosition

		Vector3 = var_2_10002
		arg_21_0.localPosition = var_2_10002(var_21_0.x, var_21_0.y + 22, 0)
		LeanTween = var_2

		local var_21_1 = var_2.moveLocalY(arg_21_0.gameObject, var_21_0.y, 0.2)
		local var_21_2 = var_2.setDelay(var_21_1, 0.1)
		local var_21_3 = var_2.setEase

		LeanTweenType = var_4

		var_21_3(var_21_2, var_4.easeInOutSine)

		return
	end)(arg_18_0.topFrame)

	return
end

function var_0_1.ShowOrHideMainView(arg_22_0, arg_22_1)
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

function var_0_1.UpdatePainting(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetFlagShip()
	local var_23_1 = false
	local var_23_2 = {}

	ipairs = var_1_10005

	for iter_23_2, iter_23_3 in var_1_10005(arg_23_0.btns) do
		var_1_10011 = iter_23_3

		if iter_23_3.IsActive(var_1_10011, var_23_0) then
			table = var_1_10011

			var_1_10011.insert(var_23_2, iter_23_3)
		end

		iter_23_3:Update(var_10, #var_23_2, var_23_0)

		if var_10 and not var_23_1 and iter_23_3:IsOverlap(arg_23_0.detailPosx) then
			var_23_1 = true
		end
	end

	if var_23_1 then
		ipairs = var_5

		for iter_23_2, iter_23_3 in var_5(var_23_2) do
			var_1_10011 = iter_23_3

			iter_23_3.SwitchToVecLayout(var_1_10011)
		end
	end

	if not arg_23_0.displaySkinID or arg_23_0.displaySkinID ~= var_23_0:getSkinId() or arg_23_1 then
		arg_23_0:ReturnPainting()

		local var_23_3 = var_23_0
		local var_23_4 = var_23_0.getPainting(var_23_3)

		setPaintingPrefabAsync = var_23_3

		var_23_3(arg_23_0.painting, var_23_4, "kanban")

		arg_23_0.paintingName = var_23_4
		HXSet = var_23_3

		local var_23_5, var_23_6

		if not var_23_3.isHxSkin() then
			getProxy = var_6
			ShipSkinProxy = var_23_5
			var_23_5 = var_6(var_23_5)
			var_23_6 = var_6.HasFashion(var_23_5, var_23_0)
		else
			var_23_6 = false
		end

		if false then
			var_23_6 = true
		end

		setActive = var_23_5
		iter_23_2 = arg_23_0.switchSkinBtn

		if var_23_6 then
			::label_23_0::

			isa = iter_23_3

			local var_23_7 = var_23_0

			VirtualEducateCharShip = var_1_10011
			iter_23_3 = not iter_23_3(var_23_7, var_1_10011)
		end

		var_23_5(iter_23_2, iter_23_3)

		iter_23_2 = var_23_0
		arg_23_0.displaySkinID = var_23_0.getSkinId(iter_23_2)
	end

	local var_23_8 = var_23_0
	local var_23_9 = var_23_0.getGroupId(var_23_8)

	setActive = var_23_8

	local var_23_10 = arg_23_0.cryptolaliaBtn

	getProxy = iter_23_2
	PlayerProxy = iter_23_3

	local var_23_11 = iter_23_2(iter_23_3)
	local var_23_12 = var_8.getRawData(var_23_11)

	var_23_8(var_23_10, var_8.ExistCryptolalia(var_23_12, var_23_9))
	arg_23_0:updateSwitchSkinBtnTag()
	arg_23_0:checkShowResetL2dBtn()

	return
end

function var_0_1.ReturnPainting(arg_24_0)
	if arg_24_0.paintingName then
		retPaintingPrefab = var_1

		var_1(arg_24_0.painting, arg_24_0.paintingName)
	end

	arg_24_0.paintingName = nil

	return
end

function var_0_1.updateSwitchSkinBtnTag(arg_25_0)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.GetFlagShip(var_25_0)

	setActive = var_25_0

	local var_25_2 = arg_25_0.switchSkinBtnTag

	PaintingGroupConst = var_1_10004

	var_25_0(var_25_2, #var_1_10004.GetPaintingNameListByShipVO(var_25_1) > 0)

	return
end

function var_0_1.onBackPressed(arg_26_0)
	if arg_26_0.shipsPage then
		local var_26_0 = arg_26_0.shipsPage

		if var_1.GetLoaded(var_26_0) then
			local var_26_1 = arg_26_0.shipsPage

			if var_1.isShowing(var_26_1) then
				triggerButton = var_1

				var_1(arg_26_0.backBtn)

				return
			end
		end
	end

	if arg_26_0.contextData.renamePage then
		local var_26_2 = arg_26_0.contextData.renamePage

		if var_1.GetLoaded(var_26_2) then
			local var_26_3 = arg_26_0.contextData.renamePage

			if var_1.isShowing(var_26_3) then
				local var_26_4 = arg_26_0.contextData.renamePage

				var_1.Hide(var_26_4)

				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_26_0)

	return
end

function var_0_1.checkShowResetL2dBtn(arg_27_0)
	if arg_27_0:GetFlagShip() then
		var_1_10003 = var_1

		if var_1.GetSkinConfig(var_1_10003).spine_use_live2d == 1 then
			setActive = var_2

			var_2(arg_27_0.btnLive2dReset, false)

			return
		end
	end

	local var_27_0 = "live2d/"

	string = var_1_10003

	local var_27_1 = var_27_0 .. var_1_10003.lower(var_1:getPainting())

	HXSet = var_3

	local var_27_2 = var_3.autoHxShiftPath(var_27_1, nil, true)

	checkABExist = var_3

	if not var_3(var_27_2) then
		setActive = var_4

		var_4(arg_27_0.btnLive2dReset, false)

		return
	end

	setActive = var_4

	var_4(arg_27_0.btnLive2dReset, true)

	onButton = var_4

	local var_27_3 = arg_27_0
	local var_27_4 = arg_27_0.btnLive2dReset

	local function var_27_5()
		local var_28_0 = arg_27_0

		if var_0.GetFlagShip(var_28_0) then
			local var_28_1 = arg_27_0
			local var_28_2 = var_0.GetFlagShip(var_28_1)

			Live2dConst = var_28_1

			var_28_1.ClearLive2dSave(var_28_2:getSkinId(), var_28_2.id)

			Live2dConst = var_1

			var_1.SetLive2dDirty(var_28_2:getSkinId(), var_28_2.id)
		end

		return
	end

	SFX_CONFIRM = var_1_10008

	var_4(var_27_3, var_27_4, var_27_5, var_1_10008)

	return
end

function var_0_1.willExit(arg_29_0)
	arg_29_0:ReturnPainting()

	LeanTween = var_1

	if var_1.isTweening(arg_29_0.painting.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_29_0.painting.gameObject)
	end

	ipairs = var_1

	for iter_29_0, iter_29_1 in var_1(arg_29_0.btns) do
		iter_29_1:Dispose()
	end

	arg_29_0.btns = nil

	if arg_29_0.shipsPage then
		local var_29_0 = arg_29_0.shipsPage

		var_1.Destroy(var_29_0)

		arg_29_0.shipsPage = nil
	end

	if arg_29_0.detailPage then
		local var_29_1 = arg_29_0.detailPage

		var_1.Destroy(var_29_1)

		arg_29_0.detailPage = nil
	end

	if arg_29_0.contextData.renamePage then
		local var_29_2 = arg_29_0.contextData.renamePage

		var_1.Destroy(var_29_2)

		arg_29_0.contextData.renamePage = nil
	end

	return
end

return var_0_1
