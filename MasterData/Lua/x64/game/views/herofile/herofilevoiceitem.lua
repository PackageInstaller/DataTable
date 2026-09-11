local HeroFileVoiceItem = class("HeroFileVoiceItem", ReduxView)

function HeroFileVoiceItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroFileVoiceItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroFileVoiceItem:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.voiceControllerEx_:GetController("lock")
	self.playController_ = self.voiceControllerEx_:GetController("playing")
	self.bgController = self.voiceControllerEx_:GetController("bg")
end

local var_0_1 = 8

function HeroFileVoiceItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.unlock_ = arg_4_2.unlock
	self.onClick_ = arg_4_3
	self.id_ = arg_4_2.id

	local var_4_0 = nullable(HeroVoiceCfg[arg_4_2.id], "title")

	self:SetBgState(nullable(HeroVoiceCfg[arg_4_2.id], "tag_id") == var_0_1 and "oath" or "normal")

	self.voiceNameText_.text = var_4_0

	if arg_4_2.unlock then
		self.lockController_:SetSelectedState("unlock")
	else
		self.lockController_:SetSelectedState("lock")

		self.voiceLockText_.text = self:GetLockMsg(arg_4_2, arg_4_1)
	end
end

function HeroFileVoiceItem:SetBgState(arg_5_1)
	self.bgController:SetSelectedState(arg_5_1)
end

function HeroFileVoiceItem:SetIsShow(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function HeroFileVoiceItem:GetLockMsg(arg_7_1, arg_7_2)
	if arg_7_1.lockMsg then
		return arg_7_1.lockMsg
	elseif DormHeroTools:IsVoiceNeedUnlock(arg_7_1.id, arg_7_2) then
		return string.format(GetTips("DORM_VOICE_UNLOCK_TIP"), DormHeroTools:GetVoiceUnlockLevel(arg_7_2, arg_7_1.id))
	else
		return nullable(ConditionCfg, nullable(HeroVoiceCfg, arg_7_1.id, "unlock_condition"), "desc")
	end
end

function HeroFileVoiceItem:AddUIListener()
	self:AddBtnListener(self.voiceBtn_, nil, function()
		if self.onClick_ and self.unlock_ then
			self.onClick_(self.id_)
		end
	end)
end

function HeroFileVoiceItem:StopPlay()
	self.playController_:SetSelectedState("stop")
end

function HeroFileVoiceItem:StartPlay()
	self.playController_:SetSelectedState("play")
end

function HeroFileVoiceItem:Dispose()
	HeroFileVoiceItem.super.Dispose(self)
end

return HeroFileVoiceItem
