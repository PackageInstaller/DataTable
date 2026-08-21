local var_0_0 = class("TarotSignLuckyItem", ReduxView)

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

	arg_3_0.luckyDayDetailController_ = arg_3_0.accControllerEx_:GetController("luckyDayDetail")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.surprisedBtn_, nil, function()
		if arg_4_0.luckyDayDetailController_:GetSelectedState() == "show" then
			arg_4_0.luckyDayDetailController_:SetSelectedState("hide")
		else
			arg_4_0.luckyDayDetailController_:SetSelectedState("show")
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.day_ = arg_6_1
	arg_6_0.index_ = arg_6_2

	arg_6_0:RefreshUI()
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.transform_, arg_7_1)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = TarotSignTools.GetLuckyDayReward(arg_8_0.index_)

	arg_8_0.luckyDayItemImg_.sprite = ItemTools.getItemSprite(var_8_0[1])
	arg_8_0.luckyDayNumText_.text = tostring(var_8_0[2])

	local var_8_1 = TarotSignData:GetLuckyDayList()[arg_8_0.index_]
	local var_8_2 = 7 + TarotSignConst.SLIDER_LEN / 10 * var_8_1

	arg_8_0.transform_.localPosition = Vector3.New(var_8_2, arg_8_0.transform_.localPosition.y, 0)

	if TarotSignTools.GetCompleteLuckyDayIndex() >= arg_8_0.index_ then
		arg_8_0:SetActive(true)
	else
		arg_8_0:SetActive(false)
	end
end

function var_0_0.PlayEffect(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0:SetActive(true)
	end

	SetActive(arg_9_0.surprisedEff_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
