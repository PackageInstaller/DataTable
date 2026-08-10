local var_0_0 = class("CommonItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.info_ = {}
	arg_1_0.oldInfo_ = {}

	arg_1_0:InitUI(arg_1_2)
end

function var_0_0.InitUI(arg_2_0, arg_2_1)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.iconImageObj_ = arg_2_0.iconImage_.gameObject
	arg_2_0.itemCanvasGroup_ = arg_2_0.itemCanvasGroup_ or arg_2_0.transform_:Find("panelItem"):GetComponent("CanvasGroup")
	arg_2_0.emptyController_ = arg_2_0.controllerExCollection_:GetController("empty")
	arg_2_0.typeController_ = arg_2_0.controllerExCollection_:GetController("type")
	arg_2_0.rareController_ = arg_2_0.controllerExCollection_:GetController("quality")
	arg_2_0.starController_ = arg_2_0.controllerExCollection_:GetController("star")
	arg_2_0.grayController_ = arg_2_0.controllerExCollection_:GetController("gray")
	arg_2_0.bottomAmountController_ = arg_2_0.controllerExCollection_:GetController("textcom")
	arg_2_0.raceController_ = arg_2_0.controllerExCollection_:GetController("camp")
	arg_2_0.lockController_ = arg_2_0.controllerExCollection_:GetController("notunlock")
	arg_2_0.lockEquipController_ = arg_2_0.controllerExCollection_:GetController("lock")
	arg_2_0.leftHeroController_ = arg_2_0.controllerExCollection_:GetController("heroHead")
	arg_2_0.selectController_ = arg_2_0.controllerExCollection_:GetController("select")
	arg_2_0.selectController2_ = arg_2_0.controllerExCollection_:GetController("select2")
	arg_2_0.highLightController_ = arg_2_0.controllerExCollection_:GetController("award")
	arg_2_0.completedController_ = arg_2_0.controllerExCollection_:GetController("completed")
	arg_2_0.rightHeroController_ = arg_2_0.controllerExCollection_:GetController("using")
	arg_2_0.countdownController_ = arg_2_0.controllerExCollection_:GetController("time")
	arg_2_0.favouriteController_ = arg_2_0.controllerExCollection_:GetController("like")
	arg_2_0.topAmountController_ = arg_2_0.controllerExCollection_:GetController("btnamount")
	arg_2_0.infoBtnController_ = arg_2_0.controllerExCollection_:GetController("btnlook")
	arg_2_0.gradeController_ = arg_2_0.controllerExCollection_:GetController("grade")
	arg_2_0.surpassController_ = arg_2_0.controllerExCollection_:GetController("surpass")
	arg_2_0.bottomTextController_ = arg_2_0.controllerExCollection_:GetController("deplete")
	arg_2_0.ownedController_ = arg_2_0.controllerExCollection_:GetController("owned")
	arg_2_0.equipPosController_ = arg_2_0.controllerExCollection_:GetController("bgequip")
	arg_2_0.transformController_ = arg_2_0.controllerExCollection_:GetController("transform")

	if not arg_2_1 then
		arg_2_0:ResetTransform()
	end

	arg_2_0:AddDragEvent()
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

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.oldInfo_ = arg_4_0.info_
	arg_4_0.info_ = var_0_1(arg_4_1)

	arg_4_0:RefreshUI()
end

function var_0_0.GetData(arg_5_0)
	return arg_5_0.info_
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0:RefreshEmptyState()

	if arg_6_0.info_ == nil then
		return
	end

	if arg_6_0.info_.id == nil then
		return
	end

	arg_6_0:RefreshRace(arg_6_0.info_.race or 0)
	arg_6_0:RefreshLeftHeroHead(arg_6_0.info_.bindHeroID or 0)
	arg_6_0:RefreshEquipLock(arg_6_0.info_.equipedLocked)
	arg_6_0:RefreshFavourite(arg_6_0.info_.favouriteFlag)
	arg_6_0:RefreshLock(arg_6_0.info_.locked)
	arg_6_0:RefreshRightHeroHead(arg_6_0.info_.equipedHeroID)
	arg_6_0:RefreshInfoBtn(arg_6_0.info_.infoBtnFlag)
	arg_6_0:RefreshTopAmount(arg_6_0.info_.topAmountValue)
	arg_6_0:RefreshCountdown(arg_6_0.info_)
	arg_6_0:RefreshTransform(arg_6_0.info_.transform)

	if not arg_6_0.oldInfo_ or arg_6_0.oldInfo_.id ~= arg_6_0.info_.id then
		arg_6_0:RefreshGrade()
		arg_6_0:RefreshStar()
		arg_6_0:RefreshType()
		arg_6_0:RefreshEquipPos()
		arg_6_0:RefreshIcon()
		arg_6_0:RefreshRareBg()
	end

	arg_6_0:RefreshHighLight(arg_6_0.info_.highLight)
	arg_6_0:RefreshSelectState(arg_6_0.info_.selectStyle)
	arg_6_0:RefreshSelectState2(arg_6_0.info_.selectStyle2)
	arg_6_0:RefreshCompleted(arg_6_0.info_.completedFlag)
	arg_6_0:RefreshOwned(arg_6_0.info_.ownedFlag)
	arg_6_0:RefreshGray(arg_6_0.info_.grayFlag)
	arg_6_0:RefreshBottomAmountText()
	arg_6_0:RefreshBottomText(arg_6_0.info_.bottomText)
	arg_6_0:RefreshSurpass(arg_6_0.info_.addLevel)
	arg_6_0:RefreshBottomRightText(arg_6_0.info_.hideBottomRightTextFlag)
	arg_6_0:RefreshClickBtn()
	arg_6_0:RefreshAnimator(arg_6_0.info_.animatorType)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.clickBtn_, nil, function()
		if arg_7_0.info_.clickFun then
			arg_7_0.info_.clickFun(arg_7_0.info_)
		end
	end)
	arg_7_0:AddPressingByTimeListener(arg_7_0.longClickGo_, 3, 0.5, 0.2, function(arg_9_0, arg_9_1, arg_9_2)
		if arg_7_0.info_.longClickFun then
			return (arg_7_0.info_.longClickFun(arg_7_0.info_, arg_9_0, arg_9_1, arg_9_2))
		end

		return false
	end)
	arg_7_0:AddPressingByTimeListener(arg_7_0.topAmountGo_, 3, 0.5, 0.2, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_7_0.info_.clickAmountFun then
			return (arg_7_0.info_.clickAmountFun(arg_7_0.info_, arg_10_0, arg_10_1, arg_10_2))
		end

		return false
	end)
	arg_7_0:AddBtnListener(arg_7_0.infoBtn_, nil, function(arg_11_0, arg_11_1)
		if arg_7_0.info_.clickInfoFun then
			return (arg_7_0.info_.clickInfoFun(arg_7_0.info_, arg_11_0, arg_11_1))
		end
	end)
