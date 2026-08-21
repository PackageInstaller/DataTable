local var_0_0 = class("VoiceChatLoader", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function var_0_0.getUIName(arg_1_0)
	return "VoiceChatUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.stateTxt = arg_2_0._tf:Find("front/label"):GetComponent(typeof(Text))
	arg_2_0.stateEnTxt = arg_2_0._tf:Find("front/label/en"):GetComponent(typeof(Text))
	arg_2_0.timeTxt = arg_2_0._tf:Find("front/label/time"):GetComponent(typeof(Text))
	arg_2_0.respondBtn = arg_2_0._tf:Find("front/btns/respond")
	arg_2_0.closeBtn = arg_2_0._tf:Find("front/btns/close_btn")
	arg_2_0.optionPanel = arg_2_0._tf:Find("front/options_panel")
	arg_2_0.bg = arg_2_0._tf:Find("back")
	arg_2_0.bgImg = arg_2_0._tf:Find("back/bg"):GetComponent(typeof(Image))
	arg_2_0.player = VoiceChatPlayer.New(arg_2_0._go)
	arg_2_0.state = var_0_1

	return
end

local var_0_5 = {
	"",
	"JP",
	"KR",
	"US",
	""
}

function var_0_0.LoadScript(arg_3_0, arg_3_1)
	if arg_3_1 == "index" then
		arg_3_1 = arg_3_1 .. var_0_5[PLATFORM_CODE]
	end

	local var_3_0 = PLATFORM_CODE == PLATFORM_JP and "GameCfg.story" .. var_0_5[PLATFORM_CODE] .. "." .. arg_3_1 or "GameCfg.story" .. "." .. arg_3_1
	local var_3_1, var_3_2 = pcall(function()
		return require(var_3_0)
	end)

	assert(var_3_2, "load script failed:" .. arg_3_1)

	return VoiceChat.New(var_3_2)
end

function var_0_0.Play(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:LoadScript(arg_5_1)

	table.insert({}, function(arg_6_0)
		arg_5_0:WaitForRespond(var_5_0, arg_6_0, arg_5_2)

		return
	end)
	table.insert({}, function(arg_7_0)
		arg_5_0:StartAction(var_5_0)
		arg_7_0()

		return
	end)

	for iter_5_0, iter_5_1 in ipairs(var_5_0.steps) do
		table.insert({}, function(arg_8_0)
			arg_5_0.player:Play(var_5_0, iter_5_0, arg_8_0)

			return
		end)
	end

	table.insert({}, function(arg_9_0)
		arg_5_0:WaitForHangUp(arg_9_0)

		return
	end)

	arg_5_0.script = var_5_0

	arg_5_0:InitAction(var_5_0)
	seriesAsync({}, function()
		arg_5_0:EndAction()

		if arg_5_2 then
			arg_5_2()
		end

		return
	end)

	return
end

function var_0_0.InitAction(arg_11_0, arg_11_1)
	arg_11_0.state = var_0_2

	removeOnButton(arg_11_0.respondBtn)
	removeOnButton(arg_11_0.closeBtn)
	setActive(arg_11_0.optionPanel, false)
	setActive(arg_11_0.bg, arg_11_1:HasBg())
	arg_11_0:Show()

	if arg_11_1:HasBg() then
		arg_11_0.bgImg.sprite = LoadSprite("bg/" .. arg_11_1:GetBgName())

		arg_11_0.bgImg:SetNativeSize()
	end

	arg_11_0.player:OnStart()

	return
end

function var_0_0.WaitForRespond(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	setActive(arg_12_0.respondBtn, true)
	setActive(arg_12_0.closeBtn, true)

	arg_12_0.stateTxt.text = i18n(arg_12_1:GetLabel(), arg_12_1:GetShipName())
	arg_12_0.stateEnTxt.text = "P R I V A T E C H A T"

	onButton(arg_12_0, arg_12_0.respondBtn, arg_12_2, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.closeBtn, function()
		arg_12_0.closeBtn:GetComponent(typeof(Animation)):Play("anim_close_btn_hang")
		arg_12_0.closeBtn:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			arg_12_0:Stop()
			existCall(arg_12_3)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

local function var_0_6(arg_15_0)
	return string.format("%02d:%02d", math.floor(arg_15_0 / 60), arg_15_0 % 60)
end

function var_0_0.StartAction(arg_16_0, arg_16_1)
	arg_16_0.state = var_0_3
	arg_16_0.stateEnTxt.text = "V I D E O  I N V I T E"

	local var_16_0 = 0

	arg_16_0:AddTimer(1, function()
		var_16_0 = var_16_0 + 1
		arg_16_0.timeTxt.text = var_0_6(var_16_0)

		return
	end)
	setActive(arg_16_0.respondBtn, false)

	if arg_16_1:ShouldStopBgm() then
		pg.BgmMgr.GetInstance():StopPlay()
	end

	return
end

function var_0_0.WaitForHangUp(arg_18_0, arg_18_1)
	arg_18_0:RemoveTimer()

	arg_18_0.timeTxt.text = ""

	arg_18_0:AddWaitTimer(2, arg_18_1)

	return
end

function var_0_0.EndAction(arg_19_0)
	arg_19_0:RemoveWaitTimer()
	arg_19_0:RemoveTimer()
	arg_19_0:Hide()

	if arg_19_0.script:ShouldStopBgm() then
		pg.BgmMgr.GetInstance():ContinuePlay()
	end

	arg_19_0.player:OnEnd()

	arg_19_0.script = nil
	arg_19_0.state = var_0_4

	removeOnButton(arg_19_0.respondBtn)
	removeOnButton(arg_19_0.closeBtn)

	return
end

function var_0_0.IsRunning(arg_20_0)
	return arg_20_0.state == var_0_3 or arg_20_0.state == var_0_2
end

function var_0_0.Stop(arg_21_0)
	if not arg_21_0:IsRunning() then
		return
	end

	if arg_21_0.state == var_0_3 then
		arg_21_0.script:MarkSkip()
		arg_21_0.player:OnStop()
	elseif arg_21_0.state == var_0_2 then
		arg_21_0:EndAction()
	end

	return
end

function var_0_0.OnDestroy(arg_22_0)
	if arg_22_0:isShowing() then
		arg_22_0:Hide()
	end

	arg_22_0:RemoveWaitTimer()
	arg_22_0:RemoveTimer()

	if arg_22_0.player then
		arg_22_0.player:Clear()
	end

	return
end

function var_0_0.AddTimer(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:RemoveTimer()

	arg_23_0.timer = Timer.New(arg_23_2, arg_23_1, -1)

	arg_23_0.timer.func()
	arg_23_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_24_0)
	if arg_24_0.timer then
		arg_24_0.timer:Stop()

		arg_24_0.timer = nil
	end

	return
end

function var_0_0.AddWaitTimer(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:RemoveWaitTimer()

	arg_25_0.waitTimer = Timer.New(arg_25_2, arg_25_1, 1)

	arg_25_0.waitTimer:Start()

	return
end

function var_0_0.RemoveWaitTimer(arg_26_0)
	if arg_26_0.waitTimer then
		arg_26_0.waitTimer:Stop()

		arg_26_0.waitTimer = nil
	end

	return
end

return var_0_0
