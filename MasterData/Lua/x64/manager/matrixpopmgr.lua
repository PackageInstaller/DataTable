local MatrixMgr = class("MatrixMgr")

function MatrixMgr:Ctor()
	return
end

function MatrixMgr:ShowPopItem(arg_2_1, arg_2_2, arg_2_3)
	self.popItemView_ = self.popItemView_ or MatrixItemInfoView.New(manager.ui.uiMain.transform)

	self.popItemView_:SetActive(true)
	self.popItemView_:SetWorldPosition(arg_2_3)
	self.popItemView_:RefreshText(arg_2_1, arg_2_2)
	self:AddClickTimer()
end

function MatrixMgr:ShowMatrixPopItem(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.popItemView_ = self.popItemView_ or MatrixItemInfoView.New(manager.ui.uiMain.transform)

	self.popItemView_:SetActive(true)
	self.popItemView_:SetWorldPosition(arg_3_2)
	self.popItemView_:Refresh(arg_3_1, arg_3_3, arg_3_4, arg_3_5)
	self:AddClickTimer()
end

function MatrixMgr:ShowMatrixAiffixPopItem(arg_4_1, arg_4_2)
	self.popItemView_ = self.popItemView_ or MatrixItemInfoView.New(manager.ui.uiMain.transform)

	self.popItemView_:SetActive(true)
	self.popItemView_:SetWorldPosition(arg_4_2)
	self.popItemView_:RefreshAffix(arg_4_1)
	self:AddClickTimer()
end

function MatrixMgr:ShowMatrixBeaconPopItem(arg_5_1, arg_5_2)
	self.popItemView_ = self.popItemView_ or MatrixItemInfoView.New(manager.ui.uiMain.transform)

	self.popItemView_:SetActive(true)
	self.popItemView_:SetWorldPosition(arg_5_2)
	self.popItemView_:RefreshBeacon(arg_5_1)
	self:AddClickTimer()
end

function MatrixMgr:HideItem()
	self.popItemView_:SetActive(false)
end

function MatrixMgr:AddClickTimer()
	self:StopTimer()

	self.buttonUp_ = 0
	self.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			self.buttonUp_ = self.buttonUp_ + 1

			if self.buttonUp_ >= 2 then
				self:HideItem()
				FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

				self.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function MatrixMgr:StopTimer()
	if self.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

		self.clickTimer_ = nil
	end
end

function MatrixMgr:Dispose()
	self:StopTimer()

	if self.popItemView_ then
		self.popItemView_:Dispose()

		self.popItemView_ = nil
	end
end

return MatrixMgr
