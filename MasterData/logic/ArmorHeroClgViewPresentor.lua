-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/view/ArmorHeroClgViewPresentor.lua

module("logic.extensions.armorhero.view.ArmorHeroClgViewPresentor", package.seeall)

local ArmorHeroClgViewPresentor = class("ArmorHeroClgViewPresentor", ViewPresentor)

function ArmorHeroClgViewPresentor:ctor()
	ArmorHeroClgViewPresentor.super.ctor(self)
end

function ArmorHeroClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArmorHeroClgViewPresentor:dependWhatResources()
	return {
		"ui/views/armorhero/armorheroclgview.prefab"
	}
end

function ArmorHeroClgViewPresentor:buildViews()
	return {
		ArmorHeroClgView.New()
	}
end

return ArmorHeroClgViewPresentor
