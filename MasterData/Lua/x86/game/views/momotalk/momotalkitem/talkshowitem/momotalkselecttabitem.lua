local MomoTalkSelectTabItem = class("MomoTalkSelectTabItem", (import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBaseItemView")))

function MomoTalkSelectTabItem:Init()
	if self.mainControllerEx_ then
		self.selectController_ = self.mainControllerEx_:GetController("select")
	end
end

function MomoTalkSelectTabItem:OnReset(arg_2_1, arg_2_2)
	if self.text_ then
		if arg_2_1 then
			self.text_.text = arg_2_1.txt or ""
		end
	end

	if self.selectController_ then
		self.selectController_:SetSelectedState("selected")
	end

	if self.speakerIcon_ then
		self.speakerIcon_.sprite = MomoTalkTools.GetMonoAvatarIcon(MomoTalkData.icon)
	end

	if self.speakerName_ then
		self.speakerName_.text = PlayerData and PlayerData:GetPlayerInfo().name or ""
	end
end

return MomoTalkSelectTabItem
