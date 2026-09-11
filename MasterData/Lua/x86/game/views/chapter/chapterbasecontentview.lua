local ChapterBaseContentView = class("ChapterBaseContentView", ReduxView)

ChapterBaseContentView.CIRCLE_RADIUS = 1425
ChapterBaseContentView.ELLIPSE_A = 1425
ChapterBaseContentView.ELLIPSE_B = 1425
ChapterBaseContentView.ELLIPSE_SQUARE_A = ChapterBaseContentView.ELLIPSE_A * ChapterBaseContentView.ELLIPSE_A
ChapterBaseContentView.ELLIPSE_SQUARE_B = ChapterBaseContentView.ELLIPSE_B * ChapterBaseContentView.ELLIPSE_B

function ChapterBaseContentView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterToggle_ = arg_1_2
	self.itemList_ = {}
	self.tempVector3_ = Vector3.New(0, 0, 0)

	self:InitUI()

	self.ChangeSelectChapterHandler_ = handler(self, self.ChangeSelectChapter)
	self.layoutGroup_.padding.left = self.scrollTf_.rect.width / 2
	self.layoutGroup_.padding.right = self.scrollTf_.rect.width / 2
end

function ChapterBaseContentView:OnEnter()
	manager.notify:RegistListener(CHANGE_DUNGEON, self.ChangeSelectChapterHandler_)
	self:RefreshData()
	self:RefreshUI()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Scroll, LuaHelper.EventTriggerAction1(handler(self, self.ScrollFunc)))
end

function ChapterBaseContentView:OnExit()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Scroll)
	manager.notify:RemoveListener(CHANGE_DUNGEON, self.ChangeSelectChapterHandler_)

	for iter_3_0, iter_3_1 in ipairs(self.itemList_) do
		iter_3_1.virtualItem:OnExit()
		iter_3_1.renderItem:OnExit()
	end

	self:StopMoveTimer()
	self:StopScrollTimer()
end

function ChapterBaseContentView:Dispose()
	self.ChangeSelectChapterHandler_ = nil

	for iter_4_0, iter_4_1 in pairs(self.itemList_) do
		iter_4_1.virtualItem:Dispose()
		iter_4_1.renderItem:Dispose()
	end

	self.itemList_ = nil
	self.scrollView_ = nil
	self.mapItem_ = nil
	self.itemParent_ = nil

	ChapterBaseContentView.super.Dispose(self)
end

function ChapterBaseContentView:InitUI()
	self:BindCfgUI()

	self.mapImage_.immediate = true

	self:AddListeners()

	self.lockController_ = self.btnControllerEx_:GetController("lock")
	self.selectController_ = self.controllerEx_:GetController("select")
end

function ChapterBaseContentView:AddListeners()
	self:AddToggleListener(self.scrollView_, function(arg_7_0)
		self:RefreshItemPosition()
	end)
	self:AddBtnListener(self.btn_, nil, function()
		self:GetSelectItem().renderItem:InvokeBtn()
	end)
end

function ChapterBaseContentView:BeginDragFun(arg_9_1, arg_9_2)
	self:StopMoveTimer()
	self:StopScrollTimer()
	self.scrollView_:OnBeginDrag(arg_9_2)
	self.selectController_:SetSelectedState("false")
	self:PlayAnimatorExit()
end

function ChapterBaseContentView:EndDragFun(arg_10_1, arg_10_2)
	self.scrollView_:OnEndDrag(arg_10_2)
	self:AddScrollTimer()
end

function ChapterBaseContentView:AddScrollTimer()
	self:StopScrollTimer()

	self.scrollTimer_ = nil
	self.scrollTimer_ = FrameTimer.New(function()
		if math.abs(self.scrollView_.velocity.x) <= 100 then
			self.scrollTimer_:Stop()
			self:AdjustItem()
		end
	end, 1, -1)

	self.scrollTimer_:Start()
end

