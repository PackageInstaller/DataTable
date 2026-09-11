local GuildActivityAffixMainView = class("GuildActivityAffixMainView", ReduxView)

function GuildActivityAffixMainView:UIName()
	return "UI/GuildActivityUI/GuildActivitytalentUI"
end

function GuildActivityAffixMainView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivityAffixMainView:OnCtor()
	return
end

function GuildActivityAffixMainView:Init()
	self.selectRaceItemHandler_ = handler(self, self.OnSelectRaceItem)
	self.selectAffixItemHandler_ = handler(self, self.OnSelectAffixItem)
	self.raceItemList_ = {}
	self.affixItemList_ = {}
	self.affixInfoItemList_ = {}

	self:InitUI()
	self:AddUIListener()
end

function GuildActivityAffixMainView:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.racePanelTrans_, "select")
	self.upgeadeStateController_ = ControllerUtil.GetController(self.transform_, "upgradeState")

	for iter_5_0 = 1, self.racePanelTrans_.childCount do
		self.raceItemList_[iter_5_0] = GuildActivityAffixRaceItem.New(self.racePanelTrans_:GetChild(iter_5_0 - 1))

		self.raceItemList_[iter_5_0]:SetSelectCallBack(self.selectRaceItemHandler_)
	end

	for iter_5_1 = 1, self.affixPanelTrans_.childCount do
		self.affixItemList_[iter_5_1] = GuildActivityAffixItem.New(self.affixPanelTrans_:GetChild(iter_5_1 - 1))

		self.affixItemList_[iter_5_1]:SetSelectCallBack(self.selectAffixItemHandler_)
	end

	for iter_5_2 = 1, self.affixInfoPanelTrans_.childCount do
		self.affixInfoItemList_[iter_5_2] = GuildActivityAffixInfoItem.New(self.affixInfoPanelTrans_:GetChild(iter_5_2 - 1))
	end
end

function GuildActivityAffixMainView:AddUIListener()
	self:AddBtnListener(self.upgradeBtn_, nil, function()
		if self.isMaxLevel_ == true then
			return
		end

		if self.costEnough_ == false then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		GuildActivityAction.UpgradeAffix(self.curAffixID_, function(arg_8_0, arg_8_1)
			if isSuccess(arg_8_0.result) then
				GuildActivityData:UpgradeAffix(self.activityID_, self.curAffixID_)
				self:RefreshAffixItem()

				for iter_8_0, iter_8_1 in ipairs(self.affixInfoItemList_) do
					if self.curAffixLevel_ == iter_8_0 then
						iter_8_1:OnUpgrade()

						break
					end
				end
			else
				ShowTips(GetTips(arg_8_0.result))
			end
		end)
	end)
end

function GuildActivityAffixMainView:AddEventListeners()
	return
end

function GuildActivityAffixMainView:OnEnter()
	self:InitBar()
	self:AddEventListeners()

	self.activityID_ = self.params_.activityID
	self.raceIDList_ = RaceEffectCfg.all

	self:RefreshUI()
	self:BindRedPoint()
end

function GuildActivityAffixMainView:InitBar()
	self.currencyID_ = TalentTreeCfg[TalentTreeCfg.get_id_list_by_activity_id[self.params_.activityID][1]].cost[1][1]

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		self.currencyID_
	})
	manager.windowBar:SetBarCanAdd(self.currencyID_, true)
	manager.windowBar:SetGameHelpKey("CLUB_ACTIVITY_AFFIX_DESC")
end

function GuildActivityAffixMainView:OnTop()
	local var_12_0, var_12_1 = GuildActivityData:CheckRateUpgrade(self.activityID_)

	if var_12_0 == true then
		JumpTools.OpenPageByJump("guildActivityRateUpgrad", {
			rateID = var_12_1
		})
		GuildActivityData:RefreshRateRedPoint(self.params_.activityID)
	end
end

function GuildActivityAffixMainView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	self:UnBindRedPoint()

	for iter_13_0, iter_13_1 in ipairs(self.affixInfoItemList_) do
		iter_13_1:OnExit()
	end
end

function GuildActivityAffixMainView:Dispose()
	self.selectRaceItemHandler_ = nil
	self.selectAffixItemHandler_ = nil

	for iter_14_0, iter_14_1 in ipairs(self.raceItemList_) do
		iter_14_1:Dispose()
	end

	self.raceItemList_ = nil

	for iter_14_2, iter_14_3 in ipairs(self.affixItemList_) do
		iter_14_3:Dispose()
	end

	self.affixItemList_ = nil

	for iter_14_4, iter_14_5 in ipairs(self.affixInfoItemList_) do
		iter_14_5:Dispose()
	end

	self.affixInfoItemList_ = nil

	GuildActivityAffixMainView.super.Dispose(self)
end

function GuildActivityAffixMainView:RefreshUI()
	self:RefreshRaceItem()
end

