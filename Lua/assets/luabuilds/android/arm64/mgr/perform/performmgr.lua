pg = pg or {}

local var_0_0 = singletonClass("PerformMgr")

pg.PerformMgr = var_0_0

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_10 = 2

require("Mgr/Perform/Include")

local var_0_11 = true

local function var_0_12(...)
	if var_0_11 and IsUnityEditor then
		originalPrint(...)
	end

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.status = var_0_1
	arg_2_0.playedList = {}
	arg_2_0.playQueue = {}

	if arg_2_1 then
		arg_2_1()
	end

	return
end

function var_0_0.CheckLoad(arg_3_0, arg_3_1)
	seriesAsync({
		function(arg_4_0)
			if not arg_3_0._go then
				PoolMgr.GetInstance():GetUI("PerformUI", true, function(arg_5_0)
					arg_3_0._go = arg_5_0
					arg_3_0._tf = tf(arg_3_0._go)
					arg_3_0.UIOverlay = GameObject.Find("Overlay/UIOverlay")

					arg_3_0._go.transform:SetParent(arg_3_0.UIOverlay.transform, false)

					arg_3_0.cpkPlayer = CpkPerformPlayer.New(findTF(arg_3_0._tf, "window_cpk"))
					arg_3_0.dialoguePlayer = DialoguePerformPlayer.New(findTF(arg_3_0._tf, "window_dialogue"))
					arg_3_0.picturePlayer = PictruePerformPlayer.New(findTF(arg_3_0._tf, "window_picture"))
					arg_3_0.storyPlayer = StoryPerformPlayer.New(findTF(arg_3_0._tf, "window_story"))

					setActive(arg_3_0._go, false)

					arg_3_0.status = var_0_2

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

function var_0_0.PlayOne(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	assert(pg.child_performance[arg_7_1], "child_performance not exist id: " .. arg_7_1)

	if not arg_7_0:CheckState() then
		var_0_12("perform state error" .. arg_7_0.status)

		return nil
	end

	var_0_12("OnlyOne Play")
	arg_7_0:Show()
	arg_7_0:play(arg_7_1, function()
		arg_7_0:Hide()

		if arg_7_2 then
			arg_7_2()
		end

		return
	end, arg_7_3, arg_7_4)

	return
end

function var_0_0.PlayGroup(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		table.insert({}, function(arg_10_0)
			arg_9_0:play(iter_9_1, arg_10_0, arg_9_3, arg_9_4)

			return
		end)
	end

	arg_9_0:Show()
	seriesAsync({}, function(arg_11_0)
		arg_9_0:Hide()

		if arg_9_2 then
			arg_9_2()
		end

		return
	end)

	return
end

function var_0_0.play(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	assert(pg.child_performance[arg_12_1], "child_performance not exist id: " .. arg_12_1)

	if not arg_12_0:CheckState() then
		var_0_12("perform state error" .. arg_12_0.status)

		return nil
	end

	var_0_12("Play Perform:", arg_12_1)
	arg_12_0:addTaskProgress(arg_12_1)

	arg_12_0.status = var_0_4

	local function var_12_0()
		arg_12_0.status = var_0_5

		if arg_12_2 then
			arg_12_2()
		end

		return
	end

	local var_12_1 = pg.child_performance[arg_12_1]

	arg_12_0:setWindowStatus(pg.child_performance[arg_12_1])
	switch(pg.child_performance[arg_12_1].type, {
		[EducateConst.PERFORM_TYPE_ANIM] = function()
			arg_12_0.cpkPlayer:Play(var_12_1, var_12_0, arg_12_4)

			return
		end,
		[EducateConst.PERFORM_TYPE_WORD] = function()
			({}).drops = arg_12_3 or {}

			arg_12_0.dialoguePlayer:Play(setmetatable({}, {
				__index = var_12_1
			}), var_12_0)

			return
		end,
		[EducateConst.PERFORM_TYPE_STORY] = function()
			arg_12_0.storyPlayer:Play(var_12_1, var_12_0)

			return
		end,
		[EducateConst.PERFORM_TYPE_PICTURE] = function()
			arg_12_0.picturePlayer:Play(var_12_1, var_12_0, arg_12_4)

			return
		end
	})

	return
end

function var_0_0.addTaskProgress(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs((getProxy(EducateProxy):GetTaskProxy():GetPerformAddTasks(arg_18_1))) do
		if iter_18_1:IsMind() then
			table.insert({}, {
				progress = 1,
				task_id = iter_18_1.id
			})
		end

		if iter_18_1:IsTarget() then
			table.insert({}, {
				progress = 1,
				task_id = iter_18_1.id
			})
		end

		if iter_18_1:IsMain() then
			table.insert({}, {
				progress = 1,
				task_id = iter_18_1.id
			})
		end
	end

	if #{} > 0 then
		pg.m02:sendNotification(GAME.EDUCATE_ADD_TASK_PROGRESS, {
			system = EducateTask.SYSTEM_TYPE_MIND,
			progresses = {}
		})
	end

	if #{} > 0 then
		pg.m02:sendNotification(GAME.EDUCATE_ADD_TASK_PROGRESS, {
			system = EducateTask.SYSTEM_TYPE_TARGET,
			progresses = {}
		})
	end

	if #{} > 0 then
		pg.m02:sendNotification(GAME.EDUCATE_ADD_TASK_PROGRESS, {
			system = EducateTask.STSTEM_TYPE_MAIN,
			progresses = {}
		})
	end

	return
end

function var_0_0.PlayGroupNoHide(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		table.insert({}, function(arg_20_0)
			arg_19_0:play(iter_19_1, arg_20_0, arg_19_3, arg_19_4)

			return
		end)
	end

	seriesAsync({}, arg_19_2)

	return
end

function var_0_0.setWindowStatus(arg_21_0, arg_21_1)
	setActive(arg_21_0.cpkPlayer._tf, arg_21_1.cpk_status == var_0_10)
	setActive(arg_21_0.dialoguePlayer._tf, arg_21_1.dialogue_status == var_0_10)
	setActive(arg_21_0.picturePlayer._tf, arg_21_1.picture_status == var_0_10)
	setActive(arg_21_0.storyPlayer._tf, arg_21_1.story_status == var_0_10)

	return
end

function var_0_0.CheckState(arg_22_0)
	if arg_22_0.status == var_0_1 then
		return false
	end

	return true
end

function var_0_0.IsRunning(arg_23_0)
	return arg_23_0.status == var_0_3 or arg_23_0.status == var_0_4 or arg_23_0.status == var_0_5
end

function var_0_0.Show(arg_24_0)
	arg_24_0:CheckLoad(function()
		arg_24_0:_Show()

		return
	end)

	return
end

function var_0_0._Show(arg_26_0)
	arg_26_0.status = var_0_3

	setActive(arg_26_0._go, true)
	arg_26_0._tf:SetAsLastSibling()

	return
end

function var_0_0.Clear(arg_27_0)
	arg_27_0.cpkPlayer:Clear()
	arg_27_0.dialoguePlayer:Clear()
	arg_27_0.picturePlayer:Clear()
	arg_27_0.storyPlayer:Clear()

	return
end

function var_0_0.Show(arg_28_0)
	arg_28_0:CheckLoad(function()
		arg_28_0:_Show()

		return
	end)

	return
end

function var_0_0.Hide(arg_30_0)
	arg_30_0:Clear()
	setActive(arg_30_0._go, false)

	arg_30_0.status = var_0_6

	return
end

function var_0_0.Quit(arg_31_0)
	Object.Destroy(arg_31_0._go)

	arg_31_0._go = nil
	arg_31_0._tf = nil
	arg_31_0.status = var_0_7

	if arg_31_0.cpkPlayer then
		arg_31_0.cpkPlayer:Dispose()

		arg_31_0.cpkPlayer = nil
	end

	if arg_31_0.dialoguePlayer then
		arg_31_0.dialoguePlayer:Dispose()

		arg_31_0.dialoguePlayer = nil
	end

	if arg_31_0.picturePlayer then
		arg_31_0.picturePlayer:Dispose()

		arg_31_0.picturePlayer = nil
	end

	if arg_31_0.storyPlayer then
		arg_31_0.storyPlayer:Dispose()

		arg_31_0.storyPlayer = nil
	end

	return
end

function var_0_0.SetParamForUI(arg_32_0, arg_32_1)
	arg_32_0:CheckLoad(function()
		arg_32_0:_SetParamForUI(arg_32_1)

		return
	end)

	return
end

function var_0_0._SetParamForUI(arg_34_0, arg_34_1)
	local var_34_0 = var_0_0.UI_PARAM[arg_34_1] or var_0_0.UI_PARAM.Default

	arg_34_0.cpkPlayer:SetUIParam(var_34_0)

	return
end

var_0_0.UI_PARAM = {
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
