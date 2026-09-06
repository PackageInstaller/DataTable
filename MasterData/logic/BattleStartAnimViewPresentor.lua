-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/view/BattleStartAnimViewPresentor.lua

module("logic.extensions.battlestartanim.view.BattleStartAnimViewPresentor", package.seeall)

local BattleStartAnimViewPresentor = class("BattleStartAnimViewPresentor", ViewPresentor)

function BattleStartAnimViewPresentor:ctor()
	BattleStartAnimViewPresentor.super.ctor(self)
end

function BattleStartAnimViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattleStartAnimViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/battlestartanimview.prefab"
	}
end

function BattleStartAnimViewPresentor:buildViews()
	return {
		BattleStartAnimView.New()
	}
end

return BattleStartAnimViewPresentor
