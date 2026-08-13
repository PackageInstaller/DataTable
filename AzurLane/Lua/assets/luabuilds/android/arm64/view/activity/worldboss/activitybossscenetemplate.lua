class = var_0_10000

local var_0_0 = "ActivityBossSceneTemplate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	error = var_1_10001

	var_1_10001("Need Complete")

	return
end

function var_0_1.getGroupName(arg_2_0)
	return "ActivityBossSceneTemplate"
end

var_0_1.optionsPath = {
	"adapt/top/option"
}

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.mainTF = var_1.Find(var_3_0, "adapt")

	local var_3_1 = arg_3_0._tf

	arg_3_0.bg = var_1.Find(var_3_1, "bg")

	local var_3_2 = arg_3_0.mainTF

	arg_3_0.bottom = var_1.Find(var_3_2, "bottom")

	local var_3_3 = arg_3_0.bottom

	arg_3_0.hpBar = var_1.Find(var_3_3, "progress")
	arg_3_0.barList = {}

	for iter_3_0 = 1, 4 do
		local var_3_4 = arg_3_0.barList
		local var_3_5 = arg_3_0.hpBar

		var_3_4[iter_3_0] = var_6.Find(var_3_5, iter_3_0)
	end

	local var_3_6 = arg_3_0.bottom

	arg_3_0.progressDigit = var_1.Find(var_3_6, "digit")

	local var_3_7 = arg_3_0.progressDigit

	arg_3_0.digitbig = var_1.Find(var_3_7, "big")

	local var_3_8 = arg_3_0.progressDigit

	arg_3_0.digitsmall = var_1.Find(var_3_8, "small")

	local var_3_9 = arg_3_0.mainTF

	arg_3_0.left = var_1.Find(var_3_9, "left")

	local var_3_10 = arg_3_0.left

	arg_3_0.rankTF = var_1.Find(var_3_10, "rank")
	CustomIndexLayer = var_1

	local var_3_11 = var_1.Clone2Full
	local var_3_12 = arg_3_0.rankTF

	arg_3_0.rankList = var_3_11(var_3.Find(var_3_12, "layout"), 3)
	ipairs = var_1

	for iter_3_1, iter_3_2 in var_1(arg_3_0.rankList) do
		setActive = var_6

		var_6(iter_3_2, false)
	end

	local var_3_13 = arg_3_0.mainTF

	arg_3_0.right = var_1.Find(var_3_13, "right")
	arg_3_0.stageList = {}

	for iter_3_3 = 1, 4 do
		local var_3_14 = arg_3_0.stageList
		local var_3_15 = arg_3_0.right

		var_3_14[iter_3_3] = var_6.Find(var_3_15, iter_3_3)
	end

	local var_3_16 = arg_3_0.right

	arg_3_0.stageSP = var_1.Find(var_3_16, "5")
	IsNil = var_1

	if not var_1(arg_3_0.stageSP) then
		setActive = var_1

		var_1(arg_3_0.stageSP, false)
	end

	local var_3_17 = arg_3_0.right

	arg_3_0.awardFlash = var_1.Find(var_3_17, "ptaward/flash")

	local var_3_18 = arg_3_0.right

	arg_3_0.awardBtn = var_1.Find(var_3_18, "ptaward/button")

	local var_3_19 = arg_3_0.right

	arg_3_0.ptScoreTxt = var_1.Find(var_3_19, "ptaward/Text")

	local var_3_20 = arg_3_0.mainTF

	arg_3_0.top = var_1.Find(var_3_20, "top")

	local var_3_21 = arg_3_0.top

	arg_3_0.ticketNum = var_1.Find(var_3_21, "ticket/Text")

	local var_3_22 = arg_3_0.top

	arg_3_0.helpBtn = var_1.Find(var_3_22, "help")
	onButton = var_1

	local var_3_23 = arg_3_0
	local var_3_24 = arg_3_0.top
	local var_3_25 = var_4.Find(var_3_24, "back_btn")

	local function var_3_26()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_3_24

	var_1(var_3_23, var_3_25, var_3_26, var_3_24)

	setActive = var_1

	var_1(arg_3_0.top, false)

	setAnchoredPosition = var_1

	var_1(arg_3_0.top, {
		y = 1080
	})

	setActive = var_1

	var_1(arg_3_0.left, false)

	setAnchoredPosition = var_1

	var_1(arg_3_0.left, {
		x = -1920
	})

	setActive = var_1

	var_1(arg_3_0.right, false)

	setAnchoredPosition = var_1

	var_1(arg_3_0.right, {
		x = 1920
	})

	setActive = var_1

	var_1(arg_3_0.bottom, false)

	setAnchoredPosition = var_1

	var_1(arg_3_0.bottom, {
		y = -1080
	})
	arg_3_0:buildCommanderPanel()

	return
