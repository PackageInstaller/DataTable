local var_0_0 = class("ChapterV2MapBaseMapView", BaseView)

var_0_0.SCALE_VALUE = 1.2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.handler_ = arg_1_1

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.isDragging_ = false
	arg_1_0.lastDragPosition_ = nil
	arg_1_0.mapOriginalPosition_ = nil
	arg_1_0.mapBounds_ = nil
	arg_1_0.screenBounds_ = nil
	arg_1_0.mapLocationItems_ = {}
	arg_1_0.chapterMapScrollView_ = ChapterMapScrollView.New(arg_1_0, arg_1_2)

	SetActive(arg_1_0.maskBtn_.gameObject, true)

	arg_1_0.segmentGoList_ = {}
	arg_1_0.segmentRootGoList_ = {}
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.maskBtn_, nil, function()
		arg_2_0:OnClickMapLocation(nil, true)

		if gameContext:GetLastOpenPage() == "chapterV2MapTimeline" then
			JumpTools.Back()
		end
	end)
end

function var_0_0.OnBeginDrag(arg_4_0, arg_4_1)
	arg_4_0.isDragging_ = true
	arg_4_0.lastDragPosition_ = arg_4_1.position

	if arg_4_0.mapOriginalPosition_ == nil then
		arg_4_0.mapOriginalPosition_ = arg_4_0.transform_.localPosition
	end

	arg_4_0:UpdateMapBounds()
end

function var_0_0.OnDrag(arg_5_0, arg_5_1)
	return
end

function var_0_0.OnEndDrag(arg_6_0, arg_6_1)
	arg_6_0.isDragging_ = false
	arg_6_0.lastDragPosition_ = nil
end

function var_0_0.SetInitialMapCenter(arg_7_0, arg_7_1)
	local var_7_0 = ChapterV2MapTools.GetCurrentMapMainLocation(ChapterV2MapData:GetCurrentMapId())

	if arg_7_1 then
		var_7_0 = ChapterV2MapTools.GetCurrentMainLocation(arg_7_1)
	end

	if not var_7_0 or var_7_0 == 0 then
		arg_7_0.transform_.localPosition = Vector3(0, 0, 0)

		return
	end

	local var_7_1 = ChapterV2MapLocationCfg[var_7_0]

	if not var_7_1 or not var_7_1.position or #var_7_1.position < 2 then
		arg_7_0.transform_.localPosition = Vector3(0, 0, 0)

		return
	end

	local var_7_2 = var_7_1.position[1]
	local var_7_3 = var_7_1.position[2]
	local var_7_4 = Vector3(var_7_2, var_7_3, 0)

	arg_7_0.mapOriginalPosition_ = arg_7_0:ClampPositionToBounds(var_7_4)

	arg_7_0.chapterMapScrollView_:ScrollToPosition(Vector3(arg_7_0.mapOriginalPosition_.x, arg_7_0.mapOriginalPosition_.y, 0))
end

function var_0_0.UpdateMapBounds(arg_8_0)
	if not arg_8_0.mapBounds_ then
		arg_8_0.mapBounds_ = arg_8_0.baseMapTrs_.rect
	end

	if not arg_8_0.screenBounds_ then
		arg_8_0.screenBounds_ = arg_8_0.transform_.rect
	end
end

function var_0_0.ClampPositionToBounds(arg_9_0, arg_9_1)
	if not arg_9_0.mapBounds_ or not arg_9_0.screenBounds_ then
		return arg_9_1
	end

	local var_9_0 = arg_9_0.mapBounds_.width
	local var_9_1 = arg_9_0.mapBounds_.height
	local var_9_2 = arg_9_0.screenBounds_.width
	local var_9_3 = arg_9_0.screenBounds_.height
	local var_9_4 = math.max(0, (var_9_0 - var_9_2) / 2)
	local var_9_5 = math.max(0, (var_9_1 - var_9_3) / 2)
	local var_9_6 = math.max(-var_9_4, math.min(var_9_4, arg_9_1.x))
	local var_9_7 = math.max(-var_9_5, math.min(var_9_5, arg_9_1.y))

	return Vector3(var_9_6, var_9_7, arg_9_1.z)
