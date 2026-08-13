class = var_0_10000

local var_0_0 = "ProposeUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = {
	1,
	2,
	3,
	4,
	4,
	5,
	5,
	7,
	7,
	7,
	7,
	6,
	7
}

var_0_1.nationSpriteIndex = {
	us = 1,
	de = 4,
	cm = 0,
	cn = 5,
	np = 9,
	um = 11,
	en = 2,
	jp = 3,
	mnf = 8,
	bili = 10,
	ff = 7,
	sn = 6
}

function var_0_1.getUIName(arg_1_0)
	return "ProposeUI"
end

function var_0_1.setShip(arg_2_0, arg_2_1)
	arg_2_0.shipVO = arg_2_1

	local var_2_0 = arg_2_0.shipVO

	arg_2_0.proposeType = var_2.getProposeType(var_2_0)

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.setShipGroupID
	local var_2_3 = arg_2_0.shipVO

	var_2_2(var_2_1, var_4.getGroupId(var_2_3))

	return
end

function var_0_1.setShipGroupID(arg_3_0, arg_3_1)
	arg_3_0.shipGroupID = arg_3_1

	return
end

function var_0_1.setWeddingReviewSkinID(arg_4_0, arg_4_1)
	arg_4_0.reviewSkinID = arg_4_1

	return
end

function var_0_1.setBagProxy(arg_5_0, arg_5_1)
	arg_5_0.bagProxy = arg_5_1

	return
end

function var_0_1.setPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.storybg = var_1.Find(var_7_0, "close/bg")

	local var_7_1 = arg_7_0._tf

	arg_7_0.bgAdd = var_1.Find(var_7_1, "add")
	setActive = var_1

	var_1(arg_7_0.storybg, false)

	setActive = var_1

	var_1(arg_7_0.bgAdd, false)

	local var_7_2 = arg_7_0._tf

	arg_7_0.targetActorTF = var_1.Find(var_7_2, "actor_middle")

	local var_7_3 = arg_7_0._tf

	arg_7_0.maskTF = var_1.Find(var_7_3, "mask")

	local var_7_4 = arg_7_0._tf

	arg_7_0.skipBtn = var_1.Find(var_7_4, "skip_button")
	arg_7_0.actorPainting = nil

	local var_7_5 = arg_7_0._tf
	local var_7_6 = var_1.Find(var_7_5, "Resource/face")
	local var_7_7 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_7_0.materialFace = var_7_7(var_7_6, var_3(var_1_10004)).material

	local var_7_8 = arg_7_0._tf
	local var_7_9 = var_1.Find(var_7_8, "Resource/paint")
	local var_7_10 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_7_0.materialPaint = var_7_10(var_7_9, var_3(var_1_10004)).material
	arg_7_0.finishCallback = arg_7_0.contextData.finishCallback
	GameObject = var_1
	arg_7_0.commonTF = var_1.Find("OverlayCamera/Overlay/UIMain/common")

	local var_7_11 = arg_7_0._tf

	arg_7_0.exchangePanel = var_1.Find(var_7_11, "exchange_panel")

	local var_7_12 = arg_7_0.exchangePanel
	local var_7_13 = var_1.Find(var_7_12, "window/msg_panel/content")

	setText = var_7_12

	local var_7_14 = var_7_13
	local var_7_15 = var_7_13.Find(var_7_14, "text")

	i18n = var_7_14

	var_7_12(var_7_15, var_7_14("word_propose_cost_tip2"))

	pg = var_7_12

	local var_7_16 = var_7_12.gameset.vow_prop_conversion.description

	ipairs = var_7_15

	for iter_7_0, iter_7_1 in var_7_15(var_7_16) do
		Drop = var_1_10008
		var_1_10008 = var_1_10008.New

		local var_7_17 = {
			count = 1
		}

		DROP_TYPE_ITEM = var_1_10010
		var_7_17.type = var_1_10010
		var_7_17.id = iter_7_1
		var_1_10008 = var_1_10008(var_7_17)
		updateDrop = var_7_17

		var_7_17(var_7_13:Find("icon_" .. iter_7_0), var_1_10008)

		onButton = var_7_17
		var_1_10010 = arg_7_0

		local var_7_18 = var_7_13:Find("icon_" .. iter_7_0)

		local function var_7_19()
			local var_8_0 = arg_7_0
			local var_8_1 = var_0.emit

			BaseUI = var_2_10002

			var_8_1(var_8_0, var_2_10002.ON_DROP, var_1_10008)

			return
		end

		SFX_PANEL = var_13

		var_7_17(var_1_10010, var_7_18, var_7_19, var_13)
	end

	onButton = var_3

	local var_7_20 = arg_7_0
	local var_7_21 = arg_7_0.exchangePanel
	local var_7_22 = var_5.Find(var_7_21, "bg")

	local function var_7_23()
		local var_9_0 = arg_7_0

		var_0.hideExchangePanel(var_9_0)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_7_20, var_7_22, var_7_23, var_7)

	onButton = var_3

	local var_7_24 = arg_7_0
	local var_7_25 = arg_7_0.exchangePanel
	local var_7_26 = var_5.Find(var_7_25, "window/top/btnBack")

	local function var_7_27()
		local var_10_0 = arg_7_0

		var_0.hideExchangePanel(var_10_0)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_7_24, var_7_26, var_7_27, var_7)

	onButton = var_3

	local var_7_28 = arg_7_0
	local var_7_29 = arg_7_0.exchangePanel
	local var_7_30 = var_5.Find(var_7_29, "window/button_container/cancel")

	local function var_7_31()
		local var_11_0 = arg_7_0

		var_0.hideExchangePanel(var_11_0)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_7_28, var_7_30, var_7_31, var_7)

	onButton = var_3

	local var_7_32 = arg_7_0
	local var_7_33 = arg_7_0.exchangePanel
	local var_7_34 = var_5.Find(var_7_33, "window/button_container/confirm")

	local function var_7_35()
		getProxy = var_2_10000
		BagProxy = var_2_10001

		local var_12_0 = var_2_10000(var_2_10001)
		local var_12_1 = var_0.getItemCountById

		ITEM_ID_FOR_PROPOSE = var_2_10002

		local var_12_3

		if var_12_1(var_12_0, var_2_10002) > 0 then
			local var_12_2 = arg_7_0

			var_12_3 = var_12_3.emit
			ProposeMediator = var_2_10002

			var_12_3(var_12_2, var_2_10002.EXCHANGE_TIARA)
		else
			ItemTipPanel = var_12_3

			var_12_3.ShowRingBuyTip()
		end

		local var_12_4 = arg_7_0

		var_0.hideExchangePanel(var_12_4)

		return
	end

	SFX_CONFIRM = var_7

	var_3(var_7_32, var_7_34, var_7_35, var_7)

	arg_7_0.tweenList = {}

	return
end

