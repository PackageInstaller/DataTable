local ActivityToggleSpecialRewardView = class("ActivityToggleSpecialRewardView", (import("game.views.mardukSpecial.MardukSpecialRewardView")))

function ActivityToggleSpecialRewardView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdEscortUI/XH3rdEscortRewardUI"
end

function ActivityToggleSpecialRewardView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, ActivityToggleSpecialRewardItemView)
end

return ActivityToggleSpecialRewardView
