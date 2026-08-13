ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

class = var_0_10002

local var_0_2 = var_0_10002("BattleBombWeaponUnit", var_0.Battle.BattleWeaponUnit)

var_0.Battle.BattleBombWeaponUnit = var_0_2
var_0_2.__name = "BattleBombWeaponUnit"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	arg_1_0._alertCache = {}
	arg_1_0._cacheList = {}

	return
end

function var_0_2.Clear(arg_2_0)
	if arg_2_0._alertTimer then
		pg = var_1

		local var_2_0 = var_1.TimeMgr.GetInstance()

		var_1.RemoveBattleTimer(var_2_0, arg_2_0._alertTimer)
	end

	arg_2_0._alertTimer = nil
	pairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0._cacheList) do
		iter_2_1:Destroy()
	end

	var_0_2._cacheList = nil

	var_0_2.super.Clear(arg_2_0)

	return
end

function var_0_2.HostOnEnemy(arg_3_0)
	var_0_2.super.HostOnEnemy(arg_3_0)

	if arg_3_0._preCastInfo.alertTime ~= nil then
		arg_3_0._showPrecastAlert = true

		local function var_3_0()
			local var_4_0 = arg_3_0._alertTimer

			var_0.Stop(var_4_0)

			local var_4_1 = arg_3_0

			var_0.Fire(var_4_1)

			return
		end

		pg = var_2

		local var_3_1 = var_2.TimeMgr.GetInstance()
		local var_3_2 = var_2.AddBattleTimer
		local var_3_3 = ""
		local var_3_4 = -1
		local var_3_5

		if not arg_3_0._preCastInfo.alertTime then
			var_3_5 = 3
		end

		arg_3_0._alertTimer = var_3_2(var_3_1, var_3_3, var_3_4, var_3_5, var_3_0, true, true)
	end

	return
end

function var_0_2.Update(arg_5_0, arg_5_1)
	arg_5_0:UpdateReload()

	if arg_5_0._currentState == arg_5_0.STATE_READY then
		arg_5_0:updateMovementInfo()

		if arg_5_0:Tracking() then
			if arg_5_0._showPrecastAlert then
				arg_5_0:PreCast(var_2)
			else
				arg_5_0._currentState = arg_5_0.STATE_PRECAST_FINISH
			end
		end
	end

	if arg_5_0._currentState == arg_5_0.STATE_PRECAST_FINISH then
		arg_5_0:updateMovementInfo()

		local var_5_0 = arg_5_0:Tracking()
		local var_5_1 = arg_5_0:GetDirection()
		local var_5_2 = arg_5_0
		local var_5_3 = arg_5_0.GetAttackAngle(var_5_2)

		ipairs = var_5_2

		for iter_5_0, iter_5_1 in var_5_2(arg_5_0._majorEmitterList) do
			iter_5_1:Ready()
		end

		ipairs = var_5

		for iter_5_2, iter_5_3 in var_5(arg_5_0._majorEmitterList) do
			iter_5_3:Fire(var_5_0, var_5_1, var_5_3)
		end

		var_0_2.super.Fire(arg_5_0, var_5_0)
	end

	return
end

function var_0_2.PreCast(arg_6_0, arg_6_1)
	arg_6_0:cacheBulletID()

	ipairs = var_2

	for iter_6_0, iter_6_1 in var_2(arg_6_0._majorEmitterList) do
		iter_6_1:Ready()
	end

	ipairs = var_2

	for iter_6_2, iter_6_3 in var_2(arg_6_0._majorEmitterList) do
		iter_6_3:Fire(arg_6_1, arg_6_0:GetDirection(), arg_6_0:GetAttackAngle())
	end

	var_0_2.super.PreCast(arg_6_0)

	local var_6_0 = arg_6_0._alertTimer

	var_2.Start(var_6_0)

	return
end

