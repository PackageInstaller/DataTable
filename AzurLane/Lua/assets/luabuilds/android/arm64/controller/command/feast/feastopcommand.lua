class = var_0_10000

local var_0_0 = "FeastOpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activityId
	local var_1_1

	if not var_2.cmd then
		var_1_1 = 0
	end

	local var_1_2

	if not var_2.arg1 then
		var_1_2 = 0
	end

	local var_1_3

	if not var_2.arg2 then
		var_1_3 = 0
	end

	local var_1_4

	if not var_2.argList then
		var_1_4 = {}
	end

	local var_1_5

	if not var_2.kvpArgs then
		var_1_5 = {}
	end

	local var_1_6 = var_2.callback

	FeastDorm = var_1_10010

	if var_1_1 == var_1_10010.OP_RANDOM_SHIPS then
		pg = var_10

		local var_1_7 = var_10.ConnectionMgr.GetInstance()

		var_10.Send(var_1_7, 26158, {
			act_id = var_1_0,
			ship_group_id = var_1_4
		}, 26159, function(arg_2_0)
			if arg_2_0.ret == 0 then
				getProxy = var_1
				FeastProxy = var_2_10003
				var_2_10004 = var_1(var_2_10003)

				local var_2_0 = var_1.getData(var_2_10004)

				var_2.SetRefreshTime(var_2_0, arg_2_0.refresh_time)

				local var_2_1 = {}

				ipairs = var_2_10004

				for iter_2_0, iter_2_1 in var_2_10004(arg_2_0.party_roles) do
					var_2_1[iter_2_1.tid] = true

					if not var_2:GetFeastShip(iter_2_1.tid) then
						FeastShip = var_10

						local var_2_2 = var_10.New(iter_2_1)

						if var_2:GetInvitedFeastShip(iter_2_1.tid) ~= nil then
							var_2_2:SetSkinId(var_11:GetSkinId())
						end

						var_2:AddShip(var_2_2)
					else
						var_2_10009:UpdateBubble(iter_2_1.bubble)
						var_2_10009:UpdateSpeechBubble(iter_2_1.speech_bubble)
					end
				end

				pairs = var_2_10004

				for iter_2_2, iter_2_3 in var_2_10004(var_2:GetFeastShipList()) do
					if var_2_1[iter_2_2] ~= true then
						var_2:RemoveShip(iter_2_2)
					end
				end

				var_1:UpdateData(var_2)
				var_1:AddRefreshTimer()

				local var_2_3 = arg_1_0

				var_2_10004 = var_2_10004.sendNotification
				GAME = var_7

				local var_2_4 = var_7.FEAST_OP_DONE
				local var_2_5 = {}

				FeastDorm = var_2_10009
				var_2_5.cmd = var_2_10009.OP_RANDOM_SHIPS
				var_2_5.ships = var_2:GetBayShipOnFloor()
				var_2_5.awards = {}

				var_2_10004(var_2_3, var_2_4, var_2_5)
			else
				pg = var_1

				local var_2_6 = var_1.TipsMgr.GetInstance()
				local var_2_7 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_7(var_2_6, var_2_10004[arg_2_0.ret] .. arg_2_0.ret)
			end

			if var_1_6 then
				var_1_6()
			end

			return
		end)
	else
		local var_1_9

		if not arg_1_0:CheckRes(var_1_1, var_1_2) then
			pg = var_1_9

			local var_1_8 = var_1_9.TipsMgr.GetInstance()

			var_1_9 = var_1_9.ShowTips
			i18n = var_13

			var_1_9(var_1_8, var_13("common_no_resource"))

			return
		end

		pg = var_1_9

		local var_1_10 = var_1_9.ConnectionMgr.GetInstance()

		var_10.Send(var_1_10, 11202, {
			activity_id = var_1_0,
			cmd = var_1_1,
			arg1 = var_1_2,
			arg2 = var_1_3,
			arg_list = var_1_4,
			kvargs1 = var_1_5
		}, 11203, function(arg_3_0)
			local var_3_0

			if arg_3_0.result == 0 then
				PlayerConst = var_3_0
				var_3_0 = var_3_0.addTranDrop(arg_3_0.award_list)

				local var_3_1 = var_1_1

				FeastDorm = var_3

				if var_3_1 == var_3.OP_INTERACTION then
					var_2_10004 = arg_1_0

					local var_3_2 = var_2.HandleInteraction
					local var_3_3 = var_1_2
					local var_3_4 = var_1_3
					local var_3_5

					if not arg_3_0.number[1] then
						var_3_5 = 0
					end

					var_3_2(var_2_10004, var_3_3, var_3_4, var_3_5, var_3_0)
				else
					local var_3_6 = var_1_1

					FeastDorm = var_3

					if var_3_6 == var_3.OP_MAKE_TICKET then
						var_2_10004 = arg_1_0

						var_2.HandleMakeTicket(var_2_10004, var_1_2)
					else
						local var_3_7 = var_1_1

						FeastDorm = var_3

						if var_3_7 == var_3.OP_GIVE_TICKET then
							var_2_10004 = arg_1_0

							local var_3_8 = var_2.HandleGiveTicket
							local var_3_9 = var_1_2
							local var_3_10

							if not arg_3_0.number[1] then
								var_3_10 = 0
							end

							var_3_8(var_2_10004, var_3_9, var_3_10, var_3_0)
						else
							local var_3_11 = var_1_1

							FeastDorm = var_3

							if var_3_11 == var_3.OP_GIVE_GIFT then
								var_2_10004 = arg_1_0

								var_2.HandleGiveGift(var_2_10004, var_1_2, var_3_0)
							else
								local var_3_12 = var_1_1

								FeastDorm = var_3

								if var_3_12 == var_3.OP_ENTER then
									-- block empty
								end
							end
						end
					end
				end
			else
				pg = var_3_0

				local var_3_13 = var_3_0.TipsMgr.GetInstance()
				local var_3_14 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_3_14(var_3_13, var_2_10004[arg_3_0.result] .. arg_3_0.result)
			end

			if var_1_6 then
				var_1_6()
			end

			return
		end)
	end

	return