function ChapterBaseContentView:ScrollFunc(arg_13_1, arg_13_2)
	self:BeginDragFun(arg_13_1, arg_13_2)
	self:EndDragFun(arg_13_1, arg_13_2)
end

function ChapterBaseContentView:StopScrollTimer()
	if self.scrollTimer_ then
		self.scrollTimer_:Stop()

		self.scrollTimer_ = nil
	end
end

function ChapterBaseContentView:AdjustItem()
	BattleFieldData:SetCacheChapterClient(self.chapterToggle_, self:GetNearestItem().renderItem:GetChapterClientID())
	self:ChangeSelectChapter(true)
end

function ChapterBaseContentView:SetActive(arg_16_1)
	SetActive(self.gameObject_, arg_16_1)

	if arg_16_1 then
		self:RefreshItemPosition()
		self:PlayAnimatorEnter()
	end
end

function ChapterBaseContentView:RefreshData()
	self.selectClientID_ = BattleFieldData:GetCacheChapterClient(self.chapterToggle_)
end

function ChapterBaseContentView:RefreshUI()
	self:RefreshMapItems()

	for iter_18_0, iter_18_1 in pairs(self.itemList_) do
		iter_18_1.virtualItem:OnEnter()
		iter_18_1.renderItem:OnEnter()
	end

	self:RefreshSortItem()
	FrameTimer.New(function()
		self:OverMoveAction()
		self:RefreshItemPosition()
	end, 1, 1):Start()
end

function ChapterBaseContentView:RefreshChapterUI()
	self.nameText_.text = GetI18NText(ChapterClientCfg[self.selectClientID_].name)

	SetSpriteWithoutAtlasAsync(self.mapImage_, SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectClientID_].chapter_paint)

	local var_20_0 = self:GetSelectItem()
	local var_20_1 = var_20_0.renderItem:GetLockState()

	self.lockController_:SetSelectedState(tostring(var_20_1))

	if var_20_1 then
		self.lockText_.text = var_20_0.renderItem:GetLockTips(self.lockTips_)
	end

	if self.assetPendLockGo_ then
		SetActive(self.assetPendLockGo_, (var_20_0.renderItem:GetAssetPendLockkState()))
	end

	if self.gameObject_.activeInHierarchy then
		self.bgAnimator_:Play("Fx_base_cx", 0, 0)
	end

	self:PlayAnimatorEnter()
end

function ChapterBaseContentView:RefreshMapItems()
	return
end

function ChapterBaseContentView:GetToggleID()
	return
end

function ChapterBaseContentView:RefreshSortItem()
	local var_23_0 = {}
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(self.itemList_) do
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

function ChapterBaseContentView:ChangeSelectChapter(arg_24_1)
	if not arg_24_1 then
		self:PlayAnimatorExit()
	end

	self:RefreshData()
	self:Scroll2SelectItem()
end

function ChapterBaseContentView:Scroll2SelectItem()
	self.selectController_:SetSelectedState("false")

	for iter_25_0, iter_25_1 in ipairs(self.itemList_) do
		if iter_25_1.renderItem:GetChapterClientID() == self.selectClientID_ then
			self:AddMoveTimer(iter_25_1)
		end
	end
end

function ChapterBaseContentView:RefreshItemPosition()
	for iter_26_0, iter_26_1 in ipairs(self.itemList_) do
		local var_26_0 = (iter_26_1.virtualItem:GetLocalPosition().x + self.contentTf_.localPosition.x) * math.pi / 3600

		iter_26_1.renderItem:SetPosition(math.cos(var_26_0) * 0 - math.sin(var_26_0) * (-1 * ChapterBaseContentView.CIRCLE_RADIUS) - self.contentTf_.localPosition.x, ChapterBaseContentView.CIRCLE_RADIUS + (math.cos(var_26_0) * (-1 * ChapterBaseContentView.CIRCLE_RADIUS) + math.sin(var_26_0) * 0) + 220, 1)
	end
end

