local var_0_0 = require("cjson")
local var_0_1 = class("BattleUIAdjustView", ReduxView)

function var_0_1.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_1.UIName(arg_2_0)
	if GameToSDK.PLATFORM_ID == 3 then
		return "Widget/System/Setting/BattlePanelSetting_PC_Variant"
	elseif GameToSDK.PLATFORM_ID == 0 or GameToSDK.PLATFORM_ID == 1 or GameToSDK.PLATFORM_ID == 4 then
		return "Widget/System/Setting/BattlePanelSetting"
	else
		return "Widget/System/Setting/BattlePanelSetting"
	end
end

function var_0_1.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.adapter_ = arg_5_0:FindCom("BattleUIAdapter", "")
	arg_5_0.targets_ = {}
	arg_5_0.trans_ = {}
	arg_5_0.defaultScale_ = {}
	arg_5_0.panelController_ = ControllerUtil.GetController(arg_5_0.panelGo_.transform, "conName")

	for iter_5_0 = 0, arg_5_0.adapter_.listToChange.Count - 1 do
		local var_5_0 = arg_5_0:FindCom(typeof(Image), arg_5_0.adapter_.listToChange[iter_5_0])

		table.insert(arg_5_0.targets_, var_5_0)

		arg_5_0.defaultScale_[var_5_0] = var_5_0.transform.localScale.x

		table.insert(arg_5_0.trans_, arg_5_0:FindCom(typeof(RectTransform), arg_5_0.adapter_.listToChange[iter_5_0]))
	end

	arg_5_0.canvasGroupList_ = {}

	for iter_5_1 = 0, arg_5_0.adapter_.m_alphaList.Count - 1 do
		table.insert(arg_5_0.canvasGroupList_, arg_5_0:FindCom(typeof(CanvasGroup), arg_5_0.adapter_.m_alphaList[iter_5_1]))
	end

	arg_5_0.typeTgls_ = {
		arg_5_0.type0Btn_,
		arg_5_0.type1Btn_,
		arg_5_0.type2Btn_,
		arg_5_0.type3Btn_
	}
	arg_5_0.stateCtrl = arg_5_0.tabControllerexcollection_:GetController("default0")
end

function var_0_1.OnEnter(arg_6_0)
	arg_6_0:AdaptScreen()

	arg_6_0.settingData_ = SettingData:GetBattleUISettingData()
	arg_6_0.tmpSettingData_ = deepClone(arg_6_0.settingData_)
	arg_6_0.currentIndex_ = 0

	if arg_6_0.tmpSettingData_.battle_ui_cur_type == arg_6_0.tmpSettingData_.battle_ui_type_0 then
		arg_6_0.currentIndex_ = 0
	elseif arg_6_0.tmpSettingData_.battle_ui_cur_type == arg_6_0.tmpSettingData_.battle_ui_type_1 then
		arg_6_0.currentIndex_ = 1
	elseif arg_6_0.tmpSettingData_.battle_ui_cur_type == arg_6_0.tmpSettingData_.battle_ui_type_2 then
		arg_6_0.currentIndex_ = 2
	elseif arg_6_0.tmpSettingData_.battle_ui_cur_type == arg_6_0.tmpSettingData_.battle_ui_type_3 then
		arg_6_0.currentIndex_ = 3
	end

	arg_6_0:UpdateSelectTrans(arg_6_0.targets_[1])
	arg_6_0:UpdateIndex(arg_6_0.currentIndex_)

	arg_6_0.isDirty_ = false

	if manager.windowBar:GetIsShow() then
		arg_6_0.barList_ = manager.windowBar:GetLastBarList()

		manager.windowBar:HideBar()
	end

	arg_6_0.stateCtrl:SetSelectedIndex(arg_6_0.currentIndex_)
end

function var_0_1.OnExit(arg_7_0)
	if arg_7_0.barList_ then
		manager.windowBar:SwitchBar(arg_7_0.barList_)
	end
end

function var_0_1.Dispose(arg_8_0)
	var_0_1.super.Dispose(arg_8_0)
	arg_8_0.sizeSlr_.onValueChanged:RemoveAllListeners()
	arg_8_0.alphaSlider_.onValueChanged:RemoveAllListeners()
	arg_8_0.rotateSpeedSlider_.onValueChanged:RemoveAllListeners()
end

function var_0_1.UpdateSelectTrans(arg_9_0, arg_9_1)
	if arg_9_0.selectTarget_ then
		arg_9_0.selectTarget_.color = Color.white
	end

	arg_9_0.selectTarget_ = arg_9_1
	arg_9_0.selectTarget_.color = Color.green

	local var_9_0 = arg_9_0.defaultScale_[arg_9_0.selectTarget_]

	if var_9_0 and var_9_0 > 0 then
		arg_9_0.sizeSlr_.value = arg_9_0.selectTarget_.transform.localScale.x / var_9_0 - 0.5
	else
		arg_9_0.sizeSlr_.value = arg_9_0.selectTarget_.transform.localScale.x - 0.5
	end
