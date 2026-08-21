local var_0_0 = class("WeaponQuickView", ReduxView)
local var_0_1 = {
	can_level_up = "CAN_LEVEL_UP",
	break_material_limit = "UPGRADE_MATERIAL_LACK",
	level_material_limit = "LEVELUP_MATERIAL_LACK",
	gold_limit = "LACK_CURRENCY",
	user_level_limit = "ERROR_USER_LEVEL_LIMIT"
}
local var_0_2 = {}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_key/HeroKeyPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:BindController()
	arg_3_0:AddUIListener()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.RenderItem), arg_3_0.uiListGo_, CommonItemView)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:InitContext()
	arg_4_0:InitData()
	arg_4_0:InitSlider()
	arg_4_0:OnTargetLevelChanged()
	arg_4_0:RefreshUI()
end

function var_0_0.OnTop(arg_5_0)
	if arg_5_0.heroID then
		local var_5_0 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
		local var_5_1 = deepClone(var_5_0:GetHeroWeaponInfo(arg_5_0.heroID))

		if var_5_1.level == HeroConst.WEAPON_LV_MAX then
			JumpTools.Back()

			return
		end

		if not arg_5_0:DeepCompare(var_5_1, arg_5_0.weaponInfo) then
			arg_5_0.weaponInfo = var_5_1

			arg_5_0:InitContext()
			arg_5_0:InitData()
			arg_5_0:InitSlider()
			arg_5_0:OnTargetLevelChanged()
		else
			arg_5_0:InitContext()
			arg_5_0:InitData()
			arg_5_0:OnTargetLevelChanged()
		end
	end

	arg_5_0:RefreshUI()
	manager.windowBar:SetAsLastSibling()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function var_0_0.OnBehind(arg_6_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.BindController(arg_8_0)
	arg_8_0.tipController_ = arg_8_0.tipControllerEx_:GetController("tip")
	arg_8_0.toggleController_ = arg_8_0.toggleControllerEx_:GetController("select")
	arg_8_0.btnController_ = arg_8_0.mainControllerEx_:GetController("btnState")
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.scrollHelper_:Dispose()
	arg_9_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.InitContext(arg_10_0)
	arg_10_0.context = {
		cost = 0,
		breakNum = 0,
		state = "",
		can_level_up = false,
		totalExp = 0,
		needExp = 0,
		material_list = {},
		servant_list = {},
		break_material_list = {}
	}
end

function var_0_0.InitData(arg_11_0)
	arg_11_0.all_material_list = {}
	arg_11_0.all_servant_list = {}
	arg_11_0.weaponInfo = {}
	arg_11_0.heroID = 0
	arg_11_0.targetLevel = 0
	arg_11_0.isBreak = false
	arg_11_0.addInteract_ = true
	arg_11_0.subInteract_ = true
	arg_11_0.sliderInteract_ = true

	arg_11_0:InitMaterialList()

	arg_11_0.heroID = arg_11_0.params_.heroID

	local var_11_0 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

	arg_11_0.weaponInfo = deepClone(var_11_0:GetHeroWeaponInfo(arg_11_0.heroID))
end

function var_0_0.InitMaterialList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		local var_12_2 = ItemTools.getItemNum(iter_12_1)

		if ItemCfg[iter_12_1].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and var_12_2 > 0 then
			local var_12_3 = clone(ItemTemplateData)

			var_12_3.type = ItemConst.ITEM_TYPE.MATERIAL
			var_12_3.id = iter_12_1
			var_12_3.number = var_12_2
			var_12_3.index = 0
			var_12_3.selectStyle = false

			table.insert(var_12_0, var_12_3)
		end
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		return ItemCfg[arg_13_0.id].rare < ItemCfg[arg_13_1.id].rare
	end)

	local var_12_4 = ServantTools.GetServantLimited(true, true)

	for iter_12_2, iter_12_3 in ipairs(var_12_4) do
		local var_12_5 = clone(ItemTemplateData)

		var_12_5.type = ItemConst.ITEM_TYPE.WEAPON_SERVANT
		var_12_5.uid = iter_12_3.uid
		var_12_5.id = iter_12_3.id
		var_12_5.number = iter_12_3.stage
		var_12_5.addLevel = iter_12_3.stage
		var_12_5.index = 0
		var_12_5.selectStyle = false

		table.insert(var_12_1, var_12_5)
	end

	table.sort(var_12_1, function(arg_14_0, arg_14_1)
		local var_14_0 = WeaponServantCfg[arg_14_0.id].starlevel
		local var_14_1 = WeaponServantCfg[arg_14_1.id].starlevel
		local var_14_2 = arg_14_0.number
		local var_14_3 = arg_14_1.number
		local var_14_4 = WeaponServantCfg[arg_14_0.id].race
		local var_14_5 = WeaponServantCfg[arg_14_1.id].race
		local var_14_6 = arg_14_0.id
		local var_14_7 = arg_14_1.id

		if not selectTrain and var_14_0 ~= var_14_1 then
			if selectDescSort then
				return var_14_1 < var_14_0
			else
				return var_14_0 < var_14_1
			end
		end

		if var_14_2 ~= var_14_3 then
			if selectDescSort then
				return var_14_3 < var_14_2
			else
				return var_14_2 < var_14_3
			end
		end

		if selectTrain and var_14_0 ~= var_14_1 then
			if selectDescSort then
				return var_14_1 < var_14_0
			else
				return var_14_0 < var_14_1
			end
		end

		if var_14_4 ~= var_14_5 then
			return var_14_4 < var_14_5
		end

		if var_14_6 ~= var_14_7 then
			if selectDescSort then
				return var_14_7 < var_14_6
			else
				return var_14_6 < var_14_7
			end
		end

		return arg_14_0.uid < arg_14_1.uid
	end)

	arg_12_0.all_material_list = var_12_0
	arg_12_0.all_servant_list = var_12_1
