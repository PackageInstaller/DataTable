-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManBuildingView.lua

module("logic.extensions.beastrichman.view.BeastRichManBuildingView", package.seeall)

local BeastRichManBuildingView = class("BeastRichManBuildingView", ViewComponent)

function BeastRichManBuildingView:ctor()
	BeastRichManBuildingView.super.ctor(self)
end

function BeastRichManBuildingView:unbindEvents()
	BeastRichManBuildingView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._btnGiveUp)
	GameUtil.rmClickHandler(self._matNum)
	GameUtil.rmClickHandler(self._cardNum)
end

function BeastRichManBuildingView:bindEvents()
	BeastRichManBuildingView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickBtnLevelUp, self)
	GameUtil.addClickHandler(self._btnGiveUp, self._onClickBtnGiveUp, self)
	GameUtil.addClickHandler(self._matNum, self._onClickMatIcon, self)
	GameUtil.addClickHandler(self._cardNum, self._onClickCardIcon, self)
end

function BeastRichManBuildingView:buildUI()
	BeastRichManBuildingView.super.buildUI(self)

	self._btnClose = self:getGo("bg/btnClose")
	self._icon = self:getGo("bg/pet/mask/icon")
	self._btnLevelUp = self:getGo("btnLevelUp")
	self._btnGiveUp = self:getGo("btnGiveUp")
	self._cardNum = self:getGo("cardNum")
	self._matNum = self:getGo("matNum")
	self._txtTitle = self:getTxt("bg/txtTitle")
	self._txtCardNum = self:getTxt("cardNum/txtMatNum")
	self._matCardIcon = self:getGo("cardNum/matIcon")
	self._txtMatNum = self:getTxt("matNum/txtMatNum")
	self._matIcon = self:getGo("matNum/matIcon")
	self._btnLevelUp = self:getGo("btnLevelUp")
	self._toggleLevelUp = self:getToggle("toggleLevelUp")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BeastRichManBuildingView:onExit()
	BeastRichManBuildingView.super.onExit(self)
	uGuiUtil.clearImage(self._icon)
	MaterialMgr.clearIcon(self._matIcon)
	MaterialMgr.clearIcon(self._matCardIcon)
	self._scrollList:dispose()
end

function BeastRichManBuildingView:onEnter()
	BeastRichManBuildingView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleEventRes, self._onEventRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 558001
	end

	self._zoneId = checknumber(params[2])
	self._gridId = checknumber(params[3])
	self._bindEventUniqueId = checknumber(params[4])
	self._isCurGrid = params[5] or false
	self._actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	self._gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._gridId)

	if self._gridCfg then
		if not self._gridCfg.eventId then
			local eventId = 0

			self._eventCfg = BeastRichmanConfig.instance:getEventCfgById(self._activityId, eventId)
			self._buildId = checknumber(self._eventCfg.eventParam)
			self._eventBuildingCfgs = BeastRichmanConfig.instance:getIpairsEventBuildShowCfgsById(self._activityId, self._buildId)
			self._info = BeastRichmanModel.instance:getInfo(self._activityId)

			local zoneMap = BeastRichmanModel.instance:getZoneMap(self._activityId)
			local zone = zoneMap and zoneMap[self._zoneId]
			local state = zone and zone.state

			self._eventInfo = state and state.event
			self._isLevelUp = false

			self:_initUI()
		end
	end
end

function BeastRichManBuildingView:_initUI()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.scoreMatStr)
	local score = BeastRichmanModel.instance:getScore(self._activityId)
	local type = self._eventCfg.eventType
	local eventDescCfg = BeastRichmanConfig.instance:getEventDescCfgByType(self._activityId, type)

	if eventDescCfg then
		if not eventDescCfg.useCardId then
			local cardId = 1
			local cardNum = BeastRichmanModel.instance:getCardNum(self._activityId, cardId)
			local cardCfg = BeastRichmanConfig.instance:getCardCfg(self._activityId, cardId)
			local matStr = cardCfg.matStr
			local cardType, matCardId, matCardNum = MaterialMgr.getMatParams(matStr)
			local eventId = BeastRichmanConfig.instance:getEventIdByGridId(self._activityId, self._zoneId, self._gridId)
			local eventParam = BeastRichmanModel.instance:getEventParamByEventId(self._activityId, self._zoneId, eventId)
			local curLv = checknumber(eventParam)
			local curBuildCfg = BeastRichmanConfig.instance:getEventBuildShowCfgByLv(self._activityId, self._buildId, curLv)
			local buildId = checknumber(self._eventCfg.eventParam)
			local hasFinish = false

			if self._eventInfo then
				hasFinish = self._eventInfo.finish
			end

			self._txtMatNum.text = curBuildCfg.cost
			self._txtCardNum.text = string.format("%s", cardNum)
			self._txtTitle.text = curBuildCfg.name or ""

			MaterialMgr.setIcon(self._matIcon, matType, matId, nil, nil)
			MaterialMgr.setIcon(self._matCardIcon, cardType, matCardId, nil, nil)
			self._scrollList:reloadData(self._eventBuildingCfgs)
			GameUtil.SetGray(self._btnLevelUp, not self._isCurGrid or hasFinish)
			GameUtil.SetActive(self._btnGiveUp, self._isCurGrid and not hasFinish)

			local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
			local skinId = zoneCfg.skinId
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

			if modelCo and not string.nilorempty(modelCo.cardName) then
				local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

				uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, imgUrl)
			end

			self._toggleLevelUp.isOn = cardNum ~= 0
		end
	end
