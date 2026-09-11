local CommonItemServant = class("CommonItemServant", ReduxView)

CLICK_MODE = {
	LONG = 2,
	SINGLE = 1
}

function CommonItemServant:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CommonItemServant:Init()
	self:InitUI()
	self:AddUIListener()
	self:UpdateView()
end

function CommonItemServant:RefreshData(arg_3_1)
	self.info_ = arg_3_1

	if arg_3_1 == nil then
		return
	end

	self:UpdateType(arg_3_1.type and arg_3_1.type or ItemCfg[arg_3_1.id] and ItemCfg[arg_3_1.id].type or ItemConst.ITEM_TYPE.MATERIAL)
	self:UpdateView()
end

function CommonItemServant:InitUI()
	self:BindCfgUI()

	self.typeController_ = ControllerUtil.GetController(self.gameObject_.transform, "type")
	self.starController_ = ControllerUtil.GetController(self.gameObject_.transform, "star")
	self.qualityController_ = ControllerUtil.GetController(self.gameObject_.transform, "quality")
	self.campController_ = ControllerUtil.GetController(self.gameObject_.transform, "camp")
	self.lockedController_ = ControllerUtil.GetController(self.gameObject_.transform, "locked")
	self.usingController_ = ControllerUtil.GetController(self.gameObject_.transform, "using")
	self.selectedController_ = ControllerUtil.GetController(self.gameObject_.transform, "selected")
	self.gradeController_ = ControllerUtil.GetController(self.gameObject_.transform, "grade")
	self.enchantmentController_ = ControllerUtil.GetController(self.gameObject_.transform, "enchantment")
	self.selectTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "selectType")
	self.floorController_ = ControllerUtil.GetController(self.gameObject_.transform, "floor")
	self.countdownStatusController_ = ControllerUtil.GetController(self.countdownGo_.transform, "countdownStatus")
	self.geryController_ = ControllerUtil.GetController(self.gameObject_.transform, "grey")
end

function CommonItemServant:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.clickMode_ == CLICK_MODE.SINGLE and self.clickFunc then
			self.clickFunc(self.info_)
		end
	end)
	self:AddPressingByTimeListener(self.longClickBtn_, 3, 0.5, 0.2, function()
		if self.clickLongFunc and self.clickMode_ == CLICK_MODE.LONG then
			return (self.clickLongFunc(self.info_))
		end

		return false
	end)
	self:AddPressingByTimeListener(self.clickCutBtn_, 3, 0.5, 0.2, function()
		if self.clickCutFunc then
			return (self.clickCutFunc(self.info_))
		end

		return false
	end)

	if self.clickGaryBtn_ then
		self:AddBtnListener(self.clickGaryBtn_, nil, function()
			if self.clickGaryFunc then
				self.clickGaryFunc(self.info_)
			end
		end)
	end
end

function CommonItemServant:ResetTransform()
	self.transform_.localPosition = Vector3(0, 0, 0)
	self.transform_.localScale = Vector3(1, 1, 1)
	self.transform_.localEulerAngles = Vector3.New(0, 0, 0)
end

function CommonItemServant:SetScale(arg_11_1)
	self.transform_.localScale = arg_11_1
end

function CommonItemServant:SetSelectType(arg_12_1)
	self.manualSelectType_ = arg_12_1

	self.selectTypeController_:SetSelectedState(arg_12_1)
end

