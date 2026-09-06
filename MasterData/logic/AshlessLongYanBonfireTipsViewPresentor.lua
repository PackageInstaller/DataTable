-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/view/AshlessLongYanBonfireTipsViewPresentor.lua

module("logic.extensions.ashlesslongyan.view.AshlessLongYanBonfireTipsViewPresentor", package.seeall)

local AshlessLongYanBonfireTipsViewPresentor = class("AshlessLongYanBonfireTipsViewPresentor", ViewPresentor)

function AshlessLongYanBonfireTipsViewPresentor:ctor()
	AshlessLongYanBonfireTipsViewPresentor.super.ctor(self)
end

function AshlessLongYanBonfireTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AshlessLongYanBonfireTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/ashlesslongyan/ashlesslongyanbonfiretipsview.prefab"
	}
end

function AshlessLongYanBonfireTipsViewPresentor:buildViews()
	return {
		AshlessLongYanBonfireTipsView.New()
	}
end

return AshlessLongYanBonfireTipsViewPresentor
