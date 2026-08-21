local var_0_0 = class("HeroUpgradeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_arrt/HeroArrtLvupUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local var_0_1 = 0
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.tweens_ = {}
	arg_3_0.breakItems_ = {}
	arg_3_0.needIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.addExpController_ = arg_4_0.controller_:GetController("addExp")
	arg_4_0.typeController_ = arg_4_0.controller_:GetController("type")
	arg_4_0.moneyEnoughController_ = arg_4_0.controller_:GetController("moneyEnough")
	arg_4_0.canBreakController_ = arg_4_0.controller_:GetController("canBreak")
	arg_4_0.conditionBreakController_ = arg_4_0.conditionController_:GetController("conditionItem")

	arg_4_0:InitMaterialItem()
	arg_4_0:InitPropItem()
end

function var_0_0.CameraEnter(arg_5_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		2
	}, false)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.okBtn_, nil, function()
		local var_7_0 = false

		for iter_7_0 = 1, #arg_6_0.items_ do
			if arg_6_0.items_[iter_7_0]:GetData().topAmountValue > 0 then
				var_7_0 = true

				break
			end
		end

		if not var_7_0 then
			ShowTips("HERO_LEVEL_MATERIAL_NOT_SELECTED")

			return
		end

		if arg_6_0:HaveMaterial() then
			local var_7_1 = MaterialTools.materialGiveBack(arg_6_0.cutExp_, ItemConst.STR_ITEM.HERO)

			arg_6_0.cutExpForReward_ = arg_6_0.cutExp_

			if #var_7_1 > 0 then
				JumpTools.OpenPageByJump("materialPreview", {
					content = GetTips("HERO_STRENGTH_EXP_OVERFLOW"),
					OkCallback = function()
						arg_6_0:SendAddExpToServer()
					end,
					itemList = var_7_1
				})

				return
			else
				arg_6_0:SendAddExpToServer()
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function()
					local var_9_0 = GameSetting.hero_exp_props_id_list.value[1]
					local var_9_1 = ItemCfg[var_9_0].source

					JumpTools.JumpToPage(var_9_1[1])
				end
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.oneKeyBtn_, nil, function()
		local var_10_0 = false

		for iter_10_0 = 1, #arg_6_0.items_ do
			if arg_6_0.items_[iter_10_0]:GetData().number > 0 then
				var_10_0 = true

				break
			end
		end

		if arg_6_0:HaveMaterial() and var_10_0 then
			arg_6_0:OnKeyLevelUp()
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function()
					local var_11_0 = GameSetting.hero_exp_props_id_list.value[1]
					local var_11_1 = ItemCfg[var_11_0].source

					JumpTools.JumpToPage(var_11_1[1])
				end
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.breakPreviewBtn_, nil, function()
		JumpTools.OpenPageByJump("heroBreakPreview", {
			heroInfo = arg_6_0.heroInfo_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.breakBtn_, nil, function()
		if arg_6_0.canBreak_ then
			arg_6_0:SendBreakToServer()
		elseif PlayerData:GetPlayerInfo().userLevel < arg_6_0.breakCfg_.user_level then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), arg_6_0.breakCfg_.user_level))
		elseif not arg_6_0:HaveBreakMaterial() then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
		elseif not checkGold(arg_6_0.breakCfg_.cost_gold, true) then
			return
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.upgradeViewBtn1_, nil, function()
		local var_14_0 = GameSetting.hero_exp_props_id_list.value
		local var_14_1 = false

		for iter_14_0, iter_14_1 in pairs(var_14_0) do
			if ItemTools.getItemNum(iter_14_1) > 0 then
				var_14_1 = true

				break
			end
		end

		if var_14_1 then
			JumpTools.OpenPageByJump("heroOneKeyUpgrandView", {
				heroInfo = arg_6_0.heroInfo_,
				proxy = arg_6_0.heroViewProxy_
			})
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function()
					local var_15_0 = GameSetting.hero_exp_props_id_list.value[1]
					local var_15_1 = ItemCfg[var_15_0].source

					JumpTools.JumpToPage(var_15_1[1])
				end
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.upgradeViewBtn2_, nil, function()
		local var_16_0 = GameSetting.hero_exp_props_id_list.value
		local var_16_1 = false

		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			if ItemTools.getItemNum(iter_16_1) > 0 then
				var_16_1 = true

				break
			end
		end

		if var_16_1 then
			JumpTools.OpenPageByJump("heroOneKeyUpgrandView", {
				heroInfo = arg_6_0.heroInfo_,
				proxy = arg_6_0.heroViewProxy_
			})
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function()
					local var_17_0 = GameSetting.hero_exp_props_id_list.value[1]
					local var_17_1 = ItemCfg[var_17_0].source

					JumpTools.JumpToPage(var_17_1[1])
				end
			})
		end
	end)
