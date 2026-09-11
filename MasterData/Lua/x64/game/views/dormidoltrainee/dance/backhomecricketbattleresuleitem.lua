local BackHomeCricketBattleResuleItem = class("BackHomeCricketBattleResuleItem", ReduxView)

function BackHomeCricketBattleResuleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function BackHomeCricketBattleResuleItem:InitUI()
	self:BindCfgUI()
end

function BackHomeCricketBattleResuleItem:RefreshUI(arg_3_1, arg_3_2)
	self.type = arg_3_1.type
	self.name_.text = GetTips(BackHomeCricketConst.SCORE_DESC[self.type])

	if BackHomeCricketBattleData:GetSingleBattleData() or arg_3_2 then
		local var_3_0 = arg_3_1.attackData
		local var_3_1
		local var_3_2

		if self.type == BackHomeCricketConst.SCORE_INDEX.TOTAL then
			var_3_1 = var_3_0.totalNum
			var_3_2 = arg_3_1.defendData.totalNum
		elseif self.type == BackHomeCricketConst.SCORE_INDEX.ADVANTAGE then
			var_3_1 = var_3_0.peculiar
			var_3_2 = arg_3_1.defendData.peculiar
		elseif self.type == BackHomeCricketConst.SCORE_INDEX.SKILL_SCORE then
			var_3_1 = var_3_0.skillAdd
			var_3_2 = arg_3_1.defendData.skillAdd
		elseif self.type == BackHomeCricketConst.SCORE_INDEX.SKILL_DEDCUTION then
			var_3_1 = var_3_0.skillDec
			var_3_2 = arg_3_1.defendData.skillDec
		end

		local var_3_3 = self:CalculateBaseNum(var_3_1, var_3_2)

		self.scorelText_.text = var_3_1
		self.scorerText_.text = var_3_2

		local var_3_5 = LeanTween.value(self.bar1_.gameObject, 0, var_3_1 / var_3_3, 1)

		var_3_5:setOnUpdate(LuaHelper.FloatAction(function(arg_4_0)
			self.bar1_.value = arg_4_0
		end))
		var_3_5:setOnComplete(System.Action(function()
			LeanTween.cancel(self.bar1_.gameObject)
			var_3_5:setOnUpdate(nil):setOnComplete(nil)
		end))

		local var_3_6 = LeanTween.value(self.bar2_.gameObject, 0, var_3_2 / var_3_3, 1)

		var_3_6:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
			self.bar2_.value = arg_6_0
		end))
		var_3_6:setOnComplete(System.Action(function()
			LeanTween.cancel(self.bar2_.gameObject)
			var_3_6:setOnUpdate(nil):setOnComplete(nil)
		end))
	end
end

function BackHomeCricketBattleResuleItem:CalculateBaseNum(arg_8_1, arg_8_2)
	local var_8_0 = math.max(arg_8_1, arg_8_2)
	local var_8_1 = -1

	for iter_8_0, iter_8_1 in ipairs(GameDisplayCfg.dorm_idol_score_compare_scale.value) do
		if var_8_0 < iter_8_1[1] then
			var_8_1 = iter_8_1[2]

			break
		end
	end

	if var_8_1 < 0 then
		var_8_1 = GameDisplayCfg.dorm_idol_score_compare_scale.value[#GameDisplayCfg.dorm_idol_score_compare_scale.value][2]
	end

	return math.ceil((var_8_0 + 1) / var_8_1) * var_8_1
end

function BackHomeCricketBattleResuleItem:Dispose()
	BackHomeCricketBattleResuleItem.super.Dispose(self)
end

return BackHomeCricketBattleResuleItem
