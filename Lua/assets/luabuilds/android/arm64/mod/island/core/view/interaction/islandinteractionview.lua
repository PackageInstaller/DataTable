local var_0_0 = class("IslandInteractionView", import("..IslandBaseOpView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandInteractionUI"
end

function var_0_0.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().interactionContainer
end

function var_0_0.OnInit(arg_3_0, arg_3_1)
	arg_3_0.showBalance = 1
	arg_3_0.timers = {}
	arg_3_0.interactionPanel = arg_3_0._tf:Find("interaction_btns")
	arg_3_0.interactionUIItemList = UIItemList.New(arg_3_0.interactionPanel, arg_3_0.interactionPanel:Find("interaction"))

	arg_3_0:ShowInterActionPanel({
		type = -1
	})

	return
end

function var_0_0.ShowInterActionPanel(arg_4_0, arg_4_1)
	arg_4_0:UpdateInteractionBtns(arg_4_1)

	return
end

function var_0_0.UpdateInteractionBtns(arg_5_0, arg_5_1)
	arg_5_0.interactionData = arg_5_1

	local var_5_0 = IslandInteractionUntil.GetInteractionOptions(arg_5_0:GetView():GetIsland(), arg_5_0.interactionData.type, arg_5_0.interactionData.id)

	arg_5_0:RemoveTimers()
	arg_5_0.interactionUIItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]

			arg_6_2.name = var_5_0[arg_6_1 + 1].id

			onButton(arg_5_0, arg_6_2, function()
				if arg_5_0.interactionData.callback then
					arg_5_0.interactionData.callback()
				end

				IslandInteractionUntil.Response(arg_5_0, var_0, var_6_0.id)

				return
			end, SFX_PANEL)
			arg_5_0:SetInteractionText(arg_6_2, var_5_0[arg_6_1 + 1])
		end

		return
	end)
	arg_5_0.interactionUIItemList:align(#IslandInteractionUntil.GetInteractionOptions(arg_5_0:GetView():GetIsland(), arg_5_0.interactionData.type, arg_5_0.interactionData.id))

	return
end

function var_0_0.CloseInterActionPanelByUnitIdRemove(arg_8_0, arg_8_1)
	if not arg_8_0.interactionData then
		return
	end

	if arg_8_0.interactionData.id == arg_8_1 then
		arg_8_0:HideInterActionPanel()
	end

	return
end

function var_0_0.ShowNextInteractionBtns(arg_9_0, arg_9_1)
	arg_9_0.interactionData.type = tonumber(arg_9_1)

	arg_9_0:UpdateInteractionBtns(arg_9_0.interactionData)

	return
end

function var_0_0.SetInteractionText(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2.id == IslandInteractionUntil.SIGNIN_TIME_ID then
		setActive(arg_10_1:Find("time"), true)
		arg_10_0:AddTimer(arg_10_1, arg_10_2)
	else
		setActive(arg_10_1:Find("time"), false)
	end

	setText(arg_10_1:Find("bg/Text"), HXSet.hxLan(arg_10_2.text))
	setImageSprite(arg_10_1:Find("icon_type"), GetSpriteFromAtlas("island/IslandInteractionBtns", tostring(arg_10_2.icon)), true)

	return
end

function var_0_0.AddTimer(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:GetView():GetIsland():GetSignInAgency():GetNextCanSignInTime()
	local var_11_1 = Timer.New(function()
		local var_12_0 = var_11_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_12_0 <= 0 then
			setActive(arg_11_1:Find("time"), false)
			arg_11_0:RemoveTimers()
			arg_11_0:RefreshInteractionBtns()
		else
			setText(arg_11_1:Find("time/Text"), pg.TimeMgr.GetInstance():DescCDTime(var_12_0))
		end

		return
	end, 1, -1)

	arg_11_0.timers[arg_11_2.id] = var_11_1

	arg_11_0.timers[arg_11_2.id].func()
	var_11_1:Start()

	return
end

function var_0_0.RemoveTimers(arg_13_0)
	local var_13_0 = arg_13_0.timers or {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		iter_13_1:Stop()
	end

	arg_13_0.timers = {}

	return
end

function var_0_0.RefreshInteractionBtns(arg_14_0)
	if not arg_14_0.interactionData then
		return
	end

	arg_14_0:UpdateInteractionBtns(arg_14_0.interactionData)

	return
end

function var_0_0.HideInterActionPanel(arg_15_0)
	arg_15_0:RemoveTimers()

	arg_15_0.interactionData = nil

	arg_15_0.interactionUIItemList:align(0)

	return
end

function var_0_0.EnableInteraction(arg_16_0)
	arg_16_0:ShowOrHideGameObject(arg_16_0.interactionPanel, true)

	return
end

function var_0_0.DisableInteraction(arg_17_0)
	arg_17_0:ShowOrHideGameObject(arg_17_0.interactionPanel, false)

	return
end

function var_0_0.OnDestroy(arg_18_0)
	arg_18_0:RemoveTimers()

	return
end

return var_0_0
