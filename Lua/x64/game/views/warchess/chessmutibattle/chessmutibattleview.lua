local var_0_0 = class("ChessMutiBattleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_system/WarChessTeamToPrepareUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.changehandler_ = handler(arg_4_0, arg_4_0.OnChangeBtnClick)
	arg_4_0.confirmhandler_ = handler(arg_4_0, arg_4_0.OnConfirmBtnClick)
	arg_4_0.changeindex_1 = 0
	arg_4_0.changeindex_2 = 0
	arg_4_0.heroList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexHeroList), arg_4_0.uilistGo_, ChessMutiBattleItemView)
end

function var_0_0.OnChangeBtnClick(arg_5_0, arg_5_1)
	if arg_5_0.changeindex_1 == 0 then
		arg_5_0.changeindex_1 = arg_5_1

		local var_5_0 = arg_5_0.heroList_:GetItemList()

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			iter_5_1:OnChangeRefreshStatus(arg_5_1)
		end

		SetActive(arg_5_0.btn_warbeganGo_, false)
	else
		arg_5_0:ResetStatus()
	end
end

function var_0_0.OnConfirmBtnClick(arg_6_0, arg_6_1)
	arg_6_0.changeindex_2 = arg_6_1

	if arg_6_0.changeindex_1 ~= 0 and arg_6_0.changeindex_2 ~= 0 then
		ReserveTools.SwapTeam(ReserveConst.RESERVE_TYPE.MULTI_CHESS, arg_6_0.activityID_, arg_6_0.changeindex_1, arg_6_0.changeindex_2)
		arg_6_0.heroList_:StartScroll(arg_6_0.times_)
	end

	arg_6_0:ResetStatus()
end

function var_0_0.ResetStatus(arg_7_0)
	arg_7_0.changeindex_1 = 0
	arg_7_0.changeindex_2 = 0

	local var_7_0 = arg_7_0.heroList_:GetItemList()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		iter_7_1:ResetState()
	end

	SetActive(arg_7_0.btn_warbeganGo_, true)
end

function var_0_0.indexHeroList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_1, arg_8_0.battleList_[arg_8_1], arg_8_0.typeList_[arg_8_1], arg_8_0.activityID_, #arg_8_0.battleList_)
	arg_8_2:RegionHandler(arg_8_0.changehandler_, arg_8_0.confirmhandler_)
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btn_warbeganBtn_, nil, function()
		if not ChessTools.CheckCanEnterMutiBattle(arg_9_0.times_, arg_9_0.activityID_) then
			ShowTips("ERROR_MULTIPLE_BATTLES_REQUIREMENT")

			return
		end

		ReserveAction.SaveMultiChessContData(arg_9_0.xz_.x, arg_9_0.xz_.z, arg_9_0.times_, arg_9_0.activityID_, function()
			local var_11_0 = {}

			for iter_11_0 = 1, arg_9_0.times_ do
				local var_11_1 = ReserveParams.New(ReserveConst.RESERVE_TYPE.MULTI_CHESS, arg_9_0.activityID_, iter_11_0, {
					stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS,
					stageID = arg_9_0.battleList_[index]
				})

				var_11_0[iter_11_0] = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, arg_9_0.battleList_[iter_11_0], arg_9_0.activityID_, var_11_1)

				if iter_11_0 > 1 then
					var_11_0[iter_11_0 - 1]:SetNextStage(var_11_0[iter_11_0])
				end
			end

			BattleController.GetInstance():LaunchBattle(var_11_0[1])
		end)
	end)
end

function var_0_0.OnEnter(arg_12_0)
	manager.ui:SetMainCamera("battleHeroSelect")

	arg_12_0.times_ = arg_12_0.params_.times
	arg_12_0.battleList_ = arg_12_0.params_.battleList
	arg_12_0.activityID_ = arg_12_0.params_.activityID
	arg_12_0.xz_ = arg_12_0.params_.xz
	arg_12_0.typeList_ = arg_12_0.params_.typeList
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_13_0.changeindex_1 ~= 0 then
			arg_13_0:ResetStatus()
		else
			JumpTools.Back()
		end
	end)
	arg_13_0.heroList_:StartScroll(arg_13_0.times_)
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	arg_15_0:ResetStatus()
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.heroList_ then
		arg_16_0.heroList_:Dispose()

		arg_16_0.heroList_ = nil
	end

	arg_16_0.changehandler_ = nil
	arg_16_0.confirmhandler_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
