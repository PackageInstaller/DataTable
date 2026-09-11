local HeroTrialView_2_0 = class("HeroTrialView_2_0", ReduxView)

function HeroTrialView_2_0:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName(arg_1_2)), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform
	self.activityID_ = arg_1_2

	self:Init()
end

function HeroTrialView_2_0:UIName(arg_2_1)
	return HeroTrialTools.GetMainUIName(arg_2_1)
end

function HeroTrialView_2_0:Init()
	self:InitUI()
	self:AddListeners()
end

function HeroTrialView_2_0:InitUI()
	self:BindCfgUI()

	self.heroItemList_ = {}
	self.rewardItemList_ = {}
	self.itemDataList_ = {}
	self.onClickTrialHandler_ = handler(self, self.OnClickTrial)
	self.OnActivityUpdateHandler_ = handler(self, self.OnActivityUpdate)
	self.adaptImg_ = self:FindCom("AdaptImage", nil, self.imageIcon_.transform)
	self.imageIcon_.immediate = true
	self.goItemParentTrans_ = self.goItemParent_.transform
	self.controller_ = ControllerUtil.GetController(self.transformBtn_, "name")
	self.attackTypeController_ = ControllerUtil.GetController(self.transform_, "attackType")
	self.atackTypeIcon_ = self.atackTypeIcon_ or self.transform_:Find("right_adapt/panel/right/property/type/icon"):GetComponent("Image")
end

function HeroTrialView_2_0:AddListeners()
	self:AddBtnListener(self.btnReceive_, nil, function()
		HeroTrialAction.GetTrialReward(self.activityID_, self.selectActivityHeroID_, function(arg_7_0)
			if isSuccess(arg_7_0.result) then
				getReward(formatRewardCfgList(ActivityHeroTrialCfg[self.selectActivityHeroID_].reward_list))
				self:RefreshReward()
			else
				ShowTips(arg_7_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.btnTrial_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(self.activityHeroIDList_) do
			table.insert(var_8_0, (HeroTrialTools.GetHeroStandardID(iter_8_1)))
		end

		self:Go("/newHero", {
			isEnter = true,
			hid = HeroTrialTools.GetHeroStandardID(self.selectActivityHeroID_),
			type = HeroConst.HERO_DATA_TYPE.TRIAL,
			tempHeroList = var_8_0
		})
	end)
	self:AddBtnListener(self.btnBattle_, nil, function()
		HeroTrialData:SaveStageID(self.selectActivityHeroID_)
		HeroTrialData:SetBattleWay(ActivityHeroTrialConst.BATTLE_WAY.ACTIVITY)
		self:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[self.selectActivityHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_HERO_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_HERO_TRIAL_DESCRIPE")
		})
	end)
end

function HeroTrialView_2_0:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HeroTrialView_2_0:Dispose()
	HeroTrialView_2_0.super.Dispose(self)

	for iter_12_0, iter_12_1 in pairs(self.rewardItemList_) do
		iter_12_1:Dispose()
	end

	self.rewardItemList_ = nil
	self.itemDataList_ = nil

	for iter_12_2, iter_12_3 in pairs(self.heroItemList_) do
		iter_12_3:Dispose()
	end

	self.heroItemList_ = nil
end

function HeroTrialView_2_0:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)

	if arg_13_1 == true then
		self:OnEnable()
	else
		self:OnDisable()
	end
end

function HeroTrialView_2_0:OnEnable()
	self:InitActivityList()
	self:ScrollToLastPos()
	self:RefreshHeroItem()
	self:RefreshUI()
	self:UpdateStopTime()
	self:AddTimer()
	self:RegistEventListener(HERO_TRIAL_CLICK, self.onClickTrialHandler_)
	self:RegistEventListener(ACTIVITY_UPDATE, self.OnActivityUpdateHandler_)
end

function HeroTrialView_2_0:OnDisable()
	self:StopTimer()
	self:RemoveAllEventListener()
	self:SaveLastScrollPos()
end

