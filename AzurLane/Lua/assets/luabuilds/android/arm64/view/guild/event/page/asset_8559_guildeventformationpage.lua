class = var_0_10000

local var_0_0 = "GuildEventFormationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "GuildEventFormationUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.tpl = var_1.Find(var_2_0, "ShipCardTpl")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "frame/close")

	local var_2_2 = arg_2_0._tf

	arg_2_0.sendBtn = var_1.Find(var_2_2, "frame/btn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.sendBtnGray = var_1.Find(var_2_3, "frame/btn/gray")

	local var_2_4 = {}
	local var_2_5 = arg_2_0._tf

	var_2_4[1] = var_2.Find(var_2_5, "frame/ship1")

	local var_2_6 = arg_2_0._tf

	var_2_4[2] = var_2.Find(var_2_6, "frame/ship2")
	arg_2_0.slots = var_2_4
	arg_2_0.items = {}
	arg_2_0.cdTimer = {}

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		arg_3_0.contextData.editFleet = nil

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		arg_3_0.contextData.editFleet = nil

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.OnFleetUpdated(arg_6_0, arg_6_1)
	arg_6_0.extraData.fleet = arg_6_1

	arg_6_0:UpdateSlots()

	return
end

function var_0_1.OnFleetFormationDone(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.slots) do
		arg_7_0:RefreshCdTimer(iter_7_0)
	end

	arg_7_0:UpdateSendBtn()

	return
end

function var_0_1.OnShow(arg_8_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	if not var_1_10001(var_1_10003).isFetchAssaultFleet then
		local var_8_0 = arg_8_0
		local var_8_1 = arg_8_0.emit

		GuildEventMediator = var_1_10004

		var_8_1(var_8_0, var_1_10004.ON_GET_FORMATION)
	else
		arg_8_0:UpdateSlots()
	end

	arg_8_0:UpdateSendBtn()

	return
end

function var_0_1.UpdateSendBtn(arg_9_0)
	if arg_9_0.contextData.editFleet then
		if arg_9_0.contextData.editFleet then
			local var_9_0 = arg_9_0.extraData.fleet
			local var_9_1 = not var_1.AnyShipChanged(var_9_0, arg_9_0.contextData.editFleet)
		end

		if false then
			var_9_1 = false
		end
	else
		var_9_1 = true
	end

	setActive = var_1_10002

	var_1_10002(arg_9_0.sendBtnGray, var_9_1)

	if var_9_1 then
		removeOnButton = var_1_10002

		var_1_10002(arg_9_0.sendBtn)

		return
	end

	onButton = var_1_10002

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.sendBtn

	local function var_9_4()
		if arg_9_0.existBossBattle then
			pg = var_0

			local var_10_0 = var_0.TipsMgr.GetInstance()
			local var_10_1 = var_0.ShowTips

			i18n = var_2_10003

			var_10_1(var_10_0, var_2_10003("guild_formation_erro_in_boss_battle"))

			return
		end

		local var_10_2 = arg_9_0
		local var_10_3 = var_0.emit

		GuildEventMediator = var_2_10003

		var_10_3(var_10_2, var_2_10003.UPDATE_FORMATION)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_9_2, var_9_3, var_9_4, var_1_10007)

	return
end

function var_0_1.UpdateSlots(arg_11_0)
	local var_11_0

	if not arg_11_0.contextData.editFleet then
		var_11_0 = arg_11_0.extraData.fleet
	end

	arg_11_0.fleet = var_11_0

	local var_11_1 = arg_11_0.fleet
	local var_11_2 = arg_11_0.guild
	local var_11_3

	var_11_3 = var_2.GetActiveEvent(var_11_2) and var_3:GetBossMission() and var_4:IsActive()
	arg_11_0.existBossBattle = var_11_3
	ipairs = var_11_3

	for iter_11_0, iter_11_1 in var_11_3(arg_11_0.slots) do
		local var_11_4 = arg_11_0.fleet
		local var_11_5 = var_10.GetShipByPos(var_11_4, iter_11_0)

		arg_11_0:UpdateSlot(iter_11_0, iter_11_1, var_11_5)
		arg_11_0:RefreshCdTimer(iter_11_0)
	end

	return
end

function var_0_1.ShipIsBattle(arg_12_0, arg_12_1)
	return arg_12_0.existBossBattle
end

function var_0_1.UpdateSlot(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0.guild
	local var_13_1 = arg_13_2
	local var_13_2 = arg_13_2.Find(var_13_1, "ship")
	local var_13_3 = arg_13_2
	local var_13_4 = arg_13_2.Find(var_13_3, "tag/tag")

	if arg_13_3 then
		if not var_13_2 then
			cloneTplTo = var_13_1
			var_13_2 = var_13_1(arg_13_0.tpl, arg_13_2)
			setActive = var_13_1

			var_13_1(var_13_2, true)
			var_13_2:SetAsFirstSibling()
		end

		if not arg_13_0.items[arg_13_1] then
			DockyardShipItem = var_13_3
			var_13_1 = var_13_3.New(var_13_2)
		end

		local var_13_5 = var_13_1

		var_13_3 = var_13_1.update
		GuildAssaultShip = var_1_10011

		var_13_3(var_13_5, var_1_10011.ConverteFromShip(arg_13_3))

		var_13_3 = var_13_1.go
		var_13_3.name = "ship"
		setActive = var_13_3

		local var_13_6 = var_13_4

		var_1_10013 = arg_13_0

		var_13_3(var_13_6, arg_13_0.ShipIsBattle(var_1_10013, arg_13_3))
	elseif var_13_2 then
		setActive = var_13_1

		var_13_1(var_13_2, false)

		setActive = var_13_1

		var_13_1(var_13_4, false)
	else
		setActive = var_13_1

		var_13_1(var_13_4, false)
	end

	local var_13_7 = arg_13_3 and var_13_2 or arg_13_2

	onButton = var_13_3

	local var_13_8 = arg_13_0
	local var_13_9 = var_13_7

	local function var_13_10()
		getProxy = var_2_10000
		GuildProxy = var_2_10002

		local var_14_0 = var_2_10000(var_2_10002)

		if not var_0.CanFormationPos(var_14_0, arg_13_1) then
			return
		end

		if arg_13_0.existBossBattle then
			pg = var_0

			local var_14_1 = var_0.TipsMgr.GetInstance()
			local var_14_2 = var_0.ShowTips

			i18n = var_3

			var_14_2(var_14_1, var_3("guild_formation_erro_in_boss_battle"))

			return
		end

		local var_14_3 = arg_13_0
		local var_14_4 = var_0.emit

		GuildEventMediator = var_3

		var_14_4(var_14_3, var_3.ON_SELECT_SHIP, arg_13_1, arg_13_3, arg_13_0.fleet)

		return
	end

	SFX_PANEL = var_1_10013

	var_13_3(var_13_8, var_13_9, var_13_10, var_1_10013)

	return
end

function var_0_1.RefreshCdTimer(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.slots[arg_15_1]
	local var_15_1 = var_2.Find(var_15_0, "tag/timer")
	local var_15_2 = var_3.Find(var_15_1, "Text")
	local var_15_3 = var_4.GetComponent

	typeof = var_7
	Text = var_1_10009

	local var_15_4 = var_15_3(var_15_2, var_7(var_1_10009))
	local var_15_5 = var_2
	local var_15_6 = var_2.Find(var_15_5, "tag/tag")

	getProxy = var_15_2
	GuildProxy = var_8

	local var_15_7 = var_15_2(var_8)
	local var_15_8 = not var_6.CanFormationPos(var_15_7, arg_15_1)

	setActive = var_15_5

	var_15_5(var_3, false)
	arg_15_0:RemoveTimer(arg_15_1)

	local var_15_9

	if var_15_8 then
		var_15_9 = arg_15_0.cdTimer
		Timer = var_15_7
		var_15_9[arg_15_1] = var_15_7.New(function()
			getProxy = var_2_10000
			GuildProxy = var_2_10002

			local var_16_0 = var_2_10000(var_2_10002)
			local var_16_1 = var_0.GetNextCanFormationTime(var_16_0, arg_15_1)

			pg = var_2_10001

			local var_16_2 = var_2_10001.TimeMgr.GetInstance()
			local var_16_3 = var_16_1 - var_1.GetServerTime(var_16_2)
			local var_16_4

			if 0 < var_16_3 then
				var_16_4 = var_15_4
				pg = var_16_2

				local var_16_5 = var_16_2.TimeMgr.GetInstance()

				var_16_4.text = var_3.DescCDTime(var_16_5, var_16_3)
			else
				setActive = var_16_4

				var_16_4(var_0, false)

				setActive = var_16_4

				local var_16_6 = var_0
				local var_16_7 = var_4.Find(var_16_6, "tag")

				isActive = var_5

				var_16_4(var_16_7, var_5(var_15_6))
			end

			return
		end, 1, -1)

		local var_15_10 = arg_15_0.cdTimer[arg_15_1]

		var_15_9.Start(var_15_10)
		arg_15_0.cdTimer[arg_15_1].func()

		setActive = var_15_9

		var_15_9(var_3, true)
	end

	setActive = var_15_9

	local var_15_11 = var_2:Find("tag")

	isActive = var_10

	local var_15_12

	if not var_10(var_15_6) then
		var_15_12 = var_15_8
	end

	var_15_9(var_15_11, var_15_12)

	return
end

function var_0_1.RemoveTimer(arg_17_0, arg_17_1)
	if arg_17_0.cdTimer[arg_17_1] then
		local var_17_0 = arg_17_0.cdTimer[arg_17_1]

		var_2.Stop(var_17_0)

		arg_17_0.cdTimer[arg_17_1] = nil
	end

	return
end

function var_0_1.OnDestroy(arg_18_0)
	var_0_1.super.OnDestroy(arg_18_0)

	pairs = var_1

	for iter_18_0, iter_18_1 in var_1(arg_18_0.cdTimer) do
		arg_18_0:RemoveTimer(iter_18_0)
	end

	return
end

return var_0_1
