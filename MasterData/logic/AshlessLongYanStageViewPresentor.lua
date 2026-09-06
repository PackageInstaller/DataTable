-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/view/AshlessLongYanStageViewPresentor.lua

module("logic.extensions.ashlesslongyan.view.AshlessLongYanStageViewPresentor", package.seeall)

local AshlessLongYanStageViewPresentor = class("AshlessLongYanStageViewPresentor", ViewPresentor)

function AshlessLongYanStageViewPresentor:ctor()
	AshlessLongYanStageViewPresentor.super.ctor(self)
end

function AshlessLongYanStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AshlessLongYanStageViewPresentor:dependWhatResources()
	return {
		"ui/views/ashlesslongyan/ashlesslongyanstageview.prefab"
	}
end

function AshlessLongYanStageViewPresentor:buildViews()
	return {
		AshlessLongYanStageView.New()
	}
end

return AshlessLongYanStageViewPresentor
