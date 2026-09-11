local ToggleParentView = class("ToggleParentView", ReduxView)

function ToggleParentView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2
	self.childrenCnt_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.childrenItemList_ = {}

	for iter_1_0 = 1, arg_1_3 do
		self.childrenItemList_[iter_1_0] = ToggleChildrenView.New(self[string.format("toggleChildren%s_", iter_1_0)], arg_1_2, iter_1_0)
	end

	self.controller_ = ControllerUtil.GetController(self.toggle_.transform, "toggle")
end

function ToggleParentView:AddListeners()
	self:AddBtnListener(self.toggle_, nil, function()
		manager.notify:Invoke(TOGGLE_LIST_CHILDREN_UPDATE, self.index_, self.childrenIndex_)
	end)
end

function ToggleParentView:Dispose()
	ToggleParentView.super.Dispose(self)

	for iter_4_0, iter_4_1 in pairs(self.childrenItemList_) do
		iter_4_1:Dispose()
	end

	self.childrenItemList_ = nil
end

function ToggleParentView:SetSelectOn(arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(self.childrenItemList_) do
		iter_5_1:SetSelectOn(arg_5_2)
	end

	local var_5_0 = self.index_ == arg_5_1

	if self.index_ == arg_5_1 then
		self.controller_:SetSelectedState("on")

		self.childrenIndex_ = arg_5_2
	else
		self.controller_:SetSelectedState("off")
	end

	SetActive(self.goChildren_, var_5_0)
end

return ToggleParentView
