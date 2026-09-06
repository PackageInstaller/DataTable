-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aruisi/AruisiDetailView.lua

module("logic.extensions.timelimitedchallenge.view.aruisi.AruisiDetailView", package.seeall)

local AruisiDetailView = class("AruisiDetailView", TimeLimitedDetailView)

function AruisiDetailView:buildUI()
	AruisiDetailView.super.buildUI(self)

	self._challengeId = 1
end

return AruisiDetailView
