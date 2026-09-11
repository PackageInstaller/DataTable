local SkuldSystemStageView = class("SkuldSystemStageView", ReduxView)

function SkuldSystemStageView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_StageUI"
end

function SkuldSystemStageView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldSystemStageView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldSystemStageView:InitUI()
	self:BindCfgUI()

	self.curSectionIndex_ = 1
	self.curLevelID_ = 0
	self.selectLevelItemHandler_ = handler(self, self.OnSelectLevelItem)
	self.btnController1_ = self.btnCtrEx1_:GetController("select")
	self.btnController2_ = self.btnCtrEx2_:GetController("select")
	self.btnController3_ = self.btnCtrEx3_:GetController("select")
	self.btnLockController1_ = self.btnCtrEx1_:GetController("lock")
	self.btnLockController2_ = self.btnCtrEx2_:GetController("lock")
	self.btnLockController3_ = self.btnCtrEx3_:GetController("lock")
	self.stageController_ = self.stageCtrEx_:GetController("stage")

	for iter_4_0 = 1, 36 do
		self["levelItem" .. iter_4_0 .. "_"] = SkuldSystemStageItem.New(self["levelGo" .. iter_4_0 .. "_"], iter_4_0, SkuldStageCfg.all[iter_4_0], self.selectLevelItemHandler_)
	end

	self.trustItem_ = SkuldSystemTrustItem.New(self.trustGo_)
end

function SkuldSystemStageView:AddUIListeners()
	self:AddBtnListener(self.archiveCollectBtn_, nil, function()
		JumpTools.OpenPageByJump("stageArchiveCollect", {
			chapterID = self.chapterID_
		})
	end)

	for iter_5_0 = 1, 3 do
		self:AddBtnListener(self["sectionBtn" .. iter_5_0 .. "_"], nil, function()
			local var_7_0 = false

			for iter_7_0, iter_7_1 in pairs(SkuldStageCfg.get_id_list_by_section[iter_5_0]) do
				if SkuldSystemData:GetLevelIDIsOpen(iter_7_1) then
					var_7_0 = true

					break
				end
			end

			if var_7_0 then
				self.curSectionIndex_ = iter_5_0

				self:TryToCloseSectionView()
				self:RefreshUI()
				self:RemoveTween()

				self["scrollView" .. self.curSectionIndex_ .. "_"].horizontal = true

				if self.curScrollContent_.transform.localPosition.x > 0 then
					self.curScrollContent_.transform.localPosition = Vector3.New(0, self.curScrollContent_.transform.localPosition.y, self.curScrollContent_.transform.localPosition.z)
				end
			elseif iter_5_0 == 2 then
				ShowTips("SKULD_SECTION_UNLOCK1")
			elseif iter_5_0 == 3 then
				ShowTips("SKULD_SECTION_UNLOCK2")
			end
		end)
	end

	self:AddBtnListener(self.bgbtn_, nil, function()
		self:TryToCloseSectionView()
	end)
	self.scrollEvent1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		self:TryToCloseSectionView()
	end))
	self.scrollEvent1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
		self:TryToCloseSectionView()
	end))
	self.scrollEvent2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
		self:TryToCloseSectionView()
	end))
	self.scrollEvent2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		self:TryToCloseSectionView()
	end))
	self.scrollEvent3_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
		self:TryToCloseSectionView()
	end))
	self.scrollEvent3_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
		self:TryToCloseSectionView()
	end))
	self.scrollEvent4_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		self:TryToCloseSectionView()
	end))
	self.scrollEvent4_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		self:TryToCloseSectionView()
	end))
end

