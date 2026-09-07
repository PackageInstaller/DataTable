local ActivityBossSceneTemplate = class("ActivityBossSceneTemplate", import("view.base.BaseUI"))

function ActivityBossSceneTemplate:getUIName()
	error("Need Complete")

	return
end

function ActivityBossSceneTemplate:getGroupName()
	return "ActivityBossSceneTemplate"
end

ActivityBossSceneTemplate.optionsPath = {
	"adapt/top/option"
}

function ActivityBossSceneTemplate:init()
	self.mainTF = self._tf:Find("adapt")
	self.bg = self._tf:Find("bg")
	self.bottom = self.mainTF:Find("bottom")
	self.hpBar = self.bottom:Find("progress")
	self.barList = {}

	for iter_3_0 = 1, 4 do
		self.barList[iter_3_0] = self.hpBar:Find(iter_3_0)
	end

	self.progressDigit = self.bottom:Find("digit")
	self.digitbig = self.progressDigit:Find("big")
	self.digitsmall = self.progressDigit:Find("small")
	self.left = self.mainTF:Find("left")
	self.rankTF = self.left:Find("rank")
	self.rankList = CustomIndexLayer.Clone2Full(self.rankTF:Find("layout"), 3)

	for iter_3_1, iter_3_2 in ipairs(self.rankList) do
		setActive(iter_3_2, false)
	end

	self.right = self.mainTF:Find("right")
	self.stageList = {}

	for iter_3_3 = 1, 4 do
		self.stageList[iter_3_3] = self.right:Find(iter_3_3)
	end

	self.stageSP = self.right:Find("5")

	if not IsNil(self.stageSP) then
		setActive(self.stageSP, false)
	end

	self.awardFlash = self.right:Find("ptaward/flash")
	self.awardBtn = self.right:Find("ptaward/button")
	self.ptScoreTxt = self.right:Find("ptaward/Text")
	self.top = self.mainTF:Find("top")
	self.ticketNum = self.top:Find("ticket/Text")
	self.helpBtn = self.top:Find("help")

	onButton(self, self.top:Find("back_btn"), function()
		self:emit(ActivityBossSceneTemplate.ON_BACK)

		return
	end, SOUND_BACK)
	setActive(self.top, false)
	setAnchoredPosition(self.top, {
		y = 1080
	})
	setActive(self.left, false)
	setAnchoredPosition(self.left, {
		x = -1920
	})
	setActive(self.right, false)
	setAnchoredPosition(self.right, {
		x = 1920
	})
	setActive(self.bottom, false)
	setAnchoredPosition(self.bottom, {
		y = -1080
	})
	self:buildCommanderPanel()

	return
end

function ActivityBossSceneTemplate:GetBonusWindow()
	if not self.bonusWindow then
		self.bonusWindow = ActivityBossPtAwardSubPanel.New(self)

		self.bonusWindow:Load()
	end

	return self.bonusWindow
end

function ActivityBossSceneTemplate:DestroyBonusWindow()
	if self.bonusWindow then
		self.bonusWindow:Destroy()

		self.bonusWindow = nil
	end

	return
end

function ActivityBossSceneTemplate:GetFleetEditPanel()
	if not self.fleetEditPanel then
		self.fleetEditPanel = ActivityBossBattleFleetSelectSubPanel.New(self)

		self.fleetEditPanel:Load()
	end

	return self.fleetEditPanel
end

function ActivityBossSceneTemplate:DestroyFleetEditPanel()
	if self.fleetEditPanel then
		self.fleetEditPanel:Destroy()

		self.fleetEditPanel = nil
	end

	return
end

function ActivityBossSceneTemplate:EnterAnim()
	setActive(self.top, true)
	setActive(self.left, true)
	setActive(self.right, true)
	setActive(self.bottom, true)
	self.mainTF:GetComponent("Animation"):Play("Enter_Animation")

	return
end

