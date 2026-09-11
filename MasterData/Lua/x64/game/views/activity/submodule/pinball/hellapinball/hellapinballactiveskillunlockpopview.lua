local HellaPinballActiveSkillUnlockPopView = class("HellaPinballActiveSkillUnlockPopView", ReduxView)

function HellaPinballActiveSkillUnlockPopView:UIName()
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_SkillUnlockUI"
end

function HellaPinballActiveSkillUnlockPopView:UIParent()
	return manager.ui.uiPop.transform
end

function HellaPinballActiveSkillUnlockPopView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddUIListener()
end

function HellaPinballActiveSkillUnlockPopView:InitUI()
	return
end

function HellaPinballActiveSkillUnlockPopView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		self:Back()
		PinballBridge.ShowBackGroundMask(true)
		JumpTools.OpenPageByJump("/pinballHero", {
			roleID = PinballData:GetRoleID()
		})
		PinballBridge.PlayTimelineWithCallBack("skill_stand", function()
			PinballBridge.SetPlayerAniState("skill_stand")
		end)
	end)
end

function HellaPinballActiveSkillUnlockPopView:OnEnter()
	self:RefreshUI()
end

function HellaPinballActiveSkillUnlockPopView:RefreshUI()
	self.skillID_ = getData("Hella_Pinball", "Unlock_Active_Skill") or -1

	if self.skillID_ > 0 then
		if PinballSkillCfg[self.skillID_] then
			self.skillIcon_.sprite = pureGetSpriteWithoutAtlas(PinballSkillCfg[self.skillID_].icon)
			self.skillNameText_.text = GetI18NText(PinballSkillCfg[self.skillID_].name)
			self.skillDescText_.text = string.format(GetI18NText(PinballSkillCfg[self.skillID_].description), unpack(PinballSkillCfg[self.skillID_].effect))
		end

		saveData("Hella_Pinball", "Unlock_Active_Skill", -1)
	end
end

function HellaPinballActiveSkillUnlockPopView:OnExit()
	return
end

function HellaPinballActiveSkillUnlockPopView:Dispose()
	HellaPinballActiveSkillUnlockPopView.super.Dispose(self)
end

return HellaPinballActiveSkillUnlockPopView
