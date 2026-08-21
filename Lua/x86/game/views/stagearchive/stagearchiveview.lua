local var_0_0 = class("StageArchiveView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationDiaryUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.clueController_ = arg_3_0.controllerEx_:GetController("verClue")
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = arg_4_0.params_.archiveID

	if arg_4_0.params_.isClue then
		arg_4_0.clueController_:SetSelectedState("state1")
	else
		arg_4_0.clueController_:SetSelectedState("state0")
	end

	local var_4_1 = StageArchiveCfg[var_4_0]

	arg_4_0.nameText_.text = formatText(var_4_1.name)
	arg_4_0.archiveText_.text = formatText(var_4_1.desc)

	if arg_4_0.iconImage_ then
		arg_4_0.iconImage_.sprite = pureGetSpriteWithoutAtlas(var_4_1.iconPath)
	end

	arg_4_0.scrollView_.verticalNormalizedPosition = 1
end

function var_0_0.OnExit(arg_5_0)
	if arg_5_0.iconImage_ then
		arg_5_0.iconImage_.sprite = nil
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		arg_7_0:Back()
	end)
end

return var_0_0
