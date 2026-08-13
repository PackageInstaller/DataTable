class = var_0_10000

local var_0_0 = "SpringCoupletPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))
local var_0_2 = 7
local var_0_3 = 7
local var_0_4 = 7
local var_0_5 = 400
local var_0_6 = 78
local var_0_7 = 1
local var_0_8 = "ui/activityuipage/springcoupletpage_atlas"
local var_0_9 = "couplete_activty_desc"
local var_0_10 = "couplete_click_desc"
local var_0_11 = "couplet_index_desc"
local var_0_12 = "couplete_help"
local var_0_13 = "couplete_drag_tip"
local var_0_14 = "couplete_remind"
local var_0_15 = "couplete_complete"
local var_0_16 = "couplete_enter"
local var_0_17 = "couplete_stay"
local var_0_18 = "couplete_task"
local var_0_19 = {
	"couplete_pass_1",
	"couplete_pass_2"
}
local var_0_20 = {
	"couplete_fail_1",
	"couplete_fail_2"
}
local var_0_21 = 20

function var_0_1.OnInit(arg_1_0)
	findTF = var_1_10001
	arg_1_0.itemTpl = var_1_10001(arg_1_0._tf, "AD/itemTpl")
	findTF = var_1
	arg_1_0.iconTpl = var_1(arg_1_0._tf, "AD/iconTpl")
	findTF = var_1
	arg_1_0.wordTpl = var_1(arg_1_0._tf, "AD/wordTpl")
	findTF = var_1
	arg_1_0.itemContainer = var_1(arg_1_0._tf, "AD/itemContainer")
	findTF = var_1
	arg_1_0.taskIcon = var_1(arg_1_0._tf, "AD/task/icon")
	findTF = var_1
	arg_1_0.taskSlider = var_1(arg_1_0._tf, "AD/task/Slider")
	findTF = var_1
	arg_1_0.taskBtnGet = var_1(arg_1_0._tf, "AD/task/btnGet")
	findTF = var_1
	arg_1_0.taskBtnGot = var_1(arg_1_0._tf, "AD/task/btnGot")
	findTF = var_1
	arg_1_0.taskBtnGo = var_1(arg_1_0._tf, "AD/task/btnGo")
	findTF = var_1
	arg_1_0.taskDesc = var_1(arg_1_0._tf, "AD/task/desc")
	findTF = var_1
	arg_1_0.taskCur = var_1(arg_1_0._tf, "AD/task/cur")
	findTF = var_1
	arg_1_0.taskMax = var_1(arg_1_0._tf, "AD/task/max")
	findTF = var_1
	arg_1_0.finalAward = var_1(arg_1_0._tf, "AD/finalAward")
	findTF = var_1
	arg_1_0.charPos = var_1(arg_1_0._tf, "AD/charPos")
	findTF = var_1
	arg_1_0.charClick = var_1(arg_1_0.charPos, "click")
	findTF = var_1
	arg_1_0.btnConfirm = var_1(arg_1_0._tf, "AD/btnConfirm")
	findTF = var_1
	arg_1_0.imgComplete = var_1(arg_1_0._tf, "AD/imgComplete")
	findTF = var_1
	arg_1_0.charTip = var_1(arg_1_0._tf, "AD/charTip")
	setActive = var_1

	var_1(arg_1_0.charTip, false)

	findTF = var_1
	arg_1_0.btnHelp = var_1(arg_1_0._tf, "AD/btnHelp")
	findTF = var_1
	arg_1_0.remindDesc = var_1(arg_1_0._tf, "AD/remindDesc")
	setText = var_1

	local var_1_0 = arg_1_0.remindDesc

	i18n = var_3

	var_1(var_1_0, var_3(var_0_10))

	findTF = var_1
	arg_1_0.dragTip = var_1(arg_1_0._tf, "AD/dragTip")
	setText = var_1

	local var_1_1 = arg_1_0.dragTip

	i18n = var_3

	var_1(var_1_1, var_3(var_0_13))

	findTF = var_1
	arg_1_0.btnPre = var_1(arg_1_0._tf, "AD/pre")
	findTF = var_1
	arg_1_0.btnNext = var_1(arg_1_0._tf, "AD/next")
	findTF = var_1
	arg_1_0.activityDesc = var_1(arg_1_0._tf, "AD/desc")
	setText = var_1

	local var_1_2 = arg_1_0.activityDesc

	i18n = var_3

	var_1(var_1_2, var_3(var_0_9))

	GetComponent = var_1
	findTF = var_1_2

	local var_1_3 = var_1_2(arg_1_0._tf, "AD/coupletUp/contents/img")

	typeof = var_3
	Image = var_4
	arg_1_0.coupletUpImg = var_1(var_1_3, var_3(var_4))
	findTF = var_1
	arg_1_0.coupletUpContents = var_1(arg_1_0._tf, "AD/coupletUp/contents")
	findTF = var_1
	arg_1_0.coupletBottomContents = var_1(arg_1_0._tf, "AD/coupletBottom/contents")
	findTF = var_1
	arg_1_0.coupletUpLock = var_1(arg_1_0._tf, "AD/coupletUp/lock")
	findTF = var_1
	arg_1_0.coupletBottomLock = var_1(arg_1_0._tf, "AD/coupletBottom/lock")
	tf = var_1
	instantiate = var_2
	arg_1_0.awardIcon = var_1(var_2(arg_1_0.iconTpl))

	local var_1_4 = arg_1_0.awardIcon

	Vector2 = var_2
	var_1_4.anchoredPosition = var_2(0, 0)
	setActive = var_1_4

	var_1_4(arg_1_0.awardIcon, true)

	setParent = var_1_4

	var_1_4(arg_1_0.awardIcon, arg_1_0.taskIcon)

	findTF = var_1_4
	arg_1_0.countDesc = var_1_4(arg_1_0._tf, "AD/countDesc")
	arg_1_0.items = {}

	for iter_1_0 = 1, var_0_3 do
		tf = var_1_10005
		instantiate = var_1_10006
		var_1_10005 = var_1_10005(var_1_10006(arg_1_0.itemTpl))
		setActive = var_1_10006

		var_1_10006(var_1_10005, true)

		setParent = var_1_10006

		var_1_10006(var_1_10005, arg_1_0.itemContainer)

		table = var_1_10006

		var_1_10006.insert(arg_1_0.items, var_1_10005)
	end

	arg_1_0.coupletBottomWords = {}

	for iter_1_1 = 1, var_0_4 do
		var_1_10005 = arg_1_0:createWord(iter_1_1, arg_1_0.coupletBottomContents)

		arg_1_0:addCoupletWordEvent(var_1_10005)

		table = var_6

		var_6.insert(arg_1_0.coupletBottomWords, var_1_10005)
	end

	GameObject = var_1

	local var_1_5 = var_1.Find("UICamera")
	local var_1_6 = var_1.GetComponent

	typeof = var_3
	Camera = iter_1_1
	arg_1_0._uiCamera = var_1_6(var_1_5, var_3(iter_1_1))
	Timer = var_1
	arg_1_0.timer = var_1.New(function()
		local var_2_0 = arg_1_0

		var_0.onTimer(var_2_0)

		return
	end, 2, -1)

	local var_1_7 = arg_1_0.timer

	var_1.Start(var_1_7)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.btnConfirm, function()
		local var_3_0 = arg_1_0

		var_0.finishCouplete(var_3_0)

		return
	end)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.btnPre, function()
		arg_1_0.coupletIndex = arg_1_0.coupletIndex - 1

		local var_4_0 = arg_1_0

		var_0.selectCoupletChange(var_4_0)

		return
	end)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.btnNext, function()
		arg_1_0.coupletIndex = arg_1_0.coupletIndex + 1

		local var_5_0 = arg_1_0

		var_0.selectCoupletChange(var_5_0)

		return
	end)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.btnHelp, function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.couplete_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.charClick, function()
		if not arg_1_0.charClickCount then
			arg_1_0.charClickCount = 0
		end

		arg_1_0.charClickCount = arg_1_0.charClickCount + 1

		if arg_1_0.charClickCount % 3 == 0 and not arg_1_0.coupletComplete and arg_1_0.coupletUnLock then
			local var_7_0 = arg_1_0
			local var_7_1 = var_0.showTips

			i18n = var_2_10002

			local var_7_2 = var_0_14

			i18n = var_2_10004

			var_7_1(var_7_0, var_2_10002(var_7_2, var_2_10004("couplete_pair_" .. arg_1_0.coupletIndex)), true)
		end

		return
	end)

	onButton = var_1

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.taskBtnGo

	local function var_1_10()
		local var_8_0 = arg_1_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_TASK_GO, arg_1_0.taskVO)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_8, var_1_9, var_1_10, var_1_10005)

	onButton = var_1

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0.taskBtnGet

	local function var_1_13()
		pg = var_2_10000

		local var_9_0 = var_2_10000.m02
		local var_9_1 = var_0.sendNotification

		GAME = var_2_10002

		var_9_1(var_9_0, var_2_10002.SUBMIT_TASK, {
			normal_submit = true,
			virtual = false,
			taskId = arg_1_0.taskVO.id
		})

		local var_9_2 = arg_1_0
		local var_9_3 = var_0.showTips

		i18n = var_2

		var_9_3(var_9_2, var_2(var_0_16), true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_11, var_1_12, var_1_13, var_1_10005)

	Ship = var_1

	local var_1_14 = var_1.New({
		skin_id = 502010,
		configId = 502011
	})
	local var_1_15 = var_1.getPrefab(var_1_14)

	PoolMgr = var_1_14

	local var_1_16 = var_1_14.GetInstance()

	var_3.GetSpineChar(var_1_16, var_1_15, true, function(arg_10_0)
		arg_1_0.model = arg_10_0

		local var_10_0 = arg_1_0.model.transform

		Vector3 = var_2_10002
		var_10_0.localScale = var_2_10002(0.7, 0.7, 0.7)

		local var_10_1 = arg_1_0.model.transform

		Vector3 = var_2
		var_10_1.localPosition = var_2.zero

		local var_10_2 = arg_1_0.model.transform
		local var_10_3 = var_1.SetParent

		findTF = var_3

		var_10_3(var_10_2, var_3(arg_1_0.charPos, "pos"), false)

		local var_10_4 = arg_1_0
		local var_10_5 = arg_1_0.model
		local var_10_6 = var_2.GetComponent

		typeof = var_4
		SpineAnimUI = var_5
		var_10_4.anim = var_10_6(var_10_5, var_4(var_5))

		local var_10_7 = arg_1_0.anim

		var_1.SetAction(var_10_7, "stand", 0)

		return
	end)

	return
