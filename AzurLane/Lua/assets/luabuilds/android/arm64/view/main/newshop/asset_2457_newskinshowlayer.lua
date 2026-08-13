class = var_0_10000

local var_0_0 = "NewSkinShowLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_1.getUIName(arg_1_0)
	return "NewSkinShowUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "adapt/top/closeBtn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_1, "adapt/top/homeBtn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.bgs = var_1.Find(var_2_2, "bgs")

	local var_2_3 = arg_2_0._tf

	arg_2_0.resources = var_1.Find(var_2_3, "adapt/top/resources")

	local var_2_4 = arg_2_0._tf

	arg_2_0.limitTime = var_1.Find(var_2_4, "adapt/top/skinTitle/limit_time")

	local var_2_5 = arg_2_0._tf

	arg_2_0.skinName = var_1.Find(var_2_5, "adapt/top/skinTitle/skin_name_mask/skin_name")

	local var_2_6 = arg_2_0._tf

	arg_2_0.shipName = var_1.Find(var_2_6, "adapt/top/skinTitle/name_mask/name")

	local var_2_7 = arg_2_0._tf

	arg_2_0.changeSkin = var_1.Find(var_2_7, "adapt/top/change_skin")

	local var_2_8 = arg_2_0._tf

	arg_2_0.sdTg = var_1.Find(var_2_8, "adapt/right/sdTg")

	local var_2_9 = arg_2_0._tf

	arg_2_0.hideUITg = var_1.Find(var_2_9, "adapt/right/hideUITg")

	local var_2_10 = arg_2_0._tf

	arg_2_0.charContainer = var_1.Find(var_2_10, "adapt/right/char_container")

	local var_2_11 = arg_2_0.charContainer

	arg_2_0.backChara = var_1.Find(var_2_11, "bg/back/chara")

	local var_2_12 = arg_2_0.charContainer

	arg_2_0.charTf = var_1.Find(var_2_12, "char")

	local var_2_13 = arg_2_0.charContainer

	arg_2_0.furnitureContainer = var_1.Find(var_2_13, "fur")

	local var_2_14 = arg_2_0._tf

	arg_2_0.dynamicToggle = var_1.Find(var_2_14, "adapt/right/functionsAndTags/dynamic")

	local var_2_15 = arg_2_0._tf

	arg_2_0.showBgToggle = var_1.Find(var_2_15, "adapt/right/functionsAndTags/showBg")

	local var_2_16 = arg_2_0._tf

	arg_2_0.dynamicResToggle = var_1.Find(var_2_16, "adapt/right/functionsAndTags/dynamic/l2d_res_state")
	UIItemList = var_1

	local var_2_17 = var_1.New
	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "adapt/right/functionsAndTags/tags")
	local var_2_20 = arg_2_0._tf

	arg_2_0.tagList = var_2_17(var_2_19, var_4.Find(var_2_20, "adapt/right/functionsAndTags/tags/tag"))

	local var_2_21 = arg_2_0.charContainer

	arg_2_0.switchPreviewBtn = var_1.Find(var_2_21, "switch")

	local var_2_22 = arg_2_0._tf

	arg_2_0.painting = var_1.Find(var_2_22, "painting")

	local var_2_23 = arg_2_0._tf

	arg_2_0.paintingTF = var_1.Find(var_2_23, "painting/paint")
	arg_2_0.defaultPaintingPosition = arg_2_0.paintingTF.anchoredPosition
	arg_2_0.defaultPaintingScale = arg_2_0.paintingTF.localScale

	local var_2_24 = arg_2_0._tf

	arg_2_0.live2dContainer = var_1.Find(var_2_24, "painting/paint/live2d")

	local var_2_25 = arg_2_0._tf

	arg_2_0.spTF = var_1.Find(var_2_25, "painting/paint/spinePainting")

	local var_2_26 = arg_2_0._tf

	arg_2_0.spBg = var_1.Find(var_2_26, "painting/paintBg/spinePainting")

	local var_2_27 = arg_2_0._tf

	arg_2_0.equipBtn = var_1.Find(var_2_27, "adapt/equipBtn")
	setText = var_1

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_3.Find(var_2_28, "bgs/empty/Text")

	i18n = var_4

	var_1(var_2_29, var_4("shop_new_unfound"))

	setText = var_1

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_3.Find(var_2_30, "adapt/top/title/Text")

	i18n = var_4

	var_1(var_2_31, var_4("shop_new_shop"))

	setText = var_1

	local var_2_32 = arg_2_0.equipBtn
	local var_2_33 = var_3.Find(var_2_32, "Text")

	i18n = var_4

	var_1(var_2_33, var_4("shop_new_wear"))

	setActive = var_1

	var_1(arg_2_0.switchPreviewBtn, false)

	setActive = var_1

	var_1(arg_2_0.limitTime, false)

	ChangeSkinToggle = var_1

	local var_2_34 = var_1.New
	local var_2_35 = arg_2_0.changeSkin

	arg_2_0.changeSkinToggle = var_2_34(var_3.Find(var_2_35, "toggle_ui"))
	arg_2_0.downloads = {}
	arg_2_0.isToggleDynamic = false
	arg_2_0.isToggleShowBg = true
	ChangeShipSkinPage = var_1
	arg_2_0.selectShipPage = var_1.New(arg_2_0._parentTf, arg_2_0.event)
	pg = var_1

	local var_2_36 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_2_36, arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0.shipSkin = arg_3_0.contextData.skin
	arg_3_0.skinId = arg_3_0.shipSkin.id

	arg_3_0:SetResource()
	arg_3_0:UpdateMainView()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.homeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	getProxy = var_1
	PlayerProxy = var_3_3

	local var_3_6 = var_1(var_3_3)
	local var_3_7 = var_1.getRawData(var_3_6).id

	onToggle = var_1_10002

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.sdTg

	local function var_3_10(arg_6_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0.charContainer, arg_6_0)

		PlayerPrefs = var_2_10001

		var_2_10001.SetInt("LatestSkinShopLayerSdTg" .. var_3_7, arg_6_0 and 1 or 0)

		PlayerPrefs = var_1

		var_1.Save()

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_3_8, var_3_9, var_3_10, var_1_10007)

	PlayerPrefs = var_1_10002

	local var_3_11 = var_1_10002.GetInt("LatestSkinShopLayerSdTg" .. var_3_7, 0)

	triggerToggle = var_3_6

	var_3_6(arg_3_0.sdTg, var_3_11 == 1)

	onToggle = var_3_6

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.sdTg

	local function var_3_14(arg_7_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0.charContainer, arg_7_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_3_6(var_3_12, var_3_13, var_3_14, var_1_10008)

	onToggle = var_3_6

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.hideUITg

	local function var_3_17(arg_8_0)
		setActive = var_2_10001

		local var_8_0 = arg_3_0._tf

		var_2_10001(var_3.Find(var_8_0, "adapt/top"), not arg_8_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_3_6(var_3_15, var_3_16, var_3_17, var_1_10008)

	onButton = var_3_6

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.equipBtn

	local function var_3_20()
		local var_9_0 = arg_3_0.shipSkin

		if var_0.CantUse(var_9_0) then
			pg = var_0

			local var_9_1 = var_0.TipsMgr.GetInstance()
			local var_9_2 = var_0.ShowTips

			i18n = var_2_10003

			var_9_2(var_9_1, var_2_10003("without_ship_to_wear"))

			return
		end

		local var_9_3 = arg_3_0.selectShipPage

		var_0.ExecuteAction(var_9_3, "Show", arg_3_0.shipSkin)

		return
	end

	SFX_PANEL = var_1_10008

	var_3_6(var_3_18, var_3_19, var_3_20, var_1_10008)

	onButton = var_3_6

	local var_3_21 = arg_3_0
	local var_3_22 = arg_3_0.changeSkin

	local function var_3_23()
		ShipSkin = var_2_10000

		if var_2_10000.IsChangeSkin(arg_3_0.skinId) then
			local var_10_0 = arg_3_0

			ShipSkin = var_2_10001
			var_10_0.changeSkinId = var_2_10001.GetChangeSkinNextId(arg_3_0.skinId)

			local var_10_1 = arg_3_0

			var_0.UpdateMainView(var_10_1)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_3_6(var_3_21, var_3_22, var_3_23, var_1_10008)

	return
end

function var_0_1.SetResource(arg_11_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = var_1.getRawData(var_11_0)

	setText = var_1_10002

	local var_11_2 = arg_11_0.resources

	var_1_10002(var_4.Find(var_11_2, "gem/Text"), var_11_1:getTotalGem())

	onButton = var_1_10002

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.resources
	local var_11_5 = var_5.Find(var_11_4, "gem")

	local function var_11_6()
		pg = var_2_10000

		local var_12_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_12_0)

		return
	end

	SFX_PANEL = var_11_4

	var_1_10002(var_11_3, var_11_5, var_11_6, var_11_4)

	return
end

function var_0_1.UpdateMainView(arg_13_0)
	ShipSkin = var_1_10001

	local var_13_0 = var_1_10001.IsChangeSkin(arg_13_0.skinId)

	setActive = var_1_10002

	var_1_10002(arg_13_0.changeSkin, var_13_0)

	if var_13_0 then
		arg_13_0:FlushChangeSkin()
	end

	arg_13_0:FlushName()
	arg_13_0:FlushSkin()
	arg_13_0:FlushPaintingToggle()
	arg_13_0:FlushTag()
	arg_13_0:FlushBG()
	arg_13_0:FlushPainting()

	return
end

function var_0_1.FlushChangeSkin(arg_14_0)
	ShipSkin = var_1_10001

	local var_14_0 = var_1_10001.GetChangeSkinGroupId(arg_14_0.skinId)

	if not arg_14_0.changeSkinId then
		arg_14_0.changeSkinId = arg_14_0.skinId
	else
		ShipSkin = var_2

		if var_2.GetChangeSkinGroupId(arg_14_0.changeSkinId) == var_14_0 then
			arg_14_0.skinId = arg_14_0.changeSkinId
			ShipSkin = var_3
			arg_14_0.shipSkin = var_3.New({
				id = arg_14_0.skinId
			})
		else
			arg_14_0.changeSkinId = arg_14_0.skinId
		end
	end

	ShipSkin = var_2
	arg_14_0._toggleIndex = var_2.GetChangeSkinIndex(arg_14_0.skinId)

	local var_14_1 = arg_14_0.changeSkinToggle

	var_2.setSkinData(var_14_1, arg_14_0.skinId)

	setActive = var_2

	local var_14_2 = arg_14_0.changeSkin
	local var_14_3 = arg_14_0.changeSkinToggle

	var_2(var_14_2, not var_5.IsAsmrSkin(var_14_3))

	return
end

function var_0_1.FlushName(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.ship_skin_template[arg_15_0.skinId]

	setScrollText = var_2

	local var_15_1 = arg_15_0.skinName

	SwitchSpecialChar = var_1_10005

	var_2(var_15_1, var_1_10005(var_15_0.name, true))

	local var_15_2 = var_15_0.skin_type

	ShipSkin = var_1_10003

	if var_15_2 == var_1_10003.SKIN_TYPE_TB then
		setScrollText = var_15_2

		local var_15_3 = arg_15_0.shipName

		NewEducateHelper = var_5

		local var_15_4 = var_5.GetShipNameBySecId

		NewEducateHelper = var_7

		var_15_2(var_15_3, var_15_4(var_7.GetSecIdBySkinId(arg_15_0.skinId)))
	else
		ShipGroup = var_15_2

		local var_15_5 = var_15_2.getDefaultShipConfig(var_15_0.ship_group)

		setScrollText = var_3

		var_3(arg_15_0.shipName, var_15_5.name)
	end

	return
end

function var_0_1.FlushSkin(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.ship_skin_template[arg_16_0.skinId].skin_type

	ShipSkin = var_2

	if var_16_0 == var_2.SKIN_TYPE_TB then
		setActive = var_16_0

		var_16_0(arg_16_0.charContainer, false)

		return
	end

	setActive = var_16_0

	var_16_0(arg_16_0.charContainer, true)

	pg = var_16_0

	local var_16_1 = var_16_0.ship_skin_template[arg_16_0.skinId]

	arg_16_0:FlushChar(var_16_1.prefab, var_16_1.id)

	GetImageSpriteFromAtlasAsync = var_2

	var_2("qicon/" .. var_16_1.painting, "", arg_16_0.backChara)

	return
end

function var_0_1.FlushChar(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.prefabName and arg_17_0.prefabName == arg_17_1 then
		return
	end

	arg_17_0:ReturnChar()

	arg_17_0.prefabName = arg_17_1
	PoolMgr = var_3

	local var_17_0 = var_3.GetInstance()

	var_3.GetSpineChar(var_17_0, arg_17_1, true, function(arg_18_0)
		if arg_17_0.prefabName ~= arg_17_1 then
			PoolMgr = var_1
			var_2_10003 = var_1.GetInstance()

			var_1.ReturnSpineChar(var_2_10003, arg_17_1, arg_18_0)

			return
		end

		local var_18_0 = arg_17_0

		tf = var_2
		var_18_0.spineChar = var_2(arg_18_0)
		pg = var_18_0

		if var_18_0.skinshop_spine_scale[arg_17_2] then
			local var_18_1 = arg_17_0.spineChar

			Vector3 = var_2_10003
			var_18_1.localScale = var_2_10003(var_1.skinshop_scale, var_1.skinshop_scale, 1)
		else
			local var_18_2 = arg_17_0.spineChar

			Vector3 = var_2_10003
			var_18_2.localScale = var_2_10003(0.9, 0.9, 1)
		end

		local var_18_3 = arg_17_0.spineChar

		Vector3 = var_2_10003
		var_18_3.localPosition = var_2_10003(0, 0, 0)
		pg = var_18_3

		local var_18_4 = var_18_3.ViewUtils.SetLayer
		local var_18_5 = arg_17_0.spineChar

		Layer = var_5

		var_18_4(var_18_5, var_5.UI)

		setParent = var_18_4

		var_18_4(arg_17_0.spineChar, arg_17_0.charTf)

		local var_18_6 = arg_18_0:GetComponent("SpineAnimUI")

		var_2.SetAction(var_18_6, "normal", 0)

		return
	end)

	return
end

function var_0_1.FlushPaintingToggle(arg_19_0)
	removeOnToggle = var_1_10001

	var_1_10001(arg_19_0.dynamicToggle)

	removeOnToggle = var_1_10001

	var_1_10001(arg_19_0.showBgToggle)

	checkABExist = var_1_10001

	local var_19_0 = "painting/"
	local var_19_1 = arg_19_0.shipSkin
	local var_19_2 = var_1_10001(var_19_0 .. var_4.getConfig(var_19_1, "painting") .. "_n")

	if arg_19_0.isToggleShowBg and not var_19_2 then
		triggerToggle = var_2

		var_2(arg_19_0.showBgToggle, false)

		arg_19_0.isToggleShowBg = false
	elseif var_19_2 then
		triggerToggle = var_2

		var_2(arg_19_0.showBgToggle, true)

		arg_19_0.isToggleShowBg = true
	end

	local var_19_3 = arg_19_0.shipSkin
	local var_19_4

	if not var_2.IsSpine(var_19_3) then
		var_19_3 = arg_19_0.shipSkin

		if not var_2.IsLive2d(var_19_3) then
			var_19_3 = arg_19_0.shipSkin

			if not var_2.IsSpinePlus(var_19_3) then
				var_19_3 = arg_19_0.shipSkin
				var_19_4 = var_2.IsLive2dPlus(var_19_3)
			end
		end
	end

	if var_19_4 then
		PlayerPrefs = var_3

		local var_19_5 = var_3.GetInt
		local var_19_6 = "skinShop#l2dPreViewToggle"

		getProxy = var_19_1
		PlayerProxy = var_1_10008
		var_1_10008 = var_19_1(var_1_10008)

		if var_19_5(var_19_6 .. var_19_1.getRawData(var_1_10008).id, 0) == 1 then
			arg_19_0.isToggleDynamic = true
		end
	end

	if var_19_4 then
		local var_19_7 = 0

		var_19_1 = arg_19_0.shipSkin

		if var_19_3.IsSpine(var_19_1) then
			var_19_7 = 6
		else
			var_19_1 = arg_19_0.shipSkin

			if var_19_3.IsLive2d(var_19_1) then
				var_19_7 = 1
			else
				var_19_1 = arg_19_0.shipSkin

				if var_19_3.IsSpinePlus(var_19_1) then
					var_19_7 = 7
				else
					var_19_1 = arg_19_0.shipSkin

					if var_19_3.IsLive2dPlus(var_19_1) then
						var_19_7 = 9
					end
				end
			end
		end

		LoadImageSpriteAtlasAsync = var_19_3
		var_19_1 = "SkinIcon"

		local var_19_8 = "type_"

		ShipSkin = var_1_10008

		var_19_3(var_19_1, var_19_8 .. var_1_10008.Tag2Name(var_19_7) .. "_off", arg_19_0.dynamicToggle)

		LoadImageSpriteAtlasAsync = var_19_3
		var_19_1 = "SkinIcon"

		local var_19_9 = "type_"

		ShipSkin = var_1_10008

		local var_19_10 = var_19_9 .. var_1_10008.Tag2Name(var_19_7)
		local var_19_11 = arg_19_0.dynamicToggle

		var_19_3(var_19_1, var_19_10, var_1_10008.Find(var_19_11, "select"))
	end

	if arg_19_0.isToggleDynamic and not var_19_4 then
		triggerToggle = var_19_13

		var_19_13(arg_19_0.dynamicToggle, false)

		arg_19_0.isToggleDynamic = false

		goto label_19_0
	end

	if arg_19_0.isToggleDynamic then
		local var_19_12 = arg_19_0.dynamicToggle
		local var_19_13 = var_19_13.GetComponent

		typeof = var_19_1
		Toggle = var_1_10008

		if not var_19_13(var_19_12, var_19_1(var_1_10008)).isOn then
			local var_19_14 = arg_19_0.shipSkin

			if not var_19_13.IsLive2d(var_19_14) then
				var_19_14 = arg_19_0.shipSkin

				if var_19_13.IsLive2dPlus(var_19_14) then
					Live2dConst = var_19_13

					if var_19_13.GetLive2DArm32MatchAble() then
						arg_19_0.isToggleDynamic = false
						getProxy = var_19_13
						PlayerProxy = var_19_14

						local var_19_15 = var_19_13(var_19_14)

						var_19_13 = var_19_13.getRawData(var_19_15).id
						PlayerPrefs = var_19_3

						var_19_3.SetInt("skinShop#l2dPreViewToggle" .. var_19_13, 0)

						PlayerPrefs = var_4

						var_4.Save()

						triggerToggle = var_4

						var_4(arg_19_0.dynamicToggle, false)

						goto label_19_0
					end
				end

				triggerToggle = var_19_13

				var_19_13(arg_19_0.dynamicToggle, true)

				arg_19_0.isToggleDynamic = true

				::label_19_0::

				if var_19_2 then
					onToggle = var_19_13

					local var_19_16 = arg_19_0
					local var_19_17 = arg_19_0.showBgToggle

					local function var_19_18(arg_20_0)
						arg_19_0.isToggleShowBg = arg_20_0

						local var_20_0 = arg_19_0

						var_1.FlushPainting(var_20_0)

						local var_20_1 = arg_19_0

						var_1.FlushBG(var_20_1)

						return
					end

					SFX_PANEL = var_1_10008

					var_19_13(var_19_16, var_19_17, var_19_18, var_1_10008)
				end

				local var_19_19 = arg_19_0.shipSkin

				if not var_3.IsSpine(var_19_19) then
					local var_19_20 = arg_19_0.shipSkin

					if not var_3.IsLive2d(var_19_20) then
						local var_19_21 = arg_19_0.shipSkin

						if not var_3.IsSpinePlus(var_19_21) then
							local var_19_22 = arg_19_0.shipSkin

							if var_3.IsLive2dPlus(var_19_22) then
								onToggle = var_3

								local var_19_23 = arg_19_0
								local var_19_24 = arg_19_0.dynamicToggle

								local function var_19_25(arg_21_0)
									if arg_21_0 then
										Live2dConst = var_2_10001

										if var_2_10001.GetLive2DArm32MatchAble() then
											local var_21_0 = arg_19_0.shipSkin

											if not var_1.IsLive2d(var_21_0) then
												local var_21_1 = arg_19_0.shipSkin

												if var_1.IsLive2dPlus(var_21_1) then
													Live2dConst = var_1

													var_1.ShowLive2DArm32Tips()

													triggerToggle = var_1

													var_1(arg_19_0.dynamicToggle, false)

													return
												end

												local var_21_2 = arg_19_0

												var_21_2.isToggleDynamic = arg_21_0
												setActive = var_21_2

												var_21_2(arg_19_0.showBgToggle, not arg_21_0 and var_19_2)

												local var_21_3 = arg_19_0

												var_1.FlushPainting(var_21_3)

												local var_21_4 = arg_19_0

												var_1.FlushDynamicPaintingResState(var_21_4)

												local var_21_5 = arg_19_0

												var_1.RecordFlag(var_21_5, arg_21_0)

												return
											end
										end
									end
								end

								SFX_PANEL = var_1_10008

								var_3(var_19_23, var_19_24, var_19_25, var_1_10008)
							end

							if arg_19_0.isToggleDynamic then
								arg_19_0:FlushDynamicPaintingResState()
							end

							setActive = var_3

							var_3(arg_19_0.dynamicToggle, var_19_4)

							setActive = var_3

							var_3(arg_19_0.showBgToggle, not arg_19_0.isToggleDynamic and var_19_2)

							return
						end
					end
				end
			end
		end
	end
end

function var_0_1.FlushPainting(arg_22_0)
	local var_22_0 = arg_22_0:GetPaintingState()

	pg = var_1_10002

	local var_22_1 = var_1_10002.ship_skin_template[arg_22_0.skinId].painting

	ShipSkin = var_3

	local var_22_2 = var_3.GetChangeSkinData(arg_22_0.skinId) and true or false

	if var_22_0 == var_0_3 and not arg_22_0:ExistL2dRes(var_22_1) or var_22_0 == var_0_4 and not arg_22_0:ExistSpineRes(var_22_1) then
		var_22_0 = var_0_2
	end

	if arg_22_0.paintingState and arg_22_0.paintingState.state == var_22_0 and arg_22_0.paintingState.id == arg_22_0.skinId and arg_22_0.paintingState.showBg == arg_22_0.isToggleShowBg and not var_22_2 then
		return
	end

	arg_22_0:ClearPainting()

	if var_22_0 == var_0_2 then
		arg_22_0:LoadMeshPainting(arg_22_0.isToggleShowBg)
	elseif var_22_0 == var_0_3 then
		arg_22_0:LoadL2dPainting()
	elseif var_22_0 == var_0_4 then
		arg_22_0:LoadSpinePainting()
	end

	arg_22_0.paintingState = {
		state = var_22_0,
		id = arg_22_0.skinId,
		showBg = arg_22_0.isToggleShowBg
	}

	arg_22_0:AdjustPainting(false)

	return
end

function var_0_1.GetPaintingState(arg_23_0)
	if arg_23_0.isToggleDynamic then
		local var_23_0 = arg_23_0.shipSkin

		if not var_1.IsLive2d(var_23_0) then
			local var_23_1 = arg_23_0.shipSkin

			if var_1.IsLive2dPlus(var_23_1) then
				do return var_0_3 end

				goto label_23_0
			end

			if arg_23_0.isToggleDynamic then
				local var_23_2 = arg_23_0.shipSkin

				if not var_1.IsSpine(var_23_2) then
					do
						local var_23_3 = arg_23_0.shipSkin

						if var_1.IsSpinePlus(var_23_3) then
							local var_23_4 = arg_23_0.shipSkin

							if var_1.getConfig(var_23_4, "spine_use_live2d") == 1 then
								return var_0_3
							end

							do return var_0_4 end

							goto label_23_0
						end

						return var_0_2
					end

					::label_23_0::

					return
				end
			end
		end
	end
end

function var_0_1.ExistL2dRes(arg_24_0, arg_24_1)
	local var_24_0 = "live2d/"

	string = var_1_10003

	local var_24_1 = var_24_0 .. var_1_10003.lower(arg_24_1)

	HXSet = var_3

	local var_24_2 = var_3.autoHxShiftPath(var_24_1, nil, true)

	checkABExist = var_3

	return var_3(var_24_2), var_24_2
end

function var_0_1.ExistSpineRes(arg_25_0, arg_25_1)
	local var_25_0 = "SpinePainting/"

	string = var_1_10003

	local var_25_1 = var_25_0 .. var_1_10003.lower(arg_25_1)

	HXSet = var_3

	local var_25_2 = var_3.autoHxShiftPath(var_25_1, nil, true)

	checkABExist = var_3

	return var_3(var_25_2), var_25_2
end

function var_0_1.FlushBG(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.skinId

	pg = var_1_10003

	local var_26_1 = var_1_10003.ship_skin_template[var_26_0]
	local var_26_2
	local var_26_3 = var_26_1.skin_type

	ShipSkin = var_1_10006

	if var_26_3 == var_1_10006.SKIN_TYPE_TB then
		VirtualEducateCharShip = var_26_3
		var_26_3 = var_26_3.New
		NewEducateHelper = var_1_10007
		var_26_2 = var_26_3(var_1_10007.GetSecIdBySkinId(var_26_0))
	else
		ShipGroup = var_26_3

		local var_26_4 = var_26_3.getDefaultShipConfig(var_26_1.ship_group)

		Ship = var_6
		var_26_2 = var_6.New({
			id = 999,
			configId = var_26_4.id,
			skin_id = var_26_0
		})
	end

	local var_26_5 = var_26_2:getShipBgPrint(true)

	pg = var_6

	local var_26_6 = var_6.ship_skin_template[var_26_0].painting

	if not arg_26_0.isToggleShowBg then
		checkABExist = var_7

		if not var_7("painting/" .. var_26_6 .. "_n") then
			if var_26_1.bg_sp ~= "" then
				var_26_5 = var_26_1.bg_sp
			end
		end

		local var_26_8

		if var_26_5 ~= var_26_2:rarity2bgPrintForGet() then
			pg = var_26_8

			local var_26_7 = var_26_8.DynamicBgMgr.GetInstance()

			var_26_8 = var_26_8.LoadBg

			local var_26_9 = arg_26_0
			local var_26_10 = var_26_5
			local var_26_11 = arg_26_0.bgs
			local var_26_12 = var_13.Find(var_26_11, "diffBg")
			local var_26_13 = arg_26_0.bgs

			var_26_8(var_26_7, var_26_9, var_26_10, var_26_12, var_14.Find(var_26_13, "diffBg/bg"), function(arg_27_0)
				if arg_26_1 then
					arg_26_1()
				end

				return
			end, function(arg_28_0)
				if arg_26_1 then
					arg_26_1()
				end

				return
			end)
		else
			pg = var_26_8

			local var_26_14 = var_26_8.DynamicBgMgr.GetInstance()

			var_26_8.ClearBg(var_26_14, arg_26_0:getUIName())

			if arg_26_1 then
				arg_26_1()
			end
		end

		setActive = var_26_8

		local var_26_15 = arg_26_0.bgs

		var_26_8(var_10.Find(var_26_15, "diffBg"), var_7)

		setActive = var_26_8

		local var_26_16 = arg_26_0.bgs

		var_26_8(var_10.Find(var_26_16, "default"), not var_7)

		return
	end
end

function var_0_1.FlushDynamicPaintingResState(arg_29_0)
	if not arg_29_0.isToggleDynamic then
		return
	end

	local var_29_0 = arg_29_0:GetPaintingState()
	local var_29_1 = false
	local var_29_2 = ""

	pg = var_1_10004

	local var_29_3 = var_1_10004.ship_skin_template[arg_29_0.skinId].painting
	local var_29_4

	if var_0_3 == var_29_0 then
		local var_29_5

		var_29_4, var_29_5 = arg_29_0:ExistL2dRes(var_29_3)
		var_29_2 = var_29_5
		var_29_1 = var_29_4
	elseif var_0_4 == var_29_0 then
		local var_29_6

		var_29_4, var_29_6 = arg_29_0:ExistSpineRes(var_29_3)
		var_29_2 = var_29_6
		var_29_1 = var_29_4
	end

	setActive = var_29_4

	var_29_4(arg_29_0.dynamicResToggle, not var_29_1)

	removeOnButton = var_29_4

	var_29_4(arg_29_0.dynamicResToggle)

	if not var_29_1 and var_29_2 ~= "" then
		onButton = var_29_4

		local var_29_7 = arg_29_0
		local var_29_8 = arg_29_0.dynamicResToggle

		local function var_29_9()
			local var_30_0 = arg_29_0

			var_0.DownloadDynamicPainting(var_30_0, var_29_2)

			return
		end

		SFX_PANEL = var_1_10010

		var_29_4(var_29_7, var_29_8, var_29_9, var_1_10010)
	end

	return
end

function var_0_1.DownloadDynamicPainting(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.skinId

	if arg_31_0.downloads[var_31_0] then
		return
	end

	SkinShopDownloadRequest = var_3

	local var_31_1 = var_3.New()

	arg_31_0.downloads[var_31_0] = var_31_1

	var_31_1:Start(arg_31_1, function(arg_32_0)
		if arg_32_0 and arg_31_0.paintingState and arg_31_0.paintingState.id == arg_31_0.skinId then
			local var_32_0 = arg_31_0

			var_1.FlushPainting(var_32_0)

			local var_32_1 = arg_31_0

			var_1.FlushDynamicPaintingResState(var_32_1)
		end

		local var_32_2 = var_31_1

		var_1.Dispose(var_32_2)

		arg_31_0.downloads[var_31_0] = nil

		return
	end)

	return
end

function var_0_1.RecordFlag(arg_33_0, arg_33_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_33_0 = var_1_10002(var_1_10004)
	local var_33_1 = var_2.getRawData(var_33_0).id

	PlayerPrefs = var_1_10003

	var_1_10003.SetInt("skinShop#l2dPreViewToggle" .. var_33_1, arg_33_1 and 1 or 0)

	PlayerPrefs = var_3

	var_3.Save()

	local var_33_2 = arg_33_0
	local var_33_3 = arg_33_0.emit

	LatestSkinShopMediator = var_6

	var_33_3(var_33_2, var_6.ON_RECORD_ANIM_PREVIEW_BTN, arg_33_1)

	return
end

function var_0_1.LoadMeshPainting(arg_34_0, arg_34_1)
	findTF = var_1_10002

	local var_34_0 = var_1_10002(arg_34_0.paintingTF, "fitter")

	GetOrAddComponent = var_1_10003

	local var_34_1 = var_1_10003(var_34_0, "PaintingScaler")

	var_34_1.FrameName = "chuanwu"
	var_34_1.Tween = 1
	pg = var_4

	local var_34_2 = var_4.ship_skin_template[arg_34_0.skinId].painting
	local var_34_3

	if not arg_34_1 then
		checkABExist = var_6

		if var_6("painting/" .. var_34_3 .. "_n") then
			var_34_3 = var_34_3 .. "_n"
		end
	end

	checkABExist = var_6

	if not var_6("painting/" .. var_34_3) then
		return
	end

	pg = var_6

	local var_34_4 = var_6.UIMgr.GetInstance()

	var_6.LoadingOn(var_34_4)

	PoolMgr = var_6

	local var_34_5 = var_6.GetInstance()

	var_6.GetPainting(var_34_5, var_34_3, true, function(arg_35_0)
		pg = var_2_10001

		local var_35_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_35_0)

		setParent = var_1

		var_1(arg_35_0, var_34_0, false)

		ShipExpressionHelper = var_1

		local var_35_1 = var_1.SetExpression
		local var_35_2 = var_34_0

		var_35_1(var_3.GetChild(var_35_2, 0), var_34_2)

		arg_34_0.paintingName = var_34_3

		if arg_34_0.paintingState and arg_34_0.paintingState.id ~= arg_34_0.skinId then
			local var_35_3 = arg_34_0

			var_1.ClearMeshPainting(var_35_3)
		end

		return
	end)

	return
end

function var_0_1.ClearMeshPainting(arg_36_0)
	local var_36_0 = arg_36_0.paintingTF
	local var_36_1 = var_1.Find(var_36_0, "fitter")

	if arg_36_0.paintingName then
		local var_36_2 = var_36_1.childCount

		if 0 < var_36_2 then
			local var_36_3 = var_36_1:GetChild(0).gameObject

			PoolMgr = var_3

			local var_36_4 = var_3.GetInstance()

			var_3.ReturnPainting(var_36_4, arg_36_0.paintingName, var_36_3)
		end
	end

	arg_36_0.paintingName = nil

	return
end

function var_0_1.LoadL2dPainting(arg_37_0)
	local var_37_0 = arg_37_0.skinId

	pg = var_1_10002

	local var_37_1 = var_1_10002.ship_skin_template[var_37_0].skin_type
	local var_37_2

	ShipSkin = var_1_10004

	local var_37_3

	if var_37_1 == var_1_10004.SKIN_TYPE_TB then
		VirtualEducateCharShip = var_37_3
		var_37_3 = var_37_3.New
		NewEducateHelper = var_1_10006
		var_37_2 = var_37_3(var_1_10006.GetSecIdBySkinId(var_37_0))
	else
		pg = var_37_3
		var_37_3 = var_37_3.ship_skin_template[var_37_0].ship_group
		ShipGroup = var_1_10005
		var_1_10005 = var_1_10005.getDefaultShipConfig(var_37_3)
		Ship = var_1_10006
		var_37_2 = var_1_10006.New({
			noChangeSkin = true,
			configId = var_1_10005.id,
			skin_id = var_37_0
		})
	end

	Live2DPainting = var_37_3

	local var_37_4 = var_37_3.GenerateData
	local var_37_5 = {
		ship = var_37_2
	}

	Vector3 = var_1_10007
	var_37_5.position = var_1_10007(0, 0, -1)
	var_37_5.parent = arg_37_0.live2dContainer
	var_37_5.offset = var_37_2:GetSkinConfig().shop_offset

	local var_37_6 = var_37_4(var_37_5)

	pg = var_1_10005

	local var_37_7 = var_1_10005.UIMgr.GetInstance()

	var_5.LoadingOn(var_37_7)

	Live2DPainting = var_5
	arg_37_0.live2dChar = var_5.New(var_37_6, function(arg_38_0)
		arg_38_0:IgonreReactPos(true)

		if arg_37_0.paintingState and arg_37_0.paintingState.id ~= arg_37_0.skinId then
			local var_38_0 = arg_37_0

			var_1.ClearL2dPainting(var_38_0)
		end

		local var_38_1 = arg_38_0
		local var_38_2 = arg_38_0.setSortingLayer

		LayerWeightConst = var_4

		var_38_2(var_38_1, var_4.L2D_DEFAULT_LAYER)

		pg = var_38_2

		local var_38_3 = var_38_2.UIMgr.GetInstance()

		var_1.LoadingOff(var_38_3)

		return
	end)

	return
end

function var_0_1.ClearL2dPainting(arg_39_0)
	if arg_39_0.live2dChar then
		local var_39_0 = arg_39_0.live2dChar

		var_1.Dispose(var_39_0)

		arg_39_0.live2dChar = nil
	end

	return
end

function var_0_1.LoadSpinePainting(arg_40_0)
	local var_40_0 = arg_40_0.skinId

	pg = var_1_10002

	local var_40_1 = var_1_10002.ship_skin_template[var_40_0].skin_type
	local var_40_2

	ShipSkin = var_1_10004

	local var_40_3

	if var_40_1 == var_1_10004.SKIN_TYPE_TB then
		VirtualEducateCharShip = var_40_3
		var_40_3 = var_40_3.New
		NewEducateHelper = var_1_10006
		var_40_2 = var_40_3(var_1_10006.GetSecIdBySkinId(var_40_0))
	else
		pg = var_40_3
		var_40_3 = var_40_3.ship_skin_template[var_40_0].ship_group
		ShipGroup = var_1_10005
		var_1_10005 = var_1_10005.getDefaultShipConfig(var_40_3)
		Ship = var_1_10006
		var_40_2 = var_1_10006.New({
			noChangeSkin = true,
			configId = var_1_10005.id,
			skin_id = var_40_0
		})
	end

	SpinePainting = var_40_3

	local var_40_4 = var_40_3.GenerateData
	local var_40_5 = {
		ship = var_40_2
	}

	Vector3 = var_1_10007
	var_40_5.position = var_1_10007(0, 0, 0)
	var_40_5.parent = arg_40_0.spTF
	var_40_5.effectParent = arg_40_0.spBg
	var_40_5.offset = var_40_2:GetSkinConfig().shop_offset

	local var_40_6 = var_40_4(var_40_5)

	pg = var_1_10005

	local var_40_7 = var_1_10005.UIMgr.GetInstance()

	var_5.LoadingOn(var_40_7)

	SpinePainting = var_5
	arg_40_0.spinePainting = var_5.New(var_40_6, function(arg_41_0)
		if arg_40_0.paintingState and arg_40_0.paintingState.id ~= arg_40_0.skinId then
			local var_41_0 = arg_40_0

			var_1.ClearSpinePainting(var_41_0)
		end

		local var_41_1 = arg_40_0

		var_1.InitSpecialTouch(var_41_1, var_40_2, arg_40_0.spTF)

		pg = var_1

		local var_41_2 = var_1.UIMgr.GetInstance()

		var_1.LoadingOff(var_41_2)

		return
	end)

	return
end

function var_0_1.ClearSpinePainting(arg_42_0)
	if arg_42_0.spinePainting and arg_42_0.spinePainting._tf then
		local var_42_0 = arg_42_0.spinePainting._tf
		local var_42_1 = var_1.Find(var_42_0, "shop_hx")
		local var_42_2 = arg_42_0.spinePainting

		var_2.Dispose(var_42_2)

		arg_42_0.spinePainting = nil

		if arg_42_0.dragEvent then
			ClearEventTrigger = var_2

			var_2(arg_42_0.dragEvent)
		end
	end

	return
end

function var_0_1.InitSpecialTouch(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_1
	local var_43_1 = arg_43_1.getPainting(var_43_0)

	findTF = var_1_10004

	if not var_1_10004(arg_43_2:GetChild(0), "hitArea") then
		return
	end

	eachChild = var_43_0

	var_43_0(var_4, function(arg_44_0)
		local var_44_0 = arg_43_0
		local var_44_1

		if var_1.getDragTouchAble(var_44_0, arg_44_0.name, var_43_1, false) then
			var_44_1 = arg_43_0
			GetOrAddComponent = var_2_10002

			local var_44_2 = arg_44_0

			typeof = var_5
			EventTriggerListener = var_2_10007
			var_44_1.dragEvent = var_2_10002(var_44_2, var_5(var_2_10007))

			local var_44_3 = arg_43_0.dragEvent

			var_44_1.AddPointDownFunc(var_44_3, function(arg_45_0, arg_45_1)
				arg_43_0.dragActive = true
				arg_43_0.dragStart = arg_45_1.position

				return
			end)

			local var_44_4 = arg_43_0.dragEvent

			var_44_1.AddPointUpFunc(var_44_4, function(arg_46_0, arg_46_1)
				if arg_43_0.dragActive then
					arg_43_0.dragActive = false

					local var_46_0 = arg_43_0

					Vector2 = var_3
					var_46_0.dragOffset = var_3(arg_43_0.dragStart.x - arg_46_1.position.x, arg_43_0.dragStart.y - arg_46_1.position.y)
					math = var_46_0

					if not (var_46_0.abs(arg_43_0.dragOffset.x) < 200) then
						math = var_2

						if var_2.abs(arg_43_0.dragOffset.y) < 200 then
							arg_43_0.dragUp = arg_46_1.position

							local var_46_1 = arg_43_0.spinePainting

							if var_2.isInAction(var_46_1) then
								return
							end

							local var_46_2
							local var_46_3 = arg_43_0

							if var_3.getDragTouchAble(var_46_3, arg_44_0.name, var_43_1, true) then
								local var_46_4 = arg_43_0.spinePainting
								local var_46_5 = var_3.readyDragAction(var_46_4, arg_44_0.name)
							end
						end

						return
					end
				end
			end)

			local var_44_5 = arg_43_0.dragEvent

			var_44_1.AddDragFunc(var_44_5, function(arg_47_0, arg_47_1)
				if arg_43_0.dragActive then
					local var_47_0 = arg_43_0

					Vector2 = var_3_10003
					var_47_0.dragOffset = var_3_10003(arg_43_0.dragStart.x - arg_47_1.position.x, arg_43_0.dragStart.y - arg_47_1.position.y)
					math = var_47_0

					if not (var_47_0.abs(arg_43_0.dragOffset.x) > 200) then
						math = var_2

						if var_2.abs(arg_43_0.dragOffset.y) > 200 then
							arg_43_0.dragActive = false

							local var_47_1 = arg_43_0.spinePainting

							var_2.readyDragAction(var_47_1, arg_44_0.name)
						end

						return
					end
				end
			end)
		else
			onButton = var_44_1

			var_44_1(arg_43_0, arg_44_0, function()
				local var_48_0 = arg_43_0.spinePainting

				if var_0.isInAction(var_48_0) then
					return
				end

				pg = var_0

				local var_48_1 = var_0.AssistantInfo.getPaintingTouchEvents(arg_44_0.name)
				local var_48_2 = arg_43_0

				if var_1.getDragTouchAble(var_48_2, arg_44_0.name, var_43_1, true) then
					local var_48_3 = arg_43_0.spinePainting

					var_1.readyDragAction(var_48_3, arg_44_0.name)
				end

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.getDragTouchAble(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	SpinePaintingConst = var_1_10004

	if not var_1_10004.ship_drag_datas[arg_49_2] then
		return false
	end

	if var_4.drag_data and var_4.click_trigger ~= arg_49_3 then
		return false
	end

	if var_4.hit_area then
		table = var_5

		return var_5.contains(var_4.hit_area, arg_49_1)
	end

	return false
end

function var_0_1.AdjustPainting(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0.paintingTF

	pg = var_1_10003

	local var_50_1

	if var_1_10003.ship_skin_newmainui_shift[arg_50_0.skinId] then
		var_50_1 = var_3.skin_shop_shift

		if arg_50_1 then
			Vector2 = var_1_10005
			var_50_0.anchoredPosition = var_1_10005(var_50_1[1] - 440, var_50_1[2] + arg_50_0.defaultPaintingPosition.y)
		else
			Vector2 = var_1_10005
			var_50_0.anchoredPosition = var_1_10005(var_50_1[1] + arg_50_0.defaultPaintingPosition.x, var_50_1[2] + arg_50_0.defaultPaintingPosition.y)
		end

		local var_50_2 = var_50_1[4]

		Vector3 = var_1_10006
		var_50_0.localScale = var_1_10006(var_50_2, var_50_2, 1)
	else
		Vector2 = var_50_1
		var_50_0.anchoredPosition = var_50_1(arg_50_0.defaultPaintingPosition.x, arg_50_0.defaultPaintingPosition.y)
		var_50_0.localScale = arg_50_0.defaultPaintingScale
	end

	return
end

function var_0_1.ReturnChar(arg_51_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_51_0.spineChar) then
		local var_51_0 = arg_51_0.spineChar.gameObject
		local var_51_1 = var_1.GetComponent(var_51_0, "SpineAnimUI")

		var_1.SetActionCallBack(var_51_1, nil)

		PoolMgr = var_2

		local var_51_2 = var_2.GetInstance()

		var_2.ReturnSpineChar(var_51_2, arg_51_0.prefabName, arg_51_0.spineChar.gameObject)

		arg_51_0.spineChar = nil
		arg_51_0.prefabName = nil
	end

	return
end

function var_0_1.FlushTag(arg_52_0)
	local var_52_0 = arg_52_0.skinId

	pg = var_1_10002

	local var_52_1 = var_1_10002.ship_skin_template[var_52_0]

	Clone = var_1_10003

	local var_52_2 = var_1_10003(var_52_1.tag)
	local var_52_3 = false

	for iter_52_0 = #var_52_2, 1, -1 do
		if var_52_2[iter_52_0] == 1 or var_9 == 6 or var_9 == 7 or var_9 == 9 then
			local var_52_4 = true

			table = var_1_10010

			var_1_10010.remove(var_52_2, iter_52_0)
		end
	end

	checkABExist = var_5

	local var_52_5 = "painting/"
	local var_52_6 = arg_52_0.shipSkin
	local var_52_7 = var_5(var_52_5 .. var_8.getConfig(var_52_6, "painting") .. "_n")
	local var_52_8 = arg_52_0.tagList

	var_6.make(var_52_8, function(arg_53_0, arg_53_1, arg_53_2)
		UIItemList = var_2_10003

		if arg_53_0 == var_2_10003.EventUpdate then
			local var_53_0 = var_52_2[arg_53_1 + 1]

			LoadSpriteAtlasAsync = var_4

			local var_53_1 = "SkinIcon"
			local var_53_2 = "type_"

			ShipSkin = var_2_10008

			var_4(var_53_1, var_53_2 .. var_2_10008.Tag2Name(var_52_2[arg_53_1 + 1]), function(arg_54_0)
				if arg_52_0.exited then
					return
				end

				local var_54_0 = arg_53_2
				local var_54_1 = var_1.GetComponent

				typeof = var_3_10004
				Image = var_3_10006
				var_54_1(var_54_0, var_3_10004(var_3_10006)).sprite = arg_54_0

				return
			end)
		end

		return
	end)

	local var_52_9 = arg_52_0.tagList

	var_6.align(var_52_9, #var_52_2)

	return
end

function var_0_1.ClearPainting(arg_55_0)
	if not arg_55_0.paintingState then
		return
	end

	if var_1.state == var_0_2 then
		arg_55_0:ClearMeshPainting()
	elseif var_1.state == var_0_3 then
		arg_55_0:ClearL2dPainting()
	elseif var_1.state == var_0_4 then
		arg_55_0:ClearSpinePainting()
	end

	arg_55_0.paintingState = nil

	return
end

function var_0_1.IsShowSelectShipView(arg_56_0)
	local var_56_2

	if arg_56_0.selectShipPage then
		local var_56_0 = arg_56_0.selectShipPage

		if var_1.GetLoaded(var_56_0) then
			local var_56_1 = arg_56_0.selectShipPage

			var_56_2 = var_1.isShowing(var_56_1)
		end
	end

	return var_56_2
end

function var_0_1.CloseSelectShipView(arg_57_0)
	local var_57_0 = arg_57_0.selectShipPage

	var_1.Hide(var_57_0)

	return
end

function var_0_1.willExit(arg_58_0)
	pg = var_1_10001

	local var_58_0 = var_1_10001.DynamicBgMgr.GetInstance()

	var_1.ClearBg(var_58_0, arg_58_0:getUIName())

	if arg_58_0.live2dChar then
		local var_58_1 = arg_58_0.live2dChar

		var_1.Dispose(var_58_1)

		arg_58_0.live2dChar = nil
	end

	pairs = var_1

	for iter_58_0, iter_58_1 in var_1(arg_58_0.downloads) do
		iter_58_1:Dispose()
	end

	arg_58_0.downloads = {}

	arg_58_0:ClearPainting()
	arg_58_0:ReturnChar()

	local var_58_2 = arg_58_0.selectShipPage

	var_1.Destroy(var_58_2)

	arg_58_0.selectShipPage = nil
	pg = var_1

	local var_58_3 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_58_3, arg_58_0._tf)

	return
end

function var_0_1.onBackPressed(arg_59_0)
	if arg_59_0:IsShowSelectShipView() then
		arg_59_0:CloseSelectShipView()

		return
	end

	var_0_1.super.onBackPressed(arg_59_0)

	return
end

return var_0_1
