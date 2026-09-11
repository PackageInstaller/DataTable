local BattleMultipleResultHeroItem = class("BattleMultipleResultHeroItem", ReduxView)

function BattleMultipleResultHeroItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.heroData_ = arg_1_2
	self.stageData = arg_1_3
	self.isLock_ = arg_1_4
	self.heroCollectData = arg_1_5 or {}

	self:InitUI()
	self:RefreshUI()
end

function BattleMultipleResultHeroItem:Dispose()
	self:RemoveTween()
	BattleMultipleResultHeroItem.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

function BattleMultipleResultHeroItem:InitUI()
	self:BindCfgUI()
end

function BattleMultipleResultHeroItem:RefreshUI()
	self.icon_.sprite = getSpriteViaConfig("HeroLittleIcon", self.heroData_.using_skin)

	if self.isLock_ then
		self:LockHero()
	else
		self:RefreshHero()
	end
end

function BattleMultipleResultHeroItem:LockHero()
	self.addExpText_.text = "+0"
	self.lvText_.text = self.heroData_.level
	self.expProgressBar_.value = 1
end

function BattleMultipleResultHeroItem:RefreshHero()
	local var_6_1 = 1
	local var_6_2 = 1
	local var_6_3 = 0
	local var_6_4 = 0

	if self.heroCollectData then
		var_6_1 = self.heroCollectData.oldLv
		var_6_2 = self.heroCollectData.newLv
		var_6_3 = self.heroCollectData.oldPersent
		var_6_4 = self.heroCollectData.newPersent
	end

	self.addExpText_.text = ""

	self:RemoveTween()

	self.heroExp_ = var_6_2 + var_6_4
	self.tweens_ = LeanTween.value(self.expProgressBar_.gameObject, var_6_1 + var_6_3, var_6_2 + var_6_4, 6):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
		self:UpdateHeroData(arg_7_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:RemoveTween()
	end))
end

function BattleMultipleResultHeroItem:RemoveTween()
	if self.tweens_ then
		self.tweens_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tweens_.id)
	end
end

function BattleMultipleResultHeroItem:UpdateHeroData(arg_10_1)
	local var_10_0, var_10_1 = math.modf(arg_10_1)

	self.lvText_.text = string.format("%d", var_10_0)
	self.expProgressBar_.value = LvTools.GetIsMaxLv(var_10_0, "hero") and 1 or var_10_1
end

function BattleMultipleResultHeroItem:EndAnimator()
	self:RemoveTween()

	if not self.isLock_ then
		self:UpdateHeroData(self.heroExp_)
	end
end

return BattleMultipleResultHeroItem
