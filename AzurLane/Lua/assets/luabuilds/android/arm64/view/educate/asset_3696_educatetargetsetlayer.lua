class = var_0_10000

local var_0_0 = "EducateTargetSetLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateTargetSetUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	arg_3_0:initTargetList()

	arg_3_0.selectedIndex = 1

	return
end

function var_0_1.initTargetList(arg_4_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.GetCharData(var_4_0)

	arg_4_0.maxAttrId = var_2.GetAttrSortIds(var_4_1)[1]

	local var_4_2 = var_2:GetStage()
	local var_4_3 = var_1:GetTaskProxy()
	local var_4_4 = var_4.GetTargetId(var_4_3) == 0 and 1 or var_4_2 + 1
	local var_4_5 = var_1:GetPersonalityId()
	local var_4_6 = {}
	local var_4_7 = {}

	ipairs = var_1_10009
	pg = var_1_10011

	for iter_4_0, iter_4_1 in var_1_10009(var_1_10011.child_target_set.all) do
		pg = var_1_10014

		if var_1_10014.child_target_set[iter_4_1].stage == var_4_4 then
			pg = var_1_10014

			if var_1_10014.child_target_set[iter_4_1].condition == "" or #var_1_10014 == 0 then
				table = var_1_10015

				var_1_10015.insert(var_4_6, iter_4_1)
			elseif var_4_5 == var_1_10014[2][1] then
				table = var_1_10015

				var_1_10015.insert(var_4_7, iter_4_1)
			end
		end
	end

	table = var_9

	local var_4_8 = var_9.sort
	local var_4_9 = var_4_7

	CompareFuncs = iter_4_0

	var_4_8(var_4_9, iter_4_0({
		function(arg_5_0)
			pg = var_2_10001

			local var_5_0 = var_2_10001.child_target_set[arg_5_0].condition[1][1]
			local var_5_1 = var_0

			return -var_3.GetAttrById(var_5_1, var_5_0)
		end,
		function(arg_6_0)
			return arg_6_0
		end
	}))

	local var_4_10 = 0

	arg_4_0.targetList = {}
	ipairs = var_10

	for iter_4_2, iter_4_3 in var_10(var_4_7) do
		table = var_15

		var_15.insert(arg_4_0.targetList, iter_4_3)

		if var_4_10 + 1 == 4 then
			break
		end
	end

	if var_4_10 < 4 then
		ipairs = var_10

		for iter_4_4, iter_4_5 in var_10(var_4_6) do
			table = var_15

			var_15.insert(arg_4_0.targetList, iter_4_5)

			if var_4_10 + 1 == 4 then
				break
			end
		end
	end

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.windowTF = var_1.Find(var_7_0, "anim_root/window")

	local var_7_1 = arg_7_0.windowTF

	arg_7_0.targetContent = var_1.Find(var_7_1, "content")

	local var_7_2 = arg_7_0.targetContent

	arg_7_0.targetTpl = var_1.Find(var_7_2, "tpl")
	setActive = var_1

	var_1(arg_7_0.targetTpl, false)

	local var_7_3 = arg_7_0.windowTF

	arg_7_0.sureBtn = var_1.Find(var_7_3, "sure_btn")
	setText = var_1

	local var_7_4 = arg_7_0.sureBtn
	local var_7_5 = var_3.Find(var_7_4, "Text")

	i18n = var_4

	var_1(var_7_5, var_4("word_ok"))

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.sureBtn

	local function var_8_2()
		local var_9_0 = arg_8_0.targetList[arg_8_0.selectedIndex]

		pg = var_1

		local var_9_1 = var_1.child_target_set[var_9_0].recommend_attr2

		pg = var_2_10002

		local var_9_2 = var_2_10002.child_attr[var_9_1].name
		local var_9_3 = arg_8_0
		local var_9_4 = var_3.emit

		EducateBaseUI = var_2_10006

		local var_9_5 = var_2_10006.EDUCATE_ON_MSG_TIP
		local var_9_6 = {}

		i18n = var_2_10008
		var_9_6.content = var_2_10008("child_target_set_sure_tip", var_9_2)

		function var_9_6.onYes()
			local var_10_0 = arg_8_0
			local var_10_1 = var_0.emit

			EducateTargetSetMediator = var_3_10003

			var_10_1(var_10_0, var_3_10003.ON_TARGET_SET, {
				open = true,
				id = var_9_0
			})

			local var_10_2 = arg_8_0._tf
			local var_10_3 = var_0.Find(var_10_2, "anim_root")
			local var_10_4 = var_0.GetComponent

			typeof = var_3
			Animation = var_5

			local var_10_5 = var_10_4(var_10_3, var_3(var_5))
			local var_10_6 = arg_8_0._tf
			local var_10_7 = var_1.Find(var_10_6, "anim_root")
			local var_10_8 = var_1.GetComponent

			typeof = var_4
			DftAniEvent = var_3_10006

			local var_10_9 = var_10_8(var_10_7, var_4(var_3_10006))

			var_1.SetEndEvent(var_10_9, function()
				local var_11_0 = var_0

				var_0.SetEndEvent(var_11_0, nil)

				local var_11_1 = arg_8_0

				var_0.emit(var_11_1, var_0_1.ON_CLOSE)

				return
			end)
			var_10_5:Play("anim_educate_targetset_out")

			return
		end

		var_9_4(var_9_3, var_9_5, var_9_6)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	return
end

function var_0_1.didEnter(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_12_0, arg_12_0._tf)
	arg_12_0:initTarget()

	return
end

function var_0_1.initTarget(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.targetList do
		cloneTplTo = var_1_10005

		local var_13_0 = arg_13_0.targetTpl
		local var_13_1 = arg_13_0.targetContent

		tostring = var_1_10009
		var_1_10005 = var_1_10005(var_13_0, var_13_1, var_1_10009(iter_13_0))
		var_1_10006 = arg_13_0.targetList[iter_13_0]
		setImageSprite = var_13_0
		var_1_10009 = var_1_10005:Find("animroot/icon/Image")
		LoadSprite = var_1_10010

		local var_13_2 = "educatetarget/"

		pg = var_1_10013

		var_13_0(var_1_10009, var_1_10010(var_13_2 .. var_1_10013.child_target_set[var_1_10006].icon), true)

		setImageSprite = var_13_0
		var_1_10009 = var_1_10005:Find("animroot/name")
		LoadSprite = var_1_10010

		local var_13_3 = "educatetarget/"

		pg = var_1_10013

		var_13_0(var_1_10009, var_1_10010(var_13_3 .. var_1_10013.child_target_set[var_1_10006].pic), true)

		onButton = var_13_0
		var_1_10009 = arg_13_0
		var_1_10010 = var_1_10005

		local function var_13_4()
			if arg_13_0.selectedIndex == iter_13_0 then
				return
			end

			arg_13_0.selectedIndex = iter_13_0

			local var_14_0 = arg_13_0

			var_0.updateTarget(var_14_0)

			return
		end

		SFX_PANEL = var_12

		var_13_0(var_1_10009, var_1_10010, var_13_4, var_12)

		pg = var_13_0

		local var_13_5 = var_13_0.child_target_set[var_1_10006].recommend_attr

		setActive = var_13_1

		var_13_1(var_1_10005:Find("animroot/recommand"), var_13_5 == arg_13_0.maxAttrId)
	end

	arg_13_0:updateTarget()

	local var_13_6 = {}

	table = var_2

	var_2.insert(var_13_6, function(arg_15_0)
		onDelayTick = var_2_10001

		var_2_10001(function()
			arg_15_0()

			return
		end, 0.066)

		return
	end)

	for iter_13_1 = 1, #arg_13_0.targetList do
		table = var_1_10006

		var_1_10006.insert(var_13_6, function(arg_17_0)
			local var_17_0 = arg_13_0.targetContent
			local var_17_1 = var_1.Find

			tostring = var_2_10004

			local var_17_2 = var_17_1(var_17_0, var_2_10004(iter_13_1))
			local var_17_3 = var_1.GetComponent

			typeof = var_2_10005
			Animation = var_2_10007

			local var_17_4 = var_17_3(var_17_2, var_2_10005(var_2_10007))

			var_2.Play(var_17_4, "anim_educate_targetset_tpl_in")

			onDelayTick = var_3

			var_3(function()
				arg_17_0()

				return
			end, 0.066)

			return
		end)
	end

	seriesAsync = var_2

	var_2(var_13_6, function()
		return
	end)

	return
end

function var_0_1.updateTarget(arg_20_0)
	eachChild = var_1_10001

	var_1_10001(arg_20_0.targetContent, function(arg_21_0)
		setActive = var_2_10001

		local var_21_0 = arg_21_0
		local var_21_1 = arg_21_0.Find(var_21_0, "animroot/selected")
		local var_21_2 = arg_20_0.selectedIndex

		tonumber = var_21_0

		var_2_10001(var_21_1, var_21_2 == var_21_0(arg_21_0.name))

		return
	end)

	return
end

function var_0_1.willExit(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_22_0, arg_22_0._tf)

	return
end

function var_0_1.onBackPressed(arg_23_0)
	return
end

return var_0_1
