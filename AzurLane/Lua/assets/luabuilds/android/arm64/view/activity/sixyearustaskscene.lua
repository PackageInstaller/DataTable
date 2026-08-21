local var_0_0 = class("SixYearUsTaskScene", import("view.base.BaseUI"))
local var_0_1 = {
	{
		6,
		9004
	},
	{
		16,
		1006
	}
}
local var_0_2 = 65011

function var_0_0.getUIName(arg_1_0)
	return "SixYearUsTaskPage"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.scrollPanel = arg_2_0._tf:Find("window/panel")
	arg_2_0.UIlist = UIItemList.New(arg_2_0._tf:Find("window/panel/list"), arg_2_0._tf:Find("window/panel/list/Tasktpl"))
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.getBtn = arg_2_0._tf:Find("window/btn_get")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0.anim:Play("anim_kinder_schoolPT_out")

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.bg, function()
		arg_3_0.anim:Play("anim_kinder_schoolPT_out")

		return
	end, SFX_PANEL)
	arg_3_0:Show()

	arg_3_0.anim = arg_3_0._tf:GetComponent(typeof(Animation))
	arg_3_0.animEvent = arg_3_0.anim:GetComponent(typeof(DftAniEvent))

	arg_3_0.animEvent:SetEndEvent(function()
		arg_3_0:closeView()

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.Show(arg_7_0)
	arg_7_0:UpdateTaskData()

	arg_7_0.canGetTaskVOs = {}
	arg_7_0.canGetTaskIds = {}

	arg_7_0:sort(arg_7_0.taskVOs)
	arg_7_0:UpdateList(arg_7_0.taskVOs)
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.sort(arg_8_0, arg_8_1)
	arg_8_0.canGetAward = false

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if iter_8_1:getTaskStatus() == 1 then
			table.insert({}, iter_8_1)
			table.insert(arg_8_0.canGetTaskVOs, iter_8_1)
			table.insert(arg_8_0.canGetTaskIds, iter_8_1.id)

			arg_8_0.canGetAward = true
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_1) do
		if iter_8_3:getTaskStatus() == 0 then
			table.insert({}, iter_8_3)
		end
	end

	for iter_8_4, iter_8_5 in pairs(arg_8_1) do
		if iter_8_5:getTaskStatus() == 2 then
			table.insert({}, iter_8_5)
		end
	end

	arg_8_0.taskVOs = {}

	return
end

