local LimitTimeSkinUsePopView = class("LimitTimeSkinUsePopView", ReduxView)

function LimitTimeSkinUsePopView:UIName()
	return "Widget/System/Recharge/LimitTimeSkinUsePopUI"
end

function LimitTimeSkinUsePopView:UIParent()
	return manager.ui.uiPop.transform
end

function LimitTimeSkinUsePopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function LimitTimeSkinUsePopView:InitUI()
	self:BindCfgUI()

	self.skinOwnController_ = self.skinController_:GetController("owned2")
	self.dlcOwnController_ = self.dlcController_:GetController("owned2")
	self.stateController_ = self.controller_:GetController("state")
	self.tipsController_ = self.controller_:GetController("tips")
	self.btnController_ = self.controller_:GetController("btn")
	self.skinItem_ = CommonItemView.New(self.skinItemGo_)
	self.dlcItem_ = CommonItemView.New(self.dlcItemGo_)
end

function LimitTimeSkinUsePopView:AddUIListeners()
	self:AddBtnListener(self.tipsBtn_, nil, function()
		if self:HasOwnAllItem() then
			return
		end

		self.showSkin_ = not self.showSkin_

		self.tipsController_:SetSelectedState(tostring(self.showSkin_))
	end)
	self:AddBtnListener(self.mask_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.hadBtn_, nil, function()
		self:CheckCanUse()
	end)
	self:AddBtnListener(self.yesBtn_, nil, function()
		if not self:CheckCanUse() then
			return
		end

		CommonAction.TryToUseItemWitchCallback({
			{
				item_info = {
					num = 1,
					id = self.itemId_,
					time_valid = self.timeValid
				},
				use_list = {}
			}
		}, function(arg_11_0)
			self:UseItemSuccess(arg_11_0)
		end)
	end)
end

function LimitTimeSkinUsePopView:UseItemSuccess(arg_12_1)
	self._dropList = arg_12_1.drop_list

	HeroAction.SelectSkin(SkinCfg[self.skinId_].hero, self.skinId_)
end

function LimitTimeSkinUsePopView:OnSelectSkin(arg_13_1, arg_13_2)
	if self.showSkin_ then
		PlayerAction.ChangePosterGirl(SkinCfg[self.skinId_].hero)
		HomeSceneSettingAction.SetHomeScene(self.dlcId_, true)
	end

	self:Back()

	if self._dropList then
		getReward(self._dropList)
	end

	self._dropList = nil
end

function LimitTimeSkinUsePopView:OnEnter()
	self.itemId_ = self.params_.itemData.id
	self.timeValid = ItemTools.GetItemExpiredTimeByInfo(self.params_.itemData)
	self.cfg_ = ItemCfg[self.itemId_]
	self.reward_ = self.cfg_.param
	self.dlcId_ = nil
	self.skinId_ = nil
	self.LimitDlcId_ = nil
	self.LimitskinItemId_ = nil

	for iter_14_0, iter_14_1 in ipairs(self.reward_) do
		if ItemCfg[iter_14_1].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			self.LimitskinItemId_ = iter_14_1
		elseif ItemCfg[iter_14_1].type == ItemConst.ITEM_TYPE.SCENE then
			self.LimitDlcId_ = iter_14_1
		end
	end

	if self.LimitskinItemId_ then
		self.LimitskinItemCfg_ = ItemCfg[self.LimitskinItemId_]

		if self.LimitskinItemCfg_ then
			self.skinId_ = self.LimitskinItemCfg_.param[1]
			self.heroId_ = SkinCfg[self.skinId_].hero
		end
	end

	if self.LimitDlcId_ then
		self.LimitDlcCfg_ = ItemCfg[self.LimitDlcId_]

		if self.LimitDlcCfg_ then
			self.dlcId_ = self.LimitDlcCfg_.param[1]
		end
	end

	self.showSkin_ = true

	self.tipsController_:SetSelectedState(tostring(self.showSkin_))
	self:UpdateView()
end

