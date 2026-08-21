local var_0_0 = import("game.views.chat.chatItem.ChatJumpItemView")
local var_0_1 = class("MoonCakeChatJumpItemView", var_0_0)

function var_0_1.JumpFunc(arg_1_0)
	local var_1_0 = JumpTools.GetSystemActivityID(arg_1_0.jumpLink_)

	if not ActivityData:GetActivityIsOpen(var_1_0) then
		ShowTips("TIME_OVER")

		return
	end

	local var_1_1 = GameSetting.refresh_time1.value[1][1]

	if manager.time:GetNextTime(var_1_1, 0, 0) - arg_1_0.itemData_.timestamp >= 86400 then
		ShowTips("MID_AUTUMN_FESTIVAL_PARTY_END")

		return
	end

	if arg_1_0.itemData_.id ~= USER_ID then
		MoonCakeAction.RequirePartyOwnerData(var_1_0, arg_1_0.itemData_.id, function()
			JumpTools.JumpToPage2(arg_1_0.jumpLink_)
		end)
	else
		JumpTools.JumpToPage2(arg_1_0.jumpLink_)
	end
end

return var_0_1
