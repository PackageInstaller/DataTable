local var_0_0 = class("WorldBossHelpPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "WorldBossHelpUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.friendBtn = arg_2_0._tf:Find("window/sliders/content/friend")
	arg_2_0.friendRequested = arg_2_0.friendBtn:Find("requested")
	arg_2_0.friendMark = arg_2_0.friendBtn:Find("mark")
	arg_2_0.friendSupportTimeTxt = arg_2_0.friendBtn:Find("requested/Text"):GetComponent(typeof(Text))
	arg_2_0.guildBtn = arg_2_0._tf:Find("window/sliders/content/guild")
	arg_2_0.guildRequested = arg_2_0.guildBtn:Find("requested")
	arg_2_0.guildMark = arg_2_0.guildBtn:Find("mark")
	arg_2_0.guildSupportTimeTxt = arg_2_0.guildBtn:Find("requested/Text"):GetComponent(typeof(Text))
	arg_2_0.worldBtn = arg_2_0._tf:Find("window/sliders/content/world")
	arg_2_0.worldRequested = arg_2_0.worldBtn:Find("requested")
	arg_2_0.worldMark = arg_2_0.worldBtn:Find("mark")
	arg_2_0.worldSupportTimeTxt = arg_2_0.worldBtn:Find("requested/Text"):GetComponent(typeof(Text))
	arg_2_0.timers = {}

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("cancel_btn"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("window/top/btnBack"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.friendBtn, function()
		arg_3_0.friendFlag = not arg_3_0.friendFlag

		setActive(arg_3_0.friendMark, arg_3_0.friendFlag)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.guildBtn, function()
		arg_3_0.guildFlag = not arg_3_0.guildFlag

		setActive(arg_3_0.guildMark, arg_3_0.guildFlag)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.worldBtn, function()
		if nowWorld():GetBossProxy():WorldSupported() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_ask_help"))

			return
		end

		arg_3_0.worldFlag = not arg_3_0.worldFlag

		setActive(arg_3_0.worldMark, arg_3_0.worldFlag)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("confirm_btn"), function()
		arg_3_0:emit(WorldBossMediator.ON_SURPPORT, {
			arg_3_0.friendFlag,
			arg_3_0.guildFlag,
			arg_3_0.worldFlag
		})
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Reset(arg_11_0)
	arg_11_0.friendFlag = false
	arg_11_0.guildFlag = false
	arg_11_0.worldFlag = false

	return
end

function var_0_0.Update(arg_12_0, arg_12_1)
	arg_12_0.boss = arg_12_1

	arg_12_0:Reset()
	arg_12_0:UpdateFriendRequestItem()
	arg_12_0:UpdateGuildRequetItem()
	arg_12_0:UpdateWorldRequetItem()
	arg_12_0:Show()

	return
end

function var_0_0.UpdateFriendRequestItem(arg_13_0)
	local var_13_1 = nowWorld():GetBossProxy()
	local var_13_2 = var_13_1:FriendSupported()

	setButtonEnabled(arg_13_0.friendBtn, not var_13_2)
	setActive(arg_13_0.friendRequested, var_13_2)
	setActive(arg_13_0.friendMark, false)
	arg_13_0:RemoveRequestTimer(arg_13_0.friendSupportTimeTxt)

	if var_13_2 then
		arg_13_0:AddRequestTimer(var_13_1:GetNextFriendSupportTime(), arg_13_0.friendSupportTimeTxt, function()
			arg_13_0:UpdateFriendRequestItem()

			return
		end)
	end

	return
end

function var_0_0.UpdateGuildRequetItem(arg_15_0)
	local var_15_1 = nowWorld():GetBossProxy()
	local var_15_2 = var_15_1:GuildSupported()

	setButtonEnabled(arg_15_0.guildBtn, not var_15_2)
	setActive(arg_15_0.guildRequested, var_15_2)
	setActive(arg_15_0.guildMark, false)
	arg_15_0:RemoveRequestTimer(arg_15_0.guildSupportTimeTxt)

	if var_15_2 then
		arg_15_0:AddRequestTimer(var_15_1:GetNextGuildSupportTime(), arg_15_0.guildSupportTimeTxt, function()
			arg_15_0:UpdateGuildRequetItem()

			return
		end)
	end

	return
end

function var_0_0.UpdateWorldRequetItem(arg_17_0)
	local var_17_0 = nowWorld():GetBossProxy()
	local var_17_1 = var_17_0:WorldSupported()

	setActive(arg_17_0.worldRequested, var_17_1)
	setActive(arg_17_0.worldMark, false)
	arg_17_0:RemoveRequestTimer(arg_17_0.worldSupportTimeTxt)

	if var_17_1 then
		arg_17_0:AddRequestTimer(var_17_0:GetNextWorldSupportTime(), arg_17_0.worldSupportTimeTxt, function()
			arg_17_0:UpdateWorldRequetItem()

			return
		end)
	end

	return
end

function var_0_0.AddRequestTimer(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = nowWorld():GetBossProxy()

	arg_19_0.timers[arg_19_2] = Timer.New(function()
		local var_20_0 = arg_19_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_20_0 > 0 then
			arg_19_2.text = pg.TimeMgr.GetInstance():DescCDTime(var_20_0)
		else
			arg_19_2.text = ""

			arg_19_0:RemoveRequestTimer(arg_19_2)
			arg_19_3()
		end

		return
	end, 1, -1)

	arg_19_0.timers[arg_19_2]:Start()
	arg_19_0.timers[arg_19_2].func()

	return
end

function var_0_0.RemoveRequestTimer(arg_21_0, arg_21_1)
	if arg_21_0.timers[arg_21_1] then
		arg_21_0.timers[arg_21_1]:Stop()

		arg_21_0.timers[arg_21_1] = nil
	end

	return
end

function var_0_0.RemoveRequestTimers(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.timers) do
		iter_22_1:Stop()
	end

	arg_22_0.timers = {}

	return
end

function var_0_0.Show(arg_23_0)
	var_0_0.super.Show(arg_23_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_23_0._tf)

	return
end

function var_0_0.Hide(arg_24_0)
	var_0_0.super.Hide(arg_24_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_24_0._tf, arg_24_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_25_0)
	arg_25_0:Hide()
	arg_25_0:RemoveRequestTimers()

	return
end

return var_0_0
