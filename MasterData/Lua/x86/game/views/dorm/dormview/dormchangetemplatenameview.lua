local DormChangeTemplateNameView = class("DormChangeTemplateNameView", ReduxView)

function DormChangeTemplateNameView:UIName()
	return "Widget/BackHouseUI/Dorm/DormPopupChangeNameUI"
end

function DormChangeTemplateNameView:UIParent()
	return manager.ui.uiPop.transform
end

function DormChangeTemplateNameView:InitUI()
	self:BindCfgUI()
	self:GetOrAddComponent(self.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(self.nameinput_.gameObject)
end

function DormChangeTemplateNameView:_onValidateInput(arg_4_1, arg_4_2)
	if #self >= 24 then
		return 0
	end

	return arg_4_2
end

function DormChangeTemplateNameView:AddUIListener()
	self:AddBtnListener(self.cancelbtnBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		local var_8_0 = self.params_.oldName or ""
		local var_8_1 = self.nameinput_.text

		if self.nameinput_.text == "" then
			ShowTips(GetTips("DORM_MOULD_NAME_NULL"))

			return
		end

		if var_8_0 == var_8_1 then
			ShowTips(GetTips("DORM_MOULD_NAME_SAME"))

			return
		end

		local var_8_2, var_8_3 = textLimit(var_8_1, GameDisplayCfg.dorm_mould_name_max.value[1])

		self.nameinput_.text = GetI18NText(var_8_2)

		local var_8_4 = var_8_2

		if not nameRule(var_8_2) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		if not var_8_3 then
			return
		end

		WordVerifyBySDK(var_8_2, function(arg_9_0)
			if not arg_9_0 then
				ShowTips("ERROR_USER_NAME_VER_WORD")
			elseif self.params_.callBack then
				self.params_.callBack(var_8_4)
			end
		end, JUDGE_MESSAGE_TYPE.DORM_TEMPLATE)
	end)
end

function DormChangeTemplateNameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormChangeTemplateNameView:RegisterEvent()
	self:RegistEventListener(DOMR_RENAME_TEMPLATE_SUCCESS, function()
		ShowTips(GetTips("DORM_MOULD_NAME_CHANGE"))
		JumpTools.Back()
	end)
end

function DormChangeTemplateNameView:OnEnter()
	self.nameinput_.text = ""
	self.placeholderText_.text = self.params_.showText or ""

	self:RegisterEvent()
end

function DormChangeTemplateNameView:OnExit()
	self:RemoveAllEventListener()
end

function DormChangeTemplateNameView:Dispose()
	self:RemoveAllListeners()
	self.nameinput_.onValueChanged:RemoveAllListeners()
	DormChangeTemplateNameView.super.Dispose(self)
end

return DormChangeTemplateNameView
