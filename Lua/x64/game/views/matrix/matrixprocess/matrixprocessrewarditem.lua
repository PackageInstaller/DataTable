local var_0_0 = class("MatrixProcessRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.m_des1 = arg_2_0.m_des1Go:GetComponent("ExtendText")
	arg_2_0.extendScrollRect = arg_2_0.m_des1Go:GetComponent("ScrollRect")
	arg_2_0.selectedController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "selected")
	arg_2_0.typeController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "type")
	arg_2_0.rareController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "rare")
	arg_2_0.astrolabeImgs_ = {}

	for iter_2_0 = 1, 3 do
		table.insert(arg_2_0.astrolabeImgs_, arg_2_0["m_astrolabeImg" .. iter_2_0])
	end
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.index)
		end
	end)
end

function var_0_0.SetDesc(arg_5_0, arg_5_1)
	arg_5_0.m_des1:Hide()
	arg_5_0.m_des1:SetText(arg_5_1)

	arg_5_0.m_des2.text = GetI18NText(arg_5_1)
	arg_5_0.extendScrollRect.verticalNormalizedPosition = 1
end

function var_0_0.Refresh(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.id = arg_6_1
	arg_6_0.index = arg_6_2

	local var_6_0 = MatrixItemCfg[arg_6_1]

	arg_6_0.m_name1.text = GetI18NText(var_6_0.name)
	arg_6_0.m_name2.text = GetI18NText(var_6_0.name)

	local var_6_1 = arg_6_0:GetItemDes(arg_6_1)

	arg_6_0:SetDesc(var_6_1)
	arg_6_0.rareController_:SetSelectedIndex(var_6_0.rare - 1)

	local var_6_2 = var_6_0.matrix_item_type

	arg_6_0.typeController_:SetSelectedIndex(var_6_2 - 1)

	if var_6_2 == MatrixConst.ITEM_TYPE.ASTROLABE then
		arg_6_0:UpdateAstrolabePreview()

		arg_6_0.m_suit_name.text = GetI18NText(var_6_0.name)
	elseif var_6_2 == MatrixConst.ITEM_TYPE.EQUIP then
		arg_6_0.m_equipImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)
	elseif var_6_2 == MatrixConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_6_0.m_weaponImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)

		local var_6_3 = var_6_0.params[1]

		if MatrixTools.GetWeaponSpecHero(var_6_3) ~= 0 then
			-- block empty
		end
	elseif var_6_2 == MatrixConst.ITEM_TYPE.TREASURE then
		arg_6_0.m_treasureImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)
	elseif var_6_2 == MatrixConst.ITEM_TYPE.ITEM then
		arg_6_0.m_itemImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)
	elseif var_6_2 == MatrixConst.ITEM_TYPE.EFFECT then
		arg_6_0.m_buffImg.sprite = MatrixTools.GetMatrixItemSprite(arg_6_1)
	end
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selectedController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

function var_0_0.GetIndex(arg_9_0)
	return arg_9_0.index
end

function var_0_0.UpdateAstrolabePreview(arg_10_0)
	local var_10_0 = MatrixItemCfg[arg_10_0.id]

	if var_10_0.matrix_item_type ~= MatrixConst.ITEM_TYPE.ASTROLABE then
		return
	end

	local var_10_1 = var_10_0.params[1]
	local var_10_2 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_10_1]
	local var_10_3 = math.floor(var_10_0.params[1] / 1000)
	local var_10_4 = arg_10_0:GetHeroData(var_10_3):GetAstrolabeNum(var_10_0.params[1])
	local var_10_5 = arg_10_0:GetHeroSkin(var_10_3)

	arg_10_0.m_heroImg.sprite = getSpriteViaConfig("HeroLittleIcon", var_10_5)

	local var_10_6 = var_10_4 + 1
	local var_10_7 = math.min(3, var_10_6)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.astrolabeImgs_) do
		if iter_10_0 <= var_10_7 then
			SetActive(iter_10_1.gameObject, true)

			iter_10_1.sprite = MatrixTools.GetMatrixItemSprite(arg_10_0.id)
		else
			SetActive(iter_10_1.gameObject, false)
		end
	end

	if var_10_7 > 0 then
		local var_10_8 = var_10_2[var_10_7]
		local var_10_9 = AstrolabeEffectCfg[var_10_8].desc[1]
		local var_10_10 = GetCfgDescription(var_10_9, 1)

		arg_10_0:SetDesc(var_10_10)

		local var_10_11 = HeroAstrolabeCfg[var_10_8]

		arg_10_0.m_name1.text = GetI18NText(var_10_11.name)
		arg_10_0.m_name2.text = GetI18NText(var_10_11.name)
	else
		arg_10_0:SetDesc(var_10_0.desc)
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.GetHeroData(arg_12_0, arg_12_1)
	return MatrixData:GetHeroData(arg_12_1)
end

function var_0_0.GetHeroSkin(arg_13_0, arg_13_1)
	return MatrixData:GetHeroSkin(arg_13_1)
end

function var_0_0.GetItemDes(arg_14_0, arg_14_1)
	return MatrixTools.GetMatrixItemDes(arg_14_1)
end

return var_0_0
