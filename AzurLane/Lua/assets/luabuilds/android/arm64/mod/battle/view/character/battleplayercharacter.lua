ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleCardPuzzleEvent

class = var_0_10005

local var_0_5 = var_0_10005("BattlePlayerCharacter", var_0.Battle.BattleCharacter)

var_0.Battle.BattlePlayerCharacter = var_0_5
var_0_5.__name = "BattlePlayerCharacter"

function var_0_5.Ctor(arg_1_0)
	var_0_5.super.Ctor(arg_1_0)

	return
end

function var_0_5.SetUnitData(arg_2_0, arg_2_1)
	var_0_5.super.SetUnitData(arg_2_0, arg_2_1)

	arg_2_0._chargeWeaponList = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1:GetChargeList()) do
		arg_2_0:InitChargeWeapon(iter_2_1)
	end

	arg_2_0._torpedoWeaponList = {}
	ipairs = var_2

	for iter_2_2, iter_2_3 in var_2(arg_2_1:GetTorpedoList()) do
		arg_2_0:InitTorpedoWeapon(iter_2_3)
	end

	arg_2_0._airAssistList = {}

	if arg_2_1:GetAirAssistList() ~= nil then
		ipairs = var_3

		for iter_2_4, iter_2_5 in var_3(var_2) do
			arg_2_0:InitAirAssit(iter_2_5)
		end
	end

	arg_2_0._weaponSectorList = {}

	return
end

function var_0_5.AddUnitEvent(arg_3_0)
	var_0_5.super.AddUnitEvent(arg_3_0)

	local var_3_0 = arg_3_0._unitData

	var_1.RegisterEventListener(var_3_0, arg_3_0, var_0_1.WILL_DIE, arg_3_0.onWillDie)

	local var_3_1 = arg_3_0._unitData

	var_1.RegisterEventListener(var_3_1, arg_3_0, var_0_1.INIT_COOL_DOWN, arg_3_0.onInitWeaponCD)

	local var_3_2 = arg_3_0._unitData

	var_1.RegisterEventListener(var_3_2, arg_3_0, var_0_1.WEAPON_SECTOR, arg_3_0.onActiveWeaponSector)

	local var_3_3 = arg_3_0._unitData

	var_1.RegisterEventListener(var_3_3, arg_3_0, var_0_1.CREATE_POINT_AIR_STRIKE, arg_3_0.onCreatePointAirStrike)

	local var_3_4 = arg_3_0._unitData

	if var_1.GetFleetRangeAAWeapon(var_3_4) then
		local var_3_5 = arg_3_0
		local var_3_6 = arg_3_0.RegisterWeaponListener
		local var_3_7 = arg_3_0._unitData

		var_3_6(var_3_5, var_4.GetFleetRangeAAWeapon(var_3_7))
	end

	return
end