function var_0_1.didEnter(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.emit

	ProposeMediator = var_1_10003

	var_13_1(var_13_0, var_1_10003.HIDE_SHIP_MAIN_WORD)

	if arg_13_0.commonTF then
		setActive = var_1

		var_1(arg_13_0.commonTF, false)
	end

	if arg_13_0.contextData.review then
		arg_13_0.weddingReview = true

		local var_13_2 = arg_13_0.contextData.group

		arg_13_0.proposeType = var_1.getProposeType(var_13_2)

		local var_13_3 = arg_13_0.contextData.group
		local var_13_4 = var_1.getNation(var_13_3)

		Nation = var_13_3

		local var_13_5

		if not var_13_3.Nation2BG(var_13_4) then
			Nation = var_13_5
			var_13_5 = var_13_5.Nation2BG(0)
		end

		arg_13_0.bgName = var_13_5
		onButton = var_13_5

		local var_13_6 = arg_13_0
		local var_13_7 = arg_13_0.skipBtn

		local function var_13_8()
			local var_14_0 = arg_13_0

			var_0.closeView(var_14_0)

			return
		end

		SFX_CANCEL = var_1_10006

		var_13_5(var_13_6, var_13_7, var_13_8, var_1_10006)

		pg = var_13_5

		local var_13_9 = var_13_5.UIMgr.GetInstance()

		var_2.BlurPanel(var_13_9, arg_13_0._tf)
		arg_13_0:doPlay()
	else
		arg_13_0:doMain()
	end

	return
end

function var_0_1.doPlay(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.skipBtn, arg_15_0.weddingReview)
	arg_15_0:setMask(true)

	pg = var_1

	local var_15_0 = var_1.BgmMgr.GetInstance()

	var_1.TempPlay(var_15_0, "wedding")
	arg_15_0:showProposePanel()

	return
end

function var_0_1.doMain(arg_16_0)
	onButton = var_1_10001

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.skipBtn

	local function var_16_2()
		local var_17_0 = arg_16_0

		var_0.closeView(var_17_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_16_0, var_16_1, var_16_2, var_1_10005)

	onButton = var_1_10001

	local var_16_3 = arg_16_0
	local var_16_4 = arg_16_0._tf
	local var_16_5 = var_3.Find(var_16_4, "close0")

	local function var_16_6()
		if arg_16_0.proposeEndFlag then
			local var_18_0 = arg_16_0

			var_0.DisplayRenamePanel(var_18_0)
		else
			local var_18_1 = arg_16_0

			var_0.closeView(var_18_1)
		end

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_16_3, var_16_5, var_16_6, var_5)

	onButton = var_1_10001

	local var_16_7 = arg_16_0
	local var_16_8 = arg_16_0._tf
	local var_16_9 = var_3.Find(var_16_8, "close_end")

	local function var_16_10()
		if arg_16_0.proposeEndFlag then
			local var_19_0 = arg_16_0

			var_0.DisplayRenamePanel(var_19_0)
		else
			local var_19_1 = arg_16_0

			var_0.closeView(var_19_1)
		end

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_16_7, var_16_9, var_16_10, var_5)

	local var_16_11 = arg_16_0.shipVO
	local var_16_12 = var_1.getConfigTable(var_16_11).nationality
	local var_16_13 = "Propose"

	Nation = var_16_9

	local var_16_14 = var_16_13 .. var_16_9.Nation2Side(var_16_12) .. "UI"

	Nation = var_3

	local var_16_15

	if not var_3.Nation2BG(var_16_12) then
		Nation = var_16_15
		var_16_15 = var_16_15.Nation2BG(0)
	end

	arg_16_0.bgName = var_16_15
	PoolMgr = var_16_15

	local var_16_16 = var_16_15.GetInstance()

	var_3.GetUI(var_16_16, var_16_14, true, function(arg_20_0)
		if arg_16_0.exited then
			PoolMgr = var_1
			var_2_10002 = var_1.GetInstance()

			var_1.ReturnUI(var_2_10002, var_16_14, arg_20_0)

			return
		end

		local var_20_0 = arg_16_0

		tf = var_2_10002
		var_20_0.window = var_2_10002(arg_20_0)
		setParent = var_20_0
		tf = var_2

		local var_20_1 = var_2(arg_20_0)
		local var_20_2 = arg_16_0._tf

		var_20_0(var_20_1, var_3.Find(var_20_2, "window"))

		local var_20_3 = arg_16_0
		local var_20_4 = arg_16_0.window

		var_20_3.intimacyTF = var_2.Find(var_20_4, "intimacy/icon")

		local var_20_5 = arg_16_0
		local var_20_6 = arg_16_0.window

		var_20_5.intimacyValueTF = var_2.Find(var_20_6, "intimacy/value")

		local var_20_7 = arg_16_0
		local var_20_8 = arg_16_0.window

		var_20_7.button = var_2.Find(var_20_8, "button")

		local var_20_9 = arg_16_0
		local var_20_10 = arg_16_0.window

		var_20_9.giftButton = var_2.Find(var_20_10, "giftBtn")

		local var_20_11 = arg_16_0
		local var_20_12 = arg_16_0.window

		var_20_11.intimacyDesc = var_2.Find(var_20_12, "desc")

		local var_20_13 = arg_16_0
		local var_20_14 = arg_16_0.window

		var_20_13.intimacydescTime = var_2.Find(var_20_14, "descPic/desc_time")

		local var_20_15 = arg_16_0
		local var_20_16 = arg_16_0.window

		var_20_15.intimacyDescPic = var_2.Find(var_20_16, "descPic")

		local var_20_17 = arg_16_0
		local var_20_18 = arg_16_0.window

		var_20_17.intimacyBuffDesc = var_2.Find(var_20_18, "desc_buff")

		local var_20_19 = arg_16_0
		local var_20_20 = arg_16_0.window

		var_20_19._paintingTF = var_2.Find(var_20_20, "paintMask/paint")

		local var_20_21 = arg_16_0
		local var_20_22 = arg_16_0.window

		var_20_21.intimacyAchieved = var_2.Find(var_20_22, "intimacy/achieved")

		local var_20_23 = arg_16_0
		local var_20_24 = arg_16_0.window

		var_20_23.intimacyNoAchieved = var_2.Find(var_20_24, "intimacy/no_achieved")

		local var_20_25 = arg_16_0
		local var_20_26 = arg_16_0.window

		var_20_25.ringAchieved = var_2.Find(var_20_26, "ringCount/achieved")

		local var_20_27 = arg_16_0
		local var_20_28 = arg_16_0.window

		var_20_27.ringNoAchieved = var_2.Find(var_20_28, "ringCount/no_achieved")

		local var_20_29 = arg_16_0
		local var_20_30 = arg_16_0.window

		var_20_29.ringValue = var_2.Find(var_20_30, "ringCount/value")

		local var_20_31 = arg_16_0
		local var_20_32 = arg_16_0.window

		var_20_31.nameTF = var_2.Find(var_20_32, "title1/Text")

		local var_20_33 = arg_16_0
		local var_20_34 = arg_16_0.window

		var_20_33.shipNameTF = var_2.Find(var_20_34, "title2/Text")

		local var_20_35 = arg_16_0
		local var_20_36 = arg_16_0.window

		var_20_35.campTF = var_2.Find(var_20_36, "Camp")

		local var_20_37 = arg_16_0
		local var_20_38 = arg_16_0.window

		var_20_37.doneTF = var_2.Find(var_20_38, "done")

		local var_20_39 = arg_16_0
		local var_20_40 = arg_16_0.window

		var_20_39.CampSprite = var_2.Find(var_20_40, "CampSprite")
		setActive = var_20_39

		var_20_39(arg_16_0.window, true)

		setText = var_20_39

		var_20_39(arg_16_0.nameTF, arg_16_0.player.name)

		setText = var_20_39

		local var_20_41 = arg_16_0.shipNameTF
		local var_20_42 = arg_16_0.shipVO

		var_20_39(var_20_41, var_3.getName(var_20_42))

		if arg_16_0.CampSprite then
			getImageSprite = var_1

			local var_20_43 = arg_16_0.CampSprite
			local var_20_44 = var_2.Find

			Nation = var_20_42

			if not var_1(var_20_44(var_20_43, var_20_42.Nation2Print(var_16_12))) then
				warning = var_2

				var_2("找不到印花, shipConfigId: " .. arg_16_0.shipVO.configId)

				setActive = var_2

				var_2(arg_16_0.campTF, false)
			else
				setImageSprite = var_2

				var_2(arg_16_0.campTF, var_1, false)

				setActive = var_2

				var_2(arg_16_0.campTF, true)
			end
		end

		setIntimacyIcon = var_1

		local var_20_45 = arg_16_0.intimacyTF
		local var_20_46 = arg_16_0.shipVO

		var_1(var_20_45, var_3.getIntimacyIcon(var_20_46))

		local var_20_47 = arg_16_0.shipVO
		local var_20_48, var_20_49 = var_1.getIntimacyDetail(var_20_47)

		setText = var_3

		local var_20_50 = arg_16_0.intimacyValueTF

		i18n = var_5

		var_3(var_20_50, var_5("propose_intimacy_tip", var_20_49))

		if 100 <= var_20_49 then
			setTextColor = var_3

			local var_20_51 = arg_16_0.intimacyValueTF

			Color = var_5

			var_3(var_20_51, var_5.white)
		else
			setTextColor = var_3

			local var_20_52 = arg_16_0.intimacyValueTF

			Color = var_5

			var_3(var_20_52, var_5.New(0.5843137254901961, 0.5215686274509804, 0.40784313725490196))
		end

		setActive = var_3

		local var_20_53 = arg_16_0.intimacyAchieved
		local var_20_54

		if not arg_16_0.shipVO.propose then
			var_20_54 = var_20_49 >= 100
		end

		var_3(var_20_53, var_20_54)

		setActive = var_3

		var_3(arg_16_0.intimacyNoAchieved, var_20_49 < 100 and not arg_16_0.shipVO.propose)

		local var_20_55 = arg_16_0

		var_3.onUpdateItemCount(var_20_55)

		setActive = var_3

		var_3(arg_16_0.doneTF, arg_16_0.shipVO.propose)

		local var_20_56 = arg_16_0.shipVO
		local var_20_57, var_20_58 = var_3.getIntimacyInfo(var_20_56)
		local var_20_61

		if arg_16_0.shipVO.propose then
			if arg_16_0.intimacyDescPic then
				setActive = var_20_61

				var_20_61(arg_16_0.intimacyDescPic, true)

				local var_20_59 = arg_16_0

				var_20_61.onUpdateIntimacydescTime(var_20_59, arg_16_0.shipVO.proposeTime)
			end

			if arg_16_0.intimacyDesc then
				setActive = var_20_61

				var_20_61(arg_16_0.intimacyDesc, not arg_16_0.intimacyDescPic)

				local var_20_60 = arg_16_0

				var_20_61 = var_20_61.getProposeText(var_20_60)
				setText = var_20_60

				var_20_60(arg_16_0.intimacyDesc, var_20_61)
			end
		else
			if arg_16_0.intimacyDesc then
				GetComponent = var_20_61

				if var_20_61(arg_16_0.intimacyDesc, "VerticalText") then
					GetComponent = var_20_61
					var_20_61 = var_20_61(arg_16_0.intimacyDesc, "VerticalText")
					var_20_61.enabled = false
				end
			end

			if arg_16_0.intimacyDescPic then
				setActive = var_20_61

				var_20_61(arg_16_0.intimacyDescPic, false)
			end

			if arg_16_0.intimacyDesc then
				setActive = var_20_61

				var_20_61(arg_16_0.intimacyDesc, true)

				setText = var_20_61

				local var_20_62 = arg_16_0.intimacyDesc

				i18n = var_7

				var_20_61(var_20_62, var_7(var_20_58, arg_16_0.shipVO.name))
			end
		end

		setText = var_20_61

		local var_20_63 = arg_16_0.intimacyBuffDesc
		local var_20_64 = "*"

		i18n = var_2_10008

		var_20_61(var_20_63, var_20_64 .. var_2_10008(var_20_58 .. "_buff"))

		local var_20_65 = arg_16_0

		var_5.loadChar(var_20_65)

		pg = var_5

		local var_20_66 = var_5.UIMgr.GetInstance()

		var_5.BlurPanel(var_20_66, arg_16_0._tf)

		setActive = var_5

		local var_20_67 = arg_16_0.button
		local var_20_68 = arg_16_0.shipVO

		var_5(var_20_67, not var_7.ShowPropose(var_20_68))

		local var_20_69 = not arg_16_0.shipVO.propose and var_20_48 <= var_20_49
		local var_20_71

		if arg_16_0.shipVO.propose then
			local var_20_70 = arg_16_0.shipVO

			var_20_71 = not var_6.ShowPropose(var_20_70)
		end

		local var_20_72 = arg_16_0.button
		local var_20_73 = var_7.GetComponent

		typeof = var_9
		Button = var_10

		local var_20_74 = var_20_73(var_20_72, var_9(var_10))

		var_20_74.interactable = var_20_69 or var_20_71
		onButton = var_20_74

		local var_20_75 = arg_16_0
		local var_20_76 = arg_16_0.button

		local function var_20_77()
			if var_20_69 then
				local var_21_0 = arg_16_0.bagProxy
				local var_21_1 = var_0.getItemCountById
				local var_21_2 = arg_16_0

				if var_21_1(var_21_0, var_3_10002.getProposeItemId(var_21_2)) < 1 then
					if arg_16_0.proposeType == "imas" then
						var_3_10002 = arg_16_0

						var_1.showExchangePanel(var_3_10002)
					else
						ItemTipPanel = var_1

						var_1.ShowRingBuyTip()
					end

					return
				end

				ShipStatus = var_1

				local var_21_3

				var_21_3, var_3_10002 = var_1.ShipStatusCheck("onPropose", arg_16_0.shipVO)

				if not var_21_3 then
					pg = var_3

					local var_21_4 = var_3.TipsMgr.GetInstance()

					var_3.ShowTips(var_21_4, var_3_10002)

					return
				end

				local var_21_5 = arg_16_0

				var_3.checkPaintingRes(var_21_5, arg_16_0.shipVO, function()
					pg = var_4_10000

					local var_22_0 = var_4_10000.MsgboxMgr.GetInstance()
					local var_22_1 = var_0.ShowMsgBox
					local var_22_2 = {}

					i18n = var_4_10003
					var_22_2.content = var_4_10003("word_propose_cost_tip" .. (arg_16_0.proposeType == "imas" and "1" or ""), var_0)

					function var_22_2.onYes()
						if arg_16_0.intimacydescTime then
							local var_23_0 = arg_16_0
							local var_23_1 = var_0.onUpdateIntimacydescTime

							pg = var_5_10002

							local var_23_2 = var_5_10002.TimeMgr.GetInstance()

							var_23_1(var_23_0, var_2.GetServerTime(var_23_2))
						end

						local var_23_3 = arg_16_0

						var_0.hideWindow(var_23_3)

						setActive = var_0

						var_0(arg_16_0.window, false)

						local var_23_4 = arg_16_0

						var_0.doPlay(var_23_4)

						return
					end

					var_22_1(var_22_0, var_22_2)

					return
				end)
			elseif var_20_71 then
				function arg_16_0.afterRegisterCall()
					local var_24_0 = arg_16_0

					var_24_0.afterRegisterCall = nil
					pg = var_24_0

					local var_24_1 = var_24_0.TipsMgr.GetInstance()
					local var_24_2 = var_0.ShowTips

					i18n = var_4_10002

					var_24_2(var_24_1, var_4_10002("word_propose_switch_tip"))

					local var_24_3 = arg_16_0

					var_0.closeView(var_24_3)

					return
				end

				local var_21_6 = arg_16_0
				local var_21_7 = var_0.emit

				ProposeMediator = var_3_10002

				var_21_7(var_21_6, var_3_10002.REGISTER_SHIP, arg_16_0.shipVO.id)
			else
				local var_21_8 = arg_16_0

				var_0.closeView(var_21_8)
			end

			return
		end

		SFX_PANEL = var_2_10011

		var_20_74(var_20_75, var_20_76, var_20_77, var_2_10011)

		setActive = var_20_74

		local var_20_78 = arg_16_0.giftButton

		LOCK_SHIP_GIFT = var_20_76

		var_20_74(var_20_78, not var_20_76)

		onButton = var_20_74

		local var_20_79 = arg_16_0
		local var_20_80 = arg_16_0.giftButton

		local function var_20_81()
			LOCK_SHIP_GIFT = var_3_10000

			if var_3_10000 then
				return
			end

			local var_25_0 = arg_16_0
			local var_25_1 = var_0.emit

			ProposeMediator = var_3_10002

			var_25_1(var_25_0, var_3_10002.GIFT_SHIP, arg_16_0.shipVO.id)

			return
		end

		SFX_PANEL = var_2_10011

		var_20_74(var_20_79, var_20_80, var_20_81, var_2_10011)

		return
	end)

	return
end

