class = var_0_10000

local var_0_0 = "ShipProfileScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

var_0_1.SHOW_SKILL_INFO = "event show skill info"
var_0_1.SHOW_EVALUATION = "event show evalution"
var_0_1.WEDDING_REVIEW = "event wedding review"
var_0_1.INDEX_DETAIL = 1
var_0_1.INDEX_PROFILE = 2
var_0_1.CHAT_ANIMATION_TIME = 0.3
var_0_1.CHAT_SHOW_TIME = 3

local var_0_2 = 0.35

function var_0_1.getUIName(arg_1_0)
	return "ShipProfileUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	CollectionProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)
	local var_2_1 = var_2.getShipGroup(var_2_0, arg_2_0.contextData.groupId)

	LoadSpriteAtlasAsync = var_2_0

	var_2_0("bg/star_level_bg_" .. var_2_1:rarity2bgPrintForGet(arg_2_0.showTrans), "", arg_2_1)

	return
end

function var_0_1.setShipGroup(arg_3_0, arg_3_1)
	arg_3_0.shipGroup = arg_3_1
	ShipGroup = var_1_10002
	arg_3_0.groupSkinList = var_1_10002.GetDisplayableSkinList(arg_3_1.id)

	local var_3_0 = arg_3_0.shipGroup

	arg_3_0.isBluePrintGroup = var_2.isBluePrintGroup(var_3_0)

	local var_3_1 = arg_3_0.shipGroup

	arg_3_0.isMetaGroup = var_2.isMetaGroup(var_3_1)

	return
end

function var_0_1.setShowTrans(arg_4_0, arg_4_1)
	arg_4_0.showTrans = arg_4_1

	return
end

function var_0_1.setOwnedSkinList(arg_5_0, arg_5_1)
	arg_5_0.ownedSkinList = arg_5_1

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_0, "bg")

	local var_6_1 = arg_6_0.bg

	arg_6_0.staticBg = var_1.Find(var_6_1, "static_bg")

	local var_6_2 = arg_6_0._tf

	arg_6_0.painting = var_1.Find(var_6_2, "paint")
	findTF = var_1
	arg_6_0.paintingFitter = var_1(arg_6_0.painting, "fitter")
	arg_6_0.paintingInitPos = arg_6_0.painting.transform.localPosition

	local var_6_3 = arg_6_0._tf

	arg_6_0.chatTF = var_1.Find(var_6_3, "paint/chat")
	setActive = var_1

	var_1(arg_6_0.chatTF, false)

	local var_6_4 = arg_6_0.painting

	arg_6_0.commonPainting = var_1.Find(var_6_4, "fitter")

	local var_6_5 = arg_6_0.painting

	arg_6_0.l2dRoot = var_1.Find(var_6_5, "live2d")

	local var_6_6 = arg_6_0.painting

	arg_6_0.spinePaintingRoot = var_1.Find(var_6_6, "spinePainting")

	local var_6_7 = arg_6_0._tf

	arg_6_0.spinePaintingBgRoot = var_1.Find(var_6_7, "paintBg/spinePainting")

	local var_6_8 = arg_6_0.chatTF

	arg_6_0.chatBg = var_1.Find(var_6_8, "chatbgtop")
	arg_6_0.initChatBgH = arg_6_0.chatBg.sizeDelta.y

	local var_6_9 = arg_6_0.chatBg

	arg_6_0.chatText = var_1.Find(var_6_9, "Text")

	local var_6_10 = arg_6_0._tf

	arg_6_0.name = var_1.Find(var_6_10, "name")
	arg_6_0.nameInitPos = arg_6_0.name.transform.localPosition

	local var_6_11 = arg_6_0.name

	arg_6_0.shipType = var_1.Find(var_6_11, "type")

	local var_6_12 = arg_6_0.name
	local var_6_13 = var_1.Find(var_6_12, "name_mask/Text")
	local var_6_14 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.labelName = var_6_14(var_6_13, var_3(var_1_10004))

	local var_6_15 = arg_6_0.name
	local var_6_16 = var_1.Find(var_6_15, "english_name")
	local var_6_17 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.labelEnName = var_6_17(var_6_16, var_3(var_1_10004))

	local var_6_18 = arg_6_0.name

	arg_6_0.stars = var_1.Find(var_6_18, "stars")
	arg_6_0.star = arg_6_0:getTpl("star_tpl", arg_6_0.stars)

	local var_6_19 = arg_6_0._tf

	arg_6_0.blurPanel = var_1.Find(var_6_19, "blur_panel")

	local var_6_20 = arg_6_0._tf

	arg_6_0.top = var_1.Find(var_6_20, "blur_panel/adapt/top")

	local var_6_21 = arg_6_0.top

	arg_6_0.btnBack = var_1.Find(var_6_21, "back")

	local var_6_22 = arg_6_0._tf

	arg_6_0.bottomTF = var_1.Find(var_6_22, "adapt/bottom")

	local var_6_23 = arg_6_0.blurPanel

	arg_6_0.labelHeart = var_1.Find(var_6_23, "adapt/detail_left_panel/heart/label")

	local var_6_24 = arg_6_0.blurPanel

	arg_6_0.btnLike = var_1.Find(var_6_24, "adapt/detail_left_panel/heart/btnLike")

	local var_6_25 = arg_6_0.blurPanel

	arg_6_0.btnChangeSkin = var_1.Find(var_6_25, "adapt/detail_left_panel/change_skin")
	ChangeSkinToggle = var_1

	local var_6_26 = var_1.New

	findTF = var_6_25
	arg_6_0.changeSkinToggle = var_6_26(var_6_25(arg_6_0.btnChangeSkin, "toggle_ui"))

	local var_6_27 = arg_6_0.btnLike

	arg_6_0.btnLikeAct = var_1.Find(var_6_27, "like")

	local var_6_28 = arg_6_0.btnLike

	arg_6_0.btnLikeDisact = var_1.Find(var_6_28, "unlike")

	local var_6_29 = arg_6_0._tf

	arg_6_0.obtainBtn = var_1.Find(var_6_29, "adapt/bottom/others/obtain_btn")

	local var_6_30 = arg_6_0._tf

	arg_6_0.evaBtn = var_1.Find(var_6_30, "adapt/bottom/others/eva_btn")

	local var_6_31 = arg_6_0._tf

	arg_6_0.viewBtn = var_1.Find(var_6_31, "adapt/bottom/others/view_btn")

	local var_6_32 = arg_6_0._tf

	arg_6_0.shareBtn = var_1.Find(var_6_32, "adapt/bottom/others/share_btn")

	local var_6_33 = arg_6_0._tf

	arg_6_0.rotateBtn = var_1.Find(var_6_33, "adapt/bottom/others/rotate_btn")

	local var_6_34 = arg_6_0._tf

	arg_6_0.cryptolaliaBtn = var_1.Find(var_6_34, "adapt/bottom/others/cryptolalia_btn")

	local var_6_35 = arg_6_0._tf

	arg_6_0.equipCodeBtn = var_1.Find(var_6_35, "adapt/bottom/others/equip_code_btn")

	local var_6_36 = arg_6_0.blurPanel

	arg_6_0.leftProfile = var_1.Find(var_6_36, "adapt/profile_left_panel")

	local var_6_37 = arg_6_0.leftProfile

	arg_6_0.modelContainer = var_1.Find(var_6_37, "model")
	ShipProfileLive2dBtn = var_1

	local var_6_38 = var_1.New
	local var_6_39 = arg_6_0.blurPanel

	arg_6_0.live2DBtn = var_6_38(var_2.Find(var_6_39, "L2D_btn"))
	arg_6_0.l2dBtnOn = false
	GetComponent = var_1

	local var_6_40 = arg_6_0.blurPanel
	local var_6_41 = var_2.Find(var_6_40, "L2D_btn")

	typeof = var_6_40
	Image = var_4

	local var_6_42 = var_1(var_6_41, var_6_40(var_4))

	var_1.SetNativeSize(var_6_42)

	GetComponent = var_1

	local var_6_43 = arg_6_0.blurPanel
	local var_6_44 = var_2.Find(var_6_43, "L2D_btn/img")

	typeof = var_6_43
	Image = var_4

	local var_6_45 = var_1(var_6_44, var_6_43(var_4))

	var_1.SetNativeSize(var_6_45)

	local var_6_46 = arg_6_0.blurPanel

	arg_6_0.spinePaintingBtn = var_1.Find(var_6_46, "SP_btn")
	GetComponent = var_1

	local var_6_47 = arg_6_0.spinePaintingBtn

	typeof = var_3
	Image = var_4

	local var_6_48 = var_1(var_6_47, var_3(var_4))

	var_1.SetNativeSize(var_6_48)

	GetComponent = var_1

	local var_6_49 = arg_6_0.blurPanel
	local var_6_50 = var_2.Find(var_6_49, "SP_btn/img")

	typeof = var_6_49
	Image = var_4

	local var_6_51 = var_1(var_6_50, var_6_49(var_4))

	var_1.SetNativeSize(var_6_51)

	GetComponent = var_1

	local var_6_52 = arg_6_0.blurPanel
	local var_6_53 = var_2.Find(var_6_52, "adapt/top/title")

	typeof = var_6_52
	Image = var_4

	local var_6_54 = var_1(var_6_53, var_6_52(var_4))

	var_1.SetNativeSize(var_6_54)

	local var_6_55 = arg_6_0.spinePaintingBtn

	arg_6_0.spinePaintingToggle = var_1.Find(var_6_55, "toggle")
	ShipProfileCVLoader = var_1
	arg_6_0.cvLoader = var_1.New()

	local var_6_56 = arg_6_0._tf

	arg_6_0.pageTFs = var_1.Find(var_6_56, "adapt/pages")
	ShipProfilePaintingView = var_1
	arg_6_0.paintingView = var_1.New(arg_6_0._tf, arg_6_0.painting)

	local var_6_57 = {}
	local var_6_58 = arg_6_0._tf

	var_6_57[1] = var_2.Find(var_6_58, "adapt/bottom/detail")

	local var_6_59 = arg_6_0._tf

	var_6_57[2] = var_2.Find(var_6_59, "adapt/bottom/profile")
	arg_6_0.toggles = var_6_57
	ShipProfileInformationPage = var_6_57

	local var_6_60 = var_6_57.New(arg_6_0.pageTFs, arg_6_0.event)

	ShipProfileDetailPage = var_2

	local var_6_61 = var_2.New(arg_6_0.pageTFs, arg_6_0.event)

	var_6_60:SetCvLoader(arg_6_0.cvLoader)
	var_6_60:SetCallback(function(arg_7_0)
		local var_7_0 = arg_6_0

		var_1.OnCVBtnClick(var_7_0, arg_7_0)

		return
	end)

	arg_6_0.pages = {
		var_6_61,
		var_6_60
	}
	UIItemList = var_3

	local var_6_62 = var_3.New
	local var_6_63 = arg_6_0.leftProfile
	local var_6_64 = var_4.Find(var_6_63, "scroll/Viewport/skin_container")
	local var_6_65 = arg_6_0.leftProfile

	arg_6_0.UISkinList = var_6_62(var_6_64, var_5.Find(var_6_65, "scroll/Viewport/skin_container/skin_tpl"))

	return
