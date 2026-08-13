class = var_0_10000

local var_0_0 = "ShipMainScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))
local var_0_2 = 0
local var_0_3 = 0.2
local var_0_4 = 0.3
local var_0_5 = 3
local var_0_6 = 0.5
local var_0_7 = 11

function var_0_1.getUIName(arg_1_0)
	return "ShipMainScene"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.preload(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)
	local var_3_1 = var_2.getShipById(var_3_0, arg_3_0.contextData.shipId)

	parallelAsync = var_1_10004

	var_1_10004({
		function(arg_4_0)
			GetSpriteFromAtlasAsync = var_2_10001

			local var_4_0 = "bg/star_level_bg_"
			local var_4_1 = var_3_1

			var_2_10001(var_4_0 .. var_4.rarity2bgPrintForGet(var_4_1), "", arg_4_0)

			return
		end,
		function(arg_5_0)
			if arg_3_0.exited then
				return
			end

			PoolMgr = var_1

			local var_5_0 = var_1.GetInstance()

			var_1.PreloadUI(var_5_0, "ShipDetailView", arg_5_0)

			return
		end
	}, arg_3_1)

	return
end

function var_0_1.setPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1

	local var_6_0 = arg_6_0:GetShareData()

	var_2.SetPlayer(var_6_0, arg_6_1)

	return
end

function var_0_1.setShipList(arg_7_0, arg_7_1)
	arg_7_0.shipList = arg_7_1

	return
end

function var_0_1.setShip(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetShareData()

	var_2.SetShipVO(var_8_0, arg_8_1)

	local var_8_1 = false

	if arg_8_0.shipVO and arg_8_0.shipVO.id ~= arg_8_1.id then
		arg_8_0:StopPreVoice()

		var_8_1 = true
	end

	arg_8_0.shipVO = arg_8_1
	setActive = var_3

	var_3(arg_8_0.npcFlagTF, arg_8_1:isActivityNpc())
	arg_8_0:setToggleEnable()

	pg = var_3

	local var_8_2 = var_3.ship_skin_template
	local var_8_3 = arg_8_0.shipVO
	local var_8_4

	if var_8_2[var_4.getSkinId(var_8_3)].rarity_bg then
		var_8_4 = var_3.rarity_bg ~= ""
	end

	arg_8_0.isSpBg = var_8_4

	arg_8_0:updatePreference(arg_8_1)

	local var_8_5 = arg_8_0.shipDetailView

	var_4.ActionInvokeExclusive(var_8_5, "UpdateUI")

	local var_8_6 = arg_8_0.shipFashionView

	var_4.ActionInvokeExclusive(var_8_6, "UpdateUI")

	local var_8_7 = arg_8_0.shipEquipView

	var_4.ActionInvokeExclusive(var_8_7, "UpdateUI")

	if var_8_1 then
		local var_8_8 = arg_8_0
		local var_8_9 = arg_8_0.checkToggleActive

		ShipViewConst = var_7

		if not var_8_9(var_8_8, var_7.currentPage) then
			triggerToggle = var_4

			var_4(arg_8_0.detailToggle, true)
		end
	end

	return
end

function var_0_1.equipmentChange(arg_9_0)
	if arg_9_0.shipDetailView then
		local var_9_0 = arg_9_0.shipDetailView

		var_1.ActionInvoke(var_9_0, "UpdateUI")
	end

	return
end

function var_0_1.setToggleEnable(arg_10_0)
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.togglesList) do
		setActive = var_1_10006

		var_1_10006(iter_10_1, arg_10_0:checkToggleActive(iter_10_0))
	end

	setActive = var_1

	local var_10_0 = arg_10_0.technologyToggle
	local var_10_1 = arg_10_0.shipVO

	var_1(var_10_0, var_4.isBluePrintShip(var_10_1))

	SetActive = var_1

	local var_10_2 = arg_10_0.metaToggle
	local var_10_3 = arg_10_0.shipVO

	var_1(var_10_2, var_4.isMetaShip(var_10_3))

	return
end

function var_0_1.checkToggleActive(arg_11_0, arg_11_1)
	ShipViewConst = var_1_10002

	if arg_11_1 == var_1_10002.PAGE.DETAIL then
		return true
	else
		ShipViewConst = var_2

		if arg_11_1 == var_2.PAGE.EQUIPMENT then
			return true
		else
			ShipViewConst = var_2

			local var_11_3

			if arg_11_1 == var_2.PAGE.INTENSIFY then
				local var_11_0 = arg_11_0.shipVO

				if not var_11_3.isTestShip(var_11_0) then
					local var_11_1 = arg_11_0.shipVO

					if not var_11_3.isBluePrintShip(var_11_1) then
						local var_11_2 = arg_11_0.shipVO

						var_11_3 = not var_11_3.isMetaShip(var_11_2)

						goto label_11_0
					end
				end

				var_11_3 = false

				if false then
					var_11_3 = true
				end

				::label_11_0::

				return var_11_3
			else
				ShipViewConst = var_11_3

				local var_11_7

				if arg_11_1 == var_11_3.PAGE.UPGRADE then
					local var_11_4 = arg_11_0.shipVO

					if not var_11_7.isTestShip(var_11_4) then
						local var_11_5 = arg_11_0.shipVO

						if not var_11_7.isBluePrintShip(var_11_5) then
							local var_11_6 = arg_11_0.shipVO

							var_11_7 = not var_11_7.isMetaShip(var_11_6)

							goto label_11_1
						end
					end

					var_11_7 = false

					if false then
						var_11_7 = true
					end

					::label_11_1::

					return var_11_7
				else
					ShipViewConst = var_11_7

					local var_11_11

					if arg_11_1 == var_11_7.PAGE.REMOULD then
						local var_11_8 = arg_11_0.shipVO

						if not var_11_11.isTestShip(var_11_8) then
							local var_11_9 = arg_11_0.shipVO

							if not var_11_11.isBluePrintShip(var_11_9) then
								pg = var_11_11

								if var_11_11.ship_data_trans[arg_11_0.shipVO.groupId] then
									local var_11_10 = arg_11_0.shipVO

									var_11_11 = not var_11_11.isMetaShip(var_11_10)
								end

								goto label_11_2
							end
						end

						var_11_11 = false

						if false then
							var_11_11 = true
						end

						::label_11_2::

						return var_11_11
					else
						ShipViewConst = var_11_11

						if arg_11_1 == var_11_11.PAGE.FASHION then
							local var_11_12 = arg_11_0

							if not arg_11_0.hasFashion(var_11_12) then
								return false
							else
								local var_11_13

								PaintingGroupConst = var_11_12

								if not var_11_12.IsPaintingNeedCheck() then
									var_11_13 = false
								else
									PaintingGroupConst = var_4

									local var_11_14 = var_4.GetPaintingNameListByShipVO(arg_11_0.shipVO)

									PaintingGroupConst = var_1_10005
									var_11_13 = var_1_10005.CalcPaintingListSize(var_11_14) > 0
								end

								return not var_11_13
							end
						else
							return false
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.setSkinList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.shipFashionView

	var_2.ActionInvoke(var_12_0, "SetSkinList", arg_12_1)

	return
end

function var_0_1.updateLock(arg_13_0)
	local var_13_0 = arg_13_0.shipDetailView

	var_1.ActionInvoke(var_13_0, "UpdateLock")

	return
end

function var_0_1.updatePreferenceTag(arg_14_0)
	local var_14_0 = arg_14_0.shipDetailView

	var_1.ActionInvoke(var_14_0, "UpdatePreferenceTag")

	return
end

function var_0_1.updateFashionTag(arg_15_0)
	local var_15_0 = arg_15_0.shipDetailView

	var_1.ActionInvoke(var_15_0, "UpdateFashionTag")

	return
end

function var_0_1.closeRecordPanel(arg_16_0)
	local var_16_0 = arg_16_0.shipDetailView

	var_1.ActionInvoke(var_16_0, "CloseRecordPanel")

	return
end