end

function var_0_0.InitSlider(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0:GetStartAndEndLevel()

	arg_15_0.levelSlider_.minValue = var_15_0
	arg_15_0.levelSlider_.maxValue = var_15_1

	local var_15_2 = 0

	for iter_15_0 = var_15_0, var_15_1 do
		if arg_15_0:BuildContext(iter_15_0, false) then
			var_15_2 = iter_15_0
		else
			break
		end
	end

	arg_15_0.levelSlider_.value = var_15_2

	if var_15_0 == var_15_1 then
		arg_15_0.addInteract_ = false
		arg_15_0.subInteract_ = false
		arg_15_0.sliderInteract_ = false
		arg_15_0.levelSlider_.minValue = var_15_0 - 1
		arg_15_0.levelSlider_.value = var_15_1
	else
		arg_15_0.addInteract_ = true
		arg_15_0.subInteract_ = true
		arg_15_0.sliderInteract_ = true
	end
end

function var_0_0.AddUIListener(arg_16_0)
	arg_16_0:AddBtnListener(arg_16_0.btn_noBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_16_0:AddBtnListener(arg_16_0.btn_yesBtn_, nil, function()
		arg_16_0:OnYesBtnClicked()
	end)
	arg_16_0:AddBtnListener(arg_16_0.toggle_, nil, function()
		arg_16_0:ChangeBreak(not arg_16_0.isBreak)
	end)
	arg_16_0:AddPressingByTimeListener(arg_16_0.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_16_0.addInteract_ == false or arg_16_0.sliderInteract_ == false then
			return
		end

		if arg_16_0.levelSlider_.value < arg_16_0.levelSlider_.maxValue then
			arg_16_0.levelSlider_.value = math.min(arg_16_0.levelSlider_.value + 1, arg_16_0.levelSlider_.maxValue)

			return true
		end

		return false
	end)
	arg_16_0:AddPressingByTimeListener(arg_16_0.subBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_16_0.subInteract_ == false or arg_16_0.sliderInteract_ == false then
			return
		end

		if arg_16_0.levelSlider_.value > arg_16_0.levelSlider_.minValue then
			arg_16_0.levelSlider_.value = math.max(arg_16_0.levelSlider_.value - 1, arg_16_0.levelSlider_.minValue)

			return true
		end

		return false
	end)
	arg_16_0.levelSlider_.onValueChanged:AddListener(function()
		arg_16_0:OnTargetLevelChanged()
	end)
end

function var_0_0.OnYesBtnClicked(arg_23_0)
	if checkGold(arg_23_0.context.cost, false) then
		WeaponAction.WeaponLvUp(arg_23_0.heroID, arg_23_0.context.material_list, arg_23_0.context.servant_list, arg_23_0.targetLevel, arg_23_0.context.breakNum, arg_23_0.context.needExp, arg_23_0.weaponInfo.breakthrough, arg_23_0.weaponInfo.level)
		JumpTools.Back()
	else
		local var_23_0 = false
		local var_23_1 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND]

		for iter_23_0, iter_23_1 in ipairs(var_23_1 or {}) do
			if ItemTools.getItemNum(iter_23_1) > 0 then
				var_23_0 = true

				break
			end
		end

		if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or var_23_0 then
			JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)
		end
	end
