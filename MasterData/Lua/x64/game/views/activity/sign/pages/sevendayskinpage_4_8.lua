ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SevenDaySkinPage_4_8 = class("SevenDaySkinPage_4_8", ActivityMainBasePanel)

function SevenDaySkinPage_4_8:GetUIName()
	return ActivityCumulativeSignCfg[self.activityID_].ui_path
end

function SevenDaySkinPage_4_8:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SevenDaySkinPage_4_8:InitUI()
	self:BindCfgUI()

	self.items_ = {}
	self.maxDay_ = SevenDaySkinData_New:MaxSignDay(self.activityID_)

	for iter_3_0 = 1, self.maxDay_ do
		self.items_[iter_3_0] = SevenDaySkinItem_4_8.New(self["btn_" .. iter_3_0], ActivityCumulativeSignCfg[self.activityID_].config_list[iter_3_0], iter_3_0)

		self.items_[iter_3_0]:RegisterClickFunc(function(arg_4_0, arg_4_1)
			self:OnBtnSignClick(arg_4_0, arg_4_1)
		end)
	end

	self.onSignHandler = handler(self, self.OnSignSuccess)
	self.onClearHandler = handler(self, self.OnClearSuccess)
end

function SevenDaySkinPage_4_8:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_3_6_SIGN_INSTRUSCTIONS")
		})
	end)
end

function SevenDaySkinPage_4_8:OnEnter()
	SevenDaySkinPage_4_8.super.OnEnter(self)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	self:BindRedPoint()

	self.crossDay_ = false

	self:RefreshView()
end

function SevenDaySkinPage_4_8:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

function SevenDaySkinPage_4_8:RefreshView()
	self.data_ = SevenDaySkinData_New:GetActivityData(self.activityID_)

	if not self.itemData_ then
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	end

	local var_9_2 = ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]

	self.descText_.text = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].desc)
	self.titleTxt_.text = GetI18NText(ActivityToggleCfg[var_9_2].name)

	self:RefreshItems()
end

function SevenDaySkinPage_4_8:RefreshItems()
	self.data_ = SevenDaySkinData_New:GetActivityData(self.activityID_)

	local var_11_0 = self.data_:SignRewardList()
	local var_11_1 = self.data_.gain_reward
	local var_11_2 = #self.data_.unlock_reward + #self.data_.gain_reward
	local var_11_3 = self.data_:ReSignNum()
	local var_11_4 = var_11_3 + (#self.data_.unlock_reward + #self.data_.gain_reward)

	for iter_11_0 = 1, self.maxDay_ do
		self.items_[iter_11_0]:RefreshView(var_11_0[iter_11_0], iter_11_0 <= var_11_2 and 1 or 0, iter_11_0 == var_11_2 + 1 and var_11_3 > 0 and true or false, var_11_4)
		self.items_[iter_11_0]:RefreshGet(var_11_1)
	end
end

function SevenDaySkinPage_4_8:OnBtnSignClick(arg_12_1, arg_12_2)
	local var_12_0 = {}

	table.insert(var_12_0, arg_12_1)

	if arg_12_2 then
		self:ShowCheckDialog(arg_12_1)
	else
		SevenDaySkinAction_New.ReqSign(self.activityID_, var_12_0)
	end
end

function SevenDaySkinPage_4_8:ShowCheckDialog(arg_13_1)
	local var_13_0 = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2]
	local var_13_1 = CurrencyData:GetCurrencyNum(ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1])

	JumpTools.OpenPageByJump("popCostItem", {
		costId = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1],
		costCount = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2],
		content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1]), ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2], GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN")),
		popCostCallBack = function()
			local var_14_0, var_14_1 = ActivityData:GetActivityTime(self.activityID_)

			if var_14_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif self.crossDay_ then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				self.crossDay_ = false
			elseif var_13_1 < var_13_0 then
				ShopTools.DefaultOpenPopUp(var_13_0 - var_13_1)
			else
				SevenDaySkinAction_New.ReqReSign(self.activityID_, arg_13_1)
			end
		end
	})
end

function SevenDaySkinPage_4_8:OnSignSuccess(arg_15_1)
	if arg_15_1.rewards[1].convert_from.id and arg_15_1.rewards[1].convert_from.id > 0 then
		if ItemCfg[arg_15_1.rewards[1].convert_from.id] and ItemCfg[arg_15_1.rewards[1].convert_from.id].type == ItemConst.ITEM_TYPE.HERO then
			getReward(formatRewardCfgList({
				arg_15_1.rewards[1]
			}))
		end
	elseif ItemCfg[arg_15_1.rewards[1].id] and ItemCfg[arg_15_1.rewards[1].id].type == ItemConst.ITEM_TYPE.HERO then
		getReward(formatRewardCfgList({
			arg_15_1.rewards[1]
		}))
	elseif ItemCfg[arg_15_1.rewards[1].id] and ItemCfg[arg_15_1.rewards[1].id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		getReward(formatRewardCfgList({
			arg_15_1.rewards[1]
		}))
	elseif ItemCfg[arg_15_1.rewards[1].id] and ItemCfg[arg_15_1.rewards[1].id].type == ItemConst.ITEM_TYPE.SCENE then
		getReward(formatRewardCfgList({
			arg_15_1.rewards[1]
		}))
	else
		getReward(formatRewardCfgList({
			arg_15_1.rewards[1]
		}))
	end

	SevenDaySkinData_New:SetDlcReward(true)
	self:RefreshView()

	self.crossDay_ = false
end

function SevenDaySkinPage_4_8:OnClearSuccess()
	self:RefreshView()

	self.crossDay_ = true
end

function SevenDaySkinPage_4_8:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		SevenDaySkinData_New:SetDlcReward(false)
		self:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		SevenDaySkinData_New:SetDlcReward(false)
		self:Go("/home", nil, nil, true)
	end)
end

function SevenDaySkinPage_4_8:Show(arg_20_1)
	SetActive(self.gameObject_, arg_20_1)

	if arg_20_1 then
		self:UpdatePreview()
		self:RefreshView()
	end
end

function SevenDaySkinPage_4_8:BindRedPoint()
	return
end

function SevenDaySkinPage_4_8:UnBindRedPoint()
	return
end

function SevenDaySkinPage_4_8:OnTop()
	self:UpdateBar()
end

function SevenDaySkinPage_4_8:OnExit()
	self:UnBindRedPoint()
	SevenDaySkinPage_4_8.super.OnExit(self)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
end

function SevenDaySkinPage_4_8:Dispose()
	self:RemoveAllListeners()

	for iter_25_0 = 1, #self.items_ do
		self.items_[iter_25_0]:Dispose()
	end

	SevenDaySkinPage_4_8.super.Dispose(self)
end

return SevenDaySkinPage_4_8
