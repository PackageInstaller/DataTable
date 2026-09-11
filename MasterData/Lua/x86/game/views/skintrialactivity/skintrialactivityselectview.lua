local SkinTrialActivitySelectView = class("SkinTrialActivitySelectView", ReduxView)

function SkinTrialActivitySelectView:UIName()
	return "UI/OsirisUI/OsirisSkinTrialUI_101"
end

function SkinTrialActivitySelectView:UIParent()
	return manager.ui.uiMain.transform
end

function SkinTrialActivitySelectView:Init()
	self:BindCfgUI()

	self.activityID_ = self.params_.activityID
	self.skinTrialID_ = self.params_.skinTrialID
	self.popType_ = POP_ITEM
	self.receivedControllerList_ = {}
	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.itemListGo_, self:GetRewardItem())
	self.adaptImg_ = self:FindCom("AdaptImage", nil, self.skinImageTras_)

	self:AddListeners()
end

function SkinTrialActivitySelectView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.activityID_ = self.params_.activityID
	self.skinTrialID_ = self.params_.skinTrialID

	self:RefreshUI()
end

function SkinTrialActivitySelectView:OnExit()
	manager.windowBar:HideBar()
end

function SkinTrialActivitySelectView:Dispose()
	SkinTrialActivitySelectView.super.Dispose(self)
	self.itemList_:Dispose()

	self.itemList_ = nil
end

function SkinTrialActivitySelectView:AddListeners()
	self:AddBtnListener(self.btnBattle_, nil, function()
		SkinTrialData:SaveStageID(self.skinTrialID_)

		if not ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		self:SaveRoute()
		self:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[self.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = self.activityID_
		})
	end)
end

function SkinTrialActivitySelectView:RefreshUI()
	local var_9_0 = SkinTrialTools.GetHeroStandardID(self.skinTrialID_)
	local var_9_1 = HeroStandardSystemCfg[var_9_0].skin_id

	self.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[HeroStandardSystemCfg[var_9_0].hero_id].name), GetI18NText(HeroCfg[HeroStandardSystemCfg[var_9_0].hero_id].suffix))

	local var_9_2 = SettingData:GetCurrentLanguage()

	if var_9_2 == "fr" or var_9_2 == "de" then
		self.heroNameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[HeroStandardSystemCfg[var_9_0].hero_id].name), GetI18NText(HeroCfg[HeroStandardSystemCfg[var_9_0].hero_id].suffix))
	end

	self.skinDescText_.text = GetI18NText(SkinCfg[var_9_1].desc)

	self:RefreshRoleImage()
	self:RefreshReward()
end

function SkinTrialActivitySelectView:RefreshRoleImage()
	local var_10_0 = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[SkinTrialTools.GetHeroStandardID(self.skinTrialID_)].skin_id].picture_id)

	if var_10_0 ~= nil then
		self.skinImage_.sprite = var_10_0

		self.adaptImg_:AdaptImg()
	end
end

function SkinTrialActivitySelectView:RefreshReward()
	self.rewardCfg_ = getRewardFromDropCfg(BattleSkinTrialStageCfg[ActivitySkinTrialCfg[self.skinTrialID_].stage_id].drop_lib_id, true)

	self.itemList_:StartScroll(#self.rewardCfg_)
end

function SkinTrialActivitySelectView:IndexItem(arg_12_1, arg_12_2)
	local var_12_0 = self:GetCommonItem(arg_12_2)

	var_12_0:RefreshData(rewardToItemTemplate(self.rewardCfg_[arg_12_1]))
	var_12_0:RegistCallBack(function(arg_13_0)
		if self.clickCallback_ then
			if self.clickCallback_() then
				ShowPopItem(self.popType_, arg_13_0)
			end
		else
			ShowPopItem(self.popType_, arg_13_0)
		end
	end)

	if self.receivedControllerList_[arg_12_1] == nil then
		self.receivedControllerList_[arg_12_1] = ControllerUtil.GetController(var_12_0.transform_, "received")
	end

	if SkinTrialData:IsCompleted(self.skinTrialID_) then
		self.receivedControllerList_[arg_12_1]:SetSelectedState("true")
	end

	var_12_0:Show(true)
end

function SkinTrialActivitySelectView:GetRewardItem()
	return CommonItem
end

function SkinTrialActivitySelectView:GetCommonItem(arg_15_1)
	return arg_15_1
end

function SkinTrialActivitySelectView:SaveRoute()
	SkinTrialData:SaveRoute({
		name = "skinTrialSelect",
		activityID = self.activityID_,
		skinTrialID = self.skinTrialID_
	})
end

return SkinTrialActivitySelectView
