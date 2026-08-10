local var_0_0 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBaseItemView")
local var_0_1 = class("MomoTalkReplyItem", var_0_0)

function var_0_1.Init(arg_1_0)
	if arg_1_0.mainControllerEx_ then
		arg_1_0.senderController_ = arg_1_0.mainControllerEx_:GetController("sender")
	end
end

function var_0_1.OnReset(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 and arg_2_1.spokesmen == 0

	if arg_2_0.senderController_ then
		arg_2_0.senderController_:SetSelectedState(var_2_0 and "player" or "npc")
	end

	if arg_2_0.speakerIcon_ then
		if var_2_0 then
			arg_2_0.speakerIcon_.sprite = MomoTalkTools.GetMonoAvatarIcon(MomoTalkData.icon)
		else
			local var_2_1 = arg_2_1 and ChatHeroCfg[arg_2_1.spokesmen]

			if var_2_1 then
				arg_2_0.speakerIcon_.sprite = MomoTalkTools.GetHeroIcon(var_2_1.icon)
			end
		end
	end

	if arg_2_0.speakerName_ then
		if var_2_0 then
			arg_2_0.speakerName_.text = PlayerData and PlayerData:GetPlayerInfo().name or ""
		else
			local var_2_2 = arg_2_1 and ChatHeroCfg[arg_2_1.spokesmen]

			arg_2_0.speakerName_.text = var_2_2 and GetI18NText(var_2_2.name) or ""
		end
	end
end

return var_0_1
