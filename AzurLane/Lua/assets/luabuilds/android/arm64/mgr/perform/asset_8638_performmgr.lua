pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
singletonClass = pg

local var_0_1 = var_0("PerformMgr")

pg = var_0_10001
var_0_10001.PerformMgr = var_0_1

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6
local var_0_8 = 7
local var_0_9 = 0
local var_0_10 = 1
local var_0_11 = 2

require = var_0_10011

var_0_10011("Mgr/Perform/Include")

local var_0_12 = true

local function var_0_13(...)
	if var_0_12 then
		IsUnityEditor = var_0

		if var_0 then
			originalPrint = var_0

			var_0(...)
		end
	end

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	arg_2_0.status = var_0_2
	arg_2_0.playedList = {}
	arg_2_0.playQueue = {}

	if arg_2_1 then
		arg_2_1()
	end

	return
end

function var_0_1.CheckLoad(arg_3_0, arg_3_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_4_0)
			if not arg_3_0._go then
				PoolMgr = var_1

				local var_4_0 = var_1.GetInstance()

				var_1.GetUI(var_4_0, "PerformUI", true, function(arg_5_0)
					arg_3_0._go = arg_5_0

					local var_5_0 = arg_3_0

					tf = var_3_10002
					var_5_0._tf = var_3_10002(arg_3_0._go)

					local var_5_1 = arg_3_0

					GameObject = var_2
					var_5_1.UIOverlay = var_2.Find("Overlay/UIOverlay")

					local var_5_2 = arg_3_0._go.transform

					var_1.SetParent(var_5_2, arg_3_0.UIOverlay.transform, false)

					local var_5_3 = arg_3_0

					CpkPerformPlayer = var_2

					local var_5_4 = var_2.New

					findTF = var_4
					var_5_3.cpkPlayer = var_5_4(var_4(arg_3_0._tf, "window_cpk"))

					local var_5_5 = arg_3_0

					DialoguePerformPlayer = var_2

					local var_5_6 = var_2.New

					findTF = var_4
					var_5_5.dialoguePlayer = var_5_6(var_4(arg_3_0._tf, "window_dialogue"))

					local var_5_7 = arg_3_0

					PictruePerformPlayer = var_2

					local var_5_8 = var_2.New

					findTF = var_4
					var_5_7.picturePlayer = var_5_8(var_4(arg_3_0._tf, "window_picture"))

					local var_5_9 = arg_3_0

					StoryPerformPlayer = var_2

					local var_5_10 = var_2.New

					findTF = var_4
					var_5_9.storyPlayer = var_5_10(var_4(arg_3_0._tf, "window_story"))
					setActive = var_5_9

					var_5_9(arg_3_0._go, false)

					arg_3_0.status = var_0_3

					arg_4_0()

					return
				end)
			else
				arg_4_0()
			end

			return
		end
	}, function()
		if arg_3_1 then
			arg_3_1()
		end

		return
	end)

	return
end

