local HeroDisplayExpressionView = class("HeroDisplayExpressionView", ReduxView)

function HeroDisplayExpressionView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}
	self.dropdownItemList_ = {}
	self.selectHandler_ = handler(self, self.SelectPresetItem)
end

function HeroDisplayExpressionView:OnShow(arg_2_1)
	self.heroModel_ = arg_2_1
	self.skinnedMeshRenderer_ = self:FindTrs("Face", self.uiTpose_.transform) and self:FindCom(typeof(UnityEngine.SkinnedMeshRenderer), "Face", self.uiTpose_.transform) or self:FindCom(typeof(UnityEngine.SkinnedMeshRenderer), "face", self.uiTpose_.transform)

	for iter_2_0, iter_2_1 in ipairs(HeroDisplayCfg[self.heroID_].skinMeshIDList) do
		if self.itemList_[iter_2_0] == nil then
			self.itemList_[iter_2_0] = HeroDisplayExpressionItemView.New(self.goItem_, self.transformContent_)
		end

		self.itemList_[iter_2_0]:SetData(self.skinnedMeshRenderer_, iter_2_0, iter_2_1)
	end

	for iter_2_2 = #HeroDisplayCfg[self.heroID_].skinMeshIDList + 1, #self.itemList_ do
		self.itemList_[iter_2_2]:Show(false)
	end

	local var_2_1 = HeroDisplayData:GetCacheExpressionParams().values

	if var_2_1[1] then
		for iter_2_3, iter_2_4 in ipairs(var_2_1) do
			self.itemList_[iter_2_3]:SetValue(iter_2_4)
		end
	else
		self:RefreshItemValue(self.lastPresetInext_)
	end

	SetActive(self.gameObject_, true)
end

function HeroDisplayExpressionView:OnHide()
	SetActive(self.gameObject_, false)
end

function HeroDisplayExpressionView:OnEnter(arg_4_1)
	self.effectObject_ = {}
	self.heroID_ = arg_4_1

	self:InitExpressionDropdown()
	manager.notify:RegistListener(HERO_DISPLAY_EXPRESSION_ITEM, self.selectHandler_)
end

function HeroDisplayExpressionView:OnExit()
	for iter_5_0, iter_5_1 in pairs(self.effectObject_) do
		Object.Destroy(iter_5_1)
	end

	manager.notify:RemoveListener(HERO_DISPLAY_EXPRESSION_ITEM, self.selectHandler_)
	self.dropDownEffect_.options:Clear()

	self.effectObject_ = nil
end

function HeroDisplayExpressionView:Dispose()
	HeroDisplayExpressionView.super.Dispose(self)

	for iter_6_0, iter_6_1 in ipairs(self.itemList_) do
		iter_6_1:Dispose()
	end

	self.itemList_ = nil

	for iter_6_2, iter_6_3 in ipairs(self.dropdownItemList_) do
		iter_6_3:Dispose()
	end

	self.dropdownItemList_ = nil
	self.selectHandler_ = nil
end

