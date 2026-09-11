local AreaBattleChapterSectionView = class("AreaBattleChapterSectionView", ReduxView)

function AreaBattleChapterSectionView:UIName()
	return ActivityAreaBattleData:GetPrefabByActivityID(self.params_.mainActivityID) .. "NormalfightingChapterSectionInfoUI"
end

function AreaBattleChapterSectionView:UIParent()
	return manager.ui.uiMain.transform
end

function AreaBattleChapterSectionView:Init()
	self:InitUI()
	self:AddListeners()
end

function AreaBattleChapterSectionView:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller_:GetController("state")
	self.head1Controller = self.head1Controller_:GetController("show")
	self.head2Controller = self.head2Controller_:GetController("show")
	self.head3Controller = self.head3Controller_:GetController("show")
	self.reward1Controller = self.reward1Controller_:GetController("show")
	self.reward2Controller = self.reward2Controller_:GetController("show")
	self.reward3Controller = self.reward3Controller_:GetController("show")

	for iter_4_0 = 1, 6 do
		self["condition" .. iter_4_0 .. "Controller"] = self["condition" .. iter_4_0 .. "Controller_"]:GetController("default0")
	end

	self.proxy = HeroViewDataProxy.New(1)
	self.rewardItemList_ = {}

	for iter_4_1 = 1, 3 do
		item = CommonItemView.New(self["itemGo_" .. iter_4_1], true)
		self.rewardItemList_[iter_4_1] = item
	end
end

function AreaBattleChapterSectionView:OnEnter()
	self:RefreshData()
	self:RefreshUI()
	self:UpdateBar()
end

function AreaBattleChapterSectionView:OnAreaBattleAreaRefresh(arg_6_1)
	self.params_.stageID = arg_6_1

	self:RefreshData()
	self:RefreshUI()
end

function AreaBattleChapterSectionView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AreaBattleChapterSectionView:OnExit()
	self.params_.parent.rewardBtn_.interactable = true
	self.params_.parent.isOpen = nil

	self.params_.parent.moveController:SetSelectedState("0")

	self.params_.selectIndex = nil

	self.super.OnExit(self)
	manager.windowBar:HideBar()
end

function AreaBattleChapterSectionView:AddListeners()
	self:AddBtnListener(self.startBtn_, nil, function()
		local var_10_0 = false

		for iter_10_0, iter_10_1 in pairs(ActivityAreaBattleCfg[self.activityID].stage_id) do
			if iter_10_1[#iter_10_1] == self.stageID then
				var_10_0 = true
			end
		end

		if var_10_0 then
			JumpTools.GoToSystem("/AreaBattleSelectView", {
				stageID = self.stageID,
				activityID = self.activityID,
				mainActivityID = self.mainActivityID,
				difficult = self.difficult
			})
		else
			gameContext:Go("/sectionSelectHero", {
				section = self.stageID,
				sectionType = BattleConst.STAGE_TYPE_NEW.AREA_BATTLE,
				activityID = self.activityID,
				mainActivityID = self.mainActivityID,
				difficult = self.difficult
			})
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_AREA_BATTLE_RESETTING_CONFIRM_TIP1"),
			OkCallback = function()
				local var_13_0 = {
					self.stageID
				}

				if #var_13_0 == 0 then
					ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_FAIL")

					return
				end

				AreaBattleAction.ResetBattleData(self.activityID, var_13_0)
			end
		})
	end)
end

function AreaBattleChapterSectionView:OnAreaBattleAreaReset()
	self:RefreshData()
	self:RefreshUI()
end

function AreaBattleChapterSectionView:RefreshData()
	self.stageID = self.params_.stageID or self.stageID
	self.rewardItemList = DropCfg[BattleAreaBattleCfg[self.stageID].drop_lib_id] and DropCfg[BattleAreaBattleCfg[self.stageID].drop_lib_id].base_drop or {}
	self.params_.parent.isOpen = true
	self.activityID = self.params_.activityID
	self.mainActivityID = self.params_.mainActivityID
	self.difficult = self.params_.difficult
	self.cfg = BattleAreaBattleCfg[self.stageID]
	self.data = ActivityAreaBattleData:GetDataByActivityID(self.mainActivityID)[self.activityID]
	self.maxPoint = 0

	for iter_15_0, iter_15_1 in pairs(self.data.difficultList[self.difficult] or {}) do
		if iter_15_0 ~= self.stageID then
			self.maxPoint = self.maxPoint + iter_15_1.point
		end
	end

	for iter_15_2 = 1, 6 do
		self["condition" .. iter_15_2 .. "Controller"]:SetSelectedState(((self.data.difficultList[self.difficult] and self.data.difficultList[self.difficult][self.stageID] or nil) and self.data.difficultList[self.difficult][self.stageID].point) < iter_15_2 and "state0" or "state1")
	end

	for iter_15_3 = 1, 3 do
		self["condition" .. iter_15_3 .. "Txt_"].text = string.format(GetTips("ACTIVITY_AREA_BATTLE_STAGE_CONDITION"), GameSetting.activity_area_battle_point_arg.value[4 - iter_15_3][1])
	end
