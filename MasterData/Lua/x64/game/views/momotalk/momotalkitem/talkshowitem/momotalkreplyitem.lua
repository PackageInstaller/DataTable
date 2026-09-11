local MomoTalkReplyItem = class("MomoTalkReplyItem", (import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBaseItemView")))

function MomoTalkReplyItem:Init()
	if self.mainControllerEx_ then
		self.senderController_ = self.mainControllerEx_:GetController("sender")
	end
end

function MomoTalkReplyItem:OnReset(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 and arg_2_1.spokesmen == 0

	if self.senderController_ then
		self.senderController_:SetSelectedState(var_2_0 and "player" or "npc")
	end

	if self.speakerIcon_ then
		if var_2_0 then
			self.speakerIcon_.sprite = MomoTalkTools.GetMonoAvatarIcon(MomoTalkData.icon)
		elseif arg_2_1 and ChatHeroCfg[arg_2_1.spokesmen] then
			self.speakerIcon_.sprite = MomoTalkTools.GetHeroIcon((arg_2_1 and ChatHeroCfg[arg_2_1.spokesmen]).icon)
		end
	end

	if self.speakerName_ then
		self.speakerName_.text = var_2_0 and (PlayerData and PlayerData:GetPlayerInfo().name or "") or arg_2_1 and ChatHeroCfg[arg_2_1.spokesmen] and GetI18NText((arg_2_1 and ChatHeroCfg[arg_2_1.spokesmen]).name) or ""
	end
end

return MomoTalkReplyItem
