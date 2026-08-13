class = var_0_10000

local var_0_0 = "CygnetBathrobePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

var_0_1.MAX_COUNT = 7

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.drawBtn = var_1.Find(var_1_0, "DrawBtn")

	local var_1_1 = arg_1_0._tf

	arg_1_0.resultTF = var_1.Find(var_1_1, "ResultImg")

	local var_1_2 = arg_1_0.resultTF

	arg_1_0.resultImgLittle = var_1.Find(var_1_2, "Little")

	local var_1_3 = arg_1_0.resultTF

	arg_1_0.resultImgMiddle = var_1.Find(var_1_3, "Middle")

	local var_1_4 = arg_1_0.resultTF

	arg_1_0.resultImgBig = var_1.Find(var_1_4, "Big")

	local var_1_5 = arg_1_0._tf

	arg_1_0.progressTF = var_1.Find(var_1_5, "Progress")

	local var_1_6 = arg_1_0._tf

	arg_1_0.progressText = var_1.Find(var_1_6, "Progress/ProgressText")

	local var_1_7 = arg_1_0._tf

	arg_1_0.gotImg = var_1.Find(var_1_7, "GotImg")

	local var_1_8 = arg_1_0._tf

	arg_1_0.awardPanel = var_1.Find(var_1_8, "AwardPanel")

	local var_1_9 = arg_1_0.awardPanel

	arg_1_0.itemTpl = var_1.Find(var_1_9, "itemTpl")

	local var_1_10 = arg_1_0.awardPanel

	arg_1_0.resultTextTF = var_1.Find(var_1_10, "ResultImg")

	local var_1_11 = arg_1_0.awardPanel

	arg_1_0.resultTextLittle = var_1.Find(var_1_11, "ResultImg/Little")

	local var_1_12 = arg_1_0.awardPanel

	arg_1_0.resultTextMiddle = var_1.Find(var_1_12, "ResultImg/Middle")

	local var_1_13 = arg_1_0.awardPanel

	arg_1_0.resultTextBig = var_1.Find(var_1_13, "ResultImg/Big")

	local var_1_14 = arg_1_0.awardPanel

	arg_1_0.itemTplContainer = var_1.Find(var_1_14, "AwardList")

	local var_1_15 = arg_1_0._tf

	arg_1_0.animTF = var_1.Find(var_1_15, "Anim")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.progressNum = arg_2_0.activity.data1
	arg_2_0.resultNum = arg_2_0.activity.data2
	arg_2_0.awardDayList = arg_2_0.activity.data1_list
	arg_2_0.isFinished = arg_2_0.progressNum > var_0_1.MAX_COUNT
	arg_2_0.isAvailable = not (arg_2_0.resultNum > 0)

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.drawBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.activity.id
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.drawBtn, arg_5_0.isAvailable)

	setActive = var_1_10001

	var_1_10001(arg_5_0.resultTF, not arg_5_0.isAvailable)

	if not arg_5_0.isAvailable then
		for iter_5_0 = 1, arg_5_0.resultTF.childCount do
			setActive = var_1_10005

			local var_5_0 = arg_5_0.resultTF

			var_1_10005(var_7.GetChild(var_5_0, iter_5_0 - 1), iter_5_0 == arg_5_0.resultNum)
		end
	end

	setActive = var_1

	var_1(arg_5_0.progressTF, not arg_5_0.isFinished)

	setActive = var_1

	var_1(arg_5_0.gotImg, arg_5_0.isFinished)

	if not arg_5_0.isFinished then
		setText = var_1

		var_1(arg_5_0.progressText, arg_5_0.progressNum .. "/" .. var_0_1.MAX_COUNT)
	end

	local var_5_1 = arg_5_0.activity

	if var_1.getConfig(var_5_1, "config_data")[2] then
		_ = var_1_10002

		local var_5_2 = var_1_10002.filter(var_1, function(arg_6_0)
			ipairs = var_2_10001

			for iter_6_0, iter_6_1 in var_2_10001(arg_5_0.activity.data1_list) do
				if iter_6_1 == arg_6_0[1] then
					return false
				end
			end

			return true
		end)

		ipairs = var_2

		for iter_5_1, iter_5_2 in var_2(var_5_2) do
			if arg_5_0.progressNum == iter_5_2[1] then
				local var_5_3 = arg_5_0
				local var_5_4 = arg_5_0.emit

				ActivityMediator = var_1_10010

				var_5_4(var_5_3, var_1_10010.EVENT_OPERATION, {
					cmd = 2,
					activity_id = arg_5_0.activity.id,
					arg1 = iter_5_2[1]
				})

				return
			end
		end
	end

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

function var_0_1.showLotteryAwardResult(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	GetComponent = var_1_10004

	local var_8_0 = arg_8_0.animTF

	typeof = var_1_10007
	DftAniEvent = var_1_10009

	local var_8_1 = var_1_10004(var_8_0, var_1_10007(var_1_10009))

	var_4.SetEndEvent(var_8_1, function(arg_9_0)
		setActive = var_2_10001

		var_2_10001(arg_8_0.animTF, false)

		setActive = var_2_10001

		var_2_10001(arg_8_0.awardPanel, true)

		for iter_9_0 = 1, arg_8_0.resultTextTF.childCount do
			setActive = var_2_10005

			local var_9_0 = arg_8_0.resultTextTF

			var_2_10005(var_7.GetChild(var_9_0, iter_9_0 - 1), iter_9_0 == arg_8_2)
		end

		removeAllChildren = var_1

		var_1(arg_8_0.itemTplContainer)

		ipairs = var_1

		for iter_9_1, iter_9_2 in var_1(arg_8_1) do
			cloneTplTo = var_2_10006
			var_2_10006 = var_2_10006(arg_8_0.itemTpl, arg_8_0.itemTplContainer)

			local var_9_1 = {
				type = iter_9_2.type,
				id = iter_9_2.id,
				count = iter_9_2.count
			}

			updateDrop = var_8

			var_8(var_2_10006, var_9_1)

			onButton = var_8

			local var_9_2 = arg_8_0
			local var_9_3 = var_2_10006

			local function var_9_4()
				local var_10_0 = arg_8_0
				local var_10_1 = var_0.emit

				BaseUI = var_3_10003

				var_10_1(var_10_0, var_3_10003.ON_DROP, var_9_1)

				return
			end

			SFX_PANEL = var_2_10013

			var_8(var_9_2, var_9_3, var_9_4, var_2_10013)
		end

		local var_9_5 = arg_8_0
		local var_9_6 = var_1.emit

		ActivityMainScene = iter_9_1

		var_9_6(var_9_5, iter_9_1.LOCK_ACT_MAIN, false)
		arg_8_3()

		onButton = var_1

		var_1(arg_8_0, arg_8_0.awardPanel, function()
			setActive = var_3_10000

			var_3_10000(arg_8_0.awardPanel, false)

			return
		end)

		return
	end)

	setActive = var_5

	var_5(arg_8_0.animTF, true)

	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.emit

	ActivityMainScene = var_8

	var_8_3(var_8_2, var_8.LOCK_ACT_MAIN, true)

	return
end

function var_0_1.IsTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_12_0 = var_1_10000(var_1_10002)
	local var_12_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	if var_12_1(var_12_0, var_1_10003.CYGNET_BATHROBE_PAGE_ID) and not var_0:isEnd() then
		return var_0.data2 <= 0
	end

	return
end

return var_0_1
