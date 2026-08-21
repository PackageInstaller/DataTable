local var_0_0 = class("CommonItem", ReduxView)

CLICK_MODE = {
	LONG = 2,
	SINGLE = 1
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:UpdateView()
end

function var_0_0.RefreshData(arg_3_0, arg_3_1)
	arg_3_0.info_ = arg_3_1

	if arg_3_1 == nil then
		return
	end

	local var_3_0

	if arg_3_1.type then
		var_3_0 = arg_3_1.type
	elseif ItemCfg[arg_3_1.id] then
		var_3_0 = ItemCfg[arg_3_1.id].type
	else
		var_3_0 = ItemConst.ITEM_TYPE.MATERIAL
	end

	arg_3_0:UpdateType(var_3_0)
	arg_3_0:UpdateView()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.typeController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "type")
	arg_4_0.starController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "star")
	arg_4_0.qualityController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "quality")
	arg_4_0.campController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "camp")
	arg_4_0.lockedController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "locked")
	arg_4_0.usingController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "using")
	arg_4_0.selectedController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "selected")
	arg_4_0.gradeController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "grade")
	arg_4_0.enchantmentController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "enchantment")
	arg_4_0.selectTypeController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "selectType")
	arg_4_0.floorController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "floor")
	arg_4_0.countdownStatusController_ = ControllerUtil.GetController(arg_4_0.countdownGo_.transform, "countdownStatus")
	arg_4_0.geryController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "grey")
	arg_4_0.ownedController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "owned")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.clickBtn_, nil, function()
		if arg_5_0.clickMode_ == CLICK_MODE.SINGLE and arg_5_0.clickFunc then
			arg_5_0.clickFunc(arg_5_0.info_)
		end
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.longClickBtn_, 3, 0.5, 0.2, function()
		if arg_5_0.clickLongFunc and arg_5_0.clickMode_ == CLICK_MODE.LONG then
			return (arg_5_0.clickLongFunc(arg_5_0.info_))
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.clickCutBtn_, 3, 0.5, 0.2, function()
		if arg_5_0.clickCutFunc then
			return (arg_5_0.clickCutFunc(arg_5_0.info_))
		end

		return false
	end)

	if arg_5_0.clickGaryBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.clickGaryBtn_, nil, function()
			if arg_5_0.clickGaryFunc then
				arg_5_0.clickGaryFunc(arg_5_0.info_)
			end
		end)
	end
end

function var_0_0.ResetTransform(arg_10_0)
	arg_10_0.transform_.localPosition = Vector3(0, 0, 0)
	arg_10_0.transform_.localScale = Vector3(1, 1, 1)
	arg_10_0.transform_.localEulerAngles = Vector3.New(0, 0, 0)
end

function var_0_0.SetScale(arg_11_0, arg_11_1)
	arg_11_0.transform_.localScale = arg_11_1
end

function var_0_0.SetSelectType(arg_12_0, arg_12_1)
	arg_12_0.manualSelectType_ = arg_12_1

	arg_12_0.selectTypeController_:SetSelectedState(arg_12_1)
end

