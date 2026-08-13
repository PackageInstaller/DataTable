class = var_0_10000

local var_0_0 = "PockySkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.GetCurrentDay()
	pg = var_1_10000

	local var_1_0 = var_1_10000.TimeMgr.GetInstance()
	local var_1_1 = var_0.GetServerTime(var_1_0)

	pg = var_1_10001

	local var_1_2 = var_1_10001.TimeMgr.GetInstance()

	return var_1.STimeDescS(var_1_2, var_1_1, "*t").yday
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "AD")

	local var_2_1 = arg_2_0.bg

	arg_2_0.leftStage = var_1.Find(var_2_1, "left")

	local var_2_2 = arg_2_0.bg

	arg_2_0.rightStage = var_1.Find(var_2_2, "right")

	local var_2_3 = arg_2_0.leftStage

	arg_2_0.taskDesc = var_1.Find(var_2_3, "task")

	local var_2_4 = arg_2_0.leftStage

	arg_2_0.signDesc = var_1.Find(var_2_4, "signin")
	arg_2_0.spine = nil
	GetSpineRequestPackage = var_1

	local var_2_5 = var_1.New("beierfasite_4", function(arg_3_0)
		SetParent = var_2_10001

		local var_3_0 = arg_3_0
		local var_3_1 = arg_2_0.leftStage

		var_2_10001(var_3_0, var_4.Find(var_3_1, "ship"))

		arg_2_0.spine = arg_3_0

		local var_3_2 = arg_2_0.spine.transform

		Vector3 = var_2_10002
		var_3_2.localScale = var_2_10002.one

		local var_3_3 = arg_2_0

		var_1.SetAction(var_3_3, "stand")

		arg_2_0.spineLRQ = nil

		return
	end)

	arg_2_0.spineLRQ = var_1.Start(var_2_5)
	getProxy = var_1
	PlayerProxy = var_2_5

	local var_2_6 = var_1(var_2_5)
	local var_2_7 = var_1.getRawData(var_2_6).id

	PlayerPrefs = var_1_10002
	arg_2_0.startDay = var_1_10002.GetInt("PockySkinSignDay" .. (var_2_7 or "-1"), 0)
	arg_2_0.usmLRQ = nil

	return
end

