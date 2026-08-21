local var_0_0 = class("ActivityBossSceneTemplate", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	error("Need Complete")

	return
end

function var_0_0.getGroupName(arg_2_0)
	return "ActivityBossSceneTemplate"
end

var_0_0.optionsPath = {
	"adapt/top/option"
}

function var_0_0.init(arg_3_0)
	arg_3_0.mainTF = arg_3_0._tf:Find("adapt")
	arg_3_0.bg = arg_3_0._tf:Find("bg")
	arg_3_0.bottom = arg_3_0.mainTF:Find("bottom")
	arg_3_0.hpBar = arg_3_0.bottom:Find("progress")
	arg_3_0.barList = {}

	for iter_3_0 = 1, 4 do
		arg_3_0.barList[iter_3_0] = arg_3_0.hpBar:Find(iter_3_0)
	end

	arg_3_0.progressDigit = arg_3_0.bottom:Find("digit")
	arg_3_0.digitbig = arg_3_0.progressDigit:Find("big")
	arg_3_0.digitsmall = arg_3_0.progressDigit:Find("small")
	arg_3_0.left = arg_3_0.mainTF:Find("left")
	arg_3_0.rankTF = arg_3_0.left:Find("rank")
	arg_3_0.rankList = CustomIndexLayer.Clone2Full(arg_3_0.rankTF:Find("layout"), 3)

	for iter_3_1, iter_3_2 in ipairs(arg_3_0.rankList) do
		setActive(iter_3_2, false)
	end

	arg_3_0.right = arg_3_0.mainTF:Find("right")
	arg_3_0.stageList = {}

	for iter_3_3 = 1, 4 do
		arg_3_0.stageList[iter_3_3] = arg_3_0.right:Find(iter_3_3)
	end

	arg_3_0.stageSP = arg_3_0.right:Find("5")

	if not IsNil(arg_3_0.stageSP) then
		setActive(arg_3_0.stageSP, false)
	end

	arg_3_0.awardFlash = arg_3_0.right:Find("ptaward/flash")
	arg_3_0.awardBtn = arg_3_0.right:Find("ptaward/button")
	arg_3_0.ptScoreTxt = arg_3_0.right:Find("ptaward/Text")
	arg_3_0.top = arg_3_0.mainTF:Find("top")
	arg_3_0.ticketNum = arg_3_0.top:Find("ticket/Text")
	arg_3_0.helpBtn = arg_3_0.top:Find("help")

	onButton(arg_3_0, arg_3_0.top:Find("back_btn"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)
	setActive(arg_3_0.top, false)
	setAnchoredPosition(arg_3_0.top, {
		y = 1080
	})
	setActive(arg_3_0.left, false)
	setAnchoredPosition(arg_3_0.left, {
		x = -1920
	})
	setActive(arg_3_0.right, false)
	setAnchoredPosition(arg_3_0.right, {
		x = 1920
	})
	setActive(arg_3_0.bottom, false)
	setAnchoredPosition(arg_3_0.bottom, {
		y = -1080
	})
	arg_3_0:buildCommanderPanel()

	return
end

function var_0_0.GetBonusWindow(arg_5_0)
	if not arg_5_0.bonusWindow then
		arg_5_0.bonusWindow = ActivityBossPtAwardSubPanel.New(arg_5_0)

		arg_5_0.bonusWindow:Load()
	end

	return arg_5_0.bonusWindow
end

function var_0_0.DestroyBonusWindow(arg_6_0)
	if arg_6_0.bonusWindow then
		arg_6_0.bonusWindow:Destroy()

		arg_6_0.bonusWindow = nil
	end

	return
end

function var_0_0.GetFleetEditPanel(arg_7_0)
	if not arg_7_0.fleetEditPanel then
		arg_7_0.fleetEditPanel = ActivityBossBattleFleetSelectSubPanel.New(arg_7_0)

		arg_7_0.fleetEditPanel:Load()
	end

	return arg_7_0.fleetEditPanel
end

function var_0_0.DestroyFleetEditPanel(arg_8_0)
	if arg_8_0.fleetEditPanel then
		arg_8_0.fleetEditPanel:Destroy()

		arg_8_0.fleetEditPanel = nil
	end

	return
end

function var_0_0.EnterAnim(arg_9_0)
	setActive(arg_9_0.top, true)
	setActive(arg_9_0.left, true)
	setActive(arg_9_0.right, true)
	setActive(arg_9_0.bottom, true)
	arg_9_0.mainTF:GetComponent("Animation"):Play("Enter_Animation")

	return
end

function var_0_0.didEnter(arg_10_0)
	onButton(arg_10_0, arg_10_0.awardBtn, function()
		arg_10_0:ShowAwards()

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_boss_help.tip
		})

		return
	end, SFX_PANEL)
	arg_10_0:UpdateDropItems()

	for iter_10_0 = 1, #arg_10_0.stageList - 1 do
		onButton(arg_10_0, arg_10_0.stageList[iter_10_0], function()
			if arg_10_0.contextData.activity:checkBattleTimeInBossAct() then
				arg_10_0:ShowNormalFleet(iter_10_0, true)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			end

			return
		end, SFX_PANEL)
	end

	onButton(arg_10_0, arg_10_0.stageList[#arg_10_0.stageList], function()
		if arg_10_0.contextData.activity:checkBattleTimeInBossAct() then
			arg_10_0:ShowEXFleet()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)

	if not IsNil(arg_10_0.stageSP) then
		setActive(arg_10_0.stageSP, arg_10_0.contextData.spStageID)
		onButton(arg_10_0, arg_10_0.stageSP, function()
			if arg_10_0.contextData.activity:checkBattleTimeInBossAct() then
				arg_10_0:emit(ActivityBossMediatorTemplate.ONEN_BUFF_SELECT)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			end

			return
		end, SFX_PANEL)
	end

	if arg_10_0.contextData.editFleet then
		if arg_10_0.contextData.editFleet <= #arg_10_0.contextData.normalStageIDs then
			arg_10_0:ShowNormalFleet(arg_10_0.contextData.editFleet)
		elseif arg_10_0.contextData.editFleet == #arg_10_0.contextData.normalStageIDs + 1 then
			arg_10_0:ShowEXFleet()
		elseif arg_10_0.contextData.editFleet == #arg_10_0.contextData.normalStageIDs + 2 then
			arg_10_0:ShowSPFleet()
		end
	end

	arg_10_0:EnterAnim()

	if arg_10_0.contextData.msg then
		local var_10_0 = arg_10_0.contextData.msg.param

		switch(arg_10_0.contextData.msg.type, {
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
						arg_10_0:emit(PreCombatMediator.BEGIN_STAGE_PROXY, {
							curFleetId = var_10_0.id
						})
					end

					return
				end)

				return
			end
		})

		arg_10_0.contextData.msg = nil
	end

	return