function CommonItemServant:UpdateType(arg_13_1)
	self.typeController_:SetSelectedState("reset")

	if ItemConst.ITEM_TYPE.CURRENCY == arg_13_1 or ItemConst.ITEM_TYPE.MATERIAL == arg_13_1 or ItemConst.ITEM_TYPE.PROPS == arg_13_1 or ItemConst.ITEM_TYPE.GIFT == arg_13_1 or ItemConst.ITEM_TYPE.ARCHIVE_GIFT == arg_13_1 then
		self.typeController_:SetSelectedState("material")

		self.defaultSelectType_ = "item"
	elseif ItemConst.ITEM_TYPE.HERO_PIECE == arg_13_1 then
		self.typeController_:SetSelectedState("heroPiece")

		self.defaultSelectType_ = "item"
	elseif ItemConst.ITEM_TYPE.EQUIP == arg_13_1 then
		self.typeController_:SetSelectedState("equip")

		self.defaultSelectType_ = "equip"
	elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == arg_13_1 then
		self.typeController_:SetSelectedState("weaponServant")

		self.defaultSelectType_ = "equip"
	elseif ItemConst.ITEM_TYPE.HERO == arg_13_1 then
		self.typeController_:SetSelectedState("hero")

		self.defaultSelectType_ = "equip"
	elseif ItemConst.ITEM_TYPE.HERO_SKIN == arg_13_1 then
		self.typeController_:SetSelectedState("heroSkin")

		self.defaultSelectType_ = "equip"
	else
		self.typeController_:SetSelectedState("material")

		self.defaultSelectType_ = "item"
	end
end

function CommonItemServant:UpdateView()
	if self.info_ == nil then
		return
	end

	self:UpdateIcon()
	self:UpdateName()
	self:UpdateRareBg()
	self:UpdateStar()

	if self.typeController_:GetSelectedState() == "material" then
		self:UpdateMaterialView()
	elseif self.typeController_:GetSelectedState() == "heroPiece" then
		self:UpdateHeroPieceView()
	elseif self.typeController_:GetSelectedState() == "weaponServant" then
		self:UpdateWeaponServantView()
	elseif self.typeController_:GetSelectedState() == "equip" then
		self:UpdateEquipView()
	elseif self.typeController_:GetSelectedState() == "hero" then
		self:UpdateHeroView()
	elseif self.typeController_:GetSelectedState() == "heroSkin" then
		self:UpdateHeroSkinView()
	end
end

function CommonItemServant:UpdateMaterialView()
	self:ShowLock(self.info_.locked == 1)

	if self.info_.number then
		self:SetBottomText(self.info_.number)
	end
end

function CommonItemServant:UpdateHeroPieceView()
	if self.info_.number then
		self:SetBottomText(self.info_.number)
	end

	self:UpdateCamp(HeroCfg[self.info_.id % 10000].race)
	self:ShowLock(self.info_.locked == 1)
end

function CommonItemServant:UpdateWeaponServantView()
	if self.refineText_ then
		self.refineText_.text = not self.info_.isEquip and "" or GetTips("PROMOTE")
	end

	self.servantStageText_.text = self.info_.isAdd and "<color=#FF9500>" .. tostring(self.info_.number) .. "</color>" or tostring(self.info_.number)

	if ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		self.servantStageText_.text = " "

		self:SetBottomText("")
	end

	if self.severantRect_ then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.severantRect_)
	end

	local var_17_0 = false
	local var_17_1 = 0

	if self.info_.equiping and self.info_.equiping.heroId > 0 then
		var_17_0 = true
		var_17_1 = self.info_.equiping.heroId
	end

	self:ShowEquiping(var_17_0, var_17_1)
	self:UpdateCamp(WeaponServantCfg[self.info_.id].race)
	self:ShowLock(self.info_.locked == 1)
end

function CommonItemServant:UpdateEquipView()
	self:UpdateLevel(self.info_.level or self.info_.number or 1)

	if self.typeController_:GetSelectedState() == "equip" and self.info_.equip_lv then
		self.num_.text = GetTips("LEVEL") .. string.format("%d", self.info_.equip_lv)
	end

	local var_18_1 = false
	local var_18_2 = 0

	if self.info_.equiping and self.info_.equiping.heroId > 0 then
		var_18_1 = true
		var_18_2 = self.info_.equiping.heroId
	end

	self:ShowEquiping(var_18_1, var_18_2)

	self.equipPosTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (EquipCfg[self.info_.id].pos - 1))

	self.enchantmentController_:SetSelectedIndex(self.info_.equip_info and self.info_.equip_info:GetEnchantCount() or 0)
	self:ShowLock((self.info_.equip_info or nil) and (self.info_.equip_info.is_lock or false))

	local var_18_3 = self.info_.equip_info and (self.info_.equip_info.race or 0) or self.info_.race or 0

	if var_18_3 == 0 or table.keyof(RaceEffectCfg.all, var_18_3) ~= nil then
		SetActive(self.equiHeroRebuildGo_, false)
		self:UpdateCamp(var_18_3)
	else
		self.equiHeroRebuildImg_.sprite = HeroTools.GetSmallHeadSprite(var_18_3)

		SetActive(self.equiHeroRebuildGo_, true)
		self:UpdateCamp(0)
	end
