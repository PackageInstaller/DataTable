local var_0_0 = class("MatrixProcessAstrolabeRewardItem", MatrixProcessRewardItem)

function var_0_0.UpdateAstrolabePreview(arg_1_0)
	local var_1_0 = MatrixItemCfg[arg_1_0.id]

	if var_1_0.matrix_item_type ~= MatrixConst.ITEM_TYPE.ASTROLABE then
		return
	end

	local var_1_1 = var_1_0.params[1]
	local var_1_2 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_1_1]
	local var_1_3 = math.floor(var_1_0.params[1] / 1000)
	local var_1_4 = arg_1_0:GetHeroData(var_1_3):GetAstrolabeNum(var_1_0.params[1])
	local var_1_5 = arg_1_0:GetHeroSkin(var_1_3)

	arg_1_0.m_heroImg.sprite = getSpriteViaConfig("HeroLittleIcon", var_1_5)

	local var_1_6 = math.min(3, var_1_4)

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.astrolabeImgs_) do
		if iter_1_0 <= var_1_6 then
			SetActive(iter_1_1.gameObject, true)

			iter_1_1.sprite = MatrixTools.GetMatrixItemSprite(arg_1_0.id)
		else
			SetActive(iter_1_1.gameObject, false)
		end
	end

	if var_1_6 > 0 then
		local var_1_7 = var_1_2[var_1_6]
		local var_1_8 = AstrolabeEffectCfg[var_1_7].desc[1]
		local var_1_9 = GetCfgDescription(var_1_8, 1)

		arg_1_0:SetDesc(var_1_9)

		local var_1_10 = HeroAstrolabeCfg[var_1_7]

		arg_1_0.m_name1.text = GetI18NText(var_1_10.name)
		arg_1_0.m_name2.text = GetI18NText(var_1_10.name)
	else
		arg_1_0:SetDesc(var_1_0.desc)
	end
end

function var_0_0.GetHeroData(arg_2_0, arg_2_1)
	return MatrixData:GetHeroData(arg_2_1)
end

function var_0_0.GetHeroSkin(arg_3_0, arg_3_1)
	return MatrixData:GetHeroSkin(arg_3_1)
end

return var_0_0
