local DormChooseRoomView = class("DormChooseRoomView", ReduxView)

function DormChooseRoomView:UIName()
	return "Widget/BackHouseUI/Dorm/DormEntranceUI"
end

function DormChooseRoomView:UIParent()
	return manager.ui.uiMain.transform
end

function DormChooseRoomView:Init()
	self:InitUI()

	self.canteenHeroStateScroll = LuaList.New(handler(self, self.indexHeroItem), self.heroUilistGo_, BackHomeNewHeroItem)
	self.danceHeroStateScroll = LuaList.New(handler(self, self.indexDanceHeroItem), self.danceHeroUilistGo_, BackHomeNewHeroItem)
	self.toggleGroup = {}

	for iter_3_0 = 1, GameDisplayCfg.dorm_area_layer_num.value[1] do
		self.toggleGroup[iter_3_0] = self["floor" .. iter_3_0 .. "Tgl_"]
	end

	self.roomItemView = DromPrivateRoomItem.New(self.dormRoomItem)
	self.marqueComp = MarqueComponent.New(self.marqueeObj_)

	self.marqueComp:Hide()

	self.subtitleBubbleView = SubtitleBubbleView.MuteBubbleSubView.GetInstance()

	self:AddUIListener()
end

function DormChooseRoomView:InitUI()
	self:BindCfgUI()
	self:InitController()
end

function DormChooseRoomView:InitController()
	self.canteenTaskStateController = ControllerUtil.GetController(self.canteenstateTrs_, "taskstate")
	self.canteenFoodEnoughController = ControllerUtil.GetController(self.canteenstateTrs_, "foodstate")
	self.listShowController = self.showController:GetController("switch")
end

function DormChooseRoomView:OnEnter()
	if self.params_.openInfoPanel then
		self.params_.openInfoPanel = false

		JumpTools.OpenPageByJump("/dormInformationView")

		return
	end

	BackHomeAction:GetVisitData()
	self:RefreshFloorInfo()

	self.moveFlag = false

	self:RegisterEvent()
	DormRedPointTools:UpdataDormRedPoint(false)
	self:BindRedPoint()
	self.roomItemView:OnEnter()
	self:RefreshCanteenState()
	self:RefreshDanceState()
	self:RenderMarque()
	self.subtitleBubbleView:OnEnter()
	self:RefreshFloorScroll()
end

function DormChooseRoomView:OnBehind()
	self.roomItemView:OnBehind()
end

function DormChooseRoomView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.IDOL_TASK)
	manager.redPoint:bindUIandKey(self.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	manager.redPoint:bindUIandKey(self.infomationBtn_.transform, RedPointConst.BACKHOME_INFO)
end

function DormChooseRoomView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.IDOL_TASK)
	manager.redPoint:unbindUIandKey(self.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	manager.redPoint:unbindUIandKey(self.infomationBtn_.transform, RedPointConst.BACKHOME_INFO)
end

function DormChooseRoomView:RefreshFloorInfo()
	self.floor = self.floor or DormitoryData:GetFloor() or 1
	self.toggleGroup[self.floor].isOn = true

	for iter_10_0 = 1, GameDisplayCfg.dorm_area_layer_num.value[1] do
		self["text" .. iter_10_0 .. "Text_"].text = iter_10_0 .. "F"
	end

	self:RefreshRoomItem()
end

function DormChooseRoomView:OnTop()
	local var_11_0, var_11_1, var_11_2, var_11_3 = IdolTraineeTools:GetCurQuestRankInfo()

	if var_11_2 <= var_11_1 then
		manager.redPoint:setTip(RedPointConst.IDOL_TASK_GAIN, 1)
	else
		manager.redPoint:setTip(RedPointConst.IDOL_TASK_GAIN, 0)
	end

	self:UpdateBar()
	self.roomItemView:OnTop()
end

function DormChooseRoomView:OnUpdate()
	self.roomItemView:OnUpdate()
end

function DormChooseRoomView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		CurrencyConst.CURRENCY_TYPE_DORM_GOLD,
		DormConst.DORM_HOME_UNLOCK_ROOM_CURRENCY
	})
	manager.windowBar:SetBarCanAdd(DormConst.DORM_HOME_UNLOCK_ROOM_CURRENCY, true)
	manager.windowBar:RegistBackCallBack(function()
		self.roomItemView:OnExit()

		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
			BackHomeDataManager:ExitBackHomeSystem()
			JumpTools.OpenPageByJump("/home")
		else
			BackHomeTools:BackHomeGotoMain()
		end
	end)
end

function DormChooseRoomView:RegisterEvent()
	self:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function()
		self:RefreshRoomItem()
	end)
	self:RegistEventListener(DORM_HERO_OCCUPY, function()
		if self.floor then
			self.roomItemView:RefreshUI(self.floor)
		end
	end)
	self:RegistEventListener(CANTEEN_SET_JOG_SUCCESS, function()
		self:RefreshCanteenState()
	end)
	self:RegistEventListener(SHOW_MESSAGE_BOX, function()
		self:OnBehind()
	end)
	self:RegistEventListener(CLOSE_MESSAGE_BOX, function()
		self:OnTop()
	end)
	self:RegistEventListener(GUIDE_START, function()
		self:OnTop()
	end)
end

function DormChooseRoomView:OnExit()
	self.subtitleBubbleView:OnExit()
	self.roomItemView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:UnBindRedPoint()
