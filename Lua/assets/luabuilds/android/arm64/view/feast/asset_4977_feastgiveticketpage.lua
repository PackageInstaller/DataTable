local FeastGiveTicketPage = class("FeastGiveTicketPage", import(".FeastGiveGiftPage"))

function FeastGiveTicketPage:BindEvents()
	self.eventId = self:bind(FeastScene.ON_GOT_TICKET, function(arg_2_0, arg_2_1)
		self:OnGotGift(arg_2_1)

		return
	end)

	return
end

function FeastGiveTicketPage:OnGotGift(arg_3_1)
	if self.feastShip then
		self:BlockEvents()
		seriesAsync({
			function(arg_4_0)
				self:UpdateGiftState(self.feastShip, arg_4_0)

				return
			end,
			function(arg_5_0)
				self:emit(BaseUI.ON_ACHIEVE, arg_3_1, arg_5_0)

				return
			end,
			function(arg_6_0)
				pg.NewStoryMgr.GetInstance():Play(self.feastShip:GetInvitationStory(), arg_6_0)

				return
			end
		}, function()
			self:emit(FeastMediator.ON_SHIP_ENTER_FEAST, self.feastShip.id)
			self:emit(FeastScene.ON_BACK_FEAST)

			return
		end)
	end

	return
end

function FeastGiveTicketPage:ClearBindEvents()
	if self.eventId then
		self:disconnect(self.eventId)

		self.eventId = nil
	end

	return
end

function FeastGiveTicketPage:LoadItem(arg_9_1, arg_9_2)
	GetSpriteFromAtlasAsync("ui/FeastInvitation_atlas", "res_icon", function(arg_10_0)
		local var_10_0 = self.giftTr:GetComponent(typeof(Image))

		var_10_0.sprite = arg_10_0

		var_10_0:SetNativeSize()
		arg_9_2()

		return
	end)

	return
end

function FeastGiveTicketPage:UpdateGiftState(arg_11_1, arg_11_2)
	self:ClearGiftEvent()
	parallelAsync({
		function(arg_12_0)
			self:UpdateContent(arg_11_1:GetDialogueForTicket(), 3, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = self.loadedChar.spineAnimUI

			if not arg_11_1:GotTicket() then
				setActive(self.giftTr, true)
				self:AddGiftEvent()
				self.loadedChar.spineAnimUI:SetAction("activity_wait", 0)
			else
				setActive(self.giftTr, false)
				self.loadedChar.spineAnimUI:SetActionCallBack(function(arg_14_0)
					if arg_14_0 == "finish" then
						var_13_0:SetActionCallBack(nil)
						setActive(var_13_0.gameObject, false)
						arg_13_0()
					end

					return
				end)
				self.loadedChar.spineAnimUI:SetAction("activity_getletter", 0)
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

function FeastGiveTicketPage:Send()
	self:emit(FeastMediator.GIVE_TICKET, self.feastShip.tid)

	return
end

function FeastGiveTicketPage:SetTipContent()
	self.tipTr.text = i18n("feast_drag_invitation_tip")

	return
end

return FeastGiveTicketPage
