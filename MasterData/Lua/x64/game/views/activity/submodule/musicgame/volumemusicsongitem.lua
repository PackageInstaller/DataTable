local VolumeMusicSongItem = class("VolumeMusicSongItem", ReduxView)

function VolumeMusicSongItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function VolumeMusicSongItem:Init()
	self:InitUI()
end

function VolumeMusicSongItem:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, VolumeMusicRewardItem)
end

function VolumeMusicSongItem:SetData(arg_4_1)
	self.music_id = arg_4_1

	self:Refresh()
end

function VolumeMusicSongItem:Refresh()
	self.rewards = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[self.music_id] or {}) do
		if ActivityMusicCfg[iter_5_1] and #ActivityMusicCfg[iter_5_1].reward > 0 then
			table.insert(self.rewards, iter_5_1)
		end
	end

	local var_5_1 = ActivityData:GetActivityData(self.music_id)

	self.m_name.text = var_5_1 and var_5_1:IsActivitying() and (ActivityMusicCfg[self.rewards[1]] and GetI18NText(ActivityMusicCfg[self.rewards[1]].name) or "") or "???"

	self.list_:StartScroll((math.min(#self.rewards, 2)))
end

function VolumeMusicSongItem:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.rewards[arg_6_1])
end

function VolumeMusicSongItem:Dispose()
	self.list_:Dispose()
	VolumeMusicSongItem.super.Dispose(self)
end

return VolumeMusicSongItem
