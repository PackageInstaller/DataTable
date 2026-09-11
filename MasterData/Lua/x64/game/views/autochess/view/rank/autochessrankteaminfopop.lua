local AutoChessRankTeamInfoPop = class("AutoChessRankTeamInfoPop", ReduxView)

function AutoChessRankTeamInfoPop:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_RankPopUI"
end

function AutoChessRankTeamInfoPop:UIParent()
	return manager.ui.uiPop.transform
end

local function var_0_1(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		var_3_0[iter_3_1.key] = iter_3_1.value
	end

	return var_3_0
end

function AutoChessRankTeamInfoPop:Init()
	self:BindCfgUI()

	self.chessItemList = {}
	self.formationView = AutoChessFormationItemView.New(self.formationGo_)
	self.scoreDetailList = LuaList.New(function(...)
		self:RenderScoreDetailItem(...)
	end, self.scoreDetailList_, AutoChessScoreDetailItemView)
	self.tipsPanelView_ = AutoChessTipsPanelView.New(self.tipsPanelGo_)

	self:AddBtnListener(self.closeBtn_, nil, JumpTools.Back)
	self:AddBtnListener(self.maskBtn_, nil, handler(self, self.OnClickCloseTips))

	self.clickChessHandler_ = handler(self, self.OnPointerClick)
end

function AutoChessRankTeamInfoPop:OnClickCloseTips()
	SetActive(self.maskBtn_.gameObject, false)
	self.tipsPanelView_:SetActive(false)
end

function AutoChessRankTeamInfoPop:Dispose()
	self.scoreDetailList:Dispose()
	self.formationView:Dispose()
	self.tipsPanelView_:Dispose()

	for iter_7_0, iter_7_1 in pairs(self.chessItemList) do
		iter_7_1:Dispose()
	end

	self.chessItemList = nil

	AutoChessRankTeamInfoPop.super.Dispose(self)
end

function AutoChessRankTeamInfoPop:OnEnter()
	self:UpdatePlayerInfo(self.params_.rankData)
	self:UpdateAutoChessData(self.params_.teamData)
end

function AutoChessRankTeamInfoPop:OnTop()
	manager.windowBar:HideBar()
end

function AutoChessRankTeamInfoPop:OnBehind()
	manager.windowBar:HideBar()
end

function AutoChessRankTeamInfoPop:OnExit()
	self:OnClickCloseTips()
end

function AutoChessRankTeamInfoPop:UpdatePlayerInfo(arg_12_1)
	self:UpdatePlayerName(arg_12_1.nick)
	self:UpdateScore(arg_12_1.score)
	self:UpdateIcon(arg_12_1)
end

function AutoChessRankTeamInfoPop:UpdateIcon(arg_13_1)
	self.headIcon_.sprite = AutoChessTools.GetPlayerIcon(arg_13_1.portrait)
end

function AutoChessRankTeamInfoPop:UpdateAutoChessData(arg_14_1)
	local var_14_0 = var_0_1(arg_14_1.auto_chessboard_info.base_info_list)

	self:UpdateHP(var_14_0[1])
	self:UpdateRound(var_14_0[4])
	self:UpdateWin(var_14_0[2])
	self:UpdateChessItemList(arg_14_1.auto_chessboard_info.chess_list)
	self:UpdateScoreDetailList(arg_14_1.point_detail)
end

function AutoChessRankTeamInfoPop:UpdatePlayerName(arg_15_1)
	self.name_.text = arg_15_1
end

function AutoChessRankTeamInfoPop:UpdateScore(arg_16_1)
	self.scoreText_.text = arg_16_1
end

function AutoChessRankTeamInfoPop:UpdateRound(arg_17_1)
	self.roundText_.text = arg_17_1
end

function AutoChessRankTeamInfoPop:UpdateWin(arg_18_1)
	self.scoreDetailCntText_.text = string.format("%s/%s", arg_18_1, GameSetting.auto_chess_win_limit.value[1])
end

function AutoChessRankTeamInfoPop:UpdateHP(arg_19_1)
	self.hpText_.text = arg_19_1
end

function AutoChessRankTeamInfoPop:OnPointerClick(arg_20_1, arg_20_2)
	SetActive(self.maskBtn_.gameObject, true)
	self.tipsPanelView_:SetData(arg_20_1)
	self.tipsPanelView_:SetGoldState(false)
	self.tipsPanelView_:SetPos((arg_20_2:GetPos()))
	AutoChessTools.ScreenAdapter(arg_20_2, self.tipsPanelView_)
end

function AutoChessRankTeamInfoPop:UpdateChessItemList(arg_21_1)
	for iter_21_0, iter_21_1 in pairs(self.chessItemList) do
		iter_21_1:SetActive(false)
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_1) do
		local var_21_0 = AutoChessItemDataTemplate.New()

		var_21_0:Init(iter_21_3)

		local var_21_1 = self.chessItemList[var_21_0.index]

		if self.chessItemList[var_21_0.index] == nil then
			var_21_1 = AutoChessTeamItem.New((Object.Instantiate(self.chessItemGo_, self.formationRoot_)))
			self.chessItemList[var_21_0.index] = var_21_1
		end

		var_21_1:SetActive(true)
		var_21_1:SetParent(self.formationView:GetChessPanelTrans())
		var_21_1:SetLocalScale(Vector3.one)
		var_21_1:SetLocalPos(self.formationView:GetChessPos(var_21_0.index))
		var_21_1:SetData(var_21_0)
		var_21_1:RegisterEvent("PointerClick", self.clickChessHandler_)
	end
end

function AutoChessRankTeamInfoPop:UpdateScoreDetailList(arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		if iter_22_1.value > 0 then
			table.insert(var_22_0, {
				id = iter_22_1.key,
				score = iter_22_1.value
			})
		end
	end

	table.sort(var_22_0, function(arg_23_0, arg_23_1)
		return arg_23_0.score > arg_23_1.score
	end)

	self.scoreDetailDatas = var_22_0

	self.scoreDetailList:StartScroll(#var_22_0)
end

function AutoChessRankTeamInfoPop:RenderScoreDetailItem(arg_24_1, arg_24_2)
	arg_24_2:SetData(self.scoreDetailDatas[arg_24_1])
end

return AutoChessRankTeamInfoPop
