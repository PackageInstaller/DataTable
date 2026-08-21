ys = ys or {}

local var_0_0 = ys.Battle.BattleDataFunction
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleConfig
local var_0_3 = class("BattleLaserUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleLaserUnit = var_0_3
var_0_3.__name = "BattleLaserUnit"
var_0_3.STATE_ATTACK = "FIB"
var_0_3.BEAM_STATE_READY = "beamStateReady"
var_0_3.BEAM_STATE_OVER_HEAT = "beamStateOverHeat"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.Clear(arg_2_0)
	if arg_2_0._alertTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_2_0._alertTimer)
	end

	arg_2_0._alertTimer = nil

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._beamList) do
		if iter_2_1:GetBeamState() == iter_2_1.BEAM_STATE_ATTACK then
			local var_2_0 = iter_2_1:GetAoeData()

			arg_2_0._dataProxy:RemoveAreaOfEffect(var_2_0:GetUniqueID())
		end

		iter_2_1:ClearBeam()
	end

	var_0_3.super.Clear(arg_2_0)

	return
end

function var_0_3.Update(arg_3_0)
	arg_3_0:UpdateReload()

	if arg_3_0._currentState == arg_3_0.STATE_READY then
		arg_3_0:updateMovementInfo()

		local var_3_0 = arg_3_0:Tracking()

		if var_3_0 then
			if arg_3_0._preCastInfo.time ~= nil then
				arg_3_0:PreCast(var_3_0)
			else
				arg_3_0._currentState = arg_3_0.STATE_PRECAST_FINISH
			end
		end
	end

	if arg_3_0._currentState == arg_3_0.STATE_PRECAST then
		-- block empty
	elseif arg_3_0._currentState == arg_3_0.STATE_PRECAST_FINISH then
		arg_3_0:updateMovementInfo()
		arg_3_0:Fire(arg_3_0:Tracking())
	end

	if arg_3_0._attackStartTime then
		arg_3_0:updateMovementInfo()
		arg_3_0:updateBeamList()
	end

	return
end

function var_0_3.DoAttack(arg_4_0, arg_4_1)
	if arg_4_1 == nil or not arg_4_1:IsAlive() or arg_4_0:outOfFireRange(arg_4_1) then
		arg_4_1 = nil
	end

	arg_4_0._attackStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	if arg_4_0._tmpData.aim_type == var_0_1.WeaponAimType.AIM and arg_4_1 ~= nil then
		arg_4_0._aimPos = arg_4_1:GetBeenAimedPosition()
	end

	arg_4_0:cacheBulletID()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._beamList) do
		iter_4_1:ChangeBeamState(iter_4_1.BEAM_STATE_READY)

		if var_0_0.GetBarrageTmpDataFromID(iter_4_1:GetBeamInfoID()).first_delay == 0 then
			arg_4_0:createBeam(iter_4_1)
		end
	end

	var_0.Battle.PlayBattleSFX(arg_4_0._tmpData.fire_sfx)
	arg_4_0:TriggerBuffOnFire()
	arg_4_0:CheckAndShake()

	return
end

function var_0_3.SetTemplateData(arg_5_0, arg_5_1)
	var_0_3.super.SetTemplateData(arg_5_0, arg_5_1)
	arg_5_0:initBeamList()

	return
end

function var_0_3.initBeamList(arg_6_0)
	arg_6_0._alertList = {}
	arg_6_0._beamList = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._tmpData.bullet_ID) do
		arg_6_0._beamList[iter_6_0] = var_0.Battle.BattleBeamUnit.New(iter_6_1, arg_6_0._tmpData.barrage_ID[iter_6_0])
	end

	return
end

function var_0_3.updateBeamList(arg_7_0)
	local var_7_0 = pg.TimeMgr.GetInstance():GetCombatTime() - arg_7_0._attackStartTime
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._beamList) do
		if iter_7_1:GetBeamState() == iter_7_1.BEAM_STATE_READY then
			if var_7_0 > var_0_0.GetBarrageTmpDataFromID(iter_7_1:GetBeamInfoID()).first_delay then
				arg_7_0:createBeam(iter_7_1)
			end
		elseif iter_7_1:GetBeamState() == iter_7_1.BEAM_STATE_ATTACK then
			if not iter_7_1:IsBeamActive() then
				iter_7_1:ClearBeam()

				var_7_1 = var_7_1 + 1
			else
				iter_7_1:UpdateBeamPos(arg_7_0._hostPos)
				iter_7_1:UpdateBeamAngle()

				if iter_7_1:CanDealDamage() then
					arg_7_0:doBeamDamage(iter_7_1)
				end
			end
		elseif iter_7_1:GetBeamState() == iter_7_1.BEAM_STATE_FINISH then
			var_7_1 = var_7_1 + 1
		end
	end

	if var_7_1 == #arg_7_0._beamList then
		arg_7_0:EnterCoolDown()
	end

	return
