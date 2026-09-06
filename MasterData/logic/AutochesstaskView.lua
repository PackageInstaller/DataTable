-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochesstaskView.lua

module("logic.extensions.autochess.view.AutochesstaskView", package.seeall)

local AutochesstaskView = class("AutochesstaskView", LotusbattletaskView)

function AutochesstaskView:_getActivityId()
	return AutochessModel.instance:getActivityId()
end

return AutochesstaskView
