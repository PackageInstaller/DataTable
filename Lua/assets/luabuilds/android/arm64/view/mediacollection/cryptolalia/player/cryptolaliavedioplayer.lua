local var_0_0 = class("CryptolaliaVedioPlayer")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5

local function var_0_6(arg_1_0)
	return PathMgr.getAssetBundle("originsource/cipher/" .. arg_1_0 .. ".txt")
end

local function var_0_7(arg_2_0)
	return PathMgr.getAssetBundle("originsource/cipher/" .. arg_2_0 .. ".cpk")
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	pg.DelegateInfo.New(arg_3_0)

	arg_3_0.root = arg_3_1
	arg_3_0.state = var_0_1
	arg_3_0.handle = arg_3_0.handle or UpdateBeat:CreateListener(arg_3_0.Update, arg_3_0)
	arg_3_0.text = nil
	arg_3_0.subtile = nil
	arg_3_0.player = nil
	arg_3_0.nowTime = nil
	arg_3_0.endTime = nil

	UpdateBeat:AddListener(arg_3_0.handle)

	return
end

function var_0_0.Play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0:CheckCpkAndSubtitle(arg_4_1, next) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("资源不存在"))

		return
	end

	arg_4_0.captionsColor = arg_4_2
	arg_4_0.onExit = arg_4_3

	seriesAsync({
		function(arg_5_0)
			arg_4_0:DownloadCpkAndSubtitle(arg_4_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_4_0:LoadVedioPlayer(arg_4_1, arg_6_0)

			return
		end
	}, function()
		arg_4_0:RegisterEvent()

		return
	end)

	return
end

function var_0_0.RegisterEvent(arg_8_0)
	onButton(arg_8_0, arg_8_0.playBtn, function()
		if not arg_8_0.player then
			return
		end

		arg_8_0:_Play()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.backBtn, function()
		if not arg_8_0.player then
			return
		end

		if arg_8_0.onExit then
			arg_8_0.onExit()
		end

		arg_8_0:Stop()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._go, function()
		arg_8_0:Pause()

		return
	end, SFX_PANEL)
	onToggle(arg_8_0, arg_8_0.loop, function(arg_12_0)
		getProxy(CryptolaliaProxy):SetLoop(arg_12_0)
		setActive(arg_8_0.loopOn, arg_12_0)
		setActive(arg_8_0.loopOff, not arg_12_0)

		return
	end)
	triggerToggle(arg_8_0.loop, getProxy(CryptolaliaProxy):GetLoop())

	return
end

function var_0_0._Play(arg_13_0)
	if arg_13_0.state == var_0_3 then
		arg_13_0.player:Pause(false)
	elseif arg_13_0.state == var_0_4 then
		arg_13_0.subtile = Clone(arg_13_0.subtileBackUp)

		if arg_13_0.targetFrame then
			arg_13_0.player.player:SetSeekPosition(arg_13_0.targetFrame)
		else
			arg_13_0.player.player:SetSeekPosition(0)
		end

		arg_13_0.player.player:Start()
	else
		arg_13_0.subtile = Clone(arg_13_0.subtileBackUp)

		arg_13_0.player:PlayCpk()
	end

	setActive(arg_13_0.playBtn, false)
	setActive(arg_13_0.backBtn, false)
	setActive(arg_13_0.bottom, false)

	arg_13_0.state = var_0_2

	return
end

local function var_0_8(arg_14_0)
	if not arg_14_0.frameInfo then
		return 0
	end

	return arg_14_0.frameInfo.frameNo / arg_14_0.frameInfo.framerateN / arg_14_0.frameInfo.framerateD * 1000000
end

local function var_0_9(arg_15_0, arg_15_1)
	if not arg_15_0 or #arg_15_0 <= 0 then
		return ""
	end

	local var_15_0 = arg_15_0[1]

	if arg_15_1 >= arg_15_0[1].startTime and arg_15_1 <= var_15_0.endTime then
		table.remove(arg_15_0, 1)

		return var_15_0.content, var_15_0.endTime
	elseif arg_15_1 > var_15_0.startTime and arg_15_1 > var_15_0.endTime then
		table.remove(arg_15_0, 1)
	end

	return ""
end

local function var_0_10(arg_16_0, arg_16_1)
	if not arg_16_0 or #arg_16_0 <= 0 then
		return ""
	end

	while #arg_16_0 > 0 do
		if arg_16_1 < arg_16_0[1].startTime then
			return ""
		elseif arg_16_1 >= arg_16_0[1].startTime and arg_16_1 <= arg_16_0[1].endTime then
			table.remove(arg_16_0, 1)

			return arg_16_0[1].content, arg_16_0[1].endTime
		elseif arg_16_1 > arg_16_0[1].endTime then
			table.remove(arg_16_0, 1)
		end
	end

	return
end

function var_0_0.Pause(arg_17_0)
	if arg_17_0.state ~= var_0_2 then
		return
	end

	arg_17_0.state = var_0_3

	setActive(arg_17_0.playBtn, true)
	arg_17_0.player:Pause(true)
	setActive(arg_17_0.backBtn, true)
	setActive(arg_17_0.bottom, true)

	local var_17_0 = math.ceil((var_0_8(arg_17_0.player.player)))

	setText(arg_17_0.nowTime, math.floor(var_17_0 / 60) .. ":" .. string.format("%02d", var_17_0 % 60))

	local var_17_1 = arg_17_0.progress:GetComponent(typeof(Slider))

	var_17_1.onValueChanged:RemoveAllListeners()

	var_17_1.value = var_17_0 / arg_17_0.totalTime

	var_17_1.onValueChanged:AddListener(function(arg_18_0)
		if arg_17_0.state ~= var_0_4 then
			arg_17_0.state = var_0_4
			arg_17_0.totalFrames = arg_17_0.player.player.movieInfo.totalFrames
		end

		arg_17_0.player.player:StopForSeek()

		arg_17_0.targetFrame = math.floor(arg_18_0 * arg_17_0.totalFrames)

		if arg_17_0.targetFrame == arg_17_0.totalFrames then
			arg_17_0.targetFrame = arg_17_0.totalFrames - 10
		end

		local var_18_0 = arg_17_0.totalTime * arg_18_0

		setText(arg_17_0.nowTime, math.floor(arg_17_0.totalTime * arg_18_0 / 60) .. ":" .. string.format("%02d", arg_17_0.totalTime * arg_18_0 % 60))

		arg_17_0.subtile = Clone(arg_17_0.subtileBackUp)

		local var_18_1, var_18_2 = var_0_10(arg_17_0.subtile, var_18_0)

		arg_17_0:RemoveTimer()
		arg_17_0:StartTimer(function()
			arg_17_0.timeStamp = nil

			arg_17_0.player.player:SetSeekPosition(arg_17_0.targetFrame)
			arg_17_0.player.player:Start()

			arg_17_0.hasStopped = false

			if var_18_1 and var_18_1 ~= "" then
				arg_17_0.hideTime = var_18_2
				arg_17_0.text.text = "<color=" .. arg_17_0.captionsColor .. ">" .. var_18_1 .. "</color>"

				setActive(arg_17_0.text.gameObject, true)
			else
				arg_17_0.hideTime = nil
				arg_17_0.text.text = ""

				setActive(arg_17_0.text.gameObject, false)
			end

			return
		end, 0.5)

		return
	end)

	return
end

function var_0_0.Stop(arg_20_0)
	arg_20_0:Dispose()

	arg_20_0.state = var_0_5

	return
end

function var_0_0.CheckCpkAndSubtitle(arg_21_0, arg_21_1, arg_21_2)
	return PathMgr.FileExists(var_0_7(arg_21_1)) and PathMgr.FileExists(var_0_6(arg_21_1))
end

function var_0_0.DownloadCpkAndSubtitle(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2()

	return
end

local function var_0_11(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs((PathMgr.ReadAllLines((var_0_6(arg_23_0))):ToTable())) do
		local var_23_0 = string.match(iter_23_1, "#%d+#%d+$")
		local var_23_1 = string.split(var_23_0, "#")

		table.insert({}, {
			startTime = tonumber(var_23_1[2]),
			endTime = tonumber(var_23_1[3]),
			content = string.gsub(iter_23_1, var_23_0, "")
		})
	end

	return {}
end

function var_0_0.LoadVedioPlayer(arg_24_0, arg_24_1, arg_24_2)
	ResourceMgr.Inst:getAssetAsync("Cryptolalia/" .. arg_24_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_25_0)
		local var_25_0 = Object.Instantiate(arg_25_0, arg_24_0.root)

		arg_24_0.text = var_25_0.transform:Find("Text"):GetComponent(typeof(Text))
		arg_24_0.subtileBackUp = var_0_11(arg_24_1)
		arg_24_0.player = var_25_0.transform:Find("cpk"):GetComponent(typeof(CriManaCpkUI))
		arg_24_0.playBtn = var_25_0.transform:Find("play")
		arg_24_0.backBtn = var_25_0.transform:Find("back")
		arg_24_0.bottom = var_25_0.transform:Find("bottom")
		arg_24_0.nowTime = var_25_0.transform:Find("bottom/nowTime")
		arg_24_0.endTime = var_25_0.transform:Find("bottom/endTime")
		arg_24_0.progress = var_25_0.transform:Find("bottom/progress")
		arg_24_0.loop = var_25_0.transform:Find("bottom/loop")
		arg_24_0.loopOff = var_25_0.transform:Find("bottom/loop/off")
		arg_24_0.loopOn = var_25_0.transform:Find("bottom/loop/on")
		arg_24_0._go = var_25_0

		arg_24_0.player:SetCpkTotalTimeCallback(function(arg_26_0)
			arg_24_0.totalTime = math.ceil(arg_26_0)

			setText(arg_24_0.endTime, math.floor(arg_24_0.totalTime / 60) .. ":" .. string.format("%02d", arg_24_0.totalTime % 60))

			return
		end)
		arg_24_0:_Play()
		arg_24_2()

		return
	end), true, true)

	return
end

function var_0_0.OnPlayEnd(arg_27_0)
	if getProxy(CryptolaliaProxy):GetLoop() then
		arg_27_0.player.player:Stop()

		arg_27_0.subtile = Clone(arg_27_0.subtileBackUp)

		arg_27_0.player.player:SetSeekPosition(0)
		arg_27_0.player:PlayCpk()
	else
		triggerButton(arg_27_0.backBtn)
	end

	return
end

function var_0_0.Update(arg_28_0)
	if arg_28_0.text == nil or arg_28_0.subtile == nil or arg_28_0.player == nil or arg_28_0.player.player.frameInfo == nil then
		return
	end

	if arg_28_0.state == var_0_4 and arg_28_0.player.player.frameInfo.frameNo == arg_28_0.targetFrame and not arg_28_0.hasStopped then
		arg_28_0.hasStopped = true

		arg_28_0.player.player:StopForSeek()
	end

	if arg_28_0.state == var_0_3 or arg_28_0.state == var_0_4 then
		return
	end

	if arg_28_0.player.player.frameInfo.frameNo >= arg_28_0.player.player.movieInfo.totalFrames - 1 then
		arg_28_0:OnPlayEnd()

		return
	end

	local var_28_0 = var_0_8(arg_28_0.player.player)
	local var_28_1, var_28_2 = var_0_9(arg_28_0.subtile, var_28_0)

	if var_28_1 and var_28_1 ~= "" then
		arg_28_0.hideTime = var_28_2
		arg_28_0.text.text = "<color=" .. arg_28_0.captionsColor .. ">" .. var_28_1 .. "</color>"

		setActive(arg_28_0.text.gameObject, true)
	elseif arg_28_0.hideTime and var_28_0 >= arg_28_0.hideTime then
		arg_28_0.text.text = ""
		arg_28_0.hideTime = nil

		setActive(arg_28_0.text.gameObject, false)
	end

	return
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.state == var_0_5 then
		return
	end

	pg.DelegateInfo.Dispose(arg_29_0)

	if arg_29_0.player then
		arg_29_0.player:SetPlayEndHandler(nil)
		arg_29_0.player.player:Stop()
	end

	if arg_29_0.player and not IsNil(arg_29_0.player.gameObject) then
		Object.Destroy(arg_29_0.player.gameObject.transform.parent.gameObject)
	end

	arg_29_0.onExit = nil
	arg_29_0.text = nil
	arg_29_0.nowTime = nil
	arg_29_0.endTime = nil
	arg_29_0.subtile = nil
	arg_29_0.player = nil
	arg_29_0.hideTime = nil

	if arg_29_0.handle then
		UpdateBeat:RemoveListener(arg_29_0.handle)
	end

	return
end

function var_0_0.StartTimer(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.timer = Timer.New(arg_30_1, arg_30_2, 1)

	arg_30_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_31_0)
	if arg_31_0.timer then
		arg_31_0.timer:Stop()
	end

	return
end

return var_0_0
