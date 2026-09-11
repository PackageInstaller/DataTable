local GiftPopUpView = class("GiftPopUpView", ReduxView)

function GiftPopUpView:UIName()
	return "Widget/System/Main/PackexchangepopUI"
end

function GiftPopUpView:UIParent()
	return manager.ui.uiPop.transform
end

function GiftPopUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GiftPopUpView:InitUI()
	self:BindCfgUI()
	self:GetOrAddComponent(self.input_.gameObject, typeof(InputFieldHelper))
end

function GiftPopUpView:AddUIListener()
	self:AddBtnListener(self.btnCancel_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.btnOK_, nil, function()
		SettingAction.ExchangeCode(string.trim(self.input_.text), tostring(_G.TMP_CHANNELID))
	end)
end

function GiftPopUpView:OnExchangeCode(arg_9_1, arg_9_2)
	if arg_9_1 then
		ShowTips("SUCCESS_EXCHANGE_CODE")

		self.input_.text = ""
	else
		ShowTips(arg_9_2 or "UNDEFINED_ERROR")
	end
end

function GiftPopUpView:OnExit()
	self.input_.text = ""
end

function GiftPopUpView:OnExitInput()
	JumpTools.Back()

	return true
end

function GiftPopUpView:Dispose()
	self:RemoveAllListeners()
	GiftPopUpView.super.Dispose(self)
end

return GiftPopUpView
