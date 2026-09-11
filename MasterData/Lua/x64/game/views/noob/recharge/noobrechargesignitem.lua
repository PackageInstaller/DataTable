local ActivityNoobUpgradeView = class("ActivityNoobUpgradeView", ReduxView)

function ActivityNoobUpgradeView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "status")
	self.rewardList_ = {}

	SetActive(self.gameObject_, true)
end

function ActivityNoobUpgradeView:AddListeners()
	return
end

function ActivityNoobUpgradeView:Dispose()
	ActivityNoobUpgradeView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	for iter_3_0, iter_3_1 in ipairs(self.rewardList_) do
		iter_3_1:Dispose()
	end

	self.rewardList_ = nil
end

function ActivityNoobUpgradeView:SetData(arg_4_1, arg_4_2)
	self.index_ = arg_4_1
	self.textDay_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), arg_4_1)
	self.textDat2_.text = "0" .. arg_4_1
	self.rewardCfg_ = {
		arg_4_2[2],
		arg_4_2[3]
	}

	for iter_4_0, iter_4_1 in ipairs(self.rewardCfg_) do
		if not self.rewardList_[iter_4_0] then
			local var_4_0 = clone(ItemTemplateData)

			var_4_0.id = iter_4_1[1]
			var_4_0.number = iter_4_1[2]

			function var_4_0:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end

			self.rewardList_[iter_4_0] = CommonItemPool.New(self.rewardPanel_, var_4_0, true)
		end
	end

	self:RefreshStatus()
end

function ActivityNoobUpgradeView:RefreshStatus()
	local var_6_0 = ActivityNewbieTools.GetFirstRechargeStatus()

	if not var_6_0.secondGearStatus then
		self.controller_:SetSelectedState("normal")
	elseif var_6_0.signTimes >= self.index_ then
		self.controller_:SetSelectedState("received")
	elseif self.index_ == var_6_0.signTimes + 1 and var_6_0.lastSignTimestamp < manager.time:GetTodayFreshTime() then
		self.controller_:SetSelectedState("complete")
	else
		self.controller_:SetSelectedState("normal")
	end
end

return ActivityNoobUpgradeView
