local var_0_0 = class("FeastGiveTicketPage", import(".FeastGiveGiftPage"))

function var_0_0.BindEvents(arg_1_0)
	arg_1_0.eventId = arg_1_0:bind(FeastScene.ON_GOT_TICKET, function(arg_2_0, arg_2_1)
		arg_1_0:OnGotGift(arg_2_1)

		return
	end)

	return
end

function var_0_0.OnGotGift(arg_3_0, arg_3_1)
	if arg_3_0.feastShip then
		arg_3_0:BlockEvents()
		seriesAsync({
			function(arg_4_0)
				arg_3_0:UpdateGiftState(arg_3_0.feastShip, arg_4_0)

				return
			end,
			function(arg_5_0)
				arg_3_0:emit(BaseUI.ON_ACHIEVE, arg_3_1, arg_5_0)

				return
			end,
			function(arg_6_0)
				pg.NewStoryMgr.GetInstance():Play(arg_3_0.feastShip:GetInvitationStory(), arg_6_0)

				return
			end
		}, function()
			arg_3_0:emit(FeastMediator.ON_SHIP_ENTER_FEAST, arg_3_0.feastShip.id)
			arg_3_0:emit(FeastScene.ON_BACK_FEAST)

			return
		end)
	end

	return
end

function var_0_0.ClearBindEvents(arg_8_0)
	if arg_8_0.eventId then
		arg_8_0:disconnect(arg_8_0.eventId)

		arg_8_0.eventId = nil
	end

	return
end

function var_0_0.LoadItem(arg_9_0, arg_9_1, arg_9_2)
	GetSpriteFromAtlasAsync("ui/FeastInvitation_atlas", "res_icon", function(arg_10_0)
		local var_10_0 = arg_9_0.giftTr:GetComponent(typeof(Image))

		var_10_0.sprite = arg_10_0

		var_10_0:SetNativeSize()
		arg_9_2()

		return
	end)

	return
end

function var_0_0.UpdateGiftState(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:ClearGiftEvent()
	parallelAsync({
		function(arg_12_0)
			arg_11_0:UpdateContent(arg_11_1:GetDialogueForTicket(), 3, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_11_0.loadedChar.spineAnimUI

			if not arg_11_1:GotTicket() then
				setActive(arg_11_0.giftTr, true)
				arg_11_0:AddGiftEvent()
				arg_11_0.loadedChar.spineAnimUI:SetAction("activity_wait", 0)
			else
				setActive(arg_11_0.giftTr, false)
				arg_11_0.loadedChar.spineAnimUI:SetActionCallBack(function(arg_14_0)
					if arg_14_0 == "finish" then
						var_13_0:SetActionCallBack(nil)
						setActive(var_13_0.gameObject, false)
						arg_13_0()
					end

					return
				end)
				arg_11_0.loadedChar.spineAnimUI:SetAction("activity_getletter", 0)
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

function var_0_0.Send(arg_16_0)
	arg_16_0:emit(FeastMediator.GIVE_TICKET, arg_16_0.feastShip.tid)

	return
end

function var_0_0.SetTipContent(arg_17_0)
	arg_17_0.tipTr.text = i18n("feast_drag_invitation_tip")

	return
end

return var_0_0
