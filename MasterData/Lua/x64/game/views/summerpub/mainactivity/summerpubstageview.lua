local SummerPubStageView = class("SummerPubStageView", ReduxView)
local var_0_1 = 3

function SummerPubStageView:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_StageUI"
end

function SummerPubStageView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerPubStageView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerPubStageView:InitUI()
	self:BindCfgUI()

	self.scrollMoveView1_ = ScrollMoveView.New(self, self.stageContent1_)
	self.scrollMoveView2_ = ScrollMoveView.New(self, self.stageContent2_)
	self.scrollMoveView3_ = ScrollMoveView.New(self, self.stageContent3_)
	self.selectLevelItemHandler_ = handler(self, self.OnSelectLevelItem)
	self.stageItemList_ = {}
	self.curSelectStageIndex_ = 0

	local var_4_0 = self.stageLine_.transform.rect.width
	local var_4_1 = self.stageLine_.transform.rect.height

	for iter_4_0 = 1, var_0_1 do
		self.stageItemList_[iter_4_0] = {}

		for iter_4_1 = 1, #SummerPubLevelCfg.get_id_list_by_area[iter_4_0] do
			local var_4_2 = SummerPubLevelCfg[SummerPubLevelCfg.get_id_list_by_area[iter_4_0][iter_4_1]]

			if SummerPubLevelCfg[SummerPubLevelCfg.get_id_list_by_area[iter_4_0][iter_4_1]].prev_id == 0 or SummerPubData:GetClearNumByStageID(var_4_2.prev_id, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
				if iter_4_1 < #SummerPubLevelCfg.get_id_list_by_area[iter_4_0] and SummerPubData:GetClearNumByStageID(SummerPubLevelCfg.get_id_list_by_area[iter_4_0][iter_4_1], SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
					local var_4_3 = SummerPubLevelCfg[SummerPubLevelCfg.get_id_list_by_area[iter_4_0][iter_4_1 + 1]]
					local var_4_4 = Object.Instantiate(self.stageLine_, self["content" .. iter_4_0 .. "_"].transform)

					var_4_4.transform.anchoredPosition = Vector3.New((SummerPubLevelCfg[SummerPubLevelCfg.get_id_list_by_area[iter_4_0][iter_4_1 + 1]].position[1] + var_4_2.position[1]) / 2, (SummerPubLevelCfg[SummerPubLevelCfg.get_id_list_by_area[iter_4_0][iter_4_1 + 1]].position[2] + var_4_2.position[2]) / 2, 0)

					if iter_4_1 % 2 == 1 then
						var_4_4.transform.localEulerAngles = Vector3.New(180, 0, 0)
					end

					local var_4_5

					do
						var_4_4.transform.localEulerAngles = Vector3.New(180, 180, 0)
						var_4_5 = math.abs(var_4_3.position[2] - var_4_2.position[2]) / var_4_1
					end

					var_4_4.transform.localScale = Vector3.New(math.abs(var_4_3.position[1] - var_4_2.position[1]) / var_4_0, var_4_5, 1)

					SetActive(var_4_4, true)
				end

				local var_4_6 = var_4_2.type == SummerPubConst.STAGE_TYPE.BALL and Object.Instantiate(self.ballStageItem_, self["content" .. iter_4_0 .. "_"].transform) or Object.Instantiate(self.battleStageItem_, self["content" .. iter_4_0 .. "_"].transform)

				SetActive(var_4_6, true)

				var_4_6.transform.anchoredPosition = Vector3.New(var_4_2.position[1], var_4_2.position[2], 0)
				self.stageItemList_[iter_4_0][iter_4_1] = SummerPubStageItem.New(var_4_6, var_4_2.id, iter_4_1, self.selectLevelItemHandler_)
			end
		end
	end

	self.areaList_ = {}
	self.selectAreaHandler_ = handler(self, self.UpdateAreaView)

	for iter_4_2 = 1, var_0_1 do
		self.areaList_[iter_4_2] = SummerPubAreaItem.New(self["areaBtn" .. iter_4_2 .. "_"], iter_4_2, self.selectAreaHandler_)
	end

	self.unlockStageController_ = self.mainControllerEx_:GetController("UnlockStage")
	self.selectStageController_ = self.mainControllerEx_:GetController("SelectStage")
	self.taskLevelObj_ = ActivityTaskLevelCommonItem.New(self.taskLevelGo_, ActivityConst.ACTIVITY_NYA_SUMMER_PUB)
	self.illuController_ = self.mainControllerEx_:GetController("IlluCodex")
	self.guoChangController_ = self.mainControllerEx_:GetController("CutScenes")
end

function SummerPubStageView:AddUIListeners()
	self:AddBtnListener(self.collectBtn_, nil, function()
		JumpTools.OpenPopUp("billiardGameIlluView")
	end)
end

function SummerPubStageView:IsOpenSectionInfo()
	return self:IsOpenRoute("summerPubStageSectionView")
end

function SummerPubStageView:TryToCloseSectionView()
	if self.curSelectStageIndex_ ~= 0 then
		self.stageItemList_[self.curAreaIndex_][self.curSelectStageIndex_]:SetSelect(false)
	end

	self.curSelectStageIndex_ = 0

	if self:IsOpenSectionInfo() then
		JumpTools.Back()
	end
end

function SummerPubStageView:OnTop()
	self:ScrollList(self.curSelectStageIndex_ ~= 0 and SummerPubLevelCfg.get_id_list_by_area[self.curAreaIndex_][self.curSelectStageIndex_] or SummerPubData:GetStageAreaIndex())
	self:TryToCloseSectionView()

	if SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			JumpTools.OpenPageByJump("/summerPubEnterView")
		end)
	end
