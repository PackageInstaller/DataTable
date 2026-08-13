class = var_0_10000

local var_0_0 = "FeastGiveTicketPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".FeastGiveGiftPage"))

function var_0_1.BindEvents(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	FeastScene = var_1_10004
	arg_1_0.eventId = var_1_1(var_1_0, var_1_10004.ON_GOT_TICKET, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.OnGotGift(var_2_0, arg_2_1)

		return
	end)

	return
end

function var_0_1.OnGotGift(arg_3_0, arg_3_1)
	if arg_3_0.feastShip then
		arg_3_0:BlockEvents()

		seriesAsync = var_2

		var_2({
			function(arg_4_0)
				local var_4_0 = arg_3_0

				var_1.UpdateGiftState(var_4_0, arg_3_0.feastShip, arg_4_0)

				return
			end,
			function(arg_5_0)
				local var_5_0 = arg_3_0
				local var_5_1 = var_1.emit

				BaseUI = var_2_10004

				var_5_1(var_5_0, var_2_10004.ON_ACHIEVE, arg_3_1, arg_5_0)

				return
			end,
			function(arg_6_0)
				local var_6_0 = arg_3_0.feastShip
				local var_6_1 = var_1.GetInvitationStory(var_6_0)

				pg = var_2_10002

				local var_6_2 = var_2_10002.NewStoryMgr.GetInstance()

				var_2.Play(var_6_2, var_6_1, arg_6_0)

				return
			end
		}, function()
			local var_7_0 = arg_3_0
			local var_7_1 = var_0.emit

			FeastMediator = var_2_10003

			var_7_1(var_7_0, var_2_10003.ON_SHIP_ENTER_FEAST, arg_3_0.feastShip.id)

			local var_7_2 = arg_3_0
			local var_7_3 = var_0.emit

			FeastScene = var_3

			var_7_3(var_7_2, var_3.ON_BACK_FEAST)

			return
		end)
	end

	return
end

function var_0_1.ClearBindEvents(arg_8_0)
	if arg_8_0.eventId then
		arg_8_0:disconnect(arg_8_0.eventId)

		arg_8_0.eventId = nil
	end

	return
end

function var_0_1.LoadItem(arg_9_0, arg_9_1, arg_9_2)
	GetSpriteFromAtlasAsync = var_1_10003

	var_1_10003("ui/FeastInvitation_atlas", "res_icon", function(arg_10_0)
		local var_10_0 = arg_9_0.giftTr
		local var_10_1 = var_1.GetComponent

		typeof = var_2_10004
		Image = var_2_10006

		local var_10_2 = var_10_1(var_10_0, var_2_10004(var_2_10006))

		var_10_2.sprite = arg_10_0

		var_10_2:SetNativeSize()
		arg_9_2()

		return
	end)

	return
end

function var_0_1.UpdateGiftState(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:ClearGiftEvent()

	parallelAsync = var_3

	var_3({
		function(arg_12_0)
			local var_12_0 = arg_11_0
			local var_12_1 = var_1.UpdateContent
			local var_12_2 = arg_11_1

			var_12_1(var_12_0, var_4.GetDialogueForTicket(var_12_2), 3, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_11_0.loadedChar.spineAnimUI
			local var_13_1 = arg_11_1

			if not var_2.GotTicket(var_13_1) then
				setActive = var_2

				var_2(arg_11_0.giftTr, true)

				local var_13_2 = arg_11_0

				var_2.AddGiftEvent(var_13_2)
				var_13_0:SetAction("activity_wait", 0)
			else
				setActive = var_2

				var_2(arg_11_0.giftTr, false)
				var_13_0:SetActionCallBack(function(arg_14_0)
					if arg_14_0 == "finish" then
						local var_14_0 = var_13_0

						var_1.SetActionCallBack(var_14_0, nil)

						setActive = var_1

						var_1(var_13_0.gameObject, false)
						arg_13_0()
					end

					return
				end)
				var_13_0:SetAction("activity_getletter", 0)
			end

			return
		end
	}, function()
		if arg_11_2 then
			arg_11_2()
		end

		return
	end)

	return
end

function var_0_1.Send(arg_16_0)
	local var_16_0 = arg_16_0.feastShip
	local var_16_1 = arg_16_0
	local var_16_2 = arg_16_0.emit

	FeastMediator = var_1_10005

	var_16_2(var_16_1, var_1_10005.GIVE_TICKET, var_16_0.tid)

	return
end

function var_0_1.SetTipContent(arg_17_0)
	local var_17_0 = arg_17_0.tipTr

	i18n = var_1_10002
	var_17_0.text = var_1_10002("feast_drag_invitation_tip")

	return
end

return var_0_1
