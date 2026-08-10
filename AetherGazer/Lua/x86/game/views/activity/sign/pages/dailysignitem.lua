local var_0_0 = class("DailySignItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.data_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.animator_ = nil

	if arg_3_0.timer_ then
		arg_3_0.timer_:Stop()

		arg_3_0.timer_ = nil
	end

	arg_3_0.commonItem_:Dispose()

	arg_3_0.commonItem_ = nil
	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.animator_ = arg_4_0.receivedpanelGo_:GetComponent(typeof(Animator))
	arg_4_0.commonItem_ = CommonItemView.New(arg_4_0.commonitemGo_)
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.info_ = arg_6_1

	arg_6_0:RefreshItem()
	arg_6_0:RefreshReceiveState()
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.RefreshItem(arg_7_0)
	local var_7_0 = 0

	if arg_7_0.info_.month then
		var_7_0 = SignCfg.get_id_list_by_month[arg_7_0.info_.month][arg_7_0.info_.day]
	else
		var_7_0 = arg_7_0.info_.day
	end

	local var_7_1 = SignCfg[var_7_0].reward
	local var_7_2 = clone(ItemTemplateData)

	var_7_2.id = var_7_1[1]
	var_7_2.number = var_7_1[2]

	function var_7_2.clickFun(arg_8_0)
		ShowPopItem(POP_ITEM, {
			arg_8_0.id,
			arg_8_0.number
		})
		OperationRecorder.Record(arg_7_0.class.__cname, "signItem")
	end

	arg_7_0.commonItem_:SetData(var_7_2)
end

function var_0_0.RefreshReceiveState(arg_9_0)
	local var_9_0 = arg_9_0.info_.state

	if var_9_0 == ActivityConst.SIGN_STATE.NONE then
		SetActive(arg_9_0.receivedpanelGo_, false)
	elseif var_9_0 == ActivityConst.SIGN_STATE.CAN_GET then
		SetActive(arg_9_0.receivedpanelGo_, false)
	elseif var_9_0 == ActivityConst.SIGN_STATE.GETTED then
		SetActive(arg_9_0.receivedpanelGo_, true)
	elseif var_9_0 == ActivityConst.SIGN_STATE.TOMORROW_GET then
		SetActive(arg_9_0.receivedpanelGo_, false)
	end
end

function var_0_0.StartPlayAnimator(arg_10_0)
	arg_10_0.timer_ = Timer.New(function()
		SetActive(arg_10_0.receivedpanelGo_, true)

		arg_10_0.animator_.enabled = true

		manager.audio:PlayUIAudioByVoice("sign_in")

		if arg_10_0.timer_ then
			arg_10_0.timer_:Stop()

			arg_10_0.timer_ = nil
		end
	end, 0.5, 1)

	arg_10_0.timer_:Start()
end

function var_0_0.GetAnimator(arg_12_0)
	return arg_12_0.animator_
end

return var_0_0