end

function var_0_0.UpdateView(arg_22_0)
	arg_22_0:UpdatePage()
	arg_22_0:CheckStory()

	return
end

function var_0_0.CheckStory(arg_23_0)
	local var_23_0 = pg.NewStoryMgr.GetInstance()

	table.SerialIpairsAsync(arg_23_0.contextData.activity:getConfig("config_client").story, function(arg_24_0, arg_24_1, arg_24_2)
		if arg_23_0.contextData.bossHP < arg_24_1[1] + ((arg_24_0 == 1 or arg_24_1[1] == 0) and 1 or 0) then
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

function var_0_0.UpdatePage(arg_25_0)
	setText(arg_25_0.digitbig, math.floor(arg_25_0.contextData.bossHP / 100))
	setText(arg_25_0.digitsmall, string.format("%02d", arg_25_0.contextData.bossHP % 100) .. "%")

	local var_25_0 = pg.TimeMgr.GetInstance()

	for iter_25_0 = 1, 4 do
		setSlider(arg_25_0.barList[iter_25_0]:Find("Slider"), 0, 2500, math.min(math.max(arg_25_0.contextData.bossHP - (iter_25_0 - 1) * 2500, 0), 2500))
		setActive(arg_25_0.barList[iter_25_0]:Find("milestone/item"), not arg_25_0.contextData.mileStones[5 - iter_25_0])
		setActive(arg_25_0.barList[iter_25_0]:Find("milestone/time"), arg_25_0.contextData.mileStones[5 - iter_25_0])

		if arg_25_0.contextData.mileStones[5 - iter_25_0] then
			setText(arg_25_0.barList[iter_25_0]:Find("milestone/time/Text"), (var_25_0:STimeDescC(arg_25_0.contextData.mileStones[5 - iter_25_0], "%m/%d/%H:%M")))
		end
	end

	for iter_25_1 = 1, #arg_25_0.stageList - 1 do
		for iter_25_2, iter_25_3 in ipairs(arg_25_0.contextData.ticketInitPools) do
			for iter_25_4, iter_25_5 in ipairs(iter_25_3[1]) do
				if iter_25_5 == arg_25_0.contextData.normalStageIDs[iter_25_1] then
					local var_25_3 = arg_25_0.contextData.stageTickets[arg_25_0.contextData.normalStageIDs[iter_25_1]] or 0

					setActive(var_25_1:Find("Text"), var_25_3 > 0)
					setText(var_25_1:Find("Text"), string.format("%d/%d", var_25_3, var_25_2))
				end
			end
		end
	end

	setText(arg_25_0.ptScoreTxt, arg_25_0.contextData.ptData.count)
	setActive(arg_25_0.awardFlash, arg_25_0.contextData.ptData:CanGetAward())

	if arg_25_0.bonusWindow and arg_25_0.bonusWindow:IsShowing() then
		arg_25_0.bonusWindow.buffer:UpdateView(arg_25_0.contextData.ptData)
	end

	setText(arg_25_0.ticketNum, (arg_25_0:GetEXTicket()))

	return
end

function var_0_0.GetEXTicket(arg_26_0)
	return getProxy(PlayerProxy):getRawData():getResource(arg_26_0.contextData.TicketID)
end

function var_0_0.ShowNormalFleet(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.contextData.actFleets[arg_27_1] = arg_27_0.contextData.actFleets[arg_27_1] or arg_27_0:CreateNewFleet(arg_27_1)
	arg_27_0.contextData.actFleets[arg_27_1 + 10] = arg_27_0.contextData.actFleets[arg_27_1 + 10] or arg_27_0:CreateNewFleet(arg_27_1 + 10)

	local var_27_0 = arg_27_0.contextData.actFleets[arg_27_1]

	if arg_27_2 and #var_27_0.ships <= 0 then
		for iter_27_0 = #arg_27_0.contextData.normalStageIDs, 1, -1 do
			if iter_27_0 ~= arg_27_1 and arg_27_0.contextData.actFleets[iter_27_0] and arg_27_0.contextData.actFleets[iter_27_0]:isLegalToFight() == true then
				var_27_0:updateShips(arg_27_0.contextData.actFleets[iter_27_0].ships)

				break
			end
		end
	end

	local var_27_1 = arg_27_0:GetFleetEditPanel()

	var_27_1.buffer:SetSettings(1, 1, false)
	var_27_1.buffer:SetFleets({
		arg_27_0.contextData.actFleets[arg_27_1],
		arg_27_0.contextData.actFleets[arg_27_1 + 10]
	})

	local var_27_2 = arg_27_0.contextData.useOilLimit[arg_27_1]

	if not arg_27_0.contextData.activity:IsOilLimit(arg_27_0.contextData.normalStageIDs[arg_27_1]) then
		var_27_2 = {
			0,
			0
		}
	end

	var_27_1.buffer:SetOilLimit(var_27_2)

	arg_27_0.contextData.editFleet = arg_27_1

	var_27_1.buffer:UpdateView()
	var_27_1.buffer:Show()

	return
end

function var_0_0.ShowEXFleet(arg_28_0)
	arg_28_0.contextData.actFleets[#arg_28_0.contextData.normalStageIDs + 1] = arg_28_0.contextData.actFleets[#arg_28_0.contextData.normalStageIDs + 1] or arg_28_0:CreateNewFleet(#arg_28_0.contextData.normalStageIDs + 1)
	arg_28_0.contextData.actFleets[#arg_28_0.contextData.normalStageIDs + 1 + 10] = arg_28_0.contextData.actFleets[#arg_28_0.contextData.normalStageIDs + 1 + 10] or arg_28_0:CreateNewFleet(#arg_28_0.contextData.normalStageIDs + 1 + 10)

	local var_28_0 = arg_28_0:GetFleetEditPanel()

	var_28_0.buffer:SetSettings(1, 1, true)
	var_28_0.buffer:SetFleets({
		arg_28_0.contextData.actFleets[#arg_28_0.contextData.normalStageIDs + 1],
		arg_28_0.contextData.actFleets[#arg_28_0.contextData.normalStageIDs + 1 + 10]
	})

	local var_28_1 = arg_28_0.contextData.useOilLimit[#arg_28_0.contextData.normalStageIDs + 1]

	if not arg_28_0.contextData.activity:IsOilLimit(arg_28_0.contextData.exStageID) then
		var_28_1 = {
			0,
			0
		}
	end

	var_28_0.buffer:SetOilLimit(var_28_1)

	arg_28_0.contextData.editFleet = #arg_28_0.contextData.normalStageIDs + 1

	var_28_0.buffer:UpdateView()
	var_28_0.buffer:Show()

	return
end

function var_0_0.ShowSPFleet(arg_29_0)
	arg_29_0.contextData.actFleets[#arg_29_0.contextData.normalStageIDs + 2] = arg_29_0.contextData.actFleets[#arg_29_0.contextData.normalStageIDs + 2] or arg_29_0:CreateNewFleet(#arg_29_0.contextData.normalStageIDs + 2)
	arg_29_0.contextData.actFleets[#arg_29_0.contextData.normalStageIDs + 2 + 10] = arg_29_0.contextData.actFleets[#arg_29_0.contextData.normalStageIDs + 2 + 10] or arg_29_0:CreateNewFleet(#arg_29_0.contextData.normalStageIDs + 2 + 10)

	local var_29_0 = arg_29_0:GetFleetEditPanel()

	var_29_0.buffer:SetSettings(1, 1, false)
	var_29_0.buffer:SetFleets({
		arg_29_0.contextData.actFleets[#arg_29_0.contextData.normalStageIDs + 2],
		arg_29_0.contextData.actFleets[#arg_29_0.contextData.normalStageIDs + 2 + 10]
	})
	var_29_0.buffer:SetOilLimit({
		0,
		0
	})

	arg_29_0.contextData.editFleet = #arg_29_0.contextData.normalStageIDs + 2

	var_29_0.buffer:UpdateView()
	var_29_0.buffer:Show()

	return
end

function var_0_0.commitEdit(arg_30_0)
	arg_30_0:emit(arg_30_0.contextData.mediatorClass.ON_COMMIT_FLEET)

	return
end

function var_0_0.commitCombat(arg_31_0)
	if arg_31_0.contextData.editFleet <= #arg_31_0.contextData.normalStageIDs then
		arg_31_0:emit(arg_31_0.contextData.mediatorClass.ON_PRECOMBAT, arg_31_0.contextData.editFleet)
	elseif arg_31_0.contextData.editFleet == #arg_31_0.contextData.normalStageIDs + 1 then
		arg_31_0:emit(arg_31_0.contextData.mediatorClass.ON_EX_PRECOMBAT, arg_31_0.contextData.editFleet, false)
	elseif arg_31_0.contextData.editFleet <= #arg_31_0.contextData.normalStageIDs + 2 then
		arg_31_0:emit(arg_31_0.contextData.mediatorClass.ON_SP_PRECOMBAT, arg_31_0.contextData.editFleet, false)
	end

	return
end

function var_0_0.commitTrybat(arg_32_0)
	arg_32_0:emit(arg_32_0.contextData.mediatorClass.ON_EX_PRECOMBAT, arg_32_0.contextData.editFleet, true)

	return
end

function var_0_0.updateEditPanel(arg_33_0)
	if arg_33_0.fleetEditPanel then
		arg_33_0.fleetEditPanel.buffer:UpdateView()
	end

	return
end

function var_0_0.hideFleetEdit(arg_34_0)
	if arg_34_0.fleetEditPanel then
		arg_34_0.fleetEditPanel.buffer:Hide()
	end

	if arg_34_0.commanderFormationPanel then
		arg_34_0.commanderFormationPanel.buffer:Close()
	end

	arg_34_0.contextData.editFleet = nil

	return
end

function var_0_0.openShipInfo(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = {}
	local var_35_1 = getProxy(BayProxy)

	if arg_35_0.contextData.actFleets[arg_35_2] then
		local var_35_3 = arg_35_0.contextData.actFleets[arg_35_2].ships or {}

		for iter_35_0, iter_35_1 in var_35_2(var_35_3) do
			table.insert(var_35_0, var_35_1:getShipById(iter_35_1))
		end

		arg_35_0:emit(arg_35_0.contextData.mediatorClass.ON_FLEET_SHIPINFO, {
			shipId = arg_35_1,
			shipVOs = var_35_0
		})

		return
	end
end

function var_0_0.setCommanderPrefabs(arg_36_0, arg_36_1)
	arg_36_0.commanderPrefabs = arg_36_1

	return
end

function var_0_0.openCommanderPanel(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.contextData.activityID

	arg_37_0.levelCMDFormationView:setCallback(function(arg_38_0)
		if arg_38_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			arg_37_0:emit(ActivityBossMediatorTemplate.ON_COMMANDER_SKILL, arg_38_0.skill)
		elseif arg_38_0.type == LevelUIConst.COMMANDER_OP_ADD then
			arg_37_0.contextData.eliteCommanderSelected = {
				fleetIndex = arg_37_2,
				cmdPos = arg_38_0.pos,
				mode = arg_37_0.curMode
			}

			arg_37_0:emit(ActivityBossMediatorTemplate.ON_SELECT_COMMANDER, arg_37_2, arg_38_0.pos)
		else
			arg_37_0:emit(ActivityBossMediatorTemplate.COMMANDER_FORMATION_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_ACTIVITY,
				data = arg_38_0,
				fleetId = arg_37_1.id,
				actId = var_37_0
			})
		end

		return
	end)
	arg_37_0.levelCMDFormationView:Load()
	arg_37_0.levelCMDFormationView:ActionInvoke("update", arg_37_1, arg_37_0.commanderPrefabs)
	arg_37_0.levelCMDFormationView:ActionInvoke("Show")

	return
end

function var_0_0.updateCommanderFleet(arg_39_0, arg_39_1)
	if arg_39_0.levelCMDFormationView:isShowing() then
		arg_39_0.levelCMDFormationView:ActionInvoke("updateFleet", arg_39_1)
	end

	return
end

function var_0_0.updateCommanderPrefab(arg_40_0)
	if arg_40_0.levelCMDFormationView:isShowing() then
		arg_40_0.levelCMDFormationView:ActionInvoke("updatePrefabs", arg_40_0.commanderPrefabs)
	end

	return
end

function var_0_0.closeCommanderPanel(arg_41_0)
	if arg_41_0.levelCMDFormationView:isShowing() then
		arg_41_0.levelCMDFormationView:ActionInvoke("Hide")
	end

	return
end

function var_0_0.buildCommanderPanel(arg_42_0)
	arg_42_0.levelCMDFormationView = LevelCMDFormationView.New(arg_42_0._tf, arg_42_0.event, arg_42_0.contextData)

	return
end

function var_0_0.destroyCommanderPanel(arg_43_0)
	arg_43_0.levelCMDFormationView:Destroy()

	arg_43_0.levelCMDFormationView = nil

	return
end

function var_0_0.ShowAwards(arg_44_0)
	local var_44_0 = arg_44_0:GetBonusWindow()

	var_44_0.buffer:UpdateView(arg_44_0.contextData.ptData)
	var_44_0.buffer:Show()

	return
end

function var_0_0.CreateNewFleet(arg_45_0, arg_45_1)
	local var_45_1 = {
		id = arg_45_1,
		ship_list = {},
		commanders = {}
	}

	if arg_45_1 > 10 then
		var_45_1.fleetType = FleetType.Submarine or FleetType.Normal

		return var_45_0(var_45_1)
	end
end

function var_0_0.UpdateRank(arg_46_0, arg_46_1)
	arg_46_1 = arg_46_1 or {}

	for iter_46_0 = 1, #arg_46_0.rankList do
		setActive(arg_46_0.rankList[iter_46_0], iter_46_0 <= #arg_46_1)

		if iter_46_0 <= #arg_46_1 then
			setText(var_46_0:Find("Text"), tostring(arg_46_1[iter_46_0].name))
		end
	end

	return
end

function var_0_0.UpdateDropItems(arg_47_0)
	local var_47_0 = arg_47_0.contextData.DisplayItems or {}

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		local var_47_1 = Drop.New({
			type = arg_47_0.contextData.DisplayItems[5 - iter_47_0][1],
			id = arg_47_0.contextData.DisplayItems[5 - iter_47_0][2],
			count = arg_47_0.contextData.DisplayItems[5 - iter_47_0][3]
		})

		onButton(arg_47_0, arg_47_0.barList[iter_47_0]:Find("milestone/item"), function()
			arg_47_0:emit(var_0_0.ON_DROP, var_47_1)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.onBackPressed(arg_49_0)
	if arg_49_0.bonusWindow and arg_49_0.bonusWindow:IsShowing() then
		arg_49_0.bonusWindow.buffer:Hide()

		return
	end

	var_0_0.super.onBackPressed(arg_49_0)

	return
end

function var_0_0.willExit(arg_50_0)
	arg_50_0:DestroyBonusWindow()
	arg_50_0:DestroyFleetEditPanel()
	arg_50_0:destroyCommanderPanel()

	return
end

return var_0_0