function ActivityBossSceneTemplate:didEnter()
	onButton(self, self.awardBtn, function()
		self:ShowAwards()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_boss_help.tip
		})

		return
	end, SFX_PANEL)
	self:UpdateDropItems()

	for iter_10_0 = 1, #self.stageList - 1 do
		onButton(self, self.stageList[iter_10_0], function()
			if self.contextData.activity:checkBattleTimeInBossAct() then
				self:ShowNormalFleet(iter_10_0, true)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self.stageList[#self.stageList], function()
		if self.contextData.activity:checkBattleTimeInBossAct() then
			self:ShowEXFleet()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)

	if not IsNil(self.stageSP) then
		setActive(self.stageSP, self.contextData.spStageID)
		onButton(self, self.stageSP, function()
			if self.contextData.activity:checkBattleTimeInBossAct() then
				self:emit(ActivityBossMediatorTemplate.ONEN_BUFF_SELECT)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			end

			return
		end, SFX_PANEL)
	end

	if self.contextData.editFleet then
		if self.contextData.editFleet <= #self.contextData.normalStageIDs then
			self:ShowNormalFleet(self.contextData.editFleet)
		elseif self.contextData.editFleet == #self.contextData.normalStageIDs + 1 then
			self:ShowEXFleet()
		elseif self.contextData.editFleet == #self.contextData.normalStageIDs + 2 then
			self:ShowSPFleet()
		end
	end

	self:EnterAnim()

	if self.contextData.msg then
		local var_10_0 = self.contextData.msg.param

		switch(self.contextData.msg.type, {
			lastBonus = function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox(var_10_0)

				return
			end,
			oil = function()
				if not ItemTipPanel.ShowOilBuyTip(var_10_0) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))
				end

				return
			end,
			shipCapacity = function()
				BeginStageCommand.DockOverload()

				return
			end,
			energy = function()
				Fleet.EnergyCheck(_.map(_.values(var_10_0.ships), function(arg_20_0)
					return getProxy(BayProxy):getShipById(arg_20_0)
				end), Fleet.DEFAULT_NAME_BOSS_ACT[var_10_0.id], function(arg_21_0)
					if arg_21_0 then
						self:emit(PreCombatMediator.BEGIN_STAGE_PROXY, {
							curFleetId = var_10_0.id
						})
					end

					return
				end)

				return
			end
		})

		self.contextData.msg = nil
	end

	return
end

function ActivityBossSceneTemplate:UpdateView()
	self:UpdatePage()
	self:CheckStory()

	return
end

function ActivityBossSceneTemplate:CheckStory()
	local var_23_0 = pg.NewStoryMgr.GetInstance()

	table.SerialIpairsAsync(self.contextData.activity:getConfig("config_client").story, function(arg_24_0, arg_24_1, arg_24_2)
		if self.contextData.bossHP < arg_24_1[1] + ((arg_24_0 == 1 or arg_24_1[1] == 0) and 1 or 0) then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(arg_24_1[2]) then
				var_23_0:Play(arg_24_1[2], arg_24_2)

				return
			end
		end

		arg_24_2()

		return
	end)

	return
end