end

function var_0_1.OnShowFlush(arg_11_0)
	arg_11_0.tipStayIndex = var_0_21

	if arg_11_0.data1List and arg_11_0.data2List and #arg_11_0.data1List ~= #arg_11_0.data2List then
		local var_11_0 = arg_11_0
		local var_11_1 = arg_11_0.showTips

		i18n = var_1_10003

		var_11_1(var_11_0, var_1_10003(var_0_16))
	elseif arg_11_0.data1List and arg_11_0.data2List and #arg_11_0.data1List == #arg_11_0.data2List and not arg_11_0.coupletFinishAll then
		local var_11_2 = arg_11_0
		local var_11_3 = arg_11_0.showTips

		i18n = var_1_10003

		var_11_3(var_11_2, var_1_10003(var_0_18))
	elseif arg_11_0.coupletFinishAll then
		local var_11_4 = arg_11_0
		local var_11_5 = arg_11_0.showTips

		i18n = var_1_10003

		var_11_5(var_11_4, var_1_10003(var_0_15))
	end

	return
end

function var_0_1.OnHideFlush(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.charTip, false)

	return
end

function var_0_1.OnDataSetting(arg_13_0)
	if not arg_13_0.coupletIds then
		var_1_10002 = arg_13_0.activity
		arg_13_0.coupletIds = var_1.getConfig(var_1_10002, "config_client").couplet
		arg_13_0.coupletDatas = {}

		for iter_13_0 = 1, #arg_13_0.coupletIds do
			pg = var_1_10005
			var_1_10005 = var_1_10005.activity_spring_couplets[arg_13_0.coupletIds[iter_13_0]]
			table = var_6

			var_6.insert(arg_13_0.coupletDatas, var_1_10005)
		end
	end

	getProxy = var_1
	TaskProxy = var_1_10002
	arg_13_0.taskProxy = var_1(var_1_10002)

	local var_13_0 = arg_13_0.activity
	local var_13_1 = var_1.getConfig(var_13_0, "config_client").linkActID

	getProxy = var_13_0
	ActivityProxy = var_3

	local var_13_2 = var_13_0(var_3)

	arg_13_0.taskActivity = var_2.getActivityById(var_13_2, var_13_1)

	local var_13_3 = arg_13_0.taskActivity

	arg_13_0.taskGroup = var_2.getConfig(var_13_3, "config_data")
	arg_13_0.tipStayIndex = var_0_21
	updateActivityTaskStatus = var_2

	return var_2(arg_13_0.taskActivity)
