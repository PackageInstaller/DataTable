local SeaWarfareMarinerItem = class("SeaWarfareMarinerItem", ReduxView)

function SeaWarfareMarinerItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SeaWarfareMarinerItem:Init()
	self:InitUI()
	self:AddListeners()
end

function SeaWarfareMarinerItem:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.controllerEx_:GetController("lock")
end

function SeaWarfareMarinerItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			ShowTips("GOON_STORY_TO_GET")
		end
	end)
end

function SeaWarfareMarinerItem:SetData(arg_6_1)
	self.marinerID_ = arg_6_1
	self.isLock_ = SeaWarfareTools.IsSkillLock(self.marinerID_)
	self.isFirstUnLock_ = SeaWarfareTools.IsSkillFirstUnlock(self.marinerID_)

	if self.isFirstUnLock_ then
		SeaWarfareTools.SetSkillFirstUnlockMark(self.marinerID_)
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

	SetActive(self.gameObject_, false)
	self:ResetAnim()
end

function SeaWarfareMarinerItem:RefreshLock()
	self.isLock_ = SeaWarfareTools.IsSkillLock(self.marinerID_)

	self.lockController_:SetSelectedState(self.isLock_ and "on" or "off")
end

function SeaWarfareMarinerItem:RefreshUI()
	self.icon_.sprite = getSpriteViaConfig("DormHeroHeadIcon", SeaWarfareSkillCfg[self.marinerID_].icon)
	self.bulletIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay_QuanZhou/QuanZhou_Navigation/" .. SeaWarfareSkillCfg[self.marinerID_].icon_bullet)
	self.desc_.text = SeaWarfareSkillCfg[self.marinerID_].desc
end

function SeaWarfareMarinerItem:PlayAnim()
	SetActive(self.gameObject_, true)

	if self.isFirstUnLock_ then
		self:PlayFirstUnlockAnim()
	elseif self.isLock_ then
		self:PlayLockAnim()
	else
		self:PlayEnterAnim()
	end
end

function SeaWarfareMarinerItem:PlayLockAnim()
	self.unlockAnim_.enabled = true

	self.unlockAnim_:Update(9999)
end

function SeaWarfareMarinerItem:PlayEnterAnim()
	self.unlockAnim_.enabled = true
end

function SeaWarfareMarinerItem:PlayFirstUnlockAnim()
	self.isFirstUnLock_ = false

	self.lockController_:SetSelectedState("off")

	self.unlockAnimtimer_ = SeaWarfareTools.PlayAnim(self.unlockAnim_, "UI_QuanZhou_Navigation_MemberItem_unlock")
end

function SeaWarfareMarinerItem:ResetAnim()
	self.unlockAnim_.enabled = false

	SetActive(self.particleGo_, false)

	if self.unlockAnimtimer_ then
		self.unlockAnimtimer_:Stop()

		self.unlockAnimtimer_ = nil
	end
end

return SeaWarfareMarinerItem
