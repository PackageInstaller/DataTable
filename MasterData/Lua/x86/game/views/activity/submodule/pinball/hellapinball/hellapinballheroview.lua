local HellaPinballHeroView = class("HellaPinballHeroView", ReduxView)

function HellaPinballHeroView:UIName()
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_HeroUI"
end

function HellaPinballHeroView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaPinballHeroView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddUIListener()
end

function HellaPinballHeroView:InitUI()
	self.activeSkillUIList_ = LuaList.New(handler(self, self.OnCreateActiveSkillItem), self.activeSkillListGo_, HellaPinballActiveSkillItem)
	self.passiveSkillUIList_ = LuaList.New(handler(self, self.OnCreatePassiveSkillItem), self.passiveSkillListGo_, HellaPinballPassiveSkillItem)
end

function HellaPinballHeroView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		SetActive(self.maskBtn_.gameObject, false)

		for iter_6_0, iter_6_1 in ipairs(self.passiveSkillUIList_:GetItemList()) do
			iter_6_1:SetSelectedState("off")
		end
	end)
end

function HellaPinballHeroView:OnEnter()
	self.selectRole_ = self.params_.roleID
	self.selectTypeTab_ = 1

	self:UpdateData()
	self:RefreshUI()
end

function HellaPinballHeroView:UpdateData()
	self.activityID_ = PinballData:GetActivityID()
	self.level_ = PinballData:GetRoleLevel(self.selectRole_)
	self.currentHp_ = PinballTools.CalcRoleProp(self.selectRole_, 1)
	self.currentAtk_ = PinballTools.CalcRoleProp(self.selectRole_, 2)
	self.maxHp_ = PinballData:GetRoleMaxAttributes(self.selectRole_)[1]
	self.maxAtk_ = PinballData:GetRoleMaxAttributes(self.selectRole_)[2]
	self.activeSkillList_ = PinballSkillCfg.get_id_list_by_activity_id_skill_type[self.activityID_][1]
	self.passiveSkillList_ = PinballData:GetPassiveSkillList()

	self.activeSkillUIList_:StartScroll(#self.activeSkillList_)
	self.passiveSkillUIList_:StartScroll(#self.passiveSkillList_)
end

function HellaPinballHeroView:RefreshUI()
	self.levelText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), self.level_)
	self.hpText_.text = self.currentHp_
	self.atkText_.text = self.currentAtk_
	self.hpSlider_.value = 1
	self.atkSlider_.value = 1
	self.equipNumText_.text = ((#PinballData:GetEquipedActiveSkill() == 2 or nil) and "<color=#C5AE65>") .. #PinballData:GetEquipedActiveSkill() .. "/2</color>"
end

function HellaPinballHeroView:OnCreateActiveSkillItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, self.activeSkillList_[arg_10_1])
end

function HellaPinballHeroView:OnCreatePassiveSkillItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, self.passiveSkillList_[arg_11_1])
	arg_11_2:SetClickCallBack(handler(self, self.OnClickPassiveSkill))
end

function HellaPinballHeroView:OnClickPassiveSkill(arg_12_1)
	SetActive(self.maskBtn_.gameObject, true)

	self.selectPassiveSkillIndex_ = arg_12_1
end

function HellaPinballHeroView:OnTop()
	self:UpdateBar()
end

function HellaPinballHeroView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
		PinballBridge.PlayTimelineWithCallBack("skill_stand_home", function()
			PinballBridge.SetPlayerAniState("home_stand")
		end)
	end)
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("PINBALLGAME_GAME_ENTRANCE_TITLE")
		})
	end)
end

function HellaPinballHeroView:OnHellaPinballEquipSkill()
	for iter_18_0, iter_18_1 in ipairs(self.activeSkillUIList_:GetItemList()) do
		iter_18_1:UpdateData()
		iter_18_1:RefreshUI()
	end

	self:RefreshUI()
end

function HellaPinballHeroView:OnExit()
	TimelineTools.StopAllCallBack()
	SetActive(self.maskBtn_.gameObject, false)
	manager.windowBar:HideBar()
end

function HellaPinballHeroView:Dispose()
	if self.activeSkillUIList_ then
		self.activeSkillUIList_:Dispose()

		self.activeSkillUIList_ = nil
	end

	if self.passiveSkillUIList_ then
		self.passiveSkillUIList_:Dispose()

		self.passiveSkillUIList_ = nil
	end

	self.super.Dispose(self)
	TimelineTools.StopAllCallBack()
end

return HellaPinballHeroView
