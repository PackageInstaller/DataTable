-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bulletscreen/view/BulletScreenViewPresentor.lua

module("logic.extensions.bulletscreen.view.BulletScreenViewPresentor", package.seeall)

local BulletScreenViewPresentor = class("BulletScreenViewPresentor", ViewPresentor)

function BulletScreenViewPresentor:ctor()
	BulletScreenViewPresentor.super.ctor(self)
end

function BulletScreenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BulletScreenViewPresentor:dependWhatResources()
	return {
		"ui/views/bulletscreen/bulletscreenview.prefab"
	}
end

function BulletScreenViewPresentor:buildViews()
	return {
		BulletScreenView.New()
	}
end

function BulletScreenViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return BulletScreenViewPresentor
