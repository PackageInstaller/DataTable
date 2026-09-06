-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamrewardView.lua

module("logic.extensions.aceteam.view.AceteamrewardView", package.seeall)

local AceteamrewardView = class("AceteamrewardView", ViewComponent)
local PageEnum = {
	Rank = 1,
	Basics = 2
}

function AceteamrewardView:ctor()
	AceteamrewardView.super.ctor(self)

	self._rankSubView = AceteamRankSubView.New()
end

function AceteamrewardView:buildUI()
	AceteamrewardView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")

	self._rankSubView:buildUI(self:getGo("rank"))

	self._goBasics = self:getGo("basics")
	self._btnRank = self:getBtn("btns/btnRank")
	self._btnBasics = self:getBtn("btns/btnBasics")
	self._txtRuleDesc = self:getTxt("basics/txtMask/txtRule")
	self._txtRuleTitle = goutil.findChildTextComponent(self.mainGO, "basics/title/text")
end

function AceteamrewardView:bindEvents()
	AceteamrewardView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._rankSubView:bindEvents()
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnBasics:AddClickListener(self._onClickBasics, self)

	self._changeRank = self._btnRank:GetComponent(typeof(UIChangeGroup))
	self._changeBasics = self._btnBasics:GetComponent(typeof(UIChangeGroup))
end

function AceteamrewardView:unbindEvents()
	AceteamrewardView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._rankSubView:unbindEvents()
	self._btnRank:RemoveClickListener()
	self._btnBasics:RemoveClickListener()
end

function AceteamrewardView:onEnter()
	AceteamrewardView.super.onEnter(self)
	self._rankSubView:onEnter()
	self:_setTxtRule()
	self:_changeTab(PageEnum.Rank)
end

function AceteamrewardView:onExit()
	AceteamrewardView.super.onExit(self)
	self._rankSubView:onExit()
end

function AceteamrewardView:_onClickClose()
	self:close()
end

function AceteamrewardView:_onClickRank()
	self:_changeTab(PageEnum.Rank)
end

function AceteamrewardView:_onClickBasics()
	self:_changeTab(PageEnum.Basics)
end

function AceteamrewardView:_changeTab(enum)
	self._changeRank:SetState(enum == PageEnum.Rank and 1 or 0)
	self._changeBasics:SetState(enum == PageEnum.Basics and 1 or 0)

	if enum == PageEnum.Rank then
		self._rankSubView:show()
		self:_hideBasics()
	else
		self._rankSubView:hide()
		self:_showBasics()
	end
end

function AceteamrewardView:_showBasics()
	self._goBasics:SetActive(true)
end

function AceteamrewardView:_hideBasics()
	self._goBasics:SetActive(false)
end

function AceteamrewardView:_setTxtRule()
	self._txtRuleTitle.text = AceTeamConfig.instance:getCommonValue("PRIZE_RULE_TITLE")
	self._txtRuleDesc.text = AceTeamConfig.instance:getCommonValue("PRIZE_RULE_DESC")
end

return AceteamrewardView