end

function DormChooseRoomView:AddUIListener()
	self:AddBtnListener(self.canteenBtn_, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Canteen then
			CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)
			JumpTools.OpenPageByJump("/restaurantMain")
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
		end
	end)

	for iter_23_0 = 1, DormConst.DORM_FLOOR_MAX do
		if self["floor" .. iter_23_0 .. "Tgl_"] then
			self:AddToggleListener(self["floor" .. iter_23_0 .. "Tgl_"], function(arg_25_0)
				if arg_25_0 then
					self:ClickChangeFloor(iter_23_0)
				end
			end)
		end
	end

	self:AddBtnListenerScale(self.visitBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormVisitView", {
			back = "chooseRoom"
		})
	end)
	self:AddBtnListenerScale(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("idolTraineeQuest")
	end)
	self:AddBtnListenerScale(self.btnupBtn_, nil, function()
		if self.floor < DormConst.DORM_FLOOR_MAX then
			self:ClickChangeFloor(self.floor + 1)
		end
	end)
	self:AddBtnListenerScale(self.btnunderBtn_, nil, function()
		if self.floor > 1 then
			self:ClickChangeFloor(self.floor - 1)
		end
	end)
	self:AddBtnListener(self.cricketBtn, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
			JumpTools.OpenPageByJump("/idolTraineeCamp")

			return
		end

		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
	self:AddBtnListener(self.showBtn, nil, function()
		if self.listShowController:GetSelectedState() == "off" then
			self.listShowController:SetSelectedState("on")
			self:RefreshCanteenState()
			self:RefreshDanceState()
		else
			self.listShowController:SetSelectedState("off")
		end
	end)
	self:AddBtnListener(self.navigationBtn_, nil, function()
		JumpTools.OpenPageByJump("dormNavigation", {
			isMain = true
		})
	end)
	self:AddBtnListenerScale(self.infomationBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormInformationView")
	end)
end

function DormChooseRoomView:ClickChangeFloor(arg_34_1)
	if self.roomItemView.edit then
		return
	end

	if self.floor == arg_34_1 then
		return
	end

	self.floor = arg_34_1
	self.toggleGroup[self.floor].isOn = true

	self:RefreshRoomItem()
	self:RefreshFloorScroll()
	DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.ChangeFloor)
	self.roomItemView:PlayFloorAnimation()
end

function DormChooseRoomView:RefreshFloorScroll()
	self.floorScroll_.movementType = ScrollRect.MovementType.Clamped
	self.floorScroll_.content.anchoredPosition = Vector2.New(0, (self.floor - 1) * -120)
	self.floorScroll_.movementType = ScrollRect.MovementType.Elastic
end

function DormChooseRoomView:RefreshCanteenState()
	if CanteenEntrustData.AnyEntrustFinished() then
		self.canteenTaskStateController:SetSelectedState("true")
	else
		self.canteenTaskStateController:SetSelectedState("false")
	end

	if CanteenTools:CheckSignFoodNumCanOpen() then
		self.canteenFoodEnoughController:SetSelectedState("false")
	else
		self.canteenFoodEnoughController:SetSelectedState("true")
	end

	self:RefreshCanteenJobItem()
end

function DormChooseRoomView:RefreshRoomItem()
	if self.floor then
		self.roomItemView:RefreshUI(self.floor)
	end
end

function DormChooseRoomView:RefreshCanteenJobItem()
	self.workHeroList = {}

	local var_38_0 = CanteenHeroTools:GetCanteenJobList()

	if var_38_0 then
		for iter_38_0, iter_38_1 in ipairs(var_38_0) do
			table.insert(self.workHeroList, iter_38_1.heroID or -1)
		end
	end

	self.canteenHeroStateScroll:StartScroll(#self.workHeroList)
end

function DormChooseRoomView:indexHeroItem(arg_39_1, arg_39_2)
	arg_39_2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	arg_39_2:RefreshUI(self.workHeroList[arg_39_1])
end

function DormChooseRoomView:indexDanceHeroItem(arg_40_1, arg_40_2)
	arg_40_2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	arg_40_2:RefreshUI(self.danceHeroList[arg_40_1])
end

function DormChooseRoomView:RefreshDanceState()
	self.danceHeroList = {}

	for iter_41_0 = 1, GameSetting.dorm_idol_room_max_place.value[1] do
		self.danceHeroList[iter_41_0] = 0
	end

	for iter_41_1, iter_41_2 in ipairs((DormHeroTools:GetHeroListInDance())) do
		if iter_41_2.dancePos then
			self.danceHeroList[iter_41_2.dancePos] = iter_41_2.hero_id
		end
	end

	self.danceHeroStateScroll:StartScroll(#self.danceHeroList)
end

function DormChooseRoomView:RenderMarque()
	return
end

function DormChooseRoomView:Dispose()
	if self.canteenHeroStateScroll then
		self.canteenHeroStateScroll:Dispose()
	end

	if self.danceHeroStateScroll then
		self.danceHeroStateScroll:Dispose()
	end

	if self.roomItemView then
		self.roomItemView:Dispose()
	end

	self.marqueComp:Dispose()
	DormitoryData:SetFloor(self.floor)
	DormChooseRoomView.super.Dispose(self)
end

return DormChooseRoomView
