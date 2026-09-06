-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleSpecialRuleView.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleSpecialRuleView", package.seeall)

local CampScuffleSpecialRuleView = class("CampScuffleSpecialRuleView", ViewComponent)

function CampScuffleSpecialRuleView:ctor()
	CampScuffleSpecialRuleView.super.ctor(self)
end

function CampScuffleSpecialRuleView:buildUI()
	CampScuffleSpecialRuleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnL = self:getBtn("btnL")
	self._btnR = self:getBtn("btnR")
	self._imgRule = self:getGo("imgRule")
end

function CampScuffleSpecialRuleView:bindEvents()
	CampScuffleSpecialRuleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnL:AddClickListener(self._onClickLeft, self)
	self._btnR:AddClickListener(self._onClickRight, self)
end

function CampScuffleSpecialRuleView:unbindEvents()
	CampScuffleSpecialRuleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnL:RemoveClickListener()
	self._btnR:RemoveClickListener()
end

function CampScuffleSpecialRuleView:onEnter()
	CampScuffleSpecialRuleView.super.onEnter(self)

	self._iconPathList = CampScuffleSpecialRuleViewPresentor.IconPath
	self._curPage = 1

	goutil.setActive(self._btnL.gameObject, false)
	goutil.setActive(self._btnR.gameObject, true)
	uGuiUtil.setSpriteToImage(self._imgRule, uGuiUtil.SpriteType.BigBg, self._iconPathList[self._curPage])
end

function CampScuffleSpecialRuleView:onExit()
	CampScuffleSpecialRuleView.super.onExit(self)
end

function CampScuffleSpecialRuleView:_onClickClose()
	self:close()
end

function CampScuffleSpecialRuleView:_onClickLeft()
	if self._curPage == 2 then
		self._curPage = 1

		goutil.setActive(self._btnL.gameObject, false)
		goutil.setActive(self._btnR.gameObject, true)
		uGuiUtil.setSpriteToImage(self._imgRule, uGuiUtil.SpriteType.BigBg, self._iconPathList[self._curPage])
	else
		goutil.setActive(self._btnL.gameObject, false)
		goutil.setActive(self._btnR.gameObject, true)
	end
end

function CampScuffleSpecialRuleView:_onClickRight()
	if self._curPage == 1 then
		self._curPage = 2

		goutil.setActive(self._btnL.gameObject, true)
		goutil.setActive(self._btnR.gameObject, false)
		uGuiUtil.setSpriteToImage(self._imgRule, uGuiUtil.SpriteType.BigBg, self._iconPathList[self._curPage])
	else
		goutil.setActive(self._btnL.gameObject, true)
		goutil.setActive(self._btnR.gameObject, false)
	end
end

return CampScuffleSpecialRuleView