function var_0_1.OnDataSetting(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = arg_4_0.activity
	local var_4_2 = var_2.getConfig(var_4_1, "config_client").linkids
	local var_4_3 = false

	arg_4_0.ActSignIn = arg_4_0.activity
	getProxy = var_4
	TaskProxy = var_1_10006
	arg_4_0.taskProxy = var_4(var_1_10006)

	if arg_4_0.ActSignIn then
		arg_4_0.nday = 0

		local var_4_4 = arg_4_0.ActSignIn

		arg_4_0.taskGroup = var_4.getConfig(var_4_4, "config_data")

		if not var_4_3 then
			updateActivityTaskStatus = var_4
			var_4_3 = var_4(arg_4_0.ActSignIn)
		end
	end

	arg_4_0.ActPT = var_4_0:getActivityById(var_4_2[1])

	if arg_4_0.ActPT then
		if arg_4_0.ptData then
			local var_4_5 = arg_4_0.ptData

			var_4.Update(var_4_5, arg_4_0.ActPT)
		else
			ActivityPtData = var_4
			arg_4_0.ptData = var_4.New(arg_4_0.ActPT)
		end
	end

	arg_4_0.ActTaskList = var_4_0:getActivityById(var_4_2[2])

	if arg_4_0.ActTaskList then
		arg_4_0.nday2 = 0

		local var_4_6 = arg_4_0.ActTaskList

		arg_4_0.taskGroup2 = var_4.getConfig(var_4_6, "config_data")

		if not var_4_3 then
			updateActivityTaskStatus = var_4
			var_4_3 = var_4(arg_4_0.ActTaskList)
		end
	end

	arg_4_0.ActFinal = var_4_0:getActivityById(var_4_2[3])

	if arg_4_0.ActFinal then
		arg_4_0.nday3 = 0

		local var_4_7 = arg_4_0.ActFinal

		arg_4_0.taskGroup3 = var_4.getConfig(var_4_7, "config_data")

		if not var_4_3 then
			updateActivityTaskStatus = var_4
			var_4_3 = var_4(arg_4_0.ActFinal)
		end
	end

	return var_4_3
end

function var_0_1.OnFirstFlush(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.rightStage
	local var_5_2 = var_4.Find(var_5_1, "display_btn")

	local function var_5_3()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_6_2 = var_2_10003.SHOW_AWARD_WINDOW

		PtAwardWindow = var_2_10004

		var_6_1(var_6_0, var_6_2, var_2_10004, {
			type = arg_5_0.ptData.type,
			dropList = arg_5_0.ptData.dropList,
			targets = arg_5_0.ptData.targets,
			level = arg_5_0.ptData.level,
			count = arg_5_0.ptData.count,
			resId = arg_5_0.ptData.resId
		})

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.rightStage
	local var_5_6 = var_4.Find(var_5_5, "battle_btn")

	local function var_5_7()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.rightStage
	local var_5_10 = var_4.Find(var_5_9, "get_btn")

	local function var_5_11()
		local var_8_0 = arg_5_0.ptData
		local var_8_1, var_8_2 = var_0.GetResProgress(var_8_0)
		local var_8_3 = arg_5_0
		local var_8_4 = var_2.emit

		ActivityMediator = var_2_10005

		local var_8_5 = var_2_10005.EVENT_PT_OPERATION
		local var_8_6 = {
			cmd = 1
		}
		local var_8_7 = arg_5_0.ptData

		var_8_6.activity_id = var_7.GetId(var_8_7)
		var_8_6.arg1 = var_8_2

		var_8_4(var_8_3, var_8_5, var_8_6)

		return
	end

	SFX_PANEL = var_5_9

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5_9)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.bg
	local var_5_14 = var_4.Find(var_5_13, "help")

	local function var_5_15()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_9_2.type = var_2_10004
		pg = var_2_10004
		var_9_2.helps = var_2_10004.gametip.pocky_help.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_5_13

	var_1_10001(var_5_12, var_5_14, var_5_15, var_5_13)

	return
end

function var_0_1.SetAction(arg_10_0, arg_10_1)
	if not arg_10_0.spine then
		return
	end

	local var_10_0 = arg_10_0.spine

	if var_2.GetComponent(var_10_0, "SpineAnimUI") then
		var_2:SetAction(arg_10_1, 0)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	arg_11_0:UpdateTaskList()
	arg_11_0:UpdatePTList()

	local var_11_0 = arg_11_0.startDay < arg_11_0.GetCurrentDay()
	local var_11_1 = "ui"
	local var_11_2 = var_11_0 and "juu_factory_rest" or "juu_factory"

	if arg_11_0.usmLRQ and arg_11_0.usmLRQ.name ~= var_11_2 then
		local var_11_3 = arg_11_0.usmLRQ

		var_4.Stop(var_11_3)

		arg_11_0.usmLRQ = nil
	end

	if arg_11_0.usmName ~= var_11_2 then
		LoadPrefabRequestPackage = var_4

		local var_11_4 = var_4.New(var_11_1 .. "/" .. var_11_2, var_11_2, function(arg_12_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_11_0.usm) then
				Destroy = var_1

				var_1(arg_11_0.usm)
			end

			local var_12_0 = arg_11_0

			var_12_0.usm = arg_12_0
			setParent = var_12_0

			local var_12_1 = arg_12_0
			local var_12_2 = arg_11_0.bg

			var_12_0(var_12_1, var_4.Find(var_12_2, "usm"))

			return
		end)

		arg_11_0.usmLRQ = var_4.Start(var_11_4)
		arg_11_0.usmName = var_11_2
	end

	return
end

function var_0_1.UpdateTaskList(arg_13_0)
	local var_13_0

	if not arg_13_0.ActSignIn.data3 then
		var_13_0 = 0
	end

	arg_13_0.nday = var_13_0

	local var_13_1

	if not arg_13_0.ActTaskList.data3 then
		var_13_1 = 0
	end

	arg_13_0.nday2 = var_13_1

	local var_13_2

	if not arg_13_0.ActFinal.data3 then
		var_13_2 = 0
	end

	arg_13_0.nday3 = var_13_2

	local var_13_3 = arg_13_0.ActSignIn
	local var_13_4 = var_1.getConfig(var_13_3, "config_client").story

	checkExist = var_1_10002

	if var_1_10002(var_13_4, {
		arg_13_0.nday
	}, {
		1
	}) then
		pg = var_2

		local var_13_5 = var_2.NewStoryMgr.GetInstance()

		var_2.Play(var_13_5, var_13_4[arg_13_0.nday][1])
	end

	local var_13_6 = arg_13_0.leftStage
	local var_13_7 = var_2.Find(var_13_6, "go_btn")
	local var_13_8 = arg_13_0.leftStage
	local var_13_9 = var_3.Find(var_13_8, "get_btn")
	local var_13_10 = arg_13_0.leftStage
	local var_13_11 = var_4.Find(var_13_10, "sign_btn")
	local var_13_12 = arg_13_0.leftStage
	local var_13_13 = var_5.Find(var_13_12, "got_btn")
	local var_13_14 = arg_13_0.leftStage
	local var_13_15 = var_6.Find(var_13_14, "award")
	local var_13_16 = arg_13_0.leftStage
	local var_13_17 = var_7.Find(var_13_16, "slider")

	getProxy = var_13_14
	TaskProxy = var_10

	local var_13_18 = var_13_14(var_10)
	local var_13_19 = arg_13_0.taskGroup[arg_13_0.nday][1]
	local var_13_20 = arg_13_0.taskGroup2[arg_13_0.nday2][1]
	local var_13_21 = arg_13_0.taskGroup3[arg_13_0.nday3][1]
	local var_13_22 = var_13_18:getTaskVO(var_13_19)
	local var_13_23 = var_13_18:getTaskVO(var_13_20)
	local var_13_24 = var_13_18:getTaskVO(var_13_21)
	local var_13_25 = var_13_22:getTaskStatus()
	local var_13_26 = var_13_23:getTaskStatus()
	local var_13_27 = var_13_24:getTaskStatus()

	if not arg_13_0.startTaskid then
		arg_13_0.startTaskid = var_13_19
		arg_13_0.startStatus = var_13_25
	end

	local var_13_28 = false

	if arg_13_0.startTaskid ~= var_13_19 then
		arg_13_0.startTaskid = var_13_19
		arg_13_0.startStatus = var_13_25
		var_13_28 = true
	elseif arg_13_0.startStatus ~= var_13_25 then
		arg_13_0.startStatus = var_13_25
		var_13_28 = true
	end

	local var_13_29 = arg_13_0.GetCurrentDay()

	if var_13_28 and arg_13_0.startDay < var_13_29 then
		arg_13_0.startDay = var_13_29
		getProxy = var_1_10020
		PlayerProxy = var_1_10022

		local var_13_30 = var_1_10020(var_1_10022)

		var_1_10020 = var_1_10020.getRawData(var_13_30).id
		PlayerPrefs = var_1_10021

		var_1_10021.SetInt("PockySkinSignDay" .. (var_1_10020 or "-1"), arg_13_0.startDay)
	end

	if var_13_27 == 2 then
		setActive = var_1_10020

		var_1_10020(var_13_15, false)

		setActive = var_1_10020

		var_1_10020(var_13_17, false)

		setActive = var_1_10020

		var_1_10020(arg_13_0.taskDesc, false)

		setActive = var_1_10020

		var_1_10020(arg_13_0.signDesc, true)

		setText = var_1_10020

		local var_13_31 = arg_13_0.signDesc
		local var_13_32 = var_22.Find(var_13_31, "title")

		i18n = var_23

		var_1_10020(var_13_32, var_23("pocky_jiujiu"))

		setText = var_1_10020

		local var_13_33 = arg_13_0.signDesc
		local var_13_34 = var_22.Find(var_13_33, "desc")

		i18n = var_23

		var_1_10020(var_13_34, var_23("pocky_jiujiu_desc"))

		setActive = var_1_10020

		var_1_10020(var_13_7, false)

		setActive = var_1_10020

		var_1_10020(var_13_11, true)

		setActive = var_1_10020

		var_1_10020(var_13_9, false)

		setActive = var_1_10020

		var_1_10020(var_13_13, false)

		onButton = var_1_10020

		local var_13_35 = arg_13_0
		local var_13_36 = var_13_11

		local function var_13_37()
			if arg_13_0.GetCurrentDay() > arg_13_0.startDay then
				local var_14_0 = arg_13_0

				var_14_0.startDay = var_0
				getProxy = var_14_0
				PlayerProxy = var_2_10003

				local var_14_1 = var_14_0(var_2_10003)
				local var_14_2 = var_1.getRawData(var_14_1).id

				PlayerPrefs = var_2_10002

				var_2_10002.SetInt("PockySkinSignDay" .. (var_14_2 or "-1"), arg_13_0.startDay)

				local var_14_3 = arg_13_0

				var_2.OnUpdateFlush(var_14_3)
			end

			return
		end

		SFX_PANEL = var_25

		var_1_10020(var_13_35, var_13_36, var_13_37, var_25)

		removeOnButton = var_1_10020

		var_1_10020(var_13_13)

		return
	end

	local var_13_38
	local var_13_39
	local var_13_40

	if arg_13_0.ptData.level >= #arg_13_0.ptData.targets and arg_13_0.nday >= #arg_13_0.taskGroup and var_13_25 == 2 and arg_13_0.nday2 >= #arg_13_0.taskGroup2 and var_13_26 == 2 then
		setActive = var_23

		var_23(var_13_11, false)

		var_13_38 = var_13_9
		var_13_39 = var_13_24
	elseif arg_13_0.nday <= arg_13_0.nday2 and var_13_25 ~= 2 then
		setActive = var_23

		var_23(var_13_9, false)

		var_13_38 = var_13_11
		var_13_39 = var_13_22
	else
		setActive = var_23

		var_23(var_13_11, false)

		var_13_38 = var_13_9
		var_13_39 = var_13_23
	end

	local var_13_41 = var_13_39:getConfig("award_display")[1]
	local var_13_42 = {
		type = var_13_41[1],
		id = var_13_41[2],
		count = var_13_41[3]
	}

	setActive = var_25

	var_25(var_13_15, true)

	updateDrop = var_25

	var_25(var_13_15, var_13_42)

	onButton = var_25

	local var_13_43 = arg_13_0
	local var_13_44 = var_13_15

	local function var_13_45()
		local var_15_0 = arg_13_0
		local var_15_1 = var_0.emit

		BaseUI = var_2_10003

		var_15_1(var_15_0, var_2_10003.ON_DROP, var_13_42)

		return
	end

	SFX_PANEL = var_1_10030

	var_25(var_13_43, var_13_44, var_13_45, var_1_10030)

	setActive = var_25

	var_25(var_13_17, true)

	setActive = var_25

	var_25(arg_13_0.taskDesc, true)

	setActive = var_25

	var_25(arg_13_0.signDesc, false)

	local var_13_46 = var_13_39
	local var_13_47 = var_13_39.getProgress(var_13_46)
	local var_13_48 = var_13_39
	local var_13_49 = var_13_39.getConfig(var_13_48, "target_num")

	setText = var_13_46

	local var_13_50 = arg_13_0.taskDesc

	var_13_46(var_29.Find(var_13_50, "title"), var_13_39:getConfig("name"))

	setText = var_13_46

	local var_13_51 = arg_13_0.taskDesc

	var_13_46(var_29.Find(var_13_51, "desc"), var_13_39:getConfig("desc"))

	setSlider = var_13_46

	var_13_46(var_13_17, 0, var_13_49, var_13_47)

	local var_13_52 = var_13_39:getTaskStatus()

	setActive = var_13_48

	var_13_48(var_13_7, var_13_52 == 0)

	setActive = var_13_48

	var_13_48(var_13_38, var_13_52 == 1)

	setActive = var_13_48

	var_13_48(var_13_13, var_13_52 == 2)

	onButton = var_13_48

	local var_13_53 = arg_13_0
	local var_13_54 = var_13_7

	local function var_13_55()
		local var_16_0 = arg_13_0
		local var_16_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_16_1(var_16_0, var_2_10003.ON_TASK_GO, var_13_39)

		return
	end

	SFX_PANEL = var_33

	var_13_48(var_13_53, var_13_54, var_13_55, var_33)

	onButton = var_13_48

	local var_13_56 = arg_13_0
	local var_13_57 = var_13_38

	local function var_13_58()
		local var_17_0 = arg_13_0
		local var_17_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_17_1(var_17_0, var_2_10003.ON_TASK_SUBMIT, var_13_39)

		return
	end

	SFX_PANEL = var_33

	var_13_48(var_13_56, var_13_57, var_13_58, var_33)

	return
end

function var_0_1.UpdatePTList(arg_18_0)
	if not arg_18_0.ptData then
		return
	end

	local var_18_0 = arg_18_0.ptData
	local var_18_1 = var_1.getTargetLevel(var_18_0)
	local var_18_2 = arg_18_0.ActPT
	local var_18_3 = var_2.getConfig(var_18_2, "config_client").story

	checkExist = var_18_0

	if var_18_0(var_18_3, {
		var_18_1
	}, {
		1
	}) then
		pg = var_3

		local var_18_4 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_18_4, var_18_3[var_18_1][1])
	end

	local var_18_5 = arg_18_0.ptData
	local var_18_6, var_18_7 = var_3.GetResProgress(var_18_5)
	local var_18_8 = arg_18_0.ptData
	local var_18_9 = var_5.GetTotalResRequire(var_18_8)
	local var_18_10 = arg_18_0.rightStage
	local var_18_11

	var_18_11, setSlider = var_6.Find(var_18_10, "slider"), var_18_8

	local var_18_12 = 0
	local var_18_13 = 1

	math = var_1_10012

	var_18_8(var_18_11, var_18_12, var_18_13, var_1_10012.min(var_18_6, var_18_7) / var_18_9)

	local var_18_14 = arg_18_0.ptData
	local var_18_15 = var_7.GetUnlockedMaxResRequire(var_18_14)
	local var_18_16 = arg_18_0.rightStage
	local var_18_17 = var_8.Find(var_18_16, "slider_total")

	setSlider = var_18_14

	var_18_14(var_18_17, 0, 1, var_18_15 / var_18_9)

	local var_18_18 = arg_18_0.ptData
	local var_18_19 = var_9.CanGetAward(var_18_18)
	local var_18_20 = arg_18_0.ptData
	local var_18_21 = var_10.CanGetNextAward(var_18_20)
	local var_18_22 = arg_18_0.ptData
	local var_18_23 = var_11.CanGetMorePt(var_18_22)

	setActive = var_18_20

	local var_18_24 = arg_18_0.rightStage

	var_18_20(var_14.Find(var_18_24, "battle_btn"), var_18_23 and not var_18_19 and var_18_21)

	setActive = var_18_20

	local var_18_25 = arg_18_0.rightStage

	var_18_20(var_14.Find(var_18_25, "get_btn"), var_18_19)

	setActive = var_18_20

	local var_18_26 = arg_18_0.rightStage

	var_18_20(var_14.Find(var_18_26, "got_btn"), not var_18_21)

	return
end

function var_0_1.OnDestroy(arg_19_0)
	if arg_19_0.spineLRQ then
		local var_19_0 = arg_19_0.spineLRQ

		var_1.Stop(var_19_0)

		arg_19_0.spineLRQ = nil
	end

	if arg_19_0.spine then
		local var_19_1 = arg_19_0.spine.transform

		Vector3 = var_1_10002
		var_19_1.localScale = var_1_10002.one
		pg = var_19_1

		local var_19_2 = var_19_1.PoolMgr.GetInstance()

		var_1.ReturnSpineChar(var_19_2, "beierfasite_4", arg_19_0.spine)

		arg_19_0.spine = nil
	end

	return
end

return var_0_1
