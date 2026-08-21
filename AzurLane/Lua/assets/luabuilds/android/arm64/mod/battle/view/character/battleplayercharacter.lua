ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleConfig
local var_0_4 = class("BattlePlayerCharacter", ys.Battle.BattleCharacter)

ys.Battle.BattlePlayerCharacter = var_0_4
var_0_4.__name = "BattlePlayerCharacter"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.SetUnitData(arg_2_0, arg_2_1)
	var_0_4.super.SetUnitData(arg_2_0, arg_2_1)

	arg_2_0._chargeWeaponList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1:GetChargeList()) do
		arg_2_0:InitChargeWeapon(iter_2_1)
	end

	arg_2_0._torpedoWeaponList = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1:GetTorpedoList()) do
		arg_2_0:InitTorpedoWeapon(iter_2_3)
	end

	arg_2_0._airAssistList = {}

	local var_2_0 = arg_2_1:GetAirAssistList()

	if var_2_0 ~= nil then
		for iter_2_4, iter_2_5 in ipairs(var_2_0) do
			arg_2_0:InitAirAssit(iter_2_5)
		end
	end

	arg_2_0._weaponSectorList = {}

	return
end

function var_0_4.AddUnitEvent(arg_3_0)
	var_0_4.super.AddUnitEvent(arg_3_0)
	arg_3_0._unitData:RegisterEventListener(arg_3_0, var_0_0.WILL_DIE, arg_3_0.onWillDie)
	arg_3_0._unitData:RegisterEventListener(arg_3_0, var_0_0.INIT_COOL_DOWN, arg_3_0.onInitWeaponCD)
	arg_3_0._unitData:RegisterEventListener(arg_3_0, var_0_0.WEAPON_SECTOR, arg_3_0.onActiveWeaponSector)
	arg_3_0._unitData:RegisterEventListener(arg_3_0, var_0_0.CREATE_POINT_AIR_STRIKE, arg_3_0.onCreatePointAirStrike)

	if arg_3_0._unitData:GetFleetRangeAAWeapon() then
		arg_3_0:RegisterWeaponListener(arg_3_0._unitData:GetFleetRangeAAWeapon())
	end

	return
end

function var_0_4.RemoveUnitEvent(arg_4_0)
	if arg_4_0._unitData:GetFleetRangeAAWeapon() then
		arg_4_0:UnregisterWeaponListener(arg_4_0._unitData:GetFleetRangeAAWeapon())
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._chargeWeaponList) do
		iter_4_1:UnregisterEventListener(arg_4_0, var_0_0.CHARGE_WEAPON_FINISH)
		arg_4_0:UnregisterWeaponListener(iter_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._torpedoWeaponList) do
		iter_4_3:UnregisterEventListener(arg_4_0, var_0_0.TORPEDO_WEAPON_FIRE)
		iter_4_3:UnregisterEventListener(arg_4_0, var_0_0.TORPEDO_WEAPON_PREPAR)
		iter_4_3:UnregisterEventListener(arg_4_0, var_0_0.TORPEDO_WEAPON_CANCEL)
		iter_4_3:UnregisterEventListener(arg_4_0, var_0_0.TORPEDO_WEAPON_READY)
		arg_4_0:UnregisterWeaponListener(iter_4_3)
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_0._airAssistList) do
		iter_4_5:UnregisterEventListener(arg_4_0, var_0_0.CHARGE_WEAPON_FINISH)
		iter_4_5:UnregisterEventListener(arg_4_0, var_0_0.FIRE)
	end

	arg_4_0._unitData:UnregisterEventListener(arg_4_0, var_0_0.WILL_DIE)
	arg_4_0._unitData:UnregisterEventListener(arg_4_0, var_0_0.INIT_COOL_DOWN)
	arg_4_0._unitData:UnregisterEventListener(arg_4_0, var_0_0.CREATE_POINT_AIR_STRIKE)
	var_0_4.super.RemoveUnitEvent(arg_4_0)

	return
end

function var_0_4.Update(arg_5_0)
	var_0_4.super.Update(arg_5_0)
	arg_5_0:UpdatePosition()
	arg_5_0:UpdateMatrix()

	if not arg_5_0._inViewArea or not arg_5_0._alwaysHideArrow then
		arg_5_0:UpdateArrowBarPosition()
	end

	if arg_5_0._unitData:GetOxyState() then
		arg_5_0:UpdateOxygenBar()
	end

	if arg_5_0._cloakBar then
		arg_5_0._cloakBar:UpdateCloakProgress()
		arg_5_0._hpCloakBar:UpdateCloakProgress()

		if not arg_5_0._inViewArea or not arg_5_0._alwaysHideArrow then
			arg_5_0:UpdateCloakBarPosition()
		end
	end

	return
