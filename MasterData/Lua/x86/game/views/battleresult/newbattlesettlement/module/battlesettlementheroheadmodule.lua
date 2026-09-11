local BattleSettlementHeroHeadModule = class("BattleSettlementHeroHeadModule", ReduxView)

function BattleSettlementHeroHeadModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BattleSettlementHeroHeadModule:BuildContext()
	self.levelUpTween = nil
	self.heroData = nil
end

function BattleSettlementHeroHeadModule:Init()
	self:BindCfgUI()
	self:BuildContext()

	if self.controller_ then
		self.npcController = self.controller_:GetController("isNpc")
	end
end

function BattleSettlementHeroHeadModule:ShowCaptain(arg_4_1)
	SetActive(self.captainObj_, arg_4_1)
end

function BattleSettlementHeroHeadModule:SetHeroData(arg_5_1)
	self.heroData = arg_5_1

	if not arg_5_1 then
		SetActive(self.heroNoneObj_, true)
		SetActive(self.heroHeadObj_, false)

		return
	else
		SetActive(self.heroNoneObj_, false)
		SetActive(self.heroHeadObj_, true)
	end

	local var_5_0 = arg_5_1.id

	self:SetHeroCfgData(var_5_0, arg_5_1.using_skin, (arg_5_1.star or 0) / 100)

	if self.npcController then
		if HeroCfg[var_5_0] and (HeroCfg[var_5_0].role_type == 1 or HeroCfg[var_5_0].role_type == 2) then
			self.npcController:SetSelectedState("true")
		else
			self.npcController:SetSelectedState("false")
		end
	end
end

function BattleSettlementHeroHeadModule:SetHeroLevelData(arg_6_1)
	local var_6_0, var_6_1 = math.modf(arg_6_1)

	if LvTools.GetIsMaxLv(var_6_0, "hero") then
		self:ShowLevel(var_6_0, 1)
	else
		self:ShowLevel(var_6_0, var_6_1)
	end
end

function BattleSettlementHeroHeadModule:ShowLevel(arg_7_1, arg_7_2)
	self.levelText_.text = tostring(arg_7_1 or 1)
	self.expSlider_.value = arg_7_2
end

function BattleSettlementHeroHeadModule:PlayLevelUpTween(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	self:StopTween()

	self.levelUpTween = LeanTween.value(self.gameObject_, arg_8_1 + arg_8_3, arg_8_2 + arg_8_4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
		self:SetHeroLevelData(arg_9_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:StopTween()
	end))
end

function BattleSettlementHeroHeadModule:RenderContentView(arg_11_1)
	return
end

function BattleSettlementHeroHeadModule:StopTween()
	if not isNil(self.levelUpTween) then
		self.levelUpTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.gameObject_)

		self.levelUpTween = nil
	end
end

function BattleSettlementHeroHeadModule:SetHeroCfgData(arg_13_1, arg_13_2, arg_13_3)
	self.heroCfg_ = HeroCfg[arg_13_1]
	self.campLogo_.sprite = HeroTools.GetHeroRaceIcon(arg_13_1)
	self.rareImg_.sprite = arg_13_3 == 0 and HeroTools.GetRareSprite(math.floor(HeroCfg[arg_13_1].rare or 0)) or HeroTools.GetRareSprite(math.floor(arg_13_3))

	local var_13_1 = HeroTools.GetHeroSkillAttributeIcon(arg_13_1)

	if var_13_1 == nil then
		SetActive(self.atkTypeGo_, false)
	else
		SetActive(self.atkTypeGo_, true)

		self.attackType_.sprite = var_13_1
	end

	if arg_13_2 then
		self.headIcon_.sprite = HeroTools.GetHeadSprite(SkinCfg[arg_13_2].picture_id)

		self.headIcon_:SetNativeSize()
	end
end

function BattleSettlementHeroHeadModule:Dispose()
	self:StopTween()
	BattleSettlementHeroHeadModule.super.Dispose(self)
end

return BattleSettlementHeroHeadModule