end

function var_0_0.OnHeroBreak(arg_18_0, arg_18_1, arg_18_2)
	if isSuccess(arg_18_1.result) then
		local var_18_0 = var_0_2

		HeroAction.BreakSuccess(arg_18_0.heroInfo_.id, (arg_18_0.heroInfo_.break_level or 0) + 1)
		JumpTools.OpenPageByJump("newBreakSuccess", {
			heroId = arg_18_0.heroInfo_.id,
			breakLevel = arg_18_0.heroInfo_.break_level or 0,
			oldCrit = var_18_0[HeroConst.HERO_ATTRIBUTE.CRITICAL],
			proxy = arg_18_0.heroViewProxy_
		})

		local var_18_1 = arg_18_0.heroViewProxy_:CalHeroEquipAttribute(arg_18_0.heroInfo_.id)

		var_0_2 = HeroTools.CaculateHeroAttribute(arg_18_0.heroInfo_, var_18_1)
	end
end

function var_0_0.SendAddExpToServer(arg_19_0)
	var_0_1 = arg_19_0.heroInfo_.level

	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.items_) do
		local var_19_1 = iter_19_1:GetData()

		if var_19_1.topAmountValue > 0 then
			table.insert(var_19_0, {
				id = var_19_1.id,
				num = var_19_1.topAmountValue
			})
		end
	end

	HeroAction.AddHeroExp(arg_19_0.heroInfo_.id, var_19_0)
end

function var_0_0.SendBreakToServer(arg_20_0)
	HeroTools.CalFinalAttribute(var_0_2)
	HeroAction.HeroBreak(arg_20_0.heroInfo_.id)
end

function var_0_0.OnAddHeroExp(arg_21_0, arg_21_1)
	if isSuccess(arg_21_1.result) then
		local var_21_0 = arg_21_0.nextLv_
		local var_21_1 = var_0_2

		HeroAction.AddHeroExpSuccess(arg_21_0.heroInfo_.id, arg_21_0.nextLv_, arg_21_0.finalExp_)

		if var_21_0 > var_0_1 then
			JumpTools.OpenPageByJump("newHeroUpgradeSuccess", {
				heroId = arg_21_0.heroInfo_.id,
				oldLv = var_0_1,
				oldAttr = var_21_1,
				proxy = arg_21_0.heroViewProxy_,
				callback = function()
					local var_22_0 = MaterialTools.materialGiveBack(arg_21_0.cutExpForReward_, ItemConst.STR_ITEM.HERO)

					if #var_22_0 > 0 then
						getReward(formatRewardCfgList(var_22_0))
					end
				end
			})
		end

		local var_21_2 = arg_21_0.heroViewProxy_:CalHeroEquipAttribute(arg_21_0.heroInfo_.id)

		var_0_2 = HeroTools.CaculateHeroAttribute(arg_21_0.heroInfo_, var_21_2)

		HeroTools.CalFinalAttribute(var_0_2)

		if not arg_21_0:HaveMaterial() or arg_21_0.nextLv_ >= arg_21_0.curLvMax_ or manager.guide:IsPlaying() then
			-- block empty
		elseif arg_21_0.nextLv_ ~= arg_21_0.curLvMax_ then
			arg_21_0:SelectFirstMaterial()
		end
	end
end

function var_0_0.OnKeyLevelUp(arg_23_0)
	arg_23_0:QuickSelectList()
	arg_23_0:UpdatePreview()
end

