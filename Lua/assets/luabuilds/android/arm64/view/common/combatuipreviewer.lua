local var_0_0 = class("CombatUIPreviewer")

var_0_0.WeaponButtonPreviewMode = {
	LOOP = 3,
	FILLED = 2,
	UNFILLED = 1
}

local var_0_1 = Vector3(0, 1, 40)
local var_0_2 = Vector3(35, 1, 40)
local var_0_3 = Vector3(30, 0, 0)
local var_0_4 = Vector3(330, 0, 0)
local var_0_5 = Vector3(-532, 157, 0)
local var_0_6 = Vector3(-665, 70, -675)
local var_0_7 = Vector3(473, 157, 0)
local var_0_8 = Vector3(-791, 70, 0)
local var_0_9 = Vector3(464, 70, -675)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.rawImage = arg_1_1

	setActive(arg_1_0.rawImage, false)

	arg_1_0.seaCameraGO = GameObject.Find("BarrageCamera")
	arg_1_0.seaCamera = arg_1_0.seaCameraGO:GetComponent(typeof(Camera))
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
	arg_3_0.chatPop = var_3_0:Find("popup")
	arg_3_0.chatPopGo = arg_3_0.chatPop.gameObject

	setActive(arg_3_0.chatPop, false)

	arg_3_0.flagShipMark = var_3_0:Find("flagShipMark")
	arg_3_0.timer = var_3_0:Find("Timer")

	setActive(arg_3_0.timer, true)
	setText(arg_3_0.timer:Find("Text"), "03:00")

	arg_3_0.buttonContainer = var_3_0:Find("Weapon_button_container")

	local var_3_1 = {
		var_0.UNFILLED,
		var_0.FILLED,
		var_0.LOOP
	}

	for iter_3_0 = 1, 3 do
		local var_3_2 = ys.Battle["BattleWeaponButton" .. arg_3_0.skinKey] and ys.Battle["BattleWeaponButton" .. arg_3_0.skinKey].New() or ys.Battle.BattleWeaponButton.New()
		local var_3_3 = cloneTplTo(var_3_0:Find("Weapon_button_progress"), arg_3_0.buttonContainer)

		skinName = "Skill_" .. iter_3_0

		ys.Battle.BattleSkillView.SetSkillButtonPreferences(var_3_3, iter_3_0)
		var_3_2:ConfigSkin(var_3_3)
		var_3_2:SwitchIcon(iter_3_0, arg_3_4)
		var_3_2:SwitchIconEffect(iter_3_0, arg_3_4)
		var_3_2:SetTextActive(true)
		var_3_2:SetToCombatUIPreview(var_3_1[iter_3_0])

		if iter_3_0 == 3 then
			local var_3_5 = GetOrAddComponent(go(var_3_3), typeof(UnityEngine.Playables.PlayableDirector))

			if var_3_5 then
				var_3_5.enabled = true
			end
		end
	end

	arg_3_0.heroBar = arg_3_2.transform

	setActive(arg_3_0.heroBar:Find("heroBlood"), true)

	arg_3_0.enemyBar = arg_3_0.enemyBarGO.transform

	setActive(arg_3_0.enemyBar:Find("enemyBlood"), true)
	arg_3_0:updateBarPos()

	arg_3_0.mainArrow = var_3_0:Find("EnemyArrowContainer/MainArrow")

	setActive(arg_3_0.mainArrow, true)

	arg_3_0.autoBtn = var_3_0:Find("AutoBtn")

	setActive(arg_3_0.autoBtn, true)
	triggerToggle(arg_3_0.autoBtn, true)

	arg_3_0.enemyHPBar = var_3_0:Find("EnemyHPBar")

	setActive(arg_3_0.enemyHPBar, false)

	arg_3_0.bossHPBar = var_3_0:Find("BossBarContainer/heroBlood")

	setActive(arg_3_0.bossHPBar, true)

	local var_3_6 = arg_3_0.bossHPBar:Find("bloodBarContainer")

	for iter_3_1 = 0, var_3_6.childCount - 1 do
		local var_3_7 = var_3_6:GetChild(iter_3_1)

		var_3_7:GetComponent(typeof(Image)).fillAmount = 1
		iter_3_1 = iter_3_1 + 1
	end

	arg_3_0.skillContainer = var_3_0:Find("Skill_Activation/Root")
	arg_3_0.skill = var_3_0:Find("Skill_Activation/mask")

	local var_3_8 = var_3_0:Find("Stick/Area/BG/spine")

	if var_3_8 then
		var_3_8:GetComponent(typeof(SpineAnimUI)):SetAction("normal", 0)
	end

	arg_3_0.stick = var_3_0:Find("Stick/Area/Stick")
	arg_3_0.stickTail = arg_3_0.stick:Find("tailGizmos")

	return