function ActivityBossSceneTemplate:UpdatePage()
	setText(self.digitbig, math.floor(self.contextData.bossHP / 100))
	setText(self.digitsmall, string.format("%02d", self.contextData.bossHP % 100) .. "%")

	local var_25_0 = pg.TimeMgr.GetInstance()

	for iter_25_0 = 1, 4 do
		setSlider(self.barList[iter_25_0]:Find("Slider"), 0, 2500, math.min(math.max(self.contextData.bossHP - (iter_25_0 - 1) * 2500, 0), 2500))
		setActive(self.barList[iter_25_0]:Find("milestone/item"), not self.contextData.mileStones[5 - iter_25_0])
		setActive(self.barList[iter_25_0]:Find("milestone/time"), self.contextData.mileStones[5 - iter_25_0])

		if self.contextData.mileStones[5 - iter_25_0] then
			setText(self.barList[iter_25_0]:Find("milestone/time/Text"), (var_25_0:STimeDescC(self.contextData.mileStones[5 - iter_25_0], "%m/%d/%H:%M")))
		end
	end

	for iter_25_1 = 1, #self.stageList - 1 do
		local var_25_1 = self.stageList[iter_25_1]

		for iter_25_2, iter_25_3 in ipairs(self.contextData.ticketInitPools) do
			for iter_25_4, iter_25_5 in ipairs(iter_25_3[1]) do
				if iter_25_5 == self.contextData.normalStageIDs[iter_25_1] then
					local var_25_2 = iter_25_3[2]
					local var_25_3 = self.contextData.stageTickets[self.contextData.normalStageIDs[iter_25_1]] or 0

					setActive(var_25_1:Find("Text"), var_25_3 > 0)
					setText(var_25_1:Find("Text"), string.format("%d/%d", var_25_3, var_25_2))
				end
			end
		end
	end

	setText(self.ptScoreTxt, self.contextData.ptData.count)
	setActive(self.awardFlash, self.contextData.ptData:CanGetAward())

	if self.bonusWindow and self.bonusWindow:IsShowing() then
		self.bonusWindow.buffer:UpdateView(self.contextData.ptData)
	end

	setText(self.ticketNum, (self:GetEXTicket()))

	return
end

function ActivityBossSceneTemplate:GetEXTicket()
	return getProxy(PlayerProxy):getRawData():getResource(self.contextData.TicketID)
end

function ActivityBossSceneTemplate:ShowNormalFleet(arg_27_1, arg_27_2)
	self.contextData.actFleets[arg_27_1] = self.contextData.actFleets[arg_27_1] or self:CreateNewFleet(arg_27_1)
	self.contextData.actFleets[arg_27_1 + 10] = self.contextData.actFleets[arg_27_1 + 10] or self:CreateNewFleet(arg_27_1 + 10)

	local var_27_0 = self.contextData.actFleets[arg_27_1]

	if arg_27_2 and #var_27_0.ships <= 0 then
		for iter_27_0 = #self.contextData.normalStageIDs, 1, -1 do
			if iter_27_0 ~= arg_27_1 and self.contextData.actFleets[iter_27_0] and self.contextData.actFleets[iter_27_0]:isLegalToFight() == true then
				var_27_0:updateShips(self.contextData.actFleets[iter_27_0].ships)

				break
			end
		end
	end

	local var_27_1 = self:GetFleetEditPanel()

	var_27_1.buffer:SetSettings(1, 1, false)
	var_27_1.buffer:SetFleets({
		self.contextData.actFleets[arg_27_1],
		self.contextData.actFleets[arg_27_1 + 10]
	})
	var_27_1.buffer:SetOilLimit((not self.contextData.activity:IsOilLimit(self.contextData.normalStageIDs[arg_27_1]) or nil) and {
		0,
		0
	})

	self.contextData.editFleet = arg_27_1

	var_27_1.buffer:UpdateView()
	var_27_1.buffer:Show()

	return
end

