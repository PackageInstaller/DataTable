local V210MusicRewardView = class("V210MusicRewardView", ReduxView)

function V210MusicRewardView:UIName()
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.rewardView then
		return var_1_0.rewardView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicRewardUI"
	end
end

function V210MusicRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function V210MusicRewardView:Init()
	self.rewardItemList = {}

	self:InitUI()
	self:AddUIListener()
end

function V210MusicRewardView:InitUI()
	self:BindCfgUI()

	self.oneClickController = self.controller_:GetController("OneClick")
end

function V210MusicRewardView:AddUIListener()
	self:AddBtnListener(self.m_mask, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.onegetBtn_, nil, function()
		self:OnOneGetBtn()
	end)
end

function V210MusicRewardView:OnOneGetBtn()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.musics) do
		for iter_8_2, iter_8_3 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[iter_8_1]) do
			if MusicData:GetRewardState(iter_8_3) == 1 then
				table.insert(var_8_0, iter_8_3)
			end
		end
	end

	MusicAction.QueryReward(var_8_0)
end

function V210MusicRewardView:OnTop()
	manager.windowBar:SwitchBar({})
end

function V210MusicRewardView:OnEnter()
	self.activity_id = self.params_.activity_id

	self:UpdateMusicRewardList()
end

function V210MusicRewardView:GetState(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[arg_11_1]) do
		if ActivityMusicCfg[iter_11_1].difficult == 1 or ActivityMusicCfg[iter_11_1].difficult == 2 then
			if MusicData:GetRewardState(iter_11_1) == 1 then
				return 1
			elseif MusicData:GetRewardState(iter_11_1) == 2 then
				return -1
			end
		end
	end

	return 0
end

function V210MusicRewardView:OnExit()
	manager.windowBar:HideBar()
end

function V210MusicRewardView:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.rewardItemList) do
		iter_13_1:Dispose()
	end

	V210MusicRewardView.super.Dispose(self)
end

function V210MusicRewardView:GetHeight(arg_14_1)
	local var_14_1 = 360.90999999999997
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[arg_14_1] or {}) do
		if ActivityMusicCfg[iter_14_1] and #ActivityMusicCfg[iter_14_1].reward > 0 then
			table.insert(var_14_2, iter_14_1)
		end
	end

	if #var_14_2 == 1 then
		var_14_1 = var_14_1 - 130
	end

	return var_14_1
end

function V210MusicRewardView:UpdateMusicRewardList()
	self.musics = {}

	for iter_15_0, iter_15_1 in ipairs(ActivityCfg[self.activity_id].sub_activity_list) do
		if ActivityCfg[iter_15_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(self.musics, iter_15_1)
		end
	end

	table.sort(self.musics, function(arg_16_0, arg_16_1)
		local var_16_0 = self:GetState(arg_16_0)
		local var_16_1 = self:GetState(arg_16_1)

		if var_16_0 ~= var_16_1 then
			return var_16_1 < var_16_0
		else
			return arg_16_0 < arg_16_1
		end
	end)

	local var_15_0 = false

	for iter_15_2, iter_15_3 in pairs(self.musics) do
		if self:GetState(iter_15_3) == 1 then
			var_15_0 = true
		end
	end

	if var_15_0 then
		self.oneClickController:SetSelectedState("state1")
	else
		self.oneClickController:SetSelectedState("state0")
	end

	if #self.rewardItemList == 0 then
		local var_15_1 = 0

		for iter_15_4, iter_15_5 in pairs(self.musics) do
			self:CreateRewardItem(iter_15_4)

			self.rewardItemList[iter_15_4].transform_.anchoredPosition = Vector2(0, -var_15_1)
			var_15_1 = var_15_1 + self:GetHeight(iter_15_5)
		end

		self.contentTrs_.sizeDelta = Vector2(1221, var_15_1)
		self.nowHeight = var_15_1
	elseif self.nowHeight then
		self.contentTrs_.sizeDelta = Vector2(1221, self.nowHeight)
	end

	for iter_15_6, iter_15_7 in pairs(self.musics) do
		self:UpdateRewardItem(self.rewardItemList[iter_15_6], iter_15_7)
	end
end

function V210MusicRewardView:CreateRewardItem(arg_17_1, arg_17_2)
	local var_17_0 = GameObject.Instantiate(self.songitemGo_, self.contentTrs_)

	SetActive(var_17_0, true)

	self.rewardItemList[arg_17_1] = VolumeMusicSongItem.New(var_17_0)
end

function V210MusicRewardView:UpdateRewardItem(arg_18_1, arg_18_2)
	if not arg_18_1 or not arg_18_2 then
		return
	end

	arg_18_1:SetData(arg_18_2)
end

function V210MusicRewardView:OnMusicRewardUpdate()
	self:UpdateMusicRewardList()
end

return V210MusicRewardView
