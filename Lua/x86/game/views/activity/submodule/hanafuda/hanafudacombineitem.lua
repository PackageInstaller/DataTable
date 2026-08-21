local var_0_0 = class("HanafudaCombineItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.uiList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.cardList_, HanafudaCardView)
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.index_ = arg_3_1
	arg_3_0.cfg_ = arg_3_2
	arg_3_0.playerType_ = arg_3_3

	if arg_3_0.playerType_ then
		arg_3_0.cardDataList_ = HanafudaData:GetCardsListByType(arg_3_0.playerType_)
	end

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0:RefreshItem()
end

function var_0_0.RefreshItem(arg_6_0)
	local var_6_0 = arg_6_0.cfg_.card_list

	arg_6_0.nameText_.text = arg_6_0.cfg_.name
	arg_6_0.scoreText_.text = string.format(GetTips("ACTIVITY_KAGUTSUCHI_CARD_SCORE_TIPS"), arg_6_0.cfg_.score)
	arg_6_0.hasCard_ = {}

	if arg_6_0.clearGo_ then
		local var_6_1 = true

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if not HanafudaData:GetHasCardByPlaceTypeAndCardId(arg_6_0.playerType_, iter_6_1) then
				var_6_1 = false
				arg_6_0.hasCard_[iter_6_0] = false
			else
				arg_6_0.hasCard_[iter_6_0] = true
			end
		end

		SetActive(arg_6_0.clearGo_, var_6_1)
	end

	if arg_6_0.collectGo_ then
		SetActive(arg_6_0.collectGo_, HanafudaData:GetIsComplete(arg_6_0.cfg_.id))
	end

	arg_6_0.uiList_:StartScroll(#var_6_0)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, HanafudaCardCfg[arg_7_0.cfg_.card_list[arg_7_1]], arg_7_0.hasCard_[arg_7_1])
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.uiList_ then
		arg_8_0.uiList_:Dispose()

		arg_8_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
