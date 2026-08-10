local var_0_0 = class("WeaponServantBeyondModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.BuildContext(arg_2_0)
	arg_2_0.eventHandler = {
		promoteHandler = handler(arg_2_0, arg_2_0.OnBeyondSuccess)
	}
	arg_2_0.controller = {
		comps = arg_2_0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			maxLevel = {
				False = "false",
				name = "maxLevel",
				True = "true"
			}
		}
	}
	arg_2_0.data = {
		servantAddLv = 0,
		heroId = 0,
		curCostType = 1,
		descType = 1,
		info = {},
		servantS_ = {}
	}
	arg_2_0.constVar = {
		red = "CD421E",
		yellow = "363A42",
		subDescColor = "#70767F",
		costItem = {
			costType = 1,
			entity = ServantBeyondViewConsumeModule.New(arg_2_0.consumeRes1_)
		},
		costMaterial = {
			costType = 2,
			entity = ServantBeyondViewConsumeModule.New(arg_2_0.consumeRes2_)
		},
		proxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}

	arg_2_0.constVar.costItem.entity:RegisteBtnListener(function()
		arg_2_0:OnCostItemClick()
	end)
	arg_2_0.constVar.costMaterial.entity:RegisteBtnListener(function()
		arg_2_0:OnCostMaterialClick()
	end)
	arg_2_0:RegistEventListener(SERVANT_PROMOTE, arg_2_0.eventHandler.promoteHandler)
end

function var_0_0.InitContext(arg_5_0)
	arg_5_0.data = {
		servantAddLv = 0,
		heroId = 0,
		descType = 1,
		info = {},
		servantS_ = {}
	}
end

function var_0_0.Init(arg_6_0)
	arg_6_0:BindCfgUI()
	arg_6_0:BuildContext()
	arg_6_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.beyondBtn_, nil, function()
		arg_7_0:OnBeyondClick()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RegistEventListener(SERVANT_PROMOTE, arg_9_0.eventHandler.promoteHandler)
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.constVar.costItem.entity:Dispose()

	arg_11_0.constVar.costItem.entity = nil

	arg_11_0.constVar.costMaterial.entity:Dispose()

	arg_11_0.constVar.costMaterial.entity = nil

	arg_11_0:RemoveAllEventListener()
	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.CheckIsArriveMax(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.stage
	local var_12_1 = WeaponServantCfg[arg_12_1.id].starlevel

	return var_12_0 >= GameSetting.weapon_promote_max.value[var_12_1] + 1
end

function var_0_0.OnRenderModule(arg_13_0, arg_13_1)
	arg_13_0.isCanBarCurrency = true

	arg_13_0:InitContext()

	local var_13_0 = arg_13_1.servantData
	local var_13_1 = arg_13_1.heroId
	local var_13_2 = WeaponServantCfg[var_13_0.id].starlevel
	local var_13_3 = var_13_0.stage

	arg_13_0.data.info = var_13_0
	arg_13_0.data.heroId = var_13_1
	arg_13_0.data.servantS_ = ServantTools.GetServantByIDLimited(var_13_0.id, true, true, var_13_0.uid)

	if arg_13_0:CheckIsArriveMax(var_13_0) then
		local var_13_4 = GameSetting.weapon_promote_max.value[var_13_2] + 1

		arg_13_0:SwitchControllerState(arg_13_0.controller.state.maxLevel.name, arg_13_0.controller.state.maxLevel.True)

		arg_13_0.curLevelTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_2"), var_13_4)

		local var_13_5 = arg_13_0.constVar.proxy:GetServantEffect(var_13_0.id, var_13_3)

		arg_13_0.strdescText_.text = var_13_5
		arg_13_0.isCanBarCurrency = false

		return
	end

	arg_13_0:SwitchControllerState(arg_13_0.controller.state.maxLevel.name, arg_13_0.controller.state.maxLevel.False)

	local var_13_6 = arg_13_0.constVar.proxy:GetServantEffect(var_13_0.id, var_13_3 + 1)

	arg_13_0.strdescText_.text = var_13_6
	arg_13_0.curLevelTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_2"), var_13_3)
	arg_13_0.nextLevelTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_2"), var_13_3 + 1)

	local var_13_7 = ServantTools.ServantBreakCost(var_13_2, var_13_3) or 0
	local var_13_8 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) or 0

	arg_13_0.costGoldTxt_.text = setTextColor(arg_13_0.constVar.yellow, arg_13_0.constVar.red, var_13_7, var_13_8)

	arg_13_0:RenderStrengthItem()
	arg_13_0:OnCostItemClick()
end

function var_0_0.RenderStrengthItem(arg_14_0)
	local var_14_0 = arg_14_0.data.info
	local var_14_1 = #arg_14_0.data.servantS_
	local var_14_2 = table.concat({
		setTextColor(arg_14_0.constVar.red, "FFFFFF", var_14_1, 1, function(arg_15_0, arg_15_1)
			return arg_15_0 < arg_15_1
		end),
		"/",
		1
	})

	arg_14_0.constVar.costItem.entity:RefreshData({
		id = var_14_0.id,
		bottomText = var_14_2
	})

	local var_14_3 = WeaponServantCfg[var_14_0.id].starlevel

	if var_14_3 > 3 then
		SetActive(arg_14_0.consumeRes2_, true)

		local var_14_4 = ServantTools.ServantBreakMaterialCost(var_14_0.id, var_14_3)
		local var_14_5 = var_14_4[1]
		local var_14_6 = ItemTools.getItemNum(var_14_5)
		local var_14_7 = var_14_4[2]
		local var_14_8 = table.concat({
			setTextColor(arg_14_0.constVar.red, "FFFFFF", var_14_6, var_14_7, function(arg_16_0, arg_16_1)
				return arg_16_0 < arg_16_1
			end),
			"/",
			var_14_7
		})

		arg_14_0.constVar.costMaterial.entity:RefreshData({
			id = var_14_5,
			bottomText = var_14_8
		})
	else
		SetActive(arg_14_0.consumeRes2_, false)
		arg_14_0.constVar.costMaterial.entity:RefreshData(nil)
	end
