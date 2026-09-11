local MatrixProcessRewardItem = class("MatrixProcessRewardItem", ReduxView)

function MatrixProcessRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function MatrixProcessRewardItem:initUI()
	self:BindCfgUI()

	self.m_des1 = self.m_des1Go:GetComponent("ExtendText")
	self.extendScrollRect = self.m_des1Go:GetComponent("ScrollRect")
	self.selectedController_ = ControllerUtil.GetController(self.gameObject_.transform, "selected")
	self.typeController_ = ControllerUtil.GetController(self.gameObject_.transform, "type")
	self.rareController_ = ControllerUtil.GetController(self.gameObject_.transform, "rare")
	self.astrolabeImgs_ = {}

	for iter_2_0 = 1, 3 do
		table.insert(self.astrolabeImgs_, self["m_astrolabeImg" .. iter_2_0])
	end
end

function MatrixProcessRewardItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.index)
		end
	end)
end

function MatrixProcessRewardItem:SetDesc(arg_5_1)
	self.m_des1:Hide()
	self.m_des1:SetText(arg_5_1)

	self.m_des2.text = GetI18NText(arg_5_1)
	self.extendScrollRect.verticalNormalizedPosition = 1
end

function MatrixProcessRewardItem:Refresh(arg_6_1, arg_6_2)
	self.id = arg_6_1
	self.index = arg_6_2
	self.m_name1.text = GetI18NText(MatrixItemCfg[arg_6_1].name)
	self.m_name2.text = GetI18NText(MatrixItemCfg[arg_6_1].name)

	self:SetDesc((self:GetItemDes(arg_6_1)))
	self.rareController_:SetSelectedIndex(MatrixItemCfg[arg_6_1].rare - 1)
	self.typeController_:SetSelectedIndex(MatrixItemCfg[arg_6_1].matrix_item_type - 1)

	if MatrixItemCfg[arg_6_1].matrix_item_type == MatrixConst.ITEM_TYPE.ASTROLABE then
		self:UpdateAstrolabePreview()

		self.m_suit_name.text = GetI18NText(MatrixItemCfg[arg_6_1].name)
	elseif MatrixItemCfg[arg_6_1].matrix_item_type == MatrixConst.ITEM_TYPE.EQUIP then
		self.m_equipImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)
	elseif MatrixItemCfg[arg_6_1].matrix_item_type == MatrixConst.ITEM_TYPE.WEAPON_SERVANT then
		self.m_weaponImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)

		if MatrixTools.GetWeaponSpecHero(MatrixItemCfg[arg_6_1].params[1]) ~= 0 then
			-- block empty
		end
	elseif MatrixItemCfg[arg_6_1].matrix_item_type == MatrixConst.ITEM_TYPE.TREASURE then
		self.m_treasureImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)
	elseif MatrixItemCfg[arg_6_1].matrix_item_type == MatrixConst.ITEM_TYPE.ITEM then
		self.m_itemImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)
	elseif MatrixItemCfg[arg_6_1].matrix_item_type == MatrixConst.ITEM_TYPE.EFFECT then
		self.m_buffImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)
	end
end

function MatrixProcessRewardItem:SetSelected(arg_7_1)
	self.selectedController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function MatrixProcessRewardItem:RegistCallBack(arg_8_1)
	self.clickFunc = arg_8_1
end

function MatrixProcessRewardItem:GetIndex()
	return self.index
end

function MatrixProcessRewardItem:UpdateAstrolabePreview()
	if MatrixItemCfg[self.id].matrix_item_type ~= MatrixConst.ITEM_TYPE.ASTROLABE then
		return
	end

	local var_10_0 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[MatrixItemCfg[self.id].params[1]]
	local var_10_1 = math.floor(MatrixItemCfg[self.id].params[1] / 1000)

	self.m_heroImg.sprite = getSpriteViaConfig("HeroLittleIcon", (self:GetHeroSkin(var_10_1)))

	local var_10_2 = math.min(3, self:GetHeroData(var_10_1):GetAstrolabeNum(MatrixItemCfg[self.id].params[1]) + 1)

	for iter_10_0, iter_10_1 in ipairs(self.astrolabeImgs_) do
		if iter_10_0 <= var_10_2 then
			SetActive(iter_10_1.gameObject, true)

			iter_10_1.sprite = MatrixTools.GetMatrixItemSprite(self.id)
		else
			SetActive(iter_10_1.gameObject, false)
		end
	end

	if var_10_2 > 0 then
		self:SetDesc((GetCfgDescription(AstrolabeEffectCfg[var_10_0[var_10_2]].desc[1], 1)))

		self.m_name1.text = GetI18NText(HeroAstrolabeCfg[var_10_0[var_10_2]].name)
		self.m_name2.text = GetI18NText(HeroAstrolabeCfg[var_10_0[var_10_2]].name)
	else
		self:SetDesc(MatrixItemCfg[self.id].desc)
	end
end

function MatrixProcessRewardItem:Dispose()
	MatrixProcessRewardItem.super.Dispose(self)
end

function MatrixProcessRewardItem:GetHeroData(arg_12_1)
	return MatrixData:GetHeroData(arg_12_1)
end

function MatrixProcessRewardItem:GetHeroSkin(arg_13_1)
	return MatrixData:GetHeroSkin(arg_13_1)
end

function MatrixProcessRewardItem:GetItemDes(arg_14_1)
	return MatrixTools.GetMatrixItemDes(arg_14_1)
end

return MatrixProcessRewardItem