function var_0_0.UpdateType(arg_13_0, arg_13_1)
	arg_13_0.typeController_:SetSelectedState("reset")

	if ItemConst.ITEM_TYPE.CURRENCY == arg_13_1 or ItemConst.ITEM_TYPE.MATERIAL == arg_13_1 or ItemConst.ITEM_TYPE.PROPS == arg_13_1 or ItemConst.ITEM_TYPE.GIFT == arg_13_1 or ItemConst.ITEM_TYPE.ARCHIVE_GIFT == arg_13_1 then
		arg_13_0.typeController_:SetSelectedState("material")

		arg_13_0.defaultSelectType_ = "item"
	elseif ItemConst.ITEM_TYPE.HERO_PIECE == arg_13_1 then
		arg_13_0.typeController_:SetSelectedState("heroPiece")

		arg_13_0.defaultSelectType_ = "item"
	elseif ItemConst.ITEM_TYPE.EQUIP == arg_13_1 then
		arg_13_0.typeController_:SetSelectedState("equip")

		arg_13_0.defaultSelectType_ = "equip"
	elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == arg_13_1 then
		arg_13_0.typeController_:SetSelectedState("weaponServant")

		arg_13_0.defaultSelectType_ = "equip"
	elseif ItemConst.ITEM_TYPE.HERO == arg_13_1 then
		arg_13_0.typeController_:SetSelectedState("hero")

		arg_13_0.defaultSelectType_ = "equip"
	elseif ItemConst.ITEM_TYPE.HERO_SKIN == arg_13_1 then
		arg_13_0.typeController_:SetSelectedState("heroSkin")

		arg_13_0.defaultSelectType_ = "equip"
	else
		arg_13_0.typeController_:SetSelectedState("material")

		arg_13_0.defaultSelectType_ = "item"
	end
end

function var_0_0.UpdateView(arg_14_0)
	if arg_14_0.info_ == nil then
		return
	end

	arg_14_0:UpdateIcon()
	arg_14_0:UpdateName()
	arg_14_0:UpdateRareBg()
	arg_14_0:UpdateStar()
	arg_14_0:ShowOwned()

	if arg_14_0.typeController_:GetSelectedState() == "material" then
		arg_14_0:UpdateMaterialView()
	elseif arg_14_0.typeController_:GetSelectedState() == "heroPiece" then
		arg_14_0:UpdateHeroPieceView()
	elseif arg_14_0.typeController_:GetSelectedState() == "weaponServant" then
		arg_14_0:UpdateWeaponServantView()
	elseif arg_14_0.typeController_:GetSelectedState() == "equip" then
		arg_14_0:UpdateEquipView()
	elseif arg_14_0.typeController_:GetSelectedState() == "hero" then
		arg_14_0:UpdateHeroView()
	elseif arg_14_0.typeController_:GetSelectedState() == "heroSkin" then
		arg_14_0:UpdateHeroSkinView()
	end
end

function var_0_0.UpdateMaterialView(arg_15_0)
	arg_15_0:ShowLock(arg_15_0.info_.locked == 1)

	if arg_15_0.info_.num then
		arg_15_0:SetBottomText(arg_15_0.info_.num)
	end
end

function var_0_0.UpdateHeroPieceView(arg_16_0)
	if arg_16_0.info_.num then
		arg_16_0:SetBottomText(arg_16_0.info_.num)
	end

	local var_16_0 = HeroCfg[arg_16_0.info_.id % 10000]

	arg_16_0:UpdateCamp(var_16_0.race)
	arg_16_0:ShowLock(arg_16_0.info_.locked == 1)
end

function var_0_0.UpdateWeaponServantView(arg_17_0)
	if arg_17_0.refineText_ then
		if not arg_17_0.info_.isEquip then
			arg_17_0.refineText_.text = ""
		else
			arg_17_0.refineText_.text = GetTips("PROMOTE")
		end
	end

	if arg_17_0.info_.isAdd then
		arg_17_0.servantStageText_.text = "<color=#FF9500>" .. tostring(arg_17_0.info_.num) .. "</color>"

		arg_17_0:SetBottomText("")
	else
		arg_17_0.servantStageText_.text = ""

		if arg_17_0.info_.num then
			arg_17_0:SetBottomText(arg_17_0.info_.num)
		end
	end

	if ItemCfg[arg_17_0.info_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_17_0.servantStageText_.text = " "

		arg_17_0:SetBottomText("")
	end

	if arg_17_0.severantRect_ then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.severantRect_)
	end

	local var_17_0 = false
	local var_17_1 = 0

	if arg_17_0.info_.equiping and arg_17_0.info_.equiping.heroId > 0 then
		var_17_0 = true
		var_17_1 = arg_17_0.info_.equiping.heroId
	end

	arg_17_0:ShowEquiping(var_17_0, var_17_1)

	local var_17_2 = WeaponServantCfg[arg_17_0.info_.id]

	arg_17_0:UpdateCamp(var_17_2.race)
	arg_17_0:ShowLock(arg_17_0.info_.locked == 1)
