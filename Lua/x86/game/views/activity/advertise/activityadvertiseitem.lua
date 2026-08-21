local var_0_0 = class("ActivityAdvertiseItem", ReduxView)

function var_0_0.UIName(arg_1_0)
	arg_1_0.cfgID_ = ActivityAdvertiseTools.GetOpenActivityCfgIDList()[1] or ActivityAdvertiseCfg.all[#ActivityAdvertiseCfg.all]

	return ActivityAdvertiseCfg[arg_1_0.cfgID_].prefab_path
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load(arg_2_0:UIName()), arg_2_1.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.rewardItemList_ = {}

	local var_2_0 = ActivityAdvertiseData:GetDefaultPrompt()

	arg_2_0.promptToggle_.isOn = var_2_0

	saveData("activityAdvertise", "prompt" .. arg_2_0.cfgID_, var_2_0)
	ActivityAdvertiseData:SetOpenAdvertiseFlag(arg_2_0.cfgID_, true)

	if arg_2_0.cfgID_ then
		saveData("activityAdvertise", tostring(arg_2_0.cfgID_), manager.time:GetServerTime())
	end

	arg_2_0:RefreshUI()
	arg_2_0:AddTimer()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	arg_3_0:StopTimer()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.rewardItemList_) do
		iter_3_1:Dispose()
	end

	arg_3_0.rewardItemList_ = nil

	arg_3_0.promptToggle_.onValueChanged:RemoveAllListeners()
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		local var_5_0 = ActivityAdvertiseCfg[arg_4_0.cfgID_].jump_system
		local var_5_1, var_5_2 = JumpTools.GetSystemLockedText(var_5_0)
		local var_5_3 = ActivityAdvertiseCfg[arg_4_0.cfgID_]

		OperationRecorder.RecordButtonTouch("homepage_jump_" .. var_5_3.activity_id)
		SDKTools.SendMessageToSDK("activity_post_trigger", {
			oper = var_5_1 and 2 or 1
		})

		if var_5_1 then
			ShowTips(var_5_2)

			return
		end

		arg_4_0:Back()
		SDKTools.SendMessageToSDK("activity_publicize_page_jump", {
			opt = 1,
			activity_id = var_5_3.activity_id
		})
		JumpTools.JumpToPage2(var_5_0)
		ActivityAdvertiseTools.StopAllAdvertise()
	end)
	arg_4_0.promptToggle_.onValueChanged:AddListener(function(arg_6_0)
		saveData("activityAdvertise", "prompt" .. arg_4_0.cfgID_, arg_6_0)
		ActivityAdvertiseData:SetDefaultPrompt(arg_6_0)
		SDKTools.SendMessageToSDK("activity_post_shield", {
			opt = arg_6_0 and 1 or 0
		})
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = ActivityAdvertiseCfg[arg_7_0.cfgID_]

	for iter_7_0, iter_7_1 in ipairs(var_7_0.reward_list) do
		local var_7_1 = {
			iter_7_1,
			0
		}

		if arg_7_0.rewardItemList_[iter_7_0] == nil then
			arg_7_0.rewardItemList_[iter_7_0] = RewardPoolItem.New(arg_7_0.rewardPanel_, var_7_1, true)

			arg_7_0.rewardItemList_[iter_7_0]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			arg_7_0.rewardItemList_[iter_7_0]:HideNum()
		else
			arg_7_0.rewardItemList_[iter_7_0]:SetData(var_7_1)
		end
	end

	for iter_7_2 = #arg_7_0.rewardItemList_, #var_7_0.reward_list + 1, -1 do
		arg_7_0.rewardItemList_[iter_7_2]:Dispose()

		arg_7_0.rewardItemList_[iter_7_2] = nil
	end

	if arg_7_0.dlcImage_ and var_7_0.free_dlc_icon ~= "" then
		arg_7_0.dlcImage_.sprite = ItemTools.getItemSprite(var_7_0.free_dlc_icon[1])
	end

	if var_7_0.new_currency_dlc_icon and var_7_0.new_currency_dlc_icon ~= "" then
		for iter_7_3, iter_7_4 in ipairs(var_7_0.new_currency_dlc_icon) do
			local var_7_2 = iter_7_4[1]
			local var_7_3 = iter_7_4[2]
			local var_7_4 = arg_7_0["dlcImg" .. iter_7_3 .. "_"]

			if var_7_4 then
				var_7_4.sprite = ItemTools.getItemSprite(var_7_2)
			end
		end
	end
end

function var_0_0.AddTimer(arg_8_0)
	arg_8_0:StopTimer()

	local var_8_0 = ActivityAdvertiseCfg[arg_8_0.cfgID_].activity_id
	local var_8_1 = ActivityData:GetActivityData(var_8_0)

	arg_8_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_8_1.stopTime, true)
	arg_8_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_8_1.stopTime then
			arg_8_0:Back()

			return
		end

		arg_8_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_8_1.stopTime, true)
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

return var_0_0
