local var_0_0 = class("MatrixScoreExchangeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.lockController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "lock")
	arg_3_0.bonusLuaList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.bonusListGo_, CommonItem)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshData({
		id = arg_4_0.bonusList_[arg_4_1].item_id,
		number = arg_4_0.bonusList_[arg_4_1].item_num
	})
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.getBtn_, nil, function()
		MatrixAction.GetBonus({
			rank = arg_6_0.rank_,
			reward = arg_6_0.bonusList_
		})
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	arg_8_0.index_ = arg_8_1
	arg_8_0.rank_ = arg_8_2
	arg_8_0.score_ = MatrixPointRankCfg[arg_8_2].point
	arg_8_0.bonusList_ = arg_8_3
	arg_8_0.haveGetBonus_ = arg_8_4
	arg_8_0.needLevel = arg_8_5

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT)

	arg_9_0.scoreText_.text = string.format("%d", arg_9_0.score_)

	arg_9_0.bonusLuaList_:StartScroll(#arg_9_0.bonusList_)

	if var_9_0 < arg_9_0.score_ then
		arg_9_0.statusController_:SetSelectedState("cannotGet")
	elseif arg_9_0.haveGetBonus_ == 1 then
		arg_9_0.statusController_:SetSelectedState("haveGet")
	else
		arg_9_0.statusController_:SetSelectedState("canGet")
	end

	if MatrixData:GetTerminalLevel() < arg_9_0.needLevel then
		arg_9_0.lockController_:SetSelectedIndex(1)

		arg_9_0.lockTip_.text = string.format(GetTips("MATRIX_TERMINAL_LEVEL_UNLOCK"), arg_9_0.needLevel)

		arg_9_0.statusController_:SetSelectedState("cannotGet")
	else
		arg_9_0.lockController_:SetSelectedIndex(0)
	end
end

function var_0_0.OnEnter(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.bonusLuaList_ then
		arg_12_0.bonusLuaList_:Dispose()

		arg_12_0.bonusLuaList_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