end

function var_0_1.onTimer(arg_14_0)
	if arg_14_0.tipStayIndex and arg_14_0.tipStayIndex > 0 then
		arg_14_0.tipStayIndex = arg_14_0.tipStayIndex - 1
	elseif arg_14_0.tipStayIndex == 0 then
		arg_14_0.tipStayIndex = -1

		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.showTips

		i18n = var_1_10003

		var_14_1(var_14_0, var_1_10003(var_0_17), true)
	end

	if arg_14_0.charClickCount and arg_14_0.charClickCount > 0 then
		arg_14_0.charClickCount = arg_14_0.charClickCount - 1
	end

	return
end

function var_0_1.OnFirstFlush(arg_15_0)
	arg_15_0:updateUI()
	arg_15_0:finishAll()

	return
end

function var_0_1.OnUpdateFlush(arg_16_0)
	arg_16_0:updateUI()

	return
end

function var_0_1.updateUI(arg_17_0)
	arg_17_0.data1 = arg_17_0.activity.data1
	arg_17_0.data2 = arg_17_0.activity.data2
	arg_17_0.data3 = arg_17_0.activity.data3
	arg_17_0.data1List = arg_17_0.activity.data1_list
	arg_17_0.data2List = arg_17_0.activity.data2_list
	arg_17_0.data3List = arg_17_0.activity.data3_list
	arg_17_0.coupletFinishAll = false

	if arg_17_0.data2List and #arg_17_0.data2List == #arg_17_0.coupletIds then
		arg_17_0.coupletFinishAll = true
	end

	arg_17_0.coupletIndex = 1

	for iter_17_0 = #arg_17_0.coupletIds, 1, -1 do
		local var_17_0 = arg_17_0.coupletIds[iter_17_0]

		table = var_1_10006

		if var_1_10006.contains(arg_17_0.data1List, var_17_0) then
			table = var_1_10006

			if not var_1_10006.contains(arg_17_0.data2List, var_17_0) then
				arg_17_0.coupletIndex = iter_17_0
			end
		end

		table = var_1_10006

		if not var_1_10006.contains(arg_17_0.data2List, var_17_0) then
			var_1_10006 = false
		end

		table = var_7

		local var_17_1

		if not var_7.contains(arg_17_0.data1List, var_17_0) then
			var_17_1 = false
		end

		local var_17_2 = arg_17_0.items[iter_17_0]

		setActive = var_9
		findTF = var_1_10010

		var_9(var_1_10010(var_17_2, "got"), var_1_10006 or false)

		setActive = var_9
		findTF = var_1_10010

		var_9(var_1_10010(var_17_2, "bgMask"), not var_17_1 or var_1_10006 or false)

		setActive = var_9
		findTF = var_1_10010

		var_9(var_1_10010(var_17_2, "red"), var_17_1)

		setActive = var_9
		findTF = var_1_10010

		var_9(var_1_10010(var_17_2, "lock"), not var_17_1 or false)

		if iter_17_0 == 7 then
			setActive = var_9
			findTF = var_1_10010

			var_9(var_1_10010(arg_17_0.finalAward, "lock"), not var_17_1 or false)

			setActive = var_9
			findTF = var_1_10010

			var_9(var_1_10010(arg_17_0.finalAward, "mask"), not var_17_1 or var_1_10006 or false)

			setActive = var_9
			findTF = var_1_10010

			var_9(var_1_10010(arg_17_0.finalAward, "got"), arg_17_0.coupletFinishAll)
		end
	end

	arg_17_0:selectCoupletChange()
	arg_17_0:updateCoupletWord()
	arg_17_0:updateTask()

	return
