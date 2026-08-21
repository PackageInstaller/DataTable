ys = ys or {}

local var_0_0 = ys
local var_0_1 = singletonClass("BattleSpaceLaserFactory", ys.Battle.BattleBulletFactory)

var_0_1.__name = "BattleSpaceLaserFactory"
ys.Battle.BattleSpaceLaserFactory = var_0_1

function var_0_1.MakeBullet(arg_1_0)
	return var_0_0.Battle.BattleLaserArea.New()
end

function var_0_1.MakeModel(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:GetBulletData()
	local var_2_1 = var_2_0:GetTemplate()
	local var_2_2 = arg_2_0:GetDataProxy()
	local var_2_3 = arg_2_0:GetBulletPool():InstFX(arg_2_1:GetModleID())

	if var_2_3 then
		arg_2_1:AddModel(var_2_3)
	else
		arg_2_1:AddTempModel(arg_2_0:GetTempGOPool():GetObject())
	end

	var_0_0.Battle.PlayBattleSFX(var_2_0:GetHitSFX())
	arg_2_1:SetSpawn(arg_2_2)
	arg_2_1:SetFXFunc(function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_3_0:GetBulletData()
		local var_3_1 = var_3_0:GetTemplate()
		local var_3_2, var_3_3 = var_3_0:GetCollidedList()

		if var_3_0:IsAlert() then
			return
		end

		local var_3_4 = var_3_3[arg_3_1] or 0
		local var_3_5 = pg.TimeMgr.GetInstance()

		if var_3_5:GetCombatTime() < var_3_4 + var_3_0:GetHitInterval() then
			return
		end

		local var_3_6 = var_0_1:GetSceneMediator():GetCharacter(arg_3_1):GetUnitData()

		if var_3_6:GetCldData().Active then
			local var_3_7 = false
			local var_3_8 = var_3_6:GetCurrentOxyState()

			for iter_3_0, iter_3_1 in ipairs((var_3_0:GetDiveFilter())) do
				if var_3_8 == iter_3_1 then
					var_3_7 = true
				end
			end

			if not var_3_7 then
				var_2_2:HandleDamage(var_3_0, var_3_6)
			end
		end

		var_3_3[arg_3_1] = pg.TimeMgr.GetInstance():GetCombatTime()

		return
	end, function(arg_4_0)
		return
	end)
	arg_2_0:GetSceneMediator():AddBullet(arg_2_1)

	return
end

function var_0_1.OutRangeFunc(arg_5_0)
	arg_5_0:ExecuteLifeEndCallback()
	var_0_1.GetDataProxy():RemoveBulletUnit(arg_5_0:GetUniqueID())

	return
end

return
