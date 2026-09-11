local TangramGameMainView = class("TangramGameMainView", ReduxView)

function TangramGameMainView:UIName()
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramStageSelectUI"
end

function TangramGameMainView:UIParent()
	return manager.ui.uiMain.transform
end

function TangramGameMainView:Init()
	self:InitUI()

	self.chapterController = self.chapterCom:GetController("mapbg")
	self.chapterBtnController = self.chapterBtnCom:GetController("btnnum")
	self.chapterBtnStateController = self.chapterBtnCom:GetController("Status")
	self.decodeFinController = self.decodeCom:GetController("clear")
	self.decodemapController = self.decodeCom:GetController("map")
end

function TangramGameMainView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.stageItemList = {
		TangramGameChapterStageView.New(self.tangrammap1Go_, ActivityTangramGameChapterCfg.all[1]),
		(TangramGameChapterStageView.New(self.tangrammap2Go_, ActivityTangramGameChapterCfg.all[2]))
	}
	self.chapterName1.text = ActivityTangramGameChapterCfg[ActivityTangramGameChapterCfg.all[1]].name
	self.chapterName2.text = ActivityTangramGameChapterCfg[ActivityTangramGameChapterCfg.all[2]].name
end

function TangramGameMainView:AddUIListener()
	self:AddBtnListener(self.taskBtn, nil, function()
		JumpTools.OpenPageByJump("/summerChessBoardTask", {
			taskActivityID = ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_TASK
		})
	end)

	for iter_5_0 = 1, 2 do
		self:AddBtnListener(self["chapter" .. iter_5_0 .. "btn"], nil, function()
			if self.chapterIndex ~= iter_5_0 then
				self.chapterIndex = iter_5_0
				self.chapterID = ActivityTangramGameChapterCfg.all[self.chapterIndex]
				self.chapterCfg = ActivityTangramGameChapterCfg[self.chapterID]

				local var_7_0, var_7_1 = TangramGameTools:CheckChapterIsOpen(ActivityTangramGameChapterCfg.all[self.chapterIndex])

				if not var_7_0 then
					ShowTips(var_7_1)

					return
				end

				self:RefreshChapterView()
			end
		end)
	end

	self:AddBtnListener(self.decodeBtn, nil, function()
		if TangramGameData:CheckStageIsClear(self.chapterCfg.inference_stage_list[1]) then
			JumpTools.OpenPageByJump("/tangramGameShowView", {
				stageID = self.chapterCfg.inference_stage_list[1]
			})
		else
			JumpTools.OpenPageByJump("/tangramGameDecodeView", {
				chapterID = self.chapterID
			})

			if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_FULL_CLUE, self.chapterID)) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_FULL_CLUE, self.chapterID), 0)
			end
		end
	end)
end

function TangramGameMainView:OnEnter()
	self.activityID = TangramGameData:GetCurRunGameActivityID()

	if self.params_.isGoto then
		self.chapterID = self.params_.chapterID
		self.params_.isGoto = false
	else
		self.chapterID = self.chapterID or self.params_.chapterID or ActivityTangramGameChapterCfg.all[1]
	end

	self.chapterCfg = ActivityTangramGameChapterCfg[self.chapterID]

	for iter_9_0, iter_9_1 in ipairs(ActivityTangramGameChapterCfg.all) do
		if iter_9_1 == self.chapterID then
			self.chapterIndex = iter_9_0
		end
	end

	if self.activityID and self.chapterID then
		self:RefreshChapterBtnState()
	end

	self:RefreshRedPonit()
	self:RefreshChapterView()

	if self.params_.stageID and self.params_.playAni then
		self.stageItemList[self.chapterIndex]:PlayNewChipAni(self.params_.stageID)
	end

	self.params_ = nil
end

function TangramGameMainView:RefreshRedPonit()
	manager.redPoint:bindUIandKey(self.taskBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_TASK))

	for iter_10_0 = 1, 2 do
		manager.redPoint:bindUIandKey(self["chapter" .. iter_10_0 .. "btn"].transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_CHAPTER, ActivityTangramGameChapterCfg.all[iter_10_0]))
	end
