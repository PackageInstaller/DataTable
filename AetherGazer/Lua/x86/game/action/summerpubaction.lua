local var_0_0 = {}

function var_0_0.finishPinBall(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	manager.net:SendWithLoadingNew(89002, {
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
		stage_id = arg_1_0,
		illustrated = arg_1_2,
		result = arg_1_3 and 1 or 2,
		sub_stage_id = arg_1_1
	}, 89003, var_0_0.OnfinishPinBall)
end

function var_0_0.OnfinishPinBall(arg_2_0, arg_2_1)
	if isSuccess(arg_2_0.result) then
		SummerPubData:FinishPinBall(arg_2_1.stage_id, arg_2_1.sub_stage_id, arg_2_1.illustrated, arg_2_1.result)
	else
		ShowTips(arg_2_0.result)
	end
end

function var_0_0.ViewIllustration(arg_3_0)
	if (SummerPubData:GetIlluInfo()[arg_3_0] or nil) == 1 then
		manager.net:SendWithLoadingNew(89004, {
			activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
			ill_id = arg_3_0
		}, 89005, var_0_0.OnViewComplete)
	end
end

function var_0_0.OnViewComplete(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		SummerPubData:UpdateIlluViewStage(arg_4_1.ill_id, 2)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.FinishCook(arg_5_0, arg_5_1, arg_5_2)
	if SummerPubData:GetCookClearNumByStageID(arg_5_0) > 0 then
		return
	end

	manager.net:SendWithLoadingNew(89006, {
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
		stage_id = arg_5_0,
		stage = arg_5_1
	}, 89007, function(arg_6_0, arg_6_1)
		var_0_0.OnFinishCook(arg_6_0, arg_6_1, arg_5_2)
	end)
end

function var_0_0.OnFinishCook(arg_7_0, arg_7_1, arg_7_2)
	if isSuccess(arg_7_0.result) then
		SummerPubData:FinishCook(arg_7_1.stage_id, arg_7_1.stage)

		if arg_7_2 then
			arg_7_2()
		end

		if arg_7_1.stage == SummerPubConst.COOK_STATE.FINISH_COOK then
			-- block empty
		elseif arg_7_1.stage == SummerPubConst.COOK_STATE.VIEW_CG then
			if arg_7_1.stage_id == SummerPubConst.COOK_FIRST_STAGE then
				SummerPubAction.OpenBattle(SummerPubConst.THIRD_LEVEL_ID, 1, BattleConst.STAGE_TYPE_NEW.SUMMER_PUB)
			elseif arg_7_1.stage_id == SummerPubConst.COOK_LAST_STAGE then
				-- block empty
			else
				JumpTools.Back()

				local var_7_0 = SummerPubCookCfg[arg_7_1.stage_id]

				JumpTools.OpenPopUp("summerPubPartnerDetailView", {
					isAnim = true,
					id = var_7_0.hero_id
				})
				SDKTools.SendMessageToSDK("activity_currency_opt", {
					activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
					hero_id = var_7_0.hero_id
				})
			end
		end
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.changeTimeState(arg_8_0)
	manager.net:SendWithLoadingNew(89008, {
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	}, 89009, function(arg_9_0, arg_9_1)
		var_0_0.changeTimeStateBackCall(arg_9_0, arg_9_1, arg_8_0)
	end)
end

function var_0_0.changeTimeStateBackCall(arg_10_0, arg_10_1, arg_10_2)
	if isSuccess(arg_10_0.result) then
		SummerPubData:SetTimeState(arg_10_2)
		JumpTools.OpenPageByJump("dayNightCutSceneLoadingDay")
	else
		ShowTips(arg_10_0.result)
	end
end

manager.net:Bind(89011, function(arg_11_0)
	SummerPubData:initData(arg_11_0)
end)

function var_0_0.InitRedPoint()
	SummerPubData:InitRedPointGroup()
	SummerPubData:UpdateTaskRedPoint()
end

function var_0_0.OpenBattle(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = SummerPubLevelCfg[arg_13_0]
	local var_13_1 = var_13_0.stage_id

	arg_13_2 = arg_13_2 or BattleConst.STAGE_TYPE_NEW.SUMMER_PUB

	if SummerPubData:GetLevelIDIsOpen(arg_13_0) then
		SummerPubData:SetStageAreaIndex(arg_13_0)

		if var_13_0.type == SummerPubConst.STAGE_TYPE.BATTLE then
			local var_13_2 = var_13_1[arg_13_1]

			if BattleStageTools.GetStageCfg(arg_13_2, var_13_2).tag == BattleConst.BATTLE_TAG.STORY then
				local var_13_3

				if arg_13_3 then
					function var_13_3(arg_14_0)
						if isSuccess(arg_14_0.result) then
							arg_13_3()
						end
					end
				end

				BattleController.GetInstance():LaunchStoryBattle(arg_13_2, var_13_2, 0, var_13_3)
			elseif arg_13_0 == SummerPubConst.FIRST_LEVEL_ID then
				local var_13_4

				if arg_13_3 then
					function var_13_4(arg_15_0)
						if isSuccess(arg_15_0.result) then
							arg_13_3()
						end
					end
				end

				local var_13_5 = BattleStageFactory.Produce(arg_13_2, var_13_2, 0)

				BattleController.GetInstance():LaunchBattle(var_13_5, nil, var_13_4)
			else
				if arg_13_3 then
					arg_13_3()
				end

				gameContext:Go("/sectionSelectHero", {
					section = var_13_2,
					sectionType = arg_13_2
				})
			end
		elseif var_13_0.type == SummerPubConst.STAGE_TYPE.BALL then
			if arg_13_3 then
				arg_13_3()
			end

			JumpTools.OpenPageByJump("billiardGameHeroSelect", {
				stageID = var_13_1[arg_13_1],
				levelID = arg_13_0,
				isEasy = arg_13_1 == 1
			})
		elseif var_13_0.type == SummerPubConst.STAGE_TYPE.COOK then
			if var_13_0.pre_story_id ~= 0 then
				if arg_13_3 then
					arg_13_3()
				end

				manager.story:StartStoryById(var_13_0.pre_story_id, function(arg_16_0)
					JumpTools.OpenPageByJump("/summerCookGameView", {
						isBattle = true,
						dishId = var_13_1[1]
					})
				end)
			else
				if arg_13_3 then
					arg_13_3()
				end

				JumpTools.OpenPageByJump("/summerCookGameView", {
					isBattle = true,
					dishId = var_13_1[1]
				})
			end
		end
	else
		ShowTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end
end

return var_0_0