end

function var_0_0.load(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	assert(not arg_4_0.loading and not arg_4_0.loaded, "load function can be called only once.")

	arg_4_0.loading = true
	arg_4_0.shipVO = arg_4_2
	arg_4_0.enemyVO = arg_4_3

	ys.Battle.BattleVariable.Init(true)
	ys.Battle.BattleVariable.UpdateCameraPositionArgs()
	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_4_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_4_0:Init()
	var_4_0:AddPreloadResource(var_4_0.GetUIPath("CombatHPPop" .. arg_4_0.skinKey))
	var_4_0:AddPreloadResource(var_4_0.GetMapResource(arg_4_1))
	var_4_0:AddPreloadResource(var_4_0.GetDisplayCommonResource())

	if arg_4_0.equipSkinId > 0 then
		var_4_0:AddPreloadResource(var_4_0.GetEquipSkinPreviewRes(arg_4_0.equipSkinId))
	end

	var_4_0:AddPreloadResource(var_4_0.GetShipResource(arg_4_2.configId, arg_4_2.skinId), false)
	var_4_0:AddPreloadResource(var_4_0.GetShipResource(arg_4_3.configId, arg_4_3.skinId), false)
	var_4_0:StartPreload(function()
		arg_4_0.seaView = ys.Battle.BattleMap.New(arg_4_1)

		local function var_5_0(arg_6_0)
			arg_4_0.loading = false
			arg_4_0.loaded = true

			pg.UIMgr.GetInstance():LoadingOff()

			arg_4_0.seaFXPool = ys.Battle.BattleFXPool.GetInstance()

			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs(ys.Battle.BattleConst.FXContainerIndex) do
				({})[iter_6_0] = Vector3(pg.ship_skin_template[arg_4_2.skinId].fx_container[iter_6_0][1], pg.ship_skin_template[arg_4_2.skinId].fx_container[iter_6_0][2], pg.ship_skin_template[arg_4_2.skinId].fx_container[iter_6_0][3])
			end

			local var_6_1 = arg_4_2:getConfig("scale") / 50

			arg_4_0.seaCharacter = arg_6_0

			;(function(arg_7_0, arg_7_1)
				arg_7_0.transform.localScale = arg_7_1 and Vector3(var_6_1 * -1, var_6_1, var_6_1) or Vector3(var_6_1, var_6_1, var_6_1)
				arg_7_0.transform.localEulerAngles = var_0_3

				arg_7_0.transform:GetComponent("SpineAnim"):SetAction(ys.Battle.BattleConst.ActionName.MOVE, 0, true)

				local var_7_0 = GameObject().transform

				var_7_0:SetParent(arg_7_0.transform, false)

				var_7_0.localPosition = Vector3.zero
				var_7_0.localEulerAngles = var_0_4

				pg.EffectMgr.GetInstance():PlayBattleEffect(var_0:GetCharacterFX("movewave", {
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

						return var_6_0[arg_11_1]
					end
				}), Vector3.zero, true)

				return
			end)(arg_4_0.seaCharacter)

			arg_4_0.seaCharacter.transform.localPosition = var_0_1

			arg_4_0:SeaUpdate()
			setImageSprite(findTF(arg_4_0.mainArrow, "icon"), (ys.Battle.BattleResourceManager.GetInstance():GetCharacterQIcon(arg_4_0.shipVO:getPrefab())))
			setImageSprite(findTF(arg_4_0.bossHPBar, "BossIcon/icon"), (ys.Battle.BattleResourceManager.GetInstance():GetCharacterSquareIcon(arg_4_0.enemyVO:getPrefab())))
			setText(findTF(arg_4_0.bossHPBar, "BossNameBG/BossName"), ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(arg_4_0.enemyVO.configId).name)
			setActive(arg_4_0.rawImage, true)
			pg.TimeMgr.GetInstance():ResumeBattleTimer()
			arg_4_5()

			return
		end

		local function var_5_1(arg_12_0)
			arg_4_0.seaFXPool = ys.Battle.BattleFXPool.GetInstance()

			local var_12_0 = {}

			for iter_12_0, iter_12_1 in ipairs(ys.Battle.BattleConst.FXContainerIndex) do
				({})[iter_12_0] = Vector3(pg.ship_skin_template[arg_4_3.skinId].fx_container[iter_12_0][1], pg.ship_skin_template[arg_4_3.skinId].fx_container[iter_12_0][2], pg.ship_skin_template[arg_4_3.skinId].fx_container[iter_12_0][3])
			end

			local var_12_1 = arg_4_3:getConfig("scale") / 50

			arg_4_0.seaEnemy = arg_12_0

			;(function(arg_13_0, arg_13_1)
				arg_13_0.transform.localScale = arg_13_1 and Vector3(var_12_1 * -1, var_12_1, var_12_1) or Vector3(var_12_1, var_12_1, var_12_1)
				arg_13_0.transform.localEulerAngles = var_0_3

				arg_13_0.transform:GetComponent("SpineAnim"):SetAction(ys.Battle.BattleConst.ActionName.MOVE, 0, true)

				local var_13_0 = GameObject().transform

				var_13_0:SetParent(arg_13_0.transform, false)

				var_13_0.localPosition = Vector3.zero
				var_13_0.localEulerAngles = var_0_4

				pg.EffectMgr.GetInstance():PlayBattleEffect(var_0:GetCharacterFX("movewave", {
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

						return var_12_0[arg_17_1]
					end
				}), Vector3.zero, true)

				return
			end)(arg_4_0.seaEnemy, true)

			arg_4_0.seaEnemy.transform.localPosition = var_0_2

			return
		end

		var_4_0:InstCharacter(arg_4_3:getPrefab(), function(arg_18_0)
			var_5_1(arg_18_0)

			return
		end)
		var_4_0:InstCharacter(arg_4_2:getPrefab(), function(arg_19_0)
			var_5_0(arg_19_0)

			return
		end)

		return
	end, nil)
	pg.UIMgr.GetInstance():LoadingOn()

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
	setActive(arg_21_0.chatPop, true)

	arg_21_0.chatPop.localPosition = var_0_8

	LeanTween.cancel(arg_21_0.chatPop)

	if arg_21_0.chatPop.transform:GetComponent(typeof(Animation)) then
		ys.Battle.BattleCharacter.ChatPopAnimation(arg_21_0.chatPop, 4)
		ys.Battle.BattleCharacter.setChatText(arg_21_0.chatPop, pg.ship_skin_words[100000].skill)
	else
		LeanTween.scale(rtf(arg_21_0.chatPop.gameObject), Vector3.New(0, 0, 1), 0.1):setEase(LeanTweenType.easeInBack):setOnComplete(System.Action(function()
			ys.Battle.BattleCharacter.ChatPop(arg_21_0.chatPop, 5)
			ys.Battle.BattleCharacter.setChatText(arg_21_0.chatPop, pg.ship_skin_words[100000].skill)

			return
		end))
	end

	return
end

function var_0_0.updateSkillFloat(arg_23_0)
	setActive(arg_23_0.skill, true)

	local var_23_0 = ys.Battle.BattleResourceManager.GetInstance()
	local var_23_1 = arg_23_0.skinKey == "Standard" and var_23_0:GetCharacterIcon(arg_23_0.shipVO:getPrefab()) or var_23_0:GetCharacterSquareIcon(arg_23_0.shipVO:getPrefab())
	local var_23_2 = arg_23_0.skill.transform

	arg_23_0.skill.localScale = Vector3(1.5, 1.5, 0)

	local var_23_3 = var_23_2:GetComponent(typeof(Animation))

	if var_23_3 then
		local var_23_4 = 1

		while var_23_3:GetClip("anim_skinui_skill_" .. var_23_4) do
			var_23_4 = var_23_4 + 1
		end

		if var_23_4 > 1 then
			var_23_3:Play("anim_skinui_skill_" .. math.random(var_23_4 - 1))
		end
	end

	setText(findTF(var_23_2, "skill/skill_name/Text"), HXSet.hxLan(pg.skill_data_template[9033].name))

	findTF(var_23_2, "skill/icon_mask/icon"):GetComponent(typeof(Image)).sprite = var_23_1

	local var_23_5 = Color.New(1, 1, 1, 1)

	findTF(var_23_2, "skill/skill_name"):GetComponent(typeof(Image)).color = var_23_5
	findTF(var_23_2, "skill"):GetComponent(typeof(Image)).color = var_23_5

	var_23_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_24_0)
		setActive(arg_23_0.skill, false)

		return
	end)

	var_23_2.position = Clone(arg_23_0.heroBar.position)

	return
