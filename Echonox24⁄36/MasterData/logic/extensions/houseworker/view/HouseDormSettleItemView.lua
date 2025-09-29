-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseDormSettleItemView.lua

module("logic.extensions.houseworker.view.HouseDormSettleItemView", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("HouseDormSettleItemView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)

	self:_buildUI()
end

function M:_buildUI()
	self._nameText = self._viewElementsRegistry:findUIElement("dorm_settled_item_-55031096", UIComponentType.Text)
	self._numText = self._viewElementsRegistry:findUIElement("dorm_settled_item_-995738979", UIComponentType.Text)
	self._headItemList = {
		self._viewElementsRegistry:findUIElement("0&hero_adjust_item_-1292290203"),
		self._viewElementsRegistry:findUIElement("1&hero_adjust_item_-1292290203"),
		self._viewElementsRegistry:findUIElement("2&hero_adjust_item_-1292290203"),
		self._viewElementsRegistry:findUIElement("3&hero_adjust_item_-1292290203")
	}
	self._headViewList = {}

	for i, headItem in ipairs(self._headItemList) do
		local headItemView = Astral.LuaComponentContainer.Add(headItem, HouseWorkHeadCell)

		headItemView:setWorkTypeShowStatus(false)
		headItemView:setCanAdd(true)
		table.insert(self._headViewList, headItemView)
	end

	self._imgSex = self._viewElementsRegistry:findUIElement("dorm_settled_item_-493526022", UIComponentType.Image)
	self._bunkNameList = {
		self._viewElementsRegistry:findUIElement("dorm_settled_item_-1860738889", UIComponentType.Text),
		self._viewElementsRegistry:findUIElement("dorm_settled_item_-79002192", UIComponentType.Text)
	}
	self._roleRootList = {
		{
			self._viewElementsRegistry:findUIElement("dorm_settled_item_2045923728"),
			self._viewElementsRegistry:findUIElement("dorm_settled_item_-1933377242").transform.parent.gameObject,
			self._viewElementsRegistry:findUIElement("0&hero_adjust_item_-1292290203")
		},
		{
			self._viewElementsRegistry:findUIElement("dorm_settled_item_192115384"),
			self._viewElementsRegistry:findUIElement("dorm_settled_item_1783158391").transform.parent.gameObject,
			self._viewElementsRegistry:findUIElement("1&hero_adjust_item_-1292290203")
		},
		{
			self._viewElementsRegistry:findUIElement("dorm_settled_item_474448314"),
			self._viewElementsRegistry:findUIElement("dorm_settled_item_1033606460").transform.parent.gameObject,
			self._viewElementsRegistry:findUIElement("dorm_settled_item_-79002192"),
			self._viewElementsRegistry:findUIElement("2&hero_adjust_item_-1292290203")
		},
		{
			self._viewElementsRegistry:findUIElement("dorm_settled_item_1724894523"),
			self._viewElementsRegistry:findUIElement("dorm_settled_item_-785874950").transform.parent.gameObject,
			self._viewElementsRegistry:findUIElement("3&hero_adjust_item_-1292290203")
		}
	}
	self._btnClick = ButtonAdapter.Get(self._viewElementsRegistry:findUIElement("dorm_settled_item_-1052536557"))

	self._btnClick:AddClickListener(self._clickSelf, self)

	self._goBunk1 = self._viewElementsRegistry:findUIElement("dorm_settled_item_1456190131")
	self._goBunk2 = self._viewElementsRegistry:findUIElement("dorm_settled_item_957067154")
	self._goSingle = self._viewElementsRegistry:findUIElement("dorm_settled_item_-1181887629")
	self._hintGo = self._viewElementsRegistry:findUIElement("dorm_settled_item_-323284922")
	self._markView = Astral.LuaComponentContainer.Add(self._hintGo, LivingFacilitiesMarkView)
end

function M:setClickListener(callback, callbackSelf)
	self._callback = callback
	self._callbackSelf = callbackSelf
end

function M:_clickSelf()
	if self._callback then
		return self._callback(self._callbackSelf, self._data)
	end
end

function M:_setEvent(add)
	return
end

function M:setCellData(data, index)
	self._data = data
	self._index = index

	self:refreshView()
	self:_setEvent(true)
end

function M:refreshView()
	self:_refreshMark()

	local bunkList = self._data:getBunkList()
	local maxRoleCount = self._data:getHeroCount()
	local currentCount = self._data:getInRoomHeroCount()

	for i, roleRoot in ipairs(self._roleRootList) do
		for j, go in ipairs(roleRoot) do
			goutil.setActive(go, i <= maxRoleCount)
		end
	end

	if maxRoleCount == 1 then
		goutil.setActive(self._roleRootList[1][1], false)
		goutil.setActive(self._roleRootList[1][2], false)
		goutil.setWidth(self._goBunk1.transform, 924)
		goutil.setActive(self._goBunk2, false)
		goutil.setActive(self._goSingle, true)
	else
		goutil.setWidth(self._goBunk1.transform, 462)
		goutil.setActive(self._goBunk2, true)
		goutil.setActive(self._goSingle, false)
	end

	RectTransformUtils.ForceRebuildLayoutImmediate(self._goBunk1.transform)

	self._numText.text = string.format("%d/%d", currentCount, maxRoleCount)
	self._nameText.text = self._data:getName()

	local bunkNameTxt = self._bunkNameList[1]
	local bunkNameStr = ""

	for i = 1, maxRoleCount do
		if i > 2 then
			bunkNameTxt = self._bunkNameList[2]
		end

		local bunkInfo = bunkList[i]

		if bunkInfo and bunkInfo.heroId > 0 then
			local heroId = bunkInfo.heroId
			local scheduleNO = HouseWorkerModel.instance:getScheduleByHeroId(heroId)
			local data = {}

			data.hero = heroId
			data.schedule = scheduleNO.schedule

			self._headViewList[i]:setVisible(true)
			self._headViewList[i]:updatePanel(data)

			bunkNameStr = bunkInfo:getFurnitureCfg().name
		elseif bunkInfo then
			self._headViewList[i]:setVisible(true)
			self._headViewList[i]:updatePanel(nil)

			bunkNameStr = bunkInfo:getFurnitureCfg().name
		else
			self._headViewList[i]:setVisible(false)

			bunkNameStr = lang("tip_no_bed_be_add")

			goutil.setActive(self._roleRootList[i][1], false)
			goutil.setActive(self._roleRootList[i][2], false)
		end

		bunkNameTxt.text = bunkNameStr
	end
end

function M:_refreshMark()
	local zoneId = self._data:getId()
	local genderMark = LivingFacilitiesZoneModel.instance:getGenderMarkCO(zoneId)
	local campMark = LivingFacilitiesZoneModel.instance:getCampMarkCO(zoneId)

	self._markView:updateData(genderMark, campMark)
end

function M:OnDestroy()
	self:_setEvent(false)
	self._btnClick:RemoveClickListener()
end

return M
