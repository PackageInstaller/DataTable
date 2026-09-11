local DanceEditView = class("DanceEditView", ReduxView)

function DanceEditView:UIName()
	return "Widget/BackHouseUI/IdolDance/IdolDanceEditActionUI"
end

function DanceEditView:UIParent()
	return manager.ui.uiMain.transform
end

function DanceEditView:OnCtor()
	self.selectedSlot = nil
	self.unitedSizeSlot = true
end

function DanceEditView:Init()
	self:BindCfgUI()

	self.statisticsSubView = {}

	self:BindCfgUI(self.statisticsPanel_, self.statisticsSubView)

	self.statisticsSubView.controllers = {
		enable = self.statisticsSubView.controllers_:GetController("enable"),
		alreadyLike = self.statisticsSubView.controllers_:GetController("alreadyLike"),
		alreadyCollect = self.statisticsSubView.controllers_:GetController("alreadyCollect")
	}
	self.statisticsSubView.headItem = CommonHeadPortrait.New(self.statisticsSubView.headItem_)
	self.playStateController = self.controllers_:GetController("play")
	self.hideUIController = self.controllers_:GetController("hideUI")
	self.editStateController = self.controllers_:GetController("editState")
	self.showPromptController = self.controllers_:GetController("showPrompt")
	self.enableSelMusicController = self.controllers_:GetController("enableSelMusic")
	self.actionList = LuaList.New(handler(self, self.RenderActionItem), self.actionList_, DanceActionItem)
	self.timelineSlotMarkers = {}
	self.timelineActionSlots = {}

	self:RegisterEvents()
	self:AddUIListeners()
end

function DanceEditView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:CancelEdit()
	end)
	self:InitActionList()
end

function DanceEditView:OnBehind()
	manager.windowBar:HideBar()
end

function DanceEditView:ProcessLoadParam(arg_8_1)
	local var_8_1
	local var_8_3 = IdolTraineeTools.GetDIYDataFromLoadInfo(arg_8_1)

	if arg_8_1.source == IdolTraineeConst.DataSource.MyData then
		var_8_3 = var_8_3 or IdolTraineeData:NewDanceDIYSequence()
		self.curEditing = arg_8_1.id
		self.sharedByOtherData = nil
		var_8_1 = arg_8_1.name

		self.editStateController:SetSelectedState("readOnly")
		self:TrySetReadOnly(self.params_.readOnly)
	else
		if arg_8_1.source == IdolTraineeConst.DataSource.MySharedData then
			self.sharedByOtherData, self.curEditing = arg_8_1.id
			var_8_1 = arg_8_1.name

			self.editStateController:SetSelectedState("mySharedData")
			self:TrySetReadOnly(true)
		end

		local var_8_4

		do
			self.sharedByOtherData, self.curEditing = arg_8_1.id
			var_8_1 = arg_8_1.name

			self.editStateController:SetSelectedState("othersSharedData")
			self:TrySetReadOnly(true)

			var_8_4 = var_8_3
		end
	end

	return var_8_4, var_8_1, self.params_.music or DIYBridge.music
end

function DanceEditView:OnEnter()
	self.hideUIController:SetSelectedState("false")
	manager.ui:SetMainCamera("dance")

	if self.params_.isBack and not self.params_.forceReset then
		return
	end

	local var_9_0 = self.params_.load
	local var_9_1, var_9_2, var_9_3 = self:ProcessLoadParam(self.params_.load)

	if self.params_.forceReset then
		self.dirty = true
		self.music = var_9_3
	else
		self.dirty = false
		self.music = var_9_1.music or var_9_3
	end

	self:RefreshStatistics(var_9_0, var_9_1)

	self.alreadyShared = nil
	self.dataName_.text = var_9_2 or ""
	self.dataName2_.text = var_9_2 or ""
	self.musicName_.text = IdolStageMusicCfg[self.music].music_name
	DIYBridge.music = self.music

	manager.audio:StopBGM()
	self:InitActionList()
	self:InitActionSlots(self.music)
	self:ResetTimelineCursor()

	if not self.params_.forceReset then
		self:LoadDIYData(var_9_1)
	end

	if self.params_.loadSceneFromSaveData and nullable(IdolStageSceneCfg, var_9_1.scene) then
		DIYBridge:SetScene(var_9_1.scene)
	end
