-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManGameSelectView.lua

module("logic.extensions.beastrichman.view.BeastRichManGameSelectView", package.seeall)

local BeastRichManGameSelectView = class("BeastRichManGameSelectView", ViewComponent)

function BeastRichManGameSelectView:ctor()
	BeastRichManGameSelectView.super.ctor(self)
end

function BeastRichManGameSelectView:unbindEvents()
	BeastRichManGameSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPlay)
	GameUtil.rmClickHandler(self._btnOneKeyPass)
	GameUtil.rmClickHandler(self._btnYearCard)
end

function BeastRichManGameSelectView:bindEvents()
	BeastRichManGameSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPlay, self._onBtnPlay, self)
	GameUtil.addClickHandler(self._btnOneKeyPass, self._onBtnOneKeyPass, self)
	GameUtil.addClickHandler(self._btnYearCard, self._onBtnYearCard, self)
end

function BeastRichManGameSelectView:buildUI()
	BeastRichManGameSelectView.super.buildUI(self)

	self._btnClose = self:getGo("bg/btnClose")
	self._icon = self:getGo("bg/pet/mask/icon")
	self._btnPlay = self:getGo("btnPlay")
	self._btnOneKeyPass = self:getGo("btnOneKeyPass")
	self._btnYearCard = self:getGo("btnYearCard")
	self._imgGame = self:getGo("game/imgGame")
	self._txtCost = self:getTxt("cost/txtCost")
end

function BeastRichManGameSelectView:onEnter()
	BeastRichManGameSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleGridRes, self._onHandleGridRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 558001
	end

	self._zoneId = checknumber(params[2])
	self._gridId = checknumber(params[3])
	self._gameId = checknumber(params[4])
	self._actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	self._gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._gridId)

	local id = checknumber(self._gridCfg.gridParam)

	self._gameTypeCfg = BeastRichmanConfig.instance:getGridGameTypeCfgById(self._activityId, self._gameId)
	self._gamePrizeCfgs = BeastRichmanConfig.instance:getGridGamePrizeCfgsById(self._activityId, self._gameId)
	self._diamondCostNum = self._actCfg.oneKeyPassGameCostNum

	self:_initUI()
end

function BeastRichManGameSelectView:_initUI()
	self._txtCost.text = string.format("消耗%s钻石", self._diamondCostNum)

	local gamePath = string.format("ui/bigbg/views/game/beastrichmangame/%s.png", self._gameTypeCfg.gameImgName)

	uGuiUtil.setSpriteToImage(self._imgGame, uGuiUtil.SpriteType.BigBg, gamePath)

	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
	local skinId = zoneCfg.skinId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, imgUrl)
	end
end

function BeastRichManGameSelectView:onExit()
	BeastRichManGameSelectView.super.onExit(self)
	uGuiUtil.clearImage(self._imgGame)
	uGuiUtil.clearImage(self._icon)
end

function BeastRichManGameSelectView:_onBtnPlay()
	local viewName = self._gameTypeCfg.jumpViewName

	if viewName then
		UIStateManager.instance:push(viewName, self._activityId, self._zoneId, self._gridId)
	end

	self:close()
end

function BeastRichManGameSelectView:_onBtnOneKeyPass()
	local content = string.format("是否使用%s钻石进行扫荡？", self._diamondCostNum)

	TipsFacade.instance:openPopupCostDiamondView(self._diamondCostNum, content, GameUtil.handler(self._sweepGame, self, false, true))
end

function BeastRichManGameSelectView:_onBtnYearCard()
	local isInitInfo = YearCardModel.instance:isInitInfo()

	if not isInitInfo then
		FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

		return
	end

	local nowActId = YearCardConfig.instance:getNextActId()

	if not YearCardModel.instance:isActiveAnnuity(nowActId) then
		FloatWordMgr.instance:show("当前不是26年年费，无法使用年费特权一键扫荡")

		return
	end

	local tipsContent = "是否使用年费特权进行扫荡？"

	TipsFacade.instance:openPopupWindow("提示", tipsContent, GameUtil.handler(self._sweepGame, self, true, false), nil, "确定", "取消")
end

function BeastRichManGameSelectView:_onHandleGridRes()
	FloatWordMgr.instance:show("扫荡成功！")
	BeastRichmanController.instance:tryPopCurScore(self._activityId)
	self:close()
end

function BeastRichManGameSelectView:_sweepGame(isAnnual, isOneKey)
	local values = table.values(self._gamePrizeCfgs)

	table.sort(values, function(a, b)
		return a.score < b.score
	end)

	local prizeCfgLen = #values

	if prizeCfgLen > 0 then
		local prizeCfg = values[prizeCfgLen]

		if prizeCfg then
			if not prizeCfg.score then
				local totalScore = 0
				local tb = {
					score = totalScore,
					onekey = isOneKey,
					annual = isAnnual
				}
				local param = GameUtil.jsonToString(tb)

				BeastRichmanController.instance:sendPM_BeastRichManHandleGridReq(self._activityId, self._zoneId, self._gridId, param)
			end
		end
	end
end

return BeastRichManGameSelectView
