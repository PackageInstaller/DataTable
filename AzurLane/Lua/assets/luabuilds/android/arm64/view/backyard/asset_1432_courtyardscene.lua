class = var_0_10000

local var_0_0 = "CourtYardScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.forceGC(arg_1_0)
	return true
end

function var_0_1.getUIName(arg_2_0)
	return "CourtYardUI"
end

function var_0_1.PlayBGM(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.BgmMgr.GetInstance()

	var_1.StopPlay(var_3_0)

	return
end

function var_0_1.preload(arg_4_0, arg_4_1)
	BackyardMsgBoxMgr = var_1_10002

	local var_4_0 = var_1_10002.New()

	_BackyardMsgBoxMgr = _BackyardMsgBoxMgr

	var_2:Init(arg_4_0, arg_4_1)

	return
end

function var_0_1.SetDorm(arg_5_0, arg_5_1)
	arg_5_0.dorm = arg_5_1

	return
end

function var_0_1.init(arg_6_0)
	if not arg_6_0.contextData.floor then
		arg_6_0.contextData.floor = 1
	end

	local var_6_0 = {}

	CourtYardLeftPanel = var_1_10002
	var_6_0[1] = var_1_10002.New(arg_6_0)
	CourtYardRightPanel = var_2
	var_6_0[2] = var_2.New(arg_6_0)
	CourtYardTopPanel = var_2
	var_6_0[3] = var_2.New(arg_6_0)
	CourtYardBottomPanel = var_2
	var_6_0[4] = var_2.New(arg_6_0)
	arg_6_0.panels = var_6_0

	local var_6_1 = arg_6_0._tf

	arg_6_0.mainTF = var_1.Find(var_6_1, "main")
	GetOrAddComponent = var_1

	local var_6_2 = arg_6_0.mainTF

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_6_0.mainCG = var_1(var_6_2, var_4(var_1_10006))

	local var_6_3 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_3, "bg000")

	local var_6_4 = arg_6_0._tf
	local var_6_5 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_6_0.animation = var_6_5(var_6_4, var_4(var_1_10006))
	CourtYardEmptyFoodPage = var_1
	arg_6_0.emptyFoodPage = var_1.New(arg_6_0._tf, arg_6_0.event)

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:BlockEvents()
	arg_7_0:SetUpCourtYard()
	arg_7_0:FlushMainView()

	AprilFoolBulinSubView = var_1
	arg_7_0.bulinTip = var_1.ShowAprilFoolBulin(arg_7_0)

	return
end

function var_0_1.OnCourtYardLoaded(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.OSSMgr.GetInstance()

	var_1.Init(var_8_0)
	arg_8_0:AddVisitorShip()

	local var_8_1 = arg_8_0.contextData.mode

	CourtYardConst = var_1_10002

	if var_8_1 ~= var_1_10002.SYSTEM_VISIT then
		BackYardThemeTempalteUtil = var_8_1

		var_8_1.CheckSaveDirectory()

		pg = var_1

		local var_8_2 = var_1.m02
		local var_8_3 = var_1.sendNotification

		GAME = var_1_10004

		var_8_3(var_8_2, var_1_10004.OPEN_ADD_EXP, 1)
	end

	arg_8_0:UnBlockEvents()

	if arg_8_0.contextData.OpenShop then
		local var_8_4 = arg_8_0
		local var_8_5 = arg_8_0.GetPanel

		CourtYardBottomPanel = var_1_10004

		local var_8_6 = var_8_5(var_8_4, var_1_10004)

		triggerButton = var_2

		var_2(var_8_6.shopBtn)
	end

	return
end

function var_0_1.UpdateDorm(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:SetDorm(arg_9_1)
	arg_9_0:FlushMainView(arg_9_2)

	return
end

function var_0_1.SetUpCourtYard(arg_10_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_11_0)
			local var_11_0

			if not arg_10_0.contextData.mode then
				CourtYardConst = var_11_0
				var_11_0 = var_11_0.SYSTEM_VISIT
			end

			CourtYardConst = var_2_10002

			if var_11_0 ~= var_2_10002.SYSTEM_VISIT then
				arg_11_0()

				return
			end

			local var_11_1 = arg_10_0
			local var_11_2 = var_2.emit

			CourtYardMediator = var_2_10005

			var_11_2(var_11_1, var_2_10005.ON_ADD_VISITOR_SHIP, arg_11_0)

			return
		end
	}, function()
		local var_12_0 = arg_10_0.contextData.floor
		local var_12_1 = arg_10_0
		local var_12_2 = var_1.emit

		CourtYardMediator = var_2_10004

		var_12_2(var_12_1, var_2_10004.SET_UP, var_12_0)

		return
	end)

	return
end

function var_0_1.FlushMainView(arg_13_0, arg_13_1)
	local var_13_0 = {}

	ipairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(arg_13_0.panels) do
		table = var_1_10008

		var_1_10008.insert(var_13_0, function(arg_14_0)
			local var_14_0 = iter_13_1

			var_1.Flush(var_14_0, arg_13_0.dorm, arg_13_1)

			onNextTick = var_1

			var_1(arg_14_0)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_13_0)

	return
end

function var_0_1.SwitchFloorDone(arg_15_0)
	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.panels) do
		iter_15_1:UpdateFloor(arg_15_0.dorm)
	end

	return
end

