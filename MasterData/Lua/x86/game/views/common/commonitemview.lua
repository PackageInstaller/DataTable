local CommonItemView = class("CommonItemView", ReduxView)

function CommonItemView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.info_ = {}
	self.oldInfo_ = {}

	self:InitUI(arg_1_2)
end

function CommonItemView:InitUI(arg_2_1)
	self:BindCfgUI()
	self:AddListeners()

	self.iconImageObj_ = self.iconImage_.gameObject
	self.itemCanvasGroup_ = self.itemCanvasGroup_ or self.transform_:Find("panelItem"):GetComponent("CanvasGroup")
	self.emptyController_ = self.controllerExCollection_:GetController("empty")
	self.typeController_ = self.controllerExCollection_:GetController("type")
	self.rareController_ = self.controllerExCollection_:GetController("quality")
	self.starController_ = self.controllerExCollection_:GetController("star")
	self.grayController_ = self.controllerExCollection_:GetController("gray")
	self.bottomAmountController_ = self.controllerExCollection_:GetController("textcom")
	self.raceController_ = self.controllerExCollection_:GetController("camp")
	self.lockController_ = self.controllerExCollection_:GetController("notunlock")
	self.lockEquipController_ = self.controllerExCollection_:GetController("lock")
	self.leftHeroController_ = self.controllerExCollection_:GetController("heroHead")
	self.selectController_ = self.controllerExCollection_:GetController("select")
	self.selectController2_ = self.controllerExCollection_:GetController("select2")
	self.highLightController_ = self.controllerExCollection_:GetController("award")
	self.completedController_ = self.controllerExCollection_:GetController("completed")
	self.rightHeroController_ = self.controllerExCollection_:GetController("using")
	self.countdownController_ = self.controllerExCollection_:GetController("time")
	self.favouriteController_ = self.controllerExCollection_:GetController("like")
	self.topAmountController_ = self.controllerExCollection_:GetController("btnamount")
	self.infoBtnController_ = self.controllerExCollection_:GetController("btnlook")
	self.gradeController_ = self.controllerExCollection_:GetController("grade")
	self.surpassController_ = self.controllerExCollection_:GetController("surpass")
	self.bottomTextController_ = self.controllerExCollection_:GetController("deplete")
	self.ownedController_ = self.controllerExCollection_:GetController("owned")
	self.equipPosController_ = self.controllerExCollection_:GetController("bgequip")
	self.transformController_ = self.controllerExCollection_:GetController("transform")

	if not arg_2_1 then
		self:ResetTransform()
	end

	self:AddDragEvent()
end

local function var_0_1(arg_3_0)
	if not arg_3_0 then
		return nil
	end

	if arg_3_0[1] ~= nil and arg_3_0.id == nil then
		return cfgToItemTemplate(arg_3_0)
	end

	if arg_3_0.num ~= nil and arg_3_0.number == nil then
		return rewardToItemTemplate(arg_3_0)
	end

	return clone(arg_3_0)
end

function CommonItemView:SetData(arg_4_1)
	self.oldInfo_ = self.info_
	self.info_ = var_0_1(arg_4_1)

	self:RefreshUI()
end

function CommonItemView:GetData()
	return self.info_
end

function CommonItemView:RefreshUI()
	self:RefreshEmptyState()

	if self.info_ == nil then
		return
	end

	if self.info_.id == nil then
		return
	end

	self:RefreshRace(self.info_.race or 0)
	self:RefreshLeftHeroHead(self.info_.bindHeroID or 0)
	self:RefreshEquipLock(self.info_.equipedLocked)
	self:RefreshFavourite(self.info_.favouriteFlag)
	self:RefreshLock(self.info_.locked)
	self:RefreshRightHeroHead(self.info_.equipedHeroID)
	self:RefreshInfoBtn(self.info_.infoBtnFlag)
	self:RefreshTopAmount(self.info_.topAmountValue)
	self:RefreshCountdown(self.info_)
	self:RefreshTransform(self.info_.transform)

	if not self.oldInfo_ or self.oldInfo_.id ~= self.info_.id then
		self:RefreshGrade()
		self:RefreshStar()
		self:RefreshType()
		self:RefreshEquipPos()
		self:RefreshIcon()
		self:RefreshRareBg()
	end

	self:RefreshHighLight(self.info_.highLight)
	self:RefreshSelectState(self.info_.selectStyle)
	self:RefreshSelectState2(self.info_.selectStyle2)
	self:RefreshCompleted(self.info_.completedFlag)
	self:RefreshOwned(self.info_.ownedFlag)
	self:RefreshGray(self.info_.grayFlag)
	self:RefreshBottomAmountText()
	self:RefreshBottomText(self.info_.bottomText)
	self:RefreshSurpass(self.info_.addLevel)
	self:RefreshBottomRightText(self.info_.hideBottomRightTextFlag)
	self:RefreshClickBtn()
	self:RefreshAnimator(self.info_.animatorType)
