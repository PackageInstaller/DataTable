local var_0_0 = class("NewWarChessChanceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessChanceUI"
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

	arg_4_0.executeChanceItemHandle_ = handler(arg_4_0, arg_4_0.ExecuteChanceItem)
	arg_4_0.itemList_ = {}
	arg_4_0.diceList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDiceItem), arg_4_0.diceListGo_, NewWarChessDiceItem)
	arg_4_0.isShowingBuff_ = false
	arg_4_0.curShowBuffIndex_ = 0
	arg_4_0.buffList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexBuffItem), arg_4_0.buffList_, NewWarChessBuffItem)
	arg_4_0.clickBuffHandler_ = handler(arg_4_0, arg_4_0.OnClickBuff)
end

function var_0_0.IndexDiceItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.diceDataList_[arg_5_1])
	arg_5_2:SetClickCallBack(function(arg_6_0)
		NewWarChessData:ClearAniCache()
		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_NEW_WARCHESS_CHECK_DICE_TO_MOVEPOINT"), arg_5_2.dicePoint_, arg_5_2.dicePoint_),
			OkCallback = function()
				local var_7_0 = arg_5_2.dicePoint_

				NewWarChessAction.DiceToMovePoint(var_7_0, function()
					local var_8_0 = math.floor(var_7_0 * (NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_TO_MOVE_POINT_TIMES") / 1000))

					NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", var_8_0)

					local var_8_1 = string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_TO_MOVEPOINT"), var_7_0, var_8_0)
					local var_8_2 = {
						tipsType = NewChessConst.TIPS_TYPE.SWITCH,
						tipsText = var_8_1,
						tipsDiceNum = var_7_0
					}

					manager.NewChessManager:CreateTips(var_8_2)
					NewWarChessData:RemoveDice({
						arg_5_2.dicePoint_
					})
					arg_5_0:GoNewChance(arg_5_0.chanceID_)
				end)
			end
		})
	end)
end

function var_0_0.IndexBuffItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_1, arg_9_0.curShowBuffIndex_, arg_9_0.buffEntityList_[arg_9_1])
	arg_9_2:SetClickCallBack(arg_9_0.clickBuffHandler_)
end

function var_0_0.OnClickBuff(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_0.isShowingBuff_ then
		SetActive(arg_10_0.buffInfoGo_, false)

		arg_10_0.curShowBuffIndex_ = 0

		arg_10_0.buffList_:Refresh()

		arg_10_0.isShowingBuff_ = false
	else
		SetActive(arg_10_0.buffInfoGo_, true)

		arg_10_0.curShowBuffIndex_ = arg_10_1
		arg_10_0.buffInfoNameText_.text = arg_10_2
		arg_10_0.buffInfoDesText_.text = arg_10_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.infoContentTrans_)

		arg_10_0.isShowingBuff_ = true
	end
end

function var_0_0.AddUIListener(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.buffinfoBtn_, nil, function()
		if arg_11_0.isShowingBuff_ then
			arg_11_0.isShowingBuff_ = false
			arg_11_0.curShowBuffIndex_ = 0

			SetActive(arg_11_0.buffInfoGo_, false)
			arg_11_0.buffList_:Refresh()
		end
	end)
	arg_11_0:AddBtnListener(arg_11_0.exitBtn_, nil, function()
		NewChessTools.ExitNewChessScene(false)
	end)
end

function var_0_0.OnEnter(arg_14_0)
	if arg_14_0.params_.chanceItemID then
		arg_14_0:ExecuteChanceItem(arg_14_0.params_.chanceItemID)

		arg_14_0.params_.chanceItemID = nil
	else
		if arg_14_0.params_.chanceID then
			arg_14_0.chanceID_ = arg_14_0.params_.chanceID
			arg_14_0.params_.chanceID = nil
		end

		arg_14_0:GoNewChance(arg_14_0.chanceID_)
	end
end

function var_0_0.OnTop(arg_15_0)
	return
end

