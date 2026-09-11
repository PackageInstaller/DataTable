local CommonFilterView = class("CommonFilterView", ReduxView)

function CommonFilterView:UIName()
	return "Widget/Common/Pop/CommonFilterView/CommonFilterView"
end

function CommonFilterView:UIParent()
	return manager.ui.uiPop.transform
end

function CommonFilterView:Init()
	self:InitUI()
	self:AddUIListeners()

	self.OnCommonFilterItemClick = handler(self, self.OnItemClick)
	self.items = {}
end

function CommonFilterView:InitUI()
	self:BindCfgUI()
	self:RegisteBottomComponent()
end

function CommonFilterView:AddUIListeners()
	if self.maskBtn_ then
		self:AddBtnListener(self.maskBtn_, nil, handler(self, self.Back))
	end

	if self.cancelBtn_ then
		self:AddBtnListener(self.cancelBtn_, nil, handler(self, self.Back))
	end

	if self.allBtn_ then
		self:AddBtnListener(self.allBtn_, nil, handler(self, self.OnBtnAllClick))
	end

	self:AddBtnListener(self.okBtn_, nil, handler(self, self.OnBtnOKClick))
end

function CommonFilterView:BuildContext()
	self.filterContext = CommonFilterData:GetFilterDataCopy(self.filter_id)
end

function CommonFilterView:OnEnter()
	manager.notify:RegistListener("OnCommonFilterItemClick", self.OnCommonFilterItemClick)

	self.filter_id = self.params_.filterGroup.filter_id
	self.filterGroup = self.params_.filterGroup.groupList

	if not self.filterGroup then
		print("CommonFilterView参数错误")

		return
	end

	self:BuildContext()

	self.count = #self.filterGroup

	self:BuildLayout()
	self:Refresh()
end

function CommonFilterView:BuildLayout()
	for iter_8_0 = 1, #self.items do
		self.items[iter_8_0]:Dispose()
	end

	self.items = {}

	for iter_8_1 = 1, self.count do
		table.insert(self.items, (CommonFilterGroup.New(Object.Instantiate(self.filterGroupObj_, self.content_), self.filterContext)))
	end
end

function CommonFilterView:OnItemClick(arg_9_1)
	self:CheckSingleState(arg_9_1)
	self:Refresh()
end

function CommonFilterView:Refresh()
	if self.AllController then
		self.isAll = self.filterContext:IsAll(self.filter_id)

		self.AllController:SetSelectedIndex(self.isAll and 1 or 0)
	end

	for iter_10_0 = 1, self.count do
		self.items[iter_10_0]:Refresh(self.filter_id, self.filterGroup[iter_10_0])
	end

	self:TryUpdateBottom()
end

function CommonFilterView:CheckSingleState(arg_11_1)
	for iter_11_0 = 1, self.count do
		local var_11_0 = CommonFilterConst.GetGroupCfg(self.filterGroup[iter_11_0])

		if arg_11_1.gId == self.filterGroup[iter_11_0] and var_11_0.mode == Filter_Group_Mode.SingleMode and not self.filterContext:AtLeastOneChooseGroup(self.filterGroup[iter_11_0]) then
			if arg_11_1.tId then
				self.filterContext:SelectTag(self.filterGroup[iter_11_0], arg_11_1.tId)
			else
				self.filterContext:SelectTag(self.filterGroup[iter_11_0], var_11_0.tags[1])
			end
		end
	end
end

function CommonFilterView:OnExit()
	manager.notify:RemoveListener("OnCommonFilterItemClick", self.OnCommonFilterItemClick)
end

function CommonFilterView:Dispose()
	for iter_13_0 = 1, #self.items do
		self.items[iter_13_0]:Dispose()
	end

	self:RemoveAllListeners()
	self:DisposeBottomView()
	CommonFilterView.super.Dispose(self)
end

function CommonFilterView:OnBtnAllClick()
	if self.isAll then
		return
	end

	self:Refresh()
end

function CommonFilterView:OnBtnOKClick()
	if not self.filterContext:CheckIsSame((CommonFilterData:GetFilterDataCopy(self.filter_id))) then
		CommonFilterData:ApplyFilterCopy(self.filterContext)
		manager.notify:CallUpdateFunc(COMMON_FILTER_OK)
		manager.notify:Invoke(COMMON_FILTER_OK)
	end

	self:Back()
end

function CommonFilterView:RegisteBottomComponent()
	if self.filterBottomObj_ and not self.filterBottomView then
		self.filterBottomView = CommonFilterBottom.New(self.filterBottomObj_)

		self.filterBottomView:RegisteClearBtnListener(handler(self, self.OnClearBtnClick))
	end
end

function CommonFilterView:OnClearBtnClick()
	self.filterContext:Clear()
	self:Refresh()
end

function CommonFilterView:TryUpdateBottom()
	self:RegisteBottomComponent()

	if self.filterBottomView then
		local var_18_0 = {}
		local var_18_1 = {}

		for iter_18_0, iter_18_1 in ipairs(self.filterGroup) do
			if CommonFilterConst.GetGroupCfg(iter_18_1).mode ~= Filter_Group_Mode.SingleMode then
				var_18_0[iter_18_1] = self.filterContext:GetGroupSelectedTags(iter_18_1)

				for iter_18_2, iter_18_3 in ipairs(var_18_0[iter_18_1]) do
					table.insert(var_18_1, {
						name = GetTips(CommonFilterConst.GetFilterTagCfg(iter_18_3).name)
					})
				end
			end
		end

		self.filterBottomView:Refresh(var_18_1)
	end
end

function CommonFilterView:DisposeBottomView()
	if self.filterBottomView then
		self.filterBottomView:Dispose()

		self.filterBottomView = nil
	end
end

return CommonFilterView
