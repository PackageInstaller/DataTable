local OathHeroUnLockPopView = class("OathHeroUnLockPopView", ReduxView)

function OathHeroUnLockPopView:UIName()
	return "Widget/System/Hero_Oath/HeroOathUnlockHeroPopUI"
end

function OathHeroUnLockPopView:UIParent()
	return manager.ui.uiPop.transform
end

function OathHeroUnLockPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OathHeroUnLockPopView:InitUI()
	self:BindCfgUI()
end

function OathHeroUnLockPopView:AddUIListener()
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
		OathTools.JumpToOathView(self.heroID)
	end)
end

function OathHeroUnLockPopView:OnEnter()
	self.heroID = self.params_.heroID

	self:RefreshUI()
end

function OathHeroUnLockPopView:RefreshUI()
	self.descText_.text = GetI18NText(WeddingCfg[self.heroID].wedding_tips)
	self.nameText_.text = HeroTools.GetHeroName(self.heroID)
	self.roleImg_.sprite = OathTools.GetOathCharacterPopSprite(self.heroID)
end

function OathHeroUnLockPopView:OnExit()
	OathSupportData:SavePopTag(self.heroID)
end

function OathHeroUnLockPopView:OnTop()
	manager.windowBar:SwitchBar({})
end

function OathHeroUnLockPopView:Dispose()
	self.super.Dispose(self)
end

return OathHeroUnLockPopView
