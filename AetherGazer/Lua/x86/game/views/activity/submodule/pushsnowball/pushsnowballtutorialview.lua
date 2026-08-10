local var_0_0 = class("PushSnowBallTutorialView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballTeachingEntrancePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		if arg_5_0.timer_ then
			return
		end

		arg_5_0.bgAni_:SetFloat("speed", -1)
		arg_5_0.bgAni_:Play("EventPopUI1", 0, 1)
		arg_5_0.bgAni_:Update(0)

		arg_5_0.timer_ = Timer.New(function()
			arg_5_0:Back()

			arg_5_0.timer_ = nil
		end, 0.18, 1)

		arg_5_0.timer_:Start()
	end)
	arg_5_0:AddBtnListener(arg_5_0.playBtn_, nil, function()
		local var_8_0 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(1, 1)
		local var_8_1 = PushSnowBallCfg.get_id_list_by_activityId[var_8_0][1]
		local var_8_2 = GameSetting.push_snow_ball_tutorial_stage.value[1]
		local var_8_3 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE, var_8_2, {
			activityID = var_8_0
		})

		BattleController.GetInstance():LaunchBattle(var_8_3)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.AddTimer(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	return
end

return var_0_0