end

function var_0_1.didEnter(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.btnBack

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.emit(var_9_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.equipCodeBtn

	local function var_8_5()
		local var_10_0 = arg_8_0
		local var_10_1 = var_0.emit

		ShipProfileMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.OPEN_EQUIP_CODE_SHARE, arg_8_0.shipGroup.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.cryptolaliaBtn

	local function var_8_8()
		local var_11_0 = arg_8_0
		local var_11_1 = var_0.emit

		ShipProfileMediator = var_2_10002

		var_11_1(var_11_0, var_2_10002.OPEN_CRYPTOLALIA, arg_8_0.shipGroup.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10005)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.obtainBtn, function()
		local var_12_0 = {}

		MSGBOX_TYPE_OBTAIN = var_2_10001
		var_12_0.type = var_2_10001

		local var_12_1 = arg_8_0.shipGroup

		var_12_0.shipId = var_1.getShipConfigId(var_12_1)
		var_12_0.list = arg_8_0.shipGroup.groupConfig.description
		ShipProfileMediator = var_1
		var_12_0.mediatorName = var_1.__cname
		pg = var_1

		local var_12_2 = var_1.MsgboxMgr.GetInstance()

		var_1.ShowMsgBox(var_12_2, var_12_0)

		return
	end)

	onButton = var_1_10001

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.evaBtn

	local function var_8_11()
		local var_13_0 = arg_8_0

		var_0.emit(var_13_0, var_0_1.SHOW_EVALUATION, arg_8_0.shipGroup.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_9, var_8_10, var_8_11, var_1_10005)

	onButton = var_1_10001

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.viewBtn

	local function var_8_14()
		LeanTween = var_2_10000

		if var_2_10000.isTweening(arg_8_0.chatTF.gameObject) then
			LeanTween = var_0

			var_0.cancel(arg_8_0.chatTF.gameObject)

			local var_14_0 = arg_8_0.chatTF

			Vector3 = var_1
			var_14_0.localScale = var_1(0, 0, 0)

			if arg_8_0.dailogueCallback then
				arg_8_0.dailogueCallback()

				arg_8_0.dailogueCallback = nil
			end
		end

		local var_14_1 = arg_8_0.paintingView

		var_0.Start(var_14_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_12, var_8_13, var_8_14, var_1_10005)

	onButton = var_1_10001

	local var_8_15 = arg_8_0
	local var_8_16 = arg_8_0.shareBtn

	local function var_8_17()
		pg = var_2_10000

		local var_15_0 = var_2_10000.ShareMgr.GetInstance()
		local var_15_1 = var_0.Share

		pg = var_2_10002

		var_15_1(var_15_0, var_2_10002.ShareMgr.TypeShipProfile)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_15, var_8_16, var_8_17, var_1_10005)

	onButton = var_1_10001

	local var_8_18 = arg_8_0
	local var_8_19 = arg_8_0.rotateBtn

	local function var_8_20()
		setActive = var_2_10000

		var_2_10000(arg_8_0._tf, false)

		setActive = var_2_10000

		var_2_10000(arg_8_0.blurPanel, false)

		local var_16_0 = arg_8_0
		local var_16_1 = var_0.emit

		ShipProfileMediator = var_2

		var_16_1(var_16_0, var_2.CLICK_ROTATE_BTN, arg_8_0.shipGroup, arg_8_0.showTrans, arg_8_0.skin)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_18, var_8_19, var_8_20, var_1_10005)

	local var_8_21 = arg_8_0.live2DBtn

	var_1.AddListener(var_8_21, function(arg_17_0)
		if arg_17_0 then
			local var_17_0 = arg_8_0

			var_1.CreateLive2D(var_17_0)
		else
			local var_17_1 = arg_8_0

			var_1.clearLive2dPainting(var_17_1)
		end

		local var_17_2 = arg_8_0

		var_17_2.l2dBtnOn = arg_17_0
		setActive = var_17_2

		var_17_2(arg_8_0.viewBtn, not arg_17_0)

		setActive = var_17_2

		var_17_2(arg_8_0.rotateBtn, not arg_17_0)

		setActive = var_17_2

		var_17_2(arg_8_0.commonPainting, not arg_17_0)

		setActive = var_17_2

		var_17_2(arg_8_0.l2dRoot, arg_17_0)

		local var_17_3 = arg_8_0

		var_1.StopDailogue(var_17_3)

		arg_8_0.l2dActioning = nil

		if arg_8_0.skin then
			local var_17_4 = arg_8_0.pages[var_0_1.INDEX_PROFILE]

			var_1.ExecuteAction(var_17_4, "Flush", arg_8_0.skin, arg_17_0)
		end

		return
	end)

	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.toggles) do
		onToggle = var_1_10006

		local var_8_22 = arg_8_0
		local var_8_23 = iter_8_1

		local function var_8_24(arg_18_0)
			if iter_8_0 == var_0_1.INDEX_DETAIL then
				local var_18_0 = arg_8_0.live2DBtn

				var_1.Update(var_18_0, arg_8_0.paintingName, false)

				arg_8_0.spinePaintingisOn = false

				local var_18_1 = arg_8_0

				var_1.updateSpinePaintingState(var_18_1)

				local var_18_2 = arg_8_0

				var_1.DisplaySpinePainting(var_18_2, false)
			end

			if arg_18_0 then
				local var_18_3 = arg_8_0

				var_1.SwitchPage(var_18_3, iter_8_0)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_8_22, var_8_23, var_8_24, var_1_10010)
	end

	arg_8_0:InitCommon()

	local var_8_25 = arg_8_0.live2DBtn

	var_1.Update(var_8_25, arg_8_0.paintingName, false)
	arg_8_0:updateSpinePaintingState()

	onButton = var_1

	local var_8_26 = arg_8_0
	local var_8_27 = arg_8_0.btnChangeSkin

	local function var_8_28()
		local var_19_0 = arg_8_0.skin

		ShipSkin = var_2_10001

		if var_2_10001.IsChangeSkin(var_19_0.id) then
			ShipSkin = var_1

			local var_19_1 = var_1.GetChangeSkinNextId(var_19_0.id)

			pg = var_2

			local var_19_2 = var_2.ship_skin_template[var_19_1]
			local var_19_3 = arg_8_0

			var_3.showSkinProfile(var_19_3, arg_8_0.contextData.skinIndex, var_19_2, arg_8_0.prevSkinBtn)
		end

		return
	end

	SFX_CONFIRM = iter_8_1

	var_1(var_8_26, var_8_27, var_8_28, iter_8_1)

	setActive = var_1

	var_1(arg_8_0.bottomTF, false)

	triggerToggle = var_1

	var_1(arg_8_0.toggles[var_0_1.INDEX_DETAIL], true)

	return
