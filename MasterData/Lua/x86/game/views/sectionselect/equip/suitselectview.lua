local SuitSelectView = class("SuitSelectView", ReduxView)

function SuitSelectView:UIName()
	return "Widget/System/Operation/EquipSelectPopUI"
end

function SuitSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function SuitSelectView:Init()
	self:InitUI()
	self:InitDropDown()
	self:AddListeners()
end

function SuitSelectView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.suitListGo_, SuitSelectItem)
	self.stateController_ = self.controller:GetController("state")
	self.autoDecomposeController_ = self.controller:GetController("autoDecompose")
	self.autoFlagController_ = self.controller:GetController("autoFlag")

	self.autoDecomposeController_:SetSelectedState("true")
end

function SuitSelectView:InitDropDown()
	self.dropDown_.options:Clear()
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("ALL"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("EQUIP_TYPE_1"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("EQUIP_TYPE_2"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("RACE_TYPE_10"), nil))
	self.dropDown_:RefreshShownValue()
end

function SuitSelectView:UpdateData()
	self.suitList_ = {}

	local var_6_0 = HideInfoData:GetEquipSuitHideList()
	local var_6_2 = self.select_
	local var_6_3 = table.length(EquipSuitCfg.get_id_list_by_equip_type)

	if self.select_ == 0 then
		var_6_2 = var_6_3
	elseif self.select_ == var_6_3 then
		var_6_2 = 0
	end

	for iter_6_0, iter_6_1 in ipairs(var_6_2 < var_6_3 and EquipSuitCfg.get_id_list_by_equip_type[var_6_2] or EquipSuitCfg.get_id_list_by_suit) do
		local var_6_4 = iter_6_1

		if type(iter_6_1) == "table" then
			var_6_4 = iter_6_1[1]
		end

		if EquipSuitCfg[var_6_4].stage_up_list == 1 and not var_6_0[var_6_4] then
			table.insert(self.suitList_, var_6_4)
		end
	end
end

function SuitSelectView:indexItem(arg_7_1, arg_7_2)
	local var_7_0 = self.suitList_[arg_7_1]

	if self.suitList_[arg_7_1] == self.selectSuitId_ then
		arg_7_2:ShowSelect(true)
	else
		arg_7_2:ShowSelect(false)
	end

	if var_7_0 == self.params_.currentSuitId then
		arg_7_2:ShowCurrentUp(true)
	else
		arg_7_2:ShowCurrentUp(false)
	end

	arg_7_2:RefreshData(self, {
		id = var_7_0
	})
	arg_7_2:RegistCallBack(function(arg_8_0)
		self:SelectSuitItem(arg_8_0)
	end)
end

function SuitSelectView:SelectSuitItem(arg_9_1)
	local var_9_0 = self.scrollHelper_:GetItemList()
	local var_9_1 = table.indexof(self.suitList_, arg_9_1.id)
	local var_9_2 = table.indexof(self.suitList_, self.selectSuitId_)

	if var_9_0[var_9_2] then
		var_9_0[var_9_2]:ShowSelect(false)
	end

	self.selectSuitId_ = arg_9_1.id

	if self.params_.hideBtn then
		self.stateController_:SetSelectedState("hide")
	else
		self.stateController_:SetSelectedState(self.choosedId_ ~= self.selectSuitId_ and "confirm" or "select")
	end

	var_9_0[var_9_1]:ShowSelect(true)
	self:RefreshSelectSuitInfo()
end

function SuitSelectView:RefreshSelectSuitInfo()
	if not EquipSuitCfg[self.selectSuitId_] then
		SetActive(self.infoGo_, false)

		return
	end

	SetActive(self.infoGo_, true)

	self.name_.text = GetI18NText(EquipSuitCfg[self.selectSuitId_].name)
	self.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), EquipSuitCfg[self.selectSuitId_].need)
	self.desc_.text = GetI18NText(EquipTools.GetEffectDesc(EquipSuitCfg[self.selectSuitId_].suit_effect[1]))
	self.scrollView_.verticalNormalizedPosition = 1
end

function SuitSelectView:AddListeners()
	self:AddBtnListener(self.btnBgMask_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.btnConfirm_, nil, function()
		if self.selectSuitId_ == nil then
			return
		end

		BattleEquipAction.ChangeUpSuit(self.selectSuitId_)
		SDKTools.SendMessageToSDK("equip_target_changed", {
			equip_id_old = self.params_.currentSuitId,
			equip_id_new = self.selectSuitId_
		})
	end)
	self:AddToggleListener(self.dropDown_, function(arg_14_0)
		self.select_ = arg_14_0

		self:RefreshUI()
	end)
	self:AddBtnListener(self.autoDecomposeBtn_, nil, function()
		if not EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.NORMAL) then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("AUTO_DECOMPOSE_TIPS"),
				OkCallback = function()
					EquipAction.SetAutoDecomposeState(BattleConst.BATTLE_EQUIP_TYPE.NORMAL, true, function()
						ShowTips("AUTO_DECOMPOSE_OPEN")
						self:RefreshAutoState()
					end)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			EquipAction.SetAutoDecomposeState(BattleConst.BATTLE_EQUIP_TYPE.NORMAL, false, function()
				ShowTips("AUTO_DECOMPOSE_CLOSE")
				self:RefreshAutoState()
			end)
		end
	end)
end

function SuitSelectView:OnEnter()
	self.selectSuitId_ = self.params_.suitId
	self.choosedId_ = self.params_.currentSuitId
	self.select_ = 0
	self.dropDown_.value = 0

	self:RefreshUI()
	self:RefreshAutoState()
end

function SuitSelectView:RefreshUI()
	self:UpdateData()

	local var_21_0 = false

	if self.selectSuitId_ then
		var_21_0 = table.indexof(self.suitList_, self.selectSuitId_)

		if not var_21_0 then
			var_21_0 = 1
			self.selectSuitId_ = self.suitList_[1]
		end
	else
		var_21_0 = 1
		self.selectSuitId_ = self.suitList_[1]
	end

	if self.params_.hideBtn then
		self.stateController_:SetSelectedState("hide")
	else
		self.stateController_:SetSelectedState(self.choosedId_ ~= self.selectSuitId_ and "confirm" or "select")
	end

	self.scrollHelper_:StartScroll(#self.suitList_, var_21_0 - 5 < 1 and 1 or var_21_0 - 5)
	self:RefreshSelectSuitInfo()
end

function SuitSelectView:OnChangeUpSuit(arg_22_1, arg_22_2)
	if isSuccess(arg_22_1.result) then
		JumpTools.Back()
	end
end

function SuitSelectView:OnExit()
	self.selectSuitId_ = nil
end

function SuitSelectView:Dispose()
	self.scrollHelper_:Dispose()
	SuitSelectView.super.Dispose(self)
end

function SuitSelectView:RefreshAutoState()
	self.autoFlagController_:SetSelectedState(tostring((EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.NORMAL))))
end

return SuitSelectView
