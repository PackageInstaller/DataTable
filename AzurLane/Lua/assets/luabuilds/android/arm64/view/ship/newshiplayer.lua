class = var_0_10000

local var_0_0 = "NewShipLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.PAINT_DURATION = 0.35
var_0_1.STAR_DURATION = 0.5
var_0_1.STAR_ANIMATION_DUR1 = 0.075
var_0_1.STAR_ANIMATION_DUR2 = 0.1
var_0_1.STAR_ANIMATION_DUR3 = 0.4
var_0_1.STAR_ANIMATION_DUR4 = 0.26

local var_0_2 = 19

function var_0_1.getUIName(arg_1_0)
	return "NewShipUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.contextData.ship

	LoadSpriteAsync = var_1_10003

	var_1_10003("newshipbg/bg_" .. var_2_0:rarity2bgPrintForGet(), function(arg_3_0)
		arg_2_0.bgSprite = arg_3_0
		arg_2_0.isLoadBg = true

		arg_2_1()

		return
	end)

	return
end

function var_0_1.init(arg_4_0)
	GetComponent = var_1_10001
	arg_4_0._animator = var_1_10001(arg_4_0._tf, "Animator")
	GetOrAddComponent = var_1

	local var_4_0 = arg_4_0._tf

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_4_0._canvasGroup = var_1(var_4_0, var_4(var_1_10006))

	local var_4_1 = arg_4_0._tf

	arg_4_0._shake = var_1.Find(var_4_1, "shake_panel")

	local var_4_2 = arg_4_0._tf

	arg_4_0._shade = var_1.Find(var_4_2, "shade")

	local var_4_3 = arg_4_0._shake

	arg_4_0._bg = var_1.Find(var_4_3, "bg")

	local var_4_4 = arg_4_0._shake

	arg_4_0._drag = var_1.Find(var_4_4, "drag")

	local var_4_5 = arg_4_0._shake

	arg_4_0._paintingTF = var_1.Find(var_4_5, "paint")

	local var_4_6 = arg_4_0._shake

	arg_4_0._paintingShadowTF = var_1.Find(var_4_6, "shadow")

	local var_4_7 = arg_4_0._shake

	arg_4_0._dialogue = var_1.Find(var_4_7, "dialogue")

	local var_4_8 = arg_4_0._dialogue
	local var_4_9 = var_1.Find(var_4_8, "bg/name")
	local var_4_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_4_0._shipName = var_4_10(var_4_9, var_4(var_1_10006))

	local var_4_11 = arg_4_0._dialogue
	local var_4_12 = var_1.Find(var_4_11, "bg/type")
	local var_4_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_4_0._shipType = var_4_13(var_4_12, var_4(var_1_10006))

	local var_4_14 = arg_4_0._dialogue

	arg_4_0._dialogueText = var_1.Find(var_4_14, "Text")

	local var_4_15 = arg_4_0._shake

	arg_4_0._left = var_1.Find(var_4_15, "ForNotch/left_panel")

	local var_4_16 = arg_4_0._left

	arg_4_0._lockTF = var_1.Find(var_4_16, "lock")

	local var_4_17 = arg_4_0._left

	arg_4_0._lockBtn = var_1.Find(var_4_17, "lock/lock")

	local var_4_18 = arg_4_0._left

	arg_4_0._unlockBtn = var_1.Find(var_4_18, "lock/unlock_btn")

	local var_4_19 = arg_4_0._left

	arg_4_0._viewBtn = var_1.Find(var_4_19, "view_btn")

	local var_4_20 = arg_4_0._left

	arg_4_0._evaluationBtn = var_1.Find(var_4_20, "evaluation_btn")

	local var_4_21 = arg_4_0._left

	arg_4_0._shareBtn = var_1.Find(var_4_21, "share_btn")

	local var_4_22 = arg_4_0._shake

	arg_4_0.audioBtn = var_1.Find(var_4_22, "property_btn")

	local var_4_23 = arg_4_0._shake

	arg_4_0.clickTF = var_1.Find(var_4_23, "click")

	local var_4_24 = arg_4_0._tf

	arg_4_0.npc = var_1.Find(var_4_24, "shake_panel/npc")
	setActive = var_1

	var_1(arg_4_0.npc, false)

	local var_4_25 = arg_4_0._shake

	arg_4_0.newTF = var_1.Find(var_4_25, "New")

	local var_4_26 = arg_4_0._shake

	arg_4_0.rarityTF = var_1.Find(var_4_26, "rarity")

	local var_4_27 = arg_4_0.rarityTF

	arg_4_0.starsTF = var_1.Find(var_4_27, "stars")

	local var_4_28 = arg_4_0.starsTF

	arg_4_0.starsCont = var_1.Find(var_4_28, "content")

	local var_4_29 = arg_4_0._shake

	arg_4_0._skipButton = var_1.Find(var_4_29, "ForNotch/skip")
	setActive = var_1

	var_1(arg_4_0._skipButton, arg_4_0.contextData.canSkipBatch)

	setActive = var_1

	var_1(arg_4_0._left, true)

	setActive = var_1

	var_1(arg_4_0.audioBtn, true)

	pg = var_1

	local var_4_30 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_4_30, arg_4_0._tf)

	local var_4_31 = arg_4_0.rarityTF

	arg_4_0.metaRepeatTF = var_1.Find(var_4_31, "MetaRepeat")

	local var_4_32 = arg_4_0._shake

	arg_4_0.metaDarkTF = var_1.Find(var_4_32, "MetaMask")
	arg_4_0.rarityEffect = {}

	if arg_4_0.contextData.autoExitTime then
		Timer = var_1
		arg_4_0.autoExitTimer = var_1.New(function()
			local var_5_0 = arg_4_0

			var_0.showExitTip(var_5_0)

			return
		end, arg_4_0.contextData.autoExitTime)

		local var_4_33 = arg_4_0.autoExitTimer

		var_1.Start(var_4_33)

		arg_4_0.contextData.autoExitTime = nil
	end

	arg_4_0:PauseAnimation()

	return
end

function var_0_1.voice(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	arg_6_0:stopVoice()

	arg_6_0._currentVoice = arg_6_1
	pg = var_2

	local var_6_0 = var_2.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_6_0, arg_6_1)

	return
end

function var_0_1.stopVoice(arg_7_0)
	if arg_7_0._currentVoice then
		pg = var_1

		local var_7_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_7_0, arg_7_0._currentVoice)
	end

	arg_7_0._currentVoice = nil

	return
end

