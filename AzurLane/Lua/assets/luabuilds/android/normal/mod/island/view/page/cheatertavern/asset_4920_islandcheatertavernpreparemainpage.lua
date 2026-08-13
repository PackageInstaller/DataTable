class = var_0_10000

local var_0_0 = "IslandCheaterTavernPrepareMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

var_0_1.OPEN_SELECT_SHIP = "IslandCheaterTavernPrepareMainPage:OPEN_SELECT_SHIP"

local var_0_2 = {
	"UICamera/Canvas/UIMain/IslandCheatBarEntranceUI(Clone)",
	"OverlayCamera/Overlay/UIMain/IslandPlayRoomMainUI(Clone)",
	"UICamera/Canvas/UIOrigin/IslandPlayRoomMainUI(Clone)"
}

function var_0_1.AddListeners(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.AddListener

	CheaterTavernEvent = var_1_10003

	var_1_1(var_1_0, var_1_10003.OPEN_SELECT_SHIP, arg_1_0.OpenShipSelectPage)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.AddListener

	ISLAND_EVT = var_3

	var_1_3(var_1_2, var_3.SUB_PAGE_OPEN, arg_1_0.OnOpenSubPage)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.AddListener

	ISLAND_EVT = var_3

	var_1_5(var_1_4, var_3.SUB_PAGE_CLOSE, arg_1_0.OnCloseSubPage)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.AddListener

	CheaterTavernEvent = var_3

	var_1_7(var_1_6, var_3.PLAY_ROOM_LOAD_ROOM_SCENE, arg_1_0.OnLoadSceneRoom)

	return
end

function var_0_1.RemoveListeners(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.RemoveListener

	CheaterTavernEvent = var_1_10003

	var_2_1(var_2_0, var_1_10003.OPEN_SELECT_SHIP, arg_2_0.OpenShipSelectPage)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.RemoveListener

	ISLAND_EVT = var_3

	var_2_3(var_2_2, var_3.SUB_PAGE_OPEN, arg_2_0.OnOpenSubPage)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.RemoveListener

	ISLAND_EVT = var_3

	var_2_5(var_2_4, var_3.SUB_PAGE_CLOSE, arg_2_0.OnCloseSubPage)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.RemoveListener

	CheaterTavernEvent = var_3

	var_2_7(var_2_6, var_3.PLAY_ROOM_LOAD_ROOM_SCENE, arg_2_0.OnLoadSceneRoom)

	return
end

function var_0_1.getUIName(arg_3_0)
	return "IslandEmptyUI"
end

function var_0_1.NeedCache(arg_4_0)
	return false
end

function var_0_1.OnEnable(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.LoadChildSubPage

	IslandCheaterTavernDisplayPage = var_1_10003

	var_5_1(var_5_0, var_1_10003)

	return
end

function var_0_1.OnDisable(arg_6_0)
	arg_6_0.subPageStack = {}

	return
end

function var_0_1.HandleUIDisplay(arg_7_0, arg_7_1)
	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(var_0_2) do
		GameObject = var_1_10007
		var_1_10007 = var_1_10007.Find(iter_7_1)
		IsNil = var_8

		if not var_8(var_1_10007) then
			setActive = var_8

			var_8(var_1_10007, arg_7_1)
		end
	end

	return
end

function var_0_1.OnOpenSubPage(arg_8_0, arg_8_1)
	if arg_8_1 == "IslandCheaterShipSelectMainPage" or arg_8_1 == "IslandCheaterTavernPlayRoomInfoPage" then
		arg_8_0:HandleUIDisplay(false)
	end

	return
end

function var_0_1.OnCloseSubPage(arg_9_0, arg_9_1)
	local var_9_0 = {
		"IslandCheaterShipSelectMainPage",
		"IslandCheaterTavernPlayRoomInfoPage",
		"IslandCheaterTavernDisplayPage"
	}

	table = var_1_10003

	if not var_1_10003.contains(var_9_0, arg_9_1) then
		return
	end

	local var_9_1 = 0

	ipairs = var_4

	for iter_9_0, iter_9_1 in var_4(arg_9_0.subPageStack) do
		if iter_9_1.__cname == arg_9_1 then
			var_9_1 = iter_9_0
		end
	end

	if var_9_1 ~= 0 then
		table = var_4

		var_4.remove(arg_9_0.subPageStack, var_9_1)
	end

	if var_9_1 > 1 then
		local var_9_2 = var_9_1 - 1

		if arg_9_0.subPageStack[var_9_2].__cname == "IslandCheaterTavernPlayRoomInfoPage" then
			local var_9_3 = arg_9_0
			local var_9_4 = arg_9_0.OpenPage
			local var_9_5 = var_5

			IslandCheaterTavernConst = var_1_10009

			var_9_4(var_9_3, var_9_5, var_1_10009.SceneRoomType.CustomRoom)
		else
			arg_9_0:OpenPage(var_5)
		end

		arg_9_0.pageClass = var_5

		arg_9_0:HandleUIDisplay(true)
	else
		arg_9_0:Hide()
	end

	return
end

function var_0_1.LoadChildSubPage(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.pageClass then
		pg = var_3

		local var_10_0 = var_3.SceneAnimMgr.GetInstance()

		var_3.CommonSceneChange(var_10_0, "Dorm3DLoading", function(arg_11_0)
			local var_11_0 = arg_10_0

			var_1.DestorySubPage(var_11_0, arg_10_0.pageClass)

			arg_10_0.pageClass = nil
			arg_10_0.pageClass = arg_10_1

			local var_11_1 = arg_10_0

			var_1.OpenPage(var_11_1, arg_10_0.pageClass, arg_10_2)

			table = var_1

			var_1.insert(arg_10_0.subPageStack, arg_10_1)
			arg_11_0()

			return
		end)

		return
	end

	arg_10_0.pageClass = arg_10_1

	arg_10_0:OpenPage(arg_10_0.pageClass, arg_10_2)

	table = var_3

	var_3.insert(arg_10_0.subPageStack, arg_10_1)

	return
end

function var_0_1.OnLoadSceneRoom(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.emit

	CheaterTavernEvent = var_1_10004

	var_12_1(var_12_0, var_1_10004.CLOSE_SHIP_SELECT_PAGE)

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.LoadChildSubPage

	IslandCheaterTavernPlayRoomInfoPage = var_4

	var_12_3(var_12_2, var_4, arg_12_1)

	return
end

function var_0_1.OpenShipSelectPage(arg_13_0, arg_13_1)
	arg_13_0.changeDressType = arg_13_1

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.LoadChildSubPage

	IslandCheaterShipSelectMainPage = var_1_10004

	var_13_1(var_13_0, var_1_10004, arg_13_1)

	return
end

function var_0_1.OnShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.subPageStack = {}

	if arg_14_1 then
		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.LoadChildSubPage

		IslandCheaterTavernPlayRoomInfoPage = var_1_10006

		var_14_1(var_14_0, var_1_10006, arg_14_2)
	else
		local var_14_2 = arg_14_0
		local var_14_3 = arg_14_0.LoadChildSubPage

		IslandCheaterTavernDisplayPage = var_1_10006

		var_14_3(var_14_2, var_1_10006)
	end

	if arg_14_3 then
		arg_14_3()
	end

	return
end

function var_0_1.OnExit(arg_15_0)
	if not arg_15_0.exit then
		local var_15_0 = arg_15_0
		local var_15_1 = arg_15_0.emitCore

		CheaterTavernEvent = var_1_10003

		var_15_1(var_15_0, var_1_10003.CLOSE_PREPARE_MAIN_PAGE)
	end

	arg_15_0.exit = true

	return
end

return var_0_1
