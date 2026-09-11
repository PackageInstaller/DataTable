local HeroOneKeyUpgrandView = class("HeroOneKeyUpgrandView", ReduxView)

function HeroOneKeyUpgrandView:UIName()
	return "Widget/System/Hero_arrt/HeroArrtLvupPopUI"
end

function HeroOneKeyUpgrandView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroOneKeyUpgrandView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroOneKeyUpgrandView:InitUI()
	self:BindCfgUI()

	self.curWantLevel_ = 0
	self.curUseItemList_ = {}
	self.breakIDList_ = {}
	self.curNeedBreakItemList_ = {}
	self.curNeedGold_ = 0
	self.canBreak_ = true
	self.init_ = false
	self.oldAttr_ = {}
	self.curLessLevel_ = 0
	self.curMaxLevel_ = 0
	self.costItemList_ = {}
	self.isSpecialBreak_ = false
	self.specialBreakID_ = 0
	self.interactable_ = true
	self.tipsController_ = self.tipsControllerEx_:GetController("status")
	self.btnController_ = self.controllerEx_:GetController("button")
	self.addBtnController_ = self.controllerEx_:GetController("addBtn")
	self.specialBreakController_ = self.breakControllerEx_:GetController("select")
end

function HeroOneKeyUpgrandView:AddUIListener()
	self:AddBtnListener(self.btn_noBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btn_yesBtn_, nil, function()
		if self.canBreak_ and checkGold(self.curNeedGold_, true) then
			local var_7_0 = {}

			for iter_7_0, iter_7_1 in pairs(self.breakIDList_) do
				table.insert(var_7_0, HeroBreakCfg[iter_7_1].break_times)
			end

			local var_7_1 = {}

			for iter_7_2, iter_7_3 in pairs(self.curUseItemList_) do
				table.insert(var_7_1, {
					id = iter_7_3[1],
					num = iter_7_3[2]
				})
			end

			HeroAction.HeroLevelUpAndBreak(self.heroInfo_.id, var_7_0, self.curWantLevel_, var_7_1, function(arg_8_0, arg_8_1)
				JumpTools.Back()

				if arg_8_0.break_list[1] then
					local var_8_0 = 0

					for iter_8_0, iter_8_1 in ipairs(arg_8_0.break_list) do
						if var_8_0 < iter_8_1 then
							var_8_0 = iter_8_1
						end
					end

					local var_8_1 = HeroTools.CaculateHeroAttribute(self.heroInfo_, {})

					HeroTools.CalFinalAttribute(var_8_1)
					HeroAction.BreakSuccess(self.heroInfo_.id, var_8_0 + 1)
					JumpTools.OpenPageByJump("newBreakSuccess", {
						heroId = self.heroInfo_.id,
						breakLevel = var_8_0 + 1,
						oldCrit = var_8_1[HeroConst.HERO_ATTRIBUTE.CRITICAL],
						proxy = self.heroViewProxy_,
						callBack = function()
							HeroAction.AddHeroExpSuccess(self.heroInfo_.id, arg_8_0.level, (LvTools.LevelToExp(arg_8_0.level, "hero_level_exp1")))
							JumpTools.OpenPageByJump("newHeroUpgradeSuccess", {
								heroId = self.heroInfo_.id,
								oldLv = self.heroInfo_.level,
								oldAttr = self.oldAttr_,
								proxy = self.heroViewProxy_,
								callback = function()
									local var_10_0 = {}

									for iter_10_0, iter_10_1 in ipairs(arg_8_1) do
										table.insert(var_10_0, {
											id = iter_10_1.id,
											num = iter_10_1.num
										})
									end

									if #var_10_0 > 0 then
										getReward(var_10_0, nil, function()
											return
										end)
									end
								end
							})

							self.oldAttr_ = self.heroViewProxy_:GetHeroAllAttribute(self.heroInfo_.id)
						end
					})

					self.oldAttr_ = self.heroViewProxy_:GetHeroAllAttribute(self.heroInfo_.id)
				else
					HeroAction.AddHeroExpSuccess(self.heroInfo_.id, arg_8_0.level, (LvTools.LevelToExp(arg_8_0.level, "hero_level_exp1")))
					JumpTools.OpenPageByJump("newHeroUpgradeSuccess", {
						heroId = self.heroInfo_.id,
						oldLv = self.heroInfo_.level,
						oldAttr = self.oldAttr_,
						proxy = self.heroViewProxy_,
						callback = function()
							local var_12_0 = {}

							for iter_12_0, iter_12_1 in ipairs(arg_8_1) do
								table.insert(var_12_0, {
									id = iter_12_1.id,
									num = iter_12_1.num
								})
							end

							if #var_12_0 > 0 then
								getReward(var_12_0, nil, function()
									return
								end)
							end
						end
					})

					local var_8_2 = self.heroViewProxy_:CalHeroEquipAttribute(self.heroInfo_.id)

					self.oldAttr_ = self.heroViewProxy_:GetHeroAllAttribute(self.heroInfo_.id)
				end
			end)
		end
	end)
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.specialBreakBtn_, nil, function()
		if self.isSpecialBreak_ == false then
			self.isSpecialBreak_ = true

			self.specialBreakController_:SetSelectedState("on")
			table.insert(self.breakIDList_, self.specialBreakID_)
			self:CheakBreakNeedItem()
			self:RefreshUI(true)
		else
			self.isSpecialBreak_ = false

			self.specialBreakController_:SetSelectedState("off")

			self.breakIDList_ = {}

			for iter_15_0, iter_15_1 in pairs((deepClone(self.breakIDList_))) do
				if iter_15_1 ~= self.specialBreakID_ then
					table.insert(self.breakIDList_, iter_15_1)
				end
			end

			self:CheakBreakNeedItem()
			self:RefreshUI(true)
		end
	end)
	self.slider_.onValueChanged:AddListener(function(arg_16_0)
		self:ChangeCurWantLevel(tonumber((string.format("%.1f", arg_16_0))), true)
	end)
	self:AddBtnListener(self.subLevelBtn_, nil, function()
		if self.curWantLevel_ > self.curLessLevel_ then
			self.slider_.value = self.curWantLevel_ - 1
		end
	end)
	self:AddBtnListener(self.addLevelBtn_, nil, function()
		if self.curWantLevel_ < self.curMaxLevel_ then
			self.slider_.value = self.curWantLevel_ + 1
		end
	end)
