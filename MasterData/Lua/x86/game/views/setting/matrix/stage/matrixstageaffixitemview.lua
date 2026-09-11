local MatrixStageAffixItemView = class("MatrixStageAffixItemView", ReduxView)

function MatrixStageAffixItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:SetData(arg_1_3)
	self:Show(true)
end

function MatrixStageAffixItemView:SetData(arg_2_1)
	self.nameText_.text = getAffixName(arg_2_1)
	self.icon_.sprite = getAffixSprite(arg_2_1)
	self.desc_.text = getAffixDesc(arg_2_1)

	self:Show(true)
end

function MatrixStageAffixItemView:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function MatrixStageAffixItemView:Dispose()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil

	MatrixStageAffixItemView.super.Dispose(self)
end

return MatrixStageAffixItemView
