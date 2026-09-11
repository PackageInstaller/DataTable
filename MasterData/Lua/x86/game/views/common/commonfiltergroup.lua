local CommonFilterGroup = class("CommonFilterGroup", ReduxView)

function CommonFilterGroup:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.items = {}
	self.alreadyBuild = false
	self.filterContext = arg_1_2

	self:Init()
end

function CommonFilterGroup:Refresh(arg_2_1, arg_2_2)
	local var_2_0 = CommonFilterConst.GetGroupCfg(arg_2_2)

	self.titleTxt_.text = GetTips(var_2_0.title)

	local var_2_1 = CommonFilterConst.GetFilterList(arg_2_2)

	if not var_2_1 then
		return
	end

	local var_2_2 = #var_2_1

	self:BuildLayout(var_2_2, var_2_0.mode or Filter_Group_Mode.MultiMode)

	for iter_2_0 = 1, var_2_2 do
		self.items[iter_2_0]:Refresh(arg_2_1, arg_2_2, var_2_1[iter_2_0])
	end
end

function CommonFilterGroup:BuildLayout(arg_3_1, arg_3_2)
	if self.alreadyBuild then
		return
	end

	self.alreadyBuild = true

	for iter_3_0 = 1, #self.items do
		self.items[iter_3_0]:Dispose()
	end

	self.items = {}

	for iter_3_1 = 1, arg_3_1 do
		if arg_3_2 == Filter_Group_Mode.SingleMode then
			table.insert(self.items, (CommonSingleFilterItem.New(Object.Instantiate(self.singleFilterItemObj_, self.singleContent_), self.filterContext)))
		else
			table.insert(self.items, (CommonFilterItem.New(Object.Instantiate(self.commonFilterItemObj_, self.content_), self.filterContext)))
		end
	end
end

function CommonFilterGroup:Init()
	self:InitUI()
	self:AddListeners()
end

function CommonFilterGroup:InitUI()
	self:BindCfgUI()
end

function CommonFilterGroup:AddListeners()
	return
end

function CommonFilterGroup:Dispose()
	Object.Destroy(self.gameObject_)

	for iter_7_0 = 1, #self.items do
		self.items[iter_7_0]:Dispose()
	end

	CommonFilterGroup.super.Dispose(self)
end

return CommonFilterGroup