end

function var_0_3.createBeam(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.GetBarrageTmpDataFromID(arg_8_1:GetBeamInfoID())
	local var_8_1 = arg_8_0._host:GetIFF()
	local var_8_2 = Vector3(arg_8_0._hostPos.x + var_8_0.offset_x, 0, arg_8_0._hostPos.z + var_8_0.offset_z)
	local var_8_3 = arg_8_0._dataProxy:SpawnLastingCubeArea(var_0_1.AOEField.SURFACE, var_8_1, var_8_2, var_8_0.delta_offset_x, var_8_0.delta_offset_z, var_8_0.delay, function(arg_9_0)
		for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
			if iter_9_1.Active then
				arg_8_1:AddCldUnit(arg_8_0._dataProxy:GetUnitList()[iter_9_1.UID])
			end
		end

		return
	end, function(arg_10_0)
		if arg_10_0.Active then
			arg_8_1:RemoveCldUnit(arg_8_0._dataProxy:GetUnitList()[arg_10_0.UID])
		end

		return
	end, false, var_0_0.GetBulletTmpDataFromID(arg_8_1:GetBulletID()).modle_ID)

	if arg_8_0._aimPos == nil then
		arg_8_1:SetAimAngle(0)
	elseif var_8_0.offset_prioritise then
		arg_8_1:SetAimPosition(arg_8_0._aimPos, var_8_2, var_8_1)
	else
		local var_8_4

		if var_8_1 == var_0_2.FRIENDLY_CODE then
			var_8_4 = math.rad2Deg * math.atan2(arg_8_0._aimPos.z - arg_8_0._hostPos.z, arg_8_0._aimPos.x - arg_8_0._hostPos.x)
		elseif var_8_1 == var_0_2.FOE_CODE then
			var_8_4 = math.rad2Deg * math.atan2(arg_8_0._hostPos.z - arg_8_0._aimPos.z, arg_8_0._hostPos.x - arg_8_0._aimPos.x)
		end

		arg_8_1:SetAimAngle(var_8_4)
	end

	if var_8_1 == var_0_2.FRIENDLY_CODE then
		var_8_3:SetAnchorPointAlignment(var_8_3.ALIGNMENT_LEFT)
	elseif var_8_1 == var_0_2.FOE_CODE then
		var_8_3:SetAnchorPointAlignment(var_8_3.ALIGNMENT_RIGHT)
	end

	var_8_3:SetFXStatic(true)
	arg_8_1:SetAoeData(var_8_3)
	arg_8_1:BeginFocus()
	arg_8_1:ChangeBeamState(arg_8_1.BEAM_STATE_ATTACK)

	return
end

function var_0_3.doBeamDamage(arg_11_0, arg_11_1)
	arg_11_1:DealDamage()

	local var_11_0 = arg_11_0:Spawn(arg_11_1:GetBulletID())

	for iter_11_0, iter_11_1 in pairs((arg_11_1:GetCldUnitList())) do
		if not iter_11_1:IsAlive() or arg_11_1:GetBeamExtraParam().mainFilter == true and iter_11_1:IsMainFleetUnit() then
			-- block empty
		else
			arg_11_0._dataProxy:HandleDamage(var_11_0, iter_11_1)

			local var_11_1, var_11_2 = var_0.Battle.BattleFXPool.GetInstance():GetFX(arg_11_1:GetFXID())

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_11_1, var_11_2:Add(iter_11_1:GetPosition()), true)
			var_0.Battle.PlayBattleSFX(arg_11_1:GetSFXID())
		end
	end

	arg_11_0._dataProxy:RemoveBulletUnit(var_11_0:GetUniqueID())

	return
end

function var_0_3.EnterCoolDown(arg_12_0)
	arg_12_0._attackStartTime = nil

	var_0_3.super.EnterCoolDown(arg_12_0)

	return
end

return
