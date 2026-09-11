local SeaWarfareSkillItem = class("SeaWarfareSkillItem", ReduxView)

function SeaWarfareSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SeaWarfareSkillItem:Init()
	self:InitUI()
	self:AddListeners()
end

function SeaWarfareSkillItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.recommentController_ = self.controllerEx_:GetController("recommend")
end

function SeaWarfareSkillItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			ShowTips("GOON_STORY_TO_GET")

			return
		end

		self.clickCallback_(self.skillID_)
	end)
end

function SeaWarfareSkillItem:SetData(arg_6_1)
	self.skillID_ = arg_6_1
	self.isLock_ = SeaWarfareTools.IsSkillLock(self.skillID_)
	self.isFirstUnLock_ = SeaWarfareTools.IsSkillFirstUnlock(self.skillID_)

	if self.isFirstUnLock_ then
		SeaWarfareTools.SetSkillFirstUnlockMark(self.skillID_)
	end

	if self.isLock_ then
		self.lockController_:SetSelectedState("on")
	elseif self.isFirstUnLock_ then
		self.lockController_:SetSelectedState("on")
	else
		self.lockController_:SetSelectedState("off")
	end

	if not self.isLock_ then
		self:RefreshUI()
	end

	self:ResetAnim()
	self:PlayAnim()
end

function SeaWarfareSkillItem:SetSelect(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "on" or "off")
end

function SeaWarfareSkillItem:RefreshLock()
	self.isLock_ = SeaWarfareTools.IsSkillLock(self.skillID_)

	self.lockController_:SetSelectedState(self.isLock_ and "on" or "off")
end

function SeaWarfareSkillItem:SetRecommend(arg_9_1)
	self.recommentController_:SetSelectedState(arg_9_1 and not self.isLock_ and "on" or "off")
end

function SeaWarfareSkillItem:SetClickCallback(arg_10_1)
	self.clickCallback_ = arg_10_1
end

function SeaWarfareSkillItem:RefreshUI()
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay_QuanZhou/QuanZhou_Navigation/" .. SeaWarfareSkillCfg[self.skillID_].icon)
	self.title_.text = SeaWarfareSkillCfg[self.skillID_].tag
end

function SeaWarfareSkillItem:GetSKillID()
	return self.skillID_
end

function SeaWarfareSkillItem:PlayAnim()
	if self.isFirstUnLock_ then
		return
	end

	if not self.isLock_ then
		self:PlayEnterAnim()
	end
end

function SeaWarfareSkillItem:PlayEnterAnim()
	self.enterAnimtimer_ = SeaWarfareTools.PlayAnim(self.enterAnim_, "UI_namebg")
end

function SeaWarfareSkillItem:PlayFirstUnlockAnim()
	if self.isFirstUnLock_ then
		self.isFirstUnLock_ = false

		self.lockController_:SetSelectedState("off")

		self.unlockAnimtimer_ = SeaWarfareTools.PlayAnim(self.unlockAnim_, "UI_QuanZhou_Navigation_Skill_Unlock")
	end
end

function SeaWarfareSkillItem:ResetAnim()
	self.enterAnim_.enabled = false

	if self.enterAnimtimer_ then
		self.enterAnimtimer_:Stop()

		self.enterAnimtimer_ = nil
	end

	self.unlockAnim_.enabled = false

	SetActive(self.particleGo_, false)

	if self.unlockAnimtimer_ then
		self.unlockAnimtimer_:Stop()

		self.unlockAnimtimer_ = nil
	end
end

return SeaWarfareSkillItem
