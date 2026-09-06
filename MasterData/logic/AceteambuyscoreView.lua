-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteambuyscoreView.lua

module("logic.extensions.aceteam.view.AceteambuyscoreView", package.seeall)

local AceteambuyscoreView = class("AceteambuyscoreView", ViewComponent)

function AceteambuyscoreView:ctor()
	AceteambuyscoreView.super.ctor(self)
end

function AceteambuyscoreView:unbindEvents()
	AceteambuyscoreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnOK)
	GameUtil.rmClickHandler(self.btnReduce)
	GameUtil.rmClickHandler(self.btnAdd)
	GameUtil.rmClickHandler(self.btnReduceTen)
	GameUtil.rmClickHandler(self.btnAddTen)
	GameUtil.rmClickHandler(self.btnMin)
	GameUtil.rmClickHandler(self.btnMax)
	self._procNumText:RemoveOnValueChanged()
end

function AceteambuyscoreView:bindEvents()
	AceteambuyscoreView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnOK, self.onOk, self)
	GameUtil.addClickHandler(self.btnReduce, self.onReduce, self)
	GameUtil.addClickHandler(self.btnAdd, self.onAdd, self)
	GameUtil.addClickHandler(self.btnReduceTen, self.onReduceTen, self)
	GameUtil.addClickHandler(self.btnAddTen, self.onAddTen, self)
	GameUtil.addClickHandler(self.btnMin, self.onMin, self)
	GameUtil.addClickHandler(self.btnMax, self.onMax, self)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
end

function AceteambuyscoreView:buildUI()
	AceteambuyscoreView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnOK = self:getGo("btnOK")
	self.btnReduce = self:getGo("btn/btnReduce")
	self.btnAdd = self:getGo("btn/btnAdd")
	self.btnReduceTen = self:getGo("btn/btnReduceTen")
	self.btnAddTen = self:getGo("btn/btnAddTen")
	self.btnMin = self:getGo("btn/btnMin")
	self.btnMax = self:getGo("btn/btnMax")
	self.item1 = self:getGo("item1")
	self.item2 = self:getGo("item2")
	self._procNumText = self:getInput("input")
	self.iconCost = self:getGo("txtCost/icon")
	self.iconHas = self:getGo("txtHave/icon")
	self.txtCost = self:getTxt("txtCost/txtNum")
	self.txtHave = self:getTxt("txtHave/txtNum")
	self.txtTips = self:getTxt("txtTips")
	self.txtRemain = self:getTxt("txtRemain")
end

function AceteambuyscoreView:onExit()
	AceteambuyscoreView.super.onExit(self)
	MaterialMgr.resetAll(self.item1)
	MaterialMgr.resetAll(self.item2)
	MaterialMgr.clearIcon(self.iconCost)
	MaterialMgr.clearIcon(self.iconHas)
end

function AceteambuyscoreView:onEnter()
	AceteambuyscoreView.super.onEnter(self)

	local params = self:getOpenParam()

	self.sourceItem = params[1]
	self.targetItem = params[2]
	self.sourceCost = checknumber(params[3])
	self.targetGet = checknumber(params[4])
	self._lastNum = 1
	self._numMax = checknumber(params[5])
	self.callBack = params[7]
	self.txtRemain.text = params[6]
	self.matType, self.matId = MaterialMgr.getMatParams(self.sourceItem)

	local na1 = MaterialMgr.getMaterialsNameByCfg(self.sourceItem)
	local na2 = MaterialMgr.getMaterialsNameByCfg(self.targetItem)

	self.txtTips.text = langPara("%s%s = %s%s", self.sourceCost, na1, self.targetGet, na2)

	local proxy = MaterialMgr.setCellByCfg(self.sourceItem, self.item1)

	if proxy then
		proxy.binder:setNum(0)
	end

	local proxy = MaterialMgr.setCellByCfg(self.targetItem, self.item2)

	if proxy then
		proxy.binder:setNum(0)
	end

	MaterialMgr.updateItemByStr(self.iconCost, self.sourceItem)
	MaterialMgr.updateItemByStr(self.iconHas, self.sourceItem)
	self:_chargeNum(self._lastNum)
end

function AceteambuyscoreView:_onValueChanged(strNum)
	local num = checkint(strNum)

	self:_chargeNum(num)
end

function AceteambuyscoreView:_chargeNum(inputNum)
	local newNum = checkint(inputNum)

	newNum = Mathf.Clamp(newNum, 0, self._numMax)
	self._lastNum = newNum

	local text = self._procNumText:GetText()

	if text ~= tostring(newNum) then
		self._procNumText:SetText(tostring(self._lastNum))
	end

	self.costNum = self.sourceCost * self._lastNum
	self.txtCost.text = self.costNum
	self.txtHave.text = MaterialMgr.getMatCount(self.sourceItem)
end

function AceteambuyscoreView:onOk()
	self:close()

	if not MaterialFacade.instance:checkMatEnough(self.matType, self.matId, self.costNum) then
		return
	end

	GameUtil.callBack(self.callBack, self._lastNum)
end

function AceteambuyscoreView:onReduce()
	local num = checkint(self._lastNum) - 1

	self:_chargeNum(num)
end

function AceteambuyscoreView:onAdd()
	local num = checkint(self._lastNum) + 1

	self:_chargeNum(num)
end

function AceteambuyscoreView:onReduceTen()
	local num = checkint(self._lastNum) - 10

	self:_chargeNum(num)
end

function AceteambuyscoreView:onAddTen()
	local num = checkint(self._lastNum) + 10

	self:_chargeNum(num)
end

function AceteambuyscoreView:onMin()
	self:_chargeNum(1)
end

function AceteambuyscoreView:onMax()
	self:_chargeNum(self._numMax)
end

return AceteambuyscoreView
