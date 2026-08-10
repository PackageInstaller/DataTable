local var_0_0 = class("PushSnowBallDeviceItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.lockController_ = ControllerUtil.GetController(arg_2_0.transform_, "lock")
	arg_2_0.equipController_ = ControllerUtil.GetController(arg_2_0.equipBtn_.transform, "isEquipped")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.index_ = arg_3_1
	arg_3_0.id_ = arg_3_2
	arg_3_0.cfg_ = PushSnowBallDeviceCfg[arg_3_2]

	manager.redPoint:bindUIandKey(arg_3_0.bgTrs_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. arg_3_0.index_)
	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.equipBtn_, nil, function()
		local var_6_0 = arg_5_0.index_ == PushSnowBallData:GetSelectedDeviceID()

		PushSnowBallAction:SendEquipDevice(PushSnowBallData:GetSingleActivityID(), var_6_0 and 0 or arg_5_0.id_)
		saveData("PushSnowBall", "Device" .. arg_5_0.id_ .. PushSnowBallData:GetActivityID() .. PlayerData:GetPlayerInfo().userID, true)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. arg_5_0.id_, 0)
	end)
end

function var_0_0.OnExit(arg_7_0)
	manager.redPoint:unbindUIandKey(arg_7_0.bgTrs_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. arg_7_0.index_)
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshItem()
	arg_8_0:RefreshState()
end

function var_0_0.RefreshItem(arg_9_0)
	arg_9_0.titleText_.text = arg_9_0.cfg_.name
	arg_9_0.descText_.text = arg_9_0.cfg_.desc
	arg_9_0.lockText_.text = ConditionCfg[arg_9_0.cfg_.condition_id].desc
	arg_9_0.powerSliderImg_.fillAmount = arg_9_0.cfg_.power_star / 5
	arg_9_0.agilitySliderImg_.fillAmount = arg_9_0.cfg_.agile_star / 5
	arg_9_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Item_l/" .. arg_9_0.cfg_.icon)
end

function var_0_0.RefreshState(arg_10_0)
	local var_10_0 = PushSnowBallData:GetIsDeviceUnlockByID(arg_10_0.cfg_.id)

	if var_10_0 then
		arg_10_0.lockController_:SetSelectedState("unlock")
	else
		arg_10_0.lockController_:SetSelectedState("lock")
	end

	local var_10_1 = arg_10_0.index_ == PushSnowBallData:GetSelectedDeviceID()

	arg_10_0.equipController_:SetSelectedState(tostring(var_10_1 and var_10_0))
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.itemList_ then
		arg_11_0.itemList_:Dispose()

		arg_11_0.itemList_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