end

function var_0_0.ResetTransform(arg_12_0)
	arg_12_0.transform_.localPosition = Vector3.zero
	arg_12_0.transform_.localScale = Vector3(1, 1, 1)
	arg_12_0.transform_.localEulerAngles = Vector3.zero
end

function var_0_0.RefreshEmptyState(arg_13_0)
	if arg_13_0.info_ == nil then
		arg_13_0.emptyController_:SetSelectedState("on")
	else
		arg_13_0.emptyController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshType(arg_14_0)
	local var_14_0 = ItemCfg[arg_14_0.info_.id].type
	local var_14_1 = "material"

	var_14_1 = (var_14_0 == ItemConst.ITEM_TYPE.CURRENCY or var_14_0 == ItemConst.ITEM_TYPE.MATERIAL or var_14_0 == ItemConst.ITEM_TYPE.PROPS or var_14_0 == ItemConst.ITEM_TYPE.GIFT or var_14_0 == ItemConst.ITEM_TYPE.ARCHIVE_GIFT or var_14_0 == ItemConst.ITEM_TYPE.DYNAMIC_STICKER or var_14_0 == ItemConst.ITEM_TYPE.DORM_FURNITURE or var_14_0 == ItemConst.ITEM_TYPE.CANTEEN_INGREDIENTS) and "material" or var_14_0 == ItemConst.ITEM_TYPE.HERO_PIECE and "heroPiece" or var_14_0 == ItemConst.ITEM_TYPE.EQUIP and "equip" or var_14_0 == ItemConst.ITEM_TYPE.HERO and "hero" or var_14_0 == ItemConst.ITEM_TYPE.HERO_SKIN and "heroSkin" or var_14_0 == ItemConst.ITEM_TYPE.WEAPON_SERVANT and "weaponServant" or var_14_1

	arg_14_0.typeController_:SetSelectedState(var_14_1)
