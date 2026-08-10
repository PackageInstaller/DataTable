local var_0_0 = class("SevenDaySignItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.info_ = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.animator_ = arg_2_0.receivedpanelGo_:GetComponent(typeof(Animator))

	if arg_2_0.newItemGo_ then
		arg_2_0.commonItem_ = CommonItemView.New(arg_2_0.newItemGo_, true)
	else
		arg_2_0.commonItem_ = CommonItem.New(arg_2_0.commonitemGo_)

		arg_2_0.commonItem_:RegistCallBack(function(arg_3_0)
			ShowPopItem(POP_ITEM, {
				arg_3_0.id,
				arg_3_0.number
			})
			OperationRecorder.Record(arg_2_0.class.__cname, "signItem")
		end)
		arg_2_0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
	end
end

function var_0_0.Refresh(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = SignCfg[arg_4_2]

	if arg_4_0.newItemGo_ then
		local var_4_1 = clone(ItemTemplateData)

		if var_4_0.show_reward ~= nil and type(var_4_0.show_reward) == "table" and var_4_0.show_reward ~= "" then
			var_4_1.id = var_4_0.show_reward[1]
			var_4_1.number = var_4_0.show_reward[2]
		else
			var_4_1.id = var_4_0.reward[1]
			var_4_1.number = var_4_0.reward[2]
		end

		function var_4_1.clickFun(arg_5_0)
			ShowPopItem(POP_ITEM, {
				arg_5_0.id,
				arg_5_0.number
			})
			OperationRecorder.Record(arg_4_0.class.__cname, "signItem")
		end

		arg_4_0.commonItem_:SetData(var_4_1)
	elseif var_4_0.show_reward ~= nil and type(var_4_0.show_reward) == "table" and var_4_0.show_reward ~= "" then
		arg_4_0.commonItem_:RefreshData(formatReward(var_4_0.show_reward))
	else
		arg_4_0.commonItem_:RefreshData(formatReward(var_4_0.reward))
	end

	local var_4_2 = var_4_0.reward[1]
	local var_4_3 = arg_4_3

	if var_4_3 == ActivityConst.SIGN_STATE.NONE then
		SetActive(arg_4_0.receivedpanelGo_, false)
	elseif var_4_3 == ActivityConst.SIGN_STATE.CAN_GET then
		SetActive(arg_4_0.receivedpanelGo_, false)
	elseif var_4_3 == ActivityConst.SIGN_STATE.GETTED then
		SetActive(arg_4_0.receivedpanelGo_, true)
	elseif var_4_3 == ActivityConst.SIGN_STATE.TOMORROW_GET then
		SetActive(arg_4_0.receivedpanelGo_, false)
	end

	arg_4_0.dayText_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), arg_4_1)

	local var_4_4 = arg_4_1 == 7 or arg_4_1 == 14

	if arg_4_4 and arg_4_1 == 7 then
		var_4_4 = false
	end

	SetActive(arg_4_0.speciaBg_, var_4_4)

	arg_4_0.index = arg_4_1
end

function var_0_0.StartPlayAnimator(arg_6_0)
	arg_6_0.timer_ = Timer.New(function()
		SetActive(arg_6_0.receivedpanelGo_, true)

		arg_6_0.animator_.enabled = true

		manager.audio:PlayUIAudioByVoice("sign_in")

		if arg_6_0.timer_ then
			arg_6_0.timer_:Stop()

			arg_6_0.timer_ = nil
		end
	end, 0.5, 1)

	arg_6_0.timer_:Start()
end

function var_0_0.GetAnimator(arg_8_0)
	return arg_8_0.animator_
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.animator_ = nil

	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end

	arg_9_0.commonItem_:Dispose()

	arg_9_0.commonItem_ = nil
	arg_9_0.transform_ = nil
	arg_9_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