end

function var_0_1.CheckRes(arg_4_0, arg_4_1, arg_4_2)
	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_4_0 = var_1_10003(var_1_10005)
	local var_4_1 = var_3.getActivityByType

	ActivityConst = var_1_10007

	local var_4_2 = var_4_1(var_4_0, var_1_10007.ACTIVITY_TYPE_VIRTUAL_BAG)
	local var_4_3 = 0
	local var_4_4 = 1

	getProxy = var_7
	FeastProxy = var_1_10009

	local var_4_5 = var_7(var_1_10009)
	local var_4_6 = var_7.getRawData(var_4_5)
	local var_4_7 = var_7.GetInvitedFeastShip(var_4_6, arg_4_2)

	FeastDorm = var_4_5

	local var_4_8

	if arg_4_1 == var_4_5.OP_MAKE_TICKET then
		var_4_8 = var_4_7:GetTicketConsume()

		return var_4_2:getVitemNumber(var_4_8.id) >= var_4_8.count
	else
		FeastDorm = var_4_8

		if arg_4_1 == var_4_8.OP_GIVE_GIFT then
			local var_4_9 = var_4_7:GetGiftConsume()

			return var_4_2:getVitemNumber(var_4_9.id) >= var_4_9.count
		else
			return true
		end
	end

	return
end

