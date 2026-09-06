-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/view/ArmorHeroClg2ViewPresentor.lua

module("logic.extensions.armorhero.view.ArmorHeroClg2ViewPresentor", package.seeall)

local ArmorHeroClg2ViewPresentor = class("ArmorHeroClg2ViewPresentor", ViewPresentor)

function ArmorHeroClg2ViewPresentor:ctor()
	ArmorHeroClg2ViewPresentor.super.ctor(self)
end

function ArmorHeroClg2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArmorHeroClg2ViewPresentor:dependWhatResources()
	return {
		"ui/views/armorhero/armorheroclg2view.prefab"
	}
end

function ArmorHeroClg2ViewPresentor:buildViews()
	return {
		ArmorHeroClg2View.New()
	}
end

return ArmorHeroClg2ViewPresentor
