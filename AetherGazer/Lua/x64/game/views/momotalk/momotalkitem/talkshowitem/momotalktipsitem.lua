local var_0_0 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBaseItemView")
local var_0_1 = class("MomoTalkTipsItem", var_0_0)

function var_0_1.OnReset(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0.tipsText_ then
		arg_1_0.tipsText_.text = arg_1_1 and arg_1_1.content or ""
	end
end

return var_0_1
