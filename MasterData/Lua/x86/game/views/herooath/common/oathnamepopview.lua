local OathNamePopView = class("OathNamePopView", ReduxView)

function OathNamePopView:UIName()
	return "Widget/System/Hero_Oath/OathCommon/HeroOathNamePopUI"
end

function OathNamePopView:UIParent()
	return manager.ui.uiPop.transform
end

function OathNamePopView:Init()
	self:InitUI()
end

local var_0_1 = 16

function OathNamePopView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
	self:GetOrAddComponent(self.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(self.nameinput_.gameObject)
	self.nameinput_.onValueChanged:AddListener(function(arg_5_0)
		self:OnValidateInput(arg_5_0)
	end)
	self:SetListener(self.nameinput_.onValueChanged)
end

function OathNamePopView:OnValidateInput(arg_6_1)
	local var_6_0, var_6_1 = textLimit(arg_6_1, var_0_1)

	if not var_6_1 then
		self.nameinput_.text = var_6_0
	end
end

function OathNamePopView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self:OnClickOkBtn()
	end)
	self:AddBtnListener(self.deleteBtn_, nil, function()
		self.nameinput_.text = ""
	end)
end

function OathNamePopView:OnClickOkBtn()
	local var_12_0, var_12_1 = OathTools.CheckNickNameCanRename(self.heroID)

	if not var_12_0 then
		ShowTipsF("WEDDING_RENAME_TIPS2", manager.time:GetLostTimeStr2(var_12_1, false, true))

		return
	end

	local var_12_2 = HeroTools.GetHeroName(self.heroID)
	local var_12_3 = self.nameinput_.text

	if self.nameinput_.text == nil or self.nameinput_.text == "" or self.nameinput_.text == HeroCfg[self.heroID].suffix then
		self:AskResetName(HeroCfg[self.heroID].suffix)

		return
	end

	if var_12_2 == self.nameinput_.text then
		ShowTips("DEFINED_SUFFIX_NOTSAME_TIP")

		return
	end

	if not nameRule(self.nameinput_.text) then
		ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

		return
	end

	WordVerifyBySDK(self.nameinput_.text, function(arg_13_0)
		if not arg_13_0 then
			ShowTips("ERROR_USER_NAME_VER_WORD")
		else
			self:AskSetName(var_12_3)
		end
	end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
end

function OathNamePopView:AskSetName(arg_14_1)
	local var_14_0, var_14_1 = OathTools.GetFormatRenameCooldownTips()

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTipsF("WEDDING_RENAME_CONFIRM_TIPS", arg_14_1, var_14_0, var_14_1),
		OkCallback = function()
			OathCollectionContentAction.SetHeroNickName(self.heroID, arg_14_1)
		end
	})
end

function OathNamePopView:AskResetName(arg_16_1)
	local var_16_0, var_16_1 = OathTools.GetFormatRenameCooldownTips()

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTipsF("WEDDING_RENAME_DEFAULT_TIPS", arg_16_1, var_16_0, var_16_1),
		OkCallback = function()
			OathCollectionContentAction.SetHeroNickName(self.heroID, "")
		end
	})
end

function OathNamePopView:OnChangeOathNickname(arg_18_1)
	ShowTips("SUCCESS_CHANGE_NAME")
	JumpTools.Back()
end

function OathNamePopView:OnEnter()
	self.heroID = self.params_.heroID

	self:RegistEventListener(OATH_CHANGE_NAME, handler(self, self.OnChangeOathNickname))

	self.nameinput_.text = OathCollectionContentData:GetOathCustomNickName(self.params_.heroID) or ""
	self.prevName_.text = HeroCfg[self.params_.heroID].suffix

	local var_19_0, var_19_1 = OathTools.CheckNickNameCanRename(self.params_.heroID)

	if var_19_0 then
		local var_19_2, var_19_3 = OathTools.GetFormatRenameCooldownTips()

		self.renameTips_.text = GetTipsF("WEDDING_RENAME_TIPS1", var_19_2, var_19_3)
	else
		self.renameTips_.text = GetTipsF("WEDDING_RENAME_TIPS2", manager.time:GetLostTimeStr2(var_19_1, false, true))
	end
end

function OathNamePopView:OnTop()
	self:RefreshBar()
end

function OathNamePopView:RefreshBar()
	manager.windowBar:SwitchBar({})
end

function OathNamePopView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function OathNamePopView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return OathNamePopView