end

function BeastRichManBuildingView:_updateCell(view, cell, data)
	local isCur = goutil.findChild(cell, "isCur")
	local txtLv = goutil.findChildTextComponent(cell, "txtLv")
	local txtReward = goutil.findChildTextComponent(cell, "txtReward")
	local eventId = BeastRichmanConfig.instance:getEventIdByGridId(self._activityId, self._zoneId, self._gridId)
	local eventParam = BeastRichmanModel.instance:getEventParamByEventId(self._activityId, self._zoneId, eventId)
	local curLv = checknumber(eventParam)

	txtLv.text = string.format("%s级%s", data.level, data.name)
	txtReward.text = data.buffDesc

	GameUtil.SetActive(isCur, curLv == data.level)
end

function BeastRichManBuildingView:_clearCell(cell)
	return
end

function BeastRichManBuildingView:_onClickBtnLevelUp()
	if not self._isCurGrid then
		FloatWordMgr.instance:show("尚未触发当前事件，无法升级")

		return
	end

	if (self._eventInfo or nil) and self._eventInfo.finish and self._isCurGrid then
		FloatWordMgr.instance:show("已完成事件，无需重复完成")

		return
	end

	local eventId = BeastRichmanConfig.instance:getEventIdByGridId(self._activityId, self._zoneId, self._gridId)
	local eventParam = BeastRichmanModel.instance:getEventParamByEventId(self._activityId, self._zoneId, eventId)
	local curLv = checknumber(eventParam)
	local buildId = checknumber(self._eventCfg.eventParam)
	local buildCfgs = BeastRichmanConfig.instance:getEventBuildShowCfgsById(self._activityId, buildId)
	local isMaxLv = curLv >= #buildCfgs

	if isMaxLv then
		FloatWordMgr.instance:show("已升级到最高级,无需升级")

		return
	end

	local buildCfg = BeastRichmanConfig.instance:getEventBuildShowCfgByLv(self._activityId, buildId, curLv)

	if buildCfg then
		if not buildCfg.cost then
			local cost = 0
			local score = BeastRichmanModel.instance:getScore(self._activityId)
			local type = self._eventCfg.eventType
			local eventDescCfg = BeastRichmanConfig.instance:getEventDescCfgByType(self._activityId, type)

			if eventDescCfg then
				if not eventDescCfg.useCardId then
					local cardId = 1
					local hasCard = BeastRichmanModel.instance:getCardNum(self._activityId, cardId)

					if cost > 0 and score < cost and not hasCard then
						FloatWordMgr.instance:show("积分不足，无法升级")

						return
					end

					self._isLevelUp = true

					local tb = {
						levelUp = true,
						useCard = self._toggleLevelUp.isOn
					}
					local param = GameUtil.jsonToString(tb)

					BeastRichmanController.instance:sendPM_BeastRichManHandleEventReq(self._activityId, self._zoneId, self._gridId, param)
				end
			end
		end
	end
end

function BeastRichManBuildingView:_onClickBtnGiveUp()
	if (self._eventInfo or nil) and self._eventInfo.finish and self._isCurGrid then
		FloatWordMgr.instance:show("已完成事件，无需重复完成")

		return
	end

	local tb = {
		useCard = false,
		levelUp = false
	}
	local param = GameUtil.jsonToString(tb)

	BeastRichmanController.instance:sendPM_BeastRichManHandleEventReq(self._activityId, self._zoneId, self._gridId, param)
end

function BeastRichManBuildingView:_onClickMatIcon()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.scoreMatStr)

	CommonTipsMgr.instance:openMaterialTips(self._matNum, matType, matId, matNum)
end

function BeastRichManBuildingView:_onClickCardIcon()
	local type = self._eventCfg.eventType
	local eventDescCfg = BeastRichmanConfig.instance:getEventDescCfgByType(self._activityId, type)

	if eventDescCfg then
		if not eventDescCfg.useCardId then
			local cardId = 1
			local cardNum = BeastRichmanModel.instance:getCardNum(self._activityId, cardId)
			local cardCfg = BeastRichmanConfig.instance:getCardCfg(self._activityId, cardId)
			local matStr = cardCfg.matStr
			local cardType, matCardId, cardNum = MaterialMgr.getMatParams(matStr)

			CommonTipsMgr.instance:openMaterialTips(self._cardNum, cardType, matCardId, cardNum)
		end
	end
end

function BeastRichManBuildingView:_onEventRes()
	if self._isLevelUp then
		FloatWordMgr.instance:show("升级成功，每次落脚仅可升级1次")
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManBuildingLevelUp, self._bindEventUniqueId)
	end

	self:close()
end

return BeastRichManBuildingView
