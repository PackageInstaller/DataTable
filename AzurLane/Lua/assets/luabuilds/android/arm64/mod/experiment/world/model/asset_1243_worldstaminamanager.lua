class = var_0_10000

local var_0_0 = "WorldStaminaManager"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	staminaExchangeTimes = "number",
	staminaLastRecoverTime = "number",
	staminaExtra = "number",
	transform = "userdata",
	updateTimer = "table",
	preSelectIndex = "number",
	stamina = "number",
	UIMain = "userdata"
}
var_0_1.EventUpdateStamina = "WorldStaminaManager.EventUpdateStamina"

function var_0_1.Build(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)

	pg = var_1
	arg_1_0.UIMain = var_1.UIMgr.GetInstance().OverlayMain
	PoolMgr = var_1

	local var_1_0 = var_1.GetInstance()

	var_1.GetUI(var_1_0, "WorldStaminaRecoverUI", true, function(arg_2_0)
		if not arg_1_0.UIMain then
			local var_2_0 = var_0

			var_1.ReturnUI(var_2_0, "WorldStaminaRecoverUI", arg_2_0)
		else
			local var_2_1 = arg_1_0

			tf = var_2_10002
			var_2_1.transform = var_2_10002(arg_2_0)
			setParent = var_2_1

			var_2_1(arg_1_0.transform, arg_1_0.UIMain, false)

			setActive = var_2_1

			var_2_1(arg_1_0.transform, false)

			onButton = var_2_1

			local var_2_2 = arg_1_0
			local var_2_3 = arg_1_0.transform
			local var_2_4 = var_4.Find(var_2_3, "bg")

			local function var_2_5()
				local var_3_0 = arg_1_0

				var_0.Hide(var_3_0)

				return
			end

			SFX_CANCEL = var_2_3

			var_2_1(var_2_2, var_2_4, var_2_5, var_2_3)

			onButton = var_2_1

			local var_2_6 = arg_1_0
			local var_2_7 = arg_1_0.transform
			local var_2_8 = var_4.Find(var_2_7, "window/top/btnBack")

			local function var_2_9()
				local var_4_0 = arg_1_0

				var_0.Hide(var_4_0)

				return
			end

			SFX_CANCEL = var_2_7

			var_2_1(var_2_6, var_2_8, var_2_9, var_2_7)

			onButton = var_2_1

			local var_2_10 = arg_1_0
			local var_2_11 = arg_1_0.transform
			local var_2_12 = var_4.Find(var_2_11, "window/button_container/custom_button_2")

			local function var_2_13()
				local var_5_0 = arg_1_0

				var_0.Hide(var_5_0)

				return
			end

			SFX_CANCEL = var_2_11

			var_2_1(var_2_10, var_2_12, var_2_13, var_2_11)
		end

		return
	end)

	return
end

function var_0_1.Setup(arg_6_0, arg_6_1)
	arg_6_0.stamina = arg_6_1[1]
	arg_6_0.staminaExtra = arg_6_1[2]
	arg_6_0.staminaLastRecoverTime = arg_6_1[3]
	arg_6_0.staminaExchangeTimes = arg_6_1[4]

	if not arg_6_0.updateTimer then
		Timer = var_2
		arg_6_0.updateTimer = var_2.New(function()
			local var_7_0 = arg_6_0

			var_0.UpdateStamina(var_7_0)

			return
		end, 1, -1)

		local var_6_0 = arg_6_0.updateTimer

		var_2.Start(var_6_0)
		arg_6_0.updateTimer.func()
	end

	return
end

function var_0_1.Dispose(arg_8_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_8_0)

	if arg_8_0.updateTimer then
		local var_8_0 = arg_8_0.updateTimer

		var_1.Stop(var_8_0)
	end

	if arg_8_0.transform then
		PoolMgr = var_1

		local var_8_1 = var_1.GetInstance()
		local var_8_2 = var_1.ReturnUI
		local var_8_3 = "WorldStaminaRecoverUI"

		go = var_1_10005

		var_8_2(var_8_1, var_8_3, var_1_10005(arg_8_0.transform))
	end

	arg_8_0:Clear()

	return
end

