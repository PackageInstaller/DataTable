local MatrixOverBeaconItem = class("MatrixOverBeaconItem", ReduxView)

function MatrixOverBeaconItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function MatrixOverBeaconItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.btn_, nil, function()
		manager.matrixPop:ShowMatrixBeaconPopItem(self.id, Vector3(-0.8, self.transform_.position.y + 0.1, self.transform_.position.z))
	end)
end

function MatrixOverBeaconItem:Refresh(arg_4_1)
	self.id = arg_4_1
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixArtifact/" .. MatrixBeaconCfg[arg_4_1].icon)
end

return MatrixOverBeaconItem
