local var_0_0 = class("EquipInheritView", EquipBaseView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.params_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.costItemList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexCostItem), arg_3_0.materialListGo_, CommonItemView)
	arg_3_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	arg_3_0.stateController_ = arg_3_0.transCon_:GetController("state")
	arg_3_0.costController_ = ControllerUtil.GetController(arg_3_0.transform_, "costState")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnTips_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("EQUIP_INHERIT_DESC")
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnAdd_, nil, function()
		JumpTools.OpenPageByJump("equipInheritPrefabSelect", {
			equipID = arg_4_0.equipID_,
			suitId = arg_4_0.selectSuitID_,
			selectSuitHandler = handler(arg_4_0, arg_4_0.OnSelectSuit)
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnInherit_, nil, function()
		if arg_4_0.selectSuitID_ == nil then
			ShowTips("EQUIP_INHERIT_SELECT")
		elseif arg_4_0.selectSuitID_ == arg_4_0.equipCfg_.suit then
			ShowTips("ERROR_EQUIP_SAME_ID")
		elseif arg_4_0.materialEnough_ == false then
			ShowTips("ERROR_ITEM_NO_ENOUGH_MATERIAL")
		elseif arg_4_0.goldEnough_ == false then
			local var_7_0 = false
			local var_7_1 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND]

			for iter_7_0, iter_7_1 in ipairs(var_7_1 or {}) do
				if ItemTools.getItemNum(iter_7_1) > 0 then
					var_7_0 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or var_7_0 then
				JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)
			else
				ShowTips(GetTips("ERROR_ITEM_NOT_ENOUGH_GOLD"))
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_INHERIT_CONFIRM"),
				OkCallback = function()
					EquipAction.InheritEquip(arg_4_0.equipID_, arg_4_0.selectPrefabID_)
				end
			})
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnInfo_, nil, function()
		arg_4_0.handler_:RefreshEquipInfo(arg_4_0.selectInfo_)
	end)
end

function var_0_0.IndexCostItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.materialList_[arg_10_1]
	local var_10_1 = clone(ItemTemplateData)

	var_10_1.id = var_10_0.id
	var_10_1.hideBottomRightTextFlag = true

	local var_10_2 = ItemTools.getItemNum(var_10_0.id)

	var_10_1.bottomText = {
		var_10_2,
		var_10_0.number
	}

	function var_10_1.clickFun(arg_11_0)
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_11_0.id,
			arg_11_0.number
		})
	end

	arg_10_2:SetData(var_10_1)

	if arg_10_0.materialEnough_ == true then
		arg_10_0.materialEnough_ = var_10_2 >= var_10_0.number
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:OnEquipChange(arg_12_0.params_.equipId)
	arg_12_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_12_0, arg_12_0.OnGoldChange))
end

function var_0_0.OnEquipChange(arg_13_0, arg_13_1)
	arg_13_0.equipID_ = arg_13_1
	arg_13_0.equipData_ = EquipData:GetEquipData(arg_13_0.equipID_)
	arg_13_0.equipCfg_ = EquipCfg[arg_13_0.equipData_.prefab_id]
	arg_13_0.selectSuitID_ = nil

	arg_13_0:OnSelectSuit()
end

function var_0_0.RefreshMoney(arg_14_0)
	local var_14_0 = arg_14_0.moneyCost_ or 0
	local var_14_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_14_2 = tostring(var_14_0)

	if var_14_1 < var_14_0 then
		var_14_2 = "<color='#FF0000'>" .. var_14_2 .. "</color>"
	end

	arg_14_0.goldEnough_ = var_14_0 <= var_14_1
	arg_14_0.costNum_.text = var_14_2
end

function var_0_0.RefreshMaterial(arg_15_0)
	arg_15_0.materialEnough_ = true

	arg_15_0.costItemList_:StartScroll(#arg_15_0.materialList_)
end

function var_0_0.OnGoldChange(arg_16_0, arg_16_1)
	if arg_16_0.selectSuitID_ and arg_16_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		arg_16_0:RefreshMoney()
	end
end

function var_0_0.ChangeBar(arg_17_0)
	local var_17_0 = {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	}

	if arg_17_0.selectSuitID_ then
		table.insert(var_17_0, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(var_17_0)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar(var_17_0)
	end
end

function var_0_0.OnTop(arg_18_0)
	arg_18_0:ChangeBar()
end

function var_0_0.OnSelectSuit(arg_19_0, arg_19_1)
	local var_19_0

	if arg_19_1 ~= nil then
		arg_19_0.stateController_:SetSelectedIndex(1)

		arg_19_0.selectSuitID_ = arg_19_1
		arg_19_0.materialList_, arg_19_0.moneyCost_ = EquipData:GetInheritCost(arg_19_0.selectSuitID_)

		arg_19_0:RefreshMaterial()
		arg_19_0:RefreshMoney()
		arg_19_0:RefreshSelect()
		arg_19_0:ChangeBar(true)
	else
		arg_19_0.stateController_:SetSelectedIndex(0)
		arg_19_0:ChangeBar(false)
	end
end

function var_0_0.RefreshSelect(arg_20_0)
	arg_20_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/icon_s/" .. arg_20_0.selectSuitID_)

	local var_20_0 = EquipCfg.get_id_list_by_suit[arg_20_0.selectSuitID_]

	for iter_20_0 = #var_20_0, 1, -1 do
		local var_20_1 = EquipCfg[var_20_0[iter_20_0]]

		if var_20_1.pos == arg_20_0.equipCfg_.pos and var_20_1.starlevel >= 5 then
			arg_20_0.selectPrefabID_ = var_20_0[iter_20_0]

			break
		end
	end

	arg_20_0.name_.text = ItemTools.getItemName(arg_20_0.selectPrefabID_)
	arg_20_0.selectInfo_ = deepClone(arg_20_0.equipData_)
	arg_20_0.selectInfo_.prefab_id = arg_20_0.selectPrefabID_
	arg_20_0.selectInfo_.equipConfig = EquipCfg[arg_20_0.selectPrefabID_]
end

function var_0_0.ResetInherit(arg_21_0)
	arg_21_0.selectSuitID_ = nil
	arg_21_0.equipData_ = EquipData:GetEquipData(arg_21_0.equipID_)
	arg_21_0.equipCfg_ = EquipCfg[arg_21_0.equipData_.prefab_id]

	arg_21_0.stateController_:SetSelectedIndex(0)
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.costItemList_ then
		arg_23_0.costItemList_:Dispose()

		arg_23_0.costItemList_ = nil
	end

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
