local HeroUpgradeView = class("HeroUpgradeView", ReduxView)

function HeroUpgradeView:UIName()
	return "Widget/System/Hero_arrt/HeroArrtLvupUI"
end

function HeroUpgradeView:UIParent()
	return manager.ui.uiMain.transform
end

local var_0_1 = 0
local var_0_2 = {}
local var_0_3 = {}

function HeroUpgradeView:Init()
	self:InitUI()
	self:AddUIListener()

	self.tweens_ = {}
	self.breakItems_ = {}
	self.needIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function HeroUpgradeView:InitUI()
	self:BindCfgUI()

	self.addExpController_ = self.controller_:GetController("addExp")
	self.typeController_ = self.controller_:GetController("type")
	self.moneyEnoughController_ = self.controller_:GetController("moneyEnough")
	self.canBreakController_ = self.controller_:GetController("canBreak")
	self.conditionBreakController_ = self.conditionController_:GetController("conditionItem")

	self:InitMaterialItem()
	self:InitPropItem()
end

function HeroUpgradeView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		2
	}, false)
end

function HeroUpgradeView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		local var_7_0 = false

		for iter_7_0 = 1, #self.items_ do
			if self.items_[iter_7_0]:GetData().topAmountValue > 0 then
				var_7_0 = true

				break
			end
		end

		if not var_7_0 then
			ShowTips("HERO_LEVEL_MATERIAL_NOT_SELECTED")

			return
		end

		if self:HaveMaterial() then
			local var_7_1 = MaterialTools.materialGiveBack(self.cutExp_, ItemConst.STR_ITEM.HERO)

			self.cutExpForReward_ = self.cutExp_

			if #var_7_1 > 0 then
				JumpTools.OpenPageByJump("materialPreview", {
					content = GetTips("HERO_STRENGTH_EXP_OVERFLOW"),
					OkCallback = function()
						self:SendAddExpToServer()
					end,
					itemList = var_7_1
				})

				return
			else
				self:SendAddExpToServer()
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function()
					JumpTools.JumpToPage(ItemCfg[GameSetting.hero_exp_props_id_list.value[1]].source[1])
				end
			})
		end
	end)
	self:AddBtnListener(self.oneKeyBtn_, nil, function()
		local var_10_0 = false

		for iter_10_0 = 1, #self.items_ do
			if self.items_[iter_10_0]:GetData().number > 0 then
				var_10_0 = true

				break
			end
		end

		if self:HaveMaterial() and var_10_0 then
			self:OnKeyLevelUp()
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function()
					JumpTools.JumpToPage(ItemCfg[GameSetting.hero_exp_props_id_list.value[1]].source[1])
				end
			})
		end
	end)
	self:AddBtnListener(self.breakPreviewBtn_, nil, function()
		JumpTools.OpenPageByJump("heroBreakPreview", {
			heroInfo = self.heroInfo_
		})
	end)
	self:AddBtnListener(self.breakBtn_, nil, function()
		if self.canBreak_ then
			self:SendBreakToServer()
		elseif PlayerData:GetPlayerInfo().userLevel < self.breakCfg_.user_level then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), self.breakCfg_.user_level))
		elseif not self:HaveBreakMaterial() then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
		elseif not checkGold(self.breakCfg_.cost_gold, true) then
			return
		end
	end)
	self:AddBtnListener(self.upgradeViewBtn1_, nil, function()
		local var_14_0 = false

		for iter_14_0, iter_14_1 in pairs(GameSetting.hero_exp_props_id_list.value) do
			if ItemTools.getItemNum(iter_14_1) > 0 then
				var_14_0 = true

				break
			end
		end

		if var_14_0 then
			JumpTools.OpenPageByJump("heroOneKeyUpgrandView", {
				heroInfo = self.heroInfo_,
				proxy = self.heroViewProxy_
			})
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function()
					JumpTools.JumpToPage(ItemCfg[GameSetting.hero_exp_props_id_list.value[1]].source[1])
				end
			})
		end
	end)
	self:AddBtnListener(self.upgradeViewBtn2_, nil, function()
		local var_16_0 = false

		for iter_16_0, iter_16_1 in pairs(GameSetting.hero_exp_props_id_list.value) do
			if ItemTools.getItemNum(iter_16_1) > 0 then
				var_16_0 = true

				break
			end
		end

		if var_16_0 then
			JumpTools.OpenPageByJump("heroOneKeyUpgrandView", {
				heroInfo = self.heroInfo_,
				proxy = self.heroViewProxy_
			})
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function()
					JumpTools.JumpToPage(ItemCfg[GameSetting.hero_exp_props_id_list.value[1]].source[1])
				end
			})
		end
	end)
