class = var_0_10000

local var_0_0 = "TianHouSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))
local var_0_2 = {
	[0] = {
		color = "ffffff",
		name = "none"
	},
	{
		color = "ffed95",
		name = "na"
	},
	{
		color = "feb8ff",
		name = "k"
	},
	{
		color = "ad92ff",
		name = "rb"
	},
	{
		color = "affff4",
		name = "zn"
	},
	{
		color = "ffa685",
		name = "ca"
	},
	{
		color = "c1ffa7",
		name = "cu"
	}
}

function var_0_1.GetCurrentDay()
	pg = var_1_10000

	local var_1_0 = var_1_10000.TimeMgr.GetInstance()
	local var_1_1 = var_0.GetServerTime(var_1_0)

	pg = var_1_10001

	local var_1_2 = var_1_10001.TimeMgr.GetInstance()

	return var_1.STimeDescS(var_1_2, var_1_1, "*t").yday
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "AD")

	local var_2_1 = arg_2_0.bg

	arg_2_0.helpBtn = var_1.Find(var_2_1, "help")

	local var_2_2 = arg_2_0.bg

	arg_2_0.gotTag = var_1.Find(var_2_2, "got")

	local var_2_3 = arg_2_0.bg

	arg_2_0.medalText = var_1.Find(var_2_3, "medal")

	local var_2_4 = arg_2_0.bg

	arg_2_0.ticketText = var_1.Find(var_2_4, "ticket")

	local var_2_5 = arg_2_0.bg

	arg_2_0.fireworkBtn = var_1.Find(var_2_5, "game_list/firework")

	local var_2_6 = arg_2_0.bg

	arg_2_0.shootBtn = var_1.Find(var_2_6, "game_list/shoot")

	local var_2_7 = arg_2_0.bg

	arg_2_0.foodBtn = var_1.Find(var_2_7, "game_list/food")

	local var_2_8 = arg_2_0.bg

	arg_2_0.effectNode = var_1.Find(var_2_8, "effectNode")

	local var_2_9 = arg_2_0.bg

	arg_2_0.playEffectBtn = var_1.Find(var_2_9, "fire")

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity

	arg_3_0.hubID = var_1.getConfig(var_3_0, "config_id")
	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.helpBtn

	local function var_3_3()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_4_2.type = var_2_10004
		i18n = var_2_10004
		var_4_2.helps = var_2_10004("help_summer_feast")

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_1, var_3_2, var_3_3, var_1_10006)

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.fireworkBtn

	local function var_3_6()
		pg = var_2_10000

		local var_5_0 = var_2_10000.m02
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10003

		var_5_1(var_5_0, var_2_10003.GO_MINI_GAME, 26)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_4, var_3_5, var_3_6, var_1_10006)

	onButton = var_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.shootBtn

	local function var_3_9()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.GO_MINI_GAME, 27)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_7, var_3_8, var_3_9, var_1_10006)

	onButton = var_1

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.foodBtn

	local function var_3_12()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.GO_MINI_GAME, 25)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_10, var_3_11, var_3_12, var_1_10006)

	getProxy = var_1
	MiniGameProxy = var_3_10

	local var_3_13 = var_1(var_3_10)
	local var_3_14 = var_1.GetMiniGameData(var_3_13, 26)

	arg_3_0.ishow = var_1.GetRuntimeData(var_3_14, "elements") and #var_2 >= 4 and var_2[4] == arg_3_0.GetCurrentDay()
	onButton = var_3

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.playEffectBtn

	local function var_3_17()
		if not arg_3_0.ishow then
			return
		end

		local var_8_0 = arg_3_0

		var_0.PlayFirework(var_8_0, var_0)

		setActive = var_0

		var_0(arg_3_0.playEffectBtn, false)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_3_15, var_3_16, var_3_17, var_1_10008)

	blinkAni = var_3

	local var_3_18 = arg_3_0.playEffectBtn

	var_3(var_5.Find(var_3_18, "light"), 0.5)

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.GetHubByHubId(var_9_0, arg_9_0.hubID)
	local var_9_2 = var_2.getConfig(var_9_1, "reward_need")

	setText = var_9_0

	var_9_0(arg_9_0.ticketText, var_2.count)

	setText = var_9_0

	var_9_0(arg_9_0.medalText, var_2.usedtime .. "/" .. var_9_2)

	setActive = var_9_0

	var_9_0(arg_9_0.gotTag, var_2.ultimate ~= 0)

	local var_9_4

	if var_2.ultimate == 0 and var_9_2 <= var_2.usedtime then
		pg = var_9_4

		local var_9_3 = var_9_4.m02

		var_9_4 = var_9_4.sendNotification
		GAME = var_7

		local var_9_5 = var_7.SEND_MINI_GAME_OP
		local var_9_6 = {
			hubid = arg_9_0.hubID
		}

		MiniGameOPCommand = var_9
		var_9_6.cmd = var_9.CMD_ULTIMATE
		var_9_6.args1 = {}

		var_9_4(var_9_3, var_9_5, var_9_6)
	end

	setActive = var_9_4

	var_9_4(arg_9_0.playEffectBtn, arg_9_0.ishow)

	pg = var_9_4

	local var_9_7 = var_9_4.NewStoryMgr.GetInstance()

	var_4.Play(var_9_7, "TIANHOUYUYI1")

	return
