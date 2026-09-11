local ToggleListView = class("ToggleListView", ReduxView)

function ToggleListView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.parentItemList_ = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		self.parentItemList_[iter_1_0] = ToggleParentView.New(self[string.format("toggleParent%s_", iter_1_0)], iter_1_0, iter_1_1)
	end

	self.childrenHandler_ = handler(self, self.ChildrenUpdate)
end

function ToggleListView:OnEnter()
	for iter_2_0, iter_2_1 in pairs(self.parentItemList_) do
		iter_2_1:OnEnter()
	end

	manager.notify:RegistListener(TOGGLE_LIST_CHILDREN_UPDATE, self.childrenHandler_)
end

function ToggleListView:OnExit()
	for iter_3_0, iter_3_1 in pairs(self.parentItemList_) do
		iter_3_1:OnExit()
	end

	manager.notify:RemoveListener(TOGGLE_LIST_CHILDREN_UPDATE, self.childrenHandler_)
end

function ToggleListView:Dispose()
	ToggleListView.super.Dispose(self)

	for iter_4_0, iter_4_1 in pairs(self.parentItemList_) do
		iter_4_1:Dispose()
	end

	self.parentItemList_ = nil
	self.childrenHandler_ = nil
end

function ToggleListView:SetSelectOn(arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(self.parentItemList_) do
		iter_5_1:SetSelectOn(arg_5_1, arg_5_2)
	end

	manager.notify:Invoke(TOGGLE_LIST_UPDATE, arg_5_1, arg_5_2)
end

function ToggleListView:ChildrenUpdate(arg_6_1, arg_6_2)
	self:SetSelectOn(arg_6_1, arg_6_2)
end

return ToggleListView
