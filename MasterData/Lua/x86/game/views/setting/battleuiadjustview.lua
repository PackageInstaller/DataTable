local cjson = require("cjson")
local BattleUIAdjustView = class("BattleUIAdjustView", ReduxView)

function BattleUIAdjustView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function BattleUIAdjustView:UIName()
	if GameToSDK.PLATFORM_ID == 3 then
		return "Widget/System/Setting/BattlePanelSetting_PC_Variant"
	elseif GameToSDK.PLATFORM_ID == 0 or GameToSDK.PLATFORM_ID == 1 or GameToSDK.PLATFORM_ID == 4 then
		return "Widget/System/Setting/BattlePanelSetting"
	else
		return "Widget/System/Setting/BattlePanelSetting"
	end
end

function BattleUIAdjustView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleUIAdjustView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BattleUIAdjustView:InitUI()
	self:BindCfgUI()

	self.adapter_ = self:FindCom("BattleUIAdapter", "")
	self.targets_ = {}
	self.trans_ = {}
	self.defaultScale_ = {}
	self.panelController_ = ControllerUtil.GetController(self.panelGo_.transform, "conName")

	for iter_5_0 = 0, self.adapter_.listToChange.Count - 1 do
		local var_5_0 = self:FindCom(typeof(Image), self.adapter_.listToChange[iter_5_0])

		table.insert(self.targets_, var_5_0)

		self.defaultScale_[var_5_0] = var_5_0.transform.localScale.x

		table.insert(self.trans_, self:FindCom(typeof(RectTransform), self.adapter_.listToChange[iter_5_0]))
	end

	self.canvasGroupList_ = {}

	for iter_5_1 = 0, self.adapter_.m_alphaList.Count - 1 do
		table.insert(self.canvasGroupList_, self:FindCom(typeof(CanvasGroup), self.adapter_.m_alphaList[iter_5_1]))
	end

	self.typeTgls_ = {
		self.type0Btn_,
		self.type1Btn_,
		self.type2Btn_,
		self.type3Btn_
	}
	self.stateCtrl = self.tabControllerexcollection_:GetController("default0")
end

function BattleUIAdjustView:OnEnter()
	self:AdaptScreen()

	self.settingData_ = SettingData:GetBattleUISettingData()
	self.tmpSettingData_ = deepClone(self.settingData_)
	self.currentIndex_ = 0

	if self.tmpSettingData_.battle_ui_cur_type == self.tmpSettingData_.battle_ui_type_0 then
		self.currentIndex_ = 0
	elseif self.tmpSettingData_.battle_ui_cur_type == self.tmpSettingData_.battle_ui_type_1 then
		self.currentIndex_ = 1
	elseif self.tmpSettingData_.battle_ui_cur_type == self.tmpSettingData_.battle_ui_type_2 then
		self.currentIndex_ = 2
	elseif self.tmpSettingData_.battle_ui_cur_type == self.tmpSettingData_.battle_ui_type_3 then
		self.currentIndex_ = 3
	end

	self:UpdateSelectTrans(self.targets_[1])
	self:UpdateIndex(self.currentIndex_)

	self.isDirty_ = false

	if manager.windowBar:GetIsShow() then
		self.barList_ = manager.windowBar:GetLastBarList()

		manager.windowBar:HideBar()
	end

	self.stateCtrl:SetSelectedIndex(self.currentIndex_)
end

function BattleUIAdjustView:OnExit()
	if self.barList_ then
		manager.windowBar:SwitchBar(self.barList_)
	end
end

function BattleUIAdjustView:Dispose()
	BattleUIAdjustView.super.Dispose(self)
	self.sizeSlr_.onValueChanged:RemoveAllListeners()
	self.alphaSlider_.onValueChanged:RemoveAllListeners()
	self.rotateSpeedSlider_.onValueChanged:RemoveAllListeners()
end

