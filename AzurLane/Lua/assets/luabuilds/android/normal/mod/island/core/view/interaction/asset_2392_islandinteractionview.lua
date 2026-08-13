class = var_0_10000

local var_0_0 = "IslandInteractionView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..IslandBaseOpView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandInteractionUI"
end

function var_0_1.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().interactionContainer
end

function var_0_1.OnInit(arg_3_0, arg_3_1)
	arg_3_0.showBalance = 1
	arg_3_0.timers = {}

	local var_3_0 = arg_3_0._tf

	arg_3_0.interactionPanel = var_2.Find(var_3_0, "interaction_btns")
	UIItemList = var_2

	local var_3_1 = var_2.New
	local var_3_2 = arg_3_0.interactionPanel
	local var_3_3 = arg_3_0.interactionPanel

	arg_3_0.interactionUIItemList = var_3_1(var_3_2, var_4.Find(var_3_3, "interaction"))

	arg_3_0:ShowInterActionPanel({
		type = -1
	})

	return
end

function var_0_1.ShowInterActionPanel(arg_4_0, arg_4_1)
	arg_4_0:UpdateInteractionBtns(arg_4_1)

	return
end

function var_0_1.UpdateInteractionBtns(arg_5_0, arg_5_1)
	arg_5_0.interactionData = arg_5_1

	local var_5_0 = arg_5_0.interactionData.id

	IslandInteractionUntil = var_1_10003

	local var_5_1 = var_1_10003.GetInteractionOptions
	local var_5_2 = arg_5_0:GetView()
	local var_5_3 = var_5_1(var_4.GetIsland(var_5_2), arg_5_0.interactionData.type, var_5_0)

	arg_5_0:RemoveTimers()

	local var_5_4 = arg_5_0.interactionUIItemList

	var_4.make(var_5_4, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			arg_6_2.name = var_5_3[arg_6_1 + 1].id
			onButton = var_4

			local var_6_0 = arg_5_0
			local var_6_1 = arg_6_2

			local function var_6_2()
				if arg_5_0.interactionData.callback then
					arg_5_0.interactionData.callback()
				end

				IslandInteractionUntil = var_0

				var_0.Response(arg_5_0, var_5_0, var_0.id)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_6_0, var_6_1, var_6_2, var_2_10008)

			local var_6_3 = arg_5_0

			var_4.SetInteractionText(var_6_3, arg_6_2, var_3)
		end

		return
	end)

	local var_5_5 = arg_5_0.interactionUIItemList

	var_4.align(var_5_5, #var_5_3)

	return
end

function var_0_1.CloseInterActionPanelByUnitIdRemove(arg_8_0, arg_8_1)
	if not arg_8_0.interactionData then
		return
	end

	if arg_8_0.interactionData.id == arg_8_1 then
		arg_8_0:HideInterActionPanel()
	end

	return
end

function var_0_1.ShowNextInteractionBtns(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.interactionData

	tonumber = var_1_10003
	var_9_0.type = var_1_10003(arg_9_1)

	arg_9_0:UpdateInteractionBtns(arg_9_0.interactionData)

	return
end

function var_0_1.SetInteractionText(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.id

	IslandInteractionUntil = var_1_10004

	if var_10_0 == var_1_10004.SIGNIN_TIME_ID then
		setActive = var_10_0

		var_10_0(arg_10_1:Find("time"), true)
		arg_10_0:AddTimer(arg_10_1, arg_10_2)
	else
		setActive = var_10_0

		var_10_0(arg_10_1:Find("time"), false)
	end

	setText = var_10_0

	local var_10_1 = arg_10_1
	local var_10_2 = arg_10_1.Find(var_10_1, "bg/Text")

	HXSet = var_10_1

	var_10_0(var_10_2, var_10_1.hxLan(arg_10_2.text))

	GetSpriteFromAtlas = var_10_0

	local var_10_3 = "island/IslandInteractionBtns"

	tostring = var_5

	local var_10_4 = var_10_0(var_10_3, var_5(arg_10_2.icon))

	setImageSprite = var_10_3

	var_10_3(arg_10_1:Find("icon_type"), var_10_4, true)

	return
end

function var_0_1.AddTimer(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:GetView()
	local var_11_1 = var_3.GetIsland(var_11_0)
	local var_11_2 = var_3.GetSignInAgency(var_11_1)
	local var_11_3 = var_3.GetNextCanSignInTime(var_11_2)

	Timer = var_11_2

	local var_11_4 = var_11_2.New(function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.TimeMgr.GetInstance()
		local var_12_1 = var_0.GetServerTime(var_12_0)

		if var_11_3 - var_12_1 <= 0 then
			setActive = var_2

			local var_12_2 = arg_11_1

			var_2(var_3.Find(var_12_2, "time"), false)

			local var_12_3 = arg_11_0

			var_2.RemoveTimers(var_12_3)

			local var_12_4 = arg_11_0

			var_2.RefreshInteractionBtns(var_12_4)
		else
			setText = var_2

			local var_12_5 = arg_11_1
			local var_12_6 = var_3.Find(var_12_5, "time/Text")

			pg = var_12_5

			local var_12_7 = var_12_5.TimeMgr.GetInstance()

			var_2(var_12_6, var_4.DescCDTime(var_12_7, var_1))
		end

		return
	end, 1, -1)

	arg_11_0.timers[arg_11_2.id] = var_11_4

	arg_11_0.timers[arg_11_2.id].func()
	var_11_4:Start()

	return
end

function var_0_1.RemoveTimers(arg_13_0)
	pairs = var_1_10001

	local var_13_0

	if not arg_13_0.timers then
		var_13_0 = {}
	end

	for iter_13_0, iter_13_1 in var_1_10001(var_13_0) do
		iter_13_1:Stop()
	end

	arg_13_0.timers = {}

	return
end

function var_0_1.RefreshInteractionBtns(arg_14_0)
	if not arg_14_0.interactionData then
		return
	end

	arg_14_0:UpdateInteractionBtns(arg_14_0.interactionData)

	return
end

function var_0_1.HideInterActionPanel(arg_15_0)
	arg_15_0:RemoveTimers()

	arg_15_0.interactionData = nil

	local var_15_0 = arg_15_0.interactionUIItemList

	var_1.align(var_15_0, 0)

	return
end

function var_0_1.EnableInteraction(arg_16_0)
	arg_16_0:ShowOrHideGameObject(arg_16_0.interactionPanel, true)

	return
end

function var_0_1.DisableInteraction(arg_17_0)
	arg_17_0:ShowOrHideGameObject(arg_17_0.interactionPanel, false)

	return
end

function var_0_1.OnDestroy(arg_18_0)
	arg_18_0:RemoveTimers()

	return
end

return var_0_1
