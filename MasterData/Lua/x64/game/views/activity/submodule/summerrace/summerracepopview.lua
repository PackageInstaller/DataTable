local SummerRacePopView = class("SummerRacePopView", ReduxView)

function SummerRacePopView:UIName()
	return "Widget/System/Activity_SummerRace/com/Activity_SummerRace_PopUI"
end

function SummerRacePopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRacePopView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function SummerRacePopView:AddUIListener()
	if self.cancelBtn_ then
		self:AddBtnListener(self.cancelBtn_, nil, function()
			self:CloseWithCancel()
		end)
	end

	if self.okBtn_ then
		self:AddBtnListener(self.okBtn_, nil, function()
			if self.okCb_ then
				self.okCb_()
			end
		end)
	end
end

function SummerRacePopView:CloseWithCancel()
	if self.isClosing_ then
		return
	end

	self.isClosing_ = true

	if self.cancelCb_ then
		self.cancelCb_()
	end

	self:Back()
end

function SummerRacePopView:EnsureWindowBar()
	self.windowBarBackHandler_ = self.windowBarBackHandler_ or function()
		self:CloseWithCancel()
	end

	if manager ~= nil and manager.windowBar ~= nil then
		manager.windowBar:PushWindowBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(self.windowBarBackHandler_)

		self.windowBarPushed_ = true
	end
end

function SummerRacePopView:CleanupWindowBar()
	if manager == nil or manager.windowBar == nil then
		self.windowBarPushed_ = false

		return
	end

	if self.windowBarPushed_ then
		self.windowBarPushed_ = false

		manager.windowBar:PopWindowBar()
	elseif self.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == self.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

function SummerRacePopView:OnEnter()
	self.okCb_ = nil
	self.cancelCb_ = nil
	self.closeCb_ = nil
	self.isClosing_ = false

	if self.params_ ~= nil then
		self.okCb_ = self.params_.okCb
		self.cancelCb_ = self.params_.cancelCb
		self.closeCb_ = self.params_.closeCb
	end

	if self.titleText_ then
		local var_11_0 = GetTips("PROMPT")

		if self.params_ ~= nil and self.params_.title ~= nil then
			self.titleText_.text = self.params_.title
		end
	end

	if self.tipContent_ then
		if self.params_ ~= nil and self.params_.content ~= nil then
			self.tipContent_.text = self.params_.content
		end
	end

	if self.confirmText_ then
		local var_11_2 = GetTips("CONFIRM")

		if self.params_ ~= nil and self.params_.confirmText ~= nil then
			self.confirmText_.text = self.params_.confirmText
		end
	end

	if self.cancelText_ then
		local var_11_3 = GetTips("CANCEL")

		if self.params_ ~= nil and self.params_.cancelText ~= nil then
			self.cancelText_.text = self.params_.cancelText
		end
	end

	self:EnsureWindowBar()
end

function SummerRacePopView:OnExit()
	self:CleanupWindowBar()

	if self.closeCb_ then
		self.closeCb_()
	end

	self.okCb_ = nil
	self.cancelCb_ = nil
	self.closeCb_ = nil
	self.isClosing_ = false
end

return SummerRacePopView