end

function var_0_0.OnTargetLevelChanged(arg_24_0)
	arg_24_0.targetLevel = arg_24_0.levelSlider_.value

	if arg_24_0.levelSlider_.value == arg_24_0.levelSlider_.maxValue then
		arg_24_0.addInteract_ = false
	else
		arg_24_0.addInteract_ = true
	end

	if arg_24_0.levelSlider_.value == arg_24_0.levelSlider_.minValue then
		arg_24_0.subInteract_ = false
	else
		arg_24_0.subInteract_ = true
	end

	arg_24_0:ChangeBreak(false)
	arg_24_0:BuildContext(arg_24_0.targetLevel, false)

	local var_24_0, var_24_1 = arg_24_0:CheckQuickLv(arg_24_0.targetLevel, false)

	arg_24_0:RefreshUI()
end

function var_0_0.ChangeBreak(arg_25_0, arg_25_1)
	arg_25_0.isBreak = arg_25_1

	arg_25_0.toggleController_:SetSelectedState(arg_25_1 and "on" or "off")

	if arg_25_1 then
		arg_25_0:RefreshBreak()
		arg_25_0:BuildContext(arg_25_0.targetLevel, arg_25_0.isBreak)
	else
		arg_25_0:BuildContext(arg_25_0.targetLevel, arg_25_0.isBreak)
		arg_25_0:RefreshBreak()
	end

	arg_25_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_26_0)
	arg_26_0:RefreshText()
	arg_26_0:RefreshState()
	arg_26_0:RefreshItem()
	arg_26_0:RefreshInteract()
end

function var_0_0.RefreshBreak(arg_27_0)
	if arg_27_0:CanChooseBreak(arg_27_0.targetLevel) and (arg_27_0:CheckQuickLv(arg_27_0.targetLevel, false) or arg_27_0.context.state == var_0_1.gold_limit) then
		SetActive(arg_27_0.toggle_.gameObject, true)
	else
		SetActive(arg_27_0.toggle_.gameObject, false)
	end
end

