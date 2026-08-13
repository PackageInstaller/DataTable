class = var_0_10000

local var_0_0 = "OutPostPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MaoziPtPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.getBtn1 = var_1.Find(var_1_0, "AD/switcher/phase2/get_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	setActive = var_1

	var_1(arg_2_0.displayBtn, true)

	local var_2_0 = arg_2_0.displayBtn
	local var_2_1 = var_1.Find(var_2_0, "Image1")
	local var_2_2 = arg_2_0.displayBtn
	local var_2_3 = var_2.Find(var_2_2, "Image2")
	local var_2_4, var_2_5 = arg_2_0:GetActTask()
	local var_2_6

	if var_2_4 and var_2_4:isReceive() then
		var_2_6 = var_2_5
	end

	setActive = var_1_10006

	var_1_10006(var_2_1, not var_2_6)

	setActive = var_1_10006

	var_1_10006(var_2_3, var_2_6)

	local var_2_7

	if var_2_4 then
		var_2_7 = var_2_4

		if not var_2_4.isReceive(var_2_7) then
			blinkAni = var_1_10006
			go = var_2_7

			var_1_10006(var_2_7(var_2_1), 0.8, -1, 0.3)

			goto label_2_1
		end
	end

	LeanTween = var_1_10006
	var_1_10006 = var_1_10006.cancel
	go = var_2_7

	var_1_10006(var_2_7(var_2_1))

	::label_2_1::

	onButton = var_1_10006

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.displayBtn

	local function var_2_10()
		if var_2_4 then
			local var_3_0 = var_2_4

			if var_0.isReceive(var_3_0) and not var_2_6 then
				pg = var_0

				local var_3_1 = var_0.TipsMgr.GetInstance()
				local var_3_2 = var_0.ShowTips

				i18n = var_2_10003

				var_3_2(var_3_1, var_2_10003("undermist_tip"))

				return
			end
		end

		if var_2_4 and not var_2_6 then
			local var_3_3 = arg_2_0
			local var_3_4 = var_0.emit

			ActivityMediator = var_2_10003

			local var_3_5 = var_2_10003.EVENT_GO_SCENE

			SCENE = var_2_10004

			var_3_4(var_3_3, var_3_5, var_2_10004.TASK, {
				page = "activity",
				targetId = var_2_4.id
			})
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_1_10006(var_2_8, var_2_9, var_2_10, var_1_10011)

	onButton = var_1_10006

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.getBtn1

	local function var_2_13()
		triggerButton = var_2_10000

		var_2_10000(arg_2_0.getBtn)

		return
	end

	SFX_PANEL = var_1_10011

	var_1_10006(var_2_11, var_2_12, var_2_13, var_1_10011)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	var_0_1.super.OnUpdateFlush(arg_5_0)

	local var_5_0 = arg_5_0.ptData
	local var_5_1 = var_1.CanGetAward(var_5_0)

	setActive = var_1_10002

	var_1_10002(arg_5_0.getBtn1, var_5_1)

	return
end

function var_0_1.GetActTask(arg_6_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	if not var_6_1(var_6_0, var_1_10004.OUTPOST_TASK) or var_1:isEnd() then
		return
	end

	_ = var_1_10002

	local var_6_2 = var_1_10002.flatten(var_1:getConfig("config_data"))

	getProxy = var_6_0
	TaskProxy = var_1_10005

	local var_6_3 = var_6_0(var_1_10005)
	local var_6_4
	local var_6_5 = false

	for iter_6_0 = #var_6_2, 1, -1 do
		local var_6_6 = var_6_2[iter_6_0]
		local var_6_7

		if not var_6_3:getTaskById(var_6_6) then
			var_6_7 = var_6_3:getFinishTaskById(var_6_6)
		end

		if var_6_7 then
			var_6_4 = var_6_7

			if iter_6_0 == #var_6_2 then
				var_6_5 = true
			end

			break
		end
	end

	return var_6_4, var_6_5
end

return var_0_1
