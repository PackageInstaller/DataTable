local MomoTalkBaseItemView = class("MomoTalkBaseItemView", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))
local var_0_1 = 0
local var_0_2 = "enter"

function MomoTalkBaseItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:InitBase()
	self:Init()
	self:AddListeners()
end

function MomoTalkBaseItemView:InitBase()
	self.describeLayoutGroup_ = self.describeContent_ and self.describeContent_:GetComponent("VerticalLayoutGroup") or nil
	self.describeFitter_ = self.describeContent_ and self.describeContent_:GetComponent("ContentSizeFitter") or nil
	self.describeLayoutLocked_ = false
	self.lockDescribeTimer_ = nil
	self.enterAnimator_ = self.gameObject_ and self.gameObject_:GetComponent(typeof(Animator)) or nil
end

function MomoTalkBaseItemView:EnsureDescribeLayoutRefs()
	if not self.describeContent_ then
		return
	end

	self.describeLayoutGroup_ = self.describeLayoutGroup_ or self.describeContent_:GetComponent("VerticalLayoutGroup")
	self.describeFitter_ = self.describeFitter_ or self.describeContent_:GetComponent("ContentSizeFitter")
end

function MomoTalkBaseItemView:Init()
	return
end

function MomoTalkBaseItemView:AddListeners()
	return
end

function MomoTalkBaseItemView:SetParent(arg_6_1)
	if self.transform_ and arg_6_1 then
		self.transform_:SetParent(arg_6_1, false)
	end
end

function MomoTalkBaseItemView:AttachContent(arg_7_1)
	if not self.describeContent_ or not arg_7_1 then
		return
	end

	if arg_7_1.SetParent then
		arg_7_1:SetParent(self.describeContent_)
	elseif arg_7_1.gameObject_ then
		arg_7_1.gameObject_.transform:SetParent(self.describeContent_, false)
	elseif arg_7_1.transform then
		arg_7_1.transform:SetParent(self.describeContent_, false)
	end
end

function MomoTalkBaseItemView:DetachContent(arg_8_1, arg_8_2)
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

function MomoTalkBaseItemView:StopLockDescribeTimer()
	if self.lockDescribeTimer_ then
		self.lockDescribeTimer_:Stop()

		self.lockDescribeTimer_ = nil
	end
end

function MomoTalkBaseItemView:RestoreDescribeLayout()
	self:StopLockDescribeTimer()
	self:EnsureDescribeLayoutRefs()

	if self.describeLayoutGroup_ then
		self.describeLayoutGroup_.enabled = true
	end

	if self.describeFitter_ then
		self.describeFitter_.enabled = true
	end

	self.describeLayoutLocked_ = false
end

function MomoTalkBaseItemView:LockDescribeLayout()
	self:EnsureDescribeLayoutRefs()

	if not self.describeContent_ or self.describeLayoutLocked_ then
		return
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.describeContent_)

	if self.describeLayoutGroup_ then
		self.describeLayoutGroup_.enabled = false
	end

	if self.describeFitter_ then
		self.describeFitter_.enabled = false
	end

	self.describeLayoutLocked_ = true
end

function MomoTalkBaseItemView:DelayLockDescribeLayout(arg_12_1)
	self:StopLockDescribeTimer()

	if not self.describeContent_ then
		return
	end

	self.lockDescribeTimer_ = Timer.New(function()
		self.lockDescribeTimer_ = nil

		if not self.gameObject_ or isNil(self.gameObject_) then
			return
		end

		if not self.gameObject_.activeInHierarchy then
			return
		end

		self:LockDescribeLayout()
	end, arg_12_1 or 0.01, 1)

	self.lockDescribeTimer_:Start()
end

function MomoTalkBaseItemView:PlayOuterEnterAnimation()
	if not self.gameObject_ or isNil(self.gameObject_) or not self.gameObject_.activeInHierarchy then
		return
	end

	if not self.enterAnimator_ then
		return
	end

	if not self.enterAnimator_:HasState(var_0_1, (Animator.StringToHash(var_0_2))) then
		return
	end

	self.enterAnimator_:Play(var_0_2, var_0_1, 0)
	self.enterAnimator_:Update(0)
end

function MomoTalkBaseItemView:Reset(arg_15_1, arg_15_2, arg_15_3)
	self:EnsureDescribeLayoutRefs()
	self:RestoreDescribeLayout()

	self.cfg_ = arg_15_1
	self.itemData_ = arg_15_2
	self.index_ = arg_15_3

	self:OnReset(arg_15_1, arg_15_2)
	self:RebuildLayout()
end

function MomoTalkBaseItemView:OnReset(arg_16_1, arg_16_2)
	return
end

function MomoTalkBaseItemView:RebuildLayout()
	if self.describeContent_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.describeContent_)
	end

	if self.rectGo_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGo_)
	elseif self.transform_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
	end
end

function MomoTalkBaseItemView:GetItemHeight()
	local var_18_0 = self.rectGo_ or self.transform_

	if var_18_0 then
		return var_18_0.sizeDelta.y
	end

	return 0
end

function MomoTalkBaseItemView:IsActive()
	if self.loopRemoveActiveSnapshot_ ~= nil then
		self.loopRemoveActiveSnapshot_ = nil

		return self.loopRemoveActiveSnapshot_
	end

	return self.gameObject_ and self.gameObject_.activeSelf == true
end

function MomoTalkBaseItemView:MarkLoopRemoving()
	self.loopRemoveActiveSnapshot_ = self.gameObject_ and self.gameObject_.activeSelf == true
end

function MomoTalkBaseItemView:SetAsLastSibling()
	if self.transform_ then
		self.transform_:SetAsLastSibling()
	end
end

function MomoTalkBaseItemView:SetAsFirstSibling()
	if self.transform_ then
		self.transform_:SetAsFirstSibling()
	end
end

function MomoTalkBaseItemView:Show(arg_23_1)
	if not arg_23_1 then
		self:RestoreDescribeLayout()
	elseif arg_23_1 then
		self.loopRemoveActiveSnapshot_ = nil
	end

	SetActive(self.gameObject_, arg_23_1)
end

function MomoTalkBaseItemView:Dispose()
	self:RestoreDescribeLayout()
	self:RemoveAllListeners()

	if self.gameObject_ then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
	end

	MomoTalkBaseItemView.super.Dispose(self)
end

return MomoTalkBaseItemView
