local SimBusinessChooseStageView = class("SimBusinessChooseStageView", ReduxView)

function SimBusinessChooseStageView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_RewardStagePopUI"
end

function SimBusinessChooseStageView:UIParent()
	return manager.ui.uiPop.transform
end

function SimBusinessChooseStageView:OnCtor()
	return
end

function SimBusinessChooseStageView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.clientList = LuaList.New(handler(self, self.indexClientItem), self.clientUilistGo_, SimBusinessGuestInfoItem)
	self.awardList = LuaList.New(handler(self, self.indexAwardItem), self.awardUilistGo_, CommonItemView)
	self.leftBtnController = self.btnlControllerexcollection_:GetController("click")
	self.rightBtnController = self.btnrControllerexcollection_:GetController("click")
	self.recordBtnController = self.controller:GetController("record")
	self.clientShowController = self.controller:GetController("clientShow")
	self.stageTypeController = self.controller:GetController("stageType")
	self.specialStateController = self.specialController:GetController("state")
	self.clientInfoPage = SimBusinessClientPage.New(self.clientGo)
end

function SimBusinessChooseStageView:OnEnter()
	return
end

function SimBusinessChooseStageView:AddUIListener()
	self:AddBtnListener(self.backBtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.startBtn, nil, function()
		SimBusinessGame.GetInstance():UpdatePreviewPath(function(arg_9_0)
			if arg_9_0 then
				self:Back()
				SimBusinessGame.GetInstance():StartGame()
			else
				ShowTips("SIM_BUSINESS_NO_VALID_PATH")
			end
		end)
	end)
	self:AddBtnListener(self.reStartBtn, nil, function()
		local var_10_0 = SimBusinessGame.GetInstance()

		var_10_0:UpdatePreviewPath(function(arg_11_0)
			if arg_11_0 then
				self:Back()
				var_10_0:ResetStage(var_10_0.stage)
				var_10_0:StartGame()
			else
				ShowTips("SIM_BUSINESS_NO_VALID_PATH")
			end
		end)
	end)
	self:AddBtnListener(self.btnlBtn_, nil, function()
		local var_12_0 = self:GetStageIndex()

		if var_12_0 <= 1 then
			return
		end

		self.stageID = SimBusinessStageCfg.all[var_12_0 - 1]

		self:RefreshView()
	end)
	self:AddBtnListener(self.btnrBtn_, nil, function()
		local var_13_0 = self:GetStageIndex()

		if var_13_0 >= #SimBusinessStageCfg.get_id_list_by_type[SimBusinessConst.LevelType.DAILY] then
			return
		end

		self.stageID = SimBusinessStageCfg.all[var_13_0 + 1]

		self:RefreshView()
	end)
	self:AddBtnListener(self.showBackBtn_, nil, function()
		if self.clientShowController:GetSelectedState() == "show" then
			self.clientShowController:SetSelectedState("null")

			self.selectID = nil

			self.clientList:Refresh()
		end
	end)
end

function SimBusinessChooseStageView:OnTop()
	self.stageID = self.params_.stageID or self.stageID

	self:RefreshView()
end

function SimBusinessChooseStageView:OnExit()
	if self.stageType == SimBusinessConst.LevelType.DAILY then
		self.stageID = SimBusinessTools.GetDefaultEnterDailyLevel()

		if self.stageID then
			SimBusinessBridge.EnterLevel(self.stageID)
		else
			DormMinigame.Exit()
		end
	end
end

function SimBusinessChooseStageView:RefreshView()
	self.stageID = self.stageID or SimBusinessStageCfg.all[1]
	self.stageType = SimBusinessStageCfg[self.stageID].type

	self:RefreshStageState()
	self:RefreshClientList()
	self:RefreshAwardList()
end

function SimBusinessChooseStageView:RefreshStageState()
	if self.stageType == SimBusinessConst.LevelType.DAILY then
		self.stageTypeController:SetSelectedState("normal")
		self:RefreshNormalStageInfo()
	elseif self.stageType == SimBusinessConst.LevelType.CHALLENGE then
		self.stageTypeController:SetSelectedState("special")
		self:RefreshSpecialStageInfo()
	end
end

