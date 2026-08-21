local var_0_0 = class("SuitSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/EquipSelectPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:InitDropDown()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.suitListGo_, SuitSelectItem)
	arg_4_0.stateController_ = arg_4_0.controller:GetController("state")
	arg_4_0.autoDecomposeController_ = arg_4_0.controller:GetController("autoDecompose")
	arg_4_0.autoFlagController_ = arg_4_0.controller:GetController("autoFlag")

	arg_4_0.autoDecomposeController_:SetSelectedState("true")
end

function var_0_0.InitDropDown(arg_5_0)
	arg_5_0.dropDown_.options:Clear()
	arg_5_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("ALL"), nil))
	arg_5_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("EQUIP_TYPE_1"), nil))
	arg_5_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("EQUIP_TYPE_2"), nil))
	arg_5_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("RACE_TYPE_10"), nil))
	arg_5_0.dropDown_:RefreshShownValue()
end

function var_0_0.UpdateData(arg_6_0)
	arg_6_0.suitList_ = {}

	local var_6_0 = HideInfoData:GetEquipSuitHideList()
	local var_6_1 = {}
	local var_6_2 = arg_6_0.select_
	local var_6_3 = table.length(EquipSuitCfg.get_id_list_by_equip_type)

	if arg_6_0.select_ == 0 then
		var_6_2 = var_6_3
	elseif arg_6_0.select_ == var_6_3 then
		var_6_2 = 0
	end

	if var_6_2 < var_6_3 then
		var_6_1 = EquipSuitCfg.get_id_list_by_equip_type[var_6_2]
	else
		var_6_1 = EquipSuitCfg.get_id_list_by_suit
	end

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_4 = iter_6_1

		if type(iter_6_1) == "table" then
			var_6_4 = iter_6_1[1]
		end

		if EquipSuitCfg[var_6_4].stage_up_list == 1 and not var_6_0[var_6_4] then
			table.insert(arg_6_0.suitList_, var_6_4)
		end
	end
end

function var_0_0.indexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.suitList_[arg_7_1]

	if var_7_0 == arg_7_0.selectSuitId_ then
		arg_7_2:ShowSelect(true)
	else
		arg_7_2:ShowSelect(false)
	end

	if var_7_0 == arg_7_0.params_.currentSuitId then
		arg_7_2:ShowCurrentUp(true)
	else
		arg_7_2:ShowCurrentUp(false)
	end

	arg_7_2:RefreshData(arg_7_0, {
		id = var_7_0
	})
	arg_7_2:RegistCallBack(function(arg_8_0)
		arg_7_0:SelectSuitItem(arg_8_0)
	end)
end

function var_0_0.SelectSuitItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.scrollHelper_:GetItemList()
	local var_9_1 = table.indexof(arg_9_0.suitList_, arg_9_1.id)
	local var_9_2 = table.indexof(arg_9_0.suitList_, arg_9_0.selectSuitId_)

	if var_9_0[var_9_2] then
		var_9_0[var_9_2]:ShowSelect(false)
	end

	arg_9_0.selectSuitId_ = arg_9_1.id

	if arg_9_0.params_.hideBtn then
		arg_9_0.stateController_:SetSelectedState("hide")
	else
		arg_9_0.stateController_:SetSelectedState(arg_9_0.choosedId_ ~= arg_9_0.selectSuitId_ and "confirm" or "select")
	end

	var_9_0[var_9_1]:ShowSelect(true)
	arg_9_0:RefreshSelectSuitInfo()
end

function var_0_0.RefreshSelectSuitInfo(arg_10_0)
	local var_10_0 = EquipSuitCfg[arg_10_0.selectSuitId_]

	if not var_10_0 then
		SetActive(arg_10_0.infoGo_, false)

		return
	end

	SetActive(arg_10_0.infoGo_, true)

	arg_10_0.name_.text = GetI18NText(var_10_0.name)
	arg_10_0.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), var_10_0.need)
	arg_10_0.desc_.text = GetI18NText(EquipTools.GetEffectDesc(var_10_0.suit_effect[1]))
	arg_10_0.scrollView_.verticalNormalizedPosition = 1
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.btnBgMask_, nil, function()
		JumpTools.Back()
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.btnConfirm_, nil, function()
		if arg_11_0.selectSuitId_ == nil then
			return
		end

		BattleEquipAction.ChangeUpSuit(arg_11_0.selectSuitId_)
		SDKTools.SendMessageToSDK("equip_target_changed", {
			equip_id_old = arg_11_0.params_.currentSuitId,
			equip_id_new = arg_11_0.selectSuitId_
		})
	end)
	arg_11_0:AddToggleListener(arg_11_0.dropDown_, function(arg_14_0)
		arg_11_0.select_ = arg_14_0

		arg_11_0:RefreshUI()
	end)
	arg_11_0:AddBtnListener(arg_11_0.autoDecomposeBtn_, nil, function()
		if not EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.NORMAL) then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("AUTO_DECOMPOSE_TIPS"),
				OkCallback = function()
					EquipAction.SetAutoDecomposeState(BattleConst.BATTLE_EQUIP_TYPE.NORMAL, true, function()
						ShowTips("AUTO_DECOMPOSE_OPEN")
						arg_11_0:RefreshAutoState()
					end)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			EquipAction.SetAutoDecomposeState(BattleConst.BATTLE_EQUIP_TYPE.NORMAL, false, function()
				ShowTips("AUTO_DECOMPOSE_CLOSE")
				arg_11_0:RefreshAutoState()
			end)
		end
	end)
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.selectSuitId_ = arg_20_0.params_.suitId
	arg_20_0.choosedId_ = arg_20_0.params_.currentSuitId
	arg_20_0.select_ = 0
	arg_20_0.dropDown_.value = 0

	arg_20_0:RefreshUI()
	arg_20_0:RefreshAutoState()
end

function var_0_0.RefreshUI(arg_21_0)
	arg_21_0:UpdateData()

	local var_21_0 = false

	if arg_21_0.selectSuitId_ then
		var_21_0 = table.indexof(arg_21_0.suitList_, arg_21_0.selectSuitId_)

		if not var_21_0 then
			var_21_0 = 1
			arg_21_0.selectSuitId_ = arg_21_0.suitList_[1]
		end
	else
		var_21_0 = 1
		arg_21_0.selectSuitId_ = arg_21_0.suitList_[1]
	end

	if arg_21_0.params_.hideBtn then
		arg_21_0.stateController_:SetSelectedState("hide")
	else
		arg_21_0.stateController_:SetSelectedState(arg_21_0.choosedId_ ~= arg_21_0.selectSuitId_ and "confirm" or "select")
	end

	local var_21_1 = 5
	local var_21_2 = var_21_0 - var_21_1 < 1 and 1 or var_21_0 - var_21_1

	arg_21_0.scrollHelper_:StartScroll(#arg_21_0.suitList_, var_21_2)
	arg_21_0:RefreshSelectSuitInfo()
end

function var_0_0.OnChangeUpSuit(arg_22_0, arg_22_1, arg_22_2)
	if isSuccess(arg_22_1.result) then
		JumpTools.Back()
	end
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0.selectSuitId_ = nil
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_24_0)
end

function var_0_0.RefreshAutoState(arg_25_0)
	local var_25_0 = EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.NORMAL)

	arg_25_0.autoFlagController_:SetSelectedState(tostring(var_25_0))
end

return var_0_0
