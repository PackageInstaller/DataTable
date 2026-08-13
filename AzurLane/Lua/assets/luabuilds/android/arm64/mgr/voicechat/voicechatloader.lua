class = var_0_10000

local var_0_0 = "VoiceChatLoader"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4

function var_0_1.getUIName(arg_1_0)
	return "VoiceChatUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "front/label")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.stateTxt = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "front/label/en")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.stateEnTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "front/label/time")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.timeTxt = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf

	arg_2_0.respondBtn = var_1.Find(var_2_9, "front/btns/respond")

	local var_2_10 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_10, "front/btns/close_btn")

	local var_2_11 = arg_2_0._tf

	arg_2_0.optionPanel = var_1.Find(var_2_11, "front/options_panel")

	local var_2_12 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_12, "back")

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "back/bg")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.bgImg = var_2_15(var_2_14, var_4(var_1_10006))
	VoiceChatPlayer = var_1
	arg_2_0.player = var_1.New(arg_2_0._go)
	arg_2_0.state = var_0_2

	return
end

local var_0_6 = {
	"",
	"JP",
	"KR",
	"US",
	""
}

function var_0_1.LoadScript(arg_3_0, arg_3_1)
	local var_3_0 = var_0_6

	PLATFORM_CODE = var_1_10003

	local var_3_1 = var_3_0[var_1_10003]

	if arg_3_1 == "index" then
		arg_3_1 = arg_3_1 .. var_3_1
	end

	local var_3_2

	PLATFORM_CODE = var_1_10004
	PLATFORM_JP = var_1_10005

	if var_1_10004 == var_1_10005 then
		var_3_2 = "GameCfg.story" .. var_3_1 .. "." .. arg_3_1
	else
		var_3_2 = "GameCfg.story" .. "." .. arg_3_1
	end

	pcall = var_1_10004

	local var_3_3, var_3_4 = var_1_10004(function()
		require = var_2_10000

		return var_2_10000(var_3_2)
	end)

	assert = var_6

	var_6(var_3_4, "load script failed:" .. arg_3_1)

	VoiceChat = var_6

	return var_6.New(var_3_4)
end

