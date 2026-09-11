local AutoChessBattleView = class("AutoChessBattleView", ReduxView)

function AutoChessBattleView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AutoChessBattleView:Init()
	self:InitUI()
end

function AutoChessBattleView:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:AddUIListener()

	self.formationView_ = AutoChessFormationItemView.New(self.foremationGo_)
	self.chessItemList_ = {}
	self.clickChessHandler_ = handler(self, self.OnClickChess)
end

function AutoChessBattleView:InitController()
	self.typeController_ = self.controllerEx_:GetController("type")
	self.statusController_ = self.controllerEx_:GetController("status")
	self.iconController1001_ = self.controller1001_:GetController("state")
	self.iconController1002_ = self.controller1002_:GetController("state")
	self.iconController1003_ = self.controller1003_:GetController("state")
	self.iconController1004_ = self.controller1004_:GetController("state")
end

function AutoChessBattleView:AddUIListener()
	self:AddBtnListener(self.scoreDetailBtn_, nil, handler(self, self.OnClickSocreDetail))
	self:AddBtnListener(self.badgeBtn_, nil, function()
		if self.medalClickHandler then
			self.medalClickHandler()
		end

		JumpTools.OpenPageByJump("autoChessMedalInfoView", {
			id = self.recordItemData_.medalId,
			medalLevel = AutoChessData.MedalCategory.Advanced
		})
		OperationRecorder.RecordButtonTouch({
			source = 2,
			button_name = "activity_autochess_achie_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function AutoChessBattleView:SetData(arg_7_1, arg_7_2)
	self.scrollView_ = arg_7_2
	self.recordItemData_ = arg_7_1
	self.playerData_ = self.recordItemData_.playerData

	self:UpdateUI()
end

function AutoChessBattleView:UpdateUI()
	self:UpdateType()
	self:UpdateStatus()
	self:UpdateChessList()
	self:UpdateScore()
	self:UpdatePlayerInfo()
	self:UpdateMedal()
	self:UpdateTimestamp()
	self:UpdateRank()
end

function AutoChessBattleView:UpdateType()
	if self.recordItemData_.type == AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE then
		self.typeController_:SetSelectedIndex(2)
	elseif self.recordItemData_.type == AutoChessConst.RECORD_TYPE.PVP_4_8 then
		self.typeController_:SetSelectedIndex(0)
	else
		self.typeController_:SetSelectedIndex(self.recordItemData_.type)
	end
end

function AutoChessBattleView:UpdateRank()
	self.txtRank_.text = "NO." .. self.recordItemData_.rank

	local var_10_0, var_10_1 = AutoChessTools.GetRankLevelCfg(self.recordItemData_.newRankScore)

	self.txtRankName_.text = var_10_0.name
	self.txtAddScore_.text = self.recordItemData_.newRankScore - self.recordItemData_.oldRankScore >= 0 and "+" .. tostring(self.recordItemData_.newRankScore - self.recordItemData_.oldRankScore) or tostring(self.recordItemData_.newRankScore - self.recordItemData_.oldRankScore)

	if var_10_0.rank_level ~= 0 then
		SetActive(self.rankLevelGo_, true)

		self.txtRankLevel_.text = NumberTools.IntToRomam(var_10_0.rank_level)
	else
		SetActive(self.rankLevelGo_, false)
	end

	self.rankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_10_0.icon)
end

function AutoChessBattleView:UpdateStatus()
	if self.playerData_.curRoundCount == self.playerData_.victoryRoundCount and self.recordItemData_.isWin then
		self.statusController_:SetSelectedState("perfectWin")
	else
		self.statusController_:SetSelectedState("win")
	end
end

function AutoChessBattleView:UpdateChessList()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.playerData_.chessDataDicByUniqueId) do
		table.insert(var_12_0, iter_12_1)
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		return arg_13_0.index < arg_13_1.index
	end)

	for iter_12_2 = 1, GameSetting.auto_chess_prepare_grid_num.value[1] do
		local var_12_1 = self.chessItemList_[iter_12_2]

		if var_12_0[iter_12_2] then
			if var_12_1 == nil then
				var_12_1 = AutoChessTeamItem.New((Object.Instantiate(self.chessItemGo_, self.chessItemGo_.transform.parent)))
				self.chessItemList_[iter_12_2] = var_12_1
			end

			var_12_1:SetActive(true)
			var_12_1:SetParent(self.formationView_:GetChessPanelTrans())
			var_12_1:SetLocalScale(Vector3.one)
			var_12_1:SetLocalPos(self.formationView_:GetChessPos(var_12_0[iter_12_2].index))
			var_12_1:SetData(var_12_0[iter_12_2])
			var_12_1:RegisterEvent("PointerClick", self.clickChessHandler_)
			var_12_1:RegisterEvent("BeginDrag", handler(self, self.OnBeginDrag))
			var_12_1:RegisterEvent("EndDrag", handler(self, self.OnEndDrag))
			var_12_1:RegisterEvent("Drag", handler(self, self.OnDrag))
		elseif var_12_1 ~= nil then
			var_12_1:SetActive(false)
			var_12_1:SetData(nil)
		end
	end
