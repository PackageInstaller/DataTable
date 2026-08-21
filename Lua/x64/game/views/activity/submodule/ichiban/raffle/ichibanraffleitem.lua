local var_0_0 = class("IchiBanRaffleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.tempVector3_ = Vector3.New(0, 0, 0)
	arg_1_0.parent_ = arg_1_2
	arg_1_0.viewportTransform_ = arg_1_2.transform.parent
	arg_1_0.width_ = arg_1_0.viewportTransform_.rect.width / 2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.uiItem_, true)
	arg_1_0.inkRawImage_ = arg_1_0.uiInkImageTf_:GetComponent(typeof(RawImage))
	arg_1_0.inkCoverCom_ = arg_1_0.transform_:GetComponent(typeof(InkCoverPureGameManager))

	function arg_1_0.inkCoverCom_.OnBeginDragFun(arg_2_0)
		manager.notify:Invoke(ICHIBAN_RAFFLE_STOP_GUIDE_TIME)
		arg_1_0:AddRaffleTimer()
	end

	function arg_1_0.inkCoverCom_.OnDragFun(arg_3_0)
		local var_3_0 = arg_1_0.inkCoverCom_:GetCurrentProgress()

		if arg_1_0.newValue_ ~= var_3_0 then
			arg_1_0.drag_ = true
			arg_1_0.newValue_ = var_3_0
		end
	end

	function arg_1_0.inkCoverCom_.OnEndDragFun(arg_4_0)
		arg_1_0:StopRaffleTimer()
		manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_scratch_stop", "")

		if arg_1_0.inkCoverCom_:IsCompleted() then
			-- block empty
		else
			manager.notify:Invoke(ICHIBAN_RAFFLE_ADD_GUIDE_TIME)
		end
	end

	function arg_1_0.inkCoverCom_.OnCompletedFun()
		manager.notify:Invoke(ICHIBAN_COMPLETED_RAFFLE)
		arg_1_0.uiAnimator_:Play("Card_finish", 0)

		local var_5_0

		var_5_0 = LeanTween.alpha(arg_1_0.uiInkImageTf_, 0, 0.8):setOnComplete(System.Action(function()
			var_5_0:setOnComplete(nil)
		end))
	end

	function arg_1_0.inkCoverCom_.OnValueChangedFun(arg_7_0)
		return
	end

	arg_1_0:Show(true)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.commonItem_:Dispose()

	arg_8_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_8_0)

	arg_8_0.inkCoverCom_.OnBeginDragFun = nil
	arg_8_0.inkCoverCom_.OnDragFun = nil
	arg_8_0.inkCoverCom_.OnEndDragFun = nil
	arg_8_0.inkCoverCom_.OnCompletedFun = nil

	Object.Destroy(arg_8_0.gameObject_)

	arg_8_0.transform_ = nil
	arg_8_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.index_ = nil

	arg_10_0:StopTimer()
	arg_10_0:StopRaffleTimer()
end

function var_0_0.Show(arg_11_0, arg_11_1)
	if arg_11_1 == false then
		arg_11_0.tempVector3_.x = 1000000000000
		arg_11_0.tempVector3_.y = 1000000000000
		arg_11_0.tempVector3_.z = 1000000000000

		arg_11_0:SetLocalPosition(arg_11_0.tempVector3_)
	else
		SetActive(arg_11_0.gameObject_, arg_11_1)
	end
end

function var_0_0.SetLocalPosition(arg_12_0, arg_12_1)
	arg_12_0.transform_.localPosition = arg_12_1
end

function var_0_0.GetLocalPosition(arg_13_0)
	return arg_13_0.transform_.localPosition + arg_13_0.parent_.transform.localPosition
end

