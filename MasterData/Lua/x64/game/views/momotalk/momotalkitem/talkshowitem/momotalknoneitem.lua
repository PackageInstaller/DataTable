local MomoTalkNoneItem = class("MomoTalkNoneItem", (import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBaseItemView")))
local var_0_1 = "end"

function MomoTalkNoneItem:EnsureStateController()
	if not self.stateController_ and self.controller_ then
		self.stateController_ = self.controller_:GetController("state")
	end
end

function MomoTalkNoneItem:OnReset(arg_2_1, arg_2_2)
	self:EnsureStateController()

	if self.stateController_ then
		self.stateController_:SetSelectedState((arg_2_2 or nil) and (arg_2_2.noneState or var_0_1))
	end
end

return MomoTalkNoneItem