end

function CommonItemView:AddListeners()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.info_.clickFun then
			self.info_:clickFun()
		end
	end)
	self:AddPressingByTimeListener(self.longClickGo_, 3, 0.5, 0.2, function(arg_9_0, arg_9_1, arg_9_2)
		if self.info_.longClickFun then
			return (self.info_:longClickFun(arg_9_0, arg_9_1, arg_9_2))
		end

		return false
	end)
	self:AddPressingByTimeListener(self.topAmountGo_, 3, 0.5, 0.2, function(arg_10_0, arg_10_1, arg_10_2)
		if self.info_.clickAmountFun then
			return (self.info_:clickAmountFun(arg_10_0, arg_10_1, arg_10_2))
		end

		return false
	end)
	self:AddBtnListener(self.infoBtn_, nil, function(arg_11_0, arg_11_1)
		if self.info_.clickInfoFun then
			return (self.info_:clickInfoFun(arg_11_0, arg_11_1))
		end
	end)
end

function CommonItemView:ResetTransform()
	self.transform_.localPosition = Vector3.zero
	self.transform_.localScale = Vector3(1, 1, 1)
	self.transform_.localEulerAngles = Vector3.zero
end

function CommonItemView:RefreshEmptyState()
	if self.info_ == nil then
		self.emptyController_:SetSelectedState("on")
	else
		self.emptyController_:SetSelectedState("off")
	end
end

function CommonItemView:RefreshType()
	local var_14_0 = "material"

	var_14_0 = (ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.CURRENCY or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.MATERIAL or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.PROPS or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.GIFT or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.ARCHIVE_GIFT or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.DORM_FURNITURE or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.CANTEEN_INGREDIENTS) and "material" or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.HERO_PIECE and "heroPiece" or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.EQUIP and "equip" or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.HERO and "hero" or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.HERO_SKIN and "heroSkin" or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT and "weaponServant" or var_14_0

	self.typeController_:SetSelectedState(var_14_0)
end

function CommonItemView:RefreshIcon()
	local var_15_0 = ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.EQUIP

	SetActive(self.iconImageObj_, false)
	ItemTools.GetItemSpriteAsync(self.info_.id, function(arg_16_0, arg_16_1)
		SetActive(self.iconImageObj_, true)

		if self.gameObject_ == nil then
			return
		end

		if self.info_ and arg_16_0 == self.info_.id then
			self.iconImage_.sprite = arg_16_1
		end
	end, nil, var_15_0)
end

function CommonItemView:RefreshEquipPos()
	if ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.EQUIP then
		self.equipPosController_:SetSelectedState(tostring(EquipCfg[self.info_.id].pos))
	else
		self.equipPosController_:SetSelectedState("off")
	end
end

function CommonItemView:RefreshRareBg()
	self.rareController_:SetSelectedState(ItemCfg[self.info_.id].display_rare)
end

function CommonItemView:RefreshStar()
	if ItemCfg[self.info_.id].type ~= ItemConst.ITEM_TYPE.EQUIP then
		if ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			self.starController_:SetSelectedState("0" .. tostring(ItemCfg[self.info_.id].display_rare))

			goto label_19_0
		end
	end

	self.starController_:SetSelectedState("off")

	::label_19_0::
end

function CommonItemView:RefreshGrade()
	if ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.HERO then
		self.gradeController_:SetSelectedState("on")

		self.gradeImage_.sprite = getSprite("Atlas/SystemHeroGradeAtlas", "com_grade_" .. HeroStarCfg[HeroCfg[self.info_.id].unlock_star].star)
	else
		self.gradeController_:SetSelectedState("off")
	end
end

function CommonItemView:RefreshTopAmount(arg_21_1)
	if arg_21_1 and arg_21_1 > 0 then
		self.topAmountController_:SetSelectedState("on")
	else
		self.topAmountController_:SetSelectedState("off")
		self:StopLongClickTimer()
	end

	self.topAmountText_.text = arg_21_1
	self.info_.topAmountValue = arg_21_1

	self:RefreshGrayInner()
end

function CommonItemView:RefreshBottomAmountText()
	self:RefreshBottomRightText()

	if ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.EQUIP then
		if self.info_.equipLevel then
			self:SetBottomAmountText(GetTips("LEVEL") .. self.info_.equipLevel)
		end
	elseif ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		if self.info_.uid == nil and self.info_.number ~= nil then
			self:SetBottomAmountText(self.info_.number)
		end
	elseif self.info_.number ~= nil then
		self:SetBottomAmountText(self.info_.number)
	end
end

