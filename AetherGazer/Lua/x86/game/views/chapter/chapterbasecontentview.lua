local var_0_0 = class("ChapterBaseContentView", ReduxView)

var_0_0.CIRCLE_RADIUS = 1425
var_0_0.ELLIPSE_A = 1425
var_0_0.ELLIPSE_B = 1425
var_0_0.ELLIPSE_SQUARE_A = var_0_0.ELLIPSE_A * var_0_0.ELLIPSE_A
var_0_0.ELLIPSE_SQUARE_B = var_0_0.ELLIPSE_B * var_0_0.ELLIPSE_B

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterToggle_ = arg_1_2
	arg_1_0.itemList_ = {}
	arg_1_0.tempVector3_ = Vector3.New(0, 0, 0)

	arg_1_0:InitUI()

	arg_1_0.ChangeSelectChapterHandler_ = handler(arg_1_0, arg_1_0.ChangeSelectChapter)
	arg_1_0.layoutGroup_.padding.left = arg_1_0.scrollTf_.rect.width / 2
	arg_1_0.layoutGroup_.padding.right = arg_1_0.scrollTf_.rect.width / 2
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(CHANGE_DUNGEON, arg_2_0.ChangeSelectChapterHandler_)
	arg_2_0:RefreshData()
	arg_2_0:RefreshUI()
	arg_2_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_2_0, arg_2_0.BeginDragFun)))
	arg_2_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_2_0, arg_2_0.EndDragFun)))
	arg_2_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Scroll, LuaHelper.EventTriggerAction1(handler(arg_2_0, arg_2_0.ScrollFunc)))
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_3_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_3_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Scroll)
	manager.notify:RemoveListener(CHANGE_DUNGEON, arg_3_0.ChangeSelectChapterHandler_)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.itemList_) do
		iter_3_1.virtualItem:OnExit()
		iter_3_1.renderItem:OnExit()
	end

	arg_3_0:StopMoveTimer()
	arg_3_0:StopScrollTimer()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.ChangeSelectChapterHandler_ = nil

	for iter_4_0, iter_4_1 in pairs(arg_4_0.itemList_) do
		iter_4_1.virtualItem:Dispose()
		iter_4_1.renderItem:Dispose()
	end

	arg_4_0.itemList_ = nil
	arg_4_0.scrollView_ = nil
	arg_4_0.mapItem_ = nil
	arg_4_0.itemParent_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.mapImage_.immediate = true

	arg_5_0:AddListeners()

	arg_5_0.lockController_ = arg_5_0.btnControllerEx_:GetController("lock")
	arg_5_0.selectController_ = arg_5_0.controllerEx_:GetController("select")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddToggleListener(arg_6_0.scrollView_, function(arg_7_0)
		arg_6_0:RefreshItemPosition()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		arg_6_0:GetSelectItem().renderItem:InvokeBtn()
	end)
end

