local MatrixTreasureAtlasItem = class("MatrixTreasureAtlasItem", ReduxView)

function MatrixTreasureAtlasItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function MatrixTreasureAtlasItem:initUI()
	self:BindCfgUI()

	self.rareController_ = ControllerUtil.GetController(self.transform_, "rare")
end

function MatrixTreasureAtlasItem:Refresh(arg_3_1, arg_3_2)
	self.m_name.text = GetI18NText(MatrixItemCfg[arg_3_1].name)
	self.m_des.text = GetI18NText(MatrixTools.GetMatrixItemDes(arg_3_1))
	self.m_icon.sprite = MatrixTools.GetMatrixItemSprite(arg_3_1)

	self.rareController_:SetSelectedIndex(MatrixItemCfg[arg_3_1].rare)

	if arg_3_2 then
		if MatrixConst.EFFECT_ACTION.AFFIX == MatrixEffectCfg[MatrixItemCfg[arg_3_1].params[1]].action then
			if AffixTypeCfg[MatrixEffectCfg[MatrixItemCfg[arg_3_1].params[1]].params[1]].max_level ~= 1 then
				self.m_name.text = GetI18NText(MatrixItemCfg[arg_3_1].name) .. "Lv" .. math.min(arg_3_2, AffixTypeCfg[MatrixEffectCfg[MatrixItemCfg[arg_3_1].params[1]].params[1]].max_level)
			end
		end
	end
end

return MatrixTreasureAtlasItem
