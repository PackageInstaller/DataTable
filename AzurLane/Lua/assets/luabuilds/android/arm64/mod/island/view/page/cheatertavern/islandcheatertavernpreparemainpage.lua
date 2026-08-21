local var_0_0 = class("IslandCheaterTavernPrepareMainPage", import("...base.IslandBasePage"))

var_0_0.OPEN_SELECT_SHIP = "IslandCheaterTavernPrepareMainPage:OPEN_SELECT_SHIP"

local var_0_1 = {
	"UICamera/Canvas/UIMain/IslandCheatBarEntranceUI(Clone)",
	"OverlayCamera/Overlay/UIMain/IslandPlayRoomMainUI(Clone)",
	"UICamera/Canvas/UIOrigin/IslandPlayRoomMainUI(Clone)"
}

function var_0_0.AddListeners(arg_1_0)
	arg_1_0:AddListener(CheaterTavernEvent.OPEN_SELECT_SHIP, arg_1_0.OpenShipSelectPage)
	arg_1_0:AddListener(ISLAND_EVT.SUB_PAGE_OPEN, arg_1_0.OnOpenSubPage)
	arg_1_0:AddListener(ISLAND_EVT.SUB_PAGE_CLOSE, arg_1_0.OnCloseSubPage)
	arg_1_0:AddListener(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, arg_1_0.OnLoadSceneRoom)

	return
end

function var_0_0.RemoveListeners(arg_2_0)
	arg_2_0:RemoveListener(CheaterTavernEvent.OPEN_SELECT_SHIP, arg_2_0.OpenShipSelectPage)
	arg_2_0:RemoveListener(ISLAND_EVT.SUB_PAGE_OPEN, arg_2_0.OnOpenSubPage)
	arg_2_0:RemoveListener(ISLAND_EVT.SUB_PAGE_CLOSE, arg_2_0.OnCloseSubPage)
	arg_2_0:RemoveListener(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, arg_2_0.OnLoadSceneRoom)

	return
end

function var_0_0.getUIName(arg_3_0)
	return "IslandEmptyUI"
end

function var_0_0.NeedCache(arg_4_0)
	return false
end

function var_0_0.OnEnable(arg_5_0)
	arg_5_0:LoadChildSubPage(IslandCheaterTavernDisplayPage)

	return
end

function var_0_0.OnDisable(arg_6_0)
	arg_6_0.subPageStack = {}

	return
end

function var_0_0.HandleUIDisplay(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(var_0_1) do
		local var_7_0 = GameObject.Find(iter_7_1)

		if not IsNil(var_7_0) then
			setActive(var_7_0, arg_7_1)
		end
	end

	return
end

function var_0_0.OnOpenSubPage(arg_8_0, arg_8_1)
	if arg_8_1 == "IslandCheaterShipSelectMainPage" or arg_8_1 == "IslandCheaterTavernPlayRoomInfoPage" then
		arg_8_0:HandleUIDisplay(false)
	end

	return
end

function var_0_0.OnCloseSubPage(arg_9_0, arg_9_1)
	if not table.contains({
		"IslandCheaterShipSelectMainPage",
		"IslandCheaterTavernPlayRoomInfoPage",
		"IslandCheaterTavernDisplayPage"
	}, arg_9_1) then
		return
	end

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.subPageStack) do
		if iter_9_1.__cname == arg_9_1 then
			var_9_0 = iter_9_0
		end
	end

	if var_9_0 ~= 0 then
		table.remove(arg_9_0.subPageStack, var_9_0)
	end

	if var_9_0 > 1 then
		local var_9_1 = arg_9_0.subPageStack[var_9_0 - 1]

		if arg_9_0.subPageStack[var_9_0 - 1].__cname == "IslandCheaterTavernPlayRoomInfoPage" then
			arg_9_0:OpenPage(var_9_1, IslandCheaterTavernConst.SceneRoomType.CustomRoom)
		else
			arg_9_0:OpenPage(var_9_1)
		end

		arg_9_0.pageClass = var_9_1

		arg_9_0:HandleUIDisplay(true)
	else
		arg_9_0:Hide()
	end

	return
end

function var_0_0.LoadChildSubPage(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.pageClass then
		pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_11_0)
			arg_10_0:DestorySubPage(arg_10_0.pageClass)

			arg_10_0.pageClass = nil
			arg_10_0.pageClass = arg_10_1

			arg_10_0:OpenPage(arg_10_0.pageClass, arg_10_2)
			table.insert(arg_10_0.subPageStack, arg_10_1)
			arg_11_0()

			return
		end)

		return
	end

	arg_10_0.pageClass = arg_10_1

	arg_10_0:OpenPage(arg_10_0.pageClass, arg_10_2)
	table.insert(arg_10_0.subPageStack, arg_10_1)

	return
end

function var_0_0.OnLoadSceneRoom(arg_12_0, arg_12_1)
	arg_12_0:emit(CheaterTavernEvent.CLOSE_SHIP_SELECT_PAGE)
	arg_12_0:LoadChildSubPage(IslandCheaterTavernPlayRoomInfoPage, arg_12_1)

	return
end

function var_0_0.OpenShipSelectPage(arg_13_0, arg_13_1)
	arg_13_0.changeDressType = arg_13_1

	arg_13_0:LoadChildSubPage(IslandCheaterShipSelectMainPage, arg_13_1)

	return
end

function var_0_0.OnShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.subPageStack = {}

	if arg_14_1 then
		arg_14_0:LoadChildSubPage(IslandCheaterTavernPlayRoomInfoPage, arg_14_2)
	else
		arg_14_0:LoadChildSubPage(IslandCheaterTavernDisplayPage)
	end

	if arg_14_3 then
		arg_14_3()
	end

	return
end

function var_0_0.OnExit(arg_15_0)
	if not arg_15_0.exit then
		arg_15_0:emitCore(CheaterTavernEvent.CLOSE_PREPARE_MAIN_PAGE)
	end

	arg_15_0.exit = true

	return
end

return var_0_0
