local var_0_0 = class("CygnetBathrobePage", import("...base.BaseActivityPage"))

var_0_0.MAX_COUNT = 7

function var_0_0.OnInit(arg_1_0)
	arg_1_0.drawBtn = arg_1_0._tf:Find("DrawBtn")
	arg_1_0.resultTF = arg_1_0._tf:Find("ResultImg")
	arg_1_0.resultImgLittle = arg_1_0.resultTF:Find("Little")
	arg_1_0.resultImgMiddle = arg_1_0.resultTF:Find("Middle")
	arg_1_0.resultImgBig = arg_1_0.resultTF:Find("Big")
	arg_1_0.progressTF = arg_1_0._tf:Find("Progress")
	arg_1_0.progressText = arg_1_0._tf:Find("Progress/ProgressText")
	arg_1_0.gotImg = arg_1_0._tf:Find("GotImg")
	arg_1_0.awardPanel = arg_1_0._tf:Find("AwardPanel")
	arg_1_0.itemTpl = arg_1_0.awardPanel:Find("itemTpl")
	arg_1_0.resultTextTF = arg_1_0.awardPanel:Find("ResultImg")
	arg_1_0.resultTextLittle = arg_1_0.awardPanel:Find("ResultImg/Little")
	arg_1_0.resultTextMiddle = arg_1_0.awardPanel:Find("ResultImg/Middle")
	arg_1_0.resultTextBig = arg_1_0.awardPanel:Find("ResultImg/Big")
	arg_1_0.itemTplContainer = arg_1_0.awardPanel:Find("AwardList")
	arg_1_0.animTF = arg_1_0._tf:Find("Anim")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.progressNum = arg_2_0.activity.data1
	arg_2_0.resultNum = arg_2_0.activity.data2
	arg_2_0.awardDayList = arg_2_0.activity.data1_list
	arg_2_0.isFinished = arg_2_0.progressNum > var_0_0.MAX_COUNT
	arg_2_0.isAvailable = arg_2_0.resultNum <= 0

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.drawBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.activity.id
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	setActive(arg_5_0.drawBtn, arg_5_0.isAvailable)
	setActive(arg_5_0.resultTF, not arg_5_0.isAvailable)

	if not arg_5_0.isAvailable then
		for iter_5_0 = 1, arg_5_0.resultTF.childCount do
			setActive(arg_5_0.resultTF:GetChild(iter_5_0 - 1), iter_5_0 == arg_5_0.resultNum)
		end
	end

	setActive(arg_5_0.progressTF, not arg_5_0.isFinished)
	setActive(arg_5_0.gotImg, arg_5_0.isFinished)

	if not arg_5_0.isFinished then
		setText(arg_5_0.progressText, arg_5_0.progressNum .. "/" .. var_0_0.MAX_COUNT)
	end

	local var_5_0 = arg_5_0.activity:getConfig("config_data")[2]

	if var_5_0 then
		for iter_5_1, iter_5_2 in ipairs((_.filter(var_5_0, function(arg_6_0)
			for iter_6_0, iter_6_1 in ipairs(arg_5_0.activity.data1_list) do
				if iter_6_1 == arg_6_0[1] then
					return false
				end
			end

			return true
		end))) do
			if arg_5_0.progressNum == iter_5_2[1] then
				arg_5_0:emit(ActivityMediator.EVENT_OPERATION, {
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

function var_0_0.OnDestroy(arg_7_0)
	return
end

function var_0_0.showLotteryAwardResult(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	GetComponent(arg_8_0.animTF, typeof(DftAniEvent)):SetEndEvent(function(arg_9_0)
		setActive(arg_8_0.animTF, false)
		setActive(arg_8_0.awardPanel, true)

		for iter_9_0 = 1, arg_8_0.resultTextTF.childCount do
			setActive(arg_8_0.resultTextTF:GetChild(iter_9_0 - 1), iter_9_0 == arg_8_2)
		end

		removeAllChildren(arg_8_0.itemTplContainer)

		for iter_9_1, iter_9_2 in ipairs(arg_8_1) do
			local var_9_0 = cloneTplTo(arg_8_0.itemTpl, arg_8_0.itemTplContainer)

			updateDrop(var_9_0, {
				type = iter_9_2.type,
				id = iter_9_2.id,
				count = iter_9_2.count
			})
			onButton(arg_8_0, var_9_0, function()
				arg_8_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		arg_8_0:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
		arg_8_3()
		onButton(arg_8_0, arg_8_0.awardPanel, function()
			setActive(arg_8_0.awardPanel, false)

			return
		end)

		return
	end)
	setActive(arg_8_0.animTF, true)
	arg_8_0:emit(ActivityMainScene.LOCK_ACT_MAIN, true)

	return
end

function var_0_0.IsTip()
	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.CYGNET_BATHROBE_PAGE_ID)

	if var_12_0 and not var_12_0:isEnd() then
		return var_12_0.data2 <= 0
	end

	return
end

return var_0_0