end

function DanceEditView:OnExit()
	self:StopPreviewSequenceAction()
	self:NotifyDisposeDraggingDummy()
	self:NotifySelectSlotChange(nil)
	self:ShowPromptBtDrag(true)
end

function DanceEditView:Dispose()
	self.statisticsSubView.headItem:Dispose()
	self.actionList:Dispose()
	self:ClearActionSlots()

	self.selectedSlot = nil

	DanceEditView.super.Dispose(self)
end

local var_0_1 = "--"

function DanceEditView:RefreshStatistics(arg_12_1, arg_12_2)
	self.statisticsSubView.like = arg_12_2.liked or 0

	if arg_12_1.source == IdolTraineeConst.DataSource.OthersSharedData then
		self.statisticsSubView.controllers.enable:SetSelectedState("true")
		self.statisticsSubView.controllers.alreadyLike:SetSelectedState(arg_12_2.myTodayLiked and arg_12_2.myTodayLiked > 0 and "true" or "false")
	else
		self.statisticsSubView.controllers.enable:SetSelectedState("false")
		self.statisticsSubView.controllers.alreadyLike:SetSelectedState("false")
	end

	self.statisticsSubView.controllers.alreadyCollect:SetSelectedState("false")

	self.statisticsSubView.collectedCnt_.text = arg_12_2.collcted or var_0_1
	self.statisticsSubView.viewedCnt_.text = arg_12_2.viewCount or var_0_1
	self.statisticsSubView.likedCnt_.text = arg_12_2.liked or var_0_1

	if arg_12_1.authorInfo then
		local var_12_0 = arg_12_1.authorInfo

		self.statisticsSubView.headItem:Render(arg_12_1.authorInfo)
		self.statisticsSubView.headItem:RegisteClickCallback(function()
			if var_12_0.uid == nil or var_12_0.uid == PlayerData:GetPlayerInfo().userID then
				return
			end

			if CooperationData:CheckInRoom() then
				return
			end

			ForeignInfoAction:TryToCheckForeignDetailInfo(var_12_0.uid, true)
		end)
	end
end

function DanceEditView:ClearActionSlots()
	for iter_14_0, iter_14_1 in ipairs(self.timelineActionSlots) do
		iter_14_1:Dispose()
		GameObject.Destroy(iter_14_1.gameObject_)
	end

	self.timelineActionSlots = {}
end

function DanceEditView:RenderActionItem(arg_15_1, arg_15_2)
	arg_15_2.parentScroll = self.actionList_._scrollRect

	local var_15_0 = self.actions[arg_15_1]

	arg_15_2:SetData(self.actions[arg_15_1])
	arg_15_2:SetDragDummyRoot(self.transform_)
	arg_15_2:SetSelected(self.curSelectAction == var_15_0)

	if self.previewAction and self.previewAction == var_15_0 then
		if self.previewActionProgress then
			if not arg_15_2:IsDuringPreview() then
				arg_15_2:OnPreviewStart()
			end

			arg_15_2:OnPreviewUpdate(self.previewActionProgress)
		else
			arg_15_2:OnPreviewEnd(true)
		end
	else
		arg_15_2:OnPreviewEnd(false)
	end
end

function DanceEditView:RegisterEvents()
	self:RegistEventListener("IDOL_DANCE_COLLECTION_VIEWED", function()
		self.actionList:Refresh()
	end)
end

function DanceEditView:SetActionListVisible(arg_18_1)
	SetActive(self.actionList_.gameObject, arg_18_1)
end

function DanceEditView:GetActionListVisible()
	if isNil(self.actionList_.gameObject) then
		return false
	end

	return self.actionList_.gameObject.activeInHierarchy
