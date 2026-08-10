local var_0_0 = class("DormLinkGameBubbleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_3)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.customerID = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.materialScroll = LuaList.New(handler(arg_2_0, arg_2_0.indexMaterialList), arg_2_0.uilistGo_, DormLinkGameMaterialItem)

	arg_2_0:InitSatiety()
	arg_2_0:RefreshSatiety()

	arg_2_0.animator = arg_2_0.bubbleGo_:GetComponent("Animation")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.InitSatiety(arg_4_0)
	local var_4_0 = ActivityLinkGameCustomerCfg[arg_4_0.customerID].satiety_limit[2]
	local var_4_1 = ActivityLinkGameCustomerCfg[arg_4_0.customerID].satiety_limit[1]

	arg_4_0.slider.minValue = var_4_1
	arg_4_0.slider.maxValue = var_4_0

	local var_4_2 = ActivityLinkGameCustomerCfg[arg_4_0.customerID].satiety_score_up[2][2][1]
	local var_4_3 = ActivityLinkGameCustomerCfg[arg_4_0.customerID].satiety_score_up[3][2][1]

	arg_4_0.image2Img_.fillAmount = (var_4_0 - var_4_3) / var_4_0
	arg_4_0.image1Img_.fillAmount = (var_4_0 - var_4_2) / var_4_0

	arg_4_0:RefreshSatiety()
end

function var_0_0.RefreshBubbleInfo(arg_5_0, arg_5_1)
	arg_5_0.foodID = DormLinkGameData:GetCustomerInfo(arg_5_0.customerID).curPreference
	arg_5_0.materilaList = ActivityLinkGameComposeCfg[arg_5_0.foodID].compose_list

	arg_5_0.materialScroll:StartScroll(#arg_5_0.materilaList)

	if arg_5_1 then
		arg_5_0.animator:Play()
	end
end

function var_0_0.RefreshSatiety(arg_6_0)
	local var_6_0 = DormLinkGameData:GetCustomerInfo(arg_6_0.customerID)

	arg_6_0.slider.value = var_6_0.satietyNum
end

function var_0_0.RefreshTransPosition(arg_7_0)
	DormLinkGameData:GetCustomerInfo(arg_7_0.customerID):RefreshCustomerBubble(arg_7_0.transform_)
end

function var_0_0.indexMaterialList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_0.materilaList[arg_8_1])
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	arg_9_0.gameObject_:SetActive(arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.materialScroll then
		arg_10_0.materialScroll:Dispose()

		arg_10_0.materialScroll = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