function var_0_1.getProposeText(arg_26_0)
	local var_26_0 = ""

	PLATFORM_CODE = var_1_10002
	PLATFORM_CH = var_1_10003

	if var_1_10002 ~= var_1_10003 then
		PLATFORM_CODE = var_1_10002
		PLATFORM_CHT = var_1_10003

		if var_1_10002 == var_1_10003 then
			i18n = var_1_10002
			var_1_10003 = "intimacy_desc_propose"
			pg = var_1_10004

			local var_26_1 = var_1_10004.TimeMgr.GetInstance()

			var_26_0 = var_1_10002(var_1_10003, var_1_10004.ChieseDescTime(var_26_1, arg_26_0.shipVO.proposeTime, true))
			IsNil = var_1_10002
			GetComponent = var_1_10003

			if not var_1_10002(var_1_10003(arg_26_0.intimacyDesc, "VerticalText")) then
				GetComponent = var_1_10002
				var_1_10002 = var_1_10002(arg_26_0.intimacyDesc, "VerticalText")
				var_1_10002.enabled = true
				i18n = var_1_10002
				var_1_10003 = "intimacy_desc_propose_vertical"
				pg = var_1_10004

				local var_26_2 = var_1_10004.TimeMgr.GetInstance()

				var_26_0 = var_1_10002(var_1_10003, var_1_10004.ChieseDescTime(var_26_2, arg_26_0.shipVO.proposeTime, true))
			end
		else
			PLATFORM_CODE = var_1_10002
			PLATFORM_KR = var_1_10003

			if var_1_10002 == var_1_10003 then
				i18n = var_1_10002

				local var_26_3 = "intimacy_desc_propose"

				pg = var_1_10004

				local var_26_4 = var_1_10004.TimeMgr.GetInstance()

				var_26_0 = var_1_10002(var_26_3, var_1_10004.STimeDescS(var_26_4, arg_26_0.shipVO.proposeTime, "%Y년%m월%d일", true))
				IsNil = var_1_10002
				GetComponent = var_26_3

				if not var_1_10002(var_26_3(arg_26_0.intimacyDesc, "VerticalText")) then
					GetComponent = var_1_10002
					var_1_10002 = var_1_10002(arg_26_0.intimacyDesc, "VerticalText")
					var_1_10002.enabled = true
					i18n = var_1_10002

					local var_26_5 = "intimacy_desc_propose_vertical"

					pg = var_1_10004

					local var_26_6 = var_1_10004.TimeMgr.GetInstance()

					var_26_0 = var_1_10002(var_26_5, var_1_10004.STimeDescS(var_26_6, arg_26_0.shipVO.proposeTime, "%Y년%m월%d일"))
				end
			else
				i18n = var_1_10002

				local var_26_7 = "intimacy_desc_propose"

				pg = var_1_10004

				local var_26_8 = var_1_10004.TimeMgr.GetInstance()

				var_26_0 = var_1_10002(var_26_7, var_4.STimeDescS(var_26_8, arg_26_0.shipVO.proposeTime, "%Y/%m/%d", true))
				IsNil = var_2
				GetComponent = var_26_7

				if not var_2(var_26_7(arg_26_0.intimacyDesc, "VerticalText")) then
					GetComponent = var_2

					local var_26_9 = var_2(arg_26_0.intimacyDesc, "VerticalText")

					var_26_9.enabled = true
					i18n = var_26_9

					local var_26_10 = "intimacy_desc_propose_vertical"

					pg = var_4

					local var_26_11 = var_4.TimeMgr.GetInstance()

					var_26_0 = var_26_9(var_26_10, var_4.STimeDescS(var_26_11, arg_26_0.shipVO.proposeTime, "%Y/%m/%d"))
				end
			end
		end

		return var_26_0
	end
end

function var_0_1.getProposeItemId(arg_27_0)
	if arg_27_0.proposeType == "imas" then
		ITEM_ID_FOR_PROPOSE_IMAS = var_1

		return var_1
	else
		ITEM_ID_FOR_PROPOSE = var_1

		return var_1
	end

	return
end

function var_0_1.onUpdateItemCount(arg_28_0)
	local var_28_0 = arg_28_0.bagProxy
	local var_28_1 = var_1.getItemCountById(var_28_0, arg_28_0:getProposeItemId())

	setActive = var_28_0

	local var_28_2 = arg_28_0.ringAchieved
	local var_28_3

	if not arg_28_0.shipVO.propose then
		var_28_3 = var_28_1 > 0
	end

	var_28_0(var_28_2, var_28_3)

	setActive = var_28_0

	var_28_0(arg_28_0.ringNoAchieved, var_28_1 <= 0 and not arg_28_0.shipVO.propose)

	setText = var_28_0

	local var_28_4 = arg_28_0.ringValue

	i18n = var_4

	var_28_0(var_28_4, var_4(arg_28_0.proposeType == "imas" and "intimacy_desc_tiara" or "intimacy_desc_ring"))

	if arg_28_0.shipVO.propose or 0 < var_28_1 then
		setTextColor = var_2
		var_28_4 = arg_28_0.ringValue
		Color = var_4

		var_2(var_28_4, var_4.white)
	else
		setTextColor = var_2
		var_28_4 = arg_28_0.ringValue
		Color = var_4

		var_2(var_28_4, var_4.New(0.5843137254901961, 0.5215686274509804, 0.40784313725490196))
	end

	local var_28_5

	if arg_28_0.proposeType == "imas" then
		var_28_5 = not arg_28_0.shipVO.propose and var_28_1 == 0
		setActive = var_28_4

		local var_28_6 = arg_28_0.window

		var_28_4(var_4.Find(var_28_6, "ringCount/bg_exchange"), var_28_5)

		setActive = var_28_4

		local var_28_7 = arg_28_0.window

		var_28_4(var_4.Find(var_28_7, "ringCount/icon/btn_exchange"), var_28_5)

		onButton = var_28_4

		local var_28_8 = arg_28_0
		local var_28_9 = arg_28_0.window
		local var_28_10 = var_5.Find(var_28_9, "ringCount/icon/btn_exchange")

		local function var_28_11()
			local var_29_0 = arg_28_0

			var_0.showExchangePanel(var_29_0)

			return
		end

		SFX_PANEL = var_7

		var_28_4(var_28_8, var_28_10, var_28_11, var_7)
	else
		setActive = var_28_5

		local var_28_12 = arg_28_0.window
		local var_28_13 = var_3.Find(var_28_12, "ringCount/icon/base")

		PLATFORM_CODE = var_28_12
		PLATFORM_CH = var_5

		var_28_5(var_28_13, var_28_12 ~= var_5)

		setActive = var_28_5

		local var_28_14 = arg_28_0.window
		local var_28_15 = var_3.Find(var_28_14, "ringCount/icon/hx")

		PLATFORM_CODE = var_28_14
		PLATFORM_CH = var_5

		var_28_5(var_28_15, var_28_14 == var_5)
	end

	return
end

function var_0_1.onUpdateIntimacydescTime(arg_30_0, arg_30_1)
	local var_30_0

	PLATFORM_CODE = var_1_10003
	PLATFORM_JP = var_1_10004

	if var_1_10003 == var_1_10004 then
		if arg_30_0.proposeType == "imas" then
			var_30_0 = "%Y.%m.%d"
		else
			var_30_0 = "%B.%d,    %y"
		end
	else
		PLATFORM_CODE = var_1_10003
		PLATFORM_US = var_1_10004

		if var_1_10003 == var_1_10004 then
			var_30_0 = "%B %d, %Y"
		elseif arg_30_0.proposeType == "imas" then
			i18n = var_1_10003
			var_30_0 = var_1_10003("intimacy_desc_day") .. " %Y.%m.%d"
		else
			var_30_0 = "%B.%d,    %y"
		end
	end

	setText = var_1_10003

	local var_30_1 = arg_30_0.intimacydescTime

	pg = var_1_10005

	local var_30_2 = var_1_10005.TimeMgr.GetInstance()

	var_1_10003(var_30_1, var_5.STimeDescS(var_30_2, arg_30_1, var_30_0))

	return
end

function var_0_1.onBackPressed(arg_31_0)
	isActive = var_1_10001

	if var_1_10001(arg_31_0.exchangePanel) then
		arg_31_0:hideExchangePanel()

		return
	end

	if arg_31_0.window then
		isActive = var_1

		if var_1(arg_31_0.window) then
			pg = var_1

			local var_31_0 = var_1.CriMgr.GetInstance()
			local var_31_1 = var_1.PlaySoundEffect_V3

			SFX_CANCEL = var_1_10003

			var_31_1(var_31_0, var_1_10003)

			triggerButton = var_31_1

			local var_31_2 = arg_31_0._tf

			var_31_1(var_2.Find(var_31_2, "close_end"))
		end
	end

	return
end

function var_0_1.willExit(arg_32_0)
	if arg_32_0._currentVoice then
		local var_32_0 = arg_32_0._currentVoice

		var_1.PlaybackStop(var_32_0)
	end

	arg_32_0._currentVoice = nil
	pg = var_1

	local var_32_1 = var_1.BgmMgr.GetInstance()

	var_1.ContinuePlay(var_32_1)

	IsNil = var_1

	if not var_1(arg_32_0.actorPainting) then
		tf = var_1

		local var_32_2 = var_1(arg_32_0.actorPainting)
		local var_32_3

		if var_1.Find(var_32_2, "temp_mask") then
			Destroy = var_2
			var_32_3 = var_1

			var_2(var_1.Find(var_32_3, "temp_mask"))
		end

		local var_32_4 = var_1
		local var_32_5 = var_1.GetComponent

		typeof = var_32_3
		Image = var_1_10005

		local var_32_6 = var_32_5(var_32_4, var_32_3(var_1_10005))

		var_32_6.material = nil
		PoolMgr = var_32_6

		local var_32_7 = var_32_6.GetInstance()

		var_2.ReturnPainting(var_32_7, arg_32_0.paintingName, arg_32_0.actorPainting)

		arg_32_0.actorPainting = nil
	end

	if arg_32_0.delayTId then
		LeanTween = var_1

		var_1.cancel(arg_32_0.delayTId)
	end

	if arg_32_0.commonTF then
		setActive = var_1

		var_1(arg_32_0.commonTF, true)
	end

	pg = var_1

	local var_32_8 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_32_8, arg_32_0._tf)

	if arg_32_0.l2dChar then
		local var_32_9 = arg_32_0.l2dChar

		var_1.ClearPics(var_32_9)

		arg_32_0.l2dChar = nil
	end

	if arg_32_0.live2dRequestId then
		pg = var_1

		local var_32_10 = var_1.Live2DMgr.GetInstance()

		var_1.StopLoadingLive2d(var_32_10, arg_32_0.live2dRequestId)

		arg_32_0.live2dRequestId = nil
	end

	if arg_32_0._delayVoiceTweenID then
		LeanTween = var_1

		var_1.cancel(arg_32_0._delayVoiceTweenID)

		arg_32_0._delayVoiceTweenID = nil
	end

	if arg_32_0.tweenList then
		cancelTweens = var_1

		var_1(arg_32_0.tweenList)

		arg_32_0.tweenList = nil
	end

	if arg_32_0.contextData.callback then
		arg_32_0.contextData.callback()
	end

	if arg_32_0.finishCallback then
		arg_32_0.finishCallback()

		arg_32_0.finishCallback = nil
	end

	return
end

function var_0_1.setMask(arg_33_0, arg_33_1)
	setActive = var_1_10002

	var_1_10002(arg_33_0.maskTF, arg_33_1)

	return
end

function var_0_1.bgAddAnimation(arg_34_0, arg_34_1)
	setActive = var_1_10002

	var_1_10002(arg_34_0.storybg, true)
	arg_34_0:showbgAdd(true, arg_34_1)

	return
end

function var_0_1.showbgChurch(arg_35_0)
	table = var_1_10001

	local var_35_0 = var_1_10001.insert
	local var_35_1 = arg_35_0.tweenList

	LeanTween = var_1_10003

	local var_35_2 = var_1_10003.scale
	local var_35_3 = arg_35_0.storybg

	Vector3 = var_1_10005

	var_35_0(var_35_1, var_35_2(var_35_3, var_1_10005(1, 1, 1), 6).uniqueId)

	setActive = var_35_0

	var_35_0(arg_35_0.churchLight, true)

	table = var_35_0

	local var_35_4 = var_35_0.insert
	local var_35_5 = arg_35_0.tweenList

	LeanTween = var_3

	local var_35_6 = var_3.delayedCall
	local var_35_7 = 6

	System = var_5

	var_35_4(var_35_5, var_35_6(var_35_7, var_5.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_35_0.churchLight, false)

		return
	end)).uniqueId)

	return
end

