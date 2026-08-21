local var_0_0 = class("EquipResetView", EquipBaseView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.params_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.toggles_ = {
		arg_2_0.raceRebuildToggle_,
		arg_2_0.heroRebuildToggle_
	}

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.materialList_ = {}
	arg_3_0.itemList_ = {}

	for iter_3_0 = 1, 2 do
		local var_3_0 = EquipData:GetRaceMaterial(iter_3_0)

		arg_3_0.materialList_[iter_3_0] = var_3_0

		if var_3_0 then
			local var_3_1 = CommonItemView.New(arg_3_0["commonItem_" .. iter_3_0])
			local var_3_2 = clone(ItemTemplateData)

			var_3_2.id = var_3_0.id

			function var_3_2.clickFun(arg_4_0)
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_4_0.id,
					arg_4_0.number
				})
			end

			var_3_1:SetData(var_3_2)

			arg_3_0.itemList_[iter_3_0] = var_3_1
		end
	end

	arg_3_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	arg_3_0.selectController = arg_3_0.selectCon_:GetController("select")
	arg_3_0.raceController_ = arg_3_0.transCon_:GetController("race")
	arg_3_0.costContrller_ = arg_3_0.transCon_:GetController("cost")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnRace_, nil, function()
		arg_5_0:OnRaceClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.clickBtn_1, nil, function()
		if arg_5_0.heroID_ ~= 0 then
			ShowTips("EQUIP_HERO_HAD_REBUILT")

			return
		end

		EquipData:SetRaceIndex(1)
		arg_5_0.selectController:SetSelectedState("race")

		arg_5_0.selectType_ = 1

		arg_5_0:RefreshMoney()
	end)
	arg_5_0:AddBtnListener(arg_5_0.clickBtn_2, nil, function()
		if arg_5_0.heroID_ ~= 0 then
			ShowTips("EQUIP_HERO_HAD_REBUILT")

			return
		end

		if arg_5_0.race_ == 0 then
			ShowTips("EQUIP_RACE_REBUILD_FIRST")

			return
		end

		EquipData:SetRaceIndex(2)
		arg_5_0.selectController:SetSelectedState("hero")

		arg_5_0.selectType_ = 2

		arg_5_0:RefreshMoney()
	end)
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:ChangeBar()
end

function var_0_0.ChangeBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.equipHeroId = arg_11_0.params_.heroId

	arg_11_0:OnEquipChange(arg_11_0.params_.equipId)
	arg_11_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_11_0, arg_11_0.OnGoldChange))
end

function var_0_0.OnEquipChange(arg_12_0, arg_12_1)
	arg_12_0.equipId = arg_12_1

	arg_12_0:RefreshUI()
	arg_12_0:RefreshSelectType()
	arg_12_0:RefreshMoney()
	arg_12_0:RefreshMaterial()
	arg_12_0:ChangeBar()
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = EquipData:GetEquipData(arg_13_0.equipId)

	if not var_13_0 then
		return
	end

	arg_13_0.race_ = 0
	arg_13_0.heroID_ = 0

	local var_13_1 = RaceEffectCfg.all

	if var_13_0.race == 0 then
		arg_13_0.costContrller_:SetSelectedState("on")
	elseif table.keyof(var_13_1, var_13_0.race) ~= nil then
		arg_13_0.race_ = var_13_0.race

		arg_13_0.costContrller_:SetSelectedState("on")
	else
		arg_13_0.heroID_ = var_13_0.race

		arg_13_0.costContrller_:SetSelectedState("off")
	end

	local var_13_2

	if arg_13_0.heroID_ ~= 0 then
		local var_13_3 = HeroCfg[arg_13_0.heroID_]

		if var_13_3 then
			arg_13_0.raceController_:SetSelectedIndex(2)

			local var_13_4 = string.format("%s·%s", GetI18NText(var_13_3.name), GetI18NText(var_13_3.suffix))
			local var_13_5 = SettingData:GetCurrentLanguage()

			if var_13_5 == "fr" or var_13_5 == "de" then
				var_13_4 = string.format("%s-%s", GetI18NText(var_13_3.name), GetI18NText(var_13_3.suffix))
			end

			arg_13_0.heroText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), GetI18NText(var_13_4))
			arg_13_0.imgHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_13_0.heroID_)
		end
	elseif arg_13_0.race_ ~= 0 then
		local var_13_6 = RaceEffectCfg[arg_13_0.race_]

		if var_13_6 then
			arg_13_0.raceController_:SetSelectedIndex(1)

			arg_13_0.groupText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_13_6.name))
			arg_13_0.imgGroup_.sprite = getSprite("Atlas/SystemGroupAtlas", var_13_6.icon2)
		end
	else
		arg_13_0.raceController_:SetSelectedIndex(0)
	end

	local var_13_7 = arg_13_0.heroID_ == 0

	arg_13_0.btnRace_.interactable = var_13_7
end

function var_0_0.RefreshSelectType(arg_14_0)
	if arg_14_0.heroID_ ~= 0 then
		if arg_14_0.selectType_ and arg_14_0.selectType_ ~= 0 then
			arg_14_0.selectController:SetSelectedState("noselect")
		end

		arg_14_0.selectType_ = 1
	elseif arg_14_0.race_ ~= 0 then
		local var_14_0 = EquipData:GetRaceIndex()

		arg_14_0.selectController:SetSelectedIndex(var_14_0 - 1)

		arg_14_0.selectType_ = var_14_0
	else
		arg_14_0.selectController:SetSelectedState("race")

		arg_14_0.selectType_ = 1

		EquipData:SetRaceIndex(1)
	end
end

function var_0_0.RefreshMoney(arg_15_0)
	if arg_15_0.selectType_ ~= nil and arg_15_0.selectType_ ~= 0 then
		local var_15_0 = arg_15_0.materialList_[arg_15_0.selectType_].money
		local var_15_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
		local var_15_2 = tostring(var_15_0)

		if var_15_1 < var_15_0 then
			var_15_2 = "<color='#FF0000'>" .. var_15_2 .. "</color>"
		end

		arg_15_0.costNum_.text = var_15_2
	end
end

function var_0_0.RefreshMaterial(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.materialList_) do
		local var_16_0 = ItemTools.getItemNum(iter_16_1.id)
		local var_16_1 = tostring(var_16_0)

		if var_16_0 < iter_16_1.number then
			var_16_1 = "<color='#FF0000'>" .. var_16_1 .. "</color>"
		end

		arg_16_0.itemList_[iter_16_0]:SetBottomAmountText(var_16_1 .. "/" .. iter_16_1.number)
	end
end

function var_0_0.OnRaceClick(arg_17_0)
	local var_17_0 = arg_17_0.equipId

	if arg_17_0.selectType_ == 1 then
		EquipAction.QueryEquipRace(var_17_0, arg_17_0.selectType_, arg_17_0.equipHeroId)
	else
		arg_17_0:Go("/equipHeroRebuild", {
			equipId = arg_17_0.equipId,
			proxy = arg_17_0.params_.proxy
		})
	end
end

function var_0_0.OnEquipRaceConfirm(arg_18_0)
	arg_18_0:RefreshUI()
	arg_18_0:RefreshMoney()
	arg_18_0:RefreshMaterial()
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0.selectController:SetSelectedState("noselect")
	arg_19_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.itemList_ then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0.itemList_) do
			iter_20_1:Dispose()
		end

		arg_20_0.itemList_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.OnGoldChange(arg_21_0, arg_21_1)
	if arg_21_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		arg_21_0:RefreshMoney()
	end
end

return var_0_0
