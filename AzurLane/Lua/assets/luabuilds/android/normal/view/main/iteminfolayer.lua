class = var_0_10000

local var_0_0 = "ItemInfoLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = 5
local var_0_3 = 11
local var_0_4 = 100
local var_0_5 = 53996
local var_0_6 = {
	USE = 3,
	RESOLVE = 2,
	COMPOSE = 1
}

function var_0_1.getUIName(arg_1_0)
	return "ItemInfoUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:BlurPanel(arg_2_0._tf)

	local var_2_0 = arg_2_0._tf

	arg_2_0.window = var_1.Find(var_2_0, "window")
	setText = var_1

	local var_2_1 = arg_2_0.window
	local var_2_2 = var_2.Find(var_2_1, "top/bg/infomation/title")

	i18n = var_2_1

	var_1(var_2_2, var_2_1("words_information"))

	local var_2_3 = arg_2_0.window

	arg_2_0.btnContent = var_1.Find(var_2_3, "actions")
	eachChild = var_1

	var_1(arg_2_0.btnContent, function(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0, false)

		return
	end)

	pairs = var_1

	local var_2_4 = {}
	local var_2_5 = {
		"ok_button"
	}

	i18n = var_4
	var_2_5[2] = var_4("msgbox_text_confirm")
	var_2_4.okBtn = var_2_5
	var_2_4.useBtn = {
		"use_button"
	}
	var_2_4.batchUseBtn = {
		"batch_use_button"
	}
	var_2_4.useOneBtn = {
		"use_one_button"
	}
	var_2_4.composeBtn = {
		"compose_button"
	}

	local var_2_6 = {
		"resolve_button"
	}

	i18n = var_4
	var_2_6[2] = var_4("msgbox_text_analyse")
	var_2_4.resolveBtn = var_2_6

	local var_2_7 = {
		"love_lettle_repair_button"
	}

	i18n = var_4
	var_2_7[2] = var_4("loveletter_exchange_button")
	var_2_4.loveRepairBtn = var_2_7

	local var_2_8 = {
		"metaskill_use_btn"
	}

	i18n = var_4
	var_2_8[2] = var_4("msgbox_text_use")
	var_2_4.metaskillBtn = var_2_8
	var_2_4.blueBtn = {
		"blue_btn"
	}
	var_2_4.yellowBtn = {
		"yellow_btn"
	}

	local var_2_9 = {
		"recycle_btn"
	}

	i18n = var_4
	var_2_9[2] = var_4("recycle_btn_label")
	var_2_4.recycleBtn = var_2_9

	local var_2_10 = {
		"skin_shop_btn"
	}

	i18n = var_4
	var_2_10[2] = var_4("go_skinshop_btn_label")
	var_2_4.skinShopBtn = var_2_10

	local var_2_11 = {
		"skin_experience_shop_btn"
	}

	i18n = var_4
	var_2_11[2] = var_4("go_skinexperienceshop_btn_label")
	var_2_4.skinExperienceShopBtn = var_2_11

	for iter_2_0, iter_2_1 in var_1(var_2_4) do
		unpack = var_1_10006

		local var_2_12

		var_1_10006, var_2_12 = var_1_10006(iter_2_1)

		local var_2_13 = arg_2_0.btnContent

		arg_2_0[iter_2_0] = var_8.Find(var_2_13, var_1_10006)

		if var_2_12 then
			setText = var_8

			local var_2_14 = arg_2_0[iter_2_0]

			var_8(var_9.Find(var_2_14, "pic"), var_2_12)
		end
	end

	local var_2_15 = arg_2_0.window

	arg_2_0.itemTF = var_1.Find(var_2_15, "item")

	local var_2_16 = arg_2_0._tf

	arg_2_0.operatePanel = var_1.Find(var_2_16, "operate")

	local var_2_17 = arg_2_0.operatePanel
	local var_2_18 = var_1.Find(var_2_17, "item/left/own/Text")
	local var_2_19 = var_1.GetComponent

	typeof = var_3
	Text = iter_2_0
	arg_2_0.countTF = var_2_19(var_2_18, var_3(iter_2_0))

	local var_2_20 = arg_2_0.operatePanel

	arg_2_0.keepFateTog = var_1.Find(var_2_20, "got/keep_tog")
	setText = var_1

	local var_2_21 = arg_2_0.keepFateTog
	local var_2_22 = var_2.Find(var_2_21, "label")

	i18n = var_2_21

	var_1(var_2_22, var_2_21("keep_fate_tip"))

	arg_2_0.operateBtns = {}

	local var_2_23 = arg_2_0.operateBtns
	local var_2_24 = arg_2_0.operatePanel

	var_2_23.Confirm = var_2.Find(var_2_24, "actions/confirm_button")

	local var_2_25 = arg_2_0.operateBtns
	local var_2_26 = arg_2_0.operatePanel

	var_2_25.Cancel = var_2.Find(var_2_26, "actions/cancel_button")

	local var_2_27 = arg_2_0.operateBtns
	local var_2_28 = arg_2_0.operatePanel

	var_2_27.Resolve = var_2.Find(var_2_28, "actions/resolve_button")
	setText = var_2_27

	local var_2_29 = arg_2_0.operateBtns.Confirm
	local var_2_30 = var_2.Find(var_2_29, "label")

	i18n = var_2_29

	var_2_27(var_2_30, var_2_29("msgbox_text_confirm"))

	setText = var_2_27

	local var_2_31 = arg_2_0.operateBtns.Cancel
	local var_2_32 = var_2.Find(var_2_31, "label")

	i18n = var_2_31

	var_2_27(var_2_32, var_2_31("msgbox_text_cancel"))

	setText = var_2_27

	local var_2_33 = arg_2_0.operateBtns.Resolve
	local var_2_34 = var_2.Find(var_2_33, "label")

	i18n = var_2_33

	var_2_27(var_2_34, var_2_33("msgbox_text_analyse"))

	SetActive = var_2_27

	var_2_27(arg_2_0.operatePanel, false)

	SetActive = var_2_27

	var_2_27(arg_2_0.window, true)

	arg_2_0.operateMode = nil

	local var_2_35 = arg_2_0.operatePanel

	arg_2_0.operateBonusList = var_1.Find(var_2_35, "got/panel_bg/list")

	local var_2_36 = arg_2_0.operatePanel

	arg_2_0.operateBonusTpl = var_1.Find(var_2_36, "got/panel_bg/list/item")

	local var_2_37 = arg_2_0.operatePanel

	arg_2_0.operateCountdesc = var_1.Find(var_2_37, "count/image_text")

	local var_2_38 = arg_2_0.operatePanel

	arg_2_0.operateValue = var_1.Find(var_2_38, "count/number_panel/value")

	local var_2_39 = arg_2_0.operatePanel

	arg_2_0.operateValueInput = var_1.Find(var_2_39, "count/number_panel/InputField")

	local var_2_40 = arg_2_0.operatePanel

	arg_2_0.operateLeftButton = var_1.Find(var_2_40, "count/number_panel/left")

	local var_2_41 = arg_2_0.operatePanel

	arg_2_0.operateRightButton = var_1.Find(var_2_41, "count/number_panel/right")

	local var_2_42 = arg_2_0.operatePanel

	arg_2_0.operateMaxButton = var_1.Find(var_2_42, "count/max")
	ItemRecycleConfirmationPage = var_1

	local var_2_43 = var_1.New

	pg = var_2_42
	arg_2_0.recycleConfirmationPage = var_2_43(var_2_42.UIMgr.GetInstance().OverlayMain)

	local var_2_44 = arg_2_0.recycleConfirmationPage

	var_1.SetCallback(var_2_44, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0._tf, false)

		return
	end, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0._tf, true)

		return
	end)

	return