function var_0_1.setShip(arg_8_0, arg_8_1)
	arg_8_0:recyclePainting()

	arg_8_0._shipVO = arg_8_1
	arg_8_0.isRemoulded = arg_8_1:isRemoulded()

	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.isBluePrintShip(var_8_0)
	local var_8_2 = arg_8_1:isMetaShip()

	setImageSprite = var_8_0

	var_8_0(arg_8_0._bg, arg_8_0.bgSprite)

	setActive = var_8_0

	var_8_0(arg_8_0.metaDarkTF, arg_8_1:isMetaShip())

	if var_8_1 then
		if arg_8_0.metaBg then
			setActive = var_4

			var_4(arg_8_0.metaBg, false)
		end

		if arg_8_0.designBg and arg_8_0.designName ~= "raritydesign" .. arg_8_1:getRarity() then
			PoolMgr = var_4

			local var_8_3 = var_4.GetInstance()

			var_4.ReturnUI(var_8_3, arg_8_0.designName, arg_8_0.designBg)

			arg_8_0.designBg = nil
		end

		local var_8_5

		if not arg_8_0.designBg then
			PoolMgr = var_8_5

			local var_8_4 = var_8_5.GetInstance()

			var_8_5 = var_8_5.GetUI

			local var_8_6 = "raritydesign"

			var_1_10010 = arg_8_1

			var_8_5(var_8_4, var_8_6 .. arg_8_1.getRarity(var_1_10010), true, function(arg_9_0)
				arg_8_0.designBg = arg_9_0

				local var_9_0 = arg_8_0
				local var_9_1 = "raritydesign"
				local var_9_2 = arg_8_1

				var_9_0.designName = var_9_1 .. var_3.getRarity(var_9_2)

				local var_9_3 = arg_9_0.transform

				var_1.SetParent(var_9_3, arg_8_0._shake, false)

				local var_9_4 = arg_9_0.transform

				Vector3 = var_2
				var_9_4.localPosition = var_2(1, 1, 1)

				local var_9_5 = arg_9_0.transform

				Vector3 = var_2
				var_9_5.localScale = var_2(1, 1, 1)

				local var_9_6 = arg_9_0.transform

				var_1.SetSiblingIndex(var_9_6, 1)

				setActive = var_1

				var_1(arg_9_0, true)

				return
			end)
		else
			setActive = var_8_5

			var_8_5(arg_8_0.designBg, true)
		end
	elseif var_8_2 then
		if arg_8_0.designBg then
			setActive = var_4

			var_4(arg_8_0.designBg, false)
		end

		if arg_8_0.metaBg and arg_8_0.metaName ~= "raritymeta" .. arg_8_1:getRarity() then
			PoolMgr = var_4

			local var_8_7 = var_4.GetInstance()

			var_4.ReturnUI(var_8_7, arg_8_0.metaName, arg_8_0.metaBg)

			arg_8_0.metaBg = nil
		end

		local var_8_9

		if not arg_8_0.metaBg then
			PoolMgr = var_8_9

			local var_8_8 = var_8_9.GetInstance()

			var_8_9 = var_8_9.GetUI

			local var_8_10 = "raritymeta"

			var_1_10010 = arg_8_1

			var_8_9(var_8_8, var_8_10 .. arg_8_1.getRarity(var_1_10010), true, function(arg_10_0)
				arg_8_0.metaBg = arg_10_0

				local var_10_0 = arg_8_0
				local var_10_1 = "raritymeta"
				local var_10_2 = arg_8_1

				var_10_0.metaName = var_10_1 .. var_3.getRarity(var_10_2)

				local var_10_3 = arg_10_0.transform

				var_1.SetParent(var_10_3, arg_8_0._shake, false)

				local var_10_4 = arg_10_0.transform

				Vector3 = var_2
				var_10_4.localPosition = var_2(1, 1, 1)

				local var_10_5 = arg_10_0.transform

				Vector3 = var_2
				var_10_5.localScale = var_2(1, 1, 1)

				local var_10_6 = arg_10_0.transform

				var_1.SetSiblingIndex(var_10_6, 1)

				setActive = var_1

				var_1(arg_10_0, true)

				return
			end)
		else
			setActive = var_8_9

			var_8_9(arg_8_0.metaBg, true)
		end
	else
		if arg_8_0.designBg then
			setActive = var_4

			var_4(arg_8_0.designBg, false)
		end

		if arg_8_0.metaBg then
			setActive = var_4

			var_4(arg_8_0.metaBg, false)
		end
	end

	local var_8_11

	if arg_8_1.virgin and not arg_8_0.isRemoulded and not arg_8_1:isActivityNpc() then
		setActive = var_8_11

		var_8_11(arg_8_0.newTF, true)

		LoadImageSpriteAsync = var_8_11

		var_8_11("clutter/new", arg_8_0.newTF)

		OPEN_TEC_TREE_SYSTEM = var_8_11

		if var_8_11 then
			table = var_8_11
			var_8_11 = var_8_11.indexof
			pg = var_6

			if var_8_11(var_6.fleet_tech_ship_template.all, arg_8_0._shipVO.groupId, 1) then
				pg = var_8_11
				var_8_11 = var_8_11.fleet_tech_ship_template[arg_8_0._shipVO.groupId].pt_get
				ShipType = var_5

				local var_8_12 = var_5.FilterOverQuZhuType

				pg = var_7

				local var_8_13 = var_8_12(var_7.fleet_tech_ship_template[arg_8_0._shipVO.groupId].add_get_shiptype)

				pg = var_6

				local var_8_14 = var_6.fleet_tech_ship_template[arg_8_0._shipVO.groupId].add_get_attr

				pg = var_7

				local var_8_15 = var_7.fleet_tech_ship_template[arg_8_0._shipVO.groupId].add_get_value

				pg = var_8
				var_1_10010 = var_8.ToastMgr.GetInstance()

				local var_8_16 = var_8.ShowToast

				pg = var_1_10011

				var_8_16(var_1_10010, var_1_10011.ToastMgr.TYPE_TECPOINT, {
					point = var_8_11,
					typeList = var_8_13,
					attr = var_8_14,
					value = var_8_15
				})
			end
		end
	else
		setActive = var_8_11

		var_8_11(arg_8_0.newTF, false)

		var_8_11 = arg_8_1:getReMetaSpecialItemVO()

		arg_8_0:updateLockTF(var_8_11 ~= nil)

		local var_8_18

		if var_8_11 then
			local var_8_17 = arg_8_0.metaRepeatTF

			var_8_18 = var_8_18.Find(var_8_17, "Icon")

			local var_8_19 = arg_8_0.metaRepeatTF
			local var_8_20 = var_6.Find(var_8_19, "Count")

			setImageSprite = var_8_17

			local var_8_21 = var_8_18

			LoadSprite = var_1_10010

			var_8_17(var_8_21, var_1_10010(var_8_11:getConfig("icon")))

			GetImageSpriteFromAtlasAsync = var_8_17

			var_8_17(var_8_11:getConfig("icon"), "", var_8_18)

			setText = var_8_17

			var_8_17(var_8_20, var_8_11.count)

			pg = var_8_17

			local var_8_22 = var_8_17.ship_transform[arg_8_0._shipVO.groupId].exclusive_item[1][2]

			pg = var_8

			local var_8_23 = var_8.ship_transform[arg_8_0._shipVO.groupId].common_item[1][2]
			local var_8_24 = arg_8_0.metaRepeatTF
			local var_8_25 = var_9.Find(var_8_24, "Special")
			local var_8_26 = arg_8_0.metaRepeatTF
			local var_8_27 = var_10.Find(var_8_26, "Commom")

			setActive = var_8_24

			var_8_24(var_8_25, var_8_11.id == var_8_22)

			setActive = var_8_24

			var_8_24(var_8_27, var_8_11.id == var_8_23)
		else
			setActive = var_8_18

			var_8_18(arg_8_0.metaRepeatTF, false)
		end
	end

	setActive = var_8_11

	var_8_11(arg_8_0.audioBtn, not arg_8_0.isRemoulded)

	local var_8_28 = arg_8_0
	local var_8_29 = arg_8_0.UpdateLockButton
	local var_8_30 = arg_8_0._shipVO

	var_8_29(var_8_28, var_7.GetLockState(var_8_30))

	local var_8_31 = arg_8_0._shipVO
	local var_8_32 = var_4.getConfigTable(var_8_31)

	if arg_8_0.isRemoulded then
		setPaintingPrefabAsync = var_5

		local var_8_33 = arg_8_0._paintingTF
		local var_8_34 = arg_8_0._shipVO

		var_5(var_8_33, var_8.getRemouldPainting(var_8_34), "huode")

		setPaintingPrefabAsync = var_5

		local var_8_35 = arg_8_0._paintingShadowTF
		local var_8_36 = arg_8_0._shipVO

		var_5(var_8_35, var_8.getRemouldPainting(var_8_36), "huode")
	else
		setPaintingPrefabAsync = var_5

		local var_8_37 = arg_8_0._paintingTF
		local var_8_38 = arg_8_0._shipVO

		var_5(var_8_37, var_8.getPainting(var_8_38), "huode")

		setPaintingPrefabAsync = var_5

		local var_8_39 = arg_8_0._paintingShadowTF
		local var_8_40 = arg_8_0._shipVO

		var_5(var_8_39, var_8.getPainting(var_8_40), "huode")
	end

	local var_8_41 = arg_8_0._shipType

	pg = var_8_31

	local var_8_42 = var_8_31.ship_data_by_type
	local var_8_43 = arg_8_0._shipVO

	var_8_41.text = var_8_42[var_7.getShipType(var_8_43)].type_name
	arg_8_0._shipName.text = arg_8_1:getName()

	local var_8_44 = arg_8_1:getRarity()

	pg = var_6

	local var_8_45 = var_6.ship_data_template[var_8_32.id].star_max
	local var_8_46 = arg_8_0._shipVO
	local var_8_47 = var_7.getStar(var_8_46)

	if not (var_8_45 % 2 == 0) or not (var_8_45 / 2) then
		math = var_8_46

		local var_8_48 = var_8_46.floor(var_8_45 / 2) + 1
	end

	local var_8_49 = 15

	for iter_8_0 = 1, 6 do
		local var_8_50 = arg_8_0.starsTF
		local var_8_51 = var_1_10015.Find(var_8_50, "content/star_" .. iter_8_0)
		local var_8_52 = var_1_10015.Find(var_8_51, "star_empty")
		local var_8_53 = var_1_10015:Find("star")

		setActive = var_8_51

		var_8_51(var_8_53, iter_8_0 <= var_8_47)

		setActive = var_8_51

		var_8_51(var_8_52, var_8_47 < iter_8_0)

		if var_8_45 < iter_8_0 then
			setActive = var_8_51

			var_8_51(var_1_10015, false)
		end
	end

	local var_8_54 = arg_8_0._shake
	local var_8_55 = var_11.Find(var_8_54, "rarity/nation")

	LoadSprite = var_12

	local var_8_56 = "prints/"

	nation2print = var_1_10015

	if not var_12(var_8_56 .. var_1_10015(var_8_32.nationality) .. "_0") then
		warning = var_8_54

		var_8_54("找不到印花, shipConfigId: " .. arg_8_1.configId)

		setActive = var_8_54

		var_8_54(var_8_55, false)
	else
		setImageSprite = var_8_54

		var_8_54(var_8_55, var_12, false)
	end

	local var_8_57 = arg_8_0._shake
	local var_8_58 = var_13.Find(var_8_57, "rarity/type")
	local var_8_59 = arg_8_0._shake
	local var_8_60 = var_14.Find(var_8_59, "rarity/type/rarLogo")

	if arg_8_1:isMetaShip() then
		LoadImageSpriteAsync = var_15

		var_15("shiprarity/1" .. var_8_44 .. "m", var_8_58, true)

		LoadImageSpriteAsync = var_15

		var_15("shiprarity/1" .. var_8_44 .. "s", var_8_60, true)
	else
		LoadImageSpriteAsync = var_15

		var_15("shiprarity/" .. (var_8_1 and "0" or "") .. var_8_44 .. "m", var_8_58, true)

		LoadImageSpriteAsync = var_15

		var_15("shiprarity/" .. (var_8_1 and "0" or "") .. var_8_44 .. "s", var_8_60, true)
	end

	setActive = var_15

	var_15(var_8_55, false)

	setActive = var_15

	var_15(arg_8_0.rarityTF, false)

	setActive = var_15

	var_15(arg_8_0._shade, true)

	arg_8_0.inAnimating = true

	arg_8_0:AddLeanTween(function()
		LeanTween = var_2_10000

		local var_11_0 = var_2_10000.delayedCall
		local var_11_1 = 0.5

		System = var_2_10003

		return var_11_0(var_11_1, var_2_10003.Action(function()
			setActive = var_3_10000

			var_3_10000(var_8_55, true)

			setActive = var_3_10000

			var_3_10000(arg_8_0.rarityTF, true)

			local var_12_0 = arg_8_0

			var_0.starsAnimation(var_12_0)

			return
		end))
	end)

	local var_8_61 = arg_8_0._shake
	local var_8_62 = var_15.Find(var_8_61, "ship_type")
	local var_8_63 = var_15.Find(var_8_62, "stars")
	local var_8_64 = var_15
	local var_8_65 = var_15.Find(var_8_64, "stars/startpl")
	local var_8_66

	var_8_66, setText = var_15:Find("english_name"), var_8_64

	local var_8_67 = arg_8_0._shipVO

	var_8_64(var_8_66, var_22.getConfig(var_8_67, "english_name"))

	local var_8_68 = var_8_63.childCount
	local var_8_69 = arg_8_0._shipVO
	local var_8_70 = var_20.getStar(var_8_69)
	local var_8_71 = arg_8_0._shipVO
	local var_8_72 = var_21.getMaxStar(var_8_71)

	for iter_8_1 = var_8_68, var_8_72 - 1 do
		cloneTplTo = var_1_10026

		var_1_10026(var_8_65, var_8_63)
	end

	local var_8_73 = var_8_63.childCount

	for iter_8_2 = 0, var_8_73 - 1 do
		var_1_10028 = var_8_63

		local var_8_74 = var_8_63.GetChild(var_1_10028, iter_8_2).gameObject

		var_1_10027.SetActive(var_8_74, iter_8_2 < var_8_72)

		setActive = var_1_10027

		var_1_10027(var_26:Find("star"), iter_8_2 < var_8_70)

		setActive = var_1_10027

		var_1_10027(var_26:Find("empty"), var_8_70 <= iter_8_2)
	end

	local var_8_75 = arg_8_0._shipVO
	local var_8_76 = var_22.getConfigTable(var_8_75)

	findTF = var_23

	local var_8_77 = var_23(var_15, "type_bg/type")
	local var_8_78 = var_23.GetComponent

	typeof = var_26
	Image = var_1_10028

	local var_8_79 = var_8_78(var_8_77, var_26(var_1_10028))

	GetSpriteFromAtlas = var_8_75

	local var_8_80 = "shiptype"

	tostring = var_1_10027

	local var_8_81 = arg_8_0._shipVO

	var_8_79.sprite = var_8_75(var_8_80, var_1_10027(var_29.getShipType(var_8_81)))
	setScrollText = var_24

	local var_8_82 = var_15:Find("name_bg/mask/Text")
	local var_8_83 = arg_8_0._shipVO

	var_24(var_8_82, var_27.getName(var_8_83))

	if var_8_1 then
		var_8_44 = var_8_44 .. "_1"
	elseif arg_8_1:isMetaShip() then
		var_8_44 = var_8_44 .. "_2"
	end

	if not arg_8_0.rarityEffect[var_8_44] then
		PoolMgr = var_24

		local var_8_84 = var_24.GetInstance()

		var_24.GetUI(var_8_84, "getrole_" .. var_8_44, true, function(arg_13_0)
			IsNil = var_2_10001

			if var_2_10001(arg_8_0._tf) then
				return
			end

			arg_8_0.rarityEffect[var_8_44] = arg_13_0

			local var_13_0 = arg_13_0.transform

			var_1.SetParent(var_13_0, arg_8_0._tf, false)

			local var_13_1 = arg_13_0.transform

			Vector3 = var_2
			var_13_1.localPosition = var_2(1, 1, 1)

			local var_13_2 = arg_13_0.transform

			Vector3 = var_2
			var_13_2.localScale = var_2(1, 1, 1)

			local var_13_3 = arg_13_0.transform

			var_1.SetSiblingIndex(var_13_3, 1)

			local var_13_4 = arg_8_1

			if var_1.isMetaShip(var_13_4) then
				tf = var_1

				local var_13_5 = var_1(arg_13_0)
				local var_13_6 = var_1.Find(var_13_5, "fire_ruchang")
				local var_13_7 = var_1.GetComponent

				typeof = var_5
				DftAniEvent = var_2_10007

				local var_13_8 = var_13_7(var_13_6, var_5(var_2_10007))

				var_2.SetEndEvent(var_13_8, function(arg_14_0)
					setActive = var_3_10001

					var_3_10001(var_8_55, true)

					setActive = var_3_10001

					var_3_10001(var_0, false)

					return
				end)
			end

			setActive = var_1

			var_1(var_8_55, false)

			local var_13_9 = arg_8_0

			var_13_9.effectObj = arg_13_0
			setActive = var_13_9

			var_13_9(arg_8_0.effectObj, arg_8_0.isOpeningEnd)

			return
		end)
	else
		arg_8_0.effectObj = arg_8_0.rarityEffect[var_8_44]
		setActive = var_24

		var_24(arg_8_0.effectObj, arg_8_0.isOpeningEnd)
	end

	arg_8_0:playOpening(function()
		local var_15_0 = arg_8_0

		var_0.ResumeAnimation(var_15_0)

		local var_15_1 = arg_8_0

		var_0.DisplayWord(var_15_1)

		return
	end)

	return
