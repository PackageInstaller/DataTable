local EquipResetView = class("EquipResetView", EquipBaseView)

function EquipResetView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.params_ = arg_1_3

	self:Init()
end

function EquipResetView:Init()
	self:BindCfgUI()

	self.toggles_ = {
		self.raceRebuildToggle_,
		self.heroRebuildToggle_
	}

	self:InitUI()
	self:AddUIListener()
	EquipResetView.super.Init(self)
end

function EquipResetView:InitUI()
	self.materialList_ = {}
	self.itemList_ = {}

	for iter_3_0 = 1, 2 do
		local var_3_0 = EquipData:GetRaceMaterial(iter_3_0)

		self.materialList_[iter_3_0] = var_3_0

		if var_3_0 then
			local var_3_1 = CommonItemView.New(self["commonItem_" .. iter_3_0])
			local var_3_2 = clone(ItemTemplateData)

			var_3_2.id = var_3_0.id

			function var_3_2:clickFun()
				ShowPopItem(POP_SOURCE_ITEM, {
					self.id,
					self.number
				})
			end

			var_3_1:SetData(var_3_2)

			self.itemList_[iter_3_0] = var_3_1
		end
	end

	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	self.selectController = self.selectCon_:GetController("select")
	self.raceController_ = self.transCon_:GetController("race")
	self.costContrller_ = self.transCon_:GetController("cost")
end

function EquipResetView:AddUIListener()
	self:AddBtnListener(self.btnRace_, nil, function()
		self:OnRaceClick()
	end)
	self:AddBtnListener(self.clickBtn_1, nil, function()
		if self.heroID_ ~= 0 then
			ShowTips("EQUIP_HERO_HAD_REBUILT")

			return
		end

		EquipData:SetRaceIndex(1)
		self.selectController:SetSelectedState("race")

		self.selectType_ = 1

		self:RefreshMoney()
	end)
	self:AddBtnListener(self.clickBtn_2, nil, function()
		if self.heroID_ ~= 0 then
			ShowTips("EQUIP_HERO_HAD_REBUILT")

			return
		end

		if self.race_ == 0 then
			ShowTips("EQUIP_RACE_REBUILD_FIRST")

			return
		end

		EquipData:SetRaceIndex(2)
		self.selectController:SetSelectedState("hero")

		self.selectType_ = 2

		self:RefreshMoney()
	end)
end

function EquipResetView:OnTop()
	self:ChangeBar()
end

function EquipResetView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function EquipResetView:OnEnter()
	self.equipHeroId = self.params_.heroId

	self:OnEquipChange(self.params_.equipId)
	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.OnGoldChange))
end

function EquipResetView:OnEquipChange(arg_12_1)
	self.equipId = arg_12_1

	self:RefreshUI()
	self:RefreshSelectType()
	self:RefreshMoney()
	self:RefreshMaterial()
	self:ChangeBar()
end

function EquipResetView:RefreshUI()
	local var_13_0 = EquipData:GetEquipData(self.equipId)

	if not var_13_0 then
		return
	end

	self.race_ = 0
	self.heroID_ = 0

	if var_13_0.race == 0 then
		self.costContrller_:SetSelectedState("on")
	elseif table.keyof(RaceEffectCfg.all, var_13_0.race) ~= nil then
		self.race_ = var_13_0.race

		self.costContrller_:SetSelectedState("on")
	else
		self.heroID_ = var_13_0.race

		self.costContrller_:SetSelectedState("off")
	end

	if self.heroID_ ~= 0 then
		if HeroCfg[self.heroID_] then
			self.raceController_:SetSelectedIndex(2)

			local var_13_2 = string.format("%s·%s", GetI18NText(HeroCfg[self.heroID_].name), GetI18NText(HeroCfg[self.heroID_].suffix))
			local var_13_3 = SettingData:GetCurrentLanguage()

			self.heroText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), GetI18NText((var_13_3 == "fr" or var_13_3 == "de" or nil) and string.format("%s-%s", GetI18NText(HeroCfg[self.heroID_].name), GetI18NText(HeroCfg[self.heroID_].suffix))))
			self.imgHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(self.heroID_)
		end
	else
		if self.race_ ~= 0 then
			if RaceEffectCfg[self.race_] then
				self.raceController_:SetSelectedIndex(1)

				self.groupText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(RaceEffectCfg[self.race_].name))
				self.imgGroup_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[self.race_].icon2)
			end
		end

		local var_13_4

		do
			self.raceController_:SetSelectedIndex(0)

			var_13_4 = self.btnRace_
		end
	end

	var_13_4.interactable = self.heroID_ == 0
end

function EquipResetView:RefreshSelectType()
	if self.heroID_ ~= 0 then
		if self.selectType_ and self.selectType_ ~= 0 then
			self.selectController:SetSelectedState("noselect")
		end

		self.selectType_ = 1
	elseif self.race_ ~= 0 then
		local var_14_0 = EquipData:GetRaceIndex()

		self.selectController:SetSelectedIndex(var_14_0 - 1)

		self.selectType_ = var_14_0
	else
		self.selectController:SetSelectedState("race")

		self.selectType_ = 1

		EquipData:SetRaceIndex(1)
	end
end

function EquipResetView:RefreshMoney()
	if self.selectType_ ~= nil and self.selectType_ ~= 0 then
		local var_15_0 = tostring(self.materialList_[self.selectType_].money)

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < self.materialList_[self.selectType_].money then
			var_15_0 = "<color='#FF0000'>" .. var_15_0 .. "</color>"
		end

		self.costNum_.text = var_15_0
	end
end

function EquipResetView:RefreshMaterial()
	for iter_16_0, iter_16_1 in ipairs(self.materialList_) do
		local var_16_0 = ItemTools.getItemNum(iter_16_1.id)
		local var_16_1 = tostring(var_16_0)

		if var_16_0 < iter_16_1.number then
			var_16_1 = "<color='#FF0000'>" .. var_16_1 .. "</color>"
		end

		self.itemList_[iter_16_0]:SetBottomAmountText(var_16_1 .. "/" .. iter_16_1.number)
	end
end

function EquipResetView:OnRaceClick()
	if self.selectType_ == 1 then
		EquipAction.QueryEquipRace(self.equipId, self.selectType_, self.equipHeroId)
	else
		self:Go("/equipHeroRebuild", {
			equipId = self.equipId,
			proxy = self.params_.proxy
		})
	end
end

function EquipResetView:OnEquipRaceConfirm()
	self:RefreshUI()
	self:RefreshMoney()
	self:RefreshMaterial()
end

function EquipResetView:OnExit()
	self.selectController:SetSelectedState("noselect")
	self:RemoveAllEventListener()
end

function EquipResetView:Dispose()
	if self.itemList_ then
		for iter_20_0, iter_20_1 in ipairs(self.itemList_) do
			iter_20_1:Dispose()
		end

		self.itemList_ = nil
	end

	EquipResetView.super.Dispose(self)
end

function EquipResetView:OnGoldChange(arg_21_1)
	if arg_21_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		self:RefreshMoney()
	end
end

return EquipResetView
