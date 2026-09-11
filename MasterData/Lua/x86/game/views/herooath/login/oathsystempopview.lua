local OathSystemPopView = class("OathSystemPopView", ReduxView)

function OathSystemPopView:UIName()
	return "Widget/System/Hero_Oath/HeroOathSystemPopUI"
end

function OathSystemPopView:UIParent()
	return manager.ui.uiPop.transform
end

function OathSystemPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OathSystemPopView:InitUI()
	self:BindCfgUI()
end

function OathSystemPopView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "wedding_picture_open_tip",
			source = 1,
			sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM
		})
		self:Back()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "wedding_picture_open_tip",
			source = 1,
			sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM
		})
		self:Back()
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "wedding_picture_open_tip",
			source = 2,
			sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM
		})
		self:Back()
		JumpTools.GoToSystem("/adminHomePageView", nil, ViewConst.SYSTEM_ID.ADMIN_SYSTEM)
	end)
end

function OathSystemPopView:OnEnter()
	self:RefreshUI()
end

function OathSystemPopView:RefreshUI()
	self.descText_.text = GetTips("WEDDING_SYSTEM_UNLOCK_DESC")
end

function OathSystemPopView:OnExit()
	OathSupportData:SavePopTag(OathConst.OATH_OPEN_TAG_ID)
end

function OathSystemPopView:OnTop()
	manager.windowBar:SwitchBar({})
end

function OathSystemPopView:Dispose()
	self.super.Dispose(self)
end

return OathSystemPopView
