-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/view/AshlessLongYanClgResultPopViewPresentor.lua

module("logic.extensions.ashlesslongyan.view.AshlessLongYanClgResultPopViewPresentor", package.seeall)

local AshlessLongYanClgResultPopViewPresentor = class("AshlessLongYanClgResultPopViewPresentor", ViewPresentor)

function AshlessLongYanClgResultPopViewPresentor:ctor()
	AshlessLongYanClgResultPopViewPresentor.super.ctor(self)
end

function AshlessLongYanClgResultPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AshlessLongYanClgResultPopViewPresentor:dependWhatResources()
	return {
		"ui/views/ashlesslongyan/ashlesslongyanclgresultpopview.prefab"
	}
end

function AshlessLongYanClgResultPopViewPresentor:buildViews()
	return {
		AshlessLongYanClgResultPopView.New()
	}
end

return AshlessLongYanClgResultPopViewPresentor
