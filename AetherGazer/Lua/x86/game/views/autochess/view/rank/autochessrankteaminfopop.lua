local var_0_0 = class("AutoChessRankTeamInfoPop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_RankPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

local function var_0_1(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		var_3_0[iter_3_1.key] = iter_3_1.value
	end

	return var_3_0
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.chessItemList = {}
	arg_4_0.formationView = AutoChessFormationItemView.New(arg_4_0.formationGo_)
	arg_4_0.scoreDetailList = LuaList.New(function(...)
		arg_4_0:RenderScoreDetailItem(...)
	end, arg_4_0.scoreDetailList_, AutoChessScoreDetailItemView)
	arg_4_0.tipsPanelView_ = AutoChessTipsPanelView.New(arg_4_0.tipsPanelGo_)

	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, JumpTools.Back)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, handler(arg_4_0, arg_4_0.OnClickCloseTips))

	arg_4_0.clickChessHandler_ = handler(arg_4_0, arg_4_0.OnPointerClick)
end

function var_0_0.OnClickCloseTips(arg_6_0)
	SetActive(arg_6_0.maskBtn_.gameObject, false)
	arg_6_0.tipsPanelView_:SetActive(false)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.scoreDetailList:Dispose()
	arg_7_0.formationView:Dispose()
	arg_7_0.tipsPanelView_:Dispose()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.chessItemList) do
		iter_7_1:Dispose()
	end

	arg_7_0.chessItemList = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = arg_8_0.params_.rankData
	local var_8_1 = arg_8_0.params_.teamData

	arg_8_0:UpdatePlayerInfo(var_8_0)
	arg_8_0:UpdateAutoChessData(var_8_1)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:OnClickCloseTips()
end

function var_0_0.UpdatePlayerInfo(arg_12_0, arg_12_1)
	arg_12_0:UpdatePlayerName(arg_12_1.nick)
	arg_12_0:UpdateScore(arg_12_1.score)
	arg_12_0:UpdateIcon(arg_12_1)
end

function var_0_0.UpdateIcon(arg_13_0, arg_13_1)
	arg_13_0.headIcon_.sprite = AutoChessTools.GetPlayerIcon(arg_13_1.portrait)
end

function var_0_0.UpdateAutoChessData(arg_14_0, arg_14_1)
	local var_14_0 = var_0_1(arg_14_1.auto_chessboard_info.base_info_list)
	local var_14_1 = var_14_0[1]
	local var_14_2 = var_14_0[2]
	local var_14_3 = var_14_0[4]

	arg_14_0:UpdateHP(var_14_1)
	arg_14_0:UpdateRound(var_14_3)
	arg_14_0:UpdateWin(var_14_2)
	arg_14_0:UpdateChessItemList(arg_14_1.auto_chessboard_info.chess_list)
	arg_14_0:UpdateScoreDetailList(arg_14_1.point_detail)
end

function var_0_0.UpdatePlayerName(arg_15_0, arg_15_1)
	arg_15_0.name_.text = arg_15_1
end

function var_0_0.UpdateScore(arg_16_0, arg_16_1)
	arg_16_0.scoreText_.text = arg_16_1
end

function var_0_0.UpdateRound(arg_17_0, arg_17_1)
	arg_17_0.roundText_.text = arg_17_1
end

function var_0_0.UpdateWin(arg_18_0, arg_18_1)
	arg_18_0.scoreDetailCntText_.text = string.format("%s/%s", arg_18_1, GameSetting.auto_chess_win_limit.value[1])
end

function var_0_0.UpdateHP(arg_19_0, arg_19_1)
	arg_19_0.hpText_.text = arg_19_1
end

function var_0_0.OnPointerClick(arg_20_0, arg_20_1, arg_20_2)
	SetActive(arg_20_0.maskBtn_.gameObject, true)
	arg_20_0.tipsPanelView_:SetData(arg_20_1)
	arg_20_0.tipsPanelView_:SetGoldState(false)

	local var_20_0 = arg_20_2:GetPos()

	arg_20_0.tipsPanelView_:SetPos(var_20_0)
	AutoChessTools.ScreenAdapter(arg_20_2, arg_20_0.tipsPanelView_)
end

function var_0_0.UpdateChessItemList(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.chessItemList) do
		iter_21_1:SetActive(false)
	end

	local var_21_0 = arg_21_1

	for iter_21_2, iter_21_3 in ipairs(var_21_0) do
		local var_21_1 = AutoChessItemDataTemplate.New()

		var_21_1:Init(iter_21_3)

		local var_21_2 = var_21_1.index
		local var_21_3 = arg_21_0.chessItemList[var_21_2]

		if var_21_3 == nil then
			local var_21_4 = Object.Instantiate(arg_21_0.chessItemGo_, arg_21_0.formationRoot_)

			var_21_3 = AutoChessTeamItem.New(var_21_4)
			arg_21_0.chessItemList[var_21_2] = var_21_3
		end

		var_21_3:SetActive(true)
		var_21_3:SetParent(arg_21_0.formationView:GetChessPanelTrans())
		var_21_3:SetLocalScale(Vector3.one)
		var_21_3:SetLocalPos(arg_21_0.formationView:GetChessPos(var_21_1.index))
		var_21_3:SetData(var_21_1)
		var_21_3:RegisterEvent("PointerClick", arg_21_0.clickChessHandler_)
	end
end

function var_0_0.UpdateScoreDetailList(arg_22_0, arg_22_1)
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

	arg_22_0.scoreDetailDatas = var_22_0

	local var_22_1 = #var_22_0

	arg_22_0.scoreDetailList:StartScroll(var_22_1)
end

function var_0_0.RenderScoreDetailItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.scoreDetailDatas[arg_24_1]

	arg_24_2:SetData(var_24_0)
end

return var_0_0