function var_0_0.SetIndex(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.isSelected_ = arg_14_2
	arg_14_0.activityID_ = arg_14_3
	arg_14_0.inkCoverCom_.enabled = arg_14_2

	SetActive(arg_14_0.uiMask_, not arg_14_2)

	if arg_14_0.index_ == arg_14_1 then
		return
	end

	local var_14_0 = arg_14_0.inkRawImage_.color

	arg_14_0.inkRawImage_.color = Color.New(var_14_0.r, var_14_0.g, var_14_0.b, 1)

	arg_14_0.uiAnimator_:Play("New State")
	arg_14_0:AddUpdate()

	arg_14_0.index_ = arg_14_1

	arg_14_0:Show(true)
	arg_14_0:RefreshUI()
	arg_14_0.inkCoverCom_:Reset()
end

function var_0_0.GetIndex(arg_15_0)
	return arg_15_0.index_
end

function var_0_0.AddRaffleTimer(arg_16_0)
	arg_16_0:StopRaffleTimer()

	local var_16_0 = arg_16_0.inkCoverCom_:GetCurrentProgress()
	local var_16_1 = false
	local var_16_2 = 0

	arg_16_0.raffleTimer_ = FrameTimer.New(function()
		var_16_2 = var_16_2 + 1

		if arg_16_0.drag_ then
			arg_16_0.drag_ = false
			var_16_2 = 0
			var_16_1 = true

			manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_scratch", "")
		elseif var_16_2 >= 10 and var_16_1 then
			var_16_1 = false

			manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_scratch_stop", "")
		end
	end, 1, -1)

	arg_16_0.raffleTimer_:Start()
end

function var_0_0.StopRaffleTimer(arg_18_0)
	if arg_18_0.raffleTimer_ then
		manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_scratch_stop", "")
		arg_18_0.raffleTimer_:Stop()

		arg_18_0.raffleTimer_ = nil
	end
end

function var_0_0.AddUpdate(arg_19_0)
	arg_19_0:StopTimer()
	arg_19_0:CalcScale()

	arg_19_0.timer_ = FrameTimer.New(function()
		arg_19_0:CalcScale()
	end, 1, -1)

	arg_19_0.timer_:Start()
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.timer_ then
		arg_21_0.timer_:Stop()

		arg_21_0.timer_ = nil
	end
end

function var_0_0.CalcScale(arg_22_0)
	local var_22_0 = arg_22_0:GetLocalPosition()
	local var_22_1 = math.abs(var_22_0.x - arg_22_0.width_)

	if var_22_1 < arg_22_0.width_ * 2 then
		arg_22_0:Scale(1 - var_22_1 / (arg_22_0.width_ * 4))
	end
end

function var_0_0.Scale(arg_23_0, arg_23_1)
	arg_23_0.tempVector3_.x = arg_23_1
	arg_23_0.tempVector3_.y = arg_23_1
	arg_23_0.tempVector3_.z = 1
	arg_23_0.transform_.localScale = arg_23_0.tempVector3_
end

function var_0_0.RefreshUI(arg_24_0)
	local var_24_0 = IchiBanData:GetUISeqList(arg_24_0.activityID_)[arg_24_0.index_]
	local var_24_1 = var_24_0.level
	local var_24_2 = var_24_0.reward[1]
	local var_24_3 = clone(ItemTemplateData)

	var_24_3.id = var_24_2.id
	var_24_3.number = var_24_2.num

	function var_24_3.clickFun(arg_25_0)
		ShowPopItem(POP_ITEM, {
			arg_25_0.id
		})
	end

	arg_24_0.commonItem_:SetData(var_24_3)

	local var_24_4 = IchiBanTeaserCfg.get_id_list_by_activity_id[arg_24_0.activityID_][var_24_1]
	local var_24_5 = IchiBanTeaserCfg[var_24_4]

	arg_24_0.uiLevelImage_.sprite = pureGetSpriteWithoutAtlas(var_24_5.level_pic)

	local var_24_6

	if var_24_1 == 1 then
		var_24_6 = GetTips("ICHIBAN_PRIZE_LEVEL_XL")
	elseif var_24_1 == 2 then
		var_24_6 = GetTips("ICHIBAN_PRIZE_LEVEL_L")
	elseif var_24_1 == 3 then
		var_24_6 = GetTips("ICHIBAN_PRIZE_LEVEL_M")
	else
		var_24_6 = GetTips("ICHIBAN_PRIZE_LEVEL_S")
	end

	arg_24_0.uiLevelText_.text = var_24_6
end

return var_0_0
