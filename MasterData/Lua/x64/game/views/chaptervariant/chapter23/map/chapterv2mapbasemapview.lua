local ChapterV2MapBaseMapView = class("ChapterV2MapBaseMapView", BaseView)

ChapterV2MapBaseMapView.SCALE_VALUE = 1.2

function ChapterV2MapBaseMapView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.handler_ = arg_1_1

	self:BindCfgUI()
	self:AddListeners()

	self.isDragging_ = false
	self.lastDragPosition_ = nil
	self.mapOriginalPosition_ = nil
	self.mapBounds_ = nil
	self.screenBounds_ = nil
	self.mapLocationItems_ = {}
	self.chapterMapScrollView_ = ChapterMapScrollView.New(self, arg_1_2)

	SetActive(self.maskBtn_.gameObject, true)

	self.segmentGoList_ = {}
	self.segmentRootGoList_ = {}
end

function ChapterV2MapBaseMapView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:OnClickMapLocation(nil, true)

		if gameContext:GetLastOpenPage() == "chapterV2MapTimeline" then
			JumpTools.Back()
		end
	end)
end

function ChapterV2MapBaseMapView:OnBeginDrag(arg_4_1)
	self.isDragging_ = true
	self.lastDragPosition_ = arg_4_1.position

	if self.mapOriginalPosition_ == nil then
		self.mapOriginalPosition_ = self.transform_.localPosition
	end

	self:UpdateMapBounds()
end

function ChapterV2MapBaseMapView:OnDrag(arg_5_1)
	return
end

function ChapterV2MapBaseMapView:OnEndDrag(arg_6_1)
	self.isDragging_ = false
	self.lastDragPosition_ = nil
end

function ChapterV2MapBaseMapView:SetInitialMapCenter(arg_7_1)
	local var_7_0 = ChapterV2MapTools.GetCurrentMapMainLocation(ChapterV2MapData:GetCurrentMapId())

	if arg_7_1 then
		var_7_0 = ChapterV2MapTools.GetCurrentMainLocation(arg_7_1)
	end

	if not var_7_0 or var_7_0 == 0 then
		self.transform_.localPosition = Vector3(0, 0, 0)

		return
	end

	local var_7_1 = ChapterV2MapLocationCfg[var_7_0]

	if not ChapterV2MapLocationCfg[var_7_0] or not var_7_1.position or #var_7_1.position < 2 then
		self.transform_.localPosition = Vector3(0, 0, 0)

		return
	end

	self.mapOriginalPosition_ = self:ClampPositionToBounds((Vector3(var_7_1.position[1], var_7_1.position[2], 0)))

	self.chapterMapScrollView_:ScrollToPosition(Vector3(self.mapOriginalPosition_.x, self.mapOriginalPosition_.y, 0))
end

function ChapterV2MapBaseMapView:UpdateMapBounds()
	self.mapBounds_ = self.mapBounds_ or self.baseMapTrs_.rect
	self.screenBounds_ = self.screenBounds_ or self.transform_.rect
end

function ChapterV2MapBaseMapView:ClampPositionToBounds(arg_9_1)
	if not self.mapBounds_ or not self.screenBounds_ then
		return arg_9_1
	end

	local var_9_0 = math.max(0, (self.mapBounds_.width - self.screenBounds_.width) / 2)
	local var_9_1 = math.max(0, (self.mapBounds_.height - self.screenBounds_.height) / 2)

	return Vector3(math.max(-var_9_0, math.min(var_9_0, arg_9_1.x)), math.max(-var_9_1, math.min(var_9_1, arg_9_1.y)), arg_9_1.z)
end

