ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SevenDaySkinPage_3_6 = class("SevenDaySkinPage_3_6", ActivityMainBasePanel)

function SevenDaySkinPage_3_6:GetUIName()
	return ActivityCumulativeSignCfg[self.activityID_].ui_path
end

function SevenDaySkinPage_3_6:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SevenDaySkinPage_3_6:InitUI()
	self:BindCfgUI()

	self.items_ = {}
	self.maxDay_ = SevenDaySkinData_New:MaxSignDay(self.activityID_)

	for iter_3_0 = 1, self.maxDay_ do
		self.items_[iter_3_0] = SevenDaySkinItem_3_6.New(self["btn_" .. iter_3_0], ActivityCumulativeSignCfg[self.activityID_].config_list[iter_3_0], iter_3_0)

		self.items_[iter_3_0]:RegisterClickFunc(function(arg_4_0, arg_4_1)
			self:OnBtnSignClick(arg_4_0, arg_4_1)
		end)
	end

	self.onSignHandler = handler(self, self.OnSignSuccess)
	self.onClearHandler = handler(self, self.OnClearSuccess)
end

function SevenDaySkinPage_3_6:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_3_6_SIGN_INSTRUSCTIONS")
		})
	end)
end

function SevenDaySkinPage_3_6:OnEnter()
	SevenDaySkinPage_3_6.super.OnEnter(self)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)

	self.crossDay_ = false
	self.data_ = SevenDaySkinData_New:GetActivityData(self.activityID_)

	self:RefreshView()
end

function SevenDaySkinPage_3_6:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

function SevenDaySkinPage_3_6:RefreshView()
	self.descText_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].desc
	self.titleTxt_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name

	self:RefreshItems()
end

function SevenDaySkinPage_3_6:RefreshItems()
	self.data_ = SevenDaySkinData_New:GetActivityData(self.activityID_)

	local var_10_0 = self.data_:SignRewardList()
	local var_10_1 = self.data_.gain_reward
	local var_10_2 = #self.data_.unlock_reward + #self.data_.gain_reward
	local var_10_3 = self.data_:ReSignNum()
	local var_10_4 = var_10_3 + (#self.data_.unlock_reward + #self.data_.gain_reward)

	for iter_10_0 = 1, self.maxDay_ do
		self.items_[iter_10_0]:RefreshView(var_10_0[iter_10_0], iter_10_0 <= var_10_2 and 1 or 0, iter_10_0 == var_10_2 + 1 and var_10_3 > 0 and true or false, var_10_4)
		self.items_[iter_10_0]:RefreshGet(var_10_1)
	end
end

function SevenDaySkinPage_3_6:OnBtnSignClick(arg_11_1, arg_11_2)
	local var_11_0 = {}

	table.insert(var_11_0, arg_11_1)

	if arg_11_2 then
		self:ShowCheckDialog(arg_11_1)
	else
		SevenDaySkinAction_New.ReqSign(self.activityID_, var_11_0)
	end
end

function SevenDaySkinPage_3_6:ShowCheckDialog(arg_12_1)
	local var_12_0 = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2]
	local var_12_1 = CurrencyData:GetCurrencyNum(ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1])

	JumpTools.OpenPageByJump("popCostItem", {
		costId = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1],
		costCount = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2],
		content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1]), ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2], GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN")),
		popCostCallBack = function()
			local var_13_0, var_13_1 = ActivityData:GetActivityTime(self.activityID_)

			if var_13_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif self.crossDay_ then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				self.crossDay_ = false
			elseif var_12_1 < var_12_0 then
				ShopTools.DefaultOpenPopUp(var_12_0 - var_12_1)
			else
				SevenDaySkinAction_New.ReqReSign(self.activityID_, arg_12_1)
			end
		end
	})
end

function SevenDaySkinPage_3_6:OnSignSuccess(arg_14_1)
	if arg_14_1.rewards[1].convert_from.id and arg_14_1.rewards[1].convert_from.id > 0 then
		if ItemCfg[arg_14_1.rewards[1].convert_from.id] and ItemCfg[arg_14_1.rewards[1].convert_from.id].type == ItemConst.ITEM_TYPE.HERO then
			getReward(formatRewardCfgList({
				arg_14_1.rewards[1]
			}))
		end
	elseif ItemCfg[arg_14_1.rewards[1].id] and ItemCfg[arg_14_1.rewards[1].id].type == ItemConst.ITEM_TYPE.HERO then
		getReward(formatRewardCfgList({
			arg_14_1.rewards[1]
		}))
	else
		getReward(formatRewardCfgList({
			arg_14_1.rewards[1]
		}))
	end

	self:RefreshView()

	self.crossDay_ = false
end

function SevenDaySkinPage_3_6:OnClearSuccess()
	self:RefreshView()

	self.crossDay_ = true
end

function SevenDaySkinPage_3_6:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SevenDaySkinPage_3_6:OnTop()
	self:UpdateBar()
end

function SevenDaySkinPage_3_6:OnExit()
	SevenDaySkinPage_3_6.super.OnExit(self)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
end

function SevenDaySkinPage_3_6:Dispose()
	self:RemoveAllListeners()

	for iter_19_0 = 1, #self.items_ do
		self.items_[iter_19_0]:Dispose()
	end

	SevenDaySkinPage_3_6.super.Dispose(self)
end

return SevenDaySkinPage_3_6
