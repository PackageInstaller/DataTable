local ChapterChallengeMatrixItemView = class("ChapterChallengeMatrixItemView", (import(".ChapterChallengeItemWithCD")))

function ChapterChallengeMatrixItemView:Ctor(...)
	ChapterChallengeMatrixItemView.super.Ctor(self, ...)

	self.updateHandler_ = handler(self, self.UpdateMatrix)
end

function ChapterChallengeMatrixItemView:OnEnter()
	ChapterChallengeMatrixItemView.super.OnEnter(self)
	manager.notify:RegistListener(MATRIX_UPDATE, self.updateHandler_)
end

function ChapterChallengeMatrixItemView:OnExit()
	manager.notify:RemoveListener(MATRIX_UPDATE, self.updateHandler_)
	ChapterChallengeMatrixItemView.super.OnExit(self)
end

function ChapterChallengeMatrixItemView:Dispose()
	self.updateHandler_ = nil

	ChapterChallengeMatrixItemView.super.Dispose(self)
end

function ChapterChallengeMatrixItemView:GetLostTime()
	return ActivityData:GetActivityData((PolyhedronData:GetActivityID())).stopTime
end

function ChapterChallengeMatrixItemView:ClickItem()
	if self.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_polyhedron_above")

		self.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_polyhedron_below")
	end

	if self:CheckLock() then
		return
	end

	local var_6_0 = PolyhedronData:GetPolyhedronInfo()

	if not var_6_0 then
		return
	end

	if not ActivityData:GetActivityIsOpen((PolyhedronData:GetActivityID())) then
		ShowTips("TIME_OVER")

		return
	end

	if self.isShowNew_ == 1 and not self.isLock_ then
		self.isShowNew_ = 0

		RedPointData:SetJsonCacheRedPoint("Polyhedron")
		manager.redPoint:bindUIandKey(self.panelTf_, RedPointConst.POLYHEDRON)
	end

	if PolyhedronConst.STATE_TYPE.SETTLEMENT == var_6_0:GetState() then
		JumpTools.GoToSystem("/polyhedronBlank/polyhedronOver", nil, ViewConst.SYSTEM_ID.MATRIX)
	else
		JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil, ViewConst.SYSTEM_ID.MATRIX)
	end
end

function ChapterChallengeMatrixItemView:AddRedPoint()
	self.isShowNew_ = RedPointData:GetJsonCacheRedPoint("Polyhedron")

	manager.redPoint:bindUIandKey(self.panelTf_, RedPointConst.POLYHEDRON)
end

function ChapterChallengeMatrixItemView:RemoveRedPoint()
	manager.redPoint:unbindUIandKey(self.panelTf_)
end

function ChapterChallengeMatrixItemView:UpdateMatrix()
	manager.redPoint:unbindUIandKey(self.panelTf_)
	self:AddRedPoint()
end

function ChapterChallengeMatrixItemView:RefreshTimeText()
	self.timeLock_ = manager.time:GetServerTime() >= self:GetLostTime()

	if self.tiemLock_ ~= self.timeLock_ then
		self:RefreshLock()
	end

	if self.timeLock_ or self.isLock_ then
		self.timeText_.text = ""

		self.timeController_:SetSelectedState("state1")
	else
		self.timeController_:SetSelectedState("state0")

		self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr(self:GetLostTime(), nil, true))
	end
end

return ChapterChallengeMatrixItemView
