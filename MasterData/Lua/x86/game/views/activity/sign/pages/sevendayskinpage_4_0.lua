ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SevenDaySkinPage_4_0 = class("SevenDaySkinPage_4_0", ActivityMainBasePanel)

function SevenDaySkinPage_4_0:GetUIName()
	return ActivityCumulativeSignCfg[self.activityID_].ui_path
end

function SevenDaySkinPage_4_0:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SevenDaySkinPage_4_0:InitUI()
	self:BindCfgUI()

	self.items_ = {}
	self.maxDay_ = SevenDaySkinData_New:MaxSignDay(self.activityID_)

	for iter_3_0 = 1, self.maxDay_ do
		self.items_[iter_3_0] = SevenDaySkinItem_4_0.New(self["btn_" .. iter_3_0], ActivityCumulativeSignCfg[self.activityID_].config_list[iter_3_0], iter_3_0)

		self.items_[iter_3_0]:RegisterClickFunc(function(arg_4_0, arg_4_1)
			self:OnBtnSignClick(arg_4_0, arg_4_1)
		end)
	end

	self.onSignHandler = handler(self, self.OnSignSuccess)
	self.onClearHandler = handler(self, self.OnClearSuccess)
	self.onReceiveSHeroHandler = handler(self, self.OnReceiveSHeroSuccess)
	self.pageCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("page")
	self.freeCon_ = self.freeControllerEx_:GetController("received")
	self.freeItemGo_ = CommonItemView.New(self.freeItem_, true)
end

function SevenDaySkinPage_4_0:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_4_0_SIGN_INSTRUSCTIONS")
		})
	end)
	self:AddBtnListener(self.signBtn_, nil, function()
		SevenDaySkinData_New:SetDlcReward(true)
		self.pageCon_:SetSelectedIndex(0)
	end)
	self:AddBtnListener(self.freeBtn_, nil, function()
		SevenDaySkinData_New:SetDlcReward(false)
		self.pageCon_:SetSelectedIndex(1)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		SevenDaySkinAction_New.ReceiveGiftSHero(self.activityID_)
	end)
end

function SevenDaySkinPage_4_0:OnEnter()
	SevenDaySkinPage_4_0.super.OnEnter(self)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_RECEIVE_SHERO_SUCCESS, self.onReceiveSHeroHandler)
	self:BindRedPoint()

	self.crossDay_ = false

	self:RefreshView()
end

function SevenDaySkinPage_4_0:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

function SevenDaySkinPage_4_0:RefreshView()
	self.changePage_ = SevenDaySkinData_New:GetDlcReward()
	self.data_ = SevenDaySkinData_New:GetActivityData(self.activityID_)

	local var_12_0 = self.data_.gift_reward

	if self.changePage_ then
		self.pageCon_:SetSelectedIndex(0)
	else
		self.pageCon_:SetSelectedIndex(var_12_0 == 0 and 1 or 0)
	end

	self.freeCon_:SetSelectedIndex(var_12_0 == 0 and 1 or 0)

	if not self.itemData_ then
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	end

	self.itemData_.id = ActivityCumulativeSignCfg[self.activityID_].gift_item_list[1][1]
	self.itemData_.number = ActivityCumulativeSignCfg[self.activityID_].gift_item_list[1][2]

	self.freeItemGo_:SetData(self.itemData_)

	self.sItemNameTxt_.text = ItemCfg[self.itemData_.id].name
	self.descText_.text = GetTips("ACTIVITY_4_0_SIGN_DESC")
	self.titleTxt_.text = GetI18NText(ActivityCfg[self.activityID_].remark)
	self.leftTxt_.text = GetTips("SEVENDAY_SKIN_OPTIONAL_HERO")
	self.rightTxt_.text = GetTips("SEVENDAY_SKIN_WELFARE_SIGNIN")

	self:RefreshItems()
end

