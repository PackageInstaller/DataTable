local MusicBottomFilterItem = class("MusicBottomFilterItem", ReduxView)

function MusicBottomFilterItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function MusicBottomFilterItem:Init()
	self:InitUI()
end

function MusicBottomFilterItem:InitUI()
	self:BindCfgUI()
end

function MusicBottomFilterItem:RefreshUI(arg_4_1, arg_4_2)
	self.filterValue = arg_4_1

	if arg_4_2 == MusicConst.MusicFilterType.tagFilterKey then
		self:UpdateTagUI()
	elseif arg_4_2 == MusicConst.MusicFilterType.verFilterKey then
		self:UpdateVersionUI()
	end
end

function MusicBottomFilterItem:UpdateVersionUI()
	self.nameText_.text = ActivityCfg[ActivityCfg.get_id_list_by_sub_activity_list[MusicConst.MusicViewRoutesName[MusicData:GetMusicTypeByTheme(self.filterValue)].activityID][1]].remark
end

function MusicBottomFilterItem:UpdateTagUI()
	self.nameText_.text = GetTips(MusicConst.MusicTagTips[self.filterValue])
end

function MusicBottomFilterItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function MusicBottomFilterItem:Dispose()
	MusicBottomFilterItem.super.Dispose(self)
end

return MusicBottomFilterItem
