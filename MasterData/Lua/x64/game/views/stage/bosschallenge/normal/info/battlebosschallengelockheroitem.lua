local BattleBossChallengeLockHeroItem = class("BattleBossChallengeLockHeroItem", ReduxView)

function BattleBossChallengeLockHeroItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
end

function BattleBossChallengeLockHeroItem:RefreshHeroItem(arg_2_1)
	self.imageIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_2_1)
end

function BattleBossChallengeLockHeroItem:SetActive(arg_3_1, arg_3_2)
	SetActive(self.gameObject_, arg_3_1)

	if arg_3_1 then
		self:RefreshHeroItem(arg_3_2)
	end
end

function BattleBossChallengeLockHeroItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return BattleBossChallengeLockHeroItem