function var_0_1.showbgAdd(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_1 and 1 or 0
	local var_37_1 = arg_37_1 and 0 or 1

	GetOrAddComponent = var_1_10005

	local var_37_2 = arg_37_0.bgAdd

	typeof = var_1_10007
	CanvasGroup = var_1_10008

	local var_37_3 = var_1_10005(var_37_2, var_1_10007(var_1_10008))

	table = var_37_2

	local var_37_4 = var_37_2.insert
	local var_37_5 = arg_37_0.tweenList

	LeanTween = var_1_10008

	local var_37_6 = var_1_10008.alphaCanvas(var_37_3, var_37_1, arg_37_2)

	var_37_4(var_37_5, var_8.setFrom(var_37_6, var_37_0).uniqueId)

	setActive = var_37_4

	var_37_4(arg_37_0.bgAdd, true)

	return
end

function var_0_1.showBlackBG(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_1 and 1 or 0
	local var_38_1 = arg_38_1 and 0 or 1

	GetOrAddComponent = var_1_10006

	local var_38_2 = arg_38_0.blackBG

	typeof = var_1_10008
	CanvasGroup = var_1_10009

	local var_38_3 = var_1_10006(var_38_2, var_1_10008(var_1_10009))

	setActive = var_38_2

	var_38_2(arg_38_0.blackBG, true)

	table = var_38_2

	local var_38_4 = var_38_2.insert
	local var_38_5 = arg_38_0.tweenList

	LeanTween = var_9

	local var_38_6 = var_9.alphaCanvas(var_38_3, var_38_1, arg_38_2)
	local var_38_7 = var_9.setFrom(var_38_6, var_38_0)
	local var_38_8 = var_9.setOnComplete

	System = var_11

	var_38_4(var_38_5, var_38_8(var_38_7, var_11.Action(function()
		if arg_38_1 then
			setActive = var_0

			var_0(arg_38_0.blackBG, false)
		end

		if arg_38_3 then
			arg_38_3()
		end

		return
	end)).uniqueId)

	return
end

function var_0_1.showPainting(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = {}

	if arg_40_1 then
		table = var_1_10005

		var_1_10005.insert(var_40_0, function(arg_41_0)
			local var_41_0 = arg_40_0

			var_1.loadChar(var_41_0, arg_40_0.targetActorTF, "duihua", arg_41_0)

			return
		end)
	end

	seriesAsync = var_1_10005

	var_1_10005(var_40_0, function()
		local var_42_0 = arg_40_1 and 0 or 1
		local var_42_1 = arg_40_1 and 1 or 0

		GetOrAddComponent = var_2_10002

		local var_42_2 = arg_40_0.targetActorTF

		typeof = var_2_10004
		CanvasGroup = var_2_10005

		local var_42_3 = var_2_10002(var_42_2, var_2_10004(var_2_10005))

		table = var_42_2

		local var_42_4 = var_42_2.insert
		local var_42_5 = arg_40_0.tweenList

		LeanTween = var_2_10005

		local var_42_6 = var_2_10005.alphaCanvas(var_42_3, var_42_1, arg_40_2)
		local var_42_7 = var_5.setFrom(var_42_6, var_42_0)
		local var_42_8 = var_5.setOnComplete

		System = var_7

		var_42_4(var_42_5, var_42_8(var_42_7, var_7.Action(function()
			if arg_40_3 then
				arg_40_3()
			end

			return
		end)).uniqueId)

		return
	end)

	return
end

var_0_1.Live2DProposeDelayTime = 2

function var_0_1.showLive2D(arg_44_0, arg_44_1)
	setActive = var_1_10002

	local var_44_0 = arg_44_0.targetActorTF

	var_1_10002(var_3.Find(var_44_0, "fitter"), false)

	setActive = var_1_10002

	local var_44_1 = arg_44_0.targetActorTF

	var_1_10002(var_3.Find(var_44_1, "live2d"), true)

	GetOrAddComponent = var_1_10002

	local var_44_2 = arg_44_0.targetActorTF

	typeof = var_4
	CanvasGroup = var_5

	local var_44_3 = var_1_10002(var_44_2, var_4(var_5))

	table = var_44_2

	local var_44_4 = var_44_2.insert
	local var_44_5 = arg_44_0.tweenList

	LeanTween = var_5

	local var_44_6 = var_5.alphaCanvas(var_44_3, 1, var_0_1.Live2DProposeDelayTime)
	local var_44_7 = var_5.setFrom(var_44_6, 0)
	local var_44_8 = var_5.setOnComplete

	System = var_7

	var_44_4(var_44_5, var_44_8(var_44_7, var_7.Action(function()
		local var_45_0 = arg_44_0

		var_0.changeParamaterValue(var_45_0, "Paramring", 1)

		local var_45_1 = arg_44_0.l2dChar
		local var_45_2 = var_0.SetAction

		pg = var_2

		var_45_2(var_45_1, var_2.AssistantInfo.action2Id[arg_44_1])

		return
	end)).uniqueId)

	return
end

function var_0_1.changeParamaterValue(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_1 then
		string = var_1_10003

		if var_1_10003.len(arg_46_1) == 0 then
			return
		end

		local var_46_0 = arg_46_0.l2dChar

		if not var_3.GetCubismParameter(var_46_0, arg_46_1) then
			return
		end

		local var_46_1 = arg_46_0.l2dChar
		local var_46_2 = var_4.AddParameterValue
		local var_46_3 = var_3
		local var_46_4 = arg_46_2

		CubismParameterBlendMode = var_1_10008

		var_46_2(var_46_1, var_46_3, var_46_4, var_1_10008.Override)

		return
	end
end

function var_0_1.hideWindow(arg_47_0)
	GetOrAddComponent = var_1_10001

	local var_47_0 = arg_47_0.window

	typeof = var_1_10003
	CanvasGroup = var_1_10004

	local var_47_1 = var_1_10001(var_47_0, var_1_10003(var_1_10004))

	var_47_1.interactable = false
	table = var_2

	local var_47_2 = var_2.insert
	local var_47_3 = arg_47_0.tweenList

	LeanTween = var_1_10004

	local var_47_4 = var_1_10004.alphaCanvas(var_47_1, 0, 0.2)
	local var_47_5 = var_4.setFrom(var_47_4, 1)
	local var_47_6 = var_4.setOnComplete

	System = var_6

	var_47_2(var_47_3, var_47_6(var_47_5, var_6.Action(function()
		var_47_1.interactable = true

		return
	end)).uniqueId)

	return
end

function var_0_1.stampWindow(arg_49_0)
	arg_49_0.proposeEndFlag = true

	arg_49_0:loadChar(nil, nil, function()
		return
	end)

	setActive = var_1

	var_1(arg_49_0.window, true)

	setActive = var_1

	var_1(arg_49_0.button, false)

	setActive = var_1

	var_1(arg_49_0.giftButton, false)

	setActive = var_1

	local var_49_0 = arg_49_0.targetActorTF

	var_1(var_2.Find(var_49_0, "live2d"), false)

	local var_49_1

	if arg_49_0.intimacyDescPic then
		setActive = var_2

		var_2(arg_49_0.intimacyDescPic, true)

		GetOrAddComponent = var_2

		local var_49_2 = arg_49_0.intimacyDescPic

		typeof = var_4
		CanvasGroup = var_5
		var_49_1 = var_2(var_49_2, var_4(var_5))
	end

	local var_49_4

	if arg_49_0.intimacyDesc then
		setActive = var_49_4

		var_49_4(arg_49_0.intimacyDesc, not arg_49_0.intimacyDescPic)

		local var_49_3 = arg_49_0

		var_49_4 = arg_49_0.getProposeText(var_49_3)
		setText = var_49_3

		var_49_3(arg_49_0.intimacyDesc, var_49_4)

		GetOrAddComponent = var_49_3

		local var_49_5 = arg_49_0.intimacyDesc

		typeof = var_5
		CanvasGroup = var_1_10006
		var_49_1 = var_49_3(var_49_5, var_5(var_1_10006))
	end

	setText = var_49_4

	var_49_4(arg_49_0.intimacyBuffDesc, "")

	setActive = var_49_4

	var_49_4(arg_49_0.doneTF, false)

	var_49_1.alpha = 0
	GetOrAddComponent = var_2

	local var_49_6 = arg_49_0.window

	typeof = var_4
	CanvasGroup = var_5

	local var_49_7 = var_2(var_49_6, var_4(var_5))

	var_49_7.interactable = false
	table = var_3

	local var_49_8 = var_3.insert
	local var_49_9 = arg_49_0.tweenList

	LeanTween = var_5

	local var_49_10 = var_5.alphaCanvas(var_49_7, 1, 0.8)

	var_49_8(var_49_9, var_5.setFrom(var_49_10, 0).uniqueId)

	table = var_49_8

	local var_49_11 = var_49_8.insert
	local var_49_12 = arg_49_0.tweenList

	LeanTween = var_5

	local var_49_13 = var_5.delayedCall
	local var_49_14 = 1.5

	System = var_7

	var_49_11(var_49_12, var_49_13(var_49_14, var_7.Action(function()
		table = var_2_10000

		local var_51_0 = var_2_10000.insert
		local var_51_1 = arg_49_0.tweenList

		LeanTween = var_2_10002

		local var_51_2 = var_2_10002.alphaCanvas(var_49_1, 1, 2)

		var_51_0(var_51_1, var_2.setFrom(var_51_2, 0).uniqueId)

		return
	end)).uniqueId)

	LeanTween = var_49_11

	local var_49_15 = var_49_11.delayedCall
	local var_49_16 = 5

	System = var_5
	arg_49_0.delayTId = var_49_15(var_49_16, var_5.Action(function()
		if not var_49_7 then
			return
		end

		local var_52_0 = var_49_7

		var_52_0.interactable = true
		setActive = var_52_0

		var_52_0(arg_49_0.doneTF, true)

		local var_52_1 = arg_49_0

		var_0.setMask(var_52_1, false)

		setActive = var_0

		local var_52_2 = arg_49_0._tf

		var_0(var_1.Find(var_52_2, "close_end"), true)

		pg = var_0

		local var_52_3 = var_0.CriMgr.GetInstance()
		local var_52_4 = var_0.PlaySoundEffect_V3

		SFX_UI_SEAL = var_2

		var_52_4(var_52_3, var_2)

		return
	end)).id

	return
end

function var_0_1.showProposePanel(arg_53_0)
	local var_53_0 = {}

	ShipGroup = var_1_10002
	arg_53_0.proposeSkin = var_1_10002.getProposeSkin(arg_53_0.shipGroupID)

	if arg_53_0.proposeSkin and arg_53_0.actorPainting then
		tf = var_2

		local var_53_1 = var_2(arg_53_0.actorPainting)
		local var_53_2

		if var_2.Find(var_53_1, "temp_mask") then
			Destroy = var_3
			var_53_2 = var_2

			var_3(var_2.Find(var_53_2, "temp_mask"))
		end

		local var_53_3 = var_2
		local var_53_4 = var_2.GetComponent

		typeof = var_53_2
		Image = var_1_10006

		local var_53_5 = var_53_4(var_53_3, var_53_2(var_1_10006))

		var_53_5.material = nil
		PoolMgr = var_53_5

		local var_53_6 = var_53_5.GetInstance()

		var_3.ReturnPainting(var_53_6, arg_53_0.paintingName, arg_53_0.actorPainting)

		arg_53_0.actorPainting = nil
	end

	if not arg_53_0.proposePanel then
		table = var_2

		var_2.insert(var_53_0, function(arg_54_0)
			local var_54_0 = "ProposeRingUI"

			PoolMgr = var_2_10002

			local var_54_1 = var_2_10002.GetInstance()

			var_2.GetUI(var_54_1, var_54_0, true, function(arg_55_0)
				if arg_53_0.exited then
					PoolMgr = var_1
					var_3_10002 = var_1.GetInstance()

					var_1.ReturnUI(var_3_10002, var_54_0, arg_55_0)

					return
				end

				local var_55_0 = arg_53_0

				tf = var_3_10002
				var_55_0.proposePanel = var_3_10002(arg_55_0)
				setParent = var_55_0
				tf = var_2

				local var_55_1 = var_2(arg_55_0)
				local var_55_2 = arg_53_0._tf

				var_55_0(var_55_1, var_3.Find(var_55_2, "contain"))

				eachChild = var_55_0

				local var_55_3 = arg_53_0.proposePanel

				var_55_0(var_2.Find(var_55_3, "ringBox"), function(arg_56_0)
					setActive = var_4_10001

					var_4_10001(arg_56_0, arg_56_0.name == arg_53_0.proposeType)

					if arg_56_0.name == arg_53_0.proposeType then
						arg_53_0.ringBoxTF = arg_56_0
					end

					return
				end)

				local var_55_4 = arg_53_0

				GetOrAddComponent = var_2

				local var_55_5 = arg_53_0.ringBoxTF

				typeof = var_4
				CanvasGroup = var_5
				var_55_4.ringBoxCG = var_2(var_55_5, var_4(var_5))

				local var_55_6 = arg_53_0
				local var_55_7 = arg_53_0.ringBoxTF

				var_55_6.ringBoxFull = var_2.Find(var_55_7, "full")

				local var_55_8 = arg_53_0
				local var_55_9 = arg_53_0.proposePanel

				var_55_8.churchBefore = var_2.Find(var_55_9, "before")

				local var_55_10 = arg_53_0
				local var_55_11 = arg_53_0.churchBefore

				var_55_10.churchLight = var_2.Find(var_55_11, "light")
				setParent = var_55_10

				var_55_10(arg_53_0.churchLight, arg_53_0._tf)

				local var_55_12 = arg_53_0.churchLight

				var_1.SetSiblingIndex(var_55_12, 2)

				local var_55_13 = arg_53_0
				local var_55_14 = arg_53_0.churchBefore

				var_55_13.blackBG = var_2.Find(var_55_14, "blackbg")

				local var_55_15 = arg_53_0
				local var_55_16 = arg_53_0.churchBefore

				var_55_15.doorLightBG = var_2.Find(var_55_16, "door_light")

				local var_55_17 = arg_53_0
				local var_55_18 = arg_53_0.churchBefore

				var_55_17.door = var_2.Find(var_55_18, "door")

				local var_55_19 = arg_53_0

				GetOrAddComponent = var_2
				var_55_19.doorAni = var_2(arg_53_0.door, "SpineAnimUI")
				setParent = var_55_19

				local var_55_20 = arg_53_0.churchBefore
				local var_55_21 = arg_53_0._tf

				var_55_19(var_55_20, var_3.Find(var_55_21, "contain"))

				local var_55_22 = arg_53_0
				local var_55_23 = arg_53_0.proposePanel

				var_55_22.ringTipTF = var_2.Find(var_55_23, "tip")

				local var_55_24 = arg_53_0

				GetOrAddComponent = var_2

				local var_55_25 = arg_53_0.ringTipTF

				typeof = var_4
				CanvasGroup = var_5
				var_55_24.ringTipCG = var_2(var_55_25, var_4(var_5))
				setText = var_55_24

				local var_55_26 = arg_53_0.ringTipTF
				local var_55_27 = var_2.Find(var_55_26, "Text")

				i18n = var_55_26

				var_55_24(var_55_27, var_55_26(arg_53_0.proposeType == "imas" and "word_propose_tiara_tip" or "word_propose_ring_tip"))

				setActive = var_55_24

				local var_55_28 = arg_53_0.ringTipTF

				var_55_24(var_2.Find(var_55_28, "finger"), false)

				LoadImageSpriteAsync = var_55_24

				var_55_24(arg_53_0.bgName, arg_53_0.storybg)

				local var_55_29 = arg_53_0.storybg

				Vector3 = var_2
				var_55_29.localScale = var_2(1.2, 1.2, 1.2)

				local var_55_31

				if not arg_53_0.weddingReview or not arg_53_0.reviewSkinID then
					local var_55_30 = arg_53_0.shipVO

					var_55_31 = var_1.getSkinId(var_55_30)
				end

				local var_55_32 = arg_53_0

				pg = var_3
				var_55_32.handId = var_3.ship_skin_template[var_55_31].hand_id
				pg = var_55_32

				local var_55_33 = var_55_32.TimeMgr.GetInstance()
				local var_55_34 = var_2.CurrentSTimeDesc(var_55_33, "%Y%m%d", true)

				SPECIAL_PROPOSE = var_55_33

				if var_55_33 then
					SPECIAL_PROPOSE = var_55_33

					if var_55_33[1] == var_55_34 then
						ipairs = var_3
						SPECIAL_PROPOSE = var_4

						for iter_55_0, iter_55_1 in var_3(var_4[2]) do
							if iter_55_1[1] == var_55_31 then
								arg_53_0.handId = iter_55_1[2]
							end
						end
					end
				end

				local var_55_35 = ({
					default = "",
					meta = "Meta_",
					imas = "Imas_"
				})[arg_53_0.proposeType] .. "ProposeHand_" .. arg_53_0.handId
				local var_55_36 = arg_53_0

				var_55_36.handName = var_55_35
				PoolMgr = var_55_36

				local var_55_37 = var_55_36.GetInstance()

				var_5.GetUI(var_55_37, var_55_35, true, function(arg_57_0)
					if arg_53_0.exited then
						PoolMgr = var_1
						var_4_10002 = var_1.GetInstance()

						var_1.ReturnUI(var_4_10002, var_55_35, arg_57_0)

						return
					end

					local var_57_0 = arg_53_0

					tf = var_4_10002
					var_57_0.transHand = var_4_10002(arg_57_0)
					setActive = var_57_0

					var_57_0(arg_53_0.transHand, false)

					setParent = var_57_0

					var_57_0(arg_53_0.transHand, arg_53_0.proposePanel)

					local var_57_1 = arg_53_0.transHand

					var_1.SetAsFirstSibling(var_57_1)

					local var_57_2 = arg_53_0
					local var_57_3 = arg_53_0.transHand

					var_57_2.handTF = var_2.Find(var_57_3, "hand")

					local var_57_4 = arg_53_0
					local var_57_5 = arg_53_0.transHand

					var_57_4.ringTF = var_2.Find(var_57_5, "ring")

					local var_57_6 = arg_53_0

					GetOrAddComponent = var_2

					local var_57_7 = arg_53_0.ringTF

					typeof = var_4
					CanvasGroup = var_4_10005
					var_57_6.ringCG = var_2(var_57_7, var_4(var_4_10005))

					local var_57_8 = arg_53_0
					local var_57_9 = arg_53_0.ringTF
					local var_57_10 = var_2.GetComponent

					typeof = var_4
					Animator = var_4_10005
					var_57_8.ringAnim = var_57_10(var_57_9, var_4(var_4_10005))
					arg_53_0.ringAnim.enabled = false

					local var_57_11 = arg_53_0
					local var_57_12 = arg_53_0.ringTF

					var_57_11.ringLight = var_2.Find(var_57_12, "ring_light")

					local var_57_13 = arg_53_0

					GetOrAddComponent = var_2

					local var_57_14 = arg_53_0.ringLight

					typeof = var_4
					CanvasGroup = var_4_10005
					var_57_13.ringLightCG = var_2(var_57_14, var_4(var_4_10005))

					arg_54_0()

					return
				end)

				return
			end)

			return
		end)
	end

	table = var_2

	var_2.insert(var_53_0, function(arg_58_0)
		table = var_2_10001

		local var_58_0 = var_2_10001.insert
		local var_58_1 = arg_53_0.tweenList

		LeanTween = var_2_10003

		local var_58_2 = var_2_10003.scale
		local var_58_3 = arg_53_0.door

		Vector3 = var_2_10005

		var_58_0(var_58_1, var_58_2(var_58_3, var_2_10005(2.1, 2.1, 2.1), 4).uniqueId)

		local var_58_4 = arg_53_0.doorAni

		var_1.SetActionCallBack(var_58_4, function(arg_59_0)
			if arg_59_0 == "FINISH" then
				local var_59_0 = arg_53_0.doorAni

				var_1.SetActionCallBack(var_59_0, nil)

				setActive = var_1

				var_1(arg_53_0.door, false)

				local var_59_1 = arg_53_0

				var_1.showBlackBG(var_59_1, true, 0.1)

				setActive = var_1

				var_1(arg_53_0.doorLightBG, false)
				arg_58_0()
			end

			return
		end)

		table = var_1

		local var_58_5 = var_1.insert
		local var_58_6 = arg_53_0.tweenList

		LeanTween = var_3

		local var_58_7 = var_3.delayedCall
		local var_58_8 = 2

		System = var_5

		var_58_5(var_58_6, var_58_7(var_58_8, var_5.Action(function()
			local var_60_0 = arg_53_0

			var_0.showbgAdd(var_60_0, false, 2)

			return
		end)).uniqueId)

		table = var_58_5

		local var_58_9 = var_58_5.insert
		local var_58_10 = arg_53_0.tweenList

		LeanTween = var_3

		local var_58_11 = var_3.alpha

		rtf = var_58_8

		local var_58_12 = var_58_11(var_58_8(arg_53_0.doorLightBG), 1, 2)

		var_58_9(var_58_10, var_3.setFrom(var_58_12, 0).uniqueId)

		local var_58_13 = arg_53_0

		var_1.showBlackBG(var_58_13, false, 0.1)

		local var_58_14 = arg_53_0.doorAni

		var_1.SetAction(var_58_14, "OPEN", 0)

		pg = var_1

		local var_58_15 = var_1.CriMgr.GetInstance()
		local var_58_16 = var_1.PlaySoundEffect_V3

		SFX_UI_DOOR = var_3

		var_58_16(var_58_15, var_3)

		return
	end)

	table = var_2

	var_2.insert(var_53_0, function(arg_61_0)
		local var_61_0 = arg_53_0.handTF
		local var_61_1 = var_1.GetComponent

		typeof = var_2_10003
		Image = var_2_10004

		local var_61_2 = var_61_1(var_61_0, var_2_10003(var_2_10004))

		Color = var_61_0
		var_61_2.color = var_61_0.New(1, 1, 1, 0)

		local var_61_3 = arg_53_0

		var_1.bgAddAnimation(var_61_3, 2)

		table = var_1

		local var_61_4 = var_1.insert
		local var_61_5 = arg_53_0.tweenList

		LeanTween = var_3

		local var_61_6 = var_3.delayedCall
		local var_61_7 = 2

		System = var_5

		var_61_4(var_61_5, var_61_6(var_61_7, var_5.Action(function()
			local var_62_0 = arg_53_0

			var_0.showPainting(var_62_0, true, 1.5, function()
				table = var_4_10000

				local var_63_0 = var_4_10000.insert
				local var_63_1 = arg_53_0.tweenList

				LeanTween = var_4_10002

				local var_63_2 = var_4_10002.delayedCall
				local var_63_3 = 1.5

				System = var_4_10004

				var_63_0(var_63_1, var_63_2(var_63_3, var_4_10004.Action(arg_61_0)).uniqueId)

				return
			end)

			return
		end)).uniqueId)

		return
	end)

	table = var_2

	var_2.insert(var_53_0, function(arg_64_0)
		local var_64_0 = arg_53_0

		var_1.showBlackBG(var_64_0, false, 1.2, function()
			local var_65_0 = arg_53_0

			var_0.showBlackBG(var_65_0, true, 1.2)

			return
		end)

		local var_64_1 = arg_53_0

		var_1.showPainting(var_64_1, false, 1, arg_64_0)

		return
	end)

	table = var_2

	var_2.insert(var_53_0, function(arg_66_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_53_0.handTF, {
			y = arg_53_0.handTF.rect.height
		})

		setAnchoredPosition = var_2_10001

		var_2_10001(arg_53_0.ringTF, {
			y = 0
		})

		setActive = var_2_10001

		var_2_10001(arg_53_0.proposePanel, true)

		setActive = var_2_10001

		var_2_10001(arg_53_0.transHand, true)

		arg_53_0.ringBoxCG.alpha = 0
		arg_53_0.ringCG.alpha = 0

		arg_66_0()

		return
	end)

	if arg_53_0.proposeType ~= "imas" then
		table = var_2

		var_2.insert(var_53_0, function(arg_67_0)
			table = var_2_10001

			local var_67_0 = var_2_10001.insert
			local var_67_1 = arg_53_0.tweenList

			LeanTween = var_2_10003

			local var_67_2 = var_2_10003.alpha

			rtf = var_2_10004

			var_67_0(var_67_1, var_67_2(var_2_10004(arg_53_0.handTF), 1, 1.2).uniqueId)

			table = var_67_0

			local var_67_3 = var_67_0.insert
			local var_67_4 = arg_53_0.tweenList

			LeanTween = var_3

			local var_67_5 = var_3.moveY

			rtf = var_4

			local var_67_6 = var_67_5(var_4(arg_53_0.handTF), 0, 2)
			local var_67_7 = var_3.setOnComplete

			System = var_5

			var_67_3(var_67_4, var_67_7(var_67_6, var_5.Action(function()
				table = var_3_10000

				local var_68_0 = var_3_10000.insert
				local var_68_1 = arg_53_0.tweenList

				LeanTween = var_3_10002

				local var_68_2 = var_3_10002.alphaCanvas(arg_53_0.ringBoxCG, 1, 1.5)
				local var_68_3 = var_2.setFrom(var_68_2, 0)
				local var_68_4 = var_2.setOnComplete

				System = var_4

				var_68_0(var_68_1, var_68_4(var_68_3, var_4.Action(arg_67_0)).uniqueId)

				return
			end)).uniqueId)

			return
		end)

		table = var_2

		var_2.insert(var_53_0, function(arg_69_0)
			table = var_2_10001

			local var_69_0 = var_2_10001.insert
			local var_69_1 = arg_53_0.tweenList

			LeanTween = var_2_10003

			local var_69_2 = var_2_10003.alpha

			rtf = var_2_10004

			local var_69_3 = var_69_2(var_2_10004(arg_53_0.ringBoxFull), 0, 0.6)
			local var_69_4 = var_3.setOnComplete

			System = var_5

			var_69_0(var_69_1, var_69_4(var_69_3, var_5.Action(arg_69_0)).uniqueId)

			table = var_69_0

			local var_69_5 = var_69_0.insert
			local var_69_6 = arg_53_0.tweenList

			LeanTween = var_3

			var_69_5(var_69_6, var_3.alphaCanvas(arg_53_0.ringCG, 1, 0.6).uniqueId)

			return
		end)
	end

	table = var_2

	var_2.insert(var_53_0, function(arg_70_0)
		arg_53_0.ringCG.alpha = 1

		local var_70_0 = arg_53_0

		var_1.setMask(var_70_0, false)

		table = var_1

		local var_70_1 = var_1.insert
		local var_70_2 = arg_53_0.tweenList

		LeanTween = var_3

		local var_70_3 = var_3.delayedCall
		local var_70_4 = 0.1

		System = var_2_10005

		var_70_1(var_70_2, var_70_3(var_70_4, var_2_10005.Action(arg_70_0)).uniqueId)

		return
	end)

	table = var_2

	var_2.insert(var_53_0, function(arg_71_0)
		arg_53_0.ringAnim.enabled = true

		local var_71_0 = arg_53_0.ringAnim

		var_1.Play(var_71_0, "movein")

		local var_71_1 = arg_53_0.proposeType == "imas" and 1 or 0.5

		table = var_71_0

		local var_71_2 = var_71_0.insert
		local var_71_3 = arg_53_0.tweenList

		LeanTween = var_2_10004

		local var_71_4 = var_2_10004.delayedCall
		local var_71_5 = var_71_1

		System = var_2_10006

		var_71_2(var_71_3, var_71_4(var_71_5, var_2_10006.Action(arg_71_0)).uniqueId)

		return
	end)

	seriesAsync = var_2

	var_2(var_53_0, function()
		local var_72_0 = arg_53_0.ringAnim

		var_0.Play(var_72_0, "blink")

		table = var_0

		local var_72_1 = var_0.insert
		local var_72_2 = arg_53_0.tweenList

		LeanTween = var_2

		local var_72_3 = var_2.alphaCanvas(arg_53_0.ringTipCG, 1, 1.5)
		local var_72_4 = var_2.setFrom(var_72_3, 0)
		local var_72_5 = var_2.setOnComplete

		System = var_4

		var_72_1(var_72_2, var_72_5(var_72_4, var_4.Action(function()
			setActive = var_3_10000

			local var_73_0 = arg_53_0.ringTipTF

			var_3_10000(var_1.Find(var_73_0, "finger"), true)

			local var_73_1 = arg_53_0

			var_0.enableRingDrag(var_73_1, true)

			return
		end)).uniqueId)

		return
	end)

	return
end

function var_0_1.ringOn(arg_74_0)
	if arg_74_0.isRingOn then
		return
	end

	setActive = var_1

	var_1(arg_74_0.ringTipTF, false)

	arg_74_0.isRingOn = true

	local var_74_0 = arg_74_0.ringTF
	local var_74_1 = var_1.GetComponent(var_74_0, "DftAniEvent")

	var_1.SetEndEvent(var_74_1, function(arg_75_0)
		arg_74_0.ringAnim.enabled = false
		arg_74_0.isRingOn = false

		if not arg_74_0.weddingReview then
			local var_75_0 = arg_74_0
			local var_75_1 = var_1.emit

			ProposeMediator = var_2_10003

			var_75_1(var_75_0, var_2_10003.ON_PROPOSE, arg_74_0.shipVO.id)
		else
			local var_75_2 = arg_74_0

			var_1.RingFadeout(var_75_2)
		end

		return
	end)

	arg_74_0.ringAnim.enabled = true

	local var_74_2 = arg_74_0.ringAnim

	var_2.Play(var_74_2, "wear")

	if arg_74_0.handId == "101" then
		GetOrAddComponent = var_2

		local var_74_3 = arg_74_0.handTF

		typeof = var_4
		CanvasGroup = var_1_10005

		local var_74_4 = var_2(var_74_3, var_4(var_1_10005))

		table = var_74_3

		local var_74_5 = var_74_3.insert
		local var_74_6 = arg_74_0.tweenList

		LeanTween = var_1_10005

		var_74_5(var_74_6, var_1_10005.alphaCanvas(var_74_4, 0, 2).uniqueId)
	end

	return
end

function var_0_1.enableRingDrag(arg_76_0, arg_76_1)
	if not arg_76_0.press then
		arg_76_0:addRingDragListenter()
	end

	arg_76_0.press.enabled = arg_76_1

	return
end

function var_0_1.addRingDragListenter(arg_77_0)
	GetOrAddComponent = var_1_10001
	arg_77_0.press = var_1_10001(arg_77_0.proposePanel, "EventTriggerListener")

	local var_77_0
	local var_77_1 = arg_77_0.press

	var_2.AddBeginDragFunc(var_77_1, function()
		return
	end)

	local var_77_2 = arg_77_0.press

	var_2.AddDragFunc(var_77_2, function(arg_79_0, arg_79_1)
		local var_79_0 = arg_79_1.position

		if not var_77_0 then
			var_77_0 = var_79_0
		end

		if var_79_0.y - var_77_0.y > 100 then
			local var_79_1 = arg_77_0

			var_3.setMask(var_79_1, true)

			local var_79_2 = arg_77_0

			var_3.ringOn(var_79_2)

			local var_79_3 = arg_77_0

			var_3.enableRingDrag(var_79_3, false)
		end

		return
	end)

	local var_77_3 = arg_77_0.press

	var_2.AddDragEndFunc(var_77_3, function(arg_80_0, arg_80_1)
		return
	end)

	return
end

function var_0_1.RingFadeout(arg_81_0)
	local var_81_0 = {}

	if arg_81_0.proposeType == "imas" then
		table = var_2

		var_2.insert(var_81_0, function(arg_82_0)
			local var_82_0 = arg_81_0.ringLight
			local var_82_1 = var_1.GetChild(var_82_0, 0)

			setActive = var_82_0

			var_82_0(var_82_1, true)

			table = var_82_0

			local var_82_2 = var_82_0.insert
			local var_82_3 = arg_81_0.tweenList

			LeanTween = var_4

			local var_82_4 = var_4.delayedCall
			local var_82_5 = 3.5

			System = var_2_10006

			var_82_2(var_82_3, var_82_4(var_82_5, var_2_10006.Action(function()
				setActive = var_3_10000

				var_3_10000(var_82_1, false)
				arg_82_0()

				return
			end)).uniqueId)

			return
		end)
	else
		table = var_2

		var_2.insert(var_81_0, function(arg_84_0)
			table = var_2_10001

			local var_84_0 = var_2_10001.insert
			local var_84_1 = arg_81_0.tweenList

			LeanTween = var_2_10003

			local var_84_2 = var_2_10003.alphaCanvas(arg_81_0.ringLightCG, 0.7, 0.5)

			var_84_0(var_84_1, var_3.setFrom(var_84_2, 0).uniqueId)

			table = var_84_0

			local var_84_3 = var_84_0.insert
			local var_84_4 = arg_81_0.tweenList

			LeanTween = var_3

			local var_84_5 = var_3.scale
			local var_84_6 = arg_81_0.ringLight

			Vector3 = var_5

			var_84_3(var_84_4, var_84_5(var_84_6, var_5(8, 8, 8), 1).uniqueId)

			table = var_84_3

			local var_84_7 = var_84_3.insert
			local var_84_8 = arg_81_0.tweenList

			LeanTween = var_3

			local var_84_9 = var_3.rotate(arg_81_0.ringLight, 90, 3)
			local var_84_10 = var_3.setOnComplete

			System = var_5

			var_84_7(var_84_8, var_84_10(var_84_9, var_5.Action(arg_84_0)).uniqueId)

			return
		end)

		table = var_2

		var_2.insert(var_81_0, function(arg_85_0)
			table = var_2_10001

			local var_85_0 = var_2_10001.insert
			local var_85_1 = arg_81_0.tweenList

			LeanTween = var_2_10003

			local var_85_2 = var_2_10003.delayedCall
			local var_85_3 = 0.5

			System = var_2_10005

			var_85_0(var_85_1, var_85_2(var_85_3, var_2_10005.Action(arg_85_0)).uniqueId)

			return
		end)
	end

	seriesAsync = var_2

	var_2(var_81_0, function()
		local var_86_0 = arg_81_0

		var_0.displayShipWord(var_86_0, "propose")

		return
	end)

	table = var_2

	local var_81_1 = var_2.insert
	local var_81_2 = arg_81_0.tweenList

	LeanTween = var_4

	local var_81_3 = var_4.delayedCall
	local var_81_4 = 1.2

	System = var_1_10006

	var_81_1(var_81_2, var_81_3(var_81_4, var_1_10006.Action(function()
		local var_87_0 = arg_81_0

		var_0.showbgAdd(var_87_0, false, 1.8)

		return
	end)).uniqueId)

	table = var_81_1

	local var_81_5 = var_81_1.insert
	local var_81_6 = arg_81_0.tweenList

	LeanTween = var_4

	local var_81_7 = var_4.delayedCall
	local var_81_8 = 3.2

	System = var_6

	var_81_5(var_81_6, var_81_7(var_81_8, var_6.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_81_0.proposePanel, false)

		local var_88_0 = arg_81_0

		var_0.showbgAdd(var_88_0, true, 2)

		return
	end)).uniqueId)

	return
end

function var_0_1.displayShipWord(arg_89_0, arg_89_1)
	ShipGroup = var_1_10002

	local var_89_0 = var_1_10002.getDefaultSkin(arg_89_0.shipGroupID)

	ShipWordHelper = var_3

	local var_89_1, var_89_2, var_89_3 = var_3.GetWordAndCV(var_89_0.id, arg_89_1)
	local var_89_4

	if arg_89_0.reviewSkinID then
		var_89_4 = arg_89_0.reviewSkinID
	elseif arg_89_0.proposeSkin then
		var_89_4 = arg_89_0.proposeSkin.id
	else
		local var_89_5 = arg_89_0.shipVO

		var_89_4 = var_7.getSkinId(var_89_5)
	end

	ShipWordHelper = var_7

	local var_89_6 = var_7.GetL2dCvCalibrate(var_89_4, arg_89_1)

	arg_89_0:showStoryUI(var_89_3)

	if var_89_2 then
		local function var_89_7()
			if arg_89_0._currentVoice then
				local var_90_0 = arg_89_0._currentVoice

				var_0.PlaybackStop(var_90_0)
			end

			pg = var_0

			local var_90_1 = var_0.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_90_1, var_89_2, function(arg_91_0)
				arg_89_0._currentVoice = arg_91_0

				return
			end)

			return
		end

		local var_89_8 = var_0_1.Live2DProposeDelayTime

		if not arg_89_0:useL2dOrPainting() then
			var_89_8 = 0
		end

		table = var_10

		local var_89_9 = var_10.insert
		local var_89_10 = arg_89_0.tweenList

		LeanTween = var_1_10012

		local var_89_11 = var_1_10012.delayedCall
		local var_89_12 = var_89_8

		System = var_1_10014

		var_89_9(var_89_10, var_89_11(var_89_12, var_1_10014.Action(function()
			if arg_89_0.l2dChar and var_89_6 and var_89_6 ~= 0 then
				local var_92_0 = arg_89_0

				LeanTween = var_2_10001

				local var_92_1 = var_2_10001.delayedCall
				local var_92_2 = var_89_6

				System = var_2_10003
				var_92_0._delayVoiceTweenID = var_92_1(var_92_2, var_2_10003.Action(function()
					var_89_7()

					arg_89_0._delayVoiceTweenID = nil

					return
				end)).uniqueId
			else
				var_89_7()
			end

			return
		end)).uniqueId)
	end

	return
end

function var_0_1.useL2dOrPainting(arg_94_0)
	checkABExist = var_1_10001

	local var_94_0 = "live2d/"

	string = var_1_10003

	return var_1_10001(var_94_0 .. var_1_10003.lower(arg_94_0.paintingName))
end

function var_0_1.showStoryUI(arg_95_0, arg_95_1)
	local var_95_0 = {}

	if not arg_95_0.storyTF then
		table = var_3

		var_3.insert(var_95_0, function(arg_96_0)
			local var_96_0 = "ProposeStoryUI"

			PoolMgr = var_2_10002

			local var_96_1 = var_2_10002.GetInstance()

			var_2.GetUI(var_96_1, var_96_0, true, function(arg_97_0)
				if arg_95_0.exited then
					PoolMgr = var_1
					var_3_10002 = var_1.GetInstance()

					var_1.ReturnUI(var_3_10002, var_96_0, arg_97_0)

					return
				end

				local var_97_0 = arg_95_0

				tf = var_3_10002
				var_97_0.storyTF = var_3_10002(arg_97_0)
				setParent = var_97_0
				tf = var_2

				local var_97_1 = var_2(arg_97_0)
				local var_97_2 = arg_95_0._tf

				var_97_0(var_97_1, var_3.Find(var_97_2, "contain"))

				local var_97_3 = arg_95_0

				GetOrAddComponent = var_97_1

				local var_97_4 = arg_95_0.storyTF

				typeof = var_97_2
				CanvasGroup = var_5
				var_97_3.storyCG = var_97_1(var_97_4, var_97_2(var_5))

				local var_97_5 = arg_95_0
				local var_97_6 = arg_95_0.storyTF

				var_97_5.storyContent = var_2.Find(var_97_6, "dialogue/content")

				local var_97_7 = arg_95_0
				local var_97_8 = arg_95_0.storyContent
				local var_97_9 = var_2.GetComponent

				typeof = var_4
				Typewriter = var_5
				var_97_7.typeWriter = var_97_9(var_97_8, var_4(var_5))

				local var_97_10 = arg_95_0
				local var_97_11 = arg_95_0.storyTF

				var_97_10.targetNameTF = var_2.Find(var_97_11, "dialogue/content/name")

				local var_97_12 = arg_95_0
				local var_97_13 = arg_95_0.storyTF

				var_97_12._renamePanel = var_2.Find(var_97_13, "changeName_panel")
				setText = var_97_12
				findTF = var_2

				local var_97_14 = var_2(arg_95_0._renamePanel, "frame/name_field/Placeholder")

				i18n = var_3

				var_97_12(var_97_14, var_3("rename_input"))

				setActive = var_97_12

				var_97_12(arg_95_0._renamePanel, false)

				onButton = var_97_12

				var_97_12(arg_95_0, arg_95_0.storyTF, function()
					if arg_95_0.inTypeWritter then
						local var_98_0 = arg_95_0.typeWriter

						var_0.setSpeed(var_98_0, arg_95_0.typeWritterSpeedUp)

						return
					end

					if not arg_95_0.initStory then
						return
					end

					table = var_0

					local var_98_1 = var_0.insert
					local var_98_2 = arg_95_0.tweenList

					LeanTween = var_4_10002

					local var_98_3 = var_4_10002.alphaCanvas(arg_95_0.storyCG, 0, 1)
					local var_98_4 = var_2.setFrom(var_98_3, 1)
					local var_98_5 = var_2.setOnComplete

					System = var_4

					var_98_1(var_98_2, var_98_5(var_98_4, var_4.Action(function()
						setActive = var_5_10000

						var_5_10000(arg_95_0.storyTF, false)

						return
					end)).uniqueId)

					if arg_95_0._currentVoice then
						local var_98_6 = arg_95_0._currentVoice

						var_0.PlaybackStop(var_98_6)
					end

					arg_95_0._currentVoice = nil

					local var_98_7 = arg_95_0

					var_0.setMask(var_98_7, true)

					table = var_0

					local var_98_8 = var_0.insert
					local var_98_9 = arg_95_0.tweenList

					LeanTween = var_2

					local var_98_10 = var_2.delayedCall
					local var_98_11 = 0.5

					System = var_4

					var_98_8(var_98_9, var_98_10(var_98_11, var_4.Action(function()
						if arg_95_0.weddingReview then
							local var_100_0 = arg_95_0

							var_0.closeView(var_100_0)
						else
							local var_100_1 = arg_95_0

							var_0.initChangeNamePanel(var_100_1)

							local var_100_2 = arg_95_0

							var_0.stampWindow(var_100_2)
						end

						return
					end)).uniqueId)

					return
				end)
				arg_96_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_95_0, function()
		local var_101_0 = arg_95_0

		if var_0.useL2dOrPainting(var_101_0) then
			local var_101_1 = arg_95_0

			var_0.showLive2D(var_101_1, "wedding")
		else
			local var_101_2 = arg_95_0

			var_0.showPainting(var_101_2, true, 2)
		end

		ShipGroup = var_0

		local var_101_3 = var_0.getDefaultShipNameByGroupID(arg_95_0.shipGroupID)

		setText = var_1

		local var_101_4 = arg_95_0.targetNameTF

		var_1(var_2.Find(var_101_4, "Text"), var_101_3)

		setText = var_1

		var_1(arg_95_0.storyContent, "")

		local var_101_5 = arg_95_0.storyCG

		var_101_5.alpha = 0
		setActive = var_101_5

		var_101_5(arg_95_0.storyTF, true)

		local var_101_6 = arg_95_0

		var_101_6.initStory = false
		table = var_101_6

		local var_101_7 = var_101_6.insert
		local var_101_8 = arg_95_0.tweenList

		LeanTween = var_3

		local var_101_9 = var_3.alphaCanvas(arg_95_0.storyCG, 1, 1)
		local var_101_10 = var_3.setFrom(var_101_9, 0)
		local var_101_11 = var_3.setDelay(var_101_10, 1)
		local var_101_12 = var_3.setOnComplete

		System = var_5

		var_101_7(var_101_8, var_101_12(var_101_11, var_5.Action(function()
			findTF = var_3_10000

			local var_102_0 = var_3_10000(arg_95_0.targetActorTF, "fitter").childCount

			if 0 < var_102_0 then
				ShipExpressionHelper = var_102_0
				var_102_0 = var_102_0.SetExpression
				findTF = var_1

				local var_102_1 = var_1(arg_95_0.targetActorTF, "fitter")

				var_102_0(var_1.GetChild(var_102_1, 0), arg_95_0.paintingName, "propose")
			end

			setText = var_102_0

			var_102_0(arg_95_0.storyContent, arg_95_1)

			arg_95_0.onWords = true

			if arg_95_1 and arg_95_1 ~= "" then
				local var_102_2 = arg_95_0

				var_0.TypeWriter(var_102_2)
			end

			arg_95_0.initStory = true

			local var_102_3 = arg_95_0

			var_0.setMask(var_102_3, false)

			if not arg_95_0.weddingReview then
				local var_102_4 = arg_95_0

				var_0.showTip(var_102_4)
			end

			return
		end)).uniqueId)

		return
	end)

	return
end

function var_0_1.TypeWriter(arg_103_0)
	local var_103_0 = 0.1

	arg_103_0.inTypeWritter = true
	arg_103_0.typeWritterSpeedUp = 0.01

	local var_103_1 = arg_103_0.typeWriter

	var_2.setSpeed(var_103_1, var_103_0)

	local var_103_2 = arg_103_0.typeWriter

	var_2.Play(var_103_2)

	function arg_103_0.typeWriter.endFunc()
		arg_103_0.inTypeWritter = false
		arg_103_0.typeWritterSpeedUp = nil

		return
	end

	return
end

function var_0_1.loadChar(arg_105_0, arg_105_1, arg_105_2, arg_105_3)
	arg_105_1 = arg_105_1 or arg_105_0._paintingTF
	arg_105_2 = arg_105_2 or "wedding"

	local var_105_0 = {}

	if not arg_105_0.actorPainting then
		table = var_5

		var_5.insert(var_105_0, function(arg_106_0)
			if arg_105_0.reviewSkinID then
				local var_106_0 = arg_105_0

				pg = var_2_10002
				var_106_0.paintingName = var_2_10002.ship_skin_template[arg_105_0.reviewSkinID].painting
			elseif arg_105_0.proposeSkin then
				arg_105_0.paintingName = arg_105_0.proposeSkin.painting
			else
				local var_106_1 = arg_105_0
				local var_106_2 = arg_105_0.shipVO

				var_106_1.paintingName = var_2_10002.getPainting(var_106_2)
			end

			local var_106_3 = arg_105_0.paintingName

			checkABExist = var_2_10002

			if var_2_10002("painting/" .. var_106_3 .. "_n") then
				PlayerPrefs = var_2

				if var_2.GetInt("paint_hide_other_obj_" .. var_106_3, 0) ~= 0 then
					var_106_3 = var_106_3 .. "_n"
				end
			end

			PoolMgr = var_2

			local var_106_4 = var_2.GetInstance()

			var_2.GetPainting(var_106_4, var_106_3, true, function(arg_107_0)
				findTF = var_3_10001

				local var_107_0 = var_3_10001(arg_107_0, "Touch")

				IsNil = var_2

				if not var_2(var_107_0) then
					setActive = var_2

					var_2(var_107_0, false)
				end

				arg_105_0.actorPainting = arg_107_0

				local var_107_1 = (arg_105_0.weddingReview or arg_105_0.shipVO and arg_105_0.shipVO.propose) and "propose" or nil

				ShipExpressionHelper = var_3

				var_3.SetExpression(arg_105_0.actorPainting, arg_105_0.paintingName, var_107_1)
				arg_106_0()

				return
			end)

			checkABExist = var_2

			local var_106_5 = "live2d/"

			string = var_4

			if var_2(var_106_5 .. var_4.lower(arg_105_0.paintingName)) then
				local var_106_6 = arg_105_0

				var_2.createLive2D(var_106_6, arg_105_0.paintingName)
			end

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_105_0, function()
		IsNil = var_2_10000

		if not var_2_10000(arg_105_1) then
			findTF = var_0

			local var_108_0 = var_0(arg_105_1, "fitter")

			assert = var_1

			var_1(var_108_0, "请添加子物体fitter")

			GetOrAddComponent = var_1

			local var_108_1 = var_1(var_108_0, "PaintingScaler")

			var_108_1.FrameName = arg_105_2
			var_108_1.Tween = 1
			setParent = var_2

			var_2(arg_105_0.actorPainting, var_108_0)
		end

		if arg_105_3 then
			arg_105_3()
		end

		return
	end)

	return
end

function var_0_1.createLive2D(arg_109_0, arg_109_1)
	pg = var_1_10002

	local var_109_0 = var_1_10002.Live2DMgr.GetInstance()

	arg_109_0.live2dRequestId = var_2.GetLive2DModelAsync(var_109_0, arg_109_1, function(arg_110_0)
		local var_110_0 = arg_110_0.transform

		GetOrAddComponent = var_2_10002

		local var_110_1 = var_110_0

		typeof = var_2_10004
		DftAniEvent = var_2_10005

		var_2_10002(var_110_1, var_2_10004(var_2_10005))

		local var_110_2 = arg_109_0.targetActorTF
		local var_110_3 = var_2.Find(var_110_2, "live2d")

		HotfixHelper = var_110_2

		local var_110_4 = var_110_2.SetLayerRecursively
		local var_110_5 = arg_110_0

		LayerMask = var_2_10005

		var_110_4(var_110_5, var_2_10005.NameToLayer("UI"))
		var_110_0:SetParent(var_110_3, true)

		local var_110_6

		if arg_109_0.reviewSkinID then
			var_110_6 = arg_109_0.reviewSkinID
		elseif arg_109_0.proposeSkin then
			var_110_6 = arg_109_0.proposeSkin.id
		else
			local var_110_7 = arg_109_0.shipVO

			var_110_6 = var_4.getSkinId(var_110_7)
		end

		Live2DPainting = var_4

		local var_110_8 = var_4.SetL2dSortingLayer
		local var_110_9 = arg_110_0

		LayerWeightConst = var_6

		var_110_8(var_110_9, var_6.L2D_DEFAULT_LAYER)

		BuildVector3 = var_110_8
		pg = var_110_9

		local var_110_10 = var_110_8(var_110_9.ship_skin_template[var_110_6].live2d_offset)

		Vector3 = var_5
		var_110_0.localPosition = var_110_10 + var_5(0, 0, 100)

		local var_110_11 = 52

		pg = var_5

		if var_5.ship_skin_template[var_110_6].live2d_offset then
			pg = var_5

			if #var_5.ship_skin_template[var_110_6].live2d_offset >= 4 then
				pg = var_5
				var_110_11 = var_5.ship_skin_template[var_110_6].live2d_offset[4]
			end
		end

		Vector3 = var_5
		var_110_0.localScale = var_5(var_110_11, var_110_11, var_110_11)

		local var_110_12 = arg_109_0

		GetComponent = var_6
		var_110_12.l2dChar = var_6(arg_110_0, "Live2dChar")

		local var_110_13 = arg_109_0.l2dChar

		var_110_13.name = arg_109_1
		pg = var_110_13

		local var_110_14 = var_110_13.AssistantInfo.action2Id.idle

		function arg_109_0.l2dChar.FinishAction(arg_111_0)
			if var_110_14 ~= arg_111_0 then
				local var_111_0 = arg_109_0.l2dChar

				var_1.SetAction(var_111_0, var_110_14)
			end

			return
		end

		local var_110_15 = arg_109_0.l2dChar

		var_6.SetAction(var_110_15, var_110_14)

		pg = var_6

		local var_110_16 = var_6.ship_skin_template[var_110_6].lip_sync_gain
		local var_110_17 = var_6.lip_smoothing

		if var_110_16 and var_110_16 ~= 0 then
			local var_110_18 = var_110_3:GetChild(0)

			var_9.GetComponent(var_110_18, "CubismCriSrcMouthInput").Gain = var_110_16
		end

		if arg_109_1 == "mojiaduoer_4" then
			local var_110_19 = arg_109_0.l2dChar
			local var_110_20 = var_9.AddParameterValue
			local var_110_21 = arg_109_0.l2dChar
			local var_110_22 = var_11.GetCubismParameter(var_110_21, "ParamAngleX1")
			local var_110_23 = 3

			CubismParameterBlendMode = var_13

			var_110_20(var_110_19, var_110_22, var_110_23, var_13.Override)

			local var_110_24 = arg_109_0.l2dChar
			local var_110_25 = var_9.AddParameterValue
			local var_110_26 = arg_109_0.l2dChar
			local var_110_27 = var_11.GetCubismParameter(var_110_26, "touch_drag45")
			local var_110_28 = 7

			CubismParameterBlendMode = var_13

			var_110_25(var_110_24, var_110_27, var_110_28, var_13.Override)
		end

		local var_110_29 = arg_109_0.l2dChar

		if var_9.GetCubismParameter(var_110_29, "l2d_hx") then
			HXSet = var_110_29

			if var_110_29.isHx() then
				local var_110_30 = arg_109_0.l2dChar
				local var_110_31 = var_10.AddParameterValue
				local var_110_32 = var_9
				local var_110_33 = 1

				CubismParameterBlendMode = var_2_10014

				var_110_31(var_110_30, var_110_32, var_110_33, var_2_10014.Override)
			else
				local var_110_34 = arg_109_0.l2dChar
				local var_110_35 = var_10.AddParameterValue
				local var_110_36 = var_9
				local var_110_37 = 0

				CubismParameterBlendMode = var_2_10014

				var_110_35(var_110_34, var_110_36, var_110_37, var_2_10014.Override)
			end
		end

		if var_110_17 and var_110_17 ~= 0 then
			local var_110_38 = var_110_3:GetChild(0)

			var_10.GetComponent(var_110_38, "CubismCriSrcMouthInput").Smoothing = var_110_17
		end

		return
	end)

	return
end

function var_0_1.showTip(arg_112_0)
	if not arg_112_0.proposeSkin then
		return
	end

	local var_112_0 = arg_112_0.storyTF
	local var_112_1 = var_2.Find(var_112_0, "tip")
	local var_112_2

	var_112_2, setText = var_2.Find(var_112_1, "Image_bg/Text"), var_112_1
	i18n = var_1_10006

	var_112_1(var_112_2, var_1_10006("achieve_propose_tip", var_1.name))

	eachChild = var_112_1

	var_112_1(var_2:Find("Image_bg/Image"), function(arg_113_0)
		setActive = var_2_10001

		var_2_10001(arg_113_0, arg_113_0.name == arg_112_0.proposeType)

		return
	end)

	GetOrAddComponent = var_112_1

	local var_112_3 = var_2

	typeof = var_6
	CanvasGroup = var_7

	local var_112_4 = var_112_1(var_112_3, var_6(var_7))

	setActive = var_112_3

	var_112_3(var_2, true)

	table = var_112_3

	local var_112_5 = var_112_3.insert
	local var_112_6 = arg_112_0.tweenList

	LeanTween = var_7

	local var_112_7 = var_7.alphaCanvas(var_112_4, 1, 0.01)

	var_112_5(var_112_6, var_7.setFrom(var_112_7, 0).uniqueId)

	table = var_112_5

	local var_112_8 = var_112_5.insert
	local var_112_9 = arg_112_0.tweenList

	LeanTween = var_7

	local var_112_10 = var_7.alphaCanvas(var_112_4, 0, 1.5)
	local var_112_11 = var_7.setFrom(var_112_10, 1)

	var_112_8(var_112_9, var_7.setDelay(var_112_11, 4).uniqueId)

	return
end

function var_0_1.initChangeNamePanel(arg_114_0)
	setText = var_1_10001

	local var_114_0 = arg_114_0._renamePanel
	local var_114_1 = var_2.Find(var_114_0, "frame/border/title")

	i18n = var_114_0

	local var_114_2 = "word_propose_changename_title"
	local var_114_3 = arg_114_0.shipVO

	var_1_10001(var_114_1, var_114_0(var_114_2, var_5.getName(var_114_3)))

	setText = var_1_10001

	local var_114_4 = arg_114_0._renamePanel
	local var_114_5 = var_2.Find(var_114_4, "frame/setting_ship_name/text")

	i18n = var_114_4

	var_1_10001(var_114_5, var_114_4("word_propose_changename_tip1"))

	setText = var_1_10001

	local var_114_6 = arg_114_0._renamePanel
	local var_114_7 = var_2.Find(var_114_6, "frame/text")

	i18n = var_114_6

	var_1_10001(var_114_7, var_114_6("word_propose_changename_tip2"))

	local var_114_8 = arg_114_0._renamePanel

	arg_114_0._renameConfirmBtn = var_1.Find(var_114_8, "frame/queren")

	local var_114_9 = arg_114_0._renamePanel

	arg_114_0._renameCancelBtn = var_1.Find(var_114_9, "frame/cancel")
	findTF = var_1

	local var_114_10 = var_1(arg_114_0._renamePanel, "frame/setting_ship_name")
	local var_114_11 = var_1.GetComponent

	typeof = var_3
	Toggle = var_4
	arg_114_0._renameToggle = var_114_11(var_114_10, var_3(var_4))

	local var_114_12 = arg_114_0._renamePanel

	arg_114_0._renameRevert = var_1.Find(var_114_12, "frame/revert_button")

	local var_114_13 = arg_114_0._renamePanel

	arg_114_0._closeBtn = var_1.Find(var_114_13, "frame/close_btn")
	onButton = var_1

	local var_114_14 = arg_114_0
	local var_114_15 = arg_114_0._renameConfirmBtn

	local function var_114_16()
		getInputText = var_2_10000
		findTF = var_2_10001

		local var_115_0 = var_2_10000(var_2_10001(arg_114_0._renamePanel, "frame/name_field"))

		pg = var_1

		local var_115_1 = var_1.PushNotificationMgr.GetInstance()

		var_1.setSwitchShipName(var_115_1, arg_114_0._renameToggle.isOn)

		local var_115_2 = arg_114_0
		local var_115_3 = var_1.emit

		ProposeMediator = var_3

		var_115_3(var_115_2, var_3.RENAME_SHIP, arg_114_0.shipVO.id, var_115_0)

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_114_14, var_114_15, var_114_16, var_5)

	onButton = var_1

	local var_114_17 = arg_114_0
	local var_114_18 = arg_114_0._renameRevert

	local function var_114_19()
		local var_116_0 = arg_114_0.shipVO

		if var_0.isRemoulded(var_116_0) then
			pg = var_116_1

			local var_116_1 = var_116_1.ship_skin_template

			var_2_10002 = arg_114_0.shipVO

			if not var_116_1[var_116_0.getRemouldSkinId(var_2_10002)].name then
				pg = var_116_1
				var_116_1 = var_116_1.ship_data_statistics[arg_114_0.shipVO.configId].name
			end

			setInputText = var_116_0
			findTF = var_2_10002

			var_116_0(var_2_10002(arg_114_0._renamePanel, "frame/name_field"), var_116_1)

			return
		end
	end

	SFX_PANEL = var_5

	var_1(var_114_17, var_114_18, var_114_19, var_5)

	onButton = var_1

	local var_114_20 = arg_114_0
	local var_114_21 = arg_114_0._renameCancelBtn

	local function var_114_22()
		local var_117_0 = arg_114_0

		var_0.closeView(var_117_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_114_20, var_114_21, var_114_22, var_5)

	onButton = var_1

	local var_114_23 = arg_114_0
	local var_114_24 = arg_114_0._closeBtn

	local function var_114_25()
		local var_118_0 = arg_114_0

		var_0.closeView(var_118_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_114_23, var_114_24, var_114_25, var_5)

	return
end

function var_0_1.DisplayRenamePanel(arg_119_0)
	local var_119_0 = arg_119_0.shipVO

	if var_1.IsXIdol(var_119_0) then
		arg_119_0:closeView()
	else
		setParent = var_1

		var_1(arg_119_0._renamePanel, arg_119_0._tf)

		setActive = var_1

		var_1(arg_119_0._renamePanel, true)

		local var_119_1 = arg_119_0.shipVO
		local var_119_2 = var_1.getName(var_119_1)

		setInputText = var_119_1
		findTF = var_3

		var_119_1(var_3(arg_119_0._renamePanel, "frame/name_field"), var_119_2)

		setIntimacyIcon = var_119_1

		local var_119_3 = arg_119_0.intimacyTF
		local var_119_4 = arg_119_0.shipVO

		var_119_1(var_119_3, var_4.getIntimacyIcon(var_119_4))
	end

	return
end

function var_0_1.showExchangePanel(arg_120_0)
	setActive = var_1_10001

	var_1_10001(arg_120_0.exchangePanel, true)

	pg = var_1_10001

	local var_120_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_120_0, arg_120_0.exchangePanel)

	return
end

function var_0_1.hideExchangePanel(arg_121_0)
	setActive = var_1_10001

	var_1_10001(arg_121_0.exchangePanel, false)

	pg = var_1_10001

	local var_121_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_121_0, arg_121_0.exchangePanel, arg_121_0._tf)

	return
end

function var_0_1.checkPaintingRes(arg_122_0, arg_122_1, arg_122_2)
	local var_122_0 = {}

	if arg_122_1:getProposeSkin() then
		local var_122_1 = var_4.id

		if 0 < var_122_1 then
			local var_122_2 = var_4.id

			PaintingGroupConst = var_1_10006

			var_1_10006.AddPaintingNameBySkinID(var_122_0, var_122_2)
		end
	end

	local var_122_3 = {
		isShowBox = true,
		paintingNameList = var_122_0,
		finishFunc = arg_122_2
	}

	PaintingGroupConst = var_1_10006

	var_1_10006.PaintingDownload(var_122_3)

	return
end

return var_0_1