function var_0_5.RemoveUnitEvent(arg_4_0)
	local var_4_0 = arg_4_0._unitData
	local var_4_2

	if var_1.GetFleetRangeAAWeapon(var_4_0) then
		local var_4_1 = arg_4_0

		var_4_2 = arg_4_0.UnregisterWeaponListener

		local var_4_3 = arg_4_0._unitData

		var_4_2(var_4_1, var_4.GetFleetRangeAAWeapon(var_4_3))
	end

	ipairs = var_4_2

	for iter_4_0, iter_4_1 in var_4_2(arg_4_0._chargeWeaponList) do
		iter_4_1:UnregisterEventListener(arg_4_0, var_0_1.CHARGE_WEAPON_FINISH)
		arg_4_0:UnregisterWeaponListener(iter_4_1)
	end

	ipairs = var_1

	for iter_4_2, iter_4_3 in var_1(arg_4_0._torpedoWeaponList) do
		iter_4_3:UnregisterEventListener(arg_4_0, var_0_1.TORPEDO_WEAPON_FIRE)
		iter_4_3:UnregisterEventListener(arg_4_0, var_0_1.TORPEDO_WEAPON_PREPAR)
		iter_4_3:UnregisterEventListener(arg_4_0, var_0_1.TORPEDO_WEAPON_CANCEL)
		iter_4_3:UnregisterEventListener(arg_4_0, var_0_1.TORPEDO_WEAPON_READY)
		arg_4_0:UnregisterWeaponListener(iter_4_3)
	end

	ipairs = var_1

	for iter_4_4, iter_4_5 in var_1(arg_4_0._airAssistList) do
		iter_4_5:UnregisterEventListener(arg_4_0, var_0_1.CHARGE_WEAPON_FINISH)
		iter_4_5:UnregisterEventListener(arg_4_0, var_0_1.FIRE)
	end

	local var_4_4 = arg_4_0._unitData

	var_1.UnregisterEventListener(var_4_4, arg_4_0, var_0_1.WILL_DIE)

	local var_4_5 = arg_4_0._unitData

	var_1.UnregisterEventListener(var_4_5, arg_4_0, var_0_1.INIT_COOL_DOWN)

	local var_4_6 = arg_4_0._unitData

	var_1.UnregisterEventListener(var_4_6, arg_4_0, var_0_1.CREATE_POINT_AIR_STRIKE)
	var_0_5.super.RemoveUnitEvent(arg_4_0)

	return
end

function var_0_5.Update(arg_5_0)
	var_0_5.super.Update(arg_5_0)
	arg_5_0:UpdatePosition()
	arg_5_0:UpdateMatrix()

	if not arg_5_0._inViewArea or not arg_5_0._alwaysHideArrow then
		arg_5_0:UpdateArrowBarPosition()
	end

	local var_5_0 = arg_5_0._unitData

	if var_1.GetOxyState(var_5_0) then
		arg_5_0:UpdateOxygenBar()
	end

	if arg_5_0._cloakBar then
		local var_5_1 = arg_5_0._cloakBar

		var_1.UpdateCloakProgress(var_5_1)

		local var_5_2 = arg_5_0._hpCloakBar

		var_1.UpdateCloakProgress(var_5_2)

		if not arg_5_0._inViewArea or not arg_5_0._alwaysHideArrow then
			arg_5_0:UpdateCloakBarPosition()
		end
	end

	return
end

function var_0_5.UpdateArrowBarPosition(arg_6_0)
	var_0_5.super.UpdateArrowBarPosition(arg_6_0)

	local var_6_0 = arg_6_0._unitData
	local var_6_1 = var_1.GetFleetVO(var_6_0)
	local var_6_2 = var_1.GetLeftBoundDistance(var_6_1)

	if arg_6_0._arrowCG and var_6_2 then
		if var_6_2 < 6 then
			arg_6_0._arrowCG.alpha = 0.1
		else
			arg_6_0._arrowCG.alpha = 1
		end
	end

	local var_6_3 = arg_6_0._unitData

	if var_2.GetGroupID(var_6_3) then
		table = var_2

		local var_6_4 = var_2.contains
		local var_6_5 = var_0_2.MIRROR_QICON_SHIP_GROUP
		local var_6_6 = arg_6_0._unitData

		if var_6_4(var_6_5, var_5.GetGroupID(var_6_6)) then
			local var_6_7
			local var_6_8 = arg_6_0._arrowVector.x

			if 0 < var_6_8 then
				local var_6_9 = arg_6_0._unitData

				var_6_7 = var_3.GetTemplate(var_6_9).painting .. var_0_2.MIRROR_QICON_KEY
			else
				local var_6_10 = arg_6_0._unitData

				var_6_7 = var_3.GetTemplate(var_6_10).painting
			end

			local var_6_11 = var_0.Battle.BattleResourceManager.GetInstance()
			local var_6_12 = var_3.GetCharacterQIcon(var_6_11, var_6_7)

			setImageSprite = var_4
			findTF = var_6

			var_4(var_6(arg_6_0._arrowBar, "icon"), var_6_12)
		end
	end

	return
end