end

function var_0_1.InitSkinList(arg_20_0)
	arg_20_0.skinBtns = {}

	local var_20_0 = arg_20_0.UISkinList

	var_1.make(var_20_0, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			local var_21_0 = arg_20_0.groupSkinList[arg_21_1 + 1]

			ShipProfileSkinBtn = var_4

			local var_21_1 = var_4.New(arg_21_2)

			table = var_5

			var_5.insert(arg_20_0.skinBtns, var_21_1)

			local var_21_2 = var_21_1
			local var_21_3 = var_21_1.Update
			local var_21_4 = var_21_0
			local var_21_5 = arg_20_0.shipGroup

			table = var_2_10009

			var_21_3(var_21_2, var_21_4, var_21_5, var_2_10009.contains(arg_20_0.ownedSkinList, var_21_0.id))

			onButton = var_21_3

			local var_21_6 = arg_20_0
			local var_21_7 = var_21_1._tf

			local function var_21_8()
				if not var_21_1.unlock then
					pg = var_0

					local var_22_0 = var_0.TipsMgr.GetInstance()
					local var_22_1 = var_0.ShowTips

					i18n = var_3_10002

					var_22_1(var_22_0, var_3_10002("ship_profile_skin_locked"))

					return
				end

				local var_22_2 = arg_20_0

				var_0.showSkinProfile(var_22_2, arg_21_1, var_21_0, var_21_1)

				return
			end

			SFX_PANEL = var_9

			var_21_3(var_21_6, var_21_7, var_21_8, var_9)

			setActive = var_21_3

			local var_21_9 = arg_21_2
			local var_21_10 = var_21_0.skin_type

			ShipSkin = var_21_8

			local var_21_11

			if var_21_10 ~= var_21_8.SKIN_TYPE_DEFAULT then
				HXSet = var_21_10
				var_21_11 = not var_21_10.isHxSkin()

				if false then
					var_21_11 = false
				end
			else
				var_21_11 = true
			end

			var_21_3(var_21_9, var_21_11)
		end

		return
	end)

	local var_20_1 = arg_20_0.UISkinList

	var_1.align(var_20_1, #arg_20_0.groupSkinList)

	return
end

function var_0_1.showSkinProfile(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	ShipSkin = var_1_10004

	local var_23_0 = var_1_10004.IsChangeSkin(arg_23_2.id)

	setActive = var_5

	var_5(arg_23_0.btnChangeSkin, var_23_0)

	if var_23_0 then
		local var_23_1 = arg_23_0.changeSkinToggle

		var_5.setSkinData(var_23_1, arg_23_2.id)

		setActive = var_5

		local var_23_2 = arg_23_0.btnChangeSkin
		local var_23_3 = arg_23_0.changeSkinToggle

		var_5(var_23_2, not var_7.IsAsmrSkin(var_23_3))
	end

	arg_23_0.contextData.skinIndex = arg_23_1 + 1

	arg_23_0:ShiftSkin(arg_23_2)

	if arg_23_0.prevSkinBtn then
		local var_23_4 = arg_23_0.prevSkinBtn

		var_5.UnShift(var_23_4)
	end

	arg_23_3:Shift()

	arg_23_0.prevSkinBtn = arg_23_3

	return
end

function var_0_1.InitCommon(arg_24_0)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.LoadSkinBg
	local var_24_2 = arg_24_0.shipGroup

	var_24_1(var_24_0, var_3.rarity2bgPrintForGet(var_24_2, arg_24_0.showTrans))

	setImageSprite = var_24_1

	local var_24_3 = arg_24_0.shipType

	GetSpriteFromAtlas = var_3

	local var_24_4 = "shiptype"
	local var_24_5 = arg_24_0.shipGroup

	var_24_1(var_24_3, var_3(var_24_4, var_5.getShipType(var_24_5, arg_24_0.showTrans)))

	local var_24_6 = arg_24_0.labelName
	local var_24_7 = arg_24_0.shipGroup

	var_24_6.text = var_2.getName(var_24_7, arg_24_0.showTrans)

	local var_24_8 = arg_24_0.shipGroup.shipConfig

	pg = var_2

	local var_24_9 = var_2.ship_data_template[var_24_8.id].star_max

	arg_24_0.labelEnName.text = var_24_8.english_name

	for iter_24_0 = 1, var_24_9 do
		cloneTplTo = var_7

		var_7(arg_24_0.star, arg_24_0.stars)
	end

	arg_24_0:FlushHearts()

	local var_24_10 = arg_24_0.shipGroup
	local var_24_11 = var_3.GetSkin(var_24_10, arg_24_0.showTrans).id

	arg_24_0:SetPainting(var_24_11, arg_24_0.showTrans)

	return
end

function var_0_1.SetPainting(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0

	arg_25_0.RecyclePainting(var_25_0)

	if arg_25_2 and arg_25_0.shipGroup.trans then
		arg_25_1 = arg_25_0.shipGroup.groupConfig.trans_skin
	end

	pg = var_3

	local var_25_1 = var_3.ship_skin_template[arg_25_1].painting

	setPaintingPrefabAsync = var_25_0

	var_25_0(arg_25_0.painting, var_25_1, "chuanwu", function()
		setActive = var_2_10000

		var_2_10000(arg_25_0.commonPainting, true)

		return
	end)

	arg_25_0.paintingName = var_25_1

	arg_25_0:UpdateCryptolaliaBtn(arg_25_1)

	return
end

function var_0_1.RecyclePainting(arg_27_0)
	if arg_27_0.paintingName then
		retPaintingPrefab = var_1

		var_1(arg_27_0.painting, arg_27_0.paintingName)
	end

	return
end

function var_0_1.FlushHearts(arg_28_0)
	local var_28_0 = arg_28_0.shipGroup.hearts

	setText = var_1_10002

	var_1_10002(arg_28_0.labelHeart, var_28_0 > 999 and "999+" or var_28_0)

	local var_28_1 = arg_28_0.labelHeart
	local var_28_2 = var_2.GetComponent(var_28_1, "Text")

	if arg_28_0.shipGroup.iheart then
		Color = var_28_3

		local var_28_3

		if not var_28_3.New(1, 0.6, 0.6) then
			Color = var_28_3
			var_28_3 = var_28_3.New(1, 1, 1)
		end

		var_28_2.color = var_28_3
		setActive = var_28_2

		var_28_2(arg_28_0.btnLikeDisact, not arg_28_0.shipGroup.iheart)

		setActive = var_28_2

		var_28_2(arg_28_0.btnLikeAct, arg_28_0.shipGroup.iheart)

		return
	end
end

function var_0_1.LoadSkinBg(arg_29_0, arg_29_1)
	local var_29_1

	if arg_29_0.isBluePrintGroup then
		local var_29_0 = arg_29_0.shipGroup

		var_29_1 = var_2.rarity2bgPrintForGet(var_29_0, arg_29_0.showTrans)
	end

	arg_29_0.bluePintBg = var_29_1

	local var_29_3

	if arg_29_0.isMetaGroup then
		local var_29_2 = arg_29_0.shipGroup

		var_29_3 = var_2.rarity2bgPrintForGet(var_29_2, arg_29_0.showTrans)
	end

	arg_29_0.metaMainBg = var_29_3

	if arg_29_0.shipSkinBg ~= arg_29_1 then
		arg_29_0.shipSkinBg = arg_29_1

		local function var_29_4(arg_30_0)
			rtf = var_2_10001

			local var_30_0 = var_2_10001(arg_30_0)

			Vector3 = var_2
			var_30_0.localPosition = var_2(0, 0, 200)
			rtf = var_30_0

			local var_30_1 = var_30_0(arg_30_0)

			Vector2 = var_2
			var_30_1.anchorMin = var_2.zero
			rtf = var_30_1

			local var_30_2 = var_30_1(arg_30_0)

			Vector2 = var_2
			var_30_2.anchorMax = var_2.one
			rtf = var_30_2

			local var_30_3 = var_30_2(arg_30_0)

			Vector2 = var_2
			var_30_3.offsetMin = var_2(0, 0)
			rtf = var_30_3

			local var_30_4 = var_30_3(arg_30_0)

			Vector2 = var_2
			var_30_4.offsetMax = var_2(0, 0)

			return
		end

		local function var_29_5()
			PoolMgr = var_2_10000

			local var_31_0 = var_2_10000.GetInstance()
			local var_31_1 = var_0.GetUI
			local var_31_2 = "raritydesign"
			local var_31_3 = arg_29_0.shipGroup

			var_31_1(var_31_0, var_31_2 .. var_3.getRarity(var_31_3, arg_29_0.showTrans), true, function(arg_32_0)
				arg_29_0.designBg = arg_32_0

				local var_32_0 = arg_29_0
				local var_32_1 = "raritydesign"
				local var_32_2 = arg_29_0.shipGroup

				var_32_0.designName = var_32_1 .. var_3.getRarity(var_32_2, arg_29_0.showTrans)

				local var_32_3 = arg_32_0.transform

				var_1.SetParent(var_32_3, arg_29_0.staticBg, false)

				local var_32_4 = arg_32_0.transform

				Vector3 = var_32_3
				var_32_4.localPosition = var_32_3(1, 1, 1)

				local var_32_5 = arg_32_0.transform

				Vector3 = var_2
				var_32_5.localScale = var_2(1, 1, 1)

				local var_32_6 = arg_32_0.transform

				var_1.SetSiblingIndex(var_32_6, 1)

				SetTFLayerOrder = var_1

				local var_32_7 = arg_32_0.transform

				LayerWeightConst = var_3

				var_1(var_32_7, var_3.PAINTING_RARITY_DESIGN_LAYER)

				setActive = var_1

				var_1(arg_32_0, true)

				return
			end)

			return
		end

		local function var_29_6()
			PoolMgr = var_2_10000

			local var_33_0 = var_2_10000.GetInstance()
			local var_33_1 = var_0.GetUI
			local var_33_2 = "raritymeta"
			local var_33_3 = arg_29_0.shipGroup

			var_33_1(var_33_0, var_33_2 .. var_3.getRarity(var_33_3, arg_29_0.showTrans), true, function(arg_34_0)
				arg_29_0.metaBg = arg_34_0

				local var_34_0 = arg_29_0
				local var_34_1 = "raritymeta"
				local var_34_2 = arg_29_0.shipGroup

				var_34_0.metaName = var_34_1 .. var_3.getRarity(var_34_2, arg_29_0.showTrans)

				local var_34_3 = arg_34_0.transform

				var_1.SetParent(var_34_3, arg_29_0.staticBg, false)

				local var_34_4 = arg_34_0.transform

				Vector3 = var_34_3
				var_34_4.localPosition = var_34_3(1, 1, 1)

				local var_34_5 = arg_34_0.transform

				Vector3 = var_2
				var_34_5.localScale = var_2(1, 1, 1)

				local var_34_6 = arg_34_0.transform

				var_1.SetSiblingIndex(var_34_6, 1)

				setActive = var_1

				var_1(arg_34_0, true)

				return
			end)

			return
		end

		local function var_29_7(arg_35_0)
			if arg_29_0.bluePintBg and arg_29_1 == arg_29_0.bluePintBg then
				if arg_29_0.metaBg then
					setActive = var_1

					var_1(arg_29_0.metaBg, false)
				end

				if arg_29_0.designBg then
					local var_35_0 = arg_29_0.designName
					local var_35_1 = "raritydesign"
					local var_35_2 = arg_29_0.shipGroup

					if var_35_0 ~= var_35_1 .. var_3.getRarity(var_35_2, arg_29_0.showTrans) then
						PoolMgr = var_35_0

						local var_35_3 = var_35_0.GetInstance()

						var_1.ReturnUI(var_35_3, arg_29_0.designName, arg_29_0.designBg)

						arg_29_0.designBg = nil
					end
				end

				if not arg_29_0.designBg then
					var_29_5()
				else
					setActive = var_1

					var_1(arg_29_0.designBg, true)
				end
			elseif arg_29_0.metaMainBg and arg_29_1 == arg_29_0.metaMainBg then
				if arg_29_0.designBg then
					setActive = var_1

					var_1(arg_29_0.designBg, false)
				end

				if arg_29_0.metaBg then
					local var_35_4 = arg_29_0.metaName
					local var_35_5 = "raritymeta"
					local var_35_6 = arg_29_0.shipGroup

					if var_35_4 ~= var_35_5 .. var_3.getRarity(var_35_6, arg_29_0.showTrans) then
						PoolMgr = var_35_4

						local var_35_7 = var_35_4.GetInstance()

						var_1.ReturnUI(var_35_7, arg_29_0.metaName, arg_29_0.metaBg)

						arg_29_0.metaBg = nil
					end
				end

				if not arg_29_0.metaBg then
					var_29_6()
				else
					setActive = var_1

					var_1(arg_29_0.metaBg, true)
				end
			else
				if arg_29_0.designBg then
					setActive = var_1

					var_1(arg_29_0.designBg, false)
				end

				if arg_29_0.metaBg then
					setActive = var_1

					var_1(arg_29_0.metaBg, false)
				end
			end

			return
		end

		pg = var_1_10006

		local var_29_8 = var_1_10006.DynamicBgMgr.GetInstance()

		var_6.LoadBg(var_29_8, arg_29_0, arg_29_1, arg_29_0.bg, arg_29_0.staticBg, var_29_4, var_29_7)
	end

	return
end

function var_0_1.SwitchPage(arg_36_0, arg_36_1)
	if arg_36_0.index ~= arg_36_1 then
		seriesAsync = var_2

		var_2({
			function(arg_37_0)
				local var_37_0 = arg_36_0

				var_1.OverlayPanel(var_37_0, arg_36_0.blurPanel)
				arg_37_0()

				return
			end,
			function(arg_38_0)
				local var_38_0 = arg_36_0.pages[arg_36_1]
				local var_38_1 = arg_36_1 == var_0_1.INDEX_PROFILE and not var_38_0:GetLoaded()

				var_38_0:ExecuteAction("Update", arg_36_0.shipGroup, arg_36_0.showTrans, function()
					if var_38_1 then
						local var_39_0 = arg_36_0

						var_0.InitSkinList(var_39_0)
					end

					arg_38_0()

					return
				end)

				return
			end,
			function(arg_40_0)
				if not arg_36_0.index then
					arg_40_0()

					return
				end

				local var_40_0 = arg_36_0.pages[arg_36_0.index]

				var_1.ExecuteAction(var_40_0, "ExistAnim", var_0_2)
				arg_40_0()

				return
			end,
			function(arg_41_0)
				local var_41_0 = arg_36_0.pages[arg_36_1]

				SetParent = var_2

				var_2(arg_36_0.bottomTF, var_41_0._tf)

				setActive = var_2

				var_2(arg_36_0.bottomTF, true)

				setAnchoredPosition = var_2

				var_2(arg_36_0.bottomTF, {
					z = 0,
					x = -7,
					y = 24
				})
				var_41_0:ExecuteAction("EnterAnim", var_0_2)

				local var_41_1 = arg_36_0

				var_2.TweenPage(var_41_1, arg_36_1)
				arg_41_0()

				return
			end,
			function(arg_42_0)
				arg_36_0.index = arg_36_1

				local var_42_0

				if not arg_36_0.contextData.skinIndex then
					var_42_0 = 1
				end

				if arg_36_1 == var_0_1.INDEX_PROFILE and var_42_0 <= #arg_36_0.skinBtns then
					triggerButton = var_2

					var_2(arg_36_0.skinBtns[var_42_0]._tf)
				end

				return
			end
		})
	end

	return
end

function var_0_1.TweenPage(arg_43_0, arg_43_1)
	if arg_43_1 == var_0_1.INDEX_DETAIL then
		LeanTween = var_2

		local var_43_0 = var_2.moveX

		rtf = var_1_10003
		var_1_10003 = var_43_0(var_1_10003(arg_43_0.leftProfile), -700, var_0_2)

		local var_43_1 = var_2.setEase

		LeanTweenType = var_4

		var_43_1(var_1_10003, var_4.easeInOutSine)

		LeanTween = var_43_1

		local var_43_2 = var_43_1.moveY

		rtf = var_1_10003
		var_1_10003 = var_43_2(var_1_10003(arg_43_0.live2DBtn._tf), -70, var_0_2)

		local var_43_3 = var_2.setEase

		LeanTweenType = var_4

		var_43_3(var_1_10003, var_4.easeInOutSine)

		LeanTween = var_43_3

		local var_43_4 = var_43_3.moveY

		rtf = var_1_10003
		var_1_10003 = var_43_4(var_1_10003(arg_43_0.spinePaintingBtn), -70, var_0_2)

		local var_43_5 = var_2.setEase

		LeanTweenType = var_4

		var_43_5(var_1_10003, var_4.easeInOutSine)

		LeanTween = var_43_5

		local var_43_6 = var_43_5.moveX

		rtf = var_1_10003
		var_1_10003 = var_43_6(var_1_10003(arg_43_0.painting), arg_43_0.paintingInitPos.x, var_0_2)

		local var_43_7 = var_2.setEase

		LeanTweenType = var_4

		var_43_7(var_1_10003, var_4.easeInOutSine)

		LeanTween = var_43_7

		local var_43_8 = var_43_7.moveX

		rtf = var_1_10003
		var_1_10003 = var_43_8(var_1_10003(arg_43_0.name), arg_43_0.nameInitPos.x, var_0_2)

		local var_43_9 = var_2.setEase

		LeanTweenType = var_4

		var_43_9(var_1_10003, var_4.easeInOutSine)
	elseif arg_43_1 == var_0_1.INDEX_PROFILE then
		LeanTween = var_2

		local var_43_10 = var_2.moveX

		rtf = var_1_10003

		local var_43_11 = var_43_10(var_1_10003(arg_43_0.leftProfile), 0, var_0_2)
		local var_43_12 = var_2.setEase

		LeanTweenType = var_4

		var_43_12(var_43_11, var_4.easeInOutSine)

		LeanTween = var_43_12

		local var_43_13 = var_43_12.moveY

		rtf = var_43_11

		local var_43_14 = var_43_13(var_43_11(arg_43_0.live2DBtn._tf), 60, var_0_2)
		local var_43_15 = var_2.setEase

		LeanTweenType = var_4

		var_43_15(var_43_14, var_4.easeInOutSine)

		LeanTween = var_43_15

		local var_43_16 = var_43_15.moveY

		rtf = var_43_14

		local var_43_17 = var_43_16(var_43_14(arg_43_0.spinePaintingBtn), 60, var_0_2)
		local var_43_18 = var_2.setEase

		LeanTweenType = var_4

		var_43_18(var_43_17, var_4.easeInOutSine)

		LeanTween = var_43_18

		local var_43_19 = var_43_18.moveX

		rtf = var_43_17

		local var_43_20 = var_43_19(var_43_17(arg_43_0.painting), arg_43_0.paintingInitPos.x + 50, var_0_2)
		local var_43_21 = var_2.setEase

		LeanTweenType = var_4

		var_43_21(var_43_20, var_4.easeInOutSine)

		LeanTween = var_43_21

		local var_43_22 = var_43_21.moveX

		rtf = var_43_20

		local var_43_23 = var_43_22(var_43_20(arg_43_0.name), arg_43_0.nameInitPos.x + 50, var_0_2)
		local var_43_24 = var_2.setEase

		LeanTweenType = var_4

		var_43_24(var_43_23, var_4.easeInOutSine)
	end

	return
end

function var_0_1.ShiftSkin(arg_44_0, arg_44_1)
	if arg_44_0.index ~= var_0_1.INDEX_PROFILE or arg_44_0.skin and arg_44_1.id == arg_44_0.skin.id then
		return
	end

	arg_44_0.skin = arg_44_1

	arg_44_0:SetPainting(arg_44_1.id, false)
	arg_44_0:LoadModel(arg_44_1)

	local var_44_0 = arg_44_0.live2DBtn

	var_2.Disable(var_44_0)

	local var_44_1 = arg_44_0.live2DBtn

	var_2.Update(var_44_1, arg_44_0.paintingName, false)

	local var_44_2
	local var_44_3 = arg_44_1 and arg_44_1.spine_use_live2d == 1 and "spine_painting_bg" or "live2d_bg"

	LoadSpriteAtlasAsync = var_44_1

	var_44_1("ui/share/btn_l2d_atlas", var_44_3, function(arg_45_0)
		GetComponent = var_2_10001

		local var_45_0 = arg_44_0.blurPanel
		local var_45_1 = var_2.Find(var_45_0, "L2D_btn")

		typeof = var_45_0
		Image = var_4

		local var_45_2 = var_2_10001(var_45_1, var_45_0(var_4))

		var_45_2.sprite = arg_45_0
		GetComponent = var_45_2

		local var_45_3 = arg_44_0.blurPanel
		local var_45_4 = var_2.Find(var_45_3, "L2D_btn/img")

		typeof = var_45_3
		Image = var_4

		local var_45_5 = var_45_2(var_45_4, var_45_3(var_4))

		var_45_5.sprite = arg_45_0
		GetComponent = var_45_5

		local var_45_6 = arg_44_0.blurPanel
		local var_45_7 = var_2.Find(var_45_6, "L2D_btn")

		typeof = var_45_6
		Image = var_4

		local var_45_8 = var_45_5(var_45_7, var_45_6(var_4))

		var_1.SetNativeSize(var_45_8)

		GetComponent = var_1

		local var_45_9 = arg_44_0.blurPanel
		local var_45_10 = var_2.Find(var_45_9, "L2D_btn/img")

		typeof = var_45_9
		Image = var_4

		local var_45_11 = var_1(var_45_10, var_45_9(var_4))

		var_1.SetNativeSize(var_45_11)

		return
	end)

	arg_44_0.spinePaintingisOn = false

	arg_44_0:updateSpinePaintingState()
	arg_44_0:DestroySpinePainting()

	local var_44_4 = arg_44_0.pages[var_0_1.INDEX_PROFILE]

	var_3.ExecuteAction(var_44_4, "Flush", arg_44_1, false)

	local var_44_5

	PlayerPrefs = var_44_4

	local var_44_6 = var_44_4.GetInt("paint_hide_other_obj_" .. arg_44_0.skin.painting, 0) == 0

	if arg_44_0.skin.bg_sp and arg_44_0.skin.bg_sp ~= "" and var_44_6 then
		var_44_5 = arg_44_0.skin.bg_sp
	elseif arg_44_0.skin.bg and arg_44_0.skin.bg ~= "" then
		var_44_5 = arg_44_0.skin.bg
	else
		local var_44_7 = arg_44_0.shipGroup

		var_44_5 = var_6.rarity2bgPrintForGet(var_44_7, arg_44_0.showTrans, arg_44_0.skin.id)
	end

	arg_44_0:LoadSkinBg(var_44_5)

	checkABExist = var_6
	arg_44_0.haveOp = var_6("ui/skinunlockanim/star_level_unlock_anim_" .. arg_44_0.skin.id)

	return
end

function var_0_1.UpdateCryptolaliaBtn(arg_46_0, arg_46_1)
	ShipSkin = var_1_10002

	local var_46_0 = var_1_10002.New({
		id = arg_46_1
	})
	local var_46_1 = var_2.getConfig(var_46_0, "ship_group")

	setActive = var_46_0

	local var_46_2 = arg_46_0.cryptolaliaBtn

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_46_3 = var_1_10006(var_1_10007)
	local var_46_4 = var_6.getRawData(var_46_3)

	var_46_0(var_46_2, var_6.ExistCryptolalia(var_46_4, var_46_1))

	return
end

function var_0_1.LoadModel(arg_47_0, arg_47_1)
	if arg_47_0.inLoading then
		return
	end

	arg_47_0:ReturnModel()

	local var_47_0 = arg_47_1.prefab

	arg_47_0.inLoading = true
	SpineAnimChar = var_3

	local var_47_1 = var_3.New()

	var_3.SetPaint(var_47_1, var_47_0)
	var_3:Load(true, function(arg_48_0)
		arg_47_0.inLoading = false

		arg_48_0:SetName(var_47_0)

		local var_48_0 = arg_48_0
		local var_48_1 = arg_48_0.SetLocalPosition

		Vector3 = var_3

		var_48_1(var_48_0, var_3.zero)

		local var_48_2 = arg_48_0
		local var_48_3 = arg_48_0.SetLocalScale

		Vector3 = var_3

		var_48_3(var_48_2, var_3(0.8, 0.8, 1))
		arg_48_0:SetParent(arg_47_0.modelContainer)

		local var_48_4 = arg_48_0
		local var_48_5 = arg_48_0.SetAction
		local var_48_6

		if not arg_47_1.show_skin then
			var_48_6 = "stand"
		end

		var_48_5(var_48_4, var_48_6, 0)

		arg_47_0.characterModel = arg_48_0
		arg_47_0.modelName = var_47_0

		return
	end)

	return
end

function var_0_1.ReturnModel(arg_49_0)
	if arg_49_0.characterModel then
		local var_49_0 = arg_49_0.characterModel

		var_1.Dispose(var_49_0)

		arg_49_0.characterModel = nil
	end

	return
end

function var_0_1.CreateLive2D(arg_50_0)
	local var_50_0 = arg_50_0.live2DBtn

	var_1.SetEnable(var_50_0, false)

	if arg_50_0.l2dChar then
		local var_50_1 = arg_50_0.l2dChar

		var_1.Dispose(var_50_1)

		arg_50_0.l2dChar = nil
	end

	local var_50_2 = arg_50_0.shipGroup
	local var_50_3 = var_1.getShipConfigId(var_50_2)

	pg = var_50_2

	local var_50_4 = var_50_2.ship_skin_template[arg_50_0.skin.id].live2d_offset_profile
	local var_50_5

	if var_50_4 and #var_50_4 >= 3 then
		local var_50_6 = var_50_4
	else
		local var_50_7 = {
			0,
			0,
			0,
			52
		}
	end

	Live2DPainting = var_1_10004

	local var_50_8 = var_1_10004.GenerateData
	local var_50_9 = {}

	Ship = var_1_10006
	var_50_9.ship = var_1_10006.New({
		noChangeSkin = true,
		configId = var_50_3,
		skin_id = arg_50_0.skin.id,
		propose = arg_50_0.shipGroup.married
	})
	Vector3 = var_6
	var_50_9.position = var_6(0, 0, 0)
	var_50_9.offset = var_50_4
	var_50_9.parent = arg_50_0.l2dRoot

	local var_50_10 = var_50_8(var_50_9)

	Live2DPainting = var_50_9
	arg_50_0.l2dChar = var_50_9.New(var_50_10, function(arg_51_0)
		arg_51_0:setSortingModeFrontZ()

		local var_51_0 = arg_50_0.live2DBtn

		var_1.SetEnable(var_51_0, true)

		return
	end)
	isHalfBodyLive2D = var_5

	if var_5(arg_50_0.skin.prefab) then
		setAnchoredPosition = var_5

		var_5(arg_50_0.l2dRoot, {
			y = -77 - (arg_50_0.painting.rect.height - arg_50_0.l2dRoot.rect.height * 1.5) / 2
		})
	else
		setAnchoredPosition = var_5

		var_5(arg_50_0.l2dRoot, {
			y = -40
		})
	end

	Live2dConst = var_5

	if var_5.UnLoadL2dPating then
		Live2dConst = var_5

		var_5.UnLoadL2dPating()
	end

	return
end

function var_0_1.GetModelAction(arg_52_0, arg_52_1)
	local var_52_0

	if not arg_52_1.spine_action or arg_52_1.spine_action == "" then
		return "stand"
	else
		return arg_52_1.spine_action
	end

	return
end

function var_0_1.OnCVBtnClick(arg_53_0, arg_53_1)
	if arg_53_0.l2dActioning then
		return
	end

	local var_53_0 = arg_53_1.voice

	local function var_53_1()
		local var_54_0
		local var_54_1 = arg_53_1

		if var_1.isEx(var_54_1) then
			local var_54_2 = var_53_0.l2d_action .. "_ex"

			if arg_53_0.l2dChar then
				local var_54_3 = arg_53_0.l2dChar

				if var_2.checkActionExist(var_54_3, var_54_2) then
					var_54_0 = var_54_2

					goto label_54_0
				end
			end

			var_54_0 = var_53_0.l2d_action
		else
			var_54_0 = var_53_0.l2d_action
		end

		::label_54_0::

		if arg_53_0.l2dBtnOn and arg_53_0.l2dChar then
			local var_54_4 = arg_53_0.l2dChar

			if not var_1.enablePlayAction(var_54_4, var_54_0) then
				return
			end
		end

		local var_54_5 = arg_53_0

		var_1.UpdatePaintingFace(var_54_5, arg_53_1)

		if arg_53_0.characterModel then
			local var_54_6 = arg_53_0
			local var_54_7 = var_1.GetModelAction(var_54_6, var_53_0)
			local var_54_8 = arg_53_0.characterModel

			var_2.SetAction(var_54_8, var_54_7, 0)
		end

		local var_54_9 = {
			var_0_1.CHAT_SHOW_TIME
		}

		if arg_53_0.live2DBtn.isOn and arg_53_0.l2dChar then
			local var_54_10 = arg_53_0.l2dChar

			if var_2.IsLoaded(var_54_10) then
				arg_53_0.l2dActioning = true

				local var_54_11 = arg_53_1

				if not var_2.L2dHasEvent(var_54_11) then
					parallelAsync = var_2

					var_2({
						function(arg_55_0)
							local var_55_0 = arg_53_0

							var_1.RemoveLive2DTimer(var_55_0)

							local var_55_1 = arg_53_0
							local var_55_2 = arg_53_0.l2dChar

							var_55_1.l2dActioning = var_2.TriggerAction(var_55_2, var_54_0, arg_55_0)

							return
						end,
						function(arg_56_0)
							local var_56_0 = arg_53_0

							var_1.PlayVoice(var_56_0, arg_53_1, var_54_9)

							local var_56_1 = arg_53_0

							var_1.ShowDailogue(var_56_1, arg_53_1, var_54_9, arg_56_0)

							return
						end
					}, function()
						arg_53_0.l2dActioning = false

						return
					end)
				else
					seriesAsync = var_2

					var_2({
						function(arg_58_0)
							local var_58_0 = arg_53_0

							var_1.RemoveLive2DTimer(var_58_0)

							local var_58_1 = arg_53_0.l2dChar

							if var_1.checkActionProfile(var_58_1, var_54_0) then
								local var_58_2 = arg_53_0
								local var_58_3 = arg_53_0.l2dChar

								var_58_2.l2dActioning = var_2.TriggerAction(var_58_3, var_54_0, arg_58_0, nil, function(arg_59_0)
									local var_59_0 = arg_53_0

									var_1.PlayVoice(var_59_0, arg_53_1, var_54_9)

									local var_59_1 = arg_53_0

									var_1.ShowDailogue(var_59_1, arg_53_1, var_54_9, arg_58_0)

									return
								end)
							else
								local var_58_4 = arg_53_0

								var_1.PlayVoice(var_58_4, arg_53_1, var_54_9)

								local var_58_5 = arg_53_0

								var_1.ShowDailogue(var_58_5, arg_53_1, var_54_9, arg_58_0)
							end

							return
						end
					}, function()
						arg_53_0.l2dActioning = false

						return
					end)
				end
			end
		else
			local var_54_12 = arg_53_0

			var_2.PlayVoice(var_54_12, arg_53_1, var_54_9)

			local var_54_13 = arg_53_0

			var_2.ShowDailogue(var_54_13, arg_53_1, var_54_9)
		end

		return
	end

	if var_53_0.key == "unlock" and arg_53_0.haveOp then
		var_1_10005 = arg_53_0

		arg_53_0.playOpening(var_1_10005, var_53_1)
	elseif arg_53_1.voice.resource_key == "get" then
		local var_53_2 = arg_53_1.skin.id

		PaintingShowScene = var_1_10005

		if var_1_10005.GetSkinShowAble(var_53_2) then
			local var_53_3 = arg_53_0
			local var_53_4 = arg_53_0.emit

			ShipProfileMediator = var_1_10007

			var_53_4(var_53_3, var_1_10007.OPEN_PAINTING_SHOW, var_53_2, function()
				onNextTick = var_2_10000

				var_2_10000(function()
					var_53_1()

					return
				end)

				return
			end)
		else
			var_53_1()
		end
	else
		var_53_1()
	end

	return
end

function var_0_1.UpdatePaintingFace(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_1.wordData.mainIndex ~= nil
	local var_63_1 = arg_63_1.voice.key

	if var_63_0 then
		var_63_1 = "main_" .. var_2.mainIndex
	end

	local var_63_2 = arg_63_0.paintingFitter.childCount

	if 0 < var_63_2 then
		ShipExpressionHelper = var_63_2

		local var_63_3 = var_63_2.SetExpression
		local var_63_4 = arg_63_0.paintingFitter

		var_63_3(var_6.GetChild(var_63_4, 0), arg_63_0.paintingName, var_63_1, var_2.maxfavor, arg_63_1.skin.id)
	end

	if arg_63_0.spinePainting then
		local var_63_5

		pg = var_6

		if var_6.AssistantInfo.GetAssistantEventsByDialog(var_63_1) then
			pg = var_6
			var_63_5 = var_6.AssistantInfo.GetAssistantEventsByDialog(var_63_1).action
		end

		ShipExpressionHelper = var_6

		if var_6.GetExpression(arg_63_0.paintingName, var_63_1, var_2.maxfavor, arg_63_1.skin.id) ~= "" then
			local var_63_6 = arg_63_0.spinePainting

			var_7.SetAction(var_63_6, var_6, 1)

			if var_63_5 then
				local var_63_7 = arg_63_0.spinePainting

				if var_7.getAnimationExist(var_63_7, var_63_5) then
					local var_63_8 = arg_63_0.spinePainting

					var_7.SetEmptyAction(var_63_8, 1)

					local var_63_9 = arg_63_0.spinePainting

					var_7.SetOnceAction(var_63_9, var_63_5, nil, function()
						return
					end, true)

					goto label_63_0
				end
			end

			local var_63_10 = arg_63_0.spinePainting

			if var_7.isInAction(var_63_10) then
				local var_63_11 = arg_63_0.spinePainting
				local var_63_12 = var_7.SetAction
				local var_63_13 = arg_63_0.spinePainting

				var_63_12(var_63_11, var_9.getIdleName(var_63_13), 0, true)

				local var_63_14 = arg_63_0.spinePainting

				var_7.ClearAction(var_63_14)
			end
		else
			local var_63_15 = arg_63_0.spinePainting

			var_7.SetEmptyAction(var_63_15, 1)

			if var_63_5 then
				local var_63_16 = arg_63_0.spinePainting

				if var_7.getAnimationExist(var_63_16, var_63_5) then
					local var_63_17 = arg_63_0.spinePainting

					var_7.SetOnceAction(var_63_17, var_63_5, nil, function()
						return
					end, true)

					goto label_63_0
				end
			end

			local var_63_18 = arg_63_0.spinePainting

			if var_7.isInAction(var_63_18) then
				local var_63_19 = arg_63_0.spinePainting
				local var_63_20 = var_7.SetAction
				local var_63_21 = arg_63_0.spinePainting

				var_63_20(var_63_19, var_9.getIdleName(var_63_21), 0, true)

				local var_63_22 = arg_63_0.spinePainting

				var_7.ClearAction(var_63_22)
			end
		end
	end

	::label_63_0::

	return
end

function var_0_1.PlayVoice(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = arg_66_1.wordData
	local var_66_1 = arg_66_1.skin
	local var_66_2 = arg_66_1.words
	local var_66_3 = arg_66_0

	arg_66_0.RemoveCvTimer(var_66_3)

	if not var_66_0.cvPath or var_66_0.cvPath == "" then
		return
	end

	local var_66_4 = var_66_2.voice_key

	ShipWordHelper = var_66_3

	if not (var_66_3.CV_KEY_REPALCE <= var_66_4) then
		local var_66_5 = var_66_2.voice_key_2

		ShipWordHelper = var_7

		if not (var_7.CV_KEY_REPALCE <= var_66_5) then
			local var_66_6 = var_66_2.voice_key

			ShipWordHelper = var_7

			if var_66_6 == var_7.CV_KEY_BAN_NEW then
				local var_66_7 = 0

				if arg_66_1.isLive2d and arg_66_0.l2dChar and var_66_0.voiceCalibrate then
					var_66_7 = var_66_0.voiceCalibrate
				end

				local var_66_8 = arg_66_0.cvLoader

				var_7.DelayPlaySound(var_66_8, var_66_0.cvPath, var_66_7, function(arg_67_0)
					if arg_67_0 then
						local var_67_0 = arg_66_2

						long2int = var_2_10002
						var_67_0[1] = var_2_10002(arg_67_0.length) * 0.001
					end

					return
				end)
			end

			local var_66_9 = var_66_0.se

			if arg_66_1.isLive2d and arg_66_0.l2dChar and var_66_9 then
				local var_66_10 = arg_66_0.cvLoader

				var_7.RawPlaySound(var_66_10, "event:/ui/" .. var_66_9[1], var_66_9[2])
			end

			return
		end
	end
end

function var_0_1.RemoveCvSeTimer(arg_68_0)
	if arg_68_0.cvSeTimer then
		local var_68_0 = arg_68_0.cvSeTimer

		var_1.Stop(var_68_0)

		arg_68_0.cvSeTimer = nil
	end

	return
end

function var_0_1.RemoveCvTimer(arg_69_0)
	if arg_69_0.cvTimer then
		local var_69_0 = arg_69_0.cvTimer

		var_1.Stop(var_69_0)

		arg_69_0.cvTimer = nil
	end

	return
end

function var_0_1.RemoveLive2DTimer(arg_70_0)
	if arg_70_0.Live2DTimer then
		LeanTween = var_1

		var_1.cancel(arg_70_0.Live2DTimer)

		arg_70_0.Live2DTimer = nil
	end

	return
end

function var_0_1.ShowDailogue(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	arg_71_0.dailogueCallback = arg_71_3 or function()
		return
	end

	if not arg_71_1.wordData.textContent or var_4 == "" or var_4 == "nil" then
		if arg_71_0.dailogueCallback then
			arg_71_0.dailogueCallback()

			arg_71_0.dailogueCallback = nil
		end

		return
	end

	local var_71_0 = arg_71_1.wordData.voiceCalibrate
	local var_71_1 = arg_71_0.chatText
	local var_71_2 = var_6.GetComponent

	typeof = var_1_10008
	Text = var_1_10009

	local var_71_3 = var_71_2(var_71_1, var_1_10008(var_1_10009))

	setText = var_71_1

	local var_71_4 = arg_71_0.chatText

	SwitchSpecialChar = var_1_10009

	var_71_1(var_71_4, var_1_10009(var_4))

	local var_71_5 = #var_71_3.text

	CHAT_POP_STR_LEN = var_71_4

	if var_71_4 < var_71_5 then
		TextAnchor = var_71_5

		if not var_71_5.MiddleLeft then
			TextAnchor = var_71_5
			var_71_5 = var_71_5.MiddleCenter
		end

		var_71_3.alignment = var_71_5

		local var_71_6 = var_71_3.preferredHeight + 120
		local var_71_7 = arg_71_0.chatBg

		if arg_71_0.initChatBgH < var_71_6 then
			Vector2 = var_71_8

			local var_71_8

			if not var_71_8.New(arg_71_0.chatBg.sizeDelta.x, var_71_6) then
				Vector2 = var_71_8
				var_71_8 = var_71_8.New(arg_71_0.chatBg.sizeDelta.x, arg_71_0.initChatBgH)
			end

			var_71_7.sizeDelta = var_71_8

			arg_71_0:StopDailogue()

			setActive = var_8

			var_8(arg_71_0.chatTF, true)

			LeanTween = var_8

			local var_71_9 = var_8.scale

			rtf = var_9

			local var_71_10 = var_9(arg_71_0.chatTF.gameObject)

			Vector3 = var_10

			local var_71_11 = var_71_9(var_71_10, var_10.New(1, 1, 1), var_0_1.CHAT_ANIMATION_TIME)
			local var_71_12 = var_8.setEase

			LeanTweenType = var_10

			local var_71_13 = var_71_12(var_71_11, var_10.easeOutBack)
			local var_71_14 = var_8.setDelay(var_71_13, var_71_0 and var_71_0 or 0)
			local var_71_15 = var_8.setOnComplete

			System = var_10

			var_71_15(var_71_14, var_10.Action(function()
				LeanTween = var_2_10000

				local var_73_0 = var_2_10000.scale

				rtf = var_2_10001

				local var_73_1 = var_2_10001(arg_71_0.chatTF.gameObject)

				Vector3 = var_2

				local var_73_2 = var_73_0(var_73_1, var_2.New(0, 0, 1), var_0_1.CHAT_ANIMATION_TIME)
				local var_73_3 = var_0.setEase

				LeanTweenType = var_2

				local var_73_4 = var_73_3(var_73_2, var_2.easeInBack)
				local var_73_5 = var_0.setDelay(var_73_4, var_0_1.CHAT_ANIMATION_TIME + arg_71_2[1])
				local var_73_6 = var_0.setOnComplete

				System = var_2

				var_73_6(var_73_5, var_2.Action(function()
					if arg_71_0.dailogueCallback then
						arg_71_0.dailogueCallback()

						arg_71_0.dailogueCallback = nil
					end

					if arg_71_0.spinePainting then
						local var_74_0 = arg_71_0.spinePainting

						var_0.SetEmptyAction(var_74_0, 1)
					end

					return
				end))

				return
			end))

			return
		end
	end
end

function var_0_1.StopDailogue(arg_75_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_75_0.chatTF.gameObject)

	local var_75_0 = arg_75_0.chatTF

	Vector3 = var_2
	var_75_0.localScale = var_2(0, 0)

	return
end

function var_0_1.onBackPressed(arg_76_0)
	if arg_76_0.paintingView.isPreview then
		local var_76_0 = arg_76_0.paintingView

		var_1.Finish(var_76_0, true)

		return
	end

	triggerButton = var_1

	var_1(arg_76_0.btnBack)

	return
end

function var_0_1.playOpening(arg_77_0, arg_77_1)
	local var_77_0 = "star_level_unlock_anim_" .. arg_77_0.skin.id

	checkABExist = var_3

	if var_3("ui/skinunlockanim/" .. var_77_0) then
		pg = var_4

		local var_77_1 = var_4.CpkPlayMgr.GetInstance()

		var_4.PlayCpkMovie(var_77_1, function()
			return
		end, function()
			if arg_77_1 then
				arg_77_1()
			end

			return
		end, "ui/skinunlockanim", var_77_0, true, false)
	elseif arg_77_1 then
		arg_77_1()
	end

	return
end

function var_0_1.updateSpinePaintingState(arg_80_0)
	HXSet = var_1_10001

	local var_80_0 = var_1_10001.autoHxShiftPath("spinepainting/" .. arg_80_0.paintingName)

	checkABExist = var_2

	if var_2(var_80_0) then
		setActive = var_3

		var_3(arg_80_0.spinePaintingBtn, true)

		setActive = var_3

		local var_80_1 = arg_80_0.spinePaintingToggle

		var_3(var_4.Find(var_80_1, "on"), arg_80_0.spinePaintingisOn)

		setActive = var_3

		local var_80_2 = arg_80_0.spinePaintingToggle

		var_3(var_4.Find(var_80_2, "off"), not arg_80_0.spinePaintingisOn)

		removeOnButton = var_3

		var_3(arg_80_0.spinePaintingBtn)

		onButton = var_3

		local var_80_3 = arg_80_0
		local var_80_4 = arg_80_0.spinePaintingBtn

		local function var_80_5()
			local var_81_0 = arg_80_0

			var_81_0.spinePaintingisOn = not arg_80_0.spinePaintingisOn
			setActive = var_81_0

			local var_81_1 = arg_80_0.spinePaintingToggle

			var_81_0(var_1.Find(var_81_1, "on"), arg_80_0.spinePaintingisOn)

			setActive = var_81_0

			local var_81_2 = arg_80_0.spinePaintingToggle

			var_81_0(var_1.Find(var_81_2, "off"), not arg_80_0.spinePaintingisOn)

			if arg_80_0.spinePaintingisOn then
				local var_81_3 = arg_80_0

				var_0.CreateSpinePainting(var_81_3)
			end

			setActive = var_0

			var_0(arg_80_0.viewBtn, not arg_80_0.spinePaintingisOn)

			setActive = var_0

			var_0(arg_80_0.rotateBtn, not arg_80_0.spinePaintingisOn)

			setActive = var_0

			var_0(arg_80_0.commonPainting, not arg_80_0.spinePaintingisOn)

			setActive = var_0

			var_0(arg_80_0.spinePaintingRoot, arg_80_0.spinePaintingisOn)

			setActive = var_0

			var_0(arg_80_0.spinePaintingBgRoot, arg_80_0.spinePaintingisOn)

			local var_81_4 = arg_80_0

			var_0.StopDailogue(var_81_4)

			if arg_80_0.skin then
				local var_81_5 = arg_80_0.pages[var_0_1.INDEX_PROFILE]

				var_0.ExecuteAction(var_81_5, "Flush", arg_80_0.skin, false)
			end

			return
		end

		SFX_PANEL = var_1_10007

		var_3(var_80_3, var_80_4, var_80_5, var_1_10007)
	else
		setActive = var_3

		var_3(arg_80_0.spinePaintingBtn, false)
	end

	return
end

function var_0_1.CreateSpinePainting(arg_82_0)
	if arg_82_0.skin.id ~= arg_82_0.preSkinId then
		arg_82_0:DestroySpinePainting()

		local var_82_0 = arg_82_0.shipGroup
		local var_82_1 = var_1.getShipConfigId(var_82_0)

		SpinePainting = var_82_0

		local var_82_2 = var_82_0.GenerateData
		local var_82_3 = {}

		Ship = var_1_10004
		var_82_3.ship = var_1_10004.New({
			noChangeSkin = true,
			configId = var_82_1,
			skin_id = arg_82_0.skin.id
		})
		Vector3 = var_4
		var_82_3.position = var_4(0, 0, 0)
		var_82_3.parent = arg_82_0.spinePaintingRoot
		pg = var_4
		var_82_3.offset = var_4.ship_skin_template[arg_82_0.skin.id].spine_offset_profile
		var_82_3.effectParent = arg_82_0.spinePaintingBgRoot

		local var_82_4 = var_82_2(var_82_3)

		SpinePainting = var_82_3
		arg_82_0.spinePainting = var_82_3.New(var_82_4, function()
			return
		end)
		arg_82_0.preSkinId = arg_82_0.skin.id
	end

	arg_82_0:DisplaySpinePainting(true)

	return
end

function var_0_1.clearLive2dPainting(arg_84_0)
	if arg_84_0.l2dChar then
		local var_84_0 = arg_84_0.l2dChar

		var_1.Dispose(var_84_0)

		arg_84_0.l2dChar = nil
		arg_84_0.l2dActioning = false
		arg_84_0.cvLoader.prevCvPath = nil

		arg_84_0:StopDailogue()

		local var_84_1 = arg_84_0.cvLoader

		var_1.StopSound(var_84_1)
	end

	return
end

function var_0_1.DestroySpinePainting(arg_85_0)
	if arg_85_0.spinePainting then
		local var_85_0 = arg_85_0.spinePainting

		var_1.Dispose(var_85_0)

		arg_85_0.spinePainting = nil
	end

	arg_85_0.preSkinId = nil

	return
end

function var_0_1.onWeddingReview(arg_86_0, arg_86_1)
	if not arg_86_1 and arg_86_0.exitLoadL2d then
		arg_86_0.exitLoadL2d = false

		local var_86_0 = arg_86_0.live2DBtn

		var_2.Update(var_86_0, arg_86_0.paintingName, true)
	else
		local var_86_1 = arg_86_0.live2DBtn

		var_2.Update(var_86_1, arg_86_0.paintingName, false)
	end

	local var_86_2 = arg_86_0.live2DBtn

	var_2.SetEnable(var_86_2, not arg_86_1)

	if arg_86_0.l2dChar and arg_86_1 then
		local var_86_3 = arg_86_0.l2dChar

		var_2.Dispose(var_86_3)

		arg_86_0.l2dChar = nil
		arg_86_0.l2dActioning = false
		arg_86_0.cvLoader.prevCvPath = nil

		arg_86_0:StopDailogue()

		local var_86_4 = arg_86_0.cvLoader

		var_2.StopSound(var_86_4)

		arg_86_0.exitLoadL2d = true
	end

	if arg_86_0.spinePaintingRoot.childCount > 0 then
		setActive = var_2

		var_2(arg_86_0.commonPainting, not arg_86_0.spinePaintingisOn)
	end

	return
end

function var_0_1.DisplaySpinePainting(arg_87_0, arg_87_1)
	setActive = var_1_10002

	var_1_10002(arg_87_0.spinePaintingRoot, arg_87_1)

	setActive = var_1_10002

	var_1_10002(arg_87_0.spinePaintingBgRoot, arg_87_1)

	return
end

function var_0_1.willExit(arg_88_0)
	pg = var_1_10001

	local var_88_0 = var_1_10001.CpkPlayMgr.GetInstance()

	var_1.DisposeCpkMovie(var_88_0)

	SetParent = var_1

	var_1(arg_88_0.bottomTF, arg_88_0._tf)
	arg_88_0:UnOverlayPanel(arg_88_0.blurPanel, arg_88_0._tf)

	ipairs = var_1

	for iter_88_0, iter_88_1 in var_1(arg_88_0.pages) do
		iter_88_1:Destroy()
	end

	if arg_88_0.l2dChar then
		local var_88_1 = arg_88_0.l2dChar

		var_1.Dispose(var_88_1)

		arg_88_0.l2dChar = nil
	end

	arg_88_0:DestroySpinePainting()

	local var_88_2 = arg_88_0.paintingView

	var_1.Dispose(var_88_2)

	local var_88_3 = arg_88_0.live2DBtn

	var_1.Dispose(var_88_3)

	local var_88_4 = arg_88_0.cvLoader

	var_1.Dispose(var_88_4)
	arg_88_0:ReturnModel()
	arg_88_0:RecyclePainting()

	_ = var_1

	local var_88_5 = var_1.each
	local var_88_6

	if not arg_88_0.skinBtns then
		var_88_6 = {}
	end

	var_88_5(var_88_6, function(arg_89_0)
		arg_89_0:Dispose()

		return
	end)
	arg_88_0:RemoveCvTimer()
	arg_88_0:RemoveCvSeTimer()
	arg_88_0:RemoveLive2DTimer()

	return
end

return var_0_1
