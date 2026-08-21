local var_0_0 = class("AutoChessCardTipsItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.cardID_ = 0
	arg_1_0.itemList_ = {}

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.qualityBgController_ = arg_3_0.tipsController_:GetController("QualityBg")
	arg_3_0.btnStateController_ = arg_3_0.controller_:GetController("state")

	for iter_3_0 = 1, 3 do
		local var_3_0 = AutoChessCardLvInfoItem.New(arg_3_0["subTipsGo" .. iter_3_0 .. "_"])

		arg_3_0.itemList_[iter_3_0] = var_3_0
	end
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.chessID_ = arg_5_1
	arg_5_0.cardID_ = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.chessImg_.sprite = AutoChessTools.GetChessBody(arg_6_0.chessID_)

	local var_6_0 = AutoChessCfg[arg_6_0.chessID_]

	if not var_6_0 then
		return
	end

	arg_6_0.chessName_.text = var_6_0.name

	arg_6_0.qualityBgController_:SetSelectedIndex(var_6_0.star - 1)

	for iter_6_0 = 1, 3 do
		arg_6_0.itemList_[iter_6_0]:RefreshUI(arg_6_0.chessID_, iter_6_0)
	end

	local var_6_1 = AutoChessCardData:GetCardNum(arg_6_0.cardID_)

	arg_6_0.txtNum_.text = var_6_1

	if AutoChessCardCfg[arg_6_0.cardID_].type == AutoChessCardConst.CARD_TYPE.R then
		arg_6_0.btnStateController_:SetSelectedState("own")
	elseif var_6_1 <= 0 then
		arg_6_0.btnStateController_:SetSelectedState("btn")
	else
		arg_6_0.btnStateController_:SetSelectedState("own")
	end
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.itemList_) do
		iter_7_1:Dispose()
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
