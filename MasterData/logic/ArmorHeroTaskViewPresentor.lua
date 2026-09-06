-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/view/ArmorHeroTaskViewPresentor.lua

module("logic.extensions.armorhero.view.ArmorHeroTaskViewPresentor", package.seeall)

local ArmorHeroTaskViewPresentor = class("ArmorHeroTaskViewPresentor", ViewPresentor)

function ArmorHeroTaskViewPresentor:ctor()
	ArmorHeroTaskViewPresentor.super.ctor(self)
end

function ArmorHeroTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArmorHeroTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/armorhero/armorherotaskview.prefab"
	}
end

function ArmorHeroTaskViewPresentor:buildViews()
	return {
		ArmorHeroTaskView.New()
	}
end

return ArmorHeroTaskViewPresentor
