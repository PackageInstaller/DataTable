local var_0_0 = class("HeroDisplayExpressionView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.itemList_ = {}
	arg_1_0.dropdownItemList_ = {}
	arg_1_0.selectHandler_ = handler(arg_1_0, arg_1_0.SelectPresetItem)
end

function var_0_0.OnShow(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.heroID_

	arg_2_0.heroModel_ = arg_2_1

	local var_2_1

	if arg_2_0:FindTrs("Face", arg_2_0.uiTpose_.transform) then
		var_2_1 = arg_2_0:FindCom(typeof(UnityEngine.SkinnedMeshRenderer), "Face", arg_2_0.uiTpose_.transform)
	else
		var_2_1 = arg_2_0:FindCom(typeof(UnityEngine.SkinnedMeshRenderer), "face", arg_2_0.uiTpose_.transform)
	end

	arg_2_0.skinnedMeshRenderer_ = var_2_1

	local var_2_2 = HeroDisplayCfg[var_2_0]

	for iter_2_0, iter_2_1 in ipairs(var_2_2.skinMeshIDList) do
		if arg_2_0.itemList_[iter_2_0] == nil then
			arg_2_0.itemList_[iter_2_0] = HeroDisplayExpressionItemView.New(arg_2_0.goItem_, arg_2_0.transformContent_)
		end

		arg_2_0.itemList_[iter_2_0]:SetData(arg_2_0.skinnedMeshRenderer_, iter_2_0, iter_2_1)
	end

	for iter_2_2 = #var_2_2.skinMeshIDList + 1, #arg_2_0.itemList_ do
		arg_2_0.itemList_[iter_2_2]:Show(false)
	end

	local var_2_3 = HeroDisplayData:GetCacheExpressionParams().values

	if var_2_3[1] then
		for iter_2_3, iter_2_4 in ipairs(var_2_3) do
			arg_2_0.itemList_[iter_2_3]:SetValue(iter_2_4)
		end
	else
		arg_2_0:RefreshItemValue(arg_2_0.lastPresetInext_)
	end

	SetActive(arg_2_0.gameObject_, true)
end

function var_0_0.OnHide(arg_3_0)
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.OnEnter(arg_4_0, arg_4_1)
	arg_4_0.effectObject_ = {}
	arg_4_0.heroID_ = arg_4_1

	arg_4_0:InitExpressionDropdown()
	manager.notify:RegistListener(HERO_DISPLAY_EXPRESSION_ITEM, arg_4_0.selectHandler_)
end

function var_0_0.OnExit(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.effectObject_) do
		Object.Destroy(iter_5_1)
	end

	manager.notify:RemoveListener(HERO_DISPLAY_EXPRESSION_ITEM, arg_5_0.selectHandler_)
	arg_5_0.dropDownEffect_.options:Clear()

	arg_5_0.effectObject_ = nil
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.itemList_ = nil

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.dropdownItemList_) do
		iter_6_3:Dispose()
	end

	arg_6_0.dropdownItemList_ = nil
	arg_6_0.selectHandler_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonBg_, nil, function()
		arg_7_0:TryBack()
	end)
	arg_7_0:AddToggleListener(arg_7_0.dropDownEffect_, function(arg_9_0)
		if arg_9_0 == 0 then
			arg_7_0:LoadEffect(0)
		else
			local var_9_0 = HeroDisplayCfg[arg_7_0.heroID_].effectList[arg_9_0]

			arg_7_0:LoadEffect(var_9_0)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonPreset_, nil, function()
		arg_7_0:ShowDropdownPanel(true)
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonMask_, nil, function()
		arg_7_0:ShowDropdownPanel(false)
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonDelete_, nil, function()
		local var_12_0 = arg_7_0.heroID_
		local var_12_1 = arg_7_0.lastPresetInext_

		if var_12_1 <= #HeroDisplayCfg[var_12_0].skinMeshPresetName + 2 then
			ShowTips("CANNOT_DELETE_PRESET")

			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("DELETE_PRESET"),
			OkCallback = function()
				HeroDisplayData:InitCacheExpressionParams(var_12_0)
				HeroDisplayData:DeleteHeroExpressionParams(var_12_0, var_12_1)
				arg_7_0:RemoveDropdownItem(var_12_1)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.InitExpressionDropdown(arg_15_0)
	local var_15_0 = arg_15_0.heroID_
	local var_15_1 = HeroDisplayCfg[var_15_0]
	local var_15_2 = HeroDisplayData:GetHeroExpressionParams(var_15_0)

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		if arg_15_0.dropdownItemList_[iter_15_0] == nil then
			arg_15_0.dropdownItemList_[iter_15_0] = HeroDisplayExpressionDropdownItem.New(arg_15_0.goDropdownItem_, arg_15_0.goDropdownParent_)
		end

		arg_15_0.dropdownItemList_[iter_15_0]:SetData(iter_15_0, iter_15_1.name)
	end

	if arg_15_0.dropdownItemList_[#var_15_2 + 1] == nil then
		arg_15_0.dropdownItemList_[#var_15_2 + 1] = HeroDisplayExpressionDropdownItem.New(arg_15_0.goDropdownItem_, arg_15_0.goDropdownParent_)
	end

	local var_15_3 = GetTips("SAVE_NEW_PRESET")

	arg_15_0.dropdownItemList_[#var_15_2 + 1]:SetData(#var_15_2 + 1, var_15_3)

	arg_15_0.lastPresetInext_ = 1

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.dropdownItemList_) do
		iter_15_3:SetSelect(iter_15_2 == arg_15_0.lastPresetInext_)
	end

	for iter_15_4 = #var_15_2 + 2, #arg_15_0.dropdownItemList_ do
		arg_15_0.dropdownItemList_[iter_15_4]:Show(false)
	end

	arg_15_0.textPreset_.text = GetI18NText(var_15_2[arg_15_0.lastPresetInext_].name)

	local var_15_4 = GetTips("NONE")

	arg_15_0.dropDownEffect_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_15_4))

	for iter_15_5, iter_15_6 in ipairs(var_15_1.effectList) do
		local var_15_5 = HeroDisplayEffectCfg[iter_15_6]

		arg_15_0.dropDownEffect_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_15_5.name))
	end

	arg_15_0.dropDownEffect_.value = 0
