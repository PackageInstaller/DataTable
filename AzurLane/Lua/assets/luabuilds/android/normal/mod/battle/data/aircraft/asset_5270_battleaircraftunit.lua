ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleConfig
local var_0_4 = var_0.Battle.BattleVariable
local var_0_5 = var_0.Battle.BattleDataFunction

class = var_0_10006

local var_0_6 = var_0_10006("BattleAircraftUnit")

var_0.Battle.BattleAircraftUnit = var_0_6
var_0_6.__name = "BattleAircraftUnit"
var_0_6.STATE_CREATE = "Create"
var_0_6.STATE_ATTACK = "Attack"
var_0_6.STATE_DESTORY = "Destory"
var_0_6.HEIGHT = var_0_3.AircraftHeight + 5

function var_0_6.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._uniqueID = arg_1_1
	arg_1_0._speedExemptKey = "air_" .. arg_1_1
	arg_1_0._dir = var_0.Battle.BattleConst.UnitDir.RIGHT
	arg_1_0._type = var_0_2.UnitType.AIRCRAFT_UNIT
	arg_1_0._currentState = arg_1_0.STATE_CREATE
	arg_1_0._distanceBackup = {}
	arg_1_0._battleProxy = var_0.Battle.BattleDataProxy.GetInstance()
	arg_1_0._frame = 0
	arg_1_0._weaponPotential = 1

	arg_1_0:Init()

	return
end

