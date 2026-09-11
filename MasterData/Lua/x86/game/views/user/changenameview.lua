local ChangeNameView = class("ChangeNameView", ReduxView)

function ChangeNameView:UIName()
	return "Widget/System/UserInfor/PopupChangeNameUI"
end

function ChangeNameView:UIParent()
	return manager.ui.uiPop.transform
end

function ChangeNameView:InitUI()
	self:BindCfgUI()
	self:GetOrAddComponent(self.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(self.nameinput_.gameObject)

	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD)
	self.typeCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("type")
end

function ChangeNameView:_onValidateInput(arg_4_1, arg_4_2)
	if #self >= 24 then
		return 0
	end

	return arg_4_2
end

function ChangeNameView:AddUIListener()
	self:AddBtnListener(self.cancelbtnBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.iconBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD
		})
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		if self.costType_ == 1 and self.cardHave <= 0 then
			ShowTips("NAME_CHANGE_CARD_INSUFFICIENT_TIPS")

			return
		end

		local var_9_0 = PlayerData:GetPlayerInfo().nick

		if self.nameinput_.text == "" then
			ShowTips("ERROR_USER_NAME_TOO_SHORT")

			return
		end

		if var_9_0 == self.nameinput_.text then
			ShowTips("NAME_CANNOT_SAME_CURRENT")

			return
		end

		local var_9_1, var_9_2 = textLimit(self.nameinput_.text, 16)

		self.nameinput_.text = var_9_1

		local var_9_3 = var_9_1

		if not OperationData:IsOperationOpen(OperationConst.CHANGE_NICK) then
			ShowTips("OPERATION_DISABLED")

			return
		end

		if not nameRule(var_9_1) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(var_9_1, function(arg_10_0)
			if not arg_10_0 then
				ShowTips("ERROR_USER_NAME_VER_WORD")
			else
				if not var_9_2 then
					return
				end

				if self.costType_ == 1 then
					ShowMessageBox({
						content = string.format(GetTips("NAME_CHANGE_CARD_WHETHER_TIPS"), var_9_3),
						OkCallback = function()
							PlayerAction.ChangeNickname(var_9_3, self.costType_)
						end,
						CancelCallback = function()
							return
						end
					})
				else
					PlayerAction.ChangeNickname(var_9_3, self.costType_)
				end
			end
		end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
	end)
end

function ChangeNameView:OnChangeNickname(arg_13_1)
	ShowTips("SUCCESS_CHANGE_NAME")
	JumpTools.Back()
end

function ChangeNameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChangeNameView:OnEnter()
	self.nameinput_.text = ""
	self.costType_ = 1
	self.tip_.text = PlayerData:GetExtraChangeNickTime() <= 0 and GetTips("TIPS_REVISENAME_ONE") or GetTips("TIPS_REVISENAME_FREE")

	if PlayerData:GetPlayerInfo().is_changed_nick == 2 and PlayerData:GetExtraChangeNickTime() <= 0 then
		self.costType_ = 1

		self.typeCon_:SetSelectedState("card")

		self.cardHave = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD)
		self.num_.text = self.cardHave > 0 and self.cardHave .. "/" .. 1 or "<color=#FF0000>" .. self.cardHave .. "</color>" .. "/" .. 1
	else
		self.costType_ = 2

		self.typeCon_:SetSelectedState("free")

		self.tip_.text = GetTips("TIPS_REVISENAME_FREE")
	end
end

function ChangeNameView:OnExit()
	return
end

function ChangeNameView:Dispose()
	self:RemoveAllListeners()
	self.nameinput_.onValueChanged:RemoveAllListeners()
	ChangeNameView.super.Dispose(self)
end

return ChangeNameView
