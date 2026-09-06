-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessbattleresultViewPresentor.lua

module("logic.extensions.autochess.view.AutochessbattleresultViewPresentor", package.seeall)

local AutochessbattleresultViewPresentor = class("AutochessbattleresultViewPresentor", ViewPresentor)

function AutochessbattleresultViewPresentor:ctor()
	AutochessbattleresultViewPresentor.super.ctor(self)
end

function AutochessbattleresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AutochessbattleresultViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessbattleresultview.prefab"
	}
end

function AutochessbattleresultViewPresentor:buildViews()
	return {
		AutochessbattleresultView.New()
	}
end

return AutochessbattleresultViewPresentor
