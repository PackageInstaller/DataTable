local QWorldQuestSideView = class("QWorldQuestSideView", ReduxView)

function QWorldQuestSideView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldQuestSideView:OnCtor(arg_2_1, arg_2_2)
	self.gameObject_ = arg_2_1
	self.transform_ = self.gameObject_.transform
	self.mainHomePage_ = arg_2_2

	self:InitUI()
end

function QWorldQuestSideView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.items_ = {}

	SetActive(self.questCondItemGo_, false)

	self.itemsNew_ = {}
	self.typeController_ = self.questConEx_:GetController("type")
	self.animTimers_ = {}
	self.lastTrackingId_ = -1

	SetActive(self.questFinishGo_, false)
	SetActive(self.questNewGo_, false)
	SetActive(self.questNewItemGo_, false)
	SetActive(self.questCondItemGo_, false)
end

function QWorldQuestSideView:AddUIListener()
	self:AddBtnListener(self.questSideBtn_, nil, function()
		if not self.mainHomePage_:CheckCanInteract() then
			return
		end

		if self.questIdNew_ ~= nil then
			if self.questIdNew_ ~= QWorldQuestTool.GetMainQuestTrackingId() then
				QWorldQuestAction.UpdateTrackingMainQuestId(self.questIdNew_, function()
					QWorldQuestAction.SendUpdateQuestTrackToSdk(self.questIdNew_, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
					QWorldNotifyQueue:ClearQuestNewQueue()
					QWorldNotifyQueue:ResetNotifyTime()
					self:ShowTrackingMainQuest()
				end)
			else
				QWorldNotifyQueue:ClearQuestNewQueue()
				QWorldNotifyQueue:ResetNotifyTime()
				self:ShowTrackingMainQuest()
			end

			return
		end

		self.mainHomePage_.fadeAnim = true

		JumpTools.OpenPageByJump("/qworldQuestMain", {})
	end)

	if self.gmBtn_ then
		self:AddBtnListener(self.gmBtn_, nil, function()
			if not Application.isEditor then
				return
			end

			if not QWorldGmView then
				QWorldGmView = import("game.qworld.gm.QWorldGmView")
				gameContext.routesCfg_.qworldGmView = {
					name = "qworldGmView",
					component = QWorldGmView
				}
			end

			JumpTools.OpenPageByJump("/qworldGmView", {})
		end)
	end
end

function QWorldQuestSideView:OnEnter()
	return
end

function QWorldQuestSideView:OnTop()
	self.noHideFx_ = true

	self:ShowTrackingMainQuest()
	self.questPanelAni_:Update(99999)

	for iter_9_0, iter_9_1 in ipairs(self.items_) do
		if iter_9_1.gameObject_.activeSelf then
			iter_9_1:GetAnimator():Update(99999)
		end
	end
end

function QWorldQuestSideView:OnBehind()
	return
end

function QWorldQuestSideView:OnExit()
	return
end

function QWorldQuestSideView:OnQWorldMainQuestUpdate(arg_12_1)
	if self.questIdNew_ or self.questIdFinish_ then
		return
	end

	self.conditionFx_ = arg_12_1 == self.lastTrackingId_ and self.lastTrackingId_ ~= -1 and self.lastTrackingId_ == QWorldQuestTool.GetMainQuestTrackingId()

	self:ShowTrackingMainQuest()
end

function QWorldQuestSideView:OnQWorldQuestUpdateProgress()
	if self.questIdNew_ or self.questIdFinish_ then
		return
	end

	if QWorldQuestTool.MainQuestHasRealtimeProgress(QWorldQuestTool.GetMainQuestTrackingId()) then
		self:RefreshUI()
	end
end

function QWorldQuestSideView:OnNotifyQueueEnd()
	if self.questIdNew_ or self.questIdFinish_ then
		self:ShowTrackingMainQuest()
	end
end

local function var_0_1(arg_15_0)
	local var_15_0 = 5381

	for iter_15_0 = 1, #arg_15_0 do
		var_15_0 = var_15_0 * 32 + var_15_0 + arg_15_0:byte(iter_15_0)
	end

	return var_15_0
end

local function var_0_2(arg_16_0)
	return var_0_1(SandplayTaskCfg[arg_16_0].task_target) + QWorldQuestTool.GetQuestProgress(arg_16_0)
end

function QWorldQuestSideView:RefreshUI()
	local var_17_0 = self.questIdNew_ or self.questIdFinish_ or QWorldQuestTool.GetMainQuestTrackingId()
	local var_17_1 = QWorldQuestData:GetMainQuestData(var_17_0)

	if not var_17_1 then
		SetActive(self.questContentGo_, false)
		self:_StopAllAnimatorTimer()
	else
		SetActive(self.questContentGo_, self.enabled_ ~= false)

		self.questTitleText_.text = SandplayTaskMainCfg[var_17_1.id].title

		local var_17_2 = QWorldQuestTool.GetVisibleQuestIdList(var_17_1.id, true)
		local var_17_3 = #var_17_2
		local var_17_4

		if self.questIdNew_ then
			var_17_4 = self.itemsNew_ or self.items_

			local var_17_5

			if self.questIdNew_ then
				var_17_5 = self.questNewGo_.transform or self.questCondListTrans_

				local var_17_6

				if self.questIdNew_ then
					var_17_6 = self.questNewItemGo_ or self.questCondItemGo_
				end
			end
		end

		for iter_17_0, iter_17_1 in ipairs(var_17_4) do
			SetActive(iter_17_1.gameObject_, iter_17_0 <= var_17_3)
			self:_StopAnimatorTimer(iter_17_1:GetAnimator())
		end

		for iter_17_2 = 1, var_17_3 do
			local var_17_7 = var_17_4[iter_17_2]

			if not var_17_4[iter_17_2] then
				local var_17_8 = Object.Instantiate(var_17_6, var_17_5)

				SetActive(var_17_8, true)

				var_17_7 = QWorldSideQuestItem.New(var_17_8)
				var_17_4[iter_17_2] = var_17_7
			end

			local var_17_9 = var_17_2[iter_17_2]

			if self.conditionFx_ and (var_17_7.__hash == nil or var_17_7.__hash ~= var_0_2(var_17_9)) then
				self:_PlayAnimatorWithCallback(var_17_7:GetAnimator(), "UI_newtaskItem_xs", function()
					var_17_7:SetData(var_17_9)

					var_17_7.__hash = var_0_2(var_17_9)
				end)
			else
				var_17_7:SetData(var_17_9)

				var_17_7.__hash = var_0_2(var_17_9)
			end
		end

		if self.questIdNew_ then
			self.questTrackGo_.transform:SetAsLastSibling()
		end

		local var_17_10 = SandplayTaskMainCfg[var_17_0].main_task_type

		if SandplayTaskMainCfg[var_17_0].main_task_type == QWorldQuestConst.QUEST_TASK_TYPE.MAIN then
			self.typeController_:SetSelectedState("main")
		elseif var_17_10 == QWorldQuestConst.QUEST_TASK_TYPE.SIDE then
			self.typeController_:SetSelectedState("side")
		elseif var_17_10 == QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE then
			self.typeController_:SetSelectedState("explore")
		end

		self.conditionFx_ = nil

		if self.needTitleFx_ then
			if var_17_10 == QWorldQuestConst.QUEST_TASK_TYPE.MAIN then
				self.questTitleAni_:Play("UI_questPanel_title_yellow", -1, 0)
			elseif var_17_10 == QWorldQuestConst.QUEST_TASK_TYPE.SIDE then
				self.questTitleAni_:Play("UI_questPanel_title_blue", -1, 0)
			elseif var_17_10 == QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE then
				self.questTitleAni_:Play("UI_questPanel_title_green", -1, 0)
			end

			self.needTitleFx_ = nil
		else
			self.questTitleAni_:Play("UI_questPanel_title", -1, 0)
		end
	end

	if self.mainHomePage_.rewardPanelGo_.activeSelf then
		self.mainHomePage_:UpdateLeftPanelLayout()
	end
end

function QWorldQuestSideView:HideSideUI(arg_19_1)
	if not self.questContentGo_.activeSelf or self.noHideFx_ then
		self.noHideFx_ = nil

		self:_StopAnimatorTimer(self.questPanelAni_)

		if arg_19_1 then
			arg_19_1()
		end

		return
	end

	self:_PlayAnimatorWithCallback(self.questPanelAni_, "UI_questPanel_xs", function()
		if arg_19_1 then
			arg_19_1()
		else
			SetActive(self.questContentGo_, false)
		end
	end)
end

function QWorldQuestSideView:ShowMainQuestsFinish(arg_21_1)
	self.questIdNew_ = nil
	self.questIdFinish_ = arg_21_1

	self:HideSideUI(function()
		self:_RemoveQuestCondition()
		self:_RemoveNewQuestCondition()
		SetActive(self.questFinishGo_, true)
		SetActive(self.questContentGo_, true)
		self.questPanelAni_:Play("UI_questPanel")
		self.questPanelAni_:Update(0)
		self:RefreshUI()
	end)
end

function QWorldQuestSideView:ShowMainQuestsNew(arg_23_1)
	self.questIdNew_ = arg_23_1
	self.questIdFinish_ = nil

	self:HideSideUI(function()
		self:_RemoveQuestCondition()
		SetActive(self.questFinishGo_, false)
		SetActive(self.questNewGo_, true)

		self.needTitleFx_ = true

		SetActive(self.questContentGo_, true)
		self.questPanelAni_:Play("UI_questPanel")
		self.questPanelAni_:Update(0)
		self:RefreshUI()
	end)
end

function QWorldQuestSideView:ShowTrackingMainQuest()
	self.questIdNew_ = nil
	self.questIdFinish_ = nil

	if self.lastTrackingId_ ~= QWorldQuestTool.GetMainQuestTrackingId() or self.questIdNew_ ~= nil or self.questIdFinish_ ~= nil then
		self:HideSideUI(function()
			self.lastTrackingId_ = QWorldQuestTool.GetMainQuestTrackingId()

			SetActive(self.questFinishGo_, false)
			self:_RemoveNewQuestCondition()
			SetActive(self.questContentGo_, true)
			self.questPanelAni_:Play("UI_questPanel")
			self.questPanelAni_:Update(0)
			self:RefreshUI()
		end)
	else
		self.noHideFx_ = nil

		SetActive(self.questFinishGo_, false)
		self:_RemoveNewQuestCondition()
		SetActive(self.questContentGo_, true)
		self.questPanelAni_:Play("UI_questPanel")
		self.questPanelAni_:Update(0)
		self:RefreshUI()
	end
end

function QWorldQuestSideView:_RemoveQuestCondition()
	for iter_27_0, iter_27_1 in ipairs(self.items_) do
		SetActive(iter_27_1.gameObject_, false)
	end
end

function QWorldQuestSideView:_RemoveNewQuestCondition()
	for iter_28_0, iter_28_1 in ipairs(self.itemsNew_) do
		Object.Destroy(self.items_.gameObject_)
		iter_28_1:Dispose()
	end

	SetActive(self.questNewGo_, false)
end

function QWorldQuestSideView:_PlayAnimatorWithCallback(arg_29_1, arg_29_2, arg_29_3)
	self:_StopAnimatorTimer(arg_29_1)
	arg_29_1:Play(arg_29_2)
	arg_29_1:Update(0)

	local var_29_0 = Timer.New(function()
		local var_30_0 = arg_29_1:GetCurrentAnimatorStateInfo(0)

		if var_30_0:IsName(arg_29_2) and var_30_0.normalizedTime >= 1 then
			if self.animTimers_[arg_29_1] ~= nil then
				self.animTimers_[arg_29_1]:Stop()

				self.animTimers_[arg_29_1] = nil
			end

			if arg_29_3 ~= nil then
				arg_29_3()
			end
		end
	end, 0.033, -1)

	var_29_0:Start()

	self.animTimers_[arg_29_1] = var_29_0
end

function QWorldQuestSideView:_StopAnimatorTimer(arg_31_1)
	if self.animTimers_[arg_31_1] then
		self.animTimers_[arg_31_1]:Stop()

		self.animTimers_[arg_31_1] = nil
	end
end

function QWorldQuestSideView:_StopAllAnimatorTimer()
	for iter_32_0, iter_32_1 in pairs(self.animTimers_) do
		iter_32_1:Stop()
	end

	self.animTimers_ = {}
end

function QWorldQuestSideView:Dispose()
	for iter_33_0, iter_33_1 in ipairs(self.items_) do
		iter_33_1:Dispose()
	end

	self:_RemoveNewQuestCondition()
	self:_StopAllAnimatorTimer()

	self.gameObject_ = nil
	self.transform_ = nil

	QWorldQuestSideView.super.Dispose(self)
end

return QWorldQuestSideView