end

function SummerPubStageView:OnEnter()
	local var_11_0 = SummerPubData:GetStageAreaIndex()

	self:UpdateAreaView(self.params_.index or SummerPubLevelCfg[var_11_0].area)
	self.taskLevelObj_:Refresh({
		type = 2
	})
	self:UpdateIlluBtn()
	self:RefreshRedPoint()
	self:ScrollList(var_11_0)
end

function SummerPubStageView:RefreshRedPoint()
	for iter_12_0 = 1, var_0_1 do
		manager.redPoint:bindUIandKey(self.areaList_[iter_12_0].transform_, RedPointConst.SUMMER_PUB_STAGE_AREA .. iter_12_0)

		for iter_12_1, iter_12_2 in ipairs(self.stageItemList_[iter_12_0]) do
			manager.redPoint:bindUIandKey(iter_12_2.transform_, RedPointConst.SUMMER_PUB_STAGE_ITEM .. iter_12_2.levelID_)
		end
	end

	manager.redPoint:bindUIandKey(self.taskLevelObj_.transform_, RedPointConst.SUMMER_PUB_RESIDENT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB)
	manager.redPoint:bindUIandKey(self.collectBtn_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION)
end

function SummerPubStageView:UpdateAreaView(arg_13_1, arg_13_2)
	self:TryToCloseSectionView()
	self.guoChangController_:SetSelectedState("false")

	if arg_13_2 and self.curAreaIndex_ ~= arg_13_1 then
		self.guoChangController_:SetSelectedState("true")
	end

	self.curAreaIndex_ = arg_13_1

	for iter_13_0, iter_13_1 in ipairs(self.stageItemList_[self.curAreaIndex_]) do
		iter_13_1:RefreshUI()
	end

	if arg_13_2 then
		self.Timer_ = Timer.New(function()
			self:StopTimer()
			self:OnEnterOver()
		end, 0.5, 1)

		self.Timer_:Start()
		self:ScrollList(SummerPubLevelCfg.get_id_list_by_area[arg_13_1][1])
	end
end

