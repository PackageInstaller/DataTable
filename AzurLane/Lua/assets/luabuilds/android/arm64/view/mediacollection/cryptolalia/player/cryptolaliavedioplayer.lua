class = var_0_10000

local var_0_0 = var_0_10000("CryptolaliaVedioPlayer")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5

local function var_0_6(arg_1_0)
	PathMgr = var_1_10001

	return var_1_10001.getAssetBundle("originsource/cipher/" .. arg_1_0 .. ".txt")
end

local function var_0_7(arg_2_0)
	PathMgr = var_1_10001

	return var_1_10001.getAssetBundle("originsource/cipher/" .. arg_2_0 .. ".cpk")
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_3_0)

	arg_3_0.root = arg_3_1
	arg_3_0.state = var_0_1

	if not arg_3_0.handle then
		UpdateBeat = var_2
		arg_3_0.handle = var_2:CreateListener(arg_3_0.Update, arg_3_0)
	end

	arg_3_0.text = nil
	arg_3_0.subtile = nil
	arg_3_0.player = nil
	arg_3_0.nowTime = nil
	arg_3_0.endTime = nil
	UpdateBeat = var_2

	var_2:AddListener(arg_3_0.handle)

	return
end

function var_0_0.Play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.CheckCpkAndSubtitle
	local var_4_2 = arg_4_1

	next = var_1_10008

	local var_4_4

	if not var_4_1(var_4_0, var_4_2, var_1_10008) then
		pg = var_4_4

		local var_4_3 = var_4_4.TipsMgr.GetInstance()

		var_4_4 = var_4_4.ShowTips
		i18n = var_4_2

		var_4_4(var_4_3, var_4_2("资源不存在"))

		return
	end

	arg_4_0.captionsColor = arg_4_2
	arg_4_0.onExit = arg_4_3
	seriesAsync = var_4_4

	var_4_4({
		function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.DownloadCpkAndSubtitle(var_5_0, arg_4_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_4_0

			var_1.LoadVedioPlayer(var_6_0, arg_4_1, arg_6_0)

			return
		end
	}, function()
		local var_7_0 = arg_4_0

		var_0.RegisterEvent(var_7_0)

		return
	end)

	return
end

function var_0_0.RegisterEvent(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.playBtn

	local function var_8_2()
		if not arg_8_0.player then
			return
		end

		local var_9_0 = arg_8_0

		var_0._Play(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.backBtn

	local function var_8_5()
		if not arg_8_0.player then
			return
		end

		if arg_8_0.onExit then
			arg_8_0.onExit()
		end

		local var_10_0 = arg_8_0

		var_0.Stop(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0._go

	local function var_8_8()
		local var_11_0 = arg_8_0

		var_0.Pause(var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10006)

	onToggle = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.loop, function(arg_12_0)
		getProxy = var_2_10001
		CryptolaliaProxy = var_2_10003

		local var_12_0 = var_2_10001(var_2_10003)

		var_1.SetLoop(var_12_0, arg_12_0)

		setActive = var_1

		var_1(arg_8_0.loopOn, arg_12_0)

		setActive = var_1

		var_1(arg_8_0.loopOff, not arg_12_0)

		return
	end)

	triggerToggle = var_1_10001

	local var_8_9 = arg_8_0.loop

	getProxy = var_4
	CryptolaliaProxy = var_1_10006

	local var_8_10 = var_4(var_1_10006)

	var_1_10001(var_8_9, var_4.GetLoop(var_8_10))

	return
end

function var_0_0._Play(arg_13_0)
	if arg_13_0.state == var_0_3 then
		local var_13_0 = arg_13_0.player

		var_1.Pause(var_13_0, false)
	elseif arg_13_0.state == var_0_4 then
		Clone = var_1
		arg_13_0.subtile = var_1(arg_13_0.subtileBackUp)

		if arg_13_0.targetFrame then
			local var_13_1 = arg_13_0.player.player

			var_1.SetSeekPosition(var_13_1, arg_13_0.targetFrame)
		else
			local var_13_2 = arg_13_0.player.player

			var_1.SetSeekPosition(var_13_2, 0)
		end

		local var_13_3 = arg_13_0.player.player

		var_1.Start(var_13_3)
	else
		Clone = var_1
		arg_13_0.subtile = var_1(arg_13_0.subtileBackUp)

		local var_13_4 = arg_13_0.player

		var_1.PlayCpk(var_13_4)
	end

	setActive = var_1

	var_1(arg_13_0.playBtn, false)

	setActive = var_1

	var_1(arg_13_0.backBtn, false)

	setActive = var_1

	var_1(arg_13_0.bottom, false)

	arg_13_0.state = var_0_2

	return
end

local function var_0_8(arg_14_0)
	if not arg_14_0.frameInfo then
		return 0
	end

	return arg_14_0.frameInfo.frameNo / var_1.framerateN / var_1.framerateD * 1000000
end

local function var_0_9(arg_15_0, arg_15_1)
	if not arg_15_0 or #arg_15_0 <= 0 then
		return ""
	end

	if arg_15_1 >= arg_15_0[1].startTime and arg_15_1 <= var_2.endTime then
		table = var_3

		var_3.remove(arg_15_0, 1)

		return var_2.content, var_2.endTime
	elseif arg_15_1 > var_2.startTime and var_2.endTime < arg_15_1 then
		table = var_3

		var_3.remove(arg_15_0, 1)
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
		elseif arg_16_1 >= var_2.startTime and arg_16_1 <= var_2.endTime then
			table = var_3

			var_3.remove(arg_16_0, 1)

			return var_2.content, var_2.endTime
		elseif var_2.endTime < arg_16_1 then
			table = var_3

			var_3.remove(arg_16_0, 1)
		end
	end

	return
end

function var_0_0.Pause(arg_17_0)
	if arg_17_0.state ~= var_0_2 then
		return
	end

	arg_17_0.state = var_0_3
	setActive = var_1

	var_1(arg_17_0.playBtn, true)

	local var_17_0 = arg_17_0.player

	var_1.Pause(var_17_0, true)

	setActive = var_1

	var_1(arg_17_0.backBtn, true)

	setActive = var_1

	var_1(arg_17_0.bottom, true)

	local var_17_1 = var_0_8(arg_17_0.player.player)

	math = var_2

	local var_17_2 = var_2.ceil(var_17_1)

	setText = var_3

	local var_17_3 = arg_17_0.nowTime

	math = var_1_10006

	local var_17_4 = var_1_10006.floor(var_17_2 / 60)
	local var_17_5 = ":"

	string = var_8

	var_3(var_17_3, var_17_4 .. var_17_5 .. var_8.format("%02d", var_17_2 % 60))

	local var_17_6 = arg_17_0.progress
	local var_17_7 = var_3.GetComponent

	typeof = var_6
	Slider = var_8

	local var_17_8 = var_17_7(var_17_6, var_6(var_8)).onValueChanged

	var_4.RemoveAllListeners(var_17_8)

	var_3.value = var_17_2 / arg_17_0.totalTime

	local var_17_9 = var_3.onValueChanged

	var_4.AddListener(var_17_9, function(arg_18_0)
		if arg_17_0.state ~= var_0_4 then
			arg_17_0.state = var_0_4
			arg_17_0.totalFrames = arg_17_0.player.player.movieInfo.totalFrames
		end

		local var_18_0 = arg_17_0.player.player

		var_1.StopForSeek(var_18_0)

		local var_18_1 = arg_17_0

		math = var_2
		var_18_1.targetFrame = var_2.floor(arg_18_0 * arg_17_0.totalFrames)

		if arg_17_0.targetFrame == arg_17_0.totalFrames then
			arg_17_0.targetFrame = arg_17_0.totalFrames - 10
		end

		local var_18_2 = arg_17_0.totalTime * arg_18_0

		setText = var_2

		local var_18_3 = arg_17_0.nowTime

		math = var_2_10005

		local var_18_4 = var_2_10005.floor(var_18_2 / 60)
		local var_18_5 = ":"

		string = var_7

		var_2(var_18_3, var_18_4 .. var_18_5 .. var_7.format("%02d", var_18_2 % 60))

		local var_18_6 = arg_17_0

		Clone = var_18_0
		var_18_6.subtile = var_18_0(arg_17_0.subtileBackUp)

		local var_18_7, var_18_8 = var_0_10(arg_17_0.subtile, var_18_2)

		local function var_18_9()
			arg_17_0.timeStamp = nil

			local var_19_0 = arg_17_0.player.player

			var_0.SetSeekPosition(var_19_0, arg_17_0.targetFrame)

			local var_19_1 = arg_17_0.player.player

			var_0.Start(var_19_1)

			arg_17_0.hasStopped = false

			if var_18_7 and var_18_7 ~= "" then
				arg_17_0.hideTime = var_18_8

				local var_19_2 = arg_17_0.text

				var_19_2.text = "<color=" .. arg_17_0.captionsColor .. ">" .. var_18_7 .. "</color>"
				setActive = var_19_2

				var_19_2(arg_17_0.text.gameObject, true)
			else
				arg_17_0.hideTime = nil

				local var_19_3 = arg_17_0.text

				var_19_3.text = ""
				setActive = var_19_3

				var_19_3(arg_17_0.text.gameObject, false)
			end

			return
		end

		local var_18_10 = arg_17_0

		var_5.RemoveTimer(var_18_10)

		local var_18_11 = arg_17_0

		var_5.StartTimer(var_18_11, var_18_9, 0.5)

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
	PathMgr = var_1_10003

	local var_21_0

	if var_1_10003.FileExists(var_0_7(arg_21_1)) then
		PathMgr = var_21_0
		var_21_0 = var_21_0.FileExists(var_0_6(arg_21_1))
	end

	return var_21_0
end

function var_0_0.DownloadCpkAndSubtitle(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2()

	return
end

local function var_0_11(arg_23_0)
	local var_23_0 = var_0_6(arg_23_0)
	local var_23_1 = {}

	PathMgr = var_3

	local var_23_2 = var_3.ReadAllLines(var_23_0)
	local var_23_3 = var_3.ToTable(var_23_2)

	ipairs = var_1_10004

	for iter_23_0, iter_23_1 in var_1_10004(var_23_3) do
		string = var_1_10009
		var_1_10009 = var_1_10009.match(iter_23_1, "#%d+#%d+$")
		string = var_1_10010

		local var_23_4 = var_1_10010.split(var_1_10009, "#")[2]
		local var_23_5 = var_1_10010[3]

		string = var_13

		local var_23_6 = var_13.gsub(iter_23_1, var_1_10009, "")

		table = var_1_10014
		var_1_10014 = var_1_10014.insert

		local var_23_7 = var_23_1
		local var_23_8 = {}

		tonumber = var_1_10018
		var_23_8.startTime = var_1_10018(var_23_4)
		tonumber = var_1_10018
		var_23_8.endTime = var_1_10018(var_23_5)
		var_23_8.content = var_23_6

		var_1_10014(var_23_7, var_23_8)
	end

	return var_23_1
end

function var_0_0.LoadVedioPlayer(arg_24_0, arg_24_1, arg_24_2)
	ResourceMgr = var_1_10003

	local var_24_0 = var_1_10003.Inst
	local var_24_1 = var_3.getAssetAsync
	local var_24_2 = "Cryptolalia/" .. arg_24_1
	local var_24_3 = ""

	UnityEngine = var_1_10008

	var_24_1(var_24_0, var_24_2, var_24_3, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_25_0)
		Object = var_2_10001

		local var_25_0 = var_2_10001.Instantiate(arg_25_0, arg_24_0.root)
		local var_25_1 = arg_24_0
		local var_25_2 = var_25_0.transform
		local var_25_3 = var_3.Find(var_25_2, "Text")
		local var_25_4 = var_3.GetComponent

		typeof = var_6
		Text = var_2_10008
		var_25_1.text = var_25_4(var_25_3, var_6(var_2_10008))
		arg_24_0.subtileBackUp = var_0_11(arg_24_1)

		local var_25_5 = arg_24_0
		local var_25_6 = var_25_0.transform
		local var_25_7 = var_3.Find(var_25_6, "cpk")
		local var_25_8 = var_3.GetComponent

		typeof = var_6
		CriManaCpkUI = var_2_10008
		var_25_5.player = var_25_8(var_25_7, var_6(var_2_10008))

		local var_25_9 = arg_24_0
		local var_25_10 = var_25_0.transform

		var_25_9.playBtn = var_3.Find(var_25_10, "play")

		local var_25_11 = arg_24_0
		local var_25_12 = var_25_0.transform

		var_25_11.backBtn = var_3.Find(var_25_12, "back")

		local var_25_13 = arg_24_0
		local var_25_14 = var_25_0.transform

		var_25_13.bottom = var_3.Find(var_25_14, "bottom")

		local var_25_15 = arg_24_0
		local var_25_16 = var_25_0.transform

		var_25_15.nowTime = var_3.Find(var_25_16, "bottom/nowTime")

		local var_25_17 = arg_24_0
		local var_25_18 = var_25_0.transform

		var_25_17.endTime = var_3.Find(var_25_18, "bottom/endTime")

		local var_25_19 = arg_24_0
		local var_25_20 = var_25_0.transform

		var_25_19.progress = var_3.Find(var_25_20, "bottom/progress")

		local var_25_21 = arg_24_0
		local var_25_22 = var_25_0.transform

		var_25_21.loop = var_3.Find(var_25_22, "bottom/loop")

		local var_25_23 = arg_24_0
		local var_25_24 = var_25_0.transform

		var_25_23.loopOff = var_3.Find(var_25_24, "bottom/loop/off")

		local var_25_25 = arg_24_0
		local var_25_26 = var_25_0.transform

		var_25_25.loopOn = var_3.Find(var_25_26, "bottom/loop/on")
		arg_24_0._go = var_25_0

		local var_25_27 = arg_24_0.player

		var_2.SetCpkTotalTimeCallback(var_25_27, function(arg_26_0)
			local var_26_0 = arg_24_0

			math = var_3_10002
			var_26_0.totalTime = var_3_10002.ceil(arg_26_0)
			setText = var_26_0

			local var_26_1 = arg_24_0.endTime

			math = var_4

			local var_26_2 = var_4.floor(arg_24_0.totalTime / 60)
			local var_26_3 = ":"

			string = var_6

			var_26_0(var_26_1, var_26_2 .. var_26_3 .. var_6.format("%02d", arg_24_0.totalTime % 60))

			return
		end)

		local var_25_28 = arg_24_0

		var_2._Play(var_25_28)
		arg_24_2()

		return
	end), true, true)

	return
end

function var_0_0.OnPlayEnd(arg_27_0)
	getProxy = var_1_10001
	CryptolaliaProxy = var_1_10003

	local var_27_0 = var_1_10001(var_1_10003)

	if var_1.GetLoop(var_27_0) then
		local var_27_1 = arg_27_0.player.player

		var_1.Stop(var_27_1)

		Clone = var_1
		arg_27_0.subtile = var_1(arg_27_0.subtileBackUp)

		local var_27_2 = arg_27_0.player.player

		var_1.SetSeekPosition(var_27_2, 0)

		local var_27_3 = arg_27_0.player

		var_1.PlayCpk(var_27_3)
	else
		triggerButton = var_1

		var_1(arg_27_0.backBtn)
	end

	return
end

function var_0_0.Update(arg_28_0)
	if arg_28_0.text == nil or arg_28_0.subtile == nil or arg_28_0.player == nil or arg_28_0.player.player.frameInfo == nil then
		return
	end

	if arg_28_0.state == var_0_4 and arg_28_0.player.player.frameInfo.frameNo == arg_28_0.targetFrame and not arg_28_0.hasStopped then
		arg_28_0.hasStopped = true

		local var_28_0 = arg_28_0.player.player

		var_1.StopForSeek(var_28_0)
	end

	if arg_28_0.state == var_0_3 or arg_28_0.state == var_0_4 then
		return
	end

	if arg_28_0.player.player.frameInfo.frameNo >= arg_28_0.player.player.movieInfo.totalFrames - 1 then
		arg_28_0:OnPlayEnd()

		return
	end

	local var_28_1 = var_0_8(arg_28_0.player.player)
	local var_28_2, var_28_3 = var_0_9(arg_28_0.subtile, var_28_1)

	if var_28_2 and var_28_2 ~= "" then
		arg_28_0.hideTime = var_28_3

		local var_28_4 = arg_28_0.text

		var_28_4.text = "<color=" .. arg_28_0.captionsColor .. ">" .. var_28_2 .. "</color>"
		setActive = var_28_4

		var_28_4(arg_28_0.text.gameObject, true)
	elseif arg_28_0.hideTime and var_28_1 >= arg_28_0.hideTime then
		arg_28_0.text.text = ""
		arg_28_0.hideTime = nil
		setActive = var_4

		var_4(arg_28_0.text.gameObject, false)
	end

	return
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.state == var_0_5 then
		return
	end

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_29_0)

	if arg_29_0.player then
		local var_29_0 = arg_29_0.player

		var_1.SetPlayEndHandler(var_29_0, nil)

		local var_29_1 = arg_29_0.player.player

		var_1.Stop(var_29_1)
	end

	if arg_29_0.player then
		IsNil = var_1

		if not var_1(arg_29_0.player.gameObject) then
			Object = var_1

			var_1.Destroy(arg_29_0.player.gameObject.transform.parent.gameObject)
		end
	end

	arg_29_0.onExit = nil
	arg_29_0.text = nil
	arg_29_0.nowTime = nil
	arg_29_0.endTime = nil
	arg_29_0.subtile = nil
	arg_29_0.player = nil
	arg_29_0.hideTime = nil

	if arg_29_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_29_0.handle)
	end

	return
end

function var_0_0.StartTimer(arg_30_0, arg_30_1, arg_30_2)
	Timer = var_1_10003
	arg_30_0.timer = var_1_10003.New(arg_30_1, arg_30_2, 1)

	local var_30_0 = arg_30_0.timer

	var_3.Start(var_30_0)

	return
end

function var_0_0.RemoveTimer(arg_31_0)
	if arg_31_0.timer then
		local var_31_0 = arg_31_0.timer

		var_1.Stop(var_31_0)
	end

	return
end

return var_0_0