function var_0_6.SetBound(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._top = arg_2_1
	arg_2_0._bottom = arg_2_2

	if arg_2_0._tmpData.spawn_brownian == -1 then
		arg_2_0._speedZ = 0
	else
		math = var_3
		arg_2_0._speedZ = (var_3.random() - 0.5) * 0.5
	end

	arg_2_0:SetTargetZ()

	return
end

function var_0_6.SetViewBoundData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._cameraTop = arg_3_1 + 3
	arg_3_0._cameraBottom = arg_3_2 - 23
	arg_3_0._cameraLeft = arg_3_3 - 3
	arg_3_0._cameraRight = arg_3_4 + 10

	return
end

function var_0_6.Update(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._pos

	var_2.Add(var_4_0, arg_4_0._speed)
	arg_4_0:UpdateSpeed()
	arg_4_0:UpdateWeapon()

	return
end

function var_0_6.ActiveCldBox(arg_5_0)
	local var_5_0 = arg_5_0._cldComponent

	var_1.SetActive(var_5_0, true)

	return
end

function var_0_6.DeactiveCldBox(arg_6_0)
	local var_6_0 = arg_6_0._cldComponent

	var_1.SetActive(var_6_0, false)

	return
end

function var_0_6.SetCldBoxImmune(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._cldComponent

	var_2.SetImmuneCLD(var_7_0, arg_7_1)

	return
end

function var_0_6.Init(arg_8_0)
	arg_8_0._aliveState = true
	Vector3 = var_1
	arg_8_0._speed = var_1.zero
	Vector3 = var_1
	arg_8_0._pos = var_1.zero
	arg_8_0._undefeated = false
	arg_8_0._labelTagList = {}

	return
end

function var_0_6.Clear(arg_9_0)
	if arg_9_0._createTimer then
		pg = var_1

		local var_9_0 = var_1.TimeMgr.GetInstance()

		var_1.RemoveBattleTimer(var_9_0, arg_9_0._createTimer)

		arg_9_0._createTimer = nil
	end

	arg_9_0:ShutdownWeapon()

	arg_9_0._distanceBackup = {}

	return
end

function var_0_6.SetWeaponPreCastBound(arg_10_0)
	return
end

function var_0_6.EnterGCD(arg_11_0)
	return
end

function var_0_6.CreateWeapon(arg_12_0)
	local var_12_0 = {}

	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0._tmpData.weapon_ID) do
		var_12_0[iter_12_0] = var_0.Battle.BattleDataFunction.CreateAirFighterWeaponUnit(iter_12_1, arg_12_0, iter_12_0, arg_12_0._weaponPotential)
	end

	return var_12_0
end

function var_0_6.ShutdownWeapon(arg_13_0)
	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0:GetWeapon()) do
		iter_13_1:Clear()
	end

	return
end

function var_0_6.UpdateWeapon(arg_14_0)
	if arg_14_0._currentState == arg_14_0.STATE_ATTACK then
		ipairs = var_1

		for iter_14_0, iter_14_1 in var_1(arg_14_0:GetWeapon()) do
			iter_14_1:Update()
		end
	end

	return
end

function var_0_6.SetStrikePoint(arg_15_0, arg_15_1)
	arg_15_0._strikePoint = arg_15_1

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.SetPosition

	Vector3 = var_1_10004

	var_15_1(var_15_0, var_1_10004(arg_15_0._pos.x, arg_15_0._pos.y, arg_15_1.z))

	return
end

function var_0_6.GetStrikePoint(arg_16_0)
	return arg_16_0._strikePoint
end

function var_0_6.GetWeapon(arg_17_0)
	return arg_17_0._weapon
end

function var_0_6.GetCurrentHP(arg_18_0)
	return arg_18_0._currentHP
end

function var_0_6.GetMaxHP(arg_19_0)
	return var_0.Battle.BattleAttr.GetCurrent(arg_19_0, "maxHP")
end

function var_0_6.IsUndefeated(arg_20_0)
	return arg_20_0._undefeated
end

function var_0_6.IsAlive(arg_21_0)
	return arg_21_0._aliveState
end

function var_0_6.IsCease(arg_22_0)
	return false
end

function var_0_6.GetOxyState(arg_23_0)
	return nil
end

function var_0_6.IsBoss(arg_24_0)
	return nil
end

function var_0_6.HandleDamageToDeath(arg_25_0)
	arg_25_0:UpdateHP(-arg_25_0._currentHP, {
		isMiss = false,
		isCri = false,
		isHeal = false
	})

	return
end

function var_0_6.UpdateHP(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2.isMiss
	local var_26_1 = arg_26_2.isCri
	local var_26_2 = arg_26_2.isHeal

	arg_26_0._currentHP = arg_26_0._currentHP + arg_26_1

	if arg_26_0:GetMaxHP() < arg_26_0._currentHP then
		arg_26_0._currentHP = var_6
	end

	if arg_26_0._currentHP < 0 then
		arg_26_0._currentHP = 0
	end

	local var_26_3 = {
		dHP = arg_26_1,
		isMiss = var_26_0,
		isCri = var_26_1,
		isHeal = var_26_2
	}

	arg_26_0:DispatchEvent(var_0.Event.New(var_0_1.UPDATE_AIR_CRAFT_HP, var_26_3))

	if arg_26_0._currentHP <= 0 and arg_26_0:IsAlive() then
		arg_26_0:onDead()
	end

	return arg_26_1
end

function var_0_6.onDead(arg_27_0)
	arg_27_0._currentState = arg_27_0.STATE_DESTORY
	arg_27_0._aliveState = false

	return
end

function var_0_6.UpdateSpeed(arg_28_0)
	local var_28_0 = arg_28_0._speedDir
	local var_28_1 = arg_28_0._velocity * arg_28_0:GetSpeedRatio()
	local var_28_2 = arg_28_0._speed

	var_3.Copy(var_28_2, var_28_0)

	local var_28_3 = arg_28_0._speed

	var_3.Mul(var_28_3, var_28_1)

	if arg_28_0:GetPosition().y < var_0_6.HEIGHT then
		local var_28_4 = arg_28_0._speed

		math = var_5
		var_28_4.y = var_5.max(0.4, 1 - var_3.y / var_0_3.AircraftHeight)
	end

	arg_28_0._speed.z = var_28_1 * arg_28_0._speedZ

	if arg_28_0._tmpData.spawn_brownian == 1 then
		if var_28_1 < arg_28_0._targetZ - var_3.z then
			arg_28_0._speed.z = var_28_1 * 0.5
		elseif var_4 < -var_28_1 then
			arg_28_0._speed.z = -var_28_1 * 0.5
		else
			arg_28_0:SetTargetZ()
		end
	end

	return
end

function var_0_6.OutBound(arg_29_0)
	arg_29_0._undefeated = true

	arg_29_0:onDead()

	return
end

function var_0_6.GetSize(arg_30_0)
	if arg_30_0._currentState == arg_30_0.STATE_CREATE then
		Mathf = var_1

		return var_1.Clamp(arg_30_0:GetPosition().y / var_0_6.HEIGHT, 0.1, arg_30_0._scale)
	else
		return arg_30_0._scale
	end

	return
end

function var_0_6.SetTemplate(arg_31_0, arg_31_1)
	arg_31_0._tmpData = arg_31_1

	arg_31_0:InitCldComponent()
	var_0.Battle.BattleAttr.SetAircraftAttFromTemp(arg_31_0)

	arg_31_0._currentHP = arg_31_0:GetMaxHP()
	arg_31_0._weapon = arg_31_0:CreateWeapon()
	arg_31_0._modelID = arg_31_1.model_ID

	local var_31_0 = arg_31_1.speed + arg_31_0:GetAttrByName("aircraftBooster")

	arg_31_0._velocity = var_0.Battle.BattleFormulas.ConvertAircraftSpeed(var_31_0)

	local var_31_1

	if not arg_31_1.scale then
		var_31_1 = 1
	end

	arg_31_0._scale = var_31_1

	return
end

function var_0_6.SetWeanponPotential(arg_32_0, arg_32_1)
	arg_32_0._weaponPotential = arg_32_1

	return
end

function var_0_6.SetTargetZ(arg_33_0)
	local var_33_0 = (arg_33_0._bottom + arg_33_0._top) * 0.5
	local var_33_1 = var_2 - var_1

	math = var_1_10005
	arg_33_0._targetZ = var_33_0 + var_33_1 * (var_1_10005.random() - 0.5) * 0.6

	return
end

function var_0_6.SetMotherUnit(arg_34_0, arg_34_1)
	arg_34_0._motherUnit = arg_34_1

	local var_34_0 = arg_34_0._motherUnit
	local var_34_1 = var_2.GetIFF(var_34_0)

	arg_34_0:SetIFF(var_34_1)
	arg_34_0:SetAttr(arg_34_1)

	local var_34_2 = arg_34_0._motherUnit

	if var_3.GetWeaponBoundBone(var_34_2).remote then
		local var_34_3 = var_3.remote

		Vector3 = var_5
		var_5.x = var_5(var_34_3[1], var_34_3[2], var_34_3[3]).x * var_34_1

		local var_34_4 = arg_34_0._battleProxy
		local var_34_5 = var_6.GetStageInfo(var_34_4).mainUnitPosition
		local var_34_6

		if var_34_5 and var_34_5[var_34_1] then
			var_34_6 = var_34_5[var_34_1][1]
		else
			var_34_6 = var_0_3.MAIN_UNIT_POS[var_34_1][1]
		end

		local var_34_7 = var_34_6 + var_5

		arg_34_0:SetPosition(var_34_7)
	else
		local var_34_8 = arg_34_0
		local var_34_9 = arg_34_0.SetPosition
		local var_34_10 = arg_34_0._motherUnit

		var_34_9(var_34_8, var_6.GetPosition(var_34_10))
	end

	if arg_34_1:GetIFF() == var_0_3.FRIENDLY_CODE then
		arg_34_0._dir = var_0_2.UnitDir.RIGHT
		arg_34_0._isPlayerAircraft = true
	else
		arg_34_0._dir = var_0_2.UnitDir.LEFT
	end

	return
end

function var_0_6.GetLabelTag(arg_35_0)
	return arg_35_0._labelTagList
end

function var_0_6.AddLabelTag(arg_36_0, arg_36_1)
	table = var_1_10002

	var_1_10002.insert(arg_36_0._labelTagList, arg_36_1)

	local var_36_0

	if not arg_36_0:GetAttrByName("labelTag")[arg_36_1] then
		var_36_0 = 0
	end

	var_2[arg_36_1] = var_36_0 + 1

	return
end

function var_0_6.ContainsLabelTag(arg_37_0, arg_37_1)
	if arg_37_0._labelTagList == nil then
		return false
	end

	ipairs = var_2

	for iter_37_0, iter_37_1 in var_2(arg_37_1) do
		table = var_1_10007

		if var_1_10007.contains(arg_37_0._labelTagList, iter_37_1) then
			return true
		end
	end

	return false
end

function var_0_6.SetIFF(arg_38_0, arg_38_1)
	arg_38_0._IFF = arg_38_1

	return
end

function var_0_6.SetPosition(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0._pos

	var_2.Set(var_39_0, arg_39_1.x, arg_39_1.y, arg_39_1.z)

	return
end

function var_0_6.IsOutViewBound(arg_40_0)
	local var_40_0 = arg_40_0:GetPosition().x
	local var_40_1 = var_1.z

	if var_40_0 > arg_40_0._cameraRight or var_40_1 > arg_40_0._cameraTop or var_40_1 < arg_40_0._cameraBottom then
		return true
	end

	return
end

function var_0_6.GetDistance(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0._battleProxy.FrameIndex

	if arg_41_0._frame ~= var_41_0 then
		arg_41_0._distanceBackup = {}
		arg_41_0._frame = var_41_0
	end

	local var_41_3

	if arg_41_0._distanceBackup[arg_41_1] == nil then
		Vector3 = var_1_10004

		local var_41_1 = var_1_10004.Distance

		pg = var_1_10005

		local var_41_2 = var_1_10005.Tool.FilterY(arg_41_0:GetPosition())

		pg = var_6
		var_41_3 = var_41_1(var_41_2, var_6.Tool.FilterY(arg_41_1:GetPosition()))
		arg_41_0._distanceBackup[arg_41_1] = var_41_3

		arg_41_1:backupDistance(arg_41_0, var_41_3)
	end

	return var_41_3
end

function var_0_6.backupDistance(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0._battleProxy.FrameIndex

	if arg_42_0._frame ~= var_42_0 then
		arg_42_0._distanceBackup = {}
		arg_42_0._frame = var_42_0
	end

	arg_42_0._distanceBackup[arg_42_1] = arg_42_2

	return
end

function var_0_6.GetSkinID(arg_43_0)
	return arg_43_0._modelID
end

function var_0_6.SetSkinID(arg_44_0, arg_44_1)
	arg_44_0._skinID = arg_44_1
	arg_44_0._modelID = var_0_5.GetEquipSkin(arg_44_0._skinID)
	ipairs = var_2

	for iter_44_0, iter_44_1 in var_2(arg_44_0._weapon) do
		iter_44_1:SetDerivateSkin(arg_44_1)
	end

	return
end

function var_0_6.SetSkinData(arg_45_0, arg_45_1)
	return
end

function var_0_6.SetAttr(arg_46_0, arg_46_1)
	var_0.Battle.BattleAttr.SetAircraftAttFromMother(arg_46_0, arg_46_1)

	return
end

function var_0_6.GetAttr(arg_47_0)
	return var_0.Battle.BattleAttr.GetAttr(arg_47_0)
end

function var_0_6.GetAttrByName(arg_48_0, arg_48_1)
	return var_0.Battle.BattleAttr.GetCurrent(arg_48_0, arg_48_1)
end

function var_0_6.GetMotherUnit(arg_49_0)
	return arg_49_0._motherUnit
end

function var_0_6.GetUniqueID(arg_50_0)
	return arg_50_0._uniqueID
end

function var_0_6.GetIFF(arg_51_0)
	return arg_51_0._IFF
end

function var_0_6.GetCurrentState(arg_52_0)
	return arg_52_0._currentState
end

function var_0_6.GetVelocity(arg_53_0)
	return arg_53_0._velocity
end

function var_0_6.GetSpeed(arg_54_0)
	return arg_54_0._speed
end

function var_0_6.GetPosition(arg_55_0)
	return arg_55_0._pos
end

function var_0_6.GetBornPosition(arg_56_0)
	return nil
end

function var_0_6.GetCLDZCenterPosition(arg_57_0)
	local var_57_0 = arg_57_0
	local var_57_1 = arg_57_0.GetBoxSize(var_57_0)

	Vector3 = var_57_0

	return var_57_0(arg_57_0._pos.x, arg_57_0._pos.y, arg_57_0._pos.z + var_57_1.z)
end

function var_0_6.GetBeenAimedPosition(arg_58_0)
	local var_58_0 = arg_58_0:GetTemplate().aim_offset
	local var_58_1 = arg_58_0
	local var_58_2 = arg_58_0.GetCLDZCenterPosition(var_58_1)

	if not var_58_0 then
		return var_58_2
	end

	Vector3 = var_58_1

	return var_58_1(var_58_2.x + var_58_0[1], var_58_2.y + var_58_0[2], var_58_2.z + var_58_0[3])
end

function var_0_6.GetDirection(arg_59_0)
	return arg_59_0._dir
end

function var_0_6.GetTemplate(arg_60_0)
	return arg_60_0._tmpData
end

function var_0_6.GetTemplateID(arg_61_0)
	return arg_61_0._tmpData.id
end

function var_0_6.GetUnitType(arg_62_0)
	return arg_62_0._type
end

function var_0_6.GetHPRate(arg_63_0)
	return arg_63_0._currentHP / arg_63_0:GetMaxHP()
end

function var_0_6.GetBoxSize(arg_64_0)
	local var_64_0 = arg_64_0._cldComponent

	return var_1.GetCldBoxSize(var_64_0)
end

function var_0_6.GetSpeedRatio(arg_65_0)
	return var_0_4.GetSpeedRatio(arg_65_0:GetSpeedExemptKey(), arg_65_0._IFF)
end

function var_0_6.GetSpeedExemptKey(arg_66_0)
	return arg_66_0._speedExemptKey
end

function var_0_6.IsPlayerAircraft(arg_67_0)
	return arg_67_0._isPlayerAircraft
end

function var_0_6.IsShowHPBar(arg_68_0)
	return false
end

function var_0_6.SetUnVisitable(arg_69_0)
	var_0.Battle.BattleAttr.UnVisitable(arg_69_0)

	return
end

function var_0_6.SetVisitable(arg_70_0)
	var_0.Battle.BattleAttr.Visitable(arg_70_0)

	return
end

function var_0_6.IsVisitable(arg_71_0)
	return var_0.Battle.BattleAttr.IsVisitable(arg_71_0)
end

function var_0_6.OverrideDeadFX(arg_72_0, arg_72_1)
	arg_72_0._deadFX = arg_72_1

	return
end

function var_0_6.GetDeadFX(arg_73_0)
	return arg_73_0._deadFX
end

var_0_6.AIRCRAFT_TRIGGER = {
	var_0.Battle.BattleConst.BuffEffectType.ON_BULLET_COLLIDE_BEFORE,
	var_0.Battle.BattleConst.BuffEffectType.ON_BOMB_BULLET_BANG,
	var_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_BULLET_BANG
}

function var_0_6.TriggerBuff(arg_74_0, arg_74_1, arg_74_2)
	table = var_1_10003

	if var_1_10003.contains(var_0_6.AIRCRAFT_TRIGGER, arg_74_1) and arg_74_0._motherUnit then
		local var_74_0 = arg_74_0._motherUnit

		if var_3.IsAlive(var_74_0) then
			local var_74_1 = arg_74_0._motherUnit

			var_3.TriggerBuff(var_74_1, arg_74_1, arg_74_2)
		end
	end

	return
end

function var_0_6.AddCreateTimer(arg_75_0, arg_75_1, arg_75_2)
	arg_75_0._currentState = arg_75_0.STATE_CREATE
	arg_75_0._speedDir = arg_75_1
	arg_75_2 = arg_75_2 or 1.5

	local function var_75_0()
		arg_75_0._currentState = arg_75_0.STATE_ATTACK

		local var_76_0 = arg_75_0

		Vector3 = var_1
		var_76_0._speedDir = var_1(arg_75_0._dir, 0, 0)
		pg = var_76_0

		local var_76_1 = var_76_0.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_76_1, arg_75_0._createTimer)

		arg_75_0._createTimer = nil

		return
	end

	pg = var_1_10004

	local var_75_1 = var_1_10004.TimeMgr.GetInstance()

	arg_75_0._createTimer = var_4.AddBattleTimer(var_75_1, "AddCreateTimer", 0, arg_75_2, var_75_0)

	return
end

function var_0_6.Dispose(arg_77_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_77_0)

	return
end

function var_0_6.InitCldComponent(arg_78_0)
	local var_78_0 = arg_78_0:GetTemplate().cld_box
	local var_78_1 = arg_78_0:GetTemplate().cld_offset[1]

	if arg_78_0:GetDirection() == var_0.Battle.BattleConst.UnitDir.LEFT then
		var_78_1 = var_78_1 * -1
	end

	arg_78_0._cldComponent = var_0.Battle.BattleCubeCldComponent.New(var_78_0[1], var_78_0[2], var_78_0[3], var_78_1, var_2[3])

	local var_78_2 = {
		type = var_0_2.CldType.AIRCRAFT,
		IFF = arg_78_0:GetIFF(),
		UID = arg_78_0:GetUniqueID()
	}
	local var_78_3 = arg_78_0._cldComponent

	var_5.SetCldData(var_78_3, var_78_2)

	return
end

function var_0_6.GetCldBox(arg_79_0)
	local var_79_0 = arg_79_0._cldComponent

	return var_1.GetCldBox(var_79_0, arg_79_0:GetPosition())
end

function var_0_6.GetCldData(arg_80_0)
	local var_80_0 = arg_80_0._cldComponent

	return var_1.GetCldData(var_80_0)
end

function var_0_6.AddBuff(arg_81_0)
	return
end

function var_0_6.SetBuffStack(arg_82_0)
	return
end

function var_0_6.RemoveBuff(arg_83_0)
	return
end

function var_0_6.CloakExpose(arg_84_0)
	return
end

function var_0_6.GetCurrentOxyState(arg_85_0)
	return nil
end

function var_0_6.RemoveRemoteBoundBone(arg_86_0)
	return
end

function var_0_6.SetRemoteBoundBone(arg_87_0)
	return
end

function var_0_6.GetRemoteBoundBone(arg_88_0)
	return
end

return
