local var_0_0 = class("AntitheticalCoupletResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return AntitheticalCoupletTools.GetResultUIName(arg_1_0.params_.activityID)
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
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if arg_5_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			JumpTools.OpenPageByJump("/antitheticalCouplet", {
				activityID = arg_5_0.params_.activityID
			})
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ActivitySpringFestivalCoupletsCfg[arg_8_0.params_.id]

	arg_8_0.couplet1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/couplets/" .. var_8_0.start_picture)

	local var_8_1

	if not arg_8_0.params_.isComplet then
		var_8_1 = manager.story:GetStoryChoice()[1] or 1

		AntitheticalCoupletAction:ChooseStoryID(arg_8_0.params_.id, var_8_1)
	else
		local var_8_2 = AntitheticalCoupletData:GetData(arg_8_0.params_.id)

		var_8_1 = var_8_2 and var_8_2.chooseID or 1
	end

	local var_8_3 = var_8_0.result_picture[var_8_1]

	arg_8_0.couplet2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/couplets/" .. var_8_3)

	if SDKTools.GetIsEnglish() then
		arg_8_0.couplet1_text.text = GetI18NText(var_8_0.start_text)
		arg_8_0.couplet2_text.text = GetI18NText(var_8_0.result_text[var_8_1])
	end
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
