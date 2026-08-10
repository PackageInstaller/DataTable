local var_0_0 = class("MessageBoxItem")
local var_0_1 = import("game.tools.ItemTools")
local var_0_2 = import("game.tools.JumpTools")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, manager.ui.uiMessage.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isFree_ = true

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.gameObject_)

	arg_2_0.typeController_ = arg_2_0.controllerEx_:GetController("type")
	arg_2_0.singleController_ = arg_2_0.controllerEx_:GetController("single")
	arg_2_0.tipsController_ = arg_2_0.controllerEx_:GetController("tips")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0.okBtn_.onClick:AddListener(function()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "okBtn")
		arg_3_0:OnClickOk()
	end)
	arg_3_0.cancelBtn_.onClick:AddListener(function()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "cancelBtn")
		arg_3_0:OnClickCancel()
	end)

	if arg_3_0.restartBtn_ then
		arg_3_0.restartBtn_.onClick:AddListener(function()
			arg_3_0:OnRestartClick()
		end)
	end

	arg_3_0.tipsBtn_.onClick:AddListener(function()
		arg_3_0.tipsFlag_ = not arg_3_0.tipsFlag_

		arg_3_0.tipsController_:SetSelectedState(tostring(arg_3_0.tipsFlag_))
	end)
	arg_3_0.maskBtn_.onClick:AddListener(function()
		arg_3_0:OnClickMask()
	end)
end

function var_0_0.OnClickOk(arg_9_0)
	if arg_9_0.gameObject_ then
		arg_9_0:RevertSeparate()

		if arg_9_0.info_.OkCallback then
			if arg_9_0.info_.ToggleCallback then
				arg_9_0.info_.ToggleCallback(arg_9_0.tipsFlag_)
			end

			if arg_9_0.info_.Param then
				arg_9_0.info_.OkCallback(arg_9_0.info_.Param)
			else
				arg_9_0.info_.OkCallback()
			end
		end

		arg_9_0:SetGameObjectInActive(true)
	end

	arg_9_0:CloseWindow()
end

function var_0_0.OnClickCancel(arg_10_0)
	if arg_10_0.gameObject_ then
		arg_10_0:RevertSeparate()

		if arg_10_0.info_.ButtonType == "SingleBtn" then
			if arg_10_0.info_.OkCallback then
				if arg_10_0.info_.Param then
					arg_10_0.info_.OkCallback(arg_10_0.info_.Param)
				else
					arg_10_0.info_.OkCallback()
				end
			end
		elseif arg_10_0.info_.CancelCallback then
			arg_10_0.info_.CancelCallback()
		end

		arg_10_0:SetGameObjectInActive(false)
	end

	arg_10_0:CloseWindow()
end

function var_0_0.OnRestartClick(arg_11_0)
	if arg_11_0.gameObject_ then
		arg_11_0:RevertSeparate()

		if arg_11_0.info_.RestartCallback then
			arg_11_0.info_.RestartCallback()
		end

		arg_11_0:SetGameObjectInActive(false)
	end

	arg_11_0:CloseWindow()
end

function var_0_0.OnClickMask(arg_12_0)
	if arg_12_0.info_.ButtonType == "SingleBtn" then
		return
	end

	if arg_12_0.gameObject_ then
		arg_12_0:RevertSeparate()

		if arg_12_0.info_.MaskCallback then
			arg_12_0.info_.MaskCallback()
		else
			arg_12_0:OnClickCancel()
		end

		arg_12_0:SetGameObjectInActive(false)
	end

	arg_12_0:CloseWindow()
end

function var_0_0.RemoveListeners(arg_13_0)
	arg_13_0.okBtn_.onClick:RemoveAllListeners()
	arg_13_0.cancelBtn_.onClick:RemoveAllListeners()
	arg_13_0.tipsBtn_.onClick:RemoveAllListeners()

	if arg_13_0.restartBtn_ then
		arg_13_0.restartBtn_.onClick:RemoveAllListeners()
	end
end

function var_0_0.IsFree(arg_14_0)
	return arg_14_0.isFree_
end

function var_0_0.SetData(arg_15_0, arg_15_1)
	arg_15_0.info_ = arg_15_1
	arg_15_0.isFree_ = false

	manager.notify:Invoke(SHOW_MESSAGE_BOX)
	SetActive(arg_15_0.gameObject_, true)

	if arg_15_1.isTop then
		arg_15_0.transform_:SetParent(manager.ui.uiTips.transform, false)
		arg_15_0.transform_:SetAsLastSibling()
	else
		arg_15_0.transform_:SetParent(manager.ui.uiMessage.transform, false)
	end

	arg_15_0.singleController_:SetSelectedState(arg_15_1.ButtonType == "SingleBtn" and "true" or "false")

	if arg_15_0.info_.BtnText then
		arg_15_0.leftBtnTxt_.text = arg_15_0.info_.BtnText[2] or GetTips("CANCEL")
		arg_15_0.rightBtnTxt_.text = arg_15_0.info_.BtnText[3] or GetTips("CONFIRM")
	else
		arg_15_0.leftBtnTxt_.text = GetTips("CANCEL")
		arg_15_0.rightBtnTxt_.text = GetTips("CONFIRM")
	end

	if type(arg_15_1.content) == "table" then
		arg_15_0.typeController_:SetSelectedState("consume")
		arg_15_0:ShowItemBox()
	else
		arg_15_0.typeController_:SetSelectedState("tip")
		arg_15_0:ShowNormalBox()
	end

	if arg_15_1.toggleText then
		arg_15_0.toggleTxt_.text = arg_15_1.toggleText
	end

	local var_15_0 = arg_15_0.info_.ToggleCallback ~= nil

	SetActive(arg_15_0.tipsGo_, var_15_0)

	if var_15_0 then
		SetActive(arg_15_0.secondTextGo_, false)
	elseif arg_15_0.info_.SecondTip then
		SetActive(arg_15_0.secondTextGo_, true)

		arg_15_0.secondText_.text = arg_15_0.info_.SecondTip

		if arg_15_0.info_.SecondValue then
			SetActive(arg_15_0.secondValueGo_, true)

			arg_15_0.secondValueText_.text = arg_15_0.info_.SecondValue
		else
			SetActive(arg_15_0.secondValueGo_, false)
		end
	else
		SetActive(arg_15_0.secondTextGo_, false)
	end
