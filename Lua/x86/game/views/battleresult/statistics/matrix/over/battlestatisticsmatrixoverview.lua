local var_0_0 = import("..BattleStatisticsMatrixView")
local var_0_1 = class("BattleStatisticsMatrixOverView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	local var_1_0 = arg_1_0:GetMatrixHeroTeam()

	arg_1_0.statisticsHeroItem_ = {}

	local var_1_1 = {
		{
			hurt = 0,
			damage = 0,
			cure = 0
		},
		{
			hurt = 0,
			damage = 0,
			cure = 0
		},
		{
			hurt = 0,
			damage = 0,
			cure = 0
		}
	}
	local var_1_2 = {
		hurt = 0,
		damage = 0,
		cure = 0
	}
	local var_1_3 = {
		hurt = 0,
		damage = 0,
		cure = 0
	}
	local var_1_4 = {}

	for iter_1_0 = 1, 3 do
		if var_1_0[iter_1_0] and var_1_0[iter_1_0] ~= 0 then
			local var_1_5 = arg_1_0:GetHeroData(var_1_0[iter_1_0])

			var_1_4[iter_1_0] = {
				level = 1,
				id = var_1_0[iter_1_0],
				skin_id = arg_1_0:GetHeroSkin(var_1_0[iter_1_0])
			}
			var_1_1[iter_1_0].damage = var_1_5.totalDamage_
			var_1_1[iter_1_0].hurt = var_1_5.totalHurt_
			var_1_1[iter_1_0].cure = var_1_5.totalHeal_
			var_1_3.damage = var_1_3.damage >= var_1_1[iter_1_0].damage and var_1_3.damage or var_1_1[iter_1_0].damage
			var_1_3.hurt = var_1_3.hurt >= var_1_1[iter_1_0].hurt and var_1_3.hurt or var_1_1[iter_1_0].hurt
			var_1_3.cure = var_1_3.cure >= var_1_1[iter_1_0].cure and var_1_3.cure or var_1_1[iter_1_0].cure
			var_1_2.damage = var_1_2.damage + var_1_1[iter_1_0].damage
			var_1_2.hurt = var_1_2.hurt + var_1_1[iter_1_0].hurt
			var_1_2.cure = var_1_2.cure + var_1_1[iter_1_0].cure
		end
	end

	for iter_1_1 = 1, 3 do
		arg_1_0.statisticsHeroItem_[iter_1_1] = arg_1_0:GetStatisticsItem().New(arg_1_0.heroItem_[iter_1_1], var_1_4[iter_1_1], var_1_2, var_1_3, var_1_1[iter_1_1])
	end

	arg_1_0:SetLevelTitle()

	if arg_1_0:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
		arg_1_0.battleTimeText_.text = arg_1_0:ParseTime(arg_1_0:GetCurrentClearTime())

		SetActive(arg_1_0.battleTimeGo_, true)
	else
		SetActive(arg_1_0.battleTimeGo_, false)
	end
end

function var_0_1.GetStatisticsItem(arg_2_0)
	return BattleStatisticsMatrixOverItem
end

function var_0_1.ParseTime(arg_3_0, arg_3_1)
	local var_3_0 = math.floor(arg_3_1 / 3600)
	local var_3_1 = math.floor(arg_3_1 % 3600 / 60)
	local var_3_2 = arg_3_1 % 60

	var_3_0 = var_3_0 < 10 and "0" .. var_3_0 or var_3_0
	var_3_1 = var_3_1 < 10 and "0" .. var_3_1 or var_3_1
	var_3_2 = var_3_2 < 10 and "0" .. var_3_2 or var_3_2

	return var_3_0 .. ":" .. var_3_1 .. ":" .. var_3_2
end

function var_0_1.SetLevelTitle(arg_4_0)
	arg_4_0.lvText_.text = ""
	arg_4_0.stareText_.text = ""
end

function var_0_1.GetGameState(arg_5_0)
	return MatrixData:GetGameState()
end

function var_0_1.GetCurrentClearTime(arg_6_0)
	return MatrixData:GetCurrentClearTime()
end

function var_0_1.GetMatrixHeroTeam(arg_7_0)
	return MatrixData:GetMatrixHeroTeam()
end

function var_0_1.GetHeroData(arg_8_0, arg_8_1)
	return MatrixData:GetHeroData(arg_8_1)
end

function var_0_1.GetHeroSkin(arg_9_0, arg_9_1)
	return MatrixData:GetHeroSkin(arg_9_1)
end

return var_0_1