function var_0_5.UpdateHpBar(arg_7_0)
	var_0_5.super.UpdateHpBar(arg_7_0)

	if arg_7_0._unitData.__name == var_0.Battle.BattleCardPuzzlePlayerUnit.__name then
		arg_7_0:UpdateVectorBar()
	end

	return
end

function var_0_5.UpdateOxygenBar(arg_8_0)
	local var_8_0 = arg_8_0._oxygenSlider
	local var_8_1 = arg_8_0._unitData

	var_8_0.value = var_2.GetOxygenProgress(var_8_1)

	return
end

function var_0_5.UpdateVectorBar(arg_9_0)
	local var_9_0 = arg_9_0._unitData
	local var_9_1 = var_1.GetHPRate(var_9_0)

	arg_9_0._vectorProgress.fillAmount = var_9_1

	return
end

function var_0_5.UpdateUIComponentPosition(arg_10_0)
	var_0_5.super.UpdateUIComponentPosition(arg_10_0)

	local var_10_0 = arg_10_0._unitData

	if var_1.GetBornPosition(var_10_0) then
		if not arg_10_0._referenceVectorBorn then
			Vector3 = var_2
			arg_10_0._referenceVectorBorn = var_2.New(var_1.x, var_1.y, var_1.z)
		else
			local var_10_1 = arg_10_0._referenceVectorBorn

			var_2.Set(var_10_1, var_1.x, var_1.y, var_1.z)
		end

		var_0.Battle.BattleVariable.CameraPosToUICameraByRef(arg_10_0._referenceVectorBorn)
	end

	return
end

function var_0_5.AddArrowBar(arg_11_0, arg_11_1)
	var_0_5.super.AddArrowBar(arg_11_0, arg_11_1)

	GetOrAddComponent = var_2

	local var_11_0 = arg_11_0._arrowBarTf

	typeof = var_5
	CanvasGroup = var_1_10007
	arg_11_0._arrowCG = var_2(var_11_0, var_5(var_1_10007))

	local var_11_1 = arg_11_0._arrowBarTf
	local var_11_2 = var_2.Find(var_11_1, "HPBar/HPProgress")
	local var_11_3 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_11_0._vectorProgress = var_11_3(var_11_2, var_5(var_1_10007))

	local var_11_4 = var_0.Battle.BattleResourceManager.GetInstance()
	local var_11_5 = var_2.GetCharacterQIcon
	local var_11_6 = arg_11_0._unitData
	local var_11_7 = var_11_5(var_11_4, var_6.GetTemplate(var_11_6).painting)

	setImageSprite = var_11_2
	findTF = var_6

	var_11_2(var_6(arg_11_0._arrowBar, "icon"), var_11_7)

	local var_11_8 = arg_11_0._unitData

	if var_4.IsMainFleetUnit(var_11_8) then
		local var_11_9 = arg_11_0._unitData
		local var_11_10 = var_4.GetFleetVO(var_11_9)

		if var_4.GetMainList(var_11_10)[3] == arg_11_0._unitData then
			local var_11_11 = arg_11_1.transform

			var_5.SetSiblingIndex(var_11_11, arg_11_1.transform.parent.childCount - 3)
		end
	end

	arg_11_0:UpdateVectorBar()

	return
end

function var_0_5.GetReferenceVector(arg_12_0, arg_12_1)
	if arg_12_0._inViewArea then
		return var_0_5.super.GetReferenceVector(arg_12_0, arg_12_1)
	else
		return arg_12_0._arrowVector
	end

	return
end

function var_0_5.DisableWeaponTrack(arg_13_0)
	if arg_13_0._torpedoTrack then
		local var_13_0 = arg_13_0._torpedoTrack

		var_1.SetActive(var_13_0, false)
	end

	return
end

function var_0_5.SonarAcitve(arg_14_0, arg_14_1)
	if var_0.Battle.BattleAttr.HasSonar(arg_14_0._unitData) then
		local var_14_0 = arg_14_0._sonar
		local var_14_1 = var_2.GetComponent

		typeof = var_1_10005
		Animator = var_1_10007
		var_14_1(var_14_0, var_1_10005(var_1_10007)).enabled = arg_14_1
	end

	return
