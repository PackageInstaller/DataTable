-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManPayMoneyView.lua

module("logic.extensions.beastrichman.view.BeastRichManPayMoneyView", package.seeall)

local BeastRichManPayMoneyView = class("BeastRichManPayMoneyView", ViewComponent)

function BeastRichManPayMoneyView:ctor()
	BeastRichManPayMoneyView.super.ctor(self)
end

function BeastRichManPayMoneyView:unbindEvents()
	BeastRichManPayMoneyView.super.unbindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._matNum)
end

function BeastRichManPayMoneyView:bindEvents()
	BeastRichManPayMoneyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._matNum, self._onClickMatNum, self)
end

function BeastRichManPayMoneyView:buildUI()
	BeastRichManPayMoneyView.super.buildUI(self)

	self._btnClose = self:getGo("bg/btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtTip = self:getTxt("tip/txtTip")
	self._matNum = self:getGo("matNum")
	self._matIcon = self:getGo("matNum/matIcon")
	self._txtMatNum = self:getTxt("matNum/txtMatNum")
	self._toggleNoPay = self:getToggle("toggleNoPay")
	self._icon = self:getGo("bg/pet/mask/icon")
end

function BeastRichManPayMoneyView:onExit()
	BeastRichManPayMoneyView.super.onExit(self)
	MaterialMgr.clearIcon(self._matIcon)
	uGuiUtil.clearImage(self._icon)
end

function BeastRichManPayMoneyView:onEnter()
	BeastRichManPayMoneyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleEventRes, self._onHandleEventRes, self)
	self.addGEvent(self, GlobalNotify.BeastRichManScoreChangeRes, self._updateUI, self)

	self._params = self:getOpenParam()
	self._activityId = checknumber(self._params[1])
	self._zoneId = checknumber(self._params[2])
	self._gridId = checknumber(self._params[3])
	self._isCurGrid = self._params[4]

	local zoneMap = BeastRichmanModel.instance:getZoneMap(self._activityId)
	local zone = zoneMap and zoneMap[self._zoneId]
	local state = zone and zone.state

	self._eventInfo = state and state.event
	self._zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
	self._gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._gridId)

	local eventId = checknumber(self._gridCfg.eventId)
	local eventCfg = BeastRichmanConfig.instance:getEventCfgById(self._activityId, eventId)
	local type = eventCfg.eventType

	self._eventDescCfg = BeastRichmanConfig.instance:getEventDescCfgByType(self._activityId, type)

	self:_updateUI()
end

function BeastRichManPayMoneyView:_updateUI()
	self._info = BeastRichmanModel.instance:getInfo(self._activityId)

	local cardNum = 0

	if self._isCurGrid then
		local score = BeastRichmanModel.instance:getScore(self._activityId)
		local percentNum = checknumber(self._eventInfo.param)
		local getBenefit = math.ceil(score * percentNum / 100)
		local curName = self._zoneCfg.name
		local descStr = string.format(self._eventDescCfg.descInPos, percentNum, getBenefit, curName)
		local cardId = self._eventDescCfg.useCardId
		local cardNum = BeastRichmanModel.instance:getCardNum(self._activityId, cardId)
		local cardCfg = BeastRichmanConfig.instance:getCardCfg(self._activityId, cardId)

		self._txtTip.text = descStr
		self._txtMatNum.text = cardNum

		local matStr = cardCfg and cardCfg.matStr
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

		MaterialMgr.setIcon(self._matIcon, matType, matId, nil, nil)
	else
		self._txtTip.text = self._eventDescCfg.descOutsidePos
	end

	self._toggleNoPay.isOn = cardNum > 0

	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
	local skinId = zoneCfg.skinId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	GameUtil.SetActive(self._btnSure, self._isCurGrid)
	GameUtil.SetActive(self._toggleNoPay, self._isCurGrid)
	GameUtil.SetActive(self._matNum, self._isCurGrid)
end

function BeastRichManPayMoneyView:_onClickBtnSure()
	if (self._eventInfo or nil) and self._eventInfo.finish and self._isCurGrid then
		FloatWordMgr.instance:show("已完成事件，无需重复完成")

		return
	end

	if self._toggleNoPay.isOn then
		local cardId = self._eventDescCfg.useCardId
		local cardNum = BeastRichmanModel.instance:getCardNum(self._activityId, cardId)

		if cardNum < 1 then
			FloatWordMgr.instance:show("您没有足够的道具，无法完成事件")

			return
		end
	end

	local param = tostring(self._toggleNoPay.isOn)

	BeastRichmanController.instance:sendPM_BeastRichManHandleEventReq(self._activityId, self._zoneId, self._gridId, param)
end

function BeastRichManPayMoneyView:_onClickMatNum()
	local cardId = self._eventDescCfg.useCardId
	local cardCfg = BeastRichmanConfig.instance:getCardCfg(self._activityId, cardId)
	local matStr = cardCfg and cardCfg.matStr

	TipsFacade.instance:openItemSourceView(matStr)
end

function BeastRichManPayMoneyView:_onHandleEventRes()
	FloatWordMgr.instance:show("成功完成税局事件")
	self:close()
end

return BeastRichManPayMoneyView
