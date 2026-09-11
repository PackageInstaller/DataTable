local MessageBoxItem = class("MessageBoxItem")
local ItemTools = import("game.tools.ItemTools")
local JumpTools = import("game.tools.JumpTools")

function MessageBoxItem:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(arg_1_1, manager.ui.uiMessage.transform)
	self.transform_ = self.gameObject_.transform
	self.isFree_ = true

	self:InitUI()
	self:AddListeners()
end

function MessageBoxItem:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.typeController_ = self.controllerEx_:GetController("type")
	self.singleController_ = self.controllerEx_:GetController("single")
	self.tipsController_ = self.controllerEx_:GetController("tips")
end

function MessageBoxItem:AddListeners()
	self.okBtn_.onClick:AddListener(function()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "okBtn")
		self:OnClickOk()
	end)
	self.cancelBtn_.onClick:AddListener(function()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "cancelBtn")
		self:OnClickCancel()
	end)

	if self.restartBtn_ then
		self.restartBtn_.onClick:AddListener(function()
			self:OnRestartClick()
		end)
	end

	self.tipsBtn_.onClick:AddListener(function()
		self.tipsFlag_ = not self.tipsFlag_

		self.tipsController_:SetSelectedState(tostring(self.tipsFlag_))
	end)
	self.maskBtn_.onClick:AddListener(function()
		self:OnClickMask()
	end)
end

function MessageBoxItem:OnClickOk()
	if self.gameObject_ then
		self:RevertSeparate()

		if self.info_.OkCallback then
			if self.info_.ToggleCallback then
				self.info_.ToggleCallback(self.tipsFlag_)
			end

			if self.info_.Param then
				self.info_.OkCallback(self.info_.Param)
			else
				self.info_.OkCallback()
			end
		end

		self:SetGameObjectInActive(true)
	end

	self:CloseWindow()
end

function MessageBoxItem:OnClickCancel()
	if self.gameObject_ then
		self:RevertSeparate()

		if self.info_.ButtonType == "SingleBtn" then
			if self.info_.OkCallback then
				if self.info_.Param then
					self.info_.OkCallback(self.info_.Param)
				else
					self.info_.OkCallback()
				end
			end
		elseif self.info_.CancelCallback then
			self.info_.CancelCallback()
		end

		self:SetGameObjectInActive(false)
	end

	self:CloseWindow()
end

function MessageBoxItem:OnRestartClick()
	if self.gameObject_ then
		self:RevertSeparate()

		if self.info_.RestartCallback then
			self.info_.RestartCallback()
		end

		self:SetGameObjectInActive(false)
	end

	self:CloseWindow()
end

function MessageBoxItem:OnClickMask()
	if self.info_.ButtonType == "SingleBtn" then
		return
	end

	if self.gameObject_ then
		self:RevertSeparate()

		if self.info_.MaskCallback then
			self.info_.MaskCallback()
		else
			self:OnClickCancel()
		end

		self:SetGameObjectInActive(false)
	end

	self:CloseWindow()
end

function MessageBoxItem:RemoveListeners()
	self.okBtn_.onClick:RemoveAllListeners()
	self.cancelBtn_.onClick:RemoveAllListeners()
	self.tipsBtn_.onClick:RemoveAllListeners()

	if self.restartBtn_ then
		self.restartBtn_.onClick:RemoveAllListeners()
	end
end

function MessageBoxItem:IsFree()
	return self.isFree_
end

