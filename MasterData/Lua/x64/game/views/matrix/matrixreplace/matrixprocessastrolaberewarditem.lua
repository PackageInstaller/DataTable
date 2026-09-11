local MatrixProcessAstrolabeRewardItem = class("MatrixProcessAstrolabeRewardItem", MatrixProcessRewardItem)

function MatrixProcessAstrolabeRewardItem:UpdateAstrolabePreview()
	if MatrixItemCfg[self.id].matrix_item_type ~= MatrixConst.ITEM_TYPE.ASTROLABE then
		return
	end

	local var_1_0 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[MatrixItemCfg[self.id].params[1]]
	local var_1_1 = math.floor(MatrixItemCfg[self.id].params[1] / 1000)

	self.m_heroImg.sprite = getSpriteViaConfig("HeroLittleIcon", (self:GetHeroSkin(var_1_1)))

	local var_1_2 = math.min(3, (self:GetHeroData(var_1_1):GetAstrolabeNum(MatrixItemCfg[self.id].params[1])))

	for iter_1_0, iter_1_1 in ipairs(self.astrolabeImgs_) do
		if iter_1_0 <= var_1_2 then
			SetActive(iter_1_1.gameObject, true)

			iter_1_1.sprite = MatrixTools.GetMatrixItemSprite(self.id)
		else
			SetActive(iter_1_1.gameObject, false)
		end
	end

	if var_1_2 > 0 then
		self:SetDesc((GetCfgDescription(AstrolabeEffectCfg[var_1_0[var_1_2]].desc[1], 1)))

		self.m_name1.text = GetI18NText(HeroAstrolabeCfg[var_1_0[var_1_2]].name)
		self.m_name2.text = GetI18NText(HeroAstrolabeCfg[var_1_0[var_1_2]].name)
	else
		self:SetDesc(MatrixItemCfg[self.id].desc)
	end
end

function MatrixProcessAstrolabeRewardItem:GetHeroData(arg_2_1)
	return MatrixData:GetHeroData(arg_2_1)
end

function MatrixProcessAstrolabeRewardItem:GetHeroSkin(arg_3_1)
	return MatrixData:GetHeroSkin(arg_3_1)
end

return MatrixProcessAstrolabeRewardItem
