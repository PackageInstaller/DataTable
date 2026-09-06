-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/ActivitySetView.lua

module("logic.extensions.bonus.view.ActivitySetView", package.seeall)

local ActivitySetView = class("ActivitySetView", BonusView)

function ActivitySetView:getCfgs()
	return BonusConfig.instance:getActivitySetCfgs()
end

return ActivitySetView