end

function DanceEditView:InitActionList()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(IdolDanceDIYActionCfg.all) do
		if IdolTraineeData:DanceDIYActionAvailable(iter_20_1) and (IdolTraineeTools.FilterDIYDanceAction == nil or IdolTraineeTools.FilterDIYDanceAction(iter_20_1)) then
			table.insert(var_20_0, iter_20_1)
		end
	end

	self.actions = var_20_0

	self.actionList:StartScroll(#var_20_0)
	self:SetActionListVisible(true)
end

local var_0_2 = 2
local var_0_3 = 1250
local var_0_4 = {}

function DanceEditView:NewSlot(arg_21_1)
	local var_21_0 = DanceActionSlot.New((GameObject.Instantiate(self.slotPrefab_, self.timelineArea_)))

	var_21_0:SetData(nil, arg_21_1.type)
	var_21_0:SetFilter(nullable(var_0_4, arg_21_1.type))
	var_21_0:SetSelected(false)

	var_21_0.parentScroll = self.timelineScroll_

	var_21_0:GenLinkedMarker(self.slotMarkerPrefab_, self.markerRoot_)

	return var_21_0
end

function DanceEditView:InitActionSlots(arg_22_1)
	self:ClearActionSlots()

	local var_22_0 = require("cjson").decode((AssetEx.LoadText(IdolStageMusicCfg[arg_22_1].music_json)))
	local var_22_1 = IdolStageMusicCfg[arg_22_1].music_duration

	var_22_1 = IdolStageMusicCfg[arg_22_1].music_duration and var_22_1 * 1000 or DanceGameController.GetCueInfoLength(IdolStageMusicCfg[arg_22_1].cue_sheet, IdolStageMusicCfg[arg_22_1].cue_name, IdolStageMusicCfg[arg_22_1].awb_name)

	local var_22_2 = 0
	local var_22_3 = {}

	for iter_22_0 = 1, var_0_2 do
		for iter_22_1, iter_22_2 in pairs(var_22_0["track" .. iter_22_0]) do
			local var_22_4 = math.max(unpack(iter_22_2))

			if var_22_2 < var_22_4 then
				var_22_2 = var_22_4
			end

			table.insert(var_22_3, {
				type = iter_22_0,
				segment = iter_22_2
			})
		end
	end

	CommonTools.UniversalSortEx(var_22_3, {
		ascend = true,
		map = function(self)
			return self.segment[1]
		end
	})

	if var_22_1 <= 0 then
		var_22_1 = var_22_2 + var_0_3
	end

	self.duration = var_22_1 / 1000

	for iter_22_3, iter_22_4 in ipairs(var_22_3) do
		local var_22_5 = self:NewSlot(iter_22_4)

		table.insert(self.timelineActionSlots, var_22_5)
		var_22_5:SetTime(iter_22_4.segment[1] / var_22_1, iter_22_4.segment[2] / var_22_1)

		var_22_5.readOnly = self.readOnly

		var_22_5:SetDragDummyRoot(self.transform_)
	end

	self:OnTimelineResize(1)

	self.timelineScroll_.horizontalNormalizedPosition = 0
end

function DanceEditView:LoadDIYData(arg_24_1)
	for iter_24_0, iter_24_1 in pairs(arg_24_1.actionList) do
		if self.timelineActionSlots[iter_24_0] then
			self.timelineActionSlots[iter_24_0]:SetData(iter_24_1)
		end
	end
end

function DanceEditView:TryMoveSlotInTimelineViewport(arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1.left or arg_25_1.ntStart
	local var_25_1 = arg_25_1.right or arg_25_1.ntEnd
	local var_25_2 = self.timelineScroll_.horizontalScrollbar.size

	if arg_25_2 or var_25_0 < self.timelineScroll_.horizontalNormalizedPosition * (1 - self.timelineScroll_.horizontalScrollbar.size) then
		self.timelineScroll_.horizontalNormalizedPosition = var_25_0 / (1 - self.timelineScroll_.horizontalScrollbar.size)
	elseif var_25_1 > self.timelineScroll_.horizontalNormalizedPosition * (1 - self.timelineScroll_.horizontalScrollbar.size) + var_25_2 then
		self.timelineScroll_.horizontalNormalizedPosition = (var_25_1 - var_25_2) / (1 - self.timelineScroll_.horizontalScrollbar.size)
	end
end

function DanceEditView:OnDanceActionSlotMarkerClicked(arg_26_1)
	self:NotifySelectSlotChange(arg_26_1.slot)
	self:TryMoveSlotInTimelineViewport(arg_26_1.slot)
end

function DanceEditView:OnDanceItemPointerDown(arg_27_1)
	return
end

function DanceEditView:OnDanceItemPointerClick(arg_28_1)
	if DIYBridge:GetCurPreviewPriority() <= 1 then
		if arg_28_1.actionID == self.previewAction and self.previewActionProgress then
			DIYBridge:StopAllPreviewTasks()
		else
			DIYBridge:PreviewSingleAction(self:GetSequenceActionInfoFromActionItem(arg_28_1))
		end
	end

	self.curSelectAction = arg_28_1.actionID

	self.actionList:Refresh()
end

function DanceEditView:OnDanceActionSlotPointerClick(arg_29_1)
	if self.playStateController:GetSelectedState() == "pause" then
		self:StopPreviewSequenceAction()
		self:StartPreviewEntireTimelineSequence(arg_29_1.ntStart)
		self:NotifySelectSlotChange(arg_29_1)
	elseif self.selectedSlot ~= arg_29_1 then
		self:NotifySelectSlotChange(arg_29_1)
	else
		self:NotifySelectSlotChange(nil)
	end
end

function DanceEditView:NotifySelectSlotChange(arg_30_1)
	if self.selectedSlot then
		self.selectedSlot:SetSelected(false)
	end

	self.selectedSlot = arg_30_1

	if self.selectedSlot then
		self.selectedSlot:SetSelected(true)
	end
end

function DanceEditView:NotifyDisposeDraggingDummy()
	for iter_31_0, iter_31_1 in pairs(self.actionList:GetItemList()) do
		iter_31_1:DisposeDragDummy()
	end

	for iter_31_2, iter_31_3 in ipairs(self.timelineActionSlots) do
		iter_31_3:DisposeDragDummy()
	end
end

local function var_0_5(arg_32_0, arg_32_1)
	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_32_1, arg_32_0.position, DanceEditView.GetUICam())
end

function DanceEditView:FindAcceptDragItem(arg_33_1, arg_33_2)
	if self.playStateController:GetSelectedState() == "pause" then
		return nil
	end

	for iter_33_0, iter_33_1 in ipairs(self.timelineActionSlots) do
		if var_0_5(arg_33_2, iter_33_1:GetDropAreaRect()) and iter_33_1:WillAcceptDrop(arg_33_1) then
			return iter_33_1
		end
	end
end

function DanceEditView:OnBeginDragDanceActionItem(arg_34_1, arg_34_2)
	if self.playStateController:GetSelectedState() == "pause" then
		return nil
	end

	for iter_34_0, iter_34_1 in ipairs(self.timelineActionSlots) do
		iter_34_1:SetDisplayAcccept(iter_34_1:WillAcceptDrop(arg_34_1))
	end

	self.curSelectAction = arg_34_1.actionID

	self.actionList:Refresh()
	self:HidePromptByDrag()
end

function DanceEditView:OnEndDragDanceActionItem(arg_35_1, arg_35_2)
	for iter_35_0, iter_35_1 in ipairs(self.timelineActionSlots) do
		iter_35_1:SetDisplayAcccept(false)
	end

	arg_35_1.moveController:SetSelectedState("off")
	self:ShowPromptBtDrag()
end

function DanceEditView:OnDragDanceActionItem(arg_36_1, arg_36_2)
	local var_36_1, var_36_2 = UnityEngine.RectTransformUtility.ScreenPointToWorldPointInRectangle(self.transform_, (arg_36_1.dragDummy.offset or Vector2.zero) + arg_36_2.position, DanceEditView.GetUICam(), nil)
	local var_36_3 = self:FindAcceptDragItem(arg_36_1, arg_36_2)

	if var_36_3 then
		arg_36_1.dragDummy.obj.transform:SetParent(self.timelineScroll_.viewport, false)

		arg_36_1.dragDummy.obj.transform.pivot = var_36_3.transform_.pivot
		arg_36_1.dragDummy.obj.transform.sizeDelta = var_36_3.transform_.sizeDelta
		arg_36_1.dragDummy.obj.transform.position = var_36_3.transform_.position
	else
		arg_36_1.dragDummy.obj.transform:SetParent(arg_36_1.dragDummy.parent)

		arg_36_1.dragDummy.obj.transform.pivot = arg_36_1.dragDummy.pivot
		arg_36_1.dragDummy.obj.transform.sizeDelta = arg_36_1.dragDummy.size
		arg_36_1.dragDummy.obj.transform.position = var_36_2
	end
end

function DanceEditView:OnDropDanceActionItem(arg_37_1, arg_37_2)
	local var_37_0 = self:FindAcceptDragItem(arg_37_1, arg_37_2)

	if var_37_0 and var_37_0:WillAcceptDrop(arg_37_1) then
		arg_37_1:OnDropAccepted(var_37_0)

		self.dirty = true
		self.alreadyShared = nil
	end

	self:OnEndDragDanceActionItem(arg_37_1, arg_37_2)
end

local var_0_6 = 10
local var_0_7 = 0.25
local var_0_8 = 50
local var_0_9 = 460

function DanceEditView:OnTimelineResize(arg_38_1)
	arg_38_1 = math.max(var_0_7, math.min(var_0_6, arg_38_1))
	self.timelineArea_.sizeDelta = Vector2(self.unitedSizeSlot and #self.timelineActionSlots * var_0_9 * arg_38_1 or self.duration * (var_0_8 * arg_38_1), self.timelineArea_.sizeDelta.y)

	self:UpdateAllTimelineElements()
end

function DanceEditView:AddUIListeners()
	self:AddBtnListenerScale(self.previewSeqBtn_, nil, function()
		if self.playStateController:GetSelectedState() == "pause" then
			self:StopPreviewSequenceAction()
			self:SwitchPlayState("normal")
		else
			self.previewAction = nil
			self.previewActionProgress = nil

			self.actionList:Refresh()
			self:StartPreviewEntireTimelineSequence(nullable(self.selectedSlot, "ntStart") or 0)
		end
	end)
	self:AddBtnListenerScale(self.editBtn_, nil, function()
		self:TrySetReadOnly(false)
	end)
	self:AddBtnListenerScale(self.shareBtn_, nil, function()
		self:Share()
	end)
	self:AddBtnListenerScale(self.saveBtn_, nil, function()
		self:Save()
	end)
	self:AddBtnListenerScale(self.cancelBtn_, nil, function()
		self:CancelEdit()
	end)
	self:AddBtnListenerScale(self.delBtn_, nil, function()
		self:DelCurEditingData()
	end)
	self:AddBtnListenerScale(self.stopShareBtn_, nil, function()
		self:DelSharingData()
	end)
	self:AddBtnListenerScale(self.statisticsSubView.likeBtn_, nil, function()
		self:Like()
	end)
	self:AddBtnListenerScale(self.statisticsSubView.collectBtn_, nil, function()
		self:Fork()
	end)
	self:AddBtnListenerScale(self.selMusic_, nil, function()
		if not self.readOnly and self.curEditing then
			self:StopPreviewSequenceAction()
			JumpTools.OpenPageByJump("idolDanceSelMusic", {
				music = self.music,
				onSelectMusic = function(arg_50_0, arg_50_1)
					return self:ConfirmChangeMusic(arg_50_1, arg_50_0)
				end
			})
		end
	end)
	self:AddBtnListenerScale(self.filterbtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List
		})
	end)
	self:AddBtnListenerScale(self.switchDisplayBtn_, nil, function()
		self.hideUIController:SetSelectedIndex(self.hideUIController:GetSelectedIndex() == 0 and 1 or 0)
	end)
	self:AddBtnListenerScale(self.switchSlotDisplayModeBtn_, nil, function()
		self:SwitchSlotDisplayMode()
	end)
