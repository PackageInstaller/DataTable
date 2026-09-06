-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/view/ArmorHeroMainViewPresentor.lua

module("logic.extensions.armorhero.view.ArmorHeroMainViewPresentor", package.seeall)

local ArmorHeroMainViewPresentor = class("ArmorHeroMainViewPresentor", ViewPresentor)

function ArmorHeroMainViewPresentor:ctor()
	ArmorHeroMainViewPresentor.super.ctor(self)
end

function ArmorHeroMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArmorHeroMainViewPresentor:dependWhatResources()
	return {
		"ui/views/armorhero/armorheromainview.prefab"
	}
end

function ArmorHeroMainViewPresentor:buildViews()
	return {
		ArmorHeroMainView.New()
	}
end

return ArmorHeroMainViewPresentor
