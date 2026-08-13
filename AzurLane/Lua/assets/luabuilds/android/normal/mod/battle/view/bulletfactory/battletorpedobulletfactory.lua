ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

singletonClass = var_0_10002
var_0_1.BattleTorpedoBulletFactory = var_0_10002("BattleTorpedoBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleTorpedoBulletFactory.__name = "BattleTorpedoBulletFactory"

local var_0_2 = var_0.Battle.BattleTorpedoBulletFactory

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.MakeBullet(arg_2_0)
	return var_0.Battle.BattleTorpedoBullet.New()
end

function var_0_2.onBulletHitFunc(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetBulletData()
	local var_3_1 = var_3.GetTemplate(var_3_0).hit_type
	local var_3_2 = var_0_2.GetDataProxy()
	local var_3_3 = arg_3_0:GetBulletData()
	local var_3_4 = var_7.GetTemplate(var_3_3)

	var_0.Battle.PlayBattleSFX(var_7:GetHitSFX())

	local var_3_5 = {
		_bullet = var_7
	}
	local var_3_6 = var_7:GetWeapon()

	var_3_5.equipIndex = var_10.GetEquipmentIndex(var_3_6)
	var_3_5.bulletTag = var_7:GetExtraTag()

	var_7:BuffTrigger(var_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_BULLET_BANG, var_3_5)

	local var_3_7 = var_7:GetDiveFilter()
	local var_3_8

	local function var_3_9(arg_4_0)
		if var_3_1.decay then
			local var_4_0 = var_3_8

			var_2_10002.UpdateDistanceInfo(var_4_0)
		end

		ipairs = var_2_10002

		for iter_4_0, iter_4_1 in var_2_10002(arg_4_0) do
			if iter_4_1.Active then
				local var_4_1 = iter_4_1.UID
				local var_4_2 = 0

				if var_1 then
					local var_4_3 = var_3_8

					var_4_2 = var_9.GetDistance(var_4_3, var_4_1) / (var_3_1.range * 0.5) * var_1
				end

				local var_4_4 = var_0_2
				local var_4_5 = var_9.GetSceneMediator(var_4_4)
				local var_4_6 = var_9.GetCharacter(var_4_5, var_4_1)
				local var_4_7 = var_9.GetUnitData(var_4_6)
				local var_4_8 = var_3_2

				var_10.HandleDamage(var_4_8, var_0, var_4_7, var_4_2)
			end
		end

		return
	end

	if var_3_1.range then
		local var_3_10 = var_3_2
		local var_3_11 = var_3_2.SpawnColumnArea
		local var_3_12 = var_7:GetEffectField()
		local var_3_13 = var_7
		local var_3_14 = var_7.GetIFF(var_3_13)

		pg = var_3_13

		local var_3_15 = var_3_13.Tool.FilterY
		local var_3_16 = arg_3_0:GetPosition()

		var_3_8 = var_3_11(var_3_10, var_3_12, var_3_14, var_3_15(var_18.Clone(var_3_16)), var_3_1.range, var_3_1.time, var_3_9)
	else
		local var_3_17 = var_3_2
		local var_3_18 = var_3_2.SpawnCubeArea
		local var_3_19 = var_7:GetEffectField()
		local var_3_20 = var_7
		local var_3_21 = var_7.GetIFF(var_3_20)

		pg = var_3_20

		local var_3_22 = var_3_20.Tool.FilterY
		local var_3_23 = arg_3_0:GetPosition()

		var_3_8 = var_3_18(var_3_17, var_3_19, var_3_21, var_3_22(var_18.Clone(var_3_23)), var_3_1.width, var_3_1.height, var_3_1.time, var_3_9)
	end

	var_3_8:SetDiveFilter(var_3_7)

	local var_3_24 = var_0_2.GetFXPool()
	local var_3_25, var_3_26 = var_13.GetFX(var_3_24, arg_3_0:GetFXID())
	local var_3_27 = arg_3_0
	local var_3_28 = arg_3_0.GetTf(var_3_27).localPosition

	pg = var_3_27

	local var_3_29 = var_3_27.EffectMgr.GetInstance()

	var_16.PlayBattleEffect(var_3_29, var_3_25, var_3_26:Add(var_3_28), true)

	if var_7:GetPierceCount() <= 0 then
		var_3_2:RemoveBulletUnit(var_7:GetUniqueID())
	end

	return
end

function var_0_2.onBulletMissFunc(arg_5_0)
	var_0_2.onBulletHitFunc(arg_5_0)

	return
end

function var_0_2.MakeModel(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:GetBulletData()
	local var_6_1 = var_3.GetTemplate(var_6_0)
	local var_6_2 = arg_6_0:GetDataProxy()
	local var_6_3 = arg_6_0:GetBulletPool()

	if not var_6.InstBullet(var_6_3, arg_6_1:GetModleID(), function(arg_7_0)
		local var_7_0 = arg_6_1

		var_1.AddModel(var_7_0, arg_7_0)

		return
	end) then
		local var_6_4 = arg_6_1
		local var_6_5 = arg_6_1.AddTempModel
		local var_6_6 = arg_6_0:GetTempGOPool()

		var_6_5(var_6_4, var_9.GetObject(var_6_6))
	end

	arg_6_1:SetSpawn(arg_6_2)
	arg_6_1:SetFXFunc(arg_6_0.onBulletHitFunc, arg_6_0.onBulletMissFunc)

	local var_6_7 = arg_6_0:GetSceneMediator()

	var_7.AddBullet(var_6_7, arg_6_1)

	if var_3:GetIFF() ~= var_6_2:GetFriendlyCode() and var_6_1.alert_fx ~= "" then
		local var_6_8 = arg_6_1
		local var_6_9 = arg_6_1.MakeAlert
		local var_6_10 = arg_6_0:GetFXPool()

		var_6_9(var_6_8, var_9.GetFX(var_6_10, var_6_1.alert_fx))
	end

	return
end

return
