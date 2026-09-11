local MomoTalkBubbleWorldItem = class("MomoTalkBubbleWorldItem", (import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleBaseItem")))

function MomoTalkBubbleWorldItem:OnReset(arg_1_1, arg_1_2)
	local var_1_1 = ChatContentCfg[(arg_1_2 or nil) and (arg_1_2.id or 0)]

	if arg_1_1 then
		local var_1_2 = arg_1_1.content or ""

		if var_1_2 == "" and var_1_1 then
			var_1_2 = formatText(var_1_1.content or "")
		end

		if self.text_ then
			self.text_.text = arg_1_2 and arg_1_2.state == "delay" and "..." or var_1_2
		end
	end
end

return MomoTalkBubbleWorldItem
