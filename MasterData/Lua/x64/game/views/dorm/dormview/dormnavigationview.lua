local DormNavigationView = class("DormNavigationView", ReduxView)

function DormNavigationView:UIName()
	return "Widget/BackHouseUI/Dorm/DormNavigationpopUI"
end

function DormNavigationView:UIParent()
	return manager.ui.uiPop.transform
end

function DormNavigationView:Init()
	self:InitUI()

	self.canteenHeroStateScroll_ = LuaList.New(handler(self, self.indexHeroItem), self.heroUilistGo_, BackHomeNewHeroItem)

	self:AddUIListener()
end

function DormNavigationView:InitUI()
	self:BindCfgUI()
	self:InitController()
end

function DormNavigationView:InitController()
	self.canteenTaskStateController = self.mainControllerEx_:GetController("canteenTask")
	self.canteenFoodEnoughController = self.mainControllerEx_:GetController("canteenFood")
	self.positionController = self.mainControllerEx_:GetController("position")
	self.buidingStateController = ControllerUtil.GetController(self.buildingStateRoot_, "taskstate")
end

function DormNavigationView:OnEnter()
	self.isMain_ = self.params_.isMain and self.params_.isMain or false

	DormRedPointTools:RefreshIlluDanceNew()
	self:RegisterEvent()
	self:RefreshCanteenState()
	self:RefreshDanceState()
	self:RefreshView()
	self:BindRedPoint()
	self.buidingStateController:SetSelectedState(DormData:CanReceiveVisitReward() and "true" or "false")
end

function DormNavigationView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.illustratBtn_.transform, RedPointConst.DORM_ILLU)
	manager.redPoint:bindUIandKey(self.canteenBtn_.transform, RedPointConst.CANTEEN)
	manager.redPoint:bindUIandKey(self.trainingroomBtn_.transform, RedPointConst.IDOL_TRAINEE)
end

function DormNavigationView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.illustratBtn_.transform)
	manager.redPoint:unbindUIandKey(self.canteenBtn_.transform)
	manager.redPoint:unbindUIandKey(self.trainingroomBtn_.transform)
end

function DormNavigationView:indexHeroItem(arg_9_1, arg_9_2)
	arg_9_2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	arg_9_2:RefreshUI(self.workHeroList[arg_9_1])
end

function DormNavigationView:RefreshCanteenState()
	self.canteenTaskStateController:SetSelectedState("false")
	self.canteenFoodEnoughController:SetSelectedState("false")
	self:RefreshCanteenJobItem()
end

function DormNavigationView:RefreshCanteenJobItem()
	self.workHeroList = {}

	local var_11_0 = CanteenHeroTools:GetCanteenJobList()

	if var_11_0 then
		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			table.insert(self.workHeroList, iter_11_1.heroID or -1)
		end
	end

	self.canteenHeroStateScroll_:StartScroll(#self.workHeroList)
end

function DormNavigationView:RefreshDanceState()
	return
end

function DormNavigationView:RegisterEvent()
	self:RegistEventListener(CANTEEN_SET_JOG_SUCCESS, function()
		self:RefreshCanteenState()
	end)
end

function DormNavigationView:RefreshView()
	if self.isMain_ then
		self.positionController:SetSelectedState("dorm")

		return
	end

	local var_15_0 = BackHomeDataManager:GetCurSystem()

	if var_15_0 == DormEnum.DormSystemType.CricketBattle then
		self.positionController:SetSelectedState("trainingroom")
	elseif var_15_0 == DormEnum.DormSystemType.Dormitory then
		self.positionController:SetSelectedState("dining")
	elseif var_15_0 == DormEnum.DormSystemType.Canteen then
		self.positionController:SetSelectedState("canteen")
	elseif var_15_0 == DormEnum.DormSystemType.Illu then
		self.positionController:SetSelectedState("illustrat")
	elseif var_15_0 == DormEnum.DormSystemType.Main then
		self.positionController:SetSelectedState("dorm")
	else
		self.positionController:SetSelectedState("dorm")
	end
end

function DormNavigationView:OnTop()
	self:UpdateBar()
	self.buidingStateController:SetSelectedState(DormData:CanReceiveVisitReward() and "true" or "false")
end

function DormNavigationView:UpdateBar()
	manager.windowBar:HideBar()
end

function DormNavigationView:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPoint()
end

function DormNavigationView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.trainingroomBtn_, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle and DormMinigame.minigame == IdolTraineeCampBridge then
			JumpTools.OpenPageByJump("/idolTraineeCamp")
		else
			BackHomeTools:GotoBackHomeRoom(nil, true, nil, function()
				return
			end)
		end
	end)
	self:AddBtnListener(self.canteenBtn_, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Canteen then
			CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)
			JumpTools.OpenPageByJump("/restaurantMain")
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
		end
	end)
	self:AddBtnListener(self.diningBtn_, nil, function()
		local var_24_0 = DormData:GetCurrectSceneID()

		if var_24_0 == DormConst.PUBLIC_DORM_ID then
			JumpTools.OpenPageByJump("/dorm")
			DormHeroTools:ShowVisitTalk()

			return
		end

		if nullable(BackHomeCfg, var_24_0, "type") == DormConst.BACKHOME_TYPE.PrivateDorm then
			JumpTools.OpenPageByJump("/dormHeroDeployView")
		end

		BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)
	end)
	self:AddBtnListener(self.dormBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	self:AddBtnListener(self.illustratBtn_, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Illu then
			JumpTools.OpenPageByJump("/dormIlluMainView")
		else
			BackHomeTools:GotoBackHomeRoom(nil, false, true)
		end
	end)
end

function DormNavigationView:Dispose()
	if self.canteenHeroStateScroll_ then
		self.canteenHeroStateScroll_:Dispose()
	end

	DormNavigationView.super.Dispose(self)
end

return DormNavigationView