function var_0_1.updateRecordEquipments(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.shipDetailView

	var_2.UpdateRecordEquipments(var_17_0, arg_17_1)

	local var_17_1 = arg_17_0.shipDetailView

	var_2.UpdateRecordSpWeapons(var_17_1, arg_17_1)

	return
end

function var_0_1.setModPanel(arg_18_0, arg_18_1)
	arg_18_0.modPanel = arg_18_1

	return
end

function var_0_1.setMaxLevelHelpFlag(arg_19_0, arg_19_1)
	arg_19_0.maxLevelHelpFlag = arg_19_1

	return
end

function var_0_1.checkMaxLevelHelp(arg_20_0)
	if not arg_20_0.maxLevelHelpFlag and arg_20_0.shipVO then
		local var_20_0 = arg_20_0.shipVO

		if var_1.isReachNextMaxLevel(var_20_0) then
			local var_20_1 = arg_20_0

			arg_20_0.openHelpPage(var_20_1)

			arg_20_0.maxLevelHelpFlag = true
			getProxy = var_1
			SettingsProxy = var_20_1

			local var_20_2 = var_1(var_20_1)

			var_1.setMaxLevelHelp(var_20_2, true)
		end
	end

	return
end

function var_0_1.GetShareData(arg_21_0)
	if not arg_21_0.shareData then
		ShipViewShareData = var_1
		arg_21_0.shareData = var_1.New(arg_21_0.contextData)

		local var_21_0 = arg_21_0.shipDetailView

		var_1.SetShareData(var_21_0, arg_21_0.shareData)

		local var_21_1 = arg_21_0.shipFashionView

		var_1.SetShareData(var_21_1, arg_21_0.shareData)

		local var_21_2 = arg_21_0.shipEquipView

		var_1.SetShareData(var_21_2, arg_21_0.shareData)

		local var_21_3 = arg_21_0.shipEquipView

		var_1.ActionInvoke(var_21_3, "InitEvent")

		local var_21_4 = arg_21_0.shipHuntingRangeView

		var_1.SetShareData(var_21_4, arg_21_0.shareData)

		local var_21_5 = arg_21_0.shipCustomMsgBox

		var_1.SetShareData(var_21_5, arg_21_0.shareData)

		local var_21_6 = arg_21_0.shipChangeNameView

		var_1.SetShareData(var_21_6, arg_21_0.shareData)
	end

	return arg_21_0.shareData
end

function var_0_1.hasFashion(arg_22_0)
	local var_22_0 = arg_22_0.shareData

	return var_1.HasFashion(var_22_0)
end

function var_0_1.DisplayRenamePanel(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.shipChangeNameView

	var_2.Load(var_23_0)

	local var_23_1 = arg_23_0.shipChangeNameView

	var_2.ActionInvoke(var_23_1, "DisplayRenamePanel", arg_23_1)

	return
end

function var_0_1.init(arg_24_0)
	arg_24_0:initShip()
	arg_24_0:initPages()
	arg_24_0:initEvents()

	local var_24_0 = arg_24_0._tf
	local var_24_1 = var_1.GetComponent

	typeof = var_1_10004
	CanvasGroup = var_1_10006
	arg_24_0.mainCanvasGroup = var_24_1(var_24_0, var_1_10004(var_1_10006))

	local var_24_2 = arg_24_0._tf
	local var_24_3 = var_1.Find(var_24_2, "blur_panel/adapt")
	local var_24_4 = var_1.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_24_0.commonCanvasGroup = var_24_4(var_24_3, var_4(var_1_10006))
	Input = var_1
	var_1.multiTouchEnabled = false

	return
end

function var_0_1.initShip(arg_25_0)
	local var_25_0 = arg_25_0._tf

	arg_25_0.shipInfo = var_1.Find(var_25_0, "main/character")
	setActive = var_1

	var_1(arg_25_0.shipInfo, true)

	local var_25_1 = {}
	local var_25_2 = arg_25_0.shipInfo

	var_25_1[1] = var_2.Find(var_25_2, "painting")

	local var_25_3 = arg_25_0.shipInfo

	var_25_1[2] = var_2.Find(var_25_3, "painting2")
	arg_25_0.tablePainting = var_25_1
	arg_25_0.nowPainting = nil
	arg_25_0.isRight = true

	local var_25_4 = arg_25_0._tf

	arg_25_0.blurPanel = var_1.Find(var_25_4, "blur_panel")

	local var_25_5 = arg_25_0.blurPanel

	arg_25_0.common = var_1.Find(var_25_5, "adapt")

	local var_25_6 = arg_25_0.common

	arg_25_0.npcFlagTF = var_1.Find(var_25_6, "name/npc")

	local var_25_7 = arg_25_0.common

	arg_25_0.shipName = var_1.Find(var_25_7, "name")

	local var_25_8 = arg_25_0.shipName

	arg_25_0.shipInfoStarTpl = var_1.Find(var_25_8, "star_tpl")

	local var_25_9 = arg_25_0.shipName

	arg_25_0.nameEditFlag = var_1.Find(var_25_9, "nameRect/editFlag")
	setActive = var_1

	var_1(arg_25_0.shipName, true)

	setActive = var_1

	var_1(arg_25_0.shipInfoStarTpl, false)

	setActive = var_1

	var_1(arg_25_0.nameEditFlag, false)

	local var_25_10 = arg_25_0.shipName

	arg_25_0.energyTF = var_1.Find(var_25_10, "energy")

	local var_25_11 = arg_25_0.energyTF

	arg_25_0.energyDescTF = var_1.Find(var_25_11, "desc")

	local var_25_12 = arg_25_0.energyTF

	arg_25_0.energyText = var_1.Find(var_25_12, "desc/desc")
	setActive = var_1

	var_1(arg_25_0.energyDescTF, false)

	local var_25_13 = arg_25_0._tf

	arg_25_0.character = var_1.Find(var_25_13, "main/character")

	local var_25_14 = arg_25_0._tf

	arg_25_0.chat = var_1.Find(var_25_14, "main/character/chat")

	local var_25_15 = arg_25_0._tf

	arg_25_0.chatBg = var_1.Find(var_25_15, "main/character/chat/chatbgtop")

	local var_25_16 = arg_25_0.chat

	arg_25_0.chatText = var_1.Find(var_25_16, "Text")
	rtf = var_1

	local var_25_17 = var_1(arg_25_0.chat)

	Vector3 = var_2
	var_25_17.localScale = var_2.New(0, 0, 1)
	arg_25_0.initChatBgH = arg_25_0.chatBg.sizeDelta.y
	arg_25_0.initChatTextH = arg_25_0.chatText.sizeDelta.y

	local var_25_18 = arg_25_0.chatText
	local var_25_19 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_25_0.initfontSize = var_25_19(var_25_18, var_4(var_6)).fontSize

	return
end

function var_0_1.initPages(arg_26_0)
	ShipViewConst = var_1_10001
	var_1_10001.currentPage = nil

	local var_26_0 = arg_26_0._tf

	arg_26_0.background = var_1.Find(var_26_0, "background")
	setActive = var_1

	var_1(arg_26_0.background, true)

	local var_26_1 = arg_26_0._tf

	arg_26_0.main = var_1.Find(var_26_1, "main")

	local var_26_2 = arg_26_0.main
	local var_26_3 = var_1.GetComponent

	typeof = var_4
	RectMask2D = var_1_10006
	arg_26_0.mainMask = var_26_3(var_26_2, var_4(var_1_10006))

	local var_26_4 = arg_26_0.common

	arg_26_0.toggles = var_1.Find(var_26_4, "left_length/frame/root")

	local var_26_5 = arg_26_0.toggles

	arg_26_0.detailToggle = var_1.Find(var_26_5, "detail_toggle")

	local var_26_6 = arg_26_0.toggles

	arg_26_0.equipmentToggle = var_1.Find(var_26_6, "equpiment_toggle")

	local var_26_7 = arg_26_0.toggles

	arg_26_0.intensifyToggle = var_1.Find(var_26_7, "intensify_toggle")

	local var_26_8 = arg_26_0.toggles

	arg_26_0.upgradeToggle = var_1.Find(var_26_8, "upgrade_toggle")

	local var_26_9 = arg_26_0.toggles

	arg_26_0.remouldToggle = var_1.Find(var_26_9, "remould_toggle")

	local var_26_10 = arg_26_0.toggles

	arg_26_0.technologyToggle = var_1.Find(var_26_10, "technology_toggle")

	local var_26_11 = arg_26_0.toggles

	arg_26_0.metaToggle = var_1.Find(var_26_11, "meta_toggle")
	arg_26_0.togglesList = {}

	local var_26_12 = arg_26_0.togglesList

	ShipViewConst = var_2
	var_26_12[var_2.PAGE.DETAIL] = arg_26_0.detailToggle

	local var_26_13 = arg_26_0.togglesList

	ShipViewConst = var_2
	var_26_13[var_2.PAGE.EQUIPMENT] = arg_26_0.equipmentToggle

	local var_26_14 = arg_26_0.togglesList

	ShipViewConst = var_2
	var_26_14[var_2.PAGE.INTENSIFY] = arg_26_0.intensifyToggle

	local var_26_15 = arg_26_0.togglesList

	ShipViewConst = var_2
	var_26_15[var_2.PAGE.UPGRADE] = arg_26_0.upgradeToggle

	local var_26_16 = arg_26_0.togglesList

	ShipViewConst = var_2
	var_26_16[var_2.PAGE.REMOULD] = arg_26_0.remouldToggle

	local var_26_17 = arg_26_0.main

	arg_26_0.detailContainer = var_1.Find(var_26_17, "detail_container")
	setAnchoredPosition = var_1

	var_1(arg_26_0.detailContainer, {
		x = 1300
	})

	local var_26_18 = arg_26_0.main

	arg_26_0.fashionContainer = var_1.Find(var_26_18, "fashion_container")
	setAnchoredPosition = var_1

	var_1(arg_26_0.fashionContainer, {
		x = 900
	})

	local var_26_19 = arg_26_0.main

	arg_26_0.equipContainer = var_1.Find(var_26_19, "equip_container")

	local var_26_20 = arg_26_0.equipContainer

	arg_26_0.equipLCon = var_1.Find(var_26_20, "equipment_l_container")

	local var_26_21 = arg_26_0.equipContainer

	arg_26_0.equipRCon = var_1.Find(var_26_21, "equipment_r_container")

	local var_26_22 = arg_26_0.equipContainer

	arg_26_0.equipBCon = var_1.Find(var_26_22, "equipment_b_container")
	setAnchoredPosition = var_1

	var_1(arg_26_0.equipRCon, {
		x = 750
	})

	setAnchoredPosition = var_1

	var_1(arg_26_0.equipLCon, {
		x = -700
	})

	setAnchoredPosition = var_1

	var_1(arg_26_0.equipBCon, {
		y = -540
	})

	ShipDetailView = var_1
	arg_26_0.shipDetailView = var_1.New(arg_26_0.detailContainer, arg_26_0.event, arg_26_0.contextData)
	ShipFashionView = var_1
	arg_26_0.shipFashionView = var_1.New(arg_26_0.fashionContainer, arg_26_0.event, arg_26_0.contextData)
	ShipEquipView = var_1
	arg_26_0.shipEquipView = var_1.New(arg_26_0.equipContainer, arg_26_0.event, arg_26_0.contextData)
	ShipHuntingRangeView = var_1
	arg_26_0.shipHuntingRangeView = var_1.New(arg_26_0._tf, arg_26_0.event, arg_26_0.contextData)
	ShipCustomMsgBox = var_1
	arg_26_0.shipCustomMsgBox = var_1.New(arg_26_0._tf, arg_26_0.event, arg_26_0.contextData)
	ShipChangeNameView = var_1
	arg_26_0.shipChangeNameView = var_1.New(arg_26_0._tf, arg_26_0.event, arg_26_0.contextData)
	ShipExpItemUsagePage = var_1
	arg_26_0.expItemUsagePage = var_1.New(arg_26_0._tf, arg_26_0.event, arg_26_0.contextData)
	ipairs = var_1

	for iter_26_0, iter_26_1 in var_1({
		arg_26_0.shipDetailView,
		arg_26_0.shipFashionView,
		arg_26_0.shipEquipView,
		arg_26_0.shipHuntingRangeView,
		arg_26_0.shipCustomMsgBox,
		arg_26_0.shipChangeNameView,
		arg_26_0.expItemUsagePage
	}) do
		iter_26_1:RegisterView(arg_26_0)
	end

	arg_26_0.viewList = {}

	local var_26_23 = arg_26_0.viewList

	ShipViewConst = var_2
	var_26_23[var_2.PAGE.DETAIL] = arg_26_0.shipDetailView

	local var_26_24 = arg_26_0.viewList

	ShipViewConst = var_2
	var_26_24[var_2.PAGE.FASHION] = arg_26_0.shipFashionView

	local var_26_25 = arg_26_0.viewList

	ShipViewConst = var_2
	var_26_25[var_2.PAGE.EQUIPMENT] = arg_26_0.shipEquipView
	onButton = var_26_25

	local var_26_26 = arg_26_0
	local var_26_27 = arg_26_0.shipName

	local function var_26_28()
		if arg_26_0.shipVO.propose then
			local var_27_0 = arg_26_0.shipVO

			if not var_0.IsXIdol(var_27_0) then
				pg = var_0

				local var_27_1 = var_0.PushNotificationMgr.GetInstance()

				if not var_0.isEnableShipName(var_27_1) then
					pg = var_0

					local var_27_2 = var_0.TipsMgr.GetInstance()
					local var_27_3 = var_0.ShowTips

					i18n = var_2_10003

					var_27_3(var_27_2, var_2_10003("word_rename_switch_tip"))

					return
				end

				local var_27_4 = arg_26_0.shipVO.renameTime + 0

				pg = var_2_10001

				local var_27_5 = var_2_10001.TimeMgr.GetInstance()
				local var_27_6 = var_27_4 - var_1.GetServerTime(var_27_5)

				if 0 < var_27_6 then
					math = var_1

					local var_27_7

					if var_1.floor(var_27_6 / 60 / 60 / 24) < 1 then
						var_27_7 = 1
					end

					pg = var_2

					local var_27_8 = var_2.TipsMgr.GetInstance()
					local var_27_9 = var_2.ShowTips

					i18n = var_2_10005

					var_27_9(var_27_8, var_2_10005("word_rename_time_tip", var_27_7))
				else
					local var_27_10 = arg_26_0

					var_1.DisplayRenamePanel(var_27_10, true)
				end
			end
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_26_25(var_26_26, var_26_27, var_26_28, var_1_10006)

	return
end

function var_0_1.initEvents(arg_28_0)
	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.bind

	ShipViewConst = var_1_10004

	var_28_1(var_28_0, var_1_10004.SWITCH_TO_PAGE, function(arg_29_0, arg_29_1)
		local var_29_0 = arg_28_0

		var_2.gotoPage(var_29_0, arg_29_1)

		return
	end)

	local var_28_2 = arg_28_0
	local var_28_3 = arg_28_0.bind

	ShipViewConst = var_4

	var_28_3(var_28_2, var_4.LOAD_PAINTING, function(arg_30_0, arg_30_1, arg_30_2)
		local var_30_0 = arg_28_0

		var_3.loadPainting(var_30_0, arg_30_1, arg_30_2)

		return
	end)

	local var_28_4 = arg_28_0
	local var_28_5 = arg_28_0.bind

	ShipViewConst = var_4

	var_28_5(var_28_4, var_4.LOAD_PAINTING_BG, function(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
		local var_31_0 = arg_28_0

		var_4.loadSkinBg(var_31_0, arg_31_1, arg_31_2, arg_31_3, arg_28_0.isSpBg)

		return
	end)

	local var_28_6 = arg_28_0
	local var_28_7 = arg_28_0.bind

	ShipViewConst = var_4

	var_28_7(var_28_6, var_4.HIDE_SHIP_WORD, function(arg_32_0)
		local var_32_0 = arg_28_0

		var_1.hideShipWord(var_32_0)

		return
	end)

	local var_28_8 = arg_28_0
	local var_28_9 = arg_28_0.bind

	ShipViewConst = var_4

	var_28_9(var_28_8, var_4.SET_CLICK_ENABLE, function(arg_33_0, arg_33_1)
		arg_28_0.mainCanvasGroup.blocksRaycasts = arg_33_1

		local var_33_0 = arg_28_0.commonCanvasGroup

		var_33_0.blocksRaycasts = arg_33_1
		GetOrAddComponent = var_33_0
		var_33_0(arg_28_0.detailContainer, "CanvasGroup").blocksRaycasts = arg_33_1

		return
	end)

	local var_28_10 = arg_28_0
	local var_28_11 = arg_28_0.bind

	ShipViewConst = var_4

	var_28_11(var_28_10, var_4.SHOW_CUSTOM_MSG, function(arg_34_0, arg_34_1)
		local var_34_0 = arg_28_0.shipCustomMsgBox

		var_2.Load(var_34_0)

		local var_34_1 = arg_28_0.shipCustomMsgBox

		var_2.ActionInvoke(var_34_1, "showCustomMsgBox", arg_34_1)

		return
	end)

	local var_28_12 = arg_28_0
	local var_28_13 = arg_28_0.bind

	ShipViewConst = var_4

	var_28_13(var_28_12, var_4.HIDE_CUSTOM_MSG, function(arg_35_0)
		local var_35_0 = arg_28_0.shipCustomMsgBox

		var_1.ActionInvoke(var_35_0, "hideCustomMsgBox")

		return
	end)

	local var_28_14 = arg_28_0
	local var_28_15 = arg_28_0.bind

	ShipViewConst = var_4

	var_28_15(var_28_14, var_4.DISPLAY_HUNTING_RANGE, function(arg_36_0, arg_36_1)
		if arg_36_1 then
			local var_36_0 = arg_28_0.shipHuntingRangeView

			var_2.Load(var_36_0)

			local var_36_1 = arg_28_0.shipHuntingRangeView

			var_2.ActionInvoke(var_36_1, "DisplayHuntingRange")
		else
			local var_36_2 = arg_28_0.shipHuntingRangeView

			var_2.HideHuntingRange(var_36_2)
		end

		return
	end)

	local var_28_16 = arg_28_0
	local var_28_17 = arg_28_0.bind

	ShipViewConst = var_4

	var_28_17(var_28_16, var_4.PAINT_VIEW, function(arg_37_0, arg_37_1)
		if arg_37_1 then
			local var_37_0 = arg_28_0

			var_2.paintView(var_37_0)
		else
			local var_37_1 = arg_28_0

			var_2.hidePaintView(var_37_1, true)
		end

		return
	end)

	local var_28_18 = arg_28_0
	local var_28_19 = arg_28_0.bind

	ShipViewConst = var_4

	var_28_19(var_28_18, var_4.SHOW_EXP_ITEM_USAGE, function(arg_38_0, arg_38_1)
		local var_38_0 = arg_28_0.expItemUsagePage

		var_2.ExecuteAction(var_38_0, "Show", arg_38_1)

		return
	end)

	return
end

function var_0_1.didEnter(arg_39_0)
	arg_39_0:addRingDragListenter()

	onButton = var_1

	local var_39_0 = arg_39_0
	local var_39_1 = arg_39_0.common
	local var_39_2 = var_4.Find(var_39_1, "top/back_btn")

	local function var_39_3()
		GetOrAddComponent = var_2_10000

		local var_40_0 = arg_39_0._tf

		typeof = var_2_10003
		CanvasGroup = var_2_10005
		var_2_10000(var_40_0, var_2_10003(var_2_10005)).interactable = false

		if not arg_39_0.everTriggerBack then
			LeanTween = var_1

			local var_40_1 = var_1.delayedCall
			local var_40_2 = 0.3

			System = var_2_10004

			var_40_1(var_40_2, var_2_10004.Action(function()
				local var_41_0 = arg_39_0

				var_0.closeView(var_41_0)

				return
			end))

			arg_39_0.everTriggerBack = true
		end

		return
	end

	SFX_CANCEL = var_39_1

	var_1(var_39_0, var_39_2, var_39_3, var_39_1)

	onButton = var_1

	local var_39_4 = arg_39_0
	local var_39_5 = arg_39_0.npcFlagTF

	local function var_39_6()
		pg = var_2_10000

		local var_42_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_42_1 = var_0.ShowMsgBox
		local var_42_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_42_2.type = var_2_10004
		pg = var_2_10004
		var_42_2.helps = var_2_10004.gametip.help_shipinfo_actnpc.tip

		var_42_1(var_42_0, var_42_2)

		return
	end

	SFX_PANEL = var_39_1

	var_1(var_39_4, var_39_5, var_39_6, var_39_1)

	local var_39_7 = arg_39_0.common

	arg_39_0.helpBtn = var_1.Find(var_39_7, "help_btn")
	onButton = var_1

	local var_39_8 = arg_39_0
	local var_39_9 = arg_39_0.helpBtn

	local function var_39_10()
		local var_43_0 = arg_39_0
		local var_43_1 = var_0.openHelpPage

		ShipViewConst = var_2_10003

		var_43_1(var_43_0, var_2_10003.currentPage)

		return
	end

	SFX_PANEL = var_39_1

	var_1(var_39_8, var_39_9, var_39_10, var_39_1)

	pairs = var_1

	for iter_39_0, iter_39_1 in var_1(arg_39_0.togglesList) do
		if iter_39_1 == arg_39_0.upgradeToggle or iter_39_1 == arg_39_0.remouldToggle or iter_39_1 == arg_39_0.equipmentToggle then
			onToggle = var_39_1

			local var_39_11 = arg_39_0
			local var_39_12 = iter_39_1

			local function var_39_13(arg_44_0)
				if arg_44_0 then
					LeanTween = var_2_10001

					local var_44_0 = var_2_10001.isTweening

					go = var_2_10003

					local var_44_1

					if var_44_0(var_2_10003(arg_39_0.chat)) then
						LeanTween = var_44_1
						var_44_1 = var_44_1.cancel
						go = var_3

						var_44_1(var_3(arg_39_0.chat))
					end

					rtf = var_44_1

					local var_44_2 = var_44_1(arg_39_0.chat)

					Vector3 = var_2_10002
					var_44_2.localScale = var_2_10002.New(0, 0, 1)
					arg_39_0.chatFlag = false

					local var_44_3 = arg_39_0

					var_1.switchToPage(var_44_3, iter_39_0)
				end

				return
			end

			SFX_PANEL = var_1_10011

			var_39_1(var_39_11, var_39_12, var_39_13, var_1_10011)
		else
			onToggle = var_39_1

			local var_39_14 = arg_39_0
			local var_39_15 = iter_39_1

			local function var_39_16(arg_45_0)
				if arg_45_0 then
					local var_45_0 = arg_39_0

					var_1.switchToPage(var_45_0, iter_39_0)
				end

				return
			end

			SFX_PANEL = var_1_10011

			var_39_1(var_39_14, var_39_15, var_39_16, var_1_10011)
		end
	end

	onButton = var_1

	local var_39_17 = arg_39_0
	local var_39_18 = arg_39_0.technologyToggle

	local function var_39_19()
		local var_46_0 = arg_39_0
		local var_46_1 = var_0.emit

		ShipMainMediator = var_2_10003

		var_46_1(var_46_0, var_2_10003.ON_TECHNOLOGY, arg_39_0.shipVO)

		return
	end

	SFX_PANEL = var_39_1

	var_1(var_39_17, var_39_18, var_39_19, var_39_1)

	onButton = var_1

	local var_39_20 = arg_39_0
	local var_39_21 = arg_39_0.metaToggle

	local function var_39_22()
		local var_47_0 = arg_39_0
		local var_47_1 = var_0.emit

		ShipMainMediator = var_2_10003

		var_47_1(var_47_0, var_2_10003.ON_META, arg_39_0.shipVO)

		return
	end

	SFX_PANEL = var_39_1

	var_1(var_39_20, var_39_21, var_39_22, var_39_1)

	onButton = var_1

	local var_39_23 = arg_39_0

	tf = var_39_21

	var_1(var_39_23, var_39_21(arg_39_0.character), function()
		ShipViewConst = var_2_10000

		local var_48_0 = var_2_10000.currentPage

		ShipViewConst = var_2_10001

		if var_48_0 ~= var_2_10001.PAGE.FASHION then
			local var_48_1 = arg_39_0

			var_0.displayShipWord(var_48_1, "detail")
		end

		return
	end)

	onButton = var_1

	var_1(arg_39_0, arg_39_0.energyTF, function()
		local var_49_0 = arg_39_0

		var_0.showEnergyDesc(var_49_0)

		getProxy = var_0
		CommanderManualProxy = var_49_0

		local var_49_1 = var_0(var_49_0)

		var_0.TaskProgressAdd(var_49_1, 2022, 1)

		return
	end)
	arg_39_0:OverlayPanel(arg_39_0.chat, {
		groupDelta = 1
	})
	arg_39_0:OverlayPanel(arg_39_0.blurPanel)

	local var_39_24 = arg_39_0
	local var_39_25

	if not arg_39_0.checkToggleActive(var_39_24, arg_39_0.contextData.page) or not arg_39_0.contextData.page then
		ShipViewConst = var_39_25
		var_39_25 = var_39_25.PAGE.DETAIL
	end

	arg_39_0:gotoPage(var_39_25)

	ShipViewConst = var_2

	local var_39_26 = var_2.currentPage

	ShipViewConst = var_39_24

	if var_39_26 ~= var_39_24.PAGE.DETAIL then
		ShipViewConst = var_39_26

		if var_39_25 == var_39_26.PAGE.DETAIL then
			arg_39_0:displayShipWord(arg_39_0:getInitmacyWords())
			arg_39_0:checkMaxLevelHelp()
		end

		arg_39_0:changePaintingSortLayer(true)

		return
	end
end

function var_0_1.openHelpPage(arg_50_0, arg_50_1)
	ShipViewConst = var_1_10002

	local var_50_1

	if arg_50_1 == var_1_10002.PAGE.EQUIPMENT then
		pg = var_50_1

		local var_50_0 = var_50_1.MsgboxMgr.GetInstance()

		var_50_1 = var_50_1.ShowMsgBox

		local var_50_2 = {}

		MSGBOX_TYPE_HELP = var_1_10006
		var_50_2.type = var_1_10006
		pg = var_1_10006
		var_50_2.helps = var_1_10006.gametip.help_shipinfo_equip.tip

		var_50_1(var_50_0, var_50_2)
	else
		ShipViewConst = var_50_1

		local var_50_4

		if arg_50_1 == var_50_1.PAGE.DETAIL then
			pg = var_50_4

			local var_50_3 = var_50_4.MsgboxMgr.GetInstance()

			var_50_4 = var_50_4.ShowMsgBox

			local var_50_5 = {}

			MSGBOX_TYPE_HELP = var_1_10006
			var_50_5.type = var_1_10006
			pg = var_1_10006
			var_50_5.helps = var_1_10006.gametip.help_shipinfo_detail.tip

			var_50_4(var_50_3, var_50_5)
		else
			ShipViewConst = var_50_4

			local var_50_7

			if arg_50_1 == var_50_4.PAGE.INTENSIFY then
				pg = var_50_7

				local var_50_6 = var_50_7.MsgboxMgr.GetInstance()

				var_50_7 = var_50_7.ShowMsgBox

				local var_50_8 = {}

				MSGBOX_TYPE_HELP = var_1_10006
				var_50_8.type = var_1_10006
				pg = var_1_10006
				var_50_8.helps = var_1_10006.gametip.help_shipinfo_intensify.tip

				var_50_7(var_50_6, var_50_8)
			else
				ShipViewConst = var_50_7

				local var_50_10

				if arg_50_1 == var_50_7.PAGE.UPGRADE then
					pg = var_50_10

					local var_50_9 = var_50_10.MsgboxMgr.GetInstance()

					var_50_10 = var_50_10.ShowMsgBox

					local var_50_11 = {}

					MSGBOX_TYPE_HELP = var_1_10006
					var_50_11.type = var_1_10006
					pg = var_1_10006
					var_50_11.helps = var_1_10006.gametip.help_shipinfo_upgrate.tip

					var_50_10(var_50_9, var_50_11)
				else
					ShipViewConst = var_50_10

					local var_50_13

					if arg_50_1 == var_50_10.PAGE.FASHION then
						pg = var_50_13

						local var_50_12 = var_50_13.MsgboxMgr.GetInstance()

						var_50_13 = var_50_13.ShowMsgBox

						local var_50_14 = {}

						MSGBOX_TYPE_HELP = var_1_10006
						var_50_14.type = var_1_10006
						pg = var_1_10006
						var_50_14.helps = var_1_10006.gametip.help_shipinfo_fashion.tip

						var_50_13(var_50_12, var_50_14)
					else
						pg = var_50_13

						local var_50_15 = var_50_13.MsgboxMgr.GetInstance()
						local var_50_16 = var_2.ShowMsgBox
						local var_50_17 = {}

						MSGBOX_TYPE_HELP = var_1_10006
						var_50_17.type = var_1_10006
						pg = var_1_10006
						var_50_17.helps = var_1_10006.gametip.help_shipinfo_maxlevel.tip

						var_50_16(var_50_15, var_50_17)
					end
				end
			end
		end
	end

	return
end

function var_0_1.showAwakenCompleteAni(arg_51_0, arg_51_1)
	local function var_51_0()
		local var_52_0 = arg_51_0.awakenAni

		var_0.SetActive(var_52_0, true)

		local var_52_1 = arg_51_0

		var_52_1.awakenPlay = true
		onButton = var_52_1

		var_52_1(arg_51_0, arg_51_0.awakenAni, function()
			local var_53_0 = arg_51_0.awakenAni
			local var_53_1 = var_0.GetComponent(var_53_0, "Animator")

			var_0.SetBool(var_53_1, "endFlag", true)

			return
		end)

		tf = var_52_1

		local var_52_2 = var_52_1(arg_51_0.awakenAni)

		pg = var_1

		local var_52_3 = var_1.UIMgr.GetInstance()

		var_1.BlurPanel(var_52_3, var_52_2)

		setText = var_1

		var_1(var_52_2:Find("window/desc"), arg_51_1)

		local var_52_4 = var_52_2:GetComponent("DftAniEvent")

		var_1.SetEndEvent(var_52_4, function(arg_54_0)
			local var_54_0 = arg_51_0.awakenAni
			local var_54_1 = var_1.GetComponent(var_54_0, "Animator")

			var_1.SetBool(var_54_1, "endFlag", false)

			pg = var_1

			local var_54_2 = var_1.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_54_2, var_52_2, arg_51_0.common)

			local var_54_3 = arg_51_0.awakenAni

			var_1.SetActive(var_54_3, false)

			arg_51_0.awakenPlay = false

			return
		end)

		return
	end

	local var_51_1 = arg_51_0._tf

	if var_3.Find(var_51_1, "AwakenCompleteWindows(Clone)") then
		go = var_1_10004
		arg_51_0.awakenAni = var_1_10004(var_3)
	end

	if not arg_51_0.awakenAni then
		PoolMgr = var_4

		local var_51_2 = var_4.GetInstance()

		var_4.GetUI(var_51_2, "AwakenCompleteWindows", true, function(arg_55_0)
			arg_55_0:SetActive(true)

			arg_51_0.awakenAni = arg_55_0

			var_51_0()

			return
		end)
	else
		var_51_0()
	end

	return
end

function var_0_1.updatePreference(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_1
	local var_56_1 = arg_56_1.getConfigTable(var_56_0)
	local var_56_2 = arg_56_0.shipVO
	local var_56_3 = var_3.getName(var_56_2)

	setScrollText = var_56_0

	local var_56_4 = arg_56_0.shipName

	var_56_0(var_6.Find(var_56_4, "nameRect/name_mask/Text"), var_56_3)

	setText = var_56_0

	local var_56_5 = arg_56_0.shipName

	var_56_0(var_6.Find(var_56_5, "english_name"), var_56_1.english_name)

	setActive = var_56_0

	local var_56_6 = arg_56_0.nameEditFlag
	local var_56_7

	if arg_56_1.propose then
		var_56_7 = not arg_56_1:IsXIdol()
	end

	var_56_0(var_56_6, var_56_7)

	GetSpriteFromAtlas = var_56_0

	if not var_56_0("energy", arg_56_1:getEnergyPrint()) then
		warning = var_56_2

		var_56_2("找不到疲劳")
	end

	setImageSprite = var_56_2

	var_56_2(arg_56_0.energyTF, var_4, true)

	setActive = var_56_2

	var_56_2(arg_56_0.energyTF, true)

	local var_56_8 = arg_56_0.shipName
	local var_56_9 = var_5.Find(var_56_8, "stars")

	removeAllChildren = var_6

	var_6(var_56_9)

	local var_56_10 = arg_56_1:getStar()
	local var_56_11 = arg_56_1:getMaxStar()

	for iter_56_0 = 1, var_56_11 do
		cloneTplTo = var_1_10012
		var_1_10012 = var_1_10012(arg_56_0.shipInfoStarTpl, var_56_9, "star_" .. iter_56_0)
		setActive = var_1_10013

		var_1_10013(var_1_10012:Find("star_tpl"), iter_56_0 <= var_56_10)

		setActive = var_1_10013

		var_1_10013(var_1_10012:Find("empty_star_tpl"), true)
	end

	ShipViewConst = var_8

	local var_56_12 = var_8.currentPage

	ShipViewConst = var_9

	if var_56_12 ~= var_9.PAGE.FASHION then
		local var_56_13 = arg_56_0

		var_56_12 = arg_56_0.loadPainting

		local var_56_14 = arg_56_0.shipVO

		var_56_12(var_56_13, var_11.getPainting(var_56_14))

		local var_56_15 = arg_56_0

		var_56_12 = arg_56_0.loadSkinBg

		local var_56_16 = arg_56_0.shipVO
		local var_56_17 = var_11.rarity2bgPrintForGet(var_56_16)
		local var_56_18 = arg_56_0.shipVO
		local var_56_19 = var_12.isBluePrintShip(var_56_18)
		local var_56_20 = arg_56_0.shipVO

		var_56_12(var_56_15, var_56_17, var_56_19, var_13.isMetaShip(var_56_20), arg_56_0.isSpBg)
	end

	GetSpriteFromAtlas = var_56_12

	if not var_56_12("shiptype", arg_56_1:getShipType()) then
		warning = var_9

		var_9("找不到船形, shipConfigId: " .. arg_56_1.configId)
	end

	setImageSprite = var_9

	local var_56_21 = arg_56_0.shipName

	var_9(var_11.Find(var_56_21, "type"), var_8, true)

	return
end

function var_0_1.doUpgradeMaxLeveAnim(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	arg_57_0.inUpgradeAnim = true

	local var_57_0 = arg_57_0.shipDetailView

	var_4.DoLeveUpAnim(var_57_0, arg_57_1, arg_57_2, function()
		if arg_57_3 then
			arg_57_3()
		end

		arg_57_0.inUpgradeAnim = nil

		return
	end)

	return
end

function var_0_1.addRingDragListenter(arg_59_0)
	GetOrAddComponent = var_1_10001

	local var_59_0 = var_1_10001(arg_59_0._tf, "EventTriggerListener")
	local var_59_1
	local var_59_2 = 0
	local var_59_3

	var_59_0:AddBeginDragFunc(function()
		var_59_2 = 0
		var_59_1 = nil

		return
	end)
	var_59_0:AddDragFunc(function(arg_61_0, arg_61_1)
		if not arg_59_0.inPaintingView then
			local var_61_0 = arg_61_1.position

			if not var_59_1 then
				var_59_1 = var_61_0
			end

			var_59_2 = var_61_0.x - var_59_1.x
		end

		return
	end)
	var_59_0:AddDragEndFunc(function(arg_62_0, arg_62_1)
		if not arg_59_0.inPaintingView then
			if var_59_2 < -50 then
				if not arg_59_0.isLoading then
					local var_62_0 = arg_59_0
					local var_62_1 = var_2.emit

					ShipMainMediator = var_2_10005

					var_62_1(var_62_0, var_2_10005.NEXTSHIP, -1)
				end
			elseif var_59_2 > 50 and not arg_59_0.isLoading then
				local var_62_2 = arg_59_0
				local var_62_3 = var_2.emit

				ShipMainMediator = var_2_10005

				var_62_3(var_62_2, var_2_10005.NEXTSHIP)
			end
		end

		return
	end)

	return
end

function var_0_1.showEnergyDesc(arg_63_0)
	if arg_63_0.energyTimer then
		return
	end

	setActive = var_1

	var_1(arg_63_0.energyDescTF, true)

	local var_63_0 = arg_63_0.shipVO
	local var_63_1, var_63_2 = var_1.getEnergyPrint(var_63_0)

	setText = var_63_0

	local var_63_3 = arg_63_0.energyText

	i18n = var_1_10006

	var_63_0(var_63_3, var_1_10006(var_63_2))

	Timer = var_63_0
	arg_63_0.energyTimer = var_63_0.New(function()
		setActive = var_2_10000

		var_2_10000(arg_63_0.energyDescTF, false)

		local var_64_0 = arg_63_0.energyTimer

		var_0.Stop(var_64_0)

		arg_63_0.energyTimer = nil

		return
	end, 2, 1)

	local var_63_4 = arg_63_0.energyTimer

	var_3.Start(var_63_4)

	return
end

function var_0_1.displayShipWord(arg_65_0, arg_65_1, arg_65_2)
	ShipViewConst = var_1_10003

	local var_65_0 = var_1_10003.currentPage

	ShipViewConst = var_1_10004

	if var_65_0 ~= var_1_10004.PAGE.EQUIPMENT then
		ShipViewConst = var_65_0
		var_65_0 = var_65_0.currentPage
		ShipViewConst = var_4

		if var_65_0 == var_4.PAGE.UPGRADE then
			rtf = var_65_0

			local var_65_1 = var_65_0(arg_65_0.chat)

			Vector3 = var_4
			var_65_1.localScale = var_4.New(0, 0, 1)

			return
		end

		if arg_65_2 or not arg_65_0.chatFlag then
			arg_65_0.chatFlag = true

			local var_65_2 = arg_65_0.chat

			Vector3 = var_4
			var_65_2.localScale = var_4.zero
			setActive = var_65_2

			var_65_2(arg_65_0.chat, true)

			local var_65_3 = arg_65_0.chat

			Vector3 = var_4
			var_65_3.localPosition = var_4(arg_65_0.character.localPosition.x + 100, arg_65_0.chat.localPosition.y, 0)

			local var_65_4 = arg_65_0.shipVO
			local var_65_5 = var_3.getCVIntimacy(var_65_4)

			findTF = var_4

			local var_65_6

			if var_4(arg_65_0.nowPainting, "fitter").childCount > 0 then
				ShipExpressionHelper = var_65_6
				var_65_6 = var_65_6.SetExpression
				findTF = var_6

				local var_65_7 = var_6(arg_65_0.nowPainting, "fitter")

				var_65_6(var_6.GetChild(var_65_7, 0), arg_65_0.paintingCode, arg_65_1, var_65_5)
			end

			ShipWordHelper = var_65_6

			local var_65_8 = var_65_6.GetWordAndCV
			local var_65_9 = arg_65_0.shipVO
			local var_65_10, var_65_11, var_65_12 = var_65_8(var_6.getSkinId(var_65_9), arg_65_1, nil, nil, var_65_5)
			local var_65_13 = arg_65_0.chatText
			local var_65_14 = var_7.GetComponent

			typeof = var_10
			Text = var_1_10012

			local var_65_15 = var_65_14(var_65_13, var_10(var_1_10012))

			PLATFORM_CODE = var_8
			PLATFORM_US = var_65_13

			local var_65_16

			if var_8 ~= var_65_13 then
				setText = var_8
				var_65_16 = arg_65_0.chatText
				SwitchSpecialChar = var_1_10011

				var_8(var_65_16, var_1_10011(var_65_12))
			else
				var_65_15.fontSize = arg_65_0.initfontSize
				setTextEN = var_8

				var_8(arg_65_0.chatText, var_65_12)

				::label_65_0::

				local var_65_17 = var_65_15.preferredHeight

				if arg_65_0.initChatTextH < var_65_17 then
					repeat
						var_65_15.fontSize = var_65_15.fontSize - 2
						setTextEN = var_8

						var_8(arg_65_0.chatText, var_65_12)

						if var_65_15.fontSize < 20 then
							break
						end

						goto label_65_0
					until true
				end
			end

			local var_65_18 = #var_65_15.text

			CHAT_POP_STR_LEN = var_65_13

			if var_65_13 < var_65_18 then
				TextAnchor = var_65_18
				var_65_15.alignment = var_65_18.MiddleLeft
			else
				TextAnchor = var_65_18
				var_65_15.alignment = var_65_18.MiddleCenter
			end

			if var_65_15.preferredHeight + 120 > arg_65_0.initChatBgH then
				local var_65_19 = arg_65_0.chatBg

				Vector2 = var_65_16
				var_65_19.sizeDelta = var_65_16.New(arg_65_0.chatBg.sizeDelta.x, var_8)
			else
				local var_65_20 = arg_65_0.chatBg

				Vector2 = var_65_16
				var_65_20.sizeDelta = var_65_16.New(arg_65_0.chatBg.sizeDelta.x, arg_65_0.initChatBgH)
			end

			local var_65_21 = var_0_5

			local function var_65_22()
				if arg_65_0.chatFlag then
					if arg_65_0.chatani1Id then
						LeanTween = var_0

						var_0.cancel(arg_65_0.chatani1Id)
					end

					if arg_65_0.chatani2Id then
						LeanTween = var_0

						var_0.cancel(arg_65_0.chatani2Id)
					end
				end

				local var_66_0 = arg_65_0

				LeanTween = var_2_10001

				local var_66_1 = var_2_10001.scale

				rtf = var_2_10003

				local var_66_2 = var_2_10003(arg_65_0.chat.gameObject)

				Vector3 = var_2_10004

				local var_66_3 = var_66_1(var_66_2, var_2_10004.New(1, 1, 1), var_0_4)
				local var_66_4 = var_1.setEase

				LeanTweenType = var_4

				local var_66_5 = var_66_4(var_66_3, var_4.easeOutBack)
				local var_66_6 = var_1.setOnComplete

				System = var_4
				var_66_0.chatani1Id = var_66_6(var_66_5, var_4.Action(function()
					local var_67_0 = arg_65_0

					LeanTween = var_3_10001

					local var_67_1 = var_3_10001.scale

					rtf = var_3_10003

					local var_67_2 = var_3_10003(arg_65_0.chat.gameObject)

					Vector3 = var_3_10004

					local var_67_3 = var_67_1(var_67_2, var_3_10004.New(0, 0, 1), var_0_4)
					local var_67_4 = var_1.setEase

					LeanTweenType = var_4

					local var_67_5 = var_67_4(var_67_3, var_4.easeInBack)
					local var_67_6 = var_1.setDelay(var_67_5, var_0_4 + var_65_21)
					local var_67_7 = var_1.setOnComplete

					System = var_4
					var_67_0.chatani2Id = var_67_7(var_67_6, var_4.Action(function()
						arg_65_0.chatFlag = nil

						return
					end)).uniqueId

					return
				end)).uniqueId

				return
			end

			if var_65_11 then
				arg_65_0:StopPreVoice()

				pg = var_11

				local var_65_23 = var_11.CriMgr.GetInstance()

				var_11.PlaySoundEffect_V3(var_65_23, var_65_11, function(arg_69_0)
					if arg_69_0 then
						var_65_21 = arg_69_0:GetLength() * 0.001
					end

					var_65_22()

					return
				end)

				arg_65_0.preVoiceContent = var_65_11
			else
				var_65_22()
			end
		end

		return
	end
end

function var_0_1.StopPreVoice(arg_70_0)
	if arg_70_0.preVoiceContent ~= nil then
		pg = var_1

		local var_70_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_70_0, arg_70_0.preVoiceContent)
	end

	return
end

function var_0_1.startChatTimer(arg_71_0)
	if arg_71_0.chatFlag then
		return
	end

	if arg_71_0.chatTimer then
		local var_71_0 = arg_71_0.chatTimer

		var_1.Stop(var_71_0)

		arg_71_0.chatTimer = nil
	end

	Timer = var_1
	arg_71_0.chatTimer = var_1.New(function()
		local var_72_0 = arg_71_0
		local var_72_1 = var_0.displayShipWord
		local var_72_2 = arg_71_0

		var_72_1(var_72_0, var_3.getInitmacyWords(var_72_2))

		return
	end, var_0_7, 1)

	local var_71_1 = arg_71_0.chatTimer

	var_1.Start(var_71_1)

	return
end

function var_0_1.hideShipWord(arg_73_0)
	if arg_73_0.chatFlag then
		if arg_73_0.chatani1Id then
			LeanTween = var_1

			var_1.cancel(arg_73_0.chatani1Id)
		end

		if arg_73_0.chatani2Id then
			LeanTween = var_1

			var_1.cancel(arg_73_0.chatani2Id)
		end

		LeanTween = var_1

		local var_73_0 = var_1.scale

		rtf = var_1_10003

		local var_73_1 = var_1_10003(arg_73_0.chat.gameObject)

		Vector3 = var_1_10004

		local var_73_2 = var_73_0(var_73_1, var_1_10004.New(0, 0, 1), var_0_4)
		local var_73_3 = var_1.setEase

		LeanTweenType = var_4

		local var_73_4 = var_73_3(var_73_2, var_4.easeInBack)
		local var_73_5 = var_1.setOnComplete

		System = var_4

		var_73_5(var_73_4, var_4.Action(function()
			arg_73_0.chatFlag = nil

			return
		end))
	end

	arg_73_0:StopPreVoice()

	return
end

function var_0_1.gotoPage(arg_75_0, arg_75_1)
	ShipViewConst = var_1_10002

	local var_75_0

	if arg_75_1 == var_1_10002.PAGE.FASHION then
		function var_75_0()
			local var_76_0 = arg_75_0

			var_0.switchToPage(var_76_0, arg_75_1)

			return
		end

		arg_75_0:checkPaintingRes(var_75_0)
	else
		triggerToggle = var_75_0

		var_75_0(arg_75_0.togglesList[arg_75_1], true)
	end

	return
end

function var_0_1.switchToPage(arg_77_0, arg_77_1, arg_77_2)
	local function var_77_0(arg_78_0, arg_78_1)
		setActive = var_2_10002

		var_2_10002(arg_77_0.detailContainer, false)

		ShipViewConst = var_2_10002

		local var_78_0, var_78_1

		if arg_78_0 == var_2_10002.PAGE.DETAIL then
			setActive = var_78_0

			var_78_0(arg_77_0.detailContainer, arg_78_1)

			if not arg_78_1 or not {
				arg_77_0.detailContainer.rect.width + 200,
				0
			} then
				var_78_0 = {
					0,
					arg_77_0.detailContainer.rect.width + 200
				}
			end

			shiftPanel = var_2_10003
			var_78_1 = var_2_10003(arg_77_0.detailContainer, var_78_0[2], 0, var_0_3, 0)

			var_2_10003.setFrom(var_78_1, var_78_0[1])
		else
			ShipViewConst = var_78_0

			local var_78_2

			if arg_78_0 == var_78_0.PAGE.EQUIPMENT then
				var_78_2 = {
					-(arg_77_0.equipLCon.rect.width + 190),
					190
				}
				var_2_10003 = {
					arg_77_0.equipRCon.rect.width,
					10
				}

				local var_78_3 = {
					-arg_77_0.equipBCon.rect.height,
					0
				}

				var_78_1 = arg_78_1 and 1 or 2

				local var_78_4 = arg_78_1 and 2 or 1

				shiftPanel = var_2_10007

				local var_78_5 = var_2_10007(arg_77_0.equipLCon, var_78_2[var_78_4], 0, var_0_3, 0)

				var_2_10007.setFrom(var_78_5, var_78_2[var_78_1])

				shiftPanel = var_2_10007

				local var_78_6 = var_2_10007(arg_77_0.equipRCon, var_2_10003[var_78_4], 0, var_0_3, 0)

				var_2_10007.setFrom(var_78_6, var_2_10003[var_78_1])

				shiftPanel = var_2_10007

				local var_78_7 = var_2_10007(arg_77_0.equipBCon, 0, var_78_3[var_78_4], var_0_3, 0)

				var_2_10007.setFrom(var_78_7, var_78_3[var_78_1])
			else
				ShipViewConst = var_78_2

				local var_78_8

				if arg_78_0 == var_78_2.PAGE.FASHION then
					if not arg_78_1 or not {
						arg_77_0.fashionContainer.rect.width + 22,
						0
					} then
						var_78_8 = {
							0,
							arg_77_0.fashionContainer.rect.width + 22
						}
					end

					shiftPanel = var_2_10003
					var_78_1 = var_2_10003(arg_77_0.fashionContainer, var_78_8[2], 0, var_0_3, 0)

					var_3.setFrom(var_78_1, var_78_8[1])

					if arg_78_1 then
						var_78_1 = arg_77_0.shipFashionView

						var_3.ActionInvoke(var_78_1, "UpdateFashion")
					end
				else
					ShipViewConst = var_78_8

					local var_78_10

					if arg_78_0 == var_78_8.PAGE.INTENSIFY then
						if arg_78_1 then
							local var_78_9 = arg_77_0

							var_78_10 = var_78_10.emit
							ShipMainMediator = var_78_1

							var_78_10(var_78_9, var_78_1.OPEN_INTENSIFY)
						else
							local var_78_11 = arg_77_0

							var_78_10 = var_78_10.emit
							ShipMainMediator = var_78_1

							var_78_10(var_78_11, var_78_1.CLOSE_INTENSIFY)
						end
					else
						ShipViewConst = var_78_10

						local var_78_13

						if arg_78_0 == var_78_10.PAGE.UPGRADE then
							if arg_78_1 then
								local var_78_12 = arg_77_0

								var_78_13 = var_78_13.emit
								ShipMainMediator = var_78_1

								var_78_13(var_78_12, var_78_1.ON_UPGRADE)
							else
								local var_78_14 = arg_77_0

								var_78_13 = var_78_13.emit
								ShipMainMediator = var_78_1

								var_78_13(var_78_14, var_78_1.CLOSE_UPGRADE)
							end
						else
							ShipViewConst = var_78_13

							if arg_78_0 == var_78_13.PAGE.REMOULD then
								if arg_78_1 then
									local var_78_15 = arg_77_0
									local var_78_16 = var_2.emit

									ShipMainMediator = var_78_1

									var_78_16(var_78_15, var_78_1.OPEN_REMOULD)
								else
									local var_78_17 = arg_77_0
									local var_78_18 = var_2.emit

									ShipMainMediator = var_78_1

									var_78_18(var_78_17, var_78_1.CLOSE_REMOULD)
								end
							end
						end
					end
				end
			end
		end

		local var_78_19 = arg_77_0

		var_2.blurPage(var_78_19, arg_78_0, arg_78_1)

		ShipViewConst = var_2

		local var_78_20

		if arg_78_0 ~= var_2.PAGE.FASHION then
			var_78_20 = arg_77_0

			local var_78_21 = arg_77_0.shipVO

			var_78_20.fashionSkinId = var_3.getSkinId(var_78_21)

			local var_78_22 = arg_77_0

			var_78_20 = var_78_20.loadPainting
			var_2_10007 = arg_77_0.shipVO

			var_78_20(var_78_22, var_5.getPainting(var_2_10007))
		end

		ShipViewConst = var_78_20

		local var_78_23 = not var_78_20.IsSubLayerPage(arg_78_0)
		local var_78_24 = arg_77_0.bgEffect
		local var_78_25 = arg_77_0.shipVO

		if var_78_24[var_4.getRarity(var_78_25)] then
			setActive = var_4

			local var_78_26 = var_3

			ShipViewConst = var_2_10007

			if arg_78_0 ~= var_2_10007.PAGE.REMOULD then
				local var_78_27

				if arg_77_0.shipVO.bluePrintFlag then
					if arg_77_0.shipVO.bluePrintFlag ~= 0 then
						var_78_27 = false
					else
						var_78_27 = true
					end
				end

				var_4(var_78_26, var_78_27)

				local var_78_28 = arg_77_0

				var_4.changePaintingSortLayer(var_78_28, true)

				setActive = var_4

				var_4(arg_77_0.helpBtn, var_78_23)

				return
			end
		end
	end

	local function var_77_1()
		local var_79_0 = arg_77_1

		ShipViewConst = var_2_10001

		if var_79_0 == var_2_10001.currentPage and arg_77_2 then
			var_77_0(arg_77_1, true)
		else
			local var_79_1 = arg_77_1

			ShipViewConst = var_1

			if var_79_1 ~= var_1.currentPage then
				ShipViewConst = var_79_1

				local var_79_2

				if var_79_1.currentPage then
					var_79_2 = var_77_0
					ShipViewConst = var_2_10002

					var_79_2(var_2_10002.currentPage, false)
				end

				ShipViewConst = var_79_2
				var_79_2.currentPage = arg_77_1
				arg_77_0.contextData.page = arg_77_1

				var_77_0(arg_77_1, true)

				local var_79_3 = arg_77_0

				var_0.switchPainting(var_79_3)
			end
		end

		return
	end

	local var_77_2 = switchHandler

	if arg_77_0.viewList[arg_77_1] ~= nil then
		local var_77_3 = arg_77_0.viewList[arg_77_1]
		local var_77_5

		if not var_4.GetLoaded(var_77_3) then
			var_4:Load()

			local var_77_4 = var_4

			var_77_5 = var_4.CallbackInvoke
			switchHandler = var_1_10008

			var_77_5(var_77_4, var_1_10008)
		else
			switchHandler = var_77_5

			var_77_5()
		end
	else
		switchHandler = var_4

		var_4()
	end

	return
end

function var_0_1.blurPage(arg_80_0, arg_80_1, arg_80_2)
	ShipViewConst = var_1_10003

	if arg_80_1 == var_1_10003.PAGE.DETAIL then
		local var_80_0 = arg_80_0.shipDetailView

		var_3.ActionInvoke(var_80_0, "OnSelected", arg_80_2)
	else
		ShipViewConst = var_3

		if arg_80_1 == var_3.PAGE.EQUIPMENT then
			local var_80_1 = arg_80_0.shipEquipView

			var_3.ActionInvoke(var_80_1, "OnSelected", arg_80_2)
		else
			ShipViewConst = var_3

			if arg_80_1 == var_3.PAGE.FASHION then
				local var_80_2 = arg_80_0.shipFashionView

				var_3.ActionInvoke(var_80_2, "OnSelected", arg_80_2)
			else
				ShipViewConst = var_3

				if arg_80_1 == var_3.PAGE.INTENSIFY then
					-- block empty
				else
					ShipViewConst = var_3

					if arg_80_1 == var_3.PAGE.UPGRADE then
						-- block empty
					else
						ShipViewConst = var_3

						if arg_80_1 == var_3.PAGE.REMOULD then
							-- block empty
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.switchPainting(arg_81_0)
	setActive = var_1_10001

	local var_81_0 = arg_81_0.shipInfo

	ShipViewConst = var_1_10004

	local var_81_1 = var_1_10004.IsSubLayerPage

	ShipViewConst = var_1_10006

	var_1_10001(var_81_0, not var_81_1(var_1_10006.currentPage))

	setActive = var_1_10001

	local var_81_2 = arg_81_0.shipName

	ShipViewConst = var_4

	local var_81_3 = var_4.IsSubLayerPage

	ShipViewConst = var_6

	var_1_10001(var_81_2, not var_81_3(var_6.currentPage))

	ShipViewConst = var_1_10001

	local var_81_4 = var_1_10001.currentPage

	ShipViewConst = var_1_10002

	if var_81_4 == var_1_10002.PAGE.EQUIPMENT then
		shiftPanel = var_81_4

		var_81_4(arg_81_0.shipInfo, -20, 0, var_0_3, 0)

		arg_81_0.paintingFrameName = "zhuangbei"
	else
		shiftPanel = var_81_4

		var_81_4(arg_81_0.shipInfo, -460, 0, var_0_3, 0)

		arg_81_0.paintingFrameName = "chuanwu"
	end

	GetOrAddComponent = var_81_4
	findTF = var_81_2

	local var_81_5 = var_81_4(var_81_2(arg_81_0.nowPainting, "fitter"), "PaintingScaler")

	var_1.Snapshoot(var_81_5)

	var_1.FrameName = arg_81_0.paintingFrameName
	LeanTween = var_2

	local var_81_6 = var_2.value

	go = var_81_5

	local var_81_7 = var_81_6(var_81_5(arg_81_0.nowPainting), 0, 1, var_0_3)
	local var_81_8 = var_2.setOnUpdate

	System = var_5

	local var_81_9 = var_81_8(var_81_7, var_5.Action_float(function(arg_82_0)
		var_0.Tween = arg_82_0

		local var_82_0 = arg_81_0.chat

		Vector3 = var_2_10002
		var_82_0.localPosition = var_2_10002(arg_81_0.character.localPosition.x + 100, arg_81_0.chat.localPosition.y, 0)

		return
	end))
	local var_81_10 = var_2.setEase

	LeanTweenType = var_5

	local var_81_11 = var_81_10(var_81_9, var_5.easeInOutSine)

	return
end

function var_0_1.setPreOrNext(arg_83_0, arg_83_1, arg_83_2)
	if arg_83_1 then
		arg_83_0.isRight = true
	else
		arg_83_0.isRight = false
	end

	local var_83_0 = arg_83_0.shipVO

	if var_3.getGroupId(var_83_0) ~= arg_83_2:getGroupId() then
		local var_83_1

		if not arg_83_0.switchCnt then
			var_83_1 = 0
		end

		arg_83_0.switchCnt = var_83_1 + 1
	end

	if arg_83_0.switchCnt and arg_83_0.switchCnt >= 10 then
		gcAll = var_3

		var_3()

		arg_83_0.switchCnt = 0
	end

	return
end

function var_0_1.loadPainting(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = arg_84_1

	MainMeshImagePainting = var_1_10004
	arg_84_1 = var_1_10004.StaticGetPaintingName(var_84_0)

	if arg_84_0.isLoading == true then
		return
	end

	pairs = var_4

	for iter_84_0, iter_84_1 in var_4(arg_84_0.tablePainting) do
		Vector3 = var_1_10009
		iter_84_1.localScale = var_1_10009(1, 1, 1)
	end

	if arg_84_0.LoadShipVOId and not arg_84_2 and arg_84_0.LoadShipVOId == arg_84_0.shipVO.id and arg_84_0.LoadPaintingCode == arg_84_1 and not arg_84_2 then
		return
	end

	local var_84_1 = 0
	local var_84_2 = arg_84_0.isRight and 1800 or -1800
	local var_84_3 = arg_84_0:getPaintingFromTable(false)

	arg_84_0.isLoading = true

	local var_84_4 = arg_84_0.paintingCode
	local var_84_5 = {}

	if var_84_3 then
		table = var_8

		var_8.insert(var_84_5, function(arg_85_0)
			local var_85_0 = var_84_3
			local var_85_1 = var_1.GetComponent

			typeof = var_2_10004
			RectTransform = var_2_10006

			local var_85_2 = var_85_1(var_85_0, var_2_10004(var_2_10006))
			local var_85_3 = var_84_3
			local var_85_4 = var_2.GetComponent

			typeof = var_2_10005
			CanvasGroup = var_2_10007

			local var_85_5 = var_85_4(var_85_3, var_2_10005(var_2_10007))

			LeanTween = var_85_0

			local var_85_6 = var_85_0.cancel

			go = var_5

			var_85_6(var_5(var_85_5))

			LeanTween = var_85_6

			local var_85_7 = var_85_6.alphaCanvas(var_85_5, 0, 0.3)
			local var_85_8 = var_3.setFrom(var_85_7, 1)

			var_3.setUseEstimatedTime(var_85_8, true)

			LeanTween = var_3

			local var_85_9 = var_3.moveX(var_85_2, -var_84_2, 0.3)
			local var_85_10 = var_3.setFrom(var_85_9, 0)
			local var_85_11 = var_3.setOnComplete

			System = var_6

			var_85_11(var_85_10, var_6.Action(function()
				retPaintingPrefab = var_3_10000

				var_3_10000(var_84_3, var_84_4)
				arg_85_0()

				return
			end))

			return
		end)
	end

	local var_84_6 = arg_84_0
	local var_84_7 = arg_84_0.getPaintingFromTable(var_84_6, true)

	arg_84_0.paintingCode = arg_84_1

	local var_84_9

	if arg_84_0.paintingCode and var_84_7 then
		local var_84_8 = var_84_7

		var_84_9 = var_84_7.GetComponent
		typeof = var_1_10012
		RectTransform = var_1_10014
		var_84_9 = var_84_9(var_84_8, var_1_10012(var_1_10014))
		table = var_84_6

		var_84_6.insert(var_84_5, function(arg_87_0)
			local var_87_0 = arg_84_0

			var_87_0.nowPainting = var_84_7
			LoadPaintingPrefabAsync = var_87_0

			local var_87_1 = var_84_7
			local var_87_2 = var_84_0
			local var_87_3 = arg_84_0.paintingCode
			local var_87_4

			if not arg_84_0.paintingFrameName then
				var_87_4 = "chuanwu"
			end

			var_87_0(var_87_1, var_87_2, var_87_3, var_87_4, function()
				local var_88_0 = arg_84_0.shipVO
				local var_88_1 = var_0.getCVIntimacy(var_88_0)
				local var_88_2 = arg_84_0
				local var_88_3 = var_1.getInitmacyWords(var_88_2)

				ShipExpressionHelper = var_88_0

				local var_88_4 = var_88_0.SetExpression

				findTF = var_3_10004

				local var_88_5 = var_3_10004(var_84_7, "fitter")

				var_88_4(var_4.GetChild(var_88_5, 0), arg_84_0.paintingCode, var_88_3, var_88_1)
				arg_87_0()

				return
			end)

			return
		end)

		table = var_10

		var_10.insert(var_84_5, function(arg_89_0)
			LeanTween = var_2_10001

			local var_89_0 = var_2_10001.cancel

			go = var_2_10003

			var_89_0(var_2_10003(var_84_9))

			LeanTween = var_89_0

			local var_89_1 = var_89_0.moveX(var_84_9, 0, 0.3)
			local var_89_2 = var_1.setFrom(var_89_1, var_84_2)
			local var_89_3 = var_1.setOnComplete

			System = var_4

			var_89_3(var_89_2, var_4.Action(arg_89_0))

			local var_89_4 = var_84_7
			local var_89_5 = var_1.GetComponent

			typeof = var_4
			CanvasGroup = var_6

			local var_89_6 = var_89_5(var_89_4, var_4(var_6))

			LeanTween = var_2_10002

			local var_89_7 = var_2_10002.alphaCanvas(var_89_6, 1, 0.3)
			local var_89_8 = var_2.setFrom(var_89_7, 0)

			var_2.setUseEstimatedTime(var_89_8, true)

			return
		end)
	end

	parallelAsync = var_84_9

	var_84_9(var_84_5, function()
		arg_84_0.LoadShipVOId = arg_84_0.shipVO.id
		arg_84_0.LoadPaintingCode = arg_84_1
		arg_84_0.isLoading = false

		return
	end)

	return
end

function var_0_1.getPaintingFromTable(arg_91_0, arg_91_1)
	if arg_91_0.tablePainting == nil then
		print = var_2

		var_2("self.tablePainting为空")

		return
	end

	for iter_91_0 = 1, #arg_91_0.tablePainting do
		findTF = var_1_10006

		if var_1_10006(arg_91_0.tablePainting[iter_91_0], "fitter").childCount == 0 then
			if arg_91_1 == true and arg_91_0.tablePainting[iter_91_0] then
				return arg_91_0.tablePainting[iter_91_0]
			end
		elseif arg_91_1 == false and arg_91_0.tablePainting[iter_91_0] then
			return arg_91_0.tablePainting[iter_91_0]
		end
	end

	return
end

function var_0_1.loadSkinBg(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4)
	if not arg_92_0.bgEffect then
		arg_92_0.bgEffect = {}
	end

	if arg_92_0.shipSkinBg ~= arg_92_1 or arg_92_0.isDesign ~= arg_92_2 or arg_92_0.isMeta ~= arg_92_3 then
		arg_92_0.shipSkinBg = arg_92_1
		arg_92_0.isDesign = arg_92_2
		arg_92_0.isMeta = arg_92_3

		local var_92_0

		if arg_92_0.isDesign then
			if arg_92_0.metaBg then
				setActive = var_92_0

				var_92_0(arg_92_0.metaBg, false)
			end

			if arg_92_0.bgEffect then
				pairs = var_92_0

				for iter_92_0, iter_92_1 in var_92_0(arg_92_0.bgEffect) do
					setActive = var_1_10010

					var_1_10010(iter_92_1, false)
				end
			end

			if arg_92_0.designBg then
				var_92_0 = arg_92_0.designName

				local var_92_1 = "raritydesign"
				local var_92_2 = arg_92_0.shipVO

				if var_92_0 ~= var_92_1 .. var_7.getRarity(var_92_2) then
					PoolMgr = var_92_0

					local var_92_3 = var_92_0.GetInstance()

					var_92_0.ReturnUI(var_92_3, arg_92_0.designName, arg_92_0.designBg)

					arg_92_0.designBg = nil
				end
			end

			if not arg_92_0.designBg then
				PoolMgr = var_92_0

				local var_92_4 = var_92_0.GetInstance()

				var_92_0 = var_92_0.GetUI

				local var_92_5 = "raritydesign"
				local var_92_6 = arg_92_0.shipVO

				var_92_0(var_92_4, var_92_5 .. var_9.getRarity(var_92_6), true, function(arg_93_0)
					arg_92_0.designBg = arg_93_0

					local var_93_0 = arg_92_0
					local var_93_1 = "raritydesign"
					local var_93_2 = arg_92_0.shipVO

					var_93_0.designName = var_93_1 .. var_3.getRarity(var_93_2)

					local var_93_3 = arg_93_0.transform

					var_1.SetParent(var_93_3, arg_92_0._tf, false)

					local var_93_4 = arg_93_0.transform

					Vector3 = var_2
					var_93_4.localPosition = var_2(1, 1, 1)

					local var_93_5 = arg_93_0.transform

					Vector3 = var_2
					var_93_5.localScale = var_2(1, 1, 1)

					local var_93_6 = arg_93_0.transform

					var_1.SetSiblingIndex(var_93_6, 1)

					setActive = var_1

					var_1(arg_93_0, true)

					return
				end)
			else
				setActive = var_92_0

				var_92_0(arg_92_0.designBg, true)
			end
		elseif arg_92_0.isMeta then
			if arg_92_0.designBg then
				setActive = var_92_0

				var_92_0(arg_92_0.designBg, false)
			end

			if arg_92_0.metaBg then
				var_92_0 = arg_92_0.metaName

				local var_92_7 = "raritymeta"
				local var_92_8 = arg_92_0.shipVO

				if var_92_0 ~= var_92_7 .. var_7.getRarity(var_92_8) then
					PoolMgr = var_92_0

					local var_92_9 = var_92_0.GetInstance()

					var_92_0.ReturnUI(var_92_9, arg_92_0.metaName, arg_92_0.metaBg)

					arg_92_0.metaBg = nil
				end
			end

			if not arg_92_0.metaBg then
				PoolMgr = var_92_0

				local var_92_10 = var_92_0.GetInstance()

				var_92_0 = var_92_0.GetUI

				local var_92_11 = "raritymeta"
				local var_92_12 = arg_92_0.shipVO

				var_92_0(var_92_10, var_92_11 .. var_9.getRarity(var_92_12), true, function(arg_94_0)
					arg_92_0.metaBg = arg_94_0

					local var_94_0 = arg_92_0
					local var_94_1 = "raritymeta"
					local var_94_2 = arg_92_0.shipVO

					var_94_0.metaName = var_94_1 .. var_3.getRarity(var_94_2)

					local var_94_3 = arg_94_0.transform

					var_1.SetParent(var_94_3, arg_92_0._tf, false)

					local var_94_4 = arg_94_0.transform

					Vector3 = var_2
					var_94_4.localPosition = var_2(1, 1, 1)

					local var_94_5 = arg_94_0.transform

					Vector3 = var_2
					var_94_5.localScale = var_2(1, 1, 1)

					local var_94_6 = arg_94_0.transform

					var_1.SetSiblingIndex(var_94_6, 1)

					setActive = var_1

					var_1(arg_94_0, true)

					return
				end)
			else
				setActive = var_92_0

				var_92_0(arg_92_0.metaBg, true)
			end
		else
			if arg_92_0.designBg then
				setActive = var_92_0

				var_92_0(arg_92_0.designBg, false)
			end

			if arg_92_0.metaBg then
				setActive = var_92_0

				var_92_0(arg_92_0.metaBg, false)
			end

			for iter_92_2 = 1, 5 do
				local var_92_13 = arg_92_0.shipVO
				local var_92_14 = var_9.getRarity(var_92_13)

				if arg_92_0.bgEffect[iter_92_2] then
					setActive = var_10

					local var_92_15 = arg_92_0.bgEffect[iter_92_2]

					if iter_92_2 == var_92_14 then
						ShipViewConst = var_1_10013
						var_1_10013 = var_1_10013.currentPage
						ShipViewConst = var_1_10014

						if var_1_10013 ~= var_1_10014.PAGE.REMOULD then
							var_1_10013 = not arg_92_4

							goto label_92_0
						end
					end

					var_1_10013 = false

					if false then
						var_1_10013 = true
					end

					::label_92_0::

					var_10(var_92_15, var_1_10013)
				elseif 2 < var_92_14 and var_92_14 == iter_92_2 and not arg_92_4 then
					PoolMgr = var_10

					local var_92_16 = var_10.GetInstance()

					var_10.GetUI(var_92_16, "al_bg02_" .. var_92_14 - 1, true, function(arg_95_0)
						arg_92_0.bgEffect[iter_92_2] = arg_95_0

						local var_95_0 = arg_95_0.transform

						var_1.SetParent(var_95_0, arg_92_0._tf, false)

						local var_95_1 = arg_95_0.transform

						Vector3 = var_2
						var_95_1.localPosition = var_2(0, 0, 0)

						local var_95_2 = arg_95_0.transform

						Vector3 = var_2
						var_95_2.localScale = var_2(1, 1, 1)

						local var_95_3 = arg_95_0.transform

						var_1.SetSiblingIndex(var_95_3, 1)

						setActive = var_1

						local var_95_4 = arg_95_0

						ShipViewConst = var_4

						local var_95_5 = var_4.IsSubLayerPage

						ShipViewConst = var_6

						var_1(var_95_4, not var_95_5(var_6.currentPage))

						return
					end)
				end

				arg_92_0:changePaintingSortLayer(true)
			end
		end

		GetSpriteFromAtlasAsync = var_92_0

		var_92_0("bg/star_level_bg_" .. arg_92_1, "", function(arg_96_0)
			if not arg_92_0.exited and arg_92_0.shipSkinBg == arg_92_1 then
				setImageSprite = var_1

				var_1(arg_92_0.background, arg_96_0)
			end

			return
		end)
	end

	return
end

function var_0_1.changePaintingSortLayer(arg_97_0, arg_97_1)
	local var_97_0
	local var_97_1 = arg_97_1 and 12 or -1

	ipairs = var_1_10003

	for iter_97_0, iter_97_1 in var_1_10003(arg_97_0.tablePainting) do
		GetComponent = var_1_10008

		local var_97_2 = iter_97_1

		typeof = var_1_10011
		Canvas = var_1_10013
		var_1_10008 = var_1_10008(var_97_2, var_1_10011(var_1_10013))
		var_1_10008.sortingOrder = var_97_1
	end

	if arg_97_1 then
		local var_97_3 = arg_97_0.shipVO
		local var_97_4 = var_3.getRarity(var_97_3)

		if arg_97_0.isDesign and arg_97_0.designBg then
			setActive = var_4

			var_4(arg_97_0.designBg, true)
		elseif arg_97_0.bgEffect and var_97_4 and arg_97_0.bgEffect[var_97_4] then
			setActive = var_4

			var_4(arg_97_0.bgEffect[var_97_4], true)
		end
	else
		if arg_97_0.designBg then
			setActive = var_3

			var_3(arg_97_0.designBg, false)
		end

		if arg_97_0.bgEffect then
			pairs = var_3

			for iter_97_2, iter_97_3 in var_3(arg_97_0.bgEffect) do
				setActive = var_1_10008

				var_1_10008(iter_97_3, false)
			end
		end
	end

	return
end

function var_0_1.getInitmacyWords(arg_98_0)
	local var_98_0 = arg_98_0.shipVO
	local var_98_1 = var_1.getIntimacyLevel(var_98_0)

	Mathf = var_1_10002

	local var_98_2 = var_1_10002.Clamp(var_98_1, 1, 5)

	return "feeling" .. var_98_2
end

function var_0_1.paintView(arg_99_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_99_0.chat.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_99_0.chat.gameObject)

		local var_99_0 = arg_99_0.chat

		Vector3 = var_1_10002
		var_99_0.localScale = var_1_10002(0, 0, 0)
		arg_99_0.chatFlag = nil
	end

	local var_99_1 = arg_99_0.character

	var_1.GetComponent(var_99_1, "Image").enabled = false
	arg_99_0.inPaintingView = true

	local var_99_2 = {}
	local var_99_3 = arg_99_0._tf.childCount
	local var_99_4 = 0

	while var_99_4 < var_99_3 do
		local var_99_5 = arg_99_0._tf

		if var_4.GetChild(var_99_5, var_99_4).gameObject.activeSelf and var_4 ~= arg_99_0.main and var_4 ~= arg_99_0.background then
			var_99_2[#var_99_2 + 1] = var_4
			setActive = var_5

			var_5(var_4, false)
		end

		var_99_4 = var_99_4 + 1
	end

	local var_99_6 = arg_99_0.main.childCount
	local var_99_7 = 0

	while var_99_7 < var_99_6 do
		local var_99_8 = arg_99_0.main

		if var_4.GetChild(var_99_8, var_99_7).gameObject.activeSelf and var_4 ~= arg_99_0.shipInfo then
			var_99_2[#var_99_2 + 1] = var_4
			setActive = var_5

			var_5(var_4, false)
		end

		var_99_7 = var_99_7 + 1
	end

	local var_99_9 = arg_99_0.shipDetailView

	var_4.Hide(var_99_9)

	setActive = var_4

	var_4(arg_99_0.blurPanel, false)

	setActive = var_4
	pg = var_6

	var_4(var_6.playerResUI._go, false)

	var_99_2[#var_99_2 + 1] = arg_99_0.chat
	openPortrait = var_4

	var_4()

	setActive = var_4

	var_4(arg_99_0.common, false)

	arg_99_0.mainMask.enabled = false

	local var_99_10 = arg_99_0.mainMask

	var_4.PerformClipping(var_99_10)

	local var_99_11 = arg_99_0.nowPainting.anchoredPosition.x
	local var_99_12 = var_4.anchoredPosition.y
	local var_99_13 = var_4.rect.width
	local var_99_14 = var_4.rect.height
	local var_99_15 = arg_99_0._tf.rect.width

	UnityEngine = var_1_10010

	local var_99_16 = var_99_15 / var_1_10010.Screen.width
	local var_99_17 = arg_99_0._tf.rect.height

	UnityEngine = var_1_10011

	local var_99_18 = var_99_17 / var_1_10011.Screen.height
	local var_99_19 = var_99_13 / 2
	local var_99_20 = var_99_14 / 2
	local var_99_21
	local var_99_22

	GetOrAddComponent = var_1_10015

	local var_99_23 = var_1_10015(arg_99_0.background, "PinchZoom")

	GetOrAddComponent = var_1_10016

	local var_99_24 = var_1_10016(arg_99_0.background, "EventTriggerListener")
	local var_99_25 = true
	local var_99_26 = false

	var_99_24:AddPointDownFunc(function(arg_100_0)
		Input = var_2_10001

		if var_2_10001.touchCount ~= 1 then
			IsUnityEditor = var_1

			if var_1 then
				var_99_26 = true
				var_99_25 = true
			else
				Input = var_1

				if var_1.touchCount >= 2 then
					var_99_25 = false
					var_99_26 = false
				end
			end

			return
		end
	end)
	var_99_24:AddPointUpFunc(function(arg_101_0)
		Input = var_2_10001

		if var_2_10001.touchCount <= 2 then
			var_99_25 = true
		end

		return
	end)
	var_99_24:AddBeginDragFunc(function(arg_102_0, arg_102_1)
		var_99_26 = false

		local var_102_0 = arg_102_1.position.x * var_99_16 - var_99_19

		tf = var_3
		var_99_21 = var_102_0 - var_3(arg_99_0.nowPainting).localPosition.x

		local var_102_1 = arg_102_1.position.y * var_99_18 - var_99_20

		tf = var_3
		var_99_22 = var_102_1 - var_3(arg_99_0.nowPainting).localPosition.y

		return
	end)
	var_99_24:AddDragFunc(function(arg_103_0, arg_103_1)
		if var_99_23.processing then
			return
		end

		if var_99_25 then
			tf = var_2

			local var_103_0 = var_2(arg_99_0.nowPainting).localPosition

			tf = var_2_10003

			local var_103_1 = var_2_10003(arg_99_0.nowPainting)

			Vector3 = var_4
			var_103_1.localPosition = var_4(arg_103_1.position.x * var_99_16 - var_99_19 - var_99_21, arg_103_1.position.y * var_99_18 - var_99_20 - var_99_22, -22)
		end

		return
	end)

	onButton = var_19

	local var_99_27 = arg_99_0
	local var_99_28 = arg_99_0.background

	local function var_99_29()
		local var_104_0 = arg_99_0

		var_0.hidePaintView(var_104_0)

		return
	end

	SFX_CANCEL = var_1_10024

	var_19(var_99_27, var_99_28, var_99_29, var_1_10024)

	local var_99_30 = var_0_1

	function var_99_30.hidePaintView(arg_105_0, arg_105_1)
		if not arg_105_1 and not var_99_26 then
			return
		end

		local var_105_0 = arg_105_0.character
		local var_105_1 = var_2.GetComponent(var_105_0, "Image")

		var_105_1.enabled = true
		Input = var_105_1
		var_105_1.multiTouchEnabled = false
		setActive = var_105_1

		var_105_1(arg_105_0.common, true)

		SwitchPanel = var_105_1

		var_105_1(arg_105_0.shipInfo, -460, nil, var_0_3 * 2)

		var_99_24.enabled = false
		var_99_23.enabled = false

		local var_105_2 = arg_105_0.character

		Vector3 = var_3
		var_105_2.localScale = var_3.one

		local var_105_3 = arg_105_0.shipDetailView

		var_2.Show(var_105_3)

		setActive = var_2

		var_2(arg_105_0.blurPanel, true)

		setActive = var_2
		pg = var_4

		var_2(var_4.playerResUI._go, true)

		ipairs = var_2

		for iter_105_0, iter_105_1 in var_2(var_99_2) do
			setActive = var_7

			var_7(iter_105_1, true)
		end

		closePortrait = var_2

		var_2()

		local var_105_4 = arg_105_0.nowPainting

		Vector3 = var_3
		var_105_4.localScale = var_3(1, 1, 1)
		setAnchoredPosition = var_105_4

		var_105_4(arg_105_0.nowPainting, {
			x = var_99_11,
			y = var_99_12
		})

		local var_105_5 = arg_105_0.background

		var_2.GetComponent(var_105_5, "Button").enabled = false

		local var_105_6 = arg_105_0.nowPainting

		var_2.GetComponent(var_105_6, "CanvasGroup").blocksRaycasts = true
		arg_105_0.mainMask.enabled = true

		local var_105_7 = arg_105_0.mainMask

		var_2.PerformClipping(var_105_7)

		arg_105_0.inPaintingView = false

		return
	end

	SwitchPanel = var_99_30

	local var_99_31 = var_99_30(arg_99_0.shipInfo, var_0_2, nil, var_0_3 * 2)
	local var_99_32 = var_19.setOnComplete

	System = var_23

	var_99_32(var_99_31, var_23.Action(function()
		var_99_23.enabled = true
		var_99_24.enabled = true

		local var_106_0 = arg_99_0.background

		var_0.GetComponent(var_106_0, "Button").enabled = true

		local var_106_1 = arg_99_0.nowPainting

		var_0.GetComponent(var_106_1, "CanvasGroup").blocksRaycasts = false

		return
	end))

	return
end

function var_0_1.onBackPressed(arg_107_0)
	if arg_107_0.inUpgradeAnim then
		return
	end

	if arg_107_0.awakenPlay then
		return
	end

	if arg_107_0.shipChangeNameView.isOpenRenamePanel then
		local var_107_0 = arg_107_0.shipChangeNameView

		var_1.ActionInvoke(var_107_0, "DisplayRenamePanel", false)

		return
	end

	if arg_107_0.shipCustomMsgBox.isShowCustomMsgBox then
		local var_107_1 = arg_107_0.shipCustomMsgBox

		var_1.ActionInvoke(var_107_1, "hideCustomMsgBox")

		return
	end

	if arg_107_0.shipHuntingRangeView.onSelected then
		local var_107_2 = arg_107_0.shipHuntingRangeView

		var_1.ActionInvoke(var_107_2, "HideHuntingRange")

		return
	end

	if arg_107_0.inPaintingView then
		arg_107_0:hidePaintView(true)

		return
	end

	if arg_107_0.expItemUsagePage then
		local var_107_3 = arg_107_0.expItemUsagePage

		if var_1.GetLoaded(var_107_3) then
			local var_107_4 = arg_107_0.expItemUsagePage

			if var_1.isShowing(var_107_4) then
				local var_107_5 = arg_107_0.expItemUsagePage

				var_1.Hide(var_107_5)

				return
			end
		end
	end

	pg = var_1

	local var_107_6 = var_1.CriMgr.GetInstance()
	local var_107_7 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_107_7(var_107_6, var_1_10004)

	triggerButton = var_107_7

	local var_107_8 = arg_107_0.common

	var_107_7(var_3.Find(var_107_8, "top/back_btn"))

	return
end

function var_0_1.willExit(arg_108_0)
	Input = var_1_10001
	var_1_10001.multiTouchEnabled = true

	arg_108_0:UnOverlayPanel(arg_108_0.chat, arg_108_0.character)

	local var_108_0 = arg_108_0
	local var_108_1 = arg_108_0.blurPage

	ShipViewConst = var_4

	var_108_1(var_108_0, var_4.currentPage)

	setActive = var_108_1

	var_108_1(arg_108_0.background, false)

	if arg_108_0.designBg then
		PoolMgr = var_1

		local var_108_2 = var_1.GetInstance()

		var_1.ReturnUI(var_108_2, arg_108_0.designName, arg_108_0.designBg)
	end

	if arg_108_0.metaBg then
		PoolMgr = var_1

		local var_108_3 = var_1.GetInstance()

		var_1.ReturnUI(var_108_3, arg_108_0.metaName, arg_108_0.metaBg)
	end

	local var_108_4 = arg_108_0.intensifyToggle
	local var_108_5 = var_1.GetComponent(var_108_4, "Toggle").onValueChanged

	var_1.RemoveAllListeners(var_108_5)

	local var_108_6 = arg_108_0.upgradeToggle
	local var_108_7 = var_1.GetComponent(var_108_6, "Toggle").onValueChanged

	var_1.RemoveAllListeners(var_108_7)

	LeanTween = var_1

	var_1.cancel(arg_108_0.chat.gameObject)

	if arg_108_0.paintingCode then
		for iter_108_0 = 1, #arg_108_0.tablePainting do
			go = var_108_8

			local var_108_8 = var_108_8(arg_108_0.tablePainting[iter_108_0])

			LeanTween = var_1_10006

			if var_1_10006.isTweening(var_108_8) then
				LeanTween = var_1_10006
				var_1_10006 = var_1_10006.cancel
				go = var_8

				var_1_10006(var_8(var_108_8))
			end
		end

		retPaintingPrefab = var_1

		var_1(arg_108_0.nowPainting, arg_108_0.paintingCode)
	end

	local var_108_9 = arg_108_0.shipDetailView

	var_1.Destroy(var_108_9)

	local var_108_10 = arg_108_0.shipFashionView

	var_1.Destroy(var_108_10)

	local var_108_11 = arg_108_0.shipEquipView

	var_1.Destroy(var_108_11)

	local var_108_12 = arg_108_0.shipHuntingRangeView

	var_1.Destroy(var_108_12)

	local var_108_13 = arg_108_0.shipCustomMsgBox

	var_1.Destroy(var_108_13)

	local var_108_14 = arg_108_0.shipChangeNameView

	var_1.Destroy(var_108_14)

	clearImageSprite = var_1

	var_1(arg_108_0.background)

	if arg_108_0.energyTimer then
		local var_108_15 = arg_108_0.energyTimer

		var_1.Stop(var_108_15)

		arg_108_0.energyTimer = nil
	end

	if arg_108_0.chatTimer then
		local var_108_16 = arg_108_0.chatTimer

		var_1.Stop(var_108_16)

		arg_108_0.chatTimer = nil
	end

	arg_108_0:StopPreVoice()

	cameraPaintViewAdjust = var_1

	var_1(false)

	if arg_108_0.tweens then
		cancelTweens = var_1

		var_1(arg_108_0.tweens)
	end

	arg_108_0:UnOverlayPanel(arg_108_0.blurPanel, arg_108_0._tf)

	arg_108_0.shareData = nil

	return
end

function var_0_1.RefreshShipExpItemUsagePage(arg_109_0)
	if arg_109_0.expItemUsagePage then
		local var_109_0 = arg_109_0.expItemUsagePage

		if var_1.GetLoaded(var_109_0) then
			local var_109_1 = arg_109_0.expItemUsagePage

			if var_1.isShowing(var_109_1) then
				local var_109_2 = arg_109_0.expItemUsagePage

				var_1.Flush(var_109_2, arg_109_0.shipVO)
			end
		end
	end

	return
end

function var_0_1.OnWillLogout(arg_110_0)
	if arg_110_0.inPaintingView then
		arg_110_0:hidePaintView(true)
	end

	return
end

function var_0_1.checkPaintingRes(arg_111_0, arg_111_1)
	PaintingGroupConst = var_1_10002

	local var_111_0 = var_1_10002.GetPaintingNameListByShipVO(arg_111_0.shipVO)
	local var_111_1 = {
		isShowBox = true,
		paintingNameList = var_111_0,
		finishFunc = arg_111_1
	}

	PaintingGroupConst = var_4

	var_4.PaintingDownload(var_111_1)

	return
end

return var_0_1
