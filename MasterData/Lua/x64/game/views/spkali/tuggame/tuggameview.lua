local TugGameView = class("TugGameView", ReduxView)

function TugGameView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_TugGameCheckpointUI"
end

function TugGameView:UIParent()
	return manager.ui.uiMain.transform
end

function TugGameView:OnCtor()
	self.selectIndex = 0
	self.nowIndex = 1
	self.isStopAni = true
	self.passIndex = 0
end

function TugGameView:Init()
	self:InitUI()
end

function TugGameView:InitUI()
	self:BindCfgUI()

	self.nodeList = {}
	self.pointlist = {}
	self.selectIndex = nil
	self.stageScroll_ = LuaList.New(handler(self, self.RefreshItem), self.uilistGo_, TugGameItem)
end

function TugGameView:RefreshItem(arg_6_1, arg_6_2)
	arg_6_2:SetActivityID(self.activityID_)
	arg_6_2:SetData(self.pointlist[arg_6_1], arg_6_1, #self.pointlist, self)
end

function TugGameView:SetSelect(arg_7_1)
	if self.selectIndex then
		local var_7_0 = self.stageScroll_:GetItemByIndex(self.selectIndex)

		if var_7_0 then
			var_7_0:SetSelect(false)
		end
	end

	self.selectIndex = arg_7_1

	local var_7_1 = self.stageScroll_:GetItemByIndex(self.selectIndex)

	if var_7_1 then
		var_7_1:SetSelect(true)
	end

	local var_7_2 = self.viewportTrs_.rect.width
	local var_7_3 = self.selectIndex * 500 - self.viewportTrs_.rect.width / 2

	if self.isStopAni then
		var_7_3 = math.min(math.max(self.selectIndex * 500 - var_7_2 / 2, 0), #self.nodeList * 500 - var_7_2)
		self.isStopAni = false
	end

	self.moveLeanTween_ = LeanTween.moveLocalX(self.contentTrs_.gameObject, -var_7_3, 0.3):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		self:StopLeanTween()
	end))

	SPKaliChallengeData:SaveTugPointPos(Mathf.Clamp((self.selectIndex - 1) * 500 / (self.contentTrs_.sizeDelta.x - var_7_2), 0, 1))
end

function TugGameView:AddListeners()
	self:AddBtnListener(self.taskbtnBtn_, nil, "OnTask")

	for iter_9_0 = 1, 2 do
		self:AddBtnListener(self[string.format("nextbtn0%sBtn_", iter_9_0)], nil, function()
			self:ChangeTab(iter_9_0)
		end)
	end
end

function TugGameView:StopLeanTween()
	if self.moveLeanTween_ then
		self.moveLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.moveLeanTween_.id)

		self.moveLeanTween_ = nil
	end
end

function TugGameView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_KALI_DESC_2")
end

function TugGameView:OnTop()
	self.uilistSr_.enabled = true
	self.isStopAni = false

	if self.selectIndex then
		local var_13_0 = self.stageScroll_:GetItemByIndex(self.selectIndex)

		if var_13_0 then
			var_13_0:SetSelect(false)
		end

		self:UpdateSCorll()
	end

	self:ChangeBar()
end

function TugGameView:OnEnter()
	if self.params_ then
		self.activityID_ = self.params_.activityID_ or ActivityConst.ACTIVITY_3_6_KALI_TUGGAME
	end

	self:UpdateStage()
	self:RegistEventListener(ACTIVITY_KALI_INFO, function()
		self:UpdateStage()
	end)
end

function TugGameView:AddRedPoint()
	return
end

function TugGameView:RemoveRedPoint()
	return
end

function TugGameView:UpdateSelectMove()
	self.scrollviewSr_.horizontalNormalizedPosition = self.passIndex / #self.pointlist
end

function TugGameView:UpdateStage()
	self.pointlist = SpKaliTool.GetTugGameStageData(self.activityID_)

	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(self.pointlist) do
		if iter_19_1 and iter_19_1.passState then
			var_19_0 = iter_19_0
		end
	end

	self:UpdateSCorll()

	self.texttittle02Text_.text = string.format("%s/%s", var_19_0, #self.pointlist)
end

function TugGameView:UpdateSCorll()
	self.stageScroll_:StartScrollByPosition(#self.pointlist, (SPKaliChallengeData.pos2 or nil) and Vector2.New(SPKaliChallengeData.pos2, 0))
end

function TugGameView:OnExit()
	TugGameView.super.OnExit(self)
	self:RemoveRedPoint()
	manager.windowBar:HideBar()

	self.isStopAni = true
end

function TugGameView:Dispose()
	TugGameView.super.Dispose(self)

	if self.stageScroll_ then
		self.stageScroll_:Dispose()
	end

	self:StopLeanTween()
end

return TugGameView
