local NewBattleStatisticsHeroItem = class("NewBattleStatisticsHeroItem", ReduxView)

function NewBattleStatisticsHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewBattleStatisticsHeroItem:BuildContext()
	self.modeController = self.controller_:GetController("default0")
	self.heroModule = BattleSettlementHeroHeadModule.New(self.heroHeadObj_)
	self.data = {}
end

function NewBattleStatisticsHeroItem:Init()
	self:BindCfgUI()
	self:BuildContext()
end

function NewBattleStatisticsHeroItem:SetHeroData(arg_4_1, arg_4_2)
	self.data.index = arg_4_1
	self.data.heroData = arg_4_2

	if arg_4_2 then
		self.modeController:SetSelectedState("hero")
		self.heroModule:ShowCaptain(arg_4_1 == 1)
		self.heroModule:SetHeroData(arg_4_2)
		self.heroModule:ShowLevel(arg_4_2.level, 1)
	else
		self.modeController:SetSelectedState("none")
	end
end

function NewBattleStatisticsHeroItem:SetStatisticsData(arg_5_1, arg_5_2, arg_5_3)
	self.data.total = arg_5_1
	self.data.max = arg_5_2
	self.data.data = arg_5_3

	local var_5_0 = arg_5_3.hurt
	local var_5_1 = arg_5_3.cure
	local var_5_2 = tonumber(tostring(arg_5_3.hurt))
	local var_5_3 = tonumber(tostring(arg_5_3.cure))
	local var_5_4 = "%.0f%%"

	if self:valuePass(arg_5_1.damage) then
		local var_5_5 = tonumber(tostring(arg_5_3.damage)) / tonumber(tostring(arg_5_1.damage))

		self.attackNumTxt_.text = tostring(arg_5_3.damage)
		self.attackTxt_.text = string.format(var_5_4, var_5_5 * 100)
		self.attackSlider_.value = var_5_5
	else
		self.attackNumTxt_.text = tostring(arg_5_3.damage)
		self.attackTxt_.text = "0%"
		self.attackSlider_.value = 0
	end

	if self:valuePass(arg_5_1.hurt) then
		local var_5_6 = var_5_2 / tonumber(tostring(arg_5_1.hurt))

		self.damageNumTxt_.text = tostring(var_5_0)
		self.damageTxt_.text = string.format(var_5_4, var_5_6 * 100)
		self.damageSlider_.value = var_5_6
	else
		self.damageNumTxt_.text = tostring(var_5_0)
		self.damageTxt_.text = "0%"
		self.damageSlider_.value = 0
	end

	if self:valuePass(arg_5_1.cure) then
		local var_5_7 = var_5_3 / tonumber(tostring(arg_5_1.cure))

		self.healNumTxt_.text = tostring(var_5_1)
		self.healTxt_.text = string.format(var_5_4, var_5_7 * 100)
		self.healSlider_.value = var_5_7
	else
		self.healNumTxt_.text = tostring(var_5_1)
		self.healTxt_.text = "0%"
		self.healSlider_.value = 0
	end
end

function NewBattleStatisticsHeroItem:valuePass(arg_6_1)
	local var_6_0, var_6_1 = pcall(function()
		if type(arg_6_1) == "number" then
			return arg_6_1 > 0
		else
			return arg_6_1 > int64.zero
		end
	end)

	if var_6_0 then
		return var_6_1
	else
		return false
	end
end

function NewBattleStatisticsHeroItem:Dispose()
	self.heroModule:Dispose()
	NewBattleStatisticsHeroItem.super.Dispose(self)
end

return NewBattleStatisticsHeroItem
