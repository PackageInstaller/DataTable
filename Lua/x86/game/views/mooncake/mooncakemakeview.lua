local var_0_0 = class("MoonCakeMakeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeMakeUI"
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

	arg_4_0.statusController_ = ControllerUtil.GetController(arg_4_0.transform_, "status")
	arg_4_0.failController_ = ControllerUtil.GetController(arg_4_0.transform_, "fail")
	arg_4_0.fillingItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scrollView_, MoonCakeItem)
	arg_4_0.clickFillingHandler_ = handler(arg_4_0, arg_4_0.OnClickFilling)
	arg_4_0.clickModelHandler_ = handler(arg_4_0, arg_4_0.OnClickModel)
	arg_4_0.modelList_ = {}

	local var_4_0 = arg_4_0.modelContentTrans_.childCount

	for iter_4_0 = 1, var_4_0 do
		local var_4_1 = arg_4_0.modelContentTrans_:GetChild(iter_4_0 - 1).gameObject

		arg_4_0.modelList_[iter_4_0] = MoonCakeItem.New(var_4_1)

		arg_4_0.modelList_[iter_4_0]:SetType(MoonCakeConst.ITEM_STYLE.NONE)
		arg_4_0.modelList_[iter_4_0]:SetData(nil, iter_4_0, true)
		arg_4_0.modelList_[iter_4_0]:SetClickHandler(arg_4_0.clickModelHandler_)
	end

	arg_4_0.originCircleRotateion_ = arg_4_0.circle_.localRotation
	arg_4_0.originArrowRotatetion_ = arg_4_0.arror_.localRotation
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		if arg_5_0.startMake_ == true then
			return
		end

		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.makeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		arg_5_0.startMake_ = true

		arg_5_0:SwitchToMake()
		arg_5_0:StartQTE()
	end)
	arg_5_0:AddBtnListener(arg_5_0.qteConfirmBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		arg_5_0.startMake_ = false

		arg_5_0:EndQTE()
	end)
	arg_5_0:AddBtnListener(arg_5_0.resultConfirmBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.curFillingID_ then
			arg_5_0:SwitchToChose()
		else
			arg_5_0:SwitchToPrepare()
		end
	end)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.fillingItemList_:Dispose()

	arg_10_0.fillingItemList_ = nil

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.modelList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.modelList_ = nil
	arg_10_0.clickFillingHandler_ = nil
	arg_10_0.clickModelHandler_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityID_ = arg_11_0.params_.activityID
	arg_11_0.startMake_ = false

	arg_11_0:SwitchToPrepare()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0.status_ = nil

	AnimatorTools.Stop()
end

function var_0_0.SwitchToPrepare(arg_13_0)
	arg_13_0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.PREPARE)
	arg_13_0:RefreshResource()

	arg_13_0.curFillingID_ = nil
	arg_13_0.curFillingItem_ = nil
	arg_13_0.curModelID_ = nil
end

function var_0_0.SwitchToChose(arg_14_0)
	arg_14_0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.CHOSE)

	arg_14_0.targetCakeID_ = MoonCakeTools.GetCakeRecipeDic(arg_14_0.activityID_)[arg_14_0.curFillingID_][arg_14_0.curModelID_]

	local var_14_0 = MoonCakeCfg[arg_14_0.targetCakeID_].moon_cakes

	arg_14_0.cakeIcon_.sprite = ItemTools.getItemSprite(var_14_0)
end

function var_0_0.SwitchToMake(arg_15_0)
	arg_15_0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.MAKE)
end

function var_0_0.SwitchToQTEResult(arg_16_0)
	arg_16_0.startMake_ = false

	if arg_16_0.curQteResult_ == true then
		arg_16_0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.SUCCESS)

		arg_16_0.cakeIcon_.sprite = ItemTools.getItemSprite(arg_16_0.resultItemID_)
	else
		arg_16_0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.FAIL)

		if arg_16_0.resultItemID_ == 0 then
			arg_16_0.failController_:SetSelectedState("true")
		else
			arg_16_0.failController_:SetSelectedState("false")

			arg_16_0.cakeIcon_.sprite = ItemTools.getItemSprite(arg_16_0.resultItemID_)
		end
	end

	SetActive(arg_16_0.maskGo_, true)

	local var_16_0
	local var_16_1 = arg_16_0.curQteResult_ == true and "Fx_successPanel_cx" or "Fx_failPanel_cx"

	if arg_16_0.resultItemID_ ~= 0 then
		AnimatorTools.PlayAnimatorWithCallback(arg_16_0.qteResultAnim_, var_16_1, function()
			local var_17_0 = {
				{
					arg_16_0.resultItemID_,
					1
				}
			}

			showRewardUI(var_17_0)
			SetActive(arg_16_0.maskGo_, false)
		end, false)
	else
		arg_16_0.qteResultAnim_:Play(var_16_1, -1, 0)
		arg_16_0.qteResultAnim_:Update(0)
	end
end

function var_0_0.IndexItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.fillingIdList_[arg_18_1]
	local var_18_1 = MoonCakeFillingCfg[var_18_0].patties

	arg_18_2:SetData(var_18_1, var_18_0)
	arg_18_2:SetType(MoonCakeConst.ITEM_STYLE.NORMAL)
	arg_18_2:SetClickHandler(arg_18_0.clickFillingHandler_)
end

