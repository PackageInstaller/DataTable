local MomoTalkChoiceView = class("MomoTalkChoiceView", ReduxView)

function MomoTalkChoiceView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.choiceBtns_ = {
		self.choice1Btn_,
		self.choice2Btn_,
		self.choice3Btn_,
		self.choice4Btn_
	}
	self.choiceTexts_ = {
		self.choice1Text_,
		self.choice2Text_,
		self.choice3Text_,
		self.choice4Text_
	}

	self:AddListeners()
end

function MomoTalkChoiceView:AddListeners()
	for iter_2_0, iter_2_1 in ipairs(self.choiceBtns_ or {}) do
		if iter_2_1 then
			self:AddBtnListener(iter_2_1, nil, function()
				manager.notify:Invoke(MOMOTALK_CHOICE_SELECTED, iter_2_0)
			end)
		end
	end
end

function MomoTalkChoiceView:GetDisplayOptions(arg_4_1)
	local var_4_0 = {}

	for iter_4_0 = 1, math.min(#(arg_4_1 or {}), #(self.choiceBtns_ or {})) do
		var_4_0[iter_4_0] = arg_4_1[iter_4_0]
	end

	return var_4_0
end

function MomoTalkChoiceView:RefreshButtons(arg_5_1)
	local var_5_0 = self:GetDisplayOptions(arg_5_1)

	for iter_5_0, iter_5_1 in ipairs(self.choiceBtns_ or {}) do
		if iter_5_1 then
			local var_5_1 = var_5_0[iter_5_0]
			local var_5_2 = self.choiceTexts_[iter_5_0]

			SetActive(iter_5_1.gameObject, var_5_0[iter_5_0] ~= nil)

			if var_5_2 then
				var_5_2.text = var_5_1 and ChatContentCfg[var_5_1] and GetI18NText(ChatContentCfg[var_5_1].content or "") or ""
			end
		end
	end

	return var_5_0
end

function MomoTalkChoiceView:Show(arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = ChatContentCfg[arg_6_1.id]

	if not ChatContentCfg[arg_6_1.id] or not var_6_0.options or #var_6_0.options == 0 then
		return
	end

	self.currentItem_ = arg_6_1
	self.currentOptions_ = self:RefreshButtons(var_6_0.options)
	self.isShowing_ = true
end

function MomoTalkChoiceView:Hide()
	self.isShowing_ = false
	self.currentItem_ = nil
	self.currentOptions_ = nil

	self:RefreshButtons(nil)
end

function MomoTalkChoiceView:IsShowing()
	return self.isShowing_ == true
end

function MomoTalkChoiceView:GetCurrentItem()
	return self.currentItem_
end

function MomoTalkChoiceView:GetCurrentOptions()
	return self.currentOptions_
end

function MomoTalkChoiceView:Dispose()
	MomoTalkChoiceView.super.Dispose(self)
end

return MomoTalkChoiceView
