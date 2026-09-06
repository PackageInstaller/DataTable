-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupPassportViewPresentor.lua

module("logic.extensions.brothergroup.view.BrotherGroupPassportViewPresentor", package.seeall)

local BrotherGroupPassportViewPresentor = class("BrotherGroupPassportViewPresentor", ViewPresentor)

function BrotherGroupPassportViewPresentor:ctor()
	BrotherGroupPassportViewPresentor.super.ctor(self)
end

function BrotherGroupPassportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherGroupPassportViewPresentor:dependWhatResources()
	return {
		"ui/views/brothergroup/brothergrouppassportview.prefab"
	}
end

function BrotherGroupPassportViewPresentor:buildViews()
	return {
		BrotherGroupPassportView.New()
	}
end

return BrotherGroupPassportViewPresentor
