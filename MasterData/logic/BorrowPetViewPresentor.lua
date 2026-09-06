-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/borrowpet/view/BorrowPetViewPresentor.lua

module("logic.extensions.borrowpet.view.BorrowPetViewPresentor", package.seeall)

local BorrowPetViewPresentor = class("BorrowPetViewPresentor", ViewPresentor)

function BorrowPetViewPresentor:ctor()
	BorrowPetViewPresentor.super.ctor(self)
end

function BorrowPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BorrowPetViewPresentor:dependWhatResources()
	return {
		"ui/views/borrowpet/borrowpetview.prefab"
	}
end

function BorrowPetViewPresentor:buildViews()
	return {
		BorrowPetView.New()
	}
end

return BorrowPetViewPresentor
