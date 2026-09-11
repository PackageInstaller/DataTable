local SPHeroChallengeScheduleTypeItem = class("SPHeroChallengeScheduleTypeItem", ReduxView)

function SPHeroChallengeScheduleTypeItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.type = arg_1_3
	self.gameObject_ = GameObject.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SPHeroChallengeScheduleTypeItem:Init()
	self:InitUI()
	self:InitItem()
end

function SPHeroChallengeScheduleTypeItem:InitUI()
	self:BindCfgUI()
end

function SPHeroChallengeScheduleTypeItem:InitItem()
	self.typeName.text = SPHeroChallengeTools:GetScheduleTypeName(self.type)

	if ActivityHeroChallengeScheduleCfg.get_id_list_by_type[self.type] and not self.scheduleList then
		self.scheduleList = {}

		for iter_4_0, iter_4_1 in ipairs(ActivityHeroChallengeScheduleCfg.get_id_list_by_type[self.type]) do
			self.scheduleList[iter_4_1] = SPHeroChallengeScheduleDailyItem.New(self.scheduleItem, self.contentTrs_, iter_4_1)
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function SPHeroChallengeScheduleTypeItem:RefreshUI()
	if self.scheduleList then
		for iter_5_0, iter_5_1 in pairs(self.scheduleList) do
			if iter_5_1:RefreshUI() then
				iter_5_1.transform_:SetAsLastSibling()
			end
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	end
end

function SPHeroChallengeScheduleTypeItem:Dispose()
	if self.scheduleList then
		for iter_6_0, iter_6_1 in pairs(self.scheduleList) do
			iter_6_1:Dispose()
		end
	end

	self.gameObject_ = nil
	self.transform_ = nil

	SPHeroChallengeScheduleTypeItem.super.Dispose(self)
end

return SPHeroChallengeScheduleTypeItem
