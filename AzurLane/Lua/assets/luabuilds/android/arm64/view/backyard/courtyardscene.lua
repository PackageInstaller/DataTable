local var_0_0 = class("CourtYardScene", import("..base.BaseUI"))

function var_0_0.forceGC(arg_1_0)
	return true
end

function var_0_0.getUIName(arg_2_0)
	return "CourtYardUI"
end

function var_0_0.PlayBGM(arg_3_0)
	pg.BgmMgr.GetInstance():StopPlay()

	return
end

function var_0_0.preload(arg_4_0, arg_4_1)
	_BackyardMsgBoxMgr = BackyardMsgBoxMgr.New()

	_BackyardMsgBoxMgr:Init(arg_4_0, arg_4_1)

	return
end

function var_0_0.SetDorm(arg_5_0, arg_5_1)
	arg_5_0.dorm = arg_5_1

	return
end

function var_0_0.init(arg_6_0)
	arg_6_0.contextData.floor = arg_6_0.contextData.floor or 1
	arg_6_0.panels = {
		CourtYardLeftPanel.New(arg_6_0),
		CourtYardRightPanel.New(arg_6_0),
		CourtYardTopPanel.New(arg_6_0),
		CourtYardBottomPanel.New(arg_6_0)
	}
	arg_6_0.mainTF = arg_6_0._tf:Find("main")
	arg_6_0.mainCG = GetOrAddComponent(arg_6_0.mainTF, typeof(CanvasGroup))
	arg_6_0.bg = arg_6_0._tf:Find("bg000")
	arg_6_0.animation = arg_6_0._tf:GetComponent(typeof(Animation))
	arg_6_0.emptyFoodPage = CourtYardEmptyFoodPage.New(arg_6_0._tf, arg_6_0.event)

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0:BlockEvents()
	arg_7_0:SetUpCourtYard()
	arg_7_0:FlushMainView()

	arg_7_0.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(arg_7_0)

	return
end

function var_0_0.OnCourtYardLoaded(arg_8_0)
	pg.OSSMgr.GetInstance():Init()
	arg_8_0:AddVisitorShip()

	if arg_8_0.contextData.mode ~= CourtYardConst.SYSTEM_VISIT then
		BackYardThemeTempalteUtil.CheckSaveDirectory()
		pg.m02:sendNotification(GAME.OPEN_ADD_EXP, 1)
	end

	arg_8_0:UnBlockEvents()

	if arg_8_0.contextData.OpenShop then
		triggerButton(arg_8_0:GetPanel(CourtYardBottomPanel).shopBtn)
	end

	return
end

