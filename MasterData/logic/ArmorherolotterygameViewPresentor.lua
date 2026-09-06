-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/view/ArmorherolotterygameViewPresentor.lua

module("logic.extensions.armorherolottery.view.ArmorherolotterygameViewPresentor", package.seeall)

local ArmorherolotterygameViewPresentor = class("ArmorherolotterygameViewPresentor", ViewPresentor)

function ArmorherolotterygameViewPresentor:ctor()
	ArmorherolotterygameViewPresentor.super.ctor(self)
end

function ArmorherolotterygameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArmorherolotterygameViewPresentor:dependWhatResources()
	return {
		"ui/views/armorherolottery/armorherolotterygameview.prefab"
	}
end

function ArmorherolotterygameViewPresentor:buildViews()
	return {
		ArmorherolotterygameView.New()
	}
end

return ArmorherolotterygameViewPresentor