end

function var_0_0.RefreshIcon(arg_15_0)
	local var_15_0 = false

	if ItemCfg[arg_15_0.info_.id].type == ItemConst.ITEM_TYPE.EQUIP then
		var_15_0 = true
	end

	SetActive(arg_15_0.iconImageObj_, false)
	ItemTools.GetItemSpriteAsync(arg_15_0.info_.id, function(arg_16_0, arg_16_1)
		SetActive(arg_15_0.iconImageObj_, true)

		if arg_15_0.gameObject_ == nil then
			return
		end

		if arg_15_0.info_ and arg_16_0 == arg_15_0.info_.id then
			arg_15_0.iconImage_.sprite = arg_16_1
		end
	end, nil, var_15_0)
end

function var_0_0.RefreshEquipPos(arg_17_0)
	local var_17_0 = ItemCfg[arg_17_0.info_.id].type
	local var_17_1 = "material"

	if var_17_0 == ItemConst.ITEM_TYPE.EQUIP then
		arg_17_0.equipPosController_:SetSelectedState(tostring(EquipCfg[arg_17_0.info_.id].pos))
	else
		arg_17_0.equipPosController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshRareBg(arg_18_0)
	local var_18_0 = ItemCfg[arg_18_0.info_.id]

	arg_18_0.rareController_:SetSelectedState(var_18_0.display_rare)
end

function var_0_0.RefreshStar(arg_19_0)
	local var_19_0 = ItemCfg[arg_19_0.info_.id]

	if var_19_0.type == ItemConst.ITEM_TYPE.EQUIP or var_19_0.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_19_1 = var_19_0.display_rare

		arg_19_0.starController_:SetSelectedState("0" .. tostring(var_19_1))
	else
		arg_19_0.starController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshGrade(arg_20_0)
	if ItemCfg[arg_20_0.info_.id].type == ItemConst.ITEM_TYPE.HERO then
		arg_20_0.gradeController_:SetSelectedState("on")

		local var_20_0 = HeroStarCfg[HeroCfg[arg_20_0.info_.id].unlock_star].star

		arg_20_0.gradeImage_.sprite = getSprite("Atlas/SystemHeroGradeAtlas", "com_grade_" .. var_20_0)
	else
		arg_20_0.gradeController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshTopAmount(arg_21_0, arg_21_1)
	if arg_21_1 and arg_21_1 > 0 then
		arg_21_0.topAmountController_:SetSelectedState("on")
	else
		arg_21_0.topAmountController_:SetSelectedState("off")
		arg_21_0:StopLongClickTimer()
	end

	arg_21_0.topAmountText_.text = arg_21_1
	arg_21_0.info_.topAmountValue = arg_21_1

	arg_21_0:RefreshGrayInner()
end

function var_0_0.RefreshBottomAmountText(arg_22_0)
	arg_22_0:RefreshBottomRightText()

	local var_22_0 = ItemCfg[arg_22_0.info_.id].type

	if var_22_0 == ItemConst.ITEM_TYPE.EQUIP then
		if arg_22_0.info_.equipLevel then
			arg_22_0:SetBottomAmountText(GetTips("LEVEL") .. arg_22_0.info_.equipLevel)
		end
	elseif var_22_0 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		if arg_22_0.info_.uid == nil and arg_22_0.info_.number ~= nil then
			arg_22_0:SetBottomAmountText(arg_22_0.info_.number)
		end
	elseif arg_22_0.info_.number ~= nil then
		arg_22_0:SetBottomAmountText(arg_22_0.info_.number)
	end
end

