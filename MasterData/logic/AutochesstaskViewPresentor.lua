-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochesstaskViewPresentor.lua

module("logic.extensions.autochess.view.AutochesstaskViewPresentor", package.seeall)

local AutochesstaskViewPresentor = class("AutochesstaskViewPresentor", ViewPresentor)

function AutochesstaskViewPresentor:ctor()
	AutochesstaskViewPresentor.super.ctor(self)
end

function AutochesstaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AutochesstaskViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattletaskview.prefab"
	}
end

function AutochesstaskViewPresentor:buildViews()
	return {
		AutochesstaskView.New()
	}
end

return AutochesstaskViewPresentor
