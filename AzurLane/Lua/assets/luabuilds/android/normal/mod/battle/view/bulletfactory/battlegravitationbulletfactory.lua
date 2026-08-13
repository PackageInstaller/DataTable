ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

singletonClass = var_0_10002
var_0_1.BattleGravitationBulletFactory = var_0_10002("BattleGravitationBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleGravitationBulletFactory.__name = "BattleGravitationBulletFactory"

local var_0_2 = var_0.Battle.BattleGravitationBulletFactory

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.MakeBullet(arg_2_0)
	return var_0.Battle.BattleTorpedoBullet.New()
end

function var_0_2.onBulletHitFunc(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetBulletData()

	if var_3.GetPierceCount(var_3_0) <= 0 then
		return
	end

	local var_3_1 = var_3:GetTemplate().hit_type
	local var_3_2 = var_0_2.GetDataProxy()
	local var_3_3 = arg_3_0:GetBulletData()
	local var_3_4 = var_7.GetTemplate(var_3_3)

	var_0.Battle.PlayBattleSFX(var_7:GetHitSFX())

	local var_3_5 = var_7:GetDiveFilter()
	local var_3_6 = var_7:GetPosition()
	local var_3_7 = var_10.Clone(var_3_6)
	local var_3_8 = var_7:GetTemplate().extra_param.buff_id
	local var_3_9

	if not var_11.buff_level then
		var_3_9 = 1
	end

	local function var_3_10(arg_4_0)
		local var_4_0 = var_0

		if var_1.CanDealDamage(var_4_0) then
			ipairs = var_1

			for iter_4_0, iter_4_1 in var_1(arg_4_0) do
				if iter_4_1.Active then
					local var_4_1 = var_0_2
					local var_4_2 = var_6.GetSceneMediator(var_4_1)
					local var_4_3 = var_6.GetCharacter(var_4_2, iter_4_1.UID)
					local var_4_4 = var_6.GetUnitData(var_4_3)
					local var_4_5 = var_0.Battle.BattleBuffUnit.New(var_3_8, var_3_9)
					local var_4_6 = var_4_4

					var_4_4.AddBuff(var_4_6, var_4_5)

					if not var_0.noIntervalDMG then
						var_4_6 = var_3_2

						var_8.HandleDamage(var_4_6, var_0, var_4_4)
					end

					local var_4_7

					if not var_0.force then
						var_4_7 = 0.1
					end

					pg = var_4_6

					if var_4_7 > var_4_6.Tool.FilterY(var_3_7 - var_4_4:GetPosition()).magnitude then
						var_4_4:SetUncontrollableSpeed(var_9, 0.001, 1e-06)
					else
						var_4_4:SetUncontrollableSpeed(var_9, var_4_7, 1e-07)
					end
				end
			end

			local var_4_8 = var_0

			var_1.DealDamage(var_4_8)
		end

		return
	end

	local function var_3_11(arg_5_0)
		if arg_5_0.Active then
			local var_5_0 = var_0_2
			local var_5_1 = var_1.GetSceneMediator(var_5_0)
			local var_5_2 = var_1.GetCharacter(var_5_1, arg_5_0.UID)
			local var_5_3 = var_1.GetUnitData(var_5_2)

			var_1.ClearUncontrollableSpeed(var_5_3)
			var_1:RemoveBuff(var_3_8)
		end

		return
	end

	local function var_3_12(arg_6_0)
		local var_6_0 = var_0.exploDMG
		local var_6_1 = var_0.knockBack

		ipairs = var_2_10003

		for iter_6_0, iter_6_1 in var_2_10003(arg_6_0) do
			if iter_6_1.Active then
				local var_6_2 = var_0_2
				local var_6_3 = var_8.GetSceneMediator(var_6_2)
				local var_6_4 = var_8.GetCharacter(var_6_3, iter_6_1.UID)
				local var_6_5 = var_8.GetUnitData(var_6_4)
				local var_6_6 = false
				local var_6_7 = var_6_5
				local var_6_8 = var_6_5.GetCurrentOxyState(var_6_7)

				ipairs = var_6_7

				for iter_6_2, iter_6_3 in var_6_7(var_3_5) do
					if var_6_8 == iter_6_3 then
						var_6_6 = true
					end
				end

				if not var_6_6 then
					local var_6_9 = var_3_2

					var_11.HandleDirectDamage(var_6_9, var_6_5, var_6_0, var_0)

					if var_6_5:IsAlive() then
						pg = var_11

						local var_6_10 = var_11.Tool.FilterY(var_6_5:GetPosition() - var_3_7)

						if var_6_1 ~= false then
							var_6_5:SetUncontrollableSpeed(var_6_10, 1, 0.2, 6)
						end

						var_6_5:RemoveBuff(var_3_8)
					end
				end
			end
		end

		local var_6_11 = var_0_2.GetFXPool()
		local var_6_12 = var_3.GetFX
		local var_6_13 = arg_3_0
		local var_6_14, var_6_15 = var_6_12(var_6_11, var_5.GetMissFXID(var_6_13))

		pg = var_5

		local var_6_16 = var_5.EffectMgr.GetInstance()

		var_5.PlayBattleEffect(var_6_16, var_6_14, var_6_15:Add(var_3_7), true)

		local var_6_17 = var_3_2
		local var_6_18 = var_5.RemoveBulletUnit
		local var_6_19 = var_0

		var_6_18(var_6_17, var_7.GetUniqueID(var_6_19))

		return
	end

	local var_3_13 = var_3_2
	local var_3_14 = var_3_2.SpawnLastingColumnArea
	local var_3_15 = var_7:GetEffectField()
	local var_3_16 = var_7
	local var_3_17 = var_7.GetIFF(var_3_16)

	pg = var_3_16

	local var_3_18 = var_3_14(var_3_13, var_3_15, var_3_17, var_3_16.Tool.FilterY(var_3_7), var_3_1.range, var_3_1.time, var_3_10, var_3_11, false, arg_3_0:GetFXID(), var_3_12, true)

	var_17.SetDiveFilter(var_3_18, var_3_5)

	return
end

function var_0_2.onBulletMissFunc(arg_7_0)
	var_0_2.onBulletHitFunc(arg_7_0)

	return
end

function var_0_2.MakeModel(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:GetBulletData()
	local var_8_1 = var_3.GetTemplate(var_8_0)
	local var_8_2 = arg_8_0:GetDataProxy()
	local var_8_3 = arg_8_0:GetBulletPool()

	if not var_6.InstBullet(var_8_3, arg_8_1:GetModleID(), function(arg_9_0)
		local var_9_0 = arg_8_1

		var_1.AddModel(var_9_0, arg_9_0)

		return
	end) then
		local var_8_4 = arg_8_1
		local var_8_5 = arg_8_1.AddTempModel
		local var_8_6 = arg_8_0:GetTempGOPool()

		var_8_5(var_8_4, var_9.GetObject(var_8_6))
	end

	arg_8_1:SetSpawn(arg_8_2)
	arg_8_1:SetFXFunc(arg_8_0.onBulletHitFunc, arg_8_0.onBulletMissFunc)

	local var_8_7 = arg_8_0:GetSceneMediator()

	var_7.AddBullet(var_8_7, arg_8_1)

	if var_3:GetIFF() ~= var_8_2:GetFriendlyCode() and var_8_1.alert_fx ~= "" then
		local var_8_8 = arg_8_1
		local var_8_9 = arg_8_1.MakeAlert
		local var_8_10 = arg_8_0:GetFXPool()

		var_8_9(var_8_8, var_9.GetFX(var_8_10, var_8_1.alert_fx))
	end

	return
end

return
