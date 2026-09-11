local MusicGourpItem = class("MusicGourpItem", ReduxView)

function MusicGourpItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MusicGourpItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.musicItemList = {}
end

function MusicGourpItem:InitUI()
	self:BindCfgUI()

	self.toggleController_ = ControllerUtil.GetController(self.titleNode_, "toggle")
	self.openController_ = self.controller_:GetController("open")
	self.newController_ = self.controller_:GetController("new")
	self.isOpen = true
end

function MusicGourpItem:SetCreateMusicItemFunc(arg_4_1)
	self.createMusicCallback = arg_4_1
end

function MusicGourpItem:AddUIListener()
	self:AddBtnListener(self.openBtn_, nil, function()
		self:ChangeOpenState()
	end)
end

function MusicGourpItem:GetActivityID()
	return self.activityID
end

function MusicGourpItem:GetMusicList()
	return self.musicList
end

function MusicGourpItem:GetTargetMusicSelectItem(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.musicItemList) do
		if iter_9_1:GetMusicActivityID() == arg_9_1 then
			return iter_9_1
		end
	end
end

function MusicGourpItem:SetData(arg_10_1, arg_10_2)
	self.activityID = arg_10_1
	self.musicList = arg_10_2

	self:RefreshUI()
	self:UpdateOpenStateUI()
end

function MusicGourpItem:RefreshUI()
	self.nameText_.text = ActivityCfg[ActivityCfg.get_id_list_by_sub_activity_list[self.activityID][1]].remark

	self.newController_:SetSelectedState(ActivityData:GetActivityIsOpen(ActivityCfg.get_id_list_by_sub_activity_list[self.activityID][1]) and "state1" or "state0")
end

function MusicGourpItem:ChangeOpenState()
	self.isOpen = not self.isOpen

	self:UpdateOpenStateUI()
end

function MusicGourpItem:UpdateOpenStateUI()
	self.toggleController_:SetSelectedState(self.isOpen and "on" or "off")
	self.openController_:SetSelectedState(self.isOpen and "on" or "off")

	if self.isOpen then
		self:UpdateMusicList()
	end
end

function MusicGourpItem:UpdateMusicList()
	for iter_14_0, iter_14_1 in ipairs(self.musicList) do
		self.musicItemList[iter_14_0] = self.musicItemList[iter_14_0] or self.createMusicCallback(self.container_)

		local var_14_0 = self.musicItemList[iter_14_0]

		self.musicItemList[iter_14_0]:Show(true)
		var_14_0:SetData(self.activityID, iter_14_1)
	end

	for iter_14_2 = #self.musicList + 1, #self.musicItemList do
		self.musicItemList[iter_14_2]:Show(false)
	end
end

function MusicGourpItem:Show(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

function MusicGourpItem:Dispose()
	for iter_16_0, iter_16_1 in pairs(self.musicItemList) do
		iter_16_1:Dispose()

		iter_16_1 = nil
	end

	self.musicItemList = {}

	MusicGourpItem.super.Dispose(self)
end

function MusicGourpItem:BindRed(arg_17_1)
	if self.musicItemList then
		for iter_17_0, iter_17_1 in pairs(self.musicItemList) do
			iter_17_1:BindRed(arg_17_1)
		end
	end
end

return MusicGourpItem
