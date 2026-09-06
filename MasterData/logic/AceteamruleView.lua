-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamruleView.lua

module("logic.extensions.aceteam.view.AceteamruleView", package.seeall)

local AceteamruleView = class("AceteamruleView", ViewComponent)

function AceteamruleView:ctor()
	AceteamruleView.super.ctor(self)
end

function AceteamruleView:buildUI()
	AceteamruleView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._tabBtn1 = self:getBtn("tabLeft/tabBtn1")
	self._tabBtn2 = self:getBtn("tabLeft/tabBtn2")
	self._tabBg1 = self:getGo("tabLeft/tabBtn1/tabBg")
	self._tabBg2 = self:getGo("tabLeft/tabBtn2/tabBg")
	self._colorChange1 = self:getGo("tabLeft/tabBtn1/txtTab"):GetComponent(typeof(UITextColorChange))
	self._colorChange2 = self:getGo("tabLeft/tabBtn2/txtTab"):GetComponent(typeof(UITextColorChange))
	self._baseRule = self:getGo("baseRule")
	self._levelRule = self:getGo("levelRule")
	self._txtBaseRule = self:getTxt("baseRule/txtscrollContent/viewport/content/txtBaseRule")
end

function AceteamruleView:bindEvents()
	AceteamruleView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._tabBtn1:AddClickListener(self._onClickTab1, self)
	self._tabBtn2:AddClickListener(self._onClickTab2, self)
end

function AceteamruleView:unbindEvents()
	AceteamruleView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._tabBtn1:RemoveClickListener()
	self._tabBtn2:RemoveClickListener()
end

function AceteamruleView:onExit()
	AceteamruleView.super.onExit(self)
	GameUtil.callBack(self.callBack)

	self.callBack = nil
end

function AceteamruleView:onEnter()
	AceteamruleView.super.onEnter(self)
	self:_setRuleDesc()
	self:_changeTab(1)

	self.callBack = self:getFirstParam()
end

function AceteamruleView:_onClickClose()
	self:close()
end

function AceteamruleView:_onClickTab1()
	self:_changeTab(1)
end

function AceteamruleView:_onClickTab2()
	self:_changeTab(2)
end

function AceteamruleView:_changeTab(index)
	self._tabBg1:SetActive(index == 1)
	self._tabBg2:SetActive(index == 2)
	self._colorChange1:SetState(index == 1 and 1 or 0)
	self._colorChange2:SetState(index == 2 and 1 or 0)
	self._baseRule:SetActive(index == 1)
	self._levelRule:SetActive(index == 2)
end

function AceteamruleView:_setRuleDesc()
	self._txtBaseRule.text = lang("aceteamruleview__1")
end

return AceteamruleView