end

function var_0_1.GetBonusWindow(arg_5_0)
	if not arg_5_0.bonusWindow then
		ActivityBossPtAwardSubPanel = var_1
		arg_5_0.bonusWindow = var_1.New(arg_5_0)

		local var_5_0 = arg_5_0.bonusWindow

		var_1.Load(var_5_0)
	end

	return arg_5_0.bonusWindow
end

function var_0_1.DestroyBonusWindow(arg_6_0)
	if arg_6_0.bonusWindow then
		local var_6_0 = arg_6_0.bonusWindow

		var_1.Destroy(var_6_0)

		arg_6_0.bonusWindow = nil
	end

	return
end

function var_0_1.GetFleetEditPanel(arg_7_0)
	if not arg_7_0.fleetEditPanel then
		ActivityBossBattleFleetSelectSubPanel = var_1
		arg_7_0.fleetEditPanel = var_1.New(arg_7_0)

		local var_7_0 = arg_7_0.fleetEditPanel

		var_1.Load(var_7_0)
	end

	return arg_7_0.fleetEditPanel
end

function var_0_1.DestroyFleetEditPanel(arg_8_0)
	if arg_8_0.fleetEditPanel then
		local var_8_0 = arg_8_0.fleetEditPanel

		var_1.Destroy(var_8_0)

		arg_8_0.fleetEditPanel = nil
	end

	return
end

function var_0_1.EnterAnim(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.top, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.left, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.right, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.bottom, true)

	local var_9_0 = arg_9_0.mainTF
	local var_9_1 = var_1.GetComponent(var_9_0, "Animation")

	var_1.Play(var_9_1, "Enter_Animation")

	return
end