end

function var_0_0.SetGaussionBg(arg_16_0)
	if not manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(true)

		arg_16_0.separateFlag_ = true
	end

	return true
end

function var_0_0.ShowNormalBox(arg_17_0)
	arg_17_0:SetGaussionBg()

	arg_17_0.tipContent_.text = arg_17_0.info_.content or ""
end

function var_0_0.ShowItemBox(arg_18_0)
	local var_18_0 = arg_18_0.consumeBox_.transform.childCount

	for iter_18_0 = 0, var_18_0 - 1 do
		arg_18_0.consumeBox_.transform:GetChild(iter_18_0).gameObject:SetActive(false)
	end

	arg_18_0.panelTrs_ = arg_18_0.consumeBox_.transform:Find("typePanelMiddle")

	if arg_18_0:GetIsFrontShow() then
		arg_18_0.panelTrs_ = arg_18_0.consumeBox_.transform:Find("typePanelFront")
	elseif arg_18_0:GetIsMiddleShow() then
		arg_18_0.panelTrs_ = arg_18_0.consumeBox_.transform:Find("typePanelMiddle")
	else
		arg_18_0.panelTrs_ = arg_18_0.consumeBox_.transform:Find("typePanelBehind")
	end

	arg_18_0.panelTrs_.gameObject:SetActive(true)

	arg_18_0.frontTrs_ = arg_18_0.panelTrs_:Find("frontText")
	arg_18_0.cntTrs_ = arg_18_0.panelTrs_:Find("cntText")
	arg_18_0.behindTrs_ = arg_18_0.panelTrs_:Find("behindText")
	arg_18_0.frontText_ = arg_18_0.frontTrs_:GetComponent("Text")
	arg_18_0.sonsumeIcon_ = arg_18_0.panelTrs_:Find("icon"):GetComponent("Image")
	arg_18_0.cntText_ = arg_18_0.cntTrs_:GetComponent("Text")
	arg_18_0.behindText_ = arg_18_0.behindTrs_:GetComponent("Text")

	arg_18_0:SetGaussionBg()

	local var_18_1 = arg_18_0.info_.content

	arg_18_0.frontText_.text = var_18_1[1]
	arg_18_0.sonsumeIcon_.sprite = var_0_1.getItemSprite(var_18_1[2][1])
	arg_18_0.cntText_.text = var_18_1[2][2]
	arg_18_0.behindText_.text = var_18_1[3]

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.frontTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.cntTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.behindTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.panelTrs_)
end

function var_0_0.Hide(arg_19_0)
	if arg_19_0.gameObject_ then
		arg_19_0:SetGameObjectInActive()
	end

	arg_19_0:RevertSeparate()
	arg_19_0:CloseWindow()
end

function var_0_0.CloseWindow(arg_20_0)
	arg_20_0.isFree_ = true
end

function var_0_0.RevertSeparate(arg_21_0)
	if arg_21_0.separateFlag_ then
		manager.ui:SetUISeparateRender(false)

		arg_21_0.separateFlag_ = false
	end
end

function var_0_0.SetGameObjectInActive(arg_22_0, arg_22_1)
	if arg_22_1 then
		function arg_22_0.info_.ToggleCallback()
			return
		end

		manager.notify:Invoke(CLOSE_MESSAGE_BOX)
	end

	arg_22_0.tipsFlag_ = false

	arg_22_0.tipsController_:SetSelectedState(tostring(arg_22_0.tipsFlag_))
	SetActive(arg_22_0.gameObject_, false)
end

function var_0_0.GetIsFrontShow(arg_24_0)
	return arg_24_0:CheckLanguage({
		"kr",
		"jp"
	})
end

function var_0_0.GetIsMiddleShow(arg_25_0)
	return arg_25_0:CheckLanguage({
		"en",
		"zh_cn",
		"tc",
		"de",
		"fr"
	})
end

function var_0_0.GetIsBehindShow(arg_26_0)
	return false
end

function var_0_0.CheckLanguage(arg_27_0, arg_27_1)
	local var_27_0 = SettingData:GetSettingData()

	return table.indexof(arg_27_1, var_27_0.sound.text_language)
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0:RemoveListeners()
	Object.Destroy(arg_28_0.gameObject_)

	arg_28_0.transform_ = nil
	arg_28_0.gameObject_ = nil
end

return var_0_0
