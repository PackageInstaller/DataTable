-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManBankView.lua

module("logic.extensions.beastrichman.view.BeastRichManBankView", package.seeall)

local BeastRichManBankView = class("BeastRichManBankView", ViewComponent)

function BeastRichManBankView:ctor()
	BeastRichManBankView.super.ctor(self)
end

function BeastRichManBankView:unbindEvents()
	BeastRichManBankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._coin)
	GameUtil.rmClickHandler(self._btnGain)
	self._btnGiveUp:RemoveClickListener()
end

function BeastRichManBankView:bindEvents()
	BeastRichManBankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._coin, self._onClickCoin, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickBtnGain, self)
	self._btnGiveUp:AddClickListener(self._onClickbtnGiveUp, self)
end

function BeastRichManBankView:buildUI()
	BeastRichManBankView.super.buildUI(self)

	self._coin = self:getGo("coin")
	self._txtNumCoin = self:getTxt("coin/txtNum")
	self._iconCoin = self:getGo("coin/icon")
	self._btnClose = self:getGo("bg/btnClose")
	self._btnGain = self:getGo("btnGain")
	self._icon = self:getGo("bg/pet/mask/icon")
	self._txtGainTip = self:getTxt("gainTip/txtTip")
	self._tip = self:getGo("tip")
	self._txtTip = self:getTxt("tip/txtTip")
	self._finishTip = self:getGo("finishTip")
	self._txtFinishTip = self:getTxt("finishTip/txtTip")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnGiveUp = self:getBtn("btnGiveUp")
end

function BeastRichManBankView:onExit()
	BeastRichManBankView.super.onExit(self)
	self._scrollList:dispose()
	uGuiUtil.clearImage(self._icon)
	MaterialMgr.clearIcon(self._iconCoin)
end

function BeastRichManBankView:onEnter()
	BeastRichManBankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleEventRes, self._onHandleEventRes, self)

	self._params = self:getOpenParam()
	self._activityId = checknumber(self._params[1])
	self._zoneId = checknumber(self._params[2])
	self._gridId = checknumber(self._params[3])
	self._isCurGrid = self._params[4]

	local zoneMap = BeastRichmanModel.instance:getZoneMap(self._activityId)
	local zone = zoneMap and zoneMap[self._zoneId]
	local state = zone and zone.state

	self._eventInfo = state and state.event
	self._selectIdx = 0
	self._actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	self._zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
	self._gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._gridId)

	local eventId = checknumber(self._gridCfg.eventId)

	self._eventCfg = BeastRichmanConfig.instance:getEventCfgById(self._activityId, eventId)
	self._eventDescCfg = BeastRichmanConfig.instance:getEventDescCfgByType(self._activityId, self._eventCfg.eventType)
	self._bankId = checknumber(self._eventCfg.eventParam)
	self._eventBankCfg = BeastRichmanConfig.instance:getEventBankCfgById(self._activityId, self._bankId)

	self:_initUI()
end

function BeastRichManBankView:_initUI()
	self._info = BeastRichmanModel.instance:getInfo(self._activityId)

	local hasFinish = false

	if self._eventInfo and self._isCurGrid then
		hasFinish = checkbool(self._eventInfo.finish)
		self._hasFinishEvent = hasFinish
	end

	if not self._zoneCfg.name then
		local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
		local skinId = zoneCfg.skinId
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

		if modelCo and not string.nilorempty(modelCo.cardName) then
			local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

			uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, imgUrl)
		end

		local scoreMatStr = self._actCfg.scoreMatStr
		local matType, matId, matNum = MaterialMgr.getMatParams(scoreMatStr)

		MaterialMgr.setIcon(self._iconCoin, matType, matId, nil, nil)

		self._txtNumCoin.text = BeastRichmanModel.instance:getScore(self._activityId)

		local eventId = checknumber(self._gridCfg.eventId)
		local eventParam = BeastRichmanModel.instance:getEventParamByEventId(self._activityId, self._zoneId, eventId)

		self._hasGiveMoney = not string.nilorempty(eventParam) and self._isCurGrid

		local descStr = ""

		if self._isCurGrid and not hasFinish and not self._hasGiveMoney then
			local benefitStr = BeastRichmanConfig.instance:getBankBenefitDesc(self._activityId, self._bankId)

			descStr = string.format(self._eventDescCfg.descInPos)
		else
			descStr = string.format(self._eventDescCfg.descOutsidePos)
		end

		self._txtFinishTip.text = self._hasGiveMoney and "恭喜你，投资成功！\n点击领取后，下次再落脚到钱庄，可以再次触发投资事件哦" or "已完成本次投资，下一次\n再落脚钱庄即可知晓投资结果！"

		self._scrollList:reloadData(self._eventBankCfg.investment)
		GameUtil.SetActive(self._btnGain, self._hasGiveMoney and not hasFinish and self._isCurGrid)
		GameUtil.SetActive(self._tableview, not self._hasGiveMoney and not hasFinish and self._isCurGrid)
		GameUtil.SetActive(self._tip, not self._hasGiveMoney and not hasFinish)
		GameUtil.SetActive(self._finishTip, self._hasGiveMoney and self._isCurGrid)
		GameUtil.SetActive(self._btnGiveUp, not hasFinish and not self._hasGiveMoney and self._isCurGrid)

		self._txtTip.text = descStr
	end
end

function BeastRichManBankView:_updateCell(view, cell, data)
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local txtSelect = goutil.findChildTextComponent(cell, "txtSelect")

	txtSelect.text = data > 0 and string.format("投%d", data) or "我不投"

	GameUtil.addClickHandler(btnSelect, function()
		if (self._eventInfo or nil) and self._eventInfo.finish then
			FloatWordMgr.instance:show("已完成事件，无需重复完成")

			return
		end

		local curScore = BeastRichmanModel.instance:getScore(self._activityId)

		if curScore < data then
			FloatWordMgr.instance:show("积分不足，无法投资")

			return
		end

		BeastRichmanController.instance:sendPM_BeastRichManHandleEventReq(self._activityId, self._zoneId, self._gridId, (data > 0 or nil) and tostring(data))
	end, self)
end

function BeastRichManBankView:_clearCell(cell)
	local btnSelect = goutil.findChild(cell, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function BeastRichManBankView:_onHandleEventRes()
	if self._hasGiveMoney then
		BeastRichmanController.instance:tryPopCurScore(self._activityId)

		self._hasFinishEvent = true
	else
		GameUtil.SetActive(self._tip, false)
		GameUtil.SetActive(self._finishTip, true)
		GameUtil.SetActive(self._tableview, false)
		GameUtil.SetActive(self._btnGiveUp, false)
	end
end

function BeastRichManBankView:_onClickbtnGiveUp()
	local param = "-1"

	BeastRichmanController.instance:sendPM_BeastRichManHandleEventReq(self._activityId, self._zoneId, self._gridId, param)
end

function BeastRichManBankView:_onClickCoin()
	local matstr = self._actCfg.scoreMatStr

	TipsFacade.instance:openItemSourceView(matstr)
end

function BeastRichManBankView:_onClickBtnGain()
	if self._hasFinishEvent then
		FloatWordMgr.instance:show("已领取，无需重复领取")

		return
	end

	local param = ""

	BeastRichmanController.instance:sendPM_BeastRichManHandleEventReq(self._activityId, self._zoneId, self._gridId, param)
end

return BeastRichManBankView
