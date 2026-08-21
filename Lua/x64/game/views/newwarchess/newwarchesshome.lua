local var_0_0 = class("NewWarChessHome", ReduxView)
local var_0_1 = {
	"Normal",
	"MoreThenCurMovePoint",
	"MoreThenMax"
}

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessMain"
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

	arg_4_0.taskList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.taskListGo_, NewWarChessHomeTaskItem)
	arg_4_0.statusController_ = ControllerUtil.GetController(arg_4_0.transform_, "status")
	arg_4_0.diceList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDiceItem), arg_4_0.diceListGo_, NewWarChessDiceItem)
	arg_4_0.isShowingBuff_ = false
	arg_4_0.curShowBuffIndex_ = 0
	arg_4_0.buffList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexBuffItem), arg_4_0.buffList_, NewWarChessBuffItem)
	arg_4_0.clickBuffHandler_ = handler(arg_4_0, arg_4_0.OnClickBuff)
	arg_4_0.moveController_ = ControllerUtil.GetController(arg_4_0.moveTrans_, "state")
	arg_4_0.moveState_ = var_0_1[1]
	arg_4_0.curCost_ = 0
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.taskIDList_[arg_5_1])
end

function var_0_0.IndexDiceItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.diceDataList_[arg_6_1])
	arg_6_2:SetClickCallBack(function(arg_7_0)
		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_NEW_WARCHESS_CHECK_DICE_TO_MOVEPOINT"), arg_6_2.dicePoint_, arg_6_2.dicePoint_),
			OkCallback = function()
				local var_8_0 = arg_6_2.dicePoint_

				NewWarChessAction.DiceToMovePoint(var_8_0, function()
					local var_9_0 = math.floor(var_8_0 * (NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_TO_MOVE_POINT_TIMES") / 1000))

					NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", var_9_0)

					local var_9_1 = string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_TO_MOVEPOINT"), var_8_0, var_9_0)
					local var_9_2 = {
						tipsType = NewChessConst.TIPS_TYPE.SWITCH,
						tipsText = var_9_1,
						tipsDiceNum = var_8_0
					}

					manager.NewChessManager:CreateTips(var_9_2)
					NewWarChessData:RemoveDice({
						arg_6_2.dicePoint_
					})
					arg_6_0:RefreshDiceList()
				end)
			end
		})
	end)
end

function var_0_0.IndexBuffItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, arg_10_0.curShowBuffIndex_, arg_10_0.buffEntityList_[arg_10_1])
	arg_10_2:SetClickCallBack(arg_10_0.clickBuffHandler_)
end

function var_0_0.OnClickBuff(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0.isShowingBuff_ then
		SetActive(arg_11_0.buffInfoGo_, false)

		arg_11_0.curShowBuffIndex_ = 0

		arg_11_0.buffList_:Refresh()

		arg_11_0.isShowingBuff_ = false
	else
		SetActive(arg_11_0.buffInfoGo_, true)

		arg_11_0.curShowBuffIndex_ = arg_11_1
		arg_11_0.buffInfoNameText_.text = arg_11_2
		arg_11_0.buffInfoDesText_.text = arg_11_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.infoContentTrans_)

		arg_11_0.isShowingBuff_ = true
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.curMovePointText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT"))

	local var_12_0 = NewWarChessData:GetCurrentWarChessMapID()
	local var_12_1 = NewWarChessData:GetExploreValue(var_12_0)

	arg_12_0.exploreValueText_.text = var_12_1 .. "%"
	arg_12_0.exploreValueImage_.fillAmount = var_12_1 / 100

	SetActive(arg_12_0.lookatBtn_.gameObject, false)
	SetActive(arg_12_0.buffInfoGo_, false)

	arg_12_0.curShowBuffIndex_ = 0
	arg_12_0.isShowingBuff_ = false

	arg_12_0:RefreshDiceList()
	arg_12_0:RefreshTaskList()
	arg_12_0:RefreshBuffList()
	arg_12_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_13_0)
	local var_13_0 = NewWarChessData:GetCurrentWarChessMapID()
	local var_13_1 = RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. NewWarChessLevelCfg[var_13_0].activity

	manager.redPoint:bindUIandKey(arg_13_0.rewardBtn_.transform, var_13_1)
end

