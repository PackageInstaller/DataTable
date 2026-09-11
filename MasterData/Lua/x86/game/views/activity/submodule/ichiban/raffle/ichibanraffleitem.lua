local IchiBanRaffleItem = class("IchiBanRaffleItem", ReduxView)

function IchiBanRaffleItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.tempVector3_ = Vector3.New(0, 0, 0)
	self.parent_ = arg_1_2
	self.viewportTransform_ = arg_1_2.transform.parent
	self.width_ = self.viewportTransform_.rect.width / 2

	self:BindCfgUI()
	self:AddListeners()

	self.commonItem_ = CommonItemView.New(self.uiItem_, true)
	self.inkRawImage_ = self.uiInkImageTf_:GetComponent(typeof(RawImage))
	self.inkCoverCom_ = self.transform_:GetComponent(typeof(InkCoverPureGameManager))

	function self.inkCoverCom_.OnBeginDragFun(arg_2_0)
		manager.notify:Invoke(ICHIBAN_RAFFLE_STOP_GUIDE_TIME)
		self:AddRaffleTimer()
	end

	function self.inkCoverCom_.OnDragFun(arg_3_0)
		local var_3_0 = self.inkCoverCom_:GetCurrentProgress()

		if self.newValue_ ~= var_3_0 then
			self.drag_ = true
			self.newValue_ = var_3_0
		end
	end

	function self.inkCoverCom_.OnEndDragFun(arg_4_0)
		self:StopRaffleTimer()
		manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_scratch_stop", "")

		if self.inkCoverCom_:IsCompleted() then
			-- block empty
		else
			manager.notify:Invoke(ICHIBAN_RAFFLE_ADD_GUIDE_TIME)
		end
	end

	function self.inkCoverCom_.OnCompletedFun()
		manager.notify:Invoke(ICHIBAN_COMPLETED_RAFFLE)
		self.uiAnimator_:Play("Card_finish", 0)

		local var_5_0

		var_5_0 = LeanTween.alpha(self.uiInkImageTf_, 0, 0.8):setOnComplete(System.Action(function()
			var_5_0:setOnComplete(nil)
		end))
	end

	function self.inkCoverCom_.OnValueChangedFun(arg_7_0)
		return
	end

	self:Show(true)
end

function IchiBanRaffleItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	IchiBanRaffleItem.super.Dispose(self)

	self.inkCoverCom_.OnBeginDragFun = nil
	self.inkCoverCom_.OnDragFun = nil
	self.inkCoverCom_.OnEndDragFun = nil
	self.inkCoverCom_.OnCompletedFun = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function IchiBanRaffleItem:AddListeners()
	return
end

function IchiBanRaffleItem:OnExit()
	self.index_ = nil

	self:StopTimer()
	self:StopRaffleTimer()
end

function IchiBanRaffleItem:Show(arg_11_1)
	if arg_11_1 == false then
		self.tempVector3_.x = 1000000000000
		self.tempVector3_.y = 1000000000000
		self.tempVector3_.z = 1000000000000

		self:SetLocalPosition(self.tempVector3_)
	else
		SetActive(self.gameObject_, arg_11_1)
	end
end

function IchiBanRaffleItem:SetLocalPosition(arg_12_1)
	self.transform_.localPosition = arg_12_1
end

function IchiBanRaffleItem:GetLocalPosition()
	return self.transform_.localPosition + self.parent_.transform.localPosition
end

function IchiBanRaffleItem:SetIndex(arg_14_1, arg_14_2, arg_14_3)
	self.isSelected_ = arg_14_2
	self.activityID_ = arg_14_3
	self.inkCoverCom_.enabled = arg_14_2

	SetActive(self.uiMask_, not arg_14_2)

	if self.index_ == arg_14_1 then
		return
	end

	self.inkRawImage_.color = Color.New(self.inkRawImage_.color.r, self.inkRawImage_.color.g, self.inkRawImage_.color.b, 1)

	self.uiAnimator_:Play("New State")
	self:AddUpdate()

	self.index_ = arg_14_1

	self:Show(true)
	self:RefreshUI()
	self.inkCoverCom_:Reset()
end

function IchiBanRaffleItem:GetIndex()
	return self.index_
end

function IchiBanRaffleItem:AddRaffleTimer()
	self:StopRaffleTimer()

	local var_16_0 = self.inkCoverCom_:GetCurrentProgress()
	local var_16_1 = false
	local var_16_2 = 0

	self.raffleTimer_ = FrameTimer.New(function()
		var_16_2 = var_16_2 + 1

		if self.drag_ then
			self.drag_ = false
			var_16_2 = 0
			var_16_1 = true

			manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_scratch", "")
		elseif var_16_2 >= 10 and var_16_1 then
			var_16_1 = false

			manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_scratch_stop", "")
		end
	end, 1, -1)

	self.raffleTimer_:Start()
end

function IchiBanRaffleItem:StopRaffleTimer()
	if self.raffleTimer_ then
		manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_scratch_stop", "")
		self.raffleTimer_:Stop()

		self.raffleTimer_ = nil
	end
end

function IchiBanRaffleItem:AddUpdate()
	self:StopTimer()
	self:CalcScale()

	self.timer_ = FrameTimer.New(function()
		self:CalcScale()
	end, 1, -1)

	self.timer_:Start()
end

function IchiBanRaffleItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function IchiBanRaffleItem:CalcScale()
	local var_22_0 = math.abs(self:GetLocalPosition().x - self.width_)

	if var_22_0 < self.width_ * 2 then
		self:Scale(1 - var_22_0 / (self.width_ * 4))
	end
end

function IchiBanRaffleItem:Scale(arg_23_1)
	self.tempVector3_.x = arg_23_1
	self.tempVector3_.y = arg_23_1
	self.tempVector3_.z = 1
	self.transform_.localScale = self.tempVector3_
end

function IchiBanRaffleItem:RefreshUI()
	local var_24_0 = IchiBanData:GetUISeqList(self.activityID_)[self.index_]
	local var_24_1 = clone(ItemTemplateData)

	var_24_1.id = var_24_0.reward[1].id
	var_24_1.number = var_24_0.reward[1].num

	function var_24_1:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id
		})
	end

	self.commonItem_:SetData(var_24_1)

	self.uiLevelImage_.sprite = pureGetSpriteWithoutAtlas(IchiBanTeaserCfg[IchiBanTeaserCfg.get_id_list_by_activity_id[self.activityID_][var_24_0.level]].level_pic)
	self.uiLevelText_.text = var_24_0.level == 1 and GetTips("ICHIBAN_PRIZE_LEVEL_XL") or var_24_0.level == 2 and GetTips("ICHIBAN_PRIZE_LEVEL_L") or var_24_0.level == 3 and GetTips("ICHIBAN_PRIZE_LEVEL_M") or GetTips("ICHIBAN_PRIZE_LEVEL_S")
end

return IchiBanRaffleItem