function var_0_0.SetBottomAmountText(arg_23_0, arg_23_1)
	arg_23_0.info_.number = arg_23_1

	if type(arg_23_1) == "number" then
		arg_23_1 = formatNumber(arg_23_1)
	end

	arg_23_0.bottomAmountText_.text = arg_23_1

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_0.bottomAmountText_.transform)
end

function var_0_0.RefreshBottomRightText(arg_24_0, arg_24_1)
	local var_24_0 = ItemCfg[arg_24_0.info_.id].type

	if var_24_0 == ItemConst.ITEM_TYPE.EQUIP then
		if arg_24_0.info_.equipLevel then
			arg_24_1 = arg_24_1 or false
		else
			arg_24_1 = true
		end
	elseif var_24_0 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		if arg_24_0.info_.uid == nil and arg_24_0.info_.number ~= nil then
			arg_24_1 = arg_24_1 or false
		else
			arg_24_1 = true
		end
	else
		arg_24_1 = arg_24_1 or arg_24_0.info_.number == nil
	end

	arg_24_0.bottomAmountController_:SetSelectedState(arg_24_1 and "off" or "on")
end

function var_0_0.RefreshBottomText(arg_25_0, arg_25_1)
	if type(arg_25_1) == "table" and #arg_25_1 > 0 then
		local var_25_0 = arg_25_1[1]
		local var_25_1 = arg_25_1[2]

		if var_25_1 == nil or var_25_1 == 0 then
			arg_25_0.bottomText_.text = var_25_0
		elseif var_25_0 < var_25_1 then
			local var_25_2 = arg_25_1[3] and arg_25_1[3] or ColorConst.RED_HEX

			arg_25_0.bottomText_.text = string.format("<color=#%s>%s</color>/%s", var_25_2, formatNumber(var_25_0), formatNumber(var_25_1))
		else
			arg_25_0.bottomText_.text = string.format("%s/%s", formatNumber(var_25_0), formatNumber(var_25_1))
		end
	elseif type(arg_25_1) == "number" then
		arg_25_0.bottomText_.text = formatNumber(arg_25_1)
	elseif type(arg_25_1) == "string" then
		arg_25_0.bottomText_.text = arg_25_1
	else
		arg_25_0.bottomTextController_:SetSelectedState("off")

		return
	end

	arg_25_0.bottomTextController_:SetSelectedState("on")
end

function var_0_0.RefreshSurpass(arg_26_0, arg_26_1)
	if arg_26_1 and arg_26_1 > 0 then
		arg_26_0.surpassController_:SetSelectedState("on")

		arg_26_0.surpassText_.text = arg_26_1
	else
		arg_26_0.surpassController_:SetSelectedState("off")
	end

	arg_26_0.info_.addLevel = arg_26_1
end

function var_0_0.RefreshRace(arg_27_0, arg_27_1)
	local var_27_0 = ItemCfg[arg_27_0.info_.id].type

	if var_27_0 == ItemConst.ITEM_TYPE.HERO then
		arg_27_1 = HeroCfg[arg_27_0.info_.id].race
	elseif var_27_0 == ItemConst.ITEM_TYPE.HERO_PIECE then
		local var_27_1 = ItemCfg[arg_27_0.info_.id].hero_id

		arg_27_1 = HeroCfg[var_27_1].race
	elseif var_27_0 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_27_1 = WeaponServantCfg[arg_27_0.info_.id].race
	end

	if arg_27_1 == 0 then
		arg_27_0.raceController_:SetSelectedState("off")
	else
		arg_27_0.raceController_:SetSelectedState("on")

		arg_27_0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[arg_27_1].icon2)
	end

	arg_27_0.info_.race = arg_27_1
end

function var_0_0.RefreshRightHeroHead(arg_28_0, arg_28_1)
	if arg_28_1 and arg_28_1 ~= 0 then
		arg_28_0.rightHeroController_:SetSelectedState("true")

		arg_28_0.rightHeroImage_.sprite = HeroTools.GetSmallHeadSprite(arg_28_1)
	else
		arg_28_0.rightHeroController_:SetSelectedState("false")
	end

	arg_28_0.info_.equipedHeroID = arg_28_1