end

function var_0_0.UpdateEquipView(arg_18_0)
	arg_18_0:UpdateLevel(arg_18_0.info_.level or arg_18_0.info_.num or 1)

	if arg_18_0.typeController_:GetSelectedState() == "equip" and arg_18_0.info_.equip_lv then
		arg_18_0.num_.text = GetTips("LEVEL") .. string.format("%d", arg_18_0.info_.equip_lv)
	end

	local var_18_0 = false
	local var_18_1 = 0

	if arg_18_0.info_.equiping and arg_18_0.info_.equiping.heroId > 0 then
		var_18_0 = true
		var_18_1 = arg_18_0.info_.equiping.heroId
	end

	arg_18_0:ShowEquiping(var_18_0, var_18_1)

	local var_18_2 = arg_18_0.info_.id

	arg_18_0.equipPosTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (EquipCfg[var_18_2].pos - 1))

	local var_18_3 = arg_18_0.info_.equip_info and arg_18_0.info_.equip_info:GetEnchantCount() or 0

	arg_18_0.enchantmentController_:SetSelectedIndex(var_18_3)
	arg_18_0:ShowLock(arg_18_0.info_.equip_info and arg_18_0.info_.equip_info.is_lock or false)

	local var_18_4

	if arg_18_0.info_.equip_info then
		var_18_4 = arg_18_0.info_.equip_info.race or 0
	else
		var_18_4 = arg_18_0.info_.race or 0
	end

	local var_18_5 = RaceEffectCfg.all

	if var_18_4 == 0 or table.keyof(var_18_5, var_18_4) ~= nil then
		SetActive(arg_18_0.equiHeroRebuildGo_, false)
		arg_18_0:UpdateCamp(var_18_4)
	else
		local var_18_6 = var_18_4

		arg_18_0.equiHeroRebuildImg_.sprite = HeroTools.GetSmallHeadSprite(var_18_6)

		SetActive(arg_18_0.equiHeroRebuildGo_, true)
		arg_18_0:UpdateCamp(0)
	end
end

function var_0_0.UpdateAnimator(arg_19_0)
	local var_19_0 = arg_19_0.mainAni_:GetCurrentAnimatorStateInfo(0)

	arg_19_0.mainAni_:Play(var_19_0.fullPathHash, -1, 0)

	arg_19_0.mainAni_.enabled = true
end

function var_0_0.StopAnimator(arg_20_0)
	local var_20_0 = arg_20_0.mainAni_:GetCurrentAnimatorStateInfo(0)

	arg_20_0.mainAni_:Play(var_20_0.fullPathHash, -1, 1)
end

function var_0_0.UpdateHeroView(arg_21_0)
	arg_21_0:SetBottomText(arg_21_0.info_.num or 1)

	local var_21_0 = HeroCfg[arg_21_0.info_.id]
	local var_21_1 = HeroStarCfg[arg_21_0.info_.star or var_21_0.unlock_star]
	local var_21_2 = var_21_1 ~= nil and var_21_1.star or 1

	arg_21_0.gradeController_:SetSelectedState(var_21_2 or 1)
	arg_21_0:UpdateCamp(var_21_0.race)
	arg_21_0:ShowLock(arg_21_0.info_.locked == 1)
end

function var_0_0.UpdateHeroSkinView(arg_22_0)
	arg_22_0:ShowLock(arg_22_0.info_.locked == 1)
	arg_22_0:UpdateIcon()
	arg_22_0:SetBottomText(arg_22_0.info_.num or 1)
end