function var_0_1.PlayOne(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	assert = var_1_10005
	pg = var_1_10007

	var_1_10005(var_1_10007.child_performance[arg_7_1], "child_performance not exist id: " .. arg_7_1)

	if not arg_7_0:CheckState() then
		var_0_13("perform state error" .. arg_7_0.status)

		return nil
	end

	var_0_13("OnlyOne Play")
	arg_7_0:Show()

	local function var_7_0()
		local var_8_0 = arg_7_0

		var_0.Hide(var_8_0)

		if arg_7_2 then
			arg_7_2()
		end

		return
	end

	arg_7_0:play(arg_7_1, var_7_0, arg_7_3, arg_7_4)

	return
end

function var_0_1.PlayGroup(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = {}

	ipairs = var_1_10006

	for iter_9_0, iter_9_1 in var_1_10006(arg_9_1) do
		table = var_1_10011

		var_1_10011.insert(var_9_0, function(arg_10_0)
			local var_10_0 = arg_9_0

			var_1.play(var_10_0, iter_9_1, arg_10_0, arg_9_3, arg_9_4)

			return
		end)
	end

	arg_9_0:Show()

	seriesAsync = var_6

	var_6(var_9_0, function(arg_11_0)
		local var_11_0 = arg_9_0

		var_1.Hide(var_11_0)

		if arg_9_2 then
			arg_9_2()
		end

		return
	end)

	return
end

function var_0_1.play(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	assert = var_1_10005
	pg = var_1_10007

	var_1_10005(var_1_10007.child_performance[arg_12_1], "child_performance not exist id: " .. arg_12_1)

	if not arg_12_0:CheckState() then
		var_0_13("perform state error" .. arg_12_0.status)

		return nil
	end

	var_0_13("Play Perform:", arg_12_1)
	arg_12_0:addTaskProgress(arg_12_1)

	arg_12_0.status = var_0_5

	local function var_12_0()
		arg_12_0.status = var_0_6

		if arg_12_2 then
			arg_12_2()
		end

		return
	end

	pg = var_1_10006

	local var_12_1 = var_1_10006.child_performance[arg_12_1]

	arg_12_0:setWindowStatus(var_12_1)

	switch = var_7

	local var_12_2 = var_12_1.type
	local var_12_3 = {}

	EducateConst = var_1_10011
	var_12_3[var_1_10011.PERFORM_TYPE_ANIM] = function()
		local var_14_0 = arg_12_0.cpkPlayer

		var_0.Play(var_14_0, var_12_1, var_12_0, arg_12_4)

		return
	end
	EducateConst = var_11
	var_12_3[var_11.PERFORM_TYPE_WORD] = function()
		setmetatable = var_2_10000

		local var_15_0 = {}
		local var_15_1

		if not arg_12_3 then
			var_15_1 = {}
		end

		var_15_0.drops = var_15_1

		local var_15_2 = var_2_10000(var_15_0, {
			__index = var_12_1
		})
		local var_15_3 = arg_12_0.dialoguePlayer

		var_1.Play(var_15_3, var_15_2, var_12_0)

		return
	end
	EducateConst = var_11
	var_12_3[var_11.PERFORM_TYPE_STORY] = function()
		local var_16_0 = arg_12_0.storyPlayer

		var_0.Play(var_16_0, var_12_1, var_12_0)

		return
	end
	EducateConst = var_11
	var_12_3[var_11.PERFORM_TYPE_PICTURE] = function()
		local var_17_0 = arg_12_0.picturePlayer

		var_0.Play(var_17_0, var_12_1, var_12_0, arg_12_4)

		return
	end

	var_7(var_12_2, var_12_3)

	return
end

function var_0_1.addTaskProgress(arg_18_0, arg_18_1)
	getProxy = var_1_10002
	EducateProxy = var_1_10004

	local var_18_0 = var_1_10002(var_1_10004)
	local var_18_1 = var_2.GetTaskProxy(var_18_0)
	local var_18_2 = var_2.GetPerformAddTasks(var_18_1, arg_18_1)
	local var_18_3 = {}
	local var_18_4 = {}
	local var_18_5 = {}

	ipairs = var_1_10006

	for iter_18_0, iter_18_1 in var_1_10006(var_18_2) do
		if iter_18_1:IsMind() then
			table = var_1_10011

			var_1_10011.insert(var_18_3, {
				progress = 1,
				task_id = iter_18_1.id
			})
		end

		if iter_18_1:IsTarget() then
			table = var_1_10011

			var_1_10011.insert(var_18_4, {
				progress = 1,
				task_id = iter_18_1.id
			})
		end

		if iter_18_1:IsMain() then
			table = var_1_10011

			var_1_10011.insert(var_18_5, {
				progress = 1,
				task_id = iter_18_1.id
			})
		end
	end

	if #var_18_3 > 0 then
		pg = var_6

		local var_18_6 = var_6.m02
		local var_18_7 = var_6.sendNotification

		GAME = iter_18_0
		iter_18_0 = iter_18_0.EDUCATE_ADD_TASK_PROGRESS

		local var_18_8 = {}

		EducateTask = var_1_10011
		var_18_8.system = var_1_10011.SYSTEM_TYPE_MIND
		var_18_8.progresses = var_18_3

		var_18_7(var_18_6, iter_18_0, var_18_8)
	end

	if #var_18_4 > 0 then
		pg = var_6

		local var_18_9 = var_6.m02
		local var_18_10 = var_6.sendNotification

		GAME = iter_18_0
		iter_18_0 = iter_18_0.EDUCATE_ADD_TASK_PROGRESS

		local var_18_11 = {}

		EducateTask = var_1_10011
		var_18_11.system = var_1_10011.SYSTEM_TYPE_TARGET
		var_18_11.progresses = var_18_4

		var_18_10(var_18_9, iter_18_0, var_18_11)
	end

	if #var_18_5 > 0 then
		pg = var_6

		local var_18_12 = var_6.m02
		local var_18_13 = var_6.sendNotification

		GAME = iter_18_0

		local var_18_14 = iter_18_0.EDUCATE_ADD_TASK_PROGRESS
		local var_18_15 = {}

		EducateTask = var_1_10011
		var_18_15.system = var_1_10011.STSTEM_TYPE_MAIN
		var_18_15.progresses = var_18_5

		var_18_13(var_18_12, var_18_14, var_18_15)
	end

	return
end

function var_0_1.PlayGroupNoHide(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = {}

	ipairs = var_1_10006

	for iter_19_0, iter_19_1 in var_1_10006(arg_19_1) do
		table = var_1_10011

		var_1_10011.insert(var_19_0, function(arg_20_0)
			local var_20_0 = arg_19_0

			var_1.play(var_20_0, iter_19_1, arg_20_0, arg_19_3, arg_19_4)

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_19_0, arg_19_2)

	return
end

function var_0_1.setWindowStatus(arg_21_0, arg_21_1)
	setActive = var_1_10002

	var_1_10002(arg_21_0.cpkPlayer._tf, arg_21_1.cpk_status == var_0_11)

	setActive = var_1_10002

	var_1_10002(arg_21_0.dialoguePlayer._tf, arg_21_1.dialogue_status == var_0_11)

	setActive = var_1_10002

	var_1_10002(arg_21_0.picturePlayer._tf, arg_21_1.picture_status == var_0_11)

	setActive = var_1_10002

	var_1_10002(arg_21_0.storyPlayer._tf, arg_21_1.story_status == var_0_11)

	return
end

function var_0_1.CheckState(arg_22_0)
	if arg_22_0.status == var_0_2 then
		return false
	end

	return true
end

function var_0_1.IsRunning(arg_23_0)
	return arg_23_0.status == var_0_4 or arg_23_0.status == var_0_5 or arg_23_0.status == var_0_6
end

function var_0_1.Show(arg_24_0)
	arg_24_0:CheckLoad(function()
		local var_25_0 = arg_24_0

		var_0._Show(var_25_0)

		return
	end)

	return
end

function var_0_1._Show(arg_26_0)
	arg_26_0.status = var_0_4
	setActive = var_1

	var_1(arg_26_0._go, true)

	local var_26_0 = arg_26_0._tf

	var_1.SetAsLastSibling(var_26_0)

	return
end

function var_0_1.Clear(arg_27_0)
	local var_27_0 = arg_27_0.cpkPlayer

	var_1.Clear(var_27_0)

	local var_27_1 = arg_27_0.dialoguePlayer

	var_1.Clear(var_27_1)

	local var_27_2 = arg_27_0.picturePlayer

	var_1.Clear(var_27_2)

	local var_27_3 = arg_27_0.storyPlayer

	var_1.Clear(var_27_3)

	return
end

function var_0_1.Show(arg_28_0)
	arg_28_0:CheckLoad(function()
		local var_29_0 = arg_28_0

		var_0._Show(var_29_0)

		return
	end)

	return
end

function var_0_1.Hide(arg_30_0)
	arg_30_0:Clear()

	setActive = var_1

	var_1(arg_30_0._go, false)

	arg_30_0.status = var_0_7

	return
end

function var_0_1.Quit(arg_31_0)
	Object = var_1_10001

	var_1_10001.Destroy(arg_31_0._go)

	arg_31_0._go = nil
	arg_31_0._tf = nil
	arg_31_0.status = var_0_8

	if arg_31_0.cpkPlayer then
		local var_31_0 = arg_31_0.cpkPlayer

		var_1.Dispose(var_31_0)

		arg_31_0.cpkPlayer = nil
	end

	if arg_31_0.dialoguePlayer then
		local var_31_1 = arg_31_0.dialoguePlayer

		var_1.Dispose(var_31_1)

		arg_31_0.dialoguePlayer = nil
	end

	if arg_31_0.picturePlayer then
		local var_31_2 = arg_31_0.picturePlayer

		var_1.Dispose(var_31_2)

		arg_31_0.picturePlayer = nil
	end

	if arg_31_0.storyPlayer then
		local var_31_3 = arg_31_0.storyPlayer

		var_1.Dispose(var_31_3)

		arg_31_0.storyPlayer = nil
	end

	return
end

function var_0_1.SetParamForUI(arg_32_0, arg_32_1)
	arg_32_0:CheckLoad(function()
		local var_33_0 = arg_32_0

		var_0._SetParamForUI(var_33_0, arg_32_1)

		return
	end)

	return
end

function var_0_1._SetParamForUI(arg_34_0, arg_34_1)
	local var_34_0

	if not var_0_1.UI_PARAM[arg_34_1] then
		var_34_0 = var_0_1.UI_PARAM.Default
	end

	local var_34_1 = arg_34_0.cpkPlayer

	var_3.SetUIParam(var_34_1, var_34_0)

	return
end

var_0_1.UI_PARAM = {
	Default = {
		showCpkBg = true,
		sliderPos = {
			x = 0,
			y = 358
		},
		cpkPos = {
			x = 0,
			y = -25
		},
		cpkCoverPos = {
			x = 0,
			y = -380
		}
	},
	EducateSchedulePerformLayer = {
		showCpkBg = false,
		sliderPos = {
			x = 144,
			y = 344
		},
		cpkPos = {
			x = 144,
			y = -25
		},
		cpkCoverPos = {
			x = 144,
			y = -383
		}
	}
}

return
