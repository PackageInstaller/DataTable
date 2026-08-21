ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = class("BattleBossCharacter", ys.Battle.BattleEnemyCharacter)

ys.Battle.BattleBossCharacter = var_0_1
var_0_1.__name = "BattleBossCharacter"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.Dispose(arg_2_0)
	if not arg_2_0._chargeTimer.paused then
		arg_2_0._chargeTimer:Stop()
	end

	if arg_2_0._castClock then
		arg_2_0._castClock:Dispose()

		arg_2_0._castClock = nil
	end

	if arg_2_0._aimBiarBar then
		arg_2_0._factory:GetHPBarPool():DestroyObj((arg_2_0._aimBiarBar:GetGO()))
		arg_2_0._aimBiarBar:Dispose()

		arg_2_0._aimBiarBar = nil
	end

	LeanTween.cancel(arg_2_0._HPBar)
	var_0_1.super.Dispose(arg_2_0)

	return
end

function var_0_1.Update(arg_3_0)
	var_0_1.super.Update(arg_3_0)
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

function var_0_1.UpdateVigilantBarPosition(arg_4_0)
	arg_4_0._vigilantBar:UpdateVigilantBarPosition(arg_4_0._referenceVector + arg_4_0._hpBarOffset)

	return
end

function var_0_1.RegisterWeaponListener(arg_5_0, arg_5_1)
	var_0_1.super.RegisterWeaponListener(arg_5_0, arg_5_1)
	arg_5_1:RegisterEventListener(arg_5_0, var_0_0.WEAPON_INTERRUPT, arg_5_0.onWeaponInterrupted)

	return
end

function var_0_1.UnregisterWeaponListener(arg_6_0, arg_6_1)
	var_0_1.super.UnregisterWeaponListener(arg_6_0, arg_6_1)
	arg_6_1:UnregisterEventListener(arg_6_0, var_0_0.WEAPON_INTERRUPT)

	return
end