end

function var_0_0.RefreshLeftHeroHead(arg_29_0, arg_29_1)
	if arg_29_1 ~= 0 then
		arg_29_0.leftHeroController_:SetSelectedState("on")

		arg_29_0.leftHeroImage_.sprite = HeroTools.GetSmallHeadSprite(arg_29_1)

		local var_29_0 = ItemCfg[arg_29_0.info_.id].type

		if arg_29_0.info_.race ~= 0 and var_29_0 == ItemConst.ITEM_TYPE.EQUIP then
			arg_29_0.raceController_:SetSelectedState("off")
		end
	else
		arg_29_0.leftHeroController_:SetSelectedState("off")
	end

	arg_29_0.info_.bindHeroID = arg_29_1
end

function var_0_0.RefreshLock(arg_30_0, arg_30_1)
	arg_30_0.lockController_:SetSelectedState(arg_30_1 and "on" or "off")

	arg_30_0.info_.locked = arg_30_1

	arg_30_0:RefreshGrayInner()
end

function var_0_0.RefreshEquipLock(arg_31_0, arg_31_1)
	arg_31_0.lockEquipController_:SetSelectedState(arg_31_1 and "on" or "off")

	arg_31_0.info_.equipedLocked = arg_31_1
end

function var_0_0.RefreshCountdown(arg_32_0, arg_32_1)
	local var_32_0 = ItemTools.GetItemExpiredTimeByInfo(arg_32_1)

	if var_32_0 and var_32_0 > 0 and arg_32_1.need_count_down then
		arg_32_0.countdownController_:SetSelectedState("on")

		if arg_32_1.count_down_time_text then
			arg_32_0.timeText_.text = arg_32_1.count_down_time_text
		else
			arg_32_0.timeText_.text = ItemTools.GetItemCountdownText(var_32_0, arg_32_1.count_down_use_floor)
		end
	else
		arg_32_0.countdownController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshTransform(arg_33_0, arg_33_1)
	if not arg_33_0.transformController_ then
		return
	end

	arg_33_0.transformController_:SetSelectedState(arg_33_1 and "on" or "off")
end

function var_0_0.RefreshFavourite(arg_34_0, arg_34_1)
	arg_34_0.favouriteController_:SetSelectedState(arg_34_1 and "on" or "off")

	arg_34_0.info_.favouriteFlag = arg_34_1
end

function var_0_0.RefreshInfoBtn(arg_35_0, arg_35_1)
	arg_35_0.infoBtnController_:SetSelectedState(arg_35_1 and "on" or "off")

	arg_35_0.info_.infoBtnFlag = arg_35_1
end

function var_0_0.RefreshGray(arg_36_0, arg_36_1)
	arg_36_0.grayController_:SetSelectedState(arg_36_1 and "on" or "off")

	arg_36_0.info_.grayFlag = arg_36_1
end

function var_0_0.RefreshGrayInner(arg_37_0)
	local var_37_0

	if arg_37_0.info_.locked or arg_37_0.info_.completedFlag or arg_37_0.info_.selectStyle or tonumber(arg_37_0.info_.topAmountValue or 0) > 0 or arg_37_0.info_.ownedFlag then
		var_37_0 = true
	end

	arg_37_0.info_.grayFlag = var_37_0 or arg_37_0.info_.grayFlag

	arg_37_0.grayController_:SetSelectedState(var_37_0 and "on" or "off")
end

function var_0_0.RefreshHighLight(arg_38_0, arg_38_1)
	arg_38_0.highLightController_:SetSelectedState(arg_38_1 and "on" or "off")

	arg_38_0.info_.highLight = highLight
end

function var_0_0.RefreshSelectState(arg_39_0, arg_39_1)
	if arg_39_1 == true then
		arg_39_0.selectController_:SetSelectedState("1")
	else
		arg_39_0.selectController_:SetSelectedState("off")
	end

	arg_39_0.info_.selectStyle = arg_39_1

	arg_39_0:RefreshGrayInner()
end