end

function var_0_1.finishAll(arg_18_0)
	if #arg_18_0.data2List == #arg_18_0.coupletIds and #arg_18_0.data2List == #arg_18_0.data1List and arg_18_0.activity.data1 == 0 then
		pg = var_1

		local var_18_0 = var_1.m02
		local var_18_1 = var_1.sendNotification

		GAME = var_1_10003

		var_18_1(var_18_0, var_1_10003.PUZZLE_PIECE_OP, {
			cmd = 1,
			actId = arg_18_0.activity.id
		})
	end

	return
end

function var_0_1.updateTask(arg_19_0)
	arg_19_0.nday = arg_19_0.taskActivity.data3

	local var_19_0 = arg_19_0.taskGroup[arg_19_0.nday][1]
	local var_19_1 = arg_19_0.taskProxy
	local var_19_3

	if not var_2.getTaskById(var_19_1, var_19_0) then
		local var_19_2 = arg_19_0.taskProxy

		var_19_3 = var_2.getFinishTaskById(var_19_2, var_19_0)
	end

	arg_19_0.taskVO = var_19_3

	local var_19_4 = var_19_3:getConfig("award_display")[1]
	local var_19_5 = {
		type = var_19_4[1],
		id = var_19_4[2],
		count = var_19_4[3]
	}

	updateDrop = var_5

	var_5(arg_19_0.awardIcon, var_19_5)

	onButton = var_5

	local var_19_6 = arg_19_0
	local var_19_7 = arg_19_0.taskIcon

	local function var_19_8()
		local var_20_0 = arg_19_0
		local var_20_1 = var_0.emit

		BaseUI = var_2_10002

		var_20_1(var_20_0, var_2_10002.ON_DROP, var_19_5)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_19_6, var_19_7, var_19_8, var_1_10009)

	local var_19_9 = var_19_3
	local var_19_10 = var_19_3.getConfig(var_19_9, "desc")

	setText = var_19_9

	var_19_9(arg_19_0.taskDesc, var_19_10)

	local var_19_11 = var_19_3
	local var_19_12 = var_19_3.getTaskStatus(var_19_11)

	setActive = var_19_11

	var_19_11(arg_19_0.taskBtnGo, var_19_12 == 0)

	setActive = var_19_11

	var_19_11(arg_19_0.taskBtnGet, var_19_12 == 1)

	setActive = var_19_11

	var_19_11(arg_19_0.taskBtnGot, var_19_12 == 2)

	local var_19_13 = var_19_3:getProgress()
	local var_19_14 = var_19_3
	local var_19_15 = var_19_3.getConfig(var_19_14, "target_num")

	setSlider = var_19_14

	var_19_14(arg_19_0.taskSlider, 0, var_19_15, var_19_13)

	setText = var_19_14

	var_19_14(arg_19_0.taskCur, var_19_13)

	setText = var_19_14

	var_19_14(arg_19_0.taskMax, "/" .. var_19_15)

	return
