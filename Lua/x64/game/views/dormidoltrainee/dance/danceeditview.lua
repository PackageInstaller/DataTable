local var_0_0 = class("DanceEditView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolDance/IdolDanceEditActionUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.selectedSlot = nil
	arg_3_0.unitedSizeSlot = true
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.statisticsSubView = {}

	arg_4_0:BindCfgUI(arg_4_0.statisticsPanel_, arg_4_0.statisticsSubView)

	local var_4_0 = {
		enable = arg_4_0.statisticsSubView.controllers_:GetController("enable"),
		alreadyLike = arg_4_0.statisticsSubView.controllers_:GetController("alreadyLike"),
		alreadyCollect = arg_4_0.statisticsSubView.controllers_:GetController("alreadyCollect")
	}

	arg_4_0.statisticsSubView.controllers = var_4_0
	arg_4_0.statisticsSubView.headItem = CommonHeadPortrait.New(arg_4_0.statisticsSubView.headItem_)
	arg_4_0.playStateController = arg_4_0.controllers_:GetController("play")
	arg_4_0.hideUIController = arg_4_0.controllers_:GetController("hideUI")
	arg_4_0.editStateController = arg_4_0.controllers_:GetController("editState")
	arg_4_0.showPromptController = arg_4_0.controllers_:GetController("showPrompt")
	arg_4_0.enableSelMusicController = arg_4_0.controllers_:GetController("enableSelMusic")
	arg_4_0.actionList = LuaList.New(handler(arg_4_0, arg_4_0.RenderActionItem), arg_4_0.actionList_, DanceActionItem)
	arg_4_0.timelineSlotMarkers = {}
	arg_4_0.timelineActionSlots = {}

	arg_4_0:RegisterEvents()
	arg_4_0:AddUIListeners()
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_5_0:CancelEdit()
	end)
	arg_5_0:InitActionList()
end

