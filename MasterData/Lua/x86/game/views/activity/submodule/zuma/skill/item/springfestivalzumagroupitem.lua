local SpringFestivalZumaGroupItem = class("SpringFestivalZumaGroupItem", ReduxView)

function SpringFestivalZumaGroupItem:OnCtor(arg_1_1, arg_1_2)
	self.skillID = arg_1_2
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function SpringFestivalZumaGroupItem:InitUI()
	self.talentList = {}

	for iter_2_0, iter_2_1 in pairs((ZumaData:GetSkillGroupList(self.skillID))) do
		table.insert(self.talentList, (SpringFestivalBuffItem.New(self.gameObject_.transform:GetChild(iter_2_0 - 1).gameObject, iter_2_1)))
	end
end

function SpringFestivalZumaGroupItem:SetClickCallBack(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self.talentList) do
		iter_3_1:SetClickCallBack(arg_3_1)
	end
end

function SpringFestivalZumaGroupItem:RefreshUI()
	for iter_4_0, iter_4_1 in pairs(self.talentList) do
		iter_4_1:RefreshUI()
	end
end

function SpringFestivalZumaGroupItem:GetTargetTalentItem(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.talentList) do
		if iter_5_1:GetTalentID() == arg_5_1 then
			return iter_5_1
		end
	end

	return nil
end

function SpringFestivalZumaGroupItem:Dispose()
	for iter_6_0, iter_6_1 in pairs(self.talentList) do
		iter_6_1:Dispose()
	end

	SpringFestivalZumaGroupItem.super.Dispose(self)
end

return SpringFestivalZumaGroupItem