function var_0_1.AddHPBar(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._HPBar = arg_7_1
	arg_7_0._HPBarTf = arg_7_1.transform

	arg_7_1:SetActive(true)
	arg_7_0._unitData:RegisterEventListener(arg_7_0, var_0_0.UPDATE_HP, arg_7_0.OnUpdateHP)

	arg_7_0._HPBarCountText = arg_7_0._HPBarTf:Find("HPBarCount"):GetComponent(typeof(Text))
	arg_7_0._activeVernier = arg_7_2

	arg_7_0:SetTemplateInfo()
	arg_7_0:initBarComponent()
	arg_7_0:SetHPBarCountText(arg_7_0._HPBarTotalCount)

	arg_7_0._cacheHP = arg_7_0._unitData:GetMaxHP()

	arg_7_0:UpdateHpBar()
	arg_7_0:initBarrierBar()

	return
end

function var_0_1.SetTemplateInfo(arg_8_0)
	local var_8_0 = arg_8_0._unitData:GetTemplate()
	local var_8_1 = ""

	if var_8_0 then
		var_8_1 = var_8_0.name
	end

	local var_8_2 = arg_8_0._HPBarTf:Find("BossNameBG/BossName")

	var_8_2:GetComponent(typeof(Text)).text = var_8_1
	arg_8_0._HPBarTf:Find("BossNameBG/BossLv"):GetComponent(typeof(Text)).text = "Lv." .. arg_8_0._unitData:GetLevel()

	setImageSprite(arg_8_0._HPBarTf:Find("BossIcon/typeIcon/icon"), GetSpriteFromAtlas("shiptype", shipType2Battleprint(pg.enemy_data_by_type[var_8_0.type].type)), true)
	setImageSprite(findTF(arg_8_0._HPBarTf, "BossIcon/icon"), (var_0.Battle.BattleResourceManager.GetInstance():GetCharacterSquareIcon(arg_8_0._bossIcon)))

	arg_8_0._armorBar = arg_8_0._HPBarTf:Find("ArmorBar")
	arg_8_0._armorProgress = arg_8_0._HPBarTf:Find("ArmorBar/armorProgress"):GetComponent(typeof(Image))

	SetActive(arg_8_0._armorBar, false)

	arg_8_0._barrierBar = arg_8_0._HPBarTf:Find("ShieldBar")
	arg_8_0._barrierProgress = arg_8_0._barrierBar:Find("shieldProgress"):GetComponent(typeof(Image))

	SetActive(arg_8_0._barrierBar, false)

	return
end

function var_0_1.SetBossData(arg_9_0, arg_9_1)
	arg_9_0._bossBarInfoList = {}
	arg_9_0._HPBarTotalCount = arg_9_1.hpBarNum or 1
	arg_9_0._hideBarNum = arg_9_1.hideBarNum
	arg_9_0._bossIcon = arg_9_0:GetUnitData():GetTemplate().icon
	arg_9_0._bossIndex = arg_9_1.bossCount

	return
end

function var_0_1.GetBossIndex(arg_10_0)
	return arg_10_0._bossIndex
end

function var_0_1.initBarComponent(arg_11_0)
	arg_11_0._stepHP = arg_11_0:GetUnitData():GetMaxHP() / arg_11_0._HPBarTotalCount
	arg_11_0._resTotalCount = 5
	arg_11_0._bossBarInfoList = {}

	while 1 <= arg_11_0._resTotalCount do
		local var_11_0 = arg_11_0._HPBarTf:Find("bloodBarContainer/hp_" .. 1)
		local var_11_1 = arg_11_0._HPBarTf:Find(("bloodBarContainer/hp_" .. 1) .. "_delta")

		;({}).progressImage = var_11_0:GetComponent(typeof(Image))
		;({}).deltaImage = var_11_1:GetComponent(typeof(Image))
		;({}).progressTF = var_11_0.transform
		;({}).deltaTF = var_11_1.transform
		;({}).progressImage.fillAmount = 1
		;({}).deltaImage.fillAmount = 1
		arg_11_0._bossBarInfoList[1] = {}
	end

	arg_11_0._topBarIndex = arg_11_0._HPBarTf.childCount - 1
	arg_11_0._currentFmod = math.fmod(arg_11_0._HPBarTotalCount, arg_11_0._resTotalCount)

	if arg_11_0._currentFmod == 0 then
		arg_11_0._currentFmod = arg_11_0._resTotalCount
	end

	if arg_11_0._HPBarTotalCount < 5 then
		local var_11_3 = arg_11_0._resTotalCount

		while var_11_3 > arg_11_0._HPBarTotalCount do
			SetActive(arg_11_0._HPBarTf:Find("bloodBarContainer/hp_" .. var_11_3), false)
			SetActive(arg_11_0._HPBarTf:Find(("bloodBarContainer/hp_" .. var_11_3) .. "_delta"), false)

			var_11_3 = var_11_3 - 1
		end
	else
		local var_11_4 = arg_11_0._resTotalCount

		while var_11_4 > arg_11_0._currentFmod do
			arg_11_0._HPBarTf:Find("bloodBarContainer/hp_" .. var_11_4).transform:SetSiblingIndex(0)
			arg_11_0._HPBarTf:Find(("bloodBarContainer/hp_" .. var_11_4) .. "_delta").transform:SetSiblingIndex(0)

			var_11_4 = var_11_4 - 1
		end
	end

	if arg_11_0._activeVernier then
		arg_11_0._vernier = arg_11_0._HPBarTf:Find("vernier/tag")

		SetActive(arg_11_0._HPBarTf:Find("vernier"), arg_11_0._activeVernier)
	end

	arg_11_0._chargeTimer = Timer.New(function()
		arg_11_0._currentTween = arg_11_0:generateTween()

		return
	end, 1)

	return
end

function var_0_1.UpdateHpBar(arg_13_0)
	local var_13_0 = arg_13_0._unitData:GetCurrentHP()

	if arg_13_0._cacheHP == var_13_0 then
		return
	end

	if not arg_13_0._chargeTimer.paused then
		arg_13_0._chargeTimer:Stop()
		arg_13_0._chargeTimer:Stop()
		arg_13_0._chargeTimer:Reset()
	end

	local var_13_1, var_13_2, var_13_3 = arg_13_0:GetCurrentFmod()

	arg_13_0:SortBar(var_13_1, var_13_3)

	arg_13_0._currentFmod = var_13_1
	arg_13_0._currentDivision = var_13_3

	if var_13_0 < arg_13_0._cacheHP then
		if arg_13_0._currentDivision ~= var_13_3 then
			LeanTween.cancel(arg_13_0._HPBar)
		end

		arg_13_0._chargeTimer:Start()
	end

	arg_13_0._bossBarInfoList[var_13_1].progressImage.fillAmount = var_13_2

	if arg_13_0._activeVernier then
		arg_13_0._vernier.anchorMin = Vector2(var_13_2, 0.5)
		arg_13_0._vernier.anchorMax = Vector2(var_13_2, 0.5)
	end

	arg_13_0:SetHPBarCountText(var_13_3)

	arg_13_0._cacheHP = var_13_0

	return
end

function var_0_1.generateTween(arg_14_0)
	local var_14_0 = arg_14_0._bossBarInfoList[arg_14_0._currentFmod].deltaImage

	duration = duration or 0.7

	return (LeanTween.value(go(arg_14_0._HPBar), arg_14_0._bossBarInfoList[arg_14_0._currentFmod].deltaImage.fillAmount, arg_14_0._bossBarInfoList[arg_14_0._currentFmod].progressImage.fillAmount, 0.7):setOnUpdate(System.Action_float(function(arg_15_0)
		var_14_0.fillAmount = arg_15_0

		return
	end)))
end

function var_0_1.GetCurrentFmod(arg_16_0)
	local var_16_0, var_16_1 = math.modf(arg_16_0._unitData:GetCurrentHP() / arg_16_0._stepHP)
	local var_16_2 = math.fmod(var_16_0 + 1, arg_16_0._resTotalCount)

	if var_16_2 == 0 then
		var_16_2 = 5
	end

	return var_16_2, var_16_1, var_16_0 + 1
end

function var_0_1.SortBar(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == arg_17_0._currentFmod then
		return
	elseif arg_17_1 > arg_17_0._currentFmod then
		local var_17_0 = arg_17_0._currentFmod

		arg_17_0._bossBarInfoList[arg_17_0._currentFmod].progressImage.fillAmount = 1
		arg_17_0._bossBarInfoList[var_17_0].deltaImage.fillAmount = 1

		while var_17_0 < arg_17_1 do
			var_17_0 = var_17_0 + 1

			arg_17_0._bossBarInfoList[var_17_0].deltaTF:SetSiblingIndex(arg_17_0._topBarIndex)
			arg_17_0._bossBarInfoList[var_17_0].progressTF:SetSiblingIndex(arg_17_0._topBarIndex)
			SetActive(arg_17_0._bossBarInfoList[var_17_0].progressImage, true)
			SetActive(arg_17_0._bossBarInfoList[var_17_0].deltaImage, true)
		end
	elseif arg_17_1 < arg_17_0._currentFmod then
		local var_17_1 = arg_17_0._currentFmod

		while arg_17_1 < var_17_1 do
			arg_17_0._bossBarInfoList[var_17_1].progressImage.fillAmount = 1
			arg_17_0._bossBarInfoList[var_17_1].deltaImage.fillAmount = 1

			arg_17_0._bossBarInfoList[var_17_1].progressTF:SetSiblingIndex(0)
			arg_17_0._bossBarInfoList[var_17_1].deltaTF:SetSiblingIndex(0)

			if arg_17_2 < arg_17_0._resTotalCount then
				SetActive(arg_17_0._bossBarInfoList[var_17_1].progressImage, false)
				SetActive(arg_17_0._bossBarInfoList[var_17_1].deltaImage, false)
			end

			var_17_1 = var_17_1 - 1
		end
	end

	return
end

function var_0_1.SetHPBarCountText(arg_18_0, arg_18_1)
	arg_18_0._HPBarCountText.text = arg_18_0._hideBarNum and "X??" or "X " .. arg_18_1

	return
end

function var_0_1.UpdateHPBarPosition(arg_19_0)
	if arg_19_0._normalHPTF and not arg_19_0._hideHP then
		arg_19_0._hpBarPos:Copy(arg_19_0._referenceVector):Add(arg_19_0._hpBarOffset)

		arg_19_0._normalHPTF.position = arg_19_0._hpBarPos
	end

	return
end

function var_0_1.onWeaponPreCast(arg_20_0, arg_20_1)
	var_0_1.super.onWeaponPreCast(arg_20_0, arg_20_1)
	arg_20_0:initArmorBar(arg_20_1.Data.armor)

	if arg_20_1.Data.armor and arg_20_1.Data.armor ~= 0 then
		arg_20_0:initCastClock(arg_20_1.Data.time, arg_20_1.Dispatcher)
	end

	return
end

function var_0_1.onWeaponPrecastFinish(arg_21_0, arg_21_1)
	var_0_1.super.onWeaponPrecastFinish(arg_21_0, arg_21_1)

	if arg_21_0._castClock:GetCastingWeapon() == arg_21_1.Dispatcher and arg_21_1.Data.armor and arg_21_1.Data.armor ~= 0 then
		if arg_21_0._armor <= 0 then
			arg_21_0._castClock:Interrupt(true)
		else
			arg_21_0._castClock:Interrupt(false)
		end

		arg_21_0._armor = nil

		SetActive(arg_21_0._armorBar, false)
	end

	return
end

function var_0_1.onWeaponInterrupted(arg_22_0, arg_22_1)
	arg_22_0._unitData:StateChange(var_0.Battle.UnitState.STATE_INTERRUPT)

	return
end

function var_0_1.initArmorBar(arg_23_0, arg_23_1)
	if arg_23_1 and arg_23_1 ~= 0 then
		arg_23_0._armor = arg_23_1
		arg_23_0._totalArmor = arg_23_1

		arg_23_0:updateWeaponArmor()
		SetActive(arg_23_0._armorBar, true)
	end

	return
end

function var_0_1.OnUpdateHP(arg_24_0, arg_24_1)
	if arg_24_0._barrier and arg_24_1.Data.preShieldHP < 0 then
		arg_24_0._barrier = arg_24_0._barrier + arg_24_1.Data.preShieldHP

		arg_24_0:updateBarrierBar()
	end

	var_0_1.super.OnUpdateHP(arg_24_0, arg_24_1)

	if arg_24_0._armor and arg_24_1.Data.dHP < 0 then
		arg_24_0._armor = arg_24_0._armor + arg_24_1.Data.dHP

		arg_24_0:updateWeaponArmor()
	end

	return
end

function var_0_1.updateWeaponArmor(arg_25_0)
	arg_25_0._armorProgress.fillAmount = arg_25_0._armor / arg_25_0._totalArmor

	return
end

function var_0_1.initCastClock(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._castClock:Casting(arg_26_1, arg_26_2)

	arg_26_0._castFinishTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_26_1
	arg_26_0._castDuration = arg_26_1

	return
end

function var_0_1.UpdateCastClock(arg_27_0)
	arg_27_0._castClock:UpdateCastClock()

	return
end

function var_0_1.updateComponentDiveInvisible(arg_28_0)
	var_0_1.super.updateComponentDiveInvisible(arg_28_0)
	SetActive(arg_28_0._HPBarTf, true)

	return
end

function var_0_1.updateComponentVisible(arg_29_0)
	var_0_1.super.updateComponentVisible(arg_29_0)
	SetActive(arg_29_0._HPBarTf, true)

	return
end

function var_0_1.initBarrierBar(arg_30_0)
	arg_30_0._unitData:RegisterEventListener(arg_30_0, var_0_0.BARRIER_STATE_CHANGE, arg_30_0.onBarrierStateChange)

	return
end

function var_0_1.onBarrierStateChange(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1.Data.barrierDurability
	local var_31_1 = arg_31_1.Data.barrierDuration

	SetActive(arg_31_0._barrierBar, arg_31_1.Data.barrierDurability > 0)

	if var_31_0 > 0 then
		arg_31_0._totalBarrier = var_31_0
		arg_31_0._barrier = var_31_0

		arg_31_0:initBarrierClock(var_31_1)
		arg_31_0:updateBarrierBar()
		arg_31_0:updateBarrierClock()
	else
		arg_31_0._barrier = nil
		arg_31_0._totalBarrier = nil

		arg_31_0._barrierClock:Interrupt()
	end

	return
end

function var_0_1.updateBarrierBar(arg_32_0)
	arg_32_0._barrierProgress.fillAmount = arg_32_0._barrier / arg_32_0._totalBarrier

	return
end

function var_0_1.updateBarrierClock(arg_33_0)
	arg_33_0._barrierClock:UpdateBarrierClockProgress()

	return
end

function var_0_1.initBarrierClock(arg_34_0, arg_34_1)
	arg_34_0._barrierClock:Shielding(arg_34_1)

	return
end

function var_0_1.AddAimBiasBar(arg_35_0, arg_35_1)
	arg_35_0._normalHPTF = arg_35_1
	arg_35_0._aimBiarBarTF = arg_35_1:Find("biasBar")
	arg_35_0._aimBiarBar = var_0.Battle.BattleAimbiasBar.New(arg_35_0._aimBiarBarTF)

	arg_35_0._aimBiarBar:ConfigAimBias(arg_35_0._unitData:GetAimBias())
	arg_35_0._aimBiarBar:UpdateAimBiasProgress()

	return
end

function var_0_1.AddModel(arg_36_0, arg_36_1)
	var_0_1.super.AddModel(arg_36_0, arg_36_1)
	arg_36_0:UpdatePosition()

	return
end

return
