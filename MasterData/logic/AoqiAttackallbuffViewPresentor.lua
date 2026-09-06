-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoqiAttackallbuffViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoqiAttackallbuffViewPresentor", package.seeall)

local AoqiAttackallbuffViewPresentor = class("AoqiAttackallbuffViewPresentor", ViewPresentor)

function AoqiAttackallbuffViewPresentor:ctor()
	AoqiAttackallbuffViewPresentor.super.ctor(self)
end

function AoqiAttackallbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiAttackallbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackallbuffview.prefab"
	}
end

function AoqiAttackallbuffViewPresentor:buildViews()
	return {
		AoqiAttackallbuffView.New()
	}
end

return AoqiAttackallbuffViewPresentor