end

function var_0_1.getButton(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if not arg_6_0[arg_6_1] then
		cloneTplTo = var_6_0
		var_6_0 = var_6_0(arg_6_2, arg_6_0.btnContent)
	end

	arg_6_0[arg_6_1] = var_6_0
	setActive = var_6_0

	var_6_0(arg_6_0[arg_6_1], true)

	return arg_6_0[arg_6_1]
end

function var_0_1.setDrop(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.type

	DROP_TYPE_SHIP = var_1_10003

	if var_7_0 == var_1_10003 then
		var_1_10003 = arg_7_0

		arg_7_0.setItemInfo(var_1_10003, arg_7_1, arg_7_0.itemTF)
	else
		local var_7_1 = arg_7_1.type

		DROP_TYPE_ITEM = var_1_10003

		if var_7_1 == var_1_10003 then
			getProxy = var_7_1
			BagProxy = var_1_10003

			local var_7_2 = var_7_1(var_1_10003)

			arg_7_1.count = var_7_1.getItemCountById(var_7_2, arg_7_1.id)

			arg_7_0:setItem(arg_7_1)
		else
			assert = var_7_1

			var_7_1(false, "do not support current kind of type: " .. arg_7_1.type)
		end
	end

	return
end

function var_0_1.setItemInfo(arg_8_0, arg_8_1, arg_8_2)
	updateDrop = var_1_10003

	local var_8_0 = arg_8_2
	local var_8_1 = arg_8_2.Find(var_8_0, "left/IconTpl")

	setmetatable = var_8_0

	var_1_10003(var_8_1, var_8_0({
		count = 0
	}, {
		__index = arg_8_1
	}))

	UpdateOwnDisplay = var_1_10003

	var_1_10003(arg_8_2:Find("left/own"), arg_8_1)

	RegisterDetailButton = var_1_10003

	var_1_10003(arg_8_0, arg_8_2:Find("left/detail"), arg_8_1)

	setText = var_1_10003

	var_1_10003(arg_8_2:Find("display_panel/name_container/name/Text"), arg_8_1:getConfig("name"))

	setText = var_1_10003

	var_1_10003(arg_8_2:Find("display_panel/desc/Text"), arg_8_1.desc)

	local var_8_2 = arg_8_2
	local var_8_3 = arg_8_2.Find(var_8_2, "display_panel/name_container/shiptype")

	setActive = var_8_2

	local var_8_4 = var_8_3
	local var_8_5 = arg_8_1.type

	DROP_TYPE_SHIP = var_7

	var_8_2(var_8_4, var_8_5 == var_7)

	local var_8_6 = arg_8_1.type

	DROP_TYPE_SHIP = var_8_4

	if var_8_6 == var_8_4 then
		GetImageSpriteFromAtlasAsync = var_8_6

		local var_8_7 = "shiptype"

		shipType2print = var_6

		var_8_6(var_8_7, var_6(arg_8_1:getConfig("type")), var_8_3, false)
	end

	return
end

function var_0_1.updateItemCount(arg_9_0, arg_9_1)
	arg_9_0.countTF.text = arg_9_1

	return
end

function var_0_1.setItem(arg_10_0, arg_10_1)
	arg_10_0:setItemInfo(arg_10_1, arg_10_0.itemTF)

	arg_10_0.itemVO = arg_10_1:getSubClass()
	Item = var_2

	if not var_2.CanInBag(arg_10_0.itemVO.id) then
		return
	end

	local var_10_0 = arg_10_0.itemVO

	if var_2.getConfig(var_10_0, "compose_number") > 0 and var_2 <= arg_10_0.itemVO.count then
		local var_10_1 = arg_10_0
		local var_10_2 = arg_10_0.setItemInfo
		local var_10_3 = arg_10_1
		local var_10_4 = arg_10_0.operatePanel

		var_10_2(var_10_1, var_10_3, var_6.Find(var_10_4, "item"))

		arg_10_0.operateMax = arg_10_0.itemVO.count / var_2
		setActive = var_3

		var_3(arg_10_0.composeBtn, true)
	end

	local var_10_5 = arg_10_0.itemVO
	local var_10_6 = var_3.getConfig(var_10_5, "usage")

	ItemUsage = var_10_5

	if var_10_6 == var_10_5.SOS then
		setText = var_10_6

		local var_10_7 = arg_10_0.useBtn

		var_10_6(var_4.Find(var_10_7, "text"), 1)

		setActive = var_10_6

		var_10_6(arg_10_0.useBtn, true)
	end

	local var_10_8 = arg_10_0.itemVO
	local var_10_9 = var_3.getConfig(var_10_8, "type")
	local var_10_10 = arg_10_0.itemVO

	if var_4.IsRepairLoveLetterItem(var_10_10) then
		onButton = var_4

		local var_10_11 = arg_10_0
		local var_10_12 = arg_10_0.loveRepairBtn

		local function var_10_13()
			pg = var_2_10000

			local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_11_1 = var_0.ShowMsgBox
			local var_11_2 = {}

			i18n = var_2_10003
			var_11_2.content = var_2_10003("loveletter2018_ui_1")

			function var_11_2.onYes()
				local var_12_0 = arg_10_0
				local var_12_1 = var_0.emit

				ItemInfoMediator = var_3_10002

				var_12_1(var_12_0, var_3_10002.REPAIR_LOVE_LETTER_ITEM, arg_10_0.itemVO)

				return
			end

			var_11_1(var_11_0, var_11_2)

			return
		end

		SFX_PANEL = var_1_10008

		var_4(var_10_11, var_10_12, var_10_13, var_1_10008)

		setActive = var_4

		var_4(arg_10_0.loveRepairBtn, true)

		setActive = var_4

		var_4(arg_10_0.okBtn, false)
	else
		Item = var_4

		if var_4.IsLoveLetterCheckItem(arg_10_0.itemVO.id) then
			local var_10_14

			if not arg_10_0.itemVO.extra then
				pg = var_10_14
				var_10_14 = var_10_14.loveletter_2018_2021[arg_10_0.itemVO.id].ship_group_id
			end

			local var_10_15 = arg_10_0
			local var_10_16 = arg_10_0.getButton(var_10_15, "checkMail", arg_10_0.blueBtn)

			setText = var_10_15
			var_1_10008 = var_10_16

			local var_10_17 = var_10_16.Find(var_1_10008, "pic")

			i18n = var_1_10008

			var_10_15(var_10_17, var_1_10008("loveletter_recover_bottom1"))

			onButton = var_10_15

			local var_10_18 = arg_10_0

			var_1_10008 = var_10_16

			local function var_10_19()
				local var_13_0 = arg_10_0
				local var_13_1 = var_0.emit

				ItemInfoMediator = var_2_10002

				var_13_1(var_13_0, var_2_10002.CHECK_LOVE_LETTER_MAIL, arg_10_0.itemVO.id, var_10_14)

				return
			end

			SFX_CONFIRM = var_1_10010

			var_10_15(var_10_18, var_1_10008, var_10_19, var_1_10010)

			local var_10_20 = arg_10_0
			local var_10_21 = arg_10_0.getButton(var_10_20, "repairMail", arg_10_0.yellowBtn)

			setText = var_10_20

			local var_10_22 = var_10_21

			var_1_10008 = var_10_21.Find(var_10_22, "pic")
			i18n = var_10_22

			var_10_20(var_1_10008, var_10_22("loveletter_recover_bottom2"))

			getProxy = var_10_20
			BagProxy = var_1_10008
			var_1_10008 = var_10_20(var_1_10008)

			local var_10_23 = var_7.GetLoveLetterRepairInfo(var_1_10008, arg_10_0.itemVO.id .. "_" .. var_10_14)

			onButton = var_1_10008

			local var_10_24 = arg_10_0
			local var_10_25 = var_10_21

			local function var_10_26()
				if not var_10_23 then
					pg = var_0
					var_2_10001 = var_0.TipsMgr.GetInstance()

					local var_14_0 = var_0.ShowTips

					i18n = var_2_10002

					var_14_0(var_2_10001, var_2_10002("loveletter_recover_tip1"))
				elseif #var_10_23 == 0 then
					pg = var_0
					var_2_10001 = var_0.TipsMgr.GetInstance()

					local var_14_1 = var_0.ShowTips

					i18n = var_2_10002

					var_14_1(var_2_10001, var_2_10002("loveletter_recover_tip3"))
				else
					local var_14_2

					if #var_10_23 == 1 then
						var_14_2 = var_10_23[1]
						pg = var_2_10001

						local var_14_3 = var_2_10001.MsgboxMgr.GetInstance()
						local var_14_4 = var_1.ShowMsgBox

						var_2_10003 = {
							delayConfirm = 3
						}
						i18n = var_2_10004
						var_2_10005 = "loveletter_recover_text1"

						local var_14_5 = var_14_2

						ShipGroup = var_2_10007

						local var_14_6 = var_2_10007.New({
							id = var_10_14
						})

						var_2_10003.content = var_2_10004(var_2_10005, var_14_5, var_7.getName(var_14_6))

						function var_2_10003.onYes()
							local var_15_0 = arg_10_0
							local var_15_1 = var_0.emit

							ItemInfoMediator = var_3_10002

							var_15_1(var_15_0, var_3_10002.REPAIR_LOVE_LETTER_MAIL, arg_10_0.itemVO.id, var_14_2, var_10_14)

							return
						end

						var_14_4(var_14_3, var_2_10003)
					else
						table = var_14_2

						var_14_2.sort(var_10_23)

						pg = var_0

						local var_14_7 = var_0.MsgboxMgr.GetInstance()
						local var_14_8 = var_0.ShowMsgBox
						local var_14_9 = {
							hideYes = true
						}

						i18n = var_2_10003

						local var_14_10 = "loveletter_recover_text2"

						ShipGroup = var_2_10005

						local var_14_11 = var_2_10005.New({
							id = var_10_14
						})

						var_14_9.content = var_2_10003(var_14_10, var_5.getName(var_14_11))
						underscore = var_3
						var_14_9.custom = var_3.map(var_10_23, function(arg_16_0)
							local var_16_0 = {
								delayButton = 3
							}

							i18n = var_3_10002
							var_16_0.text = var_3_10002("loveletter_recover_bottom3", arg_16_0)
							SFX_CONFIRM = var_2
							var_16_0.sound = var_2

							function var_16_0.onCallback()
								local var_17_0 = arg_10_0
								local var_17_1 = var_0.emit

								ItemInfoMediator = var_4_10002

								var_17_1(var_17_0, var_4_10002.REPAIR_LOVE_LETTER_MAIL, arg_10_0.itemVO.id, arg_16_0, var_10_14)

								return
							end

							pg = var_2
							var_16_0.btnType = var_2.MsgboxMgr.BUTTON_YELLOW

							return var_16_0
						end)

						var_14_8(var_14_7, var_14_9)
					end
				end

				return
			end

			SFX_PANEL = var_1_10012

			var_1_10008(var_10_24, var_10_25, var_10_26, var_1_10012)

			setGray = var_1_10008

			var_1_10008(var_10_21, not var_10_23 or #var_10_23 == 0)
		else
			local var_10_27 = arg_10_0.itemVO
			local var_10_28 = var_4.getConfig(var_10_27, "type")

			Item = var_10_27

			if var_10_28 == var_10_27.EQUIPMENT_BOX_TYPE_5 then
				local var_10_29 = arg_10_0
				local var_10_30 = arg_10_0.setItemInfo
				local var_10_31 = arg_10_1

				var_1_10008 = arg_10_0.operatePanel

				var_10_30(var_10_29, var_10_31, var_7.Find(var_1_10008, "item"))

				setActive = var_10_30

				var_10_30(arg_10_0.useOneBtn, true)

				onButton = var_10_30

				local var_10_32 = arg_10_0
				local var_10_33 = arg_10_0.useOneBtn

				local function var_10_34()
					SetActive = var_2_10000

					var_2_10000(arg_10_0.operatePanel, true)

					SetActive = var_2_10000

					var_2_10000(arg_10_0.window, false)

					arg_10_0.operateMode = var_0_6.USE

					local var_18_0 = arg_10_0

					var_0.SetOperateCount(var_18_0, 1)

					return
				end

				SFX_PANEL = var_1_10008

				var_10_30(var_10_32, var_10_33, var_10_34, var_1_10008)
			else
				local var_10_35 = arg_10_0.itemVO
				local var_10_37

				if var_4.CanOpen(var_10_35) then
					setText = var_10_37

					local var_10_36 = arg_10_0.useBtn

					var_10_37(var_10_35.Find(var_10_36, "text"), 1)

					setActive = var_10_37

					var_10_37(arg_10_0.useBtn, true)

					var_10_37 = arg_10_0.itemVO.count

					if 1 < var_10_37 then
						setText = var_10_37

						local var_10_38 = arg_10_0.batchUseBtn

						var_10_35 = var_10_35.Find(var_10_38, "text")
						math = var_10_38

						var_10_37(var_10_35, var_10_38.min(arg_10_0.itemVO.count, 10))

						setActive = var_10_37

						var_10_37(arg_10_0.batchUseBtn, true)
					end
				else
					Item = var_10_37

					if var_10_9 == var_10_37.BLUEPRINT_TYPE then
						getProxy = var_4
						TechnologyProxy = var_10_35

						local var_10_39 = var_4(var_10_35)
						local var_10_40 = var_4.GetBlueprint4Item(var_10_39, arg_10_0.itemVO.id)

						LOCK_FRAGMENT_SHOP = var_10_39

						if not var_10_39 and var_10_40 then
							var_1_10008 = var_4:getBluePrintById(var_10_40)

							if var_6.isMaxLevel(var_1_10008) then
								setActive = var_7

								var_7(arg_10_0.resolveBtn, true)

								var_1_10008 = arg_10_0

								arg_10_0.UpdateBlueprintResolveNum(var_1_10008)
							end
						end

						local var_10_41 = arg_10_0
						local var_10_42 = arg_10_0.setItemInfo

						var_1_10008 = arg_10_1

						local var_10_43 = arg_10_0.operatePanel

						var_10_42(var_10_41, var_1_10008, var_9.Find(var_10_43, "item"))

						setActive = var_10_42

						var_10_42(arg_10_0.okBtn, true)
					else
						Item = var_4

						local var_10_45

						if var_10_9 == var_4.TEC_SPEEDUP_TYPE then
							setActive = var_10_45

							var_10_45(arg_10_0.resolveBtn, true)
							arg_10_0:UpdateSpeedUpResolveNum()

							local var_10_44 = arg_10_0

							var_10_45 = arg_10_0.setItemInfo

							local var_10_46 = arg_10_1

							var_1_10008 = arg_10_0.operatePanel

							var_10_45(var_10_44, var_10_46, var_7.Find(var_1_10008, "item"))

							setActive = var_10_45

							var_10_45(arg_10_0.okBtn, true)
						else
							Item = var_10_45

							if var_10_9 == var_10_45.LOVE_LETTER_TYPE then
								setActive = var_4

								var_4(arg_10_0.loveRepairBtn, false)

								setActive = var_4

								var_4(arg_10_0.okBtn, true)
							else
								Item = var_4

								if var_10_9 == var_4.METALESSON_TYPE then
									setActive = var_4

									var_4(arg_10_0.metaskillBtn, true)

									onButton = var_4

									local var_10_47 = arg_10_0
									local var_10_48 = arg_10_0.metaskillBtn

									local function var_10_49()
										local var_19_0 = arg_10_0

										var_0.closeView(var_19_0)

										pg = var_0

										local var_19_1 = var_0.m02
										local var_19_2 = var_0.sendNotification

										GAME = var_2_10002

										local var_19_3 = var_2_10002.GO_SCENE

										SCENE = var_2_10003

										var_19_2(var_19_1, var_19_3, var_2_10003.METACHARACTER)

										return
									end

									SFX_PANEL = var_1_10008

									var_4(var_10_47, var_10_48, var_10_49, var_1_10008)

									setActive = var_4

									var_4(arg_10_0.okBtn, true)
								else
									Item = var_4

									if var_10_9 == var_4.SKIN_ASSIGNED_TYPE then
										setActive = var_4

										var_4(arg_10_0.useOneBtn, arg_10_0.contextData.confirmCall)

										onButton = var_4

										local var_10_50 = arg_10_0
										local var_10_51 = arg_10_0.useOneBtn

										local function var_10_52()
											arg_10_0.contextData.confirmCall()

											local var_20_0 = arg_10_0

											var_0.closeView(var_20_0)

											return
										end

										SFX_PANEL = var_1_10008

										var_4(var_10_50, var_10_51, var_10_52, var_1_10008)

										setActive = var_4

										var_4(arg_10_0.okBtn, true)
									else
										local var_10_53 = arg_10_0.itemVO

										if var_4.IsExclusiveDiscountType(var_10_53) then
											setActive = var_4

											var_4(arg_10_0.recycleBtn, true)

											setActive = var_4

											var_4(arg_10_0.skinShopBtn, true)
										else
											local var_10_54 = arg_10_0.itemVO

											if var_4.IsSkinExperienceType(var_10_54) then
												setActive = var_4

												var_4(arg_10_0.skinExperienceShopBtn, true)
											else
												setActive = var_4

												var_4(arg_10_0.okBtn, true)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.closeView(arg_21_0)
	if arg_21_0.playing then
		return
	end

	var_0_1.super.closeView(arg_21_0)

	return
end

function var_0_1.didEnter(arg_22_0)
	local var_22_0 = arg_22_0._tf

	if var_1.Find(var_22_0, "OpenBox(Clone)") then
		SetActive = var_22_0

		var_22_0(var_1, false)
	end

	onButton = var_22_0

	local var_22_1 = arg_22_0
	local var_22_2 = arg_22_0._tf
	local var_22_3 = var_4.Find(var_22_2, "bg")

	local function var_22_4()
		local var_23_0 = arg_22_0

		var_0.closeView(var_23_0)

		return
	end

	SFX_CANCEL = var_6

	var_22_0(var_22_1, var_22_3, var_22_4, var_6)

	onButton = var_22_0

	local var_22_5 = arg_22_0
	local var_22_6 = arg_22_0._tf
	local var_22_7 = var_4.Find(var_22_6, "window/top/btnBack")

	local function var_22_8()
		local var_24_0 = arg_22_0

		var_0.closeView(var_24_0)

		return
	end

	SFX_CANCEL = var_6

	var_22_0(var_22_5, var_22_7, var_22_8, var_6)

	onButton = var_22_0

	local var_22_9 = arg_22_0
	local var_22_10 = arg_22_0.okBtn

	local function var_22_11()
		local var_25_0 = arg_22_0

		var_0.closeView(var_25_0)

		return
	end

	SFX_CONFIRM = var_6

	var_22_0(var_22_9, var_22_10, var_22_11, var_6)

	onButton = var_22_0

	local var_22_12 = arg_22_0
	local var_22_13 = arg_22_0.useBtn

	local function var_22_14()
		local var_26_0 = arg_22_0
		local var_26_1 = var_0.emit

		ItemInfoMediator = var_2_10002

		var_26_1(var_26_0, var_2_10002.USE_ITEM, arg_22_0.itemVO.id, 1)

		return
	end

	SFX_CONFIRM = var_6

	var_22_0(var_22_12, var_22_13, var_22_14, var_6)

	onButton = var_22_0

	local var_22_15 = arg_22_0
	local var_22_16 = arg_22_0.batchUseBtn

	local function var_22_17()
		local var_27_0 = arg_22_0
		local var_27_1 = var_0.emit

		ItemInfoMediator = var_2_10002

		local var_27_2 = var_2_10002.USE_ITEM
		local var_27_3 = arg_22_0.itemVO.id

		math = var_2_10004

		var_27_1(var_27_0, var_27_2, var_27_3, var_2_10004.min(arg_22_0.itemVO.count, 10))

		return
	end

	SFX_CONFIRM = var_6

	var_22_0(var_22_15, var_22_16, var_22_17, var_6)

	onButton = var_22_0

	local var_22_18 = arg_22_0
	local var_22_19 = arg_22_0.composeBtn

	local function var_22_20()
		SetActive = var_2_10000

		var_2_10000(arg_22_0.operatePanel, true)

		SetActive = var_2_10000

		var_2_10000(arg_22_0.window, false)

		arg_22_0.operateMode = var_0_6.COMPOSE

		local var_28_0 = arg_22_0

		var_0.SetOperateCount(var_28_0, 1)

		return
	end

	SFX_CONFIRM = var_6

	var_22_0(var_22_18, var_22_19, var_22_20, var_6)

	onButton = var_22_0

	local var_22_21 = arg_22_0
	local var_22_22 = arg_22_0.resolveBtn

	local function var_22_23()
		SetActive = var_2_10000

		var_2_10000(arg_22_0.operatePanel, true)

		SetActive = var_2_10000

		var_2_10000(arg_22_0.window, false)

		arg_22_0.operateMode = var_0_6.RESOLVE

		local var_29_0 = arg_22_0

		var_0.SetOperateCount(var_29_0, 1)

		return
	end

	SFX_PANEL = var_6

	var_22_0(var_22_21, var_22_22, var_22_23, var_6)

	pressPersistTrigger = var_22_0

	local var_22_24 = arg_22_0.operateLeftButton
	local var_22_25 = 0.5

	local function var_22_26(arg_30_0)
		local var_30_0 = arg_22_0

		if not var_1.UpdateCount(var_30_0, arg_22_0.operateCount - 1) then
			arg_30_0()

			return
		end

		local var_30_1 = arg_22_0

		var_1.SetOperateCount(var_30_1, arg_22_0.operateCount - 1)

		return
	end

	local var_22_27
	local var_22_28 = true
	local var_22_29 = true
	local var_22_30 = 0.1

	SFX_PANEL = var_1_10010

	var_22_0(var_22_24, var_22_25, var_22_26, var_22_27, var_22_28, var_22_29, var_22_30, var_1_10010)

	pressPersistTrigger = var_22_0

	local var_22_31 = arg_22_0.operateRightButton
	local var_22_32 = 0.5

	local function var_22_33(arg_31_0)
		local var_31_0 = arg_22_0

		if not var_1.UpdateCount(var_31_0, arg_22_0.operateCount + 1) then
			arg_31_0()

			return
		end

		local var_31_1 = arg_22_0

		var_1.SetOperateCount(var_31_1, arg_22_0.operateCount + 1)

		return
	end

	local var_22_34
	local var_22_35 = true
	local var_22_36 = true
	local var_22_37 = 0.1

	SFX_PANEL = var_1_10010

	var_22_0(var_22_31, var_22_32, var_22_33, var_22_34, var_22_35, var_22_36, var_22_37, var_1_10010)

	onButton = var_22_0

	local var_22_38 = arg_22_0
	local var_22_39 = arg_22_0.operateMaxButton

	local function var_22_40()
		local var_32_0 = arg_22_0

		var_0.SetOperateCount(var_32_0, arg_22_0.operateMax)

		return
	end

	SFX_PANEL = var_22_34

	var_22_0(var_22_38, var_22_39, var_22_40, var_22_34)

	onInputEndEdit = var_22_0

	var_22_0(arg_22_0, arg_22_0.operateValueInput, function(arg_33_0)
		tonumber = var_2_10001

		local var_33_0

		if not var_2_10001(arg_33_0) then
			var_33_0 = 1
		end

		math = var_2

		local var_33_1 = var_2.min
		local var_33_2 = var_0_4

		math = var_2_10004

		local var_33_3 = var_33_1(var_33_2, var_2_10004.min(var_33_0, arg_22_0.operateMax))

		math = var_33_2

		local var_33_4 = var_33_2.max(1, var_33_3)
		local var_33_5 = arg_22_0

		var_3.SetOperateCount(var_33_5, var_33_4)

		tostring = var_3

		if arg_33_0 ~= var_3(var_33_4) then
			setInputText = var_3

			var_3(arg_22_0.operateValueInput, var_33_4)
		end

		return
	end)

	local var_22_41 = arg_22_0.itemVO
	local var_22_42 = var_2.getConfig(var_22_41, "type")

	Item = var_22_41

	local var_22_43 = var_22_42 == var_22_41.EQUIPMENT_BOX_TYPE_5

	setActive = var_3

	var_3(arg_22_0.operateValueInput, var_22_43)

	setActive = var_3

	var_3(arg_22_0.operateValue, not var_22_43)

	onButton = var_3

	local var_22_44 = arg_22_0
	local var_22_45 = arg_22_0.operateBtns.Cancel

	local function var_22_46()
		SetActive = var_2_10000

		var_2_10000(arg_22_0.operatePanel, false)

		SetActive = var_2_10000

		var_2_10000(arg_22_0.window, true)

		arg_22_0.operateCount = 0
		arg_22_0.operateMode = nil

		return
	end

	SFX_CANCEL = var_22_35

	var_3(var_22_44, var_22_45, var_22_46, var_22_35)

	onButton = var_3

	local var_22_47 = arg_22_0
	local var_22_48 = arg_22_0.operateBtns.Confirm

	local function var_22_49()
		if arg_22_0.operateMode == var_0_6.COMPOSE then
			local var_35_0 = arg_22_0
			local var_35_1 = var_0.emit

			ItemInfoMediator = var_2_10002

			var_35_1(var_35_0, var_2_10002.COMPOSE_ITEM, arg_22_0.itemVO.id, arg_22_0.operateCount)

			local var_35_2 = arg_22_0.itemVO
			local var_35_3 = var_0.getConfig(var_35_2, "compose_number")

			if arg_22_0.itemVO.count - arg_22_0.operateCount * var_35_3 < var_35_3 then
				triggerButton = var_1

				var_1(arg_22_0.operateBtns.Cancel)
			else
				var_2_10002 = arg_22_0

				var_1.SetOperateCount(var_2_10002, 1)
			end
		elseif arg_22_0.operateMode == var_0_6.USE then
			local var_35_4 = arg_22_0
			local var_35_5 = var_0.emit

			ItemInfoMediator = var_2_10002

			var_35_5(var_35_4, var_2_10002.USE_ITEM, arg_22_0.itemVO.id, arg_22_0.operateCount)
		end

		return
	end

	SFX_CONFIRM = var_22_35

	var_3(var_22_47, var_22_48, var_22_49, var_22_35)

	onButton = var_3

	local var_22_50 = arg_22_0
	local var_22_51 = arg_22_0.recycleBtn

	local function var_22_52()
		local var_36_0 = arg_22_0.itemVO
		local var_36_1

		if not var_0.GetPrice(var_36_0) then
			var_36_1 = {
				0,
				0
			}
		end

		i18n = var_36_0

		local var_36_2 = "skin_discount_item_recycle_tip"
		local var_36_3 = arg_22_0.itemVO
		local var_36_4 = var_36_0(var_36_2, var_3.getName(var_36_3), var_36_1[2])
		local var_36_5 = arg_22_0.recycleConfirmationPage

		var_2.ExecuteAction(var_36_5, "Show", {
			content = var_36_4,
			itemId = arg_22_0.itemVO.id
		})

		return
	end

	SFX_CONFIRM = var_22_35

	var_3(var_22_50, var_22_51, var_22_52, var_22_35)

	onButton = var_3

	local var_22_53 = arg_22_0
	local var_22_54 = arg_22_0.skinShopBtn

	local function var_22_55()
		local var_37_0 = arg_22_0

		var_0.closeView(var_37_0)

		pg = var_0

		local var_37_1 = var_0.m02
		local var_37_2 = var_0.sendNotification

		GAME = var_2_10002

		local var_37_3 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_37_2(var_37_1, var_37_3, var_2_10003.SKINSHOP)

		return
	end

	SFX_CONFIRM = var_22_35

	var_3(var_22_53, var_22_54, var_22_55, var_22_35)

	onButton = var_3

	local var_22_56 = arg_22_0
	local var_22_57 = arg_22_0.skinExperienceShopBtn

	local function var_22_58()
		local var_38_0 = arg_22_0

		var_0.closeView(var_38_0)

		pg = var_0

		local var_38_1 = var_0.m02
		local var_38_2 = var_0.sendNotification

		GAME = var_2_10002

		local var_38_3 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_38_4 = var_2_10003.SKINSHOP
		local var_38_5 = {}

		NewSkinShopScene = var_2_10005
		var_38_5.mode = var_2_10005.MODE_EXPERIENCE_FOR_ITEM

		var_38_2(var_38_1, var_38_3, var_38_4, var_38_5)

		return
	end

	SFX_CONFIRM = var_22_35

	var_3(var_22_56, var_22_57, var_22_58, var_22_35)

	onButton = var_3

	local var_22_59 = arg_22_0
	local var_22_60 = arg_22_0.operateBtns.Resolve

	local function var_22_61()
		local var_39_0 = arg_22_0
		local var_39_1 = var_0.emit

		ItemInfoMediator = var_2_10002

		local var_39_2 = var_2_10002.SELL_BLUEPRINT

		Drop = var_2_10003

		local var_39_3 = var_2_10003.New
		local var_39_4 = {}

		DROP_TYPE_ITEM = var_2_10005
		var_39_4.type = var_2_10005
		var_39_4.id = arg_22_0.itemVO.id
		var_39_4.count = arg_22_0.operateCount

		var_39_1(var_39_0, var_39_2, var_39_3(var_39_4))

		return
	end

	SFX_CONFIRM = var_22_35

	var_3(var_22_59, var_22_60, var_22_61, var_22_35)

	getProxy = var_3
	PlayerProxy = var_22_59

	local var_22_62 = var_3(var_22_59)
	local var_22_63 = var_3.getData(var_22_62)

	GetComponent = var_22_62

	local var_22_64 = arg_22_0.keepFateTog

	typeof = var_22_61
	Toggle = var_22_35

	local var_22_65 = var_22_62(var_22_64, var_22_61(var_22_35))
	local var_22_66 = var_22_63
	local var_22_67 = var_22_63.GetCommonFlag

	SHOW_DONT_KEEP_FATE_ITEM = var_22_35
	arg_22_0.keepFateState = not var_22_67(var_22_66, var_22_35)
	var_22_65.isOn = arg_22_0.keepFateState

	local function var_22_68()
		local var_40_0 = arg_22_0

		var_0.UpdateBlueprintResolveNum(var_40_0)

		local var_40_1 = arg_22_0

		var_0.SetOperateCount(var_40_1, 1)

		return
	end

	onToggle = var_22_66

	var_22_66(arg_22_0, arg_22_0.keepFateTog, function(arg_41_0)
		local var_41_0 = arg_22_0

		var_41_0.keepFateState = arg_41_0

		if arg_41_0 then
			pg = var_41_0

			local var_41_1 = var_41_0.m02

			var_41_0 = var_41_0.sendNotification
			GAME = var_2_10003
			var_2_10003 = var_2_10003.CANCEL_COMMON_FLAG

			local var_41_2 = {}

			SHOW_DONT_KEEP_FATE_ITEM = var_2_10005
			var_41_2.flagID = var_2_10005

			var_41_0(var_41_1, var_2_10003, var_41_2)
		else
			pg = var_41_0

			local var_41_3 = var_41_0.m02
			local var_41_4 = var_1.sendNotification

			GAME = var_2_10003

			local var_41_5 = var_2_10003.COMMON_FLAG
			local var_41_6 = {}

			SHOW_DONT_KEEP_FATE_ITEM = var_2_10005
			var_41_6.flagID = var_2_10005

			var_41_4(var_41_3, var_41_5, var_41_6)
		end

		var_22_68()

		return
	end)
	var_22_68()

	return
end

function var_0_1.UpdateCount(arg_42_0, arg_42_1)
	if arg_42_0.operateMode == var_0_6.COMPOSE then
		local var_42_0 = arg_42_0.itemVO

		if not var_2.getConfig(var_42_0, "target_id") or var_2 <= 0 then
			return false
		end

		math = var_42_0

		local var_42_1 = var_42_0.clamp
		local var_42_2 = arg_42_1
		local var_42_3 = 1

		math = var_1_10006

		local var_42_4 = var_1_10006.floor
		local var_42_5 = arg_42_0.itemVO.count
		local var_42_6 = arg_42_0.itemVO

		arg_42_1 = var_42_1(var_42_2, var_42_3, var_42_4(var_42_5 / var_8.getConfig(var_42_6, "compose_number")))

		return arg_42_0.operateCount ~= arg_42_1
	elseif arg_42_0.operateMode == var_0_6.RESOLVE then
		math = var_2
		arg_42_1 = var_2.clamp(arg_42_1, 1, arg_42_0.itemVO.count)

		return arg_42_0.operateCount ~= arg_42_1
	elseif arg_42_0.operateMode == var_0_6.USE then
		math = var_2
		arg_42_1 = var_2.clamp(arg_42_1, 1, arg_42_0.itemVO.count)

		return arg_42_0.operateCount ~= arg_42_1
	end

	return
end

function var_0_1.SetOperateCount(arg_43_0, arg_43_1)
	if arg_43_0.operateMode == var_0_6.COMPOSE then
		local var_43_0 = arg_43_0.itemVO

		if not var_2.getConfig(var_43_0, "target_id") or var_2 <= 0 then
			return
		end

		local var_43_1 = arg_43_0.itemVO
		local var_43_2 = var_3.getConfig(var_43_1, "compose_number")

		math = var_43_1

		local var_43_3 = var_43_1.clamp

		var_1_10005 = arg_43_1

		local var_43_4 = 1

		math = var_1_10007
		arg_43_1 = var_43_3(var_1_10005, var_43_4, var_1_10007.floor(arg_43_0.itemVO.count / var_43_2))

		if arg_43_0.operateCount ~= arg_43_1 then
			arg_43_0.operateCount = arg_43_1
			var_1_10005 = arg_43_0

			arg_43_0.UpdateComposeCount(var_1_10005)
		end

		local var_43_5 = arg_43_0.itemVO.count - arg_43_0.operateCount * var_43_2

		arg_43_0:updateItemCount(var_43_5)
	elseif arg_43_0.operateMode == var_0_6.RESOLVE then
		math = var_2
		arg_43_1 = var_2.clamp(arg_43_1, 0, arg_43_0.operateMax)

		if arg_43_0.operateCount ~= arg_43_1 then
			arg_43_0.operateCount = arg_43_1

			arg_43_0:UpdateResolvePanel()
			arg_43_0:updateItemCount(arg_43_0.itemVO.count - arg_43_0.operateCount)
		end
	elseif arg_43_0.operateMode == var_0_6.USE then
		math = var_2

		local var_43_6 = var_2.clamp
		local var_43_7 = arg_43_1
		local var_43_8 = 0

		math = var_1_10005
		arg_43_1 = var_43_6(var_43_7, var_43_8, var_1_10005.min(arg_43_0.operateMax, var_0_4))

		if arg_43_0.operateCount ~= arg_43_1 then
			arg_43_0.operateCount = arg_43_1

			arg_43_0:UpdateUsePanel()
			arg_43_0:updateItemCount(arg_43_0.itemVO.count - arg_43_0.operateCount)
		end
	end

	return
end

function var_0_1.UpdateComposeCount(arg_44_0)
	local var_44_0 = arg_44_0.operateCount

	setText = var_1_10002

	var_1_10002(arg_44_0.operateValue, var_44_0)

	setInputText = var_1_10002

	var_1_10002(arg_44_0.operateValueInput, var_44_0)

	local var_44_1 = {}

	table = var_3

	local var_44_2 = var_3.insert
	local var_44_3 = var_44_1
	local var_44_4 = {}

	DROP_TYPE_ITEM = var_1_10006
	var_44_4.type = var_1_10006

	local var_44_5 = arg_44_0.itemVO

	var_44_4.id = var_6.getConfig(var_44_5, "target_id")
	var_44_4.count = var_44_0

	var_44_2(var_44_3, var_44_4)

	UIItemList = var_44_2

	var_44_2.StaticAlign(arg_44_0.operateBonusList, arg_44_0.operateBonusTpl, #var_44_1, function(arg_45_0, arg_45_1, arg_45_2)
		arg_45_1 = arg_45_1 + 1
		UIItemList = var_2_10003

		if arg_45_0 == var_2_10003.EventUpdate then
			local var_45_0 = var_44_1[arg_45_1]

			updateDrop = var_2_10004

			var_2_10004(arg_45_2:Find("IconTpl"), var_45_0)

			onButton = var_2_10004

			local var_45_1 = arg_44_0
			local var_45_2 = arg_45_2:Find("IconTpl")

			local function var_45_3()
				local var_46_0 = arg_44_0

				var_0.emit(var_46_0, var_0_1.ON_DROP, var_45_0)

				return
			end

			SFX_PANEL = var_8

			var_2_10004(var_45_1, var_45_2, var_45_3, var_8)
		end

		return
	end)

	pairs = var_3

	for iter_44_0, iter_44_1 in var_3(arg_44_0.operateBtns) do
		setActive = var_8

		var_8(iter_44_1, iter_44_0 == "Confirm" or iter_44_0 == "Cancel")
	end

	setText = var_3

	local var_44_6 = arg_44_0.operateCountdesc

	i18n = var_5

	var_3(var_44_6, var_5("compose_amount_prefix"))

	setActive = var_3

	var_3(arg_44_0.keepFateTog, false)

	return
end

function var_0_1.UpdateResolvePanel(arg_47_0)
	local var_47_0 = arg_47_0.operateCount

	setText = var_1_10002

	var_1_10002(arg_47_0.operateValue, var_47_0)

	setInputText = var_1_10002

	var_1_10002(arg_47_0.operateValueInput, var_47_0)

	local var_47_1 = arg_47_0.itemVO
	local var_47_2 = var_2.getConfig(var_47_1, "price")
	local var_47_3 = {}

	table = var_4

	local var_47_4 = var_4.insert
	local var_47_5 = var_47_3
	local var_47_6 = {}

	DROP_TYPE_RESOURCE = var_1_10007
	var_47_6.type = var_1_10007
	var_47_6.id = var_47_2[1]
	var_47_6.count = var_47_2[2] * var_47_0

	var_47_4(var_47_5, var_47_6)

	UIItemList = var_47_4

	var_47_4.StaticAlign(arg_47_0.operateBonusList, arg_47_0.operateBonusTpl, #var_47_3, function(arg_48_0, arg_48_1, arg_48_2)
		arg_48_1 = arg_48_1 + 1
		UIItemList = var_2_10003

		if arg_48_0 == var_2_10003.EventUpdate then
			local var_48_0 = var_47_3[arg_48_1]

			updateDrop = var_2_10004

			var_2_10004(arg_48_2:Find("IconTpl"), var_48_0)

			onButton = var_2_10004

			local var_48_1 = arg_47_0
			local var_48_2 = arg_48_2:Find("IconTpl")

			local function var_48_3()
				local var_49_0 = arg_47_0

				var_0.emit(var_49_0, var_0_1.ON_DROP, var_48_0)

				return
			end

			SFX_PANEL = var_8

			var_2_10004(var_48_1, var_48_2, var_48_3, var_8)
		end

		return
	end)

	pairs = var_4

	for iter_47_0, iter_47_1 in var_4(arg_47_0.operateBtns) do
		setActive = var_1_10009

		var_1_10009(iter_47_1, iter_47_0 == "Resolve" or iter_47_0 == "Cancel")
	end

	setText = var_4

	local var_47_7 = arg_47_0.operateCountdesc

	i18n = var_6

	var_4(var_47_7, var_6("resolve_amount_prefix"))

	local var_47_8 = arg_47_0.itemVO
	local var_47_9 = var_4.getConfig(var_47_8, "type")

	Item = var_47_8

	if var_47_9 == var_47_8.TEC_SPEEDUP_TYPE then
		setActive = var_47_9

		var_47_9(arg_47_0.keepFateTog, false)
	else
		setActive = var_47_9

		var_47_9(arg_47_0.keepFateTog, true)
	end

	setButtonEnabled = var_47_9

	var_47_9(arg_47_0.operateBtns.Resolve, var_47_0 > 0)

	return
end

function var_0_1.UpdateBlueprintResolveNum(arg_50_0)
	local var_50_0 = arg_50_0.itemVO.count
	local var_50_1 = arg_50_0.itemVO
	local var_50_2 = var_2.getConfig(var_50_1, "type")

	Item = var_50_1

	if var_50_2 == var_50_1.BLUEPRINT_TYPE then
		getProxy = var_3
		TechnologyProxy = var_4

		local var_50_3 = var_3(var_4)
		local var_50_4 = var_3.GetBlueprint4Item(var_50_3, arg_50_0.itemVO.id)
		local var_50_5 = var_3:getBluePrintById(var_50_4)

		var_50_0 = arg_50_0.keepFateState and arg_50_0.itemVO.count - var_50_5:getFateMaxLeftOver() < 0 and 0 or var_50_0
	end

	arg_50_0.operateMax = var_50_0

	return
end

function var_0_1.UpdateSpeedUpResolveNum(arg_51_0)
	local var_51_0 = arg_51_0.itemVO.count
	local var_51_1 = arg_51_0.itemVO
	local var_51_2 = var_2.getConfig(var_51_1, "type")

	Item = var_51_1

	if var_51_2 == var_51_1.TEC_SPEEDUP_TYPE then
		arg_51_0.operateMax = var_51_0
	end

	return
end

function var_0_1.UpdateUsePanel(arg_52_0)
	local var_52_0 = arg_52_0.operateCount

	setText = var_1_10002

	var_1_10002(arg_52_0.operateValue, var_52_0)

	setInputText = var_1_10002

	var_1_10002(arg_52_0.operateValueInput, var_52_0)

	local var_52_1 = {}

	table = var_3

	local var_52_2 = var_3.insert
	local var_52_3 = var_52_1
	local var_52_4 = {}

	DROP_TYPE_ITEM = var_1_10006
	var_52_4.type = var_1_10006
	var_52_4.id = var_0_5
	var_52_4.count = var_52_0

	var_52_2(var_52_3, var_52_4)

	UIItemList = var_52_2

	var_52_2.StaticAlign(arg_52_0.operateBonusList, arg_52_0.operateBonusTpl, #var_52_1, function(arg_53_0, arg_53_1, arg_53_2)
		arg_53_1 = arg_53_1 + 1
		UIItemList = var_2_10003

		if arg_53_0 == var_2_10003.EventUpdate then
			local var_53_0 = var_52_1[arg_53_1]

			updateDrop = var_2_10004

			var_2_10004(arg_53_2:Find("IconTpl"), var_53_0)
		end

		return
	end)

	pairs = var_3

	for iter_52_0, iter_52_1 in var_3(arg_52_0.operateBtns) do
		setActive = var_1_10008

		var_1_10008(iter_52_1, iter_52_0 == "Confirm" or iter_52_0 == "Cancel")
	end

	setText = var_3

	local var_52_5 = arg_52_0.operateCountdesc

	i18n = var_5

	var_3(var_52_5, var_5("use_amount_prefix"))

	setActive = var_3

	var_3(arg_52_0.keepFateTog, false)

	return
end

function var_0_1.willExit(arg_54_0)
	if arg_54_0.leftEventTrigger then
		ClearEventTrigger = var_1

		var_1(arg_54_0.leftEventTrigger)
	end

	if arg_54_0.rightEventTrigger then
		ClearEventTrigger = var_1

		var_1(arg_54_0.rightEventTrigger)
	end

	arg_54_0:UnOverlayPanel(arg_54_0._tf)

	if arg_54_0.recycleConfirmationPage then
		local var_54_0 = arg_54_0.recycleConfirmationPage

		var_1.Destroy(var_54_0)

		arg_54_0.recycleConfirmationPage = nil
	end

	return
end

function var_0_1.PlayOpenBox(arg_55_0, arg_55_1, arg_55_2)
	if not arg_55_1 or arg_55_1 == "" then
		arg_55_2()

		return
	end

	local var_55_0 = {}
	local var_55_1 = arg_55_0._tf

	if var_4.Find(var_55_1, arg_55_1 .. "(Clone)") then
		go = var_55_1
		arg_55_0[arg_55_1] = var_55_1(var_4)
	end

	if not arg_55_0[arg_55_1] then
		table = var_5

		var_5.insert(var_55_0, function(arg_56_0)
			PoolMgr = var_2_10001

			local var_56_0 = var_2_10001.GetInstance()
			local var_56_1 = var_1.GetPrefab
			local var_56_2 = "ui/"

			string = var_2_10004

			var_56_1(var_56_0, var_56_2 .. var_2_10004.lower(arg_55_1), "", true, function(arg_57_0)
				arg_57_0:SetActive(true)

				arg_55_0[arg_55_1] = arg_57_0

				arg_56_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_55_0, function()
		if arg_55_0.playing or not arg_55_0[arg_55_1] then
			return
		end

		arg_55_0.playing = true

		local var_58_0 = arg_55_0[arg_55_1]

		var_0.SetActive(var_58_0, true)

		SetActive = var_0

		var_0(arg_55_0.window, false)

		tf = var_0

		local var_58_1 = var_0(arg_55_0[arg_55_1])

		var_0.SetParent(var_58_1, arg_55_0._tf, false)
		var_0:SetAsLastSibling()

		local var_58_2 = var_0:GetComponent("DftAniEvent")

		var_1.SetTriggerEvent(var_58_2, function(arg_59_0)
			arg_55_2()

			return
		end)
		var_1:SetEndEvent(function(arg_60_0)
			if arg_55_0[arg_55_1] then
				SetActive = var_1

				var_1(arg_55_0[arg_55_1], false)

				arg_55_0.playing = false
			end

			local var_60_0 = arg_55_0

			var_1.closeView(var_60_0)

			return
		end)

		pg = var_2

		local var_58_3 = var_2.CriMgr.GetInstance()
		local var_58_4 = var_2.PlaySoundEffect_V3

		SFX_UI_EQUIPMENT_OPEN = var_4

		var_58_4(var_58_3, var_4)

		return
	end)

	return
end

function var_0_1.inOutAnim(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_1 then
		local var_61_0 = arg_61_0._tf
		local var_61_1 = var_3.Find(var_61_0, "window/bg_decorations")
		local var_61_2 = var_3.GetComponent

		typeof = var_1_10006
		Animation = var_1_10007

		local var_61_3 = var_61_2(var_61_1, var_1_10006(var_1_10007))

		var_4.Stop(var_61_3)
		var_4:Play("anim_window_bg")

		local var_61_4 = arg_61_0._tf
		local var_61_5 = var_5.Find(var_61_4, "window/top")
		local var_61_6 = var_5.GetComponent

		typeof = var_1_10008
		Animation = var_1_10009

		local var_61_7 = var_61_6(var_61_5, var_1_10008(var_1_10009))

		var_6.Stop(var_61_7)
		var_6:Play("anim_top")

		local var_61_8 = arg_61_0._tf
		local var_61_9 = var_7.Find(var_61_8, "window")
		local var_61_10 = var_7.GetComponent

		typeof = var_1_10010
		Animation = var_1_10011

		local var_61_11 = var_61_10(var_61_9, var_1_10010(var_1_10011))

		var_8.Stop(var_61_11)
		var_8:Play("anim_content")

		local var_61_12 = arg_61_0._tf
		local var_61_13 = var_9.Find(var_61_12, "bg")
		local var_61_14 = var_9.GetComponent

		typeof = var_1_10012
		Animation = var_1_10013

		local var_61_15 = var_61_14(var_61_13, var_1_10012(var_1_10013))

		var_10.Stop(var_61_15)
		var_10:Play("anim_bg_plus")
	end

	arg_61_2()

	return
end

return var_0_1
