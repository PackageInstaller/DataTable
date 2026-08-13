class = var_0_10000

local var_0_0 = var_0_10000("StorySetSpeedPanel")

Color = var_0_10001

local var_0_1 = var_0_10001.New(1, 0.8705, 0.4196, 1)

Color = var_2

local var_0_2 = var_2.New(1, 1, 1, 1)
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 2

local function var_0_6(arg_1_0)
	return ({
		"0.5",
		"1",
		"2",
		"10"
	})[arg_1_0]
end

local function var_0_7(arg_2_0)
	local var_2_0 = arg_2_0:GetPlaySpeed()

	table = var_1_10002

	local var_2_1 = var_1_10002.indexof

	Story = var_1_10004

	if not (var_2_1(var_1_10004.STORY_AUTO_SPEED, var_2_0 or 0) <= 0) then
		Story = var_3

		local var_2_2

		if var_2_2 > #var_3.STORY_AUTO_SPEED then
			var_2_2 = 1
		end

		return var_0_6(var_2_2)
	end
end

function var_0_0.Ctor(arg_3_0, arg_3_1, arg_3_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_3_0)

	arg_3_0._tf = arg_3_1
	findTF = var_3
	arg_3_0.speedBtn = var_3(arg_3_0._tf, "front/btns/btns/speed")

	local var_3_0 = arg_3_0.speedBtn
	local var_3_1 = var_3.Find(var_3_0, "Text")
	local var_3_2 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_3_0.speedImg = var_3_2(var_3_1, var_6(var_1_10008))

	local var_3_3 = arg_3_0.speedBtn
	local var_3_4 = var_3.GetComponent

	typeof = var_6
	Animation = var_1_10008
	arg_3_0.speedAnim = var_3_4(var_3_3, var_6(var_1_10008))

	local var_3_5 = arg_3_0.speedBtn
	local var_3_6 = var_3.GetComponent

	typeof = var_6
	DftAniEvent = var_1_10008
	arg_3_0.speedAniEvent = var_3_6(var_3_5, var_6(var_1_10008))
	findTF = var_3
	arg_3_0.speedPanel = var_3(arg_3_0._tf, "front/speed_panel")

	local var_3_7 = {}
	local var_3_8 = arg_3_0.speedPanel

	var_3_7[1] = var_4.Find(var_3_8, "adpter/frame/content/0.5")

	local var_3_9 = arg_3_0.speedPanel

	var_3_7[2] = var_4.Find(var_3_9, "adpter/frame/content/1")

	local var_3_10 = arg_3_0.speedPanel

	var_3_7[3] = var_4.Find(var_3_10, "adpter/frame/content/2")

	local var_3_11 = arg_3_0.speedPanel

	var_3_7[4] = var_4.Find(var_3_11, "adpter/frame/content/10")
	arg_3_0.speedList = var_3_7

	local var_3_12 = arg_3_0.speedPanel
	local var_3_13 = var_3.Find(var_3_12, "adpter/frame/speed/Text")
	local var_3_14 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_3_0.speedPanelImg = var_3_14(var_3_13, var_6(var_1_10008))

	local var_3_15 = arg_3_0.speedPanel
	local var_3_16 = var_3.GetComponent

	typeof = var_6
	Animation = var_1_10008
	arg_3_0.speedPanelAnim = var_3_16(var_3_15, var_6(var_1_10008))

	local var_3_17 = arg_3_0.speedPanel
	local var_3_18 = var_3.GetComponent

	typeof = var_6
	DftAniEvent = var_1_10008
	arg_3_0.speedPanelAniEvent = var_3_18(var_3_17, var_6(var_1_10008))
	arg_3_0.onUpdate = arg_3_2

	arg_3_0:Init()

	return
end

function var_0_0.Init(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.speedBtn

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.ShowSettings(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.speedPanel

	local function var_4_5()
		if arg_4_0.speedPanelStatus == var_0_5 then
			local var_6_0 = arg_4_0

			var_0.ShowSettings(var_6_0)
		elseif arg_4_0.speedPanelStatus == var_0_3 then
			local var_6_1 = arg_4_0

			var_0.HideSettings(var_6_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)

	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.speedList) do
		onButton = var_1_10006

		local var_4_6 = arg_4_0
		local var_4_7 = iter_4_1

		local function var_4_8()
			Story = var_2_10000

			local var_7_0 = var_2_10000.STORY_AUTO_SPEED[iter_4_0]

			if arg_4_0.onUpdate then
				arg_4_0.onUpdate(var_7_0)
			end

			local var_7_1 = arg_4_0

			var_1.HideSettings(var_7_1)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_4_6, var_4_7, var_4_8, var_1_10011)
	end

	arg_4_0.speedPanelStatus = var_0_3

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	arg_8_0.story = arg_8_1
	setActive = var_1_10002

	var_1_10002(arg_8_0.speedBtn, true)

	setActiveByCanvasGroup = var_1_10002

	var_1_10002(arg_8_0.speedBtn, true)

	local var_8_0 = arg_8_0.speedImg

	GetSpriteFromAtlas = var_1_10003
	var_8_0.sprite = var_1_10003("ui/story_atlas", var_0_7(arg_8_1))

	local var_8_1 = arg_8_0.speedImg

	var_2.SetNativeSize(var_8_1)

	local var_8_2 = arg_8_0.speedAniEvent

	var_2.SetEndEvent(var_8_2, function()
		setActive = var_2_10000

		var_2_10000(arg_8_0.speedBtn, false)

		local var_9_0 = arg_8_0.speedAniEvent

		var_0.SetEndEvent(var_9_0, nil)

		return
	end)

	local var_8_3 = arg_8_0.speedAnim

	var_2.Stop(var_8_3)

	local var_8_4 = arg_8_0.speedAnim

	var_2.Play(var_8_4, "anim_newstoryUI_speed_in")

	return