function var_0_0.OnBehind(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.ProcessLoadParam(arg_8_0, arg_8_1)
	local var_8_0
	local var_8_1
	local var_8_2
	local var_8_3 = IdolTraineeTools.GetDIYDataFromLoadInfo(arg_8_1)

	if arg_8_1.source == IdolTraineeConst.DataSource.MyData then
		var_8_3 = var_8_3 or IdolTraineeData:NewDanceDIYSequence()
		arg_8_0.curEditing = arg_8_1.id
		arg_8_0.sharedByOtherData = nil
		var_8_1 = arg_8_1.name

		arg_8_0.editStateController:SetSelectedState("readOnly")
		arg_8_0:TrySetReadOnly(arg_8_0.params_.readOnly)
	elseif arg_8_1.source == IdolTraineeConst.DataSource.MySharedData then
		arg_8_0.sharedByOtherData, arg_8_0.curEditing = arg_8_1.id
		var_8_1 = arg_8_1.name

		arg_8_0.editStateController:SetSelectedState("mySharedData")
		arg_8_0:TrySetReadOnly(true)
	else
		arg_8_0.sharedByOtherData, arg_8_0.curEditing = arg_8_1.id
		var_8_1 = arg_8_1.name

		arg_8_0.editStateController:SetSelectedState("othersSharedData")
		arg_8_0:TrySetReadOnly(true)
	end

	local var_8_4 = arg_8_0.params_.music or DIYBridge.music

	return var_8_3, var_8_1, var_8_4
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.hideUIController:SetSelectedState("false")
	manager.ui:SetMainCamera("dance")

	if arg_9_0.params_.isBack and not arg_9_0.params_.forceReset then
		return
	end

	local var_9_0 = arg_9_0.params_.load
	local var_9_1, var_9_2, var_9_3 = arg_9_0:ProcessLoadParam(var_9_0)

	if arg_9_0.params_.forceReset then
		arg_9_0.dirty = true
		arg_9_0.music = var_9_3
	else
		arg_9_0.dirty = false
		arg_9_0.music = var_9_1.music or var_9_3
	end

	arg_9_0:RefreshStatistics(var_9_0, var_9_1)

	arg_9_0.alreadyShared = nil
	arg_9_0.dataName_.text = var_9_2 or ""
	arg_9_0.dataName2_.text = var_9_2 or ""
	arg_9_0.musicName_.text = IdolStageMusicCfg[arg_9_0.music].music_name
	DIYBridge.music = arg_9_0.music

	manager.audio:StopBGM()
	arg_9_0:InitActionList()
	arg_9_0:InitActionSlots(arg_9_0.music)
	arg_9_0:ResetTimelineCursor()

	if not arg_9_0.params_.forceReset then
		arg_9_0:LoadDIYData(var_9_1)
	end

	if arg_9_0.params_.loadSceneFromSaveData and nullable(IdolStageSceneCfg, var_9_1.scene) then
		DIYBridge:SetScene(var_9_1.scene)
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:StopPreviewSequenceAction()
	arg_10_0:NotifyDisposeDraggingDummy()
	arg_10_0:NotifySelectSlotChange(nil)
	arg_10_0:ShowPromptBtDrag(true)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.statisticsSubView.headItem:Dispose()
	arg_11_0.actionList:Dispose()
	arg_11_0:ClearActionSlots()

	arg_11_0.selectedSlot = nil

	var_0_0.super.Dispose(arg_11_0)
end

local var_0_1 = "--"

function var_0_0.RefreshStatistics(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.statisticsSubView

	var_12_0.like = arg_12_2.liked or 0

	if arg_12_1.source == IdolTraineeConst.DataSource.OthersSharedData then
		var_12_0.controllers.enable:SetSelectedState("true")

		local var_12_1 = arg_12_2.myTodayLiked and arg_12_2.myTodayLiked > 0

		var_12_0.controllers.alreadyLike:SetSelectedState(var_12_1 and "true" or "false")
	else
		var_12_0.controllers.enable:SetSelectedState("false")
		var_12_0.controllers.alreadyLike:SetSelectedState("false")
	end

	var_12_0.controllers.alreadyCollect:SetSelectedState("false")

	var_12_0.collectedCnt_.text = arg_12_2.collcted or var_0_1
	var_12_0.viewedCnt_.text = arg_12_2.viewCount or var_0_1
	var_12_0.likedCnt_.text = arg_12_2.liked or var_0_1

	if arg_12_1.authorInfo then
		local var_12_2 = arg_12_1.authorInfo

		var_12_0.headItem:Render(var_12_2)
		var_12_0.headItem:RegisteClickCallback(function()
			if var_12_2.uid == nil or var_12_2.uid == PlayerData:GetPlayerInfo().userID then
				return
			end

			if CooperationData:CheckInRoom() then
				return
			end

			ForeignInfoAction:TryToCheckForeignDetailInfo(var_12_2.uid, true)
		end)
	end
end

function var_0_0.ClearActionSlots(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.timelineActionSlots) do
		iter_14_1:Dispose()
		GameObject.Destroy(iter_14_1.gameObject_)
	end

	arg_14_0.timelineActionSlots = {}
end

function var_0_0.RenderActionItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.actions

	arg_15_2.parentScroll = arg_15_0.actionList_._scrollRect

	local var_15_1 = var_15_0[arg_15_1]

	arg_15_2:SetData(var_15_1)
	arg_15_2:SetDragDummyRoot(arg_15_0.transform_)
	arg_15_2:SetSelected(arg_15_0.curSelectAction == var_15_1)

	if arg_15_0.previewAction and arg_15_0.previewAction == var_15_1 then
		if arg_15_0.previewActionProgress then
			if not arg_15_2:IsDuringPreview() then
				arg_15_2:OnPreviewStart()
			end

			arg_15_2:OnPreviewUpdate(arg_15_0.previewActionProgress)
		else
			arg_15_2:OnPreviewEnd(true)
		end
	else
		arg_15_2:OnPreviewEnd(false)
	end
end

function var_0_0.RegisterEvents(arg_16_0)
	arg_16_0:RegistEventListener("IDOL_DANCE_COLLECTION_VIEWED", function()
		arg_16_0.actionList:Refresh()
	end)
end

function var_0_0.SetActionListVisible(arg_18_0, arg_18_1)
	SetActive(arg_18_0.actionList_.gameObject, arg_18_1)
end

function var_0_0.GetActionListVisible(arg_19_0)
	if isNil(arg_19_0.actionList_.gameObject) then
		return false
	end

	return arg_19_0.actionList_.gameObject.activeInHierarchy
end

function var_0_0.InitActionList(arg_20_0)
	local var_20_0 = IdolTraineeTools.FilterDIYDanceAction
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs(IdolDanceDIYActionCfg.all) do
		if IdolTraineeData:DanceDIYActionAvailable(iter_20_1) and (var_20_0 == nil or var_20_0(iter_20_1)) then
			table.insert(var_20_1, iter_20_1)
		end
	end

	arg_20_0.actions = var_20_1

	arg_20_0.actionList:StartScroll(#var_20_1)
	arg_20_0:SetActionListVisible(true)
end

local var_0_2 = 2
local var_0_3 = 1250
local var_0_4 = {}

function var_0_0.NewSlot(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.type
	local var_21_1 = GameObject.Instantiate(arg_21_0.slotPrefab_, arg_21_0.timelineArea_)
	local var_21_2 = DanceActionSlot.New(var_21_1)

	var_21_2:SetData(nil, var_21_0)
	var_21_2:SetFilter(nullable(var_0_4, var_21_0))
	var_21_2:SetSelected(false)

	var_21_2.parentScroll = arg_21_0.timelineScroll_

	var_21_2:GenLinkedMarker(arg_21_0.slotMarkerPrefab_, arg_21_0.markerRoot_)

	return var_21_2
end

function var_0_0.InitActionSlots(arg_22_0, arg_22_1)
	arg_22_0:ClearActionSlots()

	local var_22_0 = IdolStageMusicCfg[arg_22_1]
	local var_22_1 = var_22_0.music_json
	local var_22_2 = AssetEx.LoadText(var_22_1)
	local var_22_3 = require("cjson").decode(var_22_2)
	local var_22_4 = var_22_0.music_duration

	if var_22_4 then
		var_22_4 = var_22_4 * 1000
	else
		var_22_4 = DanceGameController.GetCueInfoLength(var_22_0.cue_sheet, var_22_0.cue_name, var_22_0.awb_name)
	end

	local var_22_5 = 0
	local var_22_6 = {}

	for iter_22_0 = 1, var_0_2 do
		local var_22_7 = var_22_3["track" .. iter_22_0]

		for iter_22_1, iter_22_2 in pairs(var_22_7) do
			local var_22_8 = math.max(unpack(iter_22_2))

			if var_22_5 < var_22_8 then
				var_22_5 = var_22_8
			end

			table.insert(var_22_6, {
				type = iter_22_0,
				segment = iter_22_2
			})
		end
	end

	CommonTools.UniversalSortEx(var_22_6, {
		ascend = true,
		map = function(arg_23_0)
			return arg_23_0.segment[1]
		end
	})

	if var_22_4 <= 0 then
		var_22_4 = var_22_5 + var_0_3
	end

	arg_22_0.duration = var_22_4 / 1000

	for iter_22_3, iter_22_4 in ipairs(var_22_6) do
		local var_22_9 = arg_22_0:NewSlot(iter_22_4)

		table.insert(arg_22_0.timelineActionSlots, var_22_9)

		local var_22_10 = iter_22_4.segment

		var_22_9:SetTime(var_22_10[1] / var_22_4, var_22_10[2] / var_22_4)

		var_22_9.readOnly = arg_22_0.readOnly

		var_22_9:SetDragDummyRoot(arg_22_0.transform_)
	end

	arg_22_0:OnTimelineResize(1)

	arg_22_0.timelineScroll_.horizontalNormalizedPosition = 0
end

function var_0_0.LoadDIYData(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in pairs(arg_24_1.actionList) do
		local var_24_0 = arg_24_0.timelineActionSlots[iter_24_0]

		if var_24_0 then
			var_24_0:SetData(iter_24_1)
		end
	end
end

function var_0_0.TryMoveSlotInTimelineViewport(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1.left or arg_25_1.ntStart
	local var_25_1 = arg_25_1.right or arg_25_1.ntEnd
	local var_25_2 = arg_25_0.timelineScroll_.horizontalScrollbar.size
	local var_25_3 = 1 - var_25_2
	local var_25_4 = arg_25_0.timelineScroll_.horizontalNormalizedPosition

	if arg_25_2 or var_25_0 < var_25_4 * var_25_3 then
		arg_25_0.timelineScroll_.horizontalNormalizedPosition = var_25_0 / var_25_3
	elseif var_25_1 > var_25_4 * var_25_3 + var_25_2 then
		arg_25_0.timelineScroll_.horizontalNormalizedPosition = (var_25_1 - var_25_2) / var_25_3
	end
end

function var_0_0.OnDanceActionSlotMarkerClicked(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.slot

	arg_26_0:NotifySelectSlotChange(var_26_0)
	arg_26_0:TryMoveSlotInTimelineViewport(var_26_0)
end

function var_0_0.OnDanceItemPointerDown(arg_27_0, arg_27_1)
	return
end

function var_0_0.OnDanceItemPointerClick(arg_28_0, arg_28_1)
	if DIYBridge:GetCurPreviewPriority() <= 1 then
		if arg_28_1.actionID == arg_28_0.previewAction and arg_28_0.previewActionProgress then
			DIYBridge:StopAllPreviewTasks()
		else
			DIYBridge:PreviewSingleAction(arg_28_0:GetSequenceActionInfoFromActionItem(arg_28_1))
		end
	end

	arg_28_0.curSelectAction = arg_28_1.actionID

	arg_28_0.actionList:Refresh()
end

function var_0_0.OnDanceActionSlotPointerClick(arg_29_0, arg_29_1)
	if arg_29_0.playStateController:GetSelectedState() == "pause" then
		arg_29_0:StopPreviewSequenceAction()
		arg_29_0:StartPreviewEntireTimelineSequence(arg_29_1.ntStart)
		arg_29_0:NotifySelectSlotChange(arg_29_1)
	elseif arg_29_0.selectedSlot ~= arg_29_1 then
		arg_29_0:NotifySelectSlotChange(arg_29_1)
	else
		arg_29_0:NotifySelectSlotChange(nil)
	end
end

function var_0_0.NotifySelectSlotChange(arg_30_0, arg_30_1)
	if arg_30_0.selectedSlot then
		arg_30_0.selectedSlot:SetSelected(false)
	end

	arg_30_0.selectedSlot = arg_30_1

	if arg_30_0.selectedSlot then
		arg_30_0.selectedSlot:SetSelected(true)
	end
end

function var_0_0.NotifyDisposeDraggingDummy(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.actionList:GetItemList()) do
		iter_31_1:DisposeDragDummy()
	end

	for iter_31_2, iter_31_3 in ipairs(arg_31_0.timelineActionSlots) do
		iter_31_3:DisposeDragDummy()
	end
end

local function var_0_5(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.position

	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_32_1, var_32_0, var_0_0.GetUICam())
end

function var_0_0.FindAcceptDragItem(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0.playStateController:GetSelectedState() == "pause" then
		return nil
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.timelineActionSlots) do
		if var_0_5(arg_33_2, iter_33_1:GetDropAreaRect()) and iter_33_1:WillAcceptDrop(arg_33_1) then
			return iter_33_1
		end
	end
end

function var_0_0.OnBeginDragDanceActionItem(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0.playStateController:GetSelectedState() == "pause" then
		return nil
	end

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.timelineActionSlots) do
		iter_34_1:SetDisplayAcccept(iter_34_1:WillAcceptDrop(arg_34_1))
	end

	arg_34_0.curSelectAction = arg_34_1.actionID

	arg_34_0.actionList:Refresh()
	arg_34_0:HidePromptByDrag()
end

function var_0_0.OnEndDragDanceActionItem(arg_35_0, arg_35_1, arg_35_2)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.timelineActionSlots) do
		iter_35_1:SetDisplayAcccept(false)
	end

	arg_35_1.moveController:SetSelectedState("off")
	arg_35_0:ShowPromptBtDrag()
end

function var_0_0.OnDragDanceActionItem(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = var_0_0.GetUICam()
	local var_36_1 = arg_36_1.dragDummy.offset or Vector2.zero
	local var_36_2, var_36_3 = UnityEngine.RectTransformUtility.ScreenPointToWorldPointInRectangle(arg_36_0.transform_, var_36_1 + arg_36_2.position, var_36_0, nil)
	local var_36_4 = arg_36_1.dragDummy.obj.transform
	local var_36_5 = arg_36_0:FindAcceptDragItem(arg_36_1, arg_36_2)

	if var_36_5 then
		local var_36_6 = var_36_5.transform_

		var_36_4:SetParent(arg_36_0.timelineScroll_.viewport, false)

		var_36_4.pivot = var_36_6.pivot
		var_36_4.sizeDelta = var_36_6.sizeDelta
		var_36_4.position = var_36_6.position
	else
		var_36_4:SetParent(arg_36_1.dragDummy.parent)

		var_36_4.pivot = arg_36_1.dragDummy.pivot
		var_36_4.sizeDelta = arg_36_1.dragDummy.size
		var_36_4.position = var_36_3
	end
end

function var_0_0.OnDropDanceActionItem(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0:FindAcceptDragItem(arg_37_1, arg_37_2)

	if var_37_0 and var_37_0:WillAcceptDrop(arg_37_1) then
		arg_37_1:OnDropAccepted(var_37_0)

		arg_37_0.dirty = true
		arg_37_0.alreadyShared = nil
	end

	arg_37_0:OnEndDragDanceActionItem(arg_37_1, arg_37_2)
end

local var_0_6 = 10
local var_0_7 = 0.25
local var_0_8 = 50
local var_0_9 = 460

function var_0_0.OnTimelineResize(arg_38_0, arg_38_1)
	local var_38_0

	arg_38_1 = math.max(var_0_7, math.min(var_0_6, arg_38_1))

	if arg_38_0.unitedSizeSlot then
		var_38_0 = #arg_38_0.timelineActionSlots * var_0_9 * arg_38_1
	else
		local var_38_1 = var_0_8 * arg_38_1

		var_38_0 = arg_38_0.duration * var_38_1
	end

	arg_38_0.timelineArea_.sizeDelta = Vector2(var_38_0, arg_38_0.timelineArea_.sizeDelta.y)

	arg_38_0:UpdateAllTimelineElements()
end

function var_0_0.AddUIListeners(arg_39_0)
	arg_39_0:AddBtnListenerScale(arg_39_0.previewSeqBtn_, nil, function()
		if arg_39_0.playStateController:GetSelectedState() == "pause" then
			arg_39_0:StopPreviewSequenceAction()
			arg_39_0:SwitchPlayState("normal")
		else
			arg_39_0.previewAction = nil
			arg_39_0.previewActionProgress = nil

			arg_39_0.actionList:Refresh()
			arg_39_0:StartPreviewEntireTimelineSequence(nullable(arg_39_0.selectedSlot, "ntStart") or 0)
		end
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.editBtn_, nil, function()
		arg_39_0:TrySetReadOnly(false)
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.shareBtn_, nil, function()
		arg_39_0:Share()
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.saveBtn_, nil, function()
		arg_39_0:Save()
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.cancelBtn_, nil, function()
		arg_39_0:CancelEdit()
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.delBtn_, nil, function()
		arg_39_0:DelCurEditingData()
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.stopShareBtn_, nil, function()
		arg_39_0:DelSharingData()
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.statisticsSubView.likeBtn_, nil, function()
		arg_39_0:Like()
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.statisticsSubView.collectBtn_, nil, function()
		arg_39_0:Fork()
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.selMusic_, nil, function()
		if not arg_39_0.readOnly and arg_39_0.curEditing then
			arg_39_0:StopPreviewSequenceAction()
			JumpTools.OpenPageByJump("idolDanceSelMusic", {
				music = arg_39_0.music,
				onSelectMusic = function(arg_50_0, arg_50_1)
					return arg_39_0:ConfirmChangeMusic(arg_50_1, arg_50_0)
				end
			})
		end
	end)
	arg_39_0:AddBtnListenerScale(arg_39_0.filterbtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List
		})
	end)

	local function var_39_0()
		local var_52_0 = arg_39_0.hideUIController:GetSelectedIndex() == 0 and 1 or 0

		arg_39_0.hideUIController:SetSelectedIndex(var_52_0)
	end

	arg_39_0:AddBtnListenerScale(arg_39_0.switchDisplayBtn_, nil, var_39_0)
	arg_39_0:AddBtnListenerScale(arg_39_0.switchSlotDisplayModeBtn_, nil, function()
		arg_39_0:SwitchSlotDisplayMode()
	end)
end

function var_0_0.ConfirmChangeMusic(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_0.music ~= arg_54_1 then
		ShowMessageBox({
			content = GetTips("IDOL_DANCE_CONFIRM_CHANGE_MUSIC_AND_RESET_EDIT"),
			OkCallback = function()
				JumpTools.Back(1)
				arg_54_0:SetParams({
					forceReset = true,
					music = arg_54_1,
					load = {
						source = IdolTraineeConst.DataSource.MyData,
						name = arg_54_0.dataName_.text,
						id = arg_54_0.curEditing
					}
				})
				arg_54_0:StopPreviewSequenceAction()
				arg_54_0:OnEnter()
			end,
			CancelCallback = function()
				arg_54_2:SetSelectMusic(arg_54_0.music)
			end
		})

		return true
	end
end

function var_0_0.UpdateAllTimelineElements(arg_57_0)
	local var_57_0 = #arg_57_0.timelineActionSlots

	for iter_57_0, iter_57_1 in ipairs(arg_57_0.timelineActionSlots) do
		local var_57_1
		local var_57_2

		if arg_57_0.unitedSizeSlot then
			var_57_1, var_57_2 = (iter_57_0 - 1) / var_57_0, iter_57_0 / var_57_0
		end

		iter_57_1:UpdatePosByTimeInfo(var_57_1, var_57_2)
	end
end

function var_0_0.GetSequenceActionInfoFromActionItem(arg_58_0, arg_58_1)
	local function var_58_0()
		if arg_58_0:GetActionListVisible() then
			arg_58_0.actionList:Refresh()
		end
	end

	return {
		actionID = arg_58_1.actionID,
		action = arg_58_1:GetAction(),
		onStart = function(arg_60_0)
			arg_58_0.previewAction = arg_60_0.actionID
			arg_58_0.previewActionProgress = 0

			var_58_0()
		end,
		onUpdate = function(arg_61_0, arg_61_1)
			if arg_61_0.actionID == arg_58_0.previewAction then
				arg_58_0.previewActionProgress = arg_61_1

				var_58_0()
			end
		end,
		onAbort = function(arg_62_0)
			if arg_62_0.actionID == arg_58_0.previewAction then
				arg_58_0.previewActionProgress = nil

				var_58_0()
			end
		end,
		onComplete = function(arg_63_0)
			if arg_63_0.actionID == arg_58_0.previewAction then
				arg_58_0.previewAction = nil
				arg_58_0.previewActionProgress = nil

				var_58_0()
			end
		end
	}
end

function var_0_0.GetSequenceActionInfoFromSlotItem(arg_64_0, arg_64_1, arg_64_2)
	arg_64_2 = arg_64_2 or 0

	return {
		startTime = (arg_64_1.ntStart - arg_64_2) * arg_64_0.duration,
		endTime = (arg_64_1.ntEnd - arg_64_2) * arg_64_0.duration,
		actionID = arg_64_1.actionID,
		action = arg_64_1:GetAction(),
		onStart = function(arg_65_0)
			arg_64_1:OnPreviewStart()
		end,
		onUpdate = function(arg_66_0, arg_66_1)
			arg_64_1:OnPreviewUpdate(arg_66_1)
		end,
		onAbort = function(arg_67_0)
			arg_64_1:OnPreviewEnd(false)
		end,
		onComplete = function(arg_68_0)
			arg_64_1:OnPreviewEnd(false)
		end
	}
end

function var_0_0.StartPreviewEntireTimelineSequence(arg_69_0, arg_69_1)
	arg_69_1 = arg_69_1 or 0

	local var_69_0 = {}

	for iter_69_0, iter_69_1 in ipairs(arg_69_0.timelineActionSlots) do
		if arg_69_1 <= iter_69_1.ntStart then
			table.insert(var_69_0, arg_69_0:GetSequenceActionInfoFromSlotItem(iter_69_1, arg_69_1))
		end
	end

	arg_69_0.timelineCursor_.transform:SetAsLastSibling()
	arg_69_0:ResetTimelineCursor()
	LeanTween.value(arg_69_0.timelineCursor_, arg_69_1, 1, (1 - arg_69_1) * arg_69_0.duration):setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
		arg_69_0.previewCountdown_.text = manager.time:DescCDTime4((1 - arg_70_0) * arg_69_0.duration)

		if arg_69_0.unitedSizeSlot then
			arg_70_0 = arg_69_0:CalcUnitedPreviewProgress(arg_70_0)
		end

		arg_69_0.previewProgress_.fillAmount = arg_70_0
		arg_69_0.timelineCursor_.transform.anchoredPosition = Vector2(arg_70_0 * arg_69_0.timelineArea_.rect.width, 0)
	end)):setOnComplete(System.Action(function()
		arg_69_0.curPreviewingSlot = nil
		arg_69_0.previewCountdown_.text = manager.time:DescCDTime4(0)

		arg_69_0:SwitchPlayState("normal")
		arg_69_0:SetActionListVisible(true)
		arg_69_0.hideUIController:SetSelectedState("false")
	end))
	DIYBridge:PreviewSequenceAction(var_69_0, arg_69_1 * arg_69_0.duration)
	arg_69_0:SwitchPlayState("pause")
	arg_69_0:SetActionListVisible(false)
end

function var_0_0.UpdateTimelineCursorBySlotProgress(arg_72_0, arg_72_1, arg_72_2)
	local var_72_0 = arg_72_1.left or arg_72_1.ntStart
	local var_72_1 = arg_72_2 * (arg_72_1.right or arg_72_1.ntEnd) + (1 - arg_72_2) * var_72_0

	arg_72_0.curPreviewingSlot = arg_72_1
end

function var_0_0.CalcUnitedPreviewProgress(arg_73_0, arg_73_1)
	local var_73_0 = 0

	for iter_73_0, iter_73_1 in ipairs(arg_73_0.timelineActionSlots) do
		if arg_73_1 >= iter_73_1.ntEnd then
			if var_73_0 < iter_73_1.ntEnd then
				var_73_0 = iter_73_1.right
			end
		elseif arg_73_1 >= iter_73_1.ntStart then
			return (arg_73_1 - iter_73_1.ntStart) / (iter_73_1.ntEnd - iter_73_1.ntStart) * (iter_73_1.right - iter_73_1.left) + iter_73_1.left
		end
	end

	return var_73_0
end

function var_0_0.ResetTimelineCursor(arg_74_0)
	arg_74_0.curPreviewingSlot = nil
	arg_74_0.previewProgress_.fillAmount = 0
	arg_74_0.timelineCursor_.transform.anchoredPosition = Vector3.zero

	LeanTween.cancel(arg_74_0.timelineCursor_, true)
end

function var_0_0.StopPreviewSequenceAction(arg_75_0)
	DIYBridge:StopAllPreviewTasks()
	arg_75_0:ResetTimelineCursor()
end

function var_0_0.Save(arg_76_0)
	local var_76_0 = IdolTraineeData:GetDanceDIYSequence(arg_76_0.curEditing) or IdolTraineeData:NewDanceDIYSequence()
	local var_76_1 = {}

	for iter_76_0, iter_76_1 in ipairs(arg_76_0.timelineActionSlots) do
		var_76_1[iter_76_0] = iter_76_1.actionID or 0
	end

	var_76_0.music = arg_76_0.music
	var_76_0.scene = DIYBridge.scene
	var_76_0.actionList = var_76_1

	IdolTraineeAction.SaveDanceDIYSequence(arg_76_0.curEditing, var_76_0, function()
		arg_76_0:TrySetReadOnly(true)

		arg_76_0.dirty = false
	end)
end

function var_0_0.Like(arg_78_0)
	if arg_78_0.sharedByOtherData then
		if arg_78_0.statisticsSubView.controllers.alreadyLike:GetSelectedState() == "true" then
			ShowTips("IDOL_DANCE_DIY_ALREADY_LIKED")
		else
			IdolTraineeAction.Like(arg_78_0.sharedByOtherData, function()
				arg_78_0.statisticsSubView.controllers.alreadyLike:SetSelectedState("true")

				local var_79_0 = arg_78_0.statisticsSubView.like + 1

				IdolTraineeTools.GetDIYDataFromLoadInfo(arg_78_0.params_.load).liked = var_79_0
				arg_78_0.statisticsSubView.like = var_79_0
				arg_78_0.statisticsSubView.likedCnt_.text = arg_78_0.statisticsSubView.like

				IdolTraineeTools.FetchSharedDIY(true, IdolTraineeConst.shareCategory.History)
			end)
		end
	end
end

function var_0_0.Fork(arg_80_0)
	if arg_80_0.sharedByOtherData then
		local var_80_0 = IdolTraineeData:GetDanceDIYAvailableSlotIdx()

		if var_80_0 then
			local var_80_1 = IdolTraineeData:NewDanceDIYSequence()
			local var_80_2 = {}

			for iter_80_0, iter_80_1 in ipairs(arg_80_0.timelineActionSlots) do
				var_80_2[iter_80_0] = iter_80_1.actionID or 0
			end

			var_80_1.music = arg_80_0.music
			var_80_1.scene = DIYBridge.scene
			var_80_1.actionList = var_80_2

			IdolTraineeAction.ForkDIYSequence(arg_80_0.sharedByOtherData, var_80_1, var_80_0, function(arg_81_0, arg_81_1)
				arg_80_0.statisticsSubView.collectedCnt_.text = arg_81_1
				IdolTraineeTools.GetDIYDataFromLoadInfo(arg_80_0.params_.load).collcted = arg_81_1

				ShowTips(GetTipsF("IDOL_DANCE_EDIT_COLLECT_SHARED_SUCCESS", var_80_0))
			end)
		else
			ShowTips("IDOL_DANCE_EDIT_NO_DIY_DATA_SLOT")
		end
	end
end

function var_0_0.CancelEdit(arg_82_0)
	if arg_82_0.dirty then
		ShowMessageBox({
			content = GetTips("IDOL_DANCE_DIY_CONFIRM_ABORT_EDIT"),
			OkCallback = JumpTools.Back
		})
	else
		JumpTools.Back()
	end
end

function var_0_0.Share(arg_83_0)
	if arg_83_0.alreadyShared then
		ShowTips("IDOL_DANCE_DIY_ALREADY_SHARED")

		return
	end

	local var_83_0 = IdolTraineeData:NewDanceDIYSequence()
	local var_83_1 = var_83_0.actionList

	for iter_83_0, iter_83_1 in ipairs(arg_83_0.timelineActionSlots) do
		var_83_1[iter_83_0] = iter_83_1.actionID or 0
	end

	var_83_0.music = arg_83_0.music
	var_83_0.scene = DIYBridge.scene

	IdolTraineeAction.ShareDanceDIYSequence(var_83_0, function()
		ShowTips("IDOL_DANCE_DIY_SHARE_SUCCESS")

		arg_83_0.alreadyShared = true
	end)
end

function var_0_0.DelCurEditingData(arg_85_0)
	if arg_85_0.curEditing then
		ShowMessageBox({
			content = GetTips("IDOL_DANCE_CONFIRM_DEL"),
			OkCallback = function()
				for iter_86_0, iter_86_1 in ipairs(arg_85_0.timelineActionSlots) do
					iter_86_1:Clear()
				end

				arg_85_0.timelineScroll_.horizontalNormalizedPosition = 0
			end
		})
	end
end

function var_0_0.DelSharingData(arg_87_0)
	if arg_87_0.sharedByOtherData then
		ShowMessageBox({
			content = GetTips("IDOL_DANCE_CONFIRM_STOP_SHARE"),
			OkCallback = function()
				IdolTraineeAction.StopShareDanceDIYSeqence(arg_87_0.sharedByOtherData)
				JumpTools.Back()
			end
		})
	end
end

function var_0_0.TrySetReadOnly(arg_89_0, arg_89_1)
	local var_89_0 = arg_89_0.editStateController:GetSelectedState()

	if not arg_89_1 then
		if var_89_0 == "readOnly" then
			arg_89_0.editStateController:SetSelectedState("edit")
		else
			arg_89_1 = true
		end
	elseif var_89_0 == "edit" then
		arg_89_0.editStateController:SetSelectedState("readOnly")
	end

	arg_89_0.readOnly = arg_89_1

	arg_89_0:SetSelMusicBtnInteractable(not arg_89_1)

	for iter_89_0, iter_89_1 in ipairs(arg_89_0.timelineActionSlots) do
		iter_89_1.readOnly = arg_89_1
	end

	arg_89_0:UpdateDragPromptVisible()
end

function var_0_0.SetSelMusicBtnInteractable(arg_90_0, arg_90_1)
	arg_90_0.selMusic_.interactable = arg_90_1

	arg_90_0.enableSelMusicController:SetSelectedState(arg_90_1 and "true" or "false")
end

function var_0_0.SwitchPlayState(arg_91_0, arg_91_1)
	arg_91_0.playStateController:SetSelectedState(arg_91_1)
	arg_91_0:UpdateDragPromptVisible()
end

function var_0_0.SwitchSlotDisplayMode(arg_92_0)
	arg_92_0.unitedSizeSlot = not arg_92_0.unitedSizeSlot

	arg_92_0:UpdateAllTimelineElements()

	if arg_92_0.curPreviewingSlot then
		arg_92_0:TryMoveSlotInTimelineViewport(arg_92_0.curPreviewingSlot, true)
	end
end

function var_0_0.HidePromptByDrag(arg_93_0)
	arg_93_0.dragCnt = (arg_93_0.dragCnt or 0) + 1

	arg_93_0:UpdateDragPromptVisible()
end

function var_0_0.ShowPromptBtDrag(arg_94_0, arg_94_1)
	if arg_94_1 then
		arg_94_0.dragCnt = nil
	else
		arg_94_0.dragCnt = math.max(0, (arg_94_0.dragCnt or 0) - 1)
	end

	arg_94_0:UpdateDragPromptVisible()
end

function var_0_0.UpdateDragPromptVisible(arg_95_0)
	local var_95_0 = arg_95_0.dragCnt or 0
	local var_95_1 = not arg_95_0.readOnly and arg_95_0.playStateController:GetSelectedState() == "normal" and var_95_0 == 0

	arg_95_0.showPromptController:SetSelectedState(var_95_1 and "true" or "false")
end

return var_0_0