function var_0_1.Play(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.LoadScript(var_5_0, arg_5_1)
	local var_5_2 = {}

	table = var_5_0

	var_5_0.insert(var_5_2, function(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.WaitForRespond(var_6_0, var_5_1, arg_6_0, arg_5_2)

		return
	end)

	table = var_5

	var_5.insert(var_5_2, function(arg_7_0)
		local var_7_0 = arg_5_0

		var_1.StartAction(var_7_0, var_5_1)
		arg_7_0()

		return
	end)

	ipairs = var_5

	for iter_5_0, iter_5_1 in var_5(var_5_1.steps) do
		table = var_1_10010

		var_1_10010.insert(var_5_2, function(arg_8_0)
			local var_8_0 = arg_5_0.player

			var_1.Play(var_8_0, var_5_1, iter_5_0, arg_8_0)

			return
		end)
	end

	table = var_5

	var_5.insert(var_5_2, function(arg_9_0)
		local var_9_0 = arg_5_0

		var_1.WaitForHangUp(var_9_0, arg_9_0)

		return
	end)

	arg_5_0.script = var_5_1

	arg_5_0:InitAction(var_5_1)

	seriesAsync = var_5

	var_5(var_5_2, function()
		local var_10_0 = arg_5_0

		var_0.EndAction(var_10_0)

		if arg_5_2 then
			arg_5_2()
		end

		return
	end)

	return
end

function var_0_1.InitAction(arg_11_0, arg_11_1)
	arg_11_0.state = var_0_3
	removeOnButton = var_2

	var_2(arg_11_0.respondBtn)

	removeOnButton = var_2

	var_2(arg_11_0.closeBtn)

	setActive = var_2

	var_2(arg_11_0.optionPanel, false)

	setActive = var_2

	var_2(arg_11_0.bg, arg_11_1:HasBg())
	arg_11_0:Show()

	if arg_11_1:HasBg() then
		local var_11_0 = arg_11_0.bgImg

		LoadSprite = var_1_10003
		var_11_0.sprite = var_1_10003("bg/" .. arg_11_1:GetBgName())

		local var_11_1 = arg_11_0.bgImg

		var_2.SetNativeSize(var_11_1)
	end

	local var_11_2 = arg_11_0.player

	var_2.OnStart(var_11_2)

	return
end

function var_0_1.WaitForRespond(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	setActive = var_1_10004

	var_1_10004(arg_12_0.respondBtn, true)

	setActive = var_1_10004

	var_1_10004(arg_12_0.closeBtn, true)

	local var_12_0 = arg_12_0.stateTxt

	i18n = var_1_10005

	local var_12_1 = arg_12_1

	var_12_0.text = var_1_10005(arg_12_1.GetLabel(var_12_1), arg_12_1:GetShipName())

	local var_12_2 = arg_12_0.stateEnTxt

	var_12_2.text = "P R I V A T E C H A T"
	onButton = var_12_2

	local var_12_3 = arg_12_0
	local var_12_4 = arg_12_0.respondBtn
	local var_12_5 = arg_12_2

	SFX_PANEL = var_12_1

	var_12_2(var_12_3, var_12_4, var_12_5, var_12_1)

	onButton = var_12_2

	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_0.closeBtn

	local function var_12_8()
		local var_13_0 = arg_12_0.closeBtn
		local var_13_1 = var_0.GetComponent

		typeof = var_2_10003
		Animation = var_2_10005

		local var_13_2 = var_13_1(var_13_0, var_2_10003(var_2_10005))

		var_0.Play(var_13_2, "anim_close_btn_hang")

		local var_13_3 = arg_12_0.closeBtn
		local var_13_4 = var_1.GetComponent

		typeof = var_4
		DftAniEvent = var_2_10006

		local var_13_5 = var_13_4(var_13_3, var_4(var_2_10006))

		var_1.SetEndEvent(var_13_5, function()
			local var_14_0 = arg_12_0

			var_0.Stop(var_14_0)

			existCall = var_0

			var_0(arg_12_3)

			return
		end)

		return
	end

	SFX_PANEL = var_12_1

	var_12_2(var_12_6, var_12_7, var_12_8, var_12_1)

	return
end

local function var_0_7(arg_15_0)
	math = var_1_10001

	local var_15_0 = var_1_10001.floor(arg_15_0 / 60)
	local var_15_1 = arg_15_0 % 60

	string = var_3

	return var_3.format("%02d:%02d", var_15_0, var_15_1)
end

function var_0_1.StartAction(arg_16_0, arg_16_1)
	arg_16_0.state = var_0_4
	arg_16_0.stateEnTxt.text = "V I D E O  I N V I T E"

	local var_16_0 = 0

	arg_16_0:AddTimer(1, function()
		var_16_0 = var_16_0 + 1
		arg_16_0.timeTxt.text = var_0_7(var_16_0)

		return
	end)

	setActive = var_3

	var_3(arg_16_0.respondBtn, false)

	if arg_16_1:ShouldStopBgm() then
		pg = var_3

		local var_16_1 = var_3.BgmMgr.GetInstance()

		var_3.StopPlay(var_16_1)
	end

	return
end

function var_0_1.WaitForHangUp(arg_18_0, arg_18_1)
	arg_18_0:RemoveTimer()

	arg_18_0.timeTxt.text = ""

	arg_18_0:AddWaitTimer(2, arg_18_1)

	return
end

function var_0_1.EndAction(arg_19_0)
	arg_19_0:RemoveWaitTimer()
	arg_19_0:RemoveTimer()
	arg_19_0:Hide()

	local var_19_0 = arg_19_0.script

	if var_1.ShouldStopBgm(var_19_0) then
		pg = var_1

		local var_19_1 = var_1.BgmMgr.GetInstance()

		var_1.ContinuePlay(var_19_1)
	end

	local var_19_2 = arg_19_0.player

	var_1.OnEnd(var_19_2)

	arg_19_0.script = nil
	arg_19_0.state = var_0_5
	removeOnButton = var_1

	var_1(arg_19_0.respondBtn)

	removeOnButton = var_1

	var_1(arg_19_0.closeBtn)

	return
end

function var_0_1.IsRunning(arg_20_0)
	return arg_20_0.state == var_0_4 or arg_20_0.state == var_0_3
end

function var_0_1.Stop(arg_21_0)
	if not arg_21_0:IsRunning() then
		return
	end

	if arg_21_0.state == var_0_4 then
		local var_21_0 = arg_21_0.script

		var_1.MarkSkip(var_21_0)

		local var_21_1 = arg_21_0.player

		var_1.OnStop(var_21_1)
	elseif arg_21_0.state == var_0_3 then
		arg_21_0:EndAction()
	end

	return
end

function var_0_1.OnDestroy(arg_22_0)
	if arg_22_0:isShowing() then
		arg_22_0:Hide()
	end

	arg_22_0:RemoveWaitTimer()
	arg_22_0:RemoveTimer()

	if arg_22_0.player then
		local var_22_0 = arg_22_0.player

		var_1.Clear(var_22_0)
	end

	return
end

function var_0_1.AddTimer(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:RemoveTimer()

	Timer = var_3
	arg_23_0.timer = var_3.New(arg_23_2, arg_23_1, -1)

	arg_23_0.timer.func()

	local var_23_0 = arg_23_0.timer

	var_3.Start(var_23_0)

	return
end

function var_0_1.RemoveTimer(arg_24_0)
	if arg_24_0.timer then
		local var_24_0 = arg_24_0.timer

		var_1.Stop(var_24_0)

		arg_24_0.timer = nil
	end

	return
end

function var_0_1.AddWaitTimer(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:RemoveWaitTimer()

	Timer = var_3
	arg_25_0.waitTimer = var_3.New(arg_25_2, arg_25_1, 1)

	local var_25_0 = arg_25_0.waitTimer

	var_3.Start(var_25_0)

	return
end

function var_0_1.RemoveWaitTimer(arg_26_0)
	if arg_26_0.waitTimer then
		local var_26_0 = arg_26_0.waitTimer

		var_1.Stop(var_26_0)

		arg_26_0.waitTimer = nil
	end

	return
end

return var_0_1
