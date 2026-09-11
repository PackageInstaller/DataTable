local RechargeTotalRechargeView = class("RechargeTotalRechargeView", ReduxView)

function RechargeTotalRechargeView:UIName()
	return "Widget/System/Recharge/RechargeTotalRechargeUI_New"
end

function RechargeTotalRechargeView:UIParent()
	return manager.ui.uiMain.transform
end

function RechargeTotalRechargeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeTotalRechargeView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, RechargeTotalRechargeItem)
	self.versionList_ = LuaList.New(handler(self, self.IndexVersionItem), self.versionListGo_, RechargeTotalRechargeItem)
	self.showNumController_ = self.transCon_:GetController("showNum")

	local var_4_0 = getData("totalRecharge", "seeToggle")

	self.seeToggle_.isOn = var_4_0 == nil or var_4_0 == 1

	self.showNumController_:SetSelectedState(tostring(var_4_0 == nil or var_4_0 == 1))
end

function RechargeTotalRechargeView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.totalDataList_[arg_5_1], false, self.totalDataList_[arg_5_1 + 1])
end

function RechargeTotalRechargeView:IndexVersionItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.versionDataList_[arg_6_1], true)
end

function RechargeTotalRechargeView:AddUIListener()
	self:AddToggleListener(self.seeToggle_, function(arg_8_0)
		saveData("totalRecharge", "seeToggle", arg_8_0 and 1 or 0)
		self.showNumController_:SetSelectedState(tostring(arg_8_0))
	end)
	self:AddBtnListener(self.btnTips_, nil, function()
		local var_9_0 = {
			titleStatus = false,
			content = GetTips("VERSION_RECHARGE_DESC")
		}

		var_9_0.key = "VERSION_RECHARGE_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_9_0)
	end)
end

function RechargeTotalRechargeView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RechargeTotalRechargeView:OnEnter()
	self:CheckAppendReward()
	self:UpdateList()
	self:UpdateView()

	self.tipText_.text = GetTips("VERSION_RECHARGE_TIPS")

	self:RegistEventListener(TOTAL_RECHARGE_UPDATE, function(arg_12_0)
		self:UpdateList()
		self:UpdateView()
	end)
	self:RegistEventListener(GET_TOTAL_RECHARGE_BONUS, function(arg_13_0)
		self:UpdateList()
		self:UpdateView()
	end)
end

function RechargeTotalRechargeView:CheckAppendReward()
	self.nowVersion_ = RechargeData:GetTotalRechargeVersion()
	self.targetVersion_ = RechargeData:GetTargetVersion()
	self.checkTimer = Timer.New(function()
		if self.targetVersion_ > RechargeData:GetTotalRechargeVersion() then
			local var_15_0 = RechargeData:GetTotalReceiveTotalRechargeList()
			local var_15_1 = {}
			local var_15_2 = {}

			for iter_15_0 = 1, #var_15_0 do
				for iter_15_1 = 1, #TotalRechargeCfg.get_id_list_by_version[self.targetVersion_] do
					if TotalRechargeCfg[TotalRechargeCfg.get_id_list_by_version[self.targetVersion_][iter_15_1]].num == TotalRechargeCfg[var_15_0[iter_15_0]].num then
						table.insertto(var_15_1, TotalRechargeCfg[TotalRechargeCfg.get_id_list_by_version[self.targetVersion_][iter_15_1]].reward)
						table.insert(var_15_2, TotalRechargeCfg.get_id_list_by_version[self.targetVersion_][iter_15_1])

						break
					end
				end
			end

			if #var_15_1 == 0 then
				return
			end

			JumpTools.OpenPageByJump("rechargeAppendPop", {
				appendRewardList = var_15_1,
				appendRewardIdList = var_15_2
			})
		end

		self.checkTimer:Stop()

		self.checkTimer = nil
	end, 0.5, 1)

	self.checkTimer:Start()
end

function RechargeTotalRechargeView:UpdateList()
	self.totalDataList_ = {}
	self.totalJumpIndex_ = 0

	for iter_16_0, iter_16_1 in ipairs((RechargeData:GetNowRewardList())) do
		local var_16_0 = RechargeData:HaveGetTotalRechargeBonus(iter_16_1)

		self.totalDataList_[iter_16_0] = {
			id = iter_16_1,
			index = iter_16_0,
			isReceive = var_16_0
		}

		if var_16_0 == false and self.totalJumpIndex_ == 0 then
			self.totalJumpIndex_ = iter_16_0
		end
	end

	self.versionDataList_ = {}
	self.versionJumpIndex_ = 0

	for iter_16_2, iter_16_3 in ipairs(VersionRechargeCfg.get_id_list_by_version[RechargeData:GetTimeLimitRechargeVersion()] or {}) do
		local var_16_1 = RechargeData:HaveGetTimeLimitRechargeBonus(iter_16_3)

		self.versionDataList_[iter_16_2] = {
			id = iter_16_3,
			index = iter_16_2,
			isReceive = var_16_1
		}

		if var_16_1 == false and self.versionJumpIndex_ == 0 then
			self.versionJumpIndex_ = iter_16_2
		end
	end
end

function RechargeTotalRechargeView:UpdateView()
	self.list_:StartScroll(#self.totalDataList_, self.totalJumpIndex_)
	self.versionList_:StartScroll(#self.versionDataList_, self.versionJumpIndex_)

	self.currentLabel_.text = RechargeData:GetTotalRechargeNum()
	self.versionNum_.text = RechargeData:GetVersionRechargeNum()
	self.totalNum_.text = RechargeData:GetTotalRechargeNum()

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.currencyLayout_)
end

function RechargeTotalRechargeView:OnExit()
	if self.checkTimer then
		self.checkTimer:Stop()

		self.checkTimer = nil
	end

	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function RechargeTotalRechargeView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	if self.versionList_ then
		self.versionList_:Dispose()

		self.versionList_ = nil
	end

	RechargeTotalRechargeView.super.Dispose(self)
end

return RechargeTotalRechargeView
