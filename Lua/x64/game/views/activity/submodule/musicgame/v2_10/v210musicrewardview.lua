local var_0_0 = class("V210MusicRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.rewardView then
		return var_1_0.rewardView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicRewardUI"
	end
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rewardItemList = {}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.oneClickController = arg_4_0.controller_:GetController("OneClick")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.onegetBtn_, nil, function()
		arg_5_0:OnOneGetBtn()
	end)
end

function var_0_0.OnOneGetBtn(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0.musics) do
		local var_8_1 = ActivityMusicCfg.get_id_list_by_activity_id[iter_8_1]

		for iter_8_2, iter_8_3 in ipairs(var_8_1) do
			if MusicData:GetRewardState(iter_8_3) == 1 then
				table.insert(var_8_0, iter_8_3)
			end
		end
	end

	MusicAction.QueryReward(var_8_0)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activity_id = arg_10_0.params_.activity_id

	arg_10_0:UpdateMusicRewardList()
end

function var_0_0.GetState(arg_11_0, arg_11_1)
	local var_11_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_11_1]

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = ActivityMusicCfg[iter_11_1]

		if var_11_1.difficult == 1 or var_11_1.difficult == 2 then
			if MusicData:GetRewardState(iter_11_1) == 1 then
				return 1
			elseif MusicData:GetRewardState(iter_11_1) == 2 then
				return -1
			end
		end
	end

	return 0
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.rewardItemList) do
		iter_13_1:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.GetHeight(arg_14_0, arg_14_1)
	local var_14_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_14_1] or {}
	local var_14_1 = 360.90999999999997
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if ActivityMusicCfg[iter_14_1] and #ActivityMusicCfg[iter_14_1].reward > 0 then
			table.insert(var_14_2, iter_14_1)
		end
	end

	if #var_14_2 == 1 then
		var_14_1 = var_14_1 - 130
	end

	return var_14_1
end

function var_0_0.UpdateMusicRewardList(arg_15_0)
	local var_15_0 = ActivityCfg[arg_15_0.activity_id]

	arg_15_0.musics = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0.sub_activity_list) do
		if ActivityCfg[iter_15_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(arg_15_0.musics, iter_15_1)
		end
	end

	table.sort(arg_15_0.musics, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_15_0:GetState(arg_16_0)
		local var_16_1 = arg_15_0:GetState(arg_16_1)

		if var_16_0 ~= var_16_1 then
			return var_16_1 < var_16_0
		else
			return arg_16_0 < arg_16_1
		end
	end)

	local var_15_1 = false

	for iter_15_2, iter_15_3 in pairs(arg_15_0.musics) do
		if arg_15_0:GetState(iter_15_3) == 1 then
			var_15_1 = true
		end
	end

	if var_15_1 then
		arg_15_0.oneClickController:SetSelectedState("state1")
	else
		arg_15_0.oneClickController:SetSelectedState("state0")
	end

	if #arg_15_0.rewardItemList == 0 then
		local var_15_2 = 0

		for iter_15_4, iter_15_5 in pairs(arg_15_0.musics) do
			arg_15_0:CreateRewardItem(iter_15_4)

			arg_15_0.rewardItemList[iter_15_4].transform_.anchoredPosition = Vector2(0, -var_15_2)
			var_15_2 = var_15_2 + arg_15_0:GetHeight(iter_15_5)
		end

		arg_15_0.contentTrs_.sizeDelta = Vector2(1221, var_15_2)
		arg_15_0.nowHeight = var_15_2
	elseif arg_15_0.nowHeight then
		arg_15_0.contentTrs_.sizeDelta = Vector2(1221, arg_15_0.nowHeight)
	end

	for iter_15_6, iter_15_7 in pairs(arg_15_0.musics) do
		arg_15_0:UpdateRewardItem(arg_15_0.rewardItemList[iter_15_6], iter_15_7)
	end
end

function var_0_0.CreateRewardItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = GameObject.Instantiate(arg_17_0.songitemGo_, arg_17_0.contentTrs_)

	SetActive(var_17_0, true)

	arg_17_0.rewardItemList[arg_17_1] = VolumeMusicSongItem.New(var_17_0)
end

function var_0_0.UpdateRewardItem(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 or not arg_18_2 then
		return
	end

	arg_18_1:SetData(arg_18_2)
end

function var_0_0.OnMusicRewardUpdate(arg_19_0)
	arg_19_0:UpdateMusicRewardList()
end

return var_0_0
