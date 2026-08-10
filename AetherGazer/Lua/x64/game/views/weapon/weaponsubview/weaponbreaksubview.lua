local var_0_0 = class("WeaponBreakSubView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:Init()

	arg_1_0.pageIsInOpen = false
end

function var_0_0.Init(arg_2_0)
	arg_2_0.scrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.RenderItem), arg_2_0.consumeList_, CommonItemView)

	arg_2_0:AddUIListener()

	arg_2_0.conditionController = arg_2_0.conditionController_:GetController("conditionItem")
end

function var_0_0.OnEnter(arg_3_0)
	return
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.buildContext(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_5_0.context = {
		cost = 0,
		itemCount = 0,
		heroId = 0,
		isActive = false,
		weaponInfo = {},
		itemList = {},
		type = arg_5_1,
		dataPorxy = HeroViewDataProxy.New(arg_5_1)
	}
	arg_5_0.constVar = {
		yellow = "363A42",
		red = "CD421E"
	}
end

function var_0_0.ShowWeaponInfoLocal(arg_6_0)
	arg_6_0:UpdateWeaponInfo()
	arg_6_0:ShowWeaponInfo(arg_6_0.context.heroId, arg_6_0.context.weaponInfo)
end

function var_0_0.ShowWeaponInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:buildContext(arg_7_3)
	arg_7_0:SetPageStatus(true)

	arg_7_0.context.heroId = arg_7_1
	arg_7_0.context.weaponInfo = arg_7_2

	arg_7_0:RefreshMaterialList()
	arg_7_0.scrollHelper_:StartScroll(arg_7_0.context.itemCount)
	arg_7_0:RenderView()
end

function var_0_0.RenderItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.context.itemList[arg_8_1]

	var_8_0.index = arg_8_1

	local var_8_1 = ItemTools.getItemNum(var_8_0[1])
	local var_8_2 = clone(ItemTemplateData)

	var_8_2.index = arg_8_1
	var_8_2.bottomText = {
		var_8_1,
		var_8_0[2]
	}
	var_8_2.id = var_8_0[1]
	var_8_2.number = nil

	function var_8_2.clickFun(arg_9_0)
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_9_0.id,
			var_8_1
		})
	end

	arg_8_2:SetData(var_8_2)
end

function var_0_0.RenderView(arg_10_0)
	local var_10_0 = arg_10_0.context.heroId
	local var_10_1 = arg_10_0.context.weaponInfo
	local var_10_2 = var_10_1.level
	local var_10_3 = var_10_1.breakthrough
	local var_10_4 = GameSetting.weapon_user_limit.value[var_10_3 + 1]
	local var_10_5 = GameSetting.weapon_exp_limit.value[var_10_3 + 2]
	local var_10_6 = HeroCfg[var_10_0].weapon_break_attribute[var_10_1.breakthrough + 1][2]
	local var_10_7 = HeroCfg[var_10_0].weapon_break_attribute[var_10_1.breakthrough + 2][2]
	local var_10_8 = string.format("%d", WeaponTools.WeaponAtk(var_10_2, var_10_3))
	local var_10_9 = string.format("%d", WeaponTools.WeaponAtk(var_10_2, var_10_3 + 1))
	local var_10_10 = PlayerData:GetPlayerInfo().userLevel
	local var_10_11 = GameSetting.weapon_user_limit.value[var_10_3 + 1]

	arg_10_0:RenderCost()
	SetActive(arg_10_0.markObj_, var_10_11 <= var_10_10)

	if var_10_11 <= var_10_10 then
		arg_10_0.conditionTxt_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), var_10_11)

		arg_10_0.conditionController:SetSelectedState("achieve")
	else
		arg_10_0.conditionTxt_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), var_10_11)

		arg_10_0.conditionController:SetSelectedState("unsuccessful")
	end

	arg_10_0.beforeLvTxt_.text = var_10_2
	arg_10_0.afterLvTxt_.text = var_10_5
	arg_10_0.beforeAtkTxt_.text = var_10_8
	arg_10_0.afterAtkTxt_.text = var_10_9

	local var_10_12, var_10_13 = SkillTools.GetAttr(HeroCfg[var_10_0].weapon_break_attribute[var_10_1.breakthrough + 1])

	arg_10_0.beforeSubTxt_.text = var_10_13

	local var_10_14, var_10_15 = SkillTools.GetAttr(HeroCfg[var_10_0].weapon_break_attribute[var_10_1.breakthrough + 2])

	arg_10_0.subDescTxt_.text = var_10_14
	arg_10_0.afterSubTxt_.text = var_10_15
end

function var_0_0.RefreshMaterialList(arg_11_0)
	local var_11_0 = arg_11_0.context.weaponInfo
	local var_11_1, var_11_2 = WeaponTools.BreakMaterial(var_11_0.breakthrough)

	arg_11_0.context.itemList = var_11_2
	arg_11_0.context.itemCount = #var_11_2
	arg_11_0.context.cost = var_11_1
end

function var_0_0.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.breakUpBtn_, nil, function()
		arg_12_0:OnBreakBtnClick()
	end)
	arg_12_0:AddBtnListener(arg_12_0.quickLvUpBtn_, nil, function()
		JumpTools.OpenPageByJump("weaponQuickLevelUp", {
			heroID = arg_12_0.context.heroId,
			weaponInfo = arg_12_0.context.weaponInfo
		})
	end)
end

function var_0_0.RenderCost(arg_15_0)
	local var_15_0 = arg_15_0.context.weaponInfo.breakthrough
	local var_15_1, var_15_2 = WeaponTools.BreakMaterial(var_15_0)
	local var_15_3 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)

	arg_15_0.tokenTxt_.text = setTextColor(arg_15_0.constVar.yellow, arg_15_0.constVar.red, var_15_1, var_15_3)
end

function var_0_0.OnGoldChange(arg_16_0)
	arg_16_0:RefreshMaterialList()
	arg_16_0.scrollHelper_:StartScroll(arg_16_0.context.itemCount)
	arg_16_0:RenderView()
end

function var_0_0.OnBreakBtnClick(arg_17_0)
	if WeaponAction.CheckBreak(arg_17_0.context.heroId, true) then
		WeaponAction.WeaponBreak(arg_17_0.context.heroId)
	end
end

function var_0_0.UpdateWeaponInfo(arg_18_0)
	local var_18_0 = arg_18_0.context.heroId

	if var_18_0 and var_18_0 ~= 0 then
		local var_18_1 = deepClone(arg_18_0.context.dataPorxy:GetHeroWeaponInfo(var_18_0))

		arg_18_0.context.weaponInfo = var_18_1
	end
end

function var_0_0.SetPageStatus(arg_19_0, arg_19_1)
	arg_19_0.pageIsInOpen = arg_19_1
end

function var_0_0.GetPageOpenStatus(arg_20_0)
	return arg_20_0.pageIsInOpen
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:SetPageStatus(false)
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.scrollHelper_:Dispose()
	arg_22_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