function SevenDaySkinPage_4_0:RefreshItems()
	self.data_ = SevenDaySkinData_New:GetActivityData(self.activityID_)

	local var_14_0 = self.data_:SignRewardList()
	local var_14_1 = self.data_.gain_reward
	local var_14_2 = #self.data_.unlock_reward + #self.data_.gain_reward
	local var_14_3 = self.data_:ReSignNum()
	local var_14_4 = var_14_3 + (#self.data_.unlock_reward + #self.data_.gain_reward)

	for iter_14_0 = 1, self.maxDay_ do
		self.items_[iter_14_0]:RefreshView(var_14_0[iter_14_0], iter_14_0 <= var_14_2 and 1 or 0, iter_14_0 == var_14_2 + 1 and var_14_3 > 0 and true or false, var_14_4)
		self.items_[iter_14_0]:RefreshGet(var_14_1)
	end
end

function SevenDaySkinPage_4_0:OnBtnSignClick(arg_15_1, arg_15_2)
	local var_15_0 = {}

	table.insert(var_15_0, arg_15_1)

	if arg_15_2 then
		self:ShowCheckDialog(arg_15_1)
	else
		SevenDaySkinAction_New.ReqSign(self.activityID_, var_15_0)
	end
end

function SevenDaySkinPage_4_0:ShowCheckDialog(arg_16_1)
	local var_16_0 = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2]
	local var_16_1 = CurrencyData:GetCurrencyNum(ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1])

	JumpTools.OpenPageByJump("popCostItem", {
		costId = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1],
		costCount = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2],
		content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1]), ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2], GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN")),
		popCostCallBack = function()
			local var_17_0, var_17_1 = ActivityData:GetActivityTime(self.activityID_)

			if var_17_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif self.crossDay_ then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				self.crossDay_ = false
			elseif var_16_1 < var_16_0 then
				ShopTools.DefaultOpenPopUp(var_16_0 - var_16_1)
			else
				SevenDaySkinAction_New.ReqReSign(self.activityID_, arg_16_1)
			end
		end
	})
end

function SevenDaySkinPage_4_0:OnSignSuccess(arg_18_1)
	if arg_18_1.rewards[1].convert_from.id and arg_18_1.rewards[1].convert_from.id > 0 then
		if ItemCfg[arg_18_1.rewards[1].convert_from.id] and ItemCfg[arg_18_1.rewards[1].convert_from.id].type == ItemConst.ITEM_TYPE.HERO then
			getReward(formatRewardCfgList({
				arg_18_1.rewards[1]
			}))
		end
	elseif ItemCfg[arg_18_1.rewards[1].id] and ItemCfg[arg_18_1.rewards[1].id].type == ItemConst.ITEM_TYPE.HERO then
		getReward(formatRewardCfgList({
			arg_18_1.rewards[1]
		}))
	elseif ItemCfg[arg_18_1.rewards[1].id] and ItemCfg[arg_18_1.rewards[1].id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		getReward(formatRewardCfgList({
			arg_18_1.rewards[1]
		}))
	elseif ItemCfg[arg_18_1.rewards[1].id] and ItemCfg[arg_18_1.rewards[1].id].type == ItemConst.ITEM_TYPE.SCENE then
		getReward(formatRewardCfgList({
			arg_18_1.rewards[1]
		}))
	else
		getReward(formatRewardCfgList({
			arg_18_1.rewards[1]
		}))
	end

	SevenDaySkinData_New:SetDlcReward(true)
	self:RefreshView()

	self.crossDay_ = false
end

function SevenDaySkinPage_4_0:OnClearSuccess()
	self:RefreshView()

	self.crossDay_ = true
end

function SevenDaySkinPage_4_0:OnReceiveSHeroSuccess(arg_20_1)
	getReward(formatRewardCfgList({
		arg_20_1.rewards[1]
	}), nil, function()
		self:RefreshView()
	end)
end

function SevenDaySkinPage_4_0:UpdateBar()
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

function SevenDaySkinPage_4_0:Show(arg_25_1)
	SetActive(self.gameObject_, arg_25_1)

	if arg_25_1 then
		self:UpdatePreview()
		self:RefreshView()
	end
end

function SevenDaySkinPage_4_0:BindRedPoint()
	manager.redPoint:bindUIandKey(self.signBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_NEWSIGN, self.activityID_))
	manager.redPoint:bindUIandKey(self.freeBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, self.activityID_))
end

function SevenDaySkinPage_4_0:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.signBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_NEWSIGN, self.activityID_))
	manager.redPoint:unbindUIandKey(self.freeBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, self.activityID_))
end

function SevenDaySkinPage_4_0:OnTop()
	self:UpdateBar()
end

function SevenDaySkinPage_4_0:OnExit()
	self:UnBindRedPoint()
	SevenDaySkinPage_4_0.super.OnExit(self)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_RECEIVE_SHERO_SUCCESS, self.onReceiveSHeroHandler)
end

function SevenDaySkinPage_4_0:Dispose()
	self:RemoveAllListeners()

	for iter_30_0 = 1, #self.items_ do
		self.items_[iter_30_0]:Dispose()
	end

	SevenDaySkinPage_4_0.super.Dispose(self)
end

return SevenDaySkinPage_4_0