end

function var_0_0.updateHPPop(arg_25_0)
	local var_25_0

	if not arg_25_0._popNumMgr then
		arg_25_0._popNumMgr = ys.Battle.BattlePopNumManager.GetInstance()

		arg_25_0._popNumMgr:InitialBundlePool(arg_25_0.uiGO.transform:Find("HPTextCharacterContainer/container"))

		arg_25_0._popNumBundle = arg_25_0._popNumMgr:GetBundle()
		var_25_0 = arg_25_0._popNumBundle.GetPop
	end

	;({
		nil,
		1
	})[1] = math.random(1, 4)

	local var_25_1 = var_25_0(arg_25_0._popNumBundle, false, math.random(1, 2) > 1, false, 114, {
		nil,
		1
	})

	var_25_1._tf.localPosition = var_0_9

	var_25_1:Play()

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

		if (arg_26_0.stickVX + arg_26_0.stick.localPosition.x) * (arg_26_0.stickVX + arg_26_0.stick.localPosition.x) + (arg_26_0.stickVY + arg_26_0.stick.localPosition.y) * (arg_26_0.stickVY + arg_26_0.stick.localPosition.y) > var_0_12 * 2 then
			local var_26_0 = math.atan2(arg_26_0.stickVY + arg_26_0.stick.localPosition.y, arg_26_0.stickVX + arg_26_0.stick.localPosition.x)
			local var_26_3 = math.random() * 2 * math.pi
			local var_26_4 = math.random(var_0_13, var_0_14)

			arg_26_0.stickVX = math.cos(var_26_3) * var_26_4
			arg_26_0.stickVY = math.sin(var_26_3) * var_26_4

			if arg_26_0.stickVX * (var_0_12 * math.cos(var_26_0) / var_0_12) + arg_26_0.stickVY * (var_0_12 * math.sin(var_26_0) / var_0_12) > 0 then
				arg_26_0.stickVX = -arg_26_0.stickVX
				arg_26_0.stickVY = -arg_26_0.stickVY
			end
		else
			arg_26_0.stickPos.x = arg_26_0.stickVX + arg_26_0.stick.localPosition.x
			arg_26_0.stickPos.y = arg_26_0.stickVY + arg_26_0.stick.localPosition.y
			arg_26_0.stick.localPosition = arg_26_0.stickPos
		end

		if arg_26_0._stickMoveCount >= var_0_10 then
			if arg_26_0.stickTail then
				setActive(arg_26_0.stickTail, false)
			end

			arg_26_0.stick.localPosition = Vector3.zero
			arg_26_0._stickMoveCount = nil
			arg_26_0._stickStopCount = 0
		end
	elseif arg_26_0._stickStopCount and arg_26_0._stickStopCount <= var_0_11 then
		arg_26_0._stickStopCount = arg_26_0._stickStopCount + 1

		if arg_26_0._stickStopCount >= var_0_11 then
			if arg_26_0.stickTail then
				setActive(arg_26_0.stickTail, true)
			end

			local var_26_5 = math.random() * 2 * math.pi
			local var_26_6 = math.random(var_0_13, var_0_14)

			arg_26_0.stickVX = math.cos(var_26_5) * var_26_6
			arg_26_0.stickVY = math.cos(var_26_5) * var_26_6
			arg_26_0._stickStopCount = nil
			arg_26_0._stickMoveCount = 0
		end
	end

	return
