class = var_0_10000

local var_0_0 = "NewYearsEveDinnerPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))
local var_0_2 = 3
local var_0_3 = 2

Vector2 = var_3

local var_0_4 = var_3(760, -144)

Vector2 = var_4

local var_0_5 = var_4(370, -144)

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.roleTF = var_1.Find(var_1_0, "mask/role_pos")

	local var_1_1 = arg_1_0.bg

	arg_1_0.effectNode = var_1.Find(var_1_1, "mofang_yanwu")

	local var_1_2 = arg_1_0.bg

	arg_1_0.foodTF = var_1.Find(var_1_2, "food")

	local var_1_3 = arg_1_0.bg

	arg_1_0.dialogTF = var_1.Find(var_1_3, "dialog")

	local var_1_4 = arg_1_0.bg

	arg_1_0.rightPanel = var_1.Find(var_1_4, "right_panel")

	local var_1_5 = arg_1_0.rightPanel

	arg_1_0.helpBtn = var_1.Find(var_1_5, "help_btn")

	local var_1_6 = arg_1_0.rightPanel

	arg_1_0.titleFoodTF = var_1.Find(var_1_6, "menu_title/icon")

	local var_1_7 = arg_1_0.rightPanel

	arg_1_0.cookBtn = var_1.Find(var_1_7, "cook_btn")

	local var_1_8 = arg_1_0.cookBtn

	arg_1_0.cookProgress = var_1.Find(var_1_8, "progress")

	local var_1_9 = arg_1_0.cookBtn

	arg_1_0.cookAwardTF = var_1.Find(var_1_9, "award")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.cookActID = var_1.getConfig(var_2_0, "config_client").linkTaskPoolAct
	pg = var_1
	arg_2_0.cookCfg = var_1.activity_template[arg_2_0.cookActID].config_client
	pg = var_1
	arg_2_0.cookTaskIds = var_1.activity_template[arg_2_0.cookActID].config_data
	arg_2_0.totalCookCnt = #arg_2_0.cookTaskIds
	getProxy = var_1
	PlayerProxy = var_2

	local var_2_1 = var_1(var_2)

	arg_2_0.playerId = var_1.getData(var_2_1).id
	arg_2_0.randomSeed = arg_2_0:GetRandomById()

	var_0_1.super.OnDataSetting(arg_2_0)

	return
end

function var_0_1.GetRandomById(arg_3_0)
	local var_3_0 = arg_3_0.playerId
	local var_3_1 = {}

	while #var_3_1 < 7 do
		local var_3_2 = var_3_0 % 10

		math = var_4

		if var_4.floor(var_3_0 / 10) == 0 then
			var_3_0 = arg_3_0.playerId
		end

		table = var_4

		var_4.insert(var_3_1, var_3_2)
	end

	return var_3_1
end

function var_0_1.OnFirstFlush(arg_4_0)
	var_0_1.super.OnFirstFlush(arg_4_0)

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.helpBtn

	local function var_4_2()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.sevenday_nianye.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.cookBtn

	local function var_4_5()
		if arg_4_0.isMoving then
			pg = var_0

			local var_6_0 = var_0.TipsMgr.GetInstance()
			local var_6_1 = var_0.ShowTips

			i18n = var_2_10002

			var_6_1(var_6_0, var_2_10002("tip_nianye"))

			return
		end

		if arg_4_0.isEffectPlaying then
			return
		end

		local var_6_2 = arg_4_0.taskProxy
		local var_6_3 = var_0.getTaskVO(var_6_2, arg_4_0.curTaskId)

		if var_0.getTaskStatus(var_6_3) == 1 then
			setActive = var_1

			var_1(arg_4_0.effectNode, true)

			arg_4_0.isEffectPlaying = true

			local var_6_4 = arg_4_0
			local var_6_5 = var_1.managedTween

			LeanTween = var_3

			var_6_5(var_6_4, var_3.delayedCall, function()
				local var_7_0 = arg_4_0
				local var_7_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_7_1(var_7_0, var_3_10002.ON_TASK_SUBMIT, var_0)

				setActive = var_7_1

				var_7_1(arg_4_0.effectNode, false)

				arg_4_0.isEffectPlaying = false

				return
			end, var_0_3, nil)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_3, var_4_4, var_4_5, var_1_10005)

	setActive = var_1

	local var_4_6 = arg_4_0.cookBtn

	var_1(var_2.Find(var_4_6, "shine"), false)

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	var_0_1.super.OnUpdateFlush(arg_8_0)

	getProxy = var_1
	ActivityProxy = var_2

	local var_8_0 = var_1(var_2)

	arg_8_0.cookAct = var_1.getActivityById(var_8_0, arg_8_0.cookActID)
	assert = var_1

	local var_8_2

	if arg_8_0.cookAct then
		local var_8_1 = arg_8_0.cookAct

		var_8_2 = not var_2.isEnd(var_8_1)
	end

	var_1(var_8_2, "自选任务池活动(type86)已结束")
	arg_8_0:RefreshCookData()
	arg_8_0:UpdateCookData()
	arg_8_0:UpdateCookUI()

	return
