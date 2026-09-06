-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybuswishtreemainViewPresentor.lua

module("logic.extensions.babybus.view.BabybuswishtreemainViewPresentor", package.seeall)

local BabybuswishtreemainViewPresentor = class("BabybuswishtreemainViewPresentor", WishTreeMainViewPresentor)

function BabybuswishtreemainViewPresentor:dependWhatResources()
	return {
		"ui/views/babybus/babybuswishtreemainview.prefab"
	}
end

function BabybuswishtreemainViewPresentor:buildViews()
	return {
		BabybuswishtreemainView.New()
	}
end

return BabybuswishtreemainViewPresentor