end

function var_0_4.UpdateArrowBarPosition(arg_6_0)
	var_0_4.super.UpdateArrowBarPosition(arg_6_0)

	local var_6_0 = arg_6_0._unitData:GetFleetVO():GetLeftBoundDistance()

	if arg_6_0._arrowCG and var_6_0 then
		arg_6_0._arrowCG.alpha = var_6_0 < 6 and 0.1 or 1
	end

	if arg_6_0._unitData:GetGroupID() and table.contains(var_0_1.MIRROR_QICON_SHIP_GROUP, arg_6_0._unitData:GetGroupID()) then
		local var_6_1 = arg_6_0._arrowVector.x > 0 and arg_6_0._unitData:GetTemplate().painting .. var_0_1.MIRROR_QICON_KEY or arg_6_0._unitData:GetTemplate().painting
		local var_6_2 = var_0.Battle.BattleResourceManager.GetInstance()

		setImageSprite(findTF(arg_6_0._arrowBar, "icon"), (var_6_2:GetCharacterQIcon(var_6_1)))
	end

	return
end

function var_0_4.UpdateHpBar(arg_7_0)
	var_0_4.super.UpdateHpBar(arg_7_0)

	if arg_7_0._unitData.__name == var_0.Battle.BattleCardPuzzlePlayerUnit.__name then
		arg_7_0:UpdateVectorBar()
	end

	return
end

function var_0_4.UpdateOxygenBar(arg_8_0)
	arg_8_0._oxygenSlider.value = arg_8_0._unitData:GetOxygenProgress()

	return
end

function var_0_4.UpdateVectorBar(arg_9_0)
	arg_9_0._vectorProgress.fillAmount = arg_9_0._unitData:GetHPRate()

	return
end

function var_0_4.UpdateUIComponentPosition(arg_10_0)
	var_0_4.super.UpdateUIComponentPosition(arg_10_0)

	local var_10_0 = arg_10_0._unitData:GetBornPosition()

	if var_10_0 then
		if not arg_10_0._referenceVectorBorn then
			arg_10_0._referenceVectorBorn = Vector3.New(var_10_0.x, var_10_0.y, var_10_0.z)
		else
			arg_10_0._referenceVectorBorn:Set(var_10_0.x, var_10_0.y, var_10_0.z)
		end

		var_0.Battle.BattleVariable.CameraPosToUICameraByRef(arg_10_0._referenceVectorBorn)
	end

	return
end

function var_0_4.AddArrowBar(arg_11_0, arg_11_1)
	var_0_4.super.AddArrowBar(arg_11_0, arg_11_1)

	arg_11_0._arrowCG = GetOrAddComponent(arg_11_0._arrowBarTf, typeof(CanvasGroup))
	arg_11_0._vectorProgress = arg_11_0._arrowBarTf:Find("HPBar/HPProgress"):GetComponent(typeof(Image))

	setImageSprite(findTF(arg_11_0._arrowBar, "icon"), (var_0.Battle.BattleResourceManager.GetInstance():GetCharacterQIcon(arg_11_0._unitData:GetTemplate().painting)))

	if arg_11_0._unitData:IsMainFleetUnit() then
		if arg_11_0._unitData:GetFleetVO():GetMainList()[3] == arg_11_0._unitData then
			arg_11_1.transform:SetSiblingIndex(arg_11_1.transform.parent.childCount - 3)
		end
	end

	arg_11_0:UpdateVectorBar()

	return
end

function var_0_4.GetReferenceVector(arg_12_0, arg_12_1)
	if arg_12_0._inViewArea then
		return var_0_4.super.GetReferenceVector(arg_12_0, arg_12_1)
	else
		return arg_12_0._arrowVector
	end

	return
end

function var_0_4.DisableWeaponTrack(arg_13_0)
	if arg_13_0._torpedoTrack then
		arg_13_0._torpedoTrack:SetActive(false)
	end

	return
end

function var_0_4.SonarAcitve(arg_14_0, arg_14_1)
	if var_0.Battle.BattleAttr.HasSonar(arg_14_0._unitData) then
		arg_14_0._sonar:GetComponent(typeof(Animator)).enabled = arg_14_1
	end

	return
end

function var_0_4.UpdateDiveInvisible(arg_15_0)
	var_0_4.super.UpdateDiveInvisible(arg_15_0)
	SetActive(arg_15_0._diveMark, (arg_15_0._unitData:GetDiveInvisible()))
	SetActive(arg_15_0._oxygenBar, (arg_15_0._unitData:GetOxygenVisible()))

	return
end

