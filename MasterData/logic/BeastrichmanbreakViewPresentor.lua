-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanbreakViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastrichmanbreakViewPresentor", package.seeall)

local BeastrichmanbreakViewPresentor = class("BeastrichmanbreakViewPresentor", ViewPresentor)

function BeastrichmanbreakViewPresentor:ctor()
	BeastrichmanbreakViewPresentor.super.ctor(self)
end

function BeastrichmanbreakViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastrichmanbreakViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanbreakview.prefab"
	}
end

function BeastrichmanbreakViewPresentor:buildViews()
	return {
		BeastrichmanbreakView.New()
	}
end

function BeastrichmanbreakViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(ViewName.BeastrichmanbreakView)
end

return BeastrichmanbreakViewPresentor