function var_0_0.GoNewChance(arg_16_0, arg_16_1)
	arg_16_0.animator_:Play("ani")

	arg_16_0.chanceID_ = arg_16_1
	arg_16_0.cfg_ = NewWarChessChanceCfg[arg_16_0.chanceID_]
	arg_16_0.nametext_.text = arg_16_0.cfg_.name
	arg_16_0.desText_.text = NewChessTools.GetChanceDes(arg_16_0.cfg_)
	arg_16_0.chanceItemList_ = NewWarChessData:GetCurChanceItemList()

	local var_16_0 = 1

	for iter_16_0, iter_16_1 in pairs(arg_16_0.chanceItemList_) do
		if not arg_16_0.itemList_[var_16_0] then
			local var_16_1 = Object.Instantiate(arg_16_0.chanceItemGo_, arg_16_0.content_)

			arg_16_0.itemList_[var_16_0] = NewWarChessChanceItem.New(var_16_1)

			arg_16_0.itemList_[var_16_0]:SetNewChanceHandle(arg_16_0.executeChanceItemHandle_)
		end

		arg_16_0.itemList_[var_16_0]:SetIsShow(true)
		arg_16_0.itemList_[var_16_0]:SetData(arg_16_0.chanceID_, arg_16_0.chanceItemList_[var_16_0].chanceItemID)

		var_16_0 = var_16_0 + 1
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0.itemList_) do
		if var_16_0 <= iter_16_2 then
			iter_16_3:SetIsShow(false)
		end
	end

	SetActive(arg_16_0.buffInfoGo_, false)

	arg_16_0.curShowBuffIndex_ = 0
	arg_16_0.isShowingBuff_ = false

	arg_16_0:RefreshDiceList()
	arg_16_0:RefreshBuffList()
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.content_)
end

function var_0_0.OnNewWarChessBuffUpDate(arg_17_0)
	arg_17_0:RefreshBuffList()
end

function var_0_0.OnDiceUpdate(arg_18_0)
	arg_18_0:RefreshDiceList()
end

function var_0_0.RefreshDiceList(arg_19_0)
	arg_19_0.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	arg_19_0.diceList_:StartScroll(#arg_19_0.diceDataList_)
end

function var_0_0.RefreshBuffList(arg_20_0)
	arg_20_0.buffEntityList_ = manager.NewChessManager.buffManager_:GetActiveBuffEntityList()

	arg_20_0.buffList_:StartScroll(#arg_20_0.buffEntityList_)
end

function var_0_0.ExecuteChanceItem(arg_21_0, arg_21_1)
	local var_21_0 = NewWarChessChanceItemCfg[arg_21_1]

	arg_21_0:ExecuteNewWarChessEvent(arg_21_1)
	arg_21_0:ExecuteChanceJumpEvent(var_21_0.jump_event)
end

function var_0_0.ExecuteNewWarChessEvent(arg_22_0, arg_22_1)
	local var_22_0 = manager.NewChessManager:GetChanceInteracChess()

	if NewWarChessChanceItemCfg[arg_22_1].new_warchess_event ~= 0 then
		local var_22_1 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_CHANCE_CHOOSE, {
			arg_22_1
		})

		manager.NewChessManager:ExecutChess(NewChessConst.TIMING_CHANCE_CHOOSE, var_22_0, var_22_1)
		manager.NewChessManager:StartExecuteEvent()
	end
end

function var_0_0.ExecuteChanceJumpEvent(arg_23_0, arg_23_1)
	if arg_23_1[1] then
		if arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.NEW_CHANCE then
			arg_23_0:GoNewChance(arg_23_1[2])
		elseif arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHOUTSAVE then
			JumpTools.OpenPageByJump("/newWarChessHome")
		elseif arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHSAVE then
			JumpTools.OpenPageByJump("/newWarChessHome")
		elseif arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE then
			arg_23_0:GoNewChance(arg_23_1[3])
		elseif arg_23_1[1] == NewChessConst.CHANCE_JUMP_TYPE.SELECT_CHANCE then
			local var_23_0 = arg_23_1[2]

			if arg_23_1[3] <= NewWarChessData:GetAttribute(var_23_0) then
				arg_23_0:GoNewChance(arg_23_1[4])
			else
				arg_23_0:GoNewChance(arg_23_1[5])
			end
		end
	end
end

function var_0_0.OnExit(arg_24_0)
	NewWarChessData:ClearDiceContinuousList()
	arg_24_0.diceList_:StopRender()
	arg_24_0.buffList_:StopRender()
end

function var_0_0.Dispose(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.itemList_) do
		iter_25_1:Dispose()
	end

	arg_25_0.itemList_ = {}
	arg_25_0.executeChanceItemHandle_ = nil

	if arg_25_0.diceList_ then
		arg_25_0.diceList_:Dispose()

		arg_25_0.diceList_ = nil
	end

	if arg_25_0.buffList_ then
		arg_25_0.buffList_:Dispose()

		arg_25_0.buffList_ = nil
	end

	arg_25_0.clickBuffHandler_ = nil

	arg_25_0.super.Dispose(arg_25_0)
end

return var_0_0
