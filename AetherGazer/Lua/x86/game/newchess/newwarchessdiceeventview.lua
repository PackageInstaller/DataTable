local var_0_0 = class("NewWarChessDiceEventView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessDiceUI"
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

	arg_4_0.diceFrameClickHandler_ = handler(arg_4_0, arg_4_0.OnDiceFrameClick)
	arg_4_0.diceClickHandler_ = handler(arg_4_0, arg_4_0.OnDiceClick)
	arg_4_0.skillClickHandler_ = handler(arg_4_0, arg_4_0.OnSkillItemClick)
	arg_4_0.diceFramActiveController_ = ControllerUtil.GetController(arg_4_0.diceframeListGo_.transform, "num")
	arg_4_0.diceFramSymbolController_ = ControllerUtil.GetController(arg_4_0.diceframeListGo_.transform, "symbol")
	arg_4_0.yesBtnController_ = ControllerUtil.GetController(arg_4_0.yesbtn_.transform, "disable")
	arg_4_0.diceFrameItem_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.diceFrameItem_[iter_4_0] = NewWarChessDiceFrameItem.New(arg_4_0["diceframe" .. iter_4_0 .. "_"], arg_4_0.diceFrameClickHandler_, iter_4_0)
	end

	arg_4_0.diceList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDice), arg_4_0.diceListGo_, NewWarChessDiceItem)
	arg_4_0.skillList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexSkill), arg_4_0.skillListGo_, NewWarChessSkillItem)
end

function var_0_0.OnDiceUpdate(arg_5_0)
	arg_5_0:RefreshDiceList()
	arg_5_0:RefreshDiceFrameList()
end

function var_0_0.RefreshDiceList(arg_6_0)
	arg_6_0.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	arg_6_0.diceList_:StartScroll(#arg_6_0.diceDataList_)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.backbtn_, nil, function()
		JumpTools.Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.yesbtn_, nil, function()
		if not arg_7_0.yesBtnClickAble_ then
			return
		end

		local var_9_0 = {}

		for iter_9_0 = 1, #arg_7_0.diceFrameIDList_ do
			table.insert(var_9_0, arg_7_0.diceFrameItem_[iter_9_0].dicePoint_)
		end

		if arg_7_0.chanceItemCfg_.jump_event[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE then
			NewWarChessAction.SelectChanceItem(arg_7_0.chanceItemID_, var_9_0, function()
				local var_10_0 = arg_7_0.chanceItemCfg_.jump_event[2]

				if not BattleNewWarChessStageCfg[var_10_0] then
					-- block empty
				end

				if NewWarChessData:CheckIsAllDie() then
					ShowTips("ACTIVITY_NEW_WARCHESS_ALL_HERO_DIE")

					return
				end

				local var_10_1 = {}

				if arg_7_0.chanceItemCfg_.jump_event[5] then
					local var_10_2 = 0

					for iter_10_0, iter_10_1 in pairs(var_9_0) do
						var_10_2 = var_10_2 + iter_10_1
					end

					for iter_10_2, iter_10_3 in pairs(arg_7_0.chanceItemCfg_.jump_event[5]) do
						local var_10_3 = deepClone(iter_10_3)

						var_10_3[2] = var_10_2

						table.insert(var_10_1, var_10_3)
					end
				end

				manager.NewChessManager:BattleStart(arg_7_0.chanceID_, arg_7_0.chanceItemID_, var_9_0, var_10_1)
				gameContext:Go("/sectionSelectHero", {
					section = var_10_0,
					sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS,
					activityID = NewWarChessData:GetCurrentActivity()
				})
			end)
		else
			NewWarChessAction.SelectChanceItem(arg_7_0.chanceItemID_, var_9_0, function()
				arg_7_0:ExecuteChanceItem(arg_7_0.chanceItemID_)
			end)
		end
	end)
end

function var_0_0.IndexSkill(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.skillDataList_[arg_12_1])
	arg_12_2:SetClickCallBack(arg_12_0.skillClickHandler_)
	arg_12_2:BindSkillRedPoint()
end

function var_0_0.OnSkillItemClick(arg_13_0, arg_13_1)
	JumpTools.OpenPageByJump("/newWarChessDiceSkillView", {
		skillID = arg_13_1
	})
end

function var_0_0.OnDiceClick(arg_14_0, arg_14_1)
	NewWarChessData:ClearAniCache()

	local var_14_0 = #arg_14_0.diceFrameIDList_

	if arg_14_0.diceDataList_[arg_14_1].hasInput == true then
		for iter_14_0 = 1, var_14_0 do
			if arg_14_0.diceFrameItem_[iter_14_0].diceIndex_ == arg_14_1 then
				arg_14_0.diceDataList_[arg_14_1].hasInput = false

				arg_14_0.diceFrameItem_[iter_14_0]:ResetDiceData()
				arg_14_0.diceFrameItem_[iter_14_0]:RefreshUI()
				arg_14_0:RefreshDiceList()
				arg_14_0:RefreshBtn()
				arg_14_0:RefreshUIText()

				return
			end
		end
	end

	local var_14_1 = arg_14_0.diceDataList_[arg_14_1][1]
	local var_14_2 = 0
	local var_14_3 = 0

	for iter_14_1 = 1, var_14_0 do
		if arg_14_0.diceFrameItem_[iter_14_1].dicePoint_ > 0 then
			var_14_2 = var_14_2 + arg_14_0.diceFrameItem_[iter_14_1].dicePoint_
			var_14_3 = var_14_3 + 1
		end
	end

	if var_14_3 < var_14_0 then
		if arg_14_0.diceLimitType_ == NewChessConst.DICE_LIMIT_TYPE.TWAIN then
			local var_14_4 = 0

			for iter_14_2 = 1, var_14_0 do
				if arg_14_0.diceFrameItem_[iter_14_2].dicePoint_ ~= 0 then
					var_14_4 = arg_14_0.diceFrameItem_[iter_14_2].dicePoint_

					break
				end
			end

			if var_14_4 > 0 and var_14_1 ~= var_14_4 then
				ShowTips("ACTIVITY_NEW_WARCHESS_DICE_NOT_IS_TWAIN")

				return
			end
		end

		if arg_14_0.outputLimit_ ~= 0 then
			if var_14_2 + var_14_1 > arg_14_0.outputLimit_ then
				ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), arg_14_0.outputLimit_))

				return
			end

			if var_14_3 == var_14_0 - 1 then
				if var_14_2 + var_14_1 < arg_14_0.outputLimit_ then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_SMALLER"), arg_14_0.outputLimit_))

					return
				elseif var_14_2 + var_14_1 > arg_14_0.outputLimit_ then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), arg_14_0.outputLimit_))

					return
				end
			end
		end

		for iter_14_3 = 1, var_14_0 do
			if arg_14_0.diceFrameItem_[iter_14_3]:CheckInputLimit(arg_14_1) then
				arg_14_0.diceFrameItem_[iter_14_3]:SetInputDice(arg_14_1)

				arg_14_0.diceDataList_[arg_14_1].hasInput = true

				arg_14_0:RefreshDiceList()
				arg_14_0:RefreshBtn()
				arg_14_0:RefreshUIText()

				return
			end
		end

		ShowTips("ACTIVITY_NEW_WARCHESS_DICE_UNDESIRABLE")
	end
