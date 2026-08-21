local var_0_0 = class("SecretShipyardScene", import("..base.BaseUI"))

var_0_0.optionsPath = {
	"main/top/btn_home"
}
var_0_0.ACT_ID = 5625
var_0_0.GAME_ID = 59
var_0_0.ANIMATIONS = {
	"Phase_00",
	"Phase_01",
	"Phase_02",
	"Phase_03",
	"Phase_04",
	"Phase_05",
	"Phase_06",
	"Phase_07"
}
var_0_0.EFFECT_DELAY = 2
var_0_0.ANIMATION_DELAY = 1
var_0_0.STORY_DELAY = 3

function var_0_0.getUIName(arg_1_0)
	return "SecretShipyardUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.activity = getProxy(ActivityProxy):getActivityById(var_0_0.ACT_ID)
	arg_2_0.count = 0
	arg_2_0.bgId = 1
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = arg_2_0.activity:getConfig("config_data")
	arg_2_0.main = arg_2_0._tf:Find("main")
	arg_2_0.bottom = arg_2_0.main:Find("bottom")
	arg_2_0.gameButton = arg_2_0.bottom:Find("btn_go_game")
	arg_2_0.gameButtonLock = arg_2_0.gameButton:Find("btn_go_game_lock")
	arg_2_0.items = arg_2_0.bottom:Find("items")
	arg_2_0.item = arg_2_0.bottom:Find("item")
	arg_2_0.dayText = arg_2_0.bottom:Find("day/nday")
	arg_2_0.description = arg_2_0.bottom:Find("description/Text")
	arg_2_0.top = arg_2_0.main:Find("top")
	arg_2_0.buttonBack = arg_2_0.top:Find("btn_back")
	arg_2_0.buttonHelp = arg_2_0.top:Find("btn_help")
	arg_2_0.uilist = UIItemList.New(arg_2_0.items, arg_2_0.item)
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.animator = arg_2_0.bg:Find("anim"):GetComponent(typeof(Animator))
	arg_2_0.effect = arg_2_0.bg:Find("effect")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.buttonBack, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.buttonHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("shipyard_phase_1" or "shipyard_phase_2")
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.gameButton, function()
		if not arg_3_0:checkTaskFinish() or not arg_3_0:checkMinigame() then
			return
		end

		arg_3_0:emit(SecretShipyardMediator.GO_MINI_GAME, var_0_0.GAME_ID)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.gameButtonLock, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n(arg_3_0:checkTaskFinish() and "shipyard_button_1" or "shipyard_button_2"))

		return
	end, SFX_PANEL)
	arg_3_0.uilist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateTask(arg_8_1, arg_8_2)
		end

		return
	end)
	setText(arg_3_0.description, i18n("shipyard_introduce"))
	setActive(arg_3_0.effect, false)
	setActive(arg_3_0.buttonHelp, arg_3_0:checkMinigame())

	arg_3_0.count = arg_3_0.activity.data3
	arg_3_0.bgId = arg_3_0:CheckBgId()

	arg_3_0.animator:Play(var_0_0.ANIMATIONS[arg_3_0.bgId])
	arg_3_0:OnUpdateFlush()

	local var_3_0 = arg_3_0.activity:getConfig("config_client").firstStory

	if var_3_0 then
		playStory(var_3_0)
	end

	arg_3_0:PlayStory()

	return
end

