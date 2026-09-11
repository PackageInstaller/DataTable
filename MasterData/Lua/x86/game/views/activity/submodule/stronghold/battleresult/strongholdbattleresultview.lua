local StrongholdBattleResultView = class("StrongholdBattleResultView", ReduxView)

function StrongholdBattleResultView:UIName()
	return "UI/CooperationBattleResult/CooperationResultUI"
end

function StrongholdBattleResultView:UIParent()
	return manager.ui.uiMain.transform
end

function StrongholdBattleResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdBattleResultView:InitUI()
	self:BindCfgUI()

	self.orderList = LuaList.New(handler(self, self.IndexOrderItem), self.m_orderList, StrongholdBattleResultOrderItem)
	self.intensifyList = LuaList.New(handler(self, self.IndexIntensifyItem), self.m_intensifyList, StrongholdBattleResultIntensifyItem)
	self.achieveList = LuaList.New(handler(self, self.IndexAchieveItem), self.m_achieveList, StrongholdBattleResultAchieveItem)
	self.skillController = ControllerUtil.GetController(self.gameObject_.transform, "skill")
	self.resultController = ControllerUtil.GetController(self.transform_, "result")
	self.itemInfoController = ControllerUtil.GetController(self.transform_, "itemInfo")
end

function StrongholdBattleResultView:AddUIListener()
	self:AddBtnListener(self.m_quitBtn, nil, function()
		BattleInstance.QuitBattle(self.stageData)
	end)
	self:AddBtnListener(self.m_statisticsBtn, nil, function()
		JumpTools.OpenPageByJump("strongholdBattleStatistics", {
			stageData = self.stageData,
			battleTime = self:GetBattleTime()
		})
	end)
	self:AddBtnListener(self.m_infoMask, nil, function()
		self.itemInfoController:SetSelectedIndex(0)
	end)
end

function StrongholdBattleResultView:OnTop()
	return
end

function StrongholdBattleResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.rewardList = self.params_.rewardList

	self:RefreshUI()

	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end

	self.itemInfoController:SetSelectedIndex(0)
end

function StrongholdBattleResultView:OnExit()
	return
end

function StrongholdBattleResultView:RefreshUI()
	local var_13_0 = PlayerData:GetPlayerInfo().userID
	local var_13_1 = 1
	local var_13_2, var_13_3 = self.stageData:GetIsCooperation()

	if var_13_2 then
		for iter_13_0, iter_13_1 in ipairs(var_13_3) do
			if iter_13_1.playerID == var_13_0 then
				var_13_1 = iter_13_0

				break
			end
		end
	end

	self.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", self.stageData:GetHeroDataByPos(var_13_1).using_skin)

	self.orderList:StartScroll(3)

	self.m_difficultyLab.text = ActivityStrongholdCfg[self.stageData:GetDest()].difficulty_des

	if isSuccess(self.params_.result) then
		self.resultController:SetSelectedIndex(0)
	else
		self.resultController:SetSelectedIndex(1)
	end

	self.m_timeLab.text = self:GetBattleTime()
	self.main_activity_id = 0

	local var_13_4 = self.stageData:GetActivityID()

	for iter_13_2, iter_13_3 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
		if table.indexof(ActivityCfg[iter_13_3].sub_activity_list, var_13_4) then
			self.main_activity_id = iter_13_3

			break
		end
	end

	local var_13_5 = LuaExchangeHelper.GetBattleStatisticsData()

	if var_13_5 then
		self.achieveDataList = {}

		local var_13_6 = {}

		for iter_13_4 = 0, var_13_5.finishedAchievement.Count - 1 do
			if ActivityStrongholdAchievementCfg[var_13_5.finishedAchievement[iter_13_4]] and ActivityStrongholdAchievementCfg[var_13_5.finishedAchievement[iter_13_4]].type ~= -1 then
				if ActivityStrongholdAchievementCfg[var_13_5.finishedAchievement[iter_13_4]].type == 0 then
					table.insert(self.achieveDataList, var_13_5.finishedAchievement[iter_13_4])
				else
					var_13_6[ActivityStrongholdAchievementCfg[var_13_5.finishedAchievement[iter_13_4]].type] = var_13_6[ActivityStrongholdAchievementCfg[var_13_5.finishedAchievement[iter_13_4]].type] and math.max(var_13_6[ActivityStrongholdAchievementCfg[var_13_5.finishedAchievement[iter_13_4]].type], var_13_5.finishedAchievement[iter_13_4]) or var_13_5.finishedAchievement[iter_13_4]
				end
			end
		end

		for iter_13_5, iter_13_6 in pairs(var_13_6) do
			table.insert(self.achieveDataList, iter_13_6)
		end

		self.achieveList:StartScroll(#self.achieveDataList)

		self.intensifyDataList = {}

		for iter_13_7 = 0, var_13_5.choosedEffectID.Count - 1 do
			table.insert(self.intensifyDataList, var_13_5.choosedEffectID[iter_13_7])
		end

		self.intensifyList:StartScroll(#self.intensifyDataList)
	else
		self.intensifyList:StartScroll(0)
		self.achieveList:StartScroll(0)
	end

	local var_13_7, var_13_8 = self.stageData:GetType()

	if BattleConst.STAGE_TYPE_NEW.STRONGHOLD ~= var_13_7 then
		var_13_8 = 0
	end

	if var_13_8 and var_13_8 ~= 0 then
		self.skillController:SetSelectedIndex(1)

		self.m_skillIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. var_13_8)
	else
		self.skillController:SetSelectedIndex(0)
	end
end

function StrongholdBattleResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function StrongholdBattleResultView:Dispose()
	self.orderList:Dispose()
	self.intensifyList:Dispose()
	self.achieveList:Dispose()
	StrongholdBattleResultView.super.Dispose(self)
end

function StrongholdBattleResultView:IndexOrderItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(arg_16_1, self.rewardList, self.main_activity_id)
end

function StrongholdBattleResultView:IndexIntensifyItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(self.intensifyDataList[arg_17_1])
	arg_17_2:RegistCallBack(function(arg_18_0)
		self:OnItemClick(arg_18_0)
	end)
end

function StrongholdBattleResultView:IndexAchieveItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(self.achieveDataList[arg_19_1])
end

function StrongholdBattleResultView:OnItemClick(arg_20_1)
	self.itemInfoController:SetSelectedIndex(1)

	self.m_infoName.text = ActivityStrongholdArtifactCfg[arg_20_1].name
	self.m_infoDes.text = ActivityStrongholdArtifactCfg[arg_20_1].desc

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_infoDesTrans)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_infoTrans)
end

return StrongholdBattleResultView
