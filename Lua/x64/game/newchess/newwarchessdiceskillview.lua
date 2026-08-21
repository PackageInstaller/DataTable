local var_0_0 = class("NewWarChessDiceSkillView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessDiceSkillView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.diceFrameClickHandler_ = handler(arg_4_0, arg_4_0.OnDiceFrameClick)
	arg_4_0.diceClickHandler_ = handler(arg_4_0, arg_4_0.OnDiceClick)
	arg_4_0.diceFramActiveController_ = ControllerUtil.GetController(arg_4_0.diceframeListGo_.transform, "num")
	arg_4_0.diceFramSymbolController_ = ControllerUtil.GetController(arg_4_0.diceframeListGo_.transform, "symbol")
	arg_4_0.yesBtnController_ = ControllerUtil.GetController(arg_4_0.yesBtn_.transform, "enabled")
	arg_4_0.diceFrameItem_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.diceFrameItem_[iter_4_0] = NewWarChessDiceFrameItem.New(arg_4_0["diceframe" .. iter_4_0 .. "_"], arg_4_0.diceFrameClickHandler_, iter_4_0)
	end

	arg_4_0.diceList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDice), arg_4_0.diceListGo_, NewWarChessDiceItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.yesBtn_, nil, function()
		if not arg_5_0.yesBtnClickAble_ then
			return
		end

		local var_7_0 = {}

		for iter_7_0 = 1, #arg_5_0.diceFrameIDList_ do
			table.insert(var_7_0, arg_5_0.diceFrameItem_[iter_7_0].dicePoint_)
		end

		NewWarChessAction.UseDiceSkill(arg_5_0.skillID_, var_7_0, function()
			NewWarChessData:RemoveDice(var_7_0)
			NewWarChessData:UseSkill(arg_5_0.skillID_)
			JumpTools.Back()
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.mask_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.IndexSkill(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1)
end

function var_0_0.OnDiceClick(arg_11_0, arg_11_1)
	NewWarChessData:ClearAniCache()

	local var_11_0 = #arg_11_0.diceFrameIDList_

	if arg_11_0.diceDataList_[arg_11_1].hasInput == true then
		for iter_11_0 = 1, var_11_0 do
			if arg_11_0.diceFrameItem_[iter_11_0].diceIndex_ == arg_11_1 then
				arg_11_0.diceDataList_[arg_11_1].hasInput = false

				arg_11_0.diceFrameItem_[iter_11_0]:ResetDiceData()
				arg_11_0.diceFrameItem_[iter_11_0]:RefreshUI()
				arg_11_0:RefreshDiceList()
				arg_11_0:RefreshBtn()
				arg_11_0:RefreshUIText()

				return
			end
		end
	end

	local var_11_1 = arg_11_0.diceDataList_[arg_11_1][1]
	local var_11_2 = 0
	local var_11_3 = 0

	for iter_11_1 = 1, var_11_0 do
		if arg_11_0.diceFrameItem_[iter_11_1].dicePoint_ > 0 then
			var_11_2 = var_11_2 + arg_11_0.diceFrameItem_[iter_11_1].dicePoint_
			var_11_3 = var_11_3 + 1
		end
	end

	if var_11_3 < var_11_0 then
		if arg_11_0.diceLimitType_ == NewChessConst.DICE_LIMIT_TYPE.TWAIN then
			local var_11_4 = 0

			for iter_11_2 = 1, var_11_0 do
				if arg_11_0.diceFrameItem_[iter_11_2].dicePoint_ ~= 0 then
					var_11_4 = arg_11_0.diceFrameItem_[iter_11_2].dicePoint_

					break
				end
			end

			if var_11_4 > 0 and var_11_1 ~= var_11_4 then
				ShowTips("ACTIVITY_NEW_WARCHESS_DICE_NOT_IS_TWAIN")

				return
			end
		end

		if arg_11_0.outputLimit_ ~= 0 then
			if var_11_2 + var_11_1 > arg_11_0.outputLimit_ then
				ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), arg_11_0.outputLimit_))

				return
			end

			if var_11_3 == var_11_0 - 1 then
				if var_11_2 + var_11_1 < arg_11_0.outputLimit_ then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_SMALLER"), arg_11_0.outputLimit_))

					return
				elseif var_11_2 + var_11_1 > arg_11_0.outputLimit_ then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), arg_11_0.outputLimit_))

					return
				end
			end
		end

		for iter_11_3 = 1, var_11_0 do
			if arg_11_0.diceFrameItem_[iter_11_3]:CheckInputLimit(arg_11_1) then
				arg_11_0.diceFrameItem_[iter_11_3]:SetInputDice(arg_11_1)

				arg_11_0.diceDataList_[arg_11_1].hasInput = true

				arg_11_0:RefreshDiceList()
				arg_11_0:RefreshBtn()
				arg_11_0:RefreshUIText()

				return
			end
		end

		ShowTips("ACTIVITY_NEW_WARCHESS_DICE_UNDESIRABLE")
	end
