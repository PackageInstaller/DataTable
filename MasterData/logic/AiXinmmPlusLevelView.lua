-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aixinmmplus/AiXinmmPlusLevelView.lua

module("logic.extensions.timelimitedchallenge.view.aixinmmplus.AiXinmmPlusLevelView", package.seeall)

local AiXinmmPlusLevelView = class("AiXinmmPlusLevelView", XiuMumLevelView)

function AiXinmmPlusLevelView:_getGameView()
	return ViewName.AiXinmmPlusGameView
end

return AiXinmmPlusLevelView
