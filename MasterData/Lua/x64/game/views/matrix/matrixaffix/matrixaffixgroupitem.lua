local MatrixAffixGroup = class("MatrixAffixGroup", ReduxView)

function MatrixAffixGroup:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MatrixAffixGroup:GetContainer()
	return self.transform_
end

function MatrixAffixGroup:Init()
	self:InitUI()
end

function MatrixAffixGroup:InitUI()
	self:BindCfgUI()

	self.items = {}
end

function MatrixAffixGroup:Refresh(arg_5_1, arg_5_2, arg_5_3)
	self.id = arg_5_1.id
	self.list = arg_5_1.list
	self.m_name.text = GetI18NText((getAffixName({
		self.id
	})))

	for iter_5_0 = 1, #self.list do
		self.items[iter_5_0] = self.items[iter_5_0] or MatrixSelectAffixItem.New((Object.Instantiate(self.m_item, self.m_content)))

		self.items[iter_5_0]:Refresh(self.list[iter_5_0], table.indexof(arg_5_2, self.list[iter_5_0]) and 2 or table.indexof(arg_5_3, self.list[iter_5_0]) and 1 or 0)
	end

	while #self.items > #self.list do
		SetActive(self.items[#self.items].gameObject_, false)
		self.items[#self.items]:Dispose()
		table.remove(self.items, #self.items)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function MatrixAffixGroup:RegistCallBack(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.items) do
		iter_6_1:RegistCallBack(arg_6_1)
	end
end

function MatrixAffixGroup:Dispose()
	self:RemoveAllListeners()

	if self.items then
		for iter_7_0, iter_7_1 in ipairs(self.items) do
			iter_7_1:Dispose()
		end

		self.items = nil
	end

	MatrixAffixGroup.super.Dispose(self)
end

return MatrixAffixGroup
