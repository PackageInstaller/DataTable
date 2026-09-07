local IslandCheaterTavernPrepareMainPage = class("IslandCheaterTavernPrepareMainPage", import("...base.IslandBasePage"))

IslandCheaterTavernPrepareMainPage.OPEN_SELECT_SHIP = "IslandCheaterTavernPrepareMainPage:OPEN_SELECT_SHIP"

local var_0_1 = {
	"UICamera/Canvas/UIMain/IslandCheatBarEntranceUI(Clone)",
	"OverlayCamera/Overlay/UIMain/IslandPlayRoomMainUI(Clone)",
	"UICamera/Canvas/UIOrigin/IslandPlayRoomMainUI(Clone)"
}

function IslandCheaterTavernPrepareMainPage:AddListeners()
	self:AddListener(CheaterTavernEvent.OPEN_SELECT_SHIP, self.OpenShipSelectPage)
	self:AddListener(ISLAND_EVT.SUB_PAGE_OPEN, self.OnOpenSubPage)
	self:AddListener(ISLAND_EVT.SUB_PAGE_CLOSE, self.OnCloseSubPage)
	self:AddListener(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, self.OnLoadSceneRoom)

	return
end

function IslandCheaterTavernPrepareMainPage:RemoveListeners()
	self:RemoveListener(CheaterTavernEvent.OPEN_SELECT_SHIP, self.OpenShipSelectPage)
	self:RemoveListener(ISLAND_EVT.SUB_PAGE_OPEN, self.OnOpenSubPage)
	self:RemoveListener(ISLAND_EVT.SUB_PAGE_CLOSE, self.OnCloseSubPage)
	self:RemoveListener(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, self.OnLoadSceneRoom)

	return
end

function IslandCheaterTavernPrepareMainPage:getUIName()
	return "IslandEmptyUI"
end

function IslandCheaterTavernPrepareMainPage:NeedCache()
	return false
end

function IslandCheaterTavernPrepareMainPage:OnEnable()
	self:LoadChildSubPage(IslandCheaterTavernDisplayPage)

	return
end

function IslandCheaterTavernPrepareMainPage:OnDisable()
	self.subPageStack = {}

	return
end

function IslandCheaterTavernPrepareMainPage:HandleUIDisplay(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(var_0_1) do
		local var_7_0 = GameObject.Find(iter_7_1)

		if not IsNil(var_7_0) then
			setActive(var_7_0, arg_7_1)
		end
	end

	return
end

function IslandCheaterTavernPrepareMainPage:OnOpenSubPage(arg_8_1)
	if arg_8_1 == "IslandCheaterShipSelectMainPage" or arg_8_1 == "IslandCheaterTavernPlayRoomInfoPage" then
		self:HandleUIDisplay(false)
	end

	return
end

function IslandCheaterTavernPrepareMainPage:OnCloseSubPage(arg_9_1)
	if not table.contains({
		"IslandCheaterShipSelectMainPage",
		"IslandCheaterTavernPlayRoomInfoPage",
		"IslandCheaterTavernDisplayPage"
	}, arg_9_1) then
		return
	end

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(self.subPageStack) do
		if iter_9_1.__cname == arg_9_1 then
			var_9_0 = iter_9_0
		end
	end

	if var_9_0 ~= 0 then
		table.remove(self.subPageStack, var_9_0)
	end

	if var_9_0 > 1 then
		local var_9_1 = self.subPageStack[var_9_0 - 1]

		if self.subPageStack[var_9_0 - 1].__cname == "IslandCheaterTavernPlayRoomInfoPage" then
			self:OpenPage(var_9_1, IslandCheaterTavernConst.SceneRoomType.CustomRoom)
		else
			self:OpenPage(var_9_1)
		end

		self.pageClass = var_9_1

		self:HandleUIDisplay(true)
	else
		self:Hide()
	end

	return
end

function IslandCheaterTavernPrepareMainPage:LoadChildSubPage(arg_10_1, arg_10_2)
	if self.pageClass then
		pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_11_0)
			self:DestorySubPage(self.pageClass)

			self.pageClass = nil
			self.pageClass = arg_10_1

			self:OpenPage(self.pageClass, arg_10_2)
			table.insert(self.subPageStack, arg_10_1)
			arg_11_0()

			return
		end)

		return
	end

	self.pageClass = arg_10_1

	self:OpenPage(self.pageClass, arg_10_2)
	table.insert(self.subPageStack, arg_10_1)

	return
end

function IslandCheaterTavernPrepareMainPage:OnLoadSceneRoom(arg_12_1)
	self:emit(CheaterTavernEvent.CLOSE_SHIP_SELECT_PAGE)
	self:LoadChildSubPage(IslandCheaterTavernPlayRoomInfoPage, arg_12_1)

	return
end

function IslandCheaterTavernPrepareMainPage:OpenShipSelectPage(arg_13_1)
	self.changeDressType = arg_13_1

	self:LoadChildSubPage(IslandCheaterShipSelectMainPage, arg_13_1)

	return
end

function IslandCheaterTavernPrepareMainPage:OnShow(arg_14_1, arg_14_2, arg_14_3)
	self.subPageStack = {}

	if arg_14_1 then
		self:LoadChildSubPage(IslandCheaterTavernPlayRoomInfoPage, arg_14_2)
	else
		self:LoadChildSubPage(IslandCheaterTavernDisplayPage)
	end

	if arg_14_3 then
		arg_14_3()
	end

	return
end

function IslandCheaterTavernPrepareMainPage:OnExit()
	if not self.exit then
		self:emitCore(CheaterTavernEvent.CLOSE_PREPARE_MAIN_PAGE)
	end

	self.exit = true

	return
end

return IslandCheaterTavernPrepareMainPage
