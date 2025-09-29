-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/CharacterSpineCutTestView.lua

module("logic.extensions.hacktool.view.CharacterSpineCutTestView", package.seeall)

local M = class("CharacterSpineCutTestView", ViewComponent)

function M:buildUI()
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._roleImg = self:getGo("character_detail_panel_606566779")
	self._photoUnit = PhotoUnit.Get(self._roleImg)

	self._photoUnit:clear()

	self._spineCutInput = self:getInput("characterspinecuttest_-2000187750")
	self._spineCutBtn = self:getBtn("characterspinecuttest_224043009")
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._spineCutBtn:AddClickListener(self._onClickSpineCutBtn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._spineCutBtn:RemoveClickListener()
end

function M:_onClickSpineCutBtn()
	self._modelId = tonumber(self._spineCutInput:GetText())

	self._photoUnit:showUnitLiveWholeByID(self._modelId)
	self._photoUnit:setCameraRotation(0, 0, 0)
	self._photoUnit:setCameraPosition(0, 0, -11)
end

function M:onEnter()
	self._spineCutInput:SetText(100011)

	self._modelId = self:getFirstParam()

	self._photoUnit:showUnitLiveWholeByID(self._modelId)
	self._photoUnit:setCameraRotation(0, 0, 0)
	self._photoUnit:setCameraPosition(0, 0, -11)
end

function M:onExit()
	if self._photoUnit then
		self._photoUnit:clear()
	end
end

function M:_onClickReturn()
	self:back()
end

return M