end

function var_0_1.UpdateIndex(arg_10_0, arg_10_1)
	arg_10_0.currentIndex_ = arg_10_1

	arg_10_0.stateCtrl:SetSelectedIndex(arg_10_0.currentIndex_)

	arg_10_0.tmpSettingData_.battle_ui_cur_type = arg_10_0.tmpSettingData_["battle_ui_type_" .. arg_10_1]
	arg_10_0.tmpSettingData_.battle_ui_cur_alpha_value = arg_10_0.tmpSettingData_["battle_ui_type_" .. arg_10_1]

	local var_10_0 = tonumber(arg_10_0.tmpSettingData_["battle_ui_alpha_" .. arg_10_1])

	arg_10_0.adapter_:ResetToDefault()
	arg_10_0.adapter_:Set(arg_10_0.tmpSettingData_.battle_ui_cur_type, var_10_0)

	local var_10_1 = arg_10_0.defaultScale_[arg_10_0.selectTarget_]

	if var_10_1 and var_10_1 > 0 then
		arg_10_0.sizeSlr_.value = arg_10_0.selectTarget_.transform.localScale.x / var_10_1 - 0.5
	else
		arg_10_0.sizeSlr_.value = arg_10_0.selectTarget_.transform.localScale.x - 0.5
	end

	arg_10_0.alphaSlider_.value = 1 - var_10_0
	arg_10_0.tmpSettingData_.battle_ui_cur_rotate_speed = arg_10_0.tmpSettingData_["battle_ui_rotate_speed_" .. arg_10_1]
	arg_10_0.rotateSpeedSlider_.value = tonumber(arg_10_0.tmpSettingData_["battle_ui_rotate_speed_" .. arg_10_1])
end

function var_0_1.ApplyData(arg_11_0)
	arg_11_0.tmpSettingData_.battle_ui_cur_type = arg_11_0.adapter_:Save()
	arg_11_0.tmpSettingData_.battle_ui_cur_alpha_value = 1 - arg_11_0.alphaSlider_.value
	arg_11_0.tmpSettingData_.battle_ui_cur_rotate_speed = arg_11_0.rotateSpeedSlider_.value

	if arg_11_0.currentIndex_ < 0 or arg_11_0.currentIndex_ > 3 then
		return
	end

	local var_11_0 = {}
	local var_11_1
	local var_11_2 = arg_11_0.adapter_:DecodeData(arg_11_0.tmpSettingData_.battle_ui_cur_type)

	for iter_11_0 = 0, var_11_2.datas.Count - 1 do
		local var_11_3 = var_11_2.datas[iter_11_0]
		local var_11_4 = {
			var_11_3.path,
			var_11_3.offest.x,
			var_11_3.offest.y,
			var_11_3.scale
		}

		table.insert(var_11_0, var_11_4)
	end

	local var_11_5 = var_0_0.encode(var_11_0)
	local var_11_6 = {
		diy_battle = var_11_5
	}

	SDKTools.SendMessageToSDK("diy_battle_setting", var_11_6)

	arg_11_0.tmpSettingData_["battle_ui_type_" .. arg_11_0.currentIndex_] = arg_11_0.tmpSettingData_.battle_ui_cur_type
	arg_11_0.tmpSettingData_["battle_ui_alpha_" .. arg_11_0.currentIndex_] = arg_11_0.tmpSettingData_.battle_ui_cur_alpha_value
	arg_11_0.tmpSettingData_["battle_ui_rotate_speed_" .. arg_11_0.currentIndex_] = arg_11_0.tmpSettingData_.battle_ui_cur_rotate_speed
end

function var_0_1.SaveFunc(arg_12_0)
	arg_12_0:ApplyData()

	arg_12_0.settingData_ = deepClone(arg_12_0.tmpSettingData_)

	SettingData:ModifyBattleUISetting("allData", arg_12_0.settingData_)

	arg_12_0.isDirty_ = false

	ShowTips("SAVE_SYSTEM_SETTING")
	manager.notify:Invoke(BATTLE_UI_ADJUSTED)
end

function var_0_1.BackFunc(arg_13_0)
	local var_13_0 = false

	if arg_13_0.tmpSettingData_ and not table.equal(arg_13_0.tmpSettingData_, arg_13_0.settingData_, "all") then
		var_13_0 = true
	end

	if var_13_0 or arg_13_0.isDirty_ then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SETTING_CHANGE"),
			OkCallback = function()
				arg_13_0:SaveFunc()
				OperationRecorder.Record(arg_13_0.class.__cname, "panel/btn_save")
				arg_13_0:Back()
			end,
			CancelCallback = function()
				OperationRecorder.Record(arg_13_0.class.__cname, "cancel")
				arg_13_0:Back()
			end
		})
	else
		arg_13_0:Back()
	end