end

function var_0_0.SeaUpdate(arg_27_0)
	pg.TimeMgr.GetInstance():AddBattleTimer("barrageUpdateTimer", -1, 0.033, function()
		arg_27_0:updateBarPos()

		return
	end)

	arg_27_0._stickStopCount = 0
	arg_27_0.stickPos = Vector2.New(0, 0)

	pg.TimeMgr.GetInstance():AddBattleTimer("stickUpdateTimer", -1, 0.033, function()
		arg_27_0:updateStick()

		return
	end)
	pg.TimeMgr.GetInstance():AddBattleTimer("popupUpdateTimer", -1, 10, function()
		arg_27_0:updatePopUp()

		return
	end)
	pg.TimeMgr.GetInstance():AddBattleTimer("skillFloatUpdateTimer", -1, 10, function()
		arg_27_0:updateSkillFloat()

		return
	end)
	pg.TimeMgr.GetInstance():AddBattleTimer("HPPopUpdateTimer", -1, 3, function()
		arg_27_0:updateHPPop()

		return
	end)

	return
end

function var_0_0.clear(arg_33_0)
	pg.TimeMgr.GetInstance():RemoveAllBattleTimer()
	Destroy(arg_33_0.seaCharacter)
	Destroy(arg_33_0.seaEnemy)
	Destroy(arg_33_0.uiGO)
	Destroy(arg_33_0.hpBarGO)
	Destroy(arg_33_0.enemyBarGO)

	if arg_33_0.seaView then
		arg_33_0.seaView:Dispose()

		arg_33_0.seaView = nil
	end

	if arg_33_0._popNumMgr then
		arg_33_0._popNumMgr:Clear()
	end

	if arg_33_0.weaponList then
		for iter_33_0, iter_33_1 in ipairs(arg_33_0.weaponList) do
			for iter_33_2, iter_33_3 in ipairs(iter_33_1.emitterList) do
				iter_33_3:Destroy()
			end
		end

		arg_33_0.weaponList = nil
	end

	if arg_33_0.seaFXPool then
		arg_33_0.seaFXPool:Clear()

		arg_33_0.seaFXPool = nil
	end

	if arg_33_0.seaFXContainersPool then
		arg_33_0.seaFXContainersPool:Clear()

		arg_33_0.seaFXContainersPool = nil
	end

	ys.Battle.BattleResourceManager.GetInstance():Clear()

	arg_33_0.seaCamera.enabled = true
	arg_33_0.seaCameraGO = nil
	arg_33_0.seaCamera = nil
	arg_33_0.loading = false
	arg_33_0.loaded = false

	return
end

return var_0_0