function ChapterBaseContentView:GetEllipseYValue(arg_27_1)
	return math.sqrt((ChapterBaseContentView.ELLIPSE_SQUARE_B - ChapterBaseContentView.ELLIPSE_SQUARE_B / ChapterBaseContentView.ELLIPSE_SQUARE_A * arg_27_1 * arg_27_1 < 0 or nil) and 0)
end

function ChapterBaseContentView:GetCircleYValue(arg_28_1)
	arg_28_1 = math.abs(self.contentTf_.localPosition.x + arg_28_1)

	if ChapterBaseContentView.CIRCLE_RADIUS < arg_28_1 then
		arg_28_1 = ChapterBaseContentView.CIRCLE_RADIUS
	end

	return math.sqrt(ChapterBaseContentView.CIRCLE_RADIUS * ChapterBaseContentView.CIRCLE_RADIUS - arg_28_1 * arg_28_1)
end

function ChapterBaseContentView:GetSelectItem()
	for iter_29_0, iter_29_1 in ipairs(self.itemList_) do
		if iter_29_1.renderItem:GetChapterClientID() == self.selectClientID_ then
			return iter_29_1
		end
	end

	return self.itemList_[1]
end

function ChapterBaseContentView:GetNearestItem()
	local var_30_0

	for iter_30_0, iter_30_1 in ipairs(self.itemList_) do
		if math.abs(self.contentTf_.localPosition.x + iter_30_1.virtualItem:GetLocalPosition().x) < 9999 then
			var_30_0 = iter_30_1
		end
	end

	return var_30_0
end

function ChapterBaseContentView:OverMoveAction()
	self.selectController_:SetSelectedState("true")

	self.tempVector3_.x = self:GetSelectItem().virtualItem:GetLocalPosition().x * -1
	self.tempVector3_.y = self.contentTf_.localPosition.y
	self.tempVector3_.z = self.contentTf_.localPosition.z
	self.contentTf_.localPosition = self.tempVector3_

	self:RefreshChapterUI()
end

function ChapterBaseContentView:PlayAnimatorEnter()
	for iter_32_0, iter_32_1 in ipairs(self.itemList_) do
		if iter_32_1.renderItem:GetChapterClientID() == self.selectClientID_ then
			iter_32_1.renderItem:PlayAnimatorEnter()
		end
	end
end

function ChapterBaseContentView:PlayAnimatorExit()
	for iter_33_0, iter_33_1 in ipairs(self.itemList_) do
		if iter_33_1.renderItem:GetChapterClientID() == self.selectClientID_ then
			iter_33_1.renderItem:PlayAnimatorExit()
		end
	end
end

function ChapterBaseContentView:AddMoveTimer(arg_34_1)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		local var_35_2 = arg_34_1.virtualItem:GetLocalPosition().x * -1

		self.tempVector3_.x = var_35_2
		self.tempVector3_.y = self.contentTf_.localPosition.y
		self.tempVector3_.z = self.contentTf_.localPosition.z

		local var_35_3 = Vector3.Lerp(self.contentTf_.localPosition, self.tempVector3_, GameSetting.challenge_velocity_times.value[1] * math.pow(self.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if GameSetting.challenge_scroll_min_length.value[1] > math.abs(self.contentTf_.localPosition.x - var_35_3.x) then
			local var_35_4 = var_35_2 - self.contentTf_.localPosition.x

			if GameSetting.challenge_scroll_min_length.value[1] < math.abs(var_35_2 - self.contentTf_.localPosition.x) then
				var_35_4 = GameSetting.challenge_scroll_min_length.value[1] * var_35_4 / math.abs(var_35_4)
			end

			var_35_3.x = var_35_3.x + var_35_4
		end

		self.contentTf_.localPosition = var_35_3

		if math.abs(self.contentTf_.localPosition.x - var_35_2) <= GameSetting.challenge_stop_min_length.value[1] then
			self.scrollView_:StopMovement()
			self:StopMoveTimer()
			self:OverMoveAction()
		end
	end, 1, -1)

	self.moveTimer_:Start()
end

function ChapterBaseContentView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

return ChapterBaseContentView