end

function DanceEditView:ConfirmChangeMusic(arg_54_1, arg_54_2)
	if self.music ~= arg_54_1 then
		ShowMessageBox({
			content = GetTips("IDOL_DANCE_CONFIRM_CHANGE_MUSIC_AND_RESET_EDIT"),
			OkCallback = function()
				JumpTools.Back(1)
				self:SetParams({
					forceReset = true,
					music = arg_54_1,
					load = {
						source = IdolTraineeConst.DataSource.MyData,
						name = self.dataName_.text,
						id = self.curEditing
					}
				})
				self:StopPreviewSequenceAction()
				self:OnEnter()
			end,
			CancelCallback = function()
				arg_54_2:SetSelectMusic(self.music)
			end
		})

		return true
	end
end

function DanceEditView:UpdateAllTimelineElements()
	for iter_57_0, iter_57_1 in ipairs(self.timelineActionSlots) do
		local var_57_0
		local var_57_1

		if self.unitedSizeSlot then
			var_57_1 = iter_57_0 / #self.timelineActionSlots
			var_57_0 = (iter_57_0 - 1) / #self.timelineActionSlots
		end

		iter_57_1:UpdatePosByTimeInfo(var_57_0, var_57_1)
	end
end

function DanceEditView:GetSequenceActionInfoFromActionItem(arg_58_1)
	local function var_58_0()
		if self:GetActionListVisible() then
			self.actionList:Refresh()
		end
	end

	return {
		actionID = arg_58_1.actionID,
		action = arg_58_1:GetAction(),
		onStart = function(self)
			self.previewAction = self.actionID
			self.previewActionProgress = 0

			var_58_0()
		end,
		onUpdate = function(self, arg_61_1)
			if self.actionID == self.previewAction then
				self.previewActionProgress = arg_61_1

				var_58_0()
			end
		end,
		onAbort = function(self)
			if self.actionID == self.previewAction then
				self.previewActionProgress = nil

				var_58_0()
			end
		end,
		onComplete = function(self)
			if self.actionID == self.previewAction then
				self.previewAction = nil
				self.previewActionProgress = nil

				var_58_0()
			end
		end
	}
