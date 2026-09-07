local IslandSignInGuildListPage = class("IslandSignInGuildListPage", import("..pages.IslandFriendList4GuildPage"))

function IslandSignInGuildListPage:getUIName()
	return "IslandSignInFriendListUI"
end

function IslandSignInGuildListPage:GetOpBtns()
	return {
		{
			i18n("island_btn_label_invitation"),
			function(arg_3_0)
				self:emit(IslandMediator.SIGN_IN_INVITATION, {
					arg_3_0.id
				})

				return
			end,
			function(arg_4_0)
				print(arg_4_0)

				return not getProxy(IslandProxy):GetIsland():GetSignInAgency():IsInvited(arg_4_0.id)
			end
		},
		{
			i18n("island_btn_label_invitation_already"),
			function(arg_5_0)
				return
			end,
			function(arg_6_0)
				return (getProxy(IslandProxy):GetIsland():GetSignInAgency():IsInvited(arg_6_0.id))
			end
		}
	}
end

return IslandSignInGuildListPage
