-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/anmoyanchallenge/AnmoyanchallengelevelView.lua

module("logic.extensions.wuwenchallenge.view.anmoyanchallenge.AnmoyanchallengelevelView", package.seeall)

local AnmoyanchallengelevelView = class("AnmoyanchallengelevelView", WuWenChallengeLevelView)

function AnmoyanchallengelevelView:onExit()
	AnmoyanchallengelevelView.super.onExit(self)
end

function AnmoyanchallengelevelView:onEnter()
	AnmoyanchallengelevelView.super.onEnter(self)
end

return AnmoyanchallengelevelView
