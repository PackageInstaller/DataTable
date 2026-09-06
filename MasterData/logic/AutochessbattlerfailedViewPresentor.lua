-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessbattlerfailedViewPresentor.lua

module("logic.extensions.autochess.view.AutochessbattlerfailedViewPresentor", package.seeall)

local AutochessbattlerfailedViewPresentor = class("AutochessbattlerfailedViewPresentor", ViewPresentor)

function AutochessbattlerfailedViewPresentor:ctor()
	AutochessbattlerfailedViewPresentor.super.ctor(self)
end

function AutochessbattlerfailedViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function AutochessbattlerfailedViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessbattlerfailedview.prefab"
	}
end

function AutochessbattlerfailedViewPresentor:buildViews()
	return {
		AutochessbattlerfailedView.New()
	}
end

return AutochessbattlerfailedViewPresentor