function var_0_0.UnBindRedPoint(arg_14_0)
	local var_14_0 = NewWarChessData:GetCurrentWarChessMapID()
	local var_14_1 = RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. NewWarChessLevelCfg[var_14_0].activity

	manager.redPoint:unbindUIandKey(arg_14_0.rewardBtn_.transform, var_14_1)
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		NewChessTools.ExitNewChessScene(false)
	end)

	local var_15_0 = NewChessTools.GetNewWarChessGameSetting("new_warchess_describe", NewWarChessData:GetCurrentMainActivity())

	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = var_15_0
		}
	})
end

function var_0_0.AddUIListener(arg_17_0)
	arg_17_0:AddBtnListener(arg_17_0.useItemBtn_, nil, function()
		JumpTools.OpenPageByJump("newWarChessPopItemView", {
			mainActivityID = NewWarChessData:GetCurrentMainActivity()
		})
	end)
	arg_17_0:AddBtnListener(arg_17_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("activityNewWarChessRewardView", {
			mainActivityID = NewWarChessData:GetCurrentMainActivity(),
			activityIDList = {
				NewWarChessData:GetCurrentActivity()
			}
		})
	end)
	arg_17_0:AddBtnListener(arg_17_0.lookatBtn_, nil, function()
		NewChessLuaBridge.LookAtPlayer()
		manager.NewChessManager:ClearEndPoint()
		SetActive(arg_17_0.lookatBtn_.gameObject, false)
	end)
	arg_17_0:AddBtnListener(arg_17_0.moveBtn_, nil, function()
		if arg_17_0.moveState_ == var_0_1[1] then
			manager.NewChessManager:StartMoveToCaChePath()
		elseif arg_17_0.moveState_ == var_0_1[2] then
			ShowTips("ACTIVITY_NEW_WARCHESS_MOVEPOINT_DEFICIENCY")
		elseif arg_17_0.moveState_ == var_0_1[3] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("ACTIVITY_NEW_WARCHESS_MOVEPOINT_COST_MORETHEN_MAX"), NewChessTools.GetNewWarChessGameSetting("new_warchess_single_move_point_max", NewWarChessData:GetCurrentMainActivity())[1]),
				OkCallback = function()
					manager.NewChessManager:StartMoveToCaChePath()
				end
			})
		end
	end)
	arg_17_0:AddBtnListener(arg_17_0.farClickBtn_, nil, function()
		if arg_17_0.farClickFun_ then
			arg_17_0.farClickFun_()

			arg_17_0.farClickFun_ = nil

			arg_17_0.statusController_:SetSelectedState("normal")
		end
	end)
	arg_17_0:AddBtnListener(arg_17_0.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("newWarChessHeroView")
	end)
	arg_17_0:AddBtnListener(arg_17_0.buffinfoBtn_, nil, function()
		if arg_17_0.isShowingBuff_ then
			arg_17_0.isShowingBuff_ = false
			arg_17_0.curShowBuffIndex_ = 0

			SetActive(arg_17_0.buffInfoGo_, false)
			arg_17_0.buffList_:Refresh()
		end
	end)
end