end

function HeroOneKeyUpgrandView:CheckLevelCanSelect(arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs(GameSetting.hero_exp_props_id_list.value) do
		var_19_0 = var_19_0 + ItemTools.getItemNum(iter_19_1) * ItemCfg[iter_19_1].param[1]
	end

	if var_19_0 < LvTools.LevelToExp(arg_19_1, "hero_level_exp1") - self.heroInfo_.exp then
		return false
	end

	if arg_19_1 > HeroTools.GetHeroBreakConfig(HeroCfg[self.heroInfo_.id].race, self.heroInfo_.break_level or 0).max_level then
		local var_19_1 = {}
		local var_19_2 = self.heroInfo_.break_level or 0
		local var_19_3 = HeroBreakCfg.get_id_list_by_race[HeroCfg[self.heroInfo_.id].race]
		local var_19_4 = HeroTools.GetHeroBreakConfig(HeroCfg[self.heroInfo_.id].race, self.heroInfo_.break_level or 0).max_level

		for iter_19_2, iter_19_3 in pairs(var_19_3) do
			if var_19_4 < arg_19_1 and var_19_4 <= HeroBreakCfg[iter_19_3].max_level and var_19_2 <= HeroBreakCfg[iter_19_3].break_times then
				table.insert(var_19_1, iter_19_3)

				if var_19_3[iter_19_2 + 1] then
					var_19_4 = HeroBreakCfg[var_19_3[iter_19_2 + 1]].max_level
				end
			end
		end

		if #var_19_1 > 0 then
			local var_19_5 = 0
			local var_19_6 = {}

			for iter_19_4, iter_19_5 in pairs(var_19_1) do
				if PlayerData:GetPlayerInfo().userLevel < HeroBreakCfg[iter_19_5].user_level then
					return false
				end

				var_19_5 = var_19_5 + HeroBreakCfg[iter_19_5].cost_gold

				if type(HeroBreakCfg[iter_19_5].cost) == "table" then
					for iter_19_6, iter_19_7 in pairs(HeroBreakCfg[iter_19_5].cost) do
						var_19_6[iter_19_7[1]] = var_19_6[iter_19_7[1]] and var_19_6[iter_19_7[1]] + iter_19_7[2] or iter_19_7[2]
					end
				end
			end

			if not checkGold(var_19_5, false) then
				return false
			end

			for iter_19_8, iter_19_9 in pairs(var_19_6) do
				if iter_19_9 > ItemTools.getItemNum(iter_19_8) then
					return false
				end
			end
		end
	end

	return true
end

function HeroOneKeyUpgrandView:CheckLevelCanShowBreak(arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(GameSetting.hero_exp_props_id_list.value) do
		var_20_0 = var_20_0 + ItemTools.getItemNum(iter_20_1) * ItemCfg[iter_20_1].param[1]
	end

	if var_20_0 < LvTools.LevelToExp(arg_20_1, "hero_level_exp1") - self.heroInfo_.exp then
		return false
	end

	if arg_20_1 > HeroTools.GetHeroBreakConfig(HeroCfg[self.heroInfo_.id].race, self.heroInfo_.break_level or 0).max_level then
		local var_20_1 = {}
		local var_20_2 = self.heroInfo_.break_level or 0
		local var_20_3 = HeroBreakCfg.get_id_list_by_race[HeroCfg[self.heroInfo_.id].race]
		local var_20_4 = HeroTools.GetHeroBreakConfig(HeroCfg[self.heroInfo_.id].race, self.heroInfo_.break_level or 0).max_level

		for iter_20_2, iter_20_3 in pairs(var_20_3) do
			if var_20_4 < arg_20_1 and var_20_4 <= HeroBreakCfg[iter_20_3].max_level and var_20_2 <= HeroBreakCfg[iter_20_3].break_times then
				table.insert(var_20_1, iter_20_3)

				if var_20_3[iter_20_2 + 1] then
					var_20_4 = HeroBreakCfg[var_20_3[iter_20_2 + 1]].max_level
				end
			end
		end

		if #var_20_1 > 0 then
			local var_20_5 = {}

			for iter_20_4, iter_20_5 in pairs(var_20_1) do
				if PlayerData:GetPlayerInfo().userLevel < HeroBreakCfg[iter_20_5].user_level then
					return false
				end

				if type(HeroBreakCfg[iter_20_5].cost) == "table" then
					for iter_20_6, iter_20_7 in pairs(HeroBreakCfg[iter_20_5].cost) do
						var_20_5[iter_20_7[1]] = var_20_5[iter_20_7[1]] and var_20_5[iter_20_7[1]] + iter_20_7[2] or iter_20_7[2]
					end
				end
			end

			for iter_20_8, iter_20_9 in pairs(var_20_5) do
				if iter_20_9 > ItemTools.getItemNum(iter_20_8) then
					return false
				end
			end
		end
	end

	return true
end

function HeroOneKeyUpgrandView:ChangeCurWantLevel(arg_21_1, arg_21_2)
	if arg_21_2 and self.init_ == false then
		return
	end

	if self.curWantLevel_ ~= arg_21_1 then
		self.curWantLevel_ = arg_21_1
		self.isSpecialBreak_ = false
		self.specialBreakID_ = 0

		self.specialBreakController_:SetSelectedState("off")

		self.rightLvTxt_.text = self.curWantLevel_
		self.curUseItemList_ = {}

		local var_21_0 = LvTools.LevelToExp(self.curWantLevel_, "hero_level_exp1") - self.heroInfo_.exp
		local var_21_1 = 0

		for iter_21_0, iter_21_1 in pairs(GameSetting.hero_exp_props_id_list.value) do
			var_21_1 = var_21_1 + ItemTools.getItemNum(iter_21_1) * ItemCfg[iter_21_1].param[1]
		end

		if var_21_0 <= var_21_1 then
			local var_21_2 = {}

			for iter_21_2, iter_21_3 in pairs(GameSetting.hero_exp_props_id_list.value) do
				var_21_2[iter_21_2] = math.max(math.min(math.ceil(var_21_0 / ItemCfg[iter_21_3].param[1]), (ItemTools.getItemNum(iter_21_3))), 0)
				var_21_0 = var_21_0 - var_21_2[iter_21_2] * ItemCfg[iter_21_3].param[1]

				if var_21_0 < 0 and iter_21_2 > 1 then
					local var_21_3 = -var_21_0

					for iter_21_4 = iter_21_2 - 1, 1, -1 do
						local var_21_4 = math.modf(var_21_3 / ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_21_4]].param[1])

						var_21_2[iter_21_4] = math.max(0, var_21_2[iter_21_4] - var_21_4)

						local var_21_5 = math.min(var_21_2[iter_21_4], var_21_4)

						var_21_3 = var_21_3 - ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_21_4]].param[1] * var_21_5
						var_21_0 = var_21_0 + ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_21_4]].param[1] * var_21_5
					end
				end

				if var_21_0 <= 0 then
					break
				end
			end

			self.curUseItemList_ = {}

			for iter_21_5, iter_21_6 in pairs(GameSetting.hero_exp_props_id_list.value) do
				if var_21_2[iter_21_5] and var_21_2[iter_21_5] > 0 then
					table.insert(self.curUseItemList_, {
						iter_21_6,
						var_21_2[iter_21_5]
					})
				end
			end
		else
			local var_21_6 = {}

			for iter_21_7, iter_21_8 in pairs(GameSetting.hero_exp_props_id_list.value) do
				local var_21_7 = ItemTools.getItemNum(iter_21_8)

				if var_21_7 > 0 then
					var_21_6[iter_21_8] = var_21_7
				end
			end

			local var_21_8 = var_21_0 - var_21_1

			for iter_21_9 = #GameSetting.hero_exp_props_id_list.value, 1, -1 do
				local var_21_9 = (var_21_8 - var_21_8 % ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_21_9]].param[1]) / ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_21_9]].param[1]

				if var_21_9 > 0 then
					var_21_6[GameSetting.hero_exp_props_id_list.value[iter_21_9]] = var_21_6[GameSetting.hero_exp_props_id_list.value[iter_21_9]] and var_21_6[GameSetting.hero_exp_props_id_list.value[iter_21_9]] + var_21_9 or var_21_9
					var_21_8 = var_21_8 - var_21_9 * ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_21_9]].param[1]
				end
			end

			if var_21_8 > 0 then
				var_21_6[GameSetting.hero_exp_props_id_list.value[1]] = var_21_6[GameSetting.hero_exp_props_id_list.value[1]] and var_21_6[GameSetting.hero_exp_props_id_list.value[1]] + 1 or 1
			end

			self.curUseItemList_ = {}

			for iter_21_10, iter_21_11 in pairs(GameSetting.hero_exp_props_id_list.value) do
				if var_21_6[iter_21_11] and var_21_6[iter_21_11] > 0 then
					table.insert(self.curUseItemList_, {
						iter_21_11,
						var_21_6[iter_21_11]
					})
				end
			end
		end

		self.breakIDList_ = {}

		if self.curWantLevel_ > HeroTools.GetHeroBreakConfig(HeroCfg[self.heroInfo_.id].race, self.heroInfo_.break_level or 0).max_level then
			self:OnLevelSelectRefreshBreakTimes()
		else
			self:CheakBreakNeedItem()
		end

		self:RefreshUI(false)
	end
