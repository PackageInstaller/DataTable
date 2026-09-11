local IdolCompetitionResultView = class("IdolCompetitionResultView", ReduxView)

function IdolCompetitionResultView:UIName()
	return "Widget/BackHouseUI/Competition/IdolCompetitionMatchResultPopUI"
end

function IdolCompetitionResultView:UIParent()
	return manager.ui.uiPop.transform
end

function IdolCompetitionResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolCompetitionResultView:InitUI()
	self:BindCfgUI()

	self.stageItemList_ = {}

	for iter_4_0 = 1, 3 do
		if self["stage" .. iter_4_0 .. "Go_"] then
			self.stageItemList_[iter_4_0] = IdolCompetitionResultItem.New(self["stage" .. iter_4_0 .. "Go_"])
		end
	end

	self.scoreList_ = {}

	for iter_4_1 = 1, 4 do
		self.scoreList_[iter_4_1] = BackHomeCricketBattleResuleItem.New(self["score" .. iter_4_1 .. "Go_"])
	end

	self.leftPortrait_ = CommonHeadPortrait.New(self.p1headGo_)
	self.rightPortrait_ = CommonHeadPortrait.New(self.p2headGo_)
	self.winnerController_ = self.mainControllerEx_:GetController("winner")
	self.meTagController_ = self.mainControllerEx_:GetController("meTag")
	self.detailsController_ = self.mainControllerEx_:GetController("details")
end

function IdolCompetitionResultView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)

	for iter_5_0 = 1, 3 do
		if self["info" .. iter_5_0 .. "Btn_"] then
			self:AddBtnListener(self["info" .. iter_5_0 .. "Btn_"], nil, function()
				self:ShowStageScoreDetail(iter_5_0)
			end)
		end
	end

	self:AddBtnListener(self.infoCloseBtn_, nil, function()
		self:ShowStageScoreDetail(0)
	end)
end

function IdolCompetitionResultView:OnEnter()
	manager.windowBar:SwitchBar({})

	self.raceActivityID_ = self.params_.activity
	self.racePhase_ = self.params_.phase
	self.raceIndex_ = self.params_.index
	self.battleRecordData_ = IdolCompetitionData:GetBattleDetailInfo(self.raceActivityID_, self.racePhase_, self.raceIndex_)

	self:UpdateView()
end

function IdolCompetitionResultView:OnExit()
	manager.windowBar:HideBar()
end

function IdolCompetitionResultView:UpdateView()
	self:ShowStageScoreDetail(0)
	self.winnerController_:SetSelectedState(self.battleRecordData_.result == 1 and "left" or "right")

	local var_11_0 = IdolCompetitionData:GetRacePlayerInfo(self.raceActivityID_, self.battleRecordData_.player1ID)
	local var_11_1 = IdolCompetitionData:GetRacePlayerInfo(self.raceActivityID_, self.battleRecordData_.player2ID)

	if var_11_0.npc == 0 then
		self.leftPortrait_:RenderHead(var_11_0.head)
		self.leftPortrait_:RenderFrame(var_11_0.frame)
	else
		self.leftPortrait_:RenderCustomSpriteHead("TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_11_0.head)
		self.leftPortrait_:RenderFrame(2001)
	end

	if var_11_0.npc == 0 and self.battleRecordData_.player1ID ~= USER_ID then
		self.leftPortrait_:RegisteClickCallback(function()
			ForeignInfoAction:TryToCheckForeignDetailInfo(self.battleRecordData_.player1ID, true)
		end)
	else
		self.leftPortrait_:RegisteClickCallback(nil)
	end

	if var_11_1.npc == 0 then
		self.rightPortrait_:RenderHead(var_11_1.head)
		self.rightPortrait_:RenderFrame(var_11_1.frame)
	else
		self.rightPortrait_:RenderCustomSpriteHead("TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_11_1.head)
		self.rightPortrait_:RenderFrame(2001)
	end

	if var_11_1.npc == 0 and self.battleRecordData_.player2ID ~= USER_ID then
		self.rightPortrait_:RegisteClickCallback(function()
			ForeignInfoAction:TryToCheckForeignDetailInfo(self.battleRecordData_.player2ID, true)
		end)
	else
		self.rightPortrait_:RegisteClickCallback(nil)
	end

	self.p1nameText_.text = var_11_0.name
	self.p2nameText_.text = var_11_1.name
	self.p1scoreText_.text = self.battleRecordData_.player1Score
	self.p2scoreText_.text = self.battleRecordData_.player2Score

	if self.battleRecordData_.player1ID == USER_ID then
		self.meTagController_:SetSelectedState("left")
	elseif self.battleRecordData_.player2ID == USER_ID then
		self.meTagController_:SetSelectedState("right")
	else
		self.meTagController_:SetSelectedState("none")
	end

	for iter_11_0 = 1, #self.stageItemList_ do
		self.stageItemList_[iter_11_0]:SetData(self.battleRecordData_.battleData[iter_11_0])
	end
end

function IdolCompetitionResultView:ShowStageScoreDetail(arg_14_1)
	if arg_14_1 == 0 then
		self.detailsController_:SetSelectedState("off")
	elseif arg_14_1 == 1 or arg_14_1 == 2 or arg_14_1 == 3 then
		self.detailsController_:SetSelectedState("on" .. arg_14_1)

		local var_14_0 = {
			totalNum = self.battleRecordData_.battleData[arg_14_1].player1Info.score,
			peculiar = self.battleRecordData_.battleData[arg_14_1].player1Info.advantage,
			skillAdd = self.battleRecordData_.battleData[arg_14_1].player1Info.skillAdd,
			skillDec = self.battleRecordData_.battleData[arg_14_1].player1Info.skillReduce
		}
		local var_14_1 = {
			totalNum = self.battleRecordData_.battleData[arg_14_1].player2Info.score,
			peculiar = self.battleRecordData_.battleData[arg_14_1].player2Info.advantage,
			skillAdd = self.battleRecordData_.battleData[arg_14_1].player2Info.skillAdd,
			skillDec = self.battleRecordData_.battleData[arg_14_1].player2Info.skillReduce
		}

		for iter_14_0 = 1, #self.scoreList_ do
			self.scoreList_[iter_14_0]:RefreshUI({
				type = BackHomeCricketConst.SCORE_LIST[iter_14_0],
				attackData = var_14_0,
				defendData = var_14_1
			}, true)
		end
	end
end

function IdolCompetitionResultView:Dispose()
	IdolCompetitionResultView.super.Dispose(self)

	if self.leftPortrait_ then
		self.leftPortrait_:Dispose()

		self.leftPortrait_ = nil
	end

	if self.rightPortrait_ then
		self.rightPortrait_:Dispose()

		self.rightPortrait_ = nil
	end

	for iter_15_0 = 1, #self.stageItemList_ do
		if self.stageItemList_[iter_15_0] then
			self.stageItemList_[iter_15_0]:Dispose()

			self.stageItemList_[iter_15_0] = nil
		end
	end

	for iter_15_1 = 1, #self.scoreList_ do
		if self.scoreList_[iter_15_1] then
			self.scoreList_[iter_15_1]:Dispose()

			self.scoreList_[iter_15_1] = nil
		end
	end
end

return IdolCompetitionResultView
