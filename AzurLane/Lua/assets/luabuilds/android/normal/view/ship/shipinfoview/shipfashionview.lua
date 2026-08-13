class = var_0_10000

local var_0_0 = "ShipFashionView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShipFashionView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitFashion()

	return
end

function var_0_1.InitFashion(arg_3_0)
	arg_3_0.mainPanel = arg_3_0._parentTf.parent
	arg_3_0.stylePanel = arg_3_0._tf

	local var_3_0 = arg_3_0.stylePanel

	arg_3_0.styleScroll = var_1.Find(var_3_0, "style_scroll")

	local var_3_1 = arg_3_0.styleScroll

	arg_3_0.styleContainer = var_1.Find(var_3_1, "view_port")

	local var_3_2 = arg_3_0.styleContainer

	arg_3_0.styleCard = var_1.GetChild(var_3_2, 0)
	findTF = var_1
	arg_3_0.hideObjToggleTF = var_1(arg_3_0._tf, "btns/hideObjToggle")
	setActive = var_1

	var_1(arg_3_0.hideObjToggleTF, false)

	GetComponent = var_1

	local var_3_3 = arg_3_0.hideObjToggleTF

	typeof = var_3
	Toggle = var_1_10004
	arg_3_0.hideObjToggle = var_1(var_3_3, var_3(var_1_10004))
	setText = var_1
	findTF = var_3_3

	local var_3_4 = var_3_3(arg_3_0.hideObjToggleTF, "Label")

	i18n = var_3

	var_1(var_3_4, var_3("paint_hide_other_obj_tip"))

	findTF = var_1
	arg_3_0.shareBtn = var_1(arg_3_0._tf, "share_btn")

	local var_3_5 = arg_3_0._tf

	arg_3_0.phantomBtn = var_1.Find(var_3_5, "phantom_btn")
	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.phantomBtn

	local function var_3_8()
		getProxy = var_2_10000
		TechnologyProxy = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001)
		local var_4_1 = var_0.getBluePrintById
		local var_4_2 = arg_3_0
		local var_4_3 = var_4_1(var_4_0, var_2.GetShipVO(var_4_2).groupId)
		local var_4_4 = arg_3_0
		local var_4_5 = var_1.emit

		ShipMainMediator = var_4_2

		local var_4_6 = var_4_2.OPEN_PHANTOM_LAYER
		local var_4_7

		if not var_4_3 or not var_4_3:getConfig("blueprint_version") then
			var_4_7 = nil
		end

		var_4_5(var_4_4, var_4_6, var_4_7)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	setParent = var_1

	var_1(arg_3_0.phantomBtn, arg_3_0._tf.parent)

	setActive = var_1

	var_1(arg_3_0.stylePanel, true)

	setActive = var_1

	var_1(arg_3_0.styleCard, false)

	arg_3_0.fashionSkins = {}
	arg_3_0.fashionCellMap = {}
	arg_3_0.fashionGroup = 0
	arg_3_0.fashionSkinId = 0
	arg_3_0.onSelected = false
	arg_3_0.isShareSkinFlag = false

	arg_3_0:RegisterShareToggle()

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.bind

	ShipMainMediator = var_3

	var_3_10(var_3_9, var_3.ON_NEXTSHIP_PREPARE, function(arg_5_0, arg_5_1)
		arg_3_0._lastSelectCard = nil

		if arg_3_0.isShareSkinFlag and arg_5_1 then
			local var_5_0 = arg_3_0

			if #var_2.GetShareSkins(var_5_0, arg_5_1) <= 0 then
				arg_3_0.isShareSkinFlag = false
			end
		end

		return
	end)

	return
end

function var_0_1.SetShareData(arg_6_0, arg_6_1)
	arg_6_0.shareData = arg_6_1

	return
end

function var_0_1.GetShipVO(arg_7_0)
	if arg_7_0.shareData and arg_7_0.shareData.shipVO then
		return arg_7_0.shareData.shipVO
	end

	return nil
end

function var_0_1.SetSkinList(arg_8_0, arg_8_1)
	arg_8_0.skinList = arg_8_1

	return
