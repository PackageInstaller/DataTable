local var_0_0 = class("VolumeMusicRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, VolumeMusicSongItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activity_id = arg_8_0.params_.activity_id

	local var_8_0 = ActivityCfg[arg_8_0.activity_id]

	arg_8_0.musics = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0.sub_activity_list) do
		if ActivityCfg[iter_8_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(arg_8_0.musics, iter_8_1)
		end
	end

	table.sort(arg_8_0.musics, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_8_0:GetState(arg_9_0)
		local var_9_1 = arg_8_0:GetState(arg_9_1)

		if var_9_0 ~= var_9_1 then
			return var_9_1 < var_9_0
		else
			return arg_9_0 < arg_9_1
		end
	end)
	arg_8_0.list_:StartScroll(#arg_8_0.musics)
end

function var_0_0.GetState(arg_10_0, arg_10_1)
	local var_10_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_10_1]

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = ActivityMusicCfg[iter_10_1]

		if (var_10_1.difficult == 1 or var_10_1.difficult == 2) and MusicData:GetRewardState(iter_10_1) == 1 then
			return 1
		end
	end

	return 0
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.musics[arg_12_1]

	arg_12_2:SetData(var_12_0)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.list_:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.OnMusicRewardUpdate(arg_14_0)
	local var_14_0 = arg_14_0.list_:GetItemList()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		iter_14_1:Refresh()
	end
end

return var_0_0
