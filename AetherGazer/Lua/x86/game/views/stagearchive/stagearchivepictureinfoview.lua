local var_0_0 = class("StageArchivePictureInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationDiaryUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.archiveID_ = arg_6_0.params_.archiveID

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = StageArchivesCollectCfg[arg_7_0.archiveID_]

	arg_7_0.nameText_.text = formatText(var_7_0.name)
	arg_7_0.archiveText_.text = formatText(var_7_0.desc)

	if arg_7_0.iconImage_ then
		arg_7_0.iconImage_.sprite = pureGetSpriteWithoutAtlas(var_7_0.archive_icon)
	end

	arg_7_0.scrollView_.verticalNormalizedPosition = 1
end

return var_0_0
