local MomoTalkTipsItem = class("MomoTalkTipsItem", (import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBaseItemView")))

function MomoTalkTipsItem:OnReset(arg_1_1, arg_1_2)
	if self.tipsText_ then
		if arg_1_1 then
			self.tipsText_.text = arg_1_1.content or ""
		end
	end
end

return MomoTalkTipsItem
