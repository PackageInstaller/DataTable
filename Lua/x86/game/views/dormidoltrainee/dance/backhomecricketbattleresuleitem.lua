local var_0_0 = class("BackHomeCricketBattleResuleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = BackHomeCricketBattleData:GetSingleBattleData()

	arg_3_0.type = arg_3_1.type
	arg_3_0.name_.text = GetTips(BackHomeCricketConst.SCORE_DESC[arg_3_0.type])

	if var_3_0 or arg_3_2 then
		local var_3_1 = arg_3_1.attackData
		local var_3_2 = arg_3_1.defendData
		local var_3_3
		local var_3_4

		if arg_3_0.type == BackHomeCricketConst.SCORE_INDEX.TOTAL then
			var_3_3 = var_3_1.totalNum
			var_3_4 = var_3_2.totalNum
		elseif arg_3_0.type == BackHomeCricketConst.SCORE_INDEX.ADVANTAGE then
			var_3_3 = var_3_1.peculiar
			var_3_4 = var_3_2.peculiar
		elseif arg_3_0.type == BackHomeCricketConst.SCORE_INDEX.SKILL_SCORE then
			var_3_3 = var_3_1.skillAdd
			var_3_4 = var_3_2.skillAdd
		elseif arg_3_0.type == BackHomeCricketConst.SCORE_INDEX.SKILL_DEDCUTION then
			var_3_3 = var_3_1.skillDec
			var_3_4 = var_3_2.skillDec
		end

		local var_3_5 = arg_3_0:CalculateBaseNum(var_3_3, var_3_4)
		local var_3_6
		local var_3_7
		local var_3_8 = var_3_3 / var_3_5
		local var_3_9 = var_3_4 / var_3_5

		arg_3_0.scorelText_.text = var_3_3
		arg_3_0.scorerText_.text = var_3_4

		local var_3_10 = LeanTween.value(arg_3_0.bar1_.gameObject, 0, var_3_8, 1)

		var_3_10:setOnUpdate(LuaHelper.FloatAction(function(arg_4_0)
			arg_3_0.bar1_.value = arg_4_0
		end))
		var_3_10:setOnComplete(System.Action(function()
			LeanTween.cancel(arg_3_0.bar1_.gameObject)
			var_3_10:setOnUpdate(nil):setOnComplete(nil)
		end))

		local var_3_11 = LeanTween.value(arg_3_0.bar2_.gameObject, 0, var_3_9, 1)

		var_3_11:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
			arg_3_0.bar2_.value = arg_6_0
		end))
		var_3_11:setOnComplete(System.Action(function()
			LeanTween.cancel(arg_3_0.bar2_.gameObject)
			var_3_11:setOnUpdate(nil):setOnComplete(nil)
		end))
	end
end

function var_0_0.CalculateBaseNum(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = math.max(arg_8_1, arg_8_2)
	local var_8_1 = GameDisplayCfg.dorm_idol_score_compare_scale.value
	local var_8_2 = -1

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if var_8_0 < iter_8_1[1] then
			var_8_2 = iter_8_1[2]

			break
		end
	end

	if var_8_2 < 0 then
		var_8_2 = var_8_1[#var_8_1][2]
	end

	return math.ceil((var_8_0 + 1) / var_8_2) * var_8_2
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
