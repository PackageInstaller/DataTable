local var_0_0 = import("game.views.battleResult.newStatistic.NewBattleStatisticsView")
local var_0_1 = class("BattleStatisticsPolyhdronOverView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	local var_1_0 = PolyhedronData:GetPolyhedronInfo()
	local var_1_1 = var_1_0:GetFightHeroList()

	arg_1_0.statisticsHeroItem_ = {}

	local var_1_2 = {
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
	local var_1_3 = {
		hurt = 0,
		damage = 0,
		cure = 0
	}
	local var_1_4 = {
		hurt = 0,
		damage = 0,
		cure = 0
	}
	local var_1_5 = {}

	for iter_1_0 = 1, 3 do
		if var_1_1[iter_1_0] and var_1_1[iter_1_0] ~= 0 then
			local var_1_6 = var_1_0:GetHeroPolyData(var_1_1[iter_1_0])
			local var_1_7 = PolyhedronHeroCfg[var_1_1[iter_1_0]].standard_id
			local var_1_8 = HeroStandardSystemCfg[var_1_7].hero_lv
			local var_1_9 = HeroStandardSystemCfg[var_1_7].star_lv
			local var_1_10 = var_1_1[iter_1_0]
			local var_1_11 = PolyhedronData:GetHeroUsingSkinInfo(var_1_10).id

			var_1_5[iter_1_0] = {
				id = var_1_1[iter_1_0],
				using_skin = var_1_11,
				level = var_1_8,
				star = var_1_9
			}
			var_1_2[iter_1_0].damage = var_1_6.damage
			var_1_2[iter_1_0].hurt = var_1_6.injured
			var_1_2[iter_1_0].cure = var_1_6.heal
			var_1_4.damage = var_1_4.damage >= var_1_2[iter_1_0].damage and var_1_4.damage or var_1_2[iter_1_0].damage
			var_1_4.hurt = var_1_4.hurt >= var_1_2[iter_1_0].hurt and var_1_4.hurt or var_1_2[iter_1_0].hurt
			var_1_4.cure = var_1_4.cure >= var_1_2[iter_1_0].cure and var_1_4.cure or var_1_2[iter_1_0].cure
			var_1_3.damage = var_1_3.damage + var_1_2[iter_1_0].damage
			var_1_3.hurt = var_1_3.hurt + var_1_2[iter_1_0].hurt
			var_1_3.cure = var_1_3.cure + var_1_2[iter_1_0].cure
		end
	end

	for iter_1_1 = 1, 3 do
		arg_1_0.heroModule[iter_1_1]:SetHeroData(iter_1_1, var_1_5[iter_1_1])
		arg_1_0.heroModule[iter_1_1]:SetStatisticsData(var_1_3, var_1_4, var_1_2[iter_1_1])
	end

	arg_1_0:SetLevelTitle()
	arg_1_0:RefreshTimeText()
	arg_1_0:RenderMaskBg()
end

function var_0_1.ParseTime(arg_2_0, arg_2_1)
	local var_2_0 = math.floor(arg_2_1 / 3600)
	local var_2_1 = math.floor(arg_2_1 % 3600 / 60)
	local var_2_2 = arg_2_1 % 60

	var_2_0 = var_2_0 < 10 and "0" .. var_2_0 or var_2_0
	var_2_1 = var_2_1 < 10 and "0" .. var_2_1 or var_2_1
	var_2_2 = var_2_2 < 10 and "0" .. var_2_2 or var_2_2

	return var_2_0 .. ":" .. var_2_1 .. ":" .. var_2_2
end

function var_0_1.SetLevelTitle(arg_3_0)
	arg_3_0.titleTxt_.text = ""
end

function var_0_1.RefreshTimeText(arg_4_0)
	SetActive(arg_4_0.timeTxt_.gameObject, false)
end

function var_0_1.GetHeroSkin(arg_5_0, arg_5_1)
	return arg_5_1
end

return var_0_1
