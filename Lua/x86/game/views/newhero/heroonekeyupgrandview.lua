local var_0_0 = class("HeroOneKeyUpgrandView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_arrt/HeroArrtLvupPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.curWantLevel_ = 0
	arg_4_0.curUseItemList_ = {}
	arg_4_0.breakIDList_ = {}
	arg_4_0.curNeedBreakItemList_ = {}
	arg_4_0.curNeedGold_ = 0
	arg_4_0.canBreak_ = true
	arg_4_0.init_ = false
	arg_4_0.oldAttr_ = {}
	arg_4_0.curLessLevel_ = 0
	arg_4_0.curMaxLevel_ = 0
	arg_4_0.costItemList_ = {}
	arg_4_0.isSpecialBreak_ = false
	arg_4_0.specialBreakID_ = 0
	arg_4_0.interactable_ = true
	arg_4_0.tipsController_ = arg_4_0.tipsControllerEx_:GetController("status")
	arg_4_0.btnController_ = arg_4_0.controllerEx_:GetController("button")
	arg_4_0.addBtnController_ = arg_4_0.controllerEx_:GetController("addBtn")
	arg_4_0.specialBreakController_ = arg_4_0.breakControllerEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_noBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_yesBtn_, nil, function()
		if arg_5_0.canBreak_ and checkGold(arg_5_0.curNeedGold_, true) then
			local var_7_0 = {}

			for iter_7_0, iter_7_1 in pairs(arg_5_0.breakIDList_) do
				table.insert(var_7_0, HeroBreakCfg[iter_7_1].break_times)
			end

			local var_7_1 = {}

			for iter_7_2, iter_7_3 in pairs(arg_5_0.curUseItemList_) do
				table.insert(var_7_1, {
					id = iter_7_3[1],
					num = iter_7_3[2]
				})
			end

			HeroAction.HeroLevelUpAndBreak(arg_5_0.heroInfo_.id, var_7_0, arg_5_0.curWantLevel_, var_7_1, function(arg_8_0, arg_8_1)
				JumpTools.Back()

				if arg_8_0.break_list[1] then
					local var_8_0 = 0

					for iter_8_0, iter_8_1 in ipairs(arg_8_0.break_list) do
						if var_8_0 < iter_8_1 then
							var_8_0 = iter_8_1
						end
					end

					local var_8_1 = HeroTools.CaculateHeroAttribute(arg_5_0.heroInfo_, {})

					HeroTools.CalFinalAttribute(var_8_1)
					HeroAction.BreakSuccess(arg_5_0.heroInfo_.id, var_8_0 + 1)
					JumpTools.OpenPageByJump("newBreakSuccess", {
						heroId = arg_5_0.heroInfo_.id,
						breakLevel = var_8_0 + 1,
						oldCrit = var_8_1[HeroConst.HERO_ATTRIBUTE.CRITICAL],
						proxy = arg_5_0.heroViewProxy_,
						callBack = function()
							local var_9_0 = arg_8_0.level
							local var_9_1 = arg_5_0.oldAttr_
							local var_9_2 = arg_5_0.heroInfo_.level
							local var_9_3 = LvTools.LevelToExp(var_9_0, "hero_level_exp1")

							HeroAction.AddHeroExpSuccess(arg_5_0.heroInfo_.id, var_9_0, var_9_3)
							JumpTools.OpenPageByJump("newHeroUpgradeSuccess", {
								heroId = arg_5_0.heroInfo_.id,
								oldLv = var_9_2,
								oldAttr = var_9_1,
								proxy = arg_5_0.heroViewProxy_,
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

							arg_5_0.oldAttr_ = arg_5_0.heroViewProxy_:GetHeroAllAttribute(arg_5_0.heroInfo_.id)
						end
					})

					arg_5_0.oldAttr_ = arg_5_0.heroViewProxy_:GetHeroAllAttribute(arg_5_0.heroInfo_.id)
				else
					local var_8_2 = arg_8_0.level
					local var_8_3 = arg_5_0.oldAttr_
					local var_8_4 = arg_5_0.heroInfo_.level
					local var_8_5 = LvTools.LevelToExp(var_8_2, "hero_level_exp1")

					HeroAction.AddHeroExpSuccess(arg_5_0.heroInfo_.id, var_8_2, var_8_5)
					JumpTools.OpenPageByJump("newHeroUpgradeSuccess", {
						heroId = arg_5_0.heroInfo_.id,
						oldLv = var_8_4,
						oldAttr = var_8_3,
						proxy = arg_5_0.heroViewProxy_,
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

					local var_8_6 = arg_5_0.heroViewProxy_:CalHeroEquipAttribute(arg_5_0.heroInfo_.id)

					arg_5_0.oldAttr_ = arg_5_0.heroViewProxy_:GetHeroAllAttribute(arg_5_0.heroInfo_.id)
				end
			end)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.fullscreenBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.specialBreakBtn_, nil, function()
		if arg_5_0.isSpecialBreak_ == false then
			arg_5_0.isSpecialBreak_ = true

			arg_5_0.specialBreakController_:SetSelectedState("on")
			table.insert(arg_5_0.breakIDList_, arg_5_0.specialBreakID_)
			arg_5_0:CheakBreakNeedItem()
			arg_5_0:RefreshUI(true)
		else
			arg_5_0.isSpecialBreak_ = false

			arg_5_0.specialBreakController_:SetSelectedState("off")

			local var_15_0 = deepClone(arg_5_0.breakIDList_)

			arg_5_0.breakIDList_ = {}

			for iter_15_0, iter_15_1 in pairs(var_15_0) do
				if iter_15_1 ~= arg_5_0.specialBreakID_ then
					table.insert(arg_5_0.breakIDList_, iter_15_1)
				end
			end

			arg_5_0:CheakBreakNeedItem()
			arg_5_0:RefreshUI(true)
		end
	end)
	arg_5_0.slider_.onValueChanged:AddListener(function(arg_16_0)
		local var_16_0 = string.format("%.1f", arg_16_0)

		arg_5_0:ChangeCurWantLevel(tonumber(var_16_0), true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.subLevelBtn_, nil, function()
		if arg_5_0.curWantLevel_ > arg_5_0.curLessLevel_ then
			arg_5_0.slider_.value = arg_5_0.curWantLevel_ - 1
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.addLevelBtn_, nil, function()
		if arg_5_0.curWantLevel_ < arg_5_0.curMaxLevel_ then
			arg_5_0.slider_.value = arg_5_0.curWantLevel_ + 1
		end
	end)
end

function var_0_0.CheckLevelCanSelect(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.heroInfo_.exp
	local var_19_1 = LvTools.LevelToExp(arg_19_1, "hero_level_exp1") - var_19_0
	local var_19_2 = GameSetting.hero_exp_props_id_list.value
	local var_19_3 = 0

	for iter_19_0, iter_19_1 in pairs(var_19_2) do
		var_19_3 = var_19_3 + ItemTools.getItemNum(iter_19_1) * ItemCfg[iter_19_1].param[1]
	end

	if var_19_3 < var_19_1 then
		return false
	end

	if arg_19_1 > HeroTools.GetHeroBreakConfig(HeroCfg[arg_19_0.heroInfo_.id].race, arg_19_0.heroInfo_.break_level or 0).max_level then
		local var_19_4 = {}
		local var_19_5 = arg_19_0.heroInfo_.break_level or 0
		local var_19_6 = HeroCfg[arg_19_0.heroInfo_.id]
		local var_19_7 = HeroBreakCfg.get_id_list_by_race[var_19_6.race]
		local var_19_8 = HeroTools.GetHeroBreakConfig(HeroCfg[arg_19_0.heroInfo_.id].race, arg_19_0.heroInfo_.break_level or 0).max_level

		for iter_19_2, iter_19_3 in pairs(var_19_7) do
			local var_19_9 = HeroBreakCfg[iter_19_3]

			if var_19_8 < arg_19_1 and var_19_8 <= var_19_9.max_level and var_19_5 <= var_19_9.break_times then
				table.insert(var_19_4, iter_19_3)

				if var_19_7[iter_19_2 + 1] then
					var_19_8 = HeroBreakCfg[var_19_7[iter_19_2 + 1]].max_level
				end
			end
		end

		if #var_19_4 > 0 then
			local var_19_10 = 0
			local var_19_11 = {}

			for iter_19_4, iter_19_5 in pairs(var_19_4) do
				local var_19_12 = HeroBreakCfg[iter_19_5]

				if PlayerData:GetPlayerInfo().userLevel < var_19_12.user_level then
					return false
				end

				var_19_10 = var_19_10 + var_19_12.cost_gold

				if type(var_19_12.cost) == "table" then
					for iter_19_6, iter_19_7 in pairs(var_19_12.cost) do
						if var_19_11[iter_19_7[1]] then
							var_19_11[iter_19_7[1]] = var_19_11[iter_19_7[1]] + iter_19_7[2]
						else
							var_19_11[iter_19_7[1]] = iter_19_7[2]
						end
					end
				end
			end

			if not checkGold(var_19_10, false) then
				return false
			end

			for iter_19_8, iter_19_9 in pairs(var_19_11) do
				if iter_19_9 > ItemTools.getItemNum(iter_19_8) then
					return false
				end
			end
		end
	end

	return true
end

function var_0_0.CheckLevelCanShowBreak(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.heroInfo_.exp
	local var_20_1 = LvTools.LevelToExp(arg_20_1, "hero_level_exp1") - var_20_0
	local var_20_2 = GameSetting.hero_exp_props_id_list.value
	local var_20_3 = 0

	for iter_20_0, iter_20_1 in pairs(var_20_2) do
		var_20_3 = var_20_3 + ItemTools.getItemNum(iter_20_1) * ItemCfg[iter_20_1].param[1]
	end

	if var_20_3 < var_20_1 then
		return false
	end

	if arg_20_1 > HeroTools.GetHeroBreakConfig(HeroCfg[arg_20_0.heroInfo_.id].race, arg_20_0.heroInfo_.break_level or 0).max_level then
		local var_20_4 = {}
		local var_20_5 = arg_20_0.heroInfo_.break_level or 0
		local var_20_6 = HeroCfg[arg_20_0.heroInfo_.id]
		local var_20_7 = HeroBreakCfg.get_id_list_by_race[var_20_6.race]
		local var_20_8 = HeroTools.GetHeroBreakConfig(HeroCfg[arg_20_0.heroInfo_.id].race, arg_20_0.heroInfo_.break_level or 0).max_level

		for iter_20_2, iter_20_3 in pairs(var_20_7) do
			local var_20_9 = HeroBreakCfg[iter_20_3]

			if var_20_8 < arg_20_1 and var_20_8 <= var_20_9.max_level and var_20_5 <= var_20_9.break_times then
				table.insert(var_20_4, iter_20_3)

				if var_20_7[iter_20_2 + 1] then
					var_20_8 = HeroBreakCfg[var_20_7[iter_20_2 + 1]].max_level
				end
			end
		end

		if #var_20_4 > 0 then
			local var_20_10 = {}

			for iter_20_4, iter_20_5 in pairs(var_20_4) do
				local var_20_11 = HeroBreakCfg[iter_20_5]

				if PlayerData:GetPlayerInfo().userLevel < var_20_11.user_level then
					return false
				end

				if type(var_20_11.cost) == "table" then
					for iter_20_6, iter_20_7 in pairs(var_20_11.cost) do
						if var_20_10[iter_20_7[1]] then
							var_20_10[iter_20_7[1]] = var_20_10[iter_20_7[1]] + iter_20_7[2]
						else
							var_20_10[iter_20_7[1]] = iter_20_7[2]
						end
					end
				end
			end

			for iter_20_8, iter_20_9 in pairs(var_20_10) do
				if iter_20_9 > ItemTools.getItemNum(iter_20_8) then
					return false
				end
			end
		end
	end

	return true
end

function var_0_0.ChangeCurWantLevel(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_2 and arg_21_0.init_ == false then
		return
	end

	if arg_21_0.curWantLevel_ ~= arg_21_1 then
		arg_21_0.curWantLevel_ = arg_21_1
		arg_21_0.isSpecialBreak_ = false
		arg_21_0.specialBreakID_ = 0

		arg_21_0.specialBreakController_:SetSelectedState("off")

		arg_21_0.rightLvTxt_.text = arg_21_0.curWantLevel_
		arg_21_0.curUseItemList_ = {}

		local var_21_0 = arg_21_0.heroInfo_.exp
		local var_21_1 = LvTools.LevelToExp(arg_21_0.curWantLevel_, "hero_level_exp1") - var_21_0
		local var_21_2 = GameSetting.hero_exp_props_id_list.value
		local var_21_3 = 0

		for iter_21_0, iter_21_1 in pairs(var_21_2) do
			var_21_3 = var_21_3 + ItemTools.getItemNum(iter_21_1) * ItemCfg[iter_21_1].param[1]
		end

		if var_21_1 <= var_21_3 then
			local var_21_4 = {}

			for iter_21_2, iter_21_3 in pairs(var_21_2) do
				local var_21_5 = ItemTools.getItemNum(iter_21_3)
				local var_21_6 = ItemCfg[iter_21_3].param[1]

				var_21_4[iter_21_2] = math.max(math.min(math.ceil(var_21_1 / var_21_6), var_21_5), 0)
				var_21_1 = var_21_1 - var_21_4[iter_21_2] * var_21_6

				if var_21_1 < 0 and iter_21_2 > 1 then
					local var_21_7 = -var_21_1

					for iter_21_4 = iter_21_2 - 1, 1, -1 do
						local var_21_8 = var_21_2[iter_21_4]
						local var_21_9 = ItemCfg[var_21_8].param[1]
						local var_21_10 = math.modf(var_21_7 / var_21_9)
						local var_21_11 = var_21_4[iter_21_4]

						var_21_4[iter_21_4] = math.max(0, var_21_4[iter_21_4] - var_21_10)

						local var_21_12 = math.min(var_21_11, var_21_10)

						var_21_7 = var_21_7 - var_21_9 * var_21_12
						var_21_1 = var_21_1 + var_21_9 * var_21_12
					end
				end

				if var_21_1 <= 0 then
					break
				end
			end

			arg_21_0.curUseItemList_ = {}

			for iter_21_5, iter_21_6 in pairs(var_21_2) do
				if var_21_4[iter_21_5] and var_21_4[iter_21_5] > 0 then
					table.insert(arg_21_0.curUseItemList_, {
						iter_21_6,
						var_21_4[iter_21_5]
					})
				end
			end
		else
			local var_21_13 = {}

			for iter_21_7, iter_21_8 in pairs(var_21_2) do
				local var_21_14 = ItemTools.getItemNum(iter_21_8)

				if var_21_14 > 0 then
					var_21_13[iter_21_8] = var_21_14
				end
			end

			local var_21_15 = var_21_1 - var_21_3

			for iter_21_9 = #var_21_2, 1, -1 do
				local var_21_16 = var_21_2[iter_21_9]
				local var_21_17 = ItemCfg[var_21_16].param[1]
				local var_21_18 = (var_21_15 - var_21_15 % var_21_17) / var_21_17

				if var_21_18 > 0 then
					if var_21_13[var_21_16] then
						var_21_13[var_21_16] = var_21_13[var_21_16] + var_21_18
					else
						var_21_13[var_21_16] = var_21_18
					end

					var_21_15 = var_21_15 - var_21_18 * var_21_17
				end
			end

			if var_21_15 > 0 then
				if var_21_13[var_21_2[1]] then
					var_21_13[var_21_2[1]] = var_21_13[var_21_2[1]] + 1
				else
					var_21_13[var_21_2[1]] = 1
				end
			end

			arg_21_0.curUseItemList_ = {}

			for iter_21_10, iter_21_11 in pairs(var_21_2) do
				if var_21_13[iter_21_11] and var_21_13[iter_21_11] > 0 then
					table.insert(arg_21_0.curUseItemList_, {
						iter_21_11,
						var_21_13[iter_21_11]
					})
				end
			end
		end

		arg_21_0.breakIDList_ = {}

		local var_21_19 = HeroTools.GetHeroBreakConfig(HeroCfg[arg_21_0.heroInfo_.id].race, arg_21_0.heroInfo_.break_level or 0)

		if arg_21_0.curWantLevel_ > var_21_19.max_level then
			arg_21_0:OnLevelSelectRefreshBreakTimes()
		else
			arg_21_0:CheakBreakNeedItem()
		end

		arg_21_0:RefreshUI(false)
	end
end

function var_0_0.OnEnter(arg_22_0)
	arg_22_0.heroViewProxy_ = arg_22_0.params_.proxy
	arg_22_0.heroInfo_ = arg_22_0.heroViewProxy_:GetHeroData(arg_22_0.params_.heroId)
	arg_22_0.oldAttr_ = arg_22_0.heroViewProxy_:GetHeroAllAttribute(arg_22_0.heroInfo_.id)
	arg_22_0.goldIcon_.sprite = ItemTools.getItemSprite(2)

	local var_22_0 = HeroTools.GetHeroMaxLevel(arg_22_0.heroInfo_)

	if var_22_0 <= arg_22_0.heroInfo_.level then
		return
	end

	local var_22_1 = GameSetting.hero_exp_props_id_list.value
	local var_22_2

	for iter_22_0, iter_22_1 in pairs(var_22_1) do
		if ItemTools.getItemNum(iter_22_1) > 0 then
			var_22_2 = iter_22_1

			break
		end
	end

	local var_22_3 = ItemCfg[var_22_2].param[1]
	local var_22_4, var_22_5, var_22_6, var_22_7, var_22_8 = LvTools.CheckHeroExp(arg_22_0.heroInfo_.level, arg_22_0.heroInfo_.exp + var_22_3, HeroTools.GetHeroCurrentMaxLevel(arg_22_0.heroInfo_))

	if var_22_4 > arg_22_0.heroInfo_.level then
		-- block empty
	else
		var_22_4 = arg_22_0.heroInfo_.level + 1
	end

	arg_22_0.leftLvTxt_.text = arg_22_0.heroInfo_.level
	arg_22_0.canBreak_ = true
	arg_22_0.isSpecialBreak_ = false

	arg_22_0.specialBreakController_:SetSelectedState("off")

	arg_22_0.specialBreakID_ = 0

	if var_22_4 == var_22_0 then
		arg_22_0.interactable_ = false
		arg_22_0.slider_.interactable = false
		arg_22_0.slider_.minValue = var_22_4 - 1
		arg_22_0.curLessLevel_ = var_22_4
		arg_22_0.slider_.maxValue = var_22_0
		arg_22_0.curMaxLevel_ = var_22_0
	else
		arg_22_0.interactable_ = true
		arg_22_0.slider_.interactable = true
		arg_22_0.slider_.minValue = var_22_4
		arg_22_0.curLessLevel_ = var_22_4
		arg_22_0.slider_.maxValue = var_22_0
		arg_22_0.curMaxLevel_ = var_22_0
	end

	local var_22_9 = arg_22_0:FindCurMaxLevel()

	arg_22_0.slider_.value = var_22_9

	arg_22_0:ChangeCurWantLevel(var_22_9, false)

	arg_22_0.init_ = true
end

function var_0_0.OnTop(arg_23_0)
	local var_23_0 = HeroTools.GetHeroMaxLevel(arg_23_0.heroInfo_)

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetAsLastSibling()

	if var_23_0 <= arg_23_0.heroInfo_.level then
		JumpTools.Back()

		return
	end

	arg_23_0:RefreshUI(false)
end

function var_0_0.FindCurMaxLevel(arg_24_0)
	local var_24_0 = arg_24_0.curLessLevel_

	for iter_24_0 = arg_24_0.curMaxLevel_, var_24_0, -1 do
		if arg_24_0:CheckLevelCanSelect(iter_24_0) then
			return iter_24_0
		end
	end

	return arg_24_0.curLessLevel_
end

function var_0_0.OnLevelSelectRefreshBreakTimes(arg_25_0)
	local var_25_0 = arg_25_0.heroInfo_.break_level or 0
	local var_25_1 = HeroCfg[arg_25_0.heroInfo_.id]
	local var_25_2 = HeroBreakCfg.get_id_list_by_race[var_25_1.race]
	local var_25_3 = HeroTools.GetHeroBreakConfig(HeroCfg[arg_25_0.heroInfo_.id].race, arg_25_0.heroInfo_.break_level or 0).max_level

	for iter_25_0, iter_25_1 in pairs(var_25_2) do
		local var_25_4 = HeroBreakCfg[iter_25_1]

		if var_25_3 < arg_25_0.curWantLevel_ and var_25_3 <= var_25_4.max_level and var_25_0 <= var_25_4.break_times then
			table.insert(arg_25_0.breakIDList_, iter_25_1)

			if var_25_2[iter_25_0 + 1] then
				var_25_3 = HeroBreakCfg[var_25_2[iter_25_0 + 1]].max_level
			end
		end
	end

	arg_25_0:CheakBreakNeedItem()
end

function var_0_0.CheakBreakNeedItem(arg_26_0)
	arg_26_0.curNeedBreakItemList_ = {}
	arg_26_0.curNeedGold_ = 0

	for iter_26_0, iter_26_1 in pairs(arg_26_0.breakIDList_) do
		local var_26_0 = HeroBreakCfg[iter_26_1]

		arg_26_0.curNeedGold_ = arg_26_0.curNeedGold_ + var_26_0.cost_gold

		if type(var_26_0.cost) == "table" then
			for iter_26_2, iter_26_3 in pairs(var_26_0.cost) do
				if arg_26_0.curNeedBreakItemList_[iter_26_3[1]] then
					arg_26_0.curNeedBreakItemList_[iter_26_3[1]] = arg_26_0.curNeedBreakItemList_[iter_26_3[1]] + iter_26_3[2]
				else
					arg_26_0.curNeedBreakItemList_[iter_26_3[1]] = iter_26_3[2]
				end
			end
		end
	end
end

function var_0_0.RefreshUI(arg_27_0, arg_27_1)
	local var_27_0 = 1

	for iter_27_0, iter_27_1 in pairs(arg_27_0.curUseItemList_) do
		if arg_27_0.costItemList_[var_27_0] == nil then
			arg_27_0.costItemList_[var_27_0] = CommonItemPool.New(arg_27_0.rewardpanelTrs_, nil, true)
		end

		arg_27_0.costItemList_[var_27_0]:Show(true)

		local var_27_1 = clone(ItemTemplateData)

		function var_27_1.clickFun(arg_28_0)
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_28_0.id,
				arg_28_0.number
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

		arg_27_0.costItemList_[var_27_0]:SetData(var_27_1)

		var_27_0 = var_27_0 + 1
	end

	local var_27_3 = {}
	local var_27_4 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.HERO_BREAK_ITEM]

	for iter_27_2, iter_27_3 in pairs(var_27_4) do
		if arg_27_0.curNeedBreakItemList_[iter_27_3] and arg_27_0.curNeedBreakItemList_[iter_27_3] > 0 then
			table.insert(var_27_3, {
				iter_27_3,
				arg_27_0.curNeedBreakItemList_[iter_27_3]
			})
		end
	end

	for iter_27_4, iter_27_5 in pairs(var_27_3) do
		if arg_27_0.costItemList_[var_27_0] == nil then
			arg_27_0.costItemList_[var_27_0] = CommonItemPool.New(arg_27_0.rewardpanelTrs_, nil, true)
		end

		arg_27_0.costItemList_[var_27_0]:Show(true)

		local var_27_5 = clone(ItemTemplateData)

		function var_27_5.clickFun(arg_29_0)
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_29_0.id,
				arg_29_0.number
			})
		end

		local var_27_6 = iter_27_5[1]
		local var_27_7 = iter_27_5[2]
		local var_27_8 = ItemTools.getItemNum(var_27_6)

		var_27_5.id = var_27_6
		var_27_5.number = var_27_8
		var_27_5.hideBottomRightTextFlag = true
		var_27_5.bottomText = {
			var_27_8,
			var_27_7
		}

		arg_27_0.costItemList_[var_27_0]:SetData(var_27_5)

		var_27_0 = var_27_0 + 1
	end

	for iter_27_6 = var_27_0, #arg_27_0.costItemList_ do
		if arg_27_0.costItemList_[iter_27_6] then
			arg_27_0.costItemList_[iter_27_6]:Show(false)
		end
	end

	if arg_27_0.curWantLevel_ == arg_27_0.curLessLevel_ and arg_27_0.curWantLevel_ == arg_27_0.curMaxLevel_ then
		arg_27_0.addBtnController_:SetSelectedState("noAddAndSub")
	elseif arg_27_0.curWantLevel_ >= arg_27_0.curMaxLevel_ then
		arg_27_0.addBtnController_:SetSelectedState("noAdd")
	elseif arg_27_0.curWantLevel_ <= arg_27_0.curLessLevel_ then
		arg_27_0.addBtnController_:SetSelectedState("noSub")
	else
		arg_27_0.addBtnController_:SetSelectedState("normal")
	end

	arg_27_0.canBreak_ = true

	SetActive(arg_27_0.breakBtnGo_, false)

	local var_27_9 = HeroCfg[arg_27_0.heroInfo_.id]
	local var_27_10 = HeroBreakCfg.get_id_list_by_race[var_27_9.race]

	if arg_27_0.curWantLevel_ and arg_27_0:CheckLevelCanShowBreak(arg_27_0.curWantLevel_) then
		for iter_27_7, iter_27_8 in pairs(var_27_10) do
			if HeroBreakCfg[iter_27_8].max_level == arg_27_0.curWantLevel_ and var_27_10[iter_27_7 + 1] and arg_27_0.heroInfo_.break_level <= HeroBreakCfg[iter_27_8].break_times then
				SetActive(arg_27_0.breakBtnGo_, true)

				if arg_27_0.isSpecialBreak_ == false then
					arg_27_0.isSpecialBreak_ = false
					arg_27_0.specialBreakID_ = var_27_10[iter_27_7]

					arg_27_0.specialBreakController_:SetSelectedState("off")
				end
			end
		end
	end

	if not arg_27_0:CheckUpgrandCondition() and not arg_27_0:CheckUpgrandIsBreak() then
		arg_27_0.tipsController_:SetSelectedState("levelUp")

		local var_27_11 = arg_27_0.curWantLevel_ - arg_27_0.heroInfo_.level

		arg_27_0.levelUpText_.text = string.format(GetTips("LEVELUP_DIFF"), var_27_11)
	end
end

function var_0_0.CheckUpgrandCondition(arg_30_0)
	arg_30_0.btnController_:SetSelectedState("sure")

	arg_30_0.goldNum_.text = arg_30_0.curNeedGold_

	if not checkGold(arg_30_0.curNeedGold_, false) then
		arg_30_0.goldNum_.text = "<color=#F6302F>" .. arg_30_0.curNeedGold_ .. "</color>"
	end

	if arg_30_0.breakIDList_[#arg_30_0.breakIDList_] then
		if HeroBreakCfg[arg_30_0.breakIDList_[#arg_30_0.breakIDList_]].user_level > PlayerData:GetPlayerInfo().userLevel then
			arg_30_0.canBreak_ = false

			arg_30_0.tipsController_:SetSelectedState("lock")
			arg_30_0.btnController_:SetSelectedState("noSure")

			arg_30_0.lockText_.text = GetTips("PLAYER_LEVEL_LESSTHEN_BREAK")

			return true
		end

		for iter_30_0, iter_30_1 in pairs(arg_30_0.curNeedBreakItemList_) do
			if iter_30_1 > ItemTools.getItemNum(iter_30_0) then
				arg_30_0.canBreak_ = false

				arg_30_0.tipsController_:SetSelectedState("lock")
				arg_30_0.btnController_:SetSelectedState("noSure")

				arg_30_0.lockText_.text = GetTips("NEED_MORE_BREAK_ITEM")

				return true
			end
		end
	end

	for iter_30_2, iter_30_3 in pairs(arg_30_0.curUseItemList_) do
		if ItemTools.getItemNum(iter_30_3[1]) < iter_30_3[2] then
			arg_30_0.canBreak_ = false

			arg_30_0.tipsController_:SetSelectedState("lock")
			arg_30_0.btnController_:SetSelectedState("noSure")

			local var_30_0 = arg_30_0.heroInfo_.exp
			local var_30_1 = LvTools.LevelToExp(arg_30_0.curWantLevel_, "hero_level_exp1") - var_30_0
			local var_30_2 = GameSetting.hero_exp_props_id_list.value
			local var_30_3 = 0

			for iter_30_4, iter_30_5 in pairs(var_30_2) do
				var_30_3 = var_30_3 + ItemTools.getItemNum(iter_30_5) * ItemCfg[iter_30_5].param[1]
			end

			local var_30_4 = var_30_1 - var_30_3
			local var_30_5 = 0
			local var_30_6 = 0

			for iter_30_6 = #var_30_2, 1, -1 do
				local var_30_7 = var_30_2[iter_30_6]
				local var_30_8 = ItemCfg[var_30_7].param[1]

				if var_30_8 <= var_30_4 then
					var_30_5 = var_30_7

					if var_30_4 % var_30_8 == 0 then
						var_30_6 = var_30_4 / var_30_8

						break
					end

					var_30_6 = (var_30_4 - var_30_4 % var_30_8) / var_30_8 + 1

					break
				end
			end

			if var_30_5 == 0 then
				var_30_5 = var_30_2[1]
				var_30_6 = 1
			end

			arg_30_0.lockText_.text = string.format(GetTips("NEED_MORE_EXP_ITEM"), var_30_4, GetI18NText(ItemCfg[var_30_5].name), var_30_6)

			return true
		end
	end

	return false
end

function var_0_0.CheckUpgrandIsBreak(arg_31_0)
	local var_31_0 = HeroCfg[arg_31_0.heroInfo_.id]
	local var_31_1 = HeroBreakCfg.get_id_list_by_race[var_31_0.race]

	if arg_31_0.curWantLevel_ then
		for iter_31_0, iter_31_1 in pairs(var_31_1) do
			if HeroBreakCfg[iter_31_1].max_level == arg_31_0.curWantLevel_ and var_31_1[iter_31_0 + 1] and arg_31_0.heroInfo_.break_level <= HeroBreakCfg[iter_31_1].break_times then
				arg_31_0.tipsController_:SetSelectedState("break")

				arg_31_0.specialBreakText_.text = string.format(GetTips("BREAK_HERO_LEVEL_TO"), HeroBreakCfg[var_31_1[iter_31_0 + 1]].max_level)

				return true
			end
		end
	end
end

function var_0_0.OnExit(arg_32_0)
	manager.windowBar:HideBar()

	arg_32_0.curWantLevel_ = 0
	arg_32_0.curUseItemList_ = {}
	arg_32_0.breakIDList_ = {}
	arg_32_0.curNeedBreakItemList_ = {}
	arg_32_0.curNeedGold_ = 0
	arg_32_0.canBreak_ = true
	arg_32_0.init_ = false
	arg_32_0.curLessLevel_ = 0
	arg_32_0.curMaxLevel_ = 0
	arg_32_0.isSpecialBreak_ = false
	arg_32_0.specialBreakID_ = 0
end

function var_0_0.Dispose(arg_33_0)
	var_0_0.super.Dispose(arg_33_0)

	for iter_33_0, iter_33_1 in pairs(arg_33_0.costItemList_) do
		iter_33_1:Dispose()
	end

	arg_33_0.costItemList_ = {}
end

return var_0_0