function var_0_0.RefreshText(arg_28_0)
	arg_28_0.leftLvTxt_.text = tostring(arg_28_0.weaponInfo.level)
	arg_28_0.rightLvTxt_.text = tostring(arg_28_0.targetLevel)

	if not checkGold(arg_28_0.context.cost, false) then
		arg_28_0.goldText_.text = "<color='#FF0000'>" .. tostring(arg_28_0.context.cost) .. "</color>"
	else
		arg_28_0.goldText_.text = tostring(arg_28_0.context.cost)
	end

	arg_28_0.lvNumText_.text = string.format(string.format(GetTips("LEVELUP_DIFF"), arg_28_0.targetLevel - arg_28_0.weaponInfo.level))
	arg_28_0.breakText_.text = string.format(GetTips("UPGRADE_TIP"), arg_28_0.targetLevel + 10)

	local var_28_0 = ""

	if arg_28_0.context.state == var_0_1.user_level_limit then
		var_28_0 = GetTips(arg_28_0.context.state)
	elseif arg_28_0.context.state == var_0_1.break_material_limit then
		var_28_0 = GetTips(arg_28_0.context.state)
	elseif arg_28_0.context.state == var_0_1.level_material_limit then
		local var_28_1 = GameLevelSetting[arg_28_0.targetLevel].weapon_lv_exp_sum - arg_28_0.weaponInfo.exp - arg_28_0.context.totalExp
		local var_28_2, var_28_3 = WeaponTools.GetMaterialAndNum(var_28_1)

		var_28_0 = string.format(GetTips("LEVELUP_MATERIAL_LACK"), var_28_1, var_28_2, var_28_3)
	elseif arg_28_0.context.state == var_0_1.gold_limit then
		var_28_0 = GetTips(arg_28_0.context.state)
	end

	arg_28_0.conditionText_.text = var_28_0
end

function var_0_0.RefreshState(arg_29_0)
	if arg_29_0.context.can_level_up or arg_29_0.context.state == var_0_1.gold_limit then
		if arg_29_0:CanChooseBreak(arg_29_0.targetLevel) then
			arg_29_0.tipController_:SetSelectedState("break")

			if not arg_29_0.isBreak and arg_29_0.weaponInfo.level == arg_29_0.targetLevel then
				arg_29_0.btnController_:SetSelectedState("hide")
			else
				arg_29_0.btnController_:SetSelectedState("show")
			end
		else
			arg_29_0.tipController_:SetSelectedState("yes")
			arg_29_0.btnController_:SetSelectedState("show")
		end
	else
		arg_29_0.tipController_:SetSelectedState("no")
		arg_29_0.btnController_:SetSelectedState("hide")
	end
end

function var_0_0.RefreshItem(arg_30_0)
	local var_30_0 = #arg_30_0.context.material_list + #arg_30_0.context.break_material_list + #arg_30_0.context.servant_list

	arg_30_0.scrollHelper_:StartScroll(var_30_0)
end

function var_0_0.RefreshInteract(arg_31_0)
	if arg_31_0.addInteract_ == false then
		arg_31_0.addBtn_.interactable = false
	else
		arg_31_0.addBtn_.interactable = true
	end

	if arg_31_0.subInteract_ == false then
		arg_31_0.subBtn_.interactable = false
	else
		arg_31_0.subBtn_.interactable = true
	end

	if arg_31_0.sliderInteract_ == false then
		arg_31_0.addBtn_.interactable = false
		arg_31_0.subBtn_.interactable = false
		arg_31_0.levelSlider_.interactable = false
	else
		arg_31_0.levelSlider_.interactable = true
	end
end

