local var_0_0 = class("ActivityMainBasePanel", ReduxView)

function var_0_0.GetUIName(arg_1_0)
	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:GetRealActivityId(arg_2_2)

	local var_2_0 = Asset.Load(arg_2_0:GetUIName())

	arg_2_0.gameObject_ = Object.Instantiate(var_2_0, arg_2_1.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:Init()
end

function var_0_0.PreBtnClickCheck(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if ActivityTools.CheckActivityIsSuspended(arg_3_0.activityID_) then
		return false
	end

	return true
end

function var_0_0.AddBtnListener(arg_4_0, arg_4_1, arg_4_2, arg_4_3, ...)
	local var_4_0 = {
		...
	}
	local var_4_1

	if arg_4_1 == nil or type(arg_4_1) == "string" then
		var_4_1 = arg_4_0:FindCom(typeof(Button), arg_4_1, arg_4_2)
	else
		var_4_1 = arg_4_1
	end

	if type(arg_4_3) == "string" then
		var_4_1.onClick:AddListener(function()
			if arg_4_0:PreBtnClickCheck(var_4_1, arg_4_1, arg_4_2) then
				arg_4_0:RecordOperation(var_4_1)
				arg_4_0[arg_4_3](arg_4_0, unpack(var_4_0))
			end
		end)
	else
		var_4_1.onClick:AddListener(function()
			if arg_4_0:PreBtnClickCheck(var_4_1, arg_4_1, arg_4_2) then
				arg_4_0:RecordOperation(var_4_1)
				arg_4_3(unpack(var_4_0))
			end
		end)
	end

	arg_4_0:SetListener(var_4_1.onClick)
end

function var_0_0.Init(arg_7_0)
	arg_7_0:BindCfgUI()
	arg_7_0:AddListeners()
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = ActivityData:GetActivityData(arg_8_0.activityID_)

	arg_8_0.startTime_ = var_8_0.startTime
	arg_8_0.stopTime_ = var_8_0.stopTime

	arg_8_0:AddTimer()
	arg_8_0:HideRedPoint()
	arg_8_0:UpdateTitleShow()
end

function var_0_0.UpdatePreview(arg_9_0)
	if arg_9_0.preRewardListGo_ == nil then
		arg_9_0.preRewardListGo_ = arg_9_0:FindGo("panel/middle_adapt/Activity_Com_list03/content/UIList")
	end

	if arg_9_0.preRewardListGo_ and arg_9_0.preRewardList_ == nil then
		arg_9_0.preRewards_ = {}
		arg_9_0.preRewardList_ = LuaList.New(handler(arg_9_0, arg_9_0.IndexPreviewItem), arg_9_0.preRewardListGo_, CommonItemView)
	end

	local var_9_0 = ActivityCfg[arg_9_0.activityID_]

	if var_9_0 and var_9_0.reward_show and var_9_0.reward_show ~= "" and arg_9_0.preRewardList_ and arg_9_0.preRewardListGo_ then
		local var_9_1 = {}

		for iter_9_0, iter_9_1 in ipairs(var_9_0.reward_show) do
			table.insert(var_9_1, rewardToItemTemplate({
				id = iter_9_1
			}, nil, true))
		end

		arg_9_0.preRewards_ = ItemTools.SortRewardItemList(var_9_1)

		arg_9_0.preRewardList_:StartScroll(#arg_9_0.preRewards_)
	end
end

function var_0_0.IndexPreviewItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.preRewards_[arg_10_1])
end

local var_0_1 = {
	"panel/middle_adapt/Activity_Com_tittle01/root/title/content/textTittle",
	"panel/middle_adapt/Activity_Com_tittle02/root/title/content/textTittle",
	"panel/middle_adapt/Activity_Com_tittle03/root/title/content/textTittle",
	"panel/middle_adapt/Activity_Com_tittle04/root/title/content/textTittle"
}
local var_0_2 = {
	"panel/middle_adapt/Activity_Com_tittle01/root/title/textcontent",
	"panel/middle_adapt/Activity_Com_tittle02/root/textcontent/Viewport/Content/text",
	"panel/middle_adapt/Activity_Com_tittle03/root/title/textcontent",
	"panel/middle_adapt/Activity_Com_tittle04/root/textcontent/Viewport/Content/text"
}

function var_0_0.UpdateTitleShow(arg_11_0)
	local var_11_0 = ActivityToggleCfg.get_id_list_by_activity_id[arg_11_0.toggleActivityID_]
	local var_11_1

	if var_11_0 then
		var_11_1 = var_11_0[1]
	end

	if not var_11_1 then
		return
	end

	if not arg_11_0.descText_ then
		for iter_11_0, iter_11_1 in pairs(var_0_2) do
			local var_11_2 = arg_11_0:FindGo(iter_11_1)

			if var_11_2 then
				arg_11_0.descText_ = var_11_2:GetComponent(typeof(Text))

				break
			end
		end
	end

	if not arg_11_0.titleTxt_ then
		for iter_11_2, iter_11_3 in pairs(var_0_1) do
			local var_11_3 = arg_11_0:FindGo(iter_11_3)

			if var_11_3 then
				arg_11_0.titleTxt_ = var_11_3:GetComponent(typeof(Text))

				break
			end
		end
	end

	local var_11_4 = ActivityToggleCfg[var_11_1]

	if var_11_4 and var_11_4.name ~= "" and arg_11_0.titleTxt_ then
		arg_11_0.titleTxt_.text = GetI18NText(var_11_4.name)
	end

	if var_11_4 and var_11_4.desc ~= "" and arg_11_0.descText_ then
		arg_11_0.descText_.text = GetI18NText(var_11_4.desc)
	end
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:StopTimer()
end

function var_0_0.OnTop(arg_13_0)
	return
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)

	if arg_15_0.preRewardList_ then
		arg_15_0.preRewardList_:Dispose()

		arg_15_0.preRewardList_ = nil
	end

	Object.Destroy(arg_15_0.gameObject_)

	arg_15_0.transform_ = nil
	arg_15_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_16_0)
	return
