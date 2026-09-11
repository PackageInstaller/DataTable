local EquipHeroRebuildView = class("EquipHeroRebuildView", ReduxView)

function EquipHeroRebuildView:UIName()
	return "Widget/System/Hero_equip/Develop/HeroEquipHeroReset"
end

function EquipHeroRebuildView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipHeroRebuildView:Init()
	self:BindCfgUI()

	self.heroIdList_ = {}
	self.heroList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, HeroLongHead)

	self:InitUI()
	self:AddUIListener()

	self.currentController_ = self.currentCon_:GetController("state")
	self.targetController_ = self.targetCon_:GetController("state")
end

function EquipHeroRebuildView:InitUI()
	self.material_ = EquipData:GetRaceMaterial(2)

	if self.material_ then
		self.itemView_ = CommonItemView.New(self.commonItem_, true)

		local var_4_0 = clone(ItemTemplateData)

		var_4_0.id = self.material_.id
		var_4_0.number = nil
		var_4_0.bottomText = {
			ItemTools.getItemNum(self.material_.id),
			self.material_.number
		}

		function var_4_0:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.id,
				self.number
			})
		end

		self.itemView_:SetData(var_4_0)
	end

	if self.material_ then
		self.cost_ = self.material_.money or 0
	end

	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function EquipHeroRebuildView:IndexItem(arg_6_1, arg_6_2)
	local var_6_0 = self.heroIdList_[arg_6_1]

	arg_6_2.gameObject_.name = tostring(self.heroIdList_[arg_6_1])

	arg_6_2:SetProxy(self.params_.proxy)
	arg_6_2:SetHeroId(var_6_0, HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_6_2:SetSelected(var_6_0 == self.curHeroID_)
	arg_6_2:RegisterClickListener(function()
		self:SelectHero(arg_6_2.heroId_)
	end)
end

function EquipHeroRebuildView:SelectHero(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self.heroList_:GetItemList()) do
		iter_8_1:SetSelected(iter_8_1.heroId_ == arg_8_1)
	end

	self.curHeroID_ = arg_8_1

	self:RefreshUI()
end

function EquipHeroRebuildView:AddUIListener()
	self:AddBtnListener(self.rebuildBtn_, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < self.cost_ then
			local var_10_0 = false

			for iter_10_0, iter_10_1 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}) do
				if ItemTools.getItemNum(iter_10_1) > 0 then
					var_10_0 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or var_10_0 then
				JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)

				return
			else
				ShowTips(GetTips("ERROR_ITEM_NOT_ENOUGH_GOLD"))
			end
		elseif self.material_ and ItemTools.getItemNum(self.material_.id) < self.material_.number then
			ShowPopItem(POP_SOURCE_ITEM, {
				self.material_.id,
				self.material_.number
			})
		else
			if _G.SkipTip.EquipHeroRebuildSkip or SettingData:GetRemindSettingData().rebuild_hero_equip_reminder ~= 1 then
				EquipAction.QueryEquipRace(self.equipID_, 2, self.curHeroID_)

				return
			end

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("EQUIP_HERO_REBUILD_WARNING"), HeroTools.GetHeroFullName(self.curHeroID_)),
				OkCallback = function()
					EquipAction.QueryEquipRace(self.equipID_, 2, self.curHeroID_)
				end,
				ToggleCallback = function(arg_12_0)
					_G.SkipTip.EquipHeroRebuildSkip = arg_12_0
				end
			})
		end
	end)
end

function EquipHeroRebuildView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.curHeroID_ = nil
	self.equipID_ = self.params_.equipId

	local var_13_0 = EquipData:GetEquipData(self.equipID_)

	if not var_13_0 then
		return
	end

	self.race_ = var_13_0.race

	local var_13_1 = EquipTools.GetEquipedHeroId(self.equipID_)

	if var_13_1 ~= 0 and HeroCfg[var_13_1].race == self.race_ then
		self.curHeroID_ = var_13_1
	end

	self:RefreshHeroList()
	self:RefreshMoney()
	self:RefreshMaterial()
	self:RefreshUI()
	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.OnGoldChange))
end

function EquipHeroRebuildView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function EquipHeroRebuildView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function EquipHeroRebuildView:RefreshHeroList()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs((HeroData:GetHeroList())) do
		if HeroCfg[iter_16_1.id].race == self.race_ and iter_16_1.unlock ~= 0 then
			var_16_0[#var_16_0 + 1] = iter_16_1.id
		end
	end

	self.heroIdList_ = var_16_0

	self.heroList_:StartScroll(#self.heroIdList_)
end

function EquipHeroRebuildView:RefreshMoney()
	local var_17_0 = tostring(self.cost_)

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < self.cost_ then
		var_17_0 = "<color='#FF0000'>" .. var_17_0 .. "</color>"
	end

	self.costNum_.text = var_17_0
	self.material_ = EquipData:GetRaceMaterial(2)

	self.itemView_:RefreshBottomText({
		ItemTools.getItemNum(self.material_.id),
		self.material_.number
	})
end

function EquipHeroRebuildView:RefreshMaterial()
	return
end

function EquipHeroRebuildView:RefreshUI()
	if self.curHeroID_ ~= nil then
		self.targetController_:SetSelectedIndex(1)

		local var_19_1 = string.format("%s·%s", GetI18NText(HeroCfg[self.curHeroID_].name), GetI18NText(HeroCfg[self.curHeroID_].suffix))
		local var_19_2 = SettingData:GetCurrentLanguage()

		self.targetText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), GetI18NText((var_19_2 == "fr" or var_19_2 == "de" or nil) and string.format("%s-%s", GetI18NText(HeroCfg[self.curHeroID_].name), GetI18NText(HeroCfg[self.curHeroID_].suffix))))
		self.targetHeroIcon_.sprite = SpritePathCfg.HeroMediumIcon.path .. self.curHeroID_

		HeroTools.GetSmallHeadSprite(self.curHeroID_)
	else
		self.targetController_:SetSelectedIndex(0)
	end

	local var_19_3 = RaceEffectCfg[self.race_]

	if RaceEffectCfg[self.race_] then
		self.currentController_:SetSelectedIndex(1)

		self.currentText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_19_3.name))
		self.currenGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", var_19_3.icon2)
	end

	local var_19_4 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)

	self.rebuildBtn_.interactable = self.curHeroID_ ~= nil
end

function EquipHeroRebuildView:Dispose()
	if self.itemView_ then
		self.itemView_:Dispose()

		self.itemView_ = nil
	end

	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end

	self.heroList_:Dispose()
	EquipHeroRebuildView.super.Dispose(self)
end

function EquipHeroRebuildView:OnGoldChange(arg_21_1)
	if arg_21_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		self:RefreshMoney()
	end
end

function EquipHeroRebuildView:OnEquipRace()
	self:Back()
end

return EquipHeroRebuildView
