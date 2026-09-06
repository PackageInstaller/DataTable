-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/view/ArmorherolotteryresultViewPresentor.lua

module("logic.extensions.armorherolottery.view.ArmorherolotteryresultViewPresentor", package.seeall)

local ArmorherolotteryresultViewPresentor = class("ArmorherolotteryresultViewPresentor", ViewPresentor)

function ArmorherolotteryresultViewPresentor:ctor()
	ArmorherolotteryresultViewPresentor.super.ctor(self)
end

function ArmorherolotteryresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArmorherolotteryresultViewPresentor:dependWhatResources()
	return {
		"ui/views/armorherolottery/armorherolotteryresultview.prefab"
	}
end

function ArmorherolotteryresultViewPresentor:buildViews()
	return {
		ArmorherolotteryresultView.New()
	}
end

return ArmorherolotteryresultViewPresentor