end

function CommonItemServant:UpdateAnimator()
	self.mainAni_:Play(self.mainAni_:GetCurrentAnimatorStateInfo(0).fullPathHash, -1, 0)

	self.mainAni_.enabled = true
end

function CommonItemServant:StopAnimator()
	self.mainAni_:Play(self.mainAni_:GetCurrentAnimatorStateInfo(0).fullPathHash, -1, 1)
end

function CommonItemServant:UpdateHeroView()
	self:SetBottomText(self.info_.number or 1)

	local var_21_1 = HeroCfg[self.info_.id]

	self.gradeController_:SetSelectedState((HeroStarCfg[self.info_.star or var_21_1.unlock_star] ~= nil or nil) and (HeroStarCfg[self.info_.star or var_21_1.unlock_star].star or 1) or 1)
	self:UpdateCamp(var_21_1.race)
	self:ShowLock(self.info_.locked == 1)
end

function CommonItemServant:UpdateHeroSkinView()
	self:ShowLock(self.info_.locked == 1)
	self:UpdateIcon()
	self:SetBottomText(self.info_.number or 1)
end

function CommonItemServant:UpdateIcon()
	self.icon_.enabled = false

	ItemTools.GetItemSpriteAsync(self.info_.id, function(arg_24_0, arg_24_1)
		if self.disposed_ then
			return
		end

		if arg_24_0 == self.info_.id then
			self.icon_.enabled = true
			self.icon_.sprite = arg_24_1

			if ItemCfg[arg_24_0] then
				self:ResizeIcon(arg_24_0)
			end
		end
	end, self.info_.iconPath)
end

function CommonItemServant:ResizeIcon(arg_25_1)
	if ItemCfg[arg_25_1].type ~= ItemConst.ITEM_TYPE.STICKER and ItemCfg[arg_25_1].type ~= ItemConst.ITEM_TYPE.EQUIP then
		self.icon_:SetNativeSize()
	end
end

function CommonItemServant:UpdateName()
	if ItemCfg[self.info_.id] then
		self.nameText_.text = ItemCfg[self.info_.id].name
	end
end

function CommonItemServant:UpdateStar()
	local var_27_0 = 0

	if ItemCfg[self.info_.id] then
		var_27_0 = ItemCfg[self.info_.id].display_rare
	end

	local var_27_1 = self.info_.equip_star or self.info_.star or getItemStar(self.info_.id)

	self.starController_:SetSelectedState(tostring((var_27_1 > 0 or nil) and var_27_1))
end

function CommonItemServant:UpdateRareBg()
	if ItemCfg[self.info_.id] then
		self.qualityController_:SetSelectedState(tostring(ItemCfg[self.info_.id].display_rare))
	end
end

function CommonItemServant:ShowName(arg_29_1)
	SetActive(self.nameText_.gameObject, arg_29_1)
end

function CommonItemServant:ShowEquiping(arg_30_1, arg_30_2)
	self.usingController_:SetSelectedState(arg_30_1 and "true" or "false")

	if arg_30_1 then
		self.whoIconImg_.sprite = HeroTools.GetSmallHeadSprite(arg_30_2)
	end
end

function CommonItemServant:ShowLock(arg_31_1)
	self.lockedController_:SetSelectedState(arg_31_1 and "true" or "false")
end

function CommonItemServant:ShowNew(arg_32_1)
	SetActive(self.new_, arg_32_1)
end

function CommonItemServant:ShowStar(arg_33_1)
	if arg_33_1 then
		self:UpdateStar()
	else
		self.starController_:SetSelectedState("0")
	end