end

function var_0_1.finishCouplete(arg_21_0)
	if arg_21_0.coupletUnLock and not arg_21_0.coupletComplete then
		local var_21_0 = arg_21_0.coupletIds[arg_21_0.coupletIndex]
		local var_21_1 = arg_21_0.coupletDatas[arg_21_0.coupletIndex].repeated_jp

		for iter_21_0 = 1, #arg_21_0.coupletBottomWords do
			local var_21_2 = arg_21_0.coupletBottomWords[iter_21_0]
			local var_21_3 = false

			if var_21_2.index == var_21_2.swapIndex then
				var_21_3 = true
			else
				PLATFORM_CODE = var_10
				PLATFORM_JP = var_11

				if var_10 == var_11 and var_21_1 and #var_21_1 > 0 then
					for iter_21_1 = 1, #var_21_1 do
						local var_21_4 = var_21_1[iter_21_1]

						table = var_1_10015

						if var_1_10015.contains(var_21_4, var_21_2.index) then
							table = var_1_10015

							if var_1_10015.contains(var_21_4, var_21_2.swapIndex) then
								var_21_3 = true
							end
						end
					end
				end
			end

			if not var_21_3 then
				arg_21_0:showTips(var_0_20, true)

				return
			end
		end

		table = var_4

		if var_4.contains(arg_21_0.data1List, var_21_0) then
			table = var_4

			if not var_4.contains(arg_21_0.activity.data2_list, var_21_0) then
				local var_21_5
				local var_21_7

				if #arg_21_0.activity.data2_list == #arg_21_0.coupletIds - 1 then
					function var_21_5(arg_22_0)
						local var_22_0 = arg_21_0
						local var_22_1 = var_1.emit

						ActivityMediator = var_2_10003

						var_22_1(var_22_0, var_2_10003.NEXT_DISPLAY_AWARD, arg_22_0)

						local var_22_2 = arg_21_0

						var_1.finishAll(var_22_2)

						return
					end

					local var_21_6 = arg_21_0

					var_21_7 = arg_21_0.showTips
					i18n = iter_21_0

					var_21_7(var_21_6, iter_21_0(var_0_15), true)
				else
					arg_21_0:showTips(var_0_19, true)
				end

				pg = var_21_7

				local var_21_8 = var_21_7.m02
				local var_21_9 = var_5.sendNotification

				GAME = iter_21_0

				var_21_9(var_21_8, iter_21_0.MEMORYBOOK_UNLOCK, {
					id = var_21_0,
					actId = arg_21_0.activity.id,
					awardCallback = var_21_5
				})
			end
		end
	elseif not arg_21_0.coupletUnLock then
		-- block empty
	elseif arg_21_0.coupletComplete then
		-- block empty
	end

	return
end

