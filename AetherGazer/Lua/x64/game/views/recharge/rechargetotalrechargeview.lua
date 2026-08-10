local var_0_0 = class("RechargeTotalRechargeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeTotalRechargeUI_New"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, RechargeTotalRechargeItem)
	arg_4_0.versionList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexVersionItem), arg_4_0.versionListGo_, RechargeTotalRechargeItem)
	arg_4_0.showNumController_ = arg_4_0.transCon_:GetController("showNum")

	local var_4_0 = getData("totalRecharge", "seeToggle")

	arg_4_0.seeToggle_.isOn = (var_4_0 == nil or var_4_0 == 1) and true or false

	arg_4_0.showNumController_:SetSelectedState(tostring(var_4_0 == nil or var_4_0 == 1))
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.totalDataList_[arg_5_1], false, arg_5_0.totalDataList_[arg_5_1 + 1])
end

function var_0_0.IndexVersionItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.versionDataList_[arg_6_1], true)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddToggleListener(arg_7_0.seeToggle_, function(arg_8_0)
		saveData("totalRecharge", "seeToggle", arg_8_0 and 1 or 0)
		arg_7_0.showNumController_:SetSelectedState(tostring(arg_8_0))
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnTips_, nil, function()
		local var_9_0 = "VERSION_RECHARGE_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			titleStatus = false,
			content = GetTips(var_9_0),
			key = var_9_0
		})
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:CheckAppendReward()
	arg_11_0:UpdateList()
	arg_11_0:UpdateView()

	arg_11_0.tipText_.text = GetTips("VERSION_RECHARGE_TIPS")

	arg_11_0:RegistEventListener(TOTAL_RECHARGE_UPDATE, function(arg_12_0)
		arg_11_0:UpdateList()
		arg_11_0:UpdateView()
	end)
	arg_11_0:RegistEventListener(GET_TOTAL_RECHARGE_BONUS, function(arg_13_0)
		arg_11_0:UpdateList()
		arg_11_0:UpdateView()
	end)
end

function var_0_0.CheckAppendReward(arg_14_0)
	arg_14_0.nowVersion_ = RechargeData:GetTotalRechargeVersion()
	arg_14_0.targetVersion_ = RechargeData:GetTargetVersion()
	arg_14_0.checkTimer = Timer.New(function()
		if arg_14_0.targetVersion_ > RechargeData:GetTotalRechargeVersion() then
			local var_15_0 = RechargeData:GetTotalReceiveTotalRechargeList()
			local var_15_1 = #var_15_0
			local var_15_2 = TotalRechargeCfg.get_id_list_by_version[arg_14_0.targetVersion_]
			local var_15_3 = {}
			local var_15_4 = {}

			for iter_15_0 = 1, var_15_1 do
				local var_15_5 = var_15_0[iter_15_0]

				for iter_15_1 = 1, #var_15_2 do
					local var_15_6 = var_15_2[iter_15_1]

					if TotalRechargeCfg[var_15_6].num == TotalRechargeCfg[var_15_5].num then
						table.insertto(var_15_3, TotalRechargeCfg[var_15_6].reward)
						table.insert(var_15_4, var_15_6)

						break
					end
				end
			end

			if #var_15_3 == 0 then
				return
			end

			JumpTools.OpenPageByJump("rechargeAppendPop", {
				appendRewardList = var_15_3,
				appendRewardIdList = var_15_4
			})
		end

		arg_14_0.checkTimer:Stop()

		arg_14_0.checkTimer = nil
	end, 0.5, 1)

	arg_14_0.checkTimer:Start()
end

function var_0_0.UpdateList(arg_16_0)
	arg_16_0.totalDataList_ = {}
	arg_16_0.totalJumpIndex_ = 0

	local var_16_0 = RechargeData:GetNowRewardList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = RechargeData:HaveGetTotalRechargeBonus(iter_16_1)

		arg_16_0.totalDataList_[iter_16_0] = {
			id = iter_16_1,
			index = iter_16_0,
			isReceive = var_16_1
		}

		if var_16_1 == false and arg_16_0.totalJumpIndex_ == 0 then
			arg_16_0.totalJumpIndex_ = iter_16_0
		end
	end

	arg_16_0.versionDataList_ = {}
	arg_16_0.versionJumpIndex_ = 0

	local var_16_2 = RechargeData:GetTimeLimitRechargeVersion()
	local var_16_3 = VersionRechargeCfg.get_id_list_by_version[var_16_2] or {}

	for iter_16_2, iter_16_3 in ipairs(var_16_3) do
		local var_16_4 = RechargeData:HaveGetTimeLimitRechargeBonus(iter_16_3)

		arg_16_0.versionDataList_[iter_16_2] = {
			id = iter_16_3,
			index = iter_16_2,
			isReceive = var_16_4
		}

		if var_16_4 == false and arg_16_0.versionJumpIndex_ == 0 then
			arg_16_0.versionJumpIndex_ = iter_16_2
		end
	end
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0.list_:StartScroll(#arg_17_0.totalDataList_, arg_17_0.totalJumpIndex_)
	arg_17_0.versionList_:StartScroll(#arg_17_0.versionDataList_, arg_17_0.versionJumpIndex_)

	arg_17_0.currentLabel_.text = RechargeData:GetTotalRechargeNum()
	arg_17_0.versionNum_.text = RechargeData:GetVersionRechargeNum()
	arg_17_0.totalNum_.text = RechargeData:GetTotalRechargeNum()

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.currencyLayout_)
end

function var_0_0.OnExit(arg_18_0)
	if arg_18_0.checkTimer then
		arg_18_0.checkTimer:Stop()

		arg_18_0.checkTimer = nil
	end

	arg_18_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.list_ then
		arg_19_0.list_:Dispose()

		arg_19_0.list_ = nil
	end

	if arg_19_0.versionList_ then
		arg_19_0.versionList_:Dispose()

		arg_19_0.versionList_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