end

function DanceEditView:GetSequenceActionInfoFromSlotItem(arg_64_1, arg_64_2)
	arg_64_2 = arg_64_2 or 0

	return {
		startTime = (arg_64_1.ntStart - arg_64_2) * self.duration,
		endTime = (arg_64_1.ntEnd - arg_64_2) * self.duration,
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

function DanceEditView:StartPreviewEntireTimelineSequence(arg_69_1)
	arg_69_1 = arg_69_1 or 0

	local var_69_0 = {}

	for iter_69_0, iter_69_1 in ipairs(self.timelineActionSlots) do
		if arg_69_1 <= iter_69_1.ntStart then
			table.insert(var_69_0, self:GetSequenceActionInfoFromSlotItem(iter_69_1, arg_69_1))
		end
	end

	self.timelineCursor_.transform:SetAsLastSibling()
	self:ResetTimelineCursor()
	LeanTween.value(self.timelineCursor_, arg_69_1, 1, (1 - arg_69_1) * self.duration):setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
		self.previewCountdown_.text = manager.time:DescCDTime4((1 - arg_70_0) * self.duration)

		if self.unitedSizeSlot then
			arg_70_0 = self:CalcUnitedPreviewProgress(arg_70_0)
		end

		self.previewProgress_.fillAmount = arg_70_0
		self.timelineCursor_.transform.anchoredPosition = Vector2(arg_70_0 * self.timelineArea_.rect.width, 0)
	end)):setOnComplete(System.Action(function()
		self.curPreviewingSlot = nil
		self.previewCountdown_.text = manager.time:DescCDTime4(0)

		self:SwitchPlayState("normal")
		self:SetActionListVisible(true)
		self.hideUIController:SetSelectedState("false")
	end))
	DIYBridge:PreviewSequenceAction(var_69_0, arg_69_1 * self.duration)
	self:SwitchPlayState("pause")
	self:SetActionListVisible(false)
