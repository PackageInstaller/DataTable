RewardPoolItem = import("game.views.common.RewardPoolItem")

local var_0_0 = class("RewardPoolFactoryItem", RewardPoolItem)

function var_0_0.GetParentItemPath(arg_1_0)
	return "UI/MardukUI/MardukCommonItem"
end

function var_0_0.GetItemPath(arg_2_0)
	return "UI/Common/CommonItem"
end

function var_0_0.OnCtor(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.parentGo_ = Object.Instantiate(Asset.Load(arg_3_0:GetParentItemPath()), arg_3_1.transform)

	arg_3_0:BindCfgUI(arg_3_0.parentGo_)
	var_0_0.super.OnCtor(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)

	if arg_3_3 then
		arg_3_0.commonItem_:SetScale(Vector3(0.55, 0.569, 1))
	end
end

function var_0_0.SetParent(arg_4_0)
	arg_4_0.commonItemGo_.transform:SetParent(arg_4_0.parentGo_.transform)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	var_0_0.super.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:RefreshText(arg_5_1[2])
end

function var_0_0.RefreshText(arg_6_0, arg_6_1)
	arg_6_0:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	arg_6_0.commonItem_:HideNum()

	arg_6_0.num_.text = arg_6_1
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.commonItem_:ResetTransform()
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.parentGo_)

	arg_7_0.parentGo_ = nil
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.parentGo_, arg_8_1)
	var_0_0.super.Show(arg_8_0, arg_8_1)
end

return var_0_0