end

function var_0_0.Show(arg_17_0, arg_17_1)
	SetActive(arg_17_0.gameObject_, arg_17_1)

	if arg_17_1 then
		arg_17_0:UpdatePreview()
	end
end

function var_0_0.HideRedPoint(arg_18_0)
	return
end

function var_0_0.AddTimer(arg_19_0)
	arg_19_0:StopTimer()
	arg_19_0:RefreshTimeText()

	arg_19_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_19_0.stopTime_ then
			return
		end

		arg_19_0:RefreshTimeText()
	end, 1, -1)

	arg_19_0.timer_:Start()
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.timer_ then
		arg_21_0.timer_:Stop()

		arg_21_0.timer_ = nil
	end
end

function var_0_0.RefreshTimeText(arg_22_0)
	if arg_22_0.timeText_ then
		if not arg_22_0:isHasLeftTimeDes() then
			local var_22_0, var_22_1 = arg_22_0:CheckAdvanceOpenTime()

			arg_22_0.timeText_.text = var_22_1

			arg_22_0:RefreshAcvanceStatus(not var_22_0)
		else
			arg_22_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_22_0.stopTime_, true)
		end
	end
end

function var_0_0.isHasLeftTimeDes(arg_23_0)
	return false
end

function var_0_0.IsActivityTime(arg_24_0)
	if manager.time:GetServerTime() < arg_24_0.startTime_ then
		local var_24_0 = GetTips("OPEN_TIME")

		ShowTips(string.format(var_24_0, manager.time:GetLostTimeStrWith2Unit(arg_24_0.startTime_, true)))

		return false
	end

	if manager.time:GetServerTime() >= arg_24_0.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function var_0_0.CheckAdvanceOpenTime(arg_25_0)
	local var_25_0 = 0
	local var_25_1 = 0
	local var_25_2 = ActivityData:GetActivityData(arg_25_0.activityID_)

	if arg_25_0.isAdvanceActivity_ then
		var_25_1 = var_25_2.startTime
		var_25_0 = var_25_1 - manager.time:GetServerTime()
	end

	local var_25_3 = arg_25_0.isAdvanceActivity_ and var_25_0 > 0

	arg_25_0.stopTime_ = var_25_3 and var_25_2.startTime or var_25_2.stopTime

	local var_25_4 = var_25_3 and string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_25_1)) or manager.time:GetLostTimeStrWith2UnitWithPrefix(var_25_2.stopTime)

	return var_25_3, var_25_4
end

function var_0_0.GetRealActivityId(arg_26_0, arg_26_1)
	local var_26_0 = ActivityData:GetActivityData(arg_26_1)

	arg_26_0.isAdvanceActivity_ = var_26_0.template == ActivityTemplateConst.ACTIVITY_ADVANCE_OPEN or var_26_0.template == ActivityTemplateConst.ACTIVITY_ADVANCE_PRE_OPEN
	arg_26_0.toggleActivityID_ = arg_26_1
	arg_26_0.activityID_ = arg_26_0.isAdvanceActivity_ and var_26_0.subActivityIdList[1] or arg_26_1
end

function var_0_0.RefreshAcvanceStatus(arg_27_0, arg_27_1)
	return
end

function var_0_0.BindHelpBtn(arg_28_0, arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or arg_28_0.tipsBtn_

	if isNil(arg_28_2) then
		return
	end

	local var_28_0 = type(arg_28_1)
	local var_28_1

	if var_28_0 == "function" then
		var_28_1 = arg_28_1
	else
		local var_28_2
		local var_28_3

		if var_28_0 == "string" then
			local var_28_4 = GetTips(arg_28_1)

			var_28_2, var_28_3 = "gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = var_28_4,
				key = arg_28_1
			}
		elseif var_28_0 == "table" then
			var_28_2, var_28_3 = arg_28_1.view, arg_28_1.params
		end

		if var_28_2 then
			function var_28_1()
				JumpTools.OpenPageByJump(var_28_2, var_28_3)
			end
		end
	end

	arg_28_0:AddBtnListenerScale(arg_28_2, nil, var_28_1)
end

return var_0_0