function var_0_0.UpdateIcon(arg_23_0)
	arg_23_0.icon_.enabled = false

	ItemTools.GetItemSpriteAsync(arg_23_0.info_.id, function(arg_24_0, arg_24_1)
		if arg_23_0.disposed_ then
			return
		end

		if arg_24_0 == arg_23_0.info_.id then
			arg_23_0.icon_.enabled = true
			arg_23_0.icon_.sprite = arg_24_1

			if ItemCfg[arg_24_0] then
				arg_23_0:ResizeIcon(arg_24_0)
			end
		end
	end, arg_23_0.info_.iconPath)
end

function var_0_0.ResizeIcon(arg_25_0, arg_25_1)
	if ItemCfg[arg_25_1].type ~= ItemConst.ITEM_TYPE.STICKER and ItemCfg[arg_25_1].type ~= ItemConst.ITEM_TYPE.EQUIP then
		arg_25_0.icon_:SetNativeSize()
	end
end

function var_0_0.UpdateName(arg_26_0)
	if ItemCfg[arg_26_0.info_.id] then
		arg_26_0.nameText_.text = ItemTools.getItemName(arg_26_0.info_.id)
	end
end

function var_0_0.UpdateStar(arg_27_0)
	local var_27_0 = 0
	local var_27_1 = ItemCfg[arg_27_0.info_.id]

	if var_27_1 then
		var_27_0 = var_27_1.display_rare
	end

	local var_27_2 = arg_27_0.info_.equip_star or arg_27_0.info_.star or getItemStar(arg_27_0.info_.id)

	if var_27_2 > 0 then
		var_27_0 = var_27_2
	end

	arg_27_0.starController_:SetSelectedState(tostring(var_27_0))
end

function var_0_0.UpdateRareBg(arg_28_0)
	local var_28_0 = ItemCfg[arg_28_0.info_.id]

	if var_28_0 then
		local var_28_1 = var_28_0.display_rare

		arg_28_0.qualityController_:SetSelectedState(tostring(var_28_1))
	end
end

function var_0_0.ShowName(arg_29_0, arg_29_1)
	SetActive(arg_29_0.nameText_.gameObject, arg_29_1)
end

function var_0_0.ShowEquiping(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.usingController_:SetSelectedState(arg_30_1 and "true" or "false")

	if arg_30_1 then
		arg_30_0.whoIconImg_.sprite = HeroTools.GetSmallHeadSprite(arg_30_2)
	end
end

function var_0_0.ShowLock(arg_31_0, arg_31_1)
	arg_31_0.lockedController_:SetSelectedState(arg_31_1 and "true" or "false")
end

function var_0_0.ShowOwned(arg_32_0, arg_32_1)
	if not arg_32_0.ownedController_ then
		return
	end

	arg_32_0.ownedController_:SetSelectedState(arg_32_1 or arg_32_0.info_.owned and "true" or "false")
end

function var_0_0.ShowNew(arg_33_0, arg_33_1)
	SetActive(arg_33_0.new_, arg_33_1)
end

function var_0_0.ShowStar(arg_34_0, arg_34_1)
	if arg_34_1 then
		arg_34_0:UpdateStar()
	else
		arg_34_0.starController_:SetSelectedState("0")
	end
end

function var_0_0.SetBottomText(arg_35_0, arg_35_1)
	arg_35_0.num_.text = arg_35_1

	if arg_35_0.boxImage_ ~= nil then
		local var_35_0 = arg_35_1 and tostring(arg_35_1) or ""

		arg_35_0.boxImage_.enabled = #var_35_0 > 0
	end
end

function var_0_0.SetBottomTextColor(arg_36_0, arg_36_1)
	arg_36_0.num_.color = arg_36_1
end

function var_0_0.SetIndex(arg_37_0, arg_37_1)
	arg_37_0.transform_:SetSiblingIndex(arg_37_1)
end

function var_0_0.ShowBlackBack(arg_38_0, arg_38_1)
	return
end

function var_0_0.UpdateTime(arg_39_0)
	local var_39_0 = arg_39_0.countdownStatusController_
	local var_39_1 = ItemCfg[arg_39_0.info_.id]
	local var_39_2 = ItemTools.GetItemExpiredTimeByInfo(arg_39_0.info_)

	if var_39_2 == nil or var_39_2 == 0 then
		var_39_0:SetSelectedState("noLimit")
	elseif ItemTools.IsItemExpired(arg_39_0.info_) then
		var_39_0:SetSelectedState("expired")
	elseif arg_39_0.info_.timeValid then
		var_39_0:SetSelectedState("countdowning")

		arg_39_0.lastTimeLabel_.text = manager.time:GetLostTimeStr(ItemTools.GetItemExpiredTimeByInfo(arg_39_0.info_), nil, true)
	else
		var_39_0:SetSelectedState("noLimit")
	end
end

function var_0_0.UpdateCamp(arg_40_0, arg_40_1)
	if arg_40_1 == 0 then
		arg_40_0.campController_:SetSelectedState("noCamp")
		SetActive(arg_40_0.campPanelGo_, false)
	else
		arg_40_0.campController_:SetSelectedState(tostring(arg_40_1))
		SetActive(arg_40_0.campPanelGo_, true)
	end

	if arg_40_0.functionTrans_ then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_0.functionTrans_)
	end