function GuildActivityAffixMainView:RefreshRaceItem()
	for iter_16_0, iter_16_1 in ipairs(self.raceIDList_) do
		if self.raceItemList_[iter_16_0] then
			self.raceItemList_[iter_16_0]:SetData(iter_16_1)
			self.raceItemList_[iter_16_0]:SetActive(true)
		end
	end

	for iter_16_2 = #self.raceItemList_, #self.raceIDList_ + 1, -1 do
		self.raceItemList_[iter_16_2]:SetActive(false)
	end

	self.curRaceID_ = GuildActivityData:GetSelectRaceID(self.activityID_) or self.raceIDList_[1]

	self:OnSelectRaceItem(self.curRaceID_)
end

function GuildActivityAffixMainView:OnSelectRaceItem(arg_17_1)
	GuildActivityData:SetSelectRaceID(self.activityID_, arg_17_1)

	self.curRaceID_ = arg_17_1

	self.selectController_:SetSelectedState(tostring(self.curRaceID_))
	self:RefreshAffixItem()
end

function GuildActivityAffixMainView:RefreshAffixItem()
	self.affixIDList_ = TalentTreeCfg.get_id_list_by_activity_id_and_race[self.activityID_][self.curRaceID_]
	self.unlockAffixIDList_ = GuildActivityData:GetUnLockAffixList()

	for iter_18_0, iter_18_1 in ipairs(self.affixIDList_) do
		if self.affixItemList_[iter_18_0] then
			self.affixItemList_[iter_18_0]:SetData(iter_18_1, self.unlockAffixIDList_[iter_18_1] ~= nil, self.unlockAffixIDList_[iter_18_1] and self.unlockAffixIDList_[iter_18_1].level or 0)
			self.affixItemList_[iter_18_0]:SetActive(true)
		end
	end

	for iter_18_2 = #self.affixItemList_, #self.affixIDList_ + 1, -1 do
		self.affixItemList_[iter_18_2]:SetActive(false)
	end

	local var_18_3 = GuildActivityData:GetSelectAffixID(self.activityID_, self.curRaceID_)

	self.curAffixID_ = GuildActivityData:GetSelectAffixID(self.activityID_, self.curRaceID_) or self.affixIDList_[1]

	if self.unlockAffixIDList_[self.curAffixID_] then
		self.curAffixLevel_ = self.unlockAffixIDList_[self.curAffixID_].level or 0
	end

	self:OnSelectAffixItem(self.curAffixID_, self.curAffixLevel_)
end

function GuildActivityAffixMainView:OnSelectAffixItem(arg_19_1, arg_19_2)
	GuildActivityData:SetSelectAffixID(self.activityID_, self.curRaceID_, arg_19_1)

	self.curAffixID_ = arg_19_1
	self.curAffixLevel_ = arg_19_2

	for iter_19_0, iter_19_1 in ipairs(self.affixItemList_) do
		iter_19_1:SetSelect(arg_19_1)
	end

	self:RefershAffixInfo()
	self:RefreshUpgradeBtn()
end

function GuildActivityAffixMainView:RefershAffixInfo()
	for iter_20_0, iter_20_1 in ipairs(self.affixInfoItemList_) do
		iter_20_1:SetData(TalentTreeCfg[self.curAffixID_].affix_id, iter_20_0, self.curAffixLevel_)
	end

	self.titleText_.text = GetI18NText(TalentTreeCfg[self.curAffixID_].name)
	self.descText_.text = GetI18NText(TalentTreeCfg[self.curAffixID_].desc)
end

function GuildActivityAffixMainView:RefreshUpgradeBtn()
	if TalentTreeCfg[self.curAffixID_].cost[self.curAffixLevel_ + 1] ~= nil then
		self.isMaxLevel_ = false

		SetActive(self.consumePanelGo_, true)

		self.currencyID_ = TalentTreeCfg[self.curAffixID_].cost[self.curAffixLevel_ + 1][1]
		self.upgradeCost_ = TalentTreeCfg[self.curAffixID_].cost[self.curAffixLevel_ + 1][2]
		self.costEnough_ = self.upgradeCost_ ~= nil and (ItemTools.getItemNum(self.currencyID_) or 0) >= self.upgradeCost_
		self.consumeIcon_.sprite = ItemTools.getItemSprite(self.currencyID_)
		self.consumeNumText_.text = self.costEnough_ == true and self.upgradeCost_ or "<color='#FF0000'>" .. self.upgradeCost_ .. "</color>"
	else
		self.isMaxLevel_ = true

		SetActive(self.consumePanelGo_, false)
	end

	if self.costEnough_ == true and self.isMaxLevel_ == false then
		self.upgeadeStateController_:SetSelectedState("true")
	else
		self.upgeadeStateController_:SetSelectedState("false")
	end
end

function GuildActivityAffixMainView:BindRedPoint()
	for iter_22_0, iter_22_1 in ipairs(self.raceItemList_) do
		iter_22_1:BindRedPoint(self.activityID_)
	end
end

function GuildActivityAffixMainView:UnBindRedPoint()
	for iter_23_0, iter_23_1 in ipairs(self.raceItemList_) do
		iter_23_1:UnBindRedPoint(self.activityID_)
	end
end

return GuildActivityAffixMainView
