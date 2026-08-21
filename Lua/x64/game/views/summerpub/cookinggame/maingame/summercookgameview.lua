local var_0_0 = class("SummerCookGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/CookingGame/mainGame/CookingMainGameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_5_0)
	return
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if manager.guide:IsPlaying() then
			return
		end

		ShowMessageBox({
			prefabPath = "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_TipsPopUI",
			content = GetTips("COOKING_GAME_BACK"),
			OkCallback = function()
				arg_6_0:Back(2)
				arg_6_0:SendGameMessageToSDK(3, arg_6_0.dishId_)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.OnEnter(arg_10_0)
	if SummerPubData:GetCookMenuIndex() >= #SummerPubCookCfg.all then
		manager.audio:PlayBGM("bgm_activity_4_3_battle_boss_402501", "bgm_activity_4_3_battle_boss_402501", "bgm_activity_4_3_battle_boss_402501.awb")
	else
		manager.audio:PlayBGM("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")
	end

	arg_10_0.dishId_ = arg_10_0.params_.dishId

	CookingGameBrige.LoadGame(arg_10_0.dishId_, arg_10_0.params_.isBattle or false)
end

function var_0_0.OnEnterOver(arg_11_0)
	FrameTimer.New(function()
		manager.ui:SetUISeparateRender(true)
	end, 1, 1):Start()
end

function var_0_0.OnFinishCook(arg_13_0, arg_13_1)
	local var_13_0 = tonumber(arg_13_0)

	if var_13_0 == SummerPubConst.COOK_LAST_STAGE then
		if arg_13_1 then
			local var_13_1 = SummerPubData:GetLevelIDByStageID(SummerPubConst.STAGE_5270208)
			local var_13_2 = SummerPubLevelCfg[var_13_1]

			function CallBack()
				local var_14_0 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SUMMER_PUB, SummerPubConst.STAGE_5270208, 0)
				local var_14_1 = GetOldPlayerExp()
				local var_14_2 = {
					challengedNumber = 1,
					errorCode = 0,
					clear_times = 1,
					oldPlayerEXPInfo = var_14_1,
					heroDataCollect = {}
				}

				JumpTools.OpenPageByJump("/newSettlement", {
					stageData = var_14_0,
					battleResult = var_14_2
				})
			end

			if var_13_2.post_story_id ~= 0 then
				manager.story:StartStoryById(var_13_2.post_story_id, function(arg_15_0)
					CallBack()
				end)
			else
				CallBack()
			end
		else
			JumpTools.Back()
		end
	elseif SummerPubData:GetCookClearNumByStageID(var_13_0) > 0 then
		JumpTools.Back()
	else
		gameContext:SetUrlAndParams("/summerPubPartnerView", {
			isBack = true
		})
		JumpTools.OpenPageByJump("/summerPubToTaskView", {
			cookDishId = var_13_0
		})
	end

	var_0_0.SendGameMessageToSDK(var_0_0, 1, arg_13_0)
end

function var_0_0.SendGameMessageToSDK(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = CookingGameBrige.GetCookData()
	local var_16_1 = string.split(var_16_0, "|")
	local var_16_2 = tonumber(var_16_1[1]) or 0
	local var_16_3 = tonumber(var_16_1[2]) or 0
	local var_16_4 = var_16_1[3] or "[]"

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
		stage_id = arg_16_2,
		result = arg_16_1,
		use_seconds = tonumber(var_16_3) or 0,
		other_data = var_16_4 or "{}",
		sequence_id = var_16_2 or 0
	})
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()
	manager.ui:SetUISeparateRender(false)
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
