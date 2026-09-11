local BattleStatisticsPolyhdronOverView = class("BattleStatisticsPolyhdronOverView", (import("game.views.battleResult.newStatistic.NewBattleStatisticsView")))

function BattleStatisticsPolyhdronOverView:OnEnter()
	local var_1_0 = PolyhedronData:GetPolyhedronInfo()
	local var_1_1 = var_1_0:GetFightHeroList()

	self.statisticsHeroItem_ = {}

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

			var_1_5[iter_1_0] = {
				id = var_1_1[iter_1_0],
				using_skin = PolyhedronData:GetHeroUsingSkinInfo(var_1_1[iter_1_0]).id,
				level = HeroStandardSystemCfg[PolyhedronHeroCfg[var_1_1[iter_1_0]].standard_id].hero_lv,
				star = HeroStandardSystemCfg[PolyhedronHeroCfg[var_1_1[iter_1_0]].standard_id].star_lv
			}
			var_1_2[iter_1_0].damage = var_1_6.damage
			var_1_2[iter_1_0].hurt = var_1_6.injured
			var_1_2[iter_1_0].cure = var_1_6.heal

			if var_1_4.damage >= var_1_2[iter_1_0].damage then
				var_1_4.damage = var_1_4.damage or var_1_2[iter_1_0].damage
			end

			if var_1_4.hurt >= var_1_2[iter_1_0].hurt then
				var_1_4.hurt = var_1_4.hurt or var_1_2[iter_1_0].hurt
			end

			if var_1_4.cure >= var_1_2[iter_1_0].cure then
				var_1_4.cure = var_1_4.cure or var_1_2[iter_1_0].cure
			end

			var_1_3.damage = var_1_3.damage + var_1_2[iter_1_0].damage
			var_1_3.hurt = var_1_3.hurt + var_1_2[iter_1_0].hurt
			var_1_3.cure = var_1_3.cure + var_1_2[iter_1_0].cure
		end
	end

	for iter_1_1 = 1, 3 do
		self.heroModule[iter_1_1]:SetHeroData(iter_1_1, var_1_5[iter_1_1])
		self.heroModule[iter_1_1]:SetStatisticsData(var_1_3, var_1_4, var_1_2[iter_1_1])
	end

	self:SetLevelTitle()
	self:RefreshTimeText()
	self:RenderMaskBg()
end

function BattleStatisticsPolyhdronOverView:ParseTime(arg_2_1)
	local var_2_0 = math.floor(arg_2_1 / 3600)
	local var_2_1 = math.floor(arg_2_1 % 3600 / 60)
	local var_2_2 = arg_2_1 % 60

	var_2_0 = var_2_0 < 10 and "0" .. var_2_0 or var_2_0
	var_2_1 = var_2_1 < 10 and "0" .. var_2_1 or var_2_1
	var_2_2 = var_2_2 < 10 and "0" .. var_2_2 or var_2_2

	return var_2_0 .. ":" .. var_2_1 .. ":" .. var_2_2
end

function BattleStatisticsPolyhdronOverView:SetLevelTitle()
	self.titleTxt_.text = ""
end

function BattleStatisticsPolyhdronOverView:RefreshTimeText()
	SetActive(self.timeTxt_.gameObject, false)
end

function BattleStatisticsPolyhdronOverView:GetHeroSkin(arg_5_1)
	return arg_5_1
end

return BattleStatisticsPolyhdronOverView