function var_0_1.ShowAddFoodTip(arg_16_0)
	local var_16_0 = arg_16_0.contextData.mode

	CourtYardConst = var_1_10002

	if var_16_0 ~= var_1_10002.SYSTEM_VISIT and arg_16_0.dorm.food == 0 and not arg_16_0.contextData.OpenShop then
		pg = var_1

		local var_16_1 = var_1.NewGuideMgr.GetInstance()

		if not var_1.IsBusy(var_16_1) then
			local var_16_2 = arg_16_0.dorm
			local var_16_3 = var_1.GetFloorShipCnt

			DormShip = var_1_10004

			if var_16_3(var_16_2, var_1_10004.FLOOR_1) > 0 and (not arg_16_0.contextData.fromMediatorName or arg_16_0.contextData.fromMediatorName ~= "DockyardMediator" and arg_16_0.contextData.fromMediatorName ~= "ShipMainMediator") and not arg_16_0.contextData.skipToCharge then
				local var_16_4 = arg_16_0.emptyFoodPage

				var_1.ExecuteAction(var_16_4, "Flush")

				arg_16_0.contextData.fromMain = nil
			end
		end
	end

	arg_16_0.contextData.skipToCharge = nil

	return
end

function var_0_1.AddVisitorShip(arg_17_0)
	local var_17_0 = arg_17_0.contextData.mode

	CourtYardConst = var_1_10002

	if var_17_0 == var_1_10002.SYSTEM_VISIT then
		return
	end

	if arg_17_0.contextData.floor ~= 1 then
		return
	end

	getProxy = var_1
	PlayerProxy = var_1_10003

	local var_17_1 = var_1(var_1_10003)
	local var_17_2 = var_1.getRawData(var_17_1)
	local var_17_3 = var_1.GetCommonFlag

	SHOW_FIREND_BACKYARD_SHIP_FLAG = var_1_10005

	if not var_17_3(var_17_2, var_1_10005) then
		return
	end

	getProxy = var_17_1
	DormProxy = var_1_10005

	local var_17_4 = var_17_1(var_1_10005)

	if var_3.GetVisitorShip(var_17_4) then
		_courtyard = var_1_10005

		local var_17_5 = var_1_10005:GetController()

		var_5.AddVisitorShip(var_17_5, var_4)
	end

	return
end

function var_0_1.FoldPanel(arg_18_0, arg_18_1)
	if arg_18_1 then
		local var_18_0 = arg_18_0.animation

		var_2.Play(var_18_0, "anim_courtyard_mainui_hide")
	else
		local var_18_1 = arg_18_0.animation

		var_2.Play(var_18_1, "anim_courtyard_mainui_in")
	end

	return
end

function var_0_1.OnEnterOrExitEdit(arg_19_0, arg_19_1)
	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.panels) do
		iter_19_1:OnEnterOrExitEdit(arg_19_1)
	end

	Input = var_2
	var_2.multiTouchEnabled = not arg_19_1

	return
end

function var_0_1.BlockEvents(arg_20_0)
	arg_20_0.mainCG.blocksRaycasts = false

	return
end

function var_0_1.UnBlockEvents(arg_21_0)
	arg_21_0.mainCG.blocksRaycasts = true

	return
end

function var_0_1.OnRemoveLayer(arg_22_0, arg_22_1)
	ipairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_0.panels) do
		iter_22_1:OnRemoveLayer(arg_22_1.context.mediator)
	end

	return
end

function var_0_1.OnReconnection(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.m02
	local var_23_1 = var_1.sendNotification

	GAME = var_1_10004

	var_23_1(var_23_0, var_1_10004.OPEN_ADD_EXP, 1)

	return
end

function var_0_1.OnAddFurniture(arg_24_0)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.GetPanel

	CourtYardTopPanel = var_1_10004

	local var_24_2 = var_24_1(var_24_0, var_1_10004)
	local var_24_3 = var_1.OnFlush

	BackYardConst = var_1_10004

	var_24_3(var_24_2, var_1_10004.DORM_UPDATE_TYPE_LEVEL)

	return
end

function var_0_1.GetPanel(arg_25_0, arg_25_1)
	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.panels) do
		isa = var_1_10007

		if var_1_10007(iter_25_1, arg_25_1) then
			return iter_25_1
		end
	end

	return
end

function var_0_1.onBackPressed(arg_26_0)
	ipairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0.panels) do
		if iter_26_1:onBackPressed() then
			return
		end
	end

	_courtyard = var_1

	if var_1 then
		_courtyard = var_1

		local var_26_0 = var_1:GetController()

		var_1.OnBackPressed(var_26_0)
	else
		var_0_1.super.onBackPressed(arg_26_0)
	end

	return
end

function var_0_1.willExit(arg_27_0)
	_BackyardMsgBoxMgr = var_1_10001

	var_1_10001:Destroy()

	local var_27_0

	ipairs = _BackyardMsgBoxMgr

	for iter_27_0, iter_27_1 in var_1(arg_27_0.panels) do
		iter_27_1:Detach()
	end

	local var_27_1 = arg_27_0.emptyFoodPage

	var_1.Destroy(var_27_1)

	arg_27_0.emptyFoodPage = nil

	if arg_27_0.bulinTip then
		var_27_1 = arg_27_0.bulinTip

		var_1.Destroy(var_27_1)

		arg_27_0.bulinTip = nil
	end

	local var_27_2 = arg_27_0.contextData.mode

	CourtYardConst = var_2

	if var_27_2 ~= var_2.SYSTEM_VISIT then
		pg = var_27_2
		var_27_1 = var_27_2.m02
		var_27_2 = var_27_2.sendNotification
		GAME = iter_27_0

		var_27_2(var_27_1, iter_27_0.OPEN_ADD_EXP, 0)
	end

	getProxy = var_27_2
	DormProxy = var_27_1

	local var_27_3 = var_27_2(var_27_1)
	local var_27_4 = var_1.getRawData(var_27_3)

	var_1.ClearNewFlag(var_27_4)

	return
end

return var_0_1
