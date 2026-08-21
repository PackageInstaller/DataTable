local var_0_0 = class("NewHeroArchiveHomePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroArchive/ArchiveStoryHomePopUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.mask_, nil, function()
		arg_5_0:Back()

		local var_6_0 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_5_0.heroID_][1])

		SDKTools.SendMessageToSDK("chain_story_picture_open_tip", {
			opt = 0,
			record_id = var_6_0.archive_id
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()

		local var_7_0 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_5_0.heroID_][1])

		SDKTools.SendMessageToSDK("chain_story_picture_open_tip", {
			opt = 0,
			record_id = var_7_0.archive_id
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.yesBtn_, nil, function()
		local var_8_0 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_5_0.heroID_][1])

		JumpTools.GoToSystem("/newHeroDetailArchive", {
			isBackHome = true,
			id = var_8_0.archive_id
		})
		SDKTools.SendMessageToSDK("chain_story_enter", {
			chain_story_enter_source = 3,
			record_id = var_8_0.archive_id
		})
		SDKTools.SendMessageToSDK("chain_story_picture_open_tip", {
			opt = 1,
			record_id = var_8_0.archive_id
		})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.heroID_ = arg_9_0.params_.heroID
	arg_9_0.heartType_ = arg_9_0.params_.type

	saveData("archivePop", "popInfo" .. HeroRecordCfg.get_id_list_by_hero_id[arg_9_0.heroID_][1] .. arg_9_0.heartType_, true)

	if arg_9_0.heartType_ == 2 then
		saveData("archivePop", "popInfo" .. HeroRecordCfg.get_id_list_by_hero_id[arg_9_0.heroID_][1] .. 1, true)
	end

	saveData("archivePop", "cache", manager.time:GetServerTime())
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[arg_10_0.heroID_][1]]
	local var_10_1 = HeroCfg[arg_10_0.heroID_]

	if arg_10_0.heartType_ == 1 then
		arg_10_0.descText_.text = var_10_0.plot_tip
	elseif arg_10_0.heartType_ == 2 then
		arg_10_0.descText_.text = var_10_0.super_plot_tip
	end

	arg_10_0.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_10_0.plot_tip_picture)
	arg_10_0.roleNameText_.text = HeroTools.GetHeroName(arg_10_0.heroID_)
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.callback_ then
		arg_11_0.callback_()
	end
end

return var_0_0