function var_0_0.UpdatePreview(arg_24_0)
	arg_24_0.fromLevelText_.text = string.format("%d", arg_24_0.heroInfo_.level)

	local var_24_0 = 0
	local var_24_1 = 0

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.items_) do
		local var_24_2 = iter_24_1:GetData()

		var_24_0 = var_24_0 + ItemCfg[var_24_2.id].param[1] * var_24_2.topAmountValue
		var_24_2.number = arg_24_0:GetNumber(var_24_2.id)
		var_24_2.selectStyle = var_24_2.topAmountValue ~= 0

		iter_24_1:SetData(var_24_2)
		iter_24_1:RefreshGray(var_24_2.number == 0 or var_24_2.topAmountValue > 0)

		if var_24_2.number == 0 then
			var_24_1 = var_24_1 + 1
		end
	end

	local var_24_3, var_24_4, var_24_5, var_24_6, var_24_7 = LvTools.CheckHeroExp(arg_24_0.heroInfo_.level, arg_24_0.heroInfo_.exp + var_24_0, arg_24_0.curLvMax_)

	arg_24_0.finalExp_ = var_24_6
	arg_24_0.cutExp_ = var_24_7
	arg_24_0.addExpText_.text = string.format("+%d", var_24_0 - var_24_7)
	arg_24_0.toLevelText_.text = string.format("%d", var_24_3)

	local var_24_8 = GameLevelSetting[var_24_3].hero_level_exp1

	if var_24_3 >= HeroConst.HERO_LV_MAX then
		arg_24_0.progressText_.text = "-/-"
	else
		arg_24_0.progressText_.text = string.format("%d/%d", var_24_4, var_24_8)
	end

	arg_24_0.currentProgressBar_.value = (arg_24_0.heroInfo_.exp - LvTools.LevelToExp(arg_24_0.heroInfo_.level, "hero_level_exp1")) / var_24_8
	arg_24_0.previewProgressBar_.value = var_24_4 / var_24_8

	if var_24_3 > arg_24_0.heroInfo_.level then
		arg_24_0.currentProgressBar_.value = 0
	end

	arg_24_0.addExpController_:SetSelectedState(tostring(var_24_0 - var_24_7 ~= 0))

	if arg_24_0.nextLv_ ~= var_24_3 then
		arg_24_0.nextLv_ = var_24_3

		arg_24_0:UpdatePreviewAttr()
	end

	SetActive(arg_24_0.maxText_, var_24_3 >= arg_24_0.curLvMax_)
end

function var_0_0.InitMaterialItem(arg_25_0)
	arg_25_0.items_ = {}

	for iter_25_0, iter_25_1 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		local var_25_0 = arg_25_0[string.format("itemGo%d_", iter_25_0)]

		SetActive(var_25_0, true)

		local var_25_1 = CommonItemView.New(var_25_0)

		table.insert(arg_25_0.items_, var_25_1)

		local var_25_2 = clone(ItemTemplateData)

		var_25_2.id = iter_25_1
		var_25_2.number = arg_25_0:GetNumber(iter_25_1)
		var_25_2.topAmountValue = 0

		function var_25_2.longClickFun(arg_26_0, arg_26_1, arg_26_2)
			if arg_26_2.dragging then
				return false
			end

			if arg_26_0.number == 0 then
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_26_0.id,
					arg_26_0.number
				})
			end

			if arg_26_0.number <= arg_26_0.topAmountValue or arg_25_0.cutExp_ >= 0 and arg_25_0.nextLv_ == arg_25_0.curLvMax_ or arg_26_0.topAmountValue == ItemTools.getItemNum(arg_26_0.id) then
				return false
			end

			arg_26_0.topAmountValue = arg_26_0.topAmountValue + 1

			arg_25_0:UpdatePreview()

			return true
		end

		function var_25_2.clickAmountFun(arg_27_0)
			arg_27_0.topAmountValue = arg_27_0.topAmountValue - 1

			arg_25_0:UpdatePreview()

			return true
		end

		var_25_1:SetData(var_25_2)
	end
end