function var_0_0.RenderItem(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = 1
	local var_32_1 = #arg_32_0.context.material_list
	local var_32_2 = #arg_32_0.context.break_material_list

	if arg_32_1 > var_32_1 + var_32_2 then
		var_32_0 = 3
		arg_32_1 = arg_32_1 - var_32_1 - var_32_2
	elseif var_32_1 < arg_32_1 then
		var_32_0 = 2
		arg_32_1 = arg_32_1 - var_32_1
	end

	local var_32_3

	if var_32_0 == 1 then
		local var_32_4 = arg_32_0.context.material_list[arg_32_1]
		local var_32_5 = ItemTools.getItemNum(var_32_4.id)
		local var_32_6 = clone(ItemTemplateData)

		var_32_6.index = arg_32_1
		var_32_6.bottomText = {
			var_32_5,
			var_32_4.num
		}
		var_32_6.id = var_32_4.id
		var_32_6.number = nil

		function var_32_6.clickFun(arg_33_0)
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_33_0.id,
				var_32_5
			})
		end

		arg_32_2:SetData(var_32_6)

		arg_32_2.infoProxy = var_32_4
	elseif var_32_0 == 2 then
		local var_32_7 = arg_32_0.context.break_material_list[arg_32_1]

		var_32_7.index = arg_32_1

		local var_32_8 = ItemTools.getItemNum(var_32_7[1])
		local var_32_9 = clone(ItemTemplateData)

		var_32_9.index = arg_32_1
		var_32_9.bottomText = {
			var_32_8,
			var_32_7[2]
		}
		var_32_9.id = var_32_7[1]
		var_32_9.number = nil

		function var_32_9.clickFun(arg_34_0)
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_34_0.id,
				var_32_8
			})
		end

		arg_32_2:SetData(var_32_9)
	elseif var_32_0 == 3 then
		local var_32_10 = arg_32_0.context.servant_list[arg_32_1]
		local var_32_11 = WeaponTools.GetServantByUid(arg_32_0.all_servant_list, var_32_10)
		local var_32_12 = ItemTools.getItemNum(var_32_11.id)
		local var_32_13 = clone(ItemTemplateData)

		var_32_13.index = arg_32_1
		var_32_13.id = var_32_11.id
		var_32_13.number = nil

		function var_32_13.clickFun(arg_35_0)
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_35_0.id,
				var_32_12
			})
		end

		arg_32_2:SetData(var_32_13)

		arg_32_2.infoProxy = var_32_11
	end
end

function var_0_0.GetStartAndEndLevel(arg_36_0)
	local var_36_0 = HeroConst.WEAPON_LV_MAX
	local var_36_1 = 0

	if arg_36_0.context.materialList then
		for iter_36_0 = 1, #arg_36_0.context.materialList do
			local var_36_2 = arg_36_0.context.materialList[iter_36_0]
			local var_36_3 = ItemCfg[var_36_2.id].param[1]

			if var_36_1 == 0 then
				var_36_1 = var_36_3
			else
				var_36_1 = math.min(var_36_1, var_36_3)
			end
		end
	end

	if arg_36_0.context.servantList then
		for iter_36_1 = 1, #arg_36_0.context.servantList do
			local var_36_4 = arg_36_0.context.servantList[iter_36_1]

			if not (ItemCfg[var_36_4.id].rare >= 4 or var_36_4.number ~= 1) then
				local var_36_5 = ItemCfg[var_36_4.id].rare
				local var_36_6 = GameSetting.base_exp_weapon_servant.value[var_36_5]

				if var_36_1 == 0 then
					var_36_1 = var_36_6
				else
					var_36_1 = math.min(var_36_1, var_36_6)
				end
			end
		end
	end

	local var_36_7, var_36_8, var_36_9, var_36_10 = WeaponTools.AddWeaponExp(arg_36_0.weaponInfo.exp, arg_36_0.weaponInfo.breakthrough, var_36_1)

	if var_36_8 == arg_36_0.weaponInfo.level then
		var_36_8 = var_36_8 + 1
	end

	return var_36_8, var_36_0
end

function var_0_0.CanChooseBreak(arg_37_0, arg_37_1)
	local var_37_0 = GameSetting.weapon_exp_limit.value

	for iter_37_0 = 1, #var_37_0 - 1 do
		if var_37_0[iter_37_0] == arg_37_1 then
			return true
		end
	end

	return false
end

