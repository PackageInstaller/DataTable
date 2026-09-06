-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybuswishtreemainView.lua

module("logic.extensions.babybus.view.BabybuswishtreemainView", package.seeall)

local BabybuswishtreemainView = class("BabybuswishtreemainView", WishTreeMainView)

function BabybuswishtreemainView:_onClickClose()
	self:close()
end

function BabybuswishtreemainView:_onClickAdd(idx)
	UIStateManager.instance:push(ViewName.BabybuswishtreelistView, self._activityId, idx)
end

function BabybuswishtreemainView:_onClickPray()
	UIStateManager.instance:push(ViewName.BabybuswishtreetaskView, self._activityId)
end

return BabybuswishtreemainView
