-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/baioogamescommunity/view/BaioogamescommunityView.lua

module("logic.extensions.baioogamescommunity.view.BaioogamescommunityView", package.seeall)

local BaioogamescommunityView = class("BaioogamescommunityView", ViewComponent)

function BaioogamescommunityView:ctor()
	BaioogamescommunityView.super.ctor(self)
end

function BaioogamescommunityView:unbindEvents()
	BaioogamescommunityView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGo)
end

function BaioogamescommunityView:bindEvents()
	BaioogamescommunityView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGo, self._onClickGoWeb, self)
end

function BaioogamescommunityView:buildUI()
	BaioogamescommunityView.super.buildUI(self)

	self._btnGo = self:getGo("btnGo")
end

function BaioogamescommunityView:onExit()
	BaioogamescommunityView.super.onExit(self)
end

function BaioogamescommunityView:onEnter()
	BaioogamescommunityView.super.onEnter(self)
end

function BaioogamescommunityView:_onClickGoWeb()
	local url = "https://qq.baioogames.com/aqsy/home?fromAct=aqsy_game"

	UnityEngine.Application.OpenURL(url)
end

return BaioogamescommunityView
