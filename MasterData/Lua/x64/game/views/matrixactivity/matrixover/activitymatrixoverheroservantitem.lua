local ActivityMatrixOverHeroServantItem = class("ActivityMatrixOverHeroServantItem", (import("game.views.matrixOver.MatrixOverHeroServantItem")))

function ActivityMatrixOverHeroServantItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddBtnListener(self.btn_, nil, function()
		if self.matrixServantID and self.matrixServantID ~= 0 then
			manager.matrixPop:ShowMatrixPopItem(self.matrixServantID, Vector3(-0.45, self.transform_.position.y + 0.1, self.transform_.position.z), nil, nil, self.matrix_activity_id)
		end
	end)
end

function ActivityMatrixOverHeroServantItem:SetMatrixActivityId(arg_3_1)
	self.matrix_activity_id = arg_3_1
end

return ActivityMatrixOverHeroServantItem
