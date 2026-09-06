-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/BonusViewPresentor.lua

module("logic.extensions.bonus.view.BonusViewPresentor", package.seeall)

local BonusViewPresentor = class("BonusViewPresentor", ViewWithGuidePresentor)

function BonusViewPresentor:ctor()
	BonusViewPresentor.super.ctor(self)
end

function BonusViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BonusViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/bonusextview.prefab"
	}
end

function BonusViewPresentor:buildViews()
	return {
		BonusView.New()
	}
end

return BonusViewPresentor
