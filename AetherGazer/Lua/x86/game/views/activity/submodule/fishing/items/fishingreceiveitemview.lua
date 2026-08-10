local var_0_0 = class("FishingReceiveItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.fishIcon_ = FishIcon.New(arg_3_0.fishIconGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		FishingAction.GetFriendsFish(ActivityConst.SUMMER_FISHING, arg_4_0.data_.giver_id, arg_4_0.data_.timestamp)
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_8_0)
	return
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	arg_9_0.data_ = arg_9_1

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.playerNameLabel_.text = GetI18NText(arg_10_0.data_.giver_nick)
	arg_10_0.playerHeadIcon_.sprite = ItemTools.getItemSprite(arg_10_0.data_.giver_icon)

	arg_10_0.fishIcon_:SetId(arg_10_0.data_.fish_id, 1)
end

function var_0_0.OnEnter(arg_11_0)
	return
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllEventListener()

	if arg_14_0.fishIcon_ then
		arg_14_0.fishIcon_:Dispose()

		arg_14_0.fishIcon_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
