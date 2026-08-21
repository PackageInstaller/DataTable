local var_0_0 = class("PassportBuyLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Passport/PassportBuyLevelUI"
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

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.listGo_, CommonItemView)
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		id = arg_5_0.rewardList_[arg_5_1].id,
		number = arg_5_0.rewardList_[arg_5_1].num,
		clickFun = function()
			ShowPopItem(POP_ITEM, arg_5_0.rewardList_[arg_5_1])
		end
	}

	CommonTools.SetCommonData(arg_5_2, var_5_0)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.delBtn_, nil, function()
		arg_7_0:UpdateByNum(math.min(arg_7_0.num_ - 1), 1)
	end)
	arg_7_0:AddBtnListener(arg_7_0.addBtn_, nil, function()
		arg_7_0:UpdateByNum(math.max(arg_7_0.num_ + 1), arg_7_0:GetMaxNum())
	end)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buyBtn_, nil, function()
		local var_12_0 = math.min(arg_7_0.num_, arg_7_0:GetMaxNum())
		local var_12_1 = PassportData:GetLevel() + var_12_0

		JumpTools.OpenPageByJump("passportBuyLevelConfirm", {
			num = var_12_0,
			level = var_12_1,
			cost = GameSetting.battlepass_level_price.value[2] * var_12_0,
			callback = function()
				arg_7_0:Back()
			end
		})
	end)
	arg_7_0.slider_.onValueChanged:AddListener(function()
		arg_7_0:UpdateByNum(math.max(math.floor(arg_7_0.slider_.value), 1))
	end)
end

function var_0_0.UpdateByNum(arg_15_0, arg_15_1)
	arg_15_0.num_ = arg_15_1
	arg_15_0.delBtn_.interactable = arg_15_0.num_ > 1
	arg_15_0.addBtn_.interactable = arg_15_0.num_ < arg_15_0:GetMaxNum()
	arg_15_0.slider_.value = arg_15_1

	arg_15_0:CalculateReward()
	arg_15_0.list_:StartScroll(#arg_15_0.rewardList_)

	local var_15_0 = GameSetting.battlepass_level_price.value[1]
	local var_15_1 = GameSetting.battlepass_level_price.value[2] * arg_15_1

	if var_15_1 > ItemTools.getItemNum(var_15_0) then
		arg_15_0.costLabel_.text = string.format("<color=#FF000B>%s</color>", var_15_1)
	else
		arg_15_0.costLabel_.text = var_15_1
	end

	arg_15_0.costIcon_.sprite = ItemTools.getItemLittleSprite(var_15_0)
	arg_15_0.buyNumLabel_.text = arg_15_1
	arg_15_0.levelTxt_.text = string.format(GetTips("BATTLEPASS_BUY_TITLE"), PassportData:GetLevel() + arg_15_1)
end

function var_0_0.CalculateReward(arg_16_0)
	arg_16_0.rewardList_ = {}

	local var_16_0 = PassportData:GetLevel()
	local var_16_1 = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
	local var_16_2 = math.min(arg_16_0.num_, arg_16_0:GetMaxNum())

	for iter_16_0 = 1, var_16_2 do
		local var_16_3 = var_16_1[var_16_0 + iter_16_0]

		table.insertto(arg_16_0.rewardList_, BattlePassCfg[var_16_3].reward_free)

		if PassportData:GetPayLevel() > 0 then
			table.insertto(arg_16_0.rewardList_, BattlePassCfg[var_16_3].reward_pay)
		end
	end

	local var_16_4 = formatRewardCfgList(arg_16_0.rewardList_)

	arg_16_0.rewardList_ = mergeReward(var_16_4)

	table.sort(arg_16_0.rewardList_, function(arg_17_0, arg_17_1)
		local var_17_0 = ItemCfg[arg_17_0.id]
		local var_17_1 = ItemCfg[arg_17_1.id]

		if var_17_0.rare ~= var_17_1.rare then
			return var_17_0.rare > var_17_1.rare
		end

		return var_17_0.id > var_17_1.id
	end)
end

function var_0_0.UpdateBar(arg_18_0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_0.OnEnter(arg_19_0)
	local var_19_0 = arg_19_0.params_.notRemainLevel or true

	arg_19_0.params_.notRemainLevel = nil
	arg_19_0.slider_.maxValue = arg_19_0:GetMaxNum()
	arg_19_0.slider_.value = var_19_0 and 1 or arg_19_0.num_

	arg_19_0:UpdateByNum(var_19_0 and 1 or arg_19_0.num_)
end

function var_0_0.OnExit(arg_20_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_21_0)
	arg_21_0:UpdateBar()
end

function var_0_0.GetMaxNum(arg_22_0)
	return PassportData:GetMaxLevel() - PassportData:GetLevel()
end

function var_0_0.OnExitInput(arg_23_0)
	return true
end

function var_0_0.Dispose(arg_24_0)
	if arg_24_0.list_ then
		arg_24_0.list_:Dispose()

		arg_24_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
