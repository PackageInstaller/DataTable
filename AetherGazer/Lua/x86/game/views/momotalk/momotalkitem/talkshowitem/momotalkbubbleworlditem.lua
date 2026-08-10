local var_0_0 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleBaseItem")
local var_0_1 = class("MomoTalkBubbleWorldItem", var_0_0)

function var_0_1.OnReset(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2 and arg_1_2.state == "delay"
	local var_1_1 = ChatContentCfg[arg_1_2 and arg_1_2.id or 0]
	local var_1_2 = arg_1_1 and arg_1_1.content or ""

	if var_1_2 == "" and var_1_1 then
		var_1_2 = formatText(var_1_1.content or "")
	end

	if arg_1_0.text_ then
		arg_1_0.text_.text = var_1_0 and "..." or var_1_2
	end
end

return var_0_1
