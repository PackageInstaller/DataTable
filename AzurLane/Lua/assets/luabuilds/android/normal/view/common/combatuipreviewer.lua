class = var_0_10000

local var_0_0 = var_0_10000("CombatUIPreviewer")

var_0_0.WeaponButtonPreviewMode = {
	LOOP = 3,
	FILLED = 2,
	UNFILLED = 1
}
Vector3 = var_0_10002

local var_0_1 = var_0_10002(0, 1, 40)

Vector3 = var_3

local var_0_2 = var_3(35, 1, 40)

Vector3 = var_4

local var_0_3 = var_4(30, 0, 0)

Vector3 = var_5

local var_0_4 = var_5(330, 0, 0)

Vector3 = var_6

local var_0_5 = var_6(-532, 157, 0)

Vector3 = var_7

local var_0_6 = var_7(-665, 70, -675)

Vector3 = var_8

local var_0_7 = var_8(473, 157, 0)

Vector3 = var_9

local var_0_8 = var_9(-791, 70, 0)

Vector3 = var_10

local var_0_9 = var_10(464, 70, -675)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.rawImage = arg_1_1
	setActive = var_1_10002

	var_1_10002(arg_1_0.rawImage, false)

	GameObject = var_1_10002
	arg_1_0.seaCameraGO = var_1_10002.Find("BarrageCamera")

	local var_1_0 = arg_1_0.seaCameraGO
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Camera = var_1_10005
	arg_1_0.seaCamera = var_1_1(var_1_0, var_4(var_1_10005))
	arg_1_0.seaCamera.targetTexture = arg_1_0.rawImage.texture
	arg_1_0.seaCamera.enabled = true

	return
end

