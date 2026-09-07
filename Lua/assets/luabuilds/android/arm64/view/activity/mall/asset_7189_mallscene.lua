local MallScene = class("MallScene", import("view.base.BaseUI"))

function MallScene:getUIName()
	return "MallUI"
end

function MallScene:init()
	self.animDft = self._tf:GetComponent(typeof(DftAniEvent))

	self.animDft:SetEndEvent(function(arg_3_0)
		MallScene.super.onBackPressed(self)

		return
	end)
	onButton(self, self.uiBackBtn, function()
		self:onBackPressed()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHomeBtn, function()
		self:quickExitFunc()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.mall_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiMapBtn, function()
		self:emit(MallMediator.CHANGE_SCENE, SCENE.MALL_MAP)

		return
	end, SFX_PANEL)
	onButton(self, self.uiBookBtn, function()
		self:emit(MallMediator.GO_SUBLAYER, Context.New({
			mediator = MallStoryLineMediator,
			viewComponent = MallStoryLineLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiOrderBtn, function()
		self:emit(MallMediator.GO_SUBLAYER, Context.New({
			mediator = MallOrderMediator,
			viewComponent = MallOrderLayer,
			data = {
				onExit = function()
					self:UpdateData()
					self:UpdateView()

					return
				end
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiSummaryBtn, function()
		self:ShowSummaryBox()

		return
	end, SFX_PANEL)
	onButton(self, self.uiAwardBtn, function()
		self:emit(MallMediator.GO_SUBLAYER, Context.New({
			mediator = MallAwardMediator,
			viewComponent = MallAwardLayer,
			data = {
				onExit = function()
					self:UpdateData()
					self:UpdateView()

					return
				end
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiRightUpgradeBtn, function()
		setActive(self.uiRightUpgradeTF, true)
		setActive(self.uiRightSummaryTF, false)
		setText(self.uiRightTitleText, i18n("mall_right_title_summary"))

		return
	end, SFX_PANEL)
	onButton(self, self.uiRightSummaryBtn, function()
		setActive(self.uiRightSummaryTF, true)
		setActive(self.uiRightUpgradeTF, false)
		setText(self.uiRightTitleText, i18n("mall_right_title_upgrade"))

		return
	end, SFX_PANEL)

	self.upgradeUIList = UIItemList.New(self.uiUpgradeConditionTF, self.uiUpgradeConditionTF:Find("tpl"))

	self.upgradeUIList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			self:UpdateConditionTpl(arg_16_1, arg_16_2)
		end

		return
	end)

	self.upgradeBox = MallUpgradeBox.New(self._tf, self.event, self.contextData)
	self.settleBox = MallSettleBox.New(self._tf, self.event, self.contextData)
	self.summaryBox = MallSummaryBox.New(self._tf, self.event, self.contextData)

	setText(self.uiTitleText, i18n("mall_title"))
	setText(self.uiTitleEnText, i18n("mall_title_en"))
	setText(self.uiRoundHeaderText, i18n("mall_round_header"))
	setText(self.uiLevelHeaderText, i18n("mall_level_header"))
	setText(self.uiRightUpgradeTF:Find("max/Text"), i18n("mall_level_max"))

	return
end

function MallScene:didEnter()
	self:UpdateData()
	self:UpdateView()
	triggerButton(self.uiRightSummaryBtn)

	return
end

function MallScene:UpdateData()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)

	assert(self.activity and not self.activity:isEnd(), "not exist mall act, type: " .. ActivityConst.ACTIVITY_TYPE_MALL)

	self.levelDate = self.activity:GetLevelData()
	self.conditionList = self.levelDate:getConfig("upgrade_task")
	self.conditionDescList = self.levelDate:getConfig("upgrade_task_desc")

	local var_18_0 = ActivityPtData.New((getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_id"))))

	self.curPt = var_18_0.count
	self.ptTargets = var_18_0.targets
	self.ptUnlockStamps = var_18_0:GetDayUnlockStamps()

	return
end

function MallScene:UpdateView()
	setText(self.uiGoldText, self.activity:GetGold())
	setText(self.uiRoundText, self.activity:GetRound())
	setText(self.uiLevelText, self.levelDate.level)

	local var_19_0 = self.levelDate:IsMaxLevel()

	setActive(self.uiRightUpgradeTF:Find("conditions"), not var_19_0)
	setActive(self.uiRightUpgradeTF:Find("max"), var_19_0)
	self.upgradeUIList:align(var_19_0 and 0 or #self.conditionList)
	self:UpdateFloors()
	self:UpdateOrderBtn()
	self:UpdateTips()
	self:UpdateStartBtn()

	return
end

function MallScene:UpdateOrderBtn()
	setActive(self.uiOrderTimeTF, false)

	self.orderData = self.activity:GetOrderData()

	if self.orderData.id ~= 0 then
		if pg.TimeMgr.GetInstance():GetServerTime() < self.orderData:GetEndTime() then
			setActive(self.uiOrderTimeTF, true)
			self:StartTimer()
		end
	else
		self:StopTimer()
	end

	return
end

function MallScene:UpdateTips()
	setActive(self.uiAwardTip, MallScene.IsAwardTip())
	setActive(self.uiOrderTip, MallScene.IsOrderTip())
	setActive(self.uiMapTip, MallScene.IsMapTip())

	return
end

function MallScene:UpdateStartBtn()
	local var_22_0 = false

	for iter_22_0, iter_22_1 in ipairs(self.activity:GetFloorList()) do
		if iter_22_1:IsUnlock() and iter_22_1:GetStaffList()[1] ~= 0 then
			var_22_0 = false

			break
		end

		var_22_0 = true
	end

	if var_22_0 then
		setActive(self.uiStartBtn, false)
		setActive(self.uiStartGreyBtn, true)
		onButton(self, self.uiStartGreyBtn, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("mall_floor_all_empty_tip"))

			return
		end, SFX_PANEL)

		return
	end

	local var_22_1, var_22_2, var_22_3 = (function()
		local var_24_0 = pg.TimeMgr.GetInstance()

		for iter_24_0, iter_24_1 in ipairs(self.ptTargets) do
			if self.ptUnlockStamps[iter_24_0] and self.ptUnlockStamps[iter_24_0] > var_24_0:GetServerTime() then
				return iter_24_0, var_24_0:STimeDescS(self.ptUnlockStamps[iter_24_0], "%m"), (var_24_0:STimeDescS(self.ptUnlockStamps[iter_24_0], "%d"))
			end
		end

		return nil
	end)()
	local var_22_4 = self.ptTargets[(var_22_1 or nil) and (var_22_1 - 1 or #self.ptTargets)] <= self.curPt + self.activity:GetGold()

	setActive(self.uiStartBtn, not var_22_4 or not var_22_1)
	onButton(self, self.uiStartBtn, function()
		if var_22_4 and var_22_1 then
			return
		end

		self:emit(MallMediator.SETTLE_ROUND, self.activity.id)

		return
	end, SFX_PANEL)
	setActive(self.uiStartGreyBtn, var_22_4 and var_22_1)
	onButton(self, self.uiStartGreyBtn, function()
		if not var_22_4 then
			return
		end

		if var_22_1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mall_unlock_date_tip", var_22_2, var_22_3))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("mall_finished_all_tip"))
		end

		return
	end, SFX_PANEL)

	return
end

function MallScene:UpdateConditionTpl(arg_27_1, arg_27_2)
	local var_27_0 = self.conditionList[arg_27_1 + 1][2]
	local var_27_1 = 0
	local var_27_2 = 0
	local var_27_3 = self.conditionDescList[arg_27_1 + 1]

	switch(self.conditionList[arg_27_1 + 1][1], {
		[MallLevel.CONDITION_TYPE.ROUND] = function()
			var_27_1 = self.activity:GetRound()
			var_27_2 = var_27_0[1]

			return
		end,
		[MallLevel.CONDITION_TYPE.ORDER] = function()
			var_27_1 = #self.activity:GetOrderData():GetFinishedList()
			var_27_2 = var_27_0[1]

			return
		end,
		[MallLevel.CONDITION_TYPE.ROUND_INCOME] = function()
			var_27_1 = self.activity:GetLastIncome()
			var_27_2 = var_27_0[1]

			return
		end,
		[MallLevel.CONDITION_TYPE.FLOOR_INCOME] = function()
			var_27_1 = self.activity:GetFloorData()[var_27_0[1]]:GetLastIncome()
			var_27_2 = var_27_0[2]

			return
		end
	})

	local var_27_4 = var_27_2 <= var_27_1

	setActive(arg_27_2:Find("unfinished"), not (var_27_2 <= var_27_1))
	setActive(arg_27_2:Find("finished"), var_27_4)
	setText(arg_27_2:Find("Text"), (string.gsub(string.gsub(var_27_3, "$1", var_27_4 and var_27_1 or setColorStr(var_27_1, "#bd5d4a")), "$2", var_27_2)))

	return
end

function MallScene:UpdateFloors()
	eachChild(self.uiFloorsTF, function(arg_33_0)
		self:UpdateFloorTpl(tonumber(arg_33_0.name), arg_33_0)

		return
	end)

	return
end

function MallScene:UpdateFloorTpl(arg_34_1, arg_34_2)
	local var_34_0 = self.activity:GetFloor(arg_34_1)
	local var_34_1 = var_34_0:IsUnlock()

	setActive(arg_34_2:Find("lock"), not var_34_1)

	if arg_34_2:Find("sign") then
		setActive(arg_34_2:Find("sign"), var_34_1)
	end

	local var_34_2 = var_34_0:GetStaffList()
	local var_34_3 = underscore.reduce(var_34_2, 0, function(arg_35_0, arg_35_1)
		return arg_35_0 + (arg_35_1 ~= 0 and 1 or 0)
	end)

	setActive(arg_34_2:Find("bg"), var_34_3 ~= 0)
	setActive(arg_34_2:Find("empty"), var_34_3 == 0)
	setText(arg_34_2:Find("rank/Text"), var_34_3 .. "/" .. #var_34_2)

	local var_34_4 = {}

	for iter_34_0, iter_34_1 in ipairs(var_34_0:GetTargetInfos(self.levelDate.level)) do
		table.insert(var_34_4, {
			cur = 0,
			id = iter_34_0,
			base = iter_34_1[1],
			max = iter_34_1[2]
		})
	end

	for iter_34_2, iter_34_3 in ipairs(var_34_2) do
		if iter_34_3 ~= 0 then
			for iter_34_4, iter_34_5 in ipairs(self.activity:GetStaff(iter_34_3):GetAttrList()) do
				var_34_4[iter_34_4].cur = var_34_4[iter_34_4].cur + iter_34_5
			end
		end
	end

	local var_34_5 = underscore.select(var_34_4, function(arg_36_0)
		return arg_36_0.base ~= 0 and arg_36_0.max ~= 0
	end)

	GetImageSpriteFromAtlasAsync("ui/mallui_atlas", "rank_" .. MallUtil.GetFloorRank(underscore.reduce(var_34_5, 0, function(arg_37_0, arg_37_1)
		return arg_37_0 + arg_37_1.cur
	end), (underscore.reduce(var_34_5, 0, function(arg_38_0, arg_38_1)
		return arg_38_0 + arg_38_1.base
	end))), arg_34_2:Find("rank"), true)
	onButton(self, arg_34_2, function()
		if not var_34_1 then
			return
		end

		self:emit(MallMediator.GO_SUBLAYER, Context.New({
			mediator = MallStaffMediator,
			viewComponent = MallStaffLayer,
			data = {
				floorId = var_34_0.id
			}
		}))

		return
	end, SFX_PANEL)

	return
end

function MallScene:StartTimer()
	self:StopTimer()

	self.orderEndTime = self.orderData:GetEndTime()
	self.timer = Timer.New(function()
		local var_41_0 = self.orderEndTime - pg.TimeMgr.GetInstance():GetServerTime()

		setText(self.uiOrderTimeTF:Find("Text"), pg.TimeMgr.GetInstance():DescCDTime(var_41_0))

		if var_41_0 <= 0 then
			self:UpdateOrderBtn()
			setActive(self.uiOrderTip, true)
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function MallScene:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MallScene:ShowUpgradeBox(arg_43_1, arg_43_2, arg_43_3)
	self.upgradeBox:ExecuteAction("Show", arg_43_1, arg_43_2, arg_43_3)

	return
end

function MallScene:ShowSettleBox(arg_44_1, arg_44_2)
	self.settleBox:ExecuteAction("Show", arg_44_1, arg_44_2)

	return
end

function MallScene:ShowSummaryBox()
	self.summaryBox:ExecuteAction("Show")

	return
end

function MallScene:onBackPressed()
	if self.upgradeBox and self.upgradeBox:isShowing() then
		self.upgradeBox:ExecuteAction("Hide")

		return
	end

	if self.summaryBox and self.summaryBox:isShowing() then
		self.summaryBox:ExecuteAction("Hide")

		return
	end

	if self.settleBox and self.settleBox:isShowing() then
		self.settleBox:ExecuteAction("Hide")

		return
	end

	quickPlayAnimation(self._tf, "anim_MallUI_out")

	return
end

function MallScene:willExit()
	self.animDft:SetEndEvent(nil)

	if self.upgradeBox then
		self.upgradeBox:Destroy()

		self.upgradeBox = nil
	end

	if self.settleBox then
		self.settleBox:Destroy()

		self.settleBox = nil
	end

	if self.summaryBox then
		self.summaryBox:Destroy()

		self.summaryBox = nil
	end

	self:StopTimer()

	return
end

function MallScene.IsAwardTip()
	return MallAwardLayer.IsAwardTip() or MallAwardLayer.IsInputTip() or MallAwardLayer.IsTaskTip()
end

function MallScene.IsOrderTip()
	local var_49_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	local var_49_1 = var_49_0:GetOrderData()

	if var_49_1:IsFinishedAll() then
		return false
	end

	local var_49_2 = var_49_1:GetFinishedList()
	local var_49_3 = underscore.detect(pg.activity_mall_custom_order.all, function(arg_50_0)
		return not table.contains(var_49_2, arg_50_0)
	end)

	if not (var_49_0:GetLevelData().level >= pg.activity_mall_custom_order[var_49_3].unlock_lv and var_49_0:getDayIndex() >= pg.activity_mall_custom_order[var_49_3].unlock_time) then
		var_49_3 = 0
	end

	local var_49_4

	if var_49_3 ~= 0 then
		if var_49_1.startTime ~= 0 then
			if pg.TimeMgr.GetInstance():GetServerTime() < var_49_1:GetEndTime() then
				var_49_4 = false

				goto label_49_0
			end
		end
	end

	::label_49_0::

	return true
end

function MallScene.IsMapTip()
	local var_51_0 = getProxy(ActivityProxy)
	local var_51_1 = var_51_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	local var_51_2 = var_51_1:GetTriggeredPointIds()

	return #underscore.select(var_51_1:GetLevelData().GetUnlockStoryIds(var_51_0), function(arg_52_0)
		local var_52_0 = pg.activity_mall_story[arg_52_0]
		local var_52_1

		if table.contains(var_51_2, arg_52_0) then
			if pg.activity_mall_story[arg_52_0].type ~= MallActivity.POINT_TYPE.SITE then
				::label_52_0::

				var_52_1 = var_52_0.lua ~= "" and not pg.NewStoryMgr.GetInstance():IsPlayed(var_52_0.lua) or false

				goto label_52_1
			end
		end

		::label_52_1::

		return true
	end) > 0
end

return MallScene
