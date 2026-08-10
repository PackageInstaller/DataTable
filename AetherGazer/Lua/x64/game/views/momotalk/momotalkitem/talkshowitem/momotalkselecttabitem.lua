local var_0_0 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBaseItemView")
local var_0_1 = class("MomoTalkSelectTabItem", var_0_0)

function var_0_1.Init(arg_1_0)
	if arg_1_0.mainControllerEx_ then
		arg_1_0.selectController_ = arg_1_0.mainControllerEx_:GetController("select")
	end
end

function var_0_1.OnReset(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.text_ then
		arg_2_0.text_.text = arg_2_1 and arg_2_1.txt or ""
	end

	if arg_2_0.selectController_ then
		arg_2_0.selectController_:SetSelectedState("selected")
	end

	if arg_2_0.speakerIcon_ then
		arg_2_0.speakerIcon_.sprite = MomoTalkTools.GetMonoAvatarIcon(MomoTalkData.icon)
	end

	if arg_2_0.speakerName_ then
		arg_2_0.speakerName_.text = PlayerData and PlayerData:GetPlayerInfo().name or ""
	end
end

return var_0_1
