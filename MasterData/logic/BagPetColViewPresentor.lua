-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/stack/BagPetColViewPresentor.lua

module("logic.extensions.roleinfo.view.stack.BagPetColViewPresentor", package.seeall)

local BagPetColViewPresentor = class("BagPetColViewPresentor", ViewPresentor)

function BagPetColViewPresentor:ctor()
	BagPetColViewPresentor.super.ctor(self)
end

function BagPetColViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BagPetColViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/bagpetcolview.prefab"
	}
end

function BagPetColViewPresentor:buildViews()
	return {
		BagPetColView.New()
	}
end

return BagPetColViewPresentor