end

function var_0_1.PauseAnimation(arg_16_0)
	arg_16_0._canvasGroup.alpha = 0
	arg_16_0._animator.enabled = false

	return
end

function var_0_1.ResumeAnimation(arg_17_0)
	arg_17_0._canvasGroup.alpha = 1
	arg_17_0._animator.enabled = true
	arg_17_0.isOpeningEnd = true

	if arg_17_0.effectObj then
		setActive = var_1

		var_1(arg_17_0.effectObj, true)
	end

	return
end

function var_0_1.DisplayWord(arg_18_0)
	local var_18_0
	local var_18_1 = ""
	local var_18_2
	local var_18_4

	if arg_18_0.isRemoulded then
		local var_18_3 = arg_18_0._shipVO

		var_18_4 = var_18_4.getRemouldSkinId(var_18_3)
		ShipWordHelper = var_1_10005
		var_1_10005 = var_1_10005.RawGetWord
		var_1_10007 = var_18_4
		ShipWordHelper = var_1_10008

		if var_1_10005(var_1_10007, var_1_10008.WORD_TYPE_UNLOCK) == "" then
			ShipWordHelper = var_1_10005
			var_1_10005 = var_1_10005.GetWordAndCV
			var_1_10007 = var_18_4
			ShipWordHelper = var_8

			local var_18_5

			var_1_10005, var_18_5, var_1_10007 = var_1_10005(var_1_10007, var_8.WORD_TYPE_DROP)
			var_18_1 = var_1_10007
			var_18_2 = var_18_5

			local var_18_6 = var_1_10005
		else
			ShipWordHelper = var_1_10005
			var_1_10005 = var_1_10005.GetWordAndCV
			var_1_10007 = var_18_4
			ShipWordHelper = var_8

			local var_18_7

			var_1_10005, var_18_7, var_1_10007 = var_1_10005(var_1_10007, var_8.WORD_TYPE_UNLOCK)
			var_18_1 = var_1_10007
			var_18_2 = var_18_7

			local var_18_8 = var_1_10005
		end
	else
		ShipWordHelper = var_18_4
		var_18_4 = var_18_4.GetWordAndCV

		local var_18_9 = arg_18_0._shipVO
		local var_18_10 = var_6.getSkinId(var_18_9)

		ShipWordHelper = var_1_10007

		local var_18_11

		var_18_4, var_1_10005, var_18_11 = var_18_4(var_18_10, var_1_10007.WORD_TYPE_UNLOCK)
		var_18_1 = var_18_11
		var_18_2 = var_1_10005

		local var_18_12 = var_18_4
	end

	setWidgetText = var_18_4

	local var_18_13 = arg_18_0._dialogue

	SwitchSpecialChar = var_1_10007

	var_18_4(var_18_13, var_1_10007(var_18_1, true), "Text")

	local var_18_14 = arg_18_0._dialogue.transform

	Vector3 = var_1_10005
	var_18_14.localScale = var_1_10005(0, 1, 1)
	SetActive = var_18_14

	var_18_14(arg_18_0._dialogue, false)
	arg_18_0:AddLeanTween(function()
		LeanTween = var_2_10000

		local var_19_0 = var_2_10000.delayedCall
		local var_19_1 = 0.5

		System = var_2_10003

		return var_19_0(var_19_1, var_2_10003.Action(function()
			SetActive = var_3_10000

			var_3_10000(arg_18_0._dialogue, true)

			local var_20_0 = arg_18_0

			var_0.AddLeanTween(var_20_0, function()
				LeanTween = var_4_10000

				local var_21_0 = var_4_10000.scale
				local var_21_1 = arg_18_0._dialogue

				Vector3 = var_4_10003

				return var_21_0(var_21_1, var_4_10003(1, 1, 1), 0.1)
			end)

			local var_20_1 = arg_18_0

			var_0.voice(var_20_1, var_18_2)

			return
		end))
	end)

	return
