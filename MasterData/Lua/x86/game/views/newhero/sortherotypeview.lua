local SortHeroTypeView = class("SortHeroTypeView", ReduxView)

function SortHeroTypeView:UIName()
	return "UI/Hero/HeroScreeningPop"
end

function SortHeroTypeView:UIParent()
	return manager.ui.uiPop.transform
end

function SortHeroTypeView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SortHeroTypeView:InitUI()
	self:BindCfgUI()

	self.allCon_ = ControllerUtil.GetController(self.allBtn_.gameObject.transform, "select")
	self.toggle_ = {}

	for iter_4_0 = 0, 1 do
		self.toggle_[iter_4_0] = self["tgl_" .. iter_4_0]
	end

	self.raceBtn_ = {}
	self.raceCon_ = {}

	for iter_4_1, iter_4_2 in ipairs(RaceEffectCfg.all) do
		self.raceBtn_[iter_4_1] = self["raceBtn_" .. iter_4_1]
		self.raceCon_[iter_4_1] = ControllerUtil.GetController(self.raceBtn_[iter_4_1].gameObject.transform, "select")
	end

	self.attackBtn_ = {}
	self.attackCon_ = {}
	self.attackType_ = {
		HeroConst.HERO_ATTACK_TYPE.PYISICS,
		HeroConst.HERO_ATTACK_TYPE.WIND,
		HeroConst.HERO_ATTACK_TYPE.FLAME,
		HeroConst.HERO_ATTACK_TYPE.THUNDER,
		HeroConst.HERO_ATTACK_TYPE.DARK,
		HeroConst.HERO_ATTACK_TYPE.LIGHT,
		HeroConst.HERO_ATTACK_TYPE.FREEZE,
		HeroConst.HERO_ATTACK_TYPE.WATER,
		HeroConst.HERO_ATTACK_TYPE.MIX,
		HeroConst.HERO_ATTACK_TYPE.RANDOM
	}

	for iter_4_3, iter_4_4 in ipairs(self.attackType_) do
		self.attackBtn_[iter_4_3] = self["attackBtn_" .. iter_4_3]
		self.attackCon_[iter_4_3] = ControllerUtil.GetController(self.attackBtn_[iter_4_3].gameObject.transform, "select")
	end

	self.energyBtn_ = {}
	self.energyCon_ = {}
	self.energyType_ = {
		HeroConst.HERO_CHARGE_TYPE.RAGE,
		HeroConst.HERO_CHARGE_TYPE.ENERGY,
		HeroConst.HERO_CHARGE_TYPE.TRACES,
		HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE,
		HeroConst.HERO_CHARGE_TYPE.NONE
	}

	for iter_4_5, iter_4_6 in ipairs(self.energyType_) do
		self.energyBtn_[iter_4_5] = self["energyBtn_" .. iter_4_5]
		self.energyCon_[iter_4_5] = ControllerUtil.GetController(self.energyBtn_[iter_4_5].gameObject.transform, "select")
	end
end

function SortHeroTypeView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.canelBtn_, nil, function()
		HeroData:ResetSortValue()
		manager.notify:CallUpdateFunc(HERO_SORT, true, 0, {}, {}, {})
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		manager.notify:CallUpdateFunc(HERO_SORT, self.isAll_, self.curSortType_, self.curSortRace_, self.curAttackType_, self.curEnergyType_)
		self:Back()
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self.isAll_ = true
		self.curSortRace_ = {}
		self.curAttackType_ = {}
		self.curEnergyType_ = {}

		self:RefreshBtnState()
	end)

	for iter_5_0 = 0, 1 do
		self:AddToggleListener(self.toggle_[iter_5_0], function(arg_10_0)
			if arg_10_0 then
				self.curSortType_ = iter_5_0
			end
		end)
	end

	for iter_5_1, iter_5_2 in ipairs(RaceEffectCfg.all) do
		self:AddBtnListener(self.raceBtn_[iter_5_1], nil, function()
			local var_11_0 = table.indexof(self.curSortRace_, iter_5_2)

			if var_11_0 then
				table.remove(self.curSortRace_, var_11_0)
				self.raceCon_[iter_5_1]:SetSelectedState("off")
				self:IsNeedAll()
			else
				table.insert(self.curSortRace_, iter_5_2)
				self.raceCon_[iter_5_1]:SetSelectedState("on")
				self:SetAllOff()
			end
		end)
	end

	for iter_5_3, iter_5_4 in ipairs(self.attackType_) do
		self:AddBtnListener(self.attackBtn_[iter_5_3], nil, function()
			local var_12_0 = table.indexof(self.curAttackType_, self.attackType_[iter_5_3])

			if var_12_0 then
				table.remove(self.curAttackType_, var_12_0)
				self.attackCon_[iter_5_3]:SetSelectedState("off")
				self:IsNeedAll()
			else
				table.insert(self.curAttackType_, self.attackType_[iter_5_3])
				self.attackCon_[iter_5_3]:SetSelectedState("on")
				self:SetAllOff()
			end
		end)
	end

	for iter_5_5, iter_5_6 in ipairs(self.energyType_) do
		self:AddBtnListener(self.energyBtn_[iter_5_5], nil, function()
			local var_13_0 = table.indexof(self.curEnergyType_, self.energyType_[iter_5_5])

			if var_13_0 then
				table.remove(self.curEnergyType_, var_13_0)
				self.energyCon_[iter_5_5]:SetSelectedState("off")
				self:IsNeedAll()
			else
				table.insert(self.curEnergyType_, self.energyType_[iter_5_5])
				self.energyCon_[iter_5_5]:SetSelectedState("on")
				self:SetAllOff()
			end
		end)
	end
end

function SortHeroTypeView:OnEnter()
	self.isAll_ = self.params_.isAll
	self.curSortType_ = self.params_.sortType or 0
	self.curSortRace_ = self.params_.sortRace and deepClone(self.params_.sortRace) or {}
	self.curAttackType_ = self.params_.attackType and deepClone(self.params_.attackType) or {}
	self.curEnergyType_ = self.params_.energyType and deepClone(self.params_.energyType) or {}

	self:RefreshBtnState()
end

function SortHeroTypeView:RefreshBtnState()
	self.allCon_:SetSelectedState(self.isAll_ and "on" or "off")

	self.toggle_[self.curSortType_].isOn = true

	for iter_15_0, iter_15_1 in ipairs(RaceEffectCfg.all) do
		self.raceCon_[iter_15_0]:SetSelectedState(table.indexof(self.curSortRace_, iter_15_1) and "on" or "off")
	end

	for iter_15_2, iter_15_3 in ipairs(self.attackType_) do
		self.attackCon_[iter_15_2]:SetSelectedState(table.indexof(self.curAttackType_, iter_15_3) and "on" or "off")
	end

	for iter_15_4, iter_15_5 in ipairs(self.energyType_) do
		self.energyCon_[iter_15_4]:SetSelectedState(table.indexof(self.curEnergyType_, iter_15_5) and "on" or "off")
	end
end

function SortHeroTypeView:SetAllOff()
	self.isAll_ = false

	self.allCon_:SetSelectedState("off")
end

function SortHeroTypeView:IsNeedAll()
	if #self.curSortRace_ <= 0 and #self.curAttackType_ <= 0 and #self.curEnergyType_ <= 0 then
		self.isAll_ = true

		self.allCon_:SetSelectedState("on")
	end
end

function SortHeroTypeView:OnExit()
	return
end

function SortHeroTypeView:Dispose()
	self:RemoveAllListeners()
	SortHeroTypeView.super.Dispose(self)
end

return SortHeroTypeView
