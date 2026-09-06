-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaytipsView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaytipsView", package.seeall)

local BirthdaytipsView = class("BirthdaytipsView", ViewComponent)

function BirthdaytipsView:ctor()
	BirthdaytipsView.super.ctor(self)
end

function BirthdaytipsView:unbindEvents()
	BirthdaytipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnCopy)
end

function BirthdaytipsView:bindEvents()
	BirthdaytipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnCopy, self._onClickCopyCode, self)
end

function BirthdaytipsView:buildUI()
	BirthdaytipsView.super.buildUI(self)

	self.txtRules = self:getTxt("txtRules")
	self.btnClose = self:getGo("btnClose")
	self.btnCopy = self:getGo("btnCopy")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function BirthdaytipsView:onExit()
	BirthdaytipsView.super.onExit(self)
	self.scrollList:dispose()
end

function BirthdaytipsView:onEnter()
	BirthdaytipsView.super.onEnter(self)

	local str = self:getFirstParam()

	self.txtRules.text = langPara("亲爱的小奥奇，您的专属兑换码为：<color=#eb4642>%s</color>，快去兑换奖励吧！", str)

	local str = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TIPS_LIST")
	local list = string.split(str, "#")

	self.scrollList:reloadData(list)
end

function BirthdaytipsView:_updateCell(view, cell, data, tag)
	local pre = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TIPS_ICON_PRE")

	uGuiUtil.setSpriteToImage(cell.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("bonus", pre .. data))
end

function BirthdaytipsView:clearCell(cell)
	uGuiUtil.clearImage(cell.gameObject)
end

function BirthdaytipsView:_onClickCopyCode()
	if not string.nilorempty(self:getFirstParam()) then
		Clipboard.copy(self:getFirstParam())
		FloatWordMgr.instance:show("兑换码复制成功，快去使用吧!")
	end
end

return BirthdaytipsView
