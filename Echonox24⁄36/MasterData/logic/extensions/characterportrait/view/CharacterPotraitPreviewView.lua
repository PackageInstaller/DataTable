-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterportrait/view/CharacterPotraitPreviewView.lua

module("logic.extensions.characterportrait.view.CharacterPotraitPreviewView", package.seeall)

local M = class("CharacterPotraitPreviewView", ViewComponent)

function M:buildUI()
	self._bg = self:getBigBg("0&backgroup_tips_-133694467")
	self._nameTxt = self:getText("0&backgroup_tips_-252807684")
	self._detailTxt = self:getText("0&backgroup_tips_1022656570")
	self._closeBtn = self:getBtn("backgroup_preview_757679680")
end

function M:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._closeBtn:RemoveClickListener()
end

function M:_onClickClose()
	self:close()
end

function M:onEnter()
	local info = self:getFirstParam()

	self._bgId = info.baseData

	self:_refreshView()
end

function M:_refreshView()
	local bgCO = BackpackConfig.instance:getItemInfoByItemId(self._bgId)

	self._nameTxt.text = bgCO.name
	self._detailTxt.text = bgCO.desc

	self._bg:SetImage(string.format("ui/bigbg/charactersystem/background/%d_1.png", self._bgId), nil, self)
end

function M:onExit()
	self._bg:ClearImage()
end

return M
