local HeroClueMainView = class("HeroClueMainView", ReduxView)

function HeroClueMainView:UIName()
	return HeroClueTools.GetMainViewUIName(self.params_.activityID)
end

function HeroClueMainView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroClueMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroClueMainView:InitUI()
	self:BindCfgUI()

	if self.InitController then
		self:InitController()
	end

	self:InitStaticText()
	self:InitClueItem()
end

function HeroClueMainView:InitStaticText()
	if self.titleText_ then
		self.titleText_.text = HeroClueTools.GetActivityTitle(self.params_.activityID)
	end

	if self.activityDescText_ then
		self.activityDescText_.text = HeroClueTools.GetActivityDesc(self.params_.activityID)
	end
end

function HeroClueMainView:InitClueItem()
	self.clueItemList_ = {}

	for iter_6_0 = 1, self.clueContentTrans_.childCount do
		self.clueItemList_[iter_6_0] = HeroClueTools.GetClueItemClass(self.params_.activityID).New(self.clueContentTrans_:GetChild(iter_6_0 - 1).gameObject, HeroClueCfg.get_id_list_by_clue_pool[HeroCluePoolCfg.get_id_list_by_activity_id[self.params_.activityID][1]][iter_6_0], self.params_.activityID, iter_6_0)
	end
end

function HeroClueMainView:AddUIListener()
	self:AddBtnListener(self.drawBtn_, nil, handler(self, self.OnClickDraw))
	self:AddBtnListener(self.rewardBtn_, nil, function()
		local var_8_0

		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			do return end

			var_8_0 = {}
		end

		var_8_0.activityID = HeroClueTools.GetPlayTaskActivityID(self.activityID_)
		var_8_0.mainActivityID = self.activityID_

		JumpTools.OpenPageByJump("heroClueTask", var_8_0)
	end)
end

function HeroClueMainView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.cluePoolID_ = HeroCluePoolCfg.get_id_list_by_activity_id[self.activityID_][1]
	self.clueIdList_ = HeroClueCfg.get_id_list_by_clue_pool[self.cluePoolID_]

	for iter_9_0, iter_9_1 in pairs(self.clueItemList_) do
		iter_9_1:OnEnter()
	end

	self:RefreshUI()
	self:BindRedPoint()
end

function HeroClueMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		HeroCluePoolCfg[self.cluePoolID_].item_id
	})
	manager.windowBar:SetBarCanClick(HeroCluePoolCfg[self.cluePoolID_].item_id, true)
end

function HeroClueMainView:OnExit()
	manager.windowBar:HideBar()

	for iter_11_0, iter_11_1 in pairs(self.clueItemList_) do
		iter_11_1:OnExit()
	end

	self:UnBindRedPoint()
end

function HeroClueMainView:Dispose()
	for iter_12_0, iter_12_1 in ipairs(self.clueItemList_) do
		iter_12_1:Dispose()
	end

	self.clueItemList_ = nil

	HeroClueMainView.super.Dispose(self)
end

function HeroClueMainView:RefreshUI()
	self:RefreshCoin()
	self:RefreshClue()
end

function HeroClueMainView:RefreshClue()
	for iter_14_0, iter_14_1 in pairs(self.clueItemList_) do
		iter_14_1:RefreshUI()
	end
end

function HeroClueMainView:RefreshCoin()
	self.coinNum_.text = HeroClueTools.GetCostOfOneDraw()
	self.coinIcon_.sprite = ItemTools.getItemSprite(HeroCluePoolCfg[self.cluePoolID_].item_id)
end

function HeroClueMainView:OnClickDraw()
	if not ActivityTools.ActivityOpenCheck(self.activityID_) then
		return
	end

	local var_16_0 = true
	local var_16_1 = HeroClueData:GetUnlockClueDataDic()

	for iter_16_0, iter_16_1 in ipairs(self.clueIdList_) do
		if not var_16_1[iter_16_1] then
			var_16_0 = false

			break
		elseif #HeroClueCfg[iter_16_1].level > var_16_1[iter_16_1].level then
			var_16_0 = false

			break
		end
	end

	local var_16_2 = HeroCluePoolCfg[self.cluePoolID_].item_id

	if var_16_0 == true then
		ShowTips(GetTipsF("ACTIVITY_HERO_CLUE_ALL_COLLECTED", (GetI18NText(ItemCfg[var_16_2].name))))

		return
	end

	if ItemTools.getItemNum(var_16_2) < 1 then
		ShowTips(GetTipsF("ACTIVITY_FLIP_CARD_COIN_NOT_ENOUGH", (GetI18NText(ItemCfg[var_16_2].name))))

		return
	end

	HeroClueAction.Draw(self.activityID_, self.cluePoolID_, 1)
end

function HeroClueMainView:OnClueDraw(arg_17_1)
	self:RefreshUI()
	JumpTools.OpenPageByJump("heroClueDrawResult", {
		activityID = self.activityID_,
		rewardList = arg_17_1
	})
end

function HeroClueMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, (string.format("%s_%d", RedPointConst.ACTIVITY_TASK, ActivityCfg[self.activityID_].sub_activity_list[2])))
	manager.redPoint:bindUIandKey(self.drawBtn_.transform, (string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, self.activityID_)))
end

function HeroClueMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, (string.format("%s_%d", RedPointConst.ACTIVITY_TASK, ActivityCfg[self.activityID_].sub_activity_list[2])))
	manager.redPoint:unbindUIandKey(self.drawBtn_.transform, (string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, self.activityID_)))
end

return HeroClueMainView
