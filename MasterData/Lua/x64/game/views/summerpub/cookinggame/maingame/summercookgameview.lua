local SummerCookGameView = class("SummerCookGameView", ReduxView)

function SummerCookGameView:UIName()
	return "Widget/System/Activity_SummerPub/CookingGame/mainGame/CookingMainGameUI"
end

function SummerCookGameView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerCookGameView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerCookGameView:InitUI()
	self:BindCfgUI()
end

function SummerCookGameView:AddUIListeners()
	return
end

function SummerCookGameView:OnTop()
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
				self:Back(2)
				self:SendGameMessageToSDK(3, self.dishId_)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function SummerCookGameView:OnEnter()
	if SummerPubData:GetCookMenuIndex() >= #SummerPubCookCfg.all then
		manager.audio:PlayBGM("bgm_activity_4_3_battle_boss_402501", "bgm_activity_4_3_battle_boss_402501", "bgm_activity_4_3_battle_boss_402501.awb")
	else
		manager.audio:PlayBGM("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")
	end

	self.dishId_ = self.params_.dishId

	CookingGameBrige.LoadGame(self.dishId_, self.params_.isBattle or false)
end

function SummerCookGameView:OnEnterOver()
	FrameTimer.New(function()
		manager.ui:SetUISeparateRender(true)
	end, 1, 1):Start()
end

function SummerCookGameView:OnFinishCook(arg_13_1)
	local var_13_0 = tonumber(self)

	if var_13_0 == SummerPubConst.COOK_LAST_STAGE then
		if arg_13_1 then
			local var_13_1 = SummerPubLevelCfg[SummerPubData:GetLevelIDByStageID(SummerPubConst.STAGE_5270208)]

			function CallBack()
				JumpTools.OpenPageByJump("/newSettlement", {
					stageData = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SUMMER_PUB, SummerPubConst.STAGE_5270208, 0),
					battleResult = {
						challengedNumber = 1,
						errorCode = 0,
						clear_times = 1,
						oldPlayerEXPInfo = GetOldPlayerExp(),
						heroDataCollect = {}
					}
				})
			end

			if var_13_1.post_story_id ~= 0 then
				manager.story:StartStoryById(var_13_1.post_story_id, function(arg_15_0)
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

	SummerCookGameView:SendGameMessageToSDK(1, self)
end

function SummerCookGameView:SendGameMessageToSDK(arg_16_1, arg_16_2)
	local var_16_0 = string.split(CookingGameBrige.GetCookData(), "|")
	local var_16_1 = tonumber(var_16_0[1]) or 0
	local var_16_2 = var_16_0[3] or "[]"
	local var_16_3 = {
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
		stage_id = arg_16_2,
		result = arg_16_1
	}

	var_16_3.use_seconds = tonumber(tonumber(var_16_0[2]) or 0) or 0
	var_16_3.other_data = var_16_2 or "{}"
	var_16_3.sequence_id = var_16_1 or 0

	SDKTools.SendMessageToSDK("activity_combat_over", var_16_3)
end

function SummerCookGameView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:SetUISeparateRender(false)
end

function SummerCookGameView:Dispose()
	SummerCookGameView.super.Dispose(self)
end

return SummerCookGameView