function var_0_4.Dispose(arg_16_0)
	arg_16_0._torpedoIcons = nil
	arg_16_0._renderer = nil
	arg_16_0._sonar = nil
	arg_16_0._diveMark = nil
	arg_16_0._oxygenBar = nil
	arg_16_0._oxygenSlider = nil

	Object.Destroy(arg_16_0._arrowBar)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._weaponSectorList) do
		iter_16_1:Dispose()
	end

	arg_16_0._weaponSectorList = nil

	var_0_4.super.Dispose(arg_16_0)

	return
end

function var_0_4.GetModleID(arg_17_0)
	return arg_17_0._unitData:GetTemplate().prefab
end

function var_0_4.OnUpdateHP(arg_18_0, arg_18_1)
	var_0_4.super.OnUpdateHP(arg_18_0, arg_18_1)
	arg_18_0:UpdateVectorBar()

	return
end

function var_0_4.onInitWeaponCD(arg_19_0, arg_19_1)
	arg_19_0:onTorepedoReady()

	return
end

function var_0_4.onCastBlink(arg_20_0, arg_20_1)
	arg_20_0:AddFX("jineng", false, arg_20_1.Data.timeScale, arg_20_1.Data.callbackFunc)

	return
end

function var_0_4.onTorpedoWeaponFire(arg_21_0, arg_21_1)
	arg_21_0._torpedoTrack:SetActive(false)
	arg_21_0:onTorepedoReady()

	return
end

function var_0_4.onTorpedoPrepar(arg_22_0, arg_22_1)
	arg_22_0._torpedoTrack:SetActive(true)

	local var_22_0 = var_0.Battle.BattleDataFunction.GetBulletTmpDataFromID(arg_22_1.Dispatcher:GetTemplateData().bullet_ID[1])

	arg_22_0._torpedoTrack:SetScale(Vector3(var_22_0.range / var_0_1.SPINE_SCALE, var_22_0.cld_box[3] / var_0_1.SPINE_SCALE, 1))

	return
end

function var_0_4.onTorpedoCancel(arg_23_0, arg_23_1)
	arg_23_0._torpedoTrack:SetActive(false)

	return
end

function var_0_4.onTorepedoReady(arg_24_0, arg_24_1)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._torpedoWeaponList) do
		if iter_24_1:GetCurrentState() == iter_24_1.STATE_READY then
			var_24_0 = var_24_0 + 1
		end
	end

	for iter_24_2 = 1, var_0.Battle.BattleConst.MAX_EQUIPMENT_COUNT do
		LuaHelper.SetTFChildActive(arg_24_0._torpedoIcons, "torpedo_" .. iter_24_2, iter_24_2 <= var_24_0)
	end

	return
end

function var_0_4.onAAMissileWeaponFire(arg_25_0, arg_25_1)
	arg_25_0:onAAMissileReady()

	return
end

function var_0_4.onWillDie(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0._smokeList) do
		if iter_26_1.active == true then
			iter_26_1.active = false

			for iter_26_2, iter_26_3 in pairs(iter_26_1.smokes) do
				if iter_26_2.unInitialize then
					-- block empty
				else
					SetActive(iter_26_3, false)
				end
			end
		end
	end

	return
end

function var_0_4.AddHPBar(arg_27_0, arg_27_1)
	var_0_4.super.AddHPBar(arg_27_0, arg_27_1)

	arg_27_0._torpedoIcons = arg_27_0._HPBarTf:Find("torpedoIcons")

	if #arg_27_0._torpedoWeaponList <= 0 then
		arg_27_0._torpedoIcons.gameObject:SetActive(false)
	end

	arg_27_0._sonar = arg_27_0._HPBarTf:Find("sonarMark")

	if var_0.Battle.BattleAttr.HasSonar(arg_27_0._unitData) then
		arg_27_0._sonar.gameObject:SetActive(true)
	else
		arg_27_0._sonar.gameObject:SetActive(false)
	end

	arg_27_0._diveMark = arg_27_0._HPBarTf:Find("diveMark")
	arg_27_0._oxygenBar = arg_27_0._HPBarTf:Find("oxygenBar")
	arg_27_0._oxygenSlider = arg_27_0._oxygenBar:Find("oxygen"):GetComponent(typeof(Slider))
	arg_27_0._oxygenSlider.value = 1

	arg_27_0:onTorepedoReady()

	return
end

function var_0_4.AddModel(arg_28_0, arg_28_1)
	var_0_4.super.AddModel(arg_28_0, arg_28_1)

	arg_28_0._renderer = arg_28_0:GetTf():GetComponent(typeof(Renderer))

	return
end

function var_0_4.AddChargeArea(arg_29_0, arg_29_1)
	arg_29_0._chargeWeaponArea = var_0.Battle.BattleChargeArea.New(arg_29_1)

	return
