class = var_0_10000

local var_0_0 = "LinerSignPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002
	var_1_10001 = var_1_10001 == var_1_10002 and var_1_10001
	arg_1_0.lockNamed = var_1_10001

	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.signTF = var_1.Find(var_1_1, "sign")

	local var_1_2 = arg_1_0.signTF

	arg_1_0.items = var_1.Find(var_1_2, "items")
	UIItemList = var_1

	local var_1_3 = var_1.New
	local var_1_4 = arg_1_0.items
	local var_1_5 = arg_1_0.items

	arg_1_0.uilist = var_1_3(var_1_4, var_3.Find(var_1_5, "tpl"))

	local var_1_6 = arg_1_0.signTF

	arg_1_0.signBtn = var_1.Find(var_1_6, "get")

	local var_1_7 = arg_1_0.signTF

	arg_1_0.signGreyBtn = var_1.Find(var_1_7, "get_grey")

	local var_1_8 = arg_1_0.signTF

	arg_1_0.countText = var_1.Find(var_1_8, "count_bg/count")

	local var_1_9 = arg_1_0.bg

	arg_1_0.namedTF = var_1.Find(var_1_9, "named")

	local var_1_10 = arg_1_0.namedTF

	arg_1_0.nameInput = var_1.Find(var_1_10, "input/nickname")

	local var_1_11 = arg_1_0.namedTF

	arg_1_0.sureBtn = var_1.Find(var_1_11, "sure")

	local var_1_12 = arg_1_0.bg

	arg_1_0.linerTF = var_1.Find(var_1_12, "liner")

	local var_1_13 = arg_1_0.linerTF

	arg_1_0.linerInput = var_1.Find(var_1_13, "name/input")

	local var_1_14 = arg_1_0.linerTF

	arg_1_0.linerBtn = var_1.Find(var_1_14, "go")
	setText = var_1

	local var_1_15 = arg_1_0.linerBtn
	local var_1_16 = var_2.Find(var_1_15, "lock/Text")

	i18n = var_1_15

	var_1(var_1_16, var_1_15("liner_sign_unlock_tip"))

	local var_1_17 = arg_1_0.nameInput
	local var_1_18 = var_1.GetComponent

	typeof = var_3
	InputField = var_4

	local var_1_19 = var_1_18(var_1_17, var_3(var_4))

	var_1_19.interactable = not arg_1_0.lockNamed
	setActive = var_1_19

	local var_1_20 = arg_1_0.namedTF

	var_1_19(var_2.Find(var_1_20, "input/pan"), not arg_1_0.lockNamed)

	local var_1_21 = arg_1_0.linerInput
	local var_1_22 = var_1.GetComponent

	typeof = var_3
	InputField = var_4

	local var_1_23 = var_1_22(var_1_21, var_3(var_4))

	var_1_23.interactable = not arg_1_0.lockNamed
	setActive = var_1_23

	local var_1_24 = arg_1_0.linerTF

	var_1_23(var_2.Find(var_1_24, "name/edit"), not arg_1_0.lockNamed)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	getProxy = var_1
	TaskProxy = var_1_10002
	arg_2_0.taskProxy = var_1(var_1_10002)
	underscore = var_1

	local var_2_0 = var_1.flatten
	local var_2_1 = arg_2_0.activity

	arg_2_0.taskGroup = var_2_0(var_2.getConfig(var_2_1, "config_data"))
	pg = var_1
	arg_2_0.taskConfig = var_1.task_data_template

	local var_2_2 = arg_2_0.activity

	arg_2_0.preStory = var_1.getConfig(var_2_2, "config_client").preStory
	updateActivityTaskStatus = var_1

	return var_1(arg_2_0.activity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.uilist

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		local var_4_0

		if arg_4_0 == var_2_10003.EventInit then
			var_4_0 = arg_4_1 + 1

			local var_4_1 = arg_3_0.taskGroup[var_4_0]
			local var_4_2 = arg_4_2
			local var_4_3 = arg_4_2.Find(var_4_2, "item_mask/item")

			Drop = var_4_2

			local var_4_4 = var_4_2.Create(arg_3_0.taskConfig[var_4_1].award_display[1])

			updateDrop = var_7

			var_7(var_4_3, var_4_4)

			onButton = var_7

			local var_4_5 = arg_3_0
			local var_4_6 = arg_4_2

			local function var_4_7()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10002

				var_5_1(var_5_0, var_3_10002.ON_DROP, var_4_4)

				return
			end

			SFX_PANEL = var_2_10011

			var_7(var_4_5, var_4_6, var_4_7, var_2_10011)

			GetImageSpriteFromAtlasAsync = var_7

			var_7("ui/activityuipage/linersignpage_atlas", "D" .. var_4_0, arg_4_2:Find("day"), true)
		else
			UIItemList = var_4_0

			if arg_4_0 == var_4_0.EventUpdate then
				local var_4_8 = arg_4_1 + 1
				local var_4_9 = arg_3_0.taskGroup[var_4_8]
				local var_4_10 = arg_3_0.taskProxy
				local var_4_11

				if not var_5.getTaskById(var_4_10, var_4_9) then
					var_4_10 = arg_3_0.taskProxy
					var_4_11 = var_5.getFinishTaskById(var_4_10, var_4_9)
				end

				setActive = var_4_10

				var_4_10(arg_4_2:Find("cur"), var_4_8 == arg_3_0.nday)

				setActive = var_4_10

				var_4_10(arg_4_2:Find("got"), var_4_8 < arg_3_0.nday or var_4_11 and var_4_11:getTaskStatus() == 2)
			end
		end

		return
	end)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.signBtn

	local function var_3_3()
		if not arg_3_0.remainCnt or arg_3_0.remainCnt <= 0 then
			return
		end

		seriesAsync = var_0

		var_0({
			function(arg_7_0)
				local var_7_0 = arg_3_0.activity
				local var_7_1 = var_1.getConfig(var_7_0, "config_client").story

				checkExist = var_7_0

				if var_7_0(var_7_1, {
					arg_3_0.nday
				}, {
					1
				}) then
					pg = var_2

					local var_7_2 = var_2.NewStoryMgr.GetInstance()

					var_2.Play(var_7_2, var_7_1[arg_3_0.nday][1], arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				local var_8_0 = arg_3_0.curTaskVO

				if var_1.getTaskStatus(var_8_0) == 1 then
					local var_8_1 = arg_3_0
					local var_8_2 = var_1.emit

					ActivityMediator = var_3_10003

					var_8_2(var_8_1, var_3_10003.ON_TASK_SUBMIT, arg_3_0.curTaskVO, arg_8_0)
				else
					arg_8_0()
				end

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_1, var_3_2, var_3_3, var_1_10005)

	getProxy = var_1
	PlayerProxy = var_3_1

	local var_3_4 = var_1(var_3_1)
	local var_3_5 = var_1.getRawData(var_3_4)

	arg_3_0.defaultName = var_1.GetName(var_3_5)
	setInputText = var_1

	var_1(arg_3_0.nameInput, arg_3_0.defaultName)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.sureBtn

	local function var_3_8()
		getInputText = var_2_10000

		if var_2_10000(arg_3_0.nameInput) == "" then
			return
		end

		if var_0 ~= arg_3_0.defaultName then
			nameValidityCheck = var_1

			if not var_1(var_0, 4, 14, {
				"spece_illegal_tip",
				"login_newPlayerScene_name_tooShort",
				"login_newPlayerScene_name_tooLong",
				"login_newPlayerScene_invalideName"
			}) then
				return
			end
		end

		local var_9_0 = arg_3_0
		local var_9_1 = var_1.emit

		ActivityMediator = var_2_10003

		local var_9_2 = var_2_10003.STORE_DATE
		local var_9_3 = {}

		ActivityConst = var_2_10005
		var_9_3.actId = var_2_10005.LINER_NAMED_ID
		var_9_3.strValue = var_0

		function var_9_3.callback()
			local var_10_0 = arg_3_0

			var_0.OnUpdateFlush(var_10_0)

			return
		end

		var_9_1(var_9_0, var_9_2, var_9_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	onInputEndEdit = var_1

	var_1(arg_3_0, arg_3_0.linerInput, function(arg_11_0)
		local var_11_0 = arg_3_0

		if not var_1.IsNamed(var_11_0) then
			return
		end

		if arg_11_0 ~= arg_3_0.defaultName then
			nameValidityCheck = var_1

			if not var_1(arg_11_0, 4, 14, {
				"spece_illegal_tip",
				"login_newPlayerScene_name_tooShort",
				"login_newPlayerScene_name_tooLong",
				"login_newPlayerScene_invalideName"
			}) then
				setInputText = var_1

				var_1(arg_3_0.linerInput, arg_3_0.lastName)

				do return end

				goto label_11_0
			end
		end

		do
			local var_11_1 = arg_3_0
			local var_11_2 = var_1.emit

			ActivityMediator = var_2_10003

			local var_11_3 = var_2_10003.STORE_DATE
			local var_11_4 = {}

			ActivityConst = var_2_10005
			var_11_4.actId = var_2_10005.LINER_NAMED_ID
			var_11_4.strValue = arg_11_0

			function var_11_4.callback()
				pg = var_3_10000

				local var_12_0 = var_3_10000.TipsMgr.GetInstance()
				local var_12_1 = var_0.ShowTips

				i18n = var_3_10002

				var_12_1(var_12_0, var_3_10002("liner_name_modify"))

				local var_12_2 = arg_3_0

				var_0.OnUpdateFlush(var_12_2)

				return
			end

			var_11_2(var_11_1, var_11_3, var_11_4)
		end

		::label_11_0::

		return
	end)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.linerBtn

	local function var_3_11()
		local var_13_0 = arg_3_0

		if var_0.IsLockLiner(var_13_0) then
			return
		end

		seriesAsync = var_0

		var_0({
			function(arg_14_0)
				if arg_3_0.preStory and arg_3_0.preStory ~= "" then
					pg = var_1

					local var_14_0 = var_1.NewStoryMgr.GetInstance()

					if not var_1.IsPlayed(var_14_0, arg_3_0.preStory) then
						pg = var_1

						local var_14_1 = var_1.NewStoryMgr.GetInstance()

						var_1.Play(var_14_1, arg_3_0.preStory, arg_14_0)

						goto label_14_0
					end
				end

				arg_14_0()

				::label_14_0::

				return
			end
		}, function()
			local var_15_0 = arg_3_0
			local var_15_1 = var_0.emit

			ActivityMediator = var_3_10002

			local var_15_2 = var_3_10002.EVENT_GO_SCENE

			SCENE = var_3_10003

			var_15_1(var_15_0, var_15_2, var_3_10003.LINER)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_16_0)
	arg_16_0.nday = arg_16_0.activity.data3

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.IsFinishSign(var_16_0)

	setActive = var_16_0

	var_16_0(arg_16_0.signTF, not var_16_1)

	setActive = var_16_0

	var_16_0(arg_16_0.namedTF, var_16_1 and not arg_16_0:IsNamed())

	setActive = var_16_0

	var_16_0(arg_16_0.linerTF, var_16_1 and arg_16_0:IsNamed())

	setActive = var_16_0

	local var_16_2 = arg_16_0.linerBtn

	var_16_0(var_3.Find(var_16_2, "lock"), arg_16_0:IsLockLiner())

	local var_16_3, var_16_4

	if not var_16_1 then
		var_16_0 = arg_16_0.taskGroup[arg_16_0.nday]
		var_16_3 = arg_16_0.taskProxy

		if not var_16_4.getTaskById(var_16_3, var_16_0) then
			var_16_3 = arg_16_0.taskProxy
			var_16_4 = var_16_4.getFinishTaskById(var_16_3, var_16_0)
		end

		arg_16_0.curTaskVO = var_16_4
		math = var_16_4
		var_16_4 = var_16_4.min

		local var_16_5 = arg_16_0.activity

		arg_16_0.remainCnt = var_16_4(var_16_3.getDayIndex(var_16_5), #arg_16_0.taskGroup) - arg_16_0.nday

		local var_16_6 = arg_16_0.curTaskVO

		if var_16_3.getTaskStatus(var_16_6) == 1 then
			arg_16_0.remainCnt = arg_16_0.remainCnt + 1
		end

		setActive = var_16_3

		var_16_3(arg_16_0.signBtn, arg_16_0.remainCnt > 0)

		setActive = var_16_3

		var_16_3(arg_16_0.signGreyBtn, arg_16_0.remainCnt <= 0)

		setText = var_16_3

		local var_16_7 = arg_16_0.countText

		i18n = var_6

		var_16_3(var_16_7, var_6("liner_sign_cnt_tip") .. arg_16_0.remainCnt)

		local var_16_8 = arg_16_0.uilist

		var_16_3.align(var_16_8, #arg_16_0.taskGroup)
	else
		getProxy = var_16_0
		ActivityProxy = var_16_4

		local var_16_9 = var_16_0(var_16_4)
		local var_16_10 = var_2.getActivityById

		ActivityConst = var_16_3

		local var_16_11 = var_16_10(var_16_9, var_16_3.LINER_NAMED_ID)

		arg_16_0.lastName = var_2.getStrData1(var_16_11)
		setInputText = var_3

		var_3(arg_16_0.linerInput, arg_16_0.lastName)
	end

	return
end

function var_0_1.IsFinishSign(arg_17_0)
	local var_17_0 = arg_17_0.taskGroup[#arg_17_0.taskGroup]
	local var_17_1 = arg_17_0.taskProxy
	local var_17_3

	if not var_2.getTaskById(var_17_1, var_17_0) then
		local var_17_2 = arg_17_0.taskProxy

		var_17_3 = var_2.getFinishTaskById(var_17_2, var_17_0)
	end

	return var_17_3 and var_17_3:getTaskStatus() == 2
end

function var_0_1.IsNamed(arg_18_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_18_0 = var_1_10001(var_1_10002)
	local var_18_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_18_2

	var_18_2 = var_18_1(var_18_0, var_1_10003.LINER_NAMED_ID) and not var_1:isEnd() and var_1:getStrData1() ~= ""

	return var_18_2
end

function var_0_1.IsLockLiner(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)
	local var_19_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	return not var_19_1(var_19_0, var_1_10003.LINER_ID) or var_1:isEnd()
end

return var_0_1
