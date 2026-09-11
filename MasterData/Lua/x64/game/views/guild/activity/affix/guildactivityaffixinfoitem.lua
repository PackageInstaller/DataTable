local GuildActivityAffixRInfoItem = class("GuildActivityAffixRInfoItem", ReduxView)

function GuildActivityAffixRInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1.gameObject
	self.transform_ = arg_1_1

	SetActive(self.gameObject_, true)
	self:Init()
end

function GuildActivityAffixRInfoItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityAffixRInfoItem:InitUI()
	self:BindCfgUI()

	self.unlockController_ = ControllerUtil.GetController(self.transform_, "state")
end

function GuildActivityAffixRInfoItem:AddUIListener()
	return
end

function GuildActivityAffixRInfoItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.affixID_ = arg_5_1
	self.level_ = arg_5_2
	self.unlock_ = arg_5_2 <= arg_5_3

	self.unlockController_:SetSelectedState(tostring(self.unlock_))

	self.descText_.text = GetI18NText(getAffixDesc({
		self.affixID_,
		self.level_
	}))
	self.levelText_.text = GetTips("LEVEL") .. self.level_
end

function GuildActivityAffixRInfoItem:OnExit()
	SetActive(self.levelUpAnim_.gameObject, false)
end

function GuildActivityAffixRInfoItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil

	GuildActivityAffixRInfoItem.super.Dispose(self)
end

function GuildActivityAffixRInfoItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function GuildActivityAffixRInfoItem:OnUpgrade()
	SetActive(self.levelUpAnim_.gameObject, true)
	self.levelUpAnim_:Play("TalentUILevelUp", -1, 0)
end

return GuildActivityAffixRInfoItem