function CommonItemView:SetBottomAmountText(arg_23_1)
	self.info_.number = arg_23_1

	if type(arg_23_1) == "number" then
		arg_23_1 = formatNumber(arg_23_1)
	end

	self.bottomAmountText_.text = arg_23_1

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.bottomAmountText_.transform)
end

function CommonItemView:RefreshBottomRightText(arg_24_1)
	arg_24_1 = ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.EQUIP and (self.info_.equipLevel and (arg_24_1 or false) or true) or ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT and (self.info_.uid == nil and self.info_.number ~= nil and (arg_24_1 or false) or true) or arg_24_1 or self.info_.number == nil

	self.bottomAmountController_:SetSelectedState(arg_24_1 and "off" or "on")
end

function CommonItemView:RefreshBottomText(arg_25_1)
	if type(arg_25_1) == "table" and #arg_25_1 > 0 then
		local var_25_0 = arg_25_1[1]
		local var_25_1 = arg_25_1[2]

		self.bottomText_.text = (arg_25_1[2] == nil or var_25_1 == 0) and var_25_0 or var_25_0 < var_25_1 and string.format("<color=#%s>%s</color>/%s", (arg_25_1[3] or nil) and (arg_25_1[3] or ColorConst.RED_HEX), formatNumber(var_25_0), formatNumber(var_25_1)) or string.format("%s/%s", formatNumber(var_25_0), formatNumber(var_25_1))
	elseif type(arg_25_1) == "number" then
		self.bottomText_.text = formatNumber(arg_25_1)
	elseif type(arg_25_1) == "string" then
		self.bottomText_.text = arg_25_1
	else
		self.bottomTextController_:SetSelectedState("off")

		return
	end

	self.bottomTextController_:SetSelectedState("on")
end

function CommonItemView:RefreshSurpass(arg_26_1)
	if arg_26_1 and arg_26_1 > 0 then
		self.surpassController_:SetSelectedState("on")

		self.surpassText_.text = arg_26_1
	else
		self.surpassController_:SetSelectedState("off")
	end

	self.info_.addLevel = arg_26_1
end

function CommonItemView:RefreshRace(arg_27_1)
	if ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.HERO then
		arg_27_1 = HeroCfg[self.info_.id].race
	elseif ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.HERO_PIECE then
		arg_27_1 = HeroCfg[ItemCfg[self.info_.id].hero_id].race
	elseif ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_27_1 = WeaponServantCfg[self.info_.id].race
	end

	if arg_27_1 == 0 then
		self.raceController_:SetSelectedState("off")
	else
		self.raceController_:SetSelectedState("on")

		self.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[arg_27_1].icon2)
	end

	self.info_.race = arg_27_1
end

function CommonItemView:RefreshRightHeroHead(arg_28_1)
	if arg_28_1 and arg_28_1 ~= 0 then
		self.rightHeroController_:SetSelectedState("true")

		self.rightHeroImage_.sprite = HeroTools.GetSmallHeadSprite(arg_28_1)
	else
		self.rightHeroController_:SetSelectedState("false")
	end

	self.info_.equipedHeroID = arg_28_1
end

function CommonItemView:RefreshLeftHeroHead(arg_29_1)
	if arg_29_1 ~= 0 then
		self.leftHeroController_:SetSelectedState("on")

		self.leftHeroImage_.sprite = HeroTools.GetSmallHeadSprite(arg_29_1)

		if self.info_.race ~= 0 and ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.EQUIP then
			self.raceController_:SetSelectedState("off")
		end
	else
		self.leftHeroController_:SetSelectedState("off")
	end

	self.info_.bindHeroID = arg_29_1
end

function CommonItemView:RefreshLock(arg_30_1)
	self.lockController_:SetSelectedState(arg_30_1 and "on" or "off")

	self.info_.locked = arg_30_1

	self:RefreshGrayInner()
end

function CommonItemView:RefreshEquipLock(arg_31_1)
	self.lockEquipController_:SetSelectedState(arg_31_1 and "on" or "off")

	self.info_.equipedLocked = arg_31_1
end

function CommonItemView:RefreshCountdown(arg_32_1)
	local var_32_0 = ItemTools.GetItemExpiredTimeByInfo(arg_32_1)

	if var_32_0 and var_32_0 > 0 and arg_32_1.need_count_down then
		self.countdownController_:SetSelectedState("on")

		self.timeText_.text = arg_32_1.count_down_time_text and arg_32_1.count_down_time_text or ItemTools.GetItemCountdownText(var_32_0, arg_32_1.count_down_use_floor)
	else
		self.countdownController_:SetSelectedState("false")
	end
end

function CommonItemView:RefreshTransform(arg_33_1)
	if not self.transformController_ then
		return
	end

	self.transformController_:SetSelectedState(arg_33_1 and "on" or "off")
end

