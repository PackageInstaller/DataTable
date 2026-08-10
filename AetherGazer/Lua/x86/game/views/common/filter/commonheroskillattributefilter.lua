local var_0_0 = class("CommonHeroSkillAttributeFilter", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Com_Prefab/Com_Paging"
end

function var_0_0.OnCtor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitAttributeItem()

	arg_4_0.selectAttributeHandler_ = handler(arg_4_0, arg_4_0.OnSelectAttribute)
end

function var_0_0.InitAttributeItem(arg_5_0)
	arg_5_0.attributeItemList_ = {}
end

function var_0_0.SetAttributeIdList(arg_6_0, arg_6_1)
	arg_6_0.attributeIdList_ = arg_6_1
end

function var_0_0.SetNeedName(arg_7_0, arg_7_1)
	arg_7_0.needName_ = arg_7_1
end

function var_0_0.Reset(arg_8_0)
	arg_8_0.selectAttributeId_ = nil
end

function var_0_0.Refresh(arg_9_0)
	arg_9_0:UpdateAttributeIdList()
	arg_9_0:RefreshAttributeItemList()
	arg_9_0:InitSelectAttributeId()
end

function var_0_0.InitSelectAttributeId(arg_10_0)
	local var_10_0 = false
	local var_10_1

	if arg_10_0.selectAttributeId_ then
		var_10_1 = arg_10_0.selectAttributeId_
		arg_10_0.selectAttributeId_ = nil
	else
		var_10_1 = arg_10_0.attributeIdList_[1]
	end

	if var_10_1 == arg_10_0.attributeIdList_[1] then
		var_10_0 = true
	end

	arg_10_0:OnSelectAttribute(var_10_1, var_10_0)
end

function var_0_0.UpdateAttributeIdList(arg_11_0)
	if not arg_11_0.attributeIdList_ then
		arg_11_0.attributeIdList_ = CommonFilterConst.GetDefaultHeroAttributeIdList()
	end
end

function var_0_0.RefreshAttributeItemList(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.attributeIdList_) do
		if not arg_12_0.attributeItemList_[iter_12_0] then
			arg_12_0.attributeItemList_[iter_12_0] = arg_12_0:GreateItem()
		end

		arg_12_0.attributeItemList_[iter_12_0]:SetData(iter_12_1)
		arg_12_0.attributeItemList_[iter_12_0]:SetNeedName(arg_12_0.needName_)
		arg_12_0.attributeItemList_[iter_12_0]:Show(true)
	end

	for iter_12_2 = #arg_12_0.attributeIdList_ + 1, #arg_12_0.attributeItemList_ do
		arg_12_0.attributeItemList_[iter_12_2]:Show(false)
	end
end

function var_0_0.SetSelectAttributeCallback(arg_13_0, arg_13_1)
	arg_13_0.selectAttributeCallback_ = arg_13_1
end

function var_0_0.OnSelectAttribute(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == arg_14_0.selectAttributeId_ then
		return
	end

	arg_14_0.selectAttributeId_ = arg_14_1
	arg_14_0.isAll_ = arg_14_2

	arg_14_0:RefreshSelectStatus()

	if arg_14_0.selectAttributeCallback_ then
		arg_14_0.selectAttributeCallback_(arg_14_1, arg_14_0.isAll_)
	end
end

function var_0_0.RefreshSelectStatus(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.attributeItemList_) do
		iter_15_1:RefreshSelect(iter_15_1:GetId() == arg_15_0.selectAttributeId_)
	end
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.attributeItemList_) do
		iter_16_1:Dispose()
	end

	arg_16_0.attributeItemList_ = nil

	Object.Destroy(arg_16_0.gameObject_)

	arg_16_0.gameObject_ = nil
	arg_16_0.transform_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.GetItemClass(arg_17_0)
	return CommonHeroSkillAttributeFilterItem
end

function var_0_0.GreateItem(arg_18_0)
	local var_18_0 = Object.Instantiate(arg_18_0.itemGo_, arg_18_0.itemContenTrans_)
	local var_18_1 = arg_18_0:GetItemClass().New(var_18_0)

	var_18_1:SetSelectCallBack(arg_18_0.selectAttributeHandler_)

	return var_18_1
end

return var_0_0
