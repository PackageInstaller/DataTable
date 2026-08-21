ys = ys or {}

local var_0_1 = class("BattleBombWeaponUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleBombWeaponUnit = var_0_1
var_0_1.__name = "BattleBombWeaponUnit"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0._alertCache = {}
	arg_1_0._cacheList = {}

	return
end

function var_0_1.Clear(arg_2_0)
	if arg_2_0._alertTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_2_0._alertTimer)
	end

	arg_2_0._alertTimer = nil

	for iter_2_0, iter_2_1 in pairs(arg_2_0._cacheList) do
		iter_2_1:Destroy()
	end

	var_0_1._cacheList = nil

	var_0_1.super.Clear(arg_2_0)

	return
end

function var_0_1.HostOnEnemy(arg_3_0)
	var_0_1.super.HostOnEnemy(arg_3_0)

	if arg_3_0._preCastInfo.alertTime ~= nil then
		arg_3_0._showPrecastAlert = true

		local var_3_0 = arg_3_0._preCastInfo.alertTime or 3

		arg_3_0._alertTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, var_3_0, function()
			arg_3_0._alertTimer:Stop()
			arg_3_0:Fire()

			return
		end, true, true)
	end

	return
end

function var_0_1.Update(arg_5_0, arg_5_1)
	arg_5_0:UpdateReload()

	if arg_5_0._currentState == arg_5_0.STATE_READY then
		arg_5_0:updateMovementInfo()

		local var_5_0 = arg_5_0:Tracking()

		if var_5_0 then
			if arg_5_0._showPrecastAlert then
				arg_5_0:PreCast(var_5_0)
			else
				arg_5_0._currentState = arg_5_0.STATE_PRECAST_FINISH
			end
		end
	end

	if arg_5_0._currentState == arg_5_0.STATE_PRECAST_FINISH then
		arg_5_0:updateMovementInfo()

		local var_5_1 = arg_5_0:Tracking()
		local var_5_2 = arg_5_0:GetDirection()
		local var_5_3 = arg_5_0:GetAttackAngle()

		for iter_5_0, iter_5_1 in ipairs(arg_5_0._majorEmitterList) do
			iter_5_1:Ready()
		end

		for iter_5_2, iter_5_3 in ipairs(arg_5_0._majorEmitterList) do
			iter_5_3:Fire(var_5_1, var_5_2, var_5_3)
		end

		var_0_1.super.Fire(arg_5_0, var_5_1)
	end

	return
end

function var_0_1.PreCast(arg_6_0, arg_6_1)
	arg_6_0:cacheBulletID()

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._majorEmitterList) do
		iter_6_1:Ready()
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._majorEmitterList) do
		iter_6_3:Fire(arg_6_1, arg_6_0:GetDirection(), arg_6_0:GetAttackAngle())
	end

	var_0_1.super.PreCast(arg_6_0)
	arg_6_0._alertTimer:Start()

	return
end

function var_0_1.AddPreCastTimer(arg_7_0)
	arg_7_0._precastTimer = pg.TimeMgr.GetInstance():AddBattleTimer("weaponPrecastTimer", 0, arg_7_0._preCastInfo.time, function()
		arg_7_0._currentState = arg_7_0.STATE_OVER_HEAT

		arg_7_0:RemovePrecastTimer()
		arg_7_0._host:SetWeaponPreCastBound(false)
		arg_7_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.WEAPON_PRE_CAST_FINISH, arg_7_0._preCastInfo)))

		return
	end, true)

	return
end

function var_0_1.createMajorEmitter(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = {}
	local var_9_2 = var_0.Battle.BattleBulletEmitter.New(function()
		arg_9_0:DispatchBulletEvent(table.remove(var_9_0, 1))

		return
	end, function()
		for iter_11_0, iter_11_1 in ipairs(arg_9_0._cacheList) do
			if iter_11_1:GetState() ~= iter_11_1.STATE_STOP then
				return
			end
		end

		arg_9_0:EnterCoolDown()

		return
	end, arg_9_1)

	arg_9_0._cacheList[var_9_2] = var_9_2

	var_0_1.super.createMajorEmitter(arg_9_0, arg_9_1, arg_9_2, nil, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		local var_12_0 = arg_9_0:Spawn(arg_9_0._emitBulletIDList[arg_9_2], arg_12_4)

		var_12_0:SetOffsetPriority(arg_12_3)
		var_12_0:SetShiftInfo(arg_12_0, arg_12_1)

		if arg_9_0._tmpData.aim_type == var_0.Battle.BattleConst.WeaponAimType.AIM and arg_12_4 ~= nil then
			var_12_0:SetRotateInfo(arg_12_4:GetBeenAimedPosition(), arg_9_0:GetBaseAngle(), arg_12_2)
		else
			var_12_0:SetRotateInfo(nil, arg_9_0:GetBaseAngle(), arg_12_2)
		end

		table.insert(var_9_0, var_12_0)
		arg_9_0:showBombAlert(var_12_0)

		return
	end, function()
		return
	end)

	return
end

function var_0_1.DoAttack(arg_14_0)
	arg_14_0:TriggerBuffOnSteday()

	for iter_14_0, iter_14_1 in pairs(arg_14_0._cacheList) do
		iter_14_1:Ready()
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0._cacheList) do
		iter_14_3:Fire(nil, arg_14_0:GetDirection())
	end

	var_0.Battle.PlayBattleSFX(arg_14_0._tmpData.fire_sfx)
	arg_14_0:TriggerBuffOnFire()
	arg_14_0:CheckAndShake()

	return
end

function var_0_1.showBombAlert(arg_15_0, arg_15_1)
	arg_15_1:SetExist(false)

	if arg_15_1:GetTemplate().alert_fx ~= "" then
		var_0.Battle.BattleBombBulletFactory.CreateBulletAlert(arg_15_1)
	end

	return
end

return