function HeroDisplayExpressionView:AddListeners()
	self:AddBtnListener(self.buttonBg_, nil, function()
		self:TryBack()
	end)
	self:AddToggleListener(self.dropDownEffect_, function(arg_9_0)
		if arg_9_0 == 0 then
			self:LoadEffect(0)
		else
			self:LoadEffect(HeroDisplayCfg[self.heroID_].effectList[arg_9_0])
		end
	end)
	self:AddBtnListener(self.buttonPreset_, nil, function()
		self:ShowDropdownPanel(true)
	end)
	self:AddBtnListener(self.buttonMask_, nil, function()
		self:ShowDropdownPanel(false)
	end)
	self:AddBtnListener(self.buttonDelete_, nil, function()
		local var_12_0 = self.heroID_
		local var_12_1 = self.lastPresetInext_

		if self.lastPresetInext_ <= #HeroDisplayCfg[self.heroID_].skinMeshPresetName + 2 then
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
				self:RemoveDropdownItem(var_12_1)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function HeroDisplayExpressionView:InitExpressionDropdown()
	local var_15_0 = HeroDisplayData:GetHeroExpressionParams(self.heroID_)

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if self.dropdownItemList_[iter_15_0] == nil then
			self.dropdownItemList_[iter_15_0] = HeroDisplayExpressionDropdownItem.New(self.goDropdownItem_, self.goDropdownParent_)
		end

		self.dropdownItemList_[iter_15_0]:SetData(iter_15_0, iter_15_1.name)
	end

	if self.dropdownItemList_[#var_15_0 + 1] == nil then
		self.dropdownItemList_[#var_15_0 + 1] = HeroDisplayExpressionDropdownItem.New(self.goDropdownItem_, self.goDropdownParent_)
	end

	self.dropdownItemList_[#var_15_0 + 1]:SetData(#var_15_0 + 1, (GetTips("SAVE_NEW_PRESET")))

	self.lastPresetInext_ = 1

	for iter_15_2, iter_15_3 in ipairs(self.dropdownItemList_) do
		iter_15_3:SetSelect(iter_15_2 == self.lastPresetInext_)
	end

	for iter_15_4 = #var_15_0 + 2, #self.dropdownItemList_ do
		self.dropdownItemList_[iter_15_4]:Show(false)
	end

	self.textPreset_.text = GetI18NText(var_15_0[self.lastPresetInext_].name)

	self.dropDownEffect_.options:Add(UnityEngine.UI.Dropdown.OptionData.New((GetTips("NONE"))))

	for iter_15_5, iter_15_6 in ipairs(HeroDisplayCfg[self.heroID_].effectList) do
		self.dropDownEffect_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(HeroDisplayEffectCfg[iter_15_6].name))
	end

	self.dropDownEffect_.value = 0
end

function HeroDisplayExpressionView:AddDropdownItem(arg_16_1)
	local var_16_1 = HeroDisplayData:GetHeroExpressionParams(self.heroID_)

	self.dropdownItemList_[#var_16_1]:SetData(#var_16_1, arg_16_1)

	if self.dropdownItemList_[#var_16_1 + 1] == nil then
		self.dropdownItemList_[#var_16_1 + 1] = HeroDisplayExpressionDropdownItem.New(self.goDropdownItem_, self.goDropdownParent_)
	end

	self.dropdownItemList_[#var_16_1 + 1]:SetData(#var_16_1 + 1, (GetTips("SAVE_NEW_PRESET")))
end

function HeroDisplayExpressionView:RemoveDropdownItem(arg_17_1)
	local var_17_1 = HeroDisplayData:GetHeroExpressionParams(self.heroID_)

	for iter_17_0 = arg_17_1, #var_17_1 do
		self.dropdownItemList_[iter_17_0]:SetData(iter_17_0, var_17_1[iter_17_0].name)
	end

	self.dropdownItemList_[#var_17_1 + 1]:SetData(i, (GetTips("SAVE_NEW_PRESET")))
	self.dropdownItemList_[#var_17_1 + 2]:Show(false)
	self:RefreshItemValue(1)
end

function HeroDisplayExpressionView:SelectPresetItem(arg_18_1)
	self:ShowDropdownPanel(false)

	if arg_18_1 > #HeroDisplayData:GetHeroExpressionParams(self.heroID_) then
		self:TrySaveData()
	else
		self:TrySwitchIndex(arg_18_1)
	end
end

function HeroDisplayExpressionView:RefreshItemValue(arg_19_1)
	self.lastPresetInext_ = arg_19_1

	local var_19_0 = HeroDisplayData:GetHeroExpressionParams(self.heroID_)[arg_19_1]

	for iter_19_0, iter_19_1 in ipairs(var_19_0.values) do
		if self.itemList_[iter_19_0] == nil then
			self.itemList_[iter_19_0] = HeroDisplayExpressionItemView.New(self.goItem_, self.transformContent_)
		end

		self.itemList_[iter_19_0]:SetValue(iter_19_1)
	end

	self.dropDownEffect_.value = var_19_0.effectID
	self.textPreset_.text = GetI18NText(var_19_0.name)

	for iter_19_2, iter_19_3 in ipairs(self.dropdownItemList_) do
		iter_19_3:SetSelect(iter_19_2 == arg_19_1)
	end
end

function HeroDisplayExpressionView:ShowDropdownPanel(arg_20_1)
	if arg_20_1 == true then
		self.scrollView_.verticalNormalizedPosition = 1 - self.lastPresetInext_ / (#HeroDisplayData:GetHeroExpressionParams(self.heroID_) + 1)
	end

	SetActive(self.goPresetPanel_, arg_20_1)
	SetActive(self.goMask_, arg_20_1)
end

function HeroDisplayExpressionView:TryBack()
	self:OnHide()
end

function HeroDisplayExpressionView:IsChangeValue()
	local var_22_0 = HeroDisplayData:GetHeroExpressionParams(self.heroID_)[self.lastPresetInext_]
	local var_22_1 = HeroDisplayData:GetCacheExpressionParams()

	if var_22_0.effectID ~= var_22_1.effectID then
		return true
	end

	for iter_22_0 = #var_22_0.values + 1, #var_22_1.values do
		var_22_0.values[iter_22_0] = 0
	end

	return self:Unequal(var_22_0.values, var_22_1.values)
end

function HeroDisplayExpressionView:TrySwitchIndex(arg_23_1)
	if not self:IsChangeValue() then
		self:RefreshItemValue(arg_23_1)

		return
	end

	JumpTools.OpenPageByJump("threeButtonBox", {
		content = GetTips("SAVE_PRESET_TIPS"),
		cancelFun = function()
			self:Back()
		end,
		closeFun = function()
			self:RefreshItemValue(arg_23_1)
		end,
		okFun = function()
			local var_26_0 = {
				preset = false,
				values = clone(HeroDisplayData:GetCacheExpressionParams().values),
				effectID = HeroDisplayData:GetCacheExpressionParams().effectID
			}

			JumpTools.OpenPageByJump("ProposalPopup", {
				maskCloseFun = function(arg_27_0)
					return self:SwitchSaveData(arg_27_0, var_26_0)
				end,
				delegate = function(arg_28_0)
					local var_28_0 = self:SwitchSaveData(arg_28_0, var_26_0)

					if var_28_0 then
						self:Back()
					end

					return var_28_0
				end
			})
		end
	})
end

function HeroDisplayExpressionView:TrySaveData()
	local var_29_1 = HeroDisplayData:GetCacheExpressionParams()
	local var_29_2 = {
		preset = false,
		values = clone(var_29_1.values),
		effectID = var_29_1.effectID
	}

	JumpTools.OpenPageByJump("ProposalPopup", {
		maskCloseFun = function(arg_30_0)
			return self:SaveData(arg_30_0, var_29_2)
		end,
		delegate = function(arg_31_0)
			return self:SaveData(arg_31_0, var_29_2)
		end
	})
end

function HeroDisplayExpressionView:TryExitSaveData()
	if not self:IsChangeValue() then
		self:Back()

		return
	end

	JumpTools.OpenPageByJump("threeButtonBox", {
		content = GetTips("SAVE_PRESET_TIPS"),
		cancelFun = function()
			self:Back()
		end,
		closeFun = function()
			self:Back()
		end,
		okFun = function()
			local var_35_1 = HeroDisplayData:GetCacheExpressionParams()
			local var_35_2 = {
				preset = false,
				values = clone(var_35_1.values),
				effectID = var_35_1.effectID
			}

			JumpTools.OpenPageByJump("ProposalPopup", {
				maskCloseFun = function(arg_36_0)
					return self:ExitSaveData(arg_36_0, var_35_2)
				end,
				delegate = function(arg_37_0)
					local var_37_0 = self:ExitSaveData(arg_37_0, var_35_2)

					if var_37_0 then
						self:Back()
					end

					return var_37_0
				end
			})
		end
	})
end

function HeroDisplayExpressionView:IsExceedMaxCnt()
	if #HeroDisplayData:GetCustomExpressionParams(self.heroID_) >= GameSetting.preset_max.value[1] then
		ShowTips("PRESET_MORE_THAN_MAX")

		return true
	end

	return false
end

function HeroDisplayExpressionView:LoadEffect(arg_39_1)
	HeroDisplayData:SetCacheExpressionEffect(arg_39_1)

	if arg_39_1 == 0 then
		SetActive(self.currentEffect_, false)

		return
	end

	if self.effectObject_[arg_39_1] then
		self.currentEffect_ = self.effectObject_[arg_39_1]

		SetActive(self.currentEffect_, true)
	else
		local var_39_0 = HeroDisplayEffectCfg[arg_39_1]

		self.effectObject_[arg_39_1] = Object.Instantiate(Asset.Load("Effect/Display/" .. HeroDisplayEffectCfg[arg_39_1].model), self:FindGo(HeroDisplayEffectCfg[arg_39_1].handPointPath, self.heroModel_.transform).transform)
		self.effectObject_[arg_39_1].transform.localPosition = Vector3(var_39_0.position[1], var_39_0.position[2], var_39_0.position[3])
		self.effectObject_[arg_39_1].transform.localEulerAngles = Vector3(var_39_0.rotation[1], var_39_0.rotation[2], var_39_0.rotation[3])
		self.currentEffect_ = self.effectObject_[arg_39_1]
	end
end

function HeroDisplayExpressionView:SwitchSaveData(arg_40_1, arg_40_2)
	local var_40_0 = self.heroID_

	arg_40_2.name = arg_40_1

	for iter_40_0, iter_40_1 in ipairs(HeroDisplayData:GetHeroExpressionParams(self.heroID_)) do
		if arg_40_1 == iter_40_1.name then
			if iter_40_0 - 1 < HeroDisplayData:GetCustomStartIndex(self.heroID_) then
				ShowTips("CANNOT_REPLACE_PRESET")

				return false
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("REPLACE_SAME_PRESET"),
				OkCallback = function()
					HeroDisplayData:ReplaceHeroExpressionParams(var_40_0, iter_40_0, arg_40_2)
					self:RefreshItemValue(iter_40_0)
					self:Back(2)
				end,
				CancelCallback = function()
					return
				end
			})

			return false
		end
	end

	if self:IsExceedMaxCnt() then
		return false
	end

	HeroDisplayData:SaveHeroExpressionParams(self.heroID_, arg_40_2)
	self:AddDropdownItem(arg_40_1)
	self:RefreshItemValue(#HeroDisplayData:GetHeroExpressionParams(self.heroID_))

	return true
end

function HeroDisplayExpressionView:SaveData(arg_43_1, arg_43_2)
	local var_43_0 = self.heroID_

	arg_43_2.name = arg_43_1

	for iter_43_0, iter_43_1 in ipairs(HeroDisplayData:GetHeroExpressionParams(self.heroID_)) do
		if arg_43_1 == iter_43_1.name then
			if iter_43_0 - 1 < HeroDisplayData:GetCustomStartIndex(self.heroID_) then
				ShowTips("CANNOT_REPLACE_PRESET")

				return false
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("REPLACE_SAME_PRESET"),
				OkCallback = function()
					HeroDisplayData:ReplaceHeroExpressionParams(var_43_0, iter_43_0, arg_43_2)
					self:RefreshItemValue(iter_43_0)
					self:Back()
				end,
				CancelCallback = function()
					return
				end
			})

			return false
		end
	end

	if self:IsExceedMaxCnt() then
		return false
	end

	HeroDisplayData:SaveHeroExpressionParams(self.heroID_, arg_43_2)
	self:AddDropdownItem(arg_43_1)
	self:RefreshItemValue(#HeroDisplayData:GetHeroExpressionParams(self.heroID_))

	return true
end

function HeroDisplayExpressionView:ExitSaveData(arg_46_1, arg_46_2)
	local var_46_0 = self.heroID_

	arg_46_2.name = arg_46_1

	for iter_46_0, iter_46_1 in ipairs(HeroDisplayData:GetHeroExpressionParams(self.heroID_)) do
		if arg_46_1 == iter_46_1.name then
			if iter_46_0 - 1 < HeroDisplayData:GetCustomStartIndex(self.heroID_) then
				ShowTips("CANNOT_REPLACE_PRESET")

				return false
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("REPLACE_SAME_PRESET"),
				OkCallback = function()
					HeroDisplayData:ReplaceHeroExpressionParams(var_46_0, iter_46_0, arg_46_2)
					self:Back(3)
				end,
				CancelCallback = function()
					return
				end
			})

			return false
		end
	end

	if self:IsExceedMaxCnt() then
		return false
	end

	HeroDisplayData:SaveHeroExpressionParams(self.heroID_, arg_46_2)
	self:Back()

	return true
end

return HeroDisplayExpressionView