end

function var_0_1.RefreshCookData(arg_9_0)
	local var_9_0 = arg_9_0.cookAct

	arg_9_0.usedCnt = var_1.getData1(var_9_0)
	pg = var_1

	local var_9_1 = var_1.TimeMgr.GetInstance()
	local var_9_2 = var_1.DiffDay
	local var_9_3 = arg_9_0.cookAct
	local var_9_4 = var_9_2(var_9_1, var_4.getStartTime(var_9_3), var_1:GetServerTime()) + 1
	local var_9_5 = arg_9_0.cookAct

	arg_9_0.unlockCnt = var_9_4 * var_3.getConfig(var_9_5, "config_id")
	math = var_2
	arg_9_0.unlockCnt = var_2.min(arg_9_0.unlockCnt, arg_9_0.totalCookCnt)
	arg_9_0.remainCnt = arg_9_0.usedCnt >= arg_9_0.totalCookCnt and 0 or arg_9_0.unlockCnt - arg_9_0.usedCnt

	return
end

function var_0_1.UpdateCookData(arg_10_0)
	local var_10_0 = 0

	arg_10_0.receivedTasks = {}
	underscore = var_2

	local var_10_1 = var_2.rest(arg_10_0.cookTaskIds, 1)

	ipairs = var_3

	for iter_10_0, iter_10_1 in var_3(arg_10_0.cookTaskIds) do
		local var_10_2 = arg_10_0.taskProxy
		local var_10_3 = var_8.getTaskVO(var_10_2, iter_10_1)

		if var_8.isReceive(var_10_3) then
			table = var_9

			var_9.insert(arg_10_0.receivedTasks, var_8)

			var_10_0 = var_10_0 + 1
			table = var_9

			var_9.removebyvalue(var_10_1, iter_10_1)
		end
	end

	table = var_3

	var_3.sort(arg_10_0.receivedTasks, function(arg_11_0, arg_11_1)
		return arg_11_0.submitTime < arg_11_1.submitTime
	end)

	underscore = var_3
	arg_10_0.receivedTasks = var_3.map(arg_10_0.receivedTasks, function(arg_12_0)
		return arg_12_0.id
	end)

	if arg_10_0.usedCnt ~= var_10_0 then
		arg_10_0.usedCnt = var_10_0

		local var_10_4 = arg_10_0.cookAct

		var_10_4.data1 = arg_10_0.usedCnt
		getProxy = var_4
		ActivityProxy = var_5

		local var_10_5 = var_4(var_5)

		var_4.updateActivity(var_10_5, var_10_4)

		return
	end

	local var_10_6

	if arg_10_0.remainCnt ~= 0 or not arg_10_0.usedCnt then
		var_10_6 = arg_10_0.usedCnt + 1
	end

	if arg_10_0.remainCnt == 0 then
		arg_10_0.curTaskId = arg_10_0.receivedTasks[#arg_10_0.receivedTasks]
	else
		arg_10_0.curTaskId = var_10_1[arg_10_0.randomSeed[var_10_6] % #var_10_1 + 1]
	end

	return
end

function var_0_1.UpdateCookUI(arg_13_0)
	local var_13_0

	if arg_13_0.remainCnt ~= 0 or not arg_13_0.usedCnt then
		var_13_0 = arg_13_0.usedCnt + 1
	end

	setText = var_1_10002

	var_1_10002(arg_13_0.cookProgress, var_13_0 .. "/" .. arg_13_0.totalCookCnt)

	local var_13_1 = arg_13_0.taskProxy
	local var_13_2 = var_2.getTaskVO(var_13_1, arg_13_0.curTaskId)
	local var_13_3 = var_2.getConfig(var_13_2, "award_display")[1]
	local var_13_4 = {
		type = var_13_3[1],
		id = var_13_3[2],
		count = var_13_3[3]
	}

	updateDrop = var_5

	var_5(arg_13_0.cookAwardTF, var_13_4)

	local var_13_5 = var_2
	local var_13_6 = var_2.getTaskStatus(var_13_5) == 2

	setActive = var_13_5

	local var_13_7 = arg_13_0.cookAwardTF

	var_13_5(var_7.Find(var_13_7, "got"), var_13_6)

	setActive = var_13_5

	local var_13_8 = arg_13_0.cookAwardTF

	var_13_5(var_7.Find(var_13_8, "icon_bg/count"), var_13_6)

	setText = var_13_5

	local var_13_9 = arg_13_0.dialogTF
	local var_13_10 = var_7.Find(var_13_9, "Text")

	i18n = var_13_9

	var_13_5(var_13_10, var_13_9(arg_13_0.cookCfg[arg_13_0.curTaskId][3]))

	local var_13_11

	if not var_13_6 or not (arg_13_0.cookCfg[arg_13_0.curTaskId][2] .. "_2") then
		var_13_11 = "unknown"
	end

	GetImageSpriteFromAtlasAsync = var_13_10

	var_13_10("ui/activityuipage/NewYearsEveDinnerPage_atlas", arg_13_0.cookCfg[arg_13_0.curTaskId][2], arg_13_0.foodTF, true)

	GetImageSpriteFromAtlasAsync = var_13_10

	var_13_10("ui/activityuipage/NewYearsEveDinnerPage_atlas", var_13_11, arg_13_0.titleFoodTF, true)

	arg_13_0.prefabName = arg_13_0.cookCfg[arg_13_0.curTaskId][1]
	pg = var_7

	local var_13_12 = var_7.UIMgr.GetInstance()

	var_7.LoadingOn(var_13_12)

	PoolMgr = var_7

	local var_13_13 = var_7.GetInstance()

	var_7.GetSpineChar(var_13_13, arg_13_0.prefabName, true, function(arg_14_0)
		pg = var_2_10001

		local var_14_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_14_0)

		local var_14_1 = arg_13_0

		tf = var_14_0
		var_14_1.modelTf = var_14_0(arg_14_0)

		local var_14_2 = arg_13_0.modelTf

		Vector3 = var_2
		var_14_2.localPosition = var_2(0, 0, 0)

		local var_14_3 = arg_13_0.modelTf

		Vector3 = var_2
		var_14_3.localScale = var_2(1, 1, 1)

		local var_14_4 = arg_13_0

		var_1.ClearRole(var_14_4)

		setParent = var_1

		var_1(arg_13_0.modelTf, arg_13_0.roleTF)

		local var_14_5 = arg_13_0

		var_1.PlayRoleAnim(var_14_5)

		return
	end)

	return
end

function var_0_1.ClearRole(arg_15_0)
	arg_15_0.isMoving = false
	LeanTween = var_1

	if var_1.isTweening(arg_15_0.roleTF) then
		LeanTween = var_1

		var_1.cancel(arg_15_0.roleTF)
	end

	removeAllChildren = var_1

	var_1(arg_15_0.roleTF)

	return
end

function var_0_1.PlayRoleAnim(arg_16_0)
	local var_16_0 = arg_16_0.taskProxy
	local var_16_1 = var_1.getTaskVO(var_16_0, arg_16_0.curTaskId)
	local var_16_2 = var_1.getTaskStatus(var_16_1) == 2
	local var_16_3 = arg_16_0.modelTf
	local var_16_4 = var_3.GetComponent(var_16_3, "SpineAnimUI")

	setActive = var_16_3

	var_16_3(arg_16_0.foodTF, false)

	setActive = var_16_3

	var_16_3(arg_16_0.dialogTF, false)

	setActive = var_16_3

	local var_16_5 = arg_16_0.cookBtn

	var_16_3(var_5.Find(var_16_5, "shine"), false)

	if var_16_2 then
		setAnchoredPosition = var_16_3

		var_16_3(arg_16_0.roleTF, var_0_5)
		var_16_4:SetAction("normal", 0)

		setActive = var_4

		var_4(arg_16_0.foodTF, true)

		setActive = var_4

		var_4(arg_16_0.dialogTF, true)

		setActive = var_4

		local var_16_6 = arg_16_0.cookBtn

		var_4(var_5.Find(var_16_6, "shine"), not var_16_2 and arg_16_0.remainCnt > 0)
	else
		var_16_4:SetAction("move", 0)

		arg_16_0.isMoving = true
		setAnchoredPosition = var_4

		var_4(arg_16_0.roleTF, var_0_4)

		local var_16_7 = arg_16_0
		local var_16_8 = arg_16_0.managedTween

		LeanTween = var_6

		local var_16_9 = var_16_8(var_16_7, var_6.moveX, function()
			local var_17_0 = var_16_4

			var_0.SetAction(var_17_0, "normal", 0)

			local var_17_1 = arg_16_0

			var_17_1.isMoving = false
			setActive = var_17_1

			var_17_1(arg_16_0.foodTF, var_16_2)

			setActive = var_17_1

			var_17_1(arg_16_0.dialogTF, var_16_2)

			setActive = var_17_1

			local var_17_2 = arg_16_0.cookBtn

			var_17_1(var_1.Find(var_17_2, "shine"), not var_16_2 and arg_16_0.remainCnt > 0)

			return
		end, arg_16_0.roleTF, var_0_5.x, var_0_2)
		local var_16_10 = var_4.setEase

		LeanTweenType = var_6

		var_16_10(var_16_9, var_6.linear)
	end

	return
end

function var_0_1.OnDestroy(arg_18_0)
	if arg_18_0.prefabName and arg_18_0.modelTf then
		PoolMgr = var_1

		local var_18_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_18_0, arg_18_0.prefabName, arg_18_0.modelTf.gameObject)

		arg_18_0.prefabName = nil
		arg_18_0.modelTf = nil
	end

	arg_18_0:cleanManagedTween()

	return
end

return var_0_1
