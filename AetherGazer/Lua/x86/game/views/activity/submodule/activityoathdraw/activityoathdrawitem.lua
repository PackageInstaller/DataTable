local var_0_0 = class("ActivityOathDrawItem", ReduxView)
local var_0_1 = {
	best = 3,
	good = 2,
	normal = 1
}
local var_0_2 = {
	[var_0_1.normal] = "UI_cookie_bg_normal",
	[var_0_1.good] = "UI_cookie_bg_good",
	[var_0_1.best] = "UI_cookie_bg_best"
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.stateController_ = arg_2_0.controller_:GetController("state")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if not arg_3_0.isOpen and arg_3_0.drawCallBack then
			arg_3_0.drawCallBack(arg_3_0.index)
		end
	end)
end

function var_0_0.Show(arg_5_0, arg_5_1)
	arg_5_0.isShow = arg_5_1

	arg_5_0.gameObject_:SetActive(arg_5_1)
end

function var_0_0.SetDrawCallBack(arg_6_0, arg_6_1)
	arg_6_0.drawCallBack = arg_6_1
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.drawData = arg_7_1

	arg_7_0:InitData()
	arg_7_0:RefreshUI()
end

function var_0_0.InitData(arg_8_0)
	arg_8_0.dropID = arg_8_0.drawData.dropID
	arg_8_0.isOpen = arg_8_0.drawData.isOpen
	arg_8_0.poolID = arg_8_0.drawData.poolID

	arg_8_0:GetQualityType(arg_8_0.dropID)
end

function var_0_0.GetIsBestReward(arg_9_0)
	return arg_9_0.qualityType == var_0_1.best
end

function var_0_0.GetQualityType(arg_10_0, arg_10_1)
	if arg_10_1 == 0 or arg_10_1 == nil then
		return
	end

	if ActivityLimitedDrawPoolCfg[arg_10_1].minimum_guarantee == 1 then
		arg_10_0.qualityType = var_0_1.normal
	else
		local var_10_0 = arg_10_0.poolID

		if ActivityLimitedDrawPoolListCfg[var_10_0].main_icon_info[1][1] == arg_10_1 then
			arg_10_0.qualityType = var_0_1.best
		else
			arg_10_0.qualityType = var_0_1.good
		end
	end
end

function var_0_0.CheckRefreshAniState(arg_11_0)
	local var_11_0 = var_0_2[arg_11_0.qualityType]

	if not arg_11_0.bgAni_:GetCurrentAnimatorStateInfo(0):IsName(var_11_0) then
		arg_11_0.bgAni_:Play(var_11_0, 0, 1)
	end
end

function var_0_0.RefreshUI(arg_12_0)
	if not arg_12_0.isOpen then
		arg_12_0.stateController_:SetSelectedState("cookie")
		arg_12_0.bgAni_:Play("UI_bg_cookie_chongzhi")
	else
		if arg_12_0.qualityType == var_0_1.normal then
			arg_12_0.stateController_:SetSelectedState("normal")
		elseif arg_12_0.qualityType == var_0_1.good then
			arg_12_0.stateController_:SetSelectedState("good")
		elseif arg_12_0.qualityType == var_0_1.best then
			arg_12_0.stateController_:SetSelectedState("best")
		end

		arg_12_0:CheckRefreshAniState()
		arg_12_0:RefreshReawrdShow(arg_12_0.dropID)
	end
end

function var_0_0.PlayOpenAni(arg_13_0, arg_13_1)
	arg_13_0:RefreshReawrdShow(arg_13_1.dropID)
	arg_13_0:GetQualityType(arg_13_1.dropID)

	local var_13_0 = var_0_2[arg_13_0.qualityType]

	arg_13_0.bgAni_:Play(var_13_0, 0, 0)
	arg_13_0:AddOpenAniTimer(arg_13_1)
end

function var_0_0.DelOpenAniTimer(arg_14_0)
	if arg_14_0.openAniTimer_ then
		arg_14_0.openAniTimer_:Stop()

		arg_14_0.openAniTimer_ = nil
	end
end

function var_0_0.AddOpenAniTimer(arg_15_0, arg_15_1)
	arg_15_0:DelOpenAniTimer()

	arg_15_0.openAniTimer_ = Timer.New(function()
		local var_16_0 = arg_15_0.bgAni_:GetCurrentAnimatorStateInfo(0)
		local var_16_1 = var_0_2[arg_15_0.qualityType]

		if var_16_0:IsName(var_16_1) and var_16_0.normalizedTime >= 0.8 then
			arg_15_0:DelOpenAniTimer()
			arg_15_0:SetData(arg_15_1)
		end
	end, 0.1, -1)

	arg_15_0.openAniTimer_:Start()
end

function var_0_0.IsFinishOpenAni(arg_17_0)
	local var_17_0 = arg_17_0.bgAni_:GetCurrentAnimatorStateInfo(0)
	local var_17_1 = var_0_2[arg_17_0.qualityType]

	return var_17_0:IsName(var_17_1) and var_17_0.normalizedTime >= 1.2
end

function var_0_0.IsCanOpenNext(arg_18_0)
	local var_18_0 = arg_18_0.bgAni_:GetCurrentAnimatorStateInfo(0)
	local var_18_1 = var_0_2[arg_18_0.qualityType]

	return var_18_0:IsName(var_18_1) and var_18_0.normalizedTime >= 0.35
end

function var_0_0.PlayCloseAni(arg_19_0)
	arg_19_0.stateController_:SetSelectedState("cookie")
	arg_19_0.bgAni_:Play("UI_bg_cookie_fanpai_01", 0, 0)
end

function var_0_0.IsFinishCloseAni(arg_20_0)
	local var_20_0 = arg_20_0.bgAni_:GetCurrentAnimatorStateInfo(0)

	return var_20_0:IsName("UI_bg_cookie_chongzhi") or var_20_0:IsName("UI_bg_cookie_fanpai_01") and var_20_0.normalizedTime >= 1
end

function var_0_0.RefreshReawrdShow(arg_21_0, arg_21_1)
	if arg_21_0.rewardItem_ == nil then
		arg_21_0.rewardItem_ = CommonItemView.New(arg_21_0.itemGo_, true)
	end

	local var_21_0 = clone(ItemTemplateData)
	local var_21_1 = ActivityLimitedDrawPoolCfg[arg_21_1].reward[1]

	var_21_0.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL
	var_21_0.id = var_21_1[1]
	var_21_0.number = var_21_1[2]

	function var_21_0.clickFun()
		ShowPopItem(POP_ITEM, {
			var_21_0.id
		})
	end

	arg_21_0.rewardItem_:SetData(var_21_0)
	arg_21_0.rewardItem_:Show(true)
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:DelOpenAniTimer()

	if arg_23_0.rewardItem_ then
		arg_23_0.rewardItem_:Dispose()

		arg_23_0.rewardItem_ = nil
	end

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
