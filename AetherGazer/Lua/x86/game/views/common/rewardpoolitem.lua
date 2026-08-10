local var_0_0 = class("RewardPoolItem", ReduxView)

function var_0_0.GetItemPath(arg_1_0)
	if arg_1_0.isSmall_ then
		return "UI/Common/CommonItemSmall"
	else
		return "UI/Common/CommonItem"
	end
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0.isSmall_ = arg_2_3
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	SetActive(arg_2_0.gameObject_, true)

	arg_2_0.commonItemGo_ = manager.objectPool:Get(arg_2_0:GetItemPath())
	arg_2_0.commonItem_ = CommonItem.New(arg_2_0.commonItemGo_)

	arg_2_0:SetParent()
	arg_2_0.commonItem_:ResetTransform()

	arg_2_0.clickCallback_ = arg_2_5
	arg_2_0.popType_ = arg_2_4 or POP_ITEM

	arg_2_0:ShowFloor(ItemConst.ITEM_FLOOR.LONG)

	if arg_2_2 then
		arg_2_0:SetData(arg_2_2, true)
	end
end

function var_0_0.SetParent(arg_3_0)
	arg_3_0.commonItemGo_.transform:SetParent(arg_3_0.transform_)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = rewardToItemTemplate(arg_4_1)

	arg_4_0.commonItem_:RefreshData(var_4_0)
	arg_4_0.commonItem_:RegistCallBack(function()
		if arg_4_0.clickCallback_ == nil or arg_4_0.clickCallback_() then
			ShowPopItem(arg_4_0.popType_, var_4_0)
		end
	end)

	if arg_4_2 ~= false then
		arg_4_2 = arg_4_2 or arg_4_0.commonItemGo_.activeSelf == false
	end

	arg_4_0:Show(true)

	if arg_4_2 then
		arg_4_0.commonItem_:UpdateAnimator()
	else
		arg_4_0.commonItem_:StopAnimator()
	end
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.commonItemGo_, arg_6_1)
end

function var_0_0.HideNum(arg_7_0)
	arg_7_0.commonItem_:HideNum()
	arg_7_0.commonItem_:HideServantTxt()
end

function var_0_0.ShowFloor(arg_8_0, arg_8_1)
	arg_8_0.commonItem_:ShowFloor(arg_8_1)
end

function var_0_0.HideServantTxt(arg_9_0)
	arg_9_0.commonItem_:HideServantTxt()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.commonItem_.mainAni_.speed = 1

	arg_10_0.commonItem_:Dispose()

	arg_10_0.commonItem_ = nil

	local var_10_0 = arg_10_0.commonItemGo_:GetComponentsInChildren(typeof(Animator), true)

	for iter_10_0, iter_10_1 in pairs(var_10_0:ToTable()) do
		iter_10_1.enabled = true
	end

	local var_10_1 = arg_10_0.commonItemGo_:GetComponentsInChildren(typeof(CanvasGroup), true)

	for iter_10_2, iter_10_3 in pairs(var_10_1:ToTable()) do
		iter_10_3.alpha = 1
	end

	manager.objectPool:Return(arg_10_0:GetItemPath(), arg_10_0.commonItemGo_)
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.SetSiblingIndex(arg_11_0, arg_11_1)
	arg_11_0.commonItem_:SetIndex(arg_11_1)
end

return var_0_0
