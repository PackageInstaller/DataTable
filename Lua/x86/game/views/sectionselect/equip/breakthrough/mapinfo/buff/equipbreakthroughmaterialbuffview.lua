local var_0_0 = class("EquipBreakThroughMaterialBuffView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.buffList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshBuffItem), arg_1_0.buffUIList_, EquipBreakThroughMaterialBuffItem)
	arg_1_0.attributeList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshAttributeItem), arg_1_0.attributeUIList_, EquipBreakThroughMaterialAttributeItem)
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.buffDataList_ = EquipBreakThroughMaterialData:GetBuffList()

	arg_2_0.buffList_:StartScroll(#arg_2_0.buffDataList_)

	arg_2_0.attributeDataList_ = EquipBreakThroughMaterialData:GetAttributeList()
	arg_2_0.itemIDList_ = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.attributeDataList_) do
		table.insert(arg_2_0.itemIDList_, iter_2_0)
	end

	arg_2_0.attributeList_:StartScroll(#arg_2_0.itemIDList_)
end

function var_0_0.OnEixt(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0.buffList_:Dispose()

	arg_4_0.buffList_ = nil

	arg_4_0.attributeList_:Dispose()

	arg_4_0.attributeList_ = nil
end

function var_0_0.RefreshBuffItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.buffDataList_[arg_5_1])
end

function var_0_0.RefreshAttributeItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.itemIDList_[arg_6_1]

	arg_6_2:SetData(var_6_0, arg_6_0.attributeDataList_[var_6_0])
end

return var_0_0
