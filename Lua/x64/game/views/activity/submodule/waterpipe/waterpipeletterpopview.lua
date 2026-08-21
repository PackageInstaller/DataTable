local var_0_0 = class("WaterPipeLetterPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipeUI/WaterPipeLetterPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.pipePolaroid = WaterPipePolaroid.New(arg_3_0.polaroidGo_)

	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardItems_ = {}
	arg_4_0.itemData = {
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	arg_4_0.viewController_ = arg_4_0.controller_:GetController("viewState")
	arg_4_0.categoryController_ = arg_4_0.controller_:GetController("showCategoryIcon")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/waterPipeGameStageView", {
			stageID = arg_5_0.stageID
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		arg_5_0:OnGetBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		JumpTools.Back()

		if arg_5_0.params_.closeCallback then
			arg_5_0.params_.closeCallback()
		end
	end)
end

function var_0_0.OnGetBtn(arg_9_0)
	local var_9_0 = WaterPipeData:GetStageInfoByStageID(arg_9_0.stageID)

	if var_9_0 and var_9_0.letter_reward then
		return
	end

	WaterPipeAction:FinishWaterPipeLetter(arg_9_0.stageID, WaterPipeData:GetMainActivityID(), function()
		arg_9_0:RefreshUI()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.stageID = arg_11_0.params_.stageID
	arg_11_0.stageCfg = ActivityWaterPipeStageCfg[arg_11_0.stageID]

	arg_11_0:RefreshUI()
	arg_11_0:ShowAni()
end

function var_0_0.ShowAni(arg_12_0)
	local var_12_0 = arg_12_0.params_.isSettle or false

	arg_12_0.lockAni1_.enabled = false
	arg_12_0.lockAni2_.enabled = false

	if var_12_0 then
		arg_12_0.panelAni_:Play("UI_WaterPipePicturePopUI_cx", 0, 0)
	else
		arg_12_0.panelAni_:Play("UI_WaterPipePicturePopUI_cx 0", 0, 0)
	end
end

function var_0_0.AddAutoGetTimer(arg_13_0)
	arg_13_0:StopAutoGetTimer()

	arg_13_0.autoGetTimer = Timer.New(function()
		if arg_13_0.panelAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.8 then
			arg_13_0:OnGetBtn()
			arg_13_0:StopAutoGetTimer()
		end
	end, 0.1, -1)

	arg_13_0.autoGetTimer:Start()
end

function var_0_0.StopAutoGetTimer(arg_15_0)
	if arg_15_0.autoGetTimer then
		arg_15_0.autoGetTimer:Stop()

		arg_15_0.autoGetTimer = nil
	end
end

function var_0_0.RefreshUI(arg_16_0)
	local var_16_0 = WaterPipeData:GetStageInfoByStageID(arg_16_0.stageID)

	if var_16_0 then
		if var_16_0.letter_reward then
			arg_16_0.viewController_:SetSelectedState("receivedGet")
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, arg_16_0.stageID), 1)
			arg_16_0.viewController_:SetSelectedState("canGet")
		end
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, arg_16_0.stageID), 0)
		arg_16_0.viewController_:SetSelectedState("unFinish")
	end

	local var_16_1 = arg_16_0.stageCfg.stage_reward
	local var_16_2 = DropCfg[var_16_1] and DropCfg[var_16_1].base_drop

	for iter_16_0, iter_16_1 in ipairs(var_16_2 or {}) do
		local var_16_3 = formatReward(iter_16_1)
		local var_16_4 = rewardToItemTemplate(var_16_3, arg_16_0.itemData[iter_16_0])

		if arg_16_0.rewardItems_[iter_16_0] == nil then
			arg_16_0.rewardItems_[iter_16_0] = CommonItemView.New(arg_16_0[string.format("commonitemGo_%s", iter_16_0)])
		end

		function var_16_4.clickFun(arg_17_0)
			ShowPopItem(POP_ITEM, {
				arg_17_0.id,
				arg_17_0.number
			})
		end

		arg_16_0.rewardItems_[iter_16_0]:SetData(var_16_4)
	end

	for iter_16_2 = #var_16_2 + 1, #arg_16_0.rewardItems_ do
		if arg_16_0.rewardItems_[iter_16_2] then
			arg_16_0.rewardItems_[iter_16_2]:SetData(nil)
		end
	end

	arg_16_0.pipePolaroid:RefreshUI(arg_16_0.stageID)

	arg_16_0.normalText_.text = arg_16_0.stageCfg.date_desc
	arg_16_0.finishText_.text = arg_16_0.stageCfg.preheat_desc

	local var_16_5 = WaterPipeData:GetCategoryImg(arg_16_0.stageID)

	if var_16_5 then
		arg_16_0.categoryiconImg_.sprite = var_16_5

		arg_16_0.categoryController_:SetSelectedState("show")
	else
		arg_16_0.categoryController_:SetSelectedState("hide")
	end
end

function var_0_0.OnTop(arg_18_0)
	return
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:StopAutoGetTimer()
end

function var_0_0.Dispose(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.rewardItems_) do
		if iter_20_1 then
			iter_20_1:Dispose()
		end
	end

	arg_20_0.pipePolaroid:Dispose()

	arg_20_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