function var_0_2.AddPreCastTimer(arg_7_0)
	local function var_7_0()
		arg_7_0._currentState = arg_7_0.STATE_OVER_HEAT

		local var_8_0 = arg_7_0

		var_0.RemovePrecastTimer(var_8_0)

		local var_8_1 = arg_7_0._preCastInfo
		local var_8_2 = var_0.Event.New(var_0.Battle.BattleUnitEvent.WEAPON_PRE_CAST_FINISH, var_8_1)
		local var_8_3 = arg_7_0._host

		var_2.SetWeaponPreCastBound(var_8_3, false)

		local var_8_4 = arg_7_0

		var_2.DispatchEvent(var_8_4, var_8_2)

		return
	end

	pg = var_1_10002

	local var_7_1 = var_1_10002.TimeMgr.GetInstance()

	arg_7_0._precastTimer = var_2.AddBattleTimer(var_7_1, "weaponPrecastTimer", 0, arg_7_0._preCastInfo.time, var_7_0, true)

	return
end

function var_0_2.createMajorEmitter(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = {}
	local var_9_1

	local function var_9_2()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.DispatchBulletEvent

		table = var_2_10002

		var_10_1(var_10_0, var_2_10002.remove(var_9_0, 1))

		return
	end

	local var_9_3

	local function var_9_4()
		ipairs = var_2_10000

		for iter_11_0, iter_11_1 in var_2_10000(arg_9_0._cacheList) do
			if iter_11_1:GetState() ~= iter_11_1.STATE_STOP then
				return
			end
		end

		local var_11_0 = arg_9_0

		var_0.EnterCoolDown(var_11_0)

		return
	end

	local var_9_5 = var_0.Battle.BattleBulletEmitter.New(var_9_2, var_9_4, arg_9_1)

	arg_9_0._cacheList[var_9_5] = var_9_5

	local function var_9_6(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		local var_12_0 = arg_9_0._emitBulletIDList[arg_9_2]
		local var_12_1 = arg_9_0
		local var_12_2 = var_6.Spawn(var_12_1, var_12_0, arg_12_4)

		var_6.SetOffsetPriority(var_12_2, arg_12_3)
		var_6:SetShiftInfo(arg_12_0, arg_12_1)

		local var_12_4

		if arg_9_0._tmpData.aim_type == var_0.Battle.BattleConst.WeaponAimType.AIM and arg_12_4 ~= nil then
			local var_12_3 = var_6

			var_12_4 = var_6.SetRotateInfo

			local var_12_5 = arg_12_4:GetBeenAimedPosition()
			local var_12_6 = arg_9_0

			var_12_4(var_12_3, var_12_5, var_10.GetBaseAngle(var_12_6), arg_12_2)
		else
			local var_12_7 = var_6

			var_12_4 = var_6.SetRotateInfo

			local var_12_8
			local var_12_9 = arg_9_0

			var_12_4(var_12_7, var_12_8, var_10.GetBaseAngle(var_12_9), arg_12_2)
		end

		table = var_12_4

		var_12_4.insert(var_9_0, var_6)

		local var_12_10 = arg_9_0

		var_7.showBombAlert(var_12_10, var_6)

		return
	end

	local function var_9_7()
		return
	end

	var_0_2.super.createMajorEmitter(arg_9_0, arg_9_1, arg_9_2, nil, var_9_6, var_9_7)

	return
end

function var_0_2.DoAttack(arg_14_0)
	arg_14_0:TriggerBuffOnSteday()

	pairs = var_1

	for iter_14_0, iter_14_1 in var_1(arg_14_0._cacheList) do
		iter_14_1:Ready()
	end

	pairs = var_1

	for iter_14_2, iter_14_3 in var_1(arg_14_0._cacheList) do
		iter_14_3:Fire(nil, arg_14_0:GetDirection())
	end

	var_0.Battle.PlayBattleSFX(arg_14_0._tmpData.fire_sfx)
	arg_14_0:TriggerBuffOnFire()
	arg_14_0:CheckAndShake()

	return
end

function var_0_2.showBombAlert(arg_15_0, arg_15_1)
	arg_15_1:SetExist(false)

	if arg_15_1:GetTemplate().alert_fx ~= "" then
		var_0.Battle.BattleBombBulletFactory.CreateBulletAlert(arg_15_1)
	end

	return
end

return
