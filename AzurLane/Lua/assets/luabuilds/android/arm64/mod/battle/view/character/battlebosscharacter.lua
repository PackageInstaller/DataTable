ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent

class = var_0_10002

local var_0_2 = var_0_10002("BattleBossCharacter", var_0.Battle.BattleEnemyCharacter)

var_0.Battle.BattleBossCharacter = var_0_2
var_0_2.__name = "BattleBossCharacter"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.Dispose(arg_2_0)
	if not arg_2_0._chargeTimer.paused then
		local var_2_0 = arg_2_0._chargeTimer

		var_1.Stop(var_2_0)
	end

	if arg_2_0._castClock then
		local var_2_1 = arg_2_0._castClock

		var_1.Dispose(var_2_1)

		arg_2_0._castClock = nil
	end

	local var_2_3

	if arg_2_0._aimBiarBar then
		local var_2_2 = arg_2_0._aimBiarBar

		var_2_3 = var_2_3.GetGO(var_2_2)

		local var_2_4 = arg_2_0._factory
		local var_2_5 = var_2.GetHPBarPool(var_2_4)

		var_2.DestroyObj(var_2_5, var_2_3)

		local var_2_6 = arg_2_0._aimBiarBar

		var_2.Dispose(var_2_6)

		arg_2_0._aimBiarBar = nil
	end

	LeanTween = var_2_3

	var_2_3.cancel(arg_2_0._HPBar)
	var_0_2.super.Dispose(arg_2_0)

	return
end

function var_0_2.Update(arg_3_0)
	var_0_2.super.Update(arg_3_0)
	arg_3_0:UpdateCastClockPosition()

	if arg_3_0._armor then
		arg_3_0:UpdateCastClock()
	end

	arg_3_0:UpdateBarrierClockPosition()

	if arg_3_0._barrier then
		arg_3_0:updateBarrierClock()
	end

	return
end

function var_0_2.UpdateVigilantBarPosition(arg_4_0)
	local var_4_0 = arg_4_0._referenceVector + arg_4_0._hpBarOffset
	local var_4_1 = arg_4_0._vigilantBar

	var_2.UpdateVigilantBarPosition(var_4_1, var_4_0)

	return
end

function var_0_2.RegisterWeaponListener(arg_5_0, arg_5_1)
	var_0_2.super.RegisterWeaponListener(arg_5_0, arg_5_1)
	arg_5_1:RegisterEventListener(arg_5_0, var_0_1.WEAPON_INTERRUPT, arg_5_0.onWeaponInterrupted)

	return
end

function var_0_2.UnregisterWeaponListener(arg_6_0, arg_6_1)
	var_0_2.super.UnregisterWeaponListener(arg_6_0, arg_6_1)
	arg_6_1:UnregisterEventListener(arg_6_0, var_0_1.WEAPON_INTERRUPT)

	return
end

