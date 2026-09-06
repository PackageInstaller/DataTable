-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonFightEndViewPresentor.lua

module("logic.extensions.bonedragon.view.BoneDragonFightEndViewPresentor", package.seeall)

local BoneDragonFightEndViewPresentor = class("BoneDragonFightEndViewPresentor", ViewPresentor)

function BoneDragonFightEndViewPresentor:ctor()
	BoneDragonFightEndViewPresentor.super.ctor(self)
end

function BoneDragonFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoneDragonFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/bonedragon/bonedragonfightendview.prefab"
	}
end

function BoneDragonFightEndViewPresentor:buildViews()
	return {
		BoneDragonFightEndView.New()
	}
end

return BoneDragonFightEndViewPresentor
