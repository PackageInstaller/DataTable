local var_0_0 = class("FeastOpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.cmd or 0
	local var_1_2 = var_1_0.arg1 or 0
	local var_1_3 = var_1_0.arg2 or 0
	local var_1_4 = var_1_0.argList or {}
	local var_1_5 = var_1_0.kvpArgs or {}
	local var_1_6 = var_1_0.callback

	if var_1_1 == FeastDorm.OP_RANDOM_SHIPS then
		pg.ConnectionMgr.GetInstance():Send(26158, {
			act_id = var_1_0.activityId,
			ship_group_id = var_1_4
		}, 26159, function(arg_2_0)
			if arg_2_0.ret == 0 then
				local var_2_0 = getProxy(FeastProxy)
				local var_2_1 = var_2_0:getData()

				var_2_1:SetRefreshTime(arg_2_0.refresh_time)

				for iter_2_0, iter_2_1 in ipairs(arg_2_0.party_roles) do
					({})[iter_2_1.tid] = true

					local var_2_2 = var_2_1:GetFeastShip(iter_2_1.tid)

					if not var_2_2 then
						local var_2_3 = FeastShip.New(iter_2_1)
						local var_2_4 = var_2_1:GetInvitedFeastShip(iter_2_1.tid)

						if var_2_4 ~= nil then
							var_2_3:SetSkinId(var_2_4:GetSkinId())
						end

						var_2_1:AddShip(var_2_3)
					else
						var_2_2:UpdateBubble(iter_2_1.bubble)
						var_2_2:UpdateSpeechBubble(iter_2_1.speech_bubble)
					end
				end

				for iter_2_2, iter_2_3 in pairs(var_2_1:GetFeastShipList()) do
					if ({})[iter_2_2] ~= true then
						var_2_1:RemoveShip(iter_2_2)
					end
				end

				var_2_0:UpdateData(var_2_1)
				var_2_0:AddRefreshTimer()
				arg_1_0:sendNotification(GAME.FEAST_OP_DONE, {
					cmd = FeastDorm.OP_RANDOM_SHIPS,
					ships = var_2_1:GetBayShipOnFloor(),
					awards = {}
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.ret] .. arg_2_0.ret)
			end

			if var_1_6 then
				var_1_6()
			end

			return
		end)
	else
		if not arg_1_0:CheckRes(var_1_1, var_1_2) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

			return
		end

		pg.ConnectionMgr.GetInstance():Send(11202, {
			activity_id = var_1_0.activityId,
			cmd = var_1_1,
			arg1 = var_1_2,
			arg2 = var_1_3,
			arg_list = var_1_4,
			kvargs1 = var_1_5
		}, 11203, function(arg_3_0)
			if arg_3_0.result == 0 then
				local var_3_0 = PlayerConst.addTranDrop(arg_3_0.award_list)

				if var_1_1 == FeastDorm.OP_INTERACTION then
					local var_3_1 = arg_3_0.number[1] or 0

					arg_1_0:HandleInteraction(var_1_2, var_1_3, var_3_1, var_3_0)
				elseif var_1_1 == FeastDorm.OP_MAKE_TICKET then
					arg_1_0:HandleMakeTicket(var_1_2)
				elseif var_1_1 == FeastDorm.OP_GIVE_TICKET then
					local var_3_2 = arg_3_0.number[1] or 0

					arg_1_0:HandleGiveTicket(var_1_2, var_3_2, var_3_0)
				elseif var_1_1 == FeastDorm.OP_GIVE_GIFT then
					arg_1_0:HandleGiveGift(var_1_2, var_3_0)
				elseif var_1_1 == FeastDorm.OP_ENTER then
					-- block empty
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
			end

			if var_1_6 then
				var_1_6()
			end

			return
		end)
	end

	return
end

function var_0_0.CheckRes(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)
	local var_4_3 = getProxy(FeastProxy):getRawData():GetInvitedFeastShip(arg_4_2)

	if arg_4_1 == FeastDorm.OP_MAKE_TICKET then
		local var_4_4 = var_4_3:GetTicketConsume()

		return var_4_0:getVitemNumber(var_4_4.id) >= var_4_4.count
	elseif arg_4_1 == FeastDorm.OP_GIVE_GIFT then
		local var_4_5 = var_4_3:GetGiftConsume()

		return var_4_0:getVitemNumber(var_4_5.id) >= var_4_5.count
	else
		return true
	end

	return
end

function var_0_0.HandleInteraction(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = getProxy(FeastProxy):getRawData()
	local var_5_1 = var_5_0:GetFeastShip(arg_5_1)

	var_5_1.speechBubble = arg_5_3

	local var_5_2 = ""

	if var_5_1:IsSpecial() then
		var_5_2 = var_5_0:GetInvitedFeastShip(arg_5_1):GetSpeechContent(var_5_1.bubble, var_5_1.speechBubble)
	end

	var_5_1:ClearBubble()
	arg_5_0:sendNotification(GAME.FEAST_OP_DONE, {
		cmd = FeastDorm.OP_INTERACTION,
		groupId = arg_5_1,
		value = var_5_1:GetBubble(),
		chat = var_5_2,
		awards = arg_5_4
	})

	return
end

function var_0_0.HandleMakeTicket(arg_6_0, arg_6_1)
	local var_6_9000
	local var_6_0 = getProxy(FeastProxy)
	local var_6_1 = var_6_0.getRawData(var_6_9000):GetInvitedFeastShip(arg_6_1)
	local var_6_2 = getProxy(ActivityProxy)
	local var_6_3 = var_6_2:getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	var_6_3:subVitemNumber(var_6_0.id, var_6_1:GetTicketConsume().count)
	var_6_2:updateActivity(var_6_3)
	var_6_1:SetInvitationState(InvitedFeastShip.STATE_MAKE_TICKET)
	arg_6_0:sendNotification(GAME.FEAST_OP_DONE, {
		cmd = FeastDorm.OP_MAKE_TICKET,
		groupId = arg_6_1,
		value = var_6_1:GetInvitationState(),
		awards = {}
	})

	return
end

function var_0_0.HandleGiveTicket(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = getProxy(FeastProxy):getRawData()
	local var_7_1 = var_7_0:GetInvitedFeastShip(arg_7_1)

	var_7_1:SetInvitationState(InvitedFeastShip.STATE_GOT_TICKET)

	local var_7_2 = FeastShip.New({
		skinId = 0,
		tid = arg_7_1,
		bubble = arg_7_2
	})

	var_7_2:SetSkinId((var_7_1:GetSkinId()))
	var_7_0:AddShip(var_7_2)
	arg_7_0:sendNotification(GAME.FEAST_OP_DONE, {
		cmd = FeastDorm.OP_GIVE_TICKET,
		groupId = arg_7_1,
		value = var_7_1:GetInvitationState(),
		awards = arg_7_3
	})

	return
end

function var_0_0.HandleGiveGift(arg_8_0, arg_8_1, arg_8_2)
	local var_8_9000
	local var_8_0 = getProxy(FeastProxy)
	local var_8_1 = var_8_0.getRawData(var_8_9000):GetInvitedFeastShip(arg_8_1)
	local var_8_2 = getProxy(ActivityProxy)
	local var_8_3 = var_8_2:getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	var_8_3:subVitemNumber(var_8_0.id, var_8_1:GetGiftConsume().count)
	var_8_2:updateActivity(var_8_3)
	var_8_1:SetGiftState(InvitedFeastShip.GIFT_STATE_GOT)
	arg_8_0:sendNotification(GAME.FEAST_OP_DONE, {
		cmd = FeastDorm.OP_GIVE_GIFT,
		groupId = arg_8_1,
		value = var_8_1:GetGiftState(),
		awards = arg_8_2
	})

	return
end

return var_0_0