function var_0_0.BeginDragFun(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:StopMoveTimer()
	arg_9_0:StopScrollTimer()
	arg_9_0.scrollView_:OnBeginDrag(arg_9_2)
	arg_9_0.selectController_:SetSelectedState("false")
	arg_9_0:PlayAnimatorExit()
end

function var_0_0.EndDragFun(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.scrollView_:OnEndDrag(arg_10_2)
	arg_10_0:AddScrollTimer()
end

function var_0_0.AddScrollTimer(arg_11_0)
	arg_11_0:StopScrollTimer()

	arg_11_0.scrollTimer_ = nil
	arg_11_0.scrollTimer_ = FrameTimer.New(function()
		if math.abs(arg_11_0.scrollView_.velocity.x) <= 100 then
			arg_11_0.scrollTimer_:Stop()
			arg_11_0:AdjustItem()
		end
	end, 1, -1)

	arg_11_0.scrollTimer_:Start()
end

function var_0_0.ScrollFunc(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:BeginDragFun(arg_13_1, arg_13_2)
	arg_13_0:EndDragFun(arg_13_1, arg_13_2)
end

function var_0_0.StopScrollTimer(arg_14_0)
	if arg_14_0.scrollTimer_ then
		arg_14_0.scrollTimer_:Stop()

		arg_14_0.scrollTimer_ = nil
	end
end

function var_0_0.AdjustItem(arg_15_0)
	local var_15_0 = arg_15_0:GetNearestItem()

	BattleFieldData:SetCacheChapterClient(arg_15_0.chapterToggle_, var_15_0.renderItem:GetChapterClientID())
	arg_15_0:ChangeSelectChapter(true)
end

function var_0_0.SetActive(arg_16_0, arg_16_1)
	SetActive(arg_16_0.gameObject_, arg_16_1)

	if arg_16_1 then
		arg_16_0:RefreshItemPosition()
		arg_16_0:PlayAnimatorEnter()
	end
end

function var_0_0.RefreshData(arg_17_0)
	arg_17_0.selectClientID_ = BattleFieldData:GetCacheChapterClient(arg_17_0.chapterToggle_)
end

function var_0_0.RefreshUI(arg_18_0)
	arg_18_0:RefreshMapItems()

	for iter_18_0, iter_18_1 in pairs(arg_18_0.itemList_) do
		iter_18_1.virtualItem:OnEnter()
		iter_18_1.renderItem:OnEnter()
	end

	arg_18_0:RefreshSortItem()
	FrameTimer.New(function()
		arg_18_0:OverMoveAction()
		arg_18_0:RefreshItemPosition()
	end, 1, 1):Start()
end

function var_0_0.RefreshChapterUI(arg_20_0)
	local var_20_0 = ChapterClientCfg[arg_20_0.selectClientID_]

	arg_20_0.nameText_.text = GetI18NText(var_20_0.name)

	SetSpriteWithoutAtlasAsync(arg_20_0.mapImage_, SpritePathCfg.ChapterPaint.path .. var_20_0.chapter_paint)

	local var_20_1 = arg_20_0:GetSelectItem()
	local var_20_2 = var_20_1.renderItem:GetLockState()

	arg_20_0.lockController_:SetSelectedState(tostring(var_20_2))

	if var_20_2 then
		arg_20_0.lockText_.text = var_20_1.renderItem:GetLockTips(arg_20_0.lockTips_)
	end

	local var_20_3 = var_20_1.renderItem:GetAssetPendLockkState()

	if arg_20_0.assetPendLockGo_ then
		SetActive(arg_20_0.assetPendLockGo_, var_20_3)
	end

	if arg_20_0.gameObject_.activeInHierarchy then
		arg_20_0.bgAnimator_:Play("Fx_base_cx", 0, 0)
	end

	arg_20_0:PlayAnimatorEnter()
end

function var_0_0.RefreshMapItems(arg_21_0)
	return
end

function var_0_0.GetToggleID(arg_22_0)
	return
end

function var_0_0.RefreshSortItem(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.itemList_) do
		if iter_23_1.renderItem:GetLockState() then
			table.insert(var_23_1, iter_23_1)
		else
			table.insert(var_23_0, iter_23_1)
		end
	end

	table.insertto(var_23_0, var_23_1)

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		iter_23_3.virtualItem:SetSiblingIndex(iter_23_2)
	end
end

function var_0_0.ChangeSelectChapter(arg_24_0, arg_24_1)
	if not arg_24_1 then
		arg_24_0:PlayAnimatorExit()
	end

	arg_24_0:RefreshData()
	arg_24_0:Scroll2SelectItem()
end

function var_0_0.Scroll2SelectItem(arg_25_0)
	arg_25_0.selectController_:SetSelectedState("false")

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.itemList_) do
		if iter_25_1.renderItem:GetChapterClientID() == arg_25_0.selectClientID_ then
			arg_25_0:AddMoveTimer(iter_25_1)
		end
	end
end

function var_0_0.RefreshItemPosition(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.itemList_) do
		local var_26_0 = iter_26_1.virtualItem:GetLocalPosition().x + arg_26_0.contentTf_.localPosition.x
		local var_26_1 = 1
		local var_26_2 = 0
		local var_26_3 = -1 * var_0_0.CIRCLE_RADIUS
		local var_26_4 = var_26_0 * math.pi / 3600
		local var_26_5 = math.cos(var_26_4) * var_26_2 - math.sin(var_26_4) * var_26_3
		local var_26_6 = var_0_0.CIRCLE_RADIUS + (math.cos(var_26_4) * var_26_3 + math.sin(var_26_4) * var_26_2)

		iter_26_1.renderItem:SetPosition(var_26_5 - arg_26_0.contentTf_.localPosition.x, var_26_6 + 220, var_26_1)
	end
end

function var_0_0.GetEllipseYValue(arg_27_0, arg_27_1)
	local var_27_0 = var_0_0.ELLIPSE_SQUARE_B - var_0_0.ELLIPSE_SQUARE_B / var_0_0.ELLIPSE_SQUARE_A * arg_27_1 * arg_27_1

	if var_27_0 < 0 then
		var_27_0 = 0
	end

	return math.sqrt(var_27_0)
end

function var_0_0.GetCircleYValue(arg_28_0, arg_28_1)
	local var_28_0 = var_0_0.CIRCLE_RADIUS

	arg_28_1 = math.abs(arg_28_0.contentTf_.localPosition.x + arg_28_1)

	if var_28_0 < arg_28_1 then
		arg_28_1 = var_28_0
	end

	return math.sqrt(var_28_0 * var_28_0 - arg_28_1 * arg_28_1)
end

function var_0_0.GetSelectItem(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.itemList_) do
		if iter_29_1.renderItem:GetChapterClientID() == arg_29_0.selectClientID_ then
			return iter_29_1
		end
	end

	return arg_29_0.itemList_[1]
end

function var_0_0.GetNearestItem(arg_30_0)
	local var_30_0 = 9999
	local var_30_1

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.itemList_) do
		local var_30_2 = math.abs(arg_30_0.contentTf_.localPosition.x + iter_30_1.virtualItem:GetLocalPosition().x)

		if var_30_2 < var_30_0 then
			var_30_0 = var_30_2
			var_30_1 = iter_30_1
		end
	end

	return var_30_1
end

function var_0_0.OverMoveAction(arg_31_0)
	arg_31_0.selectController_:SetSelectedState("true")

	local var_31_0 = arg_31_0.contentTf_.localPosition
	local var_31_1 = arg_31_0:GetSelectItem()

	arg_31_0.tempVector3_.x = var_31_1.virtualItem:GetLocalPosition().x * -1
	arg_31_0.tempVector3_.y = var_31_0.y
	arg_31_0.tempVector3_.z = var_31_0.z
	arg_31_0.contentTf_.localPosition = arg_31_0.tempVector3_

	arg_31_0:RefreshChapterUI()
end

function var_0_0.PlayAnimatorEnter(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.itemList_) do
		if iter_32_1.renderItem:GetChapterClientID() == arg_32_0.selectClientID_ then
			iter_32_1.renderItem:PlayAnimatorEnter()
		end
	end
end

function var_0_0.PlayAnimatorExit(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0.itemList_) do
		if iter_33_1.renderItem:GetChapterClientID() == arg_33_0.selectClientID_ then
			iter_33_1.renderItem:PlayAnimatorExit()
		end
	end
end

function var_0_0.AddMoveTimer(arg_34_0, arg_34_1)
	arg_34_0:StopMoveTimer()

	local var_34_0 = arg_34_0.contentTf_.localPosition

	arg_34_0.moveTimer_ = FrameTimer.New(function()
		local var_35_0 = arg_34_0.contentTf_.rect.width / 2
		local var_35_1 = arg_34_0.scrollTf_.rect.width / 2
		local var_35_2 = arg_34_0.contentTf_.localPosition
		local var_35_3 = arg_34_1.virtualItem:GetLocalPosition().x * -1
		local var_35_4 = GameSetting.challenge_velocity_times.value[1] * math.pow(arg_34_0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_34_0.tempVector3_.x = var_35_3
		arg_34_0.tempVector3_.y = var_35_2.y
		arg_34_0.tempVector3_.z = var_35_2.z

		local var_35_5 = Vector3.Lerp(var_35_2, arg_34_0.tempVector3_, var_35_4)
		local var_35_6 = GameSetting.challenge_scroll_min_length.value[1]

		if var_35_6 > math.abs(var_35_2.x - var_35_5.x) then
			local var_35_7 = var_35_3 - var_35_2.x

			if var_35_6 < math.abs(var_35_7) then
				var_35_7 = var_35_6 * var_35_7 / math.abs(var_35_7)
			end

			var_35_5.x = var_35_5.x + var_35_7
		end

		arg_34_0.contentTf_.localPosition = var_35_5

		if math.abs(arg_34_0.contentTf_.localPosition.x - var_35_3) <= GameSetting.challenge_stop_min_length.value[1] then
			arg_34_0.scrollView_:StopMovement()
			arg_34_0:StopMoveTimer()
			arg_34_0:OverMoveAction()
		end
	end, 1, -1)

	arg_34_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_36_0)
	if arg_36_0.moveTimer_ then
		arg_36_0.moveTimer_:Stop()

		arg_36_0.moveTimer_ = nil
	end
end

return var_0_0
