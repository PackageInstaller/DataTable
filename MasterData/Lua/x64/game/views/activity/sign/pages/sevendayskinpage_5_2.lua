ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SevenDaySkinPage_5_2 = class("SevenDaySkinPage_5_2", ActivityMainBasePanel)

function SevenDaySkinPage_5_2:GetUIName()
	return ActivityCumulativeSignCfg[self.activityID_].ui_path
end

function SevenDaySkinPage_5_2:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SevenDaySkinPage_5_2:InitUI()
	self:BindCfgUI()

	self.onClearHandler = handler(self, self.OnClearSuccess)
	self.onReceiveSHeroHandler = handler(self, self.OnReceiveSHeroSuccess)
	self.freeCon_ = self.freeControllerEx_:GetController("received")
	self.freeItemGo_ = CommonItemView.New(self.freeItem_, true)
end

function SevenDaySkinPage_5_2:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		local var_5_0 = {}

		var_5_0.content = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].desc or "")

		JumpTools.OpenPageByJump("gameHelp", var_5_0)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		SevenDaySkinAction_New.ReceiveGiftSHero(self.activityID_)
	end)
end

function SevenDaySkinPage_5_2:OnEnter()
	SevenDaySkinPage_5_2.super.OnEnter(self)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_RECEIVE_SHERO_SUCCESS, self.onReceiveSHeroHandler)
	self:BindRedPoint()
	self:RefreshView()
end

function SevenDaySkinPage_5_2:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

function SevenDaySkinPage_5_2:RefreshView()
	self.data_ = SevenDaySkinData_New:GetActivityData(self.activityID_)

	local var_9_0 = self.data_.gift_reward

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
	self.freeCon_:SetSelectedIndex(var_9_0 == 0 and 1 or 0)

	if ItemCfg[self.itemData_.id] then
		self.sItemNameTxt_.text = ItemCfg[self.itemData_.id].name or ""
	end

	self.descText_.text = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].desc or "")
	self.titleTxt_.text = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name or "")
end

function SevenDaySkinPage_5_2:OnClearSuccess()
	self:RefreshView()
end

function SevenDaySkinPage_5_2:OnReceiveSHeroSuccess(arg_12_1)
	getReward(formatRewardCfgList({
		arg_12_1.rewards[1]
	}), nil, function()
		self:RefreshView()
	end)
end

function SevenDaySkinPage_5_2:UpdateBar()
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

function SevenDaySkinPage_5_2:Show(arg_17_1)
	SetActive(self.gameObject_, arg_17_1)

	if arg_17_1 then
		self:UpdatePreview()
		self:RefreshView()
	end
end

function SevenDaySkinPage_5_2:BindRedPoint()
	manager.redPoint:bindUIandKey(self.receiveBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, self.activityID_))
end

function SevenDaySkinPage_5_2:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.receiveBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, self.activityID_))
end

function SevenDaySkinPage_5_2:OnTop()
	self:UpdateBar()
end

function SevenDaySkinPage_5_2:OnExit()
	self:UnBindRedPoint()
	SevenDaySkinPage_5_2.super.OnExit(self)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_RECEIVE_SHERO_SUCCESS, self.onReceiveSHeroHandler)
end

function SevenDaySkinPage_5_2:Dispose()
	self:RemoveAllListeners()

	if self.freeItemGo_ then
		self.freeItemGo_:Dispose()

		self.freeItemGo_ = nil
	end

	SevenDaySkinPage_5_2.super.Dispose(self)
end

return SevenDaySkinPage_5_2