function var_0_0.OnNewChessHomeUpdateState(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	if arg_26_1 == NewChessConst.HOME_STATUS.NORMAL then
		arg_26_0.statusController_:SetSelectedState("normal")

		arg_26_0.curCost_ = 0
	elseif arg_26_1 == NewChessConst.HOME_STATUS.MOVING then
		arg_26_0.statusController_:SetSelectedState("moving")

		arg_26_0.curCost_ = 0
	elseif arg_26_1 == NewChessConst.HOME_STATUS.READY then
		arg_26_0.statusController_:SetSelectedState("ready")

		arg_26_0.curCost_ = arg_26_2
		arg_26_0.costText_.text = arg_26_2

		arg_26_0:RefreshMoveCost()

		local var_26_0 = arg_26_3 / Screen.width * manager.ui.canvasSize_.x
		local var_26_1 = arg_26_4 / Screen.height * manager.ui.canvasSize_.y

		arg_26_0.moveTrans_.localPosition = Vector3.New(var_26_0, var_26_1)
	elseif arg_26_1 == NewChessConst.HOME_STATUS.FARCLICK then
		arg_26_0.statusController_:SetSelectedState("farClick")

		arg_26_0.farClickFun_ = arg_26_5
		arg_26_0.curCost_ = 0

		local var_26_2 = arg_26_3 / Screen.width * manager.ui.canvasSize_.x
		local var_26_3 = arg_26_4 / Screen.height * manager.ui.canvasSize_.y

		arg_26_0.farClickTrans_.localPosition = Vector3.New(var_26_2, var_26_3)
	end
end

function var_0_0.RefreshMoveCost(arg_27_0)
	if arg_27_0.curCost_ > 0 then
		local var_27_0 = NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT")
		local var_27_1 = NewChessTools.GetNewWarChessGameSetting("new_warchess_single_move_point_max", NewWarChessData:GetCurrentMainActivity())[1]

		if var_27_0 < arg_27_0.curCost_ or var_27_1 < arg_27_0.curCost_ then
			if var_27_0 < arg_27_0.curCost_ then
				arg_27_0.moveState_ = var_0_1[2]
			elseif var_27_1 < arg_27_0.curCost_ then
				arg_27_0.moveState_ = var_0_1[3]
			end

			arg_27_0.moveController_:SetSelectedState("lock")
		else
			arg_27_0.moveState_ = var_0_1[1]

			arg_27_0.moveController_:SetSelectedState("normal")
		end
	end
end

function var_0_0.OnNewWarChessBuffUpDate(arg_28_0)
	arg_28_0:RefreshBuffList()
end

function var_0_0.OnNewWarChessExploreValueUpdate(arg_29_0, arg_29_1)
	arg_29_0.exploreValueText_.text = arg_29_1 .. "%"
	arg_29_0.exploreValueImage_.fillAmount = arg_29_1 / 100
end

function var_0_0.RefreshTaskList(arg_30_0)
	arg_30_0.taskIDList_ = {}

	local var_30_0 = manager.NewChessManager.taskManager_:GetTaskList()
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if NewWarChessTaskPoolCfg[iter_30_0].type == NewChessConst.TASKTYPE.MAIN then
			table.insert(arg_30_0.taskIDList_, iter_30_0)
		else
			table.insert(var_30_1, iter_30_0)
		end
	end

	for iter_30_2, iter_30_3 in pairs(var_30_1) do
		table.insert(arg_30_0.taskIDList_, iter_30_3)
	end

	arg_30_0.taskList_:StartScroll(#arg_30_0.taskIDList_)

	if #arg_30_0.taskIDList_ > 2 then
		arg_30_0.taskListImg_.raycastTarget = true
		arg_30_0.taskListScroll_.enabled = true
	else
		arg_30_0.taskListImg_.raycastTarget = false
		arg_30_0.taskListScroll_.enabled = false
	end
end

function var_0_0.RefreshBuffList(arg_31_0)
	arg_31_0.buffEntityList_ = manager.NewChessManager.buffManager_:GetActiveBuffEntityList()

	arg_31_0.buffList_:StartScroll(#arg_31_0.buffEntityList_)
end

function var_0_0.OnDiceUpdate(arg_32_0)
	arg_32_0:RefreshDiceList()
end

function var_0_0.RefreshDiceList(arg_33_0)
	arg_33_0.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	arg_33_0.diceList_:StartScroll(#arg_33_0.diceDataList_)
end

function var_0_0.OnCurMovePointUpdate(arg_34_0)
	arg_34_0.curMovePointText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT"))

	arg_34_0:RefreshMoveCost()
end

function var_0_0.OnTaskUpdate(arg_35_0)
	arg_35_0:RefreshTaskList()
end

function var_0_0.OnNewWarChessCameraMove(arg_36_0, arg_36_1)
	SetActive(arg_36_0.lookatBtn_.gameObject, arg_36_1)
end

function var_0_0.OnBehind(arg_37_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_38_0)
	manager.windowBar:HideBar()
	NewWarChessData:ClearDiceContinuousList()
	arg_38_0:UnBindRedPoint()
	arg_38_0.taskList_:StopRender()
	arg_38_0.diceList_:StopRender()
	arg_38_0.buffList_:StopRender()
end

function var_0_0.Dispose(arg_39_0)
	var_0_0.super.Dispose(arg_39_0)

	if arg_39_0.taskList_ then
		arg_39_0.taskList_:Dispose()

		arg_39_0.taskList_ = nil
	end

	if arg_39_0.diceList_ then
		arg_39_0.diceList_:Dispose()

		arg_39_0.diceList_ = nil
	end

	if arg_39_0.buffList_ then
		arg_39_0.buffList_:Dispose()

		arg_39_0.buffList_ = nil
	end

	arg_39_0.clickBuffHandler_ = nil
end

return var_0_0