function SkuldSystemStageView:OnEnter()
	self.chapterID_ = 6010128
	self.lastAudioID_ = 0

	local var_17_0 = SkuldSystemData:GetCacheStageViewInfo(self.params_.isFinal)

	self.curSectionIndex_ = var_17_0 ~= nil and var_17_0.index or 1

	if self.params_.isFinal then
		for iter_17_0 = 31, 36 do
			self["levelItem" .. iter_17_0 .. "_"]:RefreshUI()
		end

		self.stageController_:SetSelectedState("statespecial")

		self.scrollView4_.horizontal = true
		self.curScrollContent_ = self.scrollContent4_
		self.curSectionIndex_ = 4
	else
		self["scrollView" .. self.curSectionIndex_ .. "_"].horizontal = true

		self.trustItem_:RefreshUI()
		self.trustItem_:OnEnter()
		self.trustItem_:SetCallBack(function()
			self:TryToCloseSectionView()
		end)

		self.curScrollContent_ = self["scrollContent" .. self.curSectionIndex_ .. "_"]

		self:RefreshUI()
	end

	if var_17_0 ~= nil then
		if var_17_0.positionx > 0 then
			var_17_0.positionx = 0
		end

		self.curScrollContent_.transform.localPosition = Vector3.New(var_17_0.positionx, var_17_0.positiony, var_17_0.positionz)
	end

	self:RefreshAudio()
	self:BindRedPoint()
end

function SkuldSystemStageView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.archiveCollectBtn_.transform, RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128")
end

function SkuldSystemStageView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.archiveCollectBtn_.transform, RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128")
end

function SkuldSystemStageView:OnEnterOver()
	self:PlayAni()
end

function SkuldSystemStageView:PlayAni()
	if self.animator_ then
		self.animator_:Play("Activity_Skuld_StageUI", -1, 0)
		self.animator_:Update(0)
	end

	local var_22_0 = SkuldSystemData:GetLevelIDIsClear(1026)
	local var_22_1 = SkuldSystemData:GetLevelIDIsClear(1027)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.aniCallback_ = nil
	self.timer_ = Timer.New(function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			if self.timer_ ~= nil then
				self.timer_:Stop()
			end

			if self.aniCallback_ then
				self.aniCallback_()
			end
		end
	end, 0.033, -1)

	if var_22_0 and not var_22_1 and not getData("skuldStageView", "hasViewAni") then
		self.curSectionIndex_ = 3

		self:RefreshUI()

		self.curScrollContent_ = self.scrollContent3_

		function self.aniCallback_()
			self.animator_:Play("bg", -1, 0)
			saveData("skuldStageView", "hasViewAni", true)

			function self.aniCallback_()
				SetActive(self.skuldGo_, false)
				self.animator_:Play("normal", -1, 0)
				SetActive(self.musicGo_, true)
				self:UpdateBar()
			end

			self.timer_:Start()
		end

		self.timer_:Start()
		SetActive(self.musicGo_, false)
		manager.windowBar:HideBar()
		SetActive(self.skuldGo_, true)
		SetActive(self.brokenBgGo_, true)
	elseif var_22_0 and not var_22_1 then
		SetActive(self.skuldGo_, false)
		SetActive(self.brokenBgGo_, true)

		function self.aniCallback_()
			self.animator_:Play("normal", -1, 0)
		end

		self.timer_:Start()
	else
		SetActive(self.skuldGo_, true)
		SetActive(self.brokenBgGo_, false)

		function self.aniCallback_()
			self.animator_:Play("normal", -1, 0)
		end

		self.timer_:Start()
	end
end

function SkuldSystemStageView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionView() then
			self:TryToCloseSectionView()
		else
			JumpTools.Back()
		end
	end)
end

function SkuldSystemStageView:OnTop()
	self:UpdateBar()

	if self:IsOpenSectionView() then
		-- block empty
	else
		self.curLevelID_ = 0
	end

	for iter_30_0 = 1, 36 do
		self["levelItem" .. iter_30_0 .. "_"]:RefreshSelect(self.curLevelID_)
	end
end

function SkuldSystemStageView:RefreshUI()
	for iter_31_0 = 1, 3 do
		if iter_31_0 == self.curSectionIndex_ then
			self["btnController" .. iter_31_0 .. "_"]:SetSelectedState("true")
		else
			self["btnController" .. iter_31_0 .. "_"]:SetSelectedState("false")
		end

		local var_31_0 = false

		for iter_31_1, iter_31_2 in pairs(SkuldStageCfg.get_id_list_by_section[iter_31_0]) do
			if SkuldSystemData:GetLevelIDIsOpen(iter_31_2) then
				var_31_0 = true

				break
			end
		end

		if var_31_0 then
			self["btnLockController" .. iter_31_0 .. "_"]:SetSelectedState("false")

			if SkuldSystemData:GetClientKey("IsPlaySectionUnlock" .. iter_31_0) then
				SetActive(self["sectionAniGo" .. iter_31_0 .. "_"], false)
			else
				SetActive(self["sectionAniGo" .. iter_31_0 .. "_"], true)
				self["sectionAni" .. iter_31_0 .. "_"]:Play("stage_unlock")
				SkuldSystemAction.SendMark("IsPlaySectionUnlock" .. iter_31_0)
			end
		else
			SetActive(self["sectionAniGo" .. iter_31_0 .. "_"], false)
			self["btnLockController" .. iter_31_0 .. "_"]:SetSelectedState("true")
		end
	end

	self.stageController_:SetSelectedState("stage0" .. self.curSectionIndex_)

	for iter_31_3 = 1, 30 do
		self["levelItem" .. iter_31_3 .. "_"]:RefreshUI()
	end