function var_0_0.setDisplayWeapon(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.weaponIds = arg_2_1
	arg_2_0.equipSkinId = arg_2_2 or 0

	return
end

function var_0_0.setCombatUI(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.uiGO = arg_3_1
	arg_3_0.hpBarGO = arg_3_2
	arg_3_0.enemyBarGO = arg_3_3
	arg_3_0.skinKey = arg_3_4
	arg_3_0.uiTF = arg_3_1.transform
	arg_3_0.chatPop = var_5:Find("popup")
	arg_3_0.chatPopGo = arg_3_0.chatPop.gameObject
	setActive = var_6

	var_6(arg_3_0.chatPop, false)

	arg_3_0.flagShipMark = var_5:Find("flagShipMark")
	arg_3_0.timer = var_5:Find("Timer")
	setActive = var_6

	var_6(arg_3_0.timer, true)

	setText = var_6

	local var_3_0 = arg_3_0.timer

	var_6(var_7.Find(var_3_0, "Text"), "03:00")

	arg_3_0.buttonContainer = var_5:Find("Weapon_button_container")

	local var_3_1 = {
		var_0.UNFILLED,
		var_0.FILLED,
		var_0.LOOP
	}

	for iter_3_0 = 1, 3 do
		local var_3_2

		ys = var_1_10012

		if var_1_10012.Battle["BattleWeaponButton" .. arg_3_0.skinKey] then
			ys = var_1_10012
			var_3_2 = var_1_10012.Battle["BattleWeaponButton" .. arg_3_0.skinKey].New()
		else
			ys = var_1_10012
			var_3_2 = var_1_10012.Battle.BattleWeaponButton.New()
		end

		cloneTplTo = var_1_10012
		var_1_10012 = var_1_10012(var_5:Find("Weapon_button_progress"), arg_3_0.buttonContainer)
		var_1_10013 = "Skill_" .. iter_3_0
		var_1_10013 = skinName
		var_1_10013 = {}
		ys = var_14

		var_14.Battle.BattleSkillView.SetSkillButtonPreferences(var_1_10012, iter_3_0)
		var_3_2:ConfigSkin(var_1_10012)
		var_3_2:SwitchIcon(iter_3_0, arg_3_4)
		var_3_2:SwitchIconEffect(iter_3_0, arg_3_4)
		var_3_2:SetTextActive(true)

		local var_3_3 = var_3_2

		var_3_2.SetToCombatUIPreview(var_3_3, var_3_1[iter_3_0])

		if iter_3_0 == 3 then
			GetOrAddComponent = var_14
			go = var_3_3

			local var_3_4 = var_3_3(var_1_10012)

			typeof = var_1_10016
			UnityEngine = var_17

			if var_14(var_3_4, var_1_10016(var_17.Playables.PlayableDirector)) then
				var_14.enabled = true
			end
		end
	end

	arg_3_0.heroBar = arg_3_2.transform
	setActive = var_7

	local var_3_5 = arg_3_0.heroBar

	var_7(var_8.Find(var_3_5, "heroBlood"), true)

	arg_3_0.enemyBar = arg_3_0.enemyBarGO.transform
	setActive = var_7

	local var_3_6 = arg_3_0.enemyBar

	var_7(var_8.Find(var_3_6, "enemyBlood"), true)
	arg_3_0:updateBarPos()

	arg_3_0.mainArrow = var_5:Find("EnemyArrowContainer/MainArrow")
	setActive = var_7

	var_7(arg_3_0.mainArrow, true)

	arg_3_0.autoBtn = var_5:Find("AutoBtn")
	setActive = var_7

	var_7(arg_3_0.autoBtn, true)

	triggerToggle = var_7

	var_7(arg_3_0.autoBtn, true)

	arg_3_0.enemyHPBar = var_5:Find("EnemyHPBar")
	setActive = var_7

	var_7(arg_3_0.enemyHPBar, false)

	arg_3_0.bossHPBar = var_5:Find("BossBarContainer/heroBlood")
	setActive = var_7

	var_7(arg_3_0.bossHPBar, true)

	local var_3_7 = arg_3_0.bossHPBar
	local var_3_8 = var_7.Find(var_3_7, "bloodBarContainer").childCount - 1

	for iter_3_1 = 0, var_3_8 do
		local var_3_9 = var_7:GetChild(iter_3_1)

		var_1_10013 = var_1_10013.GetComponent
		typeof = var_15
		Image = var_1_10016
		var_1_10013 = var_1_10013(var_3_9, var_15(var_1_10016))
		var_1_10013.fillAmount = 1
		iter_3_1 = iter_3_1 + 1
	end

	arg_3_0.skillContainer = var_5:Find("Skill_Activation/Root")
	arg_3_0.skill = var_5:Find("Skill_Activation/mask")

	if var_5:Find("Stick/Area/BG/spine") then
		local var_3_10 = var_9
		local var_3_11 = var_9.GetComponent

		typeof = iter_3_1
		SpineAnimUI = var_1_10013

		local var_3_12 = var_3_11(var_3_10, iter_3_1(var_1_10013))

		var_10.SetAction(var_3_12, "normal", 0)
	end

	arg_3_0.stick = var_5:Find("Stick/Area/Stick")

	local var_3_13 = arg_3_0.stick

	arg_3_0.stickTail = var_10.Find(var_3_13, "tailGizmos")

	return
end

function var_0_0.load(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	assert = var_1_10006

	var_1_10006(not arg_4_0.loading and not arg_4_0.loaded, "load function can be called only once.")

	arg_4_0.loading = true
	arg_4_0.shipVO = arg_4_2
	arg_4_0.enemyVO = arg_4_3
	ys = var_6

	var_6.Battle.BattleVariable.Init(true)

	ys = var_6

	var_6.Battle.BattleVariable.UpdateCameraPositionArgs()

	ys = var_6

	local var_4_0 = var_6.Battle.BattleFXPool.GetInstance()

	var_6.Init(var_4_0)

	ys = var_6

	local var_4_1 = var_6.Battle.BattleResourceManager.GetInstance()

	var_6.Init(var_4_1)
	var_6:AddPreloadResource(var_6.GetUIPath("CombatHPPop" .. arg_4_0.skinKey))
	var_6:AddPreloadResource(var_6.GetMapResource(arg_4_1))
	var_6:AddPreloadResource(var_6.GetDisplayCommonResource())

	if arg_4_0.equipSkinId > 0 then
		var_6:AddPreloadResource(var_6.GetEquipSkinPreviewRes(arg_4_0.equipSkinId))
	end

	var_6:AddPreloadResource(var_6.GetShipResource(arg_4_2.configId, arg_4_2.skinId), false)
	var_6:AddPreloadResource(var_6.GetShipResource(arg_4_3.configId, arg_4_3.skinId), false)

	local function var_4_2()
		local var_5_0 = arg_4_0

		ys = var_2_10001
		var_5_0.seaView = var_2_10001.Battle.BattleMap.New(arg_4_1)

		local function var_5_1(arg_6_0)
			arg_4_0.loading = false

			local var_6_0 = arg_4_0

			var_6_0.loaded = true
			pg = var_6_0

			local var_6_1 = var_6_0.UIMgr.GetInstance()

			var_1.LoadingOff(var_6_1)

			ys = var_1

			local var_6_2 = var_1.Battle.BattleFXPool.GetInstance()
			local var_6_3 = arg_4_0

			var_6_3.seaFXPool = var_6_2
			pg = var_6_3

			local var_6_4 = var_6_3.ship_skin_template[arg_4_2.skinId].fx_container
			local var_6_5 = {}

			ipairs = var_3_10005
			ys = var_3_10006

			for iter_6_0, iter_6_1 in var_3_10005(var_3_10006.Battle.BattleConst.FXContainerIndex) do
				local var_6_6 = var_6_4[iter_6_0]

				Vector3 = var_3_10011
				var_6_5[iter_6_0] = var_3_10011(var_6_6[1], var_6_6[2], var_6_6[3])
			end

			local var_6_7 = arg_4_2
			local var_6_8 = var_5.getConfig(var_6_7, "scale") / 50

			local function var_6_9(arg_7_0, arg_7_1)
				local var_7_0 = arg_7_0.transform

				if arg_7_1 then
					Vector3 = var_4_10003
					var_7_0.localScale = var_4_10003(var_6_8 * -1, var_6_8, var_6_8)
				else
					Vector3 = var_4_10003
					var_7_0.localScale = var_4_10003(var_6_8, var_6_8, var_6_8)
				end

				var_7_0.localEulerAngles = var_0_3

				local var_7_1 = var_7_0:GetComponent("SpineAnim")
				local var_7_2 = var_3.SetAction

				ys = var_5

				var_7_2(var_7_1, var_5.Battle.BattleConst.ActionName.MOVE, 0, true)

				GameObject = var_7_2

				local var_7_3 = var_7_2().transform

				var_4.SetParent(var_7_3, var_7_0, false)

				Vector3 = var_5
				var_4.localPosition = var_5.zero
				var_4.localEulerAngles = var_0_4

				local var_7_4 = {
					GetGO = function()
						return arg_4_0.seaCharacter
					end,
					GetSpecificFXScale = function()
						return {}
					end,
					GetAttachPoint = function()
						return var_0
					end,
					GetFXOffsets = function(arg_11_0, arg_11_1)
						arg_11_1 = arg_11_1 or 1

						return var_6_5[arg_11_1]
					end
				}
				local var_7_5 = var_6_2
				local var_7_6 = var_6.GetCharacterFX(var_7_5, "movewave", var_7_4)

				pg = var_7_5

				local var_7_7 = var_7_5.EffectMgr.GetInstance()
				local var_7_8 = var_7.PlayBattleEffect
				local var_7_9 = var_7_6

				Vector3 = var_4_10010

				var_7_8(var_7_7, var_7_9, var_4_10010.zero, true)

				return
			end

			arg_4_0.seaCharacter = arg_6_0

			var_6_9(arg_4_0.seaCharacter)

			arg_4_0.seaCharacter.transform.localPosition = var_0_1

			local var_6_10 = arg_4_0

			var_7.SeaUpdate(var_6_10)

			ys = var_7

			local var_6_11 = var_7.Battle.BattleResourceManager.GetInstance()
			local var_6_12 = var_7.GetCharacterSquareIcon
			local var_6_13 = arg_4_0.enemyVO
			local var_6_14 = var_6_12(var_6_11, var_9.getPrefab(var_6_13))

			ys = var_6_11

			local var_6_15 = var_6_11.Battle.BattleResourceManager.GetInstance()
			local var_6_16 = var_8.GetCharacterQIcon
			local var_6_17 = arg_4_0.shipVO
			local var_6_18 = var_6_16(var_6_15, var_10.getPrefab(var_6_17))

			findTF = var_6_15

			local var_6_19 = var_6_15(arg_4_0.mainArrow, "icon")

			setImageSprite = var_10

			var_10(var_6_19, var_6_18)

			setImageSprite = var_10
			findTF = var_11

			var_10(var_11(arg_4_0.bossHPBar, "BossIcon/icon"), var_6_14)

			setText = var_10
			findTF = var_11

			local var_6_20 = var_11(arg_4_0.bossHPBar, "BossNameBG/BossName")

			ys = var_12

			var_10(var_6_20, var_12.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(arg_4_0.enemyVO.configId).name)

			setActive = var_10

			var_10(arg_4_0.rawImage, true)

			pg = var_10

			local var_6_21 = var_10.TimeMgr.GetInstance()

			var_10.ResumeBattleTimer(var_6_21)
			arg_4_5()

			return
		end

		local function var_5_2(arg_12_0)
			ys = var_3_10001

			local var_12_0 = var_3_10001.Battle.BattleFXPool.GetInstance()
			local var_12_1 = arg_4_0

			var_12_1.seaFXPool = var_12_0
			pg = var_12_1

			local var_12_2 = var_12_1.ship_skin_template[arg_4_3.skinId].fx_container
			local var_12_3 = {}

			ipairs = var_3_10005
			ys = var_3_10006

			for iter_12_0, iter_12_1 in var_3_10005(var_3_10006.Battle.BattleConst.FXContainerIndex) do
				local var_12_4 = var_12_2[iter_12_0]

				Vector3 = var_3_10011
				var_12_3[iter_12_0] = var_3_10011(var_12_4[1], var_12_4[2], var_12_4[3])
			end

			local var_12_5 = arg_4_3
			local var_12_6 = var_5.getConfig(var_12_5, "scale") / 50

			local function var_12_7(arg_13_0, arg_13_1)
				local var_13_0 = arg_13_0.transform

				if arg_13_1 then
					Vector3 = var_4_10003
					var_13_0.localScale = var_4_10003(var_12_6 * -1, var_12_6, var_12_6)
				else
					Vector3 = var_4_10003
					var_13_0.localScale = var_4_10003(var_12_6, var_12_6, var_12_6)
				end

				var_13_0.localEulerAngles = var_0_3

				local var_13_1 = var_13_0:GetComponent("SpineAnim")
				local var_13_2 = var_3.SetAction

				ys = var_5

				var_13_2(var_13_1, var_5.Battle.BattleConst.ActionName.MOVE, 0, true)

				GameObject = var_13_2

				local var_13_3 = var_13_2().transform

				var_4.SetParent(var_13_3, var_13_0, false)

				Vector3 = var_5
				var_4.localPosition = var_5.zero
				var_4.localEulerAngles = var_0_4

				local var_13_4 = {
					GetGO = function()
						return arg_4_0.seaCharacter
					end,
					GetSpecificFXScale = function()
						return {}
					end,
					GetAttachPoint = function()
						return var_0
					end,
					GetFXOffsets = function(arg_17_0, arg_17_1)
						arg_17_1 = arg_17_1 or 1

						return var_12_3[arg_17_1]
					end
				}
				local var_13_5 = var_12_0
				local var_13_6 = var_6.GetCharacterFX(var_13_5, "movewave", var_13_4)

				pg = var_13_5

				local var_13_7 = var_13_5.EffectMgr.GetInstance()
				local var_13_8 = var_7.PlayBattleEffect
				local var_13_9 = var_13_6

				Vector3 = var_4_10010

				var_13_8(var_13_7, var_13_9, var_4_10010.zero, true)

				return
			end

			arg_4_0.seaEnemy = arg_12_0

			var_12_7(arg_4_0.seaEnemy, true)

			arg_4_0.seaEnemy.transform.localPosition = var_0_2

			return
		end

		local var_5_3 = var_0
		local var_5_4 = var_2.InstCharacter
		local var_5_5 = arg_4_3

		var_5_4(var_5_3, var_4.getPrefab(var_5_5), function(arg_18_0)
			var_5_2(arg_18_0)

			return
		end)

		local var_5_6 = var_0
		local var_5_7 = var_2.InstCharacter
		local var_5_8 = arg_4_2

		var_5_7(var_5_6, var_4.getPrefab(var_5_8), function(arg_19_0)
			var_5_1(arg_19_0)

			return
		end)

		return
	end

	var_6:StartPreload(var_4_2, nil)

	pg = var_8

	local var_4_3 = var_8.UIMgr.GetInstance()

	var_8.LoadingOn(var_4_3)

	return
end

function var_0_0.updateBarPos(arg_20_0)
	if arg_20_0.seaCharacter then
		arg_20_0.heroBar.localPosition = var_0_5
		arg_20_0.flagShipMark.localPosition = var_0_6
	end

	if arg_20_0.seaEnemy then
		arg_20_0.enemyBar.localPosition = var_0_7
	end

	return
end

function var_0_0.updatePopUp(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.chatPop, true)

	local var_21_0 = arg_21_0.chatPop

	var_21_0.localPosition = var_0_8
	LeanTween = var_21_0

	var_21_0.cancel(arg_21_0.chatPop)

	local var_21_1 = arg_21_0.chatPop.transform
	local var_21_2 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004

	local var_21_3

	if var_21_2(var_21_1, var_3(var_1_10004)) then
		ys = var_21_1

		var_21_1.Battle.BattleCharacter.ChatPopAnimation(arg_21_0.chatPop, 4)

		ys = var_21_1
		var_21_1 = var_21_1.Battle.BattleCharacter.setChatText
		var_21_3 = arg_21_0.chatPop
		pg = var_4

		var_21_1(var_21_3, var_4.ship_skin_words[100000].skill)
	else
		LeanTween = var_21_1

		local var_21_4 = var_21_1.scale

		rtf = var_21_3

		local var_21_5 = var_21_3(arg_21_0.chatPop.gameObject)

		Vector3 = var_4

		local var_21_6 = var_21_4(var_21_5, var_4.New(0, 0, 1), 0.1)
		local var_21_7 = var_2.setEase

		LeanTweenType = var_4

		local var_21_8 = var_21_7(var_21_6, var_4.easeInBack)
		local var_21_9 = var_2.setOnComplete

		System = var_4

		var_21_9(var_21_8, var_4.Action(function()
			ys = var_2_10000

			var_2_10000.Battle.BattleCharacter.ChatPop(arg_21_0.chatPop, 5)

			ys = var_0

			local var_22_0 = var_0.Battle.BattleCharacter.setChatText
			local var_22_1 = arg_21_0.chatPop

			pg = var_2

			var_22_0(var_22_1, var_2.ship_skin_words[100000].skill)

			return
		end))
	end

	return
end

function var_0_0.updateSkillFloat(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.skill, true)

	ys = var_1_10001

	local var_23_0 = var_1_10001.Battle.BattleResourceManager.GetInstance()
	local var_23_1

	if arg_23_0.skinKey == "Standard" then
		local var_23_2 = var_23_0
		local var_23_3 = var_23_0.GetCharacterIcon
		local var_23_4 = arg_23_0.shipVO

		var_23_1 = var_23_3(var_23_2, var_1_10005.getPrefab(var_23_4))
	else
		local var_23_5 = var_23_0
		local var_23_6 = var_23_0.GetCharacterSquareIcon
		local var_23_7 = arg_23_0.shipVO

		var_23_1 = var_23_6(var_23_5, var_1_10005.getPrefab(var_23_7))
	end

	local var_23_8 = arg_23_0.skill.transform
	local var_23_9 = arg_23_0.skill

	Vector3 = var_1_10005
	var_23_9.localScale = var_1_10005(1.5, 1.5, 0)

	local var_23_10 = var_23_8
	local var_23_11 = var_23_8.GetComponent

	typeof = var_6
	Animation = var_7

	local var_23_13

	if var_23_11(var_23_10, var_6(var_7)) then
		var_23_10 = 1

		while var_4:GetClip("anim_skinui_skill_" .. var_23_10) do
			var_23_10 = var_23_10 + 1
		end

		if 1 < var_23_10 then
			local var_23_12 = var_4

			var_23_13 = var_4.Play

			local var_23_14 = "anim_skinui_skill_"

			math = var_9

			var_23_13(var_23_12, var_23_14 .. var_9.random(var_23_10 - 1))
		end
	end

	setText = var_23_10
	findTF = var_23_13

	local var_23_15 = var_23_13(var_23_8, "skill/skill_name/Text")

	HXSet = var_7

	local var_23_16 = var_7.hxLan

	pg = var_8

	var_23_10(var_23_15, var_23_16(var_8.skill_data_template[9033].name))

	findTF = var_23_10

	local var_23_17 = var_23_10(var_23_8, "skill/icon_mask/icon")

	findTF = var_6

	local var_23_18 = var_6(var_23_8, "skill/skill_name")
	local var_23_19 = var_23_17
	local var_23_20 = var_23_17.GetComponent

	typeof = var_9
	Image = var_1_10010

	local var_23_21 = var_23_20(var_23_19, var_9(var_1_10010))

	var_23_21.sprite = var_23_1
	Color = var_23_21

	local var_23_22 = var_23_21.New(1, 1, 1, 1)
	local var_23_23 = var_23_18
	local var_23_24 = var_23_18.GetComponent

	typeof = var_10
	Image = var_11

	local var_23_25 = var_23_24(var_23_23, var_10(var_11))

	var_23_25.color = var_23_22
	findTF = var_23_25

	local var_23_26 = var_23_25(var_23_8, "skill")
	local var_23_27 = var_8.GetComponent

	typeof = var_10
	Image = var_11
	var_23_27(var_23_26, var_10(var_11)).color = var_23_22

	local var_23_28 = var_23_8
	local var_23_29 = var_23_8.GetComponent

	typeof = var_10
	DftAniEvent = var_11

	local var_23_30 = var_23_29(var_23_28, var_10(var_11))

	var_8.SetEndEvent(var_23_30, function(arg_24_0)
		setActive = var_2_10001

		var_2_10001(arg_23_0.skill, false)

		return
	end)

	Clone = var_9
	var_23_8.position = var_9(arg_23_0.heroBar.position)

	return
end

function var_0_0.updateHPPop(arg_25_0)
	local var_25_1

	if not arg_25_0._popNumMgr then
		ys = var_25_1
		arg_25_0._popNumMgr = var_25_1.Battle.BattlePopNumManager.GetInstance()

		local var_25_0 = arg_25_0._popNumMgr

		var_25_1 = var_25_1.InitialBundlePool

		local var_25_2 = arg_25_0.uiGO.transform

		var_25_1(var_25_0, var_3.Find(var_25_2, "HPTextCharacterContainer/container"))

		local var_25_3 = arg_25_0._popNumMgr

		arg_25_0._popNumBundle = var_25_1.GetBundle(var_25_3)
	end

	math = var_25_1

	local var_25_4 = var_25_1.random(1, 4)

	math = var_2

	local var_25_5 = var_2.random(1, 2) > 1
	local var_25_6 = arg_25_0._popNumBundle

	var_3.GetPop(var_25_6, false, var_25_5, false, 114, {
		var_25_4,
		1
	})._tf.localPosition = var_0_9

	var_3:Play()

	return
end

local var_0_10 = 250
local var_0_11 = 50
local var_0_12 = 1000
local var_0_13 = 2
local var_0_14 = 3

function var_0_0.updateStick(arg_26_0)
	if arg_26_0._stickMoveCount and arg_26_0._stickMoveCount <= var_0_10 then
		arg_26_0._stickMoveCount = arg_26_0._stickMoveCount + 1

		local var_26_0 = arg_26_0.stickVX + arg_26_0.stick.localPosition.x
		local var_26_1 = arg_26_0.stickVY + arg_26_0.stick.localPosition.y
		local var_26_2 = var_26_0 * var_26_0 + var_26_1 * var_26_1

		if var_0_12 * 2 < var_26_2 then
			math = var_4

			local var_26_3 = var_4.atan2(var_26_1, var_26_0)
			local var_26_4
			local var_26_5
			local var_26_6 = var_0_12

			math = var_1_10008

			local var_26_7 = var_26_6 * var_1_10008.cos(var_26_3)
			local var_26_8 = var_0_12

			math = var_8

			local var_26_9 = var_26_8 * var_8.sin(var_26_3)
			local var_26_10 = var_26_7 / var_0_12
			local var_26_11 = var_26_9 / var_0_12

			math = var_9

			local var_26_12 = var_9.random() * 2

			math = var_1_10010

			local var_26_13 = var_26_12 * var_1_10010.pi

			math = var_10

			local var_26_14 = var_10.random(var_0_13, var_0_14)

			math = var_11
			arg_26_0.stickVX = var_11.cos(var_26_13) * var_26_14
			math = var_11
			arg_26_0.stickVY = var_11.sin(var_26_13) * var_26_14

			if arg_26_0.stickVX * var_26_10 + arg_26_0.stickVY * var_26_11 > 0 then
				arg_26_0.stickVX = -arg_26_0.stickVX
				arg_26_0.stickVY = -arg_26_0.stickVY
			end
		else
			arg_26_0.stickPos.x = var_26_0
			arg_26_0.stickPos.y = var_26_1
			arg_26_0.stick.localPosition = arg_26_0.stickPos
		end

		local var_26_15 = arg_26_0._stickMoveCount

		if var_0_10 <= var_26_15 then
			if arg_26_0.stickTail then
				setActive = var_4

				var_4(arg_26_0.stickTail, false)
			end

			local var_26_16 = arg_26_0.stick

			Vector3 = var_5
			var_26_16.localPosition = var_5.zero
			arg_26_0._stickMoveCount = nil
			arg_26_0._stickStopCount = 0
		end
	elseif arg_26_0._stickStopCount and arg_26_0._stickStopCount <= var_0_11 then
		arg_26_0._stickStopCount = arg_26_0._stickStopCount + 1

		local var_26_17 = arg_26_0._stickStopCount

		if var_0_11 <= var_26_17 then
			if arg_26_0.stickTail then
				setActive = var_1

				var_1(arg_26_0.stickTail, true)
			end

			math = var_1

			local var_26_18 = var_1.random() * 2

			math = var_2

			local var_26_19 = var_26_18 * var_2.pi

			math = var_2

			local var_26_20 = var_2.random(var_0_13, var_0_14)

			math = var_3
			arg_26_0.stickVX = var_3.cos(var_26_19) * var_26_20
			math = var_3
			arg_26_0.stickVY = var_3.cos(var_26_19) * var_26_20
			arg_26_0._stickStopCount = nil
			arg_26_0._stickMoveCount = 0
		end
	end

	return
end

function var_0_0.SeaUpdate(arg_27_0)
	local var_27_0 = -20
	local var_27_1 = 60
	local var_27_2 = 0
	local var_27_3 = 60

	ys = var_1_10005

	local var_27_4 = var_1_10005.Battle.BattleConfig

	ys = var_1_10006

	local var_27_5 = var_1_10006.Battle.BattleConst

	local function var_27_6()
		local var_28_0 = arg_27_0

		var_0.updateBarPos(var_28_0)

		return
	end

	pg = var_1_10008

	local var_27_7 = var_1_10008.TimeMgr.GetInstance()

	var_8.AddBattleTimer(var_27_7, "barrageUpdateTimer", -1, 0.033, var_27_6)

	arg_27_0._stickStopCount = 0
	Vector2 = var_8
	arg_27_0.stickPos = var_8.New(0, 0)

	local function var_27_8()
		local var_29_0 = arg_27_0

		var_0.updateStick(var_29_0)

		return
	end

	pg = var_9

	local var_27_9 = var_9.TimeMgr.GetInstance()

	var_9.AddBattleTimer(var_27_9, "stickUpdateTimer", -1, 0.033, var_27_8)

	local function var_27_10()
		local var_30_0 = arg_27_0

		var_0.updatePopUp(var_30_0)

		return
	end

	pg = var_27_9

	local var_27_11 = var_27_9.TimeMgr.GetInstance()

	var_10.AddBattleTimer(var_27_11, "popupUpdateTimer", -1, 10, var_27_10)

	local function var_27_12()
		local var_31_0 = arg_27_0

		var_0.updateSkillFloat(var_31_0)

		return
	end

	pg = var_27_11

	local var_27_13 = var_27_11.TimeMgr.GetInstance()

	var_11.AddBattleTimer(var_27_13, "skillFloatUpdateTimer", -1, 10, var_27_12)

	local function var_27_14()
		local var_32_0 = arg_27_0

		var_0.updateHPPop(var_32_0)

		return
	end

	pg = var_27_13

	local var_27_15 = var_27_13.TimeMgr.GetInstance()

	var_12.AddBattleTimer(var_27_15, "HPPopUpdateTimer", -1, 3, var_27_14)

	return
end

function var_0_0.clear(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveAllBattleTimer(var_33_0)

	Destroy = var_1

	var_1(arg_33_0.seaCharacter)

	Destroy = var_1

	var_1(arg_33_0.seaEnemy)

	Destroy = var_1

	var_1(arg_33_0.uiGO)

	Destroy = var_1

	var_1(arg_33_0.hpBarGO)

	Destroy = var_1

	var_1(arg_33_0.enemyBarGO)

	if arg_33_0.seaView then
		local var_33_1 = arg_33_0.seaView

		var_1.Dispose(var_33_1)

		arg_33_0.seaView = nil
	end

	if arg_33_0._popNumMgr then
		local var_33_2 = arg_33_0._popNumMgr

		var_1.Clear(var_33_2)
	end

	if arg_33_0.weaponList then
		ipairs = var_1

		for iter_33_0, iter_33_1 in var_1(arg_33_0.weaponList) do
			ipairs = var_1_10006

			for iter_33_2, iter_33_3 in var_1_10006(iter_33_1.emitterList) do
				iter_33_3:Destroy()
			end
		end

		arg_33_0.weaponList = nil
	end

	if arg_33_0.seaFXPool then
		local var_33_3 = arg_33_0.seaFXPool

		var_1.Clear(var_33_3)

		arg_33_0.seaFXPool = nil
	end

	if arg_33_0.seaFXContainersPool then
		local var_33_4 = arg_33_0.seaFXContainersPool

		var_1.Clear(var_33_4)

		arg_33_0.seaFXContainersPool = nil
	end

	ys = var_1

	local var_33_5 = var_1.Battle.BattleResourceManager.GetInstance()

	var_1.Clear(var_33_5)

	arg_33_0.seaCamera.enabled = true
	arg_33_0.seaCameraGO = nil
	arg_33_0.seaCamera = nil
	arg_33_0.loading = false
	arg_33_0.loaded = false

	return
end

return var_0_0