function var_0_1.HandleInteraction(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	getProxy = var_1_10005
	FeastProxy = var_1_10007

	local var_5_0 = var_1_10005(var_1_10007)
	local var_5_1 = var_5.getRawData(var_5_0)
	local var_5_2 = var_5.GetFeastShip(var_5_1, arg_5_1)

	var_5_2.speechBubble = arg_5_3

	local var_5_3 = ""

	if var_5_2:IsSpecial() then
		var_1_10011 = var_5:GetInvitedFeastShip(arg_5_1)
		var_5_3 = var_8.GetSpeechContent(var_1_10011, var_5_2.bubble, var_5_2.speechBubble)
	end

	var_5_2:ClearBubble()

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.sendNotification

	GAME = var_1_10011

	local var_5_6 = var_1_10011.FEAST_OP_DONE
	local var_5_7 = {}

	FeastDorm = var_1_10013
	var_5_7.cmd = var_1_10013.OP_INTERACTION
	var_5_7.groupId = arg_5_1
	var_5_7.value = var_5_2:GetBubble()
	var_5_7.chat = var_5_3
	var_5_7.awards = arg_5_4

	var_5_5(var_5_4, var_5_6, var_5_7)

	return
end

function var_0_1.HandleMakeTicket(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	FeastProxy = var_1_10004

	local var_6_0 = var_1_10002(var_1_10004)
	local var_6_1 = var_2.getRawData(var_6_0)
	local var_6_2 = var_2.GetInvitedFeastShip(var_6_1, arg_6_1)
	local var_6_3 = var_3.GetTicketConsume(var_6_2)

	getProxy = var_6_1
	ActivityProxy = var_1_10007

	local var_6_4 = var_6_1(var_1_10007)
	local var_6_5 = var_5.getActivityByType

	ActivityConst = var_1_10009

	local var_6_6 = var_6_5(var_6_4, var_1_10009.ACTIVITY_TYPE_VIRTUAL_BAG)

	var_6.subVitemNumber(var_6_6, var_6_3.id, var_6_3.count)
	var_5:updateActivity(var_6)

	local var_6_7 = var_3
	local var_6_8 = var_3.SetInvitationState

	InvitedFeastShip = var_10

	var_6_8(var_6_7, var_10.STATE_MAKE_TICKET)

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.sendNotification

	GAME = var_10

	local var_6_11 = var_10.FEAST_OP_DONE
	local var_6_12 = {}

	FeastDorm = var_1_10012
	var_6_12.cmd = var_1_10012.OP_MAKE_TICKET
	var_6_12.groupId = arg_6_1
	var_6_12.value = var_3:GetInvitationState()
	var_6_12.awards = {}

	var_6_10(var_6_9, var_6_11, var_6_12)

	return
end

function var_0_1.HandleGiveTicket(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	getProxy = var_1_10004
	FeastProxy = var_1_10006

	local var_7_0 = var_1_10004(var_1_10006)
	local var_7_1 = var_4.getRawData(var_7_0)
	local var_7_2 = var_4.GetInvitedFeastShip(var_7_1, arg_7_1)
	local var_7_3 = var_5.SetInvitationState

	InvitedFeastShip = var_1_10009

	var_7_3(var_7_2, var_1_10009.STATE_GOT_TICKET)

	local var_7_4 = var_5:GetSkinId()

	FeastShip = var_7_1

	local var_7_5 = var_7_1.New({
		skinId = 0,
		tid = arg_7_1,
		bubble = arg_7_2
	})

	var_7.SetSkinId(var_7_5, var_7_4)
	var_4:AddShip(var_7)

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.sendNotification

	GAME = var_11

	local var_7_8 = var_11.FEAST_OP_DONE
	local var_7_9 = {}

	FeastDorm = var_1_10013
	var_7_9.cmd = var_1_10013.OP_GIVE_TICKET
	var_7_9.groupId = arg_7_1
	var_7_9.value = var_5:GetInvitationState()
	var_7_9.awards = arg_7_3

	var_7_7(var_7_6, var_7_8, var_7_9)

	return
end

function var_0_1.HandleGiveGift(arg_8_0, arg_8_1, arg_8_2)
	getProxy = var_1_10003
	FeastProxy = var_1_10005

	local var_8_0 = var_1_10003(var_1_10005)
	local var_8_1 = var_3.getRawData(var_8_0)
	local var_8_2 = var_3.GetInvitedFeastShip(var_8_1, arg_8_1)
	local var_8_3 = var_4.GetGiftConsume(var_8_2)

	getProxy = var_8_1
	ActivityProxy = var_1_10008

	local var_8_4 = var_8_1(var_1_10008)
	local var_8_5 = var_6.getActivityByType

	ActivityConst = var_1_10010

	local var_8_6 = var_8_5(var_8_4, var_1_10010.ACTIVITY_TYPE_VIRTUAL_BAG)

	var_7.subVitemNumber(var_8_6, var_8_3.id, var_8_3.count)
	var_6:updateActivity(var_7)

	local var_8_7 = var_4
	local var_8_8 = var_4.SetGiftState

	InvitedFeastShip = var_11

	var_8_8(var_8_7, var_11.GIFT_STATE_GOT)

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.sendNotification

	GAME = var_11

	local var_8_11 = var_11.FEAST_OP_DONE
	local var_8_12 = {}

	FeastDorm = var_1_10013
	var_8_12.cmd = var_1_10013.OP_GIVE_GIFT
	var_8_12.groupId = arg_8_1
	var_8_12.value = var_4:GetGiftState()
	var_8_12.awards = arg_8_2

	var_8_10(var_8_9, var_8_11, var_8_12)

	return
end

return var_0_1