end

function var_0_0.AddDropdownItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.heroID_
	local var_16_1 = HeroDisplayCfg[var_16_0]
	local var_16_2 = HeroDisplayData:GetHeroExpressionParams(var_16_0)

	arg_16_0.dropdownItemList_[#var_16_2]:SetData(#var_16_2, arg_16_1)

	local var_16_3 = GetTips("SAVE_NEW_PRESET")

	if arg_16_0.dropdownItemList_[#var_16_2 + 1] == nil then
		arg_16_0.dropdownItemList_[#var_16_2 + 1] = HeroDisplayExpressionDropdownItem.New(arg_16_0.goDropdownItem_, arg_16_0.goDropdownParent_)
	end

	arg_16_0.dropdownItemList_[#var_16_2 + 1]:SetData(#var_16_2 + 1, var_16_3)
end

function var_0_0.RemoveDropdownItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.heroID_
	local var_17_1 = HeroDisplayCfg[var_17_0]
	local var_17_2 = HeroDisplayData:GetHeroExpressionParams(var_17_0)

	for iter_17_0 = arg_17_1, #var_17_2 do
		arg_17_0.dropdownItemList_[iter_17_0]:SetData(iter_17_0, var_17_2[iter_17_0].name)
	end

	local var_17_3 = GetTips("SAVE_NEW_PRESET")

	arg_17_0.dropdownItemList_[#var_17_2 + 1]:SetData(i, var_17_3)
	arg_17_0.dropdownItemList_[#var_17_2 + 2]:Show(false)
	arg_17_0:RefreshItemValue(1)
end

function var_0_0.SelectPresetItem(arg_18_0, arg_18_1)
	arg_18_0:ShowDropdownPanel(false)

	local var_18_0 = arg_18_0.heroID_
	local var_18_1 = HeroDisplayCfg[var_18_0]

	if arg_18_1 > #HeroDisplayData:GetHeroExpressionParams(var_18_0) then
		arg_18_0:TrySaveData()
	else
		arg_18_0:TrySwitchIndex(arg_18_1)
	end
end

function var_0_0.RefreshItemValue(arg_19_0, arg_19_1)
	arg_19_0.lastPresetInext_ = arg_19_1

	local var_19_0 = arg_19_0.heroID_
	local var_19_1 = HeroDisplayData:GetHeroExpressionParams(var_19_0)[arg_19_1]

	for iter_19_0, iter_19_1 in ipairs(var_19_1.values) do
		if arg_19_0.itemList_[iter_19_0] == nil then
			arg_19_0.itemList_[iter_19_0] = HeroDisplayExpressionItemView.New(arg_19_0.goItem_, arg_19_0.transformContent_)
		end

		arg_19_0.itemList_[iter_19_0]:SetValue(iter_19_1)
	end

	arg_19_0.dropDownEffect_.value = var_19_1.effectID
	arg_19_0.textPreset_.text = GetI18NText(var_19_1.name)

	for iter_19_2, iter_19_3 in ipairs(arg_19_0.dropdownItemList_) do
		iter_19_3:SetSelect(iter_19_2 == arg_19_1)
	end
end

function var_0_0.ShowDropdownPanel(arg_20_0, arg_20_1)
	if arg_20_1 == true then
		local var_20_0 = arg_20_0.heroID_
		local var_20_1 = HeroDisplayData:GetHeroExpressionParams(var_20_0)

		arg_20_0.scrollView_.verticalNormalizedPosition = 1 - arg_20_0.lastPresetInext_ / (#var_20_1 + 1)
	end

	SetActive(arg_20_0.goPresetPanel_, arg_20_1)
	SetActive(arg_20_0.goMask_, arg_20_1)
end

function var_0_0.TryBack(arg_21_0)
	arg_21_0:OnHide()
end

function var_0_0.IsChangeValue(arg_22_0)
	local var_22_0 = arg_22_0.heroID_
	local var_22_1 = arg_22_0.lastPresetInext_
	local var_22_2 = HeroDisplayData:GetHeroExpressionParams(var_22_0)[var_22_1]
	local var_22_3 = HeroDisplayData:GetCacheExpressionParams()

	if var_22_2.effectID ~= var_22_3.effectID then
		return true
	end

	for iter_22_0 = #var_22_2.values + 1, #var_22_3.values do
		var_22_2.values[iter_22_0] = 0
	end

	return arg_22_0:Unequal(var_22_2.values, var_22_3.values)
end

function var_0_0.TrySwitchIndex(arg_23_0, arg_23_1)
	if not arg_23_0:IsChangeValue() then
		arg_23_0:RefreshItemValue(arg_23_1)

		return
	end

	JumpTools.OpenPageByJump("threeButtonBox", {
		content = GetTips("SAVE_PRESET_TIPS"),
		cancelFun = function()
			arg_23_0:Back()
		end,
		closeFun = function()
			arg_23_0:RefreshItemValue(arg_23_1)
		end,
		okFun = function()
			local var_26_0 = {
				preset = false,
				values = clone(HeroDisplayData:GetCacheExpressionParams().values),
				effectID = HeroDisplayData:GetCacheExpressionParams().effectID
			}

			JumpTools.OpenPageByJump("ProposalPopup", {
				maskCloseFun = function(arg_27_0)
					return arg_23_0:SwitchSaveData(arg_27_0, var_26_0)
				end,
				delegate = function(arg_28_0)
					local var_28_0 = arg_23_0:SwitchSaveData(arg_28_0, var_26_0)

					if var_28_0 then
						arg_23_0:Back()
					end

					return var_28_0
				end
			})
		end
	})
end

function var_0_0.TrySaveData(arg_29_0)
	local var_29_0 = arg_29_0.heroID_
	local var_29_1 = HeroDisplayData:GetCacheExpressionParams()
	local var_29_2 = {
		preset = false,
		values = clone(var_29_1.values),
		effectID = var_29_1.effectID
	}

	JumpTools.OpenPageByJump("ProposalPopup", {
		maskCloseFun = function(arg_30_0)
			return arg_29_0:SaveData(arg_30_0, var_29_2)
		end,
		delegate = function(arg_31_0)
			return arg_29_0:SaveData(arg_31_0, var_29_2)
		end
	})
end

function var_0_0.TryExitSaveData(arg_32_0)
	if not arg_32_0:IsChangeValue() then
		arg_32_0:Back()

		return
	end

	JumpTools.OpenPageByJump("threeButtonBox", {
		content = GetTips("SAVE_PRESET_TIPS"),
		cancelFun = function()
			arg_32_0:Back()
		end,
		closeFun = function()
			arg_32_0:Back()
		end,
		okFun = function()
			local var_35_0 = arg_32_0.heroID_
			local var_35_1 = HeroDisplayData:GetCacheExpressionParams()
			local var_35_2 = {
				preset = false,
				values = clone(var_35_1.values),
				effectID = var_35_1.effectID
			}

			JumpTools.OpenPageByJump("ProposalPopup", {
				maskCloseFun = function(arg_36_0)
					return arg_32_0:ExitSaveData(arg_36_0, var_35_2)
				end,
				delegate = function(arg_37_0)
					local var_37_0 = arg_32_0:ExitSaveData(arg_37_0, var_35_2)

					if var_37_0 then
						arg_32_0:Back()
					end

					return var_37_0
				end
			})
		end
	})
end

function var_0_0.IsExceedMaxCnt(arg_38_0)
	local var_38_0 = arg_38_0.heroID_

	if #HeroDisplayData:GetCustomExpressionParams(var_38_0) >= GameSetting.preset_max.value[1] then
		ShowTips("PRESET_MORE_THAN_MAX")

		return true
	end

	return false
end

function var_0_0.LoadEffect(arg_39_0, arg_39_1)
	HeroDisplayData:SetCacheExpressionEffect(arg_39_1)

	if arg_39_1 == 0 then
		SetActive(arg_39_0.currentEffect_, false)

		return
	end

	if arg_39_0.effectObject_[arg_39_1] then
		arg_39_0.currentEffect_ = arg_39_0.effectObject_[arg_39_1]

		SetActive(arg_39_0.currentEffect_, true)
	else
		local var_39_0 = HeroDisplayEffectCfg[arg_39_1]
		local var_39_1 = Asset.Load("Effect/Display/" .. var_39_0.model)
		local var_39_2 = arg_39_0:FindGo(var_39_0.handPointPath, arg_39_0.heroModel_.transform)

		arg_39_0.effectObject_[arg_39_1] = Object.Instantiate(var_39_1, var_39_2.transform)

		local var_39_3 = arg_39_0.effectObject_[arg_39_1].transform
		local var_39_4 = var_39_0.position

		var_39_3.localPosition = Vector3(var_39_4[1], var_39_4[2], var_39_4[3])

		local var_39_5 = var_39_0.rotation

		var_39_3.localEulerAngles = Vector3(var_39_5[1], var_39_5[2], var_39_5[3])
		arg_39_0.currentEffect_ = arg_39_0.effectObject_[arg_39_1]
	end
end

function var_0_0.SwitchSaveData(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0.heroID_

	arg_40_2.name = arg_40_1

	for iter_40_0, iter_40_1 in ipairs(HeroDisplayData:GetHeroExpressionParams(var_40_0)) do
		if arg_40_1 == iter_40_1.name then
			if iter_40_0 - 1 < HeroDisplayData:GetCustomStartIndex(var_40_0) then
				ShowTips("CANNOT_REPLACE_PRESET")

				return false
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("REPLACE_SAME_PRESET"),
				OkCallback = function()
					HeroDisplayData:ReplaceHeroExpressionParams(var_40_0, iter_40_0, arg_40_2)
					arg_40_0:RefreshItemValue(iter_40_0)
					arg_40_0:Back(2)
				end,
				CancelCallback = function()
					return
				end
			})

			return false
		end
	end

	if arg_40_0:IsExceedMaxCnt() then
		return false
	end

	HeroDisplayData:SaveHeroExpressionParams(var_40_0, arg_40_2)
	arg_40_0:AddDropdownItem(arg_40_1)
	arg_40_0:RefreshItemValue(#HeroDisplayData:GetHeroExpressionParams(var_40_0))

	return true
end

function var_0_0.SaveData(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.heroID_

	arg_43_2.name = arg_43_1

	for iter_43_0, iter_43_1 in ipairs(HeroDisplayData:GetHeroExpressionParams(var_43_0)) do
		if arg_43_1 == iter_43_1.name then
			if iter_43_0 - 1 < HeroDisplayData:GetCustomStartIndex(var_43_0) then
				ShowTips("CANNOT_REPLACE_PRESET")

				return false
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("REPLACE_SAME_PRESET"),
				OkCallback = function()
					HeroDisplayData:ReplaceHeroExpressionParams(var_43_0, iter_43_0, arg_43_2)
					arg_43_0:RefreshItemValue(iter_43_0)
					arg_43_0:Back()
				end,
				CancelCallback = function()
					return
				end
			})

			return false
		end
	end

	if arg_43_0:IsExceedMaxCnt() then
		return false
	end

	HeroDisplayData:SaveHeroExpressionParams(var_43_0, arg_43_2)
	arg_43_0:AddDropdownItem(arg_43_1)
	arg_43_0:RefreshItemValue(#HeroDisplayData:GetHeroExpressionParams(var_43_0))

	return true
end

function var_0_0.ExitSaveData(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_0.heroID_

	arg_46_2.name = arg_46_1

	for iter_46_0, iter_46_1 in ipairs(HeroDisplayData:GetHeroExpressionParams(var_46_0)) do
		if arg_46_1 == iter_46_1.name then
			if iter_46_0 - 1 < HeroDisplayData:GetCustomStartIndex(var_46_0) then
				ShowTips("CANNOT_REPLACE_PRESET")

				return false
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("REPLACE_SAME_PRESET"),
				OkCallback = function()
					HeroDisplayData:ReplaceHeroExpressionParams(var_46_0, iter_46_0, arg_46_2)
					arg_46_0:Back(3)
				end,
				CancelCallback = function()
					return
				end
			})

			return false
		end
	end

	if arg_46_0:IsExceedMaxCnt() then
		return false
	end

	HeroDisplayData:SaveHeroExpressionParams(var_46_0, arg_46_2)
	arg_46_0:Back()

	return true
end

return var_0_0
