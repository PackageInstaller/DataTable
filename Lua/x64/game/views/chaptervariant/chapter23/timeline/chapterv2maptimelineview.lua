local var_0_0 = class("ChapterV2MapTimelineView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Xuheng_PlotMap/XuhengPlotMapTimelineUI"
end

function var_0_0.UIParent(arg_2_0)
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

function var_0_0.Init(arg_10_0)
	arg_10_0:BindCfgUI()
	arg_10_0:AddListeners()

	arg_10_0.poolMain_ = var_0_2(var_0_6, var_0_7, function()
		return ChapterV2MapTimelineItem.New(arg_10_0.mainItem_, arg_10_0.contTrans_)
	end)
	arg_10_0.poolSide_ = var_0_2(var_0_6, var_0_7, function()
		return ChapterV2MapTimelineItem.New(arg_10_0.sideItem_, arg_10_0.contTrans_)
	end)
	arg_10_0.poolLine_ = var_0_2(function(arg_13_0)
		Object.Destroy(arg_13_0)
	end, function(arg_14_0)
		SetActive(arg_14_0, false)
	end, function()
		return Object.Instantiate(arg_10_0.line_, arg_10_0.contTrans_)
	end)
	arg_10_0.poolLineConflict_ = var_0_2(function(arg_16_0)
		Object.Destroy(arg_16_0)
	end, function(arg_17_0)
		SetActive(arg_17_0, false)
	end, function()
		return Object.Instantiate(arg_10_0.lineConflict_, arg_10_0.contTrans_)
	end)
	arg_10_0.poolLineAngle_ = var_0_2(function(arg_19_0)
		Object.Destroy(arg_19_0)
	end, function(arg_20_0)
		SetActive(arg_20_0, false)
	end, function()
		return Object.Instantiate(arg_10_0.lineAngle_, arg_10_0.contTrans_)
	end)

	SetActive(arg_10_0.mainItem_, false)
	SetActive(arg_10_0.sideItem_, false)
	SetActive(arg_10_0.line_, false)
	SetActive(arg_10_0.lineConflict_, false)
	SetActive(arg_10_0.lineAngle_, false)

	var_0_9 = arg_10_0.lineAngle_.transform.rect.width
	arg_10_0.for_test_go_ = nil

	if arg_10_0.for_test_go_ then
		SetActive(arg_10_0.for_test_go_, true)
	end

	arg_10_0.trackingText_.text = GetTips("CHAPTER_V2_BACKDATE_VALID_TEXT")
end

function var_0_0.AddListeners(arg_22_0)
	if arg_22_0.for_test_go_ then
		function var_0_0.SendGM(arg_23_0, arg_23_1)
			arg_23_1 = "$ " .. arg_23_1

			local var_23_0 = {
				content = arg_23_1
			}

			print(arg_23_1)
			manager.net:SendWithLoadingNew(27100, var_23_0, 27101, function(arg_24_0, arg_24_1)
				print("Send Msg Return:", arg_24_0.result)
				ShowTips(arg_24_0.result)
			end)
		end

		arg_22_0:AddBtnListener(arg_22_0.tmpFinishBtn_, nil, function()
			if not string.isNullOrEmpty(arg_22_0.tmpEventInput_.text) then
				local var_25_0 = tonumber(arg_22_0.tmpEventInput_.text)
				local var_25_1 = ChapterV2MapEventCfg[var_25_0]

				if var_25_1.type == ChapterV2MapConst.MapEventType.MAIN or var_25_1.type == ChapterV2MapConst.MapEventType.SIDE then
					arg_22_0:SendGM(string.format("zj clear_map_v2_event %d", var_25_1.params[1]))
				else
					ChapterV2MapAction.ReadEvent(var_25_0)
				end
			end
		end)
		arg_22_0:AddBtnListener(arg_22_0.tmpTrackBtn_, nil, function()
			if not string.isNullOrEmpty(arg_22_0.tmpEventInput_.text) then
				ChapterV2MapAction.TrackTimelineEvent(tonumber(arg_22_0.tmpEventInput_.text))
			end
		end)
		arg_22_0:AddBtnListener(arg_22_0.tmpOpenBtn_, nil, function()
			if not string.isNullOrEmpty(arg_22_0.tmpEventInput_.text) then
				ChapterV2MapTools.OpenEvent(tonumber(arg_22_0.tmpEventInput_.text))
			end
		end)
		arg_22_0:AddBtnListener(arg_22_0.tmpGoLocationBtn_, nil, function()
			if not string.isNullOrEmpty(arg_22_0.tmpLocationInput_.text) then
				local var_28_0 = tonumber(arg_22_0.tmpLocationInput_.text)

				ChapterV2MapAction.MoveLocation(var_28_0)
			end
		end)
		arg_22_0:AddBtnListener(arg_22_0.tmpGoMapBtn_, nil, function()
			if not string.isNullOrEmpty(arg_22_0.tmpMapInput_.text) then
				local var_29_0 = tonumber(arg_22_0.tmpMapInput_.text)

				ChapterV2MapTools.GoMap(var_29_0)
			end
		end)
		arg_22_0:AddToggleListener(arg_22_0.tmpAllTgl_, function(arg_30_0)
			arg_22_0.testDisplayAll_ = arg_30_0

			arg_22_0:CollectNodes()
			arg_22_0:RefreshUI()
		end)
		arg_22_0:AddBtnListener(arg_22_0.maskBtn_, nil, function()
			if gameContext:GetLastOpenPage() == "chapterV2MapTimeline" then
				JumpTools.Back()
			end
		end)
	end

	arg_22_0:AddBtnListener(arg_22_0.goBottomBtn_, nil, function()
		ChapterV2MapAction.QuitTracking(ChapterV2MapData:GetCurrentMapId())
		arg_22_0:Back()
	end)
end

function var_0_0.OnMapTimelineEventClick(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0.for_test_go_ then
		arg_33_0.tmpEventInput_.text = arg_33_1
		arg_33_0.tmpLocationInput_.text = ChapterV2MapEventCfg[arg_33_1].location
	end

	if arg_33_0.testDisplayAll_ then
		-- block empty
	elseif ChapterV2MapTools.IsEventInteractable(arg_33_1) then
		local var_33_0 = ChapterV2MapData:GetCurrentMapId()

		if ChapterV2MapTools.IsMapTimelineEnabled(var_33_0) and arg_33_1 ~= arg_33_0.clickEventId_ then
			OperationRecorder.RecordButtonTouch({
				button_name = "story_mapevent_timeline_event_jump",
				event_id = arg_33_1
			})
			ChapterV2MapAction.TrackTimelineEvent(arg_33_1)
		end
	else
		return
	end

	arg_33_0.clickEventId_ = arg_33_1

	if arg_33_0.lastClickItem_ then
		arg_33_0.lastClickItem_:RefreshUI(false)
	end

	arg_33_0.lastClickItem_ = arg_33_2

	arg_33_2:RefreshUI(arg_33_1 == arg_33_0.clickEventId_)
end

function var_0_0.OnMapTimelineEventReturn(arg_34_0, arg_34_1)
	arg_34_0:RefreshUI()
end

function var_0_0.OnMapChangeMap(arg_35_0, arg_35_1)
	arg_35_0.clickEventId_ = nil

	arg_35_0:CollectNodes()
	arg_35_0:RefreshUI()
end

function var_0_0.OnEnter(arg_36_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	local var_36_0 = ChapterV2MapData:GetCurrentMapId()

	if not arg_36_0.clickEventId_ or ChapterV2MapTools.IsEventCompleted(arg_36_0.clickEventId_) or ChapterV2MapTools.GetMapIdByEvent(arg_36_0.clickEventId_) ~= var_36_0 then
		arg_36_0.clickEventId_ = ChapterV2MapTools.GetNextEvent(var_36_0, nil, nil, true)
	end

	if arg_36_0.for_test_go_ then
		arg_36_0.tmpLocationInput_.text = ChapterV2MapData:GetCurrentLocationId()
		arg_36_0.tmpMapInput_.text = var_36_0
	end

	arg_36_0:CollectNodes()
	arg_36_0:RefreshUI()

	if not arg_36_0.for_test_go_ then
		if arg_36_0.curEventY then
			local var_36_1 = arg_36_0.contScroll_.viewport.rect.height
			local var_36_2 = math.max(0, arg_36_0.curEventY - var_36_1 / 2)
			local var_36_3 = arg_36_0.contScroll_.content.rect.height - var_36_1

			arg_36_0.contScroll_.verticalNormalizedPosition = math.max(1 - var_36_2 / var_36_3, 0)
		else
			arg_36_0.contScroll_.verticalNormalizedPosition = 0
		end
	end
end

function var_0_0.OnExit(arg_37_0)
	local var_37_0 = ChapterV2MapData:GetCurrentMapId()

	if ChapterV2MapTools.IsMapInTracking(var_37_0) and not arg_37_0.testDisplayAll_ then
		-- block empty
	end
end

function var_0_0.OnExitInput(arg_38_0)
	JumpTools.Back()

	return true
end

function var_0_0.RefreshUI(arg_39_0)
	local var_39_0 = ChapterV2MapData:GetCurrentMapId()

	arg_39_0.nowEventId_ = ChapterV2MapTools.GetNextEvent(var_39_0)

	if ChapterV2MapData:TimelineGetTime() then
		SetActive(arg_39_0.trackingGo_, true)
		SetActive(arg_39_0.goBottomBtn_.gameObject, true)
	else
		SetActive(arg_39_0.trackingGo_, false)
		SetActive(arg_39_0.goBottomBtn_.gameObject, false)
	end

	arg_39_0:LayoutTimeline()
end

function var_0_0.AddNode(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if arg_40_1 == ChapterV2MapConst.MapEventType.MAIN then
		table.insert(arg_40_0.mainNodes_, {
			id = arg_40_2,
			type = arg_40_1,
			children = {}
		})
	elseif arg_40_1 == ChapterV2MapConst.MapEventType.SIDE then
		local var_40_0 = var_0_1(arg_40_0.mainNodes_, function(arg_41_0)
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
		table.insert(arg_40_0.sideNodes_, var_40_1)
	else
		local var_40_2 = var_0_1(arg_40_0.mainNodes_, function(arg_42_0)
			return arg_42_0.id == arg_40_3
		end) or var_0_1(arg_40_0.sideNodes_, function(arg_43_0)
			return arg_43_0.id == arg_40_3
		end)

		if not var_40_2 then
			return
		end

		local var_40_3 = {
			id = arg_40_2,
			type = arg_40_1,
			parent = var_40_2
		}

		table.insert(var_40_2.children, var_40_3)
	end
end

function var_0_0.CollectNodes(arg_44_0)
	arg_44_0.mainNodes_ = {}
	arg_44_0.sideNodes_ = {}

	local var_44_0 = ChapterV2MapData:GetCurrentMapId()
	local var_44_1 = ChapterV2MapTools.GetCachedMapSortedEvents(var_44_0)

	for iter_44_0, iter_44_1 in ipairs(var_44_1) do
		if arg_44_0.testDisplayAll_ or ChapterV2MapTools.IsEventDisplayInTimeline(iter_44_1) then
			local var_44_2 = ChapterV2MapEventCfg[iter_44_1]

			if var_44_2.type == ChapterV2MapConst.MapEventType.MAIN then
				arg_44_0:AddNode(var_44_2.type, iter_44_1)
			elseif var_44_2.type == ChapterV2MapConst.MapEventType.SIDE then
				local var_44_3 = ChapterV2MapTools.GetMainEventByEvent(iter_44_1)

				arg_44_0:AddNode(var_44_2.type, iter_44_1, var_44_3)
			else
				local var_44_4 = ChapterV2MapTools.GetSupplementEventOwner(iter_44_1)

				arg_44_0:AddNode(var_44_2.type, iter_44_1, var_44_4)
			end
		end
	end

	arg_44_0.finalMainNode_ = arg_44_0.mainNodes_[#arg_44_0.mainNodes_]
end

function var_0_0.DrawLine(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5, arg_45_6)
	local var_45_0 = Vector2.New(arg_45_1, arg_45_2)
	local var_45_1 = Vector2.New(arg_45_3, arg_45_4)
	local var_45_2 = var_0_5(arg_45_5 and arg_45_0.poolLineAngle_ or arg_45_6 and arg_45_0.poolLineConflict_ or arg_45_0.poolLine_)

	SetActive(var_45_2, true)

	var_45_2.transform.anchorMin = Vector2.New(0, 1)
	var_45_2.transform.anchorMax = Vector2.New(0, 1)

	if arg_45_5 then
		local var_45_3 = arg_45_1 < arg_45_3 and 1 or -1

		var_45_2.transform.rotation = Quaternion.Euler(0, 0, 0)
		var_45_2.transform.localScale = Vector3.New(var_45_3, 1, 1)
		var_45_2.transform.localPosition = var_45_0 + Vector2.New(var_45_2.transform.rect.width * var_45_3, var_45_2.transform.rect.height + arg_45_0.sideItem_.transform.rect.height - 20) / 2
	elseif arg_45_6 then
		local var_45_4 = var_45_0 - var_45_1

		var_45_2.transform.localPosition = (var_45_0 + var_45_1) / 2
		var_45_2.transform.rotation = Quaternion.Euler(0, 0, 0)
		var_45_2.transform.localScale = Vector3.New(1, 1, 1)
	else
		local var_45_5 = var_45_0 - var_45_1

		var_45_2.transform.localPosition = (var_45_0 + var_45_1) / 2
		var_45_2.transform.rotation = Quaternion.Euler(0, 0, Mathf.Atan2(var_45_5.y, var_45_5.x) * Mathf.Rad2Deg + 90)
		var_45_2.transform.localScale = Vector3.New(1, var_45_5.magnitude / var_45_2.transform.rect.height, 1)
	end

	var_45_2.transform:SetAsFirstSibling()
end

function var_0_0.CreateNode(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0 = arg_46_1.id
	local var_46_1
	local var_46_2 = ChapterV2MapEventCfg[var_46_0]

	if var_46_2.type == ChapterV2MapConst.MapEventType.MAIN then
		var_46_1 = var_0_5(arg_46_0.poolMain_)
	elseif var_46_2.type == ChapterV2MapConst.MapEventType.SIDE then
		var_46_1 = var_0_5(arg_46_0.poolSide_)
	elseif var_46_2.type == ChapterV2MapConst.MapEventType.SUPPLEMENT then
		var_46_1 = arg_46_1.parent.item

		var_46_1:AddClue(var_46_0)

		return 0
	end

	if arg_46_0.clickEventId_ == var_46_0 then
		arg_46_0.curEventY = arg_46_3
	end

	arg_46_1.item = var_46_1
	var_46_1.node = arg_46_1

	var_46_1:SetData(var_46_0, arg_46_0.clickEventId_ == var_46_0)
	SetActive(var_46_1.gameObject_, true)

	var_46_1.transform_.anchorMin = Vector2.New(0, 1)
	var_46_1.transform_.anchorMax = Vector2.New(0, 1)
	var_46_1.transform_.localPosition = Vector3.New(arg_46_2, -arg_46_3, 0)

	if arg_46_4 then
		if arg_46_4.type == ChapterV2MapConst.MapEventType.SUPPLEMENT then
			arg_46_4 = arg_46_4.parent
		end

		local var_46_3 = ChapterV2MapEventCfg[arg_46_4.id]

		arg_46_0:DrawLine(var_46_1.transform_.localPosition.x, var_46_1.transform_.localPosition.y, arg_46_4.item.transform_.localPosition.x, arg_46_4.item.transform_.localPosition.y, arg_46_4.type ~= arg_46_1.type, arg_46_5)

		if arg_46_4 == arg_46_0.finalMainNode_ then
			arg_46_0:DrawLine(arg_46_4.item.transform_.localPosition.x, (var_46_1.transform_.localPosition.y + arg_46_4.item.transform_.localPosition.y) / 2 - 18, arg_46_4.item.transform_.localPosition.x, arg_46_4.item.transform_.localPosition.y, false, false)
		end
	end

	return var_46_1.transform_.rect.height
end

function var_0_0.LayoutTimeline(arg_47_0)
	var_0_4(arg_47_0.poolMain_)
	var_0_4(arg_47_0.poolSide_)
	var_0_4(arg_47_0.poolLine_)
	var_0_4(arg_47_0.poolLineConflict_)
	var_0_4(arg_47_0.poolLineAngle_)

	local var_47_0 = 100 - var_0_10

	for iter_47_0, iter_47_1 in ipairs(arg_47_0.mainNodes_) do
		var_47_0 = var_47_0 + var_0_10
		var_47_0 = var_47_0 + arg_47_0:CreateNode(iter_47_1, var_0_8, var_47_0, arg_47_0.mainNodes_[iter_47_0 - 1])

		local var_47_1 = 0

		for iter_47_2, iter_47_3 in ipairs(iter_47_1.children) do
			if iter_47_3.type == ChapterV2MapConst.MapEventType.SIDE then
				var_47_1 = var_0_10 / 2

				local var_47_2 = iter_47_1.children[iter_47_2 - 1] or iter_47_1
				local var_47_3 = var_47_2 and ChapterV2MapTools.IsEventConflict(iter_47_3.id, var_47_2.id) or false

				if var_47_3 then
					var_47_0 = var_47_0 + arg_47_0.lineConflict_.transform.rect.height - arg_47_0.sideItem_.transform.rect.height / 2
				else
					var_47_0 = var_47_0 + var_0_10 / 2
				end

				var_47_0 = var_47_0 + arg_47_0:CreateNode(iter_47_3, var_0_8 + var_0_9, var_47_0, var_47_2, var_47_3)

				for iter_47_4, iter_47_5 in ipairs(iter_47_3.children) do
					var_47_0 = var_47_0 + arg_47_0:CreateNode(iter_47_5, var_0_8 + var_0_9, var_47_0)
				end
			else
				var_47_0 = var_47_0 + arg_47_0:CreateNode(iter_47_3, var_0_8, var_47_0)
			end
		end

		var_47_0 = var_47_0 - var_47_1
	end

	arg_47_0.contScroll_.content.sizeDelta = Vector2.New(arg_47_0.contScroll_.content.sizeDelta.x, var_47_0 + 50)
end

function var_0_0.Dispose(arg_48_0)
	arg_48_0.mainNodes_ = nil
	arg_48_0.sideNodes_ = nil

	var_0_3(arg_48_0.poolMain_)

	arg_48_0.poolMain_ = nil

	var_0_3(arg_48_0.poolSide_)

	arg_48_0.poolSide_ = nil

	var_0_3(arg_48_0.poolLine_)

	arg_48_0.poolLine_ = nil

	var_0_3(arg_48_0.poolLineConflict_)

	arg_48_0.poolLineConflict_ = nil

	var_0_3(arg_48_0.poolLineAngle_)

	arg_48_0.poolLineAngle_ = nil

	var_0_0.super.Dispose(arg_48_0)
end

return var_0_0