end

function var_0_1.updateShip(arg_22_0, arg_22_1)
	arg_22_0._shipVO = arg_22_1

	return
end

function var_0_1.switch2Property(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.newTF, false)

	setActive = var_1_10001

	var_1_10001(arg_23_0._dialogue, false)

	setActive = var_1_10001

	var_1_10001(arg_23_0.rarityTF, false)

	setActive = var_1_10001

	local var_23_0 = arg_23_0._shake

	var_1_10001(var_3.Find(var_23_0, "rarity/nation"), false)

	local var_23_1 = arg_23_0._shake
	local var_23_2 = var_1.Find(var_23_1, "ship_type")

	setActive = var_1_10002

	var_1_10002(var_23_2, true)
	arg_23_0:AddLeanTween(function()
		LeanTween = var_2_10000

		local var_24_0 = var_2_10000.move

		rtf = var_2_10002

		local var_24_1 = var_2_10002(var_23_2)

		Vector3 = var_2_10003

		return var_24_0(var_24_1, var_2_10003(0, -149.55, 0), 0.3)
	end)
	arg_23_0:AddLeanTween(function()
		LeanTween = var_2_10000

		local var_25_0 = var_2_10000.move

		rtf = var_2_10002

		local var_25_1 = var_2_10002(arg_23_0._paintingTF)

		Vector3 = var_2_10003

		return var_25_0(var_25_1, var_2_10003(-59, 21, 0), 0.2)
	end)
	arg_23_0:DisplayNewShipDocumentView()

	return
end

