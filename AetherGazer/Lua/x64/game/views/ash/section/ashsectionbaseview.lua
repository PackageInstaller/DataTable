local var_0_0 = class("AshSectionBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_StageBaseUI"
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

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshRewardItem), arg_4_0.consumeList_, CommonItemView)
	arg_4_0.dropController_ = arg_4_0.controller_:GetController("hideDropPanel")
	arg_4_0.conditionController_ = arg_4_0.controller_:GetController("hideStageDesc")
	arg_4_0.lockController_ = arg_4_0.controller_:GetController("startBtnLock")
	arg_4_0.scoreController_ = arg_4_0.controller_:GetController("hideStageScore")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.startGameBtn_, nil, function()
		arg_5_0:StartGame()
	end)
end

function var_0_0.RefreshRewardItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rewardList_[arg_7_1]
	local var_7_1

	if var_7_0 then
		var_7_1 = rewardToItemTemplate(var_7_0)
		var_7_1.number = var_7_0.num

		function var_7_1.clickFun(arg_8_0)
			ShowPopItem(POP_ITEM, arg_8_0)
		end
	end

	arg_7_2:SetData(var_7_1)
end

function var_0_0.StartGame(arg_9_0)
	local var_9_0 = AshShootStageCfg[arg_9_0.level]
	local var_9_1 = BattleAshShootStageCfg[var_9_0.stage_id]

	JumpTools.OpenPageByJump("/ashPrepareView", {
		stageId = var_9_0.stage_id,
		levelId = arg_9_0.level
	})
end

function var_0_0.OnUpdate(arg_10_0)
	if arg_10_0.level == arg_10_0.params_.level then
		return
	end

	arg_10_0.level = arg_10_0.params_.level
	arg_10_0.stageId = AshShootStageCfg[arg_10_0.level].stage_id

	arg_10_0:RenderUI()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.level = arg_11_0.params_.level

	local var_11_0 = AshShootStageCfg[arg_11_0.level]

	arg_11_0.stageId = var_11_0.stage_id
	arg_11_0.dropLibID_ = BattleAshShootStageCfg[var_11_0.stage_id].drop_lib_id

	arg_11_0:RenderUI()
	arg_11_0:RefreshReward()
end

function var_0_0.RenderUI(arg_12_0)
	local var_12_0 = AshShootStageCfg[arg_12_0.level]
	local var_12_1 = BattleAshShootStageCfg[var_12_0.stage_id]

	arg_12_0.stageName_.text = var_12_1.name
	arg_12_0.stageBg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_12_1.background_1))
	arg_12_0.conditionTxt_.text = var_12_0.victory_goal_desc
	arg_12_0.lockText_.text = GetTips("ASH_STAGE_UNLOCK_TIPS")

	if AshSystemData:IsStagePass(arg_12_0.level) then
		arg_12_0.scoreText_.text = tostring(AshSystemData:GetStagePoint(arg_12_0.level))

		arg_12_0.dropController_:SetSelectedIndex(1)
	else
		arg_12_0.scoreText_.text = "-- --"

		arg_12_0.dropController_:SetSelectedIndex(0)
	end

	local var_12_2 = AshSystemData:FindPreSection(arg_12_0.level)

	if not var_12_2 or var_12_2 and AshSystemData:IsStagePass(var_12_2) then
		arg_12_0.lockController_:SetSelectedIndex(0)
	else
		arg_12_0.lockController_:SetSelectedIndex(1)
	end

	local var_12_3 = 0

	for iter_12_0, iter_12_1 in ipairs(AshShootStageCfg.all) do
		local var_12_4 = AshShootStageCfg[iter_12_1]

		if var_12_4.stage_group == 4 then
			var_12_3 = var_12_4.stage_id

			break
		end
	end

	if arg_12_0.stageId ~= var_12_3 then
		arg_12_0.conditionController_:SetSelectedIndex(0)
	else
		arg_12_0.conditionController_:SetSelectedIndex(1)
	end
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()

		if arg_13_0.params_.backFunc then
			arg_13_0.params_.backFunc()
		end
	end)
end

function var_0_0.OnBehind(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_16_0)
	return
end

function var_0_0.RefreshReward(arg_17_0)
	local var_17_0 = arg_17_0.dropLibID_

	arg_17_0.rewardList_ = getRewardFromDropCfg(var_17_0, true)

	local var_17_1 = arg_17_0.rewardList_

	arg_17_0.uiList_:StartScroll(#var_17_1)
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.uiList_:Dispose()

	arg_18_0.uiList_ = nil

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