end

function var_0_0.OnDiceFrameClick(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.diceFrameItem_[arg_12_1]

	if var_12_0.diceIndex_ ~= 0 then
		arg_12_0.diceDataList_[var_12_0.diceIndex_].hasInput = false

		var_12_0:ResetDiceData()
		var_12_0:RefreshUI()
		arg_12_0:RefreshUI()
	end
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.skillID_ = arg_13_0.params_.skillID
	arg_13_0.skillCfg_ = NewWarChessDiceSkillCfg[arg_13_0.skillID_]
	arg_13_0.data_ = NewWarChessData:GetSkillInfo(arg_13_0.skillID_)
	arg_13_0.leftUseLimit_ = arg_13_0.data_.useLimit
	arg_13_0.totalUseLimit_ = arg_13_0.skillCfg_.use_limit

	if arg_13_0.skillCfg_.dice_type > 0 then
		arg_13_0.diceEventCfg_ = NewWarChessDiceEventCfg[arg_13_0.skillCfg_.dice_type]
		arg_13_0.diceFrameIDList_ = arg_13_0.diceEventCfg_.dice_configuration
		arg_13_0.diceLimitType_ = arg_13_0.diceEventCfg_.dice_limit_type
		arg_13_0.outputLimit_ = arg_13_0.diceEventCfg_.dice_limit_output
	end

	arg_13_0:RefreshUI()
	arg_13_0:RefreshDiceFrameList()
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0:RefreshUIText()
	arg_14_0:RefreshBtn()
	arg_14_0:RefreshDiceList()
end

function var_0_0.RefreshBtn(arg_15_0)
	for iter_15_0 = 1, #arg_15_0.diceFrameIDList_ do
		if arg_15_0.diceFrameItem_[iter_15_0].dicePoint_ == 0 then
			arg_15_0.yesBtnController_:SetSelectedState("false")

			arg_15_0.yesBtnClickAble_ = false

			return
		end
	end

	arg_15_0.yesBtnClickAble_ = true

	arg_15_0.yesBtnController_:SetSelectedState("true")
end

function var_0_0.RefreshUIText(arg_16_0)
	arg_16_0.skillDescText_.text = arg_16_0.skillCfg_.description
	arg_16_0.skillNameText_.text = arg_16_0.skillCfg_.name
	arg_16_0.iconImage_.sprite = getSprite("Atlas/NewWarChess", arg_16_0.skillCfg_.icon)
	arg_16_0.useText_.text = arg_16_0.leftUseLimit_ .. "/" .. arg_16_0.totalUseLimit_
	arg_16_0.simpleDescText_.text = arg_16_0.skillCfg_.simple_description
end

function var_0_0.RefreshDiceList(arg_17_0)
	arg_17_0.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	arg_17_0.diceList_:StartScroll(#arg_17_0.diceDataList_)
end

function var_0_0.IndexDice(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:SetData(arg_18_1, arg_18_0.diceDataList_[arg_18_1])
	arg_18_2:SetClickCallBack(arg_18_0.diceClickHandler_)
end

function var_0_0.RefreshDiceFrameList(arg_19_0)
	if arg_19_0.skillCfg_.dice_type > 0 then
		arg_19_0.diceDescText_.text = arg_19_0.diceEventCfg_.dice_description

		SetActive(arg_19_0.relesGo_, true)

		if arg_19_0.diceLimitType_ == 1 then
			arg_19_0.diceFramSymbolController_:SetSelectedState("double")
		elseif arg_19_0.outputLimit_ ~= 0 then
			arg_19_0.diceFramSymbolController_:SetSelectedState("add")
		else
			arg_19_0.diceFramSymbolController_:SetSelectedState("empty")
		end

		arg_19_0.diceFramActiveController_:SetSelectedState(tostring(#arg_19_0.diceFrameIDList_))

		for iter_19_0 = 1, 3 do
			arg_19_0.diceFrameItem_[iter_19_0]:SetData(arg_19_0.diceFrameIDList_[iter_19_0] or 0)
		end
	else
		SetActive(arg_19_0.relesGo_, false)
	end
end

function var_0_0.OnExit(arg_20_0)
	NewWarChessData:ClearDiceContinuousList()

	for iter_20_0 = 1, 3 do
		arg_20_0.diceFrameItem_[iter_20_0]:ResetData()
	end
end

function var_0_0.Dispose(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.diceFrameItem_) do
		iter_21_1:Dispose()
	end

	if arg_21_0.diceList_ then
		arg_21_0.diceList_:Dispose()

		arg_21_0.diceList_ = nil
	end

	arg_21_0.diceFrameItem_ = nil
	arg_21_0.diceFrameClickHandler_ = nil

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