function SimBusinessChooseStageView:RefreshNormalStageInfo()
	self.stageIndex.text = self:GetStageIndex()

	if self.stageID == SimBusinessStageCfg.all[1] then
		self.leftBtnController:SetSelectedState("no")
	else
		self.leftBtnController:SetSelectedState("yes")
	end

	if self.stageID == SimBusinessStageCfg.get_id_list_by_type[SimBusinessConst.LevelType.DAILY][#SimBusinessStageCfg.get_id_list_by_type[SimBusinessConst.LevelType.DAILY]] then
		self.rightBtnController:SetSelectedState("no")
	else
		self.rightBtnController:SetSelectedState("yes")
	end

	local var_19_0, var_19_1 = SimBusinessTools.GetStageState(self.stageID)

	if var_19_0 == "lock" then
		self.recordBtnController:SetSelectedState("lock")

		self.lockTips.text = GetTips(var_19_1)

		return
	end

	if SimBusinessData.level[self.stageID] then
		if SimBusinessData.level[self.stageID].clear then
			if SimBusinessTools.IsChallengeLevel(self.stageID) then
				self.recordBtnController:SetSelectedState("clear")
			else
				self.recordBtnController:SetSelectedState("clearDaily")
			end
		else
			self.recordBtnController:SetSelectedState("inProgress")
		end
	else
		self.recordBtnController:SetSelectedState("notStartYet")
	end
end

function SimBusinessChooseStageView:RefreshSpecialStageInfo()
	self.specialname.text = SimBusinessStageCfg[self.stageID].name
	self.speialIcon.sprite = SimBusinessTools.GetStageIcon(self.stageID)

	local var_20_0, var_20_1 = SimBusinessTools.GetStageState(self.stageID)

	if var_20_0 ~= "lock" then
		if var_20_1 then
			self.specialStateController:SetSelectedState("record")

			self.specialRecord.text = var_20_1
		else
			self.specialStateController:SetSelectedState("null")
		end
	end
end

function SimBusinessChooseStageView:RefreshClientList()
	if self.stageID then
		self.clientInfoList = {}

		for iter_21_0, iter_21_1 in ipairs(SimBusinessStageCfg[self.stageID].wave) do
			table.insert(self.clientInfoList, {
				id = iter_21_1[1],
				remain = iter_21_1[2],
				max = iter_21_1[2]
			})
		end

		self.clientList:StartScroll(#self.clientInfoList)
	end
end

function SimBusinessChooseStageView:indexClientItem(arg_22_1, arg_22_2)
	arg_22_2:RefreshData(self.clientInfoList[arg_22_1], arg_22_1, self.selectID == self.clientInfoList[arg_22_1].id, true)
	arg_22_2:RegisterClickFunc(handler(self, self.clickClientFunc))
end

function SimBusinessChooseStageView:clickClientFunc(arg_23_1)
	self.selectID = arg_23_1.guestID

	self.clientList:Refresh()
	self.clientShowController:SetSelectedState("show")
	self.clientInfoPage:RefreshView(self.clientInfoList[arg_23_1.index].id, self.clientInfoList[arg_23_1.index].max)
end

function SimBusinessChooseStageView:RefreshAwardList()
	if self.stageID then
		self.awardInfoList = nullable(SimBusinessData.level[self.stageID], "clear") and {} or SimBusinessStageCfg[self.stageID].reward_list

		self.awardList:StartScroll(#self.awardInfoList)
	end
end

function SimBusinessChooseStageView:indexAwardItem(arg_25_1, arg_25_2)
	arg_25_2:SetData((rewardToPopableItemTemplate(formatReward(self.awardInfoList[arg_25_1]))))
end

function SimBusinessChooseStageView:GetStageIndex()
	if self.stageID then
		for iter_26_0, iter_26_1 in ipairs(SimBusinessStageCfg.get_id_list_by_type[self.stageType]) do
			if iter_26_1 == self.stageID then
				return iter_26_0
			end
		end
	end
end

function SimBusinessChooseStageView:Dispose()
	self.clientList:Dispose()
	self.awardList:Dispose()
	self.clientInfoPage:Dispose()
	SimBusinessChooseStageView.super.Dispose(self)
end

return SimBusinessChooseStageView