end

function var_0_0.ScaleMap(arg_10_0)
	if arg_10_0.clickedLocationId_ then
		arg_10_0:CancelTween()
		LeanTween.scale(arg_10_0.scrollViewTf_, Vector3(var_0_0.SCALE_VALUE, var_0_0.SCALE_VALUE, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
	else
		arg_10_0:CancelTween()
		LeanTween.scale(arg_10_0.scrollViewTf_, Vector3(1, 1, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
	end
end

function var_0_0.CancelTween(arg_11_0)
	if arg_11_0.leanTween_ then
		LeanTween.cancel(arg_11_0.scrollViewTf_)

		arg_11_0.leanTween_ = nil
	end
end

function var_0_0.IndexItemEvent(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.eventList_[arg_12_1]

	arg_12_2:SetData(var_12_0, var_12_0 == arg_12_0.clickedEventId_)
end

function var_0_0.IndexItemLocation(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.locationList_[arg_13_1]

	arg_13_2:SetData(var_13_0, var_13_0 == arg_13_0.clickedLocationId_)
end

function var_0_0.OnClickMapEvent(arg_14_0, arg_14_1)
	if arg_14_0.isPlayMoveAni_ then
		return
	end

	if gameContext:GetLastOpenPage() == "chapterV2MapTimeline" then
		JumpTools.Back()
	end

	arg_14_0.clickedLocationId_ = nil
	arg_14_0.clickedEventId_ = arg_14_1

	arg_14_0:RefreshUI()

	local var_14_0 = ChapterV2MapEventCfg[arg_14_1].location
	local var_14_1 = ChapterV2MapTools.GetCurrentMainLocation(var_14_0)
	local var_14_2 = ChapterV2MapTools.GetCurrentMapMainLocation(ChapterV2MapData:GetCurrentMapId()) or ChapterV2MapTools.GetCurrentMainLocation(ChapterV2MapCfg[ChapterV2MapData:GetCurrentMapId()].default_location)

	local function var_14_3()
		ChapterV2MapAction.MoveLocation(var_14_0)
		ChapterV2MapTools.OpenEvent(arg_14_1)
	end

	if ChapterV2MapData:TimelineGetTime() then
		if ChapterV2MapData:IsEventCompleted(arg_14_1) or var_14_1 == var_14_2 then
			var_14_3()
		else
			arg_14_0:PlayMoveLocationAni(var_14_2, var_14_0, var_14_3)
		end
	elseif var_14_1 ~= var_14_2 then
		arg_14_0:PlayMoveLocationAni(var_14_2, var_14_0, var_14_3)
	else
		var_14_3()
	end
end

function var_0_0.PlayMoveLocationAni(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.isPlayMoveAni_ = true

	local var_16_0 = ChapterV2MapTools.GetCurrentMainLocation(arg_16_1)
	local var_16_1 = ChapterV2MapTools.GetCurrentMainLocation(arg_16_2)
	local var_16_2 = ChapterV2MapLocationCfg[var_16_0]
	local var_16_3 = ChapterV2MapLocationCfg[var_16_1]

	if not var_16_2 or not var_16_3 then
		arg_16_3()

		return
	end

	local var_16_4 = arg_16_0.mapLocationItems_[var_16_0]
	local var_16_5 = arg_16_0.mapLocationItems_[var_16_1]

	if not var_16_4 or not var_16_5 then
		arg_16_3()

		return
	end

	arg_16_0.headAni_:Play("UI_playerHead_out", -1, 0)

	local var_16_6 = 0

	arg_16_0.moveLocationTimer_ = Timer.New(function()
		var_16_6 = var_16_6 + 1

		if var_16_6 == 1 then
			SetActive(arg_16_0.playerHead_.gameObject, false)
		elseif var_16_6 == 2 then
			arg_16_0.playerHead_.position = arg_16_0.mapLocationItems_[var_16_1].headAni_.transform.position

			SetActive(arg_16_0.playerHead_.gameObject, true)
		elseif var_16_6 == 4 and arg_16_3 then
			arg_16_3()
			arg_16_0.moveLocationTimer_:Stop()

			arg_16_0.moveLocationTimer_ = nil
		end

		arg_16_0.isPlayMoveAni_ = false
	end, 0.2, -1)

	arg_16_0.moveLocationTimer_:Start()
end

function var_0_0.OnClickMapLocation(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 then
		if #arg_18_0.mapLocationItems_[arg_18_1].taglist_ == 0 then
			ShowTips("CHAPTER_V2_LOCATION_EMPTY_EVENT")

			return
		end

		SetActive(arg_18_0.maskBtn_.gameObject, true)
	end

	arg_18_0.clickedLocationId_ = arg_18_1

	if not arg_18_2 then
		arg_18_0:SetInitialMapCenter(arg_18_1)
	end

	arg_18_0:RefreshUI()
	arg_18_0:ScaleMap()
end

function var_0_0.OnClickTrackEvent(arg_19_0, arg_19_1)
	local var_19_0 = ChapterV2MapEventCfg[arg_19_1]
	local var_19_1

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.locationList_) do
		if arg_19_0.mapLocationItems_[iter_19_1] then
			var_19_1 = ChapterV2MapTools.GetCurrentMainLocation(var_19_0.location)

			arg_19_0.mapLocationItems_[iter_19_1]:SetClickTag(var_19_1 == iter_19_1)
		end
	end

	arg_19_0:OnClickMapLocation(var_19_1)
end

function var_0_0.OnEnter(arg_20_0)
	ReduxView.OnEnter(arg_20_0)

	arg_20_0.handlerEvent_ = handler(arg_20_0, arg_20_0.OnClickMapEvent)
	arg_20_0.handlerLoc_ = handler(arg_20_0, arg_20_0.OnClickMapLocation)

	manager.notify:RegistListener(CHAPTER_MAP_LOCATION_EVENT_CLICK, arg_20_0.handlerEvent_)
	manager.notify:RegistListener(CHAPTER_MAP_LOCATION_CLICK, arg_20_0.handlerLoc_)

	arg_20_0.clickedEventId_ = nil
	arg_20_0.clickedLocationId_ = nil

	arg_20_0:SetCurrentMap()
	arg_20_0:UpdateMapBounds()
	arg_20_0:SetInitialMapCenter()
	arg_20_0:AddGuideTimer()
	arg_20_0:AddListeners()
	arg_20_0:RefreshUI()
end

function var_0_0.AddGuideTimer(arg_21_0)
	arg_21_0:CheckMapGuide()

	arg_21_0.guideTimer_ = Timer.New(function()
		arg_21_0:CheckMapGuide()
	end, 1, -1)

	arg_21_0.guideTimer_:Start()
end

function var_0_0.CheckMapGuide(arg_23_0)
	local var_23_0 = manager.guide:GetCurrentGuideStepID()

	if var_23_0 ~= 0 then
		local var_23_1 = GuideStepCfg[var_23_0]

		if var_23_1 then
			local var_23_2 = GuideTool.GetCommonStepGuideComponent(arg_23_0, var_23_1) or GuideTool.GetCommonStepGuideComponent(arg_23_0.handler_, var_23_1)

			if var_23_2 then
				local var_23_3 = var_23_2.transform or var_23_2.transform_

				if var_23_3 then
					local var_23_4 = Vector3(var_23_3.localPosition.x, var_23_3.localPosition.y, 0)
					local var_23_5 = arg_23_0:ClampPositionToBounds(var_23_4)

					arg_23_0.chapterMapScrollView_:ScrollToPosition(var_23_5)
				end
			end
		end
	end
end

function var_0_0.OnTop(arg_24_0)
	arg_24_0:RefreshUI()
	arg_24_0:ScaleMap()
end

function var_0_0.SetCurrentMap(arg_25_0)
	local var_25_0 = ChapterV2MapData:GetCurrentMapId()

	if var_25_0 == 40801 then
		var_25_0 = 40803
	end

	local var_25_1 = var_25_0 .. "_Map"

	if not arg_25_0.mapGo_ or arg_25_0.mapGo_.name ~= var_25_1 then
		if arg_25_0.mapGo_ then
			GameObject.DestroyImmediate(arg_25_0.mapGo_)
		end

		arg_25_0.mapGo_ = Object.Instantiate(Asset.Load("Widget/System/Xuheng_PlotMap/XuhengPlotMapMainUI/" .. var_25_1), arg_25_0.mapContent_)
	end

	local var_25_2 = ChapterV2MapData:GetCurrentMapId() .. "_MisUnlockingMap"

	if not arg_25_0.misUnlockingMapGo_ or arg_25_0.misUnlockingMapGo_ and arg_25_0.misUnlockingMapGo_.name ~= var_25_2 then
		if arg_25_0.misUnlockingMapGo_ then
			GameObject.DestroyImmediate(arg_25_0.misUnlockingMapGo_)
		end

		arg_25_0.misUnlockingMapGo_ = Object.Instantiate(Asset.Load("Widget/System/Xuheng_PlotMap/XuhengPlotMapMainUI/" .. var_25_2), arg_25_0.misUnlockMapContent_)
	end

	local var_25_3 = ChapterV2MapData:GetCurrentMapId() .. "_AboveMisUnlockingMap"

	if not arg_25_0.aboveMisUnlockingMapGo_ or arg_25_0.aboveMisUnlockingMapGo_ and arg_25_0.aboveMisUnlockingMapGo_.name ~= var_25_3 then
		if arg_25_0.aboveMisUnlockingMapGo_ then
			GameObject.DestroyImmediate(arg_25_0.aboveMisUnlockingMapGo_)
		end

		arg_25_0.aboveMisUnlockingMapGo_ = Object.Instantiate(Asset.Load("Widget/System/Xuheng_PlotMap/XuhengPlotMapMainUI/" .. var_25_3), arg_25_0.aboveMisUnlockMapContent_)
	end

	arg_25_0:RefreshMisUnlockingMap()
end

function var_0_0.OnExit(arg_26_0)
	manager.notify:RemoveListener(CHAPTER_MAP_LOCATION_EVENT_CLICK, arg_26_0.handlerEvent_)
	manager.notify:RemoveListener(CHAPTER_MAP_LOCATION_CLICK, arg_26_0.handlerLoc_)

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.locationList_) do
		if arg_26_0.mapLocationItems_[iter_26_1] then
			SetActive(arg_26_0.mapLocationItems_[iter_26_1].gameObject_, false)
		end
	end

	if arg_26_0.guideTimer_ then
		arg_26_0.guideTimer_:Stop()

		arg_26_0.guideTimer_ = nil
	end

	arg_26_0:ClearMoveLocationTimer()
end

function var_0_0.RefreshUI(arg_27_0)
	local var_27_0 = ChapterV2MapData:GetCurrentMapId()

	arg_27_0.mapId_ = var_27_0
	arg_27_0.locationList_ = ChapterV2MapTools.GetMapLocations(var_27_0)

	arg_27_0:UpdateMapLocationItemsDisplay()
end

function var_0_0.UpdateMapLocationItemsDisplay(arg_28_0)
	local var_28_0 = false

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.locationList_) do
		if not arg_28_0.mapLocationItems_[iter_28_1] then
			local var_28_1 = ChapterV2MapLocationCfg[iter_28_1]
			local var_28_2
			local var_28_3

			if var_28_1.type == ChapterV2MapConst.MAPLOCATIONTYPE.TELEPORT then
				if var_28_1.layer == 0 then
					var_28_2 = Object.Instantiate(arg_28_0.goItem_, arg_28_0.locationRoot_)
				else
					var_28_2 = Object.Instantiate(arg_28_0.goItem_, arg_28_0.aboveLocationRoot_)
				end

				var_28_3 = ChapterV2MapGoLocationItem.New(var_28_2)
			else
				if var_28_1.layer == 0 then
					var_28_2 = Object.Instantiate(arg_28_0.locationItem_, arg_28_0.locationRoot_)
				else
					var_28_2 = Object.Instantiate(arg_28_0.locationItem_, arg_28_0.aboveLocationRoot_)
				end

				var_28_3 = ChapterV2MapLocationItem.New(var_28_2)
			end

			arg_28_0.mapLocationItems_[iter_28_1] = var_28_3
		end

		SetActive(arg_28_0.mapLocationItems_[iter_28_1].gameObject_, true)
		arg_28_0.mapLocationItems_[iter_28_1]:SetData(iter_28_1, arg_28_0.clickedLocationId_ == iter_28_1)

		if ChapterV2MapTools.GetCurrentMapMainLocation(ChapterV2MapData:GetCurrentMapId()) == iter_28_1 then
			arg_28_0.playerHead_.position = arg_28_0.mapLocationItems_[iter_28_1].headAni_.transform.position
			arg_28_0.roleIcon_.sprite = ItemTools.getItemSprite(ChapterV2MapData:GetMapCurrentRole(ChapterV2MapData:GetCurrentMapId()))

			SetActive(arg_28_0.playerHead_.gameObject, true)

			var_28_0 = true
		end
	end

	SetActive(arg_28_0.playerHead_.gameObject, var_28_0)
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:ClearAllLocationItem()

	arg_29_0.isDragging_ = false
	arg_29_0.lastDragPosition_ = nil
	arg_29_0.mapOriginalPosition_ = nil
	arg_29_0.mapBounds_ = nil
	arg_29_0.screenBounds_ = nil

	var_0_0.super.Dispose(arg_29_0)
end

function var_0_0.ClearAllLocationItem(arg_30_0)
	if arg_30_0.mapLocationItems_ then
		for iter_30_0, iter_30_1 in pairs(arg_30_0.mapLocationItems_) do
			iter_30_1:Dispose()
		end

		arg_30_0.mapLocationItems_ = {}
	end

	arg_30_0:ClearMoveLocationTimer()
end

function var_0_0.ClearMoveLocationTimer(arg_31_0)
	if arg_31_0.moveLocationTimer_ then
		arg_31_0.moveLocationTimer_:Stop()
	end

	arg_31_0.isPlayMoveAni_ = false
	arg_31_0.segmentRootGoList_ = {}
end

function var_0_0.OnMapChangeMap(arg_32_0, arg_32_1)
	arg_32_0:SetCurrentMap()
	arg_32_0:ClearAllLocationItem()

	arg_32_0.mapId_ = arg_32_1
	arg_32_0.locationList_ = ChapterV2MapTools.GetMapLocations(arg_32_1)

	arg_32_0:UpdateMapBounds()
	arg_32_0:SetInitialMapCenter()
	arg_32_0:RefreshUI()
end

function var_0_0.RefreshMisUnlockingMap(arg_33_0, arg_33_1)
	local var_33_0 = ChapterV2MapCfg[ChapterV2MapData:GetCurrentMapId()].mist_unlock_condition

	if arg_33_0.misUnlockingMapGo_ then
		for iter_33_0, iter_33_1 in ipairs(var_33_0) do
			local var_33_1 = IsConditionAchieved(iter_33_1)
			local var_33_2 = arg_33_0.misUnlockingMapGo_.transform:Find(tostring(iter_33_0))

			if var_33_2 then
				if arg_33_1 == ConditionCfg[iter_33_1].params[1] then
					transform:GetComponent("Animator"):Play("MistUnlockingUI_out", -1, 0)
				else
					SetActive(var_33_2.gameObject, not var_33_1)
				end
			end
		end
	end

	if arg_33_0.aboveMisUnlockingMapGo_ then
		for iter_33_2, iter_33_3 in ipairs(var_33_0) do
			local var_33_3 = IsConditionAchieved(iter_33_3)
			local var_33_4 = arg_33_0.aboveMisUnlockingMapGo_.transform:Find(tostring(iter_33_2))

			if var_33_4 then
				if arg_33_1 == ConditionCfg[iter_33_3].params[1] then
					transform:GetComponent("Animator"):Play("MistUnlockingUI_out", -1, 0)
				else
					SetActive(var_33_4.gameObject, not var_33_3)
				end
			end
		end
	end
end

function var_0_0.GetBackCnt(arg_34_0)
	return 0
end

return var_0_0