function ChapterV2MapBaseMapView:ScaleMap()
	if self.clickedLocationId_ then
		self:CancelTween()
		LeanTween.scale(self.scrollViewTf_, Vector3(ChapterV2MapBaseMapView.SCALE_VALUE, ChapterV2MapBaseMapView.SCALE_VALUE, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
	else
		self:CancelTween()
		LeanTween.scale(self.scrollViewTf_, Vector3(1, 1, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
	end
end

function ChapterV2MapBaseMapView:CancelTween()
	if self.leanTween_ then
		LeanTween.cancel(self.scrollViewTf_)

		self.leanTween_ = nil
	end
end

function ChapterV2MapBaseMapView:IndexItemEvent(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.eventList_[arg_12_1], self.eventList_[arg_12_1] == self.clickedEventId_)
end

function ChapterV2MapBaseMapView:IndexItemLocation(arg_13_1, arg_13_2)
	arg_13_2:SetData(self.locationList_[arg_13_1], self.locationList_[arg_13_1] == self.clickedLocationId_)
end

function ChapterV2MapBaseMapView:OnClickMapEvent(arg_14_1)
	if self.isPlayMoveAni_ then
		return
	end

	if gameContext:GetLastOpenPage() == "chapterV2MapTimeline" then
		JumpTools.Back()
	end

	self.clickedLocationId_ = nil
	self.clickedEventId_ = arg_14_1

	self:RefreshUI()

	local var_14_0 = ChapterV2MapEventCfg[arg_14_1].location
	local var_14_1 = ChapterV2MapTools.GetCurrentMainLocation(ChapterV2MapEventCfg[arg_14_1].location)
	local var_14_2 = ChapterV2MapTools.GetCurrentMapMainLocation(ChapterV2MapData:GetCurrentMapId()) or ChapterV2MapTools.GetCurrentMainLocation(ChapterV2MapCfg[ChapterV2MapData:GetCurrentMapId()].default_location)

	local function var_14_3()
		ChapterV2MapAction.MoveLocation(var_14_0)
		ChapterV2MapTools.OpenEvent(arg_14_1)
	end

	if ChapterV2MapData:TimelineGetTime() then
		if ChapterV2MapData:IsEventCompleted(arg_14_1) or var_14_1 == var_14_2 then
			var_14_3()
		else
			self:PlayMoveLocationAni(var_14_2, ChapterV2MapEventCfg[arg_14_1].location, var_14_3)
		end
	elseif var_14_1 ~= var_14_2 then
		self:PlayMoveLocationAni(var_14_2, ChapterV2MapEventCfg[arg_14_1].location, var_14_3)
	else
		var_14_3()
	end
end

function ChapterV2MapBaseMapView:PlayMoveLocationAni(arg_16_1, arg_16_2, arg_16_3)
	self.isPlayMoveAni_ = true

	local var_16_0 = ChapterV2MapTools.GetCurrentMainLocation(arg_16_1)
	local var_16_1 = ChapterV2MapTools.GetCurrentMainLocation(arg_16_2)

	if not ChapterV2MapLocationCfg[var_16_0] or not ChapterV2MapLocationCfg[var_16_1] then
		arg_16_3()

		return
	end

	if not self.mapLocationItems_[var_16_0] or not self.mapLocationItems_[var_16_1] then
		arg_16_3()

		return
	end

	self.headAni_:Play("UI_playerHead_out", -1, 0)

	local var_16_2 = 0

	self.moveLocationTimer_ = Timer.New(function()
		var_16_2 = var_16_2 + 1

		if var_16_2 == 1 then
			SetActive(self.playerHead_.gameObject, false)
		elseif var_16_2 == 2 then
			self.playerHead_.position = self.mapLocationItems_[var_16_1].headAni_.transform.position

			SetActive(self.playerHead_.gameObject, true)
		elseif var_16_2 == 4 and arg_16_3 then
			arg_16_3()
			self.moveLocationTimer_:Stop()

			self.moveLocationTimer_ = nil
		end

		self.isPlayMoveAni_ = false
	end, 0.2, -1)

	self.moveLocationTimer_:Start()
end

function ChapterV2MapBaseMapView:OnClickMapLocation(arg_18_1, arg_18_2)
	if arg_18_1 then
		if #self.mapLocationItems_[arg_18_1].taglist_ == 0 then
			ShowTips("CHAPTER_V2_LOCATION_EMPTY_EVENT")

			return
		end

		SetActive(self.maskBtn_.gameObject, true)
	end

	self.clickedLocationId_ = arg_18_1

	if not arg_18_2 then
		self:SetInitialMapCenter(arg_18_1)
	end

	self:RefreshUI()
	self:ScaleMap()
end

function ChapterV2MapBaseMapView:OnClickTrackEvent(arg_19_1)
	local var_19_0

	for iter_19_0, iter_19_1 in ipairs(self.locationList_) do
		if self.mapLocationItems_[iter_19_1] then
			var_19_0 = ChapterV2MapTools.GetCurrentMainLocation(ChapterV2MapEventCfg[arg_19_1].location)

			self.mapLocationItems_[iter_19_1]:SetClickTag(var_19_0 == iter_19_1)
		end
	end

	self:OnClickMapLocation(var_19_0)
end

function ChapterV2MapBaseMapView:OnEnter()
	ReduxView.OnEnter(self)

	self.handlerEvent_ = handler(self, self.OnClickMapEvent)
	self.handlerLoc_ = handler(self, self.OnClickMapLocation)

	manager.notify:RegistListener(CHAPTER_MAP_LOCATION_EVENT_CLICK, self.handlerEvent_)
	manager.notify:RegistListener(CHAPTER_MAP_LOCATION_CLICK, self.handlerLoc_)

	self.clickedEventId_ = nil
	self.clickedLocationId_ = nil

	self:SetCurrentMap()
	self:UpdateMapBounds()
	self:SetInitialMapCenter()
	self:AddGuideTimer()
	self:AddListeners()
	self:RefreshUI()
end

function ChapterV2MapBaseMapView:AddGuideTimer()
	self:CheckMapGuide()

	self.guideTimer_ = Timer.New(function()
		self:CheckMapGuide()
	end, 1, -1)

	self.guideTimer_:Start()
end

function ChapterV2MapBaseMapView:CheckMapGuide()
	local var_23_0 = manager.guide:GetCurrentGuideStepID()

	if var_23_0 ~= 0 then
		if GuideStepCfg[var_23_0] then
			local var_23_1 = GuideTool.GetCommonStepGuideComponent(self, GuideStepCfg[var_23_0]) or GuideTool.GetCommonStepGuideComponent(self.handler_, GuideStepCfg[var_23_0])

			if var_23_1 then
				local var_23_2 = var_23_1.transform or var_23_1.transform_

				if var_23_2 then
					self.chapterMapScrollView_:ScrollToPosition((self:ClampPositionToBounds((Vector3(var_23_2.localPosition.x, var_23_2.localPosition.y, 0)))))
				end
			end
		end
	end
end

function ChapterV2MapBaseMapView:OnTop()
	self:RefreshUI()
	self:ScaleMap()
end

function ChapterV2MapBaseMapView:SetCurrentMap()
	local var_25_0 = ChapterV2MapData:GetCurrentMapId()

	if var_25_0 == 40801 then
		var_25_0 = 40803
	end

	local var_25_1 = var_25_0 .. "_Map"

	if not self.mapGo_ or self.mapGo_.name ~= var_25_1 then
		if self.mapGo_ then
			GameObject.DestroyImmediate(self.mapGo_)
		end

		self.mapGo_ = Object.Instantiate(Asset.Load("Widget/System/Xuheng_PlotMap/XuhengPlotMapMainUI/" .. var_25_1), self.mapContent_)
	end

	local var_25_2 = ChapterV2MapData:GetCurrentMapId() .. "_MisUnlockingMap"

	if not self.misUnlockingMapGo_ or self.misUnlockingMapGo_ and self.misUnlockingMapGo_.name ~= var_25_2 then
		if self.misUnlockingMapGo_ then
			GameObject.DestroyImmediate(self.misUnlockingMapGo_)
		end

		self.misUnlockingMapGo_ = Object.Instantiate(Asset.Load("Widget/System/Xuheng_PlotMap/XuhengPlotMapMainUI/" .. var_25_2), self.misUnlockMapContent_)
	end

	local var_25_3 = ChapterV2MapData:GetCurrentMapId() .. "_AboveMisUnlockingMap"

	if not self.aboveMisUnlockingMapGo_ or self.aboveMisUnlockingMapGo_ and self.aboveMisUnlockingMapGo_.name ~= var_25_3 then
		if self.aboveMisUnlockingMapGo_ then
			GameObject.DestroyImmediate(self.aboveMisUnlockingMapGo_)
		end

		self.aboveMisUnlockingMapGo_ = Object.Instantiate(Asset.Load("Widget/System/Xuheng_PlotMap/XuhengPlotMapMainUI/" .. var_25_3), self.aboveMisUnlockMapContent_)
	end

	self:RefreshMisUnlockingMap()
end

function ChapterV2MapBaseMapView:OnExit()
	manager.notify:RemoveListener(CHAPTER_MAP_LOCATION_EVENT_CLICK, self.handlerEvent_)
	manager.notify:RemoveListener(CHAPTER_MAP_LOCATION_CLICK, self.handlerLoc_)

	for iter_26_0, iter_26_1 in ipairs(self.locationList_) do
		if self.mapLocationItems_[iter_26_1] then
			SetActive(self.mapLocationItems_[iter_26_1].gameObject_, false)
		end
	end

	if self.guideTimer_ then
		self.guideTimer_:Stop()

		self.guideTimer_ = nil
	end

	self:ClearMoveLocationTimer()
end

function ChapterV2MapBaseMapView:RefreshUI()
	local var_27_0 = ChapterV2MapData:GetCurrentMapId()

	self.mapId_ = var_27_0
	self.locationList_ = ChapterV2MapTools.GetMapLocations(var_27_0)

	self:UpdateMapLocationItemsDisplay()
end

function ChapterV2MapBaseMapView:UpdateMapLocationItemsDisplay()
	local var_28_0 = false

	for iter_28_0, iter_28_1 in ipairs(self.locationList_) do
		if not self.mapLocationItems_[iter_28_1] then
			local var_28_1
			local var_28_2

			if ChapterV2MapLocationCfg[iter_28_1].type == ChapterV2MapConst.MAPLOCATIONTYPE.TELEPORT then
				var_28_1 = ChapterV2MapLocationCfg[iter_28_1].layer == 0 and Object.Instantiate(self.goItem_, self.locationRoot_) or Object.Instantiate(self.goItem_, self.aboveLocationRoot_)
				var_28_2 = ChapterV2MapGoLocationItem.New(var_28_1)
			else
				var_28_1 = ChapterV2MapLocationCfg[iter_28_1].layer == 0 and Object.Instantiate(self.locationItem_, self.locationRoot_) or Object.Instantiate(self.locationItem_, self.aboveLocationRoot_)
				var_28_2 = ChapterV2MapLocationItem.New(var_28_1)
			end

			self.mapLocationItems_[iter_28_1] = var_28_2
		end

		SetActive(self.mapLocationItems_[iter_28_1].gameObject_, true)
		self.mapLocationItems_[iter_28_1]:SetData(iter_28_1, self.clickedLocationId_ == iter_28_1)

		if ChapterV2MapTools.GetCurrentMapMainLocation(ChapterV2MapData:GetCurrentMapId()) == iter_28_1 then
			self.playerHead_.position = self.mapLocationItems_[iter_28_1].headAni_.transform.position
			self.roleIcon_.sprite = ItemTools.getItemSprite(ChapterV2MapData:GetMapCurrentRole(ChapterV2MapData:GetCurrentMapId()))

			SetActive(self.playerHead_.gameObject, true)

			var_28_0 = true
		end
	end

	SetActive(self.playerHead_.gameObject, var_28_0)
end

function ChapterV2MapBaseMapView:Dispose()
	self:ClearAllLocationItem()

	self.isDragging_ = false
	self.lastDragPosition_ = nil
	self.mapOriginalPosition_ = nil
	self.mapBounds_ = nil
	self.screenBounds_ = nil

	ChapterV2MapBaseMapView.super.Dispose(self)
end

function ChapterV2MapBaseMapView:ClearAllLocationItem()
	if self.mapLocationItems_ then
		for iter_30_0, iter_30_1 in pairs(self.mapLocationItems_) do
			iter_30_1:Dispose()
		end

		self.mapLocationItems_ = {}
	end

	self:ClearMoveLocationTimer()
end

function ChapterV2MapBaseMapView:ClearMoveLocationTimer()
	if self.moveLocationTimer_ then
		self.moveLocationTimer_:Stop()
	end

	self.isPlayMoveAni_ = false
	self.segmentRootGoList_ = {}
end

function ChapterV2MapBaseMapView:OnMapChangeMap(arg_32_1)
	self:SetCurrentMap()
	self:ClearAllLocationItem()

	self.mapId_ = arg_32_1
	self.locationList_ = ChapterV2MapTools.GetMapLocations(arg_32_1)

	self:UpdateMapBounds()
	self:SetInitialMapCenter()
	self:RefreshUI()
end

function ChapterV2MapBaseMapView:RefreshMisUnlockingMap(arg_33_1)
	local var_33_0 = ChapterV2MapCfg[ChapterV2MapData:GetCurrentMapId()].mist_unlock_condition

	if self.misUnlockingMapGo_ then
		for iter_33_0, iter_33_1 in ipairs(var_33_0) do
			local var_33_1 = IsConditionAchieved(iter_33_1)
			local var_33_2 = self.misUnlockingMapGo_.transform:Find(tostring(iter_33_0))

			if var_33_2 then
				if arg_33_1 == ConditionCfg[iter_33_1].params[1] then
					transform:GetComponent("Animator"):Play("MistUnlockingUI_out", -1, 0)
				else
					SetActive(var_33_2.gameObject, not var_33_1)
				end
			end
		end
	end

	if self.aboveMisUnlockingMapGo_ then
		for iter_33_2, iter_33_3 in ipairs(var_33_0) do
			local var_33_3 = IsConditionAchieved(iter_33_3)
			local var_33_4 = self.aboveMisUnlockingMapGo_.transform:Find(tostring(iter_33_2))

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

function ChapterV2MapBaseMapView:GetBackCnt()
	return 0
end

return ChapterV2MapBaseMapView
