local HeroChipItem = class("HeroChipItem", ReduxView)

function HeroChipItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function HeroChipItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(ON_CLICK_HEROCHIP_ITEM, self.chipID_)
	end)
end

function HeroChipItem:SetChipID(arg_4_1, arg_4_2)
	self.chipID_ = arg_4_1
	self.curHeroId_ = arg_4_2
end

function HeroChipItem:RefreshUI(arg_5_1, arg_5_2)
	self.gameObject_.name = self.chipID_
	self.curHeroId_ = arg_5_2
	self.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[self.chipID_].picture_id)
	self.name_.text = GetI18NText(ChipCfg[self.chipID_].suit_name)

	SetActive(self.lockGo_, table.keyof(ChipData:GetUnlockHeroChipIDList(), self.chipID_) == nil)
	SetActive(self.useGo_, ChipData:GetHeroChipIsEnableByChipId(self.chipID_))
	SetActive(self.selectGo_, self.chipID_ == arg_5_1)
	SetActive(self.prohibitGo_, false)
	self:BindRedPoint()
end

function HeroChipItem:Dispose()
	self:UnbindRedPoint()
	HeroChipItem.super.Dispose(self)
end

function HeroChipItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.notice_, string.format("%s_%s", self.curHeroId_, self.chipID_), {
		x = 0,
		y = 0
	})
end

function HeroChipItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.notice_)
end

return HeroChipItem
