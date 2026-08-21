local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("CooperationSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.needComboSkillPanel = false
	arg_1_0.needMimirPanel = false
	arg_1_0.needReserveProposalPanel = false
	arg_1_0.canUseMultiMode = false
	arg_1_0.roomData = CooperationData:GetRoomData()
end

function var_0_1.UpdateBar(arg_2_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("COOPERATION_LEAVE_ROOM_CONFIRM"),
			OkCallback = function()
				CooperationAction.LeaveRoom()
			end
		})
	end)
end

function var_0_1.GetRoomData(arg_5_0)
	return arg_5_0.roomData
end

function var_0_1.GetPlayerIDList(arg_6_0)
	arg_6_0.playerIDList = arg_6_0.playerIDList or {}

	local var_6_0 = {}
	local var_6_1 = arg_6_0.roomData:GetRoomPlayerIdList()

	for iter_6_0 = 1, 3 do
		if iter_6_0 == 1 then
			local var_6_2 = PlayerData:GetPlayerInfo().userID
			local var_6_3 = table.indexof(var_6_1, var_6_2)

			table.remove(var_6_1, var_6_3)

			var_6_0[1] = var_6_2
		else
			local var_6_4 = arg_6_0.playerIDList[iter_6_0]

			if var_6_4 then
				local var_6_5 = table.indexof(var_6_1, var_6_4)

				if var_6_5 then
					var_6_0[iter_6_0] = var_6_1[var_6_5]

					table.remove(var_6_1, var_6_5)
				end
			end
		end
	end

	for iter_6_1 = 1, 3 do
		if not var_6_0[iter_6_1] then
			local var_6_6 = false

			for iter_6_2, iter_6_3 in ipairs(var_6_1) do
				if arg_6_0.roomData:GetRoomPlayerData(iter_6_3).is_master == 1 then
					table.remove(var_6_1, iter_6_2)

					var_6_0[iter_6_1] = iter_6_3
					var_6_6 = true

					break
				end
			end

			if not var_6_6 then
				var_6_0[iter_6_1] = table.remove(var_6_1, 1)
			end
		end
	end

	arg_6_0.playerIDList = var_6_0

	return arg_6_0.playerIDList
end

function var_0_1.CustomGetTeamData(arg_7_0)
	local var_7_0 = {
		0,
		0,
		0
	}
	local var_7_1 = {
		false,
		false,
		false
	}
	local var_7_2 = {}
	local var_7_3 = {
		0,
		0,
		0
	}

	arg_7_0.playerIDList = arg_7_0:GetPlayerIDList()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.playerIDList) do
		var_7_0[iter_7_0] = arg_7_0.roomData:GetRoomPlayerData(iter_7_1).heroList[1].id
	end

	return var_7_0, var_7_1, var_7_2, var_7_3
end

function var_0_1.CustomGetHeroPower(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetPlayerIDList()[arg_8_1]

	if not var_8_0 then
		return 0
	end

	return CooperationData:GetCooperationHeroPower(var_8_0)
end

function var_0_1.GetHeroTeamInfoRoute(arg_9_0)
	return "/heroTeamInfoCooperation"
end

function var_0_1.GetSelectHeroViewClass(arg_10_0)
	return CooperationSelectHeroView
end

function var_0_1.GetHeroInfoItemClass(arg_11_0)
	return CooperationSelectHeroInfoItem
end

function var_0_1.GetAdditionalViewClass(arg_12_0)
	return CooperationSectionAdditionalView
end

return var_0_1