end

function var_0_0.UpdateLevel(arg_41_0, arg_41_1)
	arg_41_0:SetBottomText(tostring(arg_41_1))
end

function var_0_0.ShowSelect(arg_42_0, arg_42_1)
	type(arg_42_1)

	local var_42_0 = false

	if type(arg_42_1) == "number" then
		if arg_42_1 > 0 then
			var_42_0 = true
		end
	else
		var_42_0 = arg_42_1
	end

	arg_42_0.selectTypeController_:SetSelectedState(arg_42_0.manualSelectType_ or arg_42_0.defaultSelectType_)

	if var_42_0 then
		arg_42_0.selectedController_:SetSelectedState("true")

		local var_42_1 = ItemCfg[arg_42_0.info_.id].type

		if ItemConst.ITEM_TYPE.EQUIP ~= var_42_1 then
			arg_42_0.selectNum_.text = "x" .. arg_42_1
		end
	else
		arg_42_0.selectedController_:SetSelectedState("false")
		arg_42_0:StopLongClickTimer()
	end
end

function var_0_0.HideNum(arg_43_0)
	arg_43_0:SetBottomText("")
end

function var_0_0.Show(arg_44_0, arg_44_1)
	SetActive(arg_44_0.gameObject_, arg_44_1)
end

function var_0_0.ShowFloor(arg_45_0, arg_45_1)
	arg_45_0.floorController_:SetSelectedState(arg_45_1 or ItemConst.ITEM_FLOOR.LONG)
end

function var_0_0.SetGrey(arg_46_0, arg_46_1)
	arg_46_0.geryController_:SetSelectedState(arg_46_1)
end

function var_0_0.HideServantTxt(arg_47_0)
	SetActive(arg_47_0.severantGo_, false)
end

function var_0_0.RegistCallBack(arg_48_0, arg_48_1)
	arg_48_0.clickMode_ = CLICK_MODE.SINGLE
	arg_48_0.clickFunc = arg_48_1

	SetActive(arg_48_0.longClickBtn_, false)
end

function var_0_0.RegistLongCallBack(arg_49_0, arg_49_1)
	arg_49_0.clickMode_ = CLICK_MODE.LONG
	arg_49_0.clickLongFunc = arg_49_1

	SetActive(arg_49_0.longClickBtn_, true)
end

function var_0_0.RegistCutCallBack(arg_50_0, arg_50_1)
	arg_50_0.clickCutFunc = arg_50_1
end

function var_0_0.RegistGaryCallBack(arg_51_0, arg_51_1)
	arg_51_0.clickGaryFunc = arg_51_1
end

function var_0_0.GetItemInfo(arg_52_0)
	return arg_52_0.info_
end

function var_0_0.Dispose(arg_53_0)
	var_0_0.super.Dispose(arg_53_0)

	arg_53_0.disposed_ = true
end

return var_0_0
