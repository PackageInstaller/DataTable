-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bigorange/view/BigOrangeNoticeView.lua

module("logic.extensions.bigorange.view.BigOrangeNoticeView", package.seeall)

local BigOrangeNoticeView = class("BigOrangeNoticeView", ViewComponent)

function BigOrangeNoticeView:ctor()
	BigOrangeNoticeView.super.ctor(self)
end

function BigOrangeNoticeView:buildUI()
	BigOrangeNoticeView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._title = goutil.findChildTextComponent(self.mainGO, "title")
	self._activeImage = self:getGo("view/Viewport/Content/activeImage")
	self._content = self:getGo("view/Viewport/Content")
	self._downbg = self:getGo("view/Viewport/Content/downbg/bg")
	self._contentText = goutil.findChildTextComponent(self._content, "downbg/text")
end

function BigOrangeNoticeView:bindEvents()
	BigOrangeNoticeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function BigOrangeNoticeView:unbindEvents()
	BigOrangeNoticeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function BigOrangeNoticeView:destroyUI()
	BigOrangeNoticeView.super.destroyUI(self)
end

function BigOrangeNoticeView:onEnter()
	BigOrangeNoticeView.super.onEnter(self)

	self._noticeInfo = BigOrangeConfig.instance:getNoticeById(tonumber(self:getFirstParam()))
	self._title.text = self._noticeInfo.title

	uGuiUtil.setSpriteToImage(self._activeImage, uGuiUtil.SpriteType.BigBg, "ui/bigbg/bigorange/" .. self._noticeInfo.contentBG)

	self._contentText.text = self._noticeInfo.content

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._contentText.gameObject:GetComponent(goutil.Type_RectTransform))

	local vector = GameUtil.getAnchoredPos(self:getGo("view/Viewport/Content/downbg"))
	local downbgHeight = 221
	local newHeight = GameUtil.getHeight(self._contentText.gameObject) + 25

	if downbgHeight < newHeight then
		GameUtil.setHeight(self._downbg, newHeight)
	else
		GameUtil.setHeight(self._downbg, downbgHeight)
	end

	GameUtil.setHeight(self._content, -1 * vector.y + GameUtil.getHeight(self._downbg) + 20)
end

function BigOrangeNoticeView:onEnterFinished()
	BigOrangeNoticeView.super.onEnterFinished(self)
end

function BigOrangeNoticeView:onExit()
	BigOrangeNoticeView.super.onExit(self)
end

function BigOrangeNoticeView:onExitFinished()
	BigOrangeNoticeView.super.onExitFinished(self)
end

return BigOrangeNoticeView
