-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupInviteViewPresentor.lua

module("logic.extensions.brothergroup.view.BrotherGroupInviteViewPresentor", package.seeall)

local BrotherGroupInviteViewPresentor = class("BrotherGroupInviteViewPresentor", ViewPresentor)

function BrotherGroupInviteViewPresentor:ctor()
	BrotherGroupInviteViewPresentor.super.ctor(self)
end

function BrotherGroupInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherGroupInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/brothergroup/brothergroupinviteview.prefab"
	}
end

function BrotherGroupInviteViewPresentor:buildViews()
	return {
		BrotherGroupInviteView.New()
	}
end

return BrotherGroupInviteViewPresentor
