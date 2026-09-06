-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManEventCell.lua

module("logic.extensions.beastrichman.view.BeastRichManEventCell", package.seeall)

local BeastRichManEventCell = class("BeastRichManEventCell", BeastRichManBaseCell)

function BeastRichManEventCell:init(activityId, zoneId, eventId, bindEventUniqueId, offsetPosX, offsetPosY)
	self._eventId = eventId
	self._bindEventUniqueId = bindEventUniqueId
	self._eventCfg = BeastRichmanConfig.instance:getEventCfgById(activityId, eventId)
	self._eventType = self._eventCfg.eventType

	BeastRichManEventCell.super.init(self, activityId, zoneId, bindEventUniqueId, offsetPosX, offsetPosY)
end

function BeastRichManEventCell:_initUI()
	BeastRichManEventCell.super._initUI(self)

	local eventGo = self:getNodeGo("event")

	if eventGo then
		if self._eventType == BeastRichManEnum.EventType.Build then
			self:_setBuildUI()
		else
			local imgGo = goutil.findChild(eventGo, "btnEvent/img")

			GameUtil.SetActive(imgGo, true)

			self._changeSpriteComp = imgGo:GetComponent(ComponentType.UIImageSpriteChange)

			self._changeSpriteComp:SetState(self._eventType)
		end

		self._btnEvent = goutil.findChild(eventGo, "btnEvent")
		self._eventTipsGo = goutil.findChild(eventGo, "eventtips")

		goutil.setActive(self._eventTipsGo, false)
		GameUtil.addClickHandler(self._btnEvent, function()
			local activityId = self._activityId
			local zoneId = self._zoneId
			local curPathCellHasFinish = BeastRichmanController.instance:curPathCellHasFinish(activityId, zoneId)

			if not curPathCellHasFinish then
				FloatWordMgr.instance:show("尚未完成格子事件,请完成后再点击")

				return
			end

			self:trickCell()
		end, self)

		self._canvasGroup = self._btnEvent:GetComponent(ComponentType.CanvasGroup)
		self._eventTips = goutil.findChildTextComponent(eventGo, "eventtips/txt")

		if self._eventType == BeastRichManEnum.EventType.PayMoney then
			self._eventTips.text = "纳税"
		elseif self._eventType == BeastRichManEnum.EventType.Shop then
			self._eventTips.text = "购买"
		elseif self._eventType == BeastRichManEnum.EventType.Wheel then
			self._eventTips.text = "抽奖"
		elseif self._eventType == BeastRichManEnum.EventType.Bank then
			self._eventTips.text = "投资"
		end
	end

	self:updateUI()
end

function BeastRichManEventCell:_setBuildUI()
	local eventGo = self:getNodeGo("event")
	local imgBook1 = goutil.findChild(eventGo, "btnEvent/imgBook1")
	local imgBook2 = goutil.findChild(eventGo, "btnEvent/imgBook2")
	local imgStore1 = goutil.findChild(eventGo, "btnEvent/imgStore1")
	local imgStore2 = goutil.findChild(eventGo, "btnEvent/imgStore2")
	local eventParam = self._eventCfg.eventParam
	local buildId = checknumber(eventParam)
	local buildCfg = BeastRichmanConfig.instance:getEventBuildShowCfgByLv(self._activityId, buildId, 0)
	local buildType = buildCfg.buildType

	GameUtil.SetActive(imgStore1, buildType == BeastRichManEnum.BuildingType.Store)
	GameUtil.SetActive(imgStore2, buildType == BeastRichManEnum.BuildingType.Store)
	GameUtil.SetActive(imgBook1, buildType == BeastRichManEnum.BuildingType.BookShop)
	GameUtil.SetActive(imgBook2, buildType == BeastRichManEnum.BuildingType.BookShop)

	if buildType == BeastRichManEnum.BuildingType.Store then
		self._spriteChangeComp = imgStore2:GetComponent(ComponentType.UIImageSpriteChange)
		self._buildNorGo = imgStore1
		self._buildLevelGo = imgStore2
	else
		self._spriteChangeComp = imgBook2:GetComponent(ComponentType.UIImageSpriteChange)
		self._buildNorGo = imgBook1
		self._buildLevelGo = imgBook2
	end