end

function AutoChessBattleView:OnBeginDrag(arg_14_1, arg_14_2)
	self.scrollView_:OnBeginDrag(arg_14_2)
end

function AutoChessBattleView:OnEndDrag(arg_15_1)
	self.scrollView_:OnEndDrag(arg_15_1)
end

function AutoChessBattleView:OnDrag(arg_16_1)
	self.scrollView_:OnDrag(arg_16_1)
end

function AutoChessBattleView:UpdateScore()
	self.socreText_.text = self.recordItemData_.score
end

function AutoChessBattleView:UpdatePlayerInfo()
	self.hpText_.text = self.playerData_.hp
	self.roundText_.text = self.playerData_.curRoundCount
	self.trophyText_.text = self.playerData_.victoryRoundCount
end

function AutoChessBattleView:UpdateTimestamp()
	self.timeText_.text = manager.time:DescCTime(self.recordItemData_.timestamp, "%Y-%m-%d %H:%M")
end

function AutoChessBattleView:UpdateMedal()
	for iter_20_0, iter_20_1 in ipairs(AutoChessMedalCfg.all) do
		if iter_20_1 == self.recordItemData_.medalId then
			SetActive(self["controller" .. iter_20_1 .. "_"].gameObject, true)
		else
			SetActive(self["controller" .. iter_20_1 .. "_"].gameObject, false)
		end
	end

	if self.recordItemData_.type == AutoChessConst.RECORD_TYPE.GLORY then
		self["iconController" .. self.recordItemData_.medalId .. "_"]:SetSelectedState("03")
	end
end

function AutoChessBattleView:OnClickSocreDetail()
	manager.notify:Invoke(AUTO_CHESS_RECORD_SCORE_DETAIL_CLICK, self)
	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_record_score_touch",
		activity_id = AutoChessData:GetActivityID(),
		score = self.recordItemData_.score,
		type = self.recordItemData_.type == 1 and 1 or 2
	})
end

function AutoChessBattleView:OnClickChess(arg_22_1, arg_22_2)
	manager.notify:Invoke(AUTO_CHESS_RECORD_CHESS_CLICK, arg_22_1, arg_22_2)

	local var_22_0 = {
		button_name = "activity_autochess_record_chess_touch",
		activity_id = AutoChessData:GetActivityID(),
		other_data = AutoChessTools.GetChessTrackingPointStr(arg_22_1)
	}

	var_22_0.polyhedron_id_str = self.playerData_.battleUID or AutoChessData:GetPrepareData():GetUUID()

	OperationRecorder.RecordButtonTouch(var_22_0)
end

function AutoChessBattleView:SetMedalClickHandler(arg_23_1)
	self.medalClickHandler = arg_23_1
end

function AutoChessBattleView:Dispose()
	self.formationView_:Dispose()

	for iter_24_0, iter_24_1 in ipairs(self.chessItemList_) do
		iter_24_1:Dispose()
	end

	AutoChessBattleView.super.Dispose(self)
end

return AutoChessBattleView