function var_0_0.UpdateList(arg_9_0, arg_9_1)
	arg_9_0.UIlist:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_9_1[arg_10_1 + 1]

			setText(arg_10_2:Find("frame/desc"), arg_9_1[arg_10_1 + 1]:getConfig("desc"))

			local var_10_1, var_10_2 = arg_9_0:getTaskProgress(arg_9_1[arg_10_1 + 1])
			local var_10_3, var_10_4 = arg_9_0:getTaskTarget(arg_9_1[arg_10_1 + 1])

			setText(arg_10_2:Find("frame/progress"), var_10_2 .. "/" .. var_10_4)

			arg_10_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = math.min(var_10_1, var_10_3) / var_10_3

			local var_10_5 = arg_10_2:Find("frame/awards")

			arg_9_0:updateAwards(arg_9_1[arg_10_1 + 1]:getConfig("award_display"), var_10_5, (var_10_5:GetChild(0)))

			local var_10_6 = arg_10_2:Find("frame/go_btn")
			local var_10_7 = arg_10_2:Find("frame/get_btn")
			local var_10_8 = arg_10_2:Find("frame/got_btn")

			if arg_9_1[arg_10_1 + 1]:getTaskStatus() == 0 then
				setActive(var_10_6, true)
				setActive(var_10_7, false)
				setActive(var_10_8, false)
			elseif arg_9_1[arg_10_1 + 1]:getTaskStatus() == 1 then
				setActive(var_10_6, false)
				setActive(var_10_7, true)
				setActive(var_10_8, false)
			elseif arg_9_1[arg_10_1 + 1]:getTaskStatus() == 2 then
				setActive(var_10_6, false)
				setActive(var_10_7, false)
				setActive(var_10_8, true)
			end

			onButton(arg_9_0, var_10_6, function()
				arg_9_0:emit(SixYearUsTaskMediator.ON_TASK_GO, var_10_0)

				return
			end, SFX_PANEL)
			onButton(arg_9_0, var_10_7, function()
				arg_9_0:checkAwardOverFlow({
					var_10_0
				}, function()
					arg_9_0:emit(SixYearUsTaskMediator.ON_TASK_SUBMIT, var_10_0)

					return
				end)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_9_0.UIlist:align(#arg_9_1)

	if arg_9_0.canGetAward then
		setActive(arg_9_0.getBtn, true)
		onButton(arg_9_0, arg_9_0.getBtn, function()
			arg_9_0:checkAwardOverFlow(arg_9_0.canGetTaskVOs, function()
				arg_9_0:emit(SixYearUsTaskMediator.ON_TASK_SUBMIT_ONESTEP, arg_9_0.canGetTaskIds)

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(arg_9_0.getBtn, false)
		removeOnButton(arg_9_0.getBtn)
	end

	return
end

function var_0_0.checkAwardOverFlow(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		for iter_16_2, iter_16_3 in ipairs((iter_16_1:getConfig("award_display"))) do
			local var_16_2 = false

			for iter_16_4, iter_16_5 in pairs(var_16_0) do
				if iter_16_5[1] == iter_16_3[1] and iter_16_5[2] == iter_16_3[2] then
					var_16_2 = true
					iter_16_5[3] = iter_16_5[3] + iter_16_3[3]

					break
				end
			end

			if not var_16_2 then
				table.insert(var_16_0, {
					iter_16_3[1],
					iter_16_3[2],
					iter_16_3[3]
				})
			end
		end
	end

	local var_16_3 = 0

	for iter_16_6, iter_16_7 in ipairs(var_16_0) do
		if iter_16_7[2] == var_0_2 then
			var_16_3 = iter_16_7[3]
		end
	end

	local var_16_4, var_16_5 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN):IsOverGold(var_16_3)
	local var_16_6

	if var_16_4 then
		var_16_6 = {
			id = var_0_2,
			type = DROP_TYPE_VITEM,
			count = "<color=#FF5C5CFF>" .. math.abs(var_16_5) .. "</color>"
		}
	end

	local var_16_7 = getProxy(PlayerProxy):getRawData()
	local var_16_8 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
	local var_16_9, var_16_10 = Task.StaticJudgeOverflow(var_16_7.gold, var_16_7.oil, var_16_8, true, true, var_16_0)

	var_16_10 = var_16_10 or {}

	if var_16_6 then
		table.insert(var_16_10, var_16_6)
	end

	if var_16_9 or var_16_4 then
		table.insert({}, function(arg_17_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_16_10,
				onYes = arg_17_0
			})

			return
		end)
	end

	seriesAsync({}, arg_16_2)

	return
end

function var_0_0.updateAwards(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = _.slice(arg_18_1, 1, 3)

	for iter_18_0 = arg_18_2.childCount, #var_18_0 - 1 do
		cloneTplTo(arg_18_3, arg_18_2)
	end

	for iter_18_1 = 1, arg_18_2.childCount do
		local var_18_1 = arg_18_2:GetChild(iter_18_1 - 1)
		local var_18_2 = iter_18_1 <= #var_18_0

		setActive(var_18_1, iter_18_1 <= #var_18_0)

		if var_18_2 then
			local var_18_3 = {
				type = var_18_0[iter_18_1][1],
				id = var_18_0[iter_18_1][2],
				count = var_18_0[iter_18_1][3]
			}

			updateDrop(var_18_1:Find("mask"), {
				type = var_18_0[iter_18_1][1],
				id = var_18_0[iter_18_1][2],
				count = var_18_0[iter_18_1][3]
			})

			if ({
				type = var_18_0[iter_18_1][1],
				id = var_18_0[iter_18_1][2],
				count = var_18_0[iter_18_1][3]
			}).type == DROP_TYPE_EQUIPMENT_SKIN then
				setActive(var_18_1:Find("specialFrame"), true)
			else
				setActive(var_18_1:Find("specialFrame"), false)
			end

			onButton(arg_18_0, var_18_1, function()
				arg_18_0:emit(BaseUI.ON_DROP, var_18_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.UpdateTaskData(arg_20_0)
	local var_20_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SIX_YEAR_US_TASK_ACT_ID)
	local var_20_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SIX_YEAR_US_TASK_2_ACT_ID)

	arg_20_0.taskVOs = {}

	if var_20_0 and not var_20_0:isEnd() then
		for iter_20_0, iter_20_1 in pairs((var_20_0:getConfig("config_data"))) do
			local var_20_2 = getProxy(TaskProxy)

			table.insert(arg_20_0.taskVOs, var_20_2:getTaskVO(iter_20_1))
		end
	end

	if var_20_1 and not var_20_1:isEnd() then
		for iter_20_2, iter_20_3 in pairs((var_20_1:getConfig("config_data"))) do
			local var_20_3 = getProxy(TaskProxy)

			table.insert(arg_20_0.taskVOs, var_20_3:getTaskVO(iter_20_3))
		end
	end

	return
end

function var_0_0.getTaskProgress(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(var_0_1) do
		if iter_21_1[1] == arg_21_1:getConfig("type") and iter_21_1[2] == arg_21_1:getConfig("sub_type") then
			local var_21_0 = arg_21_1:getProgress() / 1000
			local var_21_1 = string.format("%.2d", arg_21_1:getProgress() / 1000)

			return
		end
	end

	local var_21_2 = arg_21_1:getProgress()
	local var_21_3 = tostring(arg_21_1:getProgress())
end

function var_0_0.getTaskTarget(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(var_0_1) do
		if iter_22_1[1] == arg_22_1:getConfig("type") and iter_22_1[2] == arg_22_1:getConfig("sub_type") then
			local var_22_0 = arg_22_1:getConfig("target_num") / 1000
			local var_22_1 = string.format("%.2d", arg_22_1:getConfig("target_num") / 1000)

			return
		end
	end

	local var_22_2 = arg_22_1:getConfig("target_num")
	local var_22_3 = tostring(arg_22_1:getConfig("target_num"))
end

function var_0_0.willExit(arg_23_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_23_0._tf)

	return
end

return var_0_0