function var_0_1.selectCoupletChange(arg_23_0)
	if arg_23_0.coupletIndex > var_0_2 then
		arg_23_0.coupletIndex = 1
	end

	if arg_23_0.coupletIndex <= 0 then
		arg_23_0.coupletIndex = var_0_2
	end

	local var_23_0 = arg_23_0.coupletIds[arg_23_0.coupletIndex]

	table = var_2

	local var_23_1

	if not var_2.contains(arg_23_0.data2List, var_23_0) then
		var_23_1 = false
	end

	arg_23_0.coupletComplete = var_23_1
	table = var_23_1

	local var_23_2

	if not var_23_1.contains(arg_23_0.data1List, var_23_0) then
		var_23_2 = false
	end

	arg_23_0.coupletUnLock = var_23_2

	if not arg_23_0.coupletUnLock then
		local var_23_3 = arg_23_0.btnConfirm

		var_2.GetComponent(var_23_3, "UIGrayScale").enabled = true

		local var_23_4 = arg_23_0.btnConfirm
		local var_23_5 = var_2.GetComponent(var_23_4, "Image")

		var_23_5.raycastTarget = false
		setActive = var_23_5

		var_23_5(arg_23_0.imgComplete, false)

		setActive = var_23_5

		var_23_5(arg_23_0.btnConfirm, true)
	elseif arg_23_0.coupletComplete then
		setActive = var_2

		var_2(arg_23_0.imgComplete, true)

		setActive = var_2

		var_2(arg_23_0.btnConfirm, false)
	else
		local var_23_6 = arg_23_0.btnConfirm

		var_2.GetComponent(var_23_6, "UIGrayScale").enabled = false

		local var_23_7 = arg_23_0.btnConfirm
		local var_23_8 = var_2.GetComponent(var_23_7, "Image")

		var_23_8.raycastTarget = true
		setActive = var_23_8

		var_23_8(arg_23_0.imgComplete, false)

		setActive = var_23_8

		var_23_8(arg_23_0.btnConfirm, true)
	end

	arg_23_0:updateCoupletWord()

	return
end