end

function HeroOneKeyUpgrandView:OnEnter()
	self.heroViewProxy_ = self.params_.proxy
	self.heroInfo_ = self.heroViewProxy_:GetHeroData(self.params_.heroId)
	self.oldAttr_ = self.heroViewProxy_:GetHeroAllAttribute(self.heroInfo_.id)
	self.goldIcon_.sprite = ItemTools.getItemSprite(2)

	local var_22_0 = HeroTools.GetHeroMaxLevel(self.heroInfo_)
	local var_22_1

	if var_22_0 <= self.heroInfo_.level then
		return
	end

	for iter_22_0, iter_22_1 in pairs(GameSetting.hero_exp_props_id_list.value) do
		if ItemTools.getItemNum(iter_22_1) > 0 then
			var_22_1 = iter_22_1

			break
		end
	end

	local var_22_2, var_22_3, var_22_4, var_22_5, var_22_6 = LvTools.CheckHeroExp(self.heroInfo_.level, self.heroInfo_.exp + ItemCfg[var_22_1].param[1], HeroTools.GetHeroCurrentMaxLevel(self.heroInfo_))

	if var_22_2 > self.heroInfo_.level then
		-- block empty
	else
		var_22_2 = self.heroInfo_.level + 1
	end

	self.leftLvTxt_.text = self.heroInfo_.level
	self.canBreak_ = true
	self.isSpecialBreak_ = false

	self.specialBreakController_:SetSelectedState("off")

	self.specialBreakID_ = 0

	if var_22_2 == var_22_0 then
		self.interactable_ = false
		self.slider_.interactable = false
		self.slider_.minValue = var_22_2 - 1
		self.curLessLevel_ = var_22_2
		self.slider_.maxValue = var_22_0
		self.curMaxLevel_ = var_22_0
	else
		self.interactable_ = true
		self.slider_.interactable = true
		self.slider_.minValue = var_22_2
		self.curLessLevel_ = var_22_2
		self.slider_.maxValue = var_22_0
		self.curMaxLevel_ = var_22_0
	end

	local var_22_7 = self:FindCurMaxLevel()

	self.slider_.value = var_22_7

	self:ChangeCurWantLevel(var_22_7, false)

	self.init_ = true