function var_0_0.InitPropItem(arg_28_0)
	arg_28_0.propNames_ = {
		arg_28_0.propName1_,
		arg_28_0.propName2_,
		arg_28_0.propName3_,
		arg_28_0.propName4_
	}
	arg_28_0.propItems_ = {
		arg_28_0.propNum1_,
		arg_28_0.propNum2_,
		arg_28_0.propNum3_,
		arg_28_0.propNum4_
	}
	arg_28_0.toPropItems_ = {
		arg_28_0.toPropNum1_,
		arg_28_0.toPropNum2_,
		arg_28_0.toPropNum3_,
		arg_28_0.toPropNum4_
	}
	arg_28_0.arrowItems_ = {
		arg_28_0.arrowItem1_,
		arg_28_0.arrowItem2_,
		arg_28_0.arrowItem3_,
		arg_28_0.arrowItem4_
	}
	arg_28_0.propIcon_ = {
		arg_28_0.propIcon1_,
		arg_28_0.propIcon2_,
		arg_28_0.propIcon3_,
		arg_28_0.propIcon4_
	}
	arg_28_0.propIndexes_ = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}
	arg_28_0.endfixes_ = {}

	for iter_28_0 = 1, 4 do
		local var_28_0, var_28_1, var_28_2 = SkillTools.GetAttr({
			arg_28_0.propIndexes_[iter_28_0],
			0
		})

		arg_28_0.propNames_[iter_28_0].text = GetI18NText(var_28_0)
		arg_28_0.propIcon_[iter_28_0].sprite = var_28_2
		arg_28_0.endfixes_[iter_28_0] = PublicAttrCfg[arg_28_0.propIndexes_[iter_28_0]].percent == 1 and "%" or ""
	end
end

