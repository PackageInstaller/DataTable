local MatrixOverEvaluateItem = class("MatrixOverEvaluateItem", ReduxView)

function MatrixOverEvaluateItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
end

function MatrixOverEvaluateItem:SetEvaluateID(arg_2_1)
	self.titleText_.text = GetI18NText(MatrixEvaluateCfg[arg_2_1].title)
	self.infoText_.text = GetI18NText(MatrixEvaluateCfg[arg_2_1].condition)

	local var_2_0 = "icon_matrix_assess_b"

	if MatrixEvaluateCfg[arg_2_1].class == 3 then
		var_2_0 = "icon_matrix_assess_s"
	elseif MatrixEvaluateCfg[arg_2_1].class == 2 then
		var_2_0 = "icon_matrix_assess_a"
	end

	self.icon_.sprite = getSprite("Atlas/Matrix", var_2_0)

	self:Show(true)
end

function MatrixOverEvaluateItem:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function MatrixOverEvaluateItem:Dispose()
	MatrixOverEvaluateItem.super.Dispose(self)
end

return MatrixOverEvaluateItem