function HeroTrialView_2_0:InitActivityList()
	self.activityHeroIDList_ = {}

	for iter_16_0, iter_16_1 in ipairs(ActivityCfg[self.activityID_].sub_activity_list) do
		if ActivityData:GetActivityIsOpen(iter_16_1) then
			for iter_16_2, iter_16_3 in ipairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[iter_16_1]) do
				self.activityHeroIDList_[#self.activityHeroIDList_ + 1] = iter_16_3
			end
		end
	end

	local var_16_0 = HeroTrialData:GetHeroTrialStateList()

	table.sort(self.activityHeroIDList_, function(arg_17_0, arg_17_1)
		if var_16_0[arg_17_0] ~= var_16_0[arg_17_1] then
			return var_16_0[arg_17_0] < var_16_0[arg_17_1]
		else
			return arg_17_0 < arg_17_1
		end
	end)
	self:InitSelectActivityHeroID()
end

function HeroTrialView_2_0:InitSelectActivityHeroID()
	local var_18_0 = HeroTrialData:GetSelectActivityHeroID(self.activityID_)

	if not var_18_0 or not table.indexof(self.activityHeroIDList_, var_18_0) then
		var_18_0 = self.activityHeroIDList_[1]
	end

	self.selectActivityHeroID_ = var_18_0

	HeroTrialData:SetSelectActivityHeroID(self.activityID_, self.selectActivityHeroID_)
end

function HeroTrialView_2_0:ScrollToLastPos()
	local var_19_0 = HeroTrialData:GetLastContentPosX(self.activityID_)

	if var_19_0 then
		self.goItemParentTrans_:SetAnchoredPositionX(var_19_0)
	end
end

function HeroTrialView_2_0:SaveLastScrollPos()
	HeroTrialData:SetLastContentPosX(self.activityID_, (self.goItemParentTrans_:GetAnchoredPositionX(nil)))
end

function HeroTrialView_2_0:RefreshHeroItem()
	for iter_21_0, iter_21_1 in ipairs(self.activityHeroIDList_) do
		if self.heroItemList_[iter_21_0] then
			self.heroItemList_[iter_21_0]:SetActivityHeroID(self.activityID_, iter_21_1)
		else
			self.heroItemList_[iter_21_0] = self:GetHeroTrialSelectItemClass().New(self.goItem_, self.goItemParent_, iter_21_1, self.activityID_)
		end
	end

	for iter_21_2 = #self.heroItemList_, #self.activityHeroIDList_ + 1, -1 do
		self.heroItemList_[iter_21_2]:Dispose()

		self.heroItemList_[iter_21_2] = nil
	end

	self:RefreshSelectActivityHero()
end

function HeroTrialView_2_0:RefreshSelectActivityHero()
	for iter_22_0, iter_22_1 in pairs(self.heroItemList_) do
		iter_22_1:OnSelect(self.selectActivityHeroID_)
	end
end

function HeroTrialView_2_0:OnClickTrial(arg_23_1)
	self.selectActivityHeroID_ = arg_23_1

	HeroTrialData:SetSelectActivityHeroID(self.activityID_, self.selectActivityHeroID_)
	self:RefreshUI()
	self:RefreshSelectActivityHero()
	self:UpdateStopTime()
end

function HeroTrialView_2_0:OnActivityUpdate(arg_24_1)
	if ActivityCfg[arg_24_1].activity_template == ActivityTemplateConst.SUB_HERO_TRIAL then
		self:InitActivityList()
		self:RefreshHeroItem()
		self:RefreshUI()
	end
end

function HeroTrialView_2_0:GetHeroTrialSelectItemClass()
	return HeroTrialSelectItem_2_0
end

function HeroTrialView_2_0:RefreshUI()
	self:RefreshHeroUI()
	self:RefreshReward()
end

function HeroTrialView_2_0:RefreshHeroUI()
	self:GetHeroCfg()
	self:RefreshHeroImage()
	self:RefreshHeroName()
	self:RefreshRangeType()
	self:RefreshChargeType()
	self:RefreshAttackType()
	self:RefreshRace()
	self:RefreshRare()
end

function HeroTrialView_2_0:GetHeroCfg()
	self.heroID_ = HeroStandardSystemCfg[HeroTrialTools.GetHeroStandardID(self.selectActivityHeroID_)].hero_id
	self.heroCfg_ = HeroCfg[self.heroID_]
end

function HeroTrialView_2_0:RefreshHeroImage()
	self.imageIcon_.spriteSync = "TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[HeroTrialTools.GetHeroStandardID(self.selectActivityHeroID_)].skin_id].picture_id

	self.imageIcon_:SetNativeSize()

	if self.adaptImg_ then
		self.adaptImg_:AdaptImg()
	end
end

function HeroTrialView_2_0:RefreshHeroName()
	local var_30_0 = string.format("%s·%s", self.heroCfg_.name, self.heroCfg_.suffix)

	self:RefreshTextName(var_30_0)

	self.textTips_.text = string.format(GetTips("COMPLETE_TRAIL_STAGE"), GetI18NText(var_30_0))
end

function HeroTrialView_2_0:RefreshTextName(arg_31_1)
	local var_31_0 = string.split(arg_31_1, "·")

	self.textName_.text = GetI18NText(var_31_0[1])
	self.textSubName_.text = GetI18NText(var_31_0[2])
end

function HeroTrialView_2_0:RefreshRangeType()
	self.rangeTypeText_.text = CharactorParamCfg[self.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

function HeroTrialView_2_0:RefreshChargeType()
	self.chargeType_.text = HeroTools.GetChargeTextByType(self.heroCfg_.mechanism_type[1])
end

function HeroTrialView_2_0:RefreshAttackType()
	if self.atackTypeIcon_ then
		self.atackTypeIcon_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroCfg_.id)
	elseif self.attackTypeController_ then
		if #self.heroCfg_.ATK_attribute > 1 then
			self.attackTypeController_:SetSelectedState(-1)
		else
			self.attackTypeController_:SetSelectedState(self.heroCfg_.ATK_attribute[1])
		end
	end
end

function HeroTrialView_2_0:RefreshRace()
	self.imageRace_.sprite = HeroTools.GetHeroRaceIcon(self.heroCfg_.id)
end

function HeroTrialView_2_0:RefreshRare()
	self.imageLv_.sprite = HeroTools.GetHeroRareSprite(self.heroCfg_.id)
end

function HeroTrialView_2_0:GetRewardItem(arg_37_1)
	return HeroTrialRewardItem_2_0.New(self.goRewardPanel_, self.rewardItemGo_, arg_37_1, true)
end

function HeroTrialView_2_0:RefreshReward()
	self:RefreshRewardState()
	self:RefreshRewardItem()
end

function HeroTrialView_2_0:RefreshRewardState()
	self.rewardState_ = HeroTrialData:GetHeroTrialStateList()[self.selectActivityHeroID_]

	if self.rewardState_ then
		if self.rewardState_ == ActivityHeroTrialConst.REWARD_STATE.RECEIVE then
			self.controller_:SetSelectedState("receive")
		elseif self.rewardState_ == ActivityHeroTrialConst.REWARD_STATE.COMPLETE then
			self.controller_:SetSelectedState("complete")
		else
			self.controller_:SetSelectedState("not")
		end
	else
		self.controller_:SetSelectedState("not")
	end
end

function HeroTrialView_2_0:RefreshRewardItem()
	for iter_40_0 = 1, 3 do
		if not self.itemDataList_[iter_40_0] then
			self.itemDataList_[iter_40_0] = clone(ItemTemplateData)
			self.itemDataList_[iter_40_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		local var_40_0 = true

		if ActivityHeroTrialCfg[self.selectActivityHeroID_].reward_list[iter_40_0] then
			self.itemDataList_[iter_40_0].id = ActivityHeroTrialCfg[self.selectActivityHeroID_].reward_list[iter_40_0][1]
			self.itemDataList_[iter_40_0].number = ActivityHeroTrialCfg[self.selectActivityHeroID_].reward_list[iter_40_0][2]
			self.itemDataList_[iter_40_0].completedFlag = self.rewardState_ == 2
			var_40_0 = false
		end

		if self.rewardItemList_[iter_40_0] == nil then
			self.rewardItemList_[iter_40_0] = CommonItemPool.New(self.goRewardPanel_, nil, true)
		end

		if not var_40_0 then
			self.rewardItemList_[iter_40_0]:SetData(self.itemDataList_[iter_40_0])
		else
			self.rewardItemList_[iter_40_0]:SetData(nil)
		end
	end
end

function HeroTrialView_2_0:UpdateStopTime()
	self.stopTime_ = ActivityData:GetActivityData(ActivityHeroTrialCfg[self.selectActivityHeroID_].activity_id).stopTime
end

function HeroTrialView_2_0:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self:StopTimer()

	self.textTime_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
	self.timer_ = Timer.New(handler(self, self.UpdateTimer), 1, -1)

	self.timer_:Start()
end

function HeroTrialView_2_0:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HeroTrialView_2_0:UpdateTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self:StopTimer()

		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
end

return HeroTrialView_2_0