function var_0_0.UpdateDorm(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:SetDorm(arg_9_1)
	arg_9_0:FlushMainView(arg_9_2)

	return
end

function var_0_0.SetUpCourtYard(arg_10_0)
	seriesAsync({
		function(arg_11_0)
			local var_11_0 = arg_10_0.contextData.mode or CourtYardConst.SYSTEM_VISIT

			if var_11_0 ~= CourtYardConst.SYSTEM_VISIT then
				arg_11_0()

				return
			end

			arg_10_0:emit(CourtYardMediator.ON_ADD_VISITOR_SHIP, arg_11_0)

			return
		end
	}, function()
		arg_10_0:emit(CourtYardMediator.SET_UP, arg_10_0.contextData.floor)

		return
	end)

	return
end

function var_0_0.FlushMainView(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.panels) do
		table.insert({}, function(arg_14_0)
			iter_13_1:Flush(arg_13_0.dorm, arg_13_1)
			onNextTick(arg_14_0)

			return
		end)
	end

	seriesAsync({})

	return
end

function var_0_0.SwitchFloorDone(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.panels) do
		iter_15_1:UpdateFloor(arg_15_0.dorm)
	end

	return
end

function var_0_0.ShowAddFoodTip(arg_16_0)
	if arg_16_0.contextData.mode ~= CourtYardConst.SYSTEM_VISIT and arg_16_0.dorm.food == 0 and not arg_16_0.contextData.OpenShop then
		if not pg.NewGuideMgr.GetInstance():IsBusy() and arg_16_0.dorm:GetFloorShipCnt(DormShip.FLOOR_1) > 0 and (not arg_16_0.contextData.fromMediatorName or arg_16_0.contextData.fromMediatorName ~= "DockyardMediator" and arg_16_0.contextData.fromMediatorName ~= "ShipMainMediator") and not arg_16_0.contextData.skipToCharge then
			arg_16_0.emptyFoodPage:ExecuteAction("Flush")

			arg_16_0.contextData.fromMain = nil
		end
	end

	arg_16_0.contextData.skipToCharge = nil

	return
end

function var_0_0.AddVisitorShip(arg_17_0)
	if arg_17_0.contextData.mode == CourtYardConst.SYSTEM_VISIT then
		return
	end

	if arg_17_0.contextData.floor ~= 1 then
		return
	end

	local var_17_0 = getProxy(PlayerProxy):getRawData()

	if not var_17_0:GetCommonFlag(SHOW_FIREND_BACKYARD_SHIP_FLAG) then
		return
	end

	local var_17_1 = getProxy(DormProxy):GetVisitorShip()

	if var_17_1 then
		_courtyard:GetController():AddVisitorShip(var_17_1)
	end

	return
end

function var_0_0.FoldPanel(arg_18_0, arg_18_1)
	if arg_18_1 then
		arg_18_0.animation:Play("anim_courtyard_mainui_hide")
	else
		arg_18_0.animation:Play("anim_courtyard_mainui_in")
	end

	return
end

function var_0_0.OnEnterOrExitEdit(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.panels) do
		iter_19_1:OnEnterOrExitEdit(arg_19_1)
	end

	Input.multiTouchEnabled = not arg_19_1

	return
end

function var_0_0.BlockEvents(arg_20_0)
	arg_20_0.mainCG.blocksRaycasts = false

	return
end

function var_0_0.UnBlockEvents(arg_21_0)
	arg_21_0.mainCG.blocksRaycasts = true

	return
end

function var_0_0.OnRemoveLayer(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.panels) do
		iter_22_1:OnRemoveLayer(arg_22_1.context.mediator)
	end

	return
end

function var_0_0.OnReconnection(arg_23_0)
	pg.m02:sendNotification(GAME.OPEN_ADD_EXP, 1)

	return
end

function var_0_0.OnAddFurniture(arg_24_0)
	arg_24_0:GetPanel(CourtYardTopPanel):OnFlush(BackYardConst.DORM_UPDATE_TYPE_LEVEL)

	return
end

function var_0_0.GetPanel(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.panels) do
		if isa(iter_25_1, arg_25_1) then
			return iter_25_1
		end
	end

	return
end

function var_0_0.onBackPressed(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.panels) do
		if iter_26_1:onBackPressed() then
			return
		end
	end

	if _courtyard then
		_courtyard:GetController():OnBackPressed()
	else
		var_0_0.super.onBackPressed(arg_26_0)
	end

	return
end

function var_0_0.willExit(arg_27_0)
	_BackyardMsgBoxMgr:Destroy()

	_BackyardMsgBoxMgr = nil

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.panels) do
		iter_27_1:Detach()
	end

	arg_27_0.emptyFoodPage:Destroy()

	arg_27_0.emptyFoodPage = nil

	if arg_27_0.bulinTip then
		arg_27_0.bulinTip:Destroy()

		arg_27_0.bulinTip = nil
	end

	if arg_27_0.contextData.mode ~= CourtYardConst.SYSTEM_VISIT then
		pg.m02:sendNotification(GAME.OPEN_ADD_EXP, 0)
	end

	getProxy(DormProxy):getRawData():ClearNewFlag()

	return
end

return var_0_0
