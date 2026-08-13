class = var_0_10000

local var_0_0 = "IslandSignInGuildListPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..pages.IslandFriendList4GuildPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSignInFriendListUI"
end

function var_0_1.GetOpBtns(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}

	i18n = var_1_10003
	var_2_1[1] = var_1_10003("island_btn_label_invitation")
	var_2_1[2] = function(arg_3_0)
		local var_3_0 = arg_2_0
		local var_3_1 = var_1.emit

		IslandMediator = var_2_10004

		var_3_1(var_3_0, var_2_10004.SIGN_IN_INVITATION, {
			arg_3_0.id
		})

		return
	end
	var_2_1[3] = function(arg_4_0)
		print = var_2_10001

		var_2_10001(arg_4_0)

		getProxy = var_2_10001
		IslandProxy = var_3

		local var_4_0 = var_2_10001(var_3)
		local var_4_1 = var_1.GetIsland(var_4_0)
		local var_4_2 = var_1.GetSignInAgency(var_4_1)

		return not var_2.IsInvited(var_4_2, arg_4_0.id)
	end
	var_2_0[1] = var_2_1

	local var_2_2 = {}

	i18n = var_3
	var_2_2[1] = var_3("island_btn_label_invitation_already")
	var_2_2[2] = function(arg_5_0)
		return
	end
	var_2_2[3] = function(arg_6_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		local var_6_0 = var_2_10001(var_2_10003)
		local var_6_1 = var_1.GetIsland(var_6_0)
		local var_6_2 = var_1.GetSignInAgency(var_6_1)

		return (var_2.IsInvited(var_6_2, arg_6_0.id))
	end
	var_2_0[2] = var_2_2

	return var_2_0
end

return var_0_1
