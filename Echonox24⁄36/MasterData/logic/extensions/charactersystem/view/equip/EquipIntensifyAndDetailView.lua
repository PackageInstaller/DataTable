-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipIntensifyAndDetailView.lua

module("logic.extensions.charactersystem.view.equip.EquipIntensifyAndDetailView", package.seeall)

local M = class("EquipIntensifyAndDetailView", ViewComponent)

function M:buildUI()
	self._txtTitle = self:getTextByPath("title_view/layout/btnReturn_1/txtTitle")
	self._qualityGos = {}
	self._qualityGos[GameEnum.QualityEnum.B] = goutil.findChild(self.mainGO, "quality_group_bottom/qulaityB")
	self._qualityGos[GameEnum.QualityEnum.A] = goutil.findChild(self.mainGO, "quality_group_bottom/qulaityA")
	self._qualityGos[GameEnum.QualityEnum.S] = goutil.findChild(self.mainGO, "quality_group_bottom/qulaityS")
	self._goImgLight = goutil.findChild(self.mainGO, "quality_group_bottom/imgLight")
	self._tabBarList = {}

	local goTab = self:getGo("6&left_tab_content_-205429629")

	for i = 1, 2 do
		local tab = goutil.findChild(goTab, "tab_" .. i)
		local toggleComp = tab:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._tabBarList, toggleComp)
	end

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("6&left_tab_content_-399612422"), LeftTabComp)
	self._goDetailView = self:getGo("equip_function_view_-1932746450")
	self._goIntensifyView = self:getGo("equip_function_view_-1756182817")
	self._goBtnExplain = self:getGo("title_view_-636449388")

	goutil.setActive(self._goBtnExplain, false)
end

function M:bindEvents()
	for index, toggleComp in ipairs(self._tabBarList) do
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(index)
			end
		end, nil)
	end
end

function M:unbindEvents()
	for _, toggleComp in ipairs(self._tabBarList) do
		toggleComp:RemoveListener()
	end
end

function M:onEnter()
	self._tabComp:onEnter()

	local openParam = self:getOpenParam()
	local tabIndex = 1

	self._equipmentData = EquipIntensifyController.instance:getOperatingEquip()

	if openParam and openParam[1] then
		tabIndex = openParam[1]
	end

	if openParam and openParam[2] then
		self._equipmentData = openParam[2]
	end

	if not self._equipmentData then
		return
	end

	if self._tabBarList[tabIndex].IsOn then
		self:_dealToggleClick(tabIndex)
	else
		self._tabBarList[tabIndex].IsOn = true
	end

	self:_refreshQuality()
end

function M:onEnterFinished()
	return
end

function M:onExit()
	self._tabComp:onExit()

	self._curTabIndex = nil
end

function M:_dealToggleClick(index)
	local samePage = self._curTabIndex and self._curTabIndex == index

	self._tabComp:MoveSelectMark(index, samePage and 0 or 0.3)

	if self._curTabIndex and self._curTabIndex == index then
		return
	end

	self._curTabIndex = index

	goutil.setActive(self._goDetailView, self._curTabIndex == EquipEnum.IntensifyViewPage.Detail)
	goutil.setActive(self._goIntensifyView, self._curTabIndex == EquipEnum.IntensifyViewPage.Intensify)

	local name = index == EquipEnum.IntensifyViewPage.Intensify and lang("tip_euqip_title_intensify") or lang("tip_euqip_title_detail")

	self._txtTitle.text = name

	GlobalDispatcher:dispatchEvent(EventType.EQUIP_INTESIFY_DETAIL_UPDATE, self._equipmentData, self._curTabIndex)
end

function M:_refreshQuality()
	local quality = self._equipmentData:getQuality()
	local isShow = false

	for k, v in pairs(self._qualityGos) do
		goutil.setActive(v, k == quality)

		if k == quality then
			isShow = true
		end
	end

	goutil.setActive(self._goImgLight, isShow)
end

return M
