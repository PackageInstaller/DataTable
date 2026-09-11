local BloodCardChangeNamePopView = class("BloodCardChangeNamePopView", ReduxView)

function BloodCardChangeNamePopView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardNameInputPopUI"
end

function BloodCardChangeNamePopView:UIParent()
	return manager.ui.uiPop.transform
end

function BloodCardChangeNamePopView:InitUI()
	self:BindCfgUI()
	self:GetOrAddComponent(self.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(self.nameinput_.gameObject)
end

function BloodCardChangeNamePopView:_onValidateInput(arg_4_1, arg_4_2)
	if #self >= 24 then
		return 0
	end

	return arg_4_2
end

function BloodCardChangeNamePopView:AddUIListener()
	self:AddBtnListener(self.cancelbtnBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		local var_8_0 = PlayerData:GetPlayerInfo().nick

		if self.nameinput_.text == "" then
			ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARDSET_NAME_TOO_SHORT")

			return
		end

		local var_8_1, var_8_2 = textLimit(self.nameinput_.text, 16)

		self.nameinput_.text = var_8_1

		local var_8_3 = var_8_1

		if not nameRule(var_8_1) then
			return ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARDSET_NAME_SYMBOL_WORD")
		end

		WordVerifyBySDK(var_8_1, function(arg_9_0)
			if not arg_9_0 then
				ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARDSET_NAME_VER_WORD")
			else
				if not var_8_2 then
					return
				end

				BloodCardAction.SendSaveCardGroup(self.activityID_, self.selectTabIndex_, self.selectGroupCardIDList_, var_8_3, function()
					ShowTips(GetTips("ACTIVITY_BLOOD_CARD_GAME_SAVE_CARDSET_SUCCESS"))
				end)
				self:Back()
			end
		end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
	end)
end

function BloodCardChangeNamePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BloodCardChangeNamePopView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.selectTabIndex_ = self.params_.selectTabIndex
	self.selectGroupCardIDList_ = self.params_.selectGroupCardIDList
	self.nameinput_.text = BloodCardData:GetCardGroupName(self.selectTabIndex_)
end

function BloodCardChangeNamePopView:OnExit()
	return
end

function BloodCardChangeNamePopView:Dispose()
	self:RemoveAllListeners()
	self.nameinput_.onValueChanged:RemoveAllListeners()
	BloodCardChangeNamePopView.super.Dispose(self)
end

return BloodCardChangeNamePopView