function MessageBoxItem:SetData(arg_15_1)
	self.info_ = arg_15_1
	self.isFree_ = false

	manager.notify:Invoke(SHOW_MESSAGE_BOX)
	SetActive(self.gameObject_, true)

	if arg_15_1.isTop then
		self.transform_:SetParent(manager.ui.uiTips.transform, false)
		self.transform_:SetAsLastSibling()
	else
		self.transform_:SetParent(manager.ui.uiMessage.transform, false)
	end

	self.singleController_:SetSelectedState(arg_15_1.ButtonType == "SingleBtn" and "true" or "false")

	if self.info_.BtnText then
		self.leftBtnTxt_.text = self.info_.BtnText[2] or GetTips("CANCEL")
		self.rightBtnTxt_.text = self.info_.BtnText[3] or GetTips("CONFIRM")
	else
		self.leftBtnTxt_.text = GetTips("CANCEL")
		self.rightBtnTxt_.text = GetTips("CONFIRM")
	end

	if type(arg_15_1.content) == "table" then
		self.typeController_:SetSelectedState("consume")
		self:ShowItemBox()
	else
		self.typeController_:SetSelectedState("tip")
		self:ShowNormalBox()
	end

	if arg_15_1.toggleText then
		self.toggleTxt_.text = arg_15_1.toggleText
	end

	local var_15_0 = self.info_.ToggleCallback ~= nil

	SetActive(self.tipsGo_, self.info_.ToggleCallback ~= nil)

	if var_15_0 then
		SetActive(self.secondTextGo_, false)
	elseif self.info_.SecondTip then
		SetActive(self.secondTextGo_, true)

		self.secondText_.text = self.info_.SecondTip

		if self.info_.SecondValue then
			SetActive(self.secondValueGo_, true)

			self.secondValueText_.text = self.info_.SecondValue
		else
			SetActive(self.secondValueGo_, false)
		end
	else
		SetActive(self.secondTextGo_, false)
	end
end

function MessageBoxItem:SetGaussionBg()
	if not manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(true)

		self.separateFlag_ = true
	end

	return true
end

function MessageBoxItem:ShowNormalBox()
	self:SetGaussionBg()

	self.tipContent_.text = self.info_.content or ""
end

function MessageBoxItem:ShowItemBox()
	for iter_18_0 = 0, self.consumeBox_.transform.childCount - 1 do
		self.consumeBox_.transform:GetChild(iter_18_0).gameObject:SetActive(false)
	end

	self.panelTrs_ = self.consumeBox_.transform:Find("typePanelMiddle")
	self.panelTrs_ = self:GetIsFrontShow() and self.consumeBox_.transform:Find("typePanelFront") or self:GetIsMiddleShow() and self.consumeBox_.transform:Find("typePanelMiddle") or self.consumeBox_.transform:Find("typePanelBehind")

	self.panelTrs_.gameObject:SetActive(true)

	self.frontTrs_ = self.panelTrs_:Find("frontText")
	self.cntTrs_ = self.panelTrs_:Find("cntText")
	self.behindTrs_ = self.panelTrs_:Find("behindText")
	self.frontText_ = self.frontTrs_:GetComponent("Text")
	self.sonsumeIcon_ = self.panelTrs_:Find("icon"):GetComponent("Image")
	self.cntText_ = self.cntTrs_:GetComponent("Text")
	self.behindText_ = self.behindTrs_:GetComponent("Text")

	self:SetGaussionBg()

	self.frontText_.text = self.info_.content[1]
	self.sonsumeIcon_.sprite = ItemTools.getItemSprite(self.info_.content[2][1])
	self.cntText_.text = self.info_.content[2][2]
	self.behindText_.text = self.info_.content[3]

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.frontTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.cntTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.behindTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.panelTrs_)
end

function MessageBoxItem:Hide()
	if self.gameObject_ then
		self:SetGameObjectInActive()
	end

	self:RevertSeparate()
	self:CloseWindow()
end

function MessageBoxItem:CloseWindow()
	self.isFree_ = true
end

function MessageBoxItem:RevertSeparate()
	if self.separateFlag_ then
		manager.ui:SetUISeparateRender(false)

		self.separateFlag_ = false
	end
end

function MessageBoxItem:SetGameObjectInActive(arg_22_1)
	if arg_22_1 then
		function self.info_.ToggleCallback()
			return
		end

		manager.notify:Invoke(CLOSE_MESSAGE_BOX)
	end

	self.tipsFlag_ = false

	self.tipsController_:SetSelectedState(tostring(self.tipsFlag_))
	SetActive(self.gameObject_, false)
end

function MessageBoxItem:GetIsFrontShow()
	return self:CheckLanguage({
		"kr",
		"jp"
	})
end

function MessageBoxItem:GetIsMiddleShow()
	return self:CheckLanguage({
		"en",
		"zh_cn",
		"tc",
		"de",
		"fr"
	})
end

function MessageBoxItem:GetIsBehindShow()
	return false
end

function MessageBoxItem:CheckLanguage(arg_27_1)
	return table.indexof(arg_27_1, SettingData:GetSettingData().sound.text_language)
end

function MessageBoxItem:Dispose()
	self:RemoveListeners()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return MessageBoxItem