function var_0_0.UpdateTask(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2:Find("item")
	local var_9_1 = arg_9_0.taskGroup[arg_9_0.count][arg_9_1 + 1]
	local var_9_2 = arg_9_0.taskProxy:getTaskById(arg_9_0.taskGroup[arg_9_0.count][arg_9_1 + 1]) or arg_9_0.taskProxy:getFinishTaskById(var_9_1)

	assert(var_9_2, "without this task by id: " .. arg_9_0.taskGroup[arg_9_0.count][arg_9_1 + 1])

	local var_9_3 = var_9_2:getConfig("award_display")[1]

	updateDrop(var_9_0, {
		type = var_9_3[1],
		id = var_9_3[2],
		count = var_9_3[3]
	})
	onButton(arg_9_0, var_9_0, function()
		warning("click")
		arg_9_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_9_4 = var_9_2:getProgress()
	local var_9_5 = var_9_2:getConfig("target_num")

	setText(arg_9_2:Find("description"), var_9_2:getConfig("desc"))
	setText(arg_9_2:Find("progress_text"), var_9_4 .. "/" .. var_9_5)
	setSlider(arg_9_2:Find("progress"), 0, var_9_5, var_9_4)

	local var_9_6 = arg_9_2:Find("go_btn")
	local var_9_7 = arg_9_2:Find("get_btn")
	local var_9_8 = arg_9_2:Find("got_btn")
	local var_9_9 = var_9_2:getTaskStatus()

	setActive(var_9_6, var_9_9 == 0)
	setActive(var_9_7, var_9_9 == 1)
	setActive(var_9_8, var_9_9 == 2)
	onButton(arg_9_0, var_9_6, function()
		arg_9_0:emit(SecretShipyardMediator.TASK_GO, var_9_2)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, var_9_7, function()
		arg_9_0:emit(SecretShipyardMediator.SUBMIT_TASK, var_9_2.id)

		return
	end, SFX_PANEL)
	setActive(arg_9_2:Find("mask"), arg_9_0.taskProxy:getFinishTaskById(var_9_1) ~= nil)

	return
end

function var_0_0.updateTaskLayers(arg_13_0)
	updateActivityTaskStatus(arg_13_0.activity)

	arg_13_0.activity = getProxy(ActivityProxy):getActivityById(var_0_0.ACT_ID)

	arg_13_0:OnUpdateFlush()

	return
end

function var_0_0.CheckBgId(arg_14_0)
	local var_14_0 = arg_14_0.activity.data3

	if arg_14_0.taskProxy:getFinishTaskById(arg_14_0.taskGroup[arg_14_0.count][1]) ~= nil and arg_14_0.taskProxy:getFinishTaskById(arg_14_0.taskGroup[arg_14_0.count][2]) ~= nil then
		var_14_0 = var_14_0 + 1
	end

	return var_14_0
end

function var_0_0.OnUpdateFlush(arg_15_0)
	arg_15_0.count = arg_15_0.activity.data3

	if arg_15_0.bgId ~= arg_15_0:CheckBgId() then
		arg_15_0.bgId = arg_15_0:CheckBgId()

		arg_15_0:ChangeBackground()
	end

	if arg_15_0.dayText then
		setText(arg_15_0.dayText, tostring(arg_15_0.count))
	end

	setActive(arg_15_0.gameButtonLock, not arg_15_0:checkTaskFinish() or not arg_15_0:checkMinigame())

	local var_15_0 = arg_15_0:checkTaskFinish() or arg_15_0:checkMinigame()

	setActive(arg_15_0.gameButton, var_15_0)
	arg_15_0.uilist:align(#arg_15_0.taskGroup[arg_15_0.count])

	return
end

function var_0_0.ChangeBackground(arg_16_0)
	LeanTween.cancel(go(arg_16_0._tf))
	setActive(arg_16_0.effect, true)
	LeanTween.delayedCall(go(arg_16_0._tf), var_0_0.ANIMATION_DELAY, System.Action(function()
		arg_16_0.animator:Play(var_0_0.ANIMATIONS[arg_16_0.bgId])

		return
	end))
	LeanTween.delayedCall(go(arg_16_0._tf), var_0_0.EFFECT_DELAY, System.Action(function()
		setActive(arg_16_0.effect, false)

		return
	end))
	LeanTween.delayedCall(go(arg_16_0._tf), var_0_0.STORY_DELAY, System.Action(function()
		arg_16_0:PlayStory()

		return
	end))

	return
end

function var_0_0.PlayStory(arg_20_0)
	local var_20_0 = arg_20_0.activity:getConfig("config_client").story

	if checkExist(var_20_0, {
		arg_20_0.bgId - 1
	}, {
		1
	}) then
		playStory(var_20_0[arg_20_0.bgId - 1][1])
	end

	return
end

function var_0_0.checkTaskFinish(arg_21_0)
	if arg_21_0.count < #arg_21_0.taskGroup then
		return false
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.taskGroup[arg_21_0.count]) do
		if not arg_21_0.taskProxy:getFinishTaskById(iter_21_1) then
			return false
		end
	end

	return true
end

function var_0_0.checkMinigame(arg_22_0)
	local var_22_0 = pg.TimeMgr.GetInstance():inTime(pg.mini_game[var_0_0.GAME_ID].simple_config_data.show_time)

	return pg.mini_game[var_0_0.GAME_ID] ~= nil and var_22_0
end

function var_0_0.willExit(arg_23_0)
	LeanTween.cancel(go(arg_23_0._tf))

	return
end

return var_0_0
