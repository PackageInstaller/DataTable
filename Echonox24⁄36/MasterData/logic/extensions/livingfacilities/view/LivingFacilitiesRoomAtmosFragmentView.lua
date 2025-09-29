-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesRoomAtmosFragmentView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesRoomAtmosFragmentView", package.seeall)

local M = class("LivingFacilitiesRoomAtmosFragmentView", StaticFragmentView)

function M:ctor(mainGO, viewPresentor)
	M.super.ctor(self, mainGO)

	self._viewPresentor = viewPresentor
end

function M:buildUI()
	self._txtProgress = self:getText("atmosphere_value_tips_-1367649186")
	self._fillProgress = self:getImage("atmosphere_value_tips_-1464879206")
	self._txtLevel = self:getText("atmosphere_value_tips_-742818853")
	self._scrollGo = self:getGo("atmosphere_value_tips_-1776993331")
	self._loopList = LoopListHelper.New(self._scrollGo)

	self._loopList:InitListView(0, self._updateCell, self)

	self._headIconList = {
		self:getImage("atmosphere_value_tips_-1021281864"),
		self:getImage("atmosphere_value_tips_-875302400"),
		self:getImage("atmosphere_value_tips_-1480634029"),
		self:getImage("atmosphere_value_tips_-1751202110")
	}
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
	self._scrollGo = nil
	self._txtProgress = nil
	self._fillProgress = nil
	self._txtLevel = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._atmosList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosDorm)

	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	self._currentLevel = zoneMo:getAtmosphereLevel()
	self._txtLevel.text = self._currentLevel

	if self._currentLevel < #self._atmosList then
		local currentMaxAtmosNum = self._atmosList[self._currentLevel + 1].rankNum

		self._txtProgress.text = string.format("%s/%s", zoneMo:getAtmosphere(), currentMaxAtmosNum)
		self._fillProgress.fillAmount = math.min(1, zoneMo:getAtmosphere() / currentMaxAtmosNum)
	else
		self._txtProgress.text = string.format("%s/MAX", zoneMo:getAtmosphere())
		self._fillProgress.fillAmount = 1
	end

	self._loopList:SetListItemCount(#self._atmosList, true)

	for i, headIcon in ipairs(self._headIconList) do
		goutil.setActive(headIcon.gameObject, false)
	end

	local memberList = zoneMo:getRoomMember()

	for i, member in ipairs(memberList) do
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(member)

		if heroMO then
			local modelCO = heroMO:getModelCo()

			IconLoader.setSprite(self._headIconList[i], IconType.HeadIcon, modelCO.headIconName)
			goutil.setActive(self._headIconList[i].gameObject, true)
		end
	end
end

function M:onExit()
	self._loopList:ClearCells()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("atmosphere_item")
	local AtmosInfo = self._atmosList[curIndex]
	local txtAtmos = goutil.findChildTextComponent(item, "txtNum1")
	local txtMood = goutil.findChildTextComponent(item, "txtNum2")
	local txtLevel = goutil.findChildTextComponent(item, "txtValue")

	txtAtmos.text = AtmosInfo.rankNum

	local moodRecover = AtmosInfo.moodRecover * 60

	txtMood.text = string.format("%.1f/h", moodRecover - moodRecover % 0.1)
	txtLevel.text = AtmosInfo.level

	local select = goutil.findChild(item, "select")

	goutil.setActive(select, curIndex == self._currentLevel)

	return item
end

return M