function var_0_1.didEnter(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.awardBtn

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.ShowAwards(var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10006)

	onButton = var_1_10001

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.helpBtn

	local function var_10_5()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_12_2.type = var_2_10004
		pg = var_2_10004
		var_12_2.helps = var_2_10004.gametip.world_boss_help.tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_3, var_10_4, var_10_5, var_1_10006)
	arg_10_0:UpdateDropItems()

	for iter_10_0 = 1, #arg_10_0.stageList - 1 do
		onButton = var_10_5

		local var_10_6 = arg_10_0
		local var_10_7 = arg_10_0.stageList[iter_10_0]

		local function var_10_8()
			local var_13_0 = arg_10_0.contextData.activity

			if var_0.checkBattleTimeInBossAct(var_13_0) then
				local var_13_1 = arg_10_0

				var_0.ShowNormalFleet(var_13_1, iter_10_0, true)
			else
				pg = var_0

				local var_13_2 = var_0.TipsMgr.GetInstance()
				local var_13_3 = var_0.ShowTips

				i18n = var_2_10003

				var_13_3(var_13_2, var_2_10003("common_activity_end"))
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_10_5(var_10_6, var_10_7, var_10_8, var_1_10010)
	end

	onButton = var_1

	local var_10_9 = arg_10_0
	local var_10_10 = arg_10_0.stageList[#arg_10_0.stageList]

	local function var_10_11()
		local var_14_0 = arg_10_0.contextData.activity

		if var_0.checkBattleTimeInBossAct(var_14_0) then
			local var_14_1 = arg_10_0

			var_0.ShowEXFleet(var_14_1)
		else
			pg = var_0

			local var_14_2 = var_0.TipsMgr.GetInstance()
			local var_14_3 = var_0.ShowTips

			i18n = var_2_10003

			var_14_3(var_14_2, var_2_10003("common_activity_end"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_10_9, var_10_10, var_10_11, var_1_10006)

	IsNil = var_1

	if not var_1(arg_10_0.stageSP) then
		setActive = var_1

		var_1(arg_10_0.stageSP, arg_10_0.contextData.spStageID)

		onButton = var_1

		local var_10_12 = arg_10_0
		local var_10_13 = arg_10_0.stageSP

		local function var_10_14()
			local var_15_0 = arg_10_0.contextData.activity
			local var_15_2

			if var_0.checkBattleTimeInBossAct(var_15_0) then
				local var_15_1 = arg_10_0

				var_15_2 = var_15_2.emit
				ActivityBossMediatorTemplate = var_2_10003

				var_15_2(var_15_1, var_2_10003.ONEN_BUFF_SELECT)
			else
				pg = var_15_2

				local var_15_3 = var_15_2.TipsMgr.GetInstance()
				local var_15_4 = var_0.ShowTips

				i18n = var_2_10003

				var_15_4(var_15_3, var_2_10003("common_activity_end"))
			end

			return
		end

		SFX_PANEL = var_1_10006

		var_1(var_10_12, var_10_13, var_10_14, var_1_10006)
	end

	if arg_10_0.contextData.editFleet then
		if arg_10_0.contextData.editFleet <= #arg_10_0.contextData.normalStageIDs then
			arg_10_0:ShowNormalFleet(var_1)
		elseif arg_10_0.contextData.editFleet == #arg_10_0.contextData.normalStageIDs + 1 then
			arg_10_0:ShowEXFleet()
		elseif arg_10_0.contextData.editFleet == #arg_10_0.contextData.normalStageIDs + 2 then
			arg_10_0:ShowSPFleet()
		end
	end

	arg_10_0:EnterAnim()

	if arg_10_0.contextData.msg then
		local var_10_15 = arg_10_0.contextData.msg.param

		switch = var_2

		var_2(arg_10_0.contextData.msg.type, {
			lastBonus = function()
				pg = var_2_10000

				local var_16_0 = var_2_10000.MsgboxMgr.GetInstance()

				var_0.ShowMsgBox(var_16_0, var_10_15)

				return
			end,
			oil = function()
				ItemTipPanel = var_2_10000

				if not var_2_10000.ShowOilBuyTip(var_10_15) then
					pg = var_0

					local var_17_0 = var_0.TipsMgr.GetInstance()
					local var_17_1 = var_0.ShowTips

					i18n = var_2_10003

					var_17_1(var_17_0, var_2_10003("stage_beginStage_error_noResource"))
				end

				return
			end,
			shipCapacity = function()
				BeginStageCommand = var_2_10000

				var_2_10000.DockOverload()

				return
			end,
			energy = function()
				Fleet = var_2_10000

				local var_19_0 = var_2_10000.EnergyCheck

				_ = var_2_10002

				local var_19_1 = var_2_10002.map

				_ = var_2_10004

				local var_19_2 = var_19_1(var_2_10004.values(var_10_15.ships), function(arg_20_0)
					getProxy = var_3_10001
					BayProxy = var_3_10003

					local var_20_0 = var_3_10001(var_3_10003)

					return var_1.getShipById(var_20_0, arg_20_0)
				end)

				Fleet = var_2_10003

				var_19_0(var_19_2, var_2_10003.DEFAULT_NAME_BOSS_ACT[var_10_15.id], function(arg_21_0)
					if arg_21_0 then
						local var_21_0 = arg_10_0
						local var_21_1 = var_1.emit

						PreCombatMediator = var_3_10004

						var_21_1(var_21_0, var_3_10004.BEGIN_STAGE_PROXY, {
							curFleetId = var_10_15.id
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

function var_0_1.UpdateView(arg_22_0)
	arg_22_0:UpdatePage()
	arg_22_0:CheckStory()

	return
end

function var_0_1.CheckStory(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.NewStoryMgr.GetInstance()
	local var_23_1 = arg_23_0.contextData.activity
	local var_23_2 = var_2.getConfig(var_23_1, "config_client").story

	table = var_1_10003

	var_1_10003.SerialIpairsAsync(var_23_2, function(arg_24_0, arg_24_1, arg_24_2)
		if arg_23_0.contextData.bossHP < arg_24_1[1] + ((arg_24_0 == 1 or arg_24_1[1] == 0) and 1 or 0) then
			pg = var_3

			local var_24_0 = var_3.NewStoryMgr.GetInstance()

			if not var_3.IsPlayed(var_24_0, arg_24_1[2]) then
				local var_24_1 = var_23_0

				var_3.Play(var_24_1, arg_24_1[2], arg_24_2)

				return
			end
		end

		arg_24_2()

		return
	end)

	return
end

function var_0_1.UpdatePage(arg_25_0)
	local var_25_0 = arg_25_0.contextData.bossHP

	setText = var_1_10002

	local var_25_1 = arg_25_0.digitbig

	math = var_1_10005

	var_1_10002(var_25_1, var_1_10005.floor(var_25_0 / 100))

	setText = var_1_10002

	local var_25_2 = arg_25_0.digitsmall

	string = var_5

	var_1_10002(var_25_2, var_5.format("%02d", var_25_0 % 100) .. "%")

	pg = var_1_10002

	local var_25_3 = var_1_10002.TimeMgr.GetInstance()

	for iter_25_0 = 1, 4 do
		local var_25_4 = arg_25_0.barList[iter_25_0]

		setSlider = var_25_9

		local var_25_5 = var_25_4:Find("Slider")
		local var_25_6 = 0
		local var_25_7 = 2500

		math = var_13

		local var_25_8 = var_13.min

		math = var_1_10015

		var_25_9(var_25_5, var_25_6, var_25_7, var_25_8(var_1_10015.max(var_25_0 - (iter_25_0 - 1) * 2500, 0), 2500))

		local var_25_9 = arg_25_0.contextData.mileStones[5 - iter_25_0]

		setActive = var_1_10009

		var_1_10009(var_25_4:Find("milestone/item"), not var_25_9)

		setActive = var_1_10009

		var_1_10009(var_25_4:Find("milestone/time"), var_25_9)

		if var_25_9 then
			var_1_10009 = var_25_3:STimeDescC(arg_25_0.contextData.mileStones[5 - iter_25_0], "%m/%d/%H:%M")
			setText = var_25_5
			var_1_10014 = var_25_4

			var_25_5(var_25_4.Find(var_1_10014, "milestone/time/Text"), var_1_10009)
		end
	end

	for iter_25_1 = 1, #arg_25_0.stageList - 1 do
		local var_25_10 = arg_25_0.contextData.normalStageIDs[iter_25_1]
		local var_25_11 = arg_25_0.stageList[iter_25_1]

		ipairs = var_1_10009

		for iter_25_2, iter_25_3 in var_1_10009(arg_25_0.contextData.ticketInitPools) do
			ipairs = var_1_10014

			for iter_25_4, iter_25_5 in var_1_10014(iter_25_3[1]) do
				if iter_25_5 == var_25_10 then
					local var_25_12 = iter_25_3[2]
					local var_25_13

					if not arg_25_0.contextData.stageTickets[var_25_10] then
						var_25_13 = 0
					end

					setActive = var_1_10021

					var_1_10021(var_25_11:Find("Text"), var_25_13 > 0)

					setText = var_1_10021

					local var_25_14 = var_25_11:Find("Text")

					string = var_24

					var_1_10021(var_25_14, var_24.format("%d/%d", var_25_13, var_25_12))
				end
			end
		end
	end

	setText = var_3

	var_3(arg_25_0.ptScoreTxt, arg_25_0.contextData.ptData.count)

	setActive = var_3

	local var_25_15 = arg_25_0.awardFlash
	local var_25_16 = arg_25_0.contextData.ptData

	var_3(var_25_15, var_6.CanGetAward(var_25_16))

	if arg_25_0.bonusWindow then
		local var_25_17 = arg_25_0.bonusWindow

		if var_3.IsShowing(var_25_17) then
			local var_25_18 = arg_25_0.bonusWindow.buffer

			var_3.UpdateView(var_25_18, arg_25_0.contextData.ptData)
		end
	end

	local var_25_19 = arg_25_0:GetEXTicket()

	setText = var_4

	var_4(arg_25_0.ticketNum, var_25_19)

	return
end

function var_0_1.GetEXTicket(arg_26_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_26_0 = var_1_10001(var_1_10003)
	local var_26_1 = var_1.getRawData(var_26_0)

	return var_1.getResource(var_26_1, arg_26_0.contextData.TicketID)
end

function var_0_1.ShowNormalFleet(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0.contextData.actFleets[arg_27_1] then
		arg_27_0.contextData.actFleets[arg_27_1] = arg_27_0:CreateNewFleet(arg_27_1)
	end

	if not arg_27_0.contextData.actFleets[arg_27_1 + 10] then
		arg_27_0.contextData.actFleets[arg_27_1 + 10] = arg_27_0:CreateNewFleet(arg_27_1 + 10)
	end

	local var_27_0 = arg_27_0.contextData.actFleets[arg_27_1]

	if arg_27_2 and #var_27_0.ships <= 0 then
		for iter_27_0 = #arg_27_0.contextData.normalStageIDs, 1, -1 do
			local var_27_1 = arg_27_0.contextData.actFleets[iter_27_0]

			if iter_27_0 ~= arg_27_1 and var_27_1 and var_27_1:isLegalToFight() == true then
				var_27_0:updateShips(var_27_1.ships)

				break
			end
		end
	end

	local var_27_2 = arg_27_0:GetFleetEditPanel().buffer

	var_5.SetSettings(var_27_2, 1, 1, false)

	local var_27_3 = var_4.buffer

	var_5.SetFleets(var_27_3, {
		arg_27_0.contextData.actFleets[arg_27_1],
		arg_27_0.contextData.actFleets[arg_27_1 + 10]
	})

	local var_27_4 = arg_27_0.contextData.useOilLimit[arg_27_1]
	local var_27_5 = arg_27_0.contextData.normalStageIDs[arg_27_1]
	local var_27_6 = arg_27_0.contextData.activity

	if not var_7.IsOilLimit(var_27_6, var_27_5) then
		var_27_4 = {
			0,
			0
		}
	end

	local var_27_7 = var_4.buffer

	var_8.SetOilLimit(var_27_7, var_27_4)

	arg_27_0.contextData.editFleet = arg_27_1

	local var_27_8 = var_4.buffer

	var_8.UpdateView(var_27_8)

	local var_27_9 = var_4.buffer

	var_8.Show(var_27_9)

	return
end

function var_0_1.ShowEXFleet(arg_28_0)
	local var_28_0 = #arg_28_0.contextData.normalStageIDs + 1

	if not arg_28_0.contextData.actFleets[var_28_0] then
		arg_28_0.contextData.actFleets[var_28_0] = arg_28_0:CreateNewFleet(var_28_0)
	end

	if not arg_28_0.contextData.actFleets[var_28_0 + 10] then
		arg_28_0.contextData.actFleets[var_28_0 + 10] = arg_28_0:CreateNewFleet(var_28_0 + 10)
	end

	local var_28_1 = arg_28_0:GetFleetEditPanel().buffer

	var_3.SetSettings(var_28_1, 1, 1, true)

	local var_28_2 = var_2.buffer

	var_3.SetFleets(var_28_2, {
		arg_28_0.contextData.actFleets[var_28_0],
		arg_28_0.contextData.actFleets[var_28_0 + 10]
	})

	local var_28_3 = arg_28_0.contextData.useOilLimit[var_28_0]
	local var_28_4 = arg_28_0.contextData.exStageID
	local var_28_5 = arg_28_0.contextData.activity

	if not var_5.IsOilLimit(var_28_5, var_28_4) then
		var_28_3 = {
			0,
			0
		}
	end

	local var_28_6 = var_2.buffer

	var_6.SetOilLimit(var_28_6, var_28_3)

	arg_28_0.contextData.editFleet = var_28_0

	local var_28_7 = var_2.buffer

	var_6.UpdateView(var_28_7)

	local var_28_8 = var_2.buffer

	var_6.Show(var_28_8)

	return
end

function var_0_1.ShowSPFleet(arg_29_0)
	local var_29_0 = #arg_29_0.contextData.normalStageIDs + 2

	if not arg_29_0.contextData.actFleets[var_29_0] then
		arg_29_0.contextData.actFleets[var_29_0] = arg_29_0:CreateNewFleet(var_29_0)
	end

	if not arg_29_0.contextData.actFleets[var_29_0 + 10] then
		arg_29_0.contextData.actFleets[var_29_0 + 10] = arg_29_0:CreateNewFleet(var_29_0 + 10)
	end

	local var_29_1 = arg_29_0:GetFleetEditPanel().buffer

	var_3.SetSettings(var_29_1, 1, 1, false)

	local var_29_2 = var_2.buffer

	var_3.SetFleets(var_29_2, {
		arg_29_0.contextData.actFleets[var_29_0],
		arg_29_0.contextData.actFleets[var_29_0 + 10]
	})

	local var_29_3 = {
		0,
		0
	}
	local var_29_4 = var_2.buffer

	var_4.SetOilLimit(var_29_4, var_29_3)

	arg_29_0.contextData.editFleet = var_29_0

	local var_29_5 = var_2.buffer

	var_4.UpdateView(var_29_5)

	local var_29_6 = var_2.buffer

	var_4.Show(var_29_6)

	return
end

function var_0_1.commitEdit(arg_30_0)
	arg_30_0:emit(arg_30_0.contextData.mediatorClass.ON_COMMIT_FLEET)

	return
end

function var_0_1.commitCombat(arg_31_0)
	if arg_31_0.contextData.editFleet <= #arg_31_0.contextData.normalStageIDs then
		arg_31_0:emit(arg_31_0.contextData.mediatorClass.ON_PRECOMBAT, arg_31_0.contextData.editFleet)
	elseif arg_31_0.contextData.editFleet == #arg_31_0.contextData.normalStageIDs + 1 then
		arg_31_0:emit(arg_31_0.contextData.mediatorClass.ON_EX_PRECOMBAT, arg_31_0.contextData.editFleet, false)
	elseif arg_31_0.contextData.editFleet <= #arg_31_0.contextData.normalStageIDs + 2 then
		arg_31_0:emit(arg_31_0.contextData.mediatorClass.ON_SP_PRECOMBAT, arg_31_0.contextData.editFleet, false)
	end

	return
end

function var_0_1.commitTrybat(arg_32_0)
	arg_32_0:emit(arg_32_0.contextData.mediatorClass.ON_EX_PRECOMBAT, arg_32_0.contextData.editFleet, true)

	return
end

function var_0_1.updateEditPanel(arg_33_0)
	if arg_33_0.fleetEditPanel then
		local var_33_0 = arg_33_0.fleetEditPanel.buffer

		var_1.UpdateView(var_33_0)
	end

	return
end

function var_0_1.hideFleetEdit(arg_34_0)
	if arg_34_0.fleetEditPanel then
		local var_34_0 = arg_34_0.fleetEditPanel.buffer

		var_1.Hide(var_34_0)
	end

	if arg_34_0.commanderFormationPanel then
		local var_34_1 = arg_34_0.commanderFormationPanel.buffer

		var_1.Close(var_34_1)
	end

	arg_34_0.contextData.editFleet = nil

	return
end

function var_0_1.openShipInfo(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0.contextData.actFleets[arg_35_2]
	local var_35_1 = {}

	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_35_2 = var_1_10005(var_1_10007)

	ipairs = var_1_10006

	local var_35_3

	if not var_35_0 or not var_35_0.ships then
		var_35_3 = {}
	end

	for iter_35_0, iter_35_1 in var_1_10006(var_35_3) do
		table = var_1_10011

		var_1_10011.insert(var_35_1, var_35_2:getShipById(iter_35_1))
	end

	arg_35_0:emit(arg_35_0.contextData.mediatorClass.ON_FLEET_SHIPINFO, {
		shipId = arg_35_1,
		shipVOs = var_35_1
	})

	return
end

function var_0_1.setCommanderPrefabs(arg_36_0, arg_36_1)
	arg_36_0.commanderPrefabs = arg_36_1

	return
end

function var_0_1.openCommanderPanel(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.contextData.activityID
	local var_37_1 = arg_37_0.levelCMDFormationView

	var_4.setCallback(var_37_1, function(arg_38_0)
		local var_38_0 = arg_38_0.type

		LevelUIConst = var_2_10002

		if var_38_0 == var_2_10002.COMMANDER_OP_SHOW_SKILL then
			local var_38_1 = arg_37_0
			local var_38_2 = var_1.emit

			ActivityBossMediatorTemplate = var_2_10004

			var_38_2(var_38_1, var_2_10004.ON_COMMANDER_SKILL, arg_38_0.skill)
		else
			local var_38_3 = arg_38_0.type

			LevelUIConst = var_2

			if var_38_3 == var_2.COMMANDER_OP_ADD then
				arg_37_0.contextData.eliteCommanderSelected = {
					fleetIndex = arg_37_2,
					cmdPos = arg_38_0.pos,
					mode = arg_37_0.curMode
				}

				local var_38_4 = arg_37_0
				local var_38_5 = var_1.emit

				ActivityBossMediatorTemplate = var_2_10004

				var_38_5(var_38_4, var_2_10004.ON_SELECT_COMMANDER, arg_37_2, arg_38_0.pos)
			else
				local var_38_6 = arg_37_0
				local var_38_7 = var_1.emit

				ActivityBossMediatorTemplate = var_2_10004

				local var_38_8 = var_2_10004.COMMANDER_FORMATION_OP
				local var_38_9 = {}

				LevelUIConst = var_2_10006
				var_38_9.FleetType = var_2_10006.FLEET_TYPE_ACTIVITY
				var_38_9.data = arg_38_0
				var_38_9.fleetId = arg_37_1.id
				var_38_9.actId = var_37_0

				var_38_7(var_38_6, var_38_8, var_38_9)
			end
		end

		return
	end)

	local var_37_2 = arg_37_0.levelCMDFormationView

	var_4.Load(var_37_2)

	local var_37_3 = arg_37_0.levelCMDFormationView

	var_4.ActionInvoke(var_37_3, "update", arg_37_1, arg_37_0.commanderPrefabs)

	local var_37_4 = arg_37_0.levelCMDFormationView

	var_4.ActionInvoke(var_37_4, "Show")

	return
end

function var_0_1.updateCommanderFleet(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.levelCMDFormationView

	if var_2.isShowing(var_39_0) then
		local var_39_1 = arg_39_0.levelCMDFormationView

		var_2.ActionInvoke(var_39_1, "updateFleet", arg_39_1)
	end

	return
end

function var_0_1.updateCommanderPrefab(arg_40_0)
	local var_40_0 = arg_40_0.levelCMDFormationView

	if var_1.isShowing(var_40_0) then
		local var_40_1 = arg_40_0.levelCMDFormationView

		var_1.ActionInvoke(var_40_1, "updatePrefabs", arg_40_0.commanderPrefabs)
	end

	return
end

function var_0_1.closeCommanderPanel(arg_41_0)
	local var_41_0 = arg_41_0.levelCMDFormationView

	if var_1.isShowing(var_41_0) then
		local var_41_1 = arg_41_0.levelCMDFormationView

		var_1.ActionInvoke(var_41_1, "Hide")
	end

	return
end

function var_0_1.buildCommanderPanel(arg_42_0)
	LevelCMDFormationView = var_1_10001
	arg_42_0.levelCMDFormationView = var_1_10001.New(arg_42_0._tf, arg_42_0.event, arg_42_0.contextData)

	return
end

function var_0_1.destroyCommanderPanel(arg_43_0)
	local var_43_0 = arg_43_0.levelCMDFormationView

	var_1.Destroy(var_43_0)

	arg_43_0.levelCMDFormationView = nil

	return
end

function var_0_1.ShowAwards(arg_44_0)
	local var_44_0 = arg_44_0:GetBonusWindow().buffer

	var_2.UpdateView(var_44_0, arg_44_0.contextData.ptData)

	local var_44_1 = var_1.buffer

	var_2.Show(var_44_1)

	return
end

function var_0_1.CreateNewFleet(arg_45_0, arg_45_1)
	TypedFleet = var_1_10002

	local var_45_0 = var_1_10002.New
	local var_45_1 = {
		id = arg_45_1,
		ship_list = {},
		commanders = {}
	}

	if 10 < arg_45_1 then
		FleetType = var_45_2

		local var_45_2

		if not var_45_2.Submarine then
			FleetType = var_45_2
			var_45_2 = var_45_2.Normal
		end

		var_45_1.fleetType = var_45_2

		return var_45_0(var_45_1)
	end
end

function var_0_1.UpdateRank(arg_46_0, arg_46_1)
	arg_46_1 = arg_46_1 or {}

	for iter_46_0 = 1, #arg_46_0.rankList do
		local var_46_0 = arg_46_0.rankList[iter_46_0]

		setActive = var_1_10007

		var_1_10007(var_46_0, iter_46_0 <= #arg_46_1)

		if iter_46_0 <= #arg_46_1 then
			var_1_10007 = var_46_0:Find("Text")
			setText = var_1_10008

			local var_46_1 = var_1_10007

			tostring = var_1_10011

			var_1_10008(var_46_1, var_1_10011(arg_46_1[iter_46_0].name))
		end
	end

	return
end

function var_0_1.UpdateDropItems(arg_47_0)
	ipairs = var_1_10001

	local var_47_0

	if not arg_47_0.contextData.DisplayItems then
		var_47_0 = {}
	end

	for iter_47_0, iter_47_1 in var_1_10001(var_47_0) do
		local var_47_1 = arg_47_0.barList[iter_47_0]
		local var_47_2 = var_6.Find(var_47_1, "milestone/item")

		Drop = var_1_10007
		var_1_10007 = var_1_10007.New({
			type = arg_47_0.contextData.DisplayItems[5 - iter_47_0][1],
			id = arg_47_0.contextData.DisplayItems[5 - iter_47_0][2],
			count = arg_47_0.contextData.DisplayItems[5 - iter_47_0][3]
		})
		onButton = var_47_1

		local var_47_3 = arg_47_0
		local var_47_4 = var_47_2

		local function var_47_5()
			local var_48_0 = arg_47_0

			var_0.emit(var_48_0, var_0_1.ON_DROP, var_1_10007)

			return
		end

		SFX_PANEL = var_1_10013

		var_47_1(var_47_3, var_47_4, var_47_5, var_1_10013)
	end

	return
end

function var_0_1.onBackPressed(arg_49_0)
	if arg_49_0.bonusWindow then
		local var_49_0 = arg_49_0.bonusWindow

		if var_1.IsShowing(var_49_0) then
			local var_49_1 = arg_49_0.bonusWindow.buffer

			var_1.Hide(var_49_1)

			return
		end
	end

	var_0_1.super.onBackPressed(arg_49_0)

	return
end

function var_0_1.willExit(arg_50_0)
	arg_50_0:DestroyBonusWindow()
	arg_50_0:DestroyFleetEditPanel()
	arg_50_0:destroyCommanderPanel()

	return
end

return var_0_1
