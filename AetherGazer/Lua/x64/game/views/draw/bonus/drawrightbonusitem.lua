local var_0_0 = class("DrawRightBonusItem", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/ExtractReturnBtnNew"
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load(arg_2_0:UIName()), arg_2_1.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.controller_ = arg_2_0.controllerEx_:GetController("state")
	arg_2_0.colorController_ = arg_2_0.controllerEx_:GetController("color")
	arg_2_0.onModifyBonusHandler_ = handler(arg_2_0, arg_2_0.OnModifyBonus)
end

function var_0_0.OnEnter(arg_3_0)
	manager.notify:RegistListener(UPDATE_ACTIVITY_POOL_BONUS, arg_3_0.onModifyBonusHandler_)
end

function var_0_0.OnExit(arg_4_0)
	manager.notify:RemoveListener(UPDATE_ACTIVITY_POOL_BONUS, arg_4_0.onModifyBonusHandler_)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.onModifyBonusHandler_ = nil

	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.gameObject_ = nil
	arg_5_0.transfrom_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		local var_7_0 = arg_6_0.activityID_

		if DrawTools.GetBonusCnt(var_7_0) > 0 then
			DrawAction.ReceivePoolBonus(var_7_0, function()
				arg_6_0:RefreshText()
			end)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.infoBtn_, nil, function()
		DrawAction.GetPoolData(arg_6_0.selectPoolID_)
	end)
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.activityID_ = arg_10_1
	arg_10_0.selectPoolID_ = arg_10_2

	local var_10_0 = ActivityDrawBonusCfg[arg_10_1]
	local var_10_1 = var_10_0.reward[1][1]

	ItemTools.GetItemSpriteAsync(var_10_1, function(arg_11_0, arg_11_1)
		if arg_10_0.gameObject_ == nil then
			return
		end

		if arg_11_0 == var_10_1 then
			arg_10_0.icon_.sprite = arg_11_1
		end
	end, nil, true)

	arg_10_0.needNumText_.text = string.format("/%s", var_10_0.need)

	arg_10_0.anim_:Play("UI_ExtractReturnBtn_cx", 0, 0)
	arg_10_0.anim_:Update(0)
	arg_10_0:RefreshText()
end

function var_0_0.RefreshText(arg_12_0)
	local var_12_0 = arg_12_0.activityID_

	arg_12_0.curOldNumText_.text = DrawData:GetOldPoolBonus(var_12_0)
	arg_12_0.curNumText_.text = DrawData:GetPoolBonus(var_12_0)

	arg_12_0.animator_:Play("UI_num_cx", 0, 1)
	arg_12_0.animator2_:Play("UI_text_cx", 0, 1)

	local var_12_1 = DrawTools.GetBonusCnt(var_12_0)

	if var_12_1 == 0 then
		var_12_1 = ActivityDrawBonusCfg[var_12_0].reward[1][2]

		arg_12_0.controller_:SetSelectedState("normal")
		arg_12_0.colorController_:SetSelectedState("normal")
	else
		arg_12_0.controller_:SetSelectedState("claimable")
		arg_12_0.colorController_:SetSelectedState("orange")
	end

	arg_12_0.bonusText1_.text = string.format("x%s", var_12_1)
	arg_12_0.bonusText2_.text = string.format("x%s", var_12_1)

	local var_12_2 = ActivityData:GetActivityData(arg_12_0.activityID_)

	arg_12_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_12_2.stopTime)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.timeTrs_)
	arg_12_0:Show(true)
end

function var_0_0.PrePlayAnimator(arg_13_0)
	local var_13_0 = arg_13_0.activityID_
	local var_13_1 = DrawData:GetOldPoolBonus(var_13_0)
	local var_13_2 = DrawData:GetPoolBonus(var_13_0)
	local var_13_3 = ActivityDrawBonusCfg[var_13_0].need
	local var_13_4 = math.floor(var_13_1 / var_13_3)

	if math.floor(var_13_2 / var_13_3) > 0 then
		arg_13_0.animator2_:Play("UI_text_cx", 0, 0)
		arg_13_0.animator2_:Update(0)
		arg_13_0.colorController_:SetSelectedState("orange")
	else
		arg_13_0.colorController_:SetSelectedState("normal")
	end
end

function var_0_0.PlayAnimator(arg_14_0)
	local var_14_0 = arg_14_0.activityID_
	local var_14_1 = DrawData:GetOldPoolBonus(var_14_0)
	local var_14_2 = DrawData:GetPoolBonus(var_14_0)
	local var_14_3 = ActivityDrawBonusCfg[var_14_0].need
	local var_14_4 = math.floor(var_14_1 / var_14_3)
	local var_14_5 = math.floor(var_14_2 / var_14_3) > 0

	if var_14_1 ~= var_14_2 then
		arg_14_0.curNumText_.text = var_14_2
		arg_14_0.curOldNumText_.text = var_14_1

		arg_14_0.animator_:Play("UI_num_cx", 0, 0)
		arg_14_0.animator_:Update(0)

		if var_14_5 then
			arg_14_0.animator2_:Play("UI_text_cx", 0, 0)
			arg_14_0.animator2_:Update(0)
		else
			arg_14_0.animator2_:Play("UI_text_cx", 0, 1)
			arg_14_0.animator2_:Update(0)
		end

		DrawData:SetOldPoolBonus(var_14_0, var_14_2)
	else
		arg_14_0.animator_:Play("UI_num_cx", 0, 1)
		arg_14_0.animator2_:Play("UI_text_cx", 0, 1)
		arg_14_0.animator2_:Update(0)
	end
end

function var_0_0.OnModifyBonus(arg_15_0)
	arg_15_0:RefreshText()
end

function var_0_0.Show(arg_16_0, arg_16_1)
	SetActive(arg_16_0.gameObject_, arg_16_1)
end

return var_0_0
