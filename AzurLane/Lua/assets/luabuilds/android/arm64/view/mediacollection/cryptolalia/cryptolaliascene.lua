class = var_0_10000

local var_0_0 = "CryptolaliaScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.ON_UNLOCK = "CryptolaliaScene:ON_UNLOCK"
var_0_1.ON_DELETE = "CryptolaliaScene:ON_DELETE"
var_0_1.ON_SELECT = "CryptolaliaScene:ON_SELECT"

function var_0_1.getUIName(arg_1_0)
	return "CryptolaliaUI"
end

function var_0_1.SetCryptolaliaList(arg_2_0, arg_2_1)
	arg_2_0.cryptolaliaList = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.GetComponent

	typeof = var_1_10004
	CanvasGroup = var_1_10006
	arg_3_0.cg = var_3_1(var_3_0, var_1_10004(var_1_10006))

	local var_3_2 = arg_3_0._tf

	arg_3_0.backBtn = var_1.Find(var_3_2, "Top/blur_panel/adapt/top/back_btn")

	local var_3_3 = arg_3_0._tf

	arg_3_0.auditionBtn = var_1.Find(var_3_3, "Main/audition/toggle")

	local var_3_4 = arg_3_0._tf

	arg_3_0.auditionBtnOn = var_1.Find(var_3_4, "Main/audition/toggle/on")

	local var_3_5 = arg_3_0._tf

	arg_3_0.auditionBtnOff = var_1.Find(var_3_5, "Main/audition/toggle/off")

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_1.Find(var_3_6, "Main/cd")
	local var_3_8 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_3_0.cdImg = var_3_8(var_3_7, var_4(var_1_10006))

	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_1.Find(var_3_9, "Main/cd/signature")
	local var_3_11 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_3_0.cdSignatureImg = var_3_11(var_3_10, var_4(var_1_10006))

	local var_3_12 = arg_3_0._tf
	local var_3_13 = var_1.Find(var_3_12, "Main/cd/name")
	local var_3_14 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.shipName = var_3_14(var_3_13, var_4(var_1_10006))

	local var_3_15 = arg_3_0._tf

	arg_3_0.timeLimit = var_1.Find(var_3_15, "Main/cd/timelimit")

	local var_3_16 = arg_3_0._tf
	local var_3_17 = var_1.Find(var_3_16, "Main/cd/timelimit/Text")
	local var_3_18 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.timeTxt = var_3_18(var_3_17, var_4(var_1_10006))

	local var_3_19 = arg_3_0._tf
	local var_3_20 = var_1.Find(var_3_19, "Main/name")
	local var_3_21 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.nameTxt = var_3_21(var_3_20, var_4(var_1_10006))

	local var_3_22 = arg_3_0._tf
	local var_3_23 = var_1.Find(var_3_22, "Main/author")
	local var_3_24 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.authorTxt = var_3_24(var_3_23, var_4(var_1_10006))

	local var_3_25 = arg_3_0._tf
	local var_3_26 = var_1.Find(var_3_25, "Main/desc")
	local var_3_27 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.descTxt = var_3_27(var_3_26, var_4(var_1_10006))

	local var_3_28 = arg_3_0._tf
	local var_3_29 = var_1.Find(var_3_28, "Main/desc/signature")
	local var_3_30 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_3_0.signatureImg = var_3_30(var_3_29, var_4(var_1_10006))

	local var_3_31 = arg_3_0._tf
	local var_3_32 = var_1.Find(var_3_31, "Main/audition/mask/Text")

	arg_3_0.auditionTxt = var_1.GetComponent(var_3_32, "ScrollText")

	local var_3_33 = arg_3_0._tf
	local var_3_34 = var_1.Find(var_3_33, "Main/audition/p2/Lines")
	local var_3_35 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_3_0.auditionEffect = var_3_35(var_3_34, var_4(var_1_10006))

	local var_3_36 = arg_3_0.auditionEffect

	var_1.Play(var_3_36, "anim_line_reset")

	local var_3_37 = arg_3_0._tf

	arg_3_0.btnsTr = var_1.Find(var_3_37, "Main/btns")

	local var_3_38 = arg_3_0.btnsTr

	arg_3_0.lockBtn = var_1.Find(var_3_38, "lock")

	local var_3_39 = arg_3_0.btnsTr

	arg_3_0.downloadBtn = var_1.Find(var_3_39, "download")

	local var_3_40 = arg_3_0.btnsTr

	arg_3_0.downloadingBtn = var_1.Find(var_3_40, "downloading")

	local var_3_41 = arg_3_0.btnsTr

	arg_3_0.playBtn = var_1.Find(var_3_41, "play")

	local var_3_42 = arg_3_0.btnsTr

	arg_3_0.playPrevBtn = var_1.Find(var_3_42, "play/prev")

	local var_3_43 = arg_3_0.btnsTr

	arg_3_0.playNextBtn = var_1.Find(var_3_43, "play/next")

	local var_3_44 = arg_3_0.btnsTr

	arg_3_0.deleteBtn = var_1.Find(var_3_44, "delete")

	local var_3_45 = arg_3_0.btnsTr

	arg_3_0.stateBtn = var_1.Find(var_3_45, "state")

	local var_3_46 = arg_3_0.stateBtn
	local var_3_47 = var_1.Find(var_3_46, "Text")
	local var_3_48 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.stateBtnTxt = var_3_48(var_3_47, var_4(var_1_10006))

	local var_3_49 = arg_3_0.btnsTr

	arg_3_0.switchBtn = var_1.Find(var_3_49, "switch")

	local var_3_50 = arg_3_0.btnsTr

	arg_3_0.listBtn = var_1.Find(var_3_50, "list")

	local var_3_51 = arg_3_0._tf

	arg_3_0.optionBtn = var_1.Find(var_3_51, "Top/blur_panel/adapt/top/option")
	CryptolaliaPurchaseWindow = var_1
	arg_3_0.purchaseWindow = var_1.New(arg_3_0._tf, arg_3_0.event)
	CryptolaliaResDeleteWindow = var_1
	arg_3_0.resDeleteWindow = var_1.New(arg_3_0._tf, arg_3_0.event)
	CryptolaliaDownloadMgr = var_1
	arg_3_0.downloadMgr = var_1.New()
	CryptolaliaSoundPlayer = var_1
	arg_3_0.soundPlayer = var_1.New()
	CryptolaliaMainView = var_1
	arg_3_0.mainView = var_1.New(arg_3_0)
	CryptolaliaListView = var_1
	arg_3_0.listView = var_1.New(arg_3_0._tf, arg_3_0.event)
	CryptolaliaScrollRectAnimation = var_1

	local var_3_52 = var_1.New(arg_3_0._tf)

	CryptolaliaScrollRect = var_1_10002

	local var_3_53 = var_1_10002.New
	local var_3_54 = arg_3_0._tf

	arg_3_0.scrollRect = var_3_53(var_4.Find(var_3_54, "Main/list/tpl"), var_3_52)

	local var_3_55 = arg_3_0.scrollRect

	var_2.Make(var_3_55, function(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.OnItemUpdate(var_4_0, arg_4_0)

		return
	end, function(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.OnItemSelected(var_5_0, arg_5_0:GetInitIndex())

		return
	end)

	local var_3_56 = arg_3_0._tf
	local var_3_57 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_7
	arg_3_0.dftAniEvent = var_3_57(var_3_56, var_5(var_7))
	setText = var_2

	local var_3_58 = arg_3_0._tf
	local var_3_59 = var_4.Find(var_3_58, "Main/cd/timelimit/label")

	i18n = var_5

	var_2(var_3_59, var_5("cryptolalia_timelimie"))

	setText = var_2

	local var_3_60 = arg_3_0.downloadingBtn
	local var_3_61 = var_4.Find(var_3_60, "label")

	i18n = var_5

	var_2(var_3_61, var_5("cryptolalia_label_downloading"))

	Input = var_2
	var_2.multiTouchEnabled = false

	return
end

function var_0_1.didEnter(arg_6_0)
	arg_6_0.cards = {}
	arg_6_0.downloadReqList = {}
	parallelAsync = var_1

	var_1({
		function(arg_7_0)
			local var_7_0 = arg_6_0.dftAniEvent

			var_1.SetEndEvent(var_7_0, arg_7_0)

			return
		end,
		function(arg_8_0)
			local var_8_0 = arg_6_0

			var_1.InitCryptolaliaList(var_8_0, arg_8_0)

			return
		end
	}, function()
		local var_9_0 = arg_6_0.dftAniEvent

		var_0.SetEndEvent(var_9_0, nil)

		local var_9_1 = arg_6_0.scrollRect

		var_0.SetUp(var_9_1)

		local var_9_2 = arg_6_0

		var_0.ActiveDefault(var_9_2)

		local var_9_3 = arg_6_0

		var_0.RegisterEvent(var_9_3)

		return
	end)

	return
end

function var_0_1.ActiveDefault(arg_10_0)
	if not arg_10_0.contextData.groupId then
		return
	end

	local var_10_0 = -1

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.displays) do
		if iter_10_1 and iter_10_1:IsSameGroup(arg_10_0.contextData.groupId) then
			var_10_0 = iter_10_0

			break
		end
	end

	if var_10_0 <= 0 then
		return
	end

	pairs = var_2

	for iter_10_2, iter_10_3 in var_2(arg_10_0.cards) do
		if iter_10_3:GetInitIndex() == var_10_0 then
			triggerButton = var_7

			var_7(iter_10_3._go)

			break
		end
	end

	return
end

function var_0_1.OnItemUpdate(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.displays
	local var_11_1 = arg_11_1
	local var_11_2 = var_11_0[arg_11_1.GetInitIndex(var_11_1)]

	arg_11_1:Interactable(false)

	if not var_11_2 then
		return
	end

	arg_11_1:Interactable(true)

	local var_11_3 = var_11_2:GetShipGroupId()

	LoadSpriteAtlasAsync = var_11_1

	var_11_1("CryptolaliaShip/" .. var_11_3, "icon", function(arg_12_0)
		local var_12_0 = arg_11_1

		var_1.UpdateSprite(var_12_0, arg_12_0)

		return
	end)

	arg_11_0.cards[var_11_2.id] = arg_11_1

	return
end

function var_0_1.OnItemSelected(arg_13_0, arg_13_1)
	if not arg_13_0.displays[arg_13_1] then
		return
	end

	if not arg_13_0.langType or not var_2:ExistLang(arg_13_0.langType) or arg_13_0.selectedIndex ~= arg_13_1 then
		arg_13_0.langType = var_2:GetDefaultLangType()
	end

	local var_13_0 = var_2:GetCpkName(arg_13_0.langType)

	Cryptolalia = var_1_10004

	local var_13_1 = var_1_10004.BuildCpkPath(var_13_0)
	local var_13_2 = arg_13_0.downloadMgr

	if var_5.IsDownloadState(var_13_2, var_13_1) and arg_13_0.downloadReqList[var_2.id] == nil then
		arg_13_0:OnUpdateForResDownload("ReConnection", var_2, arg_13_1)
	end

	local var_13_3 = arg_13_0.mainView

	var_6.Flush(var_13_3, var_2, arg_13_0.langType, var_5)

	arg_13_0.selectedIndex = arg_13_1

	if arg_13_0.auditionFlag then
		triggerButton = var_6

		var_6(arg_13_0.auditionBtn)
	end

	return
end

function var_0_1.Filter(arg_14_0)
	local var_14_0 = {}

	ipairs = var_1_10002

	local var_14_1

	if not arg_14_0.cryptolaliaList then
		var_14_1 = {}
	end

	for iter_14_0, iter_14_1 in var_1_10002(var_14_1) do
		if iter_14_1:InTime() or not iter_14_1:IsLock() then
			table = var_7

			var_7.insert(var_14_0, iter_14_1)
		end
	end

	table = var_2

	var_2.sort(var_14_0, function(arg_15_0, arg_15_1)
		if arg_15_0:GetSortIndex() == arg_15_1:GetSortIndex() then
			return arg_15_0.id < arg_15_1.id
		else
			return var_2 < var_3
		end

		return
	end)

	return var_14_0
end

function var_0_1.InitCryptolaliaList(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:Filter()

	arg_16_0.displays = arg_16_0:FillEmptyDisplayIfNeed(var_16_0)

	local var_16_1 = arg_16_0.scrollRect

	var_3.Align(var_16_1, #arg_16_0.displays, arg_16_1)

	return
end

function var_0_1.FillEmptyDisplayIfNeed(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = 1

	math = var_1_10004

	for iter_17_0 = var_17_1, var_1_10004.max(5, #arg_17_1) do
		defaultValue = var_17_2

		local var_17_2 = var_17_2(arg_17_1[iter_17_0], false)

		if iter_17_0 % 2 == 0 then
			table = var_8

			var_8.insert(var_17_0, var_17_2)
		else
			table = var_8

			var_8.insert(var_17_0, 1, var_17_2)
		end
	end

	return var_17_0
end

function var_0_1.RegisterEvent(arg_18_0)
	arg_18_0:bind(var_0_1.ON_UNLOCK, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_18_0

		var_2.OnUnlockCryptolalia(var_19_0, arg_19_1)

		return
	end)
	arg_18_0:bind(var_0_1.ON_DELETE, function(arg_20_0)
		if not arg_18_0.selectedIndex then
			return
		end

		local var_20_0 = arg_18_0

		var_1.OnItemSelected(var_20_0, arg_18_0.selectedIndex)

		return
	end)
	arg_18_0:bind(var_0_1.ON_SELECT, function(arg_21_0, arg_21_1)
		if arg_18_0.cards[arg_21_1] then
			triggerButton = var_2_10003

			var_2_10003(var_2._go)
		end

		return
	end)

	onButton = var_1

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.optionBtn

	local function var_18_2()
		local var_22_0 = arg_18_0

		var_0.emit(var_22_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_18_0, var_18_1, var_18_2, var_1_10006)

	onButton = var_1

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.backBtn

	local function var_18_5()
		local var_23_0 = arg_18_0

		var_0.emit(var_23_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_18_3, var_18_4, var_18_5, var_1_10006)

	onButton = var_1

	local var_18_6 = arg_18_0
	local var_18_7 = arg_18_0.switchBtn

	local function var_18_8()
		if not arg_18_0.selectedIndex then
			return
		end

		if not arg_18_0.displays[arg_18_0.selectedIndex] then
			return
		end

		if not var_0:IsMultiVersion() then
			pg = var_1

			local var_24_0 = var_1.TipsMgr.GetInstance()
			local var_24_1 = var_1.ShowTips

			i18n = var_2_10004

			var_24_1(var_24_0, var_2_10004("cryptolalia_coming_soom"))

			return
		end

		arg_18_0.langType = 1 - arg_18_0.langType

		local var_24_2 = arg_18_0

		var_1.OnItemSelected(var_24_2, arg_18_0.selectedIndex)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_18_6, var_18_7, var_18_8, var_1_10006)

	onButton = var_1

	local var_18_9 = arg_18_0
	local var_18_10 = arg_18_0.listBtn

	local function var_18_11()
		if not arg_18_0.selectedIndex then
			return
		end

		if arg_18_0.displays[arg_18_0.selectedIndex] then
			local var_25_0 = arg_18_0
			local var_25_1 = var_1.Filter(var_25_0)
			local var_25_2 = arg_18_0.listView

			var_2.ExecuteAction(var_25_2, "Show", var_25_1, arg_18_0.langType, var_0.id, arg_18_0.scrollRect)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_18_9, var_18_10, var_18_11, var_1_10006)

	onButton = var_1

	local var_18_12 = arg_18_0
	local var_18_13 = arg_18_0.deleteBtn

	local function var_18_14()
		if not arg_18_0.selectedIndex then
			return
		end

		if arg_18_0.displays[arg_18_0.selectedIndex] and var_0:IsPlayableState(arg_18_0.langType) then
			local var_26_0 = arg_18_0.resDeleteWindow

			var_1.ExecuteAction(var_26_0, "Show", var_0, arg_18_0.langType)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_18_12, var_18_13, var_18_14, var_1_10006)

	onButton = var_1

	local var_18_15 = arg_18_0
	local var_18_16 = arg_18_0.playBtn
	local var_18_17 = var_4.Find(var_18_16, "play")

	local function var_18_18()
		if not arg_18_0.selectedIndex then
			return
		end

		local var_27_0 = arg_18_0

		var_0.PlayVedio(var_27_0, arg_18_0.selectedIndex)

		return
	end

	SFX_PANEL = var_18_16

	var_1(var_18_15, var_18_17, var_18_18, var_18_16)

	onButton = var_1

	local var_18_19 = arg_18_0
	local var_18_20 = arg_18_0.playNextBtn

	local function var_18_21()
		if not arg_18_0.selectedIndex then
			return
		end

		if arg_18_0.displays[arg_18_0.selectedIndex + 1] then
			local var_28_0 = arg_18_0

			var_1.emit(var_28_0, var_0_1.ON_SELECT, var_0.id)
		end

		return
	end

	SFX_PANEL = var_18_16

	var_1(var_18_19, var_18_20, var_18_21, var_18_16)

	onButton = var_1

	local var_18_22 = arg_18_0
	local var_18_23 = arg_18_0.playPrevBtn

	local function var_18_24()
		if not arg_18_0.selectedIndex then
			return
		end

		if arg_18_0.displays[arg_18_0.selectedIndex - 1] then
			local var_29_0 = arg_18_0

			var_1.emit(var_29_0, var_0_1.ON_SELECT, var_0.id)
		end

		return
	end

	SFX_PANEL = var_18_16

	var_1(var_18_22, var_18_23, var_18_24, var_18_16)

	onButton = var_1

	local var_18_25 = arg_18_0
	local var_18_26 = arg_18_0.downloadBtn

	local function var_18_27()
		if not arg_18_0.selectedIndex then
			return
		end

		local var_30_0 = arg_18_0

		var_0.DownloadRes(var_30_0, arg_18_0.selectedIndex)

		return
	end

	SFX_PANEL = var_18_16

	var_1(var_18_25, var_18_26, var_18_27, var_18_16)

	onButton = var_1

	local var_18_28 = arg_18_0
	local var_18_29 = arg_18_0.lockBtn

	local function var_18_30()
		if not arg_18_0.selectedIndex then
			return
		end

		if arg_18_0.displays[arg_18_0.selectedIndex] and var_0:IsLockState() then
			local var_31_0 = arg_18_0.purchaseWindow

			var_1.ExecuteAction(var_31_0, "Show", var_0, arg_18_0.langType)
		end

		return
	end

	SFX_PANEL = var_18_16

	var_1(var_18_28, var_18_29, var_18_30, var_18_16)

	arg_18_0.auditionFlag = false
	onButton = var_1

	local var_18_31 = arg_18_0
	local var_18_32 = arg_18_0.auditionBtn

	local function var_18_33()
		if not arg_18_0.selectedIndex then
			return
		end

		if not arg_18_0.displays[arg_18_0.selectedIndex] then
			return
		end

		arg_18_0.auditionFlag = not arg_18_0.auditionFlag

		if arg_18_0.auditionFlag then
			local var_32_0 = arg_18_0

			var_1.PlayAudition(var_32_0, var_0)

			pg = var_1

			local var_32_1 = var_1.BgmMgr.GetInstance()

			var_1.StopPlay(var_32_1)
		else
			local var_32_2 = arg_18_0

			var_1.ClearAuditionTimer(var_32_2)

			local var_32_3 = arg_18_0.soundPlayer

			var_1.Stop(var_32_3)

			local var_32_4 = arg_18_0.auditionEffect

			var_1.Play(var_32_4, "anim_line_reset")

			pg = var_1

			local var_32_5 = var_1.BgmMgr.GetInstance()

			var_1.ContinuePlay(var_32_5)
		end

		local var_32_6 = arg_18_0

		var_1.UpdateAudition(var_32_6, arg_18_0.auditionFlag)

		return
	end

	SFX_PANEL = var_18_16

	var_1(var_18_31, var_18_32, var_18_33, var_18_16)
	arg_18_0:UpdateAudition(arg_18_0.auditionFlag)

	return
end

function var_0_1.UpdateAudition(arg_33_0, arg_33_1)
	setActive = var_1_10002

	var_1_10002(arg_33_0.auditionBtnOn, arg_33_1)

	setActive = var_1_10002

	var_1_10002(arg_33_0.auditionBtnOff, not arg_33_1)

	return
end

function var_0_1.PlayAudition(arg_34_0, arg_34_1)
	arg_34_0:ClearAuditionTimer()

	local var_34_0 = arg_34_0.auditionEffect

	var_2.Play(var_34_0, "anim_line_loop")

	getProxy = var_2
	PlayerProxy = var_34_0

	local var_34_1 = var_2(var_34_0)
	local var_34_2 = var_2.getRawData(var_34_1)
	local var_34_3 = var_2.GetFlagShip(var_34_2)
	local var_34_4 = arg_34_1:GetAudition(arg_34_0.langType)
	local var_34_5 = arg_34_1:GetAuditionVoice(arg_34_0.langType)
	local var_34_6 = arg_34_0.soundPlayer

	var_5.Load(var_34_6, var_34_4, var_34_5, 0, function(arg_35_0)
		local var_35_0 = arg_34_0

		Timer = var_2_10002
		var_35_0.timer = var_2_10002.New(function()
			if arg_34_0.auditionFlag then
				triggerButton = var_0

				var_0(arg_34_0.auditionBtn)
			end

			return
		end, arg_35_0, 1)

		local var_35_1 = arg_34_0.timer

		var_1.Start(var_35_1)

		return
	end)

	return
end

function var_0_1.ClearAuditionTimer(arg_37_0)
	if arg_37_0.timer then
		local var_37_0 = arg_37_0.timer

		var_1.Stop(var_37_0)

		arg_37_0.timer = nil
	end

	return
end

function var_0_1.IsDownloading(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return false
	end

	local var_38_0 = arg_38_1
	local var_38_1 = arg_38_1.ExistLang

	Cryptolalia = var_1_10005

	if var_38_1(var_38_0, var_1_10005.LANG_TYPE_CH) then
		local var_38_2 = arg_38_1
		local var_38_3 = arg_38_1.GetCpkName

		Cryptolalia = var_5

		local var_38_4 = var_38_3(var_38_2, var_5.LANG_TYPE_CH)

		Cryptolalia = var_1_10003
		var_1_10003 = var_1_10003.BuildCpkPath(var_38_4)

		local var_38_5 = arg_38_0.downloadMgr

		if var_4.IsDownloadState(var_38_5, var_1_10003) then
			return true
		end
	end

	local var_38_6 = arg_38_1
	local var_38_7 = arg_38_1.ExistLang

	Cryptolalia = var_5

	if var_38_7(var_38_6, var_5.LANG_TYPE_JP) then
		local var_38_8 = arg_38_1
		local var_38_9 = arg_38_1.GetCpkName

		Cryptolalia = var_5

		local var_38_10 = var_38_9(var_38_8, var_5.LANG_TYPE_JP)

		Cryptolalia = var_1_10003

		local var_38_11 = var_1_10003.BuildCpkPath(var_38_10)
		local var_38_12 = arg_38_0.downloadMgr

		if var_4.IsDownloadState(var_38_12, var_38_11) then
			return true
		end
	end

	return false
end

function var_0_1.DownloadRes(arg_39_0, arg_39_1)
	ipairs = var_1_10002

	local var_39_0

	if not arg_39_0.displays then
		var_39_0 = {}
	end

	for iter_39_0, iter_39_1 in var_1_10002(var_39_0) do
		if arg_39_0:IsDownloading(iter_39_1) then
			pg = var_7

			local var_39_1 = var_7.TipsMgr.GetInstance()
			local var_39_2 = var_7.ShowTips

			i18n = var_10

			var_39_2(var_39_1, var_10("cryptolalia_download_task_already_exists", iter_39_1:GetName()))

			return
		end
	end

	IsUnityEditor = var_2

	if var_2 then
		pg = var_2

		local var_39_3 = var_2.TipsMgr.GetInstance()
		local var_39_4 = var_2.ShowTips

		i18n = iter_39_0

		var_39_4(var_39_3, iter_39_0("common_no_open"))

		return
	end

	local var_39_5 = arg_39_0.displays[arg_39_1]

	originalPrint = var_3

	var_3(var_39_5:IsDownloadableState(arg_39_0.langType))

	if var_39_5 and var_39_5:IsDownloadableState(arg_39_0.langType) and not arg_39_0.downloadReqList[var_39_5.id] then
		originalPrint = var_3

		var_3("Downloading............")
		arg_39_0:OnUpdateForResDownload("Request", var_39_5, arg_39_1)
		arg_39_0:OnItemSelected(arg_39_0.selectedIndex)
	end

	return
end

function var_0_1.OnUpdateForResDownload(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_2
	local var_40_1 = arg_40_2.GetCpkName(var_40_0, arg_40_0.langType)

	Cryptolalia = var_1_10005

	local var_40_2 = var_1_10005.BuildCpkPath(var_40_1)

	Cryptolalia = var_40_0

	local var_40_3 = var_40_0.BuildSubtitlePath(var_40_1)

	arg_40_0.downloadMgr[arg_40_1](arg_40_0.downloadMgr, {
		var_40_3,
		var_40_2
	}, function(arg_41_0, arg_41_1)
		if not arg_40_0.downloadReqList[arg_40_2.id] or var_2.index ~= arg_40_0.selectedIndex then
			return
		end

		CryptolaliaDownloadMgr = var_3

		if arg_41_1 ~= var_3.PROGRESS_FINISH then
			CryptolaliaDownloadMgr = var_41_0

			local var_41_0

			if arg_41_1 == var_41_0.PROGRESS_ERROR then
				var_41_0 = arg_40_0.downloadReqList
				var_41_0[arg_40_2.id] = nil
				var_41_0 = arg_40_0.cg
				var_41_0.blocksRaycasts = false
				onNextTick = var_41_0

				var_41_0(function()
					local var_42_0 = arg_40_0

					var_0.OnItemSelected(var_42_0, arg_40_0.selectedIndex)

					arg_40_0.cg.blocksRaycasts = true

					return
				end)

				CryptolaliaDownloadMgr = var_41_0

				if arg_41_1 == var_41_0.PROGRESS_FINISH then
					pg = var_41_0

					local var_41_1 = var_41_0.TipsMgr.GetInstance()

					var_41_0 = var_41_0.ShowTips
					i18n = var_2_10006

					var_41_0(var_41_1, var_2_10006("cryptolalia_download_done"))
				end
			else
				setSlider = var_41_0

				var_41_0(arg_40_0.downloadingBtn, 0, 1, arg_41_1)
			end

			return
		end
	end)

	arg_40_0.downloadReqList[arg_40_2.id] = {
		index = arg_40_3
	}

	return
end

function var_0_1.PlayVedio(arg_43_0, arg_43_1)
	if arg_43_0.displays[arg_43_1] and var_2:IsPlayableState(arg_43_0.langType) then
		pg = var_3

		local var_43_0 = var_3.BgmMgr.GetInstance()

		var_3.StopPlay(var_43_0)

		local var_43_1 = var_2
		local var_43_2 = var_2.GetCpkName(var_43_1, arg_43_0.langType)
		local var_43_3 = var_2:GetCaptionsColor()

		CryptolaliaVedioPlayer = var_43_1

		local var_43_4 = var_43_1.New(arg_43_0._tf)

		var_5.Play(var_43_4, var_43_2, var_43_3, function()
			pg = var_2_10000

			local var_44_0 = var_2_10000.BgmMgr.GetInstance()

			var_0.ContinuePlay(var_44_0)

			return
		end)

		arg_43_0.player = var_5
	end

	return
end

function var_0_1.OnUnlockCryptolalia(arg_45_0, arg_45_1)
	ipairs = var_1_10002

	for iter_45_0, iter_45_1 in var_1_10002(arg_45_0.cryptolaliaList) do
		if iter_45_1.id == arg_45_1 then
			iter_45_1:Unlock()
		end
	end

	ipairs = var_2

	for iter_45_2, iter_45_3 in var_2(arg_45_0.displays) do
		if iter_45_3 and iter_45_3.id == arg_45_1 then
			iter_45_3:Unlock()
		end
	end

	if not arg_45_0.selectedIndex then
		return
	end

	if arg_45_0.displays[arg_45_0.selectedIndex] and var_2.id == arg_45_1 then
		arg_45_0:OnItemSelected(arg_45_0.selectedIndex)
	end

	if arg_45_0.purchaseWindow then
		local var_45_0 = arg_45_0.purchaseWindow

		if var_3.GetLoaded(var_45_0) then
			local var_45_1 = arg_45_0.purchaseWindow

			if var_3.isShowing(var_45_1) then
				local var_45_2 = arg_45_0.purchaseWindow

				var_3.Hide(var_45_2)
			end
		end
	end

	return
end

function var_0_1.onBackPressed(arg_46_0)
	if arg_46_0.purchaseWindow then
		local var_46_0 = arg_46_0.purchaseWindow

		if var_1.GetLoaded(var_46_0) then
			local var_46_1 = arg_46_0.purchaseWindow

			if var_1.isShowing(var_46_1) then
				local var_46_2 = arg_46_0.purchaseWindow

				var_1.Hide(var_46_2)

				return
			end
		end
	end

	if arg_46_0.resDeleteWindow then
		local var_46_3 = arg_46_0.resDeleteWindow

		if var_1.GetLoaded(var_46_3) then
			local var_46_4 = arg_46_0.resDeleteWindow

			if var_1.isShowing(var_46_4) then
				local var_46_5 = arg_46_0.resDeleteWindow

				var_1.Hide(var_46_5)

				return
			end
		end
	end

	if arg_46_0.listView then
		local var_46_6 = arg_46_0.listView

		if var_1.GetLoaded(var_46_6) then
			local var_46_7 = arg_46_0.listView

			if var_1.isShowing(var_46_7) then
				local var_46_8 = arg_46_0.listView

				var_1.Hide(var_46_8)

				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_46_0)

	return
end

function var_0_1.willExit(arg_47_0)
	arg_47_0:ClearAuditionTimer()

	if arg_47_0.scrollRect then
		local var_47_0 = arg_47_0.scrollRect

		var_1.Dispose(var_47_0)

		arg_47_0.scrollRect = nil
	end

	arg_47_0.downloadReqList = nil

	if arg_47_0.purchaseWindow then
		local var_47_1 = arg_47_0.purchaseWindow

		var_1.Destroy(var_47_1)

		arg_47_0.purchaseWindow = nil
	end

	if arg_47_0.resDeleteWindow then
		local var_47_2 = arg_47_0.resDeleteWindow

		var_1.Destroy(var_47_2)

		arg_47_0.resDeleteWindow = nil
	end

	if arg_47_0.mainView then
		local var_47_3 = arg_47_0.mainView

		var_1.Dispose(var_47_3)

		arg_47_0.mainView = nil
	end

	if arg_47_0.player then
		local var_47_4 = arg_47_0.player

		var_1.Dispose(var_47_4)

		arg_47_0.player = nil
	end

	if arg_47_0.downloadMgr then
		local var_47_5 = arg_47_0.downloadMgr

		var_1.Dispose(var_47_5)

		arg_47_0.downloadMgr = nil
	end

	if arg_47_0.listView then
		local var_47_6 = arg_47_0.listView

		var_1.Destroy(var_47_6)

		arg_47_0.listView = nil
	end

	arg_47_0.cards = nil

	if arg_47_0.soundPlayer then
		local var_47_7 = arg_47_0.soundPlayer

		var_1.Dispose(var_47_7)

		arg_47_0.soundPlayer = nil
	end

	Input = var_1
	var_1.multiTouchEnabled = true

	return
end

return var_0_1
