local SummerPubToTaskDialogPopView = class("SummerPubToTaskDialogPopView", ReduxView)

function SummerPubToTaskDialogPopView:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_DialoguePopUI"
end

function SummerPubToTaskDialogPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerPubToTaskDialogPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function SummerPubToTaskDialogPopView:InitUI()
	self:BindCfgUI()

	self.typeWritter = self.talkText_.transform:GetComponent("UITypewriterEffect")
end

function SummerPubToTaskDialogPopView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.typeWritter.percent >= 1 then
			self:Back()

			if self.callback_ then
				self.callback_()
			end
		end
	end)
end

function SummerPubToTaskDialogPopView:OnEnter()
	self.callback_ = self.params_.callback
	self.cfg_ = self.params_.cfg

	self:UpdateText()
end

function SummerPubToTaskDialogPopView:OnTop()
	manager.windowBar:HideBar()
end

function SummerPubToTaskDialogPopView:UpdateText()
	SetActive(self.buttonTextGo_, false)

	self.talkText_.text = self.cfg_.inter_CG_text or "##"

	local var_9_0 = utf8len(self.talkText_.text) / (GameSetting.nya_summer_taste_typespeed.value[1] or 20)
	local var_9_1 = 0
	local var_9_2 = 0

	self.timer = Timer.New(function()
		var_9_1 = var_9_1 + 0.01
		var_9_2 = Mathf.Lerp(0, 1, var_9_1 / var_9_0)

		if self.typeWritter.percent < var_9_2 then
			self.typeWritter.percent = var_9_2

			self.typeWritter:SetDirty()
		end

		if var_9_1 >= var_9_0 then
			SetActive(self.buttonTextGo_, true)

			if self.timer then
				self.timer:Stop()

				self.timer = nil
			end
		end
	end, 0.01, -1)

	self.timer:Start()
end

function SummerPubToTaskDialogPopView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function SummerPubToTaskDialogPopView:OnExit()
	self:StopTimer()
	self.super.OnExit(self)

	self.typeWritter.percent = 0

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	SummerPubTool:OnLogout()
end

function SummerPubToTaskDialogPopView:Dispose()
	SummerPubToTaskDialogPopView.super.Dispose(self)
end

return SummerPubToTaskDialogPopView