function var_0_2.AddHPBar(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._HPBar = arg_7_1
	arg_7_0._HPBarTf = arg_7_1.transform

	arg_7_1:SetActive(true)

	local var_7_0 = arg_7_0._unitData

	var_3.RegisterEventListener(var_7_0, arg_7_0, var_0_1.UPDATE_HP, arg_7_0.OnUpdateHP)

	local var_7_1 = arg_7_0._HPBarTf
	local var_7_2 = var_3.Find(var_7_1, "HPBarCount")
	local var_7_3 = var_4.GetComponent

	typeof = var_7
	Text = var_1_10009
	arg_7_0._HPBarCountText = var_7_3(var_7_2, var_7(var_1_10009))
	arg_7_0._activeVernier = arg_7_2

	arg_7_0:SetTemplateInfo()
	arg_7_0:initBarComponent()
	arg_7_0:SetHPBarCountText(arg_7_0._HPBarTotalCount)

	local var_7_4 = arg_7_0._unitData

	arg_7_0._cacheHP = var_4.GetMaxHP(var_7_4)

	arg_7_0:UpdateHpBar()
	arg_7_0:initBarrierBar()

	return
end

function var_0_2.SetTemplateInfo(arg_8_0)
	local var_8_0 = arg_8_0._unitData
	local var_8_1 = var_1.GetTemplate(var_8_0)
	local var_8_2 = ""

	if var_8_1 then
		var_8_2 = var_8_1.name
	end

	local var_8_3 = arg_8_0._HPBarTf
	local var_8_4 = var_3.Find(var_8_3, "BossNameBG/BossName")
	local var_8_5 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	var_8_5(var_8_4, var_6(var_1_10008)).text = var_8_2

	local var_8_6 = arg_8_0._HPBarTf
	local var_8_7 = var_3.Find(var_8_6, "BossNameBG/BossLv")
	local var_8_8 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008

	local var_8_9 = var_8_8(var_8_7, var_6(var_1_10008))
	local var_8_10 = "Lv."
	local var_8_11 = arg_8_0._unitData

	var_8_9.text = var_8_10 .. var_5.GetLevel(var_8_11)
	pg = var_8_9

	local var_8_12 = var_8_9.enemy_data_by_type[var_8_1.type].type

	GetSpriteFromAtlas = var_4

	local var_8_13 = "shiptype"

	shipType2Battleprint = var_8_11

	local var_8_14 = var_4(var_8_13, var_8_11(var_8_12))

	setImageSprite = var_5

	local var_8_15 = arg_8_0._HPBarTf

	var_5(var_7.Find(var_8_15, "BossIcon/typeIcon/icon"), var_8_14, true)

	local var_8_16 = var_0.Battle.BattleResourceManager.GetInstance()
	local var_8_17 = var_5.GetCharacterSquareIcon(var_8_16, arg_8_0._bossIcon)

	setImageSprite = var_7
	findTF = var_9

	var_7(var_9(arg_8_0._HPBarTf, "BossIcon/icon"), var_8_17)

	local var_8_18 = arg_8_0._HPBarTf

	arg_8_0._armorBar = var_7.Find(var_8_18, "ArmorBar")

	local var_8_19 = arg_8_0._HPBarTf
	local var_8_20 = var_7.Find(var_8_19, "ArmorBar/armorProgress")
	local var_8_21 = var_7.GetComponent

	typeof = var_10
	Image = var_12
	arg_8_0._armorProgress = var_8_21(var_8_20, var_10(var_12))
	SetActive = var_7

	var_7(arg_8_0._armorBar, false)

	local var_8_22 = arg_8_0._HPBarTf

	arg_8_0._barrierBar = var_7.Find(var_8_22, "ShieldBar")

	local var_8_23 = arg_8_0._barrierBar
	local var_8_24 = var_7.Find(var_8_23, "shieldProgress")
	local var_8_25 = var_7.GetComponent

	typeof = var_10
	Image = var_12
	arg_8_0._barrierProgress = var_8_25(var_8_24, var_10(var_12))
	SetActive = var_7

	var_7(arg_8_0._barrierBar, false)

	return
end

function var_0_2.SetBossData(arg_9_0, arg_9_1)
	arg_9_0._bossBarInfoList = {}

	local var_9_0

	if not arg_9_1.hpBarNum then
		var_9_0 = 1
	end

	arg_9_0._HPBarTotalCount = var_9_0
	arg_9_0._hideBarNum = arg_9_1.hideBarNum

	local var_9_1 = arg_9_0:GetUnitData()

	arg_9_0._bossIcon = var_2.GetTemplate(var_9_1).icon
	arg_9_0._bossIndex = arg_9_1.bossCount

	return
end

function var_0_2.GetBossIndex(arg_10_0)
	return arg_10_0._bossIndex
end

function var_0_2.initBarComponent(arg_11_0)
	local var_11_0 = arg_11_0:GetUnitData()

	arg_11_0._stepHP = var_1.GetMaxHP(var_11_0) / arg_11_0._HPBarTotalCount

	local var_11_1 = 1

	arg_11_0._resTotalCount = 5
	arg_11_0._bossBarInfoList = {}

	while var_11_1 <= arg_11_0._resTotalCount do
		local var_11_2 = {}
		local var_11_3 = ("bloodBarContainer/hp_" .. var_11_1) .. "_delta"
		local var_11_4 = arg_11_0._HPBarTf
		local var_11_5 = var_6.Find(var_11_4, var_4)
		local var_11_6 = arg_11_0._HPBarTf
		local var_11_7 = var_7.Find(var_11_6, var_11_3)
		local var_11_8 = var_11_5
		local var_11_9 = var_11_5.GetComponent

		typeof = var_1_10011
		Image = var_1_10013
		var_11_2.progressImage = var_11_9(var_11_8, var_1_10011(var_1_10013))

		local var_11_10 = var_11_7
		local var_11_11 = var_11_7.GetComponent

		typeof = var_1_10011
		Image = var_1_10013
		var_11_2.deltaImage = var_11_11(var_11_10, var_1_10011(var_1_10013))
		var_11_2.progressTF = var_11_5.transform
		var_11_2.deltaTF = var_11_7.transform
		var_11_2.progressImage.fillAmount = 1
		var_11_2.deltaImage.fillAmount = 1
		arg_11_0._bossBarInfoList[var_11_1] = var_11_2
		var_11_1 = var_11_1 + 1
	end

	arg_11_0._topBarIndex = arg_11_0._HPBarTf.childCount - 1
	math = var_3
	arg_11_0._currentFmod = var_3.fmod(arg_11_0._HPBarTotalCount, arg_11_0._resTotalCount)

	if arg_11_0._currentFmod == 0 then
		arg_11_0._currentFmod = arg_11_0._resTotalCount
	end

	if arg_11_0._HPBarTotalCount < 5 then
		local var_11_12 = arg_11_0._resTotalCount

		while var_11_12 > arg_11_0._HPBarTotalCount do
			local var_11_13 = "bloodBarContainer/hp_" .. var_11_12

			SetActive = var_5

			local var_11_14 = arg_11_0._HPBarTf

			var_5(var_7.Find(var_11_14, var_11_13), false)

			SetActive = var_5

			local var_11_15 = arg_11_0._HPBarTf

			var_5(var_7.Find(var_11_15, var_11_13 .. "_delta"), false)

			var_11_12 = var_11_12 - 1
		end
	else
		local var_11_16 = arg_11_0._resTotalCount

		while var_11_16 > arg_11_0._currentFmod do
			local var_11_17 = "bloodBarContainer/hp_" .. var_11_16
			local var_11_18 = arg_11_0._HPBarTf
			local var_11_19 = var_5.Find(var_11_18, var_11_17).transform

			var_5.SetSiblingIndex(var_11_19, 0)

			local var_11_20 = arg_11_0._HPBarTf
			local var_11_21 = var_5.Find(var_11_20, var_11_17 .. "_delta").transform

			var_5.SetSiblingIndex(var_11_21, 0)

			var_11_16 = var_11_16 - 1
		end
	end

	if arg_11_0._activeVernier then
		local var_11_22 = arg_11_0._HPBarTf

		arg_11_0._vernier = var_3.Find(var_11_22, "vernier/tag")
		SetActive = var_3

		local var_11_23 = arg_11_0._HPBarTf

		var_3(var_5.Find(var_11_23, "vernier"), arg_11_0._activeVernier)
	end

	Timer = var_3
	arg_11_0._chargeTimer = var_3.New(function()
		local var_12_0 = arg_11_0
		local var_12_1 = arg_11_0

		var_12_0._currentTween = var_1.generateTween(var_12_1)

		return
	end, 1)

	return
end

function var_0_2.UpdateHpBar(arg_13_0)
	local var_13_0 = arg_13_0._unitData
	local var_13_1 = var_1.GetCurrentHP(var_13_0)

	if arg_13_0._cacheHP == var_13_1 then
		return
	end

	if not arg_13_0._chargeTimer.paused then
		local var_13_2 = arg_13_0._chargeTimer

		var_2.Stop(var_13_2)

		local var_13_3 = arg_13_0._chargeTimer

		var_2.Stop(var_13_3)

		local var_13_4 = arg_13_0._chargeTimer

		var_2.Reset(var_13_4)
	end

	local var_13_5, var_13_6, var_13_7 = arg_13_0:GetCurrentFmod()

	arg_13_0:SortBar(var_13_5, var_13_7)

	arg_13_0._currentFmod = var_13_5
	arg_13_0._currentDivision = var_13_7

	if var_13_1 < arg_13_0._cacheHP then
		if arg_13_0._currentDivision ~= var_13_7 then
			LeanTween = var_5

			var_5.cancel(arg_13_0._HPBar)
		end

		local var_13_8 = arg_13_0._chargeTimer

		var_5.Start(var_13_8)
	end

	arg_13_0._bossBarInfoList[var_13_5].progressImage.fillAmount = var_13_6

	if arg_13_0._activeVernier then
		local var_13_9 = arg_13_0._vernier

		Vector2 = var_1_10006
		var_13_9.anchorMin = var_1_10006(var_13_6, 0.5)

		local var_13_10 = arg_13_0._vernier

		Vector2 = var_6
		var_13_10.anchorMax = var_6(var_13_6, 0.5)
	end

	arg_13_0:SetHPBarCountText(var_13_7)

	arg_13_0._cacheHP = var_13_1

	return
end

function var_0_2.generateTween(arg_14_0)
	local var_14_0 = arg_14_0._bossBarInfoList[arg_14_0._currentFmod].deltaImage
	local var_14_1 = var_1.progressImage.fillAmount

	duration = var_1_10004

	local var_14_2

	var_14_2 = var_1_10004 or 0.7
	LeanTween = duration

	local var_14_3 = var_4.value

	go = var_1_10006

	local var_14_4 = var_14_3(var_1_10006(arg_14_0._HPBar), var_14_0.fillAmount, var_14_1, 0.7)
	local var_14_5 = var_4.setOnUpdate

	System = var_7

	return (var_14_5(var_14_4, var_7.Action_float(function(arg_15_0)
		var_14_0.fillAmount = arg_15_0

		return
	end)))
end

function var_0_2.GetCurrentFmod(arg_16_0)
	local var_16_0 = arg_16_0._unitData
	local var_16_1 = var_1.GetCurrentHP(var_16_0)

	math = var_1_10002

	local var_16_2, var_16_3 = var_1_10002.modf(var_16_1 / arg_16_0._stepHP)
	local var_16_4 = var_16_2 + 1

	math = var_4

	local var_16_5

	if var_4.fmod(var_16_4, arg_16_0._resTotalCount) == 0 then
		var_16_5 = 5
	end

	return var_16_5, var_16_3, var_16_4
end

function var_0_2.SortBar(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == arg_17_0._currentFmod then
		return
	elseif arg_17_1 > arg_17_0._currentFmod then
		local var_17_0 = arg_17_0._currentFmod

		arg_17_0._bossBarInfoList[var_17_0].progressImage.fillAmount = 1
		arg_17_0._bossBarInfoList[var_17_0].deltaImage.fillAmount = 1

		while var_17_0 < arg_17_1 do
			var_17_0 = var_17_0 + 1

			local var_17_1 = arg_17_0._bossBarInfoList[var_17_0].deltaTF

			var_5.SetSiblingIndex(var_17_1, arg_17_0._topBarIndex)

			local var_17_2 = var_4.progressTF

			var_5.SetSiblingIndex(var_17_2, arg_17_0._topBarIndex)

			SetActive = var_5

			var_5(var_4.progressImage, true)

			SetActive = var_5

			var_5(var_4.deltaImage, true)
		end
	elseif arg_17_1 < arg_17_0._currentFmod then
		local var_17_3 = arg_17_0._currentFmod

		while arg_17_1 < var_17_3 do
			arg_17_0._bossBarInfoList[var_17_3].progressImage.fillAmount = 1
			var_4.deltaImage.fillAmount = 1

			local var_17_4 = var_4.progressTF

			var_5.SetSiblingIndex(var_17_4, 0)

			local var_17_5 = var_4.deltaTF

			var_5.SetSiblingIndex(var_17_5, 0)

			if arg_17_2 < arg_17_0._resTotalCount then
				SetActive = var_5

				var_5(var_4.progressImage, false)

				SetActive = var_5

				var_5(var_4.deltaImage, false)
			end

			var_17_3 = var_17_3 - 1
		end
	end

	return
end

function var_0_2.SetHPBarCountText(arg_18_0, arg_18_1)
	if arg_18_0._hideBarNum then
		arg_18_0._HPBarCountText.text = "X??"
	else
		arg_18_0._HPBarCountText.text = "X " .. arg_18_1
	end

	return
end

function var_0_2.UpdateHPBarPosition(arg_19_0)
	if arg_19_0._normalHPTF and not arg_19_0._hideHP then
		local var_19_0 = arg_19_0._hpBarPos
		local var_19_1 = var_1.Copy(var_19_0, arg_19_0._referenceVector)

		var_1.Add(var_19_1, arg_19_0._hpBarOffset)

		arg_19_0._normalHPTF.position = arg_19_0._hpBarPos
	end

	return
end

function var_0_2.onWeaponPreCast(arg_20_0, arg_20_1)
	var_0_2.super.onWeaponPreCast(arg_20_0, arg_20_1)

	local var_20_0 = arg_20_1.Data.armor

	arg_20_0:initArmorBar(var_2.armor)

	if var_20_0 and var_20_0 ~= 0 then
		arg_20_0:initCastClock(var_2.time, arg_20_1.Dispatcher)
	end

	return
end

function var_0_2.onWeaponPrecastFinish(arg_21_0, arg_21_1)
	var_0_2.super.onWeaponPrecastFinish(arg_21_0, arg_21_1)

	local var_21_0 = arg_21_1.Data.armor
	local var_21_1 = arg_21_1.Dispatcher
	local var_21_2 = arg_21_0._castClock

	if var_5.GetCastingWeapon(var_21_2) == var_21_1 and var_21_0 and var_21_0 ~= 0 then
		if arg_21_0._armor <= 0 then
			local var_21_3 = arg_21_0._castClock

			var_5.Interrupt(var_21_3, true)
		else
			local var_21_4 = arg_21_0._castClock

			var_5.Interrupt(var_21_4, false)
		end

		arg_21_0._armor = nil
		SetActive = var_5

		var_5(arg_21_0._armorBar, false)
	end

	return
end

function var_0_2.onWeaponInterrupted(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._unitData

	var_2.StateChange(var_22_0, var_0.Battle.UnitState.STATE_INTERRUPT)

	return
end

function var_0_2.initArmorBar(arg_23_0, arg_23_1)
	if arg_23_1 and arg_23_1 ~= 0 then
		arg_23_0._armor = arg_23_1
		arg_23_0._totalArmor = arg_23_1

		arg_23_0:updateWeaponArmor()

		SetActive = var_2

		var_2(arg_23_0._armorBar, true)
	end

	return
end

function var_0_2.OnUpdateHP(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.Data.preShieldHP

	if arg_24_0._barrier and var_24_0 < 0 then
		arg_24_0._barrier = arg_24_0._barrier + var_24_0

		arg_24_0:updateBarrierBar()
	end

	var_0_2.super.OnUpdateHP(arg_24_0, arg_24_1)

	local var_24_1 = arg_24_1.Data.dHP

	if arg_24_0._armor and var_24_1 < 0 then
		arg_24_0._armor = arg_24_0._armor + var_24_1

		arg_24_0:updateWeaponArmor()
	end

	return
end

function var_0_2.updateWeaponArmor(arg_25_0)
	arg_25_0._armorProgress.fillAmount = arg_25_0._armor / arg_25_0._totalArmor

	return
end

function var_0_2.initCastClock(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0._castClock

	var_3.Casting(var_26_0, arg_26_1, arg_26_2)

	pg = var_3

	local var_26_1 = var_3.TimeMgr.GetInstance()

	arg_26_0._castFinishTime = var_3.GetCombatTime(var_26_1) + arg_26_1
	arg_26_0._castDuration = arg_26_1

	return
end

function var_0_2.UpdateCastClock(arg_27_0)
	local var_27_0 = arg_27_0._castClock

	var_1.UpdateCastClock(var_27_0)

	return
end

function var_0_2.updateComponentDiveInvisible(arg_28_0)
	var_0_2.super.updateComponentDiveInvisible(arg_28_0)

	SetActive = var_1

	var_1(arg_28_0._HPBarTf, true)

	return
end

function var_0_2.updateComponentVisible(arg_29_0)
	var_0_2.super.updateComponentVisible(arg_29_0)

	SetActive = var_1

	var_1(arg_29_0._HPBarTf, true)

	return
end

function var_0_2.initBarrierBar(arg_30_0)
	local var_30_0 = arg_30_0._unitData

	var_1.RegisterEventListener(var_30_0, arg_30_0, var_0_1.BARRIER_STATE_CHANGE, arg_30_0.onBarrierStateChange)

	return
end

function var_0_2.onBarrierStateChange(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1.Data.barrierDurability
	local var_31_1 = arg_31_1.Data.barrierDuration

	SetActive = var_1_10004

	var_1_10004(arg_31_0._barrierBar, var_31_0 > 0)

	if var_31_0 > 0 then
		arg_31_0._totalBarrier = var_31_0
		arg_31_0._barrier = var_31_0

		arg_31_0:initBarrierClock(var_31_1)
		arg_31_0:updateBarrierBar()
		arg_31_0:updateBarrierClock()
	else
		arg_31_0._barrier = nil
		arg_31_0._totalBarrier = nil

		local var_31_2 = arg_31_0._barrierClock

		var_4.Interrupt(var_31_2)
	end

	return
end

function var_0_2.updateBarrierBar(arg_32_0)
	arg_32_0._barrierProgress.fillAmount = arg_32_0._barrier / arg_32_0._totalBarrier

	return
end

function var_0_2.updateBarrierClock(arg_33_0)
	local var_33_0 = arg_33_0._barrierClock

	var_1.UpdateBarrierClockProgress(var_33_0)

	return
end

function var_0_2.initBarrierClock(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._barrierClock

	var_2.Shielding(var_34_0, arg_34_1)

	return
end

function var_0_2.AddAimBiasBar(arg_35_0, arg_35_1)
	arg_35_0._normalHPTF = arg_35_1
	arg_35_0._aimBiarBarTF = arg_35_1:Find("biasBar")
	arg_35_0._aimBiarBar = var_0.Battle.BattleAimbiasBar.New(arg_35_0._aimBiarBarTF)

	local var_35_0 = arg_35_0._aimBiarBar
	local var_35_1 = var_2.ConfigAimBias
	local var_35_2 = arg_35_0._unitData

	var_35_1(var_35_0, var_5.GetAimBias(var_35_2))

	local var_35_3 = arg_35_0._aimBiarBar

	var_2.UpdateAimBiasProgress(var_35_3)

	return
end

function var_0_2.AddModel(arg_36_0, arg_36_1)
	var_0_2.super.AddModel(arg_36_0, arg_36_1)
	arg_36_0:UpdatePosition()

	return
end

return
