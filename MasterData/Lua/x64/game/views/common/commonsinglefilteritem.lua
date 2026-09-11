local CommonSingleFilterItem = class("CommonSingleFilterItem", ReduxView)

function CommonSingleFilterItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.filterContext = arg_1_2

	self:Init()
end

function CommonSingleFilterItem:Init()
	self:InitUI()
	self:AddListeners()
end

function CommonSingleFilterItem:InitUI()
	self:BindCfgUI()

	self.SelectController = self.controllerEx_:GetController("select")
end

function CommonSingleFilterItem:AddListeners()
	self:AddBtnListener(self.clickBtn_, nil, handler(self, self.OnBtnClick))
end

function CommonSingleFilterItem:Refresh(arg_5_1, arg_5_2, arg_5_3)
	self.filter_id = arg_5_1
	self.group_id = arg_5_2
	self.tagId = arg_5_3

	local var_5_0 = CommonFilterConst.GetFilterTagCfg(arg_5_3)

	if not var_5_0 then
		return
	end

	self.isFlag = self.filterContext:HasIndexFlag(self.group_id, arg_5_3)

	self.SelectController:SetSelectedState(self.isFlag and "select" or "normal")

	self.tagTxt_.text = GetTips(var_5_0.name)
end

function CommonSingleFilterItem:Dispose()
	Object.Destroy(self.gameObject_)
	CommonSingleFilterItem.super.Dispose(self)
end

function CommonSingleFilterItem:OnBtnClick()
	local var_7_1 = self.isFlag and self.filterContext:DeSelectTag(self.group_id, self.tagId) or self.filterContext:SelectTag(self.group_id, self.tagId)

	manager.notify:Invoke("OnCommonFilterItemClick", {
		gId = self.group_id,
		tId = self.tagId
	})
end

return CommonSingleFilterItem
