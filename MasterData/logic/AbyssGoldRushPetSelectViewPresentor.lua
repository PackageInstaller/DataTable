-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushPetSelectViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushPetSelectViewPresentor", package.seeall)

local AbyssGoldRushPetSelectViewPresentor = class("AbyssGoldRushPetSelectViewPresentor", ViewPresentor)

function AbyssGoldRushPetSelectViewPresentor:ctor()
	AbyssGoldRushPetSelectViewPresentor.super.ctor(self)
end

function AbyssGoldRushPetSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushPetSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushpetselectview.prefab"
	}
end

function AbyssGoldRushPetSelectViewPresentor:buildViews()
	return {
		AbyssGoldRushPetSelectView.New()
	}
end

return AbyssGoldRushPetSelectViewPresentor
