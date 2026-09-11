local DestroyBoxGameNormalView = class("DestroyBoxGameNormalView", ReduxView)

function DestroyBoxGameNormalView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.difficultController_ = ControllerUtil.GetController(self.transform_, "difficult")
	self.lockController_ = self.lockControllerexcollection_:GetController("lock")
	self.boxItemList_ = {}
	self.selectDifficult_ = 1
end

function DestroyBoxGameNormalView:OnEnter(arg_2_1)
	self.mainActivityID_ = arg_2_1
	self.selectID_ = DestroyBoxGameData:GetSelectID(arg_2_1)
	self.selectDifficult_ = DestroyBoxGameData:GetSelectDifficult(arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(DestroyBoxGameData:GetDifficultList(arg_2_1)[self.selectDifficult_]) do
		if self[string.format("item%dGo_", iter_2_0)] then
			self.boxItemList_[iter_2_0] = self.boxItemList_[iter_2_0] or DestroyBoxGameNormalItemView.New(self[string.format("item%dGo_", iter_2_0)], self.itemParent_, iter_2_0)

			self.boxItemList_[iter_2_0]:OnEnter(iter_2_1)
		end
	end

	self:RefreshDifficult()
	self:AddRedPoint()
end

function DestroyBoxGameNormalView:OnExit()
	for iter_3_0, iter_3_1 in ipairs(self.boxItemList_) do
		iter_3_1:OnExit()
	end

	self:RemoveRedPoint()
end

function DestroyBoxGameNormalView:Dispose()
	DestroyBoxGameNormalView.super.Dispose(self)

	for iter_4_0, iter_4_1 in ipairs(self.boxItemList_) do
		iter_4_1:Dispose()
	end

	self.boxItemList_ = nil
	self.transform_ = nil
	self.gameObject_ = nil
end

function DestroyBoxGameNormalView:AddListeners()
	self:AddBtnListener(self.normalBtn_, nil, function()
		local var_6_0 = DestroyBoxGameData:GetLastSelectNormalID(self.mainActivityID_)

		self:SwitchDifficult(2)
	end)
	self:AddBtnListener(self.hardBtn_, nil, function()
		self:SwitchDifficult(1)
	end)
end

function DestroyBoxGameNormalView:RefreshDifficult()
	if self.selectDifficult_ == 1 then
		self.difficultController_:SetSelectedState("normal")
	else
		self.difficultController_:SetSelectedState("hard")
	end

	if DestroyBoxGameData:IsFinishPreStage((DestroyBoxGameData:GetLastSelectNormalID(self.mainActivityID_))) then
		-- block empty
	end
end

function DestroyBoxGameNormalView:SwitchDifficult(arg_9_1)
	if self.selectDifficult_ ~= arg_9_1 then
		self.selectDifficult_ = arg_9_1
		self.selectID_ = DestroyBoxGameData:SwitchDifficult(self.selectID_, self.selectDifficult_)

		DestroyBoxGameData:SetSelectIDAndDifficult(DestroyBoxGameCfg[self.selectID_].main_activity_id, self.selectID_, self.selectDifficult_)
		self:RefreshItemList()
		self:RefreshScore()
		self:RefreshDifficult()
	end
end

function DestroyBoxGameNormalView:SwitchSelectItem(arg_10_1)
	self.selectID_ = arg_10_1

	for iter_10_0, iter_10_1 in ipairs(self.boxItemList_) do
		iter_10_1:SwitchSelectItem(arg_10_1)
	end

	self:RefreshScore()
end

function DestroyBoxGameNormalView:RefreshItemList()
	for iter_11_0, iter_11_1 in ipairs(self.boxItemList_) do
		iter_11_1:SwitchDifficult()
	end
end

function DestroyBoxGameNormalView:RefreshScore()
	local var_12_0 = DestroyBoxGameData:GetLastSelectNormalID(self.mainActivityID_)

	if table.keyof(DestroyBoxGameData:GetDifficultList(self.mainActivityID_)[self.selectDifficult_], var_12_0) == nil then
		print("mainActivityID:", self.mainActivityID_, "difficult:", self.selectDifficult_, "lastID:", var_12_0)

		self.selectDifficult_ = 1

		DestroyBoxGameData:SetSelectIDAndDifficult(self.mainActivityID_, DestroyBoxGameCfg.get_id_list_by_main_activity_id[self.mainActivityID_][1], 1)
		self:RefreshDifficult()
		self:RefreshItemList()
	end
end

function DestroyBoxGameNormalView:AddRedPoint()
	manager.redPoint:bindUIandKey(self.normalGo_.transform, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 1, self.mainActivityID_))
	manager.redPoint:bindUIandKey(self.hardGo_.transform, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 2, self.mainActivityID_))
end

function DestroyBoxGameNormalView:RemoveRedPoint()
	manager.redPoint:unbindUIandKey(self.normalGo_.transform, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 1, self.mainActivityID_))
	manager.redPoint:unbindUIandKey(self.hardGo_.transform, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 2, self.mainActivityID_))
end

return DestroyBoxGameNormalView