end

function CommonItemServant:SetBottomText(arg_34_1)
	self.num_.text = arg_34_1

	if self.boxImage_ ~= nil then
		self.boxImage_.enabled = #(arg_34_1 and tostring(arg_34_1) or "") > 0
	end
end

function CommonItemServant:SetBottomTextColor(arg_35_1)
	self.num_.color = arg_35_1
end

function CommonItemServant:SetIndex(arg_36_1)
	self.transform_:SetSiblingIndex(arg_36_1)
end

function CommonItemServant:ShowBlackBack(arg_37_1)
	return
end

function CommonItemServant:UpdateTime()
	local var_38_1 = ItemTools.GetItemExpiredTimeByInfo(self.info_)

	if var_38_1 == nil or var_38_1 == 0 then
		self.countdownStatusController_:SetSelectedState("noLimit")
	elseif ItemTools.IsItemExpired(self.info_) then
		self.countdownStatusController_:SetSelectedState("expired")
	elseif self.info_.timeValid then
		self.countdownStatusController_:SetSelectedState("countdowning")

		self.lastTimeLabel_.text = manager.time:GetLostTimeStr(ItemTools.GetItemExpiredTimeByInfo(self.info_), nil, true)
	else
		self.countdownStatusController_:SetSelectedState("noLimit")
	end
end

function CommonItemServant:UpdateCamp(arg_39_1)
	if arg_39_1 == 0 then
		self.campController_:SetSelectedState("noCamp")
		SetActive(self.campPanelGo_, false)
	else
		self.campController_:SetSelectedState(tostring(arg_39_1))
		SetActive(self.campPanelGo_, true)
	end

	if self.functionTrans_ then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.functionTrans_)
	end
end

function CommonItemServant:UpdateLevel(arg_40_1)
	self:SetBottomText(tostring(arg_40_1))
end

function CommonItemServant:ShowSelect(arg_41_1)
	type(arg_41_1)

	local var_41_0 = false

	if type(arg_41_1) == "number" then
		if arg_41_1 > 0 then
			var_41_0 = true
		end
	else
		var_41_0 = arg_41_1
	end

	self.selectTypeController_:SetSelectedState(self.manualSelectType_ or self.defaultSelectType_)

	if var_41_0 then
		self.selectedController_:SetSelectedState("true")

		if ItemConst.ITEM_TYPE.EQUIP ~= ItemCfg[self.info_.id].type then
			self.selectNum_.text = "x" .. arg_41_1
		end
	else
		self.selectedController_:SetSelectedState("false")
		self:StopLongClickTimer()
	end
end

function CommonItemServant:HideNum()
	self:SetBottomText("")
end

function CommonItemServant:Show(arg_43_1)
	SetActive(self.gameObject_, arg_43_1)
end

function CommonItemServant:ShowFloor(arg_44_1)
	self.floorController_:SetSelectedState(arg_44_1 or ItemConst.ITEM_FLOOR.LONG)
end

function CommonItemServant:SetGrey(arg_45_1)
	self.geryController_:SetSelectedState(arg_45_1)
end

function CommonItemServant:HideServantTxt()
	SetActive(self.severantGo_, false)
end

function CommonItemServant:RegistCallBack(arg_47_1)
	self.clickMode_ = CLICK_MODE.SINGLE
	self.clickFunc = arg_47_1

	SetActive(self.longClickBtn_, false)
end

function CommonItemServant:RegistLongCallBack(arg_48_1)
	self.clickMode_ = CLICK_MODE.LONG
	self.clickLongFunc = arg_48_1

	SetActive(self.longClickBtn_, true)
end

function CommonItemServant:RegistCutCallBack(arg_49_1)
	self.clickCutFunc = arg_49_1
end

function CommonItemServant:RegistGaryCallBack(arg_50_1)
	self.clickGaryFunc = arg_50_1
end

function CommonItemServant:GetItemInfo()
	return self.info_
end

function CommonItemServant:Dispose()
	CommonItemServant.super.Dispose(self)

	self.disposed_ = true
end

return CommonItemServant
