-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanuniversaldiceView.lua

module("logic.extensions.beastrichman.view.BeastrichmanuniversaldiceView", package.seeall)

local BeastrichmanuniversaldiceView = class("BeastrichmanuniversaldiceView", ViewComponent)

function BeastrichmanuniversaldiceView:buildUI()
	BeastrichmanuniversaldiceView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._choseCells = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("choseCells/cell_" .. i)
		cell.select = goutil.findChild(cell.go, "select")

		local change = cell.go:GetComponent(ComponentType.UIImageSpriteChange)

		change:SetState(i - 1)

		self._choseCells[i] = cell
	end
end

function BeastrichmanuniversaldiceView:bindEvents()
	BeastrichmanuniversaldiceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)

	for i = 1, 6 do
		GameUtil.addClickHandler(self._choseCells[i].go, GameUtil.handler(self._onClickChoseCell, self, i))
	end
end

function BeastrichmanuniversaldiceView:unbindEvents()
	BeastrichmanuniversaldiceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)

	for i = 1, 4 do
		GameUtil.rmClickHandler(self._choseCells[i].go)
	end
end

function BeastrichmanuniversaldiceView:onEnter()
	BeastrichmanuniversaldiceView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManMoveRes, self.close, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])
	self._curSelectId = 0

	self:_onClickChoseCell(1)
end

function BeastrichmanuniversaldiceView:onExit()
	BeastrichmanuniversaldiceView.super.onExit(self)
end

function BeastrichmanuniversaldiceView:_onClickSure()
	if self._curSelectId == 0 then
		FloatWordMgr.instance:show(lang("请选择一个点数"))

		return
	end

	BeastRichmanController.instance:sendPM_BeastRichManMoveReq(self._activityId, self._zoneId, BeastRichManEnum.DiceType.Fix, tostring(self._curSelectId))
end

function BeastrichmanuniversaldiceView:_onClickChoseCell(id)
	self._curSelectId = id

	for i = 1, 6 do
		goutil.setActive(self._choseCells[i].select, self._curSelectId == i)
	end
end

return BeastrichmanuniversaldiceView