function SummerPubStageView:OnEnterOver()
	for iter_15_0 = 1, var_0_1 do
		if iter_15_0 == self.curAreaIndex_ then
			SetActive(self["stageContent" .. iter_15_0 .. "_"], true)
			self.areaList_[iter_15_0]:SetSelect(true)
			self.selectStageController_:SetSelectedState("state" .. iter_15_0)
		else
			SetActive(self["stageContent" .. iter_15_0 .. "_"], false)
			self.areaList_[iter_15_0]:SetSelect(false)
		end
	end
end

function SummerPubStageView:UpdateIlluBtn()
	local var_16_0 = "off"

	for iter_16_0, iter_16_1 in pairs(SummerPubData:GetIlluInfo()) do
		var_16_0 = "on"

		break
	end

	self.illuController_:SetSelectedState(var_16_0)
end

function SummerPubStageView:SelectStageItem(arg_17_1)
	if self.curSelectStageIndex_ ~= 0 then
		self.stageItemList_[self.curAreaIndex_][self.curSelectStageIndex_]:SetSelect(false)
	end

	self.stageItemList_[self.curAreaIndex_][arg_17_1]:SetSelect(true)

	self.curSelectStageIndex_ = arg_17_1
end

function SummerPubStageView:OnSelectLevelItem(arg_18_1, arg_18_2)
	if arg_18_1 ~= self.curSelectStageIndex_ then
		self:SelectStageItem(arg_18_1)
		self:ScrollList(arg_18_2)
	end
end

function SummerPubStageView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SummerPubStageView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
	self.scrollMoveView1_:OnExit()
	self.scrollMoveView2_:OnExit()
	self.scrollMoveView3_:OnExit()

	for iter_20_0, iter_20_1 in ipairs(self.areaList_) do
		manager.redPoint:unbindUIandKey(iter_20_1.transform_, RedPointConst.SUMMER_PUB_STAGE_AREA .. iter_20_0)

		for iter_20_2, iter_20_3 in ipairs(self.stageItemList_[iter_20_0]) do
			manager.redPoint:unbindUIandKey(iter_20_3.transform_, RedPointConst.SUMMER_PUB_STAGE_ITEM .. iter_20_3.levelID_)
		end
	end

	manager.redPoint:unbindUIandKey(self.taskLevelObj_.transform_, RedPointConst.SUMMER_PUB_RESIDENT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB)
	manager.redPoint:unbindUIandKey(self.collectBtn_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION)
end

function SummerPubStageView:ScrollList(arg_21_1)
	self["scrollMoveView" .. self.curAreaIndex_ .. "_"]:RefreshUI(self:GetScrollPos(arg_21_1), (self:GetScrollWidth()))
end

function SummerPubStageView:GetScrollPos(arg_22_1)
	return SummerPubLevelCfg[arg_22_1].position[1]
end

function SummerPubStageView:GetScrollWidth()
	return self.stageItemList_[self.curAreaIndex_][#self.stageItemList_[self.curAreaIndex_]].cfg_.position[1] - self.stageItemList_[self.curAreaIndex_][1].cfg_.position[1]
end

function SummerPubStageView:Dispose()
	for iter_24_0, iter_24_1 in ipairs(self.stageItemList_) do
		for iter_24_2, iter_24_3 in ipairs(iter_24_1) do
			iter_24_3:Dispose()
		end
	end

	for iter_24_4, iter_24_5 in ipairs(self.areaList_) do
		manager.redPoint:unbindUIandKey(iter_24_5.transform_, RedPointConst.SUMMER_PUB_STAGE_AREA .. iter_24_4)
		iter_24_5:Dispose()
	end

	self.taskLevelObj_:Dispose()
	self.scrollMoveView1_:Dispose()

	self.scrollMoveView1_ = nil

	self.scrollMoveView2_:Dispose()

	self.scrollMoveView2_ = nil

	self.scrollMoveView3_:Dispose()

	self.scrollMoveView3_ = nil

	SummerPubStageView.super.Dispose(self)
end

return SummerPubStageView
