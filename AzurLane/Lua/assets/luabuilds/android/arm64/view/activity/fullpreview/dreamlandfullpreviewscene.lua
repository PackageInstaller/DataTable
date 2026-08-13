class = var_0_10000

local var_0_0 = "DreamlandFullPreviewScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".FullPreviewSceneTemplate"))

var_0_1.MINIGAME_ID = 66

function var_0_1.getUIName(arg_1_0)
	return "DreamlandFullPreviewUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "btns")

	arg_2_0.dreamlandBtn = var_1.Find(var_2_1, "dreamland")
	arg_2_0.skinBtn = var_1:Find("skin")
	arg_2_0.buildBtn = var_1:Find("build")
	arg_2_0.battleBtn = var_1:Find("battle")
	arg_2_0.minigameBtn = var_1:Find("minigame")
	setText = var_2

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_4.Find(var_2_2, "top/info/Text")

	i18n = var_5

	var_2(var_2_3, var_5("dreamland_main_desc"))

	getProxy = var_2
	ActivityProxy = var_2_3

	local var_2_4 = var_2(var_2_3)
	local var_2_5 = var_2.getActivityByType

	ActivityConst = var_5

	local var_2_6 = var_2_5(var_2_4, var_5.ACTIVITY_TYPE_DREAMLAND)

	arg_2_0.preActId = var_2.getConfig(var_2_6, "config_client").preActID
	underscore = var_3

	local var_2_7 = var_3.flatten

	pg = var_2_6
	arg_2_0.taskId = var_3[#var_2_7(var_2_6.activity_template[arg_2_0.preActId].config_data)]

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "top/home")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_4.Find(var_3_9, "top/help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.dreamland_main_tip.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_3_9

	var_1_10001(var_3_8, var_3_10, var_3_11, var_3_9)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.dreamlandBtn

	local function var_3_14()
		if arg_3_0.isFinishPre then
			local var_7_0 = arg_3_0
			local var_7_1 = var_0.emit

			FullPreviewMediatorTemplate = var_2_10003
			var_2_10003 = var_2_10003.GO_SCENE
			SCENE = var_2_10004

			var_7_1(var_7_0, var_2_10003, var_2_10004.DREAMLAND)
		else
			local var_7_2 = arg_3_0
			local var_7_3 = var_0.emit

			FullPreviewMediatorTemplate = var_2_10003

			local var_7_4 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_7_3(var_7_2, var_7_4, var_2_10004.ACTIVITY, {
				id = arg_3_0.preActId
			})
		end

		return
	end

	SFX_PANEL = var_3_9

	var_1_10001(var_3_12, var_3_13, var_3_14, var_3_9)
	arg_3_0:BindSkinShop(arg_3_0.skinBtn)
	arg_3_0:BindBuildShip(arg_3_0.buildBtn)
	arg_3_0:BindBattle(arg_3_0.battleBtn)
	arg_3_0:BindMiniGame(arg_3_0.minigameBtn, var_0_1.MINIGAME_ID)
	arg_3_0:UpdateView()

	return
end

function var_0_1.IsFinishPreAct(arg_8_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1

	if not var_1.getTaskById(var_8_0, arg_8_0.taskId) then
		var_8_1 = var_1:getFinishTaskById(arg_8_0.taskId)
	end

	return var_8_1 and var_8_1:getTaskStatus() == 2
end

function var_0_1.UpdateView(arg_9_0)
	setActive = var_1_10001

	local var_9_0 = arg_9_0.minigameBtn

	var_1_10001(var_3.Find(var_9_0, "tip"), var_0_1.MiniGameTip())

	setActive = var_1_10001

	local var_9_1 = arg_9_0.dreamlandBtn

	var_1_10001(var_3.Find(var_9_1, "dreamland/tip"), var_0_1.DreamlandTip())

	arg_9_0.isFinishPre = arg_9_0:IsFinishPreAct()
	setActive = var_1

	local var_9_2 = arg_9_0.dreamlandBtn

	var_1(var_3.Find(var_9_2, "dreamland"), arg_9_0.isFinishPre)

	setActive = var_1

	local var_9_3 = arg_9_0.dreamlandBtn

	var_1(var_3.Find(var_9_3, "pre_act"), not arg_9_0.isFinishPre)

	getProxy = var_1
	ActivityProxy = var_3

	local var_9_4 = var_1(var_3)
	local var_9_5 = var_1.getActivityById(var_9_4, arg_9_0.preActId)

	setActive = var_1_10002

	local var_9_6 = arg_9_0.dreamlandBtn

	var_1_10002(var_4.Find(var_9_6, "pre_act/tip"), var_0_1.ActivityTip(var_9_5))

	return
end

function var_0_1.MiniGameTip()
	return var_0_1.IsMiniGameTip(var_0_1.MINIGAME_ID)
end

function var_0_1.DreamlandTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_11_0 = var_1_10000(var_1_10002)
	local var_11_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_11_2 = var_11_1(var_11_0, var_1_10003.ACTIVITY_TYPE_DREAMLAND)

	getProxy = var_1_10001
	ActivityProxy = var_3

	local var_11_3 = var_1_10001(var_3)
	local var_11_4 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_11_5 = var_11_4(var_11_3, var_1_10004.ACTIVITY_TYPE_HOTSPRING_2)

	DreamlandData = var_11_0

	local var_11_6 = var_11_0.New(var_11_2, var_11_5)

	return var_2.ExistAnyMapOrExploreAward(var_11_6)
end

function var_0_1.ActivityTip(arg_12_0)
	if arg_12_0 then
		var_1_10003 = arg_12_0

		if arg_12_0.isEnd(var_1_10003) then
			return false
		end

		getProxy = var_1_10001
		TaskProxy = var_1_10003

		local var_12_0 = var_1_10001(var_1_10003)

		underscore = var_1_10002

		local var_12_1 = var_1_10002.flatten
		local var_12_2 = arg_12_0
		local var_12_3 = var_12_1(arg_12_0.getConfig(var_12_2, "config_data"))[arg_12_0.data3]
		local var_12_4

		if not var_12_0:getTaskById(var_12_3) then
			var_12_4 = var_12_0:getFinishTaskById(var_12_3)
		end

		math = var_12_2

		local var_12_5 = var_12_2.min(arg_12_0:getDayIndex(), #var_2) - var_3

		if var_12_4:getTaskStatus() == 1 then
			var_12_5 = var_12_5 + 1
		end

		return var_12_5 > 0
	end
end

function var_0_1.IsShowMainTip(arg_13_0)
	local var_13_0

	if not var_0_1.MiniGameTip() then
		var_13_0 = var_0_1.DreamlandTip()
	end

	return var_13_0
end

return var_0_1
