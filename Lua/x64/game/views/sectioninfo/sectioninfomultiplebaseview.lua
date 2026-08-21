local var_0_0 = class("SectionInfoMultipleBaseView", import(".SectionInfoBaseView"))
local var_0_1 = #GameSetting.challenge_multiple_count_unlock_level.value

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	arg_1_0.hideMultiplePanelController_:SetSelectedState("false")
end

function var_0_0.AddListeners(arg_2_0)
	var_0_0.super.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.minMultipleBtn_, nil, function()
		OperationRecorder.Record(arg_2_0.class.__cname, "challenge_multiple")

		arg_2_0.multiple_ = 1

		arg_2_0:ChangeMultiple()
	end)
	arg_2_0:AddBtnListener(arg_2_0.subBtn_, nil, function()
		OperationRecorder.Record(arg_2_0.class.__cname, "single")

		arg_2_0.multiple_ = arg_2_0.multiple_ - 1

		arg_2_0:ChangeMultiple()
	end)
	arg_2_0:AddBtnListener(arg_2_0.addBtn_, nil, function()
		OperationRecorder.Record(arg_2_0.class.__cname, "single")

		if arg_2_0.multiple_ >= arg_2_0.challengeCnt_ then
			local var_5_0 = arg_2_0:GetChallengeCntMaxTip()

			ShowTips(var_5_0)

			return
		end

		arg_2_0.multiple_ = arg_2_0.multiple_ + 1

		arg_2_0:ChangeMultiple()
	end)
	arg_2_0:AddBtnListener(arg_2_0.maxMultipleBtn_, nil, function()
		OperationRecorder.Record(arg_2_0.class.__cname, "challenge_multiple")

		local var_6_0 = arg_2_0.maxMultiple_

		if arg_2_0.challengeCnt_ < arg_2_0.maxMultiple_ then
			var_6_0 = arg_2_0.challengeCnt_
		end

		arg_2_0.multiple_ = var_6_0

		arg_2_0:ChangeMultiple()
	end)
end

function var_0_0.RemoveListeners(arg_7_0)
	var_0_0.super.RemoveListeners(arg_7_0)
	arg_7_0.minMultipleBtn_.onClick:RemoveAllListeners()
	arg_7_0.subBtn_.onClick:RemoveAllListeners()
	arg_7_0.addBtn_.onClick:RemoveAllListeners()
	arg_7_0.maxMultipleBtn_.onClick:RemoveAllListeners()
end

function var_0_0.OnCurrencyChange(arg_8_0)
	var_0_0.super.OnCurrencyChange(arg_8_0)
	arg_8_0:RefreshMultiple()
end

function var_0_0.RefreshData(arg_9_0)
	local var_9_0 = 1

	for iter_9_0 = var_0_1, 1, -1 do
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= arg_9_0.cost_ * iter_9_0 then
			var_9_0 = iter_9_0

			break
		end
	end

	arg_9_0.maxMultiple_ = var_9_0
	arg_9_0.multiple_ = arg_9_0.multiple_ or 1
	arg_9_0.challengeCnt_ = arg_9_0:GetUnlockChallengeCnt()
end

function var_0_0.RefreshUI(arg_10_0)
	var_0_0.super.RefreshUI(arg_10_0)
	arg_10_0:RefreshMultiple()
end

function var_0_0.OnClickBtn(arg_11_0)
	return
end

function var_0_0.ChangeMultiple(arg_12_0)
	arg_12_0:RefreshMultiple()
	arg_12_0:RefreshCost()
	arg_12_0:RefreshBtn()
end

function var_0_0.RefreshMultiple(arg_13_0)
	arg_13_0.multipleText_.text = "x" .. arg_13_0.multiple_

	if arg_13_0.multiple_ >= arg_13_0.maxMultiple_ or arg_13_0.multiple_ >= arg_13_0.challengeCnt_ then
		arg_13_0.maxMultipleBtn_.interactable = false
		arg_13_0.maxMultipleBtnCanvas_.alpha = 0.5
		arg_13_0.minMultipleBtn_.interactable = true
		arg_13_0.minMultipleCanvas_.alpha = 1
		arg_13_0.subBtn_.interactable = true
		arg_13_0.subBtnCanvas_.alpha = 1
	elseif arg_13_0.multiple_ <= 1 then
		arg_13_0.maxMultipleBtn_.interactable = true
		arg_13_0.maxMultipleBtnCanvas_.alpha = 1
		arg_13_0.minMultipleBtn_.interactable = false
		arg_13_0.minMultipleCanvas_.alpha = 0.5
		arg_13_0.subBtn_.interactable = false
		arg_13_0.subBtnCanvas_.alpha = 0.5
	else
		arg_13_0.maxMultipleBtn_.interactable = true
		arg_13_0.maxMultipleBtnCanvas_.alpha = 1
		arg_13_0.minMultipleBtn_.interactable = true
		arg_13_0.minMultipleCanvas_.alpha = 1
		arg_13_0.subBtn_.interactable = true
		arg_13_0.subBtnCanvas_.alpha = 1
	end

	if arg_13_0.multiple_ == var_0_1 then
		arg_13_0.addBtn_.interactable = false
		arg_13_0.addBtnCanvas_.alpha = 0.5
	else
		arg_13_0.addBtn_.interactable = true
		arg_13_0.addBtnCanvas_.alpha = 1
	end

	if arg_13_0.multiple_ <= 1 then
		arg_13_0.minMultipleBtn_.interactable = false
		arg_13_0.minMultipleCanvas_.alpha = 0.5
		arg_13_0.subBtn_.interactable = false
		arg_13_0.subBtnCanvas_.alpha = 0.5
	end
end

function var_0_0.GetUnlockChallengeCnt(arg_14_0)
	local var_14_0 = GameSetting.challenge_multiple_count_unlock_level.value
	local var_14_1 = PlayerData:GetPlayerInfo().userLevel

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if var_14_1 < iter_14_1 then
			return iter_14_0 - 1
		end
	end

	return #var_14_0
end

function var_0_0.GetChallengeCntMaxTip(arg_15_0)
	return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.challenge_multiple_count_unlock_level.value[arg_15_0.multiple_ + 1])
end

return var_0_0