end

function SkuldSystemStageView:OnExit()
	self:UnBindRedPoint()
	manager.windowBar:HideBar()
	self.trustItem_:OnExit()
	self:RemoveTween()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	SkuldSystemData:CacheStageViewInfo({
		index = self.curSectionIndex_,
		positionx = self.curScrollContent_.transform.localPosition.x,
		positiony = self.curScrollContent_.transform.localPosition.y,
		positionz = self.curScrollContent_.transform.localPosition.z
	}, self.params_.isFinal)
end

function SkuldSystemStageView:OnSelectLevelItem(arg_33_1, arg_33_2)
	if self.curLevelID_ == arg_33_2 then
		return
	end

	self.curLevelID_ = arg_33_2

	for iter_33_0 = 1, 36 do
		self["levelItem" .. iter_33_0 .. "_"]:RefreshSelect(self.curLevelID_)
	end

	if self["levelItem" .. arg_33_1 .. "_"] then
		local var_33_0 = -self["levelItem" .. arg_33_1 .. "_"].transform_.localPosition.x + self.scrollViewTrans_.rect.width / 2 - self["levelItem" .. arg_33_1 .. "_"].transform_.rect.width / 2

		self:RemoveTween()

		if self.params_.isFinal then
			self.scrollView4_.horizontal = false
			self.curScrollContent_ = self.scrollContent4_
		else
			self["scrollView" .. self.curSectionIndex_ .. "_"].horizontal = false
			self.curScrollContent_ = self["scrollContent" .. self.curSectionIndex_ .. "_"]
		end

		self.tween_ = LeanTween.value(self.curScrollContent_, self.curScrollContent_.transform.localPosition.x, var_33_0, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
			self.curScrollContent_.transform.localPosition = Vector3(arg_34_0, 0, 0)
		end))
	elseif self.params_.isFinal then
		self.scrollView4_.horizontal = true
	else
		self["scrollView" .. self.curSectionIndex_ .. "_"].horizontal = true
	end
end

function SkuldSystemStageView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.curScrollContent_)

		self.tween_ = nil
	end
end

function SkuldSystemStageView:IsOpenSectionView()
	return self:IsOpenRoute("skuldSystemStageSectionView")
end

function SkuldSystemStageView:TryToCloseSectionView()
	if self:IsOpenSectionView() then
		self.curLevelID_ = 0

		for iter_37_0 = 1, 36 do
			self["levelItem" .. iter_37_0 .. "_"]:RefreshSelect(self.curLevelID_)
		end

		if self.params_.isFinal then
			self.scrollView4_.horizontal = true
		else
			self["scrollView" .. self.curSectionIndex_ .. "_"].horizontal = true
		end

		JumpTools.Back()
	end
end

function SkuldSystemStageView:RefreshAudio()
	local var_38_0 = ChapterTools.GetSkuildAudio()

	if self.lastAudioID_ == var_38_0 then
		return
	end

	local var_38_1 = ChapterAudioCfg[var_38_0]

	manager.audio:PlayUIAudio(ChapterAudioCfg[var_38_0].bgm_id)

	self.bgmNameText_.text = var_38_1.name
	self.lastAudioID_ = var_38_0
end

function SkuldSystemStageView:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	for iter_39_0 = 1, 36 do
		self["levelItem" .. iter_39_0 .. "_"]:Dispose()
	end

	self.trustItem_:Dispose()
	self.super.Dispose(self)
end

return SkuldSystemStageView