function var_0_0.RefreshResource(arg_19_0)
	arg_19_0.fillingIdList_ = MoonCakeFillingCfg.get_id_list_by_activity[arg_19_0.activityID_]

	arg_19_0.fillingItemList_:StartScroll(#arg_19_0.fillingIdList_)

	local var_19_0 = arg_19_0.fillingItemList_:GetItemList()

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		iter_19_1:SetSelect(nil)
	end

	for iter_19_2, iter_19_3 in ipairs(arg_19_0.modelList_) do
		iter_19_3:SetSelect(nil)
	end
end

function var_0_0.RefreshTargetCake(arg_20_0)
	if arg_20_0.curFillingID_ ~= nil and arg_20_0.curModelID_ ~= nil then
		arg_20_0.targetCakeID_ = MoonCakeTools.GetCakeRecipeDic(arg_20_0.activityID_)[arg_20_0.curFillingID_][arg_20_0.curModelID_]

		local var_20_0 = MoonCakeCfg[arg_20_0.targetCakeID_].moon_cakes

		arg_20_0.cakeIcon_.sprite = ItemTools.getItemSprite(var_20_0)
	end
end

function var_0_0.OnClickFilling(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = MoonCakeFillingCfg[arg_21_1].patties

	if ItemTools.getItemNum(var_21_0) <= 0 then
		ShowTips("MID_AUTUMN_FESTIVAL_MOONCAKE_MAKING_INSUFFICIENT_RAW_MATERIALS")

		return
	end

	arg_21_0.curFillingID_ = arg_21_1
	arg_21_0.curFillingItem_ = arg_21_2

	local var_21_1 = arg_21_0.fillingItemList_:GetItemList()

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		iter_21_1:SetSelect(arg_21_1)
	end

	if arg_21_0.curFillingID_ ~= nil and arg_21_0.curModelID_ ~= nil then
		arg_21_0:SwitchToChose()
	end
end

function var_0_0.OnClickModel(arg_22_0, arg_22_1)
	arg_22_0.curModelID_ = arg_22_1

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.modelList_) do
		iter_22_1:SetSelect(arg_22_1)
	end

	if arg_22_0.curFillingID_ ~= nil and arg_22_0.curModelID_ ~= nil then
		arg_22_0:SwitchToChose()
	end
end

function var_0_0.OnMakeCakeResult(arg_23_0, arg_23_1)
	arg_23_0.resultItemID_ = arg_23_1

	arg_23_0.curFillingItem_:RefreshNum()

	local var_23_0 = MoonCakeFillingCfg[arg_23_0.curFillingID_].patties

	if ItemTools.getItemNum(var_23_0) <= 0 then
		arg_23_0.curFillingItem_:SetSelect(nil)

		arg_23_0.curFillingID_ = nil
		arg_23_0.curFillingItem_ = nil
	end

	arg_23_0:SwitchToQTEResult()
	arg_23_0:ResetQTE()
end

function var_0_0.ResetQTE(arg_24_0)
	arg_24_0.circle_.localRotation = arg_24_0.originCircleRotateion_
	arg_24_0.arror_.localRotation = arg_24_0.originArrowRotatetion_
	arg_24_0.countDownProgress_.fillAmount = 1
end

function var_0_0.InitQTE(arg_25_0)
	arg_25_0.tagretAngle_ = arg_25_0:RandomAngle()
	arg_25_0.circle_.localRotation = Quaternion.Euler(0, 0, arg_25_0.tagretAngle_)
	arg_25_0.countDownProgress_.fillAmount = 1
end

function var_0_0.StartQTE(arg_26_0)
	arg_26_0:InitQTE()
	arg_26_0:RemoveTween()
	arg_26_0:DoTween(arg_26_0.tagretAngle_)
end

function var_0_0.DoTween(arg_27_0, arg_27_1)
	arg_27_0.tagretAngle_ = arg_27_1
	arg_27_0.circle_.localRotation = Quaternion.Euler(0, 0, arg_27_0.tagretAngle_)

	local var_27_0 = arg_27_0.arror_.localEulerAngles.z

	arg_27_0.countDownProgress_.transform.localRotation = Quaternion.Euler(0, 0, var_27_0)
	arg_27_0.tween = LeanTween.rotateAroundLocal(arg_27_0.arror_.gameObject, Vector3.New(0, 0, -1), 360, 2):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
		arg_27_0.countDownProgress_.fillAmount = (360 - arg_28_0) / 360
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_27_0:RemoveTween()
		arg_27_0:GoToResult(false)
	end))
end

function var_0_0.EndQTE(arg_30_0)
	local var_30_0 = (arg_30_0.arror_.localEulerAngles.z + 360) % 360
	local var_30_1 = (arg_30_0.tagretAngle_ + 360 - var_30_0) % 360

	if var_30_1 <= 35 or var_30_1 >= 325 then
		if var_30_1 <= 15 or var_30_1 >= 345 then
			arg_30_0:RemoveTween()
			arg_30_0:GoToResult(true)
		else
			local var_30_2 = arg_30_0:RandomAngle()

			arg_30_0:RemoveTween()
			arg_30_0:DoTween(var_30_2)
		end
	else
		arg_30_0:RemoveTween()
		arg_30_0:GoToResult(false)
	end
end

function var_0_0.GoToResult(arg_31_0, arg_31_1)
	arg_31_0.curQteResult_ = arg_31_1

	MoonCakeAction.MoonCakeMakeResult(arg_31_0.activityID_, arg_31_0.targetCakeID_, arg_31_0.curQteResult_)
end

function var_0_0.RemoveTween(arg_32_0)
	if arg_32_0.tween then
		arg_32_0.tween:setOnComplete(nil)
		LeanTween.cancel(arg_32_0.arror_.gameObject)

		arg_32_0.tween = nil
	end
end

function var_0_0.RandomAngle(arg_33_0)
	return -((-arg_33_0.arror_.localEulerAngles.z + 360) % 360 + math.random(120, 300)) % 360
end

return var_0_0