end

function AreaBattleChapterSectionView:RefreshUI()
	for iter_16_0 = 1, 3 do
		self["reward" .. iter_16_0 .. "Controller"]:SetSelectedState("false")
	end

	local var_16_0 = false

	for iter_16_1, iter_16_2 in pairs(ActivityAreaBattleCfg[self.activityID].stage_id) do
		if iter_16_2[#iter_16_2] == self.stageID then
			var_16_0 = true
		end
	end

	self.stateController:SetSelectedState(var_16_0 and "hard" or "normal")

	self.params_.parent.rewardBtn_.interactable = false
	self.totalTxt_.text = self.maxPoint .. "/12"

	SetActive(self.noTxt_.gameObject, self.data.allChallengeValue == 0)
	SetActive(self.highScoreTxt_.gameObject, self.data.allChallengeValue ~= 0)

	self.highScoreTxt_.text = self.data.difficultList[self.difficult] and self.data.difficultList[self.difficult][self.stageID] and self.data.difficultList[self.difficult][self.stageID].point or 0

	if self.data.difficultList[self.difficult] == nil or self.data.difficultList[self.difficult][self.stageID] == nil then
		for iter_16_3 = 1, 3 do
			self["head" .. iter_16_3 .. "Controller"]:SetSelectedState("false")
		end
	else
		for iter_16_4 = 1, 3 do
			if self.data.difficultList[self.difficult][self.stageID].usedHeroList[iter_16_4] then
				self["icon" .. iter_16_4 .. "Image_"].sprite = HeroStandardSystemCfg[self.data.difficultList[self.difficult][self.stageID].usedHeroList[iter_16_4]] and getSpriteViaConfig("HeroLittleIcon", HeroStandardSystemCfg[self.data.difficultList[self.difficult][self.stageID].usedHeroList[iter_16_4]].skin_id) or getSpriteViaConfig("HeroLittleIcon", self.proxy:GetHeroUsingSkinInfo(self.data.difficultList[self.difficult][self.stageID].usedHeroList[iter_16_4] % 10000).id)

				self["head" .. iter_16_4 .. "Controller"]:SetSelectedState("true")
			else
				self["head" .. iter_16_4 .. "Controller"]:SetSelectedState("false")
			end
		end
	end

	for iter_16_5 = 1, #self.rewardItemList do
		self["reward" .. iter_16_5 .. "Controller"]:SetSelectedState("true")
	end

	self:RefreshTitleDesc()
	self:RefreshReward()
end

function AreaBattleChapterSectionView:RefreshReward()
	SetActive(self.firstGo_, #self.rewardItemList > 0)

	local var_17_0 = ActivityAreaBattleData:GetStageIdList()

	for iter_17_0 = 1, #self.rewardItemList do
		local var_17_1 = clone(ItemTemplateData)

		var_17_1.id = self.rewardItemList[iter_17_0][1]
		var_17_1.number = self.rewardItemList[iter_17_0][2]

		for iter_17_1, iter_17_2 in pairs(var_17_0) do
			if iter_17_1 == self.stageID then
				var_17_1.completedFlag = true

				break
			end

			var_17_1.completedFlag = false
		end

		function var_17_1:clickFun()
			ShowPopItemOnly(POP_OTHER_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItemList_[iter_17_0]:SetData(var_17_1)
	end
end

function AreaBattleChapterSectionView:RefreshTitleDesc()
	self.nameTxt_.text = self.cfg.name
	self.bgIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleAreaBattleCfg[self.stageID].background_1))
end

function AreaBattleChapterSectionView:Dispose()
	AreaBattleChapterSectionView.super.Dispose(self)

	for iter_20_0, iter_20_1 in pairs(self.rewardItemList_) do
		iter_20_1:Dispose()
	end

	self.rewardItemList_ = nil
end

return AreaBattleChapterSectionView