function var_0_0.RefreshSelectState2(arg_40_0, arg_40_1)
	if arg_40_1 == true then
		arg_40_0.selectController2_:SetSelectedState("true")
	else
		arg_40_0.selectController2_:SetSelectedState("false")
	end

	arg_40_0.info_.selectStyle2 = arg_40_1
end

function var_0_0.RefreshCompleted(arg_41_0, arg_41_1)
	arg_41_0.completedController_:SetSelectedState(arg_41_1 and "on" or "off")

	arg_41_0.info_.completedFlag = arg_41_1

	arg_41_0:RefreshGrayInner()
end

function var_0_0.RefreshOwned(arg_42_0, arg_42_1)
	arg_42_0.ownedController_:SetSelectedState(arg_42_1 and "on" or "off")

	arg_42_0.info_.ownedFlag = arg_42_1

	arg_42_0:RefreshGrayInner()
end

function var_0_0.RefreshClickBtn(arg_43_0)
	if arg_43_0.info_.clickFun then
		SetActive(arg_43_0.clickBtn_.gameObject, true)
	else
		SetActive(arg_43_0.clickBtn_.gameObject, false)
	end

	if arg_43_0.info_.longClickFun then
		SetActive(arg_43_0.longClickGo_, true)
	else
		SetActive(arg_43_0.longClickGo_, false)
	end
end

function var_0_0.RefreshAnimator(arg_44_0, arg_44_1)
	if arg_44_0.oldAnimatorType_ == arg_44_1 then
		return
	end

	if arg_44_1 == ItemConst.ITEM_ANIMATOR_TYPE.NULL then
		arg_44_0.itemCanvasGroup_.alpha = 1
		arg_44_0.animator_.enabled = true

		if arg_44_0.gameObject_.activeInHierarchy == true then
			arg_44_0.animator_:Update(0)
		end

		arg_44_0.animator_.runtimeAnimatorController = nil
	else
		arg_44_0.animator_.enabled = true

		if arg_44_1 == ItemConst.ITEM_ANIMATOR_TYPE.NORMAL then
			arg_44_0.animator_.runtimeAnimatorController = Asset.Load("AnimatorController/CommonItem/CommonItem")

			if arg_44_0.gameObject_.activeInHierarchy == true then
				arg_44_0.animator_:Update(0)
			end
		elseif arg_44_1 == ItemConst.ITEM_ANIMATOR_TYPE.ADVANCED then
			arg_44_0.animator_.runtimeAnimatorController = Asset.Load("AnimatorController/CommonItem/CommonItem2")

			if arg_44_0.gameObject_.activeInHierarchy == true then
				arg_44_0.animator_:Update(0)
			end
		end
	end

	arg_44_0.oldAnimatorType_ = arg_44_1

	if arg_44_0.info_ then
		arg_44_0.info_.animatorType = arg_44_1
	end
end

function var_0_0.AddDragEvent(arg_45_0)
	arg_45_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_45_0, arg_45_0.BeginDragFun)))
	arg_45_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_45_0, arg_45_0.DragFun)))
	arg_45_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_45_0, arg_45_0.EndDragFun)))
end

function var_0_0.RemoveDragEvent(arg_46_0)
	arg_46_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_46_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_46_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
end

function var_0_0.BeginDragFun(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_0.info_.beginDragFun then
		arg_47_0.info_.beginDragFun(arg_47_1, arg_47_2)
	end
end

function var_0_0.DragFun(arg_48_0, arg_48_1, arg_48_2)
	if arg_48_0.info_.dragFun then
		arg_48_0.info_.dragFun(arg_48_1, arg_48_2)
	end
end

function var_0_0.EndDragFun(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_0.info_.endDragFun then
		arg_49_0.info_.endDragFun(arg_49_1, arg_49_2)
	end
end

function var_0_0.Show(arg_50_0, arg_50_1)
	SetActive(arg_50_0.gameObject_, arg_50_1)
end

function var_0_0.Dispose(arg_51_0)
	arg_51_0:RemoveDragEvent()
	var_0_0.super.Dispose(arg_51_0)

	arg_51_0.transform_ = nil
	arg_51_0.gameObject_ = nil
	arg_51_0.oldInfo_ = nil
end

return var_0_0
