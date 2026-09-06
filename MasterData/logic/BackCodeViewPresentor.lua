-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/BackCodeViewPresentor.lua

module("logic.extensions.playerreturn.view.BackCodeViewPresentor", package.seeall)

local BackCodeViewPresentor = class("BackCodeViewPresentor", ViewPresentor)

function BackCodeViewPresentor:ctor()
	BackCodeViewPresentor.super.ctor(self)
end

function BackCodeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BackCodeViewPresentor:dependWhatResources()
	return {
		"ui/views/exchangecode/backcodeview.prefab"
	}
end

function BackCodeViewPresentor:buildViews()
	return {
		BackCodeView.New()
	}
end

return BackCodeViewPresentor
