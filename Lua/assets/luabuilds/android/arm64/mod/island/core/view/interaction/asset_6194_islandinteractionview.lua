local IslandInteractionView = class("IslandInteractionView", import("..IslandBaseOpView"))

function IslandInteractionView:GetUIName()
	return "IslandInteractionUI"
end

function IslandInteractionView:GetUIParent(arg_2_1)
	return self:GetView().interactionContainer
end

function IslandInteractionView:OnInit(arg_3_1)
	self.showBalance = 1
	self.timers = {}
	self.interactionPanel = self._tf:Find("interaction_btns")
	self.interactionUIItemList = UIItemList.New(self.interactionPanel, self.interactionPanel:Find("interaction"))

	self:ShowInterActionPanel({
		type = -1
	})

	return
end

function IslandInteractionView:ShowInterActionPanel(arg_4_1)
	self:UpdateInteractionBtns(arg_4_1)

	return
end

function IslandInteractionView:UpdateInteractionBtns(arg_5_1)
	self.interactionData = arg_5_1

	local var_5_0 = self.interactionData.id
	local var_5_1 = IslandInteractionUntil.GetInteractionOptions(self:GetView():GetIsland(), self.interactionData.type, self.interactionData.id)

	self:RemoveTimers()
	self.interactionUIItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = var_5_1[arg_6_1 + 1]

			arg_6_2.name = var_5_1[arg_6_1 + 1].id

			onButton(self, arg_6_2, function()
				if self.interactionData.callback then
					self.interactionData.callback()
				end

				IslandInteractionUntil.Response(self, var_5_0, var_6_0.id)

				return
			end, SFX_PANEL)
			self:SetInteractionText(arg_6_2, var_5_1[arg_6_1 + 1])
		end

		return
	end)
	self.interactionUIItemList:align(#var_5_1)

	return
end

function IslandInteractionView:CloseInterActionPanelByUnitIdRemove(arg_8_1)
	if not self.interactionData then
		return
	end

	if self.interactionData.id == arg_8_1 then
		self:HideInterActionPanel()
	end

	return
end

function IslandInteractionView:ShowNextInteractionBtns(arg_9_1)
	self.interactionData.type = tonumber(arg_9_1)

	self:UpdateInteractionBtns(self.interactionData)

	return
end

function IslandInteractionView:SetInteractionText(arg_10_1, arg_10_2)
	if arg_10_2.id == IslandInteractionUntil.SIGNIN_TIME_ID then
		setActive(arg_10_1:Find("time"), true)
		self:AddTimer(arg_10_1, arg_10_2)
	else
		setActive(arg_10_1:Find("time"), false)
	end

	setText(arg_10_1:Find("bg/Text"), HXSet.hxLan(arg_10_2.text))
	setImageSprite(arg_10_1:Find("icon_type"), GetSpriteFromAtlas("island/IslandInteractionBtns", tostring(arg_10_2.icon)), true)

	return
end

function IslandInteractionView:AddTimer(arg_11_1, arg_11_2)
	local var_11_0 = self:GetView():GetIsland():GetSignInAgency():GetNextCanSignInTime()
	local var_11_1 = Timer.New(function()
		local var_12_0 = var_11_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_12_0 <= 0 then
			setActive(arg_11_1:Find("time"), false)
			self:RemoveTimers()
			self:RefreshInteractionBtns()
		else
			setText(arg_11_1:Find("time/Text"), pg.TimeMgr.GetInstance():DescCDTime(var_12_0))
		end

		return
	end, 1, -1)

	self.timers[arg_11_2.id] = var_11_1

	self.timers[arg_11_2.id].func()
	var_11_1:Start()

	return
end

function IslandInteractionView:RemoveTimers()
	for iter_13_0, iter_13_1 in pairs(self.timers or {}) do
		iter_13_1:Stop()
	end

	self.timers = {}

	return
end

function IslandInteractionView:RefreshInteractionBtns()
	if not self.interactionData then
		return
	end

	self:UpdateInteractionBtns(self.interactionData)

	return
end

function IslandInteractionView:HideInterActionPanel()
	self:RemoveTimers()

	self.interactionData = nil

	self.interactionUIItemList:align(0)

	return
end

function IslandInteractionView:EnableInteraction()
	self:ShowOrHideGameObject(self.interactionPanel, true)

	return
end

function IslandInteractionView:DisableInteraction()
	self:ShowOrHideGameObject(self.interactionPanel, false)

	return
end

function IslandInteractionView:OnDestroy()
	self:RemoveTimers()

	return
end

return IslandInteractionView
