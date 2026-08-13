class = var_0_10000

local var_0_0 = "WorldBossHelpPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldBossHelpUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.friendBtn = var_1.Find(var_2_0, "window/sliders/content/friend")

	local var_2_1 = arg_2_0.friendBtn

	arg_2_0.friendRequested = var_1.Find(var_2_1, "requested")

	local var_2_2 = arg_2_0.friendBtn

	arg_2_0.friendMark = var_1.Find(var_2_2, "mark")

	local var_2_3 = arg_2_0.friendBtn
	local var_2_4 = var_1.Find(var_2_3, "requested/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.friendSupportTimeTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf

	arg_2_0.guildBtn = var_1.Find(var_2_6, "window/sliders/content/guild")

	local var_2_7 = arg_2_0.guildBtn

	arg_2_0.guildRequested = var_1.Find(var_2_7, "requested")

	local var_2_8 = arg_2_0.guildBtn

	arg_2_0.guildMark = var_1.Find(var_2_8, "mark")

	local var_2_9 = arg_2_0.guildBtn
	local var_2_10 = var_1.Find(var_2_9, "requested/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.guildSupportTimeTxt = var_2_11(var_2_10, var_4(var_1_10006))

	local var_2_12 = arg_2_0._tf

	arg_2_0.worldBtn = var_1.Find(var_2_12, "window/sliders/content/world")

	local var_2_13 = arg_2_0.worldBtn

	arg_2_0.worldRequested = var_1.Find(var_2_13, "requested")

	local var_2_14 = arg_2_0.worldBtn

	arg_2_0.worldMark = var_1.Find(var_2_14, "mark")

	local var_2_15 = arg_2_0.worldBtn
	local var_2_16 = var_1.Find(var_2_15, "requested/Text")
	local var_2_17 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.worldSupportTimeTxt = var_2_17(var_2_16, var_4(var_1_10006))
	arg_2_0.timers = {}

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_4.Find(var_3_4, "cancel_btn")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_4

	var_1_10001(var_3_3, var_3_5, var_3_6, var_3_4)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0._tf
	local var_3_9 = var_4.Find(var_3_8, "window/top/btnBack")

	local function var_3_10()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_3_8

	var_1_10001(var_3_7, var_3_9, var_3_10, var_3_8)

	onButton = var_1_10001

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.friendBtn

	local function var_3_13()
		local var_7_0 = arg_3_0

		var_7_0.friendFlag = not arg_3_0.friendFlag
		setActive = var_7_0

		var_7_0(arg_3_0.friendMark, arg_3_0.friendFlag)

		return
	end

	SFX_PANEL = var_3_8

	var_1_10001(var_3_11, var_3_12, var_3_13, var_3_8)

	onButton = var_1_10001

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.guildBtn

	local function var_3_16()
		local var_8_0 = arg_3_0

		var_8_0.guildFlag = not arg_3_0.guildFlag
		setActive = var_8_0

		var_8_0(arg_3_0.guildMark, arg_3_0.guildFlag)

		return
	end

	SFX_PANEL = var_3_8

	var_1_10001(var_3_14, var_3_15, var_3_16, var_3_8)

	onButton = var_1_10001

	local var_3_17 = arg_3_0
	local var_3_18 = arg_3_0.worldBtn

	local function var_3_19()
		nowWorld = var_2_10000

		local var_9_0 = var_2_10000()
		local var_9_1 = var_0.GetBossProxy(var_9_0)

		if var_0.WorldSupported(var_9_1) then
			pg = var_9_0

			local var_9_2 = var_9_0.TipsMgr.GetInstance()
			local var_9_3 = var_2.ShowTips

			i18n = var_2_10005

			var_9_3(var_9_2, var_2_10005("world_boss_ask_help"))

			return
		end

		local var_9_4 = arg_3_0

		var_9_4.worldFlag = not arg_3_0.worldFlag
		setActive = var_9_4

		var_9_4(arg_3_0.worldMark, arg_3_0.worldFlag)

		return
	end

	SFX_PANEL = var_3_8

	var_1_10001(var_3_17, var_3_18, var_3_19, var_3_8)

	onButton = var_1_10001

	local var_3_20 = arg_3_0
	local var_3_21 = arg_3_0._tf
	local var_3_22 = var_4.Find(var_3_21, "confirm_btn")

	local function var_3_23()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		WorldBossMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.ON_SURPPORT, {
			arg_3_0.friendFlag,
			arg_3_0.guildFlag,
			arg_3_0.worldFlag
		})

		local var_10_2 = arg_3_0

		var_0.Hide(var_10_2)

		return
	end

	SFX_PANEL = var_3_21

	var_1_10001(var_3_20, var_3_22, var_3_23, var_3_21)

	return
end

function var_0_1.Reset(arg_11_0)
	arg_11_0.friendFlag = false
	arg_11_0.guildFlag = false
	arg_11_0.worldFlag = false

	return
end

function var_0_1.Update(arg_12_0, arg_12_1)
	arg_12_0.boss = arg_12_1

	arg_12_0:Reset()
	arg_12_0:UpdateFriendRequestItem()
	arg_12_0:UpdateGuildRequetItem()
	arg_12_0:UpdateWorldRequetItem()
	arg_12_0:Show()

	return
end

function var_0_1.UpdateFriendRequestItem(arg_13_0)
	local var_13_0 = arg_13_0.boss

	nowWorld = var_1_10002

	local var_13_1 = var_1_10002()
	local var_13_2 = var_2.GetBossProxy(var_13_1)
	local var_13_3 = var_2.FriendSupported(var_13_2)

	setButtonEnabled = var_13_1

	var_13_1(arg_13_0.friendBtn, not var_13_3)

	setActive = var_13_1

	var_13_1(arg_13_0.friendRequested, var_13_3)

	setActive = var_13_1

	var_13_1(arg_13_0.friendMark, false)
	arg_13_0:RemoveRequestTimer(arg_13_0.friendSupportTimeTxt)

	if var_13_3 then
		local var_13_4 = var_2:GetNextFriendSupportTime()

		arg_13_0:AddRequestTimer(var_13_4, arg_13_0.friendSupportTimeTxt, function()
			local var_14_0 = arg_13_0

			var_0.UpdateFriendRequestItem(var_14_0)

			return
		end)
	end

	return
end

function var_0_1.UpdateGuildRequetItem(arg_15_0)
	local var_15_0 = arg_15_0.boss

	nowWorld = var_1_10002

	local var_15_1 = var_1_10002()
	local var_15_2 = var_2.GetBossProxy(var_15_1)
	local var_15_3 = var_2.GuildSupported(var_15_2)

	setButtonEnabled = var_15_1

	var_15_1(arg_15_0.guildBtn, not var_15_3)

	setActive = var_15_1

	var_15_1(arg_15_0.guildRequested, var_15_3)

	setActive = var_15_1

	var_15_1(arg_15_0.guildMark, false)
	arg_15_0:RemoveRequestTimer(arg_15_0.guildSupportTimeTxt)

	if var_15_3 then
		local var_15_4 = var_2:GetNextGuildSupportTime()

		arg_15_0:AddRequestTimer(var_15_4, arg_15_0.guildSupportTimeTxt, function()
			local var_16_0 = arg_15_0

			var_0.UpdateGuildRequetItem(var_16_0)

			return
		end)
	end

	return
end

function var_0_1.UpdateWorldRequetItem(arg_17_0)
	nowWorld = var_1_10001

	local var_17_0 = var_1_10001()
	local var_17_1 = var_1.GetBossProxy(var_17_0)
	local var_17_2 = var_1.WorldSupported(var_17_1)

	setActive = var_17_0

	var_17_0(arg_17_0.worldRequested, var_17_2)

	setActive = var_17_0

	var_17_0(arg_17_0.worldMark, false)
	arg_17_0:RemoveRequestTimer(arg_17_0.worldSupportTimeTxt)

	if var_17_2 then
		local var_17_3 = var_1:GetNextWorldSupportTime()

		arg_17_0:AddRequestTimer(var_17_3, arg_17_0.worldSupportTimeTxt, function()
			local var_18_0 = arg_17_0

			var_0.UpdateWorldRequetItem(var_18_0)

			return
		end)
	end

	return
end

function var_0_1.AddRequestTimer(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	nowWorld = var_1_10004

	local var_19_0 = var_1_10004()
	local var_19_1 = var_4.GetBossProxy(var_19_0)
	local var_19_2 = arg_19_0.timers

	Timer = var_19_0
	var_19_2[arg_19_2] = var_19_0.New(function()
		pg = var_2_10000

		local var_20_0 = var_2_10000.TimeMgr.GetInstance()
		local var_20_1 = var_0.GetServerTime(var_20_0)

		if arg_19_1 - var_20_1 > 0 then
			local var_20_2 = arg_19_2

			pg = var_2_10003

			local var_20_3 = var_2_10003.TimeMgr.GetInstance()

			var_20_2.text = var_3.DescCDTime(var_20_3, var_1)
		else
			arg_19_2.text = ""

			local var_20_4 = arg_19_0

			var_2.RemoveRequestTimer(var_20_4, arg_19_2)
			arg_19_3()
		end

		return
	end, 1, -1)

	local var_19_3 = arg_19_0.timers[arg_19_2]

	var_5.Start(var_19_3)
	arg_19_0.timers[arg_19_2].func()

	return
end

function var_0_1.RemoveRequestTimer(arg_21_0, arg_21_1)
	if arg_21_0.timers[arg_21_1] then
		local var_21_0 = arg_21_0.timers[arg_21_1]

		var_2.Stop(var_21_0)

		arg_21_0.timers[arg_21_1] = nil
	end

	return
end

function var_0_1.RemoveRequestTimers(arg_22_0)
	pairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.timers) do
		iter_22_1:Stop()
	end

	arg_22_0.timers = {}

	return
end

function var_0_1.Show(arg_23_0)
	var_0_1.super.Show(arg_23_0)

	pg = var_1

	local var_23_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_23_0, arg_23_0._tf)

	return
end

function var_0_1.Hide(arg_24_0)
	var_0_1.super.Hide(arg_24_0)

	pg = var_1

	local var_24_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_24_0, arg_24_0._tf, arg_24_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_25_0)
	arg_25_0:Hide()
	arg_25_0:RemoveRequestTimers()

	return
end

return var_0_1
