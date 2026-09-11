local CommonFilterItem = class("CommonFilterItem", ReduxView)

function CommonFilterItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.filterContext = arg_1_2

	self:Init()
end

function CommonFilterItem:Init()
	self:InitUI()
	self:AddListeners()

	self.oldIsFlag = false
end

function CommonFilterItem:InitUI()
	self:BindCfgUI()

	self.SelectController = ControllerUtil.GetController(self.controllerObj_, "select")
end

function CommonFilterItem:AddListeners()
	self:AddBtnListener(self.clickBtn_, nil, handler(self, self.OnBtnClick))
end

function CommonFilterItem:Refresh(arg_5_1, arg_5_2, arg_5_3)
	self.filter_id = arg_5_1
	self.group_id = arg_5_2
	self.tagId = arg_5_3

	local var_5_0 = CommonFilterConst.GetFilterTagCfg(arg_5_3)

	if not var_5_0 then
		return
	end

	self.isFlag = self.filterContext:HasIndexFlag(self.group_id, arg_5_3)

	if self.isFlag ~= self.oldIsFlag then
		self.oldIsFlag = self.isFlag

		self.SelectController:SetSelectedState(self.isFlag and "on" or "off")
	end

	if var_5_0.atlasName and var_5_0.atlasName ~= "" then
		SetActive(self.tagImg_.gameObject, true)

		self.tagImg_.sprite = getSprite(var_5_0.atlasName, var_5_0.spriteName)
		self.tagTxt_.text = GetTips(var_5_0.name)
	else
		SetActive(self.tagImg_.gameObject, false)

		self.tagTxt_.text = GetTips(var_5_0.name)
	end
end

function CommonFilterItem:Dispose()
	Object.Destroy(self.gameObject_)
	CommonFilterItem.super.Dispose(self)
end

function CommonFilterItem:OnBtnClick()
	local var_7_1 = self.isFlag and self.filterContext:DeSelectTag(self.group_id, self.tagId) or self.filterContext:SelectTag(self.group_id, self.tagId)

	manager.notify:Invoke("OnCommonFilterItemClick", {
		gId = self.group_id,
		tId = self.tagId
	})
end

return CommonFilterItem
