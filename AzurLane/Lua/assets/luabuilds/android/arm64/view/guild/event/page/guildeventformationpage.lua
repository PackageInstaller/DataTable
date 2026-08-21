local var_0_0 = class("GuildEventFormationPage", import(".GuildEventBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "GuildEventFormationUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.tpl = arg_2_0._tf:Find("ShipCardTpl")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.sendBtn = arg_2_0._tf:Find("frame/btn")
	arg_2_0.sendBtnGray = arg_2_0._tf:Find("frame/btn/gray")
	arg_2_0.slots = {
		arg_2_0._tf:Find("frame/ship1"),
		arg_2_0._tf:Find("frame/ship2")
	}
	arg_2_0.items = {}
	arg_2_0.cdTimer = {}

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		arg_3_0.contextData.editFleet = nil

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		arg_3_0.contextData.editFleet = nil

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnFleetUpdated(arg_6_0, arg_6_1)
	arg_6_0.extraData.fleet = arg_6_1

	arg_6_0:UpdateSlots()

	return
end

function var_0_0.OnFleetFormationDone(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.slots) do
		arg_7_0:RefreshCdTimer(iter_7_0)
	end

	arg_7_0:UpdateSendBtn()

	return
end

function var_0_0.OnShow(arg_8_0)
	if not getProxy(GuildProxy).isFetchAssaultFleet then
		arg_8_0:emit(GuildEventMediator.ON_GET_FORMATION)
	else
		arg_8_0:UpdateSlots()
	end

	arg_8_0:UpdateSendBtn()

	return
end

function var_0_0.UpdateSendBtn(arg_9_0)
	local var_9_0

	if arg_9_0.contextData.editFleet then
		var_9_0 = arg_9_0.contextData.editFleet and not arg_9_0.extraData.fleet:AnyShipChanged(arg_9_0.contextData.editFleet)

		if false then
			var_9_0 = false
		end
	else
		var_9_0 = true
	end

	setActive(arg_9_0.sendBtnGray, var_9_0)

	if var_9_0 then
		removeOnButton(arg_9_0.sendBtn)

		return
	end

	onButton(arg_9_0, arg_9_0.sendBtn, function()
		if arg_9_0.existBossBattle then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_formation_erro_in_boss_battle"))

			return
		end

		arg_9_0:emit(GuildEventMediator.UPDATE_FORMATION)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateSlots(arg_11_0)
	arg_11_0.fleet = arg_11_0.contextData.editFleet or arg_11_0.extraData.fleet

	local var_11_1 = arg_11_0.guild:GetActiveEvent()
	local var_11_2 = var_11_1 and var_11_1:GetBossMission()

	arg_11_0.existBossBattle = var_11_2 and var_11_2:IsActive()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.slots) do
		arg_11_0:UpdateSlot(iter_11_0, iter_11_1, (arg_11_0.fleet:GetShipByPos(iter_11_0)))
		arg_11_0:RefreshCdTimer(iter_11_0)
	end

	return
end

function var_0_0.ShipIsBattle(arg_12_0, arg_12_1)
	return arg_12_0.existBossBattle
end

function var_0_0.UpdateSlot(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_1 = arg_13_2:Find("ship")
	local var_13_2 = arg_13_2:Find("tag/tag")
	local var_13_4

	if arg_13_3 then
		if not var_13_1 then
			var_13_1 = cloneTplTo(arg_13_0.tpl, arg_13_2)

			setActive(var_13_1, true)
			var_13_1:SetAsFirstSibling()
		end

		local var_13_3 = arg_13_0.items[arg_13_1] or DockyardShipItem.New(var_13_1)

		var_13_3:update(GuildAssaultShip.ConverteFromShip(arg_13_3))

		var_13_3.go.name = "ship"

		setActive(var_13_2, arg_13_0:ShipIsBattle(arg_13_3))
	elseif var_13_1 then
		setActive(var_13_1, false)
		setActive(var_13_2, false)
	else
		setActive(var_13_2, false)

		var_13_4 = onButton
	end

	var_13_4(arg_13_0, arg_13_3 and var_13_1 or arg_13_2, function()
		if not getProxy(GuildProxy):CanFormationPos(arg_13_1) then
			return
		end

		if arg_13_0.existBossBattle then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_formation_erro_in_boss_battle"))

			return
		end

		arg_13_0:emit(GuildEventMediator.ON_SELECT_SHIP, arg_13_1, arg_13_3, arg_13_0.fleet)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.RefreshCdTimer(arg_15_0, arg_15_1)
	local var_15_9000
	local var_15_0 = arg_15_0.slots[arg_15_1]
	local var_15_1 = arg_15_0.slots[arg_15_1]:Find("tag/timer")
	local var_15_2 = var_15_1:Find("Text")
	local var_15_3 = var_15_2.GetComponent(var_15_9000, typeof(Text))
	local var_15_4 = arg_15_0.slots[arg_15_1]:Find("tag/tag")
	local var_15_5 = not getProxy(GuildProxy).CanFormationPos(var_15_2, arg_15_1)

	setActive(var_15_1, false)
	arg_15_0:RemoveTimer(arg_15_1)

	local var_15_6

	if var_15_5 then
		arg_15_0.cdTimer[arg_15_1] = Timer.New(function()
			local var_16_0 = getProxy(GuildProxy):GetNextCanFormationTime(arg_15_1) - pg.TimeMgr.GetInstance():GetServerTime()

			if var_16_0 > 0 then
				var_15_3.text = pg.TimeMgr.GetInstance():DescCDTime(var_16_0)
			else
				setActive(var_15_1, false)
				setActive(var_15_0:Find("tag"), isActive(var_15_4))
			end

			return
		end, 1, -1)

		arg_15_0.cdTimer[arg_15_1]:Start()
		arg_15_0.cdTimer[arg_15_1].func()
		setActive(var_15_1, true)

		var_15_6 = isActive((arg_15_0.slots[arg_15_1]:Find("tag/tag"))) or var_15_5
	end

	setActive(arg_15_0.slots[arg_15_1]:Find("tag"), var_15_6)

	return
end

function var_0_0.RemoveTimer(arg_17_0, arg_17_1)
	if arg_17_0.cdTimer[arg_17_1] then
		arg_17_0.cdTimer[arg_17_1]:Stop()

		arg_17_0.cdTimer[arg_17_1] = nil
	end

	return
end

function var_0_0.OnDestroy(arg_18_0)
	var_0_0.super.OnDestroy(arg_18_0)

	for iter_18_0, iter_18_1 in pairs(arg_18_0.cdTimer) do
		arg_18_0:RemoveTimer(iter_18_0)
	end

	return
end

return var_0_0
