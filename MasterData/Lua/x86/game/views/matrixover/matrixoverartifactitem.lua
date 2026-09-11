local MatrixOverArtifactItem = class("MatrixOverArtifactItem", ReduxView)

function MatrixOverArtifactItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function MatrixOverArtifactItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.btn_, nil, function()
		if self.id and self.id ~= 0 then
			manager.matrixPop:ShowMatrixPopItem(self.id, Vector3(-1, self.transform_.position.y + 0.1, self.transform_.position.z), self.level)
		end
	end)
end

function MatrixOverArtifactItem:Refresh(arg_4_1)
	self.id = arg_4_1.id
	self.level = nil

	if MatrixConst.EFFECT_ACTION.AFFIX == MatrixEffectCfg[MatrixItemCfg[arg_4_1.id].params[1]].action then
		if AffixTypeCfg[MatrixEffectCfg[MatrixItemCfg[arg_4_1.id].params[1]].params[1]].max_level ~= 1 then
			self.level = math.min(arg_4_1.wins, AffixTypeCfg[MatrixEffectCfg[MatrixItemCfg[arg_4_1.id].params[1]].params[1]].max_level)
		end
	end

	self.icon_.sprite = MatrixTools.GetMatrixItemSprite(arg_4_1.id)
end

return MatrixOverArtifactItem
