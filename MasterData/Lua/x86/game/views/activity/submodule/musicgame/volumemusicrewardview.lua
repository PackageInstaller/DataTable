local VolumeMusicRewardView = class("VolumeMusicRewardView", ReduxView)

function VolumeMusicRewardView:UIName()
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicRewardUI"
end

function VolumeMusicRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function VolumeMusicRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeMusicRewardView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, VolumeMusicSongItem)
end

function VolumeMusicRewardView:AddUIListener()
	self:AddBtnListener(self.m_mask, nil, function()
		self:Back()
	end)
end

function VolumeMusicRewardView:OnTop()
	manager.windowBar:SwitchBar({})
end

function VolumeMusicRewardView:OnEnter()
	self.activity_id = self.params_.activity_id
	self.musics = {}

	for iter_8_0, iter_8_1 in ipairs(ActivityCfg[self.activity_id].sub_activity_list) do
		if ActivityCfg[iter_8_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(self.musics, iter_8_1)
		end
	end

	table.sort(self.musics, function(arg_9_0, arg_9_1)
		local var_9_0 = self:GetState(arg_9_0)
		local var_9_1 = self:GetState(arg_9_1)

		if var_9_0 ~= var_9_1 then
			return var_9_1 < var_9_0
		else
			return arg_9_0 < arg_9_1
		end
	end)
	self.list_:StartScroll(#self.musics)
end

function VolumeMusicRewardView:GetState(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[arg_10_1]) do
		if (ActivityMusicCfg[iter_10_1].difficult == 1 or ActivityMusicCfg[iter_10_1].difficult == 2) and MusicData:GetRewardState(iter_10_1) == 1 then
			return 1
		end
	end

	return 0
end

function VolumeMusicRewardView:OnExit()
	manager.windowBar:HideBar()
end

function VolumeMusicRewardView:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.musics[arg_12_1])
end

function VolumeMusicRewardView:Dispose()
	self.list_:Dispose()
	VolumeMusicRewardView.super.Dispose(self)
end

function VolumeMusicRewardView:OnMusicRewardUpdate()
	for iter_14_0, iter_14_1 in pairs((self.list_:GetItemList())) do
		iter_14_1:Refresh()
	end
end

return VolumeMusicRewardView
