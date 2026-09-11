local BattleStatisticsMatrixOverView = class("BattleStatisticsMatrixOverView", (import("..BattleStatisticsMatrixView")))

function BattleStatisticsMatrixOverView:OnEnter()
	local var_1_0 = self:GetMatrixHeroTeam()

	self.statisticsHeroItem_ = {}

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
			local var_1_5 = self:GetHeroData(var_1_0[iter_1_0])

			var_1_4[iter_1_0] = {
				level = 1,
				id = var_1_0[iter_1_0],
				skin_id = self:GetHeroSkin(var_1_0[iter_1_0])
			}
			var_1_1[iter_1_0].damage = var_1_5.totalDamage_
			var_1_1[iter_1_0].hurt = var_1_5.totalHurt_
			var_1_1[iter_1_0].cure = var_1_5.totalHeal_

			if var_1_3.damage >= var_1_1[iter_1_0].damage then
				var_1_3.damage = var_1_3.damage or var_1_1[iter_1_0].damage
			end

			if var_1_3.hurt >= var_1_1[iter_1_0].hurt then
				var_1_3.hurt = var_1_3.hurt or var_1_1[iter_1_0].hurt
			end

			if var_1_3.cure >= var_1_1[iter_1_0].cure then
				var_1_3.cure = var_1_3.cure or var_1_1[iter_1_0].cure
			end

			var_1_2.damage = var_1_2.damage + var_1_1[iter_1_0].damage
			var_1_2.hurt = var_1_2.hurt + var_1_1[iter_1_0].hurt
			var_1_2.cure = var_1_2.cure + var_1_1[iter_1_0].cure
		end
	end

	for iter_1_1 = 1, 3 do
		self.statisticsHeroItem_[iter_1_1] = self:GetStatisticsItem().New(self.heroItem_[iter_1_1], var_1_4[iter_1_1], var_1_2, var_1_3, var_1_1[iter_1_1])
	end

	self:SetLevelTitle()

	if self:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
		self.battleTimeText_.text = self:ParseTime(self:GetCurrentClearTime())

		SetActive(self.battleTimeGo_, true)
	else
		SetActive(self.battleTimeGo_, false)
	end
end

function BattleStatisticsMatrixOverView:GetStatisticsItem()
	return BattleStatisticsMatrixOverItem
end

function BattleStatisticsMatrixOverView:ParseTime(arg_3_1)
	local var_3_0 = math.floor(arg_3_1 / 3600)
	local var_3_1 = math.floor(arg_3_1 % 3600 / 60)
	local var_3_2 = arg_3_1 % 60

	var_3_0 = var_3_0 < 10 and "0" .. var_3_0 or var_3_0
	var_3_1 = var_3_1 < 10 and "0" .. var_3_1 or var_3_1
	var_3_2 = var_3_2 < 10 and "0" .. var_3_2 or var_3_2

	return var_3_0 .. ":" .. var_3_1 .. ":" .. var_3_2
end

function BattleStatisticsMatrixOverView:SetLevelTitle()
	self.lvText_.text = ""
	self.stareText_.text = ""
end

function BattleStatisticsMatrixOverView:GetGameState()
	return MatrixData:GetGameState()
end

function BattleStatisticsMatrixOverView:GetCurrentClearTime()
	return MatrixData:GetCurrentClearTime()
end

function BattleStatisticsMatrixOverView:GetMatrixHeroTeam()
	return MatrixData:GetMatrixHeroTeam()
end

function BattleStatisticsMatrixOverView:GetHeroData(arg_8_1)
	return MatrixData:GetHeroData(arg_8_1)
end

function BattleStatisticsMatrixOverView:GetHeroSkin(arg_9_1)
	return MatrixData:GetHeroSkin(arg_9_1)
end

return BattleStatisticsMatrixOverView