end

function HeroUpgradeView:OnHeroBreak(arg_18_1, arg_18_2)
	if isSuccess(arg_18_1.result) then
		HeroAction.BreakSuccess(self.heroInfo_.id, (self.heroInfo_.break_level or 0) + 1)

		local var_18_1 = {
			heroId = self.heroInfo_.id
		}

		var_18_1.breakLevel = self.heroInfo_.break_level or 0
		var_18_1.oldCrit = var_0_2[HeroConst.HERO_ATTRIBUTE.CRITICAL]
		var_18_1.proxy = self.heroViewProxy_

		JumpTools.OpenPageByJump("newBreakSuccess", var_18_1)

		var_0_2 = HeroTools.CaculateHeroAttribute(self.heroInfo_, (self.heroViewProxy_:CalHeroEquipAttribute(self.heroInfo_.id)))
	end
end

function HeroUpgradeView:SendAddExpToServer()
	var_0_1 = self.heroInfo_.level

	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(self.items_) do
		local var_19_1 = iter_19_1:GetData()

		if var_19_1.topAmountValue > 0 then
			table.insert(var_19_0, {
				id = var_19_1.id,
				num = var_19_1.topAmountValue
			})
		end
	end

	HeroAction.AddHeroExp(self.heroInfo_.id, var_19_0)
end

function HeroUpgradeView:SendBreakToServer()
	HeroTools.CalFinalAttribute(var_0_2)
	HeroAction.HeroBreak(self.heroInfo_.id)
end

function HeroUpgradeView:OnAddHeroExp(arg_21_1)
	if isSuccess(arg_21_1.result) then
		HeroAction.AddHeroExpSuccess(self.heroInfo_.id, self.nextLv_, self.finalExp_)

		if self.nextLv_ > var_0_1 then
			JumpTools.OpenPageByJump("newHeroUpgradeSuccess", {
				heroId = self.heroInfo_.id,
				oldLv = var_0_1,
				oldAttr = var_0_2,
				proxy = self.heroViewProxy_,
				callback = function()
					local var_22_0 = MaterialTools.materialGiveBack(self.cutExpForReward_, ItemConst.STR_ITEM.HERO)

					if #var_22_0 > 0 then
						getReward(formatRewardCfgList(var_22_0))
					end
				end
			})
		end

		var_0_2 = HeroTools.CaculateHeroAttribute(self.heroInfo_, (self.heroViewProxy_:CalHeroEquipAttribute(self.heroInfo_.id)))

		HeroTools.CalFinalAttribute(var_0_2)

		if not self:HaveMaterial() or self.nextLv_ >= self.curLvMax_ or manager.guide:IsPlaying() then
			-- block empty
		elseif self.nextLv_ ~= self.curLvMax_ then
			self:SelectFirstMaterial()
		end
	end
end

function HeroUpgradeView:OnKeyLevelUp()
	self:QuickSelectList()
	self:UpdatePreview()
end

