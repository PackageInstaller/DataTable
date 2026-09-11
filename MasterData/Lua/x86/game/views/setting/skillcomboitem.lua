local SkillComboItem = class("SkillComboItem", ReduxView)

function SkillComboItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SkillComboItem:Init()
	self:InitUI()
end

function SkillComboItem:InitUI()
	self.skillSubList_ = {}

	self:BindCfgUI()
end

function SkillComboItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function SkillComboItem:RefreshData(arg_5_1, arg_5_2)
	if arg_5_1.desc and arg_5_1.desc ~= "" then
		self.descText_.text = GetI18NText(arg_5_1.desc)
	else
		self.descText_.gameObject:SetActive(false)
	end

	self.nameText_.text = GetI18NText(arg_5_1.name)

	if arg_5_1.list_icon[1] then
		self.panelTrs_.gameObject:SetActive(true)

		for iter_5_0, iter_5_1 in ipairs(self.skillSubList_) do
			iter_5_1:Show(false)
		end

		for iter_5_2, iter_5_3 in ipairs(arg_5_1.list_icon) do
			if self.skillSubList_[iter_5_2] == nil then
				self.skillSubList_[iter_5_2] = SkillComboSubItem.New((Object.Instantiate(self.skillGo_, self.panelTrs_)))
			end

			self.skillSubList_[iter_5_2]:Show(true)
			self.skillSubList_[iter_5_2]:RefreshData(arg_5_1, arg_5_2, iter_5_2)
		end
	else
		self.panelTrs_.gameObject:SetActive(false)
	end
end

function SkillComboItem:Dispose()
	SkillComboItem.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.skillSubList_) do
		iter_6_1:Dispose()
	end

	self.skillSubList_ = nil
end

return SkillComboItem
