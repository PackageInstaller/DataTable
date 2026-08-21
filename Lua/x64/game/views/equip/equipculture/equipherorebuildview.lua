local var_0_0 = class("EquipHeroRebuildView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/HeroEquipHeroReset"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroIdList_ = {}
	arg_3_0.heroList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, HeroLongHead)

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.currentController_ = arg_3_0.currentCon_:GetController("state")
	arg_3_0.targetController_ = arg_3_0.targetCon_:GetController("state")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.material_ = EquipData:GetRaceMaterial(2)

	if arg_4_0.material_ then
		arg_4_0.itemView_ = CommonItemView.New(arg_4_0.commonItem_, true)

		local var_4_0 = clone(ItemTemplateData)
		local var_4_1 = ItemTools.getItemNum(arg_4_0.material_.id)

		var_4_0.id = arg_4_0.material_.id
		var_4_0.number = nil
		var_4_0.bottomText = {
			var_4_1,
			arg_4_0.material_.number
		}

		function var_4_0.clickFun(arg_5_0)
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_5_0.id,
				arg_5_0.number
			})
		end

		arg_4_0.itemView_:SetData(var_4_0)
	end

	arg_4_0.cost_ = arg_4_0.material_ and arg_4_0.material_.money or 0
	arg_4_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.heroIdList_[arg_6_1]

	arg_6_2.gameObject_.name = tostring(var_6_0)

	arg_6_2:SetProxy(arg_6_0.params_.proxy)
	arg_6_2:SetHeroId(var_6_0, HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_6_2:SetSelected(var_6_0 == arg_6_0.curHeroID_)
	arg_6_2:RegisterClickListener(function()
		arg_6_0:SelectHero(arg_6_2.heroId_)
	end)
end

function var_0_0.SelectHero(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.heroList_:GetItemList()) do
		iter_8_1:SetSelected(iter_8_1.heroId_ == arg_8_1)
	end

	arg_8_0.curHeroID_ = arg_8_1

	arg_8_0:RefreshUI()
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.rebuildBtn_, nil, function()
		local var_10_0 = arg_9_0.cost_
		local var_10_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
		local var_10_2 = ItemTools.getItemNum(arg_9_0.material_.id)

		if var_10_1 < var_10_0 then
			local var_10_3 = false
			local var_10_4 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND]

			for iter_10_0, iter_10_1 in ipairs(var_10_4 or {}) do
				if ItemTools.getItemNum(iter_10_1) > 0 then
					var_10_3 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or var_10_3 then
				JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)

				return
			else
				ShowTips(GetTips("ERROR_ITEM_NOT_ENOUGH_GOLD"))
			end
		elseif arg_9_0.material_ and var_10_2 < arg_9_0.material_.number then
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_9_0.material_.id,
				arg_9_0.material_.number
			})
		else
			local var_10_5 = SettingData:GetRemindSettingData()

			if _G.SkipTip.EquipHeroRebuildSkip or var_10_5.rebuild_hero_equip_reminder ~= 1 then
				EquipAction.QueryEquipRace(arg_9_0.equipID_, 2, arg_9_0.curHeroID_)

				return
			end

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("EQUIP_HERO_REBUILD_WARNING"), HeroTools.GetHeroFullName(arg_9_0.curHeroID_)),
				OkCallback = function()
					EquipAction.QueryEquipRace(arg_9_0.equipID_, 2, arg_9_0.curHeroID_)
				end,
				ToggleCallback = function(arg_12_0)
					_G.SkipTip.EquipHeroRebuildSkip = arg_12_0
				end
			})
		end
	end)
end

function var_0_0.OnEnter(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_13_0.curHeroID_ = nil
	arg_13_0.equipID_ = arg_13_0.params_.equipId

	local var_13_0 = EquipData:GetEquipData(arg_13_0.equipID_)

	if not var_13_0 then
		return
	end

	arg_13_0.race_ = var_13_0.race

	local var_13_1 = EquipTools.GetEquipedHeroId(arg_13_0.equipID_)

	if var_13_1 ~= 0 and HeroCfg[var_13_1].race == arg_13_0.race_ then
		arg_13_0.curHeroID_ = var_13_1
	end

	arg_13_0:RefreshHeroList()
	arg_13_0:RefreshMoney()
	arg_13_0:RefreshMaterial()
	arg_13_0:RefreshUI()
	arg_13_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_13_0, arg_13_0.OnGoldChange))
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.RefreshHeroList(arg_16_0)
	local var_16_0 = HeroData:GetHeroList()
	local var_16_1 = {}
	local var_16_2

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if HeroCfg[iter_16_1.id].race == arg_16_0.race_ and iter_16_1.unlock ~= 0 then
			var_16_1[#var_16_1 + 1] = iter_16_1.id
		end
	end

	arg_16_0.heroIdList_ = var_16_1

	arg_16_0.heroList_:StartScroll(#arg_16_0.heroIdList_)
end

function var_0_0.RefreshMoney(arg_17_0)
	local var_17_0 = arg_17_0.cost_
	local var_17_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_17_2 = tostring(var_17_0)

	if var_17_1 < var_17_0 then
		var_17_2 = "<color='#FF0000'>" .. var_17_2 .. "</color>"
	end

	arg_17_0.costNum_.text = var_17_2
	arg_17_0.material_ = EquipData:GetRaceMaterial(2)

	local var_17_3 = ItemTools.getItemNum(arg_17_0.material_.id)

	arg_17_0.itemView_:RefreshBottomText({
		var_17_3,
		arg_17_0.material_.number
	})
end

function var_0_0.RefreshMaterial(arg_18_0)
	return
end

function var_0_0.RefreshUI(arg_19_0)
	local var_19_0

	if arg_19_0.curHeroID_ ~= nil then
		arg_19_0.targetController_:SetSelectedIndex(1)

		local var_19_1 = HeroCfg[arg_19_0.curHeroID_]
		local var_19_2 = string.format("%s·%s", GetI18NText(var_19_1.name), GetI18NText(var_19_1.suffix))
		local var_19_3 = SettingData:GetCurrentLanguage()

		if var_19_3 == "fr" or var_19_3 == "de" then
			var_19_2 = string.format("%s-%s", GetI18NText(var_19_1.name), GetI18NText(var_19_1.suffix))
		end

		arg_19_0.targetText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), GetI18NText(var_19_2))
		arg_19_0.targetHeroIcon_.sprite = SpritePathCfg.HeroMediumIcon.path .. arg_19_0.curHeroID_

		HeroTools.GetSmallHeadSprite(arg_19_0.curHeroID_)
	else
		arg_19_0.targetController_:SetSelectedIndex(0)
	end

	local var_19_4 = RaceEffectCfg[arg_19_0.race_]

	if var_19_4 then
		arg_19_0.currentController_:SetSelectedIndex(1)

		arg_19_0.currentText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_19_4.name))
		arg_19_0.currenGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", var_19_4.icon2)
	end

	local var_19_5 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_19_6 = arg_19_0.curHeroID_ ~= nil

	arg_19_0.rebuildBtn_.interactable = var_19_6
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.itemView_ then
		arg_20_0.itemView_:Dispose()

		arg_20_0.itemView_ = nil
	end

	if arg_20_0.filterView_ then
		arg_20_0.filterView_:Dispose()

		arg_20_0.filterView_ = nil
	end

	arg_20_0.heroList_:Dispose()
	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.OnGoldChange(arg_21_0, arg_21_1)
	if arg_21_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		arg_21_0:RefreshMoney()
	end
end

function var_0_0.OnEquipRace(arg_22_0)
	arg_22_0:Back()
end

return var_0_0
