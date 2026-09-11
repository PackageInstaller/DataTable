local GuildActivitySPAffixRInfoItem = class("GuildActivitySPAffixRInfoItem", ReduxView)

function GuildActivitySPAffixRInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1.gameObject
	self.transform_ = arg_1_1

	SetActive(self.gameObject_, true)
	self:Init()
end

function GuildActivitySPAffixRInfoItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPAffixRInfoItem:InitUI()
	self:BindCfgUI()

	self.unlockController_ = ControllerUtil.GetController(self.transform_, "state")
end

function GuildActivitySPAffixRInfoItem:AddUIListener()
	return
end

function GuildActivitySPAffixRInfoItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.affixID_ = arg_5_1
	self.level_ = arg_5_2
	self.unlock_ = arg_5_2 <= arg_5_3

	self.unlockController_:SetSelectedState(tostring(self.unlock_))

	self.descText_.text = getAffixDesc({
		self.affixID_,
		self.level_
	})
	self.levelText_.text = GetTips("LEVEL") .. self.level_
end

function GuildActivitySPAffixRInfoItem:OnExit()
	SetActive(self.levelUpAnim_.gameObject, false)
end

function GuildActivitySPAffixRInfoItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil

	GuildActivitySPAffixRInfoItem.super.Dispose(self)
end

function GuildActivitySPAffixRInfoItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function GuildActivitySPAffixRInfoItem:OnUpgrade()
	SetActive(self.levelUpAnim_.gameObject, true)
	self.levelUpAnim_:Play("TalentUILevelUp", -1, 0)
end

return GuildActivitySPAffixRInfoItem