function var_0_0.UpdateBreakView(arg_29_0)
	var_0_2 = HeroTools.CaculateHeroAttribute(arg_29_0.heroInfo_, {})

	HeroTools.CalFinalAttribute(var_0_2)

	arg_29_0.fromBreakLevelText_.text = arg_29_0.breakCfg_.max_level

	if arg_29_0.nextBreakCfg_ then
		arg_29_0.toBreakLevelText_.text = arg_29_0.nextBreakCfg_.max_level
	end

	arg_29_0.fromCritText_.text = string.format("%.2f", var_0_2[HeroConst.HERO_ATTRIBUTE.CRITICAL] / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")

	local var_29_0 = deepClone(arg_29_0.heroInfo_)

	var_29_0.break_level = var_29_0.break_level + 1

	local var_29_1 = HeroTools.CaculateHeroAttribute(var_29_0, {})

	HeroTools.CalFinalAttribute(var_29_1)

	arg_29_0.toCritText_.text = string.format("%.2f", var_29_1[HeroConst.HERO_ATTRIBUTE.CRITICAL] / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")

	arg_29_0:CheckCanBreak()
end

function var_0_0.CheckCanBreak(arg_30_0)
	arg_30_0.canBreak_ = true

	local var_30_0

	if PlayerData:GetPlayerInfo().userLevel >= arg_30_0.breakCfg_.user_level then
		var_30_0 = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), arg_30_0.breakCfg_.user_level)

		arg_30_0.conditionBreakController_:SetSelectedState("achieve")
	else
		var_30_0 = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), arg_30_0.breakCfg_.user_level)
		arg_30_0.canBreak_ = false

		arg_30_0.conditionBreakController_:SetSelectedState("unsuccessful")
	end

	arg_30_0.conditionText_.text = var_30_0

	local var_30_1 = #arg_30_0.breakCfg_.cost

	for iter_30_0 = 1, 3 do
		local var_30_2 = arg_30_0["breakItemGo" .. iter_30_0 .. "_"]

		if iter_30_0 <= var_30_1 then
			if not arg_30_0.breakItems_[iter_30_0] then
				SetActive(var_30_2, true)

				local var_30_3 = NewHeroBreakMaterialItem.New(arg_30_0, var_30_2)

				table.insert(arg_30_0.breakItems_, var_30_3)
			end

			arg_30_0.breakItems_[iter_30_0]:SetInfo(arg_30_0.breakCfg_.cost[iter_30_0][1], arg_30_0.breakCfg_.cost[iter_30_0][2])

			if not arg_30_0.breakItems_[iter_30_0]:IsEnough() then
				arg_30_0.canBreak_ = false
			end
		else
			SetActive(var_30_2, false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_0.breakItemContent_)

	while var_30_1 < #arg_30_0.breakItems_ do
		arg_30_0.breakItems_[#arg_30_0.breakItems_]:Dispose()
		table.remove(arg_30_0.breakItems_, #arg_30_0.breakItems_)
	end

	arg_30_0.needNumText_.text = string.format("%d", arg_30_0.breakCfg_.cost_gold)

	if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) >= arg_30_0.breakCfg_.cost_gold then
		arg_30_0.moneyEnoughController_:SetSelectedState("true")
	else
		arg_30_0.moneyEnoughController_:SetSelectedState("false")

		arg_30_0.canBreak_ = false
	end

	arg_30_0.canBreakController_:SetSelectedState(tostring(PlayerData:GetPlayerInfo().userLevel >= arg_30_0.breakCfg_.user_level))
end

function var_0_0.OnTop(arg_31_0)
	arg_31_0:UpdateBar()

	arg_31_0.heroInfo_ = arg_31_0.heroViewProxy_:GetHeroData(arg_31_0.params_.heroId)

	if HeroTools.GetHeroMaxLevel(arg_31_0.heroInfo_) <= arg_31_0.heroInfo_.level then
		JumpTools.Back()

		return
	end

	arg_31_0:CheckCanBreak()
end

function var_0_0.HaveMaterial(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		if ItemTools.getItemNum(iter_32_1) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.HaveBreakMaterial(arg_33_0)
	local var_33_0 = #arg_33_0.breakCfg_.cost

	for iter_33_0 = 1, var_33_0 do
		if not arg_33_0.breakItems_[iter_33_0]:IsEnough() then
			return false
		end
	end

	return true
end

function var_0_0.SelectFirstMaterial(arg_34_0)
	local var_34_0 = true

	for iter_34_0 = 1, #arg_34_0.items_ do
		local var_34_1 = arg_34_0.items_[iter_34_0]:GetData()

		var_34_1.selectNum_ = 0

		if var_0_0:GetNumber(var_34_1.id) > 0 and var_34_0 then
			var_34_0 = false
			var_34_1.topAmountValue = 1

			arg_34_0.items_[iter_34_0]:SetData(var_34_1)
			arg_34_0.items_[iter_34_0]:RefreshGray(var_34_1.number == 0)
		else
			var_34_1.topAmountValue = 0

			arg_34_0.items_[iter_34_0]:SetData(var_34_1)
			arg_34_0.items_[iter_34_0]:RefreshGray(var_34_1.number == 0)
		end
	end

	arg_34_0:UpdatePreview()
end

function var_0_0.UpdateBar(arg_35_0)
	if arg_35_0.type_ == "lvUp" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_GOLD
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	end
end

function var_0_0.OnEnter(arg_36_0)
	arg_36_0.heroViewProxy_ = arg_36_0.params_.proxy

	arg_36_0:UpdateView()
	arg_36_0:RegistEventListener(HERO_DATA_MODIFY, handler(arg_36_0, arg_36_0.OnHeroModify))
end

function var_0_0.GetNumber(arg_37_0, arg_37_1)
	return ItemTools.getItemNum(arg_37_1)
end

function var_0_0.OnMaterialModify(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(arg_38_0.items_) do
		local var_38_0 = iter_38_1:GetData()

		if var_38_0.id == arg_38_1 then
			var_38_0.number = arg_38_0:GetNumber(arg_38_1)
			var_38_0.topAmountValue = 0

			iter_38_1:SetData(var_38_0)
			arg_38_0.items_[iter_38_0]:RefreshGray(var_38_0.number == 0)
		end
	end
end

function var_0_0.QuickSelectList(arg_39_0)
	local var_39_0 = LvTools.LevelToExp(arg_39_0.curLvMax_, "hero_level_exp1") - arg_39_0.heroInfo_.exp
	local var_39_1 = {}

	for iter_39_0 = 1, #arg_39_0.items_ do
		local var_39_2 = arg_39_0.items_[iter_39_0]:GetData()
		local var_39_3 = ItemCfg[var_39_2.id].param[1]

		var_39_1[iter_39_0] = math.max(math.min(math.ceil(var_39_0 / var_39_3), var_39_2.number), 0)
		var_39_0 = var_39_0 - var_39_1[iter_39_0] * var_39_3

		if var_39_0 < 0 and iter_39_0 > 1 then
			local var_39_4 = -var_39_0

			for iter_39_1 = iter_39_0 - 1, 1, -1 do
				local var_39_5 = arg_39_0.items_[iter_39_1]:GetData()
				local var_39_6 = ItemCfg[var_39_5.id].param[1]
				local var_39_7 = math.modf(var_39_4 / var_39_6)
				local var_39_8 = var_39_1[iter_39_1]

				var_39_1[iter_39_1] = math.max(0, var_39_1[iter_39_1] - var_39_7)

				local var_39_9 = math.min(var_39_8, var_39_7)

				var_39_4 = var_39_4 - var_39_6 * var_39_9
				var_39_0 = var_39_0 + var_39_6 * var_39_9
			end
		end

		if var_39_0 <= 0 then
			break
		end
	end

	for iter_39_2 = 1, #arg_39_0.items_ do
		if var_39_1[iter_39_2] == nil then
			var_39_1[iter_39_2] = 0
		end

		arg_39_0.items_[iter_39_2]:GetData().topAmountValue = var_39_1[iter_39_2]
		arg_39_0.selectStyle = var_39_1[iter_39_2] ~= 0
	end
end

function var_0_0.UpdatePreviewAttr(arg_40_0)
	var_0_2 = arg_40_0.heroViewProxy_:GetHeroAllAttribute(arg_40_0.heroInfo_.id)
	var_0_3 = arg_40_0:GetPreviewAttribute(arg_40_0.heroInfo_.id)

	for iter_40_0, iter_40_1 in pairs(arg_40_0.propItems_) do
		local var_40_0 = PublicAttrCfg[arg_40_0.propIndexes_[iter_40_0]].percent == 1
		local var_40_1 = var_0_2[arg_40_0.propIndexes_[iter_40_0]] or 0
		local var_40_2 = var_0_3[arg_40_0.propIndexes_[iter_40_0]]

		SetActive(arg_40_0.toPropItems_[iter_40_0].gameObject, var_40_2 - var_40_1 ~= 0)
		SetActive(arg_40_0.arrowItems_[iter_40_0], var_40_2 - var_40_1 ~= 0)

		if var_40_0 then
			iter_40_1.text = string.format("%.2f", var_40_1 / 10) .. arg_40_0.endfixes_[iter_40_0]
		else
			iter_40_1.text = math.floor(var_40_1)
		end

		if var_40_0 then
			arg_40_0.toPropItems_[iter_40_0].text = string.format("%.2f", var_40_2 / 10) .. arg_40_0.endfixes_[iter_40_0]
		else
			arg_40_0.toPropItems_[iter_40_0].text = math.floor(var_40_2)
		end
	end
end

function var_0_0.UpdateView(arg_41_0)
	arg_41_0.heroInfo_ = arg_41_0.heroViewProxy_:GetHeroData(arg_41_0.params_.heroId)
	arg_41_0.heroCfg_ = HeroCfg[arg_41_0.params_.heroId]

	if arg_41_0.heroInfo_.level == HeroConst.HERO_LV_MAX then
		arg_41_0:Back()

		return
	end

	arg_41_0.curLvMax_ = HeroTools.GetHeroCurrentMaxLevel(arg_41_0.heroInfo_)
	arg_41_0.breakCfg_ = HeroTools.GetHeroBreakConfig(arg_41_0.heroCfg_.race, arg_41_0.heroInfo_.break_level or 0)
	arg_41_0.breakIdList_ = HeroBreakCfg.get_id_list_by_race[arg_41_0.heroCfg_.race]

	if arg_41_0.heroInfo_.break_level < #arg_41_0.breakIdList_ - 1 then
		arg_41_0.nextBreakCfg_ = HeroTools.GetHeroBreakConfig(arg_41_0.heroCfg_.race, arg_41_0.heroInfo_.break_level + 1 or 0)
	end

	local var_41_0 = arg_41_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_41_0.params_.heroId).id

	manager.heroRaiseTrack:SetModelState(var_41_0)

	if arg_41_0.heroInfo_.level == arg_41_0.curLvMax_ then
		arg_41_0.type_ = "break"
	else
		arg_41_0.type_ = "lvUp"
	end

	arg_41_0.typeController_:SetSelectedState(arg_41_0.type_)

	if arg_41_0.type_ == "lvUp" then
		arg_41_0:SelectFirstMaterial()

		local var_41_1 = arg_41_0.heroViewProxy_:GetHeroAllAttribute(arg_41_0.heroInfo_.id)

		for iter_41_0, iter_41_1 in ipairs(arg_41_0.propItems_) do
			local var_41_2 = var_41_1[arg_41_0.propIndexes_[iter_41_0]] or 0

			if PublicAttrCfg[arg_41_0.propIndexes_[iter_41_0]].percent == 1 then
				iter_41_1.text = string.format("%.2f", var_41_2 / 10) .. arg_41_0.endfixes_[iter_41_0]
			else
				iter_41_1.text = math.floor(var_41_2)
			end
		end
	elseif arg_41_0.type_ == "break" then
		arg_41_0:UpdateBreakView()
	end

	arg_41_0:UpdateBar()
end

function var_0_0.GetPreviewAttribute(arg_42_0, arg_42_1)
	local var_42_0 = deepClone(arg_42_0.heroViewProxy_:GetHeroData(arg_42_1))
	local var_42_1 = {}

	for iter_42_0, iter_42_1 in pairs(var_42_0.equip) do
		if iter_42_1.equip_id ~= 0 then
			table.insert(var_42_1, EquipData:GetEquipData(iter_42_1.equip_id))
		end
	end

	var_42_0.level = arg_42_0.nextLv_

	if var_42_0.servant_uid ~= 0 then
		local var_42_2 = WeaponServantData.GetWeaponServantList()[var_42_0.servant_uid]

		var_42_0.servantInfo = {
			id = var_42_2.id,
			stage = var_42_2.stage
		}
	else
		var_42_0.servantInfo = nil
	end

	local var_42_3 = GetHeroFinalAttr(var_42_0, var_42_0.servantInfo, var_42_1)
	local var_42_4 = var_42_3[HeroConst.HERO_ATTRIBUTE.ATK] or 0
	local var_42_5 = var_42_3[HeroConst.HERO_ATTRIBUTE.ARM] or 0
	local var_42_6 = var_42_3[HeroConst.HERO_ATTRIBUTE.STA] or 0
	local var_42_7 = var_42_3[11] or 0
	local var_42_8 = var_42_3[12] or 0
	local var_42_9 = var_42_3[13] or 0
	local var_42_10 = var_42_3[21] or 0
	local var_42_11 = var_42_3[22] or 0
	local var_42_12 = var_42_3[31] or 0
	local var_42_13 = var_42_3[32] or 0

	var_42_3[HeroConst.HERO_ATTRIBUTE.ATK] = var_42_4 * (1 + var_42_7 / 1000 + var_42_9 / 1000) + var_42_8
	var_42_3[HeroConst.HERO_ATTRIBUTE.ARM] = var_42_5 * (1 + var_42_10 / 1000) + var_42_11
	var_42_3[HeroConst.HERO_ATTRIBUTE.STA] = var_42_6 * (1 + var_42_12 / 1000) + var_42_13

	return var_42_3
end

function var_0_0.OnExit(arg_43_0)
	manager.windowBar:HideBar()
	arg_43_0:RemoveAllEventListener()
end

function var_0_0.OnHeroModify(arg_44_0, arg_44_1)
	if arg_44_1 == arg_44_0.heroInfo_.id then
		arg_44_0:UpdateView()
	end
end

function var_0_0.Dispose(arg_45_0)
	if arg_45_0.breakItems_ then
		for iter_45_0, iter_45_1 in pairs(arg_45_0.breakItems_) do
			iter_45_1:Dispose()
		end

		arg_45_0.breakItems_ = nil
	end

	if arg_45_0.items_ then
		for iter_45_2, iter_45_3 in pairs(arg_45_0.items_) do
			iter_45_3:Dispose()
		end

		arg_45_0.items_ = nil
	end

	if arg_45_0.tweens_ then
		arg_45_0.tweens_ = {}
	end

	arg_45_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_45_0)
end

return var_0_0