function var_0_1.showExitTip(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._shipVO
	local var_26_1 = var_2.GetLockState(var_26_0)

	pg = var_1_10003

	local var_26_2 = var_1_10003.settings_other_template[22]

	getProxy = var_26_0
	PlayerProxy = var_1_10006

	local var_26_3 = var_26_0(var_1_10006)
	local var_26_4 = var_4.getRawData(var_26_3)
	local var_26_5 = var_4.GetCommonFlag

	_G = var_1_10007

	local var_26_6 = var_26_5(var_26_4, var_1_10007[var_26_2.name])

	if var_26_2.default == 1 then
		var_26_6 = not var_26_6
	end

	local var_26_9

	if arg_26_0._shipVO.virgin then
		Ship = var_5

		if var_26_1 == var_5.LOCK_STATE_UNLOCK and not var_26_6 then
			if arg_26_0.effectObj then
				setActive = var_5

				var_5(arg_26_0.effectObj, false)
			end

			if arg_26_0.effectLineObj then
				setActive = var_5

				var_5(arg_26_0.effectLineObj, false)
			end

			pg = var_5

			local var_26_7 = var_5.MsgboxMgr.GetInstance()
			local var_26_8 = var_5.ShowMsgBox

			var_26_9 = {
				modal = true
			}
			i18n = var_1_10009
			var_26_9.content = var_1_10009("ship_lock_tip")

			function var_26_9.onYes()
				triggerButton = var_2_10000

				var_2_10000(arg_26_0._lockBtn)

				if arg_26_1 then
					arg_26_1()
				else
					local var_27_0 = arg_26_0
					local var_27_1 = var_0.emit

					NewShipMediator = var_2_10003

					var_27_1(var_27_0, var_2_10003.ON_EXIT)
				end

				return
			end

			function var_26_9.onNo()
				if arg_26_1 then
					arg_26_1()
				else
					local var_28_0 = arg_26_0
					local var_28_1 = var_0.emit

					NewShipMediator = var_2_10003

					var_28_1(var_28_0, var_2_10003.ON_EXIT)
				end

				return
			end

			var_26_8(var_26_7, var_26_9)

			goto label_26_0
		end
	end

	if arg_26_1 then
		arg_26_1()
	else
		local var_26_10 = arg_26_0
		local var_26_11 = arg_26_0.emit

		NewShipMediator = var_26_9

		var_26_11(var_26_10, var_26_9.ON_EXIT)
	end

	::label_26_0::

	return
end

function var_0_1.UpdateLockButton(arg_29_0, arg_29_1)
	setActive = var_1_10002

	local var_29_0 = arg_29_0._lockBtn

	Ship = var_1_10005

	var_1_10002(var_29_0, arg_29_1 ~= var_1_10005.LOCK_STATE_LOCK)

	setActive = var_1_10002

	local var_29_1 = arg_29_0._unlockBtn

	Ship = var_5

	var_1_10002(var_29_1, arg_29_1 ~= var_5.LOCK_STATE_UNLOCK)

	return
end

function var_0_1.updateLockTF(arg_30_0, arg_30_1)
	setActive = var_1_10002

	var_1_10002(arg_30_0._lockTF, not arg_30_1)

	return
end

function var_0_1.didEnter(arg_31_0)
	onButton = var_1_10001

	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0._lockBtn

	local function var_31_2()
		local var_32_0 = arg_31_0

		var_0.StopAutoExitTimer(var_32_0)

		local var_32_1 = arg_31_0
		local var_32_2 = var_0.emit

		NewShipMediator = var_2_10003

		local var_32_3 = var_2_10003.ON_LOCK
		local var_32_4 = {
			arg_31_0._shipVO.id
		}

		Ship = var_5

		var_32_2(var_32_1, var_32_3, var_32_4, var_5.LOCK_STATE_LOCK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_31_0, var_31_1, var_31_2, var_1_10006)

	onButton = var_1_10001

	local var_31_3 = arg_31_0
	local var_31_4 = arg_31_0._unlockBtn

	local function var_31_5()
		local var_33_0 = arg_31_0

		var_0.StopAutoExitTimer(var_33_0)

		local var_33_1 = arg_31_0
		local var_33_2 = var_0.emit

		NewShipMediator = var_2_10003

		local var_33_3 = var_2_10003.ON_LOCK
		local var_33_4 = {
			arg_31_0._shipVO.id
		}

		Ship = var_5

		var_33_2(var_33_1, var_33_3, var_33_4, var_5.LOCK_STATE_UNLOCK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_31_3, var_31_4, var_31_5, var_1_10006)

	onButton = var_1_10001

	local var_31_6 = arg_31_0
	local var_31_7 = arg_31_0._viewBtn

	local function var_31_8()
		local var_34_0 = arg_31_0

		var_0.StopAutoExitTimer(var_34_0)

		arg_31_0.isInView = true

		local var_34_1 = arg_31_0

		var_0.paintView(var_34_1)

		setActive = var_0

		var_0(arg_31_0.clickTF, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_31_6, var_31_7, var_31_8, var_1_10006)

	onButton = var_1_10001

	local var_31_9 = arg_31_0
	local var_31_10 = arg_31_0._evaluationBtn

	local function var_31_11()
		local var_35_0 = arg_31_0

		var_0.StopAutoExitTimer(var_35_0)

		local var_35_1 = arg_31_0
		local var_35_2 = var_0.emit

		NewShipMediator = var_2_10003

		local var_35_3 = var_2_10003.ON_EVALIATION
		local var_35_4 = arg_31_0._shipVO

		var_35_2(var_35_1, var_35_3, var_4.getGroupId(var_35_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_31_9, var_31_10, var_31_11, var_1_10006)

	onButton = var_1_10001

	local var_31_12 = arg_31_0
	local var_31_13 = arg_31_0._shareBtn

	local function var_31_14()
		local var_36_0 = arg_31_0

		var_0.StopAutoExitTimer(var_36_0)

		pg = var_0

		local var_36_1 = var_0.ShareMgr.GetInstance()
		local var_36_2 = var_0.Share

		pg = var_2_10003

		var_36_2(var_36_1, var_2_10003.ShareMgr.TypeNewShip)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_31_12, var_31_13, var_31_14, var_1_10006)

	onButton = var_1_10001

	local var_31_15 = arg_31_0
	local var_31_16 = arg_31_0.clickTF

	local function var_31_17()
		local var_37_0 = arg_31_0

		var_0.StopAutoExitTimer(var_37_0)

		if arg_31_0.isInView or not arg_31_0.isLoadBg then
			return
		end

		local var_37_1 = arg_31_0

		var_0.showExitTip(var_37_1)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_31_15, var_31_16, var_31_17, var_1_10006)

	onButton = var_1_10001

	local var_31_18 = arg_31_0
	local var_31_19 = arg_31_0.audioBtn

	local function var_31_20()
		local var_38_0 = arg_31_0

		var_0.StopAutoExitTimer(var_38_0)

		if arg_31_0.isInView then
			return
		end

		local var_38_2

		if not arg_31_0.isOpenProperty then
			local var_38_1 = arg_31_0

			var_38_2.switch2Property(var_38_1)

			var_38_2 = arg_31_0
			var_38_2.isOpenProperty = true
		end

		setActive = var_38_2

		var_38_2(arg_31_0.audioBtn, not arg_31_0.isRemoulded and not arg_31_0.isOpenProperty)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_31_18, var_31_19, var_31_20, var_1_10006)

	onButton = var_1_10001

	local var_31_21 = arg_31_0
	local var_31_22 = arg_31_0._skipButton

	local function var_31_23()
		local var_39_0 = arg_31_0

		var_0.showExitTip(var_39_0, function()
			local var_40_0 = arg_31_0
			local var_40_1 = var_0.emit

			NewShipMediator = var_3_10003

			var_40_1(var_40_0, var_3_10003.ON_SKIP_BATCH)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_31_21, var_31_22, var_31_23, var_1_10006)

	pg = var_1_10001

	local var_31_24 = var_1_10001.CriMgr.GetInstance()
	local var_31_25 = var_1.PlaySoundEffect_V3

	SFX_UI_DOCKYARD_CHARGET = var_31_22

	var_31_25(var_31_24, var_31_22)

	pg = var_31_25

	local var_31_26 = var_31_25.SystemGuideMgr.GetInstance()

	var_1.Play(var_31_26, arg_31_0)

	return
end

