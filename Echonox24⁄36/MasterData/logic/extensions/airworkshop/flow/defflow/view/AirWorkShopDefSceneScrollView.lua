-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefSceneScrollView.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefSceneScrollView", package.seeall)

local M = class("AirWorkShopDefSceneScrollView", ViewComponent)

function M:buildUI()
	self._tabToggleGroup = goutil.findChildComponent(self.mainGO, "down/stateEdit/tabGroup", UIComponentType.SpaceXToggleGroup)
	self._tabToggleCompList = {}

	local tabToggleGoList = Astral.GameObjectUtil.GetChildren(self._tabToggleGroup.gameObject)

	for index = 0, tabToggleGoList.Length - 1 do
		local toggleComp = tabToggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._tabToggleCompList, toggleComp)
	end

	self._scrollViewList = {}
	self._scrollViewList[1] = AirWorkShopDefSceneScrollHero.New(goutil.findChild(self.mainGO, "down/stateEdit/objRole"))
	self._scrollViewList[2] = AirWorkShopDefSceneScrollHighland.New(goutil.findChild(self.mainGO, "down/stateEdit/objHighland"))
	self._scrollViewList[3] = AirWorkShopDefSceneScrollBuilding.New(goutil.findChild(self.mainGO, "down/stateEdit/objSpecialBuild"))
	self._scrollViewList[4] = AirWorkShopDefSceneScrollMessage.New(goutil.findChild(self.mainGO, "down/stateEdit/objMessage"))
end

function M:_setEvents(add)
	if add then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_EDIT_MODE_UPDATE, self._onEditModeUpdate, self)
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_CLICK_UNIT_TO_ENTER_EDIT, self._onclickUnitToEnterEdit, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_EDIT_MODE_UPDATE, self._onEditModeUpdate, self)
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_CLICK_UNIT_TO_ENTER_EDIT, self._onclickUnitToEnterEdit, self)
	end
end

function M:onEnter()
	self:_setEvents(true)
	self._tabToggleGroup:TryActiveChildOn(self._tabToggleCompList[1], true)
end

function M:bindEvents()
	for k, v in pairs(self._tabToggleCompList) do
		v:AddListener(function(_, isOn, IsEnable)
			self:_dealScrollClick(k, isOn, IsEnable)
		end, nil)
	end
end

function M:unbindEvents()
	for k, v in pairs(self._tabToggleCompList) do
		v:RemoveListener()
	end
end

function M:_dealScrollClick(index, isOn, IsEnable)
	self._curTab = index

	if self._scrollViewList[index] then
		self._scrollViewList[index]:setVisibleAndUpdate(isOn)
	end

	if isOn then
		AirWorkShopDefSceneModel.instance:setCurTabType(self._curTab)
	end
end

function M:_onEditModeUpdate(_, editState, tab)
	if editState == AirWorkShopEnum.DefState.Edit then
		self._curTab = tab or AirWorkShopEnum.TabEnum.Hero

		self._tabToggleGroup:TryActiveChildOn(self._tabToggleCompList[self._curTab], true)
		self._scrollViewList[self._curTab]:setVisibleAndUpdate(true)
		AirWorkShopDefSceneModel.instance:setCurTabType(self._curTab)
	else
		if self._curTab then
			self._scrollViewList[self._curTab]:setVisibleAndUpdate(false)
		end

		AirWorkShopDefSceneModel.instance:setCurTabType(false)
	end
end

function M:_onclickUnitToEnterEdit(_, tab)
	self:_onEditModeUpdate(false, true, tab)
end

function M:onExit()
	self:_setEvents(false)

	for i, scrollView in pairs(self._scrollViewList) do
		scrollView:destroy()
	end
end

return M
