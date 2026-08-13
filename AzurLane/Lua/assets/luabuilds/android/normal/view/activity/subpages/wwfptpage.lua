class = var_0_10000

local var_0_0 = "WWFPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))
local var_0_2 = 6000

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_0, "help_btn")

	local var_1_1 = arg_1_0.bg

	arg_1_0.collectBtn = var_1.Find(var_1_1, "collect_btn")

	local var_1_2 = arg_1_0.collectBtn

	arg_1_0.taskRedDot = var_1.Find(var_1_2, "red_dot")

	local var_1_3 = arg_1_0.collectBtn

	arg_1_0.resNumTF = var_1.Find(var_1_3, "res_num")

	local var_1_4 = arg_1_0.bg

	arg_1_0.title = var_1.Find(var_1_4, "title")

	local var_1_5 = arg_1_0.bg

	arg_1_0.tags = var_1.Find(var_1_5, "tags")

	local var_1_6 = arg_1_0.bg

	arg_1_0.convertBtn = var_1.Find(var_1_6, "convert_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.switchBtn = var_1.Find(var_1_7, "switch_btn")

	local var_1_8 = arg_1_0.switchBtn

	arg_1_0.switchRedDot = var_1.Find(var_1_8, "red_dot")

	local var_1_9 = {}
	local var_1_10 = arg_1_0.bg

	var_1_9[1] = var_2.Find(var_1_10, "paintings/ninghai")

	local var_1_11 = arg_1_0.bg

	var_1_9[2] = var_2.Find(var_1_11, "paintings/pinghai")
	arg_1_0.paintings = var_1_9

	local var_1_12 = arg_1_0.bg

	arg_1_0.anim = var_1.Find(var_1_12, "anim")

	local var_1_13 = arg_1_0.bg

	arg_1_0.ninghaiTF = var_1.Find(var_1_13, "anim/panda_anim/ninghai")

	local var_1_14 = arg_1_0.bg

	arg_1_0.pinghaiTF = var_1.Find(var_1_14, "anim/panda_anim/pinghai")

	local var_1_15 = arg_1_0.bg

	arg_1_0.heartImages = var_1.Find(var_1_15, "hearts")

	local var_1_16 = arg_1_0.bg

	arg_1_0.step2 = var_1.Find(var_1_16, "step2")

	local var_1_17 = arg_1_0._tf

	arg_1_0.taskWindow = var_1.Find(var_1_17, "TaskWindow")

	local var_1_18 = arg_1_0.taskWindow

	arg_1_0.closeBtn = var_1.Find(var_1_18, "panel/close_btn")

	local var_1_19 = arg_1_0.taskWindow

	arg_1_0.maskBtn = var_1.Find(var_1_19, "mask")

	local var_1_20 = arg_1_0.taskWindow

	arg_1_0.item = var_1.Find(var_1_20, "panel/scrollview/item")

	local var_1_21 = arg_1_0.taskWindow

	arg_1_0.items = var_1.Find(var_1_21, "panel/scrollview/items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_22 = arg_1_0.taskWindow

	arg_1_0.typeImages = var_1.Find(var_1_22, "panel/tags")

	local var_1_23 = arg_1_0.taskWindow

	arg_1_0.barImages = var_1.Find(var_1_23, "panel/bars")

	local var_1_24 = arg_1_0._tf

	arg_1_0.guide = var_1.Find(var_1_24, "Guide")

	local var_1_25 = arg_1_0.guide

	arg_1_0.guideTarget = var_1.Find(var_1_25, "target")

	local var_1_26 = arg_1_0.guide

	arg_1_0.guideContent = var_1.Find(var_1_26, "dialogBox/content")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = {}

	i18n = var_1_10002
	var_2_0[1] = var_1_10002("wwf_bamboo_tip1")
	i18n = var_2
	var_2_0[2] = var_2("wwf_bamboo_tip2")
	arg_2_0.titleTxts = var_2_0

	local var_2_1 = arg_2_0.activity

	arg_2_0.resID = var_1.getConfig(var_2_1, "config_client").convertRes

	local var_2_2 = arg_2_0.activity

	arg_2_0.subActivities = var_1.getConfig(var_2_2, "config_client").ptActID

	local var_2_3 = arg_2_0.activity

	arg_2_0.taskList = var_1.getConfig(var_2_3, "config_data")

	arg_2_0:initPtData()
	arg_2_0:initTaskData()
	arg_2_0:initLocalData()

	return
end

function var_0_1.initPtData(arg_3_0)
	arg_3_0.subPtDate = {}
	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.subActivities) do
		getProxy = var_1_10006
		ActivityProxy = var_1_10007
		var_1_10007 = var_1_10006(var_1_10007)
		var_1_10006 = var_1_10006.getActivityById(var_1_10007, iter_3_1)

		local var_3_0

		if arg_3_0.subPtDate[iter_3_1] then
			var_3_0 = arg_3_0.subPtDate[iter_3_1]

			var_1_10007.Update(var_3_0, var_1_10006)
		else
			var_1_10007 = arg_3_0.subPtDate
			ActivityPtData = var_3_0
			var_1_10007[iter_3_1] = var_3_0.New(var_1_10006)
		end
	end

	getProxy = var_1
	PlayerProxy = var_2

	local var_3_1 = var_1(var_2)
	local var_3_2 = var_1.getRawData(var_3_1)

	arg_3_0.resNum = var_1.getResource(var_3_2, arg_3_0.resID)

	return
end

function var_0_1.setPtActIndex(arg_4_0)
	arg_4_0.curActIndex = arg_4_0.lastSelectIndex
	arg_4_0.curSubActID = arg_4_0.subActivities[arg_4_0.curActIndex]

	local var_4_0 = arg_4_0.curActIndex == 1 and 2 or 1
	local var_4_1 = arg_4_0.subPtDate[arg_4_0.curSubActID]
	local var_4_2 = var_2.CanGetMorePt(var_4_1)
	local var_4_3 = arg_4_0.subPtDate[arg_4_0.subActivities[var_4_0]]
	local var_4_4 = var_3.CanGetAward(var_4_3)

	if not var_4_2 or var_4_4 then
		arg_4_0.curActIndex = var_4_0
		arg_4_0.curSubActID = arg_4_0.subActivities[arg_4_0.curActIndex]
		PlayerPrefs = var_4

		var_4.SetInt("wwf_select_index_" .. arg_4_0.playerId, arg_4_0.lastSelectIndex)

		PlayerPrefs = var_4

		var_4.Save()
	end

	return
end

function var_0_1.setStep2Progress(arg_5_0)
	local var_5_0 = arg_5_0.subPtDate[arg_5_0.curSubActID].count

	setImageSprite = var_2

	local var_5_1 = arg_5_0.step2
	local var_5_2 = arg_5_0.heartImages
	local var_5_3 = var_4.Find

	tostring = var_1_10006

	local var_5_4 = var_5_3(var_5_2, var_1_10006(arg_5_0.curActIndex))
	local var_5_5 = var_4.GetComponent

	typeof = var_6
	Image = var_7

	var_2(var_5_1, var_5_5(var_5_4, var_6(var_7)).sprite)

	local var_5_6 = arg_5_0.step2
	local var_5_7 = var_2.GetComponent

	typeof = var_4
	Image = var_5_4
	var_5_7(var_5_6, var_4(var_5_4)).fillAmount = var_5_0 / var_0_2

	return
end

function var_0_1.initTaskData(arg_6_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002
	arg_6_0.taskProxy = var_1_10001(var_1_10002)
	arg_6_0.curTask = {}
	arg_6_0.todoTaskNum = 0
	ipairs = var_1

	for iter_6_0, iter_6_1 in var_1(arg_6_0.taskList) do
		local var_6_0 = arg_6_0.taskProxy
		local var_6_1

		if not var_6.getTaskById(var_6_0, iter_6_1) then
			var_6_0 = arg_6_0.taskProxy
			var_6_1 = var_6.getFinishTaskById(var_6_0, iter_6_1)
		end

		if var_6_1 then
			table = var_6_0

			var_6_0.insert(arg_6_0.curTask, var_6_1.id)

			if var_6_1:getTaskStatus() == 0 then
				arg_6_0.todoTaskNum = arg_6_0.todoTaskNum + 1
			end
		end
	end

	return
end

function var_0_1.initLocalData(arg_7_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)

	arg_7_0.playerId = var_1.getData(var_7_0).id
	PlayerPrefs = var_1
	arg_7_0.isFirst = var_1.GetInt("wwf_first_" .. arg_7_0.playerId)
	PlayerPrefs = var_1

	if var_1.GetInt("wwf_select_index_" .. arg_7_0.playerId) == 0 then
		arg_7_0.lastSelectIndex = 1
	else
		PlayerPrefs = var_1
		arg_7_0.lastSelectIndex = var_1.GetInt("wwf_select_index_" .. arg_7_0.playerId)
	end

	arg_7_0.showTaskRedDot = false
	PlayerPrefs = var_1

	if (var_1.GetInt("wwf_todo_task_num_" .. arg_7_0.playerId) == 0 and not arg_7_0.todoTaskNum == 0 or var_1 < arg_7_0.todoTaskNum) and not arg_7_0:isFinishAllAct() then
		arg_7_0.showTaskRedDot = true
	end

	arg_7_0.hasClickTask = false
	PlayerPrefs = var_2

	var_2.SetInt("wwf_todo_task_num_" .. arg_7_0.playerId, arg_7_0.todoTaskNum)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.OnFirstFlush(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.awardTF

	local function var_8_2()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_9_2 = var_2_10002.SHOW_AWARD_WINDOW

		PtAwardWindow = var_2_10003

		var_9_1(var_9_0, var_9_2, var_2_10003, {
			type = arg_8_0.subPtDate[arg_8_0.curSubActID].type,
			dropList = arg_8_0.subPtDate[arg_8_0.curSubActID].dropList,
			targets = arg_8_0.subPtDate[arg_8_0.curSubActID].targets,
			level = arg_8_0.subPtDate[arg_8_0.curSubActID].level,
			count = arg_8_0.subPtDate[arg_8_0.curSubActID].count,
			resId = arg_8_0.subPtDate[arg_8_0.curSubActID].resId
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.getBtn

	local function var_8_5()
		local var_10_0 = {}
		local var_10_1 = arg_8_0.subPtDate[arg_8_0.curSubActID]
		local var_10_2 = var_1.GetAward(var_10_1)

		getProxy = var_10_1
		PlayerProxy = var_2_10003

		local var_10_3 = var_10_1(var_2_10003)
		local var_10_4 = var_2.getData(var_10_3)
		local var_10_5 = var_10_2.type

		DROP_TYPE_RESOURCE = var_2_10005

		if var_10_5 == var_2_10005 then
			local var_10_6 = var_10_2.id

			PlayerConst = var_2_10005

			if var_10_6 == var_2_10005.ResGold then
				var_2_10005 = var_10_4

				if var_10_4.GoldMax(var_2_10005, var_10_2.count) then
					table = var_4

					var_4.insert(var_10_0, function(arg_11_0)
						pg = var_3_10001

						local var_11_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_11_1 = var_1.ShowMsgBox
						local var_11_2 = {}

						i18n = var_3_10004

						local var_11_3 = var_3_10004("gold_max_tip_title")

						i18n = var_5
						var_11_2.content = var_11_3 .. var_5("award_max_warning")
						var_11_2.onYes = arg_11_0

						var_11_1(var_11_0, var_11_2)

						return
					end)
				end
			end
		end

		local function var_10_7()
			local var_12_0 = arg_8_0.subPtDate[arg_8_0.curSubActID]

			if not var_0.CanGetNextAward(var_12_0) then
				triggerButton = var_0

				var_0(arg_8_0.switchBtn)
			end

			return
		end

		seriesAsync = var_2_10005

		var_2_10005(var_10_0, function()
			local var_13_0 = arg_8_0.subPtDate[arg_8_0.curSubActID]
			local var_13_1, var_13_2 = var_0.GetResProgress(var_13_0)
			local var_13_3 = arg_8_0
			local var_13_4 = var_2.emit

			ActivityMediator = var_3_10004

			local var_13_5 = var_3_10004.EVENT_PT_OPERATION
			local var_13_6 = {
				cmd = 1
			}
			local var_13_7 = arg_8_0.subPtDate[arg_8_0.curSubActID]

			var_13_6.activity_id = var_6.GetId(var_13_7)
			var_13_6.arg1 = var_13_2
			var_13_6.callback = var_10_7

			var_13_4(var_13_3, var_13_5, var_13_6)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.helpBtn

	local function var_8_8()
		pg = var_2_10000

		local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_14_2.type = var_2_10003
		i18n = var_2_10003
		var_14_2.helps = var_2_10003("wwf_bamboo_help")

		var_14_1(var_14_0, var_14_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10005)

	onButton = var_1_10001

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.convertBtn

	local function var_8_11()
		if arg_8_0.resNum <= 0 then
			pg = var_0

			local var_15_0 = var_0.TipsMgr.GetInstance()
			local var_15_1 = var_0.ShowTips

			i18n = var_2_10002

			var_15_1(var_15_0, var_2_10002("wwf_bamboo_tip3"))

			local var_15_2 = arg_8_0

			var_0.openTask(var_15_2)
		else
			local var_15_3 = arg_8_0
			local var_15_4 = var_0.emit

			ActivityMediator = var_2_10002

			var_15_4(var_15_3, var_2_10002.EVENT_PT_OPERATION, {
				cmd = 5,
				activity_id = arg_8_0.curSubActID,
				arg1 = arg_8_0.resID
			})

			local var_15_5 = arg_8_0

			var_0.playSpineAni(var_15_5)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_9, var_8_10, var_8_11, var_1_10005)

	onButton = var_1_10001

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.switchBtn

	local function var_8_14()
		if arg_8_0.isSwitching then
			return
		end

		arg_8_0.curActIndex = arg_8_0.curActIndex == 1 and 2 or 1

		local var_16_0 = arg_8_0

		var_16_0.lastSelectIndex = arg_8_0.curActIndex
		PlayerPrefs = var_16_0

		var_16_0.SetInt("wwf_select_index_" .. arg_8_0.playerId, arg_8_0.lastSelectIndex)

		PlayerPrefs = var_0

		var_0.Save()

		arg_8_0.curSubActID = arg_8_0.subActivities[arg_8_0.curActIndex]

		local var_16_1 = arg_8_0

		var_0.OnUpdatePtAct(var_16_1)

		local var_16_2 = arg_8_0

		var_0.playPaintingAni(var_16_2)

		local var_16_3 = arg_8_0

		var_0.setStep2Progress(var_16_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_12, var_8_13, var_8_14, var_1_10005)

	onButton = var_1_10001

	local var_8_15 = arg_8_0
	local var_8_16 = arg_8_0.collectBtn

	local function var_8_17()
		local var_17_0 = arg_8_0

		var_0.openTask(var_17_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_15, var_8_16, var_8_17, var_1_10005)

	onButton = var_1_10001

	local var_8_18 = arg_8_0
	local var_8_19 = arg_8_0.closeBtn

	local function var_8_20()
		local var_18_0 = arg_8_0

		var_0.closeTask(var_18_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_18, var_8_19, var_8_20, var_1_10005)

	onButton = var_1_10001

	local var_8_21 = arg_8_0
	local var_8_22 = arg_8_0.maskBtn

	local function var_8_23()
		local var_19_0 = arg_8_0

		var_0.closeTask(var_19_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_21, var_8_22, var_8_23, var_1_10005)

	onButton = var_1_10001

	local var_8_24 = arg_8_0
	local var_8_25 = arg_8_0.guideTarget

	local function var_8_26()
		setActive = var_2_10000

		var_2_10000(arg_8_0.guide, false)

		local var_20_0 = arg_8_0

		var_0.openTask(var_20_0)

		PlayerPrefs = var_0

		var_0.SetInt("wwf_first_" .. arg_8_0.playerId, 1)

		PlayerPrefs = var_0

		var_0.Save()

		if #arg_8_0.finishItemList > 0 then
			local var_20_1 = arg_8_0

			var_0.autoFinishTask(var_20_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_24, var_8_25, var_8_26, var_1_10005)

	local var_8_27 = "ninghai_7"
	local var_8_28 = "pinghai_7"

	if not arg_8_0.model1 then
		pg = var_3

		local var_8_29 = var_3.UIMgr.GetInstance()

		var_3.LoadingOn(var_8_29)

		PoolMgr = var_3

		local var_8_30 = var_3.GetInstance()

		var_3.GetSpineChar(var_8_30, var_8_27, true, function(arg_21_0)
			pg = var_2_10001

			local var_21_0 = var_2_10001.UIMgr.GetInstance()

			var_1.LoadingOff(var_21_0)

			arg_8_0.prefab1 = var_8_27

			local var_21_1 = arg_8_0

			var_21_1.model1 = arg_21_0
			tf = var_21_1

			local var_21_2 = var_21_1(arg_21_0)

			Vector3 = var_2
			var_21_2.localScale = var_2(1, 1, 1)
			setParent = var_21_2

			var_21_2(arg_21_0, arg_8_0.ninghaiTF)

			setActive = var_21_2

			var_21_2(arg_21_0, false)

			return
		end)
	end

	if not arg_8_0.model2 then
		pg = var_3

		local var_8_31 = var_3.UIMgr.GetInstance()

		var_3.LoadingOn(var_8_31)

		PoolMgr = var_3

		local var_8_32 = var_3.GetInstance()

		var_3.GetSpineChar(var_8_32, var_8_28, true, function(arg_22_0)
			pg = var_2_10001

			local var_22_0 = var_2_10001.UIMgr.GetInstance()

			var_1.LoadingOff(var_22_0)

			arg_8_0.prefab2 = var_8_28

			local var_22_1 = arg_8_0

			var_22_1.model2 = arg_22_0
			tf = var_22_1

			local var_22_2 = var_22_1(arg_22_0)

			Vector3 = var_2
			var_22_2.localScale = var_2(1, 1, 1)
			setParent = var_22_2

			var_22_2(arg_22_0, arg_8_0.pinghaiTF)

			setActive = var_22_2

			var_22_2(arg_22_0, false)

			return
		end)
	end

	arg_8_0:setPtActIndex()
	arg_8_0:setStep2Progress()
	arg_8_0:initTaskWindow()

	if arg_8_0.isFirst == 0 then
		setActive = var_3

		var_3(arg_8_0.guide, true)

		setText = var_3

		local var_8_33 = arg_8_0.guideContent

		i18n = var_5

		var_3(var_8_33, var_5("wwf_guide_tip"))
	elseif #arg_8_0.finishItemList > 0 then
		arg_8_0:openTask()
		arg_8_0:autoFinishTask()
	end

	return
end

function var_0_1.OnUpdateFlush(arg_23_0)
	ipairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001(arg_23_0.subActivities) do
		getProxy = var_1_10006
		ActivityProxy = var_1_10007
		var_1_10007 = var_1_10006(var_1_10007)
		var_1_10006 = var_1_10006.getActivityById(var_1_10007, iter_23_1)

		local var_23_0

		if arg_23_0.subPtDate[iter_23_1] then
			var_23_0 = arg_23_0.subPtDate[iter_23_1]

			var_1_10007.Update(var_23_0, var_1_10006)
		else
			var_1_10007 = arg_23_0.subPtDate
			ActivityPtData = var_23_0
			var_1_10007[iter_23_1] = var_23_0.New(var_1_10006)
		end
	end

	getProxy = var_1
	PlayerProxy = var_2

	local var_23_1 = var_1(var_2)
	local var_23_2 = var_1.getRawData(var_23_1)

	arg_23_0.resNum = var_1.getResource(var_23_2, arg_23_0.resID)
	setText = var_2

	var_2(arg_23_0.resNumTF, arg_23_0.resNum)

	local var_23_3 = arg_23_0

	arg_23_0.OnUpdatePtAct(var_23_3)

	local var_23_4 = arg_23_0.curActIndex == 1 and 2 or 1

	GetOrAddComponent = var_23_3

	local var_23_5 = arg_23_0.paintings[arg_23_0.curActIndex]

	typeof = var_5
	CanvasGroup = var_1_10006

	local var_23_6 = var_23_3(var_23_5, var_5(var_1_10006))

	var_23_6.alpha = 1
	GetOrAddComponent = var_23_6

	local var_23_7 = arg_23_0.paintings[var_23_4]

	typeof = var_5
	CanvasGroup = var_1_10006
	var_23_6(var_23_7, var_5(var_1_10006)).alpha = 0

	return
end

function var_0_1.OnUpdatePtAct(arg_24_0)
	setText = var_1_10001

	var_1_10001(arg_24_0.title, arg_24_0.titleTxts[arg_24_0.curActIndex])

	eachChild = var_1_10001

	var_1_10001(arg_24_0.tags, function(arg_25_0)
		setActive = var_2_10001

		local var_25_0 = arg_25_0

		tonumber = var_2_10003

		var_2_10001(var_25_0, var_2_10003(arg_25_0.name) == arg_24_0.curActIndex)

		return
	end)

	local var_24_0 = arg_24_0.subPtDate[arg_24_0.curSubActID]
	local var_24_1, var_24_2, var_24_3 = var_1.GetLevelProgress(var_24_0)
	local var_24_4 = arg_24_0.subPtDate[arg_24_0.curSubActID]
	local var_24_5, var_24_6, var_24_7 = var_4.GetResProgress(var_24_4)

	eachChild = var_1_10007

	var_1_10007(arg_24_0.step, function(arg_26_0)
		setActive = var_2_10001

		local var_26_0 = arg_26_0

		tonumber = var_2_10003

		var_2_10001(var_26_0, var_2_10003(arg_26_0.name) < var_24_1 and true or false)

		return
	end)

	setText = var_1_10007

	local var_24_8 = arg_24_0.progress

	if 1 <= var_24_7 then
		setColorStr = var_9

		local var_24_9

		if not var_9(var_24_5, "#94D979") then
			var_24_9 = var_24_5
		end

		var_1_10007(var_24_8, var_24_9 .. "/" .. var_24_6)

		local var_24_10 = arg_24_0.subPtDate[arg_24_0.curSubActID]
		local var_24_11 = var_7.GetAward(var_24_10)

		updateDrop = var_24_10

		var_24_10(arg_24_0.awardTF, var_24_11)

		local var_24_12 = arg_24_0.subPtDate[arg_24_0.curSubActID]
		local var_24_13 = var_8.CanGetAward(var_24_12)
		local var_24_14 = arg_24_0.subPtDate[arg_24_0.curSubActID]
		local var_24_15 = var_9.CanGetNextAward(var_24_14)
		local var_24_16 = arg_24_0.subPtDate[arg_24_0.curSubActID]
		local var_24_17 = var_10.CanGetMorePt(var_24_16)

		setActive = var_24_16

		var_24_16(arg_24_0.convertBtn, not var_24_13)

		setActive = var_24_16

		var_24_16(arg_24_0.getBtn, var_24_13)

		setActive = var_24_16

		var_24_16(arg_24_0.gotBtn, not var_24_15)

		setActive = var_24_16

		local var_24_18 = arg_24_0.step

		var_24_16(var_12.Find(var_24_18, "10"), not var_24_15)

		setActive = var_24_16

		var_24_16(arg_24_0.switchRedDot, not var_24_15 and not arg_24_0:isFinishAllAct())

		setActive = var_24_16

		local var_24_19 = arg_24_0.taskRedDot
		local var_24_20

		if arg_24_0.showTaskRedDot then
			var_24_20 = not arg_24_0.hasClickTask
		end

		var_24_16(var_24_19, var_24_20)

		return
	end
end

function var_0_1.playPaintingAni(arg_27_0)
	arg_27_0.isSwitching = true

	local var_27_0 = arg_27_0.curActIndex
	local var_27_1 = arg_27_0.curActIndex == 1 and 2 or 1
	local var_27_2 = arg_27_0.paintings[var_27_0]
	local var_27_3 = arg_27_0.paintings[var_27_1]

	GetOrAddComponent = var_1_10005

	local var_27_4 = var_27_2

	typeof = var_1_10007
	CanvasGroup = var_1_10008

	local var_27_5 = var_1_10005(var_27_4, var_1_10007(var_1_10008))

	GetOrAddComponent = var_27_4

	local var_27_6 = var_27_3

	typeof = var_1_10008
	CanvasGroup = var_1_10009

	local var_27_7 = var_27_4(var_27_6, var_1_10008(var_1_10009))

	LeanTween = var_27_6

	local var_27_8 = var_27_6.value

	go = var_8

	local var_27_9 = var_27_8(var_8(var_27_3), 1, 0, 0.4)
	local var_27_10 = var_7.setOnUpdate

	System = var_9

	local var_27_11 = var_27_10(var_27_9, var_9.Action_float(function(arg_28_0)
		var_27_7.alpha = arg_28_0

		return
	end))
	local var_27_12 = var_7.setOnComplete

	System = var_9

	var_27_12(var_27_11, var_9.Action(function()
		LeanTween = var_2_10000

		local var_29_0 = var_2_10000.value

		go = var_2_10001

		local var_29_1 = var_29_0(var_2_10001(var_27_2), 0, 1, 0.4)
		local var_29_2 = var_0.setOnUpdate

		System = var_2

		local var_29_3 = var_29_2(var_29_1, var_2.Action_float(function(arg_30_0)
			var_27_5.alpha = arg_30_0

			return
		end))
		local var_29_4 = var_0.setOnComplete

		System = var_2

		var_29_4(var_29_3, var_2.Action(function()
			arg_27_0.isSwitching = false

			return
		end))

		return
	end))

	return
end

function var_0_1.playSpineAni(arg_32_0)
	setActive = var_1_10001

	var_1_10001(arg_32_0.anim, true)

	local var_32_0 = 0.4
	local var_32_1 = arg_32_0.anim
	local var_32_2 = var_2.Find(var_32_1, "panda_anim")
	local var_32_3 = arg_32_0.anim
	local var_32_4 = var_3.Find(var_32_3, "heart_anim")

	GetOrAddComponent = var_32_3

	local var_32_5 = var_32_2

	typeof = var_1_10006
	CanvasGroup = var_1_10007

	local var_32_6 = var_32_3(var_32_5, var_1_10006(var_1_10007))

	setActive = var_32_5

	var_32_5(var_32_2, true)

	var_32_6.alpha = 1
	LeanTween = var_5

	local var_32_7 = var_5.value

	go = var_6

	local var_32_8 = var_32_7(var_6(var_32_2), 0, 1, var_32_0)
	local var_32_9 = var_5.setOnUpdate

	System = var_7

	var_32_9(var_32_8, var_7.Action_float(function(arg_33_0)
		var_32_6.alpha = arg_33_0

		return
	end))

	local function var_32_10()
		LeanTween = var_2_10000

		local var_34_0 = var_2_10000.value

		go = var_2_10001

		local var_34_1 = var_34_0(var_2_10001(var_32_2), 1, 0, var_32_0)
		local var_34_2 = var_0.setOnUpdate

		System = var_2

		var_34_2(var_34_1, var_2.Action_float(function(arg_35_0)
			var_32_6.alpha = arg_35_0

			return
		end))

		LeanTween = var_34_2

		local var_34_3 = var_34_2.scale
		local var_34_4 = var_32_2

		Vector3 = var_2

		local var_34_5 = var_34_3(var_34_4, var_2(1, 0, 1), var_32_0)
		local var_34_6 = var_0.setFrom

		Vector3 = var_2

		local var_34_7 = var_34_6(var_34_5, var_2(1, 1, 1))
		local var_34_8 = var_0.setOnComplete

		System = var_2

		var_34_8(var_34_7, var_2.Action(function()
			setActive = var_3_10000

			var_3_10000(var_32_2, false)

			return
		end))

		setActive = var_34_8

		var_34_8(var_32_4, true)

		LeanTween = var_34_8

		local var_34_9 = var_34_8.delayedCall
		local var_34_10 = 2

		System = var_2

		var_34_9(var_34_10, var_2.Action(function()
			setActive = var_3_10000

			var_3_10000(var_32_4, false)

			local var_37_0 = arg_32_0.step2
			local var_37_1 = var_0.GetComponent

			typeof = var_2
			Image = var_3_10003

			local var_37_2 = var_37_1(var_37_0, var_2(var_3_10003)).fillAmount
			local var_37_3 = arg_32_0.subPtDate[arg_32_0.curSubActID].count

			LeanTween = var_2

			local var_37_4 = var_2.value

			go = var_3_10003

			local var_37_5 = var_37_4(var_3_10003(arg_32_0.step2), var_37_2, var_37_3 / var_0_2, 1)
			local var_37_6 = var_2.setOnUpdate

			System = var_4

			local var_37_7 = var_37_6(var_37_5, var_4.Action_float(function(arg_38_0)
				local var_38_0 = arg_32_0.step2
				local var_38_1 = var_1.GetComponent

				typeof = var_4_10003
				Image = var_4_10004
				var_38_1(var_38_0, var_4_10003(var_4_10004)).fillAmount = arg_38_0

				return
			end))
			local var_37_8 = var_2.setOnComplete

			System = var_4

			var_37_8(var_37_7, var_4.Action(function()
				setActive = var_4_10000

				var_4_10000(arg_32_0.anim, false)

				arg_32_0.heartAni = false

				return
			end))

			return
		end))

		return
	end

	local var_32_11

	if arg_32_0.curActIndex ~= 1 or not arg_32_0.model1 then
		var_32_11 = arg_32_0.model2
	end

	LeanTween = var_7

	local var_32_12 = var_7.scale
	local var_32_13 = var_32_2

	Vector3 = var_9

	local var_32_14 = var_32_12(var_32_13, var_9(1, 1, 1), var_32_0)
	local var_32_15 = var_7.setFrom

	Vector3 = var_9

	local var_32_16 = var_32_15(var_32_14, var_9(1, 0, 1))
	local var_32_17 = var_7.setOnComplete

	System = var_9

	var_32_17(var_32_16, var_9.Action(function()
		setActive = var_2_10000

		var_2_10000(var_32_11, true)

		local var_40_0 = var_32_11
		local var_40_1 = var_0.GetComponent(var_40_0, "SpineAnimUI")

		var_0.SetActionCallBack(var_40_1, function(arg_41_0)
			if arg_41_0 == "finish" then
				local var_41_0 = var_32_11
				local var_41_1 = var_1.GetComponent(var_41_0, "SpineAnimUI")

				var_1.SetActionCallBack(var_41_1, nil)

				setActive = var_1

				var_1(var_32_11, false)
				var_32_10()
			end

			return
		end)

		local var_40_2 = var_32_11
		local var_40_3 = var_0.GetComponent(var_40_2, "SpineAnimUI")

		var_0.SetAction(var_40_3, "event", 0)

		return
	end))

	arg_32_0.heartAni = false
	onButton = var_7

	local var_32_18 = arg_32_0
	local var_32_19 = arg_32_0.anim

	local function var_32_20()
		if arg_32_0.heartAni then
			return
		end

		local var_42_0 = var_32_11
		local var_42_1 = var_0.GetComponent(var_42_0, "SpineAnimUI")

		var_0.SetActionCallBack(var_42_1, nil)

		setActive = var_0

		var_0(var_32_11, false)

		arg_32_0.heartAni = true

		var_32_10()

		return
	end

	SFX_PANEL = var_11

	var_7(var_32_18, var_32_19, var_32_20, var_11)

	return
end

function var_0_1.initTaskWindow(arg_43_0)
	arg_43_0.finishItemList = {}
	arg_43_0.finishTaskVOList = {}

	local var_43_0 = arg_43_0.uilist

	var_1.make(var_43_0, function(arg_44_0, arg_44_1, arg_44_2)
		UIItemList = var_2_10003

		if arg_44_0 == var_2_10003.EventUpdate then
			local var_44_0 = arg_44_1 + 1
			local var_44_1 = arg_44_2:Find("item")
			local var_44_2 = arg_43_0.curTask[var_44_0]
			local var_44_3 = arg_43_0.taskProxy
			local var_44_4

			if not var_6.getTaskById(var_44_3, var_44_2) then
				var_44_3 = arg_43_0.taskProxy
				var_44_4 = var_6.getFinishTaskById(var_44_3, var_44_2)
			end

			assert = var_44_3

			var_44_3(var_44_4, "without this task by id: " .. var_44_2)

			local var_44_5 = var_44_4:getConfig("award_display")[1]
			local var_44_6 = {
				type = var_44_5[1],
				id = var_44_5[2],
				count = var_44_5[3]
			}

			updateDrop = var_9

			var_9(var_44_1, var_44_6)

			onButton = var_9

			local var_44_7 = arg_43_0
			local var_44_8 = var_44_1

			local function var_44_9()
				local var_45_0 = arg_43_0
				local var_45_1 = var_0.emit

				BaseUI = var_3_10002

				var_45_1(var_45_0, var_3_10002.ON_DROP, var_44_6)

				return
			end

			SFX_PANEL = var_2_10013

			var_9(var_44_7, var_44_8, var_44_9, var_2_10013)

			local var_44_10 = var_44_4:getProgress()
			local var_44_11 = var_44_4
			local var_44_12 = var_44_4.getConfig(var_44_11, "target_num")

			setText = var_44_11

			var_44_11(arg_44_2:Find("description"), var_44_4:getConfig("desc"))

			setText = var_44_11

			var_44_11(arg_44_2:Find("progressText"), var_44_10 .. "/" .. var_44_12)

			setSlider = var_44_11

			var_44_11(arg_44_2:Find("progress"), 0, var_44_12, var_44_10)

			local var_44_13 = arg_44_2:Find("go_btn")
			local var_44_14 = var_44_4

			if var_44_4.getTaskStatus(var_44_14) == 1 then
				table = var_44_14

				var_44_14.insert(arg_43_0.finishItemList, arg_44_2)

				table = var_44_14

				var_44_14.insert(arg_43_0.finishTaskVOList, var_44_4)
			end

			setActive = var_44_14

			var_44_14(arg_44_2:Find("finnal"), var_12 == 2)

			onButton = var_44_14

			local var_44_15 = arg_43_0
			local var_44_16 = var_44_13

			local function var_44_17()
				local var_46_0 = arg_43_0
				local var_46_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_46_1(var_46_0, var_3_10002.ON_TASK_GO, var_44_4)

				return
			end

			SFX_PANEL = var_2_10017

			var_44_14(var_44_15, var_44_16, var_44_17, var_2_10017)

			local var_44_18 = var_44_4
			local var_44_19 = var_44_4.getConfig(var_44_18, "type")

			setImageSprite = var_44_18

			local var_44_20 = arg_44_2:Find("type")
			local var_44_21 = arg_43_0.typeImages
			local var_44_22 = var_16.Find

			tostring = var_2_10018

			local var_44_23 = var_44_22(var_44_21, var_2_10018(var_44_19))
			local var_44_24 = var_16.GetComponent

			typeof = var_18
			Image = var_19

			var_44_18(var_44_20, var_44_24(var_44_23, var_18(var_19)).sprite, true)

			setImageSprite = var_44_18

			local var_44_25 = arg_44_2:Find("progress/slider")
			local var_44_26 = arg_43_0.barImages
			local var_44_27 = var_16.Find

			tostring = var_18

			local var_44_28 = var_44_27(var_44_26, var_18(var_44_19))
			local var_44_29 = var_16.GetComponent

			typeof = var_18
			Image = var_19

			var_44_18(var_44_25, var_44_29(var_44_28, var_18(var_19)).sprite)
		end

		return
	end)

	local var_43_1 = arg_43_0.uilist

	var_1.align(var_43_1, #arg_43_0.curTask)

	setActive = var_1

	var_1(arg_43_0.taskWindow, false)

	return
end

function var_0_1.closeTask(arg_47_0)
	setActive = var_1_10001

	var_1_10001(arg_47_0.taskWindow, false)

	return
end

function var_0_1.openTask(arg_48_0)
	if not arg_48_0.curSubActID then
		arg_48_0:setPtActIndex()
		arg_48_0:setStep2Progress()
	end

	setActive = var_1

	var_1(arg_48_0.taskWindow, true)

	if arg_48_0.showTaskRedDot then
		setActive = var_1

		var_1(arg_48_0.taskRedDot, false)

		getProxy = var_1
		ActivityProxy = var_2

		local var_48_0 = var_1(var_2)

		var_1.updateActivity(var_48_0, arg_48_0.activity)
	end

	arg_48_0.hasClickTask = true
	eachChild = var_1

	var_1(arg_48_0.items, function(arg_49_0)
		isActive = var_2_10001

		if var_2_10001(arg_49_0:Find("finnal")) then
			arg_49_0:SetAsLastSibling()
		end

		return
	end)

	return
end

function var_0_1.autoFinishTask(arg_50_0)
	local var_50_0 = 0.01
	local var_50_1 = 0.5

	ipairs = var_1_10003

	for iter_50_0, iter_50_1 in var_1_10003(arg_50_0.finishItemList) do
		GetOrAddComponent = var_1_10008

		local var_50_2 = iter_50_1

		typeof = var_1_10010
		CanvasGroup = var_1_10011
		var_1_10008 = var_1_10008(var_50_2, var_1_10010(var_1_10011))
		var_1_10010 = arg_50_0

		local var_50_3 = arg_50_0.managedTween

		LeanTween = var_1_10011

		var_50_3(var_1_10010, var_1_10011.delayedCall, function()
			local var_51_0 = iter_50_1

			var_0.SetAsFirstSibling(var_51_0)

			LeanTween = var_0

			local var_51_1 = var_0.value

			go = var_51_0

			local var_51_2 = var_51_1(var_51_0(iter_50_1), 1, 0, var_50_1)
			local var_51_3 = var_0.setOnUpdate

			System = var_2

			local var_51_4 = var_51_3(var_51_2, var_2.Action_float(function(arg_52_0)
				var_1_10008.alpha = arg_52_0

				return
			end))
			local var_51_5 = var_0.setOnComplete

			System = var_2

			var_51_5(var_51_4, var_2.Action(function()
				local var_53_0 = var_1_10008

				var_53_0.alpha = 1
				setActive = var_53_0

				local var_53_1 = iter_50_1

				var_53_0(var_1.Find(var_53_1, "finnal"), true)

				local var_53_2 = iter_50_1

				var_0.SetAsLastSibling(var_53_2)

				return
			end))

			return
		end, var_50_0, nil)

		var_50_0 = var_50_0 + var_50_1 + 0.1
	end

	local var_50_4 = arg_50_0
	local var_50_5 = arg_50_0.managedTween

	LeanTween = var_5

	var_50_5(var_50_4, var_5.delayedCall, function()
		pg = var_2_10000

		local var_54_0 = var_2_10000.m02
		local var_54_1 = var_0.sendNotification

		GAME = var_2_10002

		var_54_1(var_54_0, var_2_10002.SUBMIT_TASK_ONESTEP, {
			resultList = arg_50_0.finishTaskVOList
		})

		return
	end, var_50_0, nil)

	return
end

function var_0_1.canFinishTask(arg_55_0, arg_55_1)
	local var_55_0 = false

	pairs = var_1_10003

	for iter_55_0, iter_55_1 in var_1_10003(arg_55_0) do
		local var_55_1

		if not arg_55_1:getTaskById(iter_55_1) then
			var_55_1 = arg_55_1:getFinishTaskById(iter_55_1)
		end

		if var_55_1:getTaskStatus() == 1 then
			var_55_0 = true

			break
		end
	end

	return var_55_0
end

function var_0_1.canAddProgress(arg_56_0, arg_56_1)
	local var_56_0 = false

	pairs = var_1_10003

	for iter_56_0, iter_56_1 in var_1_10003(arg_56_1) do
		local var_56_1, var_56_2, var_56_3 = iter_56_1:GetResProgress()

		if arg_56_0 >= var_56_2 - var_56_1 and iter_56_1:CanGetNextAward() then
			var_56_0 = true

			break
		end
	end

	return var_56_0
end

function var_0_1.canGetPtAward(arg_57_0)
	local var_57_0 = false

	pairs = var_1_10002

	for iter_57_0, iter_57_1 in var_1_10002(arg_57_0) do
		if iter_57_1:CanGetAward() then
			var_57_0 = true

			break
		end
	end

	return var_57_0
end

function var_0_1.isFinishAllAct(arg_58_0)
	local var_58_0 = true

	pairs = var_1_10002

	for iter_58_0, iter_58_1 in var_1_10002(arg_58_0.subPtDate) do
		if iter_58_1:CanGetNextAward() then
			var_58_0 = false

			break
		end
	end

	return var_58_0
end

function var_0_1.isNewTask(arg_59_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_59_0 = var_1_10001(var_1_10002)
	local var_59_1 = var_1.getData(var_59_0).id

	PlayerPrefs = var_59_0

	if var_59_0.GetInt("wwf_todo_task_num_" .. var_59_1) == 0 and not arg_59_0 == 0 or var_2 < arg_59_0 then
		return true
	else
		return false
	end

	return
end

function var_0_1.IsShowRed()
	pg = var_1_10000

	local var_60_0 = var_1_10000.activity_template

	ActivityConst = var_1_10001

	local var_60_1 = var_60_0[var_1_10001.WWF_TASK_ID].config_client.convertRes
	local var_60_2 = var_0.config_client.ptActID
	local var_60_3 = var_0.config_data
	local var_60_4 = {}

	ipairs = var_1_10005

	for iter_60_0, iter_60_1 in var_1_10005(var_60_2) do
		getProxy = var_1_10010
		ActivityProxy = var_1_10011
		var_1_10011 = var_1_10010(var_1_10011)
		var_1_10010 = var_1_10010.getActivityById(var_1_10011, iter_60_1)

		if var_60_4[iter_60_1] then
			local var_60_5 = var_60_4[iter_60_1]

			var_1_10011.Update(var_60_5, var_1_10010)
		else
			ActivityPtData = var_1_10011
			var_60_4[iter_60_1] = var_1_10011.New(var_1_10010)
		end
	end

	getProxy = var_5
	PlayerProxy = var_6

	local var_60_6 = var_5(var_6)
	local var_60_7 = var_5.getRawData(var_60_6)
	local var_60_8 = var_5.getResource(var_60_7, var_60_1)

	getProxy = var_60_7
	TaskProxy = var_8

	local var_60_9 = var_60_7(var_8)
	local var_60_10 = {}
	local var_60_11 = 0

	ipairs = var_1_10010

	for iter_60_2, iter_60_3 in var_1_10010(var_60_3) do
		local var_60_12 = var_60_9
		local var_60_13

		if not var_60_9.getTaskById(var_60_12, iter_60_3) then
			var_60_12 = var_60_9
			var_60_13 = var_60_9.getFinishTaskById(var_60_12, iter_60_3)
		end

		if var_60_13 then
			table = var_60_12

			var_60_12.insert(var_60_10, var_60_13.id)

			if var_60_13:getTaskStatus() == 0 then
				var_60_11 = var_60_11 + 1
			end
		end
	end

	if (function()
		local var_61_0 = true

		pairs = var_2_10001

		for iter_61_0, iter_61_1 in var_2_10001(var_60_4) do
			if iter_61_1:CanGetNextAward() then
				var_61_0 = false

				break
			end
		end

		return var_61_0
	end)() then
		return false
	else
		local var_60_14

		if not var_0_1.canFinishTask(var_60_10, var_60_9) and not var_0_1.canGetPtAward(var_60_4) and not var_0_1.canAddProgress(var_60_8, var_60_4) then
			var_60_14 = var_0_1.isNewTask(var_60_11)
		end

		return var_60_14
	end

	return false
end

function var_0_1.OnDestroy(arg_62_0)
	if arg_62_0.prefab1 and arg_62_0.model1 then
		PoolMgr = var_1

		local var_62_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_62_0, arg_62_0.prefab1, arg_62_0.model1)

		arg_62_0.prefab1 = nil
		arg_62_0.model1 = nil
	end

	if arg_62_0.prefab2 and arg_62_0.model2 then
		PoolMgr = var_1

		local var_62_1 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_62_1, arg_62_0.prefab2, arg_62_0.model2)

		arg_62_0.prefab2 = nil
		arg_62_0.model2 = nil
	end

	arg_62_0:cleanManagedTween()

	return
end

return var_0_1