end

function HeroOneKeyUpgrandView:OnTop()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetAsLastSibling()

	if HeroTools.GetHeroMaxLevel(self.heroInfo_) <= self.heroInfo_.level then
		JumpTools.Back()

		return
	end

	self:RefreshUI(false)
end

function HeroOneKeyUpgrandView:FindCurMaxLevel()
	for iter_24_0 = self.curMaxLevel_, self.curLessLevel_, -1 do
		if self:CheckLevelCanSelect(iter_24_0) then
			return iter_24_0
		end
	end

	return self.curLessLevel_
end

function HeroOneKeyUpgrandView:OnLevelSelectRefreshBreakTimes()
	local var_25_0 = self.heroInfo_.break_level or 0
	local var_25_1 = HeroBreakCfg.get_id_list_by_race[HeroCfg[self.heroInfo_.id].race]
	local var_25_2 = HeroTools.GetHeroBreakConfig(HeroCfg[self.heroInfo_.id].race, self.heroInfo_.break_level or 0).max_level

	for iter_25_0, iter_25_1 in pairs(var_25_1) do
		if var_25_2 < self.curWantLevel_ and var_25_2 <= HeroBreakCfg[iter_25_1].max_level and var_25_0 <= HeroBreakCfg[iter_25_1].break_times then
			table.insert(self.breakIDList_, iter_25_1)

			if var_25_1[iter_25_0 + 1] then
				var_25_2 = HeroBreakCfg[var_25_1[iter_25_0 + 1]].max_level
			end
		end
	end

	self:CheakBreakNeedItem()