end

function var_0_1.UpdateUI(arg_9_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_9_0.shareBtn, arg_9_0.isShareSkinFlag)

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetShareSkins(var_9_0, arg_9_0:GetShipVO())

	setActive = var_9_0

	var_9_0(arg_9_0.shareBtn, #var_9_1 > 0)

	setActive = var_9_0

	local var_9_2 = arg_9_0.phantomBtn
	local var_9_3 = arg_9_0:GetShipVO()

	var_9_0(var_9_2, var_4.isBluePrintShip(var_9_3))

	return
end

function var_0_1.OnSelected(arg_10_0, arg_10_1)
	if arg_10_1 then
		local var_10_0 = arg_10_0
		local var_10_1 = arg_10_0.OverlayPanel
		local var_10_2 = arg_10_0._parentTf
		local var_10_3 = {}
		local var_10_4 = {}
		local var_10_5 = arg_10_0.stylePanel

		var_10_4[1] = var_7.Find(var_10_5, "style_desc")

		local var_10_6 = arg_10_0.stylePanel

		var_10_4[2] = var_7.Find(var_10_6, "frame")
		var_10_3.pbList = var_10_4
		LayerWeightConst = var_10_4
		var_10_3.overlayType = var_10_4.OVERLAY_UI_ADAPT

		var_10_1(var_10_0, var_10_2, var_10_3)
	else
		arg_10_0:UnOverlayPanel(arg_10_0._parentTf, arg_10_0.mainPanel)
	end

	arg_10_0.onSelected = arg_10_1

	return
end

function var_0_1.GetShareSkins(arg_11_0, arg_11_1)
	getProxy = var_1_10002
	ShipSkinProxy = var_1_10003

	local var_11_0 = var_1_10002(var_1_10003)
	local var_11_1 = var_2.GetShareSkinsForShip(var_11_0, arg_11_1)

	_ = var_11_0

	return (var_11_0.map(var_11_1, function(arg_12_0)
		pg = var_2_10001

		return var_2_10001.ship_skin_template[arg_12_0.id]
	end))
end

function var_0_1.UpdateAllFashion(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:GetShipVO().groupId
	local var_13_2

	if not arg_13_0.isShareSkinFlag or not arg_13_0:GetShareSkins(var_2) then
		local var_13_1 = arg_13_0.shareData

		var_13_2 = var_4.GetGroupSkinList(var_13_1, var_13_0)
	end

	arg_13_0.fashionSkins = var_13_2

	if arg_13_0.fashionGroup ~= var_13_0 or arg_13_1 then
		arg_13_0.fashionGroup = var_13_0

		arg_13_0:ResetFashion()

		for iter_13_0 = arg_13_0.styleContainer.childCount, #arg_13_0.fashionSkins - 1 do
			cloneTplTo = var_1_10008

			var_1_10008(arg_13_0.styleCard, arg_13_0.styleContainer)
		end

		for iter_13_1 = #arg_13_0.fashionSkins, arg_13_0.styleContainer.childCount - 1 do
			local var_13_3 = arg_13_0.styleContainer
			local var_13_4 = var_8.GetChild(var_13_3, iter_13_1)

			if arg_13_0.fashionCellMap[var_13_4] then
				local var_13_5 = arg_13_0.fashionCellMap[var_13_4]

				var_9.clear(var_13_5)
			end

			setActive = var_9

			var_9(var_13_4, false)
		end

		ipairs = var_4

		for iter_13_2, iter_13_3 in var_4(arg_13_0.fashionSkins) do
			local var_13_6 = iter_13_2
			local var_13_7 = arg_13_0.fashionSkins[iter_13_2]
			local var_13_8 = arg_13_0.styleContainer
			local var_13_9 = var_11.GetChild(var_13_8, iter_13_2 - 1)
			local var_13_10

			if not arg_13_0.fashionCellMap[var_13_9] then
				ShipSkinCard = var_13
				var_13_10 = var_13.New(var_13_9.gameObject)
				arg_13_0.fashionCellMap[var_13_9] = var_13_10
			end

			local var_13_11 = arg_13_0:GetShipVO()
			local var_13_13

			if var_13.getRemouldSkinId(var_13_11) == var_13_7.id then
				local var_13_12 = arg_13_0:GetShipVO()

				var_13_13 = var_13.isRemoulded(var_13_12)
			else
				var_13_13 = false
			end

			if false then
				var_13_13 = true
			end

			local var_13_14 = arg_13_0:GetShipVO()
			local var_13_15

			if not var_14.proposeSkinOwned(var_13_14, var_13_7) then
				table = var_13_15

				if not var_13_15.contains(arg_13_0.skinList, var_13_7.id) and not var_13_13 then
					::label_13_0::

					var_13_15 = var_13_7.skin_type
					ShipSkin = var_15

					if var_13_15 ~= var_15.SKIN_TYPE_OLD then
						getProxy = var_13_15
						ShipSkinProxy = var_15

						local var_13_16 = var_13_15(var_15)

						var_13_15 = var_13_15.hasSkin(var_13_16, var_13_7.id)

						if false then
							var_13_15 = false
						end
					else
						var_13_15 = true
					end
				end
			end

			var_13_10:updateData(arg_13_0:GetShipVO(), var_13_7, var_13_15)

			local var_13_17 = arg_13_0:GetShipVO()
			local var_13_18 = var_15.useSkin(var_13_17, var_13_7.id)

			var_13_10:updateUsing(var_13_18)

			onButton = var_16

			local var_13_19 = arg_13_0
			local var_13_20 = var_13_10.changeSkinTF

			local function var_13_21(arg_14_0)
				ShipSkin = var_2_10001

				local var_14_0 = var_2_10001.GetChangeSkinNextId(var_13_7.id)

				if var_13_18 then
					ShipSkin = var_2

					local var_14_1 = var_2.SetStoreChangeSkinId
					local var_14_2 = var_14_0
					local var_14_3 = var_0

					var_14_1(var_14_2, var_4.GetShipPhantomMark(var_14_3))

					pg = var_14_1

					local var_14_4 = var_14_1.m02
					local var_14_5 = var_2.sendNotification

					GAME = var_4

					local var_14_6 = var_4.CHANGE_SKIN_UPDATE
					local var_14_7 = arg_13_0
					local var_14_8 = var_5.GetShipVO(var_14_7)

					var_14_5(var_14_4, var_14_6, var_5.GetShipPhantomMark(var_14_8))
				end

				return
			end

			SFX_PANEL = var_1_10020

			var_16(var_13_19, var_13_20, var_13_21, var_1_10020)

			onButton = var_16

			var_16(arg_13_0, var_13_9, function()
				local var_15_0 = arg_13_0

				var_0.clickCell(var_15_0, var_13_10, var_13_7)

				arg_13_0._lastSelectCard = var_13_6

				return
			end)

			setActive = var_16

			var_16(var_13_9, true)
		end
	else
		ipairs = var_4

		for iter_13_4, iter_13_5 in var_4(arg_13_0.fashionSkins) do
			local var_13_22 = arg_13_0.styleContainer
			local var_13_23 = var_9.GetChild(var_13_22, iter_13_4 - 1)
			local var_13_24 = arg_13_0.fashionCellMap[var_13_23]
			local var_13_25 = arg_13_0:GetShipVO()
			local var_13_27

			if var_11.getRemouldSkinId(var_13_25) == iter_13_5.id then
				local var_13_26 = arg_13_0:GetShipVO()

				var_13_27 = var_11.isRemoulded(var_13_26)
			else
				var_13_27 = false
			end

			if false then
				var_13_27 = true
			end

			local var_13_28 = arg_13_0:GetShipVO()
			local var_13_29

			if not var_12.proposeSkinOwned(var_13_28, iter_13_5) then
				table = var_13_29

				if not var_13_29.contains(arg_13_0.skinList, iter_13_5.id) and not var_13_27 then
					::label_13_1::

					var_13_29 = iter_13_5.skin_type
					ShipSkin = var_13

					if var_13_29 ~= var_13.SKIN_TYPE_OLD then
						getProxy = var_13_29
						ShipSkinProxy = var_13

						local var_13_30 = var_13_29(var_13)

						var_13_29 = var_13_29.hasSkin(var_13_30, iter_13_5.id)

						if false then
							var_13_29 = false
						end
					else
						var_13_29 = true
					end
				end
			end

			var_13_24:updateData(arg_13_0:GetShipVO(), iter_13_5, var_13_29)
		end
	end

	local var_13_31 = arg_13_0:GetShipVO()

	arg_13_0.fashionSkinId = var_4.getSkinId(var_13_31)

	local var_13_32 = arg_13_0.styleContainer
	local var_13_33 = var_4.GetChild(var_13_32, 0)

	ipairs = var_13_32

	for iter_13_6, iter_13_7 in var_13_32(arg_13_0.fashionSkins) do
		if iter_13_7.id == arg_13_0.fashionSkinId then
			local var_13_34 = arg_13_0.styleContainer

			var_13_33 = var_10.GetChild(var_13_34, iter_13_6 - 1)

			break
		end
	end

	if arg_13_0._lastSelectCard then
		local var_13_35 = arg_13_0.styleContainer

		var_13_33 = var_5.GetChild(var_13_35, arg_13_0._lastSelectCard - 1)
		arg_13_0._lastSelectCard = nil
	end

	triggerButton = var_5

	var_5(var_13_33)

	return
end

function var_0_1.clickCell(arg_16_0, arg_16_1, arg_16_2)
	ShipViewConst = var_1_10003

	local var_16_0 = var_1_10003.currentPage

	ShipViewConst = var_1_10004

	if var_16_0 ~= var_1_10004.PAGE.FASHION then
		return
	end

	Time = var_16_0
	arg_16_0.clickCellTime = var_16_0.realtimeSinceStartup
	arg_16_0.fashionSkinId = arg_16_2.id

	arg_16_0:UpdateFashionDetail(arg_16_2)

	local var_16_1 = arg_16_0
	local var_16_2 = arg_16_0.emit

	ShipViewConst = var_5

	var_16_2(var_16_1, var_5.LOAD_PAINTING, arg_16_2.painting)

	local var_16_3 = arg_16_0
	local var_16_4 = arg_16_0.emit

	ShipViewConst = var_5

	local var_16_5 = var_5.LOAD_PAINTING_BG
	local var_16_6 = arg_16_0:GetShipVO()
	local var_16_7 = var_6.rarity2bgPrintForGet(var_16_6)
	local var_16_8 = arg_16_0:GetShipVO()
	local var_16_9 = var_7.isBluePrintShip(var_16_8)
	local var_16_10 = arg_16_0:GetShipVO()

	var_16_4(var_16_3, var_16_5, var_16_7, var_16_9, var_8.isMetaShip(var_16_10))

	ipairs = var_16_4

	for iter_16_0, iter_16_1 in var_16_4(arg_16_0.fashionSkins) do
		var_16_10 = arg_16_0.styleContainer

		local var_16_11 = var_8.GetChild(var_16_10, iter_16_0 - 1)
		local var_16_12 = arg_16_0.fashionCellMap[var_16_11]

		var_16_10.updateSelected(var_16_12, iter_16_1.id == arg_16_0.fashionSkinId)

		local var_16_13 = var_16_10
		local var_16_14 = var_16_10.updateUsing
		local var_16_15 = arg_16_0:GetShipVO()

		var_16_14(var_16_13, var_12.useSkin(var_16_15, iter_16_1.id))
	end

	local var_16_16 = arg_16_2.painting

	checkABExist = var_4

	local var_16_17 = var_4("painting/" .. var_16_16 .. "_n")

	setActive = var_5

	var_5(arg_16_0.hideObjToggle, var_16_17)

	if var_16_17 then
		local var_16_18 = arg_16_0.hideObjToggle

		PlayerPrefs = var_6
		var_16_18.isOn = var_6.GetInt("paint_hide_other_obj_" .. var_16_16, 0) ~= 0
		onToggle = var_16_18

		local var_16_19 = arg_16_0
		local var_16_20 = arg_16_0.hideObjToggleTF

		local function var_16_21(arg_17_0)
			PlayerPrefs = var_2_10001

			var_2_10001.SetInt("paint_hide_other_obj_" .. var_16_16, arg_17_0 and 1 or 0)

			local var_17_0 = arg_16_1

			var_1.flushSkin(var_17_0)

			local var_17_1 = arg_16_0
			local var_17_2 = var_1.emit

			ShipViewConst = var_3

			var_17_2(var_17_1, var_3.LOAD_PAINTING, var_16_16, true)

			return
		end

		SFX_PANEL = var_16_10

		var_16_18(var_16_19, var_16_20, var_16_21, var_16_10)
	end

	return
end

function var_0_1.UpdateFashion(arg_18_0, arg_18_1)
	ShipViewConst = var_1_10002

	local var_18_0 = var_1_10002.currentPage

	ShipViewConst = var_1_10003

	if var_18_0 == var_1_10003.PAGE.FASHION then
		local var_18_1 = arg_18_0.shareData

		if not var_2.HasFashion(var_18_1) then
			return
		end

		arg_18_0:UpdateAllFashion(arg_18_1)

		return
	end
end

function var_0_1.ResetFashion(arg_19_0)
	arg_19_0.fashionSkinId = 0

	return
end

function var_0_1.UpdateFashionDetail(arg_20_0, arg_20_1)
	local var_20_0

	if not arg_20_0.fashionDetailWrapper then
		var_20_0 = {}
		findTF = var_1_10003
		var_20_0.name = var_1_10003(arg_20_0.stylePanel, "style_desc/name_bg/name")
		findTF = var_1_10003
		var_20_0.descTxt = var_1_10003(arg_20_0.stylePanel, "style_desc/desc_frame/desc/Text")
		findTF = var_1_10003
		var_20_0.character = var_1_10003(arg_20_0.stylePanel, "style_desc/character")
		findTF = var_1_10003
		var_20_0.confirm = var_1_10003(arg_20_0.stylePanel, "confirm_button")
		findTF = var_1_10003
		var_20_0.cancel = var_1_10003(arg_20_0.stylePanel, "cancel_button")
		findTF = var_1_10003
		var_20_0.diamond = var_1_10003(var_20_0.confirm, "diamond")
		findTF = var_1_10003
		var_20_0.using = var_1_10003(var_20_0.confirm, "using")
		findTF = var_1_10003
		var_20_0.experience = var_1_10003(var_20_0.confirm, "experience")
		findTF = var_1_10003
		var_20_0.change = var_1_10003(var_20_0.confirm, "change")
		findTF = var_1_10003
		var_20_0.buy = var_1_10003(var_20_0.confirm, "buy")
		findTF = var_1_10003
		var_20_0.activity = var_1_10003(var_20_0.confirm, "activity")
		findTF = var_1_10003
		var_20_0.cantbuy = var_1_10003(var_20_0.confirm, "cantbuy")
		var_20_0.prefab = "unknown"
		arg_20_0.fashionDetailWrapper = var_20_0
	end

	setText = var_1_10003

	var_1_10003(var_20_0.name, arg_20_1.name)

	setText = var_1_10003

	local var_20_1 = var_20_0.descTxt

	SwitchSpecialChar = var_5

	var_1_10003(var_20_1, var_5(arg_20_1.desc, true))

	local var_20_2 = var_20_0.descTxt
	local var_20_3 = var_3.GetComponent

	typeof = var_5
	Text = var_6

	if #var_20_3(var_20_2, var_5(var_6)).text > 50 then
		TextAnchor = var_4
		var_3.alignment = var_4.MiddleLeft
	else
		TextAnchor = var_4
		var_3.alignment = var_4.MiddleCenter
	end

	if var_20_0.prefab ~= arg_20_1.prefab then
		local var_20_4 = var_20_0.character
		local var_20_5 = var_4.Find(var_20_4, var_20_0.prefab)

		IsNil = var_20_4

		local var_20_6

		if not var_20_4(var_20_5) then
			PoolMgr = var_5
			var_20_6 = var_5.GetInstance()

			var_5.ReturnSpineChar(var_20_6, var_20_0.prefab, var_20_5.gameObject)
		end

		var_20_0.prefab = arg_20_1.prefab

		local var_20_7 = var_20_0.prefab

		SpineAnimChar = var_20_6
		arg_20_0.spineChar = var_20_6.New()

		local var_20_8 = arg_20_0.spineChar

		var_6.SetPaint(var_20_8, var_20_7)

		local var_20_9 = arg_20_0.spineChar

		var_6.Load(var_20_9, true, function(arg_21_0)
			if var_20_0.prefab ~= var_20_7 then
				arg_21_0:Dispose()
			else
				arg_21_0:SetName(var_20_7)

				local var_21_0 = arg_21_0
				local var_21_1 = arg_21_0.SetLocalPosition

				Vector3 = var_3

				var_21_1(var_21_0, var_3.zero)

				local var_21_2 = arg_21_0
				local var_21_3 = arg_21_0.SetLocalScale

				Vector3 = var_3

				var_21_3(var_21_2, var_3(0.5, 0.5, 1))
				arg_21_0:SetParent(var_20_0.character)

				local var_21_4 = arg_21_0
				local var_21_5 = arg_21_0.SetAction
				local var_21_6

				if not arg_20_1.show_skin then
					var_21_6 = "stand"
				end

				var_21_5(var_21_4, var_21_6, 0)
			end

			return
		end)
	end

	local var_20_10 = arg_20_0:GetShipVO()
	local var_20_12

	if var_4.getRemouldSkinId(var_20_10) == arg_20_1.id then
		local var_20_11 = arg_20_0:GetShipVO()

		var_20_12 = var_4.isRemoulded(var_20_11)
	else
		var_20_12 = false
	end

	if false then
		var_20_12 = true
	end

	local var_20_13 = arg_20_0:GetShipVO()

	if not var_5.proposeSkinOwned(var_20_13, arg_20_1) then
		table = var_5

		local var_20_14

		if var_5.contains(arg_20_0.skinList, arg_20_1.id) or var_20_12 then
			var_20_14 = 1
		else
			var_20_14 = 0
		end

		local var_20_15 = arg_20_1.shop_id

		if 0 < var_20_15 then
			pg = var_20_15

			local var_20_16

			if not var_20_15.shop_template[arg_20_1.shop_id] then
				var_20_16 = nil
			end

			local var_20_18

			if var_20_16 then
				::label_20_0::

				pg = var_20_18

				local var_20_17 = var_20_18.TimeMgr.GetInstance()

				var_20_18 = not var_20_18.inTime(var_20_17, var_20_16.time)
			end

			local var_20_19 = arg_20_1.id
			local var_20_20 = arg_20_0:GetShipVO()
			local var_20_21 = var_20_19 == var_9.getSkinId(var_20_20)
			local var_20_22 = arg_20_1.id
			local var_20_23 = arg_20_0:GetShipVO()
			local var_20_25, var_20_26

			if var_20_22 ~= var_10.getConfig(var_20_23, "skin_id") and not (var_20_14 >= 1) then
				local var_20_24 = arg_20_1.skin_type

				ShipSkin = var_20_25

				if var_20_24 ~= var_20_25.SKIN_TYPE_OLD then
					getProxy = var_20_24
					ShipSkinProxy = var_20_25
					var_20_25 = var_20_24(var_20_25)
					var_20_26 = var_9.hasSkin(var_20_25, arg_20_1.id)

					if false then
						var_20_26 = false
					end

					goto label_20_1
				end
			end

			var_20_26 = true

			::label_20_1::

			getProxy = var_20_25
			ShipSkinProxy = var_20_23

			local var_20_27 = var_20_25(var_20_23)
			local var_20_28 = var_10.getSkinById(var_20_27, arg_20_1.id)

			getProxy = var_20_27
			ShipSkinProxy = var_12

			local var_20_29 = var_20_27(var_12)
			local var_20_30 = var_11.InForbiddenSkinListAndShow(var_20_29, arg_20_1.id)
			local var_20_31, var_20_32

			if var_20_21 and var_20_28 then
				::label_20_3::

				var_20_31 = var_20_28
				var_20_32 = var_20_28.isExpireType(var_20_31)
			end

			setActive = var_20_31

			var_20_31(var_20_0.using, false)

			setActive = var_20_31

			var_20_31(var_20_0.change, false)

			setActive = var_20_31

			var_20_31(var_20_0.buy, false)

			setActive = var_20_31

			var_20_31(var_20_0.experience, false)

			if var_20_32 then
				setGray = var_20_31

				var_20_31(var_20_0.confirm, false)

				setActive = var_20_31

				var_20_31(var_20_0.experience, true)
			elseif var_20_21 then
				setGray = var_20_31

				var_20_31(var_20_0.confirm, false)

				setActive = var_20_31

				var_20_31(var_20_0.using, true)
			else
				if var_20_26 then
					ShipSkin = var_20_31

					if var_20_31.IsShareSkin(arg_20_0:GetShipVO(), arg_20_1.id) then
						ShipSkin = var_20_31

						if not var_20_31.CanUseShareSkinForShip(arg_20_0:GetShipVO(), arg_20_1.id) then
							setActive = var_20_31

							var_20_31(var_20_0.change, true)

							setGray = var_20_31

							var_20_31(var_20_0.confirm, true)

							goto label_20_4
						end
					end
				end

				if var_20_26 then
					setActive = var_20_31

					var_20_31(var_20_0.change, true)

					setGray = var_20_31

					var_20_31(var_20_0.confirm, false)
				elseif var_20_16 then
					setActive = var_20_31

					var_20_31(var_20_0.buy, true)

					setGray = var_20_31

					var_20_31(var_20_0.confirm, var_20_18 or var_20_30)
				else
					setActive = var_20_31

					var_20_31(var_20_0.change, true)

					setGray = var_20_31

					var_20_31(var_20_0.confirm, true)
				end
			end

			::label_20_4::

			onButton = var_20_31

			var_20_31(arg_20_0, var_20_0.confirm, function()
				if var_20_21 then
					ShipSkin = var_0

					if var_0.IsChangeSkin(arg_20_1.id) then
						if arg_20_0.clickCellTime then
							Time = var_0

							if var_0.realtimeSinceStartup - arg_20_0.clickCellTime <= 0.35 then
								return
							end
						end

						local var_22_0 = arg_20_0

						var_0.SilentTriggerToggleFalse(var_22_0)

						local var_22_1 = arg_20_0
						local var_22_2 = var_0.emit

						ShipViewConst = var_2_10002
						var_2_10002 = var_2_10002.SWITCH_TO_PAGE
						ShipViewConst = var_2_10003

						var_22_2(var_22_1, var_2_10002, var_2_10003.PAGE.DETAIL)
					end
				elseif var_20_26 then
					ShipSkin = var_0

					local var_22_3 = var_0.IsShareSkin

					var_2_10002 = arg_20_0

					if var_22_3(var_1.GetShipVO(var_2_10002), arg_20_1.id) then
						ShipSkin = var_0

						local var_22_4 = var_0.CanUseShareSkinForShip

						var_2_10002 = arg_20_0

						if not var_22_4(var_1.GetShipVO(var_2_10002), arg_20_1.id) then
							goto label_22_0
						end
					end

					local var_22_5 = arg_20_0
					local var_22_6 = var_0.emit

					ShipMainMediator = var_2_10002
					var_2_10002 = var_2_10002.CHANGE_SKIN

					local var_22_7 = arg_20_0

					var_2_10003 = var_2_10003.GetShipVO(var_22_7).id

					local var_22_8 = arg_20_1.id
					local var_22_9 = arg_20_0
					local var_22_10 = var_5.GetShipVO(var_22_9)

					var_22_6(var_22_5, var_2_10002, var_2_10003, var_22_8 == var_5.getConfig(var_22_10, "skin_id") and 0 or arg_20_1.id)
				elseif var_20_16 then
					local var_22_12

					if var_20_18 or var_20_30 then
						pg = var_22_12

						local var_22_11 = var_22_12.TipsMgr.GetInstance()

						var_22_12 = var_22_12.ShowTips
						i18n = var_2_10002

						var_22_12(var_22_11, var_2_10002("common_skin_out_of_stock"))
					else
						Goods = var_22_12

						local var_22_13 = var_22_12.Create
						local var_22_14 = {
							shop_id = var_20_16.id
						}

						Goods = var_2

						local var_22_15 = var_22_13(var_22_14, var_2.TYPE_SKIN)

						if var_0.isDisCount(var_22_15) and var_0:IsItemDiscountType() then
							local var_22_16 = arg_20_0
							local var_22_17 = var_1.emit

							ShipMainMediator = var_2_10003

							var_22_17(var_22_16, var_2_10003.BUY_ITEM_BY_ACT, var_20_16.id, 1)
						else
							local var_22_18 = var_0
							local var_22_19 = var_0.GetPrice(var_22_18)

							i18n = var_22_18

							local var_22_20 = var_22_18("text_buy_fashion_tip", var_22_19, arg_20_1.name)

							pg = var_3

							local var_22_21 = var_3.MsgboxMgr.GetInstance()

							var_3.ShowMsgBox(var_22_21, {
								content = var_22_20,
								onYes = function()
									local var_23_0 = arg_20_0
									local var_23_1 = var_0.emit

									ShipMainMediator = var_3_10002

									var_23_1(var_23_0, var_3_10002.BUY_ITEM, var_20_16.id, 1)

									return
								end
							})
						end
					end
				end

				::label_22_0::

				return
			end)

			onButton = var_20_31

			var_20_31(arg_20_0, var_20_0.cancel, function()
				if arg_20_0.clickCellTime then
					Time = var_0

					if var_0.realtimeSinceStartup - arg_20_0.clickCellTime <= 0.35 then
						return
					end
				end

				local var_24_0 = arg_20_0

				var_0.SilentTriggerToggleFalse(var_24_0)

				local var_24_1 = arg_20_0
				local var_24_2 = var_0.emit

				ShipViewConst = var_2_10002

				local var_24_3 = var_2_10002.SWITCH_TO_PAGE

				ShipViewConst = var_2_10003

				var_24_2(var_24_1, var_24_3, var_2_10003.PAGE.DETAIL)

				return
			end)

			return
		end
	end
end

function var_0_1.SilentTriggerToggleFalse(arg_25_0)
	arg_25_0.fashionGroup = false
	arg_25_0.isShareSkinFlag = false
	removeOnToggle = var_1

	var_1(arg_25_0.shareBtn)

	triggerToggle = var_1

	var_1(arg_25_0.shareBtn, false)
	arg_25_0:RegisterShareToggle()

	return
end

function var_0_1.RegisterShareToggle(arg_26_0)
	onToggle = var_1_10001

	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_0.shareBtn

	local function var_26_2(arg_27_0)
		arg_26_0.fashionGroup = false
		arg_26_0.isShareSkinFlag = arg_27_0

		local var_27_0 = arg_26_0

		var_1.UpdateFashion(var_27_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_26_0, var_26_1, var_26_2, var_1_10005)

	return
end

function var_0_1.OnDestroy(arg_28_0)
	setParent = var_1_10001

	var_1_10001(arg_28_0.phantomBtn, arg_28_0._tf)

	if arg_28_0.fashionDetailWrapper then
		local var_28_0 = arg_28_0.fashionDetailWrapper.character

		if var_2.Find(var_28_0, var_1.prefab) and arg_28_0.spineChar then
			local var_28_1 = arg_28_0.spineChar

			var_3.Dispose(var_28_1)

			arg_28_0.spineChar = nil
		end
	end

	arg_28_0.fashionDetailWrapper = nil
	pairs = var_1

	for iter_28_0, iter_28_1 in var_1(arg_28_0.fashionCellMap) do
		iter_28_1:clear()
	end

	arg_28_0.fashionCellMap = {}
	arg_28_0.fashionSkins = {}
	arg_28_0.fashionGroup = 0
	arg_28_0.fashionSkinId = 0
	arg_28_0.shareData = nil

	return
end

return var_0_1