end

function var_0_5.UpdateDiveInvisible(arg_15_0)
	var_0_5.super.UpdateDiveInvisible(arg_15_0)

	local var_15_0 = arg_15_0._unitData
	local var_15_1 = var_1.GetDiveInvisible(var_15_0)

	SetActive = var_1_10002

	var_1_10002(arg_15_0._diveMark, var_15_1)

	local var_15_2 = arg_15_0._unitData
	local var_15_3 = var_2.GetOxygenVisible(var_15_2)

	SetActive = var_15_0

	var_15_0(arg_15_0._oxygenBar, var_15_3)

	return
end

function var_0_5.Dispose(arg_16_0)
	arg_16_0._torpedoIcons = nil
	arg_16_0._renderer = nil
	arg_16_0._sonar = nil
	arg_16_0._diveMark = nil
	arg_16_0._oxygenBar = nil
	arg_16_0._oxygenSlider = nil
	Object = var_1

	var_1.Destroy(arg_16_0._arrowBar)

	ipairs = var_1

	for iter_16_0, iter_16_1 in var_1(arg_16_0._weaponSectorList) do
		iter_16_1:Dispose()
	end

	arg_16_0._weaponSectorList = nil

	var_0_5.super.Dispose(arg_16_0)

	return
end

function var_0_5.GetModleID(arg_17_0)
	local var_17_0 = arg_17_0._unitData

	return var_1.GetTemplate(var_17_0).prefab
end

function var_0_5.OnUpdateHP(arg_18_0, arg_18_1)
	var_0_5.super.OnUpdateHP(arg_18_0, arg_18_1)
	arg_18_0:UpdateVectorBar()

	return
end

function var_0_5.onInitWeaponCD(arg_19_0, arg_19_1)
	arg_19_0:onTorepedoReady()

	return
end