end

function var_0_0.Hide(arg_10_0)
	arg_10_0:RemoveTimer()

	local var_10_0 = arg_10_0.speedAnim

	var_1.Stop(var_10_0)

	local var_10_1 = arg_10_0.speedAnim

	var_1.Play(var_10_1, "anim_newstoryUI_speed_out")

	return
end

function var_0_0.ShowSettings(arg_11_0)
	setActiveByCanvasGroup = var_1_10001

	var_1_10001(arg_11_0.speedBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_11_0.speedPanel, true)

	local var_11_0 = var_0_7(arg_11_0.story)
	local var_11_1 = arg_11_0.speedPanelImg

	GetSpriteFromAtlas = var_3
	var_11_1.sprite = var_3("ui/story_atlas", var_11_0)

	local var_11_2 = arg_11_0.speedPanelImg

	var_2.SetNativeSize(var_11_2)

	ipairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_0.speedList) do
		local var_11_3 = iter_11_1.name == var_11_0
		local var_11_4 = iter_11_1:Find("Text")
		local var_11_5 = var_8.GetComponent

		typeof = var_11
		Image = var_1_10013

		local var_11_6 = var_11_5(var_11_4, var_11(var_1_10013))
		local var_11_7

		if not var_11_3 or not var_0_1 then
			var_11_7 = var_0_2
		end

		var_11_6.color = var_11_7
	end

	local var_11_8 = arg_11_0.speedPanelAniEvent

	var_2.SetEndEvent(var_11_8, function()
		if arg_11_0.speedPanelStatus == var_0_5 then
			setActive = var_0

			var_0(arg_11_0.speedPanel, false)

			local var_12_0 = arg_11_0.speedPanelAniEvent

			var_0.SetEndEvent(var_12_0, nil)
		elseif arg_11_0.speedPanelStatus == var_0_3 then
			-- block empty
		end

		arg_11_0.speedPanelStatus = var_0_3

		return
	end)

	local var_11_9 = arg_11_0.speedPanelAnim

	var_2.Stop(var_11_9)

	local var_11_10 = arg_11_0.speedPanelAnim

	var_2.Play(var_11_10, "anim_newstoryUI_speedpanel_in")

	arg_11_0.speedPanelStatus = var_0_4

	arg_11_0:AddHideSettingsTimer()

	return
end

function var_0_0.AddHideSettingsTimer(arg_13_0)
	arg_13_0:RemoveTimer()

	Timer = var_1
	arg_13_0.timer = var_1.New(function()
		local var_14_0 = arg_13_0

		var_0.HideSettings(var_14_0)

		return
	end, 5, 1)

	local var_13_0 = arg_13_0.timer

	var_1.Start(var_13_0)

	return
end

function var_0_0.RemoveTimer(arg_15_0)
	if arg_15_0.timer then
		local var_15_0 = arg_15_0.timer

		var_1.Stop(var_15_0)

		arg_15_0.timer = nil
	end

	return
end

function var_0_0.HideSettings(arg_16_0)
	arg_16_0:RemoveTimer()
	arg_16_0:Show(arg_16_0.story)

	local var_16_0 = arg_16_0.speedPanelAnim

	var_1.Stop(var_16_0)

	local var_16_1 = arg_16_0.speedPanelAnim

	var_1.Play(var_16_1, "anim_newstoryUI_speedpanel_out")

	arg_16_0.speedPanelStatus = var_0_5

	return
end

function var_0_0.Clear(arg_17_0)
	arg_17_0:RemoveTimer()

	setActive = var_1

	var_1(arg_17_0.speedBtn, false)

	setActiveByCanvasGroup = var_1

	var_1(arg_17_0.speedBtn, true)

	setActive = var_1

	var_1(arg_17_0.speedPanel, false)

	local var_17_0 = arg_17_0.speedAnim

	var_1.Stop(var_17_0)

	local var_17_1 = arg_17_0.speedPanelAnim

	var_1.Stop(var_17_1)

	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:Clear()

	return
end

return var_0_0
