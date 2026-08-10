local var_0_0 = class("DormNavigationView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormNavigationpopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.canteenHeroStateScroll_ = LuaList.New(handler(arg_3_0, arg_3_0.indexHeroItem), arg_3_0.heroUilistGo_, BackHomeNewHeroItem)

	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitController()
end

function var_0_0.InitController(arg_5_0)
	arg_5_0.canteenTaskStateController = arg_5_0.mainControllerEx_:GetController("canteenTask")
	arg_5_0.canteenFoodEnoughController = arg_5_0.mainControllerEx_:GetController("canteenFood")
	arg_5_0.positionController = arg_5_0.mainControllerEx_:GetController("position")
	arg_5_0.buidingStateController = ControllerUtil.GetController(arg_5_0.buildingStateRoot_, "taskstate")
end

function var_0_0.OnEnter(arg_6_0)
	if arg_6_0.params_.isMain then
		arg_6_0.isMain_ = arg_6_0.params_.isMain
	else
		arg_6_0.isMain_ = false
	end

	DormRedPointTools:RefreshIlluDanceNew()
	arg_6_0:RegisterEvent()
	arg_6_0:RefreshCanteenState()
	arg_6_0:RefreshDanceState()
	arg_6_0:RefreshView()
	arg_6_0:BindRedPoint()
	arg_6_0.buidingStateController:SetSelectedState(DormData:CanReceiveVisitReward() and "true" or "false")
end

function var_0_0.BindRedPoint(arg_7_0)
	manager.redPoint:bindUIandKey(arg_7_0.illustratBtn_.transform, RedPointConst.DORM_ILLU)
	manager.redPoint:bindUIandKey(arg_7_0.canteenBtn_.transform, RedPointConst.CANTEEN)
	manager.redPoint:bindUIandKey(arg_7_0.trainingroomBtn_.transform, RedPointConst.IDOL_TRAINEE)
end

function var_0_0.UnBindRedPoint(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.illustratBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_8_0.canteenBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_8_0.trainingroomBtn_.transform)
end

function var_0_0.indexHeroItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	arg_9_2:RefreshUI(arg_9_0.workHeroList[arg_9_1])
end

function var_0_0.RefreshCanteenState(arg_10_0)
	arg_10_0.canteenTaskStateController:SetSelectedState("false")
	arg_10_0.canteenFoodEnoughController:SetSelectedState("false")
	arg_10_0:RefreshCanteenJobItem()
end

function var_0_0.RefreshCanteenJobItem(arg_11_0)
	arg_11_0.workHeroList = {}

	local var_11_0 = CanteenHeroTools:GetCanteenJobList()

	if var_11_0 then
		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			table.insert(arg_11_0.workHeroList, iter_11_1.heroID or -1)
		end
	end

	arg_11_0.canteenHeroStateScroll_:StartScroll(#arg_11_0.workHeroList)
end

function var_0_0.RefreshDanceState(arg_12_0)
	return
end

function var_0_0.RegisterEvent(arg_13_0)
	arg_13_0:RegistEventListener(CANTEEN_SET_JOG_SUCCESS, function()
		arg_13_0:RefreshCanteenState()
	end)
end

function var_0_0.RefreshView(arg_15_0)
	if arg_15_0.isMain_ then
		arg_15_0.positionController:SetSelectedState("dorm")

		return
	end

	local var_15_0 = BackHomeDataManager:GetCurSystem()

	if var_15_0 == DormEnum.DormSystemType.CricketBattle then
		arg_15_0.positionController:SetSelectedState("trainingroom")
	elseif var_15_0 == DormEnum.DormSystemType.Dormitory then
		arg_15_0.positionController:SetSelectedState("dining")
	elseif var_15_0 == DormEnum.DormSystemType.Canteen then
		arg_15_0.positionController:SetSelectedState("canteen")
	elseif var_15_0 == DormEnum.DormSystemType.Illu then
		arg_15_0.positionController:SetSelectedState("illustrat")
	elseif var_15_0 == DormEnum.DormSystemType.Main then
		arg_15_0.positionController:SetSelectedState("dorm")
	else
		arg_15_0.positionController:SetSelectedState("dorm")
	end
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:UpdateBar()
	arg_16_0.buidingStateController:SetSelectedState(DormData:CanReceiveVisitReward() and "true" or "false")
end

function var_0_0.UpdateBar(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_18_0)
	manager.windowBar:HideBar()
	arg_18_0:UnBindRedPoint()
end

function var_0_0.AddUIListener(arg_19_0)
	arg_19_0:AddBtnListener(arg_19_0.backBtn_, nil, function()
		arg_19_0:Back()
	end)
	arg_19_0:AddBtnListener(arg_19_0.trainingroomBtn_, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle and DormMinigame.minigame == IdolTraineeCampBridge then
			JumpTools.OpenPageByJump("/idolTraineeCamp")
		else
			BackHomeTools:GotoBackHomeRoom(nil, true, nil, function()
				return
			end)
		end
	end)
	arg_19_0:AddBtnListener(arg_19_0.canteenBtn_, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Canteen then
			CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)
			JumpTools.OpenPageByJump("/restaurantMain")
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
		end
	end)
	arg_19_0:AddBtnListener(arg_19_0.diningBtn_, nil, function()
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
	arg_19_0:AddBtnListener(arg_19_0.dormBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	arg_19_0:AddBtnListener(arg_19_0.illustratBtn_, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Illu then
			JumpTools.OpenPageByJump("/dormIlluMainView")
		else
			BackHomeTools:GotoBackHomeRoom(nil, false, true)
		end
	end)
end

function var_0_0.Dispose(arg_27_0)
	if arg_27_0.canteenHeroStateScroll_ then
		arg_27_0.canteenHeroStateScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_27_0)
end

return var_0_0