end

function var_0_1.AddUIListener(arg_16_0)
	arg_16_0:AddBtnListener(arg_16_0.returnBtn_, nil, function()
		arg_16_0:BackFunc()
	end)
	arg_16_0:AddBtnListener(arg_16_0.resetBtn_, nil, function()
		arg_16_0.adapter_:ResetToDefault()

		arg_16_0.sizeSlr_.value = 0.5
		arg_16_0.alphaSlider_.value = 0
		arg_16_0.rotateSpeedSlider_.value = 0.5
		arg_16_0.isDirty_ = true

		arg_16_0:ValidCheck()
	end)
	arg_16_0:AddBtnListener(arg_16_0.saveBtn_, nil, function()
		arg_16_0:SaveFunc()
	end)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.typeTgls_) do
		arg_16_0:AddBtnListener(iter_16_1, nil, function()
			if arg_16_0.currentIndex_ == iter_16_0 - 1 then
				return
			end

			arg_16_0:ApplyData()
			arg_16_0:UpdateIndex(iter_16_0 - 1)
			arg_16_0:ValidCheck()
		end)
	end

	arg_16_0.sizeSlr_.onValueChanged:AddListener(function()
		if arg_16_0.selectTarget_ then
			local var_21_0 = (arg_16_0.sizeSlr_.value + 0.5) * arg_16_0.defaultScale_[arg_16_0.selectTarget_]

			arg_16_0.selectTarget_.transform.localScale = Vector3.New(var_21_0, var_21_0, var_21_0)
		end

		arg_16_0.isDirty_ = true

		arg_16_0:ValidCheck()
	end)
	arg_16_0.alphaSlider_.onValueChanged:AddListener(function()
		local var_22_0 = arg_16_0.alphaSlider_.value

		for iter_22_0, iter_22_1 in pairs(arg_16_0.canvasGroupList_) do
			iter_22_1.alpha = 1 - var_22_0
		end

		arg_16_0.isDirty_ = true

		arg_16_0:ValidCheck()
	end)
	arg_16_0.rotateSpeedSlider_.onValueChanged:AddListener(function()
		arg_16_0.isDirty_ = true
	end)

	for iter_16_2, iter_16_3 in pairs(arg_16_0.targets_) do
		arg_16_0:GetOrAddComponent(iter_16_3.gameObject, typeof(EventTriggerListener)):AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function()
			arg_16_0.isDirty_ = true

			arg_16_0:UpdateSelectTrans(iter_16_3)
			arg_16_0:ValidCheck()
		end))
	end

	arg_16_0:AddBtnListener(arg_16_0.zoombtnBtn_, nil, function()
		local var_25_0 = arg_16_0.panelController_:GetSelectedState() == "1"

		arg_16_0.panelController_:SetSelectedState(var_25_0 and "0" or "1")
	end)
end

function var_0_1.GetScreenRect(arg_26_0, arg_26_1)
	local var_26_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	if arg_26_0.corners == nil then
		arg_26_0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end

	arg_26_1:GetWorldCorners(arg_26_0.corners)

	local var_26_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_26_0, arg_26_0.corners[0])
	local var_26_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_26_0, arg_26_0.corners[2])

	return (UnityEngine.Rect.New(var_26_1, var_26_2 - var_26_1))
end

function var_0_1.Overlap(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:GetScreenRect(arg_27_1)
	local var_27_1 = arg_27_0:GetScreenRect(arg_27_2)

	return var_27_0:Overlaps(var_27_1)
end

function var_0_1.ValidCheck(arg_28_0)
	if arg_28_0.invalidList_ then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.invalidList_) do
			if arg_28_0.selectTarget_ == arg_28_0.targets_[iter_28_1] then
				arg_28_0.targets_[iter_28_1].color = Color.green
			else
				arg_28_0.targets_[iter_28_1].color = Color.white
			end
		end
	end

	arg_28_0.invalidList_ = {}

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.trans_) do
		for iter_28_4, iter_28_5 in ipairs(arg_28_0.trans_) do
			if iter_28_3 ~= iter_28_5 and arg_28_0:Overlap(iter_28_3, iter_28_5) then
				table.insert(arg_28_0.invalidList_, iter_28_2)
				table.insert(arg_28_0.invalidList_, iter_28_4)
			end
		end
	end

	for iter_28_6, iter_28_7 in ipairs(arg_28_0.invalidList_) do
		arg_28_0.targets_[iter_28_7].color = Color.red
	end
end

return var_0_1