function var_0_1.Reset(arg_9_0)
	arg_9_0.stamina = arg_9_0:GetMaxStamina()

	return
end

function var_0_1.ChangeStamina(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.stamina = arg_10_1
	arg_10_0.staminaExtra = arg_10_2

	arg_10_0:DispatchEvent(var_0_1.EventUpdateStamina)

	return
end

function var_0_1.UpdateStamina(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.gameset.world_movepower_recovery_interval.key_value

	pg = var_1_10002

	local var_11_1 = var_1_10002.TimeMgr.GetInstance()
	local var_11_2 = var_2.GetServerTime(var_11_1)

	math = var_1_10003

	if var_1_10003.floor((var_11_2 - arg_11_0.staminaLastRecoverTime) / var_11_0) > 0 then
		arg_11_0.staminaLastRecoverTime = arg_11_0.staminaLastRecoverTime + var_3 * var_11_0

		if arg_11_0.stamina < arg_11_0:GetMaxStamina() then
			math = var_4
			arg_11_0.stamina = var_4.min(arg_11_0.stamina + var_3, arg_11_0:GetMaxStamina())

			arg_11_0:DispatchEvent(var_0_1.EventUpdateStamina)
		end
	end

	return
end

function var_0_1.CheckUpdateShow(arg_12_0)
	if arg_12_0:IsShowing() then
		arg_12_0:Show()
	end

	return
end

function var_0_1.Show(arg_13_0)
	local var_13_0 = arg_13_0.transform
	local var_13_1 = var_1.Find(var_13_0, "window/world_stamina_panel")

	pg = var_1_10002

	local var_13_2 = var_1_10002.gameset.world_movepower_recovery_interval.key_value

	string = var_13_0

	local var_13_3 = var_13_0.format
	local var_13_4 = "%.2d:%.2d:%.2d"

	math = var_1_10006

	local var_13_5 = var_1_10006.floor(var_13_2 / 16)

	math = var_1_10007

	local var_13_6 = var_13_3(var_13_4, var_13_5, var_1_10007.floor(var_13_2 % 16 / 60), var_13_2 % 60)

	setText = var_4

	local var_13_7 = var_13_1:Find("content/tip_bg/tip")

	i18n = var_7

	var_4(var_13_7, var_7("world_stamina_recover", var_13_6))

	setText = var_4

	var_4(var_13_1:Find("content/tip_bg/stamina/value"), arg_13_0:GetTotalStamina())

	local var_13_8 = var_13_1
	local var_13_9 = var_13_1.Find(var_13_8, "content/item_list")
	local var_13_10 = var_13_1
	local var_13_11 = var_13_1.Find(var_13_10, "item")

	setActive = var_13_8

	var_13_8(var_13_11, false)

	local var_13_12 = arg_13_0.transform
	local var_13_13 = var_6.Find(var_13_12, "window/button_container/custom_button_1")

	removeAllChildren = var_13_10

	var_13_10(var_13_9)

	local var_13_14 = arg_13_0:GetExchangeItems()

	ipairs = var_13_12

	for iter_13_0, iter_13_1 in var_13_12(var_13_14) do
		cloneTplTo = var_1_10013
		var_1_10013 = var_1_10013(var_13_11, var_13_9)
		updateDrop = var_1_10014

		var_1_10014(var_1_10013:Find("IconTpl"), iter_13_1.drop)

		setText = var_1_10014

		local var_13_15 = var_1_10013:Find("IconTpl/icon_bg/count")
		local var_13_16

		if not iter_13_1.drop.count or not iter_13_1.drop.count then
			var_13_16 = ""
		end

		var_1_10014(var_13_15, var_13_16)

		setText = var_1_10014

		local var_13_17 = var_1_10013:Find("name/Text")

		shortenString = var_13_16
		getText = var_19

		var_1_10014(var_13_17, var_13_16(var_19(var_1_10013:Find("IconTpl/name")), 5))

		onToggle = var_1_10014

		local var_13_18 = arg_13_0
		local var_13_19 = var_1_10013

		local function var_13_20(arg_14_0)
			if arg_14_0 then
				arg_13_0.preSelectIndex = iter_13_0

				if iter_13_0 > 1 then
					setText = var_1

					local var_14_0 = var_13_1
					local var_14_1 = var_3.Find(var_14_0, "content/Text")

					i18n = var_2_10004

					var_1(var_14_1, var_2_10004("world_stamina_text2", iter_13_1.name, iter_13_1.stamina))

					onButton = var_1

					local var_14_2 = arg_13_0

					var_2_10004 = var_13_13

					local function var_14_3()
						local var_15_0

						if iter_13_1.drop.count == 0 then
							pg = var_15_0
							var_3_10002 = var_15_0.TipsMgr.GetInstance()
							var_15_0 = var_15_0.ShowTips
							i18n = var_3_10003

							var_15_0(var_3_10002, var_3_10003("common_no_item_1"))
						else
							nowWorld = var_15_0

							local var_15_1 = var_15_0()
							local var_15_2 = {}

							pg = var_3_10002

							local var_15_3 = var_3_10002.TimeMgr.GetInstance()
							local var_15_4 = var_2.CurrentSTimeDesc(var_15_3, "%Y/%m/%d")
							local var_15_6

							if var_15_1:CheckResetProgress() then
								PlayerPrefs = var_15_6

								if var_15_6.GetString("world_stamina_reset_tip", "") ~= var_15_4 and var_15_1:GetResetWaitingTime() < 0 then
									local var_15_5 = arg_13_0

									var_15_6 = var_15_6.GetTotalStamina(var_15_5) + iter_13_1.stamina

									local var_15_7 = arg_13_0

									if var_15_6 > var_4.GetMaxStamina(var_15_7) then
										PlayerPrefs = var_15_6

										var_15_6.SetString("world_stamina_reset_tip", var_15_4)

										table = var_15_6

										var_15_6.insert(var_15_2, function(arg_16_0)
											pg = var_4_10001

											local var_16_0 = var_4_10001.MsgboxMgr.GetInstance()
											local var_16_1 = var_1.ShowMsgBox
											local var_16_2 = {}

											i18n = var_4_10005

											local var_16_3 = "world_stamina_resetwarning"
											local var_16_4 = arg_13_0

											var_16_2.content = var_4_10005(var_16_3, var_8.GetMaxStamina(var_16_4))
											var_16_2.onYes = arg_16_0

											var_16_1(var_16_0, var_16_2)

											return
										end)
									end
								end
							end

							seriesAsync = var_15_6

							var_15_6(var_15_2, function()
								pg = var_4_10000

								local var_17_0 = var_4_10000.m02
								local var_17_1 = var_0.sendNotification

								GAME = var_4_10003

								var_17_1(var_17_0, var_4_10003.WORLD_ITEM_USE, {
									count = 1,
									itemID = iter_13_1.drop.id,
									args = {}
								})

								return
							end)
						end

						return
					end

					SFX_CONFIRM = var_6

					var_1(var_14_2, var_2_10004, var_14_3, var_6)
				elseif iter_13_0 == 1 then
					setText = var_1

					local var_14_4 = var_13_1
					local var_14_5 = var_3.Find(var_14_4, "content/Text")

					i18n = var_2_10004

					var_1(var_14_5, var_2_10004("world_stamina_text", iter_13_1.cost, iter_13_1.stamina, iter_13_1.times, iter_13_1.limit))

					onButton = var_1

					local var_14_6 = arg_13_0
					local var_14_7 = var_13_13

					local function var_14_8()
						if iter_13_1.drop.count < iter_13_1.cost then
							pg = var_0
							var_3_10002 = var_0.TipsMgr.GetInstance()

							local var_18_0 = var_0.ShowTips

							i18n = var_3_10003

							var_18_0(var_3_10002, var_3_10003("common_no_oil"))
						else
							local var_18_1

							if iter_13_1.times == 0 then
								pg = var_18_1
								var_3_10002 = var_18_1.TipsMgr.GetInstance()
								var_18_1 = var_18_1.ShowTips
								i18n = var_3_10003

								var_18_1(var_3_10002, var_3_10003("buy_countLimit"))
							else
								nowWorld = var_18_1

								local var_18_2 = var_18_1()
								local var_18_3 = {}

								pg = var_3_10002

								local var_18_4 = var_3_10002.TimeMgr.GetInstance()
								local var_18_5 = var_2.CurrentSTimeDesc(var_18_4, "%Y/%m/%d")
								local var_18_7

								if var_18_2:CheckResetProgress() then
									PlayerPrefs = var_18_7

									if var_18_7.GetString("world_stamina_reset_tip", "") ~= var_18_5 and var_18_2:GetResetWaitingTime() < 0 then
										local var_18_6 = arg_13_0

										var_18_7 = var_18_7.GetTotalStamina(var_18_6) + iter_13_1.stamina

										local var_18_8 = arg_13_0

										if var_18_7 > var_4.GetMaxStamina(var_18_8) then
											PlayerPrefs = var_18_7

											var_18_7.SetString("world_stamina_reset_tip", var_18_5)

											table = var_18_7

											var_18_7.insert(var_18_3, function(arg_19_0)
												pg = var_4_10001

												local var_19_0 = var_4_10001.MsgboxMgr.GetInstance()
												local var_19_1 = var_1.ShowMsgBox
												local var_19_2 = {}

												i18n = var_4_10005

												local var_19_3 = "world_stamina_resetwarning"
												local var_19_4 = arg_13_0

												var_19_2.content = var_4_10005(var_19_3, var_8.GetMaxStamina(var_19_4))
												var_19_2.onYes = arg_19_0

												var_19_1(var_19_0, var_19_2)

												return
											end)
										end
									end
								end

								seriesAsync = var_18_7

								var_18_7(var_18_3, function()
									pg = var_4_10000

									local var_20_0 = var_4_10000.m02
									local var_20_1 = var_0.sendNotification

									GAME = var_4_10003

									var_20_1(var_20_0, var_4_10003.WORLD_STAMINA_EXCHANGE)

									return
								end)
							end
						end

						return
					end

					SFX_CONFIRM = var_6

					var_1(var_14_6, var_14_7, var_14_8, var_6)
				end
			end

			return
		end

		SFX_PANEL = var_19

		var_1_10014(var_13_18, var_13_19, var_13_20, var_19)
	end

	local var_13_21

	if arg_13_0.preSelectIndex then
		triggerToggle = var_13_21

		var_13_21(var_13_9:GetChild(arg_13_0.preSelectIndex - 1), true)
	else
		var_13_21 = 1

		for iter_13_2 = 2, #var_13_14 do
			if var_13_14[iter_13_2].drop.count > 0 then
				var_13_21 = iter_13_2

				break
			end
		end

		triggerToggle = var_9

		var_9(var_13_9:GetChild(var_13_21 - 1), true)
	end

	setActive = var_13_21

	var_13_21(arg_13_0.transform, true)

	pg = var_13_21

	local var_13_22 = var_13_21.UIMgr.GetInstance()

	var_8.BlurPanel(var_13_22, arg_13_0.transform)

	return
end

function var_0_1.Hide(arg_21_0)
	arg_21_0.preSelectIndex = nil
	setActive = var_1

	var_1(arg_21_0.transform, false)

	pg = var_1

	local var_21_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_0, arg_21_0.transform, arg_21_0.UIMain)

	return
end

function var_0_1.IsShowing(arg_22_0)
	if arg_22_0.transform then
		isActive = var_1

		local var_22_0

		if not var_1(arg_22_0.transform) then
			var_22_0 = false
		end

		return var_22_0
	end
end

function var_0_1.GetStamina(arg_23_0)
	return arg_23_0.stamina
end

function var_0_1.GetMaxStamina(arg_24_0)
	pg = var_1_10001

	return var_1_10001.gameset.world_movepower_maxvalue.key_value
end

function var_0_1.GetExtraStamina(arg_25_0)
	return arg_25_0.staminaExtra
end

function var_0_1.GetTotalStamina(arg_26_0)
	return arg_26_0:GetStamina() + arg_26_0:GetExtraStamina()
end

function var_0_1.GetStepStaminaCost(arg_27_0)
	pg = var_1_10001

	return var_1_10001.gameset.world_cell_cost_movepower.key_value
end

function var_0_1.GetMaxMoveStep(arg_28_0)
	math = var_1_10001

	return var_1_10001.floor(arg_28_0:GetTotalStamina() / arg_28_0:GetStepStaminaCost())
end

function var_0_1.ConsumeStamina(arg_29_0, arg_29_1)
	arg_29_0.staminaExtra = arg_29_0.staminaExtra - arg_29_1

	if arg_29_0.staminaExtra < 0 then
		arg_29_0.stamina = arg_29_0.stamina + arg_29_0.staminaExtra
		arg_29_0.staminaExtra = 0
	end

	assert = var_2

	var_2(arg_29_0.stamina >= 0, "out of stamina.")
	arg_29_0:DispatchEvent(var_0_1.EventUpdateStamina)

	return
end

function var_0_1.GetExchangeData(arg_30_0)
	pg = var_1_10001

	local var_30_0 = var_1_10001.gameset.world_supply_value.description

	pg = var_1_10002

	local var_30_1 = var_1_10002.gameset.world_supply_price.description

	math = var_1_10003

	local var_30_2 = var_30_0[var_1_10003.min(#var_30_0, arg_30_0.staminaExchangeTimes + 1)]

	math = var_1_10004

	local var_30_3 = var_30_1[var_1_10004.min(#var_30_1, arg_30_0.staminaExchangeTimes + 1)]

	return var_30_2[1], var_30_3[3], #var_30_1 - arg_30_0.staminaExchangeTimes, #var_30_1
end

function var_0_1.GetExchangeItems(arg_31_0)
	nowWorld = var_1_10001

	local var_31_0 = var_1_10001()
	local var_31_1 = var_1.GetInventoryProxy(var_31_0)
	local var_31_2, var_31_3, var_31_4, var_31_5 = arg_31_0:GetExchangeData()
	local var_31_6 = {}
	local var_31_7 = {}

	Drop = var_1_10008

	local var_31_8 = var_1_10008.New
	local var_31_9 = {}

	PlayerConst = var_1_10011
	var_31_9.id = var_1_10011.ResOil
	DROP_TYPE_RESOURCE = var_11
	var_31_9.type = var_11
	getProxy = var_11
	PlayerProxy = var_1_10013

	local var_31_10 = var_11(var_1_10013)

	var_31_9.count = var_11.getRawData(var_31_10).oil
	var_31_7.drop = var_31_8(var_31_9)
	var_31_7.cost = var_31_3
	var_31_7.stamina = var_31_2
	var_31_7.times = var_31_4
	var_31_7.limit = var_31_5
	var_31_6[1] = var_31_7
	ipairs = var_31_7
	pg = var_1_10009

	for iter_31_0, iter_31_1 in var_31_7(var_1_10009.gameset.world_supply_itemlist.description) do
		Drop = var_1_10012
		var_1_10012 = var_1_10012.New

		local var_31_11 = {}

		DROP_TYPE_WORLD_ITEM = var_1_10015
		var_31_11.type = var_1_10015
		var_31_11.id = iter_31_1
		var_31_11.count = var_31_1:GetItemCount(iter_31_1)
		var_1_10012 = var_1_10012(var_31_11)
		table = var_31_10
		var_31_10 = var_31_10.insert
		var_1_10015 = var_31_6

		local var_31_12 = {
			cost = 1,
			drop = var_1_10012,
			name = var_1_10012:getConfig("name")
		}
		local var_31_13 = var_1_10012:getSubClass()

		var_31_12.stamina = var_17.getItemStaminaRecover(var_31_13)

		var_31_10(var_1_10015, var_31_12)
	end

	return var_31_6
end

function var_0_1.ExchangeStamina(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.stamina = arg_32_0.stamina + arg_32_1

	if arg_32_2 then
		arg_32_0.staminaExchangeTimes = arg_32_0.staminaExchangeTimes + 1
	end

	arg_32_0:DispatchEvent(var_0_1.EventUpdateStamina)
	arg_32_0:CheckUpdateShow()

	return
end

function var_0_1.GetDisplayStanima(arg_33_0)
	return arg_33_0:GetTotalStamina()
end

return var_0_1