function var_0_1.updateCoupletWord(arg_24_0)
	GetSpriteFromAtlas = var_1_10001

	local var_24_0 = var_1_10001(var_0_8, "couplet_" .. arg_24_0.coupletIndex .. "_list")

	setImageSprite = var_2

	var_2(arg_24_0.coupletUpImg, var_24_0)

	setActive = var_2

	var_2(arg_24_0.coupletUpContents, arg_24_0.coupletUnLock)

	setActive = var_2

	var_2(arg_24_0.coupletUpLock, not arg_24_0.coupletUnLock)

	local var_24_1 = {}

	if not arg_24_0.coupletComplete then
		for iter_24_0 = 1, var_0_4 do
			table = var_1_10007

			var_1_10007.insert(var_24_1, iter_24_0)
		end
	end

	for iter_24_1 = 1, #arg_24_0.coupletBottomWords do
		local var_24_2 = arg_24_0.coupletBottomWords[iter_24_1]
		local var_24_3

		if #var_24_1 > 0 then
			table = var_9

			local var_24_4 = var_9.remove
			local var_24_5 = var_24_1

			math = var_1_10011
			var_24_3 = var_24_4(var_24_5, var_1_10011.random(1, #var_24_1))
		else
			var_24_3 = iter_24_1
		end

		var_24_2.swapIndex = var_24_3

		local var_24_6 = var_24_2.tf

		var_1_10011 = arg_24_0
		var_24_6.anchoredPosition = arg_24_0.getWordPosition(var_1_10011, var_24_3)
		setImageSprite = var_24_6
		findTF = var_10

		local var_24_7 = var_10(var_24_2.tf, "img")

		GetSpriteFromAtlas = var_1_10011

		var_24_6(var_24_7, var_1_10011(var_0_8, "couplet_" .. arg_24_0.coupletIndex .. "_" .. var_24_2.index), true)

		local var_24_8 = false

		var_1_10011 = arg_24_0.coupletDatas[arg_24_0.coupletIndex].repeated_jp

		local var_24_9

		if var_24_2.index == var_24_2.swapIndex then
			var_24_8 = var_24_2.index == var_24_2.swapIndex
		else
			PLATFORM_CODE = var_24_9
			PLATFORM_JP = var_13

			if var_24_9 == var_13 and var_1_10011 then
				var_24_9 = #var_1_10011

				if 0 < var_24_9 then
					for iter_24_2 = 1, #var_1_10011 do
						local var_24_10 = var_1_10011[iter_24_2]

						table = var_1_10017

						if var_1_10017.contains(var_24_10, var_24_2.index) then
							table = var_1_10017

							if var_1_10017.contains(var_24_10, var_24_2.swapIndex) then
								var_24_8 = true
							end
						end
					end
				end
			end
		end

		setActive = var_24_9
		findTF = var_13

		var_24_9(var_13(var_24_2.tf, "bgOn"), var_24_8)

		GetComponent = var_24_9
		findTF = var_13

		local var_24_11 = var_13(var_24_2.tf, "bgOn")

		typeof = var_14
		Image = var_15

		local var_24_12 = var_24_9(var_24_11, var_14(var_15))

		var_12.SetNativeSize(var_24_12)

		GetComponent = var_12
		findTF = var_24_12

		local var_24_13 = var_24_12(var_24_2.tf, "bgOff")

		typeof = var_14
		Image = var_15

		local var_24_14 = var_12(var_24_13, var_14(var_15))

		var_12.SetNativeSize(var_24_14)
	end

	setActive = var_3

	var_3(arg_24_0.coupletBottomContents, arg_24_0.coupletUnLock)

	setActive = var_3

	var_3(arg_24_0.coupletBottomLock, not arg_24_0.coupletUnLock)

	setText = var_3

	local var_24_15 = arg_24_0.countDesc

	i18n = var_5

	var_3(var_24_15, var_5(var_0_11, arg_24_0.coupletIndex))

	return
end

function var_0_1.addCoupletWordEvent(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.event
	local var_25_1 = arg_25_1.tf
	local var_25_2 = arg_25_1.parent

	var_25_0:AddBeginDragFunc(function(arg_26_0, arg_26_1)
		if arg_25_0.coupletUnLock and not arg_25_0.coupletComplete and not arg_25_0.swapWord then
			arg_25_0.swapWord = arg_25_1
		end

		return
	end)
	var_25_0:AddDragFunc(function(arg_27_0, arg_27_1)
		if arg_25_0.swapWord then
			var_2.y = arg_27_1.position.y

			local var_27_0 = arg_25_0._uiCamera
			local var_27_1 = var_3.ScreenToWorldPoint(var_27_0, var_2)
			local var_27_2 = arg_25_0

			if var_4.getWordByPosition(var_27_2, var_27_1) and arg_25_0.swapWord ~= var_4 then
				local var_27_3 = var_4.swapIndex

				var_4.swapIndex = arg_25_0.swapWord.swapIndex
				arg_25_0.swapWord.swapIndex = var_27_3

				local var_27_4 = arg_25_0

				var_6.tweenWord(var_27_4, arg_25_0.swapWord)

				local var_27_5 = arg_25_0

				var_6.tweenWord(var_27_5, var_4)
			end
		end

		return
	end)
	var_25_0:AddDragEndFunc(function(arg_28_0, arg_28_1)
		arg_25_0.swapWord = nil

		return
	end)

	return
end

function var_0_1.createWord(arg_29_0, arg_29_1, arg_29_2)
	tf = var_1_10003
	instantiate = var_1_10004

	local var_29_0 = var_1_10003(var_1_10004(arg_29_0.wordTpl))

	setParent = var_4

	var_4(var_29_0, arg_29_2)

	setActive = var_4

	var_4(var_29_0, true)

	var_29_0.anchoredPosition = arg_29_0:getWordPosition(arg_29_1)
	GetComponent = var_4

	local var_29_1 = var_29_0

	typeof = var_6
	EventTriggerListener = var_1_10007

	local var_29_2 = var_4(var_29_1, var_6(var_1_10007))

	return {
		tf = var_29_0,
		index = arg_29_1,
		swapIndex = arg_29_1,
		event = var_29_2,
		parent = arg_29_2
	}
end

function var_0_1.getWordByPosition(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.coupletBottomContents
	local var_30_1 = var_2.InverseTransformPoint(var_30_0, arg_30_1)

	math = var_30_0

	if var_30_0.abs(var_30_1.x) < var_0_5 / 2 then
		math = var_3

		local var_30_2 = var_3.floor

		math = var_4

		local var_30_3 = var_30_2(var_4.abs((var_30_1.y - var_0_6 / 2) / var_0_6)) + 1

		for iter_30_0 = 1, #arg_30_0.coupletBottomWords do
			if arg_30_0.coupletBottomWords[iter_30_0].swapIndex == var_30_3 then
				return arg_30_0.coupletBottomWords[iter_30_0]
			end
		end
	end

	return
end

function var_0_1.getWordPosition(arg_31_0, arg_31_1)
	local var_31_0 = (arg_31_1 - 1) % var_0_7

	math = var_3

	local var_31_1 = var_3.floor((arg_31_1 - 1) / var_0_7)

	Vector2 = var_4

	return var_4(var_31_0 * var_0_5, -var_31_1 * var_0_6)
end

function var_0_1.tweenWord(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.swapIndex
	local var_32_1 = arg_32_0
	local var_32_2 = arg_32_0.getWordPosition(var_32_1, var_32_0)

	LeanTween = var_32_1

	local var_32_3 = var_32_1.isTweening

	go = var_5

	local var_32_4

	if var_32_3(var_5(arg_32_1.tf)) then
		LeanTween = var_32_4
		var_32_4 = var_32_4.cancel
		go = var_5

		var_32_4(var_5(arg_32_1.tf))
	end

	LeanTween = var_32_4

	local var_32_5 = var_32_4.value

	go = var_5

	local var_32_6 = var_32_5(var_5(arg_32_1.tf), arg_32_1.tf.anchoredPosition.y, var_32_2.y, 0.1)
	local var_32_7 = var_4.setOnUpdate

	System = var_6

	local var_32_8 = var_32_7(var_32_6, var_6.Action_float(function(arg_33_0)
		local var_33_0 = arg_32_1.tf

		Vector2 = var_2_10002
		var_33_0.anchoredPosition = var_2_10002(arg_32_1.tf.anchoredPosition.x, arg_33_0)

		return
	end))
	local var_32_9 = var_4.setOnComplete

	System = var_6

	var_32_9(var_32_8, var_6.Action(function()
		local var_34_0 = false
		local var_34_1 = arg_32_0.coupletDatas[arg_32_0.coupletIndex].repeated_jp
		local var_34_2

		if arg_32_1.index == arg_32_1.swapIndex then
			var_34_0 = arg_32_1.index == arg_32_1.swapIndex
		else
			PLATFORM_CODE = var_34_2
			PLATFORM_JP = var_4

			if var_34_2 == var_4 and var_34_1 then
				var_34_2 = #var_34_1

				if 0 < var_34_2 then
					for iter_34_0 = 1, #var_34_1 do
						local var_34_3 = var_34_1[iter_34_0]

						table = var_2_10008

						if var_2_10008.contains(var_34_3, arg_32_1.index) then
							table = var_2_10008

							if var_2_10008.contains(var_34_3, arg_32_1.swapIndex) then
								var_34_0 = true
							end
						end
					end
				end
			end
		end

		setActive = var_34_2
		findTF = var_4

		var_34_2(var_4(arg_32_1.tf, "bgOn"), var_34_0)

		return
	end))

	return
end

function var_0_1.clearTween(arg_35_0)
	for iter_35_0 = 1, #arg_35_0.coupletBottomWords do
		local var_35_0 = arg_35_0.coupletBottomWords[iter_35_0]

		LeanTween = var_1_10006
		var_1_10006 = var_1_10006.isTweening
		go = var_1_10007

		if var_1_10006(var_1_10007(var_35_0.tf)) then
			LeanTween = var_1_10006
			var_1_10006 = var_1_10006.cancel
			go = var_1_10007

			var_1_10006(var_1_10007(var_35_0.tf))
		end
	end

	return
end

function var_0_1.showTips(arg_36_0, arg_36_1, arg_36_2)
	type = var_1_10003

	local var_36_0

	if var_1_10003(arg_36_1) == "table" then
		if arg_36_1 then
			var_36_0 = #arg_36_1

			if 0 < var_36_0 then
				Time = var_36_0
				arg_36_0.tipTime = var_36_0.realtimeSinceStartup
				i18n = var_36_0
				math = var_4
				var_36_0 = var_36_0(arg_36_1[var_4.random(1, #arg_36_1)])
				setText = var_4
				findTF = var_5

				var_4(var_5(arg_36_0.charTip, "text"), var_36_0)

				setActive = var_4

				var_4(arg_36_0.charTip, false)

				setActive = var_4

				var_4(arg_36_0.charTip, true)
			end
		end
	else
		Time = var_36_0
		arg_36_0.tipTime = var_36_0.realtimeSinceStartup
		setText = var_3
		findTF = var_4

		var_3(var_4(arg_36_0.charTip, "text"), arg_36_1)

		setActive = var_3

		var_3(arg_36_0.charTip, false)

		setActive = var_3

		var_3(arg_36_0.charTip, true)
	end

	return
end

function var_0_1.OnDestroy(arg_37_0)
	if arg_37_0.timer then
		local var_37_0 = arg_37_0.timer

		var_1.Stop(var_37_0)

		arg_37_0.timer = nil
	end

	if arg_37_0.model then
		PoolMgr = var_1

		local var_37_1 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_37_1, 502011, arg_37_0.model)
	end

	arg_37_0:clearTween()

	return
end

return var_0_1
