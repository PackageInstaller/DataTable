local var_0_0 = class("SkinTrialMainView_2_0", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityID_ = arg_1_2

	local var_1_0 = Asset.Load(arg_1_0:UIName())

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListener()

	arg_2_0.scrollList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiListGo_, arg_2_0:GetItemClass())
	arg_2_0.outOfDataHandler_ = handler(arg_2_0, arg_2_0.OnOutOfData)
end

function var_0_0.UIName(arg_3_0)
	return SkinTrialTools.GetMainViewUIName(arg_3_0.activityID_)
end

function var_0_0.UpdateBar(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.descBtn_, nil, function()
		local var_6_0 = GetTips("ACTIVITY_HERO_TRIAL_DESCRIPE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SKIN_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_6_0
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.stopTime_ = ActivityData:GetActivityData(arg_7_0.activityID_).stopTime

	SkinTrialData:SaveSkinTrialMainScrollPos(nil, "Global")
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:StopTimer()

	arg_8_0.scrollPos_ = arg_8_0.scrollList_:GetScrolledPosition()

	SkinTrialData:SaveSkinTrialMainScrollPos(arg_8_0.scrollPos_, "Global")
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	arg_9_0:StopTimer()

	arg_9_0.outOfDataHandler_ = nil

	arg_9_0.scrollList_:Dispose()

	arg_9_0.scrollList_ = nil

	Object.Destroy(arg_9_0.gameObject_)

	arg_9_0.transform_ = nil
	arg_9_0.gameObject_ = nil
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.skinTrialIDList_ = arg_10_0:GetskinTrialIDList()

	arg_10_0:RefreshSkinItem()
end

function var_0_0.GetskinTrialIDList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = ActivityData:GetActivityData(arg_11_0.activityID_).subActivityIdList

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		if ActivityData:GetActivityIsOpen(iter_11_1) then
			local var_11_2 = ActivitySkinTrialCfg.get_id_list_by_activity_id[iter_11_1]

			for iter_11_2, iter_11_3 in ipairs(var_11_2) do
				table.insert(var_11_0, iter_11_3)
			end
		end
	end

	return var_11_0
end

function var_0_0.RefreshSkinItem(arg_12_0)
	local var_12_0 = arg_12_0.scrollPos_

	if SkinTrialData:GetSkinTrialMainScrollPos("Back") then
		var_12_0 = SkinTrialData:GetSkinTrialMainScrollPos("Back")

		SkinTrialData:SaveSkinTrialMainScrollPos(nil, "Back")
	end

	arg_12_0.scrollList_:StartScrollByPosition(#arg_12_0.skinTrialIDList_, var_12_0)
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetSkinTrialID(arg_13_0.skinTrialIDList_[arg_13_1])
	arg_13_2:SetOutOfDataHandler(arg_13_0.outOfDataHandler_)
end

function var_0_0.GetItemClass(arg_14_0)
	return SkinTrialSelectItem_2_0
end

function var_0_0.AddTimer(arg_15_0)
	if manager.time:GetServerTime() >= arg_15_0.stopTime_ then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.scrollList_:GetItemList()) do
		iter_15_1:RefreshTime()
	end

	arg_15_0:StopTimer()

	arg_15_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_15_0.stopTime_ then
			arg_15_0:StopTimer()

			return
		end

		for iter_16_0, iter_16_1 in ipairs(arg_15_0.scrollList_:GetItemList()) do
			iter_16_1:RefreshTime()
		end
	end, 1, -1)

	arg_15_0.timer_:Start()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_0.Show(arg_18_0, arg_18_1)
	SetActive(arg_18_0.gameObject_, arg_18_1)

	if arg_18_1 == true then
		arg_18_0:AddTimer()
		arg_18_0:RefreshUI()
	else
		arg_18_0:StopTimer()
	end
end

function var_0_0.OnOutOfData(arg_19_0)
	arg_19_0:RefreshUI()
	arg_19_0:AddTimer()
end

return var_0_0