end

function HeroOneKeyUpgrandView:CheakBreakNeedItem()
	self.curNeedBreakItemList_ = {}
	self.curNeedGold_ = 0

	for iter_26_0, iter_26_1 in pairs(self.breakIDList_) do
		self.curNeedGold_ = self.curNeedGold_ + HeroBreakCfg[iter_26_1].cost_gold

		if type(HeroBreakCfg[iter_26_1].cost) == "table" then
			for iter_26_2, iter_26_3 in pairs(HeroBreakCfg[iter_26_1].cost) do
				self.curNeedBreakItemList_[iter_26_3[1]] = self.curNeedBreakItemList_[iter_26_3[1]] and self.curNeedBreakItemList_[iter_26_3[1]] + iter_26_3[2] or iter_26_3[2]
			end
		end
	end
end

function HeroOneKeyUpgrandView:RefreshUI(arg_27_1)
	local var_27_0 = 1

	for iter_27_0, iter_27_1 in pairs(self.curUseItemList_) do
		if self.costItemList_[var_27_0] == nil then
			self.costItemList_[var_27_0] = CommonItemPool.New(self.rewardpanelTrs_, nil, true)
		end

		self.costItemList_[var_27_0]:Show(true)

		local var_27_1 = clone(ItemTemplateData)

		function var_27_1:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.id,
				self.number
			})
		end

		local var_27_2 = ItemTools.getItemNum(iter_27_1[1])

		var_27_1.id = iter_27_1[1]
		var_27_1.number = var_27_2
		var_27_1.hideBottomRightTextFlag = true
		var_27_1.bottomText = {
			var_27_2,
			iter_27_1[2]
		}

		self.costItemList_[var_27_0]:SetData(var_27_1)

		var_27_0 = var_27_0 + 1
	end

	local var_27_3 = {}

	for iter_27_2, iter_27_3 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.HERO_BREAK_ITEM]) do
		if self.curNeedBreakItemList_[iter_27_3] and self.curNeedBreakItemList_[iter_27_3] > 0 then
			table.insert(var_27_3, {
				iter_27_3,
				self.curNeedBreakItemList_[iter_27_3]
			})
		end
	end

	for iter_27_4, iter_27_5 in pairs(var_27_3) do
		if self.costItemList_[var_27_0] == nil then
			self.costItemList_[var_27_0] = CommonItemPool.New(self.rewardpanelTrs_, nil, true)
		end

		self.costItemList_[var_27_0]:Show(true)

		local var_27_4 = clone(ItemTemplateData)

		function var_27_4:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.id,
				self.number
			})
		end

		local var_27_5 = ItemTools.getItemNum(iter_27_5[1])

		var_27_4.id = iter_27_5[1]
		var_27_4.number = var_27_5
		var_27_4.hideBottomRightTextFlag = true
		var_27_4.bottomText = {
			var_27_5,
			iter_27_5[2]
		}

		self.costItemList_[var_27_0]:SetData(var_27_4)

		var_27_0 = var_27_0 + 1
	end

	for iter_27_6 = var_27_0, #self.costItemList_ do
		if self.costItemList_[iter_27_6] then
			self.costItemList_[iter_27_6]:Show(false)
		end
	end

	if self.curWantLevel_ == self.curLessLevel_ and self.curWantLevel_ == self.curMaxLevel_ then
		self.addBtnController_:SetSelectedState("noAddAndSub")
	elseif self.curWantLevel_ >= self.curMaxLevel_ then
		self.addBtnController_:SetSelectedState("noAdd")
	elseif self.curWantLevel_ <= self.curLessLevel_ then
		self.addBtnController_:SetSelectedState("noSub")
	else
		self.addBtnController_:SetSelectedState("normal")
	end

	self.canBreak_ = true

	SetActive(self.breakBtnGo_, false)

	if self.curWantLevel_ and self:CheckLevelCanShowBreak(self.curWantLevel_) then
		for iter_27_7, iter_27_8 in pairs(HeroBreakCfg.get_id_list_by_race[HeroCfg[self.heroInfo_.id].race]) do
			if HeroBreakCfg[iter_27_8].max_level == self.curWantLevel_ and HeroBreakCfg.get_id_list_by_race[HeroCfg[self.heroInfo_.id].race][iter_27_7 + 1] and self.heroInfo_.break_level <= HeroBreakCfg[iter_27_8].break_times then
				SetActive(self.breakBtnGo_, true)

				if self.isSpecialBreak_ == false then
					self.isSpecialBreak_ = false
					self.specialBreakID_ = HeroBreakCfg.get_id_list_by_race[HeroCfg[self.heroInfo_.id].race][iter_27_7]

					self.specialBreakController_:SetSelectedState("off")
				end
			end
		end
	end

	if not self:CheckUpgrandCondition() and not self:CheckUpgrandIsBreak() then
		self.tipsController_:SetSelectedState("levelUp")

		self.levelUpText_.text = string.format(GetTips("LEVELUP_DIFF"), self.curWantLevel_ - self.heroInfo_.level)
	end
