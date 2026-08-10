ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityAccumulativeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/Alone_AccumulateUI/Alone_AccumulateUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.nodeList = {}
	arg_2_0.drawIndex = 0
	arg_2_0.taskUpdateHandler_ = handler(arg_2_0, arg_2_0.TaskUpdate)
	arg_2_0.controller_ = arg_2_0.lastControllerexcollection_:GetController("default0")
	arg_2_0.taskScroll_ = LuaList.New(handler(arg_2_0, arg_2_0.RefreshItem), arg_2_0.uilistUilist_, AccumulativeGachaItem)
end

function var_0_0.RefreshItem(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2:SetData(arg_3_0.tasklist[arg_3_1], arg_3_1)

	if not arg_3_0.tasklist[arg_3_1] or not arg_3_0.tasklist[arg_3_1].state then
		local var_3_0 = 0
	end
end

function var_0_0.OnEnter(arg_4_0)
	var_0_0.super.OnEnter(arg_4_0)
	arg_4_0:TaskUpdate()

	arg_4_0.contentTrs_.localPosition = Vector3.New(-222 * arg_4_0.drawIndex, 0, 0)

	manager.notify:RegistListener(ACCUMULATIVEGACHA_UPDATE, arg_4_0.taskUpdateHandler_)
end

function var_0_0.OnExit(arg_5_0)
	var_0_0.super.OnExit(arg_5_0)
	manager.notify:RemoveListener(ACCUMULATIVEGACHA_UPDATE, arg_5_0.taskUpdateHandler_)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.taskUpdateHandler_ = nil

	arg_6_0.taskScroll_:Dispose()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.nodeList) do
		iter_6_1:Dispose()
	end

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end)
	arg_7_0:AddBtnListener(arg_7_0.descbtnBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_ACCUMULATIVE_INSTRUCTIONS",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_ACCUMULATIVE_INSTRUCTIONS")
		})
	end)
end

function var_0_0.RefreshTimeText(arg_10_0)
	if arg_10_0.texttimeText_ then
		if arg_10_0:isHasLeftTimeDes() then
			local var_10_0, var_10_1 = arg_10_0:CheckAdvanceOpenTime()

			arg_10_0.texttimeText_.text = var_10_1

			arg_10_0:RefreshAcvanceStatus(not var_10_0)
		else
			arg_10_0.texttimeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_10_0.stopTime_, true)
		end
	end
end

function var_0_0.isHasLeftTimeDes(arg_11_0)
	return true
end

function var_0_0.TaskUpdate(arg_12_0)
	arg_12_0.tasklist = ActivityAccumulativeData:GetList(arg_12_0.activityID_)

	arg_12_0.taskScroll_:StartScroll(#arg_12_0.tasklist)

	local var_12_0 = 0

	arg_12_0.descnumTxt_.text = ActivityAccumulativeData:GetNum()

	local var_12_1 = 0
	local var_12_2 = 0
	local var_12_3 = 0
	local var_12_4 = ActivityAccumulativeData:GetNum()
	local var_12_5 = 0

	for iter_12_0 = 1, #arg_12_0.tasklist do
		if not arg_12_0.nodeList[iter_12_0] then
			local var_12_6 = arg_12_0[string.format("point%sGo_", iter_12_0)]

			arg_12_0.nodeList[iter_12_0] = AccumulativeGachaPoint.New(var_12_6)
		end

		local var_12_7 = arg_12_0.tasklist[iter_12_0]
		local var_12_8 = ActivityPointRewardCfg[var_12_7.id]

		var_12_1 = math.max(var_12_1, var_12_8 and var_12_8.need or 0)

		if var_12_4 >= var_12_8.need then
			var_12_5 = iter_12_0
			var_12_3 = var_12_8.need

			local var_12_9 = arg_12_0.tasklist[iter_12_0 + 1]

			if var_12_9 then
				var_12_2 = ActivityPointRewardCfg[var_12_9.id].need
			else
				var_12_2 = 0
			end
		end

		if var_12_8 then
			if var_12_7.state == 2 then
				arg_12_0.drawIndex = math.max(iter_12_0, arg_12_0.drawIndex)
			end

			if ActivityAccumulativeData:GetNum() >= var_12_8.need then
				arg_12_0.nodeList[iter_12_0]:SetIsDraw(true)
			else
				arg_12_0.nodeList[iter_12_0]:SetIsDraw(false)
			end
		end
	end

	if var_12_1 ~= 0 then
		local var_12_10 = 0.10569105691056911
		local var_12_11 = 0.061483739837398375
		local var_12_12 = 0

		if var_12_2 == 0 then
			var_12_12 = 1
		elseif var_12_5 == 0 then
			var_12_12 = var_12_4 / var_12_2 * var_12_11
		else
			var_12_12 = var_12_11 + (var_12_5 - 1) * var_12_10 + (var_12_4 - var_12_3) / (var_12_2 - var_12_3) * var_12_10
		end

		arg_12_0.sliderSlr_.value = math.max(0, math.min(1, var_12_12))
	end
end

return var_0_0
