-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aixinmmplus/AiXinmmPlusGameView.lua

module("logic.extensions.timelimitedchallenge.view.aixinmmplus.AiXinmmPlusGameView", package.seeall)

local AiXinmmPlusGameView = class("AiXinmmPlusGameView", XiuMumGameView)

function AiXinmmPlusGameView:_getMainView()
	return ViewName.AiXinmmPlusMainView
end

function AiXinmmPlusGameView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "aixinmmplusgameview_rule")
end

function AiXinmmPlusGameView:_getRuleName()
	return "aixinmmPlusGameChallenge_rule"
end

return AiXinmmPlusGameView