function CommonItemView:RefreshFavourite(arg_34_1)
	self.favouriteController_:SetSelectedState(arg_34_1 and "on" or "off")

	self.info_.favouriteFlag = arg_34_1
end

function CommonItemView:RefreshInfoBtn(arg_35_1)
	self.infoBtnController_:SetSelectedState(arg_35_1 and "on" or "off")

	self.info_.infoBtnFlag = arg_35_1
end

function CommonItemView:RefreshGray(arg_36_1)
	self.grayController_:SetSelectedState(arg_36_1 and "on" or "off")

	self.info_.grayFlag = arg_36_1
end

function CommonItemView:RefreshGrayInner()
	local var_37_0

	if not self.info_.locked and not self.info_.completedFlag and not self.info_.selectStyle then
		if tonumber(self.info_.topAmountValue or 0) > 0 or self.info_.ownedFlag then
			var_37_0 = true
		end
	end

	self.info_.grayFlag = var_37_0 or self.info_.grayFlag

	self.grayController_:SetSelectedState(var_37_0 and "on" or "off")
end

function CommonItemView:RefreshHighLight(arg_38_1)
	self.highLightController_:SetSelectedState(arg_38_1 and "on" or "off")

	self.info_.highLight = highLight
end

function CommonItemView:RefreshSelectState(arg_39_1)
	if arg_39_1 == true then
		self.selectController_:SetSelectedState("1")
	else
		self.selectController_:SetSelectedState("off")
	end

	self.info_.selectStyle = arg_39_1

	self:RefreshGrayInner()
end

function CommonItemView:RefreshSelectState2(arg_40_1)
	if arg_40_1 == true then
		self.selectController2_:SetSelectedState("true")
	else
		self.selectController2_:SetSelectedState("false")
	end

	self.info_.selectStyle2 = arg_40_1
end

function CommonItemView:RefreshCompleted(arg_41_1)
	self.completedController_:SetSelectedState(arg_41_1 and "on" or "off")

	self.info_.completedFlag = arg_41_1

	self:RefreshGrayInner()
end

function CommonItemView:RefreshOwned(arg_42_1)
	self.ownedController_:SetSelectedState(arg_42_1 and "on" or "off")

	self.info_.ownedFlag = arg_42_1

	self:RefreshGrayInner()
end

function CommonItemView:RefreshClickBtn()
	if self.info_.clickFun then
		SetActive(self.clickBtn_.gameObject, true)
	else
		SetActive(self.clickBtn_.gameObject, false)
	end

	if self.info_.longClickFun then
		SetActive(self.longClickGo_, true)
	else
		SetActive(self.longClickGo_, false)
	end
end

function CommonItemView:RefreshAnimator(arg_44_1)
	if self.oldAnimatorType_ == arg_44_1 then
		return
	end

	if arg_44_1 == ItemConst.ITEM_ANIMATOR_TYPE.NULL then
		self.itemCanvasGroup_.alpha = 1
		self.animator_.enabled = true

		if self.gameObject_.activeInHierarchy == true then
			self.animator_:Update(0)
		end

		self.animator_.runtimeAnimatorController = nil
	else
		self.animator_.enabled = true

		if arg_44_1 == ItemConst.ITEM_ANIMATOR_TYPE.NORMAL then
			self.animator_.runtimeAnimatorController = Asset.Load("AnimatorController/CommonItem/CommonItem")

			if self.gameObject_.activeInHierarchy == true then
				self.animator_:Update(0)
			end
		elseif arg_44_1 == ItemConst.ITEM_ANIMATOR_TYPE.ADVANCED then
			self.animator_.runtimeAnimatorController = Asset.Load("AnimatorController/CommonItem/CommonItem2")

			if self.gameObject_.activeInHierarchy == true then
				self.animator_:Update(0)
			end
		end
	end

	self.oldAnimatorType_ = arg_44_1

	if self.info_ then
		self.info_.animatorType = arg_44_1
	end
end

function CommonItemView:AddDragEvent()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.DragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
end

function CommonItemView:RemoveDragEvent()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
end

function CommonItemView:BeginDragFun(arg_47_1, arg_47_2)
	if self.info_.beginDragFun then
		self.info_.beginDragFun(arg_47_1, arg_47_2)
	end
end

function CommonItemView:DragFun(arg_48_1, arg_48_2)
	if self.info_.dragFun then
		self.info_.dragFun(arg_48_1, arg_48_2)
	end
end

function CommonItemView:EndDragFun(arg_49_1, arg_49_2)
	if self.info_.endDragFun then
		self.info_.endDragFun(arg_49_1, arg_49_2)
	end
end

function CommonItemView:Show(arg_50_1)
	SetActive(self.gameObject_, arg_50_1)
end

function CommonItemView:Dispose()
	self:RemoveDragEvent()
	CommonItemView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
	self.oldInfo_ = nil
end

return CommonItemView