function var_0_5.onCastBlink(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.Data.callbackFunc
	local var_20_1 = arg_20_1.Data.timeScale

	arg_20_0:AddFX("jineng", false, var_20_1, var_20_0)

	return
end

function var_0_5.onTorpedoWeaponFire(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._torpedoTrack

	var_2.SetActive(var_21_0, false)
	arg_21_0:onTorepedoReady()

	return
end

function var_0_5.onTorpedoPrepar(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._torpedoTrack

	var_2.SetActive(var_22_0, true)

	local var_22_1 = var_0.Battle.BattleDataFunction.GetBulletTmpDataFromID
	local var_22_2 = arg_22_1.Dispatcher
	local var_22_3 = var_22_1(var_4.GetTemplateData(var_22_2).bullet_ID[1])
	local var_22_4 = arg_22_0._torpedoTrack
	local var_22_5 = var_3.SetScale

	Vector3 = var_22_2

	var_22_5(var_22_4, var_22_2(var_22_3.range / var_0_2.SPINE_SCALE, var_22_3.cld_box[3] / var_0_2.SPINE_SCALE, 1))

	return
end

function var_0_5.onTorpedoCancel(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._torpedoTrack

	var_2.SetActive(var_23_0, false)

	return
end

function var_0_5.onTorepedoReady(arg_24_0, arg_24_1)
	local var_24_0 = 0

	ipairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_0._torpedoWeaponList) do
		if iter_24_1:GetCurrentState() == iter_24_1.STATE_READY then
			var_24_0 = var_24_0 + 1
		end
	end

	for iter_24_2 = 1, var_0.Battle.BattleConst.MAX_EQUIPMENT_COUNT do
		LuaHelper = iter_24_1

		iter_24_1.SetTFChildActive(arg_24_0._torpedoIcons, "torpedo_" .. iter_24_2, iter_24_2 <= var_24_0)
	end

	return
end

function var_0_5.onAAMissileWeaponFire(arg_25_0, arg_25_1)
	arg_25_0:onAAMissileReady()

	return
end

function var_0_5.onWillDie(arg_26_0, arg_26_1)
	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0._smokeList) do
		if iter_26_1.active == true then
			iter_26_1.active = false

			local var_26_0 = iter_26_1.smokes

			pairs = var_1_10008

			for iter_26_2, iter_26_3 in var_1_10008(var_26_0) do
				if iter_26_2.unInitialize then
					-- block empty
				else
					SetActive = var_13

					var_13(iter_26_3, false)
				end
			end
		end
	end

	return
end

function var_0_5.AddHPBar(arg_27_0, arg_27_1)
	var_0_5.super.AddHPBar(arg_27_0, arg_27_1)

	local var_27_0 = arg_27_0._HPBarTf

	arg_27_0._torpedoIcons = var_2.Find(var_27_0, "torpedoIcons")

	if #arg_27_0._torpedoWeaponList <= 0 then
		local var_27_1 = arg_27_0._torpedoIcons.gameObject

		var_2.SetActive(var_27_1, false)
	end

	local var_27_2 = arg_27_0._HPBarTf

	arg_27_0._sonar = var_2.Find(var_27_2, "sonarMark")

	if var_0.Battle.BattleAttr.HasSonar(arg_27_0._unitData) then
		local var_27_3 = arg_27_0._sonar.gameObject

		var_2.SetActive(var_27_3, true)
	else
		local var_27_4 = arg_27_0._sonar.gameObject

		var_2.SetActive(var_27_4, false)
	end

	local var_27_5 = arg_27_0._HPBarTf

	arg_27_0._diveMark = var_2.Find(var_27_5, "diveMark")

	local var_27_6 = arg_27_0._HPBarTf

	arg_27_0._oxygenBar = var_2.Find(var_27_6, "oxygenBar")

	local var_27_7 = arg_27_0._oxygenBar
	local var_27_8 = var_2.Find(var_27_7, "oxygen")
	local var_27_9 = var_2.GetComponent

	typeof = var_5
	Slider = var_1_10007
	arg_27_0._oxygenSlider = var_27_9(var_27_8, var_5(var_1_10007))
	arg_27_0._oxygenSlider.value = 1

	arg_27_0:onTorepedoReady()

	return
end

function var_0_5.AddModel(arg_28_0, arg_28_1)
	var_0_5.super.AddModel(arg_28_0, arg_28_1)

	local var_28_0 = arg_28_0:GetTf()
	local var_28_1 = var_2.GetComponent

	typeof = var_5
	Renderer = var_1_10007
	arg_28_0._renderer = var_28_1(var_28_0, var_5(var_1_10007))

	return
end

function var_0_5.AddChargeArea(arg_29_0, arg_29_1)
	arg_29_0._chargeWeaponArea = var_0.Battle.BattleChargeArea.New(arg_29_1)

	return
end

function var_0_5.AddTorpedoTrack(arg_30_0, arg_30_1)
	arg_30_0._torpedoTrack = var_0.Battle.BossSkillAlert.New(arg_30_1)

	local var_30_0 = arg_30_0._torpedoTrack

	var_2.SetActive(var_30_0, false)

	return
end

function var_0_5.AddCloakBar(arg_31_0, arg_31_1)
	var_0_5.super.AddCloakBar(arg_31_0, arg_31_1)

	local var_31_0 = arg_31_0._HPBarTf
	local var_31_1 = var_2.Find(var_31_0, "cloakBar")

	arg_31_0._hpCloakBar = var_0.Battle.BattleCloakBar.New(var_31_1, var_0.Battle.BattleCloakBar.FORM_BAR)

	local var_31_2 = arg_31_0._hpCloakBar
	local var_31_3 = var_3.ConfigCloak
	local var_31_4 = arg_31_0._unitData

	var_31_3(var_31_2, var_6.GetCloak(var_31_4))

	local var_31_5 = arg_31_0._hpCloakBar

	var_3.UpdateCloakProgress(var_31_5)

	local var_31_6 = arg_31_0._hpCloakBar

	var_3.SetActive(var_31_6, true)

	return
end

function var_0_5.onUpdateCloakConfig(arg_32_0, arg_32_1)
	var_0_5.super.onUpdateCloakConfig(arg_32_0, arg_32_1)

	local var_32_0 = arg_32_0._hpCloakBar

	var_2.UpdateCloakConfig(var_32_0)

	return
end

function var_0_5.onUpdateCloakLock(arg_33_0, arg_33_1)
	var_0_5.super.onUpdateCloakLock(arg_33_0, arg_33_1)

	local var_33_0 = arg_33_0._hpCloakBar

	var_2.UpdateCloakLock(var_33_0)

	return
end

function var_0_5.InitChargeWeapon(arg_34_0, arg_34_1)
	arg_34_0._chargeWeaponList[#arg_34_0._chargeWeaponList + 1] = arg_34_1

	arg_34_0:RegisterWeaponListener(arg_34_1)
	arg_34_1:RegisterEventListener(arg_34_0, var_0_1.CHARGE_WEAPON_FINISH, arg_34_0.onCastBlink)

	return
end

function var_0_5.InitAirAssit(arg_35_0, arg_35_1)
	arg_35_0._airAssistList[#arg_35_0._airAssistList + 1] = arg_35_1

	arg_35_1:RegisterEventListener(arg_35_0, var_0_1.CHARGE_WEAPON_FINISH, arg_35_0.onCastBlink)
	arg_35_1:RegisterEventListener(arg_35_0, var_0_1.FIRE, arg_35_0.onCannonFire)

	return
end

function var_0_5.InitTorpedoWeapon(arg_36_0, arg_36_1)
	arg_36_0._torpedoWeaponList[#arg_36_0._torpedoWeaponList + 1] = arg_36_1

	arg_36_0:RegisterWeaponListener(arg_36_1)
	arg_36_1:RegisterEventListener(arg_36_0, var_0_1.TORPEDO_WEAPON_FIRE, arg_36_0.onTorpedoWeaponFire)
	arg_36_1:RegisterEventListener(arg_36_0, var_0_1.TORPEDO_WEAPON_PREPAR, arg_36_0.onTorpedoPrepar)
	arg_36_1:RegisterEventListener(arg_36_0, var_0_1.TORPEDO_WEAPON_CANCEL, arg_36_0.onTorpedoCancel)
	arg_36_1:RegisterEventListener(arg_36_0, var_0_1.TORPEDO_WEAPON_READY, arg_36_0.onTorepedoReady)

	return
end

function var_0_5.onActiveWeaponSector(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1.Data.isActive
	local var_37_1 = var_2.weapon

	if var_37_0 then
		local var_37_2 = arg_37_0._factory
		local var_37_3 = var_5.GetFXPool(var_37_2)
		local var_37_4 = var_5.GetCharacterFX(var_37_3, "weaponrange", arg_37_0).transform
		local var_37_5 = var_0.Battle.BattleWeaponRangeSector.New(var_37_4)

		var_6.ConfigHost(var_37_5, arg_37_0._unitData, var_37_1)

		arg_37_0._weaponSectorList[var_37_1] = var_6
	else
		local var_37_6 = arg_37_0._weaponSectorList[var_37_1]

		var_5.Dispose(var_37_6)

		arg_37_0._weaponSectorList[var_37_1] = nil
	end

	return
end

function var_0_5.onCreatePointAirStrike(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1.Data.weapon

	arg_38_0:InitChargeWeapon(var_38_0)

	return
end

function var_0_5.OnAnimatorTrigger(arg_39_0)
	local var_39_0 = arg_39_0._unitData

	var_1.CharacterActionTriggerCallback(var_39_0)

	return
end

function var_0_5.OnAnimatorEnd(arg_40_0)
	local var_40_0 = arg_40_0._unitData

	var_1.CharacterActionEndCallback(var_40_0)

	return
end

function var_0_5.OnAnimatorStart(arg_41_0)
	local var_41_0 = arg_41_0._unitData

	var_1.CharacterActionStartCallback(var_41_0)

	return
end

return
