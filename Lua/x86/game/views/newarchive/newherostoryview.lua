local var_0_0 = class("NewHeroStoryView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroArchive/HeroStoryPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.data_ = arg_5_0.params_.data
	arg_5_0.archiveID_ = arg_5_0.params_.archiveID

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ArchiveAction.SendViewArchiveStory(arg_5_0.archiveID_, arg_5_0.data_.id)
	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = HeroCfg[arg_6_0.data_.id]

	arg_6_0.nameText_.text = string.format(arg_6_0.data_.name)
	arg_6_0.storyText_.text = formatText(arg_6_0.data_.anecdote)
	arg_6_0.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_6_0.data_.id)
	arg_6_0.roleNameText_.text = var_6_0.name
end

function var_0_0.OnExit(arg_7_0)
	if arg_7_0.callback_ then
		arg_7_0.callback_()
	end
end

return var_0_0