end

function var_0_4.AddTorpedoTrack(arg_30_0, arg_30_1)
	arg_30_0._torpedoTrack = var_0.Battle.BossSkillAlert.New(arg_30_1)

	arg_30_0._torpedoTrack:SetActive(false)

	return
end

function var_0_4.AddCloakBar(arg_31_0, arg_31_1)
	var_0_4.super.AddCloakBar(arg_31_0, arg_31_1)

	arg_31_0._hpCloakBar = var_0.Battle.BattleCloakBar.New(arg_31_0._HPBarTf:Find("cloakBar"), var_0.Battle.BattleCloakBar.FORM_BAR)

	arg_31_0._hpCloakBar:ConfigCloak(arg_31_0._unitData:GetCloak())
	arg_31_0._hpCloakBar:UpdateCloakProgress()
	arg_31_0._hpCloakBar:SetActive(true)

	return
end

function var_0_4.onUpdateCloakConfig(arg_32_0, arg_32_1)
	var_0_4.super.onUpdateCloakConfig(arg_32_0, arg_32_1)
	arg_32_0._hpCloakBar:UpdateCloakConfig()

	return
end

function var_0_4.onUpdateCloakLock(arg_33_0, arg_33_1)
	var_0_4.super.onUpdateCloakLock(arg_33_0, arg_33_1)
	arg_33_0._hpCloakBar:UpdateCloakLock()

	return
end

function var_0_4.InitChargeWeapon(arg_34_0, arg_34_1)
	arg_34_0._chargeWeaponList[#arg_34_0._chargeWeaponList + 1] = arg_34_1

	arg_34_0:RegisterWeaponListener(arg_34_1)
	arg_34_1:RegisterEventListener(arg_34_0, var_0_0.CHARGE_WEAPON_FINISH, arg_34_0.onCastBlink)

	return
end

function var_0_4.InitAirAssit(arg_35_0, arg_35_1)
	arg_35_0._airAssistList[#arg_35_0._airAssistList + 1] = arg_35_1

	arg_35_1:RegisterEventListener(arg_35_0, var_0_0.CHARGE_WEAPON_FINISH, arg_35_0.onCastBlink)
	arg_35_1:RegisterEventListener(arg_35_0, var_0_0.FIRE, arg_35_0.onCannonFire)

	return
end

function var_0_4.InitTorpedoWeapon(arg_36_0, arg_36_1)
	arg_36_0._torpedoWeaponList[#arg_36_0._torpedoWeaponList + 1] = arg_36_1

	arg_36_0:RegisterWeaponListener(arg_36_1)
	arg_36_1:RegisterEventListener(arg_36_0, var_0_0.TORPEDO_WEAPON_FIRE, arg_36_0.onTorpedoWeaponFire)
	arg_36_1:RegisterEventListener(arg_36_0, var_0_0.TORPEDO_WEAPON_PREPAR, arg_36_0.onTorpedoPrepar)
	arg_36_1:RegisterEventListener(arg_36_0, var_0_0.TORPEDO_WEAPON_CANCEL, arg_36_0.onTorpedoCancel)
	arg_36_1:RegisterEventListener(arg_36_0, var_0_0.TORPEDO_WEAPON_READY, arg_36_0.onTorepedoReady)

	return
end

function var_0_4.onActiveWeaponSector(arg_37_0, arg_37_1)
	if arg_37_1.Data.isActive then
		local var_37_0 = var_0.Battle.BattleWeaponRangeSector.New(arg_37_0._factory:GetFXPool():GetCharacterFX("weaponrange", arg_37_0).transform)

		var_37_0:ConfigHost(arg_37_0._unitData, arg_37_1.Data.weapon)

		arg_37_0._weaponSectorList[arg_37_1.Data.weapon] = var_37_0
	else
		arg_37_0._weaponSectorList[arg_37_1.Data.weapon]:Dispose()

		arg_37_0._weaponSectorList[arg_37_1.Data.weapon] = nil
	end

	return
end

function var_0_4.onCreatePointAirStrike(arg_38_0, arg_38_1)
	arg_38_0:InitChargeWeapon(arg_38_1.Data.weapon)

	return
end

function var_0_4.OnAnimatorTrigger(arg_39_0)
	arg_39_0._unitData:CharacterActionTriggerCallback()

	return
end

function var_0_4.OnAnimatorEnd(arg_40_0)
	arg_40_0._unitData:CharacterActionEndCallback()

	return
end

function var_0_4.OnAnimatorStart(arg_41_0)
	arg_41_0._unitData:CharacterActionStartCallback()

	return
end

return
