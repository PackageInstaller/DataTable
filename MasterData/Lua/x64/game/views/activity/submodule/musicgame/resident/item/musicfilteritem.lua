local MusicFilterItem = class("MusicFilterItem", ReduxView)

function MusicFilterItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MusicFilterItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MusicFilterItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("select")
end

function MusicFilterItem:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		manager.notify:Invoke(MUSIC_FILTER_CLICK_ITEM, self.filterKey, self.filterIndex, not self.isSelect)
	end)
end

function MusicFilterItem:UpdateSelect(arg_6_1)
	self.isSelect = arg_6_1

	self.selectController_:SetSelectedState(arg_6_1 and "select" or "normal")
end

function MusicFilterItem:RefreshUI(arg_7_1, arg_7_2, arg_7_3)
	self.filterIndex = arg_7_1
	self.filterValue = arg_7_2
	self.filterKey = arg_7_3

	if arg_7_3 == MusicConst.MusicFilterType.tagFilterKey then
		self:UpdateTagUI()
	elseif arg_7_3 == MusicConst.MusicFilterType.verFilterKey then
		self:UpdateVersionUI()
	end
end

function MusicFilterItem:UpdateVersionUI()
	self.tagTxt_.text = ActivityCfg[ActivityCfg.get_id_list_by_sub_activity_list[MusicConst.MusicViewRoutesName[MusicData:GetMusicTypeByTheme(self.filterValue)].activityID][1]].remark
end

function MusicFilterItem:UpdateTagUI()
	self.tagTxt_.text = GetTips(MusicConst.MusicTagTips[self.filterValue])
end

function MusicFilterItem:GetFilterValue()
	return self.filterValue
end

function MusicFilterItem:Dispose()
	MusicFilterItem.super.Dispose(self)
end

return MusicFilterItem