function LimitTimeSkinUsePopView:HasOwnAllItem()
	if self.skinId_ and self.dlcId_ then
		if HomeSceneSettingData:IsHaveScene(self.dlcId_) and HeroTools.GetHasOwnedSkin(self.skinId_) then
			return true
		end
	elseif not self.skinId_ and self.dlcId_ then
		if HomeSceneSettingData:IsHaveScene(self.dlcId_) then
			return true
		end
	elseif self.skinId_ and not self.dlcId_ and HeroTools.GetHasOwnedSkin(self.skinId_) then
		return true
	end

	return false
end

function LimitTimeSkinUsePopView:CheckCanUse()
	if HeroData:GetHeroData(self.heroId_).unlock == 0 then
		ShowTips("ERROR_HERO_NOT_UNLOCK")

		return false
	end

	return true
end

function LimitTimeSkinUsePopView:UpdateItemView(arg_17_1, arg_17_2)
	local var_17_0 = clone(ItemTemplateData)

	var_17_0.id = arg_17_2
	var_17_0.number = nil

	arg_17_1:SetData(var_17_0)
end

function LimitTimeSkinUsePopView:UpdateView()
	if self.skinId_ then
		self:UpdateItemView(self.skinItem_, self.skinId_)
	end

	if self.dlcId_ then
		self:UpdateItemView(self.dlcItem_, self.dlcId_)
	end

	SetActive(self.tipsBtnGo_, not self:HasOwnAllItem())

	if self:HasOwnAllItem() then
		self.showSkin_ = false
	end

	self.skinImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.skinId_)
	self.titleText_.text = SkinCfg[self.skinId_].name
	self.leftTimeText_.text = self.LimitskinItemCfg_.time[2][1] .. GetTips("DAY")

	if self.skinId_ and self.dlcId_ then
		self.stateController_:SetSelectedState("all")
	elseif self.skinId_ and not self.dlcId_ then
		self.stateController_:SetSelectedState("skin")
	elseif not self.skinId_ and self.dlcId_ then
		self.stateController_:SetSelectedState("dlc")
	end

	local var_18_0 = false

	if self.dlcId_ then
		var_18_0 = HomeSceneSettingData:IsHaveScene(self.dlcId_)
	end

	local var_18_1 = false

	if self.skinId_ then
		var_18_1 = HeroTools.GetHasOwnedSkin(self.skinId_)
	end

	if var_18_1 then
		self.skinOwnController_:SetSelectedState("on")
	else
		self.skinOwnController_:SetSelectedState("off")
	end

	if var_18_0 then
		self.dlcOwnController_:SetSelectedState("on")
	else
		self.dlcOwnController_:SetSelectedState("off")
	end

	local var_18_2 = HeroTools.GetHeroFullName(self.heroId_)
	local var_18_3 = GetI18NText(ItemCfg[self.itemId_].name)
	local var_18_4 = GetI18NText(SkinCfg[self.skinId_].name)

	if self.dlcId_ then
		local var_18_5 = GetI18NText(HomeSceneSettingCfg[self.dlcId_].title)

		self.descText_.text = not var_18_1 and not var_18_0 and string.format(GetTips("SKIN_LIMIT_TIME_DESC_1"), var_18_3, var_18_2, var_18_4, var_18_5) or var_18_1 and not var_18_0 and string.format(GetTips("SKIN_LIMIT_TIME_DESC_2"), var_18_3, var_18_2, var_18_4, var_18_5, var_18_2, var_18_4, (GetI18NText(self.LimitskinItemCfg_.name))) or not var_18_1 and var_18_0 and string.format(GetTips("SKIN_LIMIT_TIME_DESC_3"), var_18_3, var_18_2, var_18_4, var_18_2, var_18_4, var_18_5, (GetI18NText(self.LimitDlcCfg_.name))) or string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), var_18_3, var_18_3)
	else
		self.descText_.text = not var_18_1 and string.format(GetTips("SKIN_LIMIT_TIME_DESC_5"), var_18_3, var_18_2, var_18_4) or string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), var_18_3, var_18_3)
	end
end

function LimitTimeSkinUsePopView:OnExit()
	LimitTimeSkinUsePopView.super.OnExit(self)
end

return LimitTimeSkinUsePopView