function var_0_0.BuildContext(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0:InitContext()

	arg_38_0.targetLevel = arg_38_1

	local var_38_0 = GameLevelSetting[arg_38_1].weapon_lv_exp_sum - arg_38_0.weaponInfo.exp

	arg_38_0.context.material_list, arg_38_0.context.servant_list, arg_38_0.context.totalExp = WeaponTools.QuickSelectList(arg_38_0.all_material_list, arg_38_0.all_servant_list, var_38_0)
	arg_38_0.context.needExp = var_38_0
	arg_38_0.context.cost = arg_38_0.context.cost + var_38_0 * GameSetting.weapon_strengthen_gold_cost.value[1]

	local var_38_1 = 0

	arg_38_0.context.break_material_list = {}

	for iter_38_0, iter_38_1 in ipairs(GameSetting.weapon_exp_limit.value) do
		if iter_38_1 < arg_38_1 then
			var_38_1 = var_38_1 + 1
		end
	end

	if arg_38_2 then
		var_38_1 = var_38_1 + 1
	end

	for iter_38_2 = arg_38_0.weaponInfo.breakthrough, var_38_1 - 1 do
		local var_38_2, var_38_3 = WeaponTools.BreakMaterial(iter_38_2)

		arg_38_0.context.cost = arg_38_0.context.cost + var_38_2
		arg_38_0.context.break_material_list = WeaponTools.MergeMaterialList(arg_38_0.context.break_material_list, var_38_3)
	end

	arg_38_0.context.breakNum = var_38_1 - arg_38_0.weaponInfo.breakthrough
	arg_38_0.context.can_level_up, arg_38_0.context.state = arg_38_0:CheckQuickLv(arg_38_0.targetLevel, arg_38_2)

	return arg_38_0.context.can_level_up
end

function var_0_0.CheckQuickLv(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs(GameSetting.weapon_exp_limit.value) do
		if iter_39_1 < arg_39_0.targetLevel then
			var_39_0 = var_39_0 + 1
		end

		if arg_39_0.targetLevel == iter_39_1 and arg_39_2 then
			var_39_0 = var_39_0 + 1
		end
	end

	local var_39_1 = PlayerData:GetPlayerInfo().userLevel
	local var_39_2 = GameSetting.weapon_user_limit.value[var_39_0]

	if var_39_0 > 0 and var_39_1 < var_39_2 then
		return false, var_0_1.user_level_limit
	end

	for iter_39_2, iter_39_3 in pairs(arg_39_0.context.break_material_list) do
		if ItemTools.getItemNum(iter_39_3[1]) < iter_39_3[2] then
			return false, var_0_1.break_material_limit
		end
	end

	if GameLevelSetting[arg_39_1].weapon_lv_exp_sum - arg_39_0.weaponInfo.exp > arg_39_0.context.totalExp then
		return false, var_0_1.level_material_limit
	end

	if not checkGold(arg_39_0.context.cost, false) then
		return false, var_0_1.gold_limit
	end

	return true, var_0_1.can_level_up
end

function var_0_0.DeepCompare(arg_40_0, arg_40_1, arg_40_2)
	if type(arg_40_1) ~= "table" or type(arg_40_2) ~= "table" then
		return arg_40_1 == arg_40_2
	end

	for iter_40_0, iter_40_1 in pairs(arg_40_1) do
		if not arg_40_0:DeepCompare(arg_40_2[iter_40_0], iter_40_1) then
			return false
		end
	end

	for iter_40_2, iter_40_3 in pairs(arg_40_2) do
		if not arg_40_0:DeepCompare(arg_40_1[iter_40_2], iter_40_3) then
			return false
		end
	end

	return true
end

function var_0_0.CheckCanBreak(arg_41_0, arg_41_1)
	local var_41_0 = 1

	for iter_41_0, iter_41_1 in ipairs(GameSetting.weapon_exp_limit.value) do
		if iter_41_1 < arg_41_1 then
			var_41_0 = var_41_0 + 1
		end
	end

	local var_41_1 = PlayerData:GetPlayerInfo().userLevel
	local var_41_2 = GameSetting.weapon_user_limit.value[var_41_0]

	if var_41_0 > 0 and var_41_1 < var_41_2 then
		return false, var_0_1.user_level_limit
	end

	return true
end

return var_0_0