function BattleUIAdjustView:UpdateSelectTrans(arg_9_1)
	if self.selectTarget_ then
		self.selectTarget_.color = Color.white
	end

	self.selectTarget_ = arg_9_1
	self.selectTarget_.color = Color.green
	self.sizeSlr_.value = self.defaultScale_[self.selectTarget_] and self.defaultScale_[self.selectTarget_] > 0 and self.selectTarget_.transform.localScale.x / self.defaultScale_[self.selectTarget_] - 0.5 or self.selectTarget_.transform.localScale.x - 0.5
end

function BattleUIAdjustView:UpdateIndex(arg_10_1)
	self.currentIndex_ = arg_10_1

	self.stateCtrl:SetSelectedIndex(self.currentIndex_)

	self.tmpSettingData_.battle_ui_cur_type = self.tmpSettingData_["battle_ui_type_" .. arg_10_1]
	self.tmpSettingData_.battle_ui_cur_alpha_value = self.tmpSettingData_["battle_ui_type_" .. arg_10_1]

	local var_10_0 = tonumber(self.tmpSettingData_["battle_ui_alpha_" .. arg_10_1])

	self.adapter_:ResetToDefault()
	self.adapter_:Set(self.tmpSettingData_.battle_ui_cur_type, var_10_0)

	self.sizeSlr_.value = self.defaultScale_[self.selectTarget_] and self.defaultScale_[self.selectTarget_] > 0 and self.selectTarget_.transform.localScale.x / self.defaultScale_[self.selectTarget_] - 0.5 or self.selectTarget_.transform.localScale.x - 0.5
	self.alphaSlider_.value = 1 - var_10_0
	self.tmpSettingData_.battle_ui_cur_rotate_speed = self.tmpSettingData_["battle_ui_rotate_speed_" .. arg_10_1]
	self.rotateSpeedSlider_.value = tonumber(self.tmpSettingData_["battle_ui_rotate_speed_" .. arg_10_1])
end

function BattleUIAdjustView:ApplyData()
	self.tmpSettingData_.battle_ui_cur_type = self.adapter_:Save()
	self.tmpSettingData_.battle_ui_cur_alpha_value = 1 - self.alphaSlider_.value
	self.tmpSettingData_.battle_ui_cur_rotate_speed = self.rotateSpeedSlider_.value

	if self.currentIndex_ < 0 or self.currentIndex_ > 3 then
		return
	end

	local var_11_0 = {}
	local var_11_2 = self.adapter_:DecodeData(self.tmpSettingData_.battle_ui_cur_type)

	for iter_11_0 = 0, var_11_2.datas.Count - 1 do
		table.insert(var_11_0, {
			var_11_2.datas[iter_11_0].path,
			var_11_2.datas[iter_11_0].offest.x,
			var_11_2.datas[iter_11_0].offest.y,
			var_11_2.datas[iter_11_0].scale
		})
	end

	SDKTools.SendMessageToSDK("diy_battle_setting", {
		diy_battle = cjson.encode(var_11_0)
	})

	self.tmpSettingData_["battle_ui_type_" .. self.currentIndex_] = self.tmpSettingData_.battle_ui_cur_type
	self.tmpSettingData_["battle_ui_alpha_" .. self.currentIndex_] = self.tmpSettingData_.battle_ui_cur_alpha_value
	self.tmpSettingData_["battle_ui_rotate_speed_" .. self.currentIndex_] = self.tmpSettingData_.battle_ui_cur_rotate_speed
end

function BattleUIAdjustView:SaveFunc()
	self:ApplyData()

	self.settingData_ = deepClone(self.tmpSettingData_)

	SettingData:ModifyBattleUISetting("allData", self.settingData_)

	self.isDirty_ = false

	ShowTips("SAVE_SYSTEM_SETTING")
	manager.notify:Invoke(BATTLE_UI_ADJUSTED)
end

function BattleUIAdjustView:BackFunc()
	if not not (self.tmpSettingData_ and not table.equal(self.tmpSettingData_, self.settingData_, "all")) or self.isDirty_ then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SETTING_CHANGE"),
			OkCallback = function()
				self:SaveFunc()
				OperationRecorder.Record(self.class.__cname, "panel/btn_save")
				self:Back()
			end,
			CancelCallback = function()
				OperationRecorder.Record(self.class.__cname, "cancel")
				self:Back()
			end
		})
	else
		self:Back()
	end
