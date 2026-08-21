local var_0_0 = class("ToLoveCollabMedalView", import("..TemplateMV.MedalCollectionTemplateView"))

function var_0_0.getUIName(arg_1_0)
	return "ToLoveCollabMedalPage"
end

function var_0_0.init(arg_2_0)
	arg_2_0:FindUI()

	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.FindUI(arg_3_0)
	arg_3_0.bg = arg_3_0._tf:Find("mask")
	arg_3_0.backBtn = arg_3_0._tf:Find("Top"):Find("BackBtn")
	arg_3_0.slots = {}

	for iter_3_0 = 1, 6 do
		arg_3_0.slots[iter_3_0] = {
			char = arg_3_0._tf:Find("Desk/Slot" .. iter_3_0 .. "/Char"),
			selected = arg_3_0._tf:Find("Desk/Slot" .. iter_3_0 .. "/Selected"),
			tips = arg_3_0._tf:Find("Desk/Slot" .. iter_3_0 .. "/reddot")
		}
	end

	arg_3_0.medalTF = arg_3_0._tf:Find("Desk/trophy")
	arg_3_0.syncBtn = arg_3_0._tf:Find("Desk/syncBtn")
	arg_3_0.task = arg_3_0._tf:Find("Desk/task")
	arg_3_0.taskBGGo = arg_3_0.task:Find("bg_go")
	arg_3_0.taskBGGot = arg_3_0.task:Find("bg_got")
	arg_3_0.taskBtnGo = arg_3_0.task:Find("go_btn")
	arg_3_0.taskBtnGot = arg_3_0.task:Find("got_btn")
	arg_3_0.taskBtnGet = arg_3_0.task:Find("get_btn")
	arg_3_0.taskDesc = arg_3_0.task:Find("desc")
	arg_3_0.taskReward = arg_3_0.task:Find("award/mask")
	arg_3_0.taskRewardName = arg_3_0.task:Find("name")

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0.taskList, arg_4_0.dropInfoList = {}, {}

	local var_4_0 = arg_4_0.activityData:getConfig("config_client").item_task

	for iter_4_0 = 1, 6 do
		arg_4_0.taskList[iter_4_0] = Task.New({
			id = var_4_0[iter_4_0][2]
		})
		arg_4_0.dropInfoList[iter_4_0] = {
			type = DROP_TYPE_VITEM,
			id = var_4_0[iter_4_0][1]
		}
	end

	arg_4_0:AddListener()

	arg_4_0.contextData.ChipIndex = arg_4_0.contextData.ChipIndex or 1

	arg_4_0:UpdateView()
	pg.UIMgr.GetInstance():OverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.AddListener(arg_5_0)
	onButton(arg_5_0, arg_5_0.backBtn, function()
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0.taskBtnGet, function()
		local var_7_0 = arg_5_0.allIDList[arg_5_0.contextData.ChipIndex]

		if not table.contains(arg_5_0.activeIDList, arg_5_0.allIDList[arg_5_0.contextData.ChipIndex]) and table.contains(arg_5_0.activatableIDList, var_7_0) then
			arg_5_0:emit(MedalCollectionTemplateMediator.MEMORYBOOK_UNLOCK, {
				id = var_7_0,
				actId = arg_5_0.activityData.id
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.taskBtnGo, function()
		local var_8_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_TASK_ID)

		if var_8_0 and not var_8_0:isEnd() then
			arg_5_0:emit(MedalCollectionTemplateMediator.MEMORYBOOK_GO, arg_5_0.taskList[arg_5_0.contextData.ChipIndex])
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)

	for iter_5_0 = 1, 6 do
		onButton(arg_5_0, arg_5_0._tf:Find("Desk/Slot" .. iter_5_0 .. "/Click"), function()
			arg_5_0.contextData.ChipIndex = iter_5_0

			arg_5_0:UpdateView()

			return
		end, SFX_PANEL)
	end

	onButton(arg_5_0, arg_5_0.syncBtn, function()
		arg_5_0:CheckAward()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.bg, function()
		arg_5_0:closeView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateAfterSubmit(arg_12_0, arg_12_1)
	arg_12_0:UpdateView()

	return
end

function var_0_0.UpdateAfterFinalMedal(arg_13_0)
	var_0_0.super.UpdateAfterFinalMedal(arg_13_0)
	arg_13_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_14_0)
	for iter_14_0 = 1, 6 do
		for iter_14_1 = 1, #arg_14_0.slots do
			local var_14_2 = table.contains(arg_14_0.activeIDList, arg_14_0.allIDList[iter_14_1])

			setActive(arg_14_0.slots[iter_14_1].char, var_14_2)

			local var_14_3 = table.contains(arg_14_0.activatableIDList, arg_14_0.allIDList[iter_14_1]) and not var_14_2

			setActive(arg_14_0.slots[iter_14_1].tips, var_14_3)
		end

		setActive(arg_14_0.slots[iter_14_0].selected, iter_14_0 == arg_14_0.contextData.ChipIndex)
	end

	local var_14_4 = #arg_14_0.activeIDList == #arg_14_0.allIDList
	local var_14_5 = #arg_14_0.activeIDList == #arg_14_0.allIDList and arg_14_0.activityData.data1 == 1

	setActive(arg_14_0.medalTF:Find("Lock"), not (#arg_14_0.activeIDList == #arg_14_0.allIDList and arg_14_0.activityData.data1 == 1))
	setActive(arg_14_0.medalTF:Find("Unlock"), var_14_5)
	setActive(arg_14_0.syncBtn:Find("notSync"), not var_14_4)
	setActive(arg_14_0.syncBtn:Find("synced"), var_14_5)

	arg_14_0.syncBtn:GetComponent(typeof(Image)).enabled = var_14_4 and not var_14_5

	setActive(arg_14_0.syncBtn:Find("reddot"), var_14_4 and not var_14_5)
	arg_14_0:UpdateInfo()

	return
end

function var_0_0.UpdateInfo(arg_15_0)
	local var_15_0 = arg_15_0.allIDList[arg_15_0.contextData.ChipIndex]
	local var_15_1 = table.contains(arg_15_0.activeIDList, arg_15_0.allIDList[arg_15_0.contextData.ChipIndex])
	local var_15_2 = not var_15_1 and table.contains(arg_15_0.activatableIDList, var_15_0)

	setActive(arg_15_0.taskBGGo, not var_15_1)
	setActive(arg_15_0.taskBGGot, var_15_1)
	setActive(arg_15_0.taskBtnGot, var_15_1)
	setActive(arg_15_0.taskBtnGet, var_15_2)
	setActive(arg_15_0.taskBtnGo, not var_15_2)
	setText(arg_15_0.taskDesc, arg_15_0.taskList[arg_15_0.contextData.ChipIndex]:getConfig("desc"))
	updateDrop(arg_15_0.taskReward, arg_15_0.dropInfoList[arg_15_0.contextData.ChipIndex])
	setText(arg_15_0.taskRewardName, pg.item_virtual_data_statistics[arg_15_0.dropInfoList[arg_15_0.contextData.ChipIndex].id].name)

	return
end

function var_0_0.willExit(arg_16_0)
	arg_16_0.loader:Clear()

	return
end

return var_0_0