end

function DanceEditView:UpdateTimelineCursorBySlotProgress(arg_72_1, arg_72_2)
	self.curPreviewingSlot = arg_72_1
end

function DanceEditView:CalcUnitedPreviewProgress(arg_73_1)
	local var_73_0 = 0

	for iter_73_0, iter_73_1 in ipairs(self.timelineActionSlots) do
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

function DanceEditView:ResetTimelineCursor()
	self.curPreviewingSlot = nil
	self.previewProgress_.fillAmount = 0
	self.timelineCursor_.transform.anchoredPosition = Vector3.zero

	LeanTween.cancel(self.timelineCursor_, true)
end

function DanceEditView:StopPreviewSequenceAction()
	DIYBridge:StopAllPreviewTasks()
	self:ResetTimelineCursor()
end

function DanceEditView:Save()
	local var_76_0 = IdolTraineeData:GetDanceDIYSequence(self.curEditing) or IdolTraineeData:NewDanceDIYSequence()
	local var_76_1 = {}

	for iter_76_0, iter_76_1 in ipairs(self.timelineActionSlots) do
		var_76_1[iter_76_0] = iter_76_1.actionID or 0
	end

	var_76_0.music = self.music
	var_76_0.scene = DIYBridge.scene
	var_76_0.actionList = var_76_1

	IdolTraineeAction.SaveDanceDIYSequence(self.curEditing, var_76_0, function()
		self:TrySetReadOnly(true)

		self.dirty = false
	end)
