local CooperationSelectHeroProxy = class("CooperationSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function CooperationSelectHeroProxy:InitCustomParams(arg_1_1)
	self.needComboSkillPanel = false
	self.needMimirPanel = false
	self.needReserveProposalPanel = false
	self.canUseMultiMode = false
	self.roomData = CooperationData:GetRoomData()
end

function CooperationSelectHeroProxy:UpdateBar()
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

function CooperationSelectHeroProxy:GetRoomData()
	return self.roomData
end

function CooperationSelectHeroProxy:GetPlayerIDList()
	self.playerIDList = self.playerIDList or {}

	local var_6_0 = {}
	local var_6_1 = self.roomData:GetRoomPlayerIdList()

	for iter_6_0 = 1, 3 do
		if iter_6_0 == 1 then
			local var_6_2 = PlayerData:GetPlayerInfo().userID

			table.remove(var_6_1, (table.indexof(var_6_1, var_6_2)))

			var_6_0[1] = var_6_2
		elseif self.playerIDList[iter_6_0] then
			local var_6_3 = table.indexof(var_6_1, self.playerIDList[iter_6_0])

			if var_6_3 then
				var_6_0[iter_6_0] = var_6_1[var_6_3]

				table.remove(var_6_1, var_6_3)
			end
		end
	end

	for iter_6_1 = 1, 3 do
		if not var_6_0[iter_6_1] then
			local var_6_4 = false

			for iter_6_2, iter_6_3 in ipairs(var_6_1) do
				if self.roomData:GetRoomPlayerData(iter_6_3).is_master == 1 then
					table.remove(var_6_1, iter_6_2)

					var_6_0[iter_6_1] = iter_6_3
					var_6_4 = true

					break
				end
			end

			if not var_6_4 then
				var_6_0[iter_6_1] = table.remove(var_6_1, 1)
			end
		end
	end

	self.playerIDList = var_6_0

	return self.playerIDList
end

function CooperationSelectHeroProxy:CustomGetTeamData()
	local var_7_0 = {
		0,
		0,
		0
	}

	self.playerIDList = self:GetPlayerIDList()

	for iter_7_0, iter_7_1 in pairs(self.playerIDList) do
		var_7_0[iter_7_0] = self.roomData:GetRoomPlayerData(iter_7_1).heroList[1].id
	end

	return var_7_0, {
		false,
		false,
		false
	}, {}, {
		0,
		0,
		0
	}
end

function CooperationSelectHeroProxy:CustomGetHeroPower(arg_8_1)
	local var_8_0 = self:GetPlayerIDList()[arg_8_1]

	if not var_8_0 then
		return 0
	end

	return CooperationData:GetCooperationHeroPower(var_8_0)
end

function CooperationSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/heroTeamInfoCooperation"
end

function CooperationSelectHeroProxy:GetSelectHeroViewClass()
	return CooperationSelectHeroView
end

function CooperationSelectHeroProxy:GetHeroInfoItemClass()
	return CooperationSelectHeroInfoItem
end

function CooperationSelectHeroProxy:GetAdditionalViewClass()
	return CooperationSectionAdditionalView
end

return CooperationSelectHeroProxy
