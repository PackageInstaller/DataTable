-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroLevelUpViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroLevelUpViewPresentor", package.seeall)

local AoqiHeroLevelUpViewPresentor = class("AoqiHeroLevelUpViewPresentor", ViewPresentor)

function AoqiHeroLevelUpViewPresentor:ctor()
	AoqiHeroLevelUpViewPresentor.super.ctor(self)
end

function AoqiHeroLevelUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiHeroLevelUpViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiherolevelupview.prefab"
	}
end

function AoqiHeroLevelUpViewPresentor:buildViews()
	return {
		AoqiHeroLevelUpView.New()
	}
end

function AoqiHeroLevelUpViewPresentor:onClickOutside()
	self:close()
end

return AoqiHeroLevelUpViewPresentor
