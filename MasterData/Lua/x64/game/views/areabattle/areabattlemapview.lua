local var_0_0 = {
	EASY = 1,
	HARD = 2
}
local AreaBattleMapView = class("AreaBattleMapView", ReduxView)

function AreaBattleMapView:UIName()
	return ActivityAreaBattleData:GetPrefabByActivityID(self.params_.mainActivityID) .. "NormalfightingMapUI"
end

function AreaBattleMapView:UIParent()
	return manager.ui.uiMain.transform
end

function AreaBattleMapView:Init()
	self:InitUI()
	self:AddUIListener()

	self.proxy = HeroViewDataProxy.New(1)
end

function AreaBattleMapView:InitUI()
	self:BindCfgUI()

	self.easyController = self.easyController_:GetController("lock")
	self.hardController = self.hardController_:GetController("lock")
	self.easySelectController = self.easyController_:GetController("select")
	self.hardSelectController = self.hardController_:GetController("select")
	self.difficultController = self.mainController_:GetController("difficult")
	self.pass1Controller = self.passController1_:GetController("pass")
	self.select1Controller = self.passController1_:GetController("select")
	self.pass2Controller = self.passController2_:GetController("pass")
	self.select2Controller = self.passController2_:GetController("select")
	self.pass3Controller = self.passController3_:GetController("pass")
	self.select3Controller = self.passController3_:GetController("select")
	self.rankController = self.rankController_:GetController("haveRecord")
	self.moveController = self.mainController_:GetController("move")
	self.list = LuaList.New(handler(self, self.SetListItem), self.listGo_, AreaBattleBuffItem)
	self.difficultList = {}
end

function AreaBattleMapView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.cfg.debuff_list[arg_5_1])
end

function AreaBattleMapView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self.isOpen then
			return
		end

		self.selectIndex = nil

		TaskTools:ShowActivityTaskPop(self.activityID, ActivityAreaBattleData:GetPrefabByActivityID(self.mainActivityID) .. "NormalfightingSeizuresTipsUI")
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		SetActive(self.tipsGo_, false)
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		if self.isOpen then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_AREA_BATTLE_RESETTING_CONFIRM_TIP2"),
			OkCallback = function()
				local var_10_1 = {}

				for iter_10_0, iter_10_1 in pairs(self.data.difficultList[self.difficult] or {}) do
					table.insert(var_10_1, iter_10_0)
				end

				if #var_10_1 == 0 then
					ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_FAIL")

					return
				end

				self.selectIndex = nil

				AreaBattleAction.ResetBattleData(self.activityID, var_10_1)
			end
		})
	end)
	self:AddBtnListener(self.normalBtn_, nil, function()
		if self.isOpen then
			return
		end

		if self.difficult == var_0_0.EASY then
			return
		end

		self.difficult = var_0_0.EASY
		self.selectIndex = nil

		SetActive(self.tipsGo_, false)
		self.animator_:Play("NormalfightingMapUI", 0, 0)
		self:UpdateView()
	end)
	self:AddBtnListener(self.hardBtn_, nil, function()
		if self.isOpen then
			return
		end

		if self.difficult == var_0_0.HARD then
			return
		end

		self.difficult = var_0_0.HARD

		self.animator_:Play("NormalfightingMapUI", 0, 0)

		self.selectIndex = nil

		SetActive(self.tipsGo_, false)
		self:UpdateView()
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		if self.isOpen then
			return
		end

		JumpTools.GoToSystem("/AreaBattleRankView", {
			activityID = self.activityID,
			mainActivityID = self.mainActivityID
		})

		self.selectIndex = nil
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.isOpen then
			self.Back()
		end
	end)

	for iter_6_0 = 1, 3 do
		self:AddBtnListener(self["area" .. iter_6_0 .. "Btn_"], nil, function()
			if self["select" .. iter_6_0 .. "Controller"]:GetSelectedState() == "lock" then
				if BattleAreaBattleCfg[self.cfg.stage_id[self.difficult][iter_6_0]].unlock_condition == "" or #BattleAreaBattleCfg[self.cfg.stage_id[self.difficult][iter_6_0]].unlock_condition == 0 then
					return
				end

				ShowTips(ConditionCfg[BattleAreaBattleCfg[self.cfg.stage_id[self.difficult][iter_6_0]].unlock_condition[1]].desc)

				return
			end

			SetActive(self.tipsGo_, false)
			JumpTools.OpenPageByJump("AreaBattleChapterSectionView", {
				stageID = self.cfg.stage_id[self.difficult][iter_6_0],
				activityID = self.activityID,
				mainActivityID = self.mainActivityID,
				difficult = self.difficult,
				parent = self
			})

			for iter_15_0 = 1, 3 do
				if iter_15_0 == iter_6_0 then
					self["select" .. iter_15_0 .. "Controller"]:SetSelectedState("true")
				else
					self["select" .. iter_15_0 .. "Controller"]:SetSelectedState("false")
				end

				local var_15_0 = BattleAreaBattleCfg[self.cfg.stage_id[self.difficult][iter_15_0]].unlock_condition
				local var_15_1 = true

				if BattleAreaBattleCfg[self.cfg.stage_id[self.difficult][iter_15_0]].unlock_condition ~= "" and #var_15_0 > 0 then
					for iter_15_1 = 1, #var_15_0 do
						if not IsConditionAchieved((tonumber(var_15_0[iter_15_1]))) then
							var_15_1 = false

							break
						end
					end
				end

				if not var_15_1 then
					self["select" .. iter_15_0 .. "Controller"]:SetSelectedState("lock")
				end
			end

			self.selectIndex = tostring(iter_6_0)
			self.stageID = self.cfg.stage_id[self.difficult][iter_6_0]

			self.moveController:SetSelectedState(self.selectIndex)

			if self.isOpen then
				manager.notify:CallUpdateFunc(AREA_BATTLE_AREA_REFRESH, self.cfg.stage_id[self.difficult][iter_6_0])
			end

			self.isOpen = true
		end)
	end