function var_0_1.onBackPressed(arg_41_0)
	if arg_41_0.inAnimating then
		return
	end

	pg = var_1

	local var_41_0 = var_1.CriMgr.GetInstance()
	local var_41_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_41_1(var_41_0, var_1_10004)

	if arg_41_0.isInView then
		arg_41_0:hidePaintView(true)

		return
	end

	arg_41_0:DestroyNewShipDocumentView()

	triggerButton = var_1

	var_1(arg_41_0.clickTF)

	return
end

function var_0_1.paintView(arg_42_0)
	local var_42_0 = {}
	local var_42_1 = arg_42_0._shake.childCount
	local var_42_2 = 0

	while var_42_2 < var_42_1 do
		local var_42_3 = arg_42_0._shake

		if var_1_10004.GetChild(var_42_3, var_42_2).gameObject.activeSelf and var_1_10004 ~= arg_42_0._paintingTF and var_1_10004 ~= arg_42_0._bg and var_1_10004 ~= arg_42_0._drag then
			var_42_0[#var_42_0 + 1] = var_1_10004
			setActive = var_5

			var_5(var_1_10004, false)
		end

		var_42_2 = var_42_2 + 1
	end

	setActive = var_1_10004

	var_1_10004(arg_42_0._paintingShadowTF, false)

	openPortrait = var_1_10004

	var_1_10004()

	local var_42_4 = arg_42_0._paintingTF.anchoredPosition.x
	local var_42_5 = var_4.anchoredPosition.y
	local var_42_6 = var_4.rect.width
	local var_42_7 = var_4.rect.height
	local var_42_8 = arg_42_0._tf.rect.width

	UnityEngine = var_1_10010

	local var_42_9 = var_42_8 / var_1_10010.Screen.width
	local var_42_10 = arg_42_0._tf.rect.height

	UnityEngine = var_1_10011

	local var_42_11 = var_42_10 / var_1_10011.Screen.height
	local var_42_12 = var_42_6 / 2
	local var_42_13 = var_42_7 / 2
	local var_42_14
	local var_42_15

	LeanTween = var_1_10015

	local var_42_16 = var_1_10015.isTweening

	go = var_1_10017

	if not var_42_16(var_1_10017(var_4)) then
		arg_42_0:AddLeanTween(function()
			LeanTween = var_2_10000

			local var_43_0 = var_2_10000.moveX

			rtf = var_2_10002

			local var_43_1 = var_43_0(var_2_10002(var_0), 150, 0.5)
			local var_43_2 = var_0.setEase

			LeanTweenType = var_3

			return var_43_2(var_43_1, var_3.easeInOutSine)
		end)
	end

	GetOrAddComponent = var_15

	local var_42_17 = var_15(arg_42_0._drag, "MultiTouchZoom")

	var_15.SetZoomTarget(var_42_17, arg_42_0._paintingTF)

	GetOrAddComponent = var_16
	arg_42_0.dragTrigger = var_16(arg_42_0._drag, "EventTriggerListener")

	local var_42_18 = true

	var_15.enabled = true
	var_16.enabled = true

	local var_42_19 = false

	var_16:AddPointDownFunc(function(arg_44_0)
		Input = var_2_10001

		if var_2_10001.touchCount ~= 1 then
			IsUnityEditor = var_1

			if var_1 then
				var_42_19 = true
				var_42_18 = true
			else
				Input = var_1

				if var_1.touchCount >= 2 then
					var_42_18 = false
					var_42_19 = false
				end
			end

			return
		end
	end)
	var_16:AddPointUpFunc(function(arg_45_0)
		Input = var_2_10001

		if var_2_10001.touchCount <= 2 then
			var_42_18 = true
		end

		return
	end)
	var_16:AddBeginDragFunc(function(arg_46_0, arg_46_1)
		var_42_19 = false

		local var_46_0 = arg_46_1.position.x * var_42_9 - var_42_12

		tf = var_3
		var_42_14 = var_46_0 - var_3(arg_42_0._paintingTF).localPosition.x

		local var_46_1 = arg_46_1.position.y * var_42_11 - var_42_13

		tf = var_3
		var_42_15 = var_46_1 - var_3(arg_42_0._paintingTF).localPosition.y

		return
	end)
	var_16:AddDragFunc(function(arg_47_0, arg_47_1)
		if var_42_18 then
			tf = var_2

			local var_47_0 = var_2(arg_42_0._paintingTF).localPosition

			tf = var_2_10003

			local var_47_1 = var_2_10003(arg_42_0._paintingTF)

			Vector3 = var_4
			var_47_1.localPosition = var_4(arg_47_1.position.x * var_42_9 - var_42_12 - var_42_14, arg_47_1.position.y * var_42_11 - var_42_13 - var_42_15, -22)
		end

		return
	end)

	onButton = var_19

	local var_42_20 = arg_42_0
	local var_42_21 = arg_42_0._drag

	local function var_42_22()
		local var_48_0 = arg_42_0

		var_0.hidePaintView(var_48_0)

		return
	end

	SFX_CANCEL = var_1_10024

	var_19(var_42_20, var_42_21, var_42_22, var_1_10024)

	function var_0_1.hidePaintView(arg_49_0, arg_49_1)
		if not arg_49_1 and not var_42_19 then
			return
		end

		var_0.enabled = false

		local var_49_0 = var_0

		var_49_0.enabled = false
		ipairs = var_49_0

		for iter_49_0, iter_49_1 in var_49_0(var_42_0) do
			setActive = var_2_10007

			var_2_10007(iter_49_1, true)
		end

		setActive = var_2

		var_2(arg_49_0._paintingShadowTF, true)

		closePortrait = var_2

		var_2()

		LeanTween = var_2

		local var_49_1 = var_2.cancel

		go = var_4

		var_49_1(var_4(arg_49_0._paintingTF))

		local var_49_2 = arg_49_0._paintingTF

		Vector3 = var_3
		var_49_2.localScale = var_3(1, 1, 1)
		setAnchoredPosition = var_49_2

		var_49_2(arg_49_0._paintingTF, {
			x = var_42_4,
			y = var_42_5
		})

		arg_49_0.isInView = false
		setActive = var_2

		var_2(arg_49_0.clickTF, true)

		return
	end

	return
end

function var_0_1.recyclePainting(arg_50_0)
	if arg_50_0._shipVO then
		retPaintingPrefab = var_1

		local var_50_0 = arg_50_0._paintingTF
		local var_50_1 = arg_50_0._shipVO

		var_1(var_50_0, var_4.getPainting(var_50_1))

		retPaintingPrefab = var_1

		local var_50_2 = arg_50_0._paintingShadowTF
		local var_50_3 = arg_50_0._shipVO

		var_1(var_50_2, var_4.getPainting(var_50_3))

		arg_50_0._shipVO = nil
	end

	return
end

function var_0_1.starsAnimation(arg_51_0)
	arg_51_0.inAnimating = true

	local var_51_0 = arg_51_0._shipVO
	local var_51_1 = var_1.getMaxStar(var_51_0)
	local var_51_2

	if 6 <= var_51_1 then
		PlayerPrefs = var_51_2
		var_51_2 = var_51_2.GetInt
		RARE_SHIP_VIBRATE = var_1_10004

		if var_51_2(var_1_10004, 1) > 0 then
			LuaHelper = var_51_2

			var_51_2.Vibrate()
		end
	end

	setActive = var_51_2

	var_51_2(arg_51_0.starsCont, false)

	local var_51_3 = arg_51_0._tf
	local var_51_4 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10007

	local var_51_5 = var_51_4(var_51_3, var_5(var_1_10007))

	var_2.SetTriggerEvent(var_51_5, function(arg_52_0)
		local var_52_0 = arg_51_0

		var_1.AddLeanTween(var_52_0, function()
			LeanTween = var_3_10000

			local var_53_0 = var_3_10000.scale

			rtf = var_3_10002

			local var_53_1 = var_3_10002(arg_51_0.starsCont)

			Vector3 = var_3_10003

			local var_53_2 = var_53_0(var_53_1, var_3_10003.one, 0)
			local var_53_3 = var_0.setOnComplete

			System = var_3

			return var_53_3(var_53_2, var_3.Action(function()
				setActive = var_4_10000

				var_4_10000(arg_51_0.starsCont, true)

				return
			end))
		end)

		local var_52_1 = arg_51_0.STAR_ANIMATION_DUR1

		for iter_52_0 = 0, arg_51_0.starsCont.childCount - 1 do
			local var_52_2 = arg_51_0.starsCont
			local var_52_3 = var_6.GetChild(var_52_2, iter_52_0)
			local var_52_4 = var_6.Find(var_52_3, "star_empty")
			local var_52_5 = var_6:Find("star")

			setActive = var_52_3

			var_52_3(var_52_4, false)

			setActive = var_52_3

			var_52_3(var_52_5, false)

			local var_52_6 = iter_52_0 * var_52_1
			local var_52_7 = arg_51_0

			var_10.AddLeanTween(var_52_7, function()
				LeanTween = var_3_10000

				local var_55_0 = var_3_10000.scale

				rtf = var_3_10002

				local var_55_1 = var_3_10002(var_52_4)

				Vector3 = var_3_10003

				local var_55_2 = var_55_0(var_55_1, var_3_10003(1.8, 1.8, 1.8), 0)
				local var_55_3 = var_0.setDelay(var_55_2, var_52_6)
				local var_55_4 = var_0.setOnComplete

				System = var_3

				return var_55_4(var_55_3, var_3.Action(function()
					setActive = var_4_10000

					var_4_10000(var_52_4, true)

					local var_56_0 = arg_51_0

					var_0.AddLeanTween(var_56_0, function()
						LeanTween = var_5_10000

						local var_57_0 = var_5_10000.scale

						rtf = var_5_10002

						local var_57_1 = var_5_10002(var_52_4)

						Vector3 = var_5_10003

						return var_57_0(var_57_1, var_5_10003(1, 1, 1), var_52_1)
					end)

					return
				end))
			end)
		end

		local var_52_8 = arg_51_0._shipVO
		local var_52_9 = var_2.getStar(var_52_8)
		local var_52_10 = arg_51_0.STAR_ANIMATION_DUR2
		local var_52_11 = arg_51_0.STAR_ANIMATION_DUR3

		for iter_52_1 = 0, var_52_9 - 1 do
			local var_52_12 = arg_51_0.starsCont
			local var_52_13 = var_9.GetChild(var_52_12, iter_52_1)
			local var_52_14 = var_9.Find(var_52_13, "star_empty")
			local var_52_15 = var_9:Find("star")
			local var_52_16 = var_52_1 * arg_51_0.starsCont.childCount + iter_52_1 * var_52_10
			local var_52_17 = arg_51_0

			var_13.AddLeanTween(var_52_17, function()
				LeanTween = var_3_10000

				local var_58_0 = var_3_10000.scale

				rtf = var_3_10002

				local var_58_1 = var_3_10002(var_52_15)

				Vector3 = var_3_10003

				local var_58_2 = var_58_0(var_58_1, var_3_10003(1.8, 1.8, 1.8), 0)
				local var_58_3 = var_0.setDelay(var_58_2, var_52_16)
				local var_58_4 = var_0.setOnStart

				System = var_3

				local var_58_5 = var_58_4(var_58_3, var_3.Action(function()
					pg = var_4_10000

					local var_59_0 = var_4_10000.CriMgr.GetInstance()
					local var_59_1 = var_0.PlaySoundEffect_V3

					SFX_UI_DOCKYARD_STAR = var_4_10003

					var_59_1(var_59_0, var_4_10003)

					return
				end))
				local var_58_6 = var_0.setOnComplete

				System = var_3

				return var_58_6(var_58_5, var_3.Action(function()
					setActive = var_4_10000

					var_4_10000(var_52_14, false)

					setActive = var_4_10000

					var_4_10000(var_52_15, true)

					local var_60_0 = arg_51_0

					var_0.AddLeanTween(var_60_0, function()
						LeanTween = var_5_10000

						local var_61_0 = var_5_10000.scale

						rtf = var_5_10002

						local var_61_1 = var_5_10002(var_52_15)

						Vector3 = var_5_10003

						return var_61_0(var_61_1, var_5_10003(1, 1, 1), var_52_10)
					end)

					return
				end))
			end)

			local var_52_18 = var_9

			if var_9.Find(var_52_18, "light") then
				local var_52_19 = arg_51_0

				var_14.AddLeanTween(var_52_19, function()
					LeanTween = var_3_10000

					local var_62_0 = var_3_10000.delayedCall
					local var_62_1 = var_52_16

					System = var_3_10003

					return var_62_0(var_62_1, var_3_10003.Action(function()
						if arg_51_0.exited then
							return
						end

						setActive = var_0

						var_0(var_0, true)

						return
					end))
				end)

				local var_52_20 = arg_51_0

				var_14.AddLeanTween(var_52_20, function()
					LeanTween = var_3_10000

					local var_64_0 = var_3_10000.alpha

					rtf = var_3_10002

					local var_64_1 = var_64_0(var_3_10002(var_0), 0, var_52_11)
					local var_64_2 = var_0.setDelay(var_64_1, var_52_16)
					local var_64_3 = var_0.setOnComplete

					System = var_3

					return var_64_3(var_64_2, var_3.Action(function()
						SetActive = var_4_10000

						var_4_10000(var_0, false)

						LeanTween = var_4_10000

						local var_65_0 = var_4_10000.alpha

						rtf = var_2

						var_65_0(var_2(var_0), 1, 0)

						return
					end))
				end)

				local var_52_21 = var_13.transform

				Vector3 = var_52_18
				var_52_21.localScale = var_52_18(1, 1, 1)

				local var_52_22 = arg_51_0

				var_14.AddLeanTween(var_52_22, function()
					LeanTween = var_3_10000

					local var_66_0 = var_3_10000.scale

					rtf = var_3_10002

					local var_66_1 = var_3_10002(var_0)

					Vector3 = var_3_10003

					local var_66_2 = var_66_0(var_66_1, var_3_10003(0.5, 1, 1), arg_51_0.STAR_ANIMATION_DUR4)

					return var_0.setDelay(var_66_2, var_52_16 + var_52_11 * 1 / 3)
				end)
			end
		end

		return
	end)
	var_2:SetEndEvent(function(arg_67_0)
		local var_67_0 = arg_51_0._shipVO

		if var_1.getReMetaSpecialItemVO(var_67_0) then
			GetComponent = var_2_10002
			var_2_10002(arg_51_0.metaRepeatTF, "CanvasGroup").alpha = 1

			local var_67_1 = arg_51_0
			local var_67_2 = var_3.managedTween

			LeanTween = var_2_10006

			local var_67_3 = var_2_10006.value

			local function var_67_4()
				setAnchoredPosition = var_3_10000

				var_3_10000(arg_51_0.metaRepeatTF, {
					x = 0
				})

				local var_68_0 = arg_51_0

				var_68_0.inAnimating = false
				setActive = var_68_0

				local var_68_1 = arg_51_0.npc
				local var_68_2 = arg_51_0._shipVO

				var_68_0(var_68_1, var_3.isActivityNpc(var_68_2))

				setActive = var_68_0

				var_68_0(arg_51_0._shade, false)

				return
			end

			go = var_2_10008

			local var_67_5 = var_67_2(var_67_1, var_67_3, var_67_4, var_2_10008(arg_51_0.metaRepeatTF), arg_51_0.metaRepeatTF.rect.width, 0, 1)
			local var_67_6 = var_3.setOnUpdate

			System = var_67_3

			var_67_6(var_67_5, var_67_3.Action_float(function(arg_69_0)
				setAnchoredPosition = var_3_10001

				var_3_10001(arg_51_0.metaRepeatTF, {
					x = arg_69_0
				})

				return
			end))

			setAnchoredPosition = var_67_6

			var_67_6(arg_51_0.metaRepeatTF, {
				x = arg_51_0.metaRepeatTF.rect.width
			})

			setActive = var_67_6

			var_67_6(arg_51_0.metaRepeatTF, true)
		else
			local var_67_7 = arg_51_0

			var_67_7.inAnimating = false
			setActive = var_67_7

			local var_67_8 = arg_51_0.npc
			local var_67_9 = arg_51_0._shipVO

			var_67_7(var_67_8, var_5.isActivityNpc(var_67_9))

			setActive = var_67_7

			var_67_7(arg_51_0._shade, false)
		end

		return
	end)

	return
end

function var_0_1.playOpening(arg_70_0, arg_70_1)
	local var_70_0 = arg_70_0._shipVO

	if var_2.isMetaShip(var_70_0) then
		getProxy = var_2
		ContextProxy = var_70_0

		local var_70_1 = var_2(var_70_0)
		local var_70_2 = var_2.getContextByMediator

		BuildShipMediator = var_1_10005

		if not var_70_2(var_70_1, var_1_10005) then
			if arg_70_1 then
				arg_70_1()
			end

			return
		end
	end

	local var_70_3
	local var_70_4 = arg_70_0._shipVO
	local var_70_5

	if var_3.isRemoulded(var_70_4) then
		ShipGroup = var_70_5
		var_70_5 = var_70_5.GetGroupConfig

		local var_70_6 = arg_70_0._shipVO

		var_70_3 = var_70_5(var_70_4.getGroupId(var_70_6)).trans_skin
	else
		ShipGroup = var_70_5

		local var_70_7 = var_70_5.getDefaultSkin
		local var_70_8 = arg_70_0._shipVO

		var_70_3 = var_70_7(var_70_4.getGroupId(var_70_8)).id
	end

	local var_70_9 = "star_level_unlock_anim_" .. var_70_3

	checkABExist = var_4

	if var_4("ui/skinunlockanim/" .. var_70_9) then
		pg = var_70_4

		local var_70_10 = var_70_4.CpkPlayMgr.GetInstance()

		var_5.PlayCpkMovie(var_70_10, function()
			return
		end, function()
			if arg_70_1 then
				arg_70_1()
			end

			return
		end, "ui/skinunlockanim", var_70_9, true, false)
	elseif arg_70_1 then
		arg_70_1()
	end

	return
end

function var_0_1.ClearTweens(arg_73_0, arg_73_1)
	arg_73_0:cleanManagedTween(true)

	return
end

function var_0_1.willExit(arg_74_0)
	pg = var_1_10001

	local var_74_0 = var_1_10001.CpkPlayMgr.GetInstance()

	var_1.DisposeCpkMovie(var_74_0)
	arg_74_0:StopAutoExitTimer()
	arg_74_0:DestroyNewShipDocumentView()

	if arg_74_0.designBg then
		PoolMgr = var_1

		local var_74_1 = var_1.GetInstance()

		var_1.ReturnUI(var_74_1, arg_74_0.designName, arg_74_0.designBg)
	end

	if arg_74_0.metaBg then
		PoolMgr = var_1

		local var_74_2 = var_1.GetInstance()

		var_1.ReturnUI(var_74_2, arg_74_0.metaName, arg_74_0.metaBg)
	end

	pairs = var_1

	for iter_74_0, iter_74_1 in var_1(arg_74_0.rarityEffect) do
		if iter_74_1 then
			PoolMgr = var_1_10006

			local var_74_3 = var_1_10006.GetInstance()

			var_1_10006.ReturnUI(var_74_3, "getrole_" .. iter_74_0, iter_74_1)
		end
	end

	if arg_74_0.dragTrigger then
		ClearEventTrigger = var_1

		var_1(arg_74_0.dragTrigger)

		arg_74_0.dragTrigger = nil
	end

	if not arg_74_0.isRemoulded then
		pg = var_1

		local var_74_4 = var_1.TipsMgr.GetInstance()
		local var_74_5 = var_1.ShowTips

		i18n = iter_74_0

		local var_74_6 = "ship_newShipLayer_get"

		pg = var_1_10007

		local var_74_7 = var_1_10007.ship_data_by_type
		local var_74_8 = arg_74_0._shipVO
		local var_74_9 = var_74_7[var_8.getShipType(var_74_8)].type_name
		local var_74_10 = arg_74_0._shipVO
		local var_74_11 = iter_74_0(var_74_6, var_74_9, var_8.getName(var_74_10))

		COLOR_GREEN = iter_74_1

		var_74_5(var_74_4, var_74_11, iter_74_1)
	end

	arg_74_0:recyclePainting()

	pg = var_1

	local var_74_12 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_74_12, arg_74_0._tf)

	local var_74_13 = arg_74_0

	arg_74_0.stopVoice(var_74_13)

	if arg_74_0.loadedCVBankName then
		pg = var_1

		var_1.CriMgr.UnloadCVBank(arg_74_0.loadedCVBankName)

		arg_74_0.loadedCVBankName = nil
	end

	LeanTween = var_1

	local var_74_14 = var_1.isTweening

	go = var_74_13

	local var_74_15

	if var_74_14(var_74_13(arg_74_0.rarityTF)) then
		LeanTween = var_74_15
		var_74_15 = var_74_15.cancel
		go = var_3

		var_74_15(var_3(arg_74_0.rarityTF))
	end

	cameraPaintViewAdjust = var_74_15

	var_74_15(false)

	return
