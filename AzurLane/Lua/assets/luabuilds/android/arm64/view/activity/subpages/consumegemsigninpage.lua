local var_0_0 = class("ConsumeGemSignInPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.rtLogin = arg_1_0._tf:Find("AD/login")
	arg_1_0.shopBtn = arg_1_0._tf:Find("shop")
	arg_1_0.getAllBtn = arg_1_0._tf:Find("get_all")
	arg_1_0.getAllBtnEnb = arg_1_0._tf:Find("get_all/Text")
	arg_1_0.helpBtn = arg_1_0._tf:Find("help")
	arg_1_0.uiTargetList = UIItemList.New(arg_1_0._tf:Find("AD/targets"), arg_1_0._tf:Find("AD/targets/task"))
	arg_1_0.sliderTr = arg_1_0._tf:Find("AD/slider/Image")
	arg_1_0.ptTxt = arg_1_0._tf:Find("AD/Text")

	onButton(arg_1_0, arg_1_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ConsumeGem_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.shopBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.NEW_SHOP)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.getAllBtn, function()
		local var_4_0 = arg_1_0:CollectCanGetAwards()

		if #var_4_0 <= 0 then
			return
		end

		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			table.insert(var_4_1, function(arg_5_0)
				arg_1_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = arg_1_0.consumeGemAct.id,
					arg1 = iter_4_1,
					callback = arg_5_0
				})

				return
			end)
		end

		seriesAsync(var_4_1)

		return
	end, SFX_PANEL)

	arg_1_0.itemWid = 118

	return
end

function var_0_0.CollectCanGetAwards(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.targets) do
		if iter_6_1 <= arg_6_0.consumeGemAct.data1 and not table.contains(arg_6_0.consumeGemAct.data1_list, iter_6_1) then
			table.insert({}, iter_6_1)
		end
	end

	return {}
end

function var_0_0.OnDataSetting(arg_7_0)
	arg_7_0.nday = arg_7_0.activity.data3
	arg_7_0.taskProxy = getProxy(TaskProxy)
	arg_7_0.taskGroup = arg_7_0.activity:getConfig("config_data")
	arg_7_0.consumeGemAct = getProxy(ActivityProxy):getActivityById(arg_7_0.activity:getConfig("config_client").link_act)
	arg_7_0.targets = arg_7_0.consumeGemAct:getDataConfig("target")
	arg_7_0.drops = arg_7_0.consumeGemAct:getDataConfig("drop_client")

	return updateActivityTaskStatus(arg_7_0.activity)
end

function var_0_0.OnFirstFlush(arg_8_0)
	arg_8_0:FlushSignInAct()
	arg_8_0:FlushTargetPtAct()
	arg_8_0:Hx4Channel()

	return
end

function var_0_0.FlushTargetPtAct(arg_9_0)
	arg_9_0.pt = arg_9_0.consumeGemAct.data1
	arg_9_0.gotList = arg_9_0.consumeGemAct.data1_list

	setText(arg_9_0.ptTxt, arg_9_0.pt)
	setActive(arg_9_0.getAllBtnEnb, #arg_9_0:CollectCanGetAwards() > 0)

	local var_9_0 = 0

	arg_9_0.uiTargetList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_9_0.targets[arg_10_1 + 1]
			local var_10_1 = Drop.Create(arg_9_0.drops[arg_10_1 + 1])

			setText(arg_10_2:Find("day/Text"), arg_9_0.targets[arg_10_1 + 1])

			local var_10_2 = table.contains(arg_9_0.gotList, var_10_0)

			setActive(arg_10_2:Find("task_1/got"), var_10_2)

			local var_10_3 = not var_10_2 and var_10_0 <= arg_9_0.pt

			setActive(arg_10_2:Find("get"), not var_10_2 and var_10_0 <= arg_9_0.pt)
			setActive(arg_10_2:Find("task_1/lock"), var_10_0 > arg_9_0.pt)
			setActive(arg_10_2:Find("dot1/Image_1"), var_10_3)

			if var_10_2 then
				var_9_0 = arg_10_1 + 1
			end

			onButton(arg_9_0, arg_10_2:Find("get"), function()
				arg_9_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = arg_9_0.consumeGemAct.id,
					arg1 = var_10_0
				})

				return
			end, SFX_CONFIRM)
			updateDrop(arg_10_2:Find("task_1/IconTpl"), var_10_1)
			onButton(arg_9_0, arg_10_2, function()
				arg_9_0:emit(BaseUI.ON_DROP, var_10_1)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_9_0.uiTargetList:align(#arg_9_0.targets)

	arg_9_0.sliderTr.sizeDelta = Vector2(arg_9_0.itemWid * 0.5 + (0 - 1) * arg_9_0.itemWid, arg_9_0.sliderTr.sizeDelta.y)

	return
end

function var_0_0.FlushSignInAct(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.taskGroup) do
		local var_13_0 = arg_13_0.taskProxy:getTaskVO(iter_13_1[1]) or Task.New({
			id = iter_13_1[1]
		})
		local var_13_1 = arg_13_0.rtLogin:Find(({
			"task",
			"task_1",
			"task_2"
		})[iter_13_0])

		setText(var_13_1:Find("day/Text"), "DAY" .. iter_13_0)
		updateDrop(var_13_1:Find("IconTpl"), (Drop.Create(var_13_0:getConfig("award_display")[1])))
		onButton(arg_13_0, var_13_1:Find("get"), function()
			arg_13_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_0)

			return
		end, SFX_CONFIRM)
		onButton(arg_13_0, var_13_1, function()
			arg_13_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_16_0)
	arg_16_0:UpdateSignInAct()
	arg_16_0:UpdateTargetPtAct()

	return
end

function var_0_0.UpdateSignInAct(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.taskGroup) do
		local var_17_0 = arg_17_0.taskProxy:getTaskVO(iter_17_1[1]) or Task.New({
			id = iter_17_1[1]
		})
		local var_17_1 = arg_17_0.rtLogin:Find(({
			"task",
			"task_1",
			"task_2"
		})[iter_17_0])
		local var_17_2 = var_17_0:isReceive()

		setActive(var_17_1:Find("got"), var_17_2 or iter_17_0 < arg_17_0.nday)

		local var_17_3 = not false and not var_17_2 and iter_17_0 == arg_17_0.nday

		setActive(var_17_1:Find("get"), not false and not var_17_2 and iter_17_0 == arg_17_0.nday)
	end

	return
end

function var_0_0.UpdateTargetPtAct(arg_18_0)
	arg_18_0:FlushTargetPtAct()

	return
end

local function var_0_1(arg_19_0)
	return (arg_19_0._tf:Find("AD/rw_mask/rw_1/hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function var_0_0.Hx4Channel(arg_20_0)
	local var_20_0 = var_0_1(arg_20_0)

	if not IsNil(var_20_0) then
		setActive(var_20_0, HXSet.isHx())
	end

	return
end

return var_0_0
