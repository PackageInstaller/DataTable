local TangramRegionItem = class("TangramRegionItem", ReduxView)

function TangramRegionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.rotateAxis_ = Vector3.New(0, 0, -1)
end

function TangramRegionItem:OnExit()
	self:StopLeanTween()
	self:StopAnim()
end

function TangramRegionItem:Dispose()
	self:StopLeanTween()
	self:StopAnim()
	TangramRegionItem.super.Dispose(self)
end

function TangramRegionItem:SetData(arg_4_1)
	self.activityID_ = arg_4_1

	self:StopAnim()
end

function TangramRegionItem:GetPuzzleContent()
	return self.puzzleContentTrans_
end

function TangramRegionItem:SetTransParent(arg_6_1)
	self.originParent_ = self.transform_.parent

	self.transform_:SetParent(arg_6_1)
end

function TangramRegionItem:RecoverTrans()
	if self.originAngle_ then
		self.transform_:SetLocalEulerAngleOrigin(self.originAngle_)
	end

	self.originAngle_ = nil

	if self.originParent_ then
		self.transform_:SetParent(self.originParent_)

		self.originParent_ = nil
	end
end

function TangramRegionItem:PlayAutoPutAnim(arg_8_1)
	SetActive(self.rewardAnimGo_, true)
	self:PlayAnim(self.animator_, "JigsawPuzzleUI_regionItem", function()
		SetActive(self.rewardAnimGo_, false)

		if arg_8_1 then
			arg_8_1()
		end
	end)
end

function TangramRegionItem:PlayRewardAnim(arg_10_1)
	SetActive(self.rewardAnimGo_, true)
	self:PlayAnim(self.animator_, "JigsawPuzzleUI_regionItem", function()
		SetActive(self.rewardAnimGo_, false)

		if arg_10_1 then
			arg_10_1()
		end
	end)
end

function TangramRegionItem:StopAnim()
	if self.animtimer_ then
		self.animtimer_:Stop()

		self.animtimer_ = nil
	end

	self.animator_.enabled = false

	SetActive(self.rewardAnimGo_, false)
end

function TangramRegionItem:Rotate(arg_13_1, arg_13_2)
	self.originAngle_ = self.transform_:GetLocalEulerAngleOrigin()

	self:StopLeanTween()

	self.rotateLeanTween_ = LeanTween.rotateAroundLocal(self.gameObject_, self.rotateAxis_, arg_13_1, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		self:StopLeanTween()

		if arg_13_2 then
			arg_13_2()
		end
	end))
end

function TangramRegionItem:StopLeanTween()
	if self.rotateLeanTween_ then
		self.rotateLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.rotateLeanTween_.id)

		self.rotateLeanTween_ = nil
	end
end

function TangramRegionItem:PlayAnim(arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_1 then
		if arg_16_3 then
			arg_16_3()
		end

		return
	end

	arg_16_1.enabled = true

	arg_16_1:Play(arg_16_2, -1, 0)
	arg_16_1:Update(0)

	if self.animtimer_ then
		self.animtimer_:Stop()

		self.animtimer_ = nil
	end

	self.animtimer_ = Timer.New(function()
		local var_17_0 = arg_16_1:GetCurrentAnimatorStateInfo(0)

		if var_17_0:IsName(arg_16_2) and var_17_0.normalizedTime >= 1 then
			if self.animtimer_ ~= nil then
				self.animtimer_:Stop()

				self.animtimer_ = nil
			end

			SetActive(self.maskGo_, false)

			if arg_16_3 then
				arg_16_3()
			end
		end
	end, 0.033, -1)

	self.animtimer_:Start()
end

return TangramRegionItem
