-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/view/AshlessLongYanMainViewPresentor.lua

module("logic.extensions.ashlesslongyan.view.AshlessLongYanMainViewPresentor", package.seeall)

local AshlessLongYanMainViewPresentor = class("AshlessLongYanMainViewPresentor", ViewPresentor)

function AshlessLongYanMainViewPresentor:ctor()
	AshlessLongYanMainViewPresentor.super.ctor(self)
end

function AshlessLongYanMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AshlessLongYanMainViewPresentor:dependWhatResources()
	return {
		"ui/views/ashlesslongyan/ashlesslongyanmainview.prefab"
	}
end

function AshlessLongYanMainViewPresentor:buildViews()
	return {
		AshlessLongYanMainView.New()
	}
end

return AshlessLongYanMainViewPresentor