function HeroUpgradeView:UpdatePreview()
	self.fromLevelText_.text = string.format("%d", self.heroInfo_.level)

	local var_24_0 = 0
	local var_24_1 = 0

	for iter_24_0, iter_24_1 in ipairs(self.items_) do
		local var_24_2 = iter_24_1:GetData()

		var_24_0 = var_24_0 + ItemCfg[var_24_2.id].param[1] * var_24_2.topAmountValue
		var_24_2.number = self:GetNumber(var_24_2.id)
		var_24_2.selectStyle = var_24_2.topAmountValue ~= 0

		iter_24_1:SetData(var_24_2)
		iter_24_1:RefreshGray(var_24_2.number == 0 or var_24_2.topAmountValue > 0)

		if var_24_2.number == 0 then
			var_24_1 = var_24_1 + 1
		end
	end

	local var_24_3, var_24_4, var_24_5, var_24_6, var_24_7 = LvTools.CheckHeroExp(self.heroInfo_.level, self.heroInfo_.exp + var_24_0, self.curLvMax_)

	self.finalExp_ = var_24_6
	self.cutExp_ = var_24_7
	self.addExpText_.text = string.format("+%d", var_24_0 - var_24_7)
	self.toLevelText_.text = string.format("%d", var_24_3)

	local var_24_8 = GameLevelSetting[var_24_3].hero_level_exp1

	self.progressText_.text = var_24_3 >= HeroConst.HERO_LV_MAX and "-/-" or string.format("%d/%d", var_24_4, var_24_8)
	self.currentProgressBar_.value = (self.heroInfo_.exp - LvTools.LevelToExp(self.heroInfo_.level, "hero_level_exp1")) / var_24_8
	self.previewProgressBar_.value = var_24_4 / var_24_8

	if var_24_3 > self.heroInfo_.level then
		self.currentProgressBar_.value = 0
	end

	self.addExpController_:SetSelectedState(tostring(var_24_0 - var_24_7 ~= 0))

	if self.nextLv_ ~= var_24_3 then
		self.nextLv_ = var_24_3

		self:UpdatePreviewAttr()
	end

	SetActive(self.maxText_, var_24_3 >= self.curLvMax_)
end

function HeroUpgradeView:InitMaterialItem()
	self.items_ = {}

	for iter_25_0, iter_25_1 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		local var_25_0 = self[string.format("itemGo%d_", iter_25_0)]

		SetActive(var_25_0, true)

		local var_25_1 = CommonItemView.New(var_25_0)

		table.insert(self.items_, var_25_1)

		local var_25_2 = clone(ItemTemplateData)

		var_25_2.id = iter_25_1
		var_25_2.number = self:GetNumber(iter_25_1)
		var_25_2.topAmountValue = 0

		function var_25_2:longClickFun(arg_26_1, arg_26_2)
			if arg_26_2.dragging then
				return false
			end

			if self.number == 0 then
				ShowPopItem(POP_SOURCE_ITEM, {
					self.id,
					self.number
				})
			end

			if self.number <= self.topAmountValue or self.cutExp_ >= 0 and self.nextLv_ == self.curLvMax_ or self.topAmountValue == ItemTools.getItemNum(self.id) then
				return false
			end

			self.topAmountValue = self.topAmountValue + 1

			self:UpdatePreview()

			return true
		end

		function var_25_2:clickAmountFun()
			self.topAmountValue = self.topAmountValue - 1

			self:UpdatePreview()

			return true
		end

		var_25_1:SetData(var_25_2)
	end
end

function HeroUpgradeView:InitPropItem()
	self.propNames_ = {
		self.propName1_,
		self.propName2_,
		self.propName3_,
		self.propName4_
	}
	self.propItems_ = {
		self.propNum1_,
		self.propNum2_,
		self.propNum3_,
		self.propNum4_
	}
	self.toPropItems_ = {
		self.toPropNum1_,
		self.toPropNum2_,
		self.toPropNum3_,
		self.toPropNum4_
	}
	self.arrowItems_ = {
		self.arrowItem1_,
		self.arrowItem2_,
		self.arrowItem3_,
		self.arrowItem4_
	}
	self.propIcon_ = {
		self.propIcon1_,
		self.propIcon2_,
		self.propIcon3_,
		self.propIcon4_
	}
	self.propIndexes_ = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}
	self.endfixes_ = {}

	for iter_28_0 = 1, 4 do
		local var_28_0, var_28_1, var_28_2 = SkillTools.GetAttr({
			self.propIndexes_[iter_28_0],
			0
		})

		self.propNames_[iter_28_0].text = GetI18NText(var_28_0)
		self.propIcon_[iter_28_0].sprite = var_28_2
		self.endfixes_[iter_28_0] = PublicAttrCfg[self.propIndexes_[iter_28_0]].percent == 1 and "%" or ""
	end
end

