-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/view/ArmorherolotterymainViewPresentor.lua

module("logic.extensions.armorherolottery.view.ArmorherolotterymainViewPresentor", package.seeall)

local ArmorherolotterymainViewPresentor = class("ArmorherolotterymainViewPresentor", ViewPresentor)

function ArmorherolotterymainViewPresentor:ctor()
	ArmorherolotterymainViewPresentor.super.ctor(self)
end

function ArmorherolotterymainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArmorherolotterymainViewPresentor:dependWhatResources()
	return {
		"ui/views/armorherolottery/armorherolotterymainview.prefab"
	}
end

function ArmorherolotterymainViewPresentor:buildViews()
	return {
		ArmorherolotterymainView.New()
	}
end

return ArmorherolotterymainViewPresentor
