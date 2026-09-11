local ChapterV2MapTimelineView = class("ChapterV2MapTimelineView", ReduxView)

function ChapterV2MapTimelineView:UIName()
	return "Widget/System/Xuheng_PlotMap/XuhengPlotMapTimelineUI"
end

function ChapterV2MapTimelineView:UIParent()
	return manager.ui.uiMain.transform
end

local function var_0_1(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		if arg_3_1(iter_3_1) then
			return iter_3_1
		end
	end

	return nil
end

local function var_0_2(arg_4_0, arg_4_1, arg_4_2)
	return {
		capacity = 0,
		count = 0,
		onDisposeItem = arg_4_0,
		onReturnItem = arg_4_1,
		onCreateItem = arg_4_2
	}
end

local function var_0_3(arg_5_0)
	for iter_5_0 = 1, arg_5_0.capacity do
		arg_5_0.onDisposeItem(arg_5_0[iter_5_0])

		arg_5_0[iter_5_0] = nil
	end

	arg_5_0.count = 0
	arg_5_0.capacity = 0
end

local function var_0_4(arg_6_0)
	for iter_6_0 = 1, arg_6_0.count do
		arg_6_0.onReturnItem(arg_6_0[iter_6_0])
	end

	arg_6_0.count = 0
end

local function var_0_5(arg_7_0)
	if arg_7_0.count >= arg_7_0.capacity then
		arg_7_0.capacity = arg_7_0.capacity + 1
		arg_7_0[arg_7_0.capacity] = arg_7_0.onCreateItem()
	end

	arg_7_0.count = arg_7_0.count + 1

	return arg_7_0[arg_7_0.count]
end

local function var_0_6(arg_8_0)
	arg_8_0:Dispose()
end

local function var_0_7(arg_9_0)
	SetActive(arg_9_0.gameObject_, false)

	arg_9_0.node.item = nil
	arg_9_0.node = nil
end

local var_0_8 = 150
local var_0_9 = 300
local var_0_10 = 180

function ChapterV2MapTimelineView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.poolMain_ = var_0_2(var_0_6, var_0_7, function()
		return ChapterV2MapTimelineItem.New(self.mainItem_, self.contTrans_)
	end)
	self.poolSide_ = var_0_2(var_0_6, var_0_7, function()
		return ChapterV2MapTimelineItem.New(self.sideItem_, self.contTrans_)
	end)
	self.poolLine_ = var_0_2(function(arg_13_0)
		Object.Destroy(arg_13_0)
	end, function(arg_14_0)
		SetActive(arg_14_0, false)
	end, function()
		return Object.Instantiate(self.line_, self.contTrans_)
	end)
	self.poolLineConflict_ = var_0_2(function(arg_16_0)
		Object.Destroy(arg_16_0)
	end, function(arg_17_0)
		SetActive(arg_17_0, false)
	end, function()
		return Object.Instantiate(self.lineConflict_, self.contTrans_)
	end)
	self.poolLineAngle_ = var_0_2(function(arg_19_0)
		Object.Destroy(arg_19_0)
	end, function(arg_20_0)
		SetActive(arg_20_0, false)
	end, function()
		return Object.Instantiate(self.lineAngle_, self.contTrans_)
	end)

	SetActive(self.mainItem_, false)
	SetActive(self.sideItem_, false)
	SetActive(self.line_, false)
	SetActive(self.lineConflict_, false)
	SetActive(self.lineAngle_, false)

	var_0_9 = self.lineAngle_.transform.rect.width
	self.for_test_go_ = nil

	if self.for_test_go_ then
		SetActive(self.for_test_go_, true)
	end

	self.trackingText_.text = GetTips("CHAPTER_V2_BACKDATE_VALID_TEXT")
end

function ChapterV2MapTimelineView:AddListeners()
	if self.for_test_go_ then
		function ChapterV2MapTimelineView.SendGM(arg_23_0, arg_23_1)
			arg_23_1 = "$ " .. arg_23_1

			print(arg_23_1)
			manager.net:SendWithLoadingNew(27100, {
				content = arg_23_1
			}, 27101, function(arg_24_0, arg_24_1)
				print("Send Msg Return:", arg_24_0.result)
				ShowTips(arg_24_0.result)
			end)
		end

		self:AddBtnListener(self.tmpFinishBtn_, nil, function()
			if not string.isNullOrEmpty(self.tmpEventInput_.text) then
				local var_25_0 = tonumber(self.tmpEventInput_.text)

				if ChapterV2MapEventCfg[var_25_0].type == ChapterV2MapConst.MapEventType.MAIN or ChapterV2MapEventCfg[var_25_0].type == ChapterV2MapConst.MapEventType.SIDE then
					self:SendGM(string.format("zj clear_map_v2_event %d", ChapterV2MapEventCfg[var_25_0].params[1]))
				else
					ChapterV2MapAction.ReadEvent(var_25_0)
				end
			end
		end)
		self:AddBtnListener(self.tmpTrackBtn_, nil, function()
			if not string.isNullOrEmpty(self.tmpEventInput_.text) then
				ChapterV2MapAction.TrackTimelineEvent(tonumber(self.tmpEventInput_.text))
			end
		end)
		self:AddBtnListener(self.tmpOpenBtn_, nil, function()
			if not string.isNullOrEmpty(self.tmpEventInput_.text) then
				ChapterV2MapTools.OpenEvent(tonumber(self.tmpEventInput_.text))
			end
		end)
		self:AddBtnListener(self.tmpGoLocationBtn_, nil, function()
			if not string.isNullOrEmpty(self.tmpLocationInput_.text) then
				ChapterV2MapAction.MoveLocation((tonumber(self.tmpLocationInput_.text)))
			end
		end)
		self:AddBtnListener(self.tmpGoMapBtn_, nil, function()
			if not string.isNullOrEmpty(self.tmpMapInput_.text) then
				ChapterV2MapTools.GoMap((tonumber(self.tmpMapInput_.text)))
			end
		end)
		self:AddToggleListener(self.tmpAllTgl_, function(arg_30_0)
			self.testDisplayAll_ = arg_30_0

			self:CollectNodes()
			self:RefreshUI()
		end)
		self:AddBtnListener(self.maskBtn_, nil, function()
			if gameContext:GetLastOpenPage() == "chapterV2MapTimeline" then
				JumpTools.Back()
			end
		end)
	end

	self:AddBtnListener(self.goBottomBtn_, nil, function()
		ChapterV2MapAction.QuitTracking(ChapterV2MapData:GetCurrentMapId())
		self:Back()
	end)
end

function ChapterV2MapTimelineView:OnMapTimelineEventClick(arg_33_1, arg_33_2)
	if self.for_test_go_ then
		self.tmpEventInput_.text = arg_33_1
		self.tmpLocationInput_.text = ChapterV2MapEventCfg[arg_33_1].location
	end

	if self.testDisplayAll_ then
		-- block empty
	elseif ChapterV2MapTools.IsEventInteractable(arg_33_1) then
		if ChapterV2MapTools.IsMapTimelineEnabled((ChapterV2MapData:GetCurrentMapId())) and arg_33_1 ~= self.clickEventId_ then
			OperationRecorder.RecordButtonTouch({
				button_name = "story_mapevent_timeline_event_jump",
				event_id = arg_33_1
			})
			ChapterV2MapAction.TrackTimelineEvent(arg_33_1)
		end
	else
		return
	end

	self.clickEventId_ = arg_33_1

	if self.lastClickItem_ then
		self.lastClickItem_:RefreshUI(false)
	end

	self.lastClickItem_ = arg_33_2

	arg_33_2:RefreshUI(arg_33_1 == self.clickEventId_)
end

function ChapterV2MapTimelineView:OnMapTimelineEventReturn(arg_34_1)
	self:RefreshUI()
end

function ChapterV2MapTimelineView:OnMapChangeMap(arg_35_1)
	self.clickEventId_ = nil

	self:CollectNodes()
	self:RefreshUI()
end

function ChapterV2MapTimelineView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	local var_36_0 = ChapterV2MapData:GetCurrentMapId()

	if not self.clickEventId_ or ChapterV2MapTools.IsEventCompleted(self.clickEventId_) or ChapterV2MapTools.GetMapIdByEvent(self.clickEventId_) ~= var_36_0 then
		self.clickEventId_ = ChapterV2MapTools.GetNextEvent(var_36_0, nil, nil, true)
	end

	if self.for_test_go_ then
		self.tmpLocationInput_.text = ChapterV2MapData:GetCurrentLocationId()
		self.tmpMapInput_.text = var_36_0
	end

	self:CollectNodes()
	self:RefreshUI()

	if not self.for_test_go_ then
		self.contScroll_.verticalNormalizedPosition = self.curEventY and math.max(1 - math.max(0, self.curEventY - self.contScroll_.viewport.rect.height / 2) / (self.contScroll_.content.rect.height - self.contScroll_.viewport.rect.height), 0) or 0
	end
end

function ChapterV2MapTimelineView:OnExit()
	if ChapterV2MapTools.IsMapInTracking((ChapterV2MapData:GetCurrentMapId())) and not self.testDisplayAll_ then
		-- block empty
	end
end

function ChapterV2MapTimelineView:OnExitInput()
	JumpTools.Back()

	return true
end

function ChapterV2MapTimelineView:RefreshUI()
	self.nowEventId_ = ChapterV2MapTools.GetNextEvent((ChapterV2MapData:GetCurrentMapId()))

	if ChapterV2MapData:TimelineGetTime() then
		SetActive(self.trackingGo_, true)
		SetActive(self.goBottomBtn_.gameObject, true)
	else
		SetActive(self.trackingGo_, false)
		SetActive(self.goBottomBtn_.gameObject, false)
	end

	self:LayoutTimeline()
end

function ChapterV2MapTimelineView:AddNode(arg_40_1, arg_40_2, arg_40_3)
	if arg_40_1 == ChapterV2MapConst.MapEventType.MAIN then
		table.insert(self.mainNodes_, {
			id = arg_40_2,
			type = arg_40_1,
			children = {}
		})
	elseif arg_40_1 == ChapterV2MapConst.MapEventType.SIDE then
		local var_40_0 = var_0_1(self.mainNodes_, function(arg_41_0)
			return arg_41_0.id == arg_40_3
		end)

		if not var_40_0 then
			return
		end

		local var_40_1 = {
			id = arg_40_2,
			type = arg_40_1,
			children = {},
			parent = var_40_0
		}

		table.insert(var_40_0.children, var_40_1)
		table.insert(self.sideNodes_, var_40_1)
	else
		local var_40_2 = var_0_1(self.mainNodes_, function(arg_42_0)
			return arg_42_0.id == arg_40_3
		end) or var_0_1(self.sideNodes_, function(arg_43_0)
			return arg_43_0.id == arg_40_3
		end)

		if not var_40_2 then
			return
		end

		table.insert(var_40_2.children, {
			id = arg_40_2,
			type = arg_40_1,
			parent = var_40_2
		})
	end
end

function ChapterV2MapTimelineView:CollectNodes()
	self.mainNodes_ = {}
	self.sideNodes_ = {}

	for iter_44_0, iter_44_1 in ipairs((ChapterV2MapTools.GetCachedMapSortedEvents((ChapterV2MapData:GetCurrentMapId())))) do
		if self.testDisplayAll_ or ChapterV2MapTools.IsEventDisplayInTimeline(iter_44_1) then
			local var_44_0 = ChapterV2MapEventCfg[iter_44_1]

			if ChapterV2MapEventCfg[iter_44_1].type == ChapterV2MapConst.MapEventType.MAIN then
				self:AddNode(var_44_0.type, iter_44_1)
			elseif var_44_0.type == ChapterV2MapConst.MapEventType.SIDE then
				self:AddNode(var_44_0.type, iter_44_1, (ChapterV2MapTools.GetMainEventByEvent(iter_44_1)))
			else
				self:AddNode(var_44_0.type, iter_44_1, (ChapterV2MapTools.GetSupplementEventOwner(iter_44_1)))
			end
		end
	end

	self.finalMainNode_ = self.mainNodes_[#self.mainNodes_]
end

function ChapterV2MapTimelineView:DrawLine(arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5, arg_45_6)
	local var_45_0 = Vector2.New(arg_45_1, arg_45_2)
	local var_45_1 = Vector2.New(arg_45_3, arg_45_4)
	local var_45_2

	if arg_45_5 then
		var_45_2 = self.poolLineAngle_

		if not self.poolLineAngle_ then
			if arg_45_6 then
				var_45_2 = self.poolLineConflict_ or self.poolLine_
			end
		end
	end

	local var_45_3 = var_0_5(var_45_2)

	SetActive(var_45_3, true)

	var_45_3.transform.anchorMin = Vector2.New(0, 1)
	var_45_3.transform.anchorMax = Vector2.New(0, 1)

	if arg_45_5 then
		local var_45_4 = arg_45_1 < arg_45_3 and 1 or -1

		var_45_3.transform.rotation = Quaternion.Euler(0, 0, 0)
		var_45_3.transform.localScale = Vector3.New(var_45_4, 1, 1)
		var_45_3.transform.localPosition = var_45_0 + Vector2.New(var_45_3.transform.rect.width * var_45_4, var_45_3.transform.rect.height + self.sideItem_.transform.rect.height - 20) / 2
	elseif arg_45_6 then
		var_45_3.transform.localPosition = (var_45_0 + var_45_1) / 2
		var_45_3.transform.rotation = Quaternion.Euler(0, 0, 0)
		var_45_3.transform.localScale = Vector3.New(1, 1, 1)
	else
		local var_45_6 = var_45_0 - var_45_1

		var_45_3.transform.localPosition = (var_45_0 + var_45_1) / 2
		var_45_3.transform.rotation = Quaternion.Euler(0, 0, Mathf.Atan2(var_45_6.y, var_45_6.x) * Mathf.Rad2Deg + 90)
		var_45_3.transform.localScale = Vector3.New(1, var_45_6.magnitude / var_45_3.transform.rect.height, 1)
	end

	var_45_3.transform:SetAsFirstSibling()
end

function ChapterV2MapTimelineView:CreateNode(arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0

	if ChapterV2MapEventCfg[arg_46_1.id].type == ChapterV2MapConst.MapEventType.MAIN then
		var_46_0 = var_0_5(self.poolMain_)
	elseif ChapterV2MapEventCfg[arg_46_1.id].type == ChapterV2MapConst.MapEventType.SIDE then
		var_46_0 = var_0_5(self.poolSide_)
	elseif ChapterV2MapEventCfg[arg_46_1.id].type == ChapterV2MapConst.MapEventType.SUPPLEMENT then
		var_46_0 = arg_46_1.parent.item

		arg_46_1.parent.item:AddClue(arg_46_1.id)

		return 0
	end

	if self.clickEventId_ == arg_46_1.id then
		self.curEventY = arg_46_3
	end

	arg_46_1.item = var_46_0
	var_46_0.node = arg_46_1

	var_46_0:SetData(arg_46_1.id, self.clickEventId_ == arg_46_1.id)
	SetActive(var_46_0.gameObject_, true)

	var_46_0.transform_.anchorMin = Vector2.New(0, 1)
	var_46_0.transform_.anchorMax = Vector2.New(0, 1)
	var_46_0.transform_.localPosition = Vector3.New(arg_46_2, -arg_46_3, 0)

	if arg_46_4 then
		if arg_46_4.type == ChapterV2MapConst.MapEventType.SUPPLEMENT then
			arg_46_4 = arg_46_4.parent
		end

		self:DrawLine(var_46_0.transform_.localPosition.x, var_46_0.transform_.localPosition.y, arg_46_4.item.transform_.localPosition.x, arg_46_4.item.transform_.localPosition.y, arg_46_4.type ~= arg_46_1.type, arg_46_5)

		if arg_46_4 == self.finalMainNode_ then
			self:DrawLine(arg_46_4.item.transform_.localPosition.x, (var_46_0.transform_.localPosition.y + arg_46_4.item.transform_.localPosition.y) / 2 - 18, arg_46_4.item.transform_.localPosition.x, arg_46_4.item.transform_.localPosition.y, false, false)
		end
	end

	return var_46_0.transform_.rect.height
end

function ChapterV2MapTimelineView:LayoutTimeline()
	var_0_4(self.poolMain_)
	var_0_4(self.poolSide_)
	var_0_4(self.poolLine_)
	var_0_4(self.poolLineConflict_)
	var_0_4(self.poolLineAngle_)

	local var_47_0 = 100 - var_0_10

	for iter_47_0, iter_47_1 in ipairs(self.mainNodes_) do
		var_47_0 = var_47_0 + var_0_10
		var_47_0 = var_47_0 + self:CreateNode(iter_47_1, var_0_8, var_47_0, self.mainNodes_[iter_47_0 - 1])

		local var_47_1 = 0

		for iter_47_2, iter_47_3 in ipairs(iter_47_1.children) do
			if iter_47_3.type == ChapterV2MapConst.MapEventType.SIDE then
				var_47_1 = var_0_10 / 2

				local var_47_2 = iter_47_1.children[iter_47_2 - 1] or iter_47_1
				local var_47_3 = var_47_2 and ChapterV2MapTools.IsEventConflict(iter_47_3.id, var_47_2.id) or false

				var_47_0 = var_47_3 and var_47_0 + self.lineConflict_.transform.rect.height - self.sideItem_.transform.rect.height / 2 or var_47_0 + var_0_10 / 2
				var_47_0 = var_47_0 + self:CreateNode(iter_47_3, var_0_8 + var_0_9, var_47_0, var_47_2, var_47_3)

				for iter_47_4, iter_47_5 in ipairs(iter_47_3.children) do
					var_47_0 = var_47_0 + self:CreateNode(iter_47_5, var_0_8 + var_0_9, var_47_0)
				end
			else
				var_47_0 = var_47_0 + self:CreateNode(iter_47_3, var_0_8, var_47_0)
			end
		end

		var_47_0 = var_47_0 - var_47_1
	end

	self.contScroll_.content.sizeDelta = Vector2.New(self.contScroll_.content.sizeDelta.x, var_47_0 + 50)
end

function ChapterV2MapTimelineView:Dispose()
	self.mainNodes_ = nil
	self.sideNodes_ = nil

	var_0_3(self.poolMain_)

	self.poolMain_ = nil

	var_0_3(self.poolSide_)

	self.poolSide_ = nil

	var_0_3(self.poolLine_)

	self.poolLine_ = nil

	var_0_3(self.poolLineConflict_)

	self.poolLineConflict_ = nil

	var_0_3(self.poolLineAngle_)

	self.poolLineAngle_ = nil

	ChapterV2MapTimelineView.super.Dispose(self)
end

return ChapterV2MapTimelineView
