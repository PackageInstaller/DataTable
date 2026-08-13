ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleConst.AircraftUnitType
local var_0_4 = var_0.Battle.BattleConst.CharacterUnitType
local var_0_5 = var_0.Battle

singletonClass = var_0_10006
var_0_5.BattleShrapnelBulletFactory = var_0_10006("BattleShrapnelBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleShrapnelBulletFactory.__name = "BattleShrapnelBulletFactory"

local var_0_6 = var_0.Battle.BattleShrapnelBulletFactory

var_0_6.INHERIT_NONE = 0
var_0_6.INHERIT_ANGLE = 1
var_0_6.INHERIT_SPEED_NORMALIZE = 2
var_0_6.INHERIT_VELOCITY_TEMPLATE = 1
var_0_6.INHERIT_VELOCITY_CURRENT = 2
var_0_6.FRAGILE_DAMAGE_NOT_SPLIT = 1
var_0_6.FRAGILE_NOT_DAMAGE_NOT_SPLIT = 2

function var_0_6.Ctor(arg_1_0)
	var_0_6.super.Ctor(arg_1_0)

	return
end

function var_0_6.MakeBullet(arg_2_0)
	return var_0.Battle.BattleShrapnelBullet.New()
end

function var_0_6.CreateBullet(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_2:SetOutRangeCallback(arg_3_0.OutRangeFunc)

	local var_3_0 = arg_3_0:MakeBullet()

	var_6.SetFactory(var_3_0, arg_3_0)
	var_6:SetBulletData(arg_3_2)
	arg_3_0:MakeModel(var_6, arg_3_3, arg_3_4, arg_3_5)

	if arg_3_4 and arg_3_4 ~= "" then
		arg_3_0:PlayFireFX(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, nil)
	end

	if not arg_3_2:GetTemplate().extra_param.rangeAA then
		var_0_6.bulletSplit(var_6)
	end

	return var_6
end

function var_0_6.onBulletHitFunc(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_6.GetDataProxy()
	local var_4_1 = arg_4_0:GetBulletData()
	local var_4_2 = var_4.GetCurrentState(var_4_1)
	local var_4_3 = var_4:GetTemplate().extra_param.shrapnel
	local var_4_4 = var_6.extra_param.fragile
	local var_4_5 = var_6.extra_param.hitSplitOnly

	if not arg_4_1 and var_4_5 then
		var_1_10011 = var_4_0

		var_4_0.RemoveBulletUnit(var_1_10011, var_4:GetUniqueID())

		return
	end

	if var_4_4 and arg_4_1 then
		if var_4_4 == var_0_6.FRAGILE_DAMAGE_NOT_SPLIT then
			var_0.Battle.BattleCannonBulletFactory.onBulletHitFunc(arg_4_0, arg_4_1, arg_4_2)
		elseif var_4_4 == var_0_6.FRAGILE_NOT_DAMAGE_NOT_SPLIT then
			var_1_10011 = var_4_0

			var_4_0.RemoveBulletUnit(var_1_10011, var_4:GetUniqueID())
		end

		return
	end

	if var_4_2 == var_4.STATE_SPLIT or var_4_2 == var_4.STATE_SPIN then
		-- block empty
	elseif var_4_2 == var_4.STATE_FINAL_SPLIT then
		return
	else
		var_1_10011 = var_4

		local var_4_6 = var_4.GetPierceCount(var_1_10011)

		if 0 < var_4_6 then
			var_0.Battle.BattleCannonBulletFactory.onBulletHitFunc(arg_4_0, arg_4_1, arg_4_2)

			return
		end
	end

	if arg_4_1 ~= nil and arg_4_2 ~= nil then
		local var_4_7

		table = var_1_10011

		if var_1_10011.contains(var_0_3, arg_4_2) then
			local var_4_8 = var_0_6.GetSceneMediator()

			var_4_7 = var_11.GetAircraft(var_4_8, arg_4_1)
		else
			table = var_11

			if var_11.contains(var_0_4, arg_4_2) then
				local var_4_9 = var_0_6.GetSceneMediator()

				var_4_7 = var_11.GetCharacter(var_4_9, arg_4_1)
			end
		end

		local var_4_10 = var_4_7:GetUnitData()
		local var_4_11 = var_4_7:AddFX(arg_4_0:GetFXID())
		local var_4_12 = var_4_10:GetIFF()
		local var_4_13 = var_4_0

		if var_4_12 == var_4_0.GetFoeCode(var_4_13) then
			local var_4_14 = var_4_11.transform.localRotation

			Vector3 = var_4_13
			var_13.localRotation = var_4_13(var_4_14.x, 180, var_4_14.z)
		end
	end

	var_0.Battle.PlayBattleSFX(var_4:GetHitSFX())

	if var_6.extra_param.rangeAA then
		var_0_6.areaSplit(arg_4_0)
	else
		var_0_6.bulletSplit(arg_4_0, true)
	end

	return
end

function var_0_6.areaSplit(arg_5_0)
	local var_5_0 = var_0_6.GetDataProxy()
	local var_5_1 = arg_5_0:GetBulletData()
	local var_5_2 = var_2.GetWeapon(var_5_1)

	var_3.DoAreaSplit(var_5_2, var_2)
	var_5_0:RemoveBulletUnit(var_2:GetUniqueID())

	return
end

function var_0_6.bulletSplit(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetBulletData()
	local var_6_1 = var_0_6.GetDataProxy()
	local var_6_2 = var_6_0:GetTemplate().extra_param.shrapnel
	local var_6_3 = var_6_0:GetSrcHost()
	local var_6_4 = var_6_0:GetWeapon()

	if var_4.extra_param.FXID ~= nil then
		local var_6_5 = var_0_6.GetFXPool()
		local var_6_6, var_6_7 = var_8.GetFX(var_6_5, var_4.extra_param.FXID)

		pg = var_10

		local var_6_8 = var_10.EffectMgr.GetInstance()

		var_10.PlayBattleEffect(var_6_8, var_6_6, var_6_7:Add(arg_6_0:GetPosition()), true)
	end

	local var_6_9
	local var_6_10 = var_6_0:GetSpeed().x > 0 and 0 or 180

	ipairs = var_9

	for iter_6_0, iter_6_1 in var_9(var_6_2) do
		if arg_6_1 ~= iter_6_1.initialSplit then
			local var_6_11 = iter_6_1.barrage_ID
			local var_6_12 = iter_6_1.bullet_ID
			local var_6_13

			if not iter_6_1.emitterType then
				var_6_13 = var_0.Battle.BattleWeaponUnit.EMITTER_SHOTGUN
			end

			local var_6_14 = iter_6_1.inheritAngle
			local var_6_15 = iter_6_1.inheritSpeed
			local var_6_16 = iter_6_1.reaim
			local var_6_17 = iter_6_1.rotateOffset

			local function var_6_18(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
				local var_7_0 = var_6_1
				local var_7_1 = var_4.CreateBulletUnit
				local var_7_2 = var_6_12
				local var_7_3 = var_6_3
				local var_7_4 = var_6_4

				Vector3 = var_2_10009

				local var_7_5 = var_7_1(var_7_0, var_7_2, var_7_3, var_7_4, var_2_10009.zero)

				var_4.OverrideCorrectedDMG(var_7_5, iter_6_1.damage)
				var_4:SetOffsetPriority(arg_7_3)

				if var_6_17 then
					math = var_5

					local var_7_6 = var_5.sqrt(arg_7_0 * arg_7_0 + arg_7_1 * arg_7_1)

					math = var_6

					local var_7_7 = var_6.atan2(arg_7_1, arg_7_0)

					math = var_7

					local var_7_8 = var_7.rad
					local var_7_9 = var_6_0
					local var_7_10 = var_7_7 + var_7_8(var_8.GetYAngle(var_7_9))

					math = var_7_9

					local var_7_11 = var_7_9.abs

					math = var_2_10010

					local var_7_12 = var_7_11(var_2_10010.cos(var_7))

					math = var_2_10010
					arg_7_0 = var_7_6 * var_2_10010.cos(var_7_10) * (0.5 + 0.5 * var_7_12)
					math = var_2_10010
					arg_7_1 = var_7_6 * var_2_10010.sin(var_7_10) * (2 - var_7_12)
				end

				var_4:SetShiftInfo(arg_7_0, arg_7_1)

				local var_7_13 = var_6_10

				if var_6_14 == var_0_6.INHERIT_ANGLE then
					local var_7_14 = var_6_0

					var_7_13 = var_6.GetYAngle(var_7_14)
				elseif var_6_14 == var_0_6.INHERIT_SPEED_NORMALIZE then
					local var_7_15 = var_6_0

					var_7_13 = var_6.GetCurrentYAngle(var_7_15)
				end

				if var_6_16 then
					local var_7_16
					local var_7_17 = var_6_0
					local var_7_18 = var_7.GetWeapon(var_7_17)
					local var_7_19 = var_7.GetHost(var_7_18)

					type = var_7_18

					if var_7_18(var_6_16) == "table" and var_7_19 then
						local var_7_20 = iter_6_1.reaimParam
						local var_7_21

						ipairs = var_2_10010

						for iter_7_0, iter_7_1 in var_2_10010(var_6_16) do
							var_7_21 = var_0.Battle.BattleTargetChoise[iter_7_1](var_7_19, var_7_20, var_7_21)
						end

						var_7_16 = var_7_21[1]
					else
						var_7_16 = var_0.Battle.BattleTargetChoise.TargetHarmNearest(var_6_0)[1]
					end

					if var_7_16 == nil then
						var_4:SetRotateInfo(nil, var_7_13, arg_7_2)
					else
						var_4:SetRotateInfo(var_7_16:GetBeenAimedPosition(), var_7_13, arg_7_2)
					end
				else
					var_4:SetRotateInfo(nil, var_7_13, arg_7_2)
				end

				if var_6_15 == var_0_6.INHERIT_VELOCITY_TEMPLATE then
					local var_7_22 = var_4
					local var_7_23 = var_4.ResetVelocity
					local var_7_24 = var_6_0

					var_7_23(var_7_22, var_8.GetVelocity(var_7_24))
				elseif var_6_15 == var_0_6.INHERIT_VELOCITY_CURRENT then
					local var_7_25 = var_4
					local var_7_26 = var_4.InheritSpeed
					local var_7_27 = var_6_0

					var_7_26(var_7_25, var_8.GetSpeed(var_7_27))
				end

				local var_7_28 = var_0_6.GetFactoryList()[var_4:GetTemplate().type]
				local var_7_29 = var_6.CreateBullet
				local var_7_30 = arg_6_0
				local var_7_31 = var_9.GetTf(var_7_30)
				local var_7_32 = var_4
				local var_7_33 = arg_6_0

				var_7_29(var_7_28, var_7_31, var_7_32, var_11.GetPosition(var_7_33))

				return
			end

			local var_6_19

			local function var_6_20()
				local var_8_0 = var_6_19

				var_0.Destroy(var_8_0)

				local var_8_1 = var_6_0

				var_0.SplitFinishCount(var_8_1)

				local var_8_2 = var_6_0

				if var_0.IsAllSplitFinish(var_8_2) then
					local var_8_3 = var_6_1
					local var_8_4 = var_0.RemoveBulletUnit
					local var_8_5 = var_6_0

					var_8_4(var_8_3, var_2.GetUniqueID(var_8_5))
				end

				return
			end

			var_6_19 = var_0.Battle[var_6_13].New(var_6_18, var_6_20, var_6_11)

			var_6_0:CacheChildEimtter(var_6_19)
			var_6_19:Ready()
			var_6_19:Fire(nil, var_6_4:GetDirection(), var_0.Battle.BattleDataFunction.GetBarrageTmpDataFromID(var_6_11).angle)
		end
	end

	if arg_6_1 then
		var_6_0:ChangeShrapnelState(var_0.Battle.BattleShrapnelBulletUnit.STATE_FINAL_SPLIT)
	end

	return
end

function var_0_6.onBulletMissFunc(arg_9_0)
	return
end

function var_0_6.MakeModel(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_1:GetBulletData()
	local var_10_1 = arg_10_0:GetBulletPool()

	if not var_6.InstBullet(var_10_1, arg_10_1:GetModleID(), function(arg_11_0)
		local var_11_0 = arg_10_1

		var_1.AddModel(var_11_0, arg_11_0)

		return
	end) then
		local var_10_2 = arg_10_1
		local var_10_3 = arg_10_1.AddTempModel
		local var_10_4 = arg_10_0:GetTempGOPool()

		var_10_3(var_10_2, var_9.GetObject(var_10_4))
	end

	arg_10_1:SetSpawn(arg_10_2)
	arg_10_1:SetFXFunc(arg_10_0.onBulletHitFunc, arg_10_0.onBulletMissFunc)

	local var_10_5 = arg_10_0:GetSceneMediator()

	var_7.AddBullet(var_10_5, arg_10_1)

	return
end

function var_0_6.OutRangeFunc(arg_12_0)
	if arg_12_0:IsOutRange() then
		arg_12_0:ChangeShrapnelState(var_0.Battle.BattleShrapnelBulletUnit.STATE_SPIN)
	else
		arg_12_0:ChangeShrapnelState(var_0.Battle.BattleShrapnelBulletUnit.STATE_SPLIT)
	end

	return
end

return
