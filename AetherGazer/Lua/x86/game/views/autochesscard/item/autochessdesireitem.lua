local var_0_0 = class("AutoChessDesireItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.cardID_ = 0

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
	arg_4_0.cardItem_ = AutoChessCardItem.New(arg_4_0.cardGo_)
	arg_4_0.ownNumController_ = arg_4_0.controller_:GetController("ownNum")
	arg_4_0.emptyController_ = arg_4_0.controller_:GetController("empty")
	arg_4_0.wishStateController_ = arg_4_0.controller_:GetController("wishState")
	arg_4_0.selectController_ = arg_4_0.controller_:GetController("select")
end

function var_0_0.SetEmptyState(arg_5_0, arg_5_1)
	arg_5_0.emptyController_:SetSelectedIndex(arg_5_1)
end

function var_0_0.SetOwnNumState(arg_6_0, arg_6_1)
	arg_6_0.ownNumController_:SetSelectedIndex(arg_6_1)
end

function var_0_0.SetSelectState(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(tostring(arg_7_1))
end

function var_0_0.SetGreyState(arg_8_0, arg_8_1)
	arg_8_0.cardItem_:SetGreyState(arg_8_1)
end

function var_0_0.RefreshHead(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0, var_9_1 = AutoChessTools.GetRankLevelCfg(arg_9_2)

	arg_9_0.txtRankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_9_0.icon)
	arg_9_0.txtRankLevel_.text = var_9_0.name
	arg_9_0.txtPlayerName_.text = arg_9_3

	arg_9_0.commonPortrait_:RenderHead(arg_9_1)

	local var_9_2 = AutoChessCardData:GetCardNum(arg_9_0.cardID_)

	arg_9_0.txtNum_.text = var_9_2 <= 1 and 0 or var_9_2 - 1
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.cardID_ = arg_10_1

	arg_10_0.cardItem_:SetData(arg_10_1, arg_10_2)
	arg_10_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_11_0)
	return
end

function var_0_0.RefreshWishState(arg_12_0, arg_12_1)
	local var_12_0 = AutoChessCardData:GetDesireInfo(arg_12_0.cardID_)

	if arg_12_0.cardID_ == 0 or not arg_12_1 then
		arg_12_0.wishStateController_:SetSelectedState("hide")
	elseif arg_12_0.cardID_ == var_12_0.CardID then
		arg_12_0.wishStateController_:SetSelectedState("heart")
	elseif AutoChessCardData:GetCardNum(arg_12_0.cardID_) <= 0 then
		arg_12_0.wishStateController_:SetSelectedState("add")
	else
		arg_12_0.wishStateController_:SetSelectedState("hide")
	end
end

function var_0_0.PlayAnim(arg_13_0)
	arg_13_0.anim_:Play("CardBaseItem", 0, 0)
end

function var_0_0.SetWishState(arg_14_0, arg_14_1)
	arg_14_0.wishStateController_:SetSelectedIndex(arg_14_1)
end

function var_0_0.SetActive(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.commonPortrait_:Dispose()
	arg_16_0.cardItem_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