end

function DanceEditView:Like()
	if self.sharedByOtherData then
		if self.statisticsSubView.controllers.alreadyLike:GetSelectedState() == "true" then
			ShowTips("IDOL_DANCE_DIY_ALREADY_LIKED")
		else
			IdolTraineeAction.Like(self.sharedByOtherData, function()
				self.statisticsSubView.controllers.alreadyLike:SetSelectedState("true")

				IdolTraineeTools.GetDIYDataFromLoadInfo(self.params_.load).liked = self.statisticsSubView.like + 1
				self.statisticsSubView.like = self.statisticsSubView.like + 1
				self.statisticsSubView.likedCnt_.text = self.statisticsSubView.like

				IdolTraineeTools.FetchSharedDIY(true, IdolTraineeConst.shareCategory.History)
			end)
		end
	end
end

function DanceEditView:Fork()
	if self.sharedByOtherData then
		local var_80_0 = IdolTraineeData:GetDanceDIYAvailableSlotIdx()

		if var_80_0 then
			local var_80_1 = IdolTraineeData:NewDanceDIYSequence()
			local var_80_2 = {}

			for iter_80_0, iter_80_1 in ipairs(self.timelineActionSlots) do
				var_80_2[iter_80_0] = iter_80_1.actionID or 0
			end

			var_80_1.music = self.music
			var_80_1.scene = DIYBridge.scene
			var_80_1.actionList = var_80_2

			IdolTraineeAction.ForkDIYSequence(self.sharedByOtherData, var_80_1, var_80_0, function(arg_81_0, arg_81_1)
				self.statisticsSubView.collectedCnt_.text = arg_81_1
				IdolTraineeTools.GetDIYDataFromLoadInfo(self.params_.load).collcted = arg_81_1

				ShowTips(GetTipsF("IDOL_DANCE_EDIT_COLLECT_SHARED_SUCCESS", var_80_0))
			end)
		else
			ShowTips("IDOL_DANCE_EDIT_NO_DIY_DATA_SLOT")
		end
	end
