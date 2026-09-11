local AutoChessScoreBoardPopItemView = class("AutoChessScoreBoardPopItemView", ReduxView)

function AutoChessScoreBoardPopItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.isShowChess_ = arg_1_2

	self:Init()
end

function AutoChessScoreBoardPopItemView:Init()
	self:InitUI()
end

function AutoChessScoreBoardPopItemView:InitUI()
	self:BindCfgUI()

	self.colorController_ = self.controllerEx_:GetController("color")
	self.tipsController_ = self.controllerEx_:GetController("tips")
	self.btnAddFriendController_ = self.controllerEx_:GetController("btnAddFriend")
	self.rankStatController_ = self.controllerEx_:GetController("rankStatus")
	self.formationView_ = AutoChessFormationItemView.New(self.formationGo_)
	self.chessItemList_ = {}
	self.clickChessHandler_ = handler(self, self.OnClickChess)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function AutoChessScoreBoardPopItemView:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.scoreBoardData_ = arg_4_1
	self.scrollView_ = arg_4_2
	self.isShowRankChange_ = arg_4_3
	self.playerData_ = self.scoreBoardData_.playerData

	self:UpdateUI()
end

function AutoChessScoreBoardPopItemView:UpdateUI()
	self:UpdateStatus()
	self:UpdateChessList()
	self:UpdatePlayerInfo()
end

function AutoChessScoreBoardPopItemView:UpdateStatus()
	if self.playerData_.hp > 0 then
		self.colorController_:SetSelectedState(self.scoreBoardData_.isSelf and "orange" or "blue")
	else
		self.colorController_:SetSelectedState("grey")
	end
end

function AutoChessScoreBoardPopItemView:UpdateChessList()
	local var_7_0

	if not self.playerData_.chessDataDicByUniqueId then
		do return end

		var_7_0 = {}
	end

	for iter_7_0, iter_7_1 in pairs(self.playerData_.chessDataDicByUniqueId) do
		table.insert(var_7_0, iter_7_1)
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0.index < arg_8_1.index
	end)

	for iter_7_2 = 1, GameSetting.auto_chess_prepare_grid_num.value[1] do
		local var_7_1 = var_7_0[iter_7_2]
		local var_7_2 = self.chessItemList_[iter_7_2]

		if var_7_0[iter_7_2] then
			if var_7_2 == nil then
				var_7_2 = AutoChessSimpleItem.New((Object.Instantiate(self.chessItemGo_, self.formationView_:GetChessPanelTrans())))
				self.chessItemList_[iter_7_2] = var_7_2
			end

			local var_7_3

			if self.scoreBoardData_.isSelf then
				var_7_3 = var_7_1.index or GameSetting.auto_chess_prepare_grid_num.value[1] - var_7_1.index + 1
			end

			var_7_2:SetActive(true)
			var_7_2:SetLocalScale(Vector3.one)
			var_7_2:SetLocalPos(self.formationView_:GetChessPos(var_7_3))
			var_7_2:SetPlayerType((self.scoreBoardData_.isSelf or nil) and (AutoChessConst.PLAYER_TYPE.SELF or AutoChessConst.PLAYER_TYPE.OPPONENT))
			var_7_2:SetAppearance(self.playerData_.sunglassFlag, self.playerData_.chessSkinList_[var_7_1.chessId])
			var_7_2:SetData(var_7_1)
			var_7_2:RegisterEvent("PointerClick", self.clickChessHandler_)
			var_7_2:RegisterEvent("BeginDrag", handler(self, self.OnBeginDrag))
			var_7_2:RegisterEvent("EndDrag", handler(self, self.OnEndDrag))
			var_7_2:RegisterEvent("Drag", handler(self, self.OnDrag))
		elseif var_7_2 ~= nil then
			var_7_2:SetActive(false)
			var_7_2:SetData(nil)
		end
	end
end

function AutoChessScoreBoardPopItemView:UpdateTipsState(arg_9_1)
	self.tipsController_:SetSelectedState(arg_9_1 and "on" or "off")
end

function AutoChessScoreBoardPopItemView:OnBeginDrag(arg_10_1, arg_10_2)
	self.scrollView_:OnBeginDrag(arg_10_2)
end

function AutoChessScoreBoardPopItemView:OnEndDrag(arg_11_1)
	self.scrollView_:OnEndDrag(arg_11_1)
end

function AutoChessScoreBoardPopItemView:OnDrag(arg_12_1)
	self.scrollView_:OnDrag(arg_12_1)
end

function AutoChessScoreBoardPopItemView:UpdatePlayerInfo()
	if self.scoreBoardData_.oldRankIndex and self.isShowRankChange_ then
		if self.scoreBoardData_.oldRankIndex - self.scoreBoardData_.rankIndex == 0 then
			self.rankStatController_:SetSelectedState("draw")

			self.rankChangeText_.text = "--"
		elseif self.scoreBoardData_.oldRankIndex - self.scoreBoardData_.rankIndex > 0 then
			self.rankStatController_:SetSelectedState("up")

			self.rankChangeText_.text = self.scoreBoardData_.oldRankIndex - self.scoreBoardData_.rankIndex
		else
			self.rankStatController_:SetSelectedState("down")

			self.rankChangeText_.text = math.abs(self.scoreBoardData_.oldRankIndex - self.scoreBoardData_.rankIndex)
		end
	else
		self.rankStatController_:SetSelectedState("hide")
	end

	self.indexText_.text = tostring(self.scoreBoardData_.rankIndex)
	self.playerNameText_.text = self.scoreBoardData_.name

	self.commonPortrait_:RenderHead(self.scoreBoardData_.icon)
	self.commonPortrait_:ChangeFrameActive(true)
	self.commonPortrait_:RenderFrame(self.scoreBoardData_.iconFrame)

	self.hpText_.text = self.playerData_.hp
	self.trophyText_.text = self.playerData_.victoryRoundCount
end

function AutoChessScoreBoardPopItemView:OnClickChess(arg_14_1, arg_14_2)
	manager.notify:Invoke("AUTO_CHESS_SCORE_BOARD_CHESS_CLICK", arg_14_1, arg_14_2)
end

function AutoChessScoreBoardPopItemView:Dispose()
	if self.formationView_ then
		self.formationView_:Dispose()
	end

	self.formationView_ = nil

	for iter_15_0, iter_15_1 in ipairs(self.chessItemList_) do
		iter_15_1:Dispose()
	end

	self.chessItemList_ = {}

	if self.commonPortrait_ then
		self.commonPortrait_:Dispose()

		self.commonPortrait_ = nil
	end

	AutoChessScoreBoardPopItemView.super.Dispose(self)
end

return AutoChessScoreBoardPopItemView