function HeroUpgradeView:UpdateBreakView()
	var_0_2 = HeroTools.CaculateHeroAttribute(self.heroInfo_, {})

	HeroTools.CalFinalAttribute(var_0_2)

	self.fromBreakLevelText_.text = self.breakCfg_.max_level

	if self.nextBreakCfg_ then
		self.toBreakLevelText_.text = self.nextBreakCfg_.max_level
	end

	self.fromCritText_.text = string.format("%.2f", var_0_2[HeroConst.HERO_ATTRIBUTE.CRITICAL] / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")

	local var_29_0 = deepClone(self.heroInfo_)

	var_29_0.break_level = var_29_0.break_level + 1

	local var_29_1 = HeroTools.CaculateHeroAttribute(var_29_0, {})

	HeroTools.CalFinalAttribute(var_29_1)

	self.toCritText_.text = string.format("%.2f", var_29_1[HeroConst.HERO_ATTRIBUTE.CRITICAL] / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")

	self:CheckCanBreak()
end

function HeroUpgradeView:CheckCanBreak()
	self.canBreak_ = true

	local var_30_0

	if PlayerData:GetPlayerInfo().userLevel >= self.breakCfg_.user_level then
		var_30_0 = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), self.breakCfg_.user_level)

		self.conditionBreakController_:SetSelectedState("achieve")
	else
		var_30_0 = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), self.breakCfg_.user_level)
		self.canBreak_ = false

		self.conditionBreakController_:SetSelectedState("unsuccessful")
	end

	self.conditionText_.text = var_30_0

	for iter_30_0 = 1, 3 do
		if iter_30_0 <= #self.breakCfg_.cost then
			if not self.breakItems_[iter_30_0] then
				SetActive(self["breakItemGo" .. iter_30_0 .. "_"], true)
				table.insert(self.breakItems_, (NewHeroBreakMaterialItem.New(self, self["breakItemGo" .. iter_30_0 .. "_"])))
			end

			self.breakItems_[iter_30_0]:SetInfo(self.breakCfg_.cost[iter_30_0][1], self.breakCfg_.cost[iter_30_0][2])

			if not self.breakItems_[iter_30_0]:IsEnough() then
				self.canBreak_ = false
			end
		else
			SetActive(self["breakItemGo" .. iter_30_0 .. "_"], false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.breakItemContent_)

	while #self.breakCfg_.cost < #self.breakItems_ do
		self.breakItems_[#self.breakItems_]:Dispose()
		table.remove(self.breakItems_, #self.breakItems_)
	end

	self.needNumText_.text = string.format("%d", self.breakCfg_.cost_gold)

	if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) >= self.breakCfg_.cost_gold then
		self.moneyEnoughController_:SetSelectedState("true")
	else
		self.moneyEnoughController_:SetSelectedState("false")

		self.canBreak_ = false
	end

	self.canBreakController_:SetSelectedState(tostring(PlayerData:GetPlayerInfo().userLevel >= self.breakCfg_.user_level))
end

function HeroUpgradeView:OnTop()
	self:UpdateBar()

	self.heroInfo_ = self.heroViewProxy_:GetHeroData(self.params_.heroId)

	if HeroTools.GetHeroMaxLevel(self.heroInfo_) <= self.heroInfo_.level then
		JumpTools.Back()

		return
	end

	self:CheckCanBreak()
end

function HeroUpgradeView:HaveMaterial()
	for iter_32_0, iter_32_1 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		if ItemTools.getItemNum(iter_32_1) > 0 then
			return true
		end
	end

	return false
end

function HeroUpgradeView:HaveBreakMaterial()
	for iter_33_0 = 1, #self.breakCfg_.cost do
		if not self.breakItems_[iter_33_0]:IsEnough() then
			return false
		end
	end

	return true
end

function HeroUpgradeView:SelectFirstMaterial()
	for iter_34_0 = 1, #self.items_ do
		local var_34_0 = self.items_[iter_34_0]:GetData()

		var_34_0.selectNum_ = 0

		local var_34_1

		if HeroUpgradeView:GetNumber(var_34_0.id) > 0 and true then
			var_34_1 = false
			var_34_0.topAmountValue = 1

			self.items_[iter_34_0]:SetData(var_34_0)
			self.items_[iter_34_0]:RefreshGray(var_34_0.number == 0)
		else
			var_34_0.topAmountValue = 0

			self.items_[iter_34_0]:SetData(var_34_0)
			self.items_[iter_34_0]:RefreshGray(var_34_0.number == 0)
		end
	end

	self:UpdatePreview()
end

function HeroUpgradeView:UpdateBar()
	if self.type_ == "lvUp" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_GOLD
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	end
end

function HeroUpgradeView:OnEnter()
	self.heroViewProxy_ = self.params_.proxy

	self:UpdateView()
	self:RegistEventListener(HERO_DATA_MODIFY, handler(self, self.OnHeroModify))
end

function HeroUpgradeView:GetNumber(arg_37_1)
	return ItemTools.getItemNum(arg_37_1)
end

function HeroUpgradeView:OnMaterialModify(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(self.items_) do
		local var_38_0 = iter_38_1:GetData()

		if var_38_0.id == arg_38_1 then
			var_38_0.number = self:GetNumber(arg_38_1)
			var_38_0.topAmountValue = 0

			iter_38_1:SetData(var_38_0)
			self.items_[iter_38_0]:RefreshGray(var_38_0.number == 0)
		end
	end
end

function HeroUpgradeView:QuickSelectList()
	local var_39_0 = LvTools.LevelToExp(self.curLvMax_, "hero_level_exp1") - self.heroInfo_.exp
	local var_39_1 = {}

	for iter_39_0 = 1, #self.items_ do
		local var_39_2 = self.items_[iter_39_0]:GetData()

		var_39_1[iter_39_0] = math.max(math.min(math.ceil(var_39_0 / ItemCfg[var_39_2.id].param[1]), var_39_2.number), 0)
		var_39_0 = var_39_0 - var_39_1[iter_39_0] * ItemCfg[var_39_2.id].param[1]

		if var_39_0 < 0 and iter_39_0 > 1 then
			for iter_39_1 = iter_39_0 - 1, 1, -1 do
				local var_39_3 = ItemCfg[self.items_[iter_39_1]:GetData().id].param[1]
				local var_39_4 = math.modf(-var_39_0 / var_39_3)

				var_39_1[iter_39_1] = math.max(0, var_39_1[iter_39_1] - var_39_4)
				var_39_0 = var_39_0 + var_39_3 * math.min(var_39_1[iter_39_1], var_39_4)
			end
		end

		if var_39_0 <= 0 then
			break
		end
	end

	for iter_39_2 = 1, #self.items_ do
		if var_39_1[iter_39_2] == nil then
			var_39_1[iter_39_2] = 0
		end

		self.items_[iter_39_2]:GetData().topAmountValue = var_39_1[iter_39_2]
		self.selectStyle = var_39_1[iter_39_2] ~= 0
	end
end

function HeroUpgradeView:UpdatePreviewAttr()
	var_0_2 = self.heroViewProxy_:GetHeroAllAttribute(self.heroInfo_.id)
	var_0_3 = self:GetPreviewAttribute(self.heroInfo_.id)

	for iter_40_0, iter_40_1 in pairs(self.propItems_) do
		local var_40_0 = PublicAttrCfg[self.propIndexes_[iter_40_0]].percent == 1
		local var_40_1 = var_0_2[self.propIndexes_[iter_40_0]] or 0
		local var_40_2 = var_0_3[self.propIndexes_[iter_40_0]]

		SetActive(self.toPropItems_[iter_40_0].gameObject, var_0_3[self.propIndexes_[iter_40_0]] - var_40_1 ~= 0)
		SetActive(self.arrowItems_[iter_40_0], var_40_2 - var_40_1 ~= 0)

		iter_40_1.text = var_40_0 and string.format("%.2f", var_40_1 / 10) .. self.endfixes_[iter_40_0] or math.floor(var_40_1)
		self.toPropItems_[iter_40_0].text = var_40_0 and string.format("%.2f", var_40_2 / 10) .. self.endfixes_[iter_40_0] or math.floor(var_40_2)
	end
end

function HeroUpgradeView:UpdateView()
	self.heroInfo_ = self.heroViewProxy_:GetHeroData(self.params_.heroId)
	self.heroCfg_ = HeroCfg[self.params_.heroId]

	if self.heroInfo_.level == HeroConst.HERO_LV_MAX then
		self:Back()

		return
	end

	self.curLvMax_ = HeroTools.GetHeroCurrentMaxLevel(self.heroInfo_)
	self.breakCfg_ = HeroTools.GetHeroBreakConfig(self.heroCfg_.race, self.heroInfo_.break_level or 0)
	self.breakIdList_ = HeroBreakCfg.get_id_list_by_race[self.heroCfg_.race]

	if self.heroInfo_.break_level < #self.breakIdList_ - 1 then
		self.nextBreakCfg_ = HeroTools.GetHeroBreakConfig(self.heroCfg_.race, self.heroInfo_.break_level + 1 or 0)
	end

	manager.heroRaiseTrack:SetModelState(self.heroViewProxy_:GetHeroUsingSkinInfo(self.params_.heroId).id)

	self.type_ = self.heroInfo_.level == self.curLvMax_ and "break" or "lvUp"

	self.typeController_:SetSelectedState(self.type_)

	if self.type_ == "lvUp" then
		self:SelectFirstMaterial()

		local var_41_1 = self.heroViewProxy_:GetHeroAllAttribute(self.heroInfo_.id)

		for iter_41_0, iter_41_1 in ipairs(self.propItems_) do
			local var_41_2 = var_41_1[self.propIndexes_[iter_41_0]] or 0

			iter_41_1.text = PublicAttrCfg[self.propIndexes_[iter_41_0]].percent == 1 and string.format("%.2f", var_41_2 / 10) .. self.endfixes_[iter_41_0] or math.floor(var_41_2)
		end
	elseif self.type_ == "break" then
		self:UpdateBreakView()
	end

	self:UpdateBar()
end

function HeroUpgradeView:GetPreviewAttribute(arg_42_1)
	local var_42_0 = deepClone(self.heroViewProxy_:GetHeroData(arg_42_1))
	local var_42_1 = {}

	for iter_42_0, iter_42_1 in pairs(var_42_0.equip) do
		if iter_42_1.equip_id ~= 0 then
			table.insert(var_42_1, EquipData:GetEquipData(iter_42_1.equip_id))
		end
	end

	var_42_0.level = self.nextLv_

	if var_42_0.servant_uid ~= 0 then
		local var_42_2 = WeaponServantData.GetWeaponServantList()[var_42_0.servant_uid]

		var_42_0.servantInfo = {
			id = var_42_2.id,
			stage = var_42_2.stage
		}
	else
		var_42_0.servantInfo = nil
	end

	local var_42_3 = GetHeroFinalAttr(var_42_0, var_42_0.servantInfo, var_42_1)

	var_42_3[HeroConst.HERO_ATTRIBUTE.ATK] = (var_42_3[HeroConst.HERO_ATTRIBUTE.ATK] or 0) * (1 + (var_42_3[11] or 0) / 1000 + (var_42_3[13] or 0) / 1000) + (var_42_3[12] or 0)
	var_42_3[HeroConst.HERO_ATTRIBUTE.ARM] = (var_42_3[HeroConst.HERO_ATTRIBUTE.ARM] or 0) * (1 + (var_42_3[21] or 0) / 1000) + (var_42_3[22] or 0)
	var_42_3[HeroConst.HERO_ATTRIBUTE.STA] = (var_42_3[HeroConst.HERO_ATTRIBUTE.STA] or 0) * (1 + (var_42_3[31] or 0) / 1000) + (var_42_3[32] or 0)

	return var_42_3
end

function HeroUpgradeView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function HeroUpgradeView:OnHeroModify(arg_44_1)
	if arg_44_1 == self.heroInfo_.id then
		self:UpdateView()
	end
end

function HeroUpgradeView:Dispose()
	if self.breakItems_ then
		for iter_45_0, iter_45_1 in pairs(self.breakItems_) do
			iter_45_1:Dispose()
		end

		self.breakItems_ = nil
	end

	if self.items_ then
		for iter_45_2, iter_45_3 in pairs(self.items_) do
			iter_45_3:Dispose()
		end

		self.items_ = nil
	end

	if self.tweens_ then
		self.tweens_ = {}
	end

	self:RemoveAllListeners()
	HeroUpgradeView.super.Dispose(self)
end

return HeroUpgradeView