end

function TangramGameMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_TASK))

	for iter_11_0 = 1, 2 do
		manager.redPoint:unbindUIandKey(self["chapter" .. iter_11_0 .. "btn"].transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_CHAPTER, ActivityTangramGameChapterCfg.all[iter_11_0]))
	end
end

function TangramGameMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_TANGRAM_GAME_DESCRIBE")
end

function TangramGameMainView:RefreshChapterBtnState()
	if TangramGameTools:CheckChapterIsOpen(ActivityTangramGameChapterCfg.all[2]) then
		self.chapterBtnController:SetSelectedState("02")

		if not getData(string.format("summer_tangram_%d", self.activityID), "hadEntered") then
			self.chapterIndex = 2

			saveData(string.format("summer_tangram_%d", self.activityID), "hadEntered", true)
		end
	else
		self.chapterBtnController:SetSelectedState("01")
	end
end

function TangramGameMainView:RefreshChapterView()
	if self.chapterIndex == 1 then
		self.chapterBtnStateController:SetSelectedState("left")
		self.decodemapController:SetSelectedState("map1")
		self.chapterController:SetSelectedState("map1")
	elseif self.chapterIndex == 2 then
		self.chapterBtnStateController:SetSelectedState("right")
		self.decodemapController:SetSelectedState("map2")
		self.chapterController:SetSelectedState("map2")
	end

	self.chapterID = ActivityTangramGameChapterCfg.all[self.chapterIndex]

	self:RefreshChapterBaseInfo()
	self:RefreshInferenceBtnState()
	self:RefreshChapterStageView()
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_STAGE, tostring(self.chapterID)), 0)

	self.textdescribeText_.text = ActivityTangramGameChapterCfg[self.chapterID].chapter_desc
end

function TangramGameMainView:RefreshChapterStageView()
	if self.oldIndex then
		self.stageItemList[self.oldIndex]:OnExit()
	end

	self.stageItemList[self.chapterIndex]:OnTop()

	self.oldIndex = self.chapterIndex
end

function TangramGameMainView:RefreshChapterBaseInfo()
	self.timeDesc.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(self.activityID).stopTime, true))
end

function TangramGameMainView:RefreshInferenceBtnState()
	local var_17_0, var_17_1, var_17_2 = TangramGameData:GetChapterFinProcess(self.chapterID)
	local var_17_3, var_17_4 = TangramGameData:GetChapterFinTotalProcess(self.chapterID)

	self.sliderImg_.fillAmount = var_17_1 / var_17_2

	if var_17_4 then
		self.decodeFinController:SetSelectedState("state1")
	elseif var_17_1 == var_17_2 then
		self.decodeFinController:SetSelectedState("state2")
	else
		self.decodeFinController:SetSelectedState("state0")
	end

	self:RefreshDecodeChapterIsFin()
end

function TangramGameMainView:RefreshDecodeChapterIsFin()
	if manager.redPoint:getTipBoolean((string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_FULL_CLUE, self.chapterID))) then
		manager.redPoint:SetRedPointIndependent(self.decodeBtn.transform, true)
	else
		manager.redPoint:SetRedPointIndependent(self.decodeBtn.transform, false)
	end
end

function TangramGameMainView:StartTimer()
	self:DisposeTimer()

	self.timer = Timer.New(function()
		self:RefreshChapterBaseInfo()
	end, 1, -1)

	self.timer:Start()
end

function TangramGameMainView:DisposeTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function TangramGameMainView:OnExit()
	manager.windowBar:HideBar()
	self:DisposeTimer()
	self:UnBindRedPoint()
	self:RemoveAllEventListener()
	AnimatorTools.Stop()

	self.params_ = nil
end

function TangramGameMainView:Dispose()
	if self.stageItemList then
		for iter_23_0, iter_23_1 in pairs(self.stageItemList) do
			iter_23_1:Dispose()
		end
	end

	self:DisposeTimer()
	TangramGameMainView.super.Dispose(self)
end

return TangramGameMainView
