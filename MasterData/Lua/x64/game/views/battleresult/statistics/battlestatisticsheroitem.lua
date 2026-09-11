local BattleStatisticsHeroItem = class("BattleStatisticsHeroItem", ReduxView)

function BattleStatisticsHeroItem:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.heroData_ = arg_1_2
	self.totalData_ = arg_1_3
	self.maxData_ = arg_1_4
	self.data_ = arg_1_5

	self:Init()
end

function BattleStatisticsHeroItem:Init()
	self:InitUI()
	self:AddListeners()
	self:RefreshUI()
end

function BattleStatisticsHeroItem:Dispose()
	self:RemoveListeners()
	BattleStatisticsHeroItem.super.Dispose(self)
end

function BattleStatisticsHeroItem:InitUI()
	self:BindCfgUI()

	self.haveHeroController_ = ControllerUtil.GetController(self.gameObject_.transform, "haveHero")
	self.highGo1_ = self:FindGo("line1/high")
	self.highGo2_ = self:FindGo("line2/high")
	self.highGo3_ = self:FindGo("line3/high")
	self.controllers_ = {
		ControllerUtil.GetController(self.highGo1_.transform, "zero"),
		ControllerUtil.GetController(self.highGo2_.transform, "zero"),
		ControllerUtil.GetController(self.highGo3_.transform, "zero")
	}
end

function BattleStatisticsHeroItem:AddListeners()
	return
end

function BattleStatisticsHeroItem:RemoveListeners()
	return
end

function BattleStatisticsHeroItem:RefreshUI()
	if self.heroData_ then
		self.haveHeroController_:SetSelectedState("true")

		local var_7_1 = self.data_

		self.battleCountIcon_.sprite = getSpriteViaConfig("HeroIcon", self.heroData_.skin_id)

		SetActive(self.battleCountIcon_.gameObject, true)

		self.battleCountLv_.text = self.heroData_.level
		self.battleCountDamageNum_.text = tostring(var_7_1.damage)
		self.battleCountHurtNum_.text = tostring(var_7_1.hurt)
		self.battleCountCureNum_.text = tostring(var_7_1.cure)
		self.battleCountDamageImg_.enabled = int64.equals(self.maxData_.damage, var_7_1.damage) and self.maxData_.damage > int64.zero
		self.battleCountHurtNumImg_.enabled = int64.equals(self.maxData_.hurt, var_7_1.hurt) and self.maxData_.hurt > int64.zero
		self.battleCountCureNumImg_.enabled = int64.equals(self.maxData_.cure, var_7_1.cure) and self.maxData_.cure > int64.zero

		if var_7_1.damage == 0 then
			self.controllers_[1]:SetSelectedState("true")

			self.battleCountDamageNum_.text = "--"
		else
			self.controllers_[1]:SetSelectedState("false")
		end

		if var_7_1.hurt == 0 then
			self.controllers_[2]:SetSelectedState("true")

			self.battleCountHurtNum_.text = "--"
		else
			self.controllers_[2]:SetSelectedState("false")
		end

		if var_7_1.cure == 0 then
			self.controllers_[3]:SetSelectedState("true")

			self.battleCountCureNum_.text = "--"
		else
			self.controllers_[3]:SetSelectedState("false")
		end
	else
		self.haveHeroController_:SetSelectedState("false")
	end
end

return BattleStatisticsHeroItem