end

function DanceEditView:CancelEdit()
	if self.dirty then
		ShowMessageBox({
			content = GetTips("IDOL_DANCE_DIY_CONFIRM_ABORT_EDIT"),
			OkCallback = JumpTools.Back
		})
	else
		JumpTools.Back()
	end
end

function DanceEditView:Share()
	if self.alreadyShared then
		ShowTips("IDOL_DANCE_DIY_ALREADY_SHARED")

		return
	end

	local var_83_0 = IdolTraineeData:NewDanceDIYSequence()

	for iter_83_0, iter_83_1 in ipairs(self.timelineActionSlots) do
		var_83_0.actionList[iter_83_0] = iter_83_1.actionID or 0
	end

	var_83_0.music = self.music
	var_83_0.scene = DIYBridge.scene

	IdolTraineeAction.ShareDanceDIYSequence(var_83_0, function()
		ShowTips("IDOL_DANCE_DIY_SHARE_SUCCESS")

		self.alreadyShared = true
	end)
end

function DanceEditView:DelCurEditingData()
	if self.curEditing then
		ShowMessageBox({
			content = GetTips("IDOL_DANCE_CONFIRM_DEL"),
			OkCallback = function()
				for iter_86_0, iter_86_1 in ipairs(self.timelineActionSlots) do
					iter_86_1:Clear()
				end

				self.timelineScroll_.horizontalNormalizedPosition = 0
			end
		})
	end
end

function DanceEditView:DelSharingData()
	if self.sharedByOtherData then
		ShowMessageBox({
			content = GetTips("IDOL_DANCE_CONFIRM_STOP_SHARE"),
			OkCallback = function()
				IdolTraineeAction.StopShareDanceDIYSeqence(self.sharedByOtherData)
				JumpTools.Back()
			end
		})
	end
end

function DanceEditView:TrySetReadOnly(arg_89_1)
	local var_89_0 = self.editStateController:GetSelectedState()

	if not arg_89_1 then
		if var_89_0 == "readOnly" then
			self.editStateController:SetSelectedState("edit")
		else
			arg_89_1 = true
		end
	elseif var_89_0 == "edit" then
		self.editStateController:SetSelectedState("readOnly")
	end

	self.readOnly = arg_89_1

	self:SetSelMusicBtnInteractable(not arg_89_1)

	for iter_89_0, iter_89_1 in ipairs(self.timelineActionSlots) do
		iter_89_1.readOnly = arg_89_1
	end

	self:UpdateDragPromptVisible()
end

function DanceEditView:SetSelMusicBtnInteractable(arg_90_1)
	self.selMusic_.interactable = arg_90_1

	self.enableSelMusicController:SetSelectedState(arg_90_1 and "true" or "false")
end

function DanceEditView:SwitchPlayState(arg_91_1)
	self.playStateController:SetSelectedState(arg_91_1)
	self:UpdateDragPromptVisible()
end

function DanceEditView:SwitchSlotDisplayMode()
	self.unitedSizeSlot = not self.unitedSizeSlot

	self:UpdateAllTimelineElements()

	if self.curPreviewingSlot then
		self:TryMoveSlotInTimelineViewport(self.curPreviewingSlot, true)
	end
end

function DanceEditView:HidePromptByDrag()
	self.dragCnt = (self.dragCnt or 0) + 1

	self:UpdateDragPromptVisible()
end

function DanceEditView:ShowPromptBtDrag(arg_94_1)
	if arg_94_1 then
		self.dragCnt = nil
	else
		self.dragCnt = math.max(0, (self.dragCnt or 0) - 1)
	end

	self:UpdateDragPromptVisible()
end

function DanceEditView:UpdateDragPromptVisible()
	self.showPromptController:SetSelectedState(not self.readOnly and self.playStateController:GetSelectedState() == "normal" and (self.dragCnt or 0) == 0 and "true" or "false")
end

return DanceEditView