end

function AreaBattleMapView:UpdateData()
	self.activityID = self.params_.activityID
	self.difficult = self.difficultList[self.activityID] ~= nil and self.difficultList[self.activityID] or var_0_0.HARD
	self.rankActivityID = ActivityCfg[self.activityID].sub_activity_list[1]
	self.mainActivityID = self.params_.mainActivityID
	self.cfg = ActivityAreaBattleCfg[self.activityID]
	self.data = ActivityAreaBattleData:GetDataByActivityID(self.mainActivityID)[self.activityID]

	for iter_16_0, iter_16_1 in pairs(self.cfg.stage_id[2]) do
		if iter_16_1 == self.stageID then
			self.difficult = var_0_0.HARD
		end
	end
end

function AreaBattleMapView:UpdateView()
	self.easySelectController:SetSelectedState(self.difficult == var_0_0.EASY and "true" or "false")
	self.difficultController:SetSelectedState(tostring(self.difficult))

	if self.cfg.reward_list and type(self.cfg.reward_list) == "table" then
		self.scoreTxt_.text = math.min(self.data.allChallengeValue, self.cfg.reward_list[#self.cfg.reward_list][1]) .. "/" .. self.cfg.reward_list[#self.cfg.reward_list][1]
		self.slider_.value = math.min(self.data.allChallengeValue, self.cfg.reward_list[#self.cfg.reward_list][1]) / self.cfg.reward_list[#self.cfg.reward_list][1]
	end

	self.areaNameTxt_.text = GetI18NText(self.cfg.name)

	self.list:StartScroll(#self.cfg.debuff_list)

	if self.selectIndex then
		self.moveController:SetSelectedState(self.selectIndex)
	end

	self:UpdateAreaItemView()

	self.difficultList[self.activityID] = self.difficult
end

function AreaBattleMapView:UpdateAreaItemView()
	for iter_18_0 = 1, 3 do
		local var_18_0 = self.cfg.stage_id[self.difficult][iter_18_0]

		self["area" .. iter_18_0 .. "NameTxt_"].text = GetI18NText(BattleAreaBattleCfg[self.cfg.stage_id[self.difficult][iter_18_0]].name)

		for iter_18_1 = 1, 3 do
			SetActive(self["lock" .. iter_18_0 .. iter_18_1 .. "Image_"].gameObject, false)

			if self.data.difficultList[self.difficult] and self.data.difficultList[self.difficult][var_18_0] and self.data.difficultList[self.difficult][var_18_0].usedHeroList[iter_18_1] then
				SetActive(self["lock" .. iter_18_0 .. iter_18_1 .. "Image_"].gameObject, true)

				self["lock" .. iter_18_0 .. iter_18_1 .. "Image_"].sprite = HeroStandardSystemCfg[self.data.difficultList[self.difficult][var_18_0].usedHeroList[iter_18_1]] and getSpriteViaConfig("HeroItemshead", HeroStandardSystemCfg[self.data.difficultList[self.difficult][var_18_0].usedHeroList[iter_18_1]].skin_id) or getSpriteViaConfig("HeroItemshead", self.proxy:GetHeroUsingSkinInfo(self.data.difficultList[self.difficult][var_18_0].usedHeroList[iter_18_1] % 10000).id)
			end
		end

		self["select" .. iter_18_0 .. "Controller"]:SetSelectedState("false")

		if self.data.difficultList[self.difficult] == nil or self.data.difficultList[self.difficult][var_18_0] == nil then
			self["pass" .. iter_18_0 .. "Controller"]:SetSelectedState("false")

			if iter_18_0 < 3 then
				self["area" .. iter_18_0 .. "1ScoreTxt_"].text = "0/6"
				self["area" .. iter_18_0 .. "2ScoreTxt_"].text = "0/6"
			end
		else
			self["pass" .. iter_18_0 .. "Controller"]:SetSelectedState("true")

			if iter_18_0 < 3 then
				self["area" .. iter_18_0 .. "1ScoreTxt_"].text = self.data.difficultList[self.difficult][var_18_0].point .. "/6"
				self["area" .. iter_18_0 .. "2ScoreTxt_"].text = self.data.difficultList[self.difficult][var_18_0].point .. "/6"
			else
				self.highScoreTxt_.text = self.data.difficultList[self.difficult][var_18_0].point
			end

			if self.data.difficultList[self.difficult][var_18_0].point == 0 then
				self["pass" .. iter_18_0 .. "Controller"]:SetSelectedState("false")
			end
		end

		local var_18_1 = BattleAreaBattleCfg[var_18_0].unlock_condition
		local var_18_2 = true

		if BattleAreaBattleCfg[var_18_0].unlock_condition ~= "" and #var_18_1 > 0 then
			for iter_18_2 = 1, #var_18_1 do
				if not IsConditionAchieved((tonumber(var_18_1[iter_18_2]))) then
					var_18_2 = false

					break
				end
			end
		end

		if not var_18_2 then
			self["select" .. iter_18_0 .. "Controller"]:SetSelectedState("lock")
		end
	end
end

function AreaBattleMapView:OnEnter()
	self.moveController:SetSelectedState("0")

	if self.params_.selectIndex then
		self.params_.selectIndex = nil
		self.selectIndex = nil
	end

	if self.params_.stageID then
		self.stageID = self.params_.stageID
		self.params_.stageID = nil
	end

	self:UpdateData()
	self:UpdateView()
	self:UpdateDefaultText()
	self:BindRedPoint()
	RankAction.QueryActivityRank(self.rankActivityID)
end

function AreaBattleMapView:DifficultFistEnter()
	if self.data.allChallengeValue ~= 0 and getData("areaBattle", "enter" .. self.activityID) ~= "1" then
		saveData("areaBattle", "enter" .. self.activityID, "1")
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_AREA_BATTLE_AREA_UNLOCK_TIPS"),
			OkCallback = function()
				self.difficult = var_0_0.HARD
				self.selectIndex = nil

				SetActive(self.tipsGo_, false)
				self:UpdateView()
			end
		})
	end
end

function AreaBattleMapView:OnRankUpdate()
	local var_22_0 = RankData:GetActivityRank(self.rankActivityID)

	if var_22_0 then
		local var_22_1, var_22_2 = var_22_0:GetCurRankDes()

		if var_22_2 == GetTips("MATRIX_RANK_NO_INFO") then
			self.rankController:SetSelectedState("false")
		else
			self.rankScoreTxt_.text = var_22_2

			self.rankController:SetSelectedState("true")
		end
	else
		self.rankController:SetSelectedState("false")
	end
end

function AreaBattleMapView:UpdateDefaultText()
	self.lowLableTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_EASY_AREA")
	self.hardLableTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_HARD_AREA")
	self.scoreLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_AREA_SCORE")
	self.resetLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_RESETTING")
	self.rewardLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_REWARD")
	self.rankLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_RANKING_LIST")
	self.normal1LabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_GAIN_POINTS")
	self.normal2LabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_GAIN_POINTS")
	self.hardLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_MAX_SCORE_NON")
	self.hardMaxLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_MAX_SCORE")
	self.noRecordLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_MAX_SCORE_NON")

	SetActive(self.tipsGo_, false)
end

function AreaBattleMapView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_REWARD, self.activityID))
end

function AreaBattleMapView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_REWARD, self.activityID))
end

function AreaBattleMapView:OnExit()
	self.difficult = nil

	manager.windowBar:HideBar()
	self:UnbindRedPoint()
end

function AreaBattleMapView:OnTop()
	self.isOpen = false

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_AREA_BATTLE_DESCRIBE")
	self:UpdateAreaItemView()
	AreaBattleAction.UpdateRewardRedPoint(self.params_.mainActivityID)
end

function AreaBattleMapView:OnAreaBattleAreaReset()
	self:UpdateData()
	self:UpdateView()
	ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_SUCCESS")
end

function AreaBattleMapView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	AreaBattleMapView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleMapView
