class = var_0_10000

local var_0_0 = "BattleScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

Vector3 = var_0_10001
var_0_1.IN_VIEW_FRIEND_SKILL_OFFSET = var_0_10001(-5, 0, 6)
Vector3 = var_1
var_0_1.IN_VIEW_FOE_SKILL_OFFSET = var_1(-15, 0, 6)
var_0_1.FOE_SIDE_X_OFFSET = 250
Vector3 = var_1
var_0_1.SKILL_FLOAT_SCALE = var_1(1.5, 1.5, 0)
var_0_1.SIDE_ALIGNMENT = {
	{
		-120,
		-7.5,
		-232.5
	},
	{
		105,
		217.5,
		330
	},
	{
		-345,
		-457.5,
		-570
	}
}

local var_0_2

function var_0_1.getUIName(arg_1_0)
	local var_1_0 = "CombatUI"

	ys = var_1_10002

	return var_1_0 .. var_1_10002.Battle.BattleState.GetCombatSkinKey()
end

function var_0_1.forceRatio(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.CameraFixMgr.GetInstance().targetRatio

	math = var_1_10002

	return var_1_10002.max(var_2_0, 1.7777777777777777)
end

function var_0_1.getBGM(arg_3_0)
	local var_3_0 = {}

	table = var_1_10002

	local var_3_1 = var_1_10002.insert
	local var_3_2 = var_3_0
	local var_3_3 = arg_3_0.contextData.system

	SYSTEM_WORLD = var_1_10006

	if var_3_3 == var_1_10006 then
		checkExist = var_3_3
		pg = var_1_10007

		local var_3_4

		if not var_3_3(var_1_10007.world_expedition_data[arg_3_0.contextData.stageId], {
			"bgm"
		}) then
			var_3_4 = ""
		end

		var_3_1(var_3_2, var_3_4)

		table = var_3_1

		local var_3_5 = var_3_1.insert
		local var_3_6 = var_3_0

		pg = var_3_4

		var_3_5(var_3_6, var_3_4.expedition_data_template[arg_3_0.contextData.stageId].bgm)

		ipairs = var_3_5

		for iter_3_0, iter_3_1 in var_3_5(var_3_0) do
			if iter_3_1 ~= "" then
				return iter_3_1
			end
		end

		return var_0_1.super.getBGM(arg_3_0)
	end
end

function var_0_1.init(arg_4_0)
	ys = var_1_10001
	var_0_2 = var_1_10001.Battle.BattleVariable
	pg = var_1

	local var_4_0 = var_1.UIMgr.GetInstance()
	local var_4_1 = var_1.GetMainCamera(var_4_0)

	GameObject = var_1_10002

	local var_4_2 = var_1_10002.Find("UICamera")

	findTF = var_4_0
	arg_4_0.uiCanvas = var_4_0(var_4_2, "Canvas/UIMain")

	local var_4_3 = arg_4_0._tf

	arg_4_0.skillTips = var_3.Find(var_4_3, "Skill_Activation")

	local var_4_4 = arg_4_0._tf

	arg_4_0.skillRoot = var_3.Find(var_4_4, "Skill_Activation/Root")

	local var_4_5 = arg_4_0._tf

	arg_4_0.skillTpl = var_3.Find(var_4_5, "Skill_Activation/mask").gameObject
	pg = var_3

	local var_4_6 = var_3.Pool.New(arg_4_0.skillRoot, arg_4_0.skillTpl, 15, 10, true, false)

	arg_4_0._skillFloatPool = var_3.InitSize(var_4_6)

	local var_4_7 = arg_4_0._skillFloatPool

	var_3.SetRecycleFuncs(var_4_7, function(arg_5_0)
		local var_5_0 = arg_5_0.transform
		local var_5_1 = var_1.GetComponent

		typeof = var_2_10004
		DftAniEvent = var_2_10006

		local var_5_2 = var_5_1(var_5_0, var_2_10004(var_2_10006))

		var_1.OnDestroy(var_5_2)

		return
	end)

	local var_4_8 = arg_4_0._tf

	arg_4_0.skillCMDRoot = var_3.Find(var_4_8, "Skill_Activation/Root_cmd")

	local var_4_9 = arg_4_0._tf

	arg_4_0.skillCMDTpl = var_3.Find(var_4_9, "Skill_Activation/mask_cmd").gameObject
	pg = var_3

	local var_4_10 = var_3.Pool.New(arg_4_0.skillCMDRoot, arg_4_0.skillCMDTpl, 2, 4, true, false)

	arg_4_0._skillFloatCMDPool = var_3.InitSize(var_4_10)

	local var_4_11 = arg_4_0._skillFloatCMDPool

	var_3.SetRecycleFuncs(var_4_11, function(arg_6_0)
		local var_6_0 = arg_6_0.transform
		local var_6_1 = var_1.GetComponent

		typeof = var_2_10004
		DftAniEvent = var_2_10006

		local var_6_2 = var_6_1(var_6_0, var_2_10004(var_2_10006))

		var_1.OnDestroy(var_6_2)

		return
	end)

	arg_4_0.popupTpl = arg_4_0:getTpl("popup")
	SetActive = var_3

	var_3(arg_4_0._go, false)

	arg_4_0._skillPaintings = {}
	arg_4_0._skillFloat = true
	arg_4_0._cacheSkill = {}
	arg_4_0._commanderSkillList = {}
	arg_4_0._sideSkillFloatStateList = {}

	local var_4_12 = arg_4_0._sideSkillFloatStateList

	ys = var_4
	var_4_12[var_4.Battle.BattleConfig.FRIENDLY_CODE] = {
		{},
		{},
		{}
	}

	local var_4_13 = arg_4_0._sideSkillFloatStateList

	ys = var_4
	var_4_13[var_4.Battle.BattleConfig.FOE_CODE] = {
		{},
		{},
		{}
	}

	arg_4_0:initPainting()

	local var_4_14 = arg_4_0._tf

	arg_4_0._fxContainerUpper = var_3.Find(var_4_14, "FXContainerUpper")

	local var_4_15 = arg_4_0._tf

	arg_4_0._fxContainerBottom = var_3.Find(var_4_15, "FXContainerBottom")

	local var_4_16 = arg_4_0._tf
	local var_4_17 = var_3.GetComponentInParent

	typeof = var_6
	UnityEngine = var_8

	local var_4_18

	if not var_4_17(var_4_16, var_6(var_8.Canvas)) or not var_3.sortingOrder then
		var_4_18 = 0
	end

	arg_4_0._canvasOrder = var_4_18
	GetComponent = var_4_18

	local var_4_19 = arg_4_0._tf

	typeof = var_7
	AspectRatioFitter = var_9
	arg_4_0._ratioFitter = var_4_18(var_4_19, var_7(var_9))
	BATTLE_DEFAULT_UNIT_DETAIL = var_4

	if not var_4 then
		local var_4_20 = arg_4_0._go
		local var_4_21 = var_4.AddComponent

		typeof = var_7
		RectMask2D = var_9

		var_4_21(var_4_20, var_7(var_9))
	end

	return
end

function var_0_1.initPainting(arg_7_0)
	ys = var_1_10001

	local var_7_0 = var_1_10001.Battle.BattleResourceManager.GetInstance()
	local var_7_1 = var_1.InstSkillPaintingUI(var_7_0)

	setParent = var_1_10003

	var_1_10003(var_7_1, arg_7_0.uiCanvas, false)

	arg_7_0._paintingUI = var_7_1

	local var_7_2 = var_7_1
	local var_7_3 = var_7_1.GetComponent

	typeof = var_6
	Animator = var_1_10008
	arg_7_0._paintingAnimator = var_7_3(var_7_2, var_6(var_1_10008))

	local var_7_4 = arg_7_0._paintingAnimator

	var_7_4.enabled = false
	findTF = var_7_4
	arg_7_0._paintingParticleContainer = var_7_4(var_7_1, "particleContainer")
	findTF = var_3
	arg_7_0._paintingParticles = var_3(arg_7_0._paintingParticleContainer, "effect")

	local var_7_5 = arg_7_0._paintingParticles
	local var_7_6 = var_3.GetComponent

	typeof = var_6
	ParticleSystem = var_1_10008
	arg_7_0._paintingParticleSystem = var_7_6(var_7_5, var_6(var_1_10008))

	local var_7_7 = arg_7_0._paintingParticleSystem

	var_3.Stop(var_7_7, true)

	findTF = var_3
	arg_7_0._paintingFitter = var_3(var_7_1, "hero/fitter")
	removeAllChildren = var_3

	var_3(arg_7_0._paintingFitter)

	GetOrAddComponent = var_3

	local var_7_8 = var_3(arg_7_0._paintingFitter, "PaintingScaler")

	var_7_8.FrameName = "lihuisha"
	var_7_8.Tween = 1

	local var_7_9 = var_7_1
	local var_7_10 = var_7_1.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10009

	local var_7_11 = var_7_10(var_7_9, var_7(var_1_10009))

	var_4.SetEndEvent(var_7_11, function(arg_8_0)
		if arg_7_0._currentPainting then
			setActive = var_1

			var_1(arg_7_0._currentPainting, false)

			arg_7_0._currentPainting = nil
		end

		return
	end)

	return
end

function var_0_1.EnableSkillFloat(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0._skillFloat then
		return
	end

	arg_9_0._skillFloat = arg_9_1

	if arg_9_0._skillFloat then
		ipairs = var_2

		for iter_9_0, iter_9_1 in var_2(arg_9_0._cacheSkill) do
			arg_9_0:SkillHrzPop(iter_9_1.skillName, iter_9_1.caster, iter_9_1.commander, iter_9_1.hrzIcon)
		end

		arg_9_0._cacheSkill = {}
	else
		local var_9_0 = arg_9_0._skillFloatPool

		var_2.AllRecycle(var_9_0)

		local var_9_1 = arg_9_0._skillFloatCMDPool

		var_2.AllRecycle(var_9_1)

		arg_9_0._preCommanderSkillTF = nil
		arg_9_0._preSkillTF = nil
	end

	SetActive = var_2

	var_2(arg_9_0.skillTips, arg_9_1)

	return
end

function var_0_1.SkillHrzPop(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not arg_10_0._skillFloat then
		table = var_5

		var_5.insert(arg_10_0._cacheSkill, {
			skillName = arg_10_1,
			caster = arg_10_2,
			commander = arg_10_3,
			hrzIcon = arg_10_4
		})

		return
	end

	ys = var_5

	local var_10_0 = var_5.Battle.BattleResourceManager.GetInstance()
	local var_10_1
	local var_10_2

	if arg_10_3 then
		if arg_10_0._commanderSkillList[arg_10_3] and arg_10_0._commanderSkillList[arg_10_3][arg_10_1] then
			return
		end

		var_10_1 = arg_10_0._skillFloatCMDPool
		ys = var_8

		if var_8.Battle.BattleState.GetCombatSkinKey() == "Standard" then
			var_10_2 = var_10_0:GetCommanderHrzIcon(arg_10_3)
		else
			var_10_2 = var_10_0:GetCommanderIcon(arg_10_3)
		end
	else
		var_10_1 = arg_10_0._skillFloatPool

		local var_10_3 = arg_10_2:GetUnitType()

		ys = var_1_10009

		if var_10_3 == var_1_10009.Battle.BattleConst.UnitType.PLAYER_UNIT then
			var_10_3 = arg_10_4 or arg_10_2:GetTemplate().painting
			ys = var_9

			if var_9.Battle.BattleState.GetCombatSkinKey() == "Standard" then
				var_1_10011 = var_10_0
				var_10_2 = var_10_0.GetCharacterIcon(var_1_10011, var_10_3)
			else
				var_1_10011 = var_10_0
				var_10_2 = var_10_0.GetCharacterSquareIcon(var_1_10011, var_10_3)
			end
		else
			ys = var_10_3

			if var_10_3.Battle.BattleState.GetCombatSkinKey() == "Standard" then
				local var_10_4 = var_10_0
				local var_10_5 = var_10_0.GetCharacterIcon

				pg = var_1_10011
				var_10_2 = var_10_5(var_10_4, var_1_10011.enemy_data_statistics[arg_10_2:GetTemplateID()].icon)
			else
				local var_10_6 = var_10_0
				local var_10_7 = var_10_0.GetCharacterSquareIcon

				pg = var_1_10011
				var_10_2 = var_10_7(var_10_6, var_1_10011.enemy_data_statistics[arg_10_2:GetTemplateID()].icon)
			end
		end
	end

	local var_10_8 = var_10_1:GetObject().transform

	var_10_8.localScale = var_0_1.SKILL_FLOAT_SCALE
	setText = var_10
	findTF = var_1_10012

	local var_10_9 = var_1_10012(var_10_8, "skill/skill_name/Text")

	SwitchSpecialChar = var_1_10013
	HXSet = var_15

	var_10(var_10_9, var_1_10013(var_15.hxLan(arg_10_1)))

	findTF = var_10

	local var_10_10 = var_10(var_10_8, "skill/icon_mask/icon")

	findTF = var_1_10011

	local var_10_11 = var_1_10011(var_10_8, "skill/skill_name")
	local var_10_12 = var_10_8
	local var_10_13 = var_10_8.GetComponent

	typeof = var_15
	Animation = var_17

	if var_10_13(var_10_12, var_15(var_17)) then
		local var_10_14 = 1

		::label_10_0::

		var_1_10016 = var_12

		if var_12.GetClip(var_1_10016, "anim_skinui_skill_" .. var_10_14) then
			repeat
				var_10_14 = var_10_14 + 1

				goto label_10_0
			until true
		end

		if var_10_14 > 1 then
			var_1_10016 = var_12

			local var_10_15 = var_12.Play
			local var_10_16 = "anim_skinui_skill_"

			math = var_1_10018

			var_10_15(var_1_10016, var_10_16 .. var_1_10018.random(var_10_14 - 1))
		end
	end

	local var_10_17 = var_10_10
	local var_10_18 = var_10_10.GetComponent

	typeof = var_1_10016
	Image = var_1_10018
	var_10_18(var_10_17, var_1_10016(var_1_10018)).sprite = var_10_2

	local var_10_19, var_10_20 = arg_10_2:GetIFF()
	local var_10_21 = arg_10_2:GetIFF()

	ys = var_16

	if var_10_21 == var_16.Battle.BattleConfig.FRIENDLY_CODE then
		Color = var_10_21
		var_10_20 = var_10_21.New(1, 1, 1, 1)
	else
		Color = var_10_21
		var_10_20 = var_10_21.New(1, 0.33, 0.33, 1)
	end

	local var_10_22 = var_10_11
	local var_10_23 = var_10_11.GetComponent

	typeof = var_1_10018
	Image = var_1_10020

	local var_10_24 = var_10_23(var_10_22, var_1_10018(var_1_10020))

	var_10_24.color = var_10_20
	findTF = var_10_24

	local var_10_25 = var_10_24(var_10_8, "skill")
	local var_10_26 = var_15.GetComponent

	typeof = var_18
	Image = var_1_10020
	var_10_26(var_10_25, var_18(var_1_10020)).color = var_10_20

	if arg_10_3 then
		arg_10_0:commanderSkillFloat(arg_10_3, arg_10_1, var_8)
	else
		local var_10_27 = var_0_2.CameraPosToUICamera
		local var_10_28 = arg_10_2:GetPosition()
		local var_10_29 = var_10_27(var_17.Clone(var_10_28))

		ys = var_16

		local var_10_30 = var_16.Battle.BattleCameraUtil.GetInstance()
		local var_10_31 = var_16.GetCharacterArrowBarPosition(var_10_30, var_10_29)

		table = var_17

		local var_10_32 = var_17.contains

		ShipType = var_19

		local var_10_33 = var_10_32(var_19.SubShipType, arg_10_2:GetTemplate().type)
		local var_10_34 = arg_10_2:GetMainUnitIndex()

		if var_10_31 == nil or var_10_31 == nil and var_10_33 and not arg_10_2:IsMainFleetUnit() then
			ys = var_19

			local var_10_35

			if var_10_19 == var_19.Battle.BattleConfig.FRIENDLY_CODE then
				var_10_35 = var_0_2.CameraPosToUICamera

				local var_10_36 = arg_10_2:GetPosition()
				local var_10_37 = var_21.Clone(var_10_36)

				var_10_29 = var_10_35(var_21.Add(var_10_37, var_0_1.IN_VIEW_FRIEND_SKILL_OFFSET))
			else
				var_10_35 = var_0_2.CameraPosToUICamera

				local var_10_38 = arg_10_2:GetPosition()
				local var_10_39 = var_21.Clone(var_10_38)

				var_10_29 = var_10_35(var_21.Add(var_10_39, var_0_1.IN_VIEW_FOE_SKILL_OFFSET))
			end

			Vector3 = var_10_35
			var_10_8.position = var_10_35(var_10_29.x, var_10_29.y, -2)
			rtf = var_19

			local var_10_40 = var_19(var_10_8).rect.width * 0.5
			local var_10_41 = var_10_8.anchoredPosition.x

			Screen = var_22

			if var_22.width * 0.5 < var_10_40 + var_10_41 then
				rtf = var_23
				var_20.x = var_10_41 - var_23(var_10_8).rect.width
				var_10_8.anchoredPosition = var_20
			end

			if arg_10_0._preSkillTF then
				arg_10_0.handleSkillFloatCld(arg_10_0._preSkillTF, var_10_8)
			end

			arg_10_0._preSkillTF = var_10_8

			local var_10_42 = var_10_8
			local var_10_43 = var_10_8.GetComponent

			typeof = var_1_10026
			DftAniEvent = var_1_10028

			local var_10_44 = var_10_43(var_10_42, var_1_10026(var_1_10028))

			var_23.SetEndEvent(var_10_44, function(arg_11_0)
				arg_10_0._preSkillTF = nil

				local var_11_0 = var_10_1

				var_1.Recycle(var_11_0, var_0)

				return
			end)
		else
			local var_10_45
			local var_10_46 = var_0_1.SIDE_ALIGNMENT[var_10_34]
			local var_10_47 = arg_10_0._sideSkillFloatStateList[var_10_19][var_10_34]

			for iter_10_0 = 1, #var_10_47 do
				if var_10_47[iter_10_0] then
					var_10_45 = iter_10_0

					break
				end
			end

			if var_10_45 == nil then
				var_10_45 = #var_10_47 + 1
			end

			var_10_47[var_10_45] = false
			Vector3 = var_22
			var_10_8.position = var_22(var_10_31.x, var_10_31.y, -2)

			local var_10_48 = var_10_8.anchoredPosition

			var_10_48.y = var_10_46[var_10_45]
			ys = var_23

			if var_10_19 == var_23.Battle.BattleConfig.FOE_CODE then
				var_10_48.x = var_0_1.FOE_SIDE_X_OFFSET
			end

			var_10_8.anchoredPosition = var_10_48

			local var_10_49 = var_10_8
			local var_10_50 = var_10_8.GetComponent

			typeof = var_26
			DftAniEvent = var_1_10028

			local var_10_51 = var_10_50(var_10_49, var_26(var_1_10028))

			var_23.SetEndEvent(var_10_51, function(arg_12_0)
				var_10_47[var_10_45] = true

				local var_12_0 = var_10_1

				var_1.Recycle(var_12_0, var_0)

				return
			end)
		end
	end

	return
end

function var_0_1.SkillHrzPopCover(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:SkillHrzPop(arg_13_1, arg_13_2, nil, arg_13_3)

	return
end

function var_0_1.handleSkillFloatCld(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.anchoredPosition
	local var_14_1 = arg_14_0.anchoredPosition.y

	math = var_1_10004

	local var_14_2 = var_1_10004.floor

	math = var_1_10006

	if var_14_2(var_1_10006.abs(var_14_0.y - var_14_1)) <= 112.5 then
		var_14_0.y = var_14_1 + 112.5
		arg_14_1.anchoredPosition = var_14_0
	end

	return
end

function var_0_1.handleSkillSinkCld(arg_15_0, arg_15_1)
	return
end

function var_0_1.commanderSkillFloat(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0._commanderSkillList
	local var_16_1

	if not arg_16_0._commanderSkillList[arg_16_1] then
		var_16_1 = {}
	end

	var_16_0[arg_16_1] = var_16_1
	arg_16_0._commanderSkillList[arg_16_1][arg_16_2] = true

	local var_16_2 = arg_16_3.transform.anchoredPosition

	var_16_2.x = 0
	var_16_2.y = 0
	var_4.anchoredPosition = var_16_2

	if arg_16_0._preCommanderSkillTF then
		local var_16_3 = arg_16_0._preCommanderSkillTF.anchoredPosition.y

		math = var_1_10007

		local var_16_4 = var_1_10007.floor

		math = var_1_10009

		if var_16_4(var_1_10009.abs(var_16_2.y - var_16_3)) <= 97.5 then
			var_16_2.y = var_16_3 - 97.5
		end
	end

	var_4.anchoredPosition = var_16_2
	arg_16_0._preCommanderSkillTF = var_4

	local var_16_5 = var_4
	local var_16_6 = var_4.GetComponent

	typeof = var_1_10009
	DftAniEvent = var_1_10011

	local var_16_7 = var_16_6(var_16_5, var_1_10009(var_1_10011))

	var_6.SetEndEvent(var_16_7, function(arg_17_0)
		arg_16_0._commanderSkillList[arg_16_1][arg_16_2] = nil
		arg_16_0._preCommanderSkillTF = nil

		local var_17_0 = arg_16_0._skillFloatCMDPool

		var_1.Recycle(var_17_0, arg_16_3)

		return
	end)

	return
end

function var_0_1.CutInPainting(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_0._currentPainting then
		local var_18_0 = arg_18_0._paintingAnimator

		var_18_0.enabled = false
		setActive = var_18_0

		var_18_0(arg_18_0._currentPainting, false)
	end

	local var_18_1

	if not arg_18_4 and not arg_18_1.painting then
		var_18_1 = arg_18_1.prefab
	end

	if arg_18_0._skillPaintings[var_18_1] == nil then
		ys = var_6

		local var_18_2 = var_6.Battle.BattleResourceManager.GetInstance()
		local var_18_3 = var_6.InstPainting(var_18_2, var_18_1)
		local var_18_4 = arg_18_0._skillPaintings

		var_18_4[var_18_1] = var_18_3
		setParent = var_18_4

		var_18_4(var_18_3, arg_18_0._paintingFitter, false)
	end

	arg_18_0._currentPainting = arg_18_0._skillPaintings[var_18_1]
	setActive = var_6

	var_6(arg_18_0._currentPainting, true)

	LuaHelper = var_6

	var_6.SetParticleSpeed(arg_18_0._paintingUI, arg_18_2)

	Vector3 = var_6

	local var_18_5 = var_6(arg_18_3, 1, 1)

	arg_18_0._paintingUI.transform.localScale = var_18_5
	arg_18_0._paintingParticleContainer.transform.localScale = var_18_5

	local var_18_6 = arg_18_0._paintingParticles.transform

	Vector3 = var_8
	var_18_6.localEulerAngles = var_8(0, 90 * arg_18_3, 0)

	local var_18_7 = arg_18_0._paintingParticleSystem

	var_7.Play(var_18_7, true)

	arg_18_0._paintingAnimator.speed = arg_18_2
	arg_18_0._paintingAnimator.enabled = true

	local var_18_8 = arg_18_0._paintingAnimator

	var_7.Play(var_18_8, "skill_painting", -1, 0)

	return
end

function var_0_1.CutInPaintingDAL(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	ys = var_1_10005

	local var_19_0 = var_1_10005.Battle.BattleResourceManager.GetInstance()
	local var_19_1 = var_5.InstSkillPaintingDALUI(var_19_0)

	setParent = var_1_10007

	var_1_10007(var_19_1, arg_19_0.uiCanvas, false)

	findTF = var_1_10007

	local var_19_2 = var_1_10007(var_19_1, "hero/fitter")
	local var_19_3 = arg_19_4.cutin_cover_DAL

	GetOrAddComponent = var_9

	local var_19_4 = var_9(var_19_2, "PaintingScaler")

	var_19_4.FrameName = "lihuisha"
	var_19_4.Tween = 1
	ys = var_10

	local var_19_5 = var_10.Battle.BattleResourceManager.GetInstance()
	local var_19_6 = var_10.InstPainting(var_19_5, var_19_3)

	setParent = var_11

	var_11(var_19_6, var_19_2, false)

	local var_19_7 = var_19_1
	local var_19_8 = var_19_1.GetComponent

	typeof = var_14
	Animator = var_1_10016

	local var_19_9 = var_19_8(var_19_7, var_14(var_1_10016))

	var_11.Play(var_19_9, "skill_painting", -1, 0)

	setText = var_11
	findTF = var_19_9

	var_11(var_19_9(var_19_1, "pop/text"), arg_19_4.cutin_script)

	local var_19_10 = var_19_1
	local var_19_11 = var_19_1.GetComponent

	typeof = var_14
	DftAniEvent = var_16

	local var_19_12 = var_19_11(var_19_10, var_14(var_16))

	var_11.SetEndEvent(var_19_12, function(arg_20_0)
		setActive = var_2_10001

		var_2_10001(var_19_1, false)

		return
	end)

	return
end

function var_0_1.didEnter(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0._tf, false)

	arg_21_0._ratioFitter.enabled = true

	local var_21_0 = arg_21_0._ratioFitter

	pg = var_2

	local var_21_1 = var_2.CameraFixMgr.GetInstance()

	var_21_0.aspectRatio = var_2.GetBattleUIRatio(var_21_1)
	pg = var_21_0

	local var_21_2 = var_21_0.CameraFixMgr.GetInstance()
	local var_21_3 = var_1.bind

	pg = var_21_1
	arg_21_0.camEventId = var_21_3(var_21_2, var_21_1.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_21_0._ratioFitter

		pg = var_2_10003

		local var_22_1 = var_2_10003.CameraFixMgr.GetInstance()

		var_22_0.aspectRatio = var_3.GetBattleUIRatio(var_22_1)

		return
	end)
	ys = var_1

	local var_21_4 = var_1.Battle.BattleState.GetInstance()

	var_1.SetBattleUI(var_21_4, arg_21_0)

	onButton = var_2

	local var_21_5 = arg_21_0
	local var_21_6 = arg_21_0._tf
	local var_21_7 = var_5.Find(var_21_6, "PauseBtn")

	local function var_21_8()
		local var_23_0 = arg_21_0
		local var_23_1 = var_0.emit

		BattleMediator = var_2_10003

		var_23_1(var_23_0, var_2_10003.ON_PAUSE)

		return
	end

	SFX_CONFIRM = var_21_6

	var_2(var_21_5, var_21_7, var_21_8, var_21_6)

	local var_21_9 = arg_21_0._tf

	arg_21_0._chatBtn = var_2.Find(var_21_9, "chatBtnContainer/chatBtn")

	local var_21_10 = arg_21_0._chatBtn
	local var_21_11 = var_2.GetComponent

	typeof = var_5
	Animation = var_21_6

	local var_21_12 = var_21_11(var_21_10, var_5(var_21_6))

	onButton = var_21_2

	var_21_2(arg_21_0, arg_21_0._chatBtn, function()
		local var_24_0 = arg_21_0
		local var_24_1 = var_0.emit

		BattleMediator = var_2_10003

		local var_24_2 = var_2_10003.ON_CHAT
		local var_24_3 = arg_21_0._tf

		var_24_1(var_24_0, var_24_2, var_4.Find(var_24_3, "chatContainer"))

		if not var_21_12 then
			setActive = var_0

			var_0(arg_21_0._chatBtn, false)
		else
			local var_24_4 = var_21_12

			var_0.Play(var_24_4, "chatbtn_out")
		end

		return
	end)

	onToggle = var_21_2

	local var_21_13 = arg_21_0
	local var_21_14 = arg_21_0._tf
	local var_21_15 = var_6.Find(var_21_14, "AutoBtn")

	local function var_21_16(arg_25_0)
		local var_25_0 = var_0
		local var_25_1 = var_1.GetBattleType(var_25_0)
		local var_25_2 = arg_21_0
		local var_25_3 = var_2.emit

		BattleMediator = var_2_10005

		local var_25_4 = var_2_10005.ON_AUTO
		local var_25_5 = {
			isOn = not arg_25_0
		}
		local var_25_6 = arg_21_0._tf

		var_25_5.toggle = var_7.Find(var_25_6, "AutoBtn")
		var_25_5.system = var_25_1

		var_25_3(var_25_2, var_25_4, var_25_5)

		local var_25_7 = var_0
		local var_25_8 = var_2.ActiveBot

		ys = var_25_4

		var_25_8(var_25_7, var_25_4.Battle.BattleState.IsAutoBotActive(var_25_1))

		local var_25_9 = var_0

		if var_2.ChatUseable(var_25_9) then
			setActive = var_25_0

			var_25_0(arg_21_0._chatBtn, true)

			if var_21_12 then
				local var_25_10 = var_21_12

				var_3.Play(var_25_10, "chatbtn_in")
			end
		elseif var_21_12 then
			local var_25_11 = var_21_12

			var_3.Play(var_25_11, "chatbtn_out")
		else
			setActive = var_3

			var_3(arg_21_0._chatBtn, false)
		end

		return
	end

	SFX_PANEL = var_21_14
	SFX_PANEL = var_9

	var_21_2(var_21_13, var_21_15, var_21_16, var_21_14, var_9)

	onButton = var_21_2

	local var_21_17 = arg_21_0
	local var_21_18 = arg_21_0._tf
	local var_21_19 = var_6.Find(var_21_18, "CardPuzzleConsole/relic/bg")

	local function var_21_20()
		local var_26_0 = var_0
		local var_26_1 = var_0.GetProxyByName

		ys = var_2_10003

		local var_26_2 = var_26_1(var_26_0, var_2_10003.Battle.BattleDataProxy.__name)
		local var_26_3 = var_0.GetFleetByIFF

		ys = var_2_10004

		local var_26_4 = var_26_3(var_26_2, var_2_10004.Battle.BattleConfig.FRIENDLY_CODE)
		local var_26_5 = var_1.GetCardPuzzleComponent(var_26_4)
		local var_26_6 = var_2.GetRelicList(var_26_5)
		local var_26_7 = arg_21_0
		local var_26_8 = var_4.emit

		BattleMediator = var_2_10007

		var_26_8(var_26_7, var_2_10007.ON_PUZZLE_RELIC, {
			relicList = var_26_6
		})

		return
	end

	SFX_CONFIRM = var_21_18

	var_21_2(var_21_17, var_21_19, var_21_20, var_21_18)

	onButton = var_21_2

	local var_21_21 = arg_21_0
	local var_21_22 = arg_21_0._tf
	local var_21_23 = var_6.Find(var_21_22, "CardPuzzleConsole/deck/bg")

	local function var_21_24()
		local var_27_0 = var_0
		local var_27_1 = var_0.GetProxyByName

		ys = var_2_10003

		local var_27_2 = var_27_1(var_27_0, var_2_10003.Battle.BattleDataProxy.__name)
		local var_27_3 = var_0.GetFleetByIFF

		ys = var_2_10004

		local var_27_4 = var_27_3(var_27_2, var_2_10004.Battle.BattleConfig.FRIENDLY_CODE)
		local var_27_5 = var_1.GetCardPuzzleComponent(var_27_4)
		local var_27_6 = var_2.GetDeck(var_27_5)
		local var_27_7 = var_3.GetCardList(var_27_6)
		local var_27_8 = var_2:GetHand()
		local var_27_9 = var_4.GetCardList(var_27_8)
		local var_27_10 = arg_21_0
		local var_27_11 = var_5.emit

		BattleMediator = var_2_10008

		var_27_11(var_27_10, var_2_10008.ON_PUZZLE_CARD, {
			card = var_27_7,
			hand = var_27_9
		})

		return
	end

	SFX_CONFIRM = var_21_22

	var_21_2(var_21_21, var_21_23, var_21_24, var_21_22)
	var_1:ConfigBattleEndFunc(function(arg_28_0)
		local var_28_0 = arg_21_0

		var_1.clear(var_28_0)

		local var_28_1 = arg_21_0
		local var_28_2 = var_1.emit

		BattleMediator = var_2_10004

		var_28_2(var_28_1, var_2_10004.ON_BATTLE_RESULT, arg_28_0)

		return
	end)

	ys = var_3

	local var_21_25 = var_3.Battle.BattleConst.BuffEffectType
	local var_21_26 = {
		var_21_25.ON_START_GAME,
		var_21_25.ON_FLAG_SHIP,
		var_21_25.ON_CONSORT,
		var_21_25.ON_LEADER,
		var_21_25.ON_REAR,
		var_21_25.ON_SUB_LEADER,
		var_21_25.ON_SUB_CONSORT
	}
	local var_21_27 = 0 + (function(arg_29_0)
		local var_29_0 = 0

		ipairs = var_2_10002

		for iter_29_0, iter_29_1 in var_2_10002(arg_29_0) do
			ys = var_2_10007
			var_29_0 = var_29_0 + var_2_10007.Battle.BattleDataFunction.GetShipSkillTriggerCount(iter_29_1, var_21_26)
		end

		return var_29_0
	end)(arg_21_0.contextData.battleData.MainUnitList) + var_6(arg_21_0.contextData.battleData.VanguardUnitList) + var_6(arg_21_0.contextData.battleData.SubUnitList) + 4

	pg = var_7

	local var_21_28 = var_7.Pool.New(arg_21_0.skillRoot, arg_21_0.skillTpl, var_21_27, 10, true, false)

	arg_21_0._skillFloatPool = var_7.InitSize(var_21_28)

	local var_21_29 = arg_21_0._skillFloatPool

	var_7.SetRecycleFuncs(var_21_29, function(arg_30_0)
		local var_30_0 = arg_30_0.transform
		local var_30_1 = var_1.GetComponent

		typeof = var_2_10004
		DftAniEvent = var_2_10006

		local var_30_2 = var_30_1(var_30_0, var_2_10004(var_2_10006))

		var_1.OnDestroy(var_30_2)

		return
	end)

	local var_21_30 = arg_21_0
	local var_21_31 = arg_21_0.emit

	BattleMediator = var_10

	var_21_31(var_21_30, var_10.ENTER)
	arg_21_0:initPauseWindow()

	if arg_21_0.contextData.prePause then
		triggerButton = var_7

		local var_21_32 = arg_21_0._tf

		var_7(var_9.Find(var_21_32, "PauseBtn"))
	end

	setActive = var_7

	var_7(arg_21_0._chatBtn, var_1:ChatUseable())

	return
end

function var_0_1.onBackPressed(arg_31_0)
	isActive = var_1_10001

	if var_1_10001(arg_31_0.pauseWindow) then
		pg = var_1

		local var_31_0 = var_1.CriMgr.GetInstance()
		local var_31_1 = var_1.PlaySoundEffect_V3

		SFX_CANCEL = var_1_10004

		var_31_1(var_31_0, var_1_10004)

		triggerButton = var_31_1

		var_31_1(arg_31_0.continueBtn)
	end

	return
end

function var_0_1.activeBotHelp(arg_32_0, arg_32_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_32_0 = var_1_10002(var_1_10004)

	if not arg_32_1 then
		if arg_32_0.autoBotHelp then
			pg = var_3

			local var_32_1 = var_3.MsgboxMgr.GetInstance()

			var_3.hide(var_32_1)
		end

		return
	end

	if var_32_0.botHelp then
		return
	end

	arg_32_0.autoBotHelp = true
	pg = var_3

	local var_32_2 = var_3.MsgboxMgr.GetInstance()
	local var_32_3 = var_3.ShowMsgBox
	local var_32_4 = {}

	MSGBOX_TYPE_HELP = var_1_10007
	var_32_4.type = var_1_10007
	i18n = var_1_10007
	var_32_4.helps = var_1_10007("help_battle_auto")

	local var_32_5 = {}
	local var_32_6 = {
		text = "text_iknow"
	}

	SFX_CANCEL = var_9
	var_32_6.sound = var_9
	var_32_5[1] = var_32_6
	var_32_4.custom = var_32_5

	function var_32_4.onClose()
		arg_32_0.autoBotHelp = false

		return
	end

	var_32_3(var_32_2, var_32_4)

	var_32_0.botHelp = true

	return
end

function var_0_1.exitBattle(arg_34_0, arg_34_1)
	if not arg_34_1 then
		local var_34_0 = arg_34_0
		local var_34_1 = arg_34_0.emit

		BattleMediator = var_1_10005

		var_34_1(var_34_0, var_1_10005.ON_QUIT_BATTLE_MANUALLY)

		local var_34_2 = arg_34_0
		local var_34_3 = arg_34_0.emit

		BattleMediator = var_5

		var_34_3(var_34_2, var_5.ON_BACK_PRE_SCENE)
	elseif arg_34_1 == "kick" then
		-- block empty
	end

	return
end

function var_0_1.setChapter(arg_35_0, arg_35_1)
	arg_35_0._chapter = arg_35_1

	return
end

function var_0_1.setFleet(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	arg_36_0._mainShipVOs = arg_36_1
	arg_36_0._vanShipVOs = arg_36_2
	arg_36_0._subShipVOs = arg_36_3

	return
end

function var_0_1.initPauseWindow(arg_37_0)
	local var_37_0 = arg_37_0._tf

	arg_37_0.pauseWindow = var_1.Find(var_37_0, "Msgbox")

	local var_37_1 = arg_37_0.pauseWindow

	arg_37_0.LeftTimeContainer = var_1.Find(var_37_1, "window/LeftTime")

	local var_37_2 = arg_37_0.pauseWindow

	arg_37_0.LeftTime = var_1.Find(var_37_2, "window/LeftTime/Text")
	arg_37_0.mainTFs = {}
	arg_37_0.vanTFs = {}
	setText = var_1

	local var_37_3 = arg_37_0.LeftTimeContainer
	local var_37_4 = var_3.Find(var_37_3, "label")

	i18n = var_4

	var_1(var_37_4, var_4("battle_battleMediator_remainTime"))

	setText = var_1

	local var_37_5 = arg_37_0.pauseWindow
	local var_37_6 = var_3.Find(var_37_5, "window/van/power/title")

	i18n = var_4

	var_1(var_37_6, var_4("word_vanguard_fleet"))

	setText = var_1

	local var_37_7 = arg_37_0.pauseWindow
	local var_37_8 = var_3.Find(var_37_7, "window/main/power/title")

	i18n = var_4

	var_1(var_37_8, var_4("word_main_fleet"))

	local function var_37_9(arg_38_0, arg_38_1, arg_38_2)
		for iter_38_0 = 1, 3 do
			local var_38_0 = arg_38_1:Find("ship_" .. iter_38_0)

			setActive = var_2_10008

			var_2_10008(var_38_0, arg_38_2 and iter_38_0 <= #arg_38_2)

			if arg_38_2 and iter_38_0 <= #arg_38_2 then
				updateShip = var_2_10008

				var_2_10008(var_38_0, arg_38_2[iter_38_0])
			end

			table = var_2_10008

			var_2_10008.insert(arg_38_0, var_38_0)
		end

		if arg_38_2 then
			local var_38_1 = 0

			ipairs = var_4

			for iter_38_1, iter_38_2 in var_4(arg_38_2) do
				var_38_1 = var_38_1 + iter_38_2:getShipCombatPower()
			end

			setText = var_4

			var_4(arg_38_1:Find("power/value"), var_38_1)
		end

		return
	end

	ys = var_1_10002

	local var_37_10 = var_1_10002.Battle.BattleState.GetInstance()
	local var_37_11 = var_2.GetBattleType(var_37_10)
	local var_37_12

	if arg_37_0._mainShipVOs then
		var_37_12 = var_37_9

		local var_37_13 = arg_37_0.mainTFs
		local var_37_14 = arg_37_0.pauseWindow

		var_37_12(var_37_13, var_7.Find(var_37_14, "window/main"), arg_37_0._mainShipVOs)

		var_37_12 = var_37_9

		local var_37_15 = arg_37_0.vanTFs
		local var_37_16 = arg_37_0.pauseWindow

		var_37_12(var_37_15, var_7.Find(var_37_16, "window/van"), arg_37_0._vanShipVOs)
	else
		SYSTEM_SCENARIO_SUB_STRIKE = var_37_12

		if var_37_11 == var_37_12 then
			arg_37_0.subTFs = {}

			local var_37_17 = arg_37_0.pauseWindow

			var_37_12 = var_37_12.Find(var_37_17, "window/main")
			setActive = var_37_10

			local var_37_18 = arg_37_0.pauseWindow

			var_37_10(var_7.Find(var_37_18, "window/van"), false)

			setActive = var_37_10

			local var_37_19 = arg_37_0.pauseWindow

			var_37_10(var_7.Find(var_37_19, "window/bg_fleet/Image (1)"), false)
			var_37_9(arg_37_0.subTFs, var_37_12, arg_37_0._subShipVOs)

			setText = var_37_10

			local var_37_20 = var_37_12:Find("power/title")

			i18n = var_8

			var_37_10(var_37_20, var_8("index_shipType_qianTing"))

			var_37_10 = var_37_12.localPosition
			Vector3 = var_37_17
			var_37_12.localPosition = var_37_17(0, var_37_10.y, 0)
		end
	end

	findTF = var_37_12

	local var_37_21 = var_37_12(arg_37_0.pauseWindow, "window/Chapter")

	findTF = var_37_10

	local var_37_22 = var_37_10(arg_37_0.pauseWindow, "window/Chapter/Text")
	local var_37_23 = arg_37_0.pauseWindow

	arg_37_0.continueBtn = var_6.Find(var_37_23, "window/button_container/continue")

	local var_37_24 = arg_37_0.pauseWindow

	arg_37_0.leaveBtn = var_6.Find(var_37_24, "window/button_container/leave")
	setText = var_37_30

	local var_37_25 = arg_37_0.continueBtn
	local var_37_26 = var_8.Find(var_37_25, "pic")

	i18n = var_9

	var_37_30(var_37_26, var_9("battle_battleMediator_goOnFight"))

	setText = var_37_30

	local var_37_27 = arg_37_0.leaveBtn
	local var_37_28 = var_8.Find(var_37_27, "pic")

	i18n = var_9

	var_37_30(var_37_28, var_9("battle_battleMediator_existFight"))

	SYSTEM_SCENARIO = var_37_30

	if var_37_11 ~= var_37_30 then
		SYSTEM_SCENARIO_SUB_STRIKE = var_37_30

		local var_37_30, var_37_31

		if var_37_11 == var_37_30 then
			local var_37_29 = arg_37_0._chapter

			var_37_30 = var_37_30.getConfigTable(var_37_29)
			setText = var_37_34

			var_37_34(var_37_21, var_37_30.chapter_name)

			setText = var_37_34
			var_37_31 = var_37_22
			string = var_10

			var_37_34(var_37_31, var_10.split(var_37_30.name, "|")[1])

			goto label_37_0
		end

		SYSTEM_ROUTINE = var_37_30

		if var_37_11 ~= var_37_30 then
			SYSTEM_DUEL = var_37_30

			if var_37_11 ~= var_37_30 then
				SYSTEM_HP_SHARE_ACT_BOSS = var_37_30

				if var_37_11 ~= var_37_30 then
					SYSTEM_BOSS_EXPERIMENT = var_37_30

					if var_37_11 ~= var_37_30 then
						SYSTEM_ACT_BOSS = var_37_30

						if var_37_11 ~= var_37_30 then
							SYSTEM_ACT_BOSS_SP = var_37_30

							if var_37_11 ~= var_37_30 then
								SYSTEM_BOSS_RUSH = var_37_30

								if var_37_11 ~= var_37_30 then
									SYSTEM_BOSS_RUSH_EX = var_37_30

									if var_37_11 ~= var_37_30 then
										SYSTEM_BOSS_RUSH_COLLABRATE = var_37_30

										if var_37_11 ~= var_37_30 then
											SYSTEM_LIMIT_CHALLENGE = var_37_30

											if var_37_11 ~= var_37_30 then
												SYSTEM_BOSS_SINGLE = var_37_30

												if var_37_11 ~= var_37_30 then
													SYSTEM_BOSS_SINGLE_VARIABLE = var_37_30

													local var_37_34

													if var_37_11 == var_37_30 then
														setText = var_37_30

														var_37_30(var_37_21, "SP")

														local var_37_32 = var_2

														var_37_30 = var_2.GetProxyByName
														ys = var_37_31

														local var_37_33 = var_37_30(var_37_32, var_37_31.Battle.BattleDataProxy.__name)

														var_37_30 = var_37_30.GetInitData(var_37_33).StageTmpId
														pg = var_37_34
														var_37_34 = var_37_34.expedition_data_template[var_37_30]
														setText = var_37_33

														var_37_33(var_37_22, var_37_34.name)

														goto label_37_0
													end

													SYSTEM_DEBUG = var_37_30

													if var_37_11 == var_37_30 then
														setText = var_37_30

														var_37_30(var_37_21, "??")

														setText = var_37_30

														var_37_30(var_37_22, "碧蓝梦境")

														goto label_37_0
													end

													SYSTEM_CHALLENGE = var_37_30

													if var_37_11 == var_37_30 then
														local var_37_35 = arg_37_0._chapter

														var_37_30 = var_37_30.getNextExpedition(var_37_35)
														setText = var_37_34

														var_37_34(var_37_21, "SP")

														setText = var_37_34

														var_37_34(var_37_22, var_37_30.chapter_name[2])

														setActive = var_37_34

														var_37_34(arg_37_0.LeftTimeContainer, true)

														goto label_37_0
													end

													SYSTEM_WORLD_BOSS = var_37_30

													if var_37_11 ~= var_37_30 then
														SYSTEM_WORLD = var_37_30

														if var_37_11 == var_37_30 then
															setText = var_37_30

															local var_37_36 = var_37_21

															i18n = var_37_31

															var_37_30(var_37_36, var_37_31("world_battle_pause"))

															setText = var_37_30

															local var_37_37 = var_37_22

															i18n = var_37_31

															var_37_30(var_37_37, var_37_31("world_battle_pause2"))

															SYSTEM_WORLD_BOSS = var_37_30

															if var_37_11 == var_37_30 then
																setActive = var_37_30

																var_37_30(arg_37_0.leaveBtn, false)
															end
														else
															SYSTEM_GUILD = var_37_30

															if var_37_11 == var_37_30 then
																local var_37_38 = var_2

																var_37_30 = var_2.GetProxyByName
																ys = var_37_31

																local var_37_39 = var_37_30(var_37_38, var_37_31.Battle.BattleDataProxy.__name)

																var_37_30 = var_37_30.GetInitData(var_37_39).ActID
																pg = var_37_34

																local var_37_40 = var_37_34.guild_boss_event[var_37_30]

																setText = var_37_39

																var_37_39(var_37_21, "BOSS")

																setText = var_37_39

																local var_37_41 = var_37_22
																local var_37_42

																if not var_37_40 or not var_37_40.name then
																	var_37_42 = ""
																end

																var_37_39(var_37_41, var_37_42)
															else
																SYSTEM_TEST = var_37_30

																if var_37_11 ~= var_37_30 then
																	SYSTEM_SUB_ROUTINE = var_37_30

																	if var_37_11 ~= var_37_30 then
																		SYSTEM_SCENARIO_SUB_STRIKE = var_37_30

																		if var_37_11 ~= var_37_30 then
																			SYSTEM_PERFORM = var_37_30

																			if var_37_11 ~= var_37_30 then
																				SYSTEM_PROLOGUE = var_37_30

																				if var_37_11 ~= var_37_30 then
																					SYSTEM_DODGEM = var_37_30

																					if var_37_11 ~= var_37_30 then
																						SYSTEM_SIMULATION = var_37_30

																						if var_37_11 ~= var_37_30 then
																							SYSTEM_SUBMARINE_RUN = var_37_30

																							if var_37_11 ~= var_37_30 then
																								SYSTEM_BOSS_EXPERIMENT = var_37_30

																								if var_37_11 ~= var_37_30 then
																									SYSTEM_REWARD_PERFORM = var_37_30

																									if var_37_11 ~= var_37_30 then
																										SYSTEM_AIRFIGHT = var_37_30

																										if var_37_11 == var_37_30 then
																											-- block empty
																										else
																											SYSTEM_CARDPUZZLE = var_37_30

																											if var_37_11 == var_37_30 then
																												-- block empty
																											else
																												assert = var_37_30

																												var_37_30(false, "System not defined " .. (var_37_11 or "NIL"))
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
																end
															end
														end

														::label_37_0::

														onButton = var_37_30

														var_37_30(arg_37_0, arg_37_0.leaveBtn, function()
															local var_39_0 = arg_37_0
															local var_39_1 = var_0.emit

															BattleMediator = var_2_10003

															var_39_1(var_39_0, var_2_10003.ON_LEAVE)

															local var_39_2 = arg_37_0.leaveBtn
															local var_39_3 = var_0.GetComponent

															typeof = var_3
															Animation = var_2_10005

															if var_39_3(var_39_2, var_3(var_2_10005)) and var_0:GetClip("msgbox_btn_blink") then
																var_0:Play("msgbox_btn_blink")
															end

															return
														end)

														onButton = var_37_30

														var_37_30(arg_37_0, arg_37_0.continueBtn, function()
															local var_40_0 = arg_37_0.continueBtn
															local var_40_1 = var_0.GetComponent

															typeof = var_2_10003
															Animation = var_2_10005

															if var_40_1(var_40_0, var_2_10003(var_2_10005)) and var_0:GetClip("msgbox_btn_blink") then
																var_0:Play("msgbox_btn_blink")
															end

															local var_40_2 = arg_37_0.pauseWindow
															local var_40_3 = var_1.GetComponent

															typeof = var_2_10004
															Animation = var_2_10006

															if var_40_3(var_40_2, var_2_10004(var_2_10006)) then
																if var_1:IsPlaying("msgbox_out") then
																	var_1:Stop("msgbox_out")
																	var_1:Play("msgbox_in")
																else
																	var_1:Play("msgbox_out")

																	local var_40_4 = arg_37_0.pauseWindow
																	local var_40_5 = var_2.GetComponent

																	typeof = var_5
																	DftAniEvent = var_2_10007

																	local var_40_6 = var_40_5(var_40_4, var_5(var_2_10007))

																	var_2.SetEndEvent(var_40_6, function(arg_41_0)
																		local var_41_0 = arg_37_0

																		var_1.ClosePauseWindow(var_41_0)

																		local var_41_1 = var_0

																		var_1.Resume(var_41_1)

																		return
																	end)
																end
															else
																local var_40_7 = arg_37_0

																var_2.ClosePauseWindow(var_40_7)

																local var_40_8 = var_0

																var_2.Resume(var_40_8)
															end

															return
														end)

														onButton = var_37_30

														local var_37_43 = arg_37_0
														local var_37_44 = arg_37_0.pauseWindow

														var_37_30(var_37_43, var_9.Find(var_37_44, "help"), function()
															BATTLE_DEBUG = var_2_10000

															if var_2_10000 then
																PLATFORM = var_2_10000

																if var_2_10000 == 7 then
																	local var_42_0 = arg_37_0

																	var_2_10000.ClosePauseWindow(var_42_0)

																	local var_42_1 = var_0

																	var_2_10000.Resume(var_42_1)

																	local var_42_2 = var_0

																	var_2_10000.OpenConsole(var_42_2)

																	goto label_42_0
																end
															end

															pg = var_2_10000

															do
																local var_42_3 = var_2_10000.MsgboxMgr.GetInstance()
																local var_42_4 = var_0.ShowMsgBox
																local var_42_5 = {}

																MSGBOX_TYPE_HELP = var_2_10004
																var_42_5.type = var_2_10004
																i18n = var_2_10004
																var_42_5.helps = var_2_10004("help_battle_rule")

																var_42_4(var_42_3, var_42_5)
															end

															::label_42_0::

															return
														end)

														onButton = var_37_30

														local var_37_45 = arg_37_0
														local var_37_46 = arg_37_0.pauseWindow

														var_37_30(var_37_45, var_9.Find(var_37_46, "window/top/btnBack"), function()
															triggerButton = var_2_10000

															var_2_10000(arg_37_0.continueBtn)

															return
														end)

														onButton = var_37_30

														var_37_30(arg_37_0, arg_37_0.pauseWindow, function()
															triggerButton = var_2_10000

															var_2_10000(arg_37_0.continueBtn)

															return
														end)

														onButton = var_37_30

														var_37_30(arg_37_0, arg_37_0.pauseWindow, function()
															local var_45_0 = arg_37_0.pauseWindow
															local var_45_1 = var_0.GetComponent

															typeof = var_2_10003
															Animation = var_2_10005

															if var_45_1(var_45_0, var_2_10003(var_2_10005)) and var_0:IsPlaying("msgbox_out") then
																-- block empty
															else
																triggerButton = var_2_10001

																var_2_10001(arg_37_0.continueBtn)
															end

															return
														end)

														setActive = var_37_30

														var_37_30(arg_37_0.pauseWindow, false)

														return
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
		end
	end
end

function var_0_1.updatePauseWindow(arg_46_0)
	if not arg_46_0.pauseWindow then
		return
	end

	setActive = var_1

	var_1(arg_46_0.pauseWindow, true)

	pg = var_1

	local var_46_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_46_0, arg_46_0.pauseWindow)

	ys = var_1

	local var_46_1 = var_1.Battle.BattleState.GetInstance()
	local var_46_2 = var_1.GetProxyByName

	ys = var_1_10005

	local var_46_3 = var_46_2(var_46_1, var_1_10005.Battle.BattleDataProxy.__name)
	local var_46_4 = var_2.GetFleetByIFF

	ys = var_1_10006

	local var_46_5 = var_46_4(var_46_3, var_1_10006.Battle.BattleConfig.FRIENDLY_CODE)

	;(function(arg_47_0, arg_47_1)
		if not arg_47_0 then
			return
		end

		for iter_47_0 = 1, #arg_47_0 do
			local var_47_0 = arg_47_0[iter_47_0].id
			local var_47_1 = var_46_5

			if var_7.GetFreezeShipByID(var_47_1, var_47_0) then
				local var_47_2 = var_46_5
				local var_47_3 = var_7.GetFreezeShipByID(var_47_2, var_47_0)

				setSlider = var_2_10008

				local var_47_4 = arg_47_1[iter_47_0]

				var_2_10008(var_10.Find(var_47_4, "blood"), 0, 1, var_47_3:GetHPRate())

				SetActive = var_2_10008

				local var_47_5 = arg_47_1[iter_47_0]

				var_2_10008(var_10.Find(var_47_5, "mask"), false)
			else
				local var_47_6 = var_46_5
				local var_47_8

				if var_7.GetShipByID(var_47_6, var_47_0) then
					local var_47_7 = var_46_5

					var_47_8 = var_47_8.GetShipByID(var_47_7, var_47_0)
					setSlider = var_2_10008

					local var_47_9 = arg_47_1[iter_47_0]

					var_2_10008(var_10.Find(var_47_9, "blood"), 0, 1, var_47_8:GetHPRate())

					SetActive = var_2_10008

					local var_47_10 = arg_47_1[iter_47_0]

					var_2_10008(var_10.Find(var_47_10, "mask"), false)
				else
					setSlider = var_47_8

					local var_47_11 = arg_47_1[iter_47_0]

					var_47_8(var_9.Find(var_47_11, "blood"), 0, 1, 0)

					SetActive = var_47_8

					local var_47_12 = arg_47_1[iter_47_0]

					var_47_8(var_9.Find(var_47_12, "mask"), true)
				end
			end
		end

		return
	end)(arg_46_0._mainShipVOs, arg_46_0.mainTFs)
	var_4(arg_46_0._vanShipVOs, arg_46_0.vanTFs)

	if arg_46_0.subTFs then
		var_4(arg_46_0._subShipVOs, arg_46_0.subTFs)
	end

	setText = var_5

	local var_46_6 = arg_46_0.LeftTime

	ys = var_8

	local var_46_7 = var_8.Battle.BattleTimerView.formatTime

	math = var_1_10010

	var_5(var_46_6, var_46_7(var_1_10010.floor(var_2:GetCountDown())))

	return
end

function var_0_1.ClosePauseWindow(arg_48_0)
	setActive = var_1_10001

	var_1_10001(arg_48_0.pauseWindow, false)

	pg = var_1_10001

	local var_48_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_48_0, arg_48_0.pauseWindow, arg_48_0._tf)

	return
end

function var_0_1.AddUIFX(arg_49_0, arg_49_1, arg_49_2)
	arg_49_2 = arg_49_2 or 1

	local var_49_0 = arg_49_2 > 0

	tf = var_1_10004
	arg_49_1 = var_1_10004(arg_49_1)

	local var_49_1

	if not var_49_0 or not arg_49_0._fxContainerUpper then
		var_49_1 = arg_49_0._fxContainerBottom
	end

	arg_49_1:SetParent(var_49_1)

	pg = var_5

	var_5.ViewUtils.SetSortingOrder(arg_49_1, arg_49_0._canvasOrder + arg_49_2)

	pg = var_5

	local var_49_2 = var_5.ViewUtils.SetLayer
	local var_49_3 = arg_49_1

	Layer = var_8

	var_49_2(var_49_3, var_8.UI)

	return var_49_1.localScale
end

function var_0_1.OnCloseChat(arg_50_0)
	ys = var_1_10001

	local var_50_0 = var_1_10001.Battle.BattleState.GetInstance()
	local var_50_1 = var_1.IsBotActive(var_50_0)
	local var_50_2 = arg_50_0._chatBtn
	local var_50_3 = var_2.GetComponent

	typeof = var_1_10005
	Animation = var_1_10007

	local var_50_4 = var_50_3(var_50_2, var_1_10005(var_1_10007))

	if var_50_1 then
		setActive = var_50_0

		var_50_0(arg_50_0._chatBtn, true)

		if var_50_4 then
			var_50_4:Play("chatbtn_in")
		end
	elseif var_50_4 then
		var_50_4:Play("chatbtn_out")
	else
		setActive = var_50_0

		var_50_0(arg_50_0._chatBtn, false)
	end

	return
end

function var_0_1.clear(arg_51_0)
	arg_51_0._preSkillTF = nil

	local var_51_0 = arg_51_0._skillFloatPool

	var_1.AllRecycle(var_51_0)

	local var_51_1 = arg_51_0._skillFloatCMDPool

	var_1.AllRecycle(var_51_1)

	arg_51_0._preCommanderSkillTF = nil
	arg_51_0._commanderSkillList = nil
	arg_51_0._skillPaintings = nil
	arg_51_0._currentPainting = nil
	Destroy = var_1

	var_1(arg_51_0._paintingUI)

	return
end

function var_0_1.willExit(arg_52_0)
	local var_52_0 = arg_52_0._skillFloatPool

	var_1.Dispose(var_52_0)

	local var_52_1 = arg_52_0._skillFloatCMDPool

	var_1.Dispose(var_52_1)

	ys = var_1

	local var_52_2 = var_1.Battle.BattleState.GetInstance()

	var_1.ExitBattle(var_52_2)

	pg = var_1

	local var_52_3 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_52_3, arg_52_0.pauseWindow, arg_52_0._tf)

	ys = var_1

	var_1.Battle.BattleCameraUtil.GetInstance().ActiveMainCamera(false)

	pg = var_1

	local var_52_4 = var_1.CameraFixMgr.GetInstance()

	var_1.disconnect(var_52_4, arg_52_0.camEventId)

	return
end

return var_0_1