end

function var_0_1.DisplayNewShipDocumentView(arg_75_0)
	NewShipDocumentView = var_1_10001

	local var_75_0 = var_1_10001.New
	local var_75_1 = arg_75_0._shake

	arg_75_0.newShipDocumentView = var_75_0(var_3.Find(var_75_1, "ForNotch"), arg_75_0.event, arg_75_0.contextData)

	local var_75_2 = arg_75_0.newShipDocumentView

	var_1.Load(var_75_2)

	local function var_75_3()
		if not arg_75_0.isLoadBg then
			return
		end

		local var_76_0 = arg_75_0

		var_0.showExitTip(var_76_0)

		return
	end

	local var_75_4 = arg_75_0.newShipDocumentView

	var_2.ActionInvoke(var_75_4, "SetParams", arg_75_0._shipVO, var_75_3)

	local var_75_5 = arg_75_0.newShipDocumentView

	var_2.ActionInvoke(var_75_5, "RefreshUI")

	return
end

function var_0_1.DestroyNewShipDocumentView(arg_77_0)
	if arg_77_0.newShipDocumentView then
		local var_77_0 = arg_77_0.newShipDocumentView
		local var_77_1 = var_1.CheckState

		BaseSubView = var_1_10004

		if var_77_1(var_77_0, var_1_10004.STATES.INITED) then
			local var_77_2 = arg_77_0.newShipDocumentView

			var_1.Destroy(var_77_2)
		end
	end

	return
end

function var_0_1.StopAutoExitTimer(arg_78_0)
	if not arg_78_0.autoExitTimer then
		return
	end

	local var_78_0 = arg_78_0.autoExitTimer

	var_1.Stop(var_78_0)

	arg_78_0.autoExitTimer = nil

	return
end

return var_0_1
