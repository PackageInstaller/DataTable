local BattleBossChallengeSkillItem = class("BattleBossChallengeSkillItem", ReduxView)

function BattleBossChallengeSkillItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
end

function BattleBossChallengeSkillItem:RefreshUI(arg_2_1)
	SetActive(self.gameObject_, true)

	self.textName_.text = arg_2_1.name
	self.textDesc_.text = arg_2_1.info

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transformDesc_)
end

function BattleBossChallengeSkillItem:Hide()
	SetActive(self.gameObject_, false)
end

function BattleBossChallengeSkillItem:Dispose()
	BattleBossChallengeSkillItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return BattleBossChallengeSkillItem
