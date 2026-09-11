local ActivityAdvertiseItem = class("ActivityAdvertiseItem", ReduxView)

function ActivityAdvertiseItem:UIName()
	self.cfgID_ = ActivityAdvertiseTools.GetOpenActivityCfgIDList()[1] or ActivityAdvertiseCfg.all[#ActivityAdvertiseCfg.all]

	return ActivityAdvertiseCfg[self.cfgID_].prefab_path
end

function ActivityAdvertiseItem:Ctor(arg_2_1)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), arg_2_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.rewardItemList_ = {}

	local var_2_0 = ActivityAdvertiseData:GetDefaultPrompt()

	self.promptToggle_.isOn = var_2_0

	saveData("activityAdvertise", "prompt" .. self.cfgID_, var_2_0)
	ActivityAdvertiseData:SetOpenAdvertiseFlag(self.cfgID_, true)

	if self.cfgID_ then
		saveData("activityAdvertise", tostring(self.cfgID_), manager.time:GetServerTime())
	end

	self:RefreshUI()
	self:AddTimer()
end

function ActivityAdvertiseItem:Dispose()
	ActivityAdvertiseItem.super.Dispose(self)
	self:StopTimer()

	for iter_3_0, iter_3_1 in ipairs(self.rewardItemList_) do
		iter_3_1:Dispose()
	end

	self.rewardItemList_ = nil

	self.promptToggle_.onValueChanged:RemoveAllListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ActivityAdvertiseItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_5_0 = ActivityAdvertiseCfg[self.cfgID_].jump_system
		local var_5_1, var_5_2 = JumpTools.GetSystemLockedText(ActivityAdvertiseCfg[self.cfgID_].jump_system)
		local var_5_3 = ActivityAdvertiseCfg[self.cfgID_]

		OperationRecorder.RecordButtonTouch("homepage_jump_" .. ActivityAdvertiseCfg[self.cfgID_].activity_id)
		SDKTools.SendMessageToSDK("activity_post_trigger", {
			oper = var_5_1 and 2 or 1
		})

		if var_5_1 then
			ShowTips(var_5_2)

			return
		end

		self:Back()
		SDKTools.SendMessageToSDK("activity_publicize_page_jump", {
			opt = 1,
			activity_id = var_5_3.activity_id
		})
		JumpTools.JumpToPage2(var_5_0)
		ActivityAdvertiseTools.StopAllAdvertise()
	end)
	self.promptToggle_.onValueChanged:AddListener(function(arg_6_0)
		saveData("activityAdvertise", "prompt" .. self.cfgID_, arg_6_0)
		ActivityAdvertiseData:SetDefaultPrompt(arg_6_0)
		SDKTools.SendMessageToSDK("activity_post_shield", {
			opt = arg_6_0 and 1 or 0
		})
	end)
end

function ActivityAdvertiseItem:RefreshUI()
	for iter_7_0, iter_7_1 in ipairs(ActivityAdvertiseCfg[self.cfgID_].reward_list) do
		local var_7_0 = {
			iter_7_1,
			0
		}

		if self.rewardItemList_[iter_7_0] == nil then
			self.rewardItemList_[iter_7_0] = RewardPoolItem.New(self.rewardPanel_, var_7_0, true)

			self.rewardItemList_[iter_7_0]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			self.rewardItemList_[iter_7_0]:HideNum()
		else
			self.rewardItemList_[iter_7_0]:SetData(var_7_0)
		end
	end

	for iter_7_2 = #self.rewardItemList_, #ActivityAdvertiseCfg[self.cfgID_].reward_list + 1, -1 do
		self.rewardItemList_[iter_7_2]:Dispose()

		self.rewardItemList_[iter_7_2] = nil
	end

	if self.dlcImage_ and ActivityAdvertiseCfg[self.cfgID_].free_dlc_icon ~= "" then
		self.dlcImage_.sprite = ItemTools.getItemSprite(ActivityAdvertiseCfg[self.cfgID_].free_dlc_icon[1])
	end

	if ActivityAdvertiseCfg[self.cfgID_].new_currency_dlc_icon and ActivityAdvertiseCfg[self.cfgID_].new_currency_dlc_icon ~= "" then
		for iter_7_3, iter_7_4 in ipairs(ActivityAdvertiseCfg[self.cfgID_].new_currency_dlc_icon) do
			if self["dlcImg" .. iter_7_3 .. "_"] then
				self["dlcImg" .. iter_7_3 .. "_"].sprite = ItemTools.getItemSprite(iter_7_4[1])
			end
		end
	end
end

function ActivityAdvertiseItem:AddTimer()
	self:StopTimer()

	local var_8_0 = ActivityData:GetActivityData(ActivityAdvertiseCfg[self.cfgID_].activity_id)

	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_8_0.stopTime, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_8_0.stopTime then
			self:Back()

			return
		end

		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_8_0.stopTime, true)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityAdvertiseItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityAdvertiseItem
