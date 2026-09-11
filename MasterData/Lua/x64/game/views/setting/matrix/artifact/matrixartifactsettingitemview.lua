local MatrixArtifactSettingItem = class("MatrixArtifactSettingItem", ReduxView)

function MatrixArtifactSettingItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
end

function MatrixArtifactSettingItem:SetData(arg_2_1)
	self.name_.text = GetI18NText(MatrixItemCfg[arg_2_1].name)
	self.desc_.text = MatrixTools.GetMatrixItemDes(arg_2_1)
	self.icon_.sprite = MatrixTools.GetMatrixItemSprite(arg_2_1)
end

function MatrixArtifactSettingItem:Dispose()
	MatrixArtifactSettingItem.super.Dispose(self)

	self.icon_.sprite = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return MatrixArtifactSettingItem