end

function var_0_0.SwitchControllerState(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.controller.comps:GetController(arg_17_1)

	if var_17_0 then
		var_17_0:SetSelectedState(arg_17_2)
	end
end

function var_0_0.GetHeroInfo(arg_18_0, arg_18_1)
	return arg_18_0.constVar.proxy:GetHeroData(arg_18_1)
end

function var_0_0.OnBeyondSuccess(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.data.info
	local var_19_1 = WeaponServantData:GetServantDataByUID(var_19_0.uid)

	if var_19_1 then
		var_19_0.locked = var_19_1.locked
		var_19_0.stage = var_19_1.stage
	end

	arg_19_0:OnRenderModule({
		servantData = var_19_0,
		heroId = arg_19_0.data.heroId
	})
	arg_19_0:Go("servantBreak", {
		stage = var_19_0.stage - 1
	})
end

function var_0_0.OnCostItemClick(arg_20_0)
	arg_20_0.constVar.costMaterial.entity:SetSelect(false)
	arg_20_0.constVar.costItem.entity:SetSelect(true)

	arg_20_0.data.curCostType = arg_20_0.constVar.costItem.costType
end

function var_0_0.OnCostMaterialClick(arg_21_0)
	arg_21_0.constVar.costMaterial.entity:SetSelect(true)
	arg_21_0.constVar.costItem.entity:SetSelect(false)

	arg_21_0.data.curCostType = arg_21_0.constVar.costMaterial.costType
end

function var_0_0.OnBeyondClick(arg_22_0)
	arg_22_0:CheckCost()
end

function var_0_0.CheckCost(arg_23_0)
	local var_23_0 = arg_23_0.constVar
	local var_23_1 = arg_23_0.data.curCostType
	local var_23_2
	local var_23_3 = arg_23_0.data.info
	local var_23_4 = ServantTools.GetServantByIDLimited(var_23_3.id, true, true, var_23_3.uid)

	arg_23_0:sortList(var_23_4)

	if var_23_1 == var_23_0.costItem.costType then
		var_23_2 = var_23_4[1]

		if not var_23_2 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		local var_23_5 = WeaponServantData:GetServantDataByUID(var_23_2)

		if var_23_5.stage > 1 then
			ShowMessageBox({
				content = string.format(GetTips("SERVANT_CONSUME_CONFIRM"), var_23_5.stage),
				OkCallback = function()
					arg_23_0:OnBeyondAction(var_23_2)
				end
			})

			return
		end

		local var_23_6 = SettingData:GetRemindSettingData()

		if not _G.SkipTip.SkipServantPromoteRefineTip and var_23_6.servant_promote_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SERVANT_TRANSCEND_BY_SERVANT"), ItemTools.getItemName(var_23_3.id)),
				OkCallback = function()
					_G.SkipTip.SkipServantPromoteRefineTip = arg_23_0.SkipServantPromoteRefineTip_

					arg_23_0:OnBeyondAction(var_23_2)
				end,
				ToggleCallback = function(arg_26_0)
					arg_23_0.SkipServantPromoteRefineTip_ = arg_26_0
				end
			})

			return
		end
	else
		local var_23_7 = WeaponServantCfg[var_23_3.id].starlevel
		local var_23_8 = ServantTools.ServantBreakMaterialCost(var_23_3.id, var_23_7)

		if not var_23_8 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		if ItemTools.getItemNum(var_23_8[1]) < var_23_8[2] then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		local var_23_9 = SettingData:GetRemindSettingData()
		local var_23_10 = ServantTools.ServantBreakMaterialCost(var_23_3.id, var_23_7)

		if not _G.SkipTip.SkipSpiritRefineTip and var_23_9.spirit_refine_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SERVANT_TRANSCEND"), var_23_10[2]),
				OkCallback = function()
					_G.SkipTip.SkipSpiritRefineTip = arg_23_0.SkipSpiritRefineTip_

					arg_23_0:OnBeyondAction(var_23_2)
				end,
				ToggleCallback = function(arg_28_0)
					arg_23_0.SkipSpiritRefineTip_ = arg_28_0
				end
			})

			return
		end
	end

	arg_23_0:OnBeyondAction(var_23_2)
end

function var_0_0.OnBeyondAction(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.data.info
	local var_29_1 = WeaponServantCfg[var_29_0.id].starlevel
	local var_29_2 = var_29_0.stage
	local var_29_3 = ServantTools.ServantBreakCost(var_29_1, var_29_2)
	local var_29_4 = 1

	if arg_29_1 then
		var_29_4 = 0
	end

	if checkGold(var_29_3) then
		ServantAction.ServantPromote(var_29_4, var_29_0.uid, arg_29_1, var_29_3)
	end
end

function var_0_0.sortList(arg_30_0, arg_30_1)
	table.sort(arg_30_1, function(arg_31_0, arg_31_1)
		local var_31_0 = WeaponServantData:GetServantDataByUID(arg_31_0)
		local var_31_1 = WeaponServantData:GetServantDataByUID(arg_31_1)

		if var_31_0.stage ~= var_31_1.stage then
			return var_31_0.stage < var_31_1.stage
		end

		return var_31_0.uid < var_31_1.uid
	end)
end

return var_0_0