end

function var_0_0.OnDiceFrameClick(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.diceFrameItem_[arg_15_1]

	if var_15_0.diceIndex_ ~= 0 then
		arg_15_0.diceDataList_[var_15_0.diceIndex_].hasInput = false

		var_15_0:ResetDiceData()
		var_15_0:RefreshUI()
		arg_15_0:RefreshBtn()
		arg_15_0:RefreshUIText()
		arg_15_0:RefreshDiceList()
	end
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.chanceID_ = arg_16_0.params_.chanceID
	arg_16_0.chanceCfg_ = NewWarChessChanceCfg[arg_16_0.chanceID_]
	arg_16_0.chanceItemID_ = arg_16_0.params_.chanceItemID
	arg_16_0.chanceItemCfg_ = NewWarChessChanceItemCfg[arg_16_0.chanceItemID_]
	arg_16_0.eventPoolCfg_ = NewWarChessEventPoolCfg[arg_16_0.chanceItemCfg_.new_warchess_event]
	arg_16_0.diceEventCfg_ = NewWarChessDiceEventCfg[arg_16_0.chanceItemCfg_.dice_type]
	arg_16_0.diceFrameIDList_ = arg_16_0.diceEventCfg_.dice_configuration
	arg_16_0.diceLimitType_ = arg_16_0.diceEventCfg_.dice_limit_type
	arg_16_0.outputLimit_ = arg_16_0.diceEventCfg_.dice_limit_output

	arg_16_0:RefreshUI()
end

function var_0_0.RefreshSkillList(arg_17_0)
	arg_17_0.skillDataList_ = NewWarChessData:GetSkillList()

	arg_17_0.skillList_:StartScroll(#arg_17_0.skillDataList_)
end

function var_0_0.RefreshUI(arg_18_0)
	arg_18_0:RefreshBtn()
	arg_18_0:RefreshUIText()
	arg_18_0:RefreshDiceList()
	arg_18_0:RefreshDiceFrameList()
	arg_18_0:RefreshSkillList()
end

function var_0_0.RefreshBtn(arg_19_0)
	for iter_19_0 = 1, #arg_19_0.diceFrameIDList_ do
		if arg_19_0.diceFrameItem_[iter_19_0].dicePoint_ == 0 then
			arg_19_0.yesBtnController_:SetSelectedState("true")

			arg_19_0.yesBtnClickAble_ = false

			return
		end
	end

	arg_19_0.yesBtnClickAble_ = true

	arg_19_0.yesBtnController_:SetSelectedState("false")
end

function var_0_0.RefreshUIText(arg_20_0)
	arg_20_0.nameText_.text = arg_20_0.chanceItemCfg_.name
	arg_20_0.destext_.text = NewChessTools.GetChanceDes(arg_20_0.chanceCfg_)
	arg_20_0.diceDescText_.text = arg_20_0.diceEventCfg_.dice_description

	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.diceFrameItem_) do
		if iter_20_1.dicePoint_ ~= 0 then
			table.insert(var_20_0, iter_20_1.dicePoint_)
		end
	end

	arg_20_0.eventDescText_.text = NewChessTools.GetDiceEventDes(arg_20_0.chanceItemCfg_, var_20_0, arg_20_0.yesBtnClickAble_)
end

function var_0_0.IndexDice(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2:SetData(arg_21_1, arg_21_0.diceDataList_[arg_21_1])
	arg_21_2:SetClickCallBack(arg_21_0.diceClickHandler_)
end

function var_0_0.RefreshDiceFrameList(arg_22_0)
	if arg_22_0.diceLimitType_ == NewChessConst.DICE_LIMIT_TYPE.TWAIN then
		arg_22_0.diceFramSymbolController_:SetSelectedState("double")
	elseif arg_22_0.outputLimit_ ~= 0 then
		arg_22_0.diceFramSymbolController_:SetSelectedState("add")
	else
		arg_22_0.diceFramSymbolController_:SetSelectedState("empty")
	end

	arg_22_0.diceFramActiveController_:SetSelectedState(tostring(#arg_22_0.diceFrameIDList_))

	for iter_22_0 = 1, 3 do
		arg_22_0.diceFrameItem_[iter_22_0]:SetData(arg_22_0.diceFrameIDList_[iter_22_0] or 0)
	end
end

function var_0_0.ExecuteChanceItem(arg_23_0, arg_23_1)
	local var_23_0 = NewWarChessChanceItemCfg[arg_23_1]

	arg_23_0:ExecuteNewWarChessEvent(arg_23_1)
	arg_23_0:ExecuteChanceJumpEvent(var_23_0.jump_event)
end

function var_0_0.ExecuteNewWarChessEvent(arg_24_0, arg_24_1)
	local var_24_0 = {}

	for iter_24_0 = 1, #arg_24_0.diceFrameIDList_ do
		table.insert(var_24_0, arg_24_0.diceFrameItem_[iter_24_0].dicePoint_)
	end

	NewWarChessData:RemoveDice(var_24_0)

	local var_24_1 = manager.NewChessManager:GetChanceInteracChess()

	if NewWarChessChanceItemCfg[arg_24_1].new_warchess_event ~= 0 then
		local var_24_2 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_CHANCE_CHOOSE, {
			arg_24_1
		})

		manager.NewChessManager:ExecutChess(NewChessConst.TIMING_CHANCE_CHOOSE, var_24_1, var_24_2)
		manager.NewChessManager:StartExecuteEvent()
	end
end

function var_0_0.ExecuteChanceJumpEvent(arg_25_0, arg_25_1)
	if arg_25_1[1] then
		if arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.NEW_CHANCE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.SELECT_CHANCE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.DICE_SWITCH_CHANCE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.DICE_SUM_SWITCH_CHANCE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.ATTRIBUTE_SWITCH_CHANCE then
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = NewWarChessData:GetServerChanceID()
			})
		elseif arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHOUTSAVE or arg_25_1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHSAVE then
			JumpTools.OpenPageByJump("/newWarChessHome")
		end
	end
end

function var_0_0.OnTop(arg_26_0)
	arg_26_0:RefreshUI()
end

function var_0_0.OnExit(arg_27_0)
	NewWarChessData:ClearDiceContinuousList()

	for iter_27_0 = 1, 3 do
		arg_27_0.diceFrameItem_[iter_27_0]:ResetData()
	end
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0.diceFrameClickHandler_ = nil
	arg_28_0.skillClickHandler_ = nil

	for iter_28_0, iter_28_1 in pairs(arg_28_0.diceFrameItem_) do
		iter_28_1:Dispose()
	end

	arg_28_0.diceFrameItem_ = nil

	if arg_28_0.diceList_ then
		arg_28_0.diceList_:Dispose()

		arg_28_0.diceList_ = nil
	end

	if arg_28_0.skillList_ then
		arg_28_0.skillList_:Dispose()

		arg_28_0.skillList_ = nil
	end

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
