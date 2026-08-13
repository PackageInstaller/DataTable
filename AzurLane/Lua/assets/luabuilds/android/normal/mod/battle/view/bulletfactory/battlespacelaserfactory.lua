ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleSpaceLaserFactory", var_0.Battle.BattleBulletFactory)

var_0_1.__name = "BattleSpaceLaserFactory"
var_0.Battle.BattleSpaceLaserFactory = var_0_1

function var_0_1.MakeBullet(arg_1_0)
	return var_0.Battle.BattleLaserArea.New()
end

function var_0_1.MakeModel(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:GetBulletData()
	local var_2_1 = var_3.GetTemplate(var_2_0)
	local var_2_2 = arg_2_0:GetDataProxy()
	local var_2_3 = arg_2_0:GetBulletPool()

	if var_6.InstFX(var_2_3, arg_2_1:GetModleID()) then
		arg_2_1:AddModel(var_6)
	else
		local var_2_4 = arg_2_1
		local var_2_5 = arg_2_1.AddTempModel
		local var_2_6 = arg_2_0:GetTempGOPool()

		var_2_5(var_2_4, var_9.GetObject(var_2_6))
	end

	var_0.Battle.PlayBattleSFX(var_3:GetHitSFX())

	local function var_2_7(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_3_0:GetBulletData()
		local var_3_1 = var_3.GetTemplate(var_3_0)
		local var_3_2 = var_3:GetDiveFilter()
		local var_3_3, var_3_4 = var_3:GetCollidedList()
		local var_3_5 = var_3

		if var_3.IsAlert(var_3_5) then
			return
		end

		local var_3_6

		if not var_3_4[arg_3_1] then
			var_3_6 = 0
		end

		pg = var_3_5

		local var_3_7 = var_3_5.TimeMgr.GetInstance()

		if var_9.GetCombatTime(var_3_7) < var_3_6 + var_3:GetHitInterval() then
			return
		end

		local var_3_8 = var_0_1
		local var_3_9 = var_9.GetSceneMediator(var_3_8)
		local var_3_10 = var_9.GetCharacter(var_3_9, arg_3_1)
		local var_3_11 = var_9.GetUnitData(var_3_10)
		local var_3_12

		if var_9.GetCldData(var_3_11).Active then
			var_3_12 = false

			local var_3_13 = var_9
			local var_3_14 = var_9.GetCurrentOxyState(var_3_13)

			ipairs = var_3_13

			for iter_3_0, iter_3_1 in var_3_13(var_3_2) do
				if var_3_14 == iter_3_1 then
					var_3_12 = true
				end
			end

			if not var_3_12 then
				local var_3_15 = var_2_2

				var_12.HandleDamage(var_3_15, var_3, var_9)
			end
		end

		pg = var_3_12

		local var_3_16 = var_3_12.TimeMgr.GetInstance()

		var_3_4[arg_3_1] = var_10.GetCombatTime(var_3_16)

		return
	end

	local function var_2_8(arg_4_0)
		return
	end

	arg_2_1:SetSpawn(arg_2_2)
	arg_2_1:SetFXFunc(var_2_7, var_2_8)

	local var_2_9 = arg_2_0:GetSceneMediator()

	var_9.AddBullet(var_2_9, arg_2_1)

	return
end

function var_0_1.OutRangeFunc(arg_5_0)
	arg_5_0:ExecuteLifeEndCallback()

	local var_5_0 = var_0_1.GetDataProxy()

	var_1.RemoveBulletUnit(var_5_0, arg_5_0:GetUniqueID())

	return
end

return
