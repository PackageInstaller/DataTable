local var_0_0 = class("BattleCooperationSettlementStrategyBase")

function var_0_0.GotoSettlement(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0 = {}
	local var_1_1 = arg_1_1:GetThreeStar()

	if var_1_1 and type(var_1_1) == "table" then
		for iter_1_0 = 1, #var_1_1 do
			local var_1_2 = var_1_1[iter_1_0]

			if arg_1_3 and arg_1_3[iter_1_0] then
				table.insert(var_1_0, {
					id = var_1_2[1],
					total = arg_1_3[iter_1_0].need_progress,
					current = arg_1_3[iter_1_0].now_progress,
					xData = var_1_2[2],
					yData = var_1_2[3],
					isComplete = arg_1_3[iter_1_0].is_achieve == 1 and true or false
				})
			end
		end
	end

	if isSuccess(arg_1_2) then
		local var_1_3, var_1_4 = arg_1_1:GetHeroTeam()
		local var_1_5 = arg_1_1:GetSystemHeroTeam()
		local var_1_6 = arg_1_1:GetMultiple()
		local var_1_7 = GameSetting.mastery_gain.value[1]

		for iter_1_1 = 1, #var_1_3 do
			if var_1_5[iter_1_1] == nil and var_1_3[iter_1_1] ~= 0 and (var_1_4[iter_1_1] == nil or var_1_4[iter_1_1] == 0) then
				HeroData:HeroClearTimesModify(var_1_3[iter_1_1], var_1_7)

				local var_1_8 = HeroTools.GetHeroOntologyID(var_1_3[iter_1_1])

				if var_1_8 then
					ArchiveData:AddExp(var_1_8, GameSetting.hero_love_exp_gain.value[1] * var_1_6)
				end
			end
		end

		HeroAction.UpdateHeartRedPoint()
		HeroAction.UpdateStoryRedPoint()
		HeroAction.UpdateSuperStoryRedPoint()
	end

	arg_1_0:OnGotoSettlement({
		num = arg_1_2,
		starList = arg_1_3,
		battleResult = arg_1_4,
		stageData = arg_1_1,
		starMissionData = var_1_0,
		isHalfWay_ = arg_1_5
	})
end

function var_0_0.OnGotoSettlement(arg_2_0, arg_2_1)
	return
end

function var_0_0.GotoCooperationResult(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if isSuccess(arg_3_1) then
		local var_3_0 = arg_3_0:GetResultReward()

		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/newSettlement", {
				result = arg_3_1,
				rewardList = var_3_0,
				stageData = arg_3_2,
				starMissionData = arg_3_3,
				battleResult = arg_3_4
			})
			EndBattleLogic(arg_3_1)
		end
	else
		arg_3_0:GotoBattleFaild(arg_3_1, arg_3_2)
	end
end

function var_0_0.GotoBattleFaild(arg_5_0, arg_5_1, arg_5_2)
	function BattleCallLuaCallBack()
		gameContext:Go("/battleCooperationFailed", {
			stageData = arg_5_2
		})
		EndBattleLogic(arg_5_1)
	end
end

function var_0_0.GetResultReward(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(BattleFieldData:GetBattleResultData().dropList) do
		var_7_1[iter_7_1.battleTimes] = {}

		for iter_7_2, iter_7_3 in ipairs(iter_7_1.rewardItems) do
			print(string.format("服务端发下第%s次物品数据id:", iter_7_1.battleTimes), iter_7_3.id, "num:", iter_7_3.num)
			table.insert(var_7_1[iter_7_1.battleTimes], {
				iter_7_3.id,
				iter_7_3.num
			})
			table.insert(var_7_0, {
				iter_7_3.id,
				iter_7_3.num
			})
		end
	end

	return var_7_0, var_7_1
end

return var_0_0
