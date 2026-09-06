-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceLotteryBuffViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceLotteryBuffViewPresentor", package.seeall)

local AoQiAttackForceLotteryBuffViewPresentor = class("AoQiAttackForceLotteryBuffViewPresentor", ViewPresentor)

function AoQiAttackForceLotteryBuffViewPresentor:ctor()
	AoQiAttackForceLotteryBuffViewPresentor.super.ctor(self)
end

function AoQiAttackForceLotteryBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoQiAttackForceLotteryBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackforcelotterybuffview.prefab"
	}
end

function AoQiAttackForceLotteryBuffViewPresentor:buildViews()
	return {
		AoQiAttackForceLotteryBuffView.New()
	}
end

return AoQiAttackForceLotteryBuffViewPresentor