end

function BattleUIAdjustView:AddUIListener()
	self:AddBtnListener(self.returnBtn_, nil, function()
		self:BackFunc()
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		self.adapter_:ResetToDefault()

		self.sizeSlr_.value = 0.5
		self.alphaSlider_.value = 0
		self.rotateSpeedSlider_.value = 0.5
		self.isDirty_ = true

		self:ValidCheck()
	end)
	self:AddBtnListener(self.saveBtn_, nil, function()
		self:SaveFunc()
	end)

	for iter_16_0, iter_16_1 in ipairs(self.typeTgls_) do
		self:AddBtnListener(iter_16_1, nil, function()
			if self.currentIndex_ == iter_16_0 - 1 then
				return
			end

			self:ApplyData()
			self:UpdateIndex(iter_16_0 - 1)
			self:ValidCheck()
		end)
	end

	self.sizeSlr_.onValueChanged:AddListener(function()
		if self.selectTarget_ then
			self.selectTarget_.transform.localScale = Vector3.New((self.sizeSlr_.value + 0.5) * self.defaultScale_[self.selectTarget_], (self.sizeSlr_.value + 0.5) * self.defaultScale_[self.selectTarget_], (self.sizeSlr_.value + 0.5) * self.defaultScale_[self.selectTarget_])
		end

		self.isDirty_ = true

		self:ValidCheck()
	end)
	self.alphaSlider_.onValueChanged:AddListener(function()
		for iter_22_0, iter_22_1 in pairs(self.canvasGroupList_) do
			iter_22_1.alpha = 1 - self.alphaSlider_.value
		end

		self.isDirty_ = true

		self:ValidCheck()
	end)
	self.rotateSpeedSlider_.onValueChanged:AddListener(function()
		self.isDirty_ = true
	end)

	for iter_16_2, iter_16_3 in pairs(self.targets_) do
		self:GetOrAddComponent(iter_16_3.gameObject, typeof(EventTriggerListener)):AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function()
			self.isDirty_ = true

			self:UpdateSelectTrans(iter_16_3)
			self:ValidCheck()
		end))
	end

	self:AddBtnListener(self.zoombtnBtn_, nil, function()
		self.panelController_:SetSelectedState(self.panelController_:GetSelectedState() == "1" and "0" or "1")
	end)
end

function BattleUIAdjustView:GetScreenRect(arg_26_1)
	local var_26_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	if self.corners == nil then
		self.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end

	arg_26_1:GetWorldCorners(self.corners)

	local var_26_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_26_0, self.corners[0])

	return (UnityEngine.Rect.New(var_26_1, UnityEngine.RectTransformUtility.WorldToScreenPoint(var_26_0, self.corners[2]) - var_26_1))
end

function BattleUIAdjustView:Overlap(arg_27_1, arg_27_2)
	return self:GetScreenRect(arg_27_1):Overlaps((self:GetScreenRect(arg_27_2)))
end

function BattleUIAdjustView:ValidCheck()
	if self.invalidList_ then
		for iter_28_0, iter_28_1 in ipairs(self.invalidList_) do
			self.targets_[iter_28_1].color = self.selectTarget_ == self.targets_[iter_28_1] and Color.green or Color.white
		end
	end

	self.invalidList_ = {}

	for iter_28_2, iter_28_3 in ipairs(self.trans_) do
		for iter_28_4, iter_28_5 in ipairs(self.trans_) do
			if iter_28_3 ~= iter_28_5 and self:Overlap(iter_28_3, iter_28_5) then
				table.insert(self.invalidList_, iter_28_2)
				table.insert(self.invalidList_, iter_28_4)
			end
		end
	end

	for iter_28_6, iter_28_7 in ipairs(self.invalidList_) do
		self.targets_[iter_28_7].color = Color.red
	end
end

return BattleUIAdjustView
