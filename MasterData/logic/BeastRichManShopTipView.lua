-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManShopTipView.lua

module("logic.extensions.beastrichman.view.BeastRichManShopTipView", package.seeall)

local BeastRichManShopTipView = class("BeastRichManShopTipView", ViewComponent)

function BeastRichManShopTipView:ctor()
	BeastRichManShopTipView.super.ctor(self)
end

function BeastRichManShopTipView:unbindEvents()
	BeastRichManShopTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function BeastRichManShopTipView:bindEvents()
	BeastRichManShopTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function BeastRichManShopTipView:buildUI()
	BeastRichManShopTipView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtContent = self:getTxt("txtContent")
	self._txtCost = self:getTxt("imgCostDiamond/txtNum")
	self._txtHas = self:getTxt("imgMyDiamond/txtNum")
	self._imgGo1 = self:getGo("imgCostDiamond/img")
	self._imgGo2 = self:getGo("imgMyDiamond/img")
end

function BeastRichManShopTipView:onExit()
	BeastRichManShopTipView.super.onExit(self)
	MaterialMgr.resetAll(self._imgGo1)
	MaterialMgr.resetAll(self._imgGo2)
end

function BeastRichManShopTipView:onEnter()
	BeastRichManShopTipView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleEventRes, self.close, self)

	self._params = self:getOpenParam() or {}
	self._activityId = checknumber(self._params[1])
	self._zoneId = checknumber(self._params[2])
	self._gridId = checknumber(self._params[3])
	self._petId = checknumber(self._params[4])
	self._cost = checknumber(self._params[5])
	self._petName = self._params[6]
	self._info = BeastRichmanModel.instance:getInfo(self._activityId)
	self._actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)

	self:_initUI()
end

function BeastRichManShopTipView:_initUI()
	if self._info then
		self._txtHas.text = self._info.score or 0
	end

	self._txtCost.text = self._cost
	self._txtContent.text = string.format("确定花费%d收益,\n招募[%s]吗?", self._cost, self._petName)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.scoreMatStr)

	MaterialMgr.setIcon(self._imgGo1, matType, matId)
	MaterialMgr.setIcon(self._imgGo2, matType, matId)
end

function BeastRichManShopTipView:_onClickBtnSure()
	local curScore = BeastRichmanModel.instance:getScore(self._activityId)

	if curScore < self._cost then
		FloatWordMgr.instance:show("所需积分不足")

		return
	end

	local param = self._petId .. ""

	BeastRichmanController.instance:sendPM_BeastRichManHandleEventReq(self._activityId, self._zoneId, self._gridId, param)
end

return BeastRichManShopTipView