end

function HeroOneKeyUpgrandView:CheckUpgrandCondition()
	self.btnController_:SetSelectedState("sure")

	self.goldNum_.text = self.curNeedGold_

	if not checkGold(self.curNeedGold_, false) then
		self.goldNum_.text = "<color=#F6302F>" .. self.curNeedGold_ .. "</color>"
	end

	if self.breakIDList_[#self.breakIDList_] then
		if HeroBreakCfg[self.breakIDList_[#self.breakIDList_]].user_level > PlayerData:GetPlayerInfo().userLevel then
			self.canBreak_ = false

			self.tipsController_:SetSelectedState("lock")
			self.btnController_:SetSelectedState("noSure")

			self.lockText_.text = GetTips("PLAYER_LEVEL_LESSTHEN_BREAK")

			return true
		end

		for iter_30_0, iter_30_1 in pairs(self.curNeedBreakItemList_) do
			if iter_30_1 > ItemTools.getItemNum(iter_30_0) then
				self.canBreak_ = false

				self.tipsController_:SetSelectedState("lock")
				self.btnController_:SetSelectedState("noSure")

				self.lockText_.text = GetTips("NEED_MORE_BREAK_ITEM")

				return true
			end
		end
	end

	for iter_30_2, iter_30_3 in pairs(self.curUseItemList_) do
		if ItemTools.getItemNum(iter_30_3[1]) < iter_30_3[2] then
			self.canBreak_ = false

			self.tipsController_:SetSelectedState("lock")
			self.btnController_:SetSelectedState("noSure")

			local var_30_0 = LvTools.LevelToExp(self.curWantLevel_, "hero_level_exp1") - self.heroInfo_.exp
			local var_30_1 = 0

			for iter_30_4, iter_30_5 in pairs(GameSetting.hero_exp_props_id_list.value) do
				var_30_1 = var_30_1 + ItemTools.getItemNum(iter_30_5) * ItemCfg[iter_30_5].param[1]
			end

			local var_30_2 = 0
			local var_30_3 = 0

			for iter_30_6 = #GameSetting.hero_exp_props_id_list.value, 1, -1 do
				if ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_30_6]].param[1] <= var_30_0 - var_30_1 then
					var_30_2 = GameSetting.hero_exp_props_id_list.value[iter_30_6]

					if (var_30_0 - var_30_1) % ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_30_6]].param[1] == 0 then
						var_30_3 = (var_30_0 - var_30_1) / ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_30_6]].param[1]

						break
					end

					var_30_3 = (var_30_0 - var_30_1 - (var_30_0 - var_30_1) % ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_30_6]].param[1]) / ItemCfg[GameSetting.hero_exp_props_id_list.value[iter_30_6]].param[1] + 1

					break
				end
			end

			if var_30_2 == 0 then
				var_30_2 = GameSetting.hero_exp_props_id_list.value[1]
				var_30_3 = 1
			end

			self.lockText_.text = string.format(GetTips("NEED_MORE_EXP_ITEM"), var_30_0 - var_30_1, GetI18NText(ItemCfg[var_30_2].name), var_30_3)

			return true
		end
	end

	return false
