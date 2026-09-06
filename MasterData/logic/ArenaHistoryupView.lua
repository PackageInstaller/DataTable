-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaHistoryupView.lua

module("logic.extensions.arena.view.ArenaHistoryupView", package.seeall)

local ArenaHistoryupView = class("ArenaHistoryupView", ViewComponent)

function ArenaHistoryupView:ctor()
	ArenaHistoryupView.super.ctor(self)
end

function ArenaHistoryupView:destroyUI()
	ArenaHistoryupView.super.destroyUI(self)
end

function ArenaHistoryupView:onExitFinished()
	ArenaHistoryupView.super.onExitFinished(self)
end

function ArenaHistoryupView:onEnterFinished()
	ArenaHistoryupView.super.onEnterFinished(self)
end

function ArenaHistoryupView:unbindEvents()
	ArenaHistoryupView.super.unbindEvents(self)
	self.closeButton:RemoveClickListener()
	self.sureBtn:RemoveClickListener()
end

function ArenaHistoryupView:bindEvents()
	ArenaHistoryupView.super.bindEvents(self)
	self.closeButton:AddClickListener(self.onClickClose, self)
	self.sureBtn:AddClickListener(self.onClickClose, self)
end

function ArenaHistoryupView:onExit()
	ArenaHistoryupView.super.onExit(self)
end

function ArenaHistoryupView:buildUI()
	ArenaHistoryupView.super.buildUI(self)

	self.closeButton = self:getBtn("btnClose")
	self.sureBtn = self:getBtn("btnSure")
	self.currRank = goutil.findChildTextComponent(self.mainGO, "currRank")
	self.preRank = goutil.findChildTextComponent(self.mainGO, "preRank")
	self.desText = goutil.findChildTextComponent(self.mainGO, "desText")
	self.numText = goutil.findChildTextComponent(self.mainGO, "numText")
end

function ArenaHistoryupView:onEnter()
	ArenaHistoryupView.super.onEnter(self)

	local data = ArenaModel.instance:getUpPositionData()

	if data then
		local preRankNum = data.preRank
		local currRankNum = data.currRank

		self.currRank.text = currRankNum
		self.preRank.text = preRankNum
		self.desText.text = "排名提升了<color=#3e81cc> " .. preRankNum - currRankNum .. "</color> 名"
		self.numText.text = "<color=#3e81cc>" .. (data.diamond or 0) .. "</color>"
	end

	ArenaModel.instance:resetUpPositionData()
end

function ArenaHistoryupView:onClickClose()
	self:close()
end

return ArenaHistoryupView
