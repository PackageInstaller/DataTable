local MoonCakeChatJumpItemView = class("MoonCakeChatJumpItemView", (import("game.views.chat.chatItem.ChatJumpItemView")))

function MoonCakeChatJumpItemView:JumpFunc()
	local var_1_0 = JumpTools.GetSystemActivityID(self.jumpLink_)

	if not ActivityData:GetActivityIsOpen(var_1_0) then
		ShowTips("TIME_OVER")

		return
	end

	if manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) - self.itemData_.timestamp >= 86400 then
		ShowTips("MID_AUTUMN_FESTIVAL_PARTY_END")

		return
	end

	if self.itemData_.id ~= USER_ID then
		MoonCakeAction.RequirePartyOwnerData(var_1_0, self.itemData_.id, function()
			JumpTools.JumpToPage2(self.jumpLink_)
		end)
	else
		JumpTools.JumpToPage2(self.jumpLink_)
	end
end

return MoonCakeChatJumpItemView