function ActivityBossSceneTemplate:ShowEXFleet()
	self.contextData.actFleets[#self.contextData.normalStageIDs + 1] = self.contextData.actFleets[#self.contextData.normalStageIDs + 1] or self:CreateNewFleet(#self.contextData.normalStageIDs + 1)
	self.contextData.actFleets[#self.contextData.normalStageIDs + 1 + 10] = self.contextData.actFleets[#self.contextData.normalStageIDs + 1 + 10] or self:CreateNewFleet(#self.contextData.normalStageIDs + 1 + 10)

	local var_28_0 = self:GetFleetEditPanel()

	var_28_0.buffer:SetSettings(1, 1, true)
	var_28_0.buffer:SetFleets({
		self.contextData.actFleets[#self.contextData.normalStageIDs + 1],
		self.contextData.actFleets[#self.contextData.normalStageIDs + 1 + 10]
	})
	var_28_0.buffer:SetOilLimit((not self.contextData.activity:IsOilLimit(self.contextData.exStageID) or nil) and {
		0,
		0
	})

	self.contextData.editFleet = #self.contextData.normalStageIDs + 1

	var_28_0.buffer:UpdateView()
	var_28_0.buffer:Show()

	return
end

function ActivityBossSceneTemplate:ShowSPFleet()
	self.contextData.actFleets[#self.contextData.normalStageIDs + 2] = self.contextData.actFleets[#self.contextData.normalStageIDs + 2] or self:CreateNewFleet(#self.contextData.normalStageIDs + 2)
	self.contextData.actFleets[#self.contextData.normalStageIDs + 2 + 10] = self.contextData.actFleets[#self.contextData.normalStageIDs + 2 + 10] or self:CreateNewFleet(#self.contextData.normalStageIDs + 2 + 10)

	local var_29_0 = self:GetFleetEditPanel()

	var_29_0.buffer:SetSettings(1, 1, false)
	var_29_0.buffer:SetFleets({
		self.contextData.actFleets[#self.contextData.normalStageIDs + 2],
		self.contextData.actFleets[#self.contextData.normalStageIDs + 2 + 10]
	})
	var_29_0.buffer:SetOilLimit({
		0,
		0
	})

	self.contextData.editFleet = #self.contextData.normalStageIDs + 2

	var_29_0.buffer:UpdateView()
	var_29_0.buffer:Show()

	return
end

function ActivityBossSceneTemplate:commitEdit()
	self:emit(self.contextData.mediatorClass.ON_COMMIT_FLEET)

	return
end

function ActivityBossSceneTemplate:commitCombat()
	if self.contextData.editFleet <= #self.contextData.normalStageIDs then
		self:emit(self.contextData.mediatorClass.ON_PRECOMBAT, self.contextData.editFleet)
	elseif self.contextData.editFleet == #self.contextData.normalStageIDs + 1 then
		self:emit(self.contextData.mediatorClass.ON_EX_PRECOMBAT, self.contextData.editFleet, false)
	elseif self.contextData.editFleet <= #self.contextData.normalStageIDs + 2 then
		self:emit(self.contextData.mediatorClass.ON_SP_PRECOMBAT, self.contextData.editFleet, false)
	end

	return
end

function ActivityBossSceneTemplate:commitTrybat()
	self:emit(self.contextData.mediatorClass.ON_EX_PRECOMBAT, self.contextData.editFleet, true)

	return
end

function ActivityBossSceneTemplate:updateEditPanel()
	if self.fleetEditPanel then
		self.fleetEditPanel.buffer:UpdateView()
	end

	return
end

function ActivityBossSceneTemplate:hideFleetEdit()
	if self.fleetEditPanel then
		self.fleetEditPanel.buffer:Hide()
	end

	if self.commanderFormationPanel then
		self.commanderFormationPanel.buffer:Close()
	end

	self.contextData.editFleet = nil

	return
end

function ActivityBossSceneTemplate:openShipInfo(arg_35_1, arg_35_2)
	local var_35_0 = {}
	local var_35_1 = getProxy(BayProxy)

	for iter_35_0, iter_35_1 in ipairs((self.contextData.actFleets[arg_35_2] or nil) and (self.contextData.actFleets[arg_35_2].ships or {})) do
		table.insert(var_35_0, var_35_1:getShipById(iter_35_1))
	end

	self:emit(self.contextData.mediatorClass.ON_FLEET_SHIPINFO, {
		shipId = arg_35_1,
		shipVOs = var_35_0
	})

	return
end

function ActivityBossSceneTemplate:setCommanderPrefabs(arg_36_1)
	self.commanderPrefabs = arg_36_1

	return
end

function ActivityBossSceneTemplate:openCommanderPanel(arg_37_1, arg_37_2)
	local var_37_0 = self.contextData.activityID

	self.levelCMDFormationView:setCallback(function(arg_38_0)
		if arg_38_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			self:emit(ActivityBossMediatorTemplate.ON_COMMANDER_SKILL, arg_38_0.skill)
		elseif arg_38_0.type == LevelUIConst.COMMANDER_OP_ADD then
			self.contextData.eliteCommanderSelected = {
				fleetIndex = arg_37_2,
				cmdPos = arg_38_0.pos,
				mode = self.curMode
			}

			self:emit(ActivityBossMediatorTemplate.ON_SELECT_COMMANDER, arg_37_2, arg_38_0.pos)
		else
			self:emit(ActivityBossMediatorTemplate.COMMANDER_FORMATION_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_ACTIVITY,
				data = arg_38_0,
				fleetId = arg_37_1.id,
				actId = var_37_0
			})
		end

		return
	end)
	self.levelCMDFormationView:Load()
	self.levelCMDFormationView:ActionInvoke("update", arg_37_1, self.commanderPrefabs)
	self.levelCMDFormationView:ActionInvoke("Show")

	return
end

function ActivityBossSceneTemplate:updateCommanderFleet(arg_39_1)
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("updateFleet", arg_39_1)
	end

	return
end

function ActivityBossSceneTemplate:updateCommanderPrefab()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("updatePrefabs", self.commanderPrefabs)
	end

	return
end

function ActivityBossSceneTemplate:closeCommanderPanel()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("Hide")
	end

	return
end

function ActivityBossSceneTemplate:buildCommanderPanel()
	self.levelCMDFormationView = LevelCMDFormationView.New(self._tf, self.event, self.contextData)

	return
end

function ActivityBossSceneTemplate:destroyCommanderPanel()
	self.levelCMDFormationView:Destroy()

	self.levelCMDFormationView = nil

	return
end

function ActivityBossSceneTemplate:ShowAwards()
	local var_44_0 = self:GetBonusWindow()

	var_44_0.buffer:UpdateView(self.contextData.ptData)
	var_44_0.buffer:Show()

	return
end

function ActivityBossSceneTemplate:CreateNewFleet(arg_45_1)
	local var_45_0 = {
		id = arg_45_1,
		ship_list = {},
		commanders = {}
	}

	if arg_45_1 > 10 then
		var_45_0.fleetType = FleetType.Submarine or FleetType.Normal
	end

	return TypedFleet.New(var_45_0)
end

function ActivityBossSceneTemplate:UpdateRank(arg_46_1)
	arg_46_1 = arg_46_1 or {}

	for iter_46_0 = 1, #self.rankList do
		local var_46_0 = self.rankList[iter_46_0]

		setActive(self.rankList[iter_46_0], iter_46_0 <= #arg_46_1)

		if iter_46_0 <= #arg_46_1 then
			setText(var_46_0:Find("Text"), tostring(arg_46_1[iter_46_0].name))
		end
	end

	return
end

function ActivityBossSceneTemplate:UpdateDropItems()
	for iter_47_0, iter_47_1 in ipairs(self.contextData.DisplayItems or {}) do
		local var_47_1 = Drop.New({
			type = self.contextData.DisplayItems[5 - iter_47_0][1],
			id = self.contextData.DisplayItems[5 - iter_47_0][2],
			count = self.contextData.DisplayItems[5 - iter_47_0][3]
		})

		onButton(self, self.barList[iter_47_0]:Find("milestone/item"), function()
			self:emit(ActivityBossSceneTemplate.ON_DROP, var_47_1)

			return
		end, SFX_PANEL)
	end

	return
end

function ActivityBossSceneTemplate:onBackPressed()
	if self.bonusWindow and self.bonusWindow:IsShowing() then
		self.bonusWindow.buffer:Hide()

		return
	end

	ActivityBossSceneTemplate.super.onBackPressed(self)

	return
end

function ActivityBossSceneTemplate:willExit()
	self:DestroyBonusWindow()
	self:DestroyFleetEditPanel()
	self:destroyCommanderPanel()

	return
end

return ActivityBossSceneTemplate
