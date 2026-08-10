local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("MomoTalkBaseItemView", var_0_0)
local var_0_2 = 0
local var_0_3 = "enter"

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitBase()
	arg_1_0:Init()
	arg_1_0:AddListeners()
end

function var_0_1.InitBase(arg_2_0)
	arg_2_0.describeLayoutGroup_ = arg_2_0.describeContent_ and arg_2_0.describeContent_:GetComponent("VerticalLayoutGroup") or nil
	arg_2_0.describeFitter_ = arg_2_0.describeContent_ and arg_2_0.describeContent_:GetComponent("ContentSizeFitter") or nil
	arg_2_0.describeLayoutLocked_ = false
	arg_2_0.lockDescribeTimer_ = nil
	arg_2_0.enterAnimator_ = arg_2_0.gameObject_ and arg_2_0.gameObject_:GetComponent(typeof(Animator)) or nil
end

function var_0_1.EnsureDescribeLayoutRefs(arg_3_0)
	if not arg_3_0.describeContent_ then
		return
	end

	if not arg_3_0.describeLayoutGroup_ then
		arg_3_0.describeLayoutGroup_ = arg_3_0.describeContent_:GetComponent("VerticalLayoutGroup")
	end

	if not arg_3_0.describeFitter_ then
		arg_3_0.describeFitter_ = arg_3_0.describeContent_:GetComponent("ContentSizeFitter")
	end
end

function var_0_1.Init(arg_4_0)
	return
end

function var_0_1.AddListeners(arg_5_0)
	return
end

function var_0_1.SetParent(arg_6_0, arg_6_1)
	if arg_6_0.transform_ and arg_6_1 then
		arg_6_0.transform_:SetParent(arg_6_1, false)
	end
end

function var_0_1.AttachContent(arg_7_0, arg_7_1)
	if not arg_7_0.describeContent_ or not arg_7_1 then
		return
	end

	if arg_7_1.SetParent then
		arg_7_1:SetParent(arg_7_0.describeContent_)
	elseif arg_7_1.gameObject_ then
		arg_7_1.gameObject_.transform:SetParent(arg_7_0.describeContent_, false)
	elseif arg_7_1.transform then
		arg_7_1.transform:SetParent(arg_7_0.describeContent_, false)
	end
end

function var_0_1.DetachContent(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 or not arg_8_2 then
		return
	end

	if arg_8_1.SetParent then
		arg_8_1:SetParent(arg_8_2)
	elseif arg_8_1.gameObject_ then
		arg_8_1.gameObject_.transform:SetParent(arg_8_2, false)
	elseif arg_8_1.transform then
		arg_8_1.transform:SetParent(arg_8_2, false)
	end
end

function var_0_1.StopLockDescribeTimer(arg_9_0)
	if arg_9_0.lockDescribeTimer_ then
		arg_9_0.lockDescribeTimer_:Stop()

		arg_9_0.lockDescribeTimer_ = nil
	end
end

function var_0_1.RestoreDescribeLayout(arg_10_0)
	arg_10_0:StopLockDescribeTimer()
	arg_10_0:EnsureDescribeLayoutRefs()

	if arg_10_0.describeLayoutGroup_ then
		arg_10_0.describeLayoutGroup_.enabled = true
	end

	if arg_10_0.describeFitter_ then
		arg_10_0.describeFitter_.enabled = true
	end

	arg_10_0.describeLayoutLocked_ = false
end

function var_0_1.LockDescribeLayout(arg_11_0)
	arg_11_0:EnsureDescribeLayoutRefs()

	if not arg_11_0.describeContent_ or arg_11_0.describeLayoutLocked_ then
		return
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.describeContent_)

	if arg_11_0.describeLayoutGroup_ then
		arg_11_0.describeLayoutGroup_.enabled = false
	end

	if arg_11_0.describeFitter_ then
		arg_11_0.describeFitter_.enabled = false
	end

	arg_11_0.describeLayoutLocked_ = true
end