end

function HeroOneKeyUpgrandView:CheckUpgrandIsBreak()
	if self.curWantLevel_ then
		for iter_31_0, iter_31_1 in pairs(HeroBreakCfg.get_id_list_by_race[HeroCfg[self.heroInfo_.id].race]) do
			if HeroBreakCfg[iter_31_1].max_level == self.curWantLevel_ and HeroBreakCfg.get_id_list_by_race[HeroCfg[self.heroInfo_.id].race][iter_31_0 + 1] and self.heroInfo_.break_level <= HeroBreakCfg[iter_31_1].break_times then
				self.tipsController_:SetSelectedState("break")

				self.specialBreakText_.text = string.format(GetTips("BREAK_HERO_LEVEL_TO"), HeroBreakCfg[HeroBreakCfg.get_id_list_by_race[HeroCfg[self.heroInfo_.id].race][iter_31_0 + 1]].max_level)

				return true
			end
		end
	end
end

function HeroOneKeyUpgrandView:OnExit()
	manager.windowBar:HideBar()

	self.curWantLevel_ = 0
	self.curUseItemList_ = {}
	self.breakIDList_ = {}
	self.curNeedBreakItemList_ = {}
	self.curNeedGold_ = 0
	self.canBreak_ = true
	self.init_ = false
	self.curLessLevel_ = 0
	self.curMaxLevel_ = 0
	self.isSpecialBreak_ = false
	self.specialBreakID_ = 0
end

function HeroOneKeyUpgrandView:Dispose()
	HeroOneKeyUpgrandView.super.Dispose(self)

	for iter_33_0, iter_33_1 in pairs(self.costItemList_) do
		iter_33_1:Dispose()
	end

	self.costItemList_ = {}
end

return HeroOneKeyUpgrandView