end

function var_0_1.TransformColor(arg_10_0)
	tonumber = var_1_10001
	string = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003.sub(arg_10_0, 1, 2), 16)

	tonumber = var_1_10002
	string = var_4

	local var_10_1 = var_1_10002(var_4.sub(arg_10_0, 3, 4), 16)

	tonumber = var_3
	string = var_5

	local var_10_2 = var_3(var_5.sub(arg_10_0, 5, 6), 16)

	Color = var_4

	return var_4.New(var_10_0 / 255, var_10_1 / 255, var_10_2 / 255)
end

function var_0_1.PlayFirework(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or {
		0,
		0,
		0
	}
	UnityEngine = var_1_10002

	local var_11_0 = var_1_10002.ParticleSystem.MinMaxGradient.New

	pg = var_1_10003

	local var_11_1 = var_1_10003.PoolMgr.GetInstance()

	var_3.GetPrefab(var_11_1, "ui/firework", "", false, function(arg_12_0)
		tf = var_2_10001

		local var_12_0 = var_2_10001(arg_12_0)
		local var_12_1 = var_1.Find(var_12_0, "Fire")
		local var_12_2 = var_1.GetComponent(var_12_1, "ParticleSystem").main.startColor

		tf = var_12_1

		local var_12_3 = var_12_1(arg_12_0)
		local var_12_4 = var_3.Find(var_12_3, "Fire")
		local var_12_5 = var_3.GetComponent(var_12_4, "ParticleSystem").main

		var_12_5.startColor = var_11_0(arg_11_0.TransformColor(var_0_2[arg_11_1[1]].color))
		tf = var_12_5

		local var_12_6 = var_12_5(arg_12_0)
		local var_12_7 = var_3.Find(var_12_6, "Fire/par_small")
		local var_12_8 = var_3.GetComponent(var_12_7, "ParticleSystem").main

		var_12_8.startColor = var_11_0(arg_11_0.TransformColor(var_0_2[arg_11_1[2]].color))
		tf = var_12_8

		local var_12_9 = var_12_8(arg_12_0)
		local var_12_10 = var_3.Find(var_12_9, "Fire/par_small/par_big")
		local var_12_11 = var_3.GetComponent(var_12_10, "ParticleSystem").main

		var_12_11.startColor = var_11_0(arg_11_0.TransformColor(var_0_2[arg_11_1[3]].color))
		setParent = var_12_11

		var_12_11(arg_12_0, arg_11_0.effectNode)

		local var_12_12 = arg_12_0.transform

		Vector2 = var_4
		var_12_12.localPosition = var_4(0, 0)
		arg_11_0.fireEffect = arg_12_0

		return
	end)
	arg_11_0:PlaySE()

	return
end

function var_0_1.ClearEffectFirework(arg_13_0)
	arg_13_0:StopSE()

	if arg_13_0.fireEffect then
		pg = var_1

		local var_13_0 = var_1.PoolMgr.GetInstance()

		var_1.ReturnPrefab(var_13_0, "ui/firework", "", arg_13_0.fireEffect)
	end

	return
end

function var_0_1.PlaySE(arg_14_0)
	if arg_14_0.SETimer then
		return
	end

	arg_14_0.SECount = 10
	Timer = var_1
	arg_14_0.SETimer = var_1.New(function()
		arg_14_0.SECount = arg_14_0.SECount - 1

		if arg_14_0.SECount <= 0 then
			local var_15_0 = arg_14_0

			math = var_1
			var_15_0.SECount = var_1.random(5, 20)
			pg = var_15_0

			local var_15_1 = var_15_0.CriMgr.GetInstance()

			var_0.PlaySE_V3(var_15_1, "battle-firework")
		end

		return
	end, 0.1, -1)

	local var_14_0 = arg_14_0.SETimer

	var_1.Start(var_14_0)

	return
end

function var_0_1.StopSE(arg_16_0)
	if arg_16_0.SETimer then
		pg = var_1

		local var_16_0 = var_1.CriMgr.GetInstance()

		var_1.StopSEBattle_V3(var_16_0)

		local var_16_1 = arg_16_0.SETimer

		var_1.Stop(var_16_1)

		arg_16_0.SETimer = nil
	end

	return
end

function var_0_1.OnHideFlush(arg_17_0)
	arg_17_0:ClearEffectFirework()

	return
end

function var_0_1.OnDestroy(arg_18_0)
	arg_18_0:ClearEffectFirework()

	return
end

return var_0_1
