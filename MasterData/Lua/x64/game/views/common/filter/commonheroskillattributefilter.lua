local CommonHeroSkillAttributeFilter = class("CommonHeroSkillAttributeFilter", ReduxView)

function CommonHeroSkillAttributeFilter:UIName()
	return "Widget/Common/Com_Prefab/Com_Paging"
end

function CommonHeroSkillAttributeFilter:OnCtor(arg_2_1)
	self.gameObject_ = arg_2_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CommonHeroSkillAttributeFilter:Init()
	self:InitUI()
end

function CommonHeroSkillAttributeFilter:InitUI()
	self:BindCfgUI()
	self:InitAttributeItem()

	self.selectAttributeHandler_ = handler(self, self.OnSelectAttribute)
end

function CommonHeroSkillAttributeFilter:InitAttributeItem()
	self.attributeItemList_ = {}
end

function CommonHeroSkillAttributeFilter:SetAttributeIdList(arg_6_1)
	self.attributeIdList_ = arg_6_1
end

function CommonHeroSkillAttributeFilter:SetNeedName(arg_7_1)
	self.needName_ = arg_7_1
end

function CommonHeroSkillAttributeFilter:Reset()
	self.selectAttributeId_ = nil
end

function CommonHeroSkillAttributeFilter:Refresh()
	self:UpdateAttributeIdList()
	self:RefreshAttributeItemList()
	self:InitSelectAttributeId()
end

function CommonHeroSkillAttributeFilter:InitSelectAttributeId()
	local var_10_1

	if self.selectAttributeId_ then
		var_10_1 = self.selectAttributeId_
		self.selectAttributeId_ = nil
	else
		var_10_1 = self.attributeIdList_[1]
	end

	self:OnSelectAttribute(var_10_1, (var_10_1 == self.attributeIdList_[1] or nil) and true)
end

function CommonHeroSkillAttributeFilter:UpdateAttributeIdList()
	self.attributeIdList_ = self.attributeIdList_ or CommonFilterConst.GetDefaultHeroAttributeIdList()
end

function CommonHeroSkillAttributeFilter:RefreshAttributeItemList()
	for iter_12_0, iter_12_1 in ipairs(self.attributeIdList_) do
		self.attributeItemList_[iter_12_0] = self.attributeItemList_[iter_12_0] or self:GreateItem()

		self.attributeItemList_[iter_12_0]:SetData(iter_12_1)
		self.attributeItemList_[iter_12_0]:SetNeedName(self.needName_)
		self.attributeItemList_[iter_12_0]:Show(true)
	end

	for iter_12_2 = #self.attributeIdList_ + 1, #self.attributeItemList_ do
		self.attributeItemList_[iter_12_2]:Show(false)
	end
end

function CommonHeroSkillAttributeFilter:SetSelectAttributeCallback(arg_13_1)
	self.selectAttributeCallback_ = arg_13_1
end

function CommonHeroSkillAttributeFilter:OnSelectAttribute(arg_14_1, arg_14_2)
	if arg_14_1 == self.selectAttributeId_ then
		return
	end

	self.selectAttributeId_ = arg_14_1
	self.isAll_ = arg_14_2

	self:RefreshSelectStatus()

	if self.selectAttributeCallback_ then
		self.selectAttributeCallback_(arg_14_1, self.isAll_)
	end
end

function CommonHeroSkillAttributeFilter:RefreshSelectStatus()
	for iter_15_0, iter_15_1 in ipairs(self.attributeItemList_) do
		iter_15_1:RefreshSelect(iter_15_1:GetId() == self.selectAttributeId_)
	end
end

function CommonHeroSkillAttributeFilter:Dispose()
	for iter_16_0, iter_16_1 in ipairs(self.attributeItemList_) do
		iter_16_1:Dispose()
	end

	self.attributeItemList_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	CommonHeroSkillAttributeFilter.super.Dispose(self)
end

function CommonHeroSkillAttributeFilter:GetItemClass()
	return CommonHeroSkillAttributeFilterItem
end

function CommonHeroSkillAttributeFilter:GreateItem()
	local var_18_0 = self:GetItemClass().New((Object.Instantiate(self.itemGo_, self.itemContenTrans_)))

	var_18_0:SetSelectCallBack(self.selectAttributeHandler_)

	return var_18_0
end

return CommonHeroSkillAttributeFilter