function var_0_1.DelayLockDescribeLayout(arg_12_0, arg_12_1)
	arg_12_0:StopLockDescribeTimer()

	if not arg_12_0.describeContent_ then
		return
	end

	arg_12_0.lockDescribeTimer_ = Timer.New(function()
		arg_12_0.lockDescribeTimer_ = nil

		if not arg_12_0.gameObject_ or isNil(arg_12_0.gameObject_) then
			return
		end

		if not arg_12_0.gameObject_.activeInHierarchy then
			return
		end

		arg_12_0:LockDescribeLayout()
	end, arg_12_1 or 0.01, 1)

	arg_12_0.lockDescribeTimer_:Start()
end

function var_0_1.PlayOuterEnterAnimation(arg_14_0)
	if not arg_14_0.gameObject_ or isNil(arg_14_0.gameObject_) or not arg_14_0.gameObject_.activeInHierarchy then
		return
	end

	if not arg_14_0.enterAnimator_ then
		return
	end

	local var_14_0 = Animator.StringToHash(var_0_3)

	if not arg_14_0.enterAnimator_:HasState(var_0_2, var_14_0) then
		return
	end

	arg_14_0.enterAnimator_:Play(var_0_3, var_0_2, 0)
	arg_14_0.enterAnimator_:Update(0)
end

function var_0_1.Reset(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:EnsureDescribeLayoutRefs()
	arg_15_0:RestoreDescribeLayout()

	arg_15_0.cfg_ = arg_15_1
	arg_15_0.itemData_ = arg_15_2
	arg_15_0.index_ = arg_15_3

	arg_15_0:OnReset(arg_15_1, arg_15_2)
	arg_15_0:RebuildLayout()
end

function var_0_1.OnReset(arg_16_0, arg_16_1, arg_16_2)
	return
end

function var_0_1.RebuildLayout(arg_17_0)
	if arg_17_0.describeContent_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.describeContent_)
	end

	if arg_17_0.rectGo_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.rectGo_)
	elseif arg_17_0.transform_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.transform_)
	end
end

function var_0_1.GetItemHeight(arg_18_0)
	local var_18_0 = arg_18_0.rectGo_ or arg_18_0.transform_

	if var_18_0 then
		return var_18_0.sizeDelta.y
	end

	return 0
end

function var_0_1.IsActive(arg_19_0)
	if arg_19_0.loopRemoveActiveSnapshot_ ~= nil then
		local var_19_0 = arg_19_0.loopRemoveActiveSnapshot_

		arg_19_0.loopRemoveActiveSnapshot_ = nil

		return var_19_0
	end

	return arg_19_0.gameObject_ and arg_19_0.gameObject_.activeSelf == true
end

function var_0_1.MarkLoopRemoving(arg_20_0)
	arg_20_0.loopRemoveActiveSnapshot_ = arg_20_0.gameObject_ and arg_20_0.gameObject_.activeSelf == true
end

function var_0_1.SetAsLastSibling(arg_21_0)
	if arg_21_0.transform_ then
		arg_21_0.transform_:SetAsLastSibling()
	end
end

function var_0_1.SetAsFirstSibling(arg_22_0)
	if arg_22_0.transform_ then
		arg_22_0.transform_:SetAsFirstSibling()
	end
end

function var_0_1.Show(arg_23_0, arg_23_1)
	if not arg_23_1 then
		arg_23_0:RestoreDescribeLayout()
	elseif arg_23_1 then
		arg_23_0.loopRemoveActiveSnapshot_ = nil
	end

	SetActive(arg_23_0.gameObject_, arg_23_1)
end

function var_0_1.Dispose(arg_24_0)
	arg_24_0:RestoreDescribeLayout()
	arg_24_0:RemoveAllListeners()

	if arg_24_0.gameObject_ then
		Object.Destroy(arg_24_0.gameObject_)

		arg_24_0.gameObject_ = nil
	end

	var_0_1.super.Dispose(arg_24_0)
end

return var_0_1