end

function BeastRichManEventCell:setImageAlpha(alpha)
	if not self._canvasGroup then
		return
	end

	self._canvasGroup.alpha = alpha
end

function BeastRichManEventCell:_updateBuildUI(showTips)
	local gridId = BeastRichmanConfig.instance:eventUniqueId2PathGridId(self._activityId, self._zoneId, self._bindEventUniqueId)
	local eventId = BeastRichmanConfig.instance:getEventIdByGridId(self._activityId, self._zoneId, gridId)
	local eventParam = BeastRichmanModel.instance:getEventParamByEventId(self._activityId, self._zoneId, eventId)
	local curLv = checknumber(eventParam)

	if curLv > 0 then
		self._spriteChangeComp:SetState(curLv - 1)
	end

	goutil.setActive(self._buildNorGo, curLv == 0)
	goutil.setActive(self._buildLevelGo, curLv > 0)

	if showTips and self._eventType == BeastRichManEnum.EventType.Build then
		local eventCfg = BeastRichmanConfig.instance:getEventCfgById(self._activityId, eventId)
		local id = checknumber(eventCfg.eventParam)
		local nextBuildCfg = BeastRichmanConfig.instance:getEventBuildShowCfgByLv(self._activityId, id, curLv + 1)

		self._eventTips.text = nextBuildCfg and nextBuildCfg.level and "升级" or "已满级"
	end
end

function BeastRichManEventCell:trickCell()
	local activityId = self._activityId
	local zoneId = self._zoneId
	local curPlayerGridId = BeastRichmanModel.instance:getCurManGridId(activityId, zoneId)
	local eventId = self._eventId
	local isCurGrid = false

	if curPlayerGridId > 0 then
		local gridCfg = BeastRichmanConfig.instance:getGridCfgById(activityId, zoneId, curPlayerGridId)

		isCurGrid = eventId == gridCfg.eventId
	end

	local gridId = BeastRichmanConfig.instance:eventUniqueId2PathGridId(activityId, zoneId, self._bindEventUniqueId)

	if isCurGrid then
		gridId = curPlayerGridId
	end

	local eventType = self._eventType

	if eventType == BeastRichManEnum.EventType.Build then
		UIStateManager.instance:push(ViewName.BeastRichManBuildingView, activityId, zoneId, gridId, self._bindEventUniqueId, isCurGrid)
	elseif eventType == BeastRichManEnum.EventType.PayMoney then
		UIStateManager.instance:push(ViewName.BeastRichManPayMoneyView, activityId, zoneId, gridId, isCurGrid)
	elseif eventType == BeastRichManEnum.EventType.Shop then
		UIStateManager.instance:push(ViewName.BeastRichManShopView, activityId, zoneId, gridId, isCurGrid)
	elseif eventType == BeastRichManEnum.EventType.Wheel then
		UIStateManager.instance:push(ViewName.BeastRichManLotteryView, activityId, zoneId, gridId, isCurGrid)
	elseif eventType == BeastRichManEnum.EventType.Bank then
		UIStateManager.instance:push(ViewName.BeastRichManBankView, activityId, zoneId, gridId, isCurGrid)
	end
end

function BeastRichManEventCell:clearCell()
	GameUtil.rmClickHandler(self._btnEvent)
end

function BeastRichManEventCell:updateUI()
	if not self._eventTipsGo then
		return
	end

	local isFinish = BeastRichmanController.instance:curEventHasFinish(self._activityId, self._zoneId)
	local show = false

	if not isFinish then
		local playerGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)
		local gridCfg = BeastRichmanConfig.instance:getGridCfgById(self._activityId, self._zoneId, playerGridId)

		show = gridCfg and gridCfg.bindEventUniqueId == self._bindEventUniqueId
	end

	if self._eventType == BeastRichManEnum.EventType.Build then
		self:_updateBuildUI(show)
	end

	goutil.setActive(self._eventTipsGo, show)
end

return BeastRichManEventCell
