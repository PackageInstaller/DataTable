class = var_0_10000

local var_0_0 = "GuildOfficeTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.GuildBasePage"))

function var_0_1.getTargetUI(arg_1_0)
	return "GuildOfficeTaskBluePage", "GuildOfficeTaskRedPage"
end

function var_0_1.OnLoaded(arg_2_0)
	GuildOfficeSelectTaskPage = var_1_10001
	arg_2_0.selectTaskPage = var_1_10001.New(arg_2_0._tf.parent, arg_2_0.event)

	local var_2_0 = arg_2_0._tf

	arg_2_0.taskTF = var_1.Find(var_2_0, "TaskPanel")

	local var_2_1 = arg_2_0._tf

	arg_2_0.taskUnOpenTF = var_1.Find(var_2_1, "TaskPanel/unopen")

	local var_2_2 = arg_2_0.taskUnOpenTF

	arg_2_0.unOpenAdmin = var_1.Find(var_2_2, "select")

	local var_2_3 = arg_2_0.taskUnOpenTF

	arg_2_0.unOpenUnAdmin = var_1.Find(var_2_3, "lock")

	local var_2_4 = arg_2_0._tf

	arg_2_0.taskOpenTF = var_1.Find(var_2_4, "TaskPanel/open")

	local var_2_5 = arg_2_0.taskOpenTF
	local var_2_6 = var_1.Find(var_2_5, "top/desc/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.taskDescTxt = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0.taskOpenTF
	local var_2_9 = var_1.Find(var_2_8, "top/desc1/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.taskAwardTxt = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0.taskOpenTF
	local var_2_12 = var_1.Find(var_2_11, "top/progress")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.taskProgressTxt = var_2_13(var_2_12, var_4(var_1_10006))

	local var_2_14 = arg_2_0.taskOpenTF

	arg_2_0.taskProgressBar = var_1.Find(var_2_14, "top/progress_bar")

	local var_2_15 = arg_2_0.taskOpenTF
	local var_2_16 = var_1.Find(var_2_15, "bottom/desc")
	local var_2_17 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.privateTaskDesc = var_2_17(var_2_16, var_4(var_1_10006))

	local var_2_18 = arg_2_0.taskOpenTF

	arg_2_0.privateTaskGetBtn = var_1.Find(var_2_18, "bottom/get")

	local var_2_19 = arg_2_0.taskOpenTF

	arg_2_0.privateTaskAcceptBtn = var_1.Find(var_2_19, "bottom/accept")

	local var_2_20 = arg_2_0.taskOpenTF
	local var_2_21 = var_1.Find(var_2_20, "bottom/progress/Text")
	local var_2_22 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.privateTaskProgressTxt = var_2_22(var_2_21, var_4(var_1_10006))

	local var_2_23 = arg_2_0.taskOpenTF

	arg_2_0.privateTaskReapeatFlag = var_1.Find(var_2_23, "bottom/reapeat")

	local var_2_24 = arg_2_0.taskOpenTF
	local var_2_25 = var_1.Find(var_2_24, "bottom/res/Text")
	local var_2_26 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.privateTaskResTxt = var_2_26(var_2_25, var_4(var_1_10006))

	local var_2_27 = arg_2_0._tf

	arg_2_0.taskMaskAll = var_1.Find(var_2_27, "TaskPanel/open/mask_all")

	local var_2_28 = arg_2_0._tf

	arg_2_0.taskMaskTop = var_1.Find(var_2_28, "TaskPanel/open/mask_top")
	UIItemList = var_1

	local var_2_29 = var_1.New
	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_3.Find(var_2_30, "TaskPanel/SubmitPanel/list")
	local var_2_32 = arg_2_0._tf

	arg_2_0.contributionList = var_2_29(var_2_31, var_4.Find(var_2_32, "TaskPanel/SubmitPanel/list/tpl"))

	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_1.Find(var_2_33, "TaskPanel/SubmitPanel/cnt/Text")
	local var_2_35 = var_1.GetComponent

	typeof = var_4
	Text = var_2_32
	arg_2_0.contributionCntTxt = var_2_35(var_2_34, var_4(var_2_32))

	local var_2_36 = arg_2_0._tf

	arg_2_0.supplyFrame = var_1.Find(var_2_36, "TaskPanel/SupplyPanel/frame")

	local var_2_37 = arg_2_0._tf

	arg_2_0.supplyOpenTF = var_1.Find(var_2_37, "TaskPanel/SupplyPanel/frame/open")

	local var_2_38 = arg_2_0.supplyOpenTF
	local var_2_39 = var_1.Find(var_2_38, "time")
	local var_2_40 = var_1.GetComponent

	typeof = var_4
	Text = var_2_32
	arg_2_0.supplyOpenTimeTxt = var_2_40(var_2_39, var_4(var_2_32))

	local var_2_41 = arg_2_0.supplyOpenTF
	local var_2_42 = var_1.Find(var_2_41, "Text")
	local var_2_43 = var_1.GetComponent

	typeof = var_4
	Text = var_2_32
	arg_2_0.supplyOpenLetfCntTxt = var_2_43(var_2_42, var_4(var_2_32))

	local var_2_44 = arg_2_0.supplyOpenTF

	arg_2_0.supplyOpenGetBtn = var_1.Find(var_2_44, "get")

	local var_2_45 = arg_2_0.supplyOpenTF

	arg_2_0.supplyOpenGotBtn = var_1.Find(var_2_45, "got")

	local var_2_46 = arg_2_0._tf

	arg_2_0.supplyUnOpenTF = var_1.Find(var_2_46, "TaskPanel/SupplyPanel/frame/unopen")

	local var_2_47 = arg_2_0.supplyUnOpenTF

	arg_2_0.supplyUnOpenAdminTF = var_1.Find(var_2_47, "purchase")

	local var_2_48 = arg_2_0.supplyUnOpenAdminTF
	local var_2_49 = var_1.Find(var_2_48, "Text")
	local var_2_50 = var_1.GetComponent

	typeof = var_4
	Text = var_2_32
	arg_2_0.supplyUnOpenResTF = var_2_50(var_2_49, var_4(var_2_32))

	local var_2_51 = arg_2_0.supplyUnOpenTF

	arg_2_0.supplyUnOpenLockTF = var_1.Find(var_2_51, "lock")

	return
end

function var_0_1.OnInit(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()
	local var_3_1 = var_1.OverlayPanel
	local var_3_2 = arg_3_0.taskTF
	local var_3_3 = {
		pbList = {
			arg_3_0.taskTF
		}
	}

	LayerWeightConst = var_6
	var_3_3.overlayType = var_6.OVERLAY_UI_ADAPT

	var_3_1(var_3_0, var_3_2, var_3_3)

	onButton = var_3_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.supplyUnOpenAdminTF

	local function var_3_6()
		local var_4_0 = arg_3_0.guild
		local var_4_1 = var_0.getSupplyConsume(var_4_0)

		pg = var_2_10001

		local var_4_2 = var_2_10001.MsgboxMgr.GetInstance()
		local var_4_3 = var_1.ShowMsgBox
		local var_4_4 = {}

		i18n = var_2_10005
		var_4_4.content = var_2_10005("guild_start_supply_consume_tip", var_4_1)

		function var_4_4.onYes()
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			GuildOfficeMediator = var_3_10003

			var_5_1(var_5_0, var_3_10003.ON_PURCHASE_SUPPLY)

			return
		end

		var_4_3(var_4_2, var_4_4)

		return
	end

	SFX_PANEL = var_6

	var_3_1(var_3_4, var_3_5, var_3_6, var_6)

	onButton = var_3_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.supplyOpenGetBtn

	local function var_3_9()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		GuildOfficeMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.GET_SUPPLY_AWARD)

		return
	end

	SFX_PANEL = var_6

	var_3_1(var_3_7, var_3_8, var_3_9, var_6)

	onButton = var_3_1

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.supplyFrame

	local function var_3_12()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.guild_supply_help_tip.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_6

	var_3_1(var_3_10, var_3_11, var_3_12, var_6)

	return
end

function var_0_1.Update(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:OnUpdateGuild(arg_8_1, arg_8_2)
	arg_8_0:UpdateTaskPanel(false)
	arg_8_0:UpdateContributionPanel()
	arg_8_0:UpdateSupplyPanel()
	arg_8_0:Show()

	return
end

function var_0_1.OnUpdateGuild(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.guild = arg_9_1
	arg_9_0.isAdmin = arg_9_2

	return
end

function var_0_1.OnUpdateContribution(arg_10_0)
	arg_10_0:UpdateContributionPanel()

	return
end

function var_0_1.OnUpdateTask(arg_11_0, arg_11_1)
	arg_11_0:UpdateTaskPanel(arg_11_1)

	return
end

function var_0_1.OnUpdateSupplyPanel(arg_12_0)
	arg_12_0:UpdateSupplyPanel()

	return
end

function var_0_1.UpdateTaskPanel(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.guild
	local var_13_1 = var_2.getWeeklyTask(var_13_0)
	local var_13_2 = var_3.getState(var_13_1)

	GuildTask = var_13_0

	if var_13_2 == var_13_0.STATE_EMPTY then
		arg_13_0:UpdateLockTask()

		goto label_13_0
	end

	GuildTask = var_5

	if var_13_2 ~= var_5.STATE_ONGOING then
		GuildTask = var_5

		if var_13_2 == var_5.STATE_FINISHED then
			arg_13_0:UpdatePubliceTask(var_3)
			arg_13_0:UpdatePrivateTask(var_3)
		end

		::label_13_0::

		setActive = var_5

		local var_13_3 = arg_13_0.taskOpenTF

		GuildTask = var_1_10008

		var_5(var_13_3, var_13_2 ~= var_1_10008.STATE_EMPTY)

		setActive = var_5

		local var_13_4 = arg_13_0.taskUnOpenTF

		GuildTask = var_8

		var_5(var_13_4, var_13_2 == var_8.STATE_EMPTY)

		if arg_13_1 or var_2:shouldRefreshWeeklyTaskProgress() then
			local var_13_5 = arg_13_0
			local var_13_6 = arg_13_0.emit

			GuildOfficeMediator = var_8

			var_13_6(var_13_5, var_8.UPDATE_WEEKLY_TASK)
		end

		return
	end
end

function var_0_1.UpdateLockTask(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.unOpenAdmin, arg_14_0.isAdmin)

	setActive = var_1_10001

	var_1_10001(arg_14_0.unOpenUnAdmin, not arg_14_0.isAdmin)

	if arg_14_0.isAdmin then
		onButton = var_1

		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.unOpenAdmin

		local function var_14_2()
			local var_15_0 = arg_14_0.selectTaskPage

			var_0.ExecuteAction(var_15_0, "Show", arg_14_0.guild, arg_14_0.isAdmin)

			return
		end

		SFX_PANEL = var_1_10006

		var_1(var_14_0, var_14_1, var_14_2, var_1_10006)
	end

	return
end

function var_0_1.UpdatePrivateTask(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.guild
	local var_16_1 = not var_2.hasWeeklyTaskFlag(var_16_0)
	local var_16_2 = arg_16_1:GetPresonTaskId()

	getProxy = var_16_0
	TaskProxy = var_1_10006

	local var_16_3 = var_16_0(var_1_10006)
	local var_16_4

	if not var_4.getTaskById(var_16_3, var_16_2) then
		var_16_3 = var_4
		var_16_4 = var_4.getFinishTaskById(var_16_3, var_16_2)
	end

	if not (var_16_4 ~= nil) then
		Task = var_16_3
		var_16_4 = var_16_3.New({
			id = var_16_2
		})
	end

	arg_16_0.privateTaskDesc.text = var_16_4:getConfig("desc")

	local var_16_5 = arg_16_0.privateTaskProgressTxt
	local var_16_6 = var_16_4.progress
	local var_16_7 = "/"
	local var_16_8 = var_16_4

	var_16_5.text = var_16_6 .. var_16_7 .. var_16_4.getConfig(var_16_8, "target_num")

	local var_16_9 = arg_16_0.privateTaskResTxt

	var_16_9.text = arg_16_1:GetPrivateAward()
	onButton = var_16_9

	local var_16_10 = arg_16_0
	local var_16_11 = arg_16_0.privateTaskAcceptBtn

	local function var_16_12()
		pg = var_2_10000

		local var_17_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_17_1 = var_0.ShowMsgBox
		local var_17_2 = {}

		i18n = var_2_10004

		local var_17_3 = "guild_task_accept"
		local var_17_4 = arg_16_1
		local var_17_5 = var_7.getConfig(var_17_4, "name")
		local var_17_6 = var_16_4
		local var_17_7 = var_8.getConfig(var_17_6, "name")
		local var_17_8 = var_16_4

		var_17_2.content = var_2_10004(var_17_3, var_17_5, var_17_7, var_9.getConfig(var_17_8, "name"))

		function var_17_2.onYes()
			local var_18_0 = arg_16_0
			local var_18_1 = var_0.emit

			GuildOfficeMediator = var_3_10003

			var_18_1(var_18_0, var_3_10003.ON_ACCEPT_TASK, var_16_2)

			return
		end

		var_17_1(var_17_0, var_17_2)

		return
	end

	SFX_PANEL = var_16_8

	var_16_9(var_16_10, var_16_11, var_16_12, var_16_8)

	onButton = var_16_9

	local var_16_13 = arg_16_0
	local var_16_14 = arg_16_0.privateTaskGetBtn

	local function var_16_15()
		local var_19_0 = arg_16_0
		local var_19_1 = var_0.emit

		GuildOfficeMediator = var_2_10003

		var_19_1(var_19_0, var_2_10003.ON_SUBMIT_TASK, var_16_2)

		return
	end

	SFX_PANEL = var_16_8

	var_16_9(var_16_13, var_16_14, var_16_15, var_16_8)

	local var_16_16 = var_16_4

	if var_16_4.isFinish(var_16_16) then
		var_16_16 = var_16_4

		if not var_16_4.isReceive(var_16_16) and not var_16_1 then
			var_16_16 = arg_16_0

			local var_16_17 = arg_16_0.emit

			GuildOfficeMediator = var_16_14

			var_16_17(var_16_16, var_16_14.ON_SUBMIT_TASK, var_16_2)

			goto label_16_0
		end
	end

	if not var_6 and var_16_1 then
		var_16_16 = arg_16_0

		local var_16_18 = arg_16_0.emit

		GuildOfficeMediator = var_16_14

		var_16_18(var_16_16, var_16_14.ON_ACCEPT_TASK, var_16_2)
	end

	::label_16_0::

	local var_16_19 = not var_16_1
	local var_16_20

	if arg_16_1:isFinished() then
		var_16_20 = not var_6 or not var_16_1
	end

	setActive = var_16_16

	var_16_16(arg_16_0.taskMaskAll, var_16_20)

	setActive = var_16_16

	var_16_16(arg_16_0.taskMaskTop, not var_16_20 and arg_16_1:isFinished())

	setActive = var_16_16

	var_16_16(arg_16_0.privateTaskReapeatFlag, var_16_19)

	setActive = var_16_16

	var_16_16(arg_16_0.privateTaskResTxt.gameObject.transform.parent, not var_16_19)

	setActive = var_16_16

	var_16_16(arg_16_0.privateTaskAcceptBtn, not var_6 or var_16_4:isReceive())

	setActive = var_16_16

	local var_16_21 = arg_16_0.privateTaskGetBtn
	local var_16_22

	if var_6 and var_16_4:isFinish() then
		var_16_22 = not var_16_4:isReceive()
	end

	var_16_16(var_16_21, var_16_22)

	setActive = var_16_16

	var_16_16(arg_16_0.privateTaskProgressTxt.gameObject.transform.parent, var_6 and not var_16_4:isFinish())

	return
end

function var_0_1.UpdatePubliceTask(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:getProgress()
	local var_20_1 = arg_20_1:getMaxProgress()
	local var_20_2 = arg_20_0.taskProgressTxt

	var_20_2.text = var_20_0 .. "/<size=40>" .. var_20_1 .. "</size>"
	setFillAmount = var_20_2

	var_20_2(arg_20_0.taskProgressBar, var_20_0 / var_20_1)

	arg_20_0.taskDescTxt.text = var_20_0
	arg_20_0.taskAwardTxt.text = arg_20_1:GetCurrCaptailAward()

	return
end

function var_0_1.UpdateContributionPanel(arg_21_0)
	local var_21_0 = arg_21_0.guild
	local var_21_1 = var_1.getDonateTasks(var_21_0)
	local var_21_2 = var_1
	local var_21_3 = var_1.getRemainDonateCnt(var_21_2) + var_1:GetExtraDonateCnt()
	local var_21_4 = arg_21_0.contributionList

	var_4.make(var_21_4, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = var_21_1[arg_22_1 + 1]

			GuildDonateCard = var_4

			local var_22_1 = var_4.New(arg_22_2)

			var_4.update(var_22_1, var_22_0)

			onButton = var_5

			local var_22_2 = arg_21_0
			local var_22_3 = var_4.commitBtn

			local function var_22_4()
				local var_23_0 = var_22_0
				local var_23_1 = var_0.getCommitItem(var_23_0)

				Drop = var_3_10001

				local var_23_2 = var_3_10001.New({
					type = var_23_1[1],
					id = var_23_1[2],
					count = var_23_1[3]
				})
				local var_23_3 = var_0
				local var_23_4 = var_2.GetResCntByAward(var_23_3, var_23_1) < var_23_1[3] and "#FF5C5CFF" or "#92FC63FF"

				pg = var_23_3

				local var_23_5 = var_23_3.MsgboxMgr.GetInstance()
				local var_23_6 = var_4.ShowMsgBox
				local var_23_7 = {}

				i18n = var_3_10008
				var_23_7.content = var_3_10008("guild_donate_tip", var_23_2:getConfig("name"), var_23_1[3], var_2, var_23_4)

				function var_23_7.onYes()
					local var_24_0 = arg_21_0
					local var_24_1 = var_0.emit

					GuildOfficeMediator = var_4_10003

					var_24_1(var_24_0, var_4_10003.ON_COMMIT, var_22_0.id)

					return
				end

				var_23_6(var_23_5, var_23_7)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_22_2, var_22_3, var_22_4, var_2_10010)

			setButtonEnabled = var_5

			var_5(var_4.commitBtn, var_21_3 > 0)
		end

		return
	end)

	local var_21_5 = arg_21_0.contributionList

	var_4.align(var_21_5, #var_21_1)

	local var_21_6 = arg_21_0.contributionCntTxt

	i18n = var_21_2
	var_21_6.text = var_21_2("guild_left_donate_cnt", var_21_3)

	return
end

function var_0_1.UpdateSupplyPanel(arg_25_0)
	local var_25_0 = arg_25_0.guild
	local var_25_1 = var_1.isOpenedSupply(var_25_0)

	setActive = var_1_10003

	var_1_10003(arg_25_0.supplyOpenTF, var_25_1)

	setActive = var_1_10003

	var_1_10003(arg_25_0.supplyUnOpenTF, not var_25_1)

	if not var_25_1 then
		setActive = var_1_10003

		var_1_10003(arg_25_0.supplyUnOpenAdminTF, arg_25_0.isAdmin)

		setActive = var_1_10003

		var_1_10003(arg_25_0.supplyUnOpenLockTF, not arg_25_0.isAdmin)

		if arg_25_0.isAdmin then
			arg_25_0.supplyUnOpenResTF.text = var_1:getSupplyConsume()
		end
	else
		local var_25_2 = var_1
		local var_25_3 = var_1.getSupplyCnt(var_25_2)
		local var_25_4 = var_1
		local var_25_5 = var_1.getSupplyLeftCnt(var_25_4)

		setActive = var_25_2

		var_25_2(arg_25_0.supplyOpenGetBtn, var_25_3 > 0)

		setActive = var_25_2

		var_25_2(arg_25_0.supplyOpenGotBtn, var_25_3 <= 0)

		if var_25_5 < 0 then
			local var_25_6 = arg_25_0.supplyOpenTimeTxt

			i18n = var_25_4
			var_25_6.text = var_25_4("guild_exist_unreceived_supply_award")
		else
			local var_25_7 = arg_25_0.supplyOpenTimeTxt

			i18n = var_25_4
			var_25_7.text = var_25_4("guild_left_supply_day", var_25_5)
		end

		local var_25_8 = arg_25_0.supplyOpenLetfCntTxt

		i18n1 = var_25_4

		local var_25_9 = var_25_3
		local var_25_10 = "/"

		GuildConst = var_1_10010
		var_25_8.text = var_25_4(var_25_9 .. var_25_10 .. var_1_10010.MAX_SUPPLY_CNT)
	end

	return
end

function var_0_1.OnDestroy(arg_26_0)
	pg = var_1_10001

	local var_26_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_26_0, arg_26_0.taskTF, arg_26_0._tf)

	local var_26_1 = arg_26_0.selectTaskPage

	var_1.Destroy(var_26_1)

	return
end

return var_0_1
