local var_0_0 = class("HellaParkourLoseItem", ReduxView)

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

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index, true)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index = arg_6_1
	arg_6_0.parkour_activity_id = arg_6_2
	arg_6_0.itemid = arg_6_3
	arg_6_0.m_icon.sprite = ItemTools.getItemSprite(arg_6_3)

	arg_6_0:UpdateState()
end

function var_0_0.UpdateState(arg_7_0)
	local var_7_0 = ParkourData:GetParkCollect(arg_7_0.parkour_activity_id)
	local var_7_1 = ParkourData:GetCollectRedList(arg_7_0.parkour_activity_id)

	if not table.indexof(var_7_0, arg_7_0.itemid) then
		arg_7_0.stateController:SetSelectedIndex(2)
	elseif table.indexof(var_7_1, arg_7_0.itemid) then
		arg_7_0.stateController:SetSelectedIndex(1)
	else
		arg_7_0.stateController:SetSelectedIndex(0)
	end
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback_ = arg_8_1
end

function var_0_0.SetSelectedIndex(arg_9_0, arg_9_1)
	arg_9_0.selectController:SetSelectedIndex(arg_9_1 == arg_9_0.index and 1 or 0)
end

return var_0_0
