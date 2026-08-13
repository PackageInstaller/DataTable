class = var_0_10000

local var_0_0 = "IslandRoleDelegationPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandRoleDelegationUI"
end

local var_0_2 = 0.6

function var_0_1.AddListeners(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.AddListener

	GAME = var_1_10003

	var_2_1(var_2_0, var_1_10003.ISLAND_GET_DELEGATION_AWARD_DONE, arg_2_0.OnGetDelegationAwardDone)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.AddListener

	GAME = var_3

	var_2_3(var_2_2, var_3.ISLAND_FINISH_DELEGATION_DONE, arg_2_0.OnFinishDelegationDone)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.AddListener

	GAME = var_3

	var_2_5(var_2_4, var_3.ISLAND_START_DELEGATION_DONE, arg_2_0.OnDelegationStartDone)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.AddListener

	GAME = var_3

	var_2_7(var_2_6, var_3.ISLAND_USE_TICKET_DONE, arg_2_0.OnUseTicketDone)

	return
end

function var_0_1.RemoveListeners(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.RemoveListener

	GAME = var_1_10003

	var_3_1(var_3_0, var_1_10003.ISLAND_GET_DELEGATION_AWARD_DONE, arg_3_0.OnGetDelegationAwardDone)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.RemoveListener

	GAME = var_3

	var_3_3(var_3_2, var_3.ISLAND_FINISH_DELEGATION_DONE, arg_3_0.OnFinishDelegationDone)

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.RemoveListener

	GAME = var_3

	var_3_5(var_3_4, var_3.ISLAND_START_DELEGATION_DONE, arg_3_0.OnDelegationStartDone)

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.RemoveListener

	GAME = var_3

	var_3_7(var_3_6, var_3.ISLAND_USE_TICKET_DONE, arg_3_0.OnUseTicketDone)

	return
end

Vector3 = var_2

local var_0_3 = var_2(0, 0, 0)

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.backBtn = var_1.Find(var_4_0, "top/back")

	local var_4_1 = arg_4_0._tf

	arg_4_0.title = var_1.Find(var_4_1, "top/title")

	local var_4_2 = arg_4_0._tf

	arg_4_0.content = var_1.Find(var_4_2, "content")
	UIItemList = var_1

	local var_4_3 = var_1.New
	local var_4_4 = arg_4_0.content
	local var_4_5 = arg_4_0.content

	arg_4_0.delegationList = var_4_3(var_4_4, var_3.Find(var_4_5, "tpl"))

	local var_4_6 = arg_4_0.delegationList

	var_1.make(var_4_6, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventInit then
			local var_5_0 = arg_4_0

			var_3.InitDelegationItem(var_5_0, arg_5_1, arg_5_2)
		else
			UIItemList = var_3

			if arg_5_0 == var_3.EventUpdate then
				local var_5_1 = arg_4_0

				var_3.UpdateDelegationItem(var_5_1, arg_5_1, arg_5_2)
			end
		end

		return
	end)

	local var_4_7 = arg_4_0._tf

	arg_4_0.leftcontent = var_1.Find(var_4_7, "left/left_content")
	UIItemList = var_1

	local var_4_8 = var_1.New
	local var_4_9 = arg_4_0.leftcontent
	local var_4_10 = arg_4_0.leftcontent

	arg_4_0.delegationTabList = var_4_8(var_4_9, var_3.Find(var_4_10, "tpl"))

	local var_4_11 = arg_4_0.delegationTabList

	var_1.make(var_4_11, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventInit then
			local var_6_0 = arg_4_0

			var_3.InitDelegationTabItem(var_6_0, arg_6_1, arg_6_2)
		else
			UIItemList = var_3

			if arg_6_0 == var_3.EventUpdate then
				local var_6_1 = arg_4_0

				var_3.UpdateDelegationTabItem(var_6_1, arg_6_1, arg_6_2)
			end
		end

		return
	end)

	IslandDelegationSelectPanel = var_1

	local var_4_12 = var_1.New
	local var_4_13 = arg_4_0._tf
	local var_4_14 = arg_4_0.event

	setmetatable = var_4_10
	arg_4_0.selectPanel = var_4_12(var_4_13, var_4_14, var_4_10({
		alignRight = true,
		isPermanent = true,
		ShowMsgBox = function(arg_7_0, arg_7_1)
			local var_7_0 = arg_4_0

			var_2.ShowMsgBox(var_7_0, arg_7_1)

			return
		end
	}, {
		__index = arg_4_0.contextData
	}))
	IslandAwardDisplayInMainPanel = var_1
	arg_4_0.awardDisplayPanel = var_1.New(arg_4_0._tf, arg_4_0.event)

	return
end

function var_0_1.OnInit(arg_8_0)
	arg_8_0:InitPlaceCfg()

	onButton = var_1

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.backBtn

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.Hide(var_9_0)

		IslandCameraMgr = var_0

		local var_9_1 = var_0.instance
		local var_9_2 = var_0.ActiveVirtualCamera

		IslandConst = var_2_10002

		var_9_2(var_9_1, var_2_10002.FOLLOW_CAMERA_NAME)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0._tf
	local var_8_5 = var_3.Find(var_8_4, "top/title/help")

	local function var_8_6()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		pg = var_2_10003
		var_10_2.helps = var_2_10003.gametip.island_help_commission.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_8_3, var_8_5, var_8_6, var_5)

	return
end

function var_0_1.InitPlaceCfg(arg_11_0)
	arg_11_0.npcToPlaceCfg = {}
	ipairs = var_1
	pg = var_1_10002

	for iter_11_0, iter_11_1 in var_1(var_1_10002.island_production_place.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.island_production_place[iter_11_1]

		local var_11_0

		if not arg_11_0.npcToPlaceCfg[var_1_10006.npc_birthplace] then
			var_11_0 = arg_11_0.npcToPlaceCfg
			var_11_0[var_1_10006.npc_birthplace] = {}
		end

		table = var_11_0

		var_11_0.insert(arg_11_0.npcToPlaceCfg[var_1_10006.npc_birthplace], iter_11_1)
	end

	return
end

function var_0_1.InitDelegationTabItem(arg_12_0, arg_12_1, arg_12_2)
	onButton = var_1_10003

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_2

	local function var_12_2()
		local var_13_0 = arg_12_0

		var_0.OnSelectTargetIndexCommission(var_13_0, arg_12_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_12_0, var_12_1, var_12_2, var_1_10007)

	return
end

function var_0_1.InitDelegationItem(arg_14_0, arg_14_1, arg_14_2)
	onButton = var_1_10003

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_2

	local function var_14_2()
		local var_15_0 = arg_14_0

		var_0.OnSelectTargetIndexCommission(var_15_0, arg_14_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_14_0, var_14_1, var_14_2, var_1_10007)

	return
end

function var_0_1.UpdateDelegationItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.placeCommissionList[arg_16_1 + 1]

	pg = var_4

	local var_16_1 = var_4.island_production_commission[var_16_0]

	pg = var_1_10005

	local var_16_2 = var_1_10005.island_world_objects[var_16_1.birthplace].param.position

	Vector3 = var_6

	local var_16_3 = var_6(var_16_2[1], var_16_2[2], var_16_2[3])

	pg = var_7

	local var_16_4 = var_7.island_world_objects[var_16_1.birthplace].param.rotation

	Vector3 = var_8

	local var_16_5 = var_8(var_16_4[1], var_16_4[2], var_16_4[3])

	IslandCalcUtil = var_9

	local var_16_6 = var_9.WorldPosition2LocalPosition(arg_16_0.content, var_16_3)
	local var_16_7 = arg_16_2.transform

	var_16_7.localPosition = var_16_6 + var_0_3
	setActive = var_16_7

	var_16_7(arg_16_2:Find("select"), false)

	setActive = var_16_7

	var_16_7(arg_16_2:Find("unselect"), false)

	local var_16_8 = arg_16_1 + 1
	local var_16_9 = arg_16_0.placeCommissionList[var_16_8]

	pg = var_12

	local var_16_10 = var_12.island_production_commission[var_16_9].slot

	getProxy = var_1_10014
	IslandProxy = var_1_10015

	local var_16_11 = var_1_10014(var_1_10015)
	local var_16_12 = var_14.GetIsland(var_16_11)
	local var_16_13 = var_14.GetBuildingAgency(var_16_12)
	local var_16_14 = var_15.GetBuilding(var_16_13, arg_16_0.placeId)
	local var_16_15 = var_15.GetDelegationSlotData(var_16_14, var_16_10)

	setButtonEnabled = var_16_14

	var_16_14(arg_16_2, var_16_15 ~= nil)

	local var_16_16 = arg_16_1 + 1
	local var_16_17 = arg_16_0
	local var_16_18 = arg_16_0.emitCore

	ISLAND_EVT = var_1_10020

	var_16_18(var_16_17, var_1_10020.SELECTDELEEFFECT_SHOW, var_16_16, arg_16_0.selectedIdx, var_16_3, var_16_5)

	return
end

function var_0_1.OnSelectTargetIndexCommission(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.selectedIdx == arg_17_1 + 1 and not arg_17_2 then
		return
	end

	if not arg_17_2 then
		arg_17_0.selectedShip = nil

		arg_17_0:UnloadPreconcenCharacter()
	end

	arg_17_0.selectedIdx = arg_17_1 + 1
	arg_17_0.contextData.selectedIdx = arg_17_0.selectedIdx

	local var_17_0 = arg_17_0.placeCommissionList[arg_17_0.selectedIdx]
	local var_17_1 = arg_17_0.selectPanel

	var_4.ExecuteAction(var_17_1, "Show", var_17_0, arg_17_0.selectedShip, function(arg_18_0)
		arg_17_0.contextData.selectedShip = arg_18_0
		arg_17_0.selectedShip = arg_18_0

		local var_18_0 = arg_17_0

		var_1.LoadPreconcenCharacter(var_18_0, arg_18_0)

		return
	end, function()
		arg_17_0.contextData.selectedShip = nil
		arg_17_0.selectedShip = nil

		local var_19_0 = arg_17_0

		var_0.UnloadPreconcenCharacter(var_19_0)

		return
	end)

	local var_17_2 = arg_17_0.delegationTabList

	var_4.align(var_17_2, #arg_17_0.placeCommissionList)

	local var_17_3 = arg_17_0.delegationList

	var_4.align(var_17_3, #arg_17_0.placeCommissionList)

	return
end

function var_0_1.UpdateDelegationTabItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1 + 1

	setActive = var_1_10004

	var_1_10004(arg_20_2:Find("select"), arg_20_0.selectedIdx == var_20_0)

	setActive = var_1_10004

	var_1_10004(arg_20_2:Find("unselect"), arg_20_0.selectedIdx ~= var_20_0)

	local var_20_1 = arg_20_0.placeCommissionList[var_20_0]

	pg = var_5

	local var_20_2 = var_5.island_production_commission[var_20_1].slot

	getProxy = var_7
	IslandProxy = var_1_10008

	local var_20_3 = var_7(var_1_10008)
	local var_20_4 = var_7.GetIsland(var_20_3)
	local var_20_5 = var_7.GetBuildingAgency(var_20_4)
	local var_20_6 = var_8.GetBuilding(var_20_5, arg_20_0.placeId)
	local var_20_7 = var_8.GetDelegationSlotData(var_20_6, var_20_2)

	setActive = var_20_6

	var_20_6(arg_20_2:Find("lock"), not var_20_7)

	setActive = var_20_6

	var_20_6(arg_20_2:Find("slotName"), var_20_7)

	setButtonEnabled = var_20_6

	var_20_6(arg_20_2, var_20_7 ~= nil)

	if arg_20_0.selectedIdx == var_20_0 then
		local var_20_8 = arg_20_0.selectPanel

		var_10.ExecuteAction(var_20_8, "Flush")
	end

	if not var_20_7 then
		setActive = var_10

		var_10(arg_20_2:Find("complete "), false)

		setActive = var_10

		var_10(arg_20_2:Find("product_icon"), false)

		return
	end

	local var_20_9 = var_20_7:GetSlotRoleData()
	local var_20_10 = var_20_7:GetSlotRewardData()
	local var_20_11 = var_20_9 == nil and var_20_10 ~= nil

	setActive = var_13

	var_13(arg_20_2:Find("complete "), var_20_11)

	local var_20_12

	if not var_20_9 or not var_20_9.formula_id then
		var_20_12 = nil
	end

	var_20_12 = var_20_12 or var_20_10 and var_20_10.formula_id or nil

	local var_20_13

	if var_20_12 then
		setActive = var_20_13

		var_20_13(arg_20_2:Find("product_icon"), true)

		pg = var_20_13
		var_20_13 = var_20_13.island_formula[var_20_12]
		pg = var_15

		local var_20_14 = var_15.island_item_data_template[var_20_13.item_id]

		GetImageSpriteFromAtlasAsync = var_16

		var_16("island/" .. var_20_14.icon, "", arg_20_2:Find("product_icon"))
	else
		setActive = var_20_13

		var_20_13(arg_20_2:Find("product_icon"), false)
	end

	return
end

function var_0_1.Flush(arg_21_0)
	local var_21_0 = arg_21_0.delegationList

	var_1.align(var_21_0, #arg_21_0.placeCommissionList)

	local var_21_1 = arg_21_0.delegationTabList

	var_1.align(var_21_1, #arg_21_0.placeCommissionList)

	return
end

function var_0_1.OnShow(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 then
		arg_22_0.placeId = arg_22_1
	else
		arg_22_0.placeId = arg_22_0.npcToPlaceCfg[arg_22_2][1]
	end

	pg = var_1_10003
	arg_22_0.placeCfg = var_1_10003.island_production_place[arg_22_0.placeId]
	arg_22_0.placeCommissionList = arg_22_0.placeCfg.commission_slot

	if arg_22_0.placeCfg.delegationCamera then
		IslandCameraMgr = var_3

		local var_22_0 = var_3.instance

		var_3.ActiveVirtualCamera(var_22_0, arg_22_0.placeCfg.delegationCamera)
	end

	pg = var_3
	arg_22_0.timeMgr = var_3.TimeMgr.GetInstance()
	arg_22_0.selectedShip = arg_22_0.contextData.selectedShip

	arg_22_0:DefaultTargetTabIndex()

	if arg_22_0.selectedShip then
		arg_22_0:LoadPreconcenCharacter(arg_22_0.selectedShip)
	end

	arg_22_0:StopTimer()
	arg_22_0:StartTimer()

	setText = var_3

	local var_22_1 = arg_22_0._tf

	var_3(var_4.Find(var_22_1, "top/title/Text"), arg_22_0.placeCfg.name)

	setText = var_3

	local var_22_2 = arg_22_0._tf

	var_3(var_4.Find(var_22_2, "top/title/Text/en"), "PRODUCTING")

	return
end

function var_0_1.DefaultTargetTabIndex(arg_23_0)
	local var_23_0

	if not arg_23_0.contextData.selectedIdx then
		var_23_0 = 1
	end

	arg_23_0:OnSelectTargetIndexCommission(var_23_0 - 1, true)

	return
end

function var_0_1.OnHide(arg_24_0)
	arg_24_0:StopTimer()

	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.emitCore

	ISLAND_EVT = var_1_10003

	var_24_1(var_24_0, var_1_10003.RECYCLE_ALL_SLOTDELEEFFECT)
	arg_24_0:UnloadPreconcenCharacter()

	if arg_24_0.awardDisplayPanel then
		local var_24_2 = arg_24_0.awardDisplayPanel

		var_1.Hide(var_24_2)
	end

	return
end

function var_0_1.OnExit(arg_25_0)
	arg_25_0.contextData.selectedIdx = nil

	local var_25_0 = arg_25_0.contextData

	var_25_0.selectedShip = nil
	IslandCameraMgr = var_25_0

	local var_25_1 = var_25_0.instance
	local var_25_2 = var_1.ActiveVirtualCamera

	IslandConst = var_1_10003

	var_25_2(var_25_1, var_1_10003.FOLLOW_CAMERA_NAME)

	return
end

function var_0_1.StartTimer(arg_26_0)
	setActive = var_1_10001

	var_1_10001(arg_26_0.content, false)

	Timer = var_1_10001
	arg_26_0.timer = var_1_10001.New(function()
		setActive = var_2_10000

		var_2_10000(arg_26_0.content, true)

		local var_27_0 = arg_26_0

		var_0.Flush(var_27_0)

		return
	end, var_0_2, 0)

	local var_26_0 = arg_26_0.timer

	var_1.Start(var_26_0)

	return
end

function var_0_1.StopTimer(arg_28_0)
	if arg_28_0.timer ~= nil then
		local var_28_0 = arg_28_0.timer

		var_1.Stop(var_28_0)

		arg_28_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_29_0)
	arg_29_0:StopTimer()

	if arg_29_0.selectPanel then
		local var_29_0 = arg_29_0.selectPanel

		var_1.Destroy(var_29_0)

		arg_29_0.selectPanel = nil
	end

	if arg_29_0.awardDisplayPanel then
		local var_29_1 = arg_29_0.awardDisplayPanel

		var_1.Destroy(var_29_1)

		arg_29_0.awardDisplayPanel = nil
	end

	return
end

function var_0_1.OnGetDelegationAwardDone(arg_30_0, arg_30_1)
	if arg_30_1.addShipExpData then
		local var_30_0 = {}
		local var_30_1 = arg_30_1.addShipExpData.addShipId
		local var_30_2 = arg_30_1.addShipExpData.addExp

		IslandShip = var_1_10005

		local var_30_3 = var_1_10005.StaticGetPrefab(var_30_1)
		local var_30_4 = "island/IslandShipIcon/" .. var_30_3

		arg_30_0:UpdateMainAwardReward({
			shipExp = true,
			icon = var_30_4,
			num = var_30_2
		})
	end

	local var_30_5 = arg_30_0.delegationTabList

	var_2.align(var_30_5, #arg_30_0.placeCommissionList)

	return
end

function var_0_1.OnFinishDelegationDone(arg_31_0, arg_31_1)
	if arg_31_1.addShipExpData then
		local var_31_0 = {}
		local var_31_1 = arg_31_1.addShipExpData.addShipId
		local var_31_2 = arg_31_1.addShipExpData.addExp

		IslandShip = var_1_10005

		local var_31_3 = var_1_10005.StaticGetPrefab(var_31_1)
		local var_31_4 = "island/IslandShipIcon/" .. var_31_3

		arg_31_0:UpdateMainAwardReward({
			shipExp = true,
			icon = var_31_4,
			num = var_31_2
		})
	end

	local var_31_5 = arg_31_0.delegationTabList

	var_2.align(var_31_5, #arg_31_0.placeCommissionList)

	return
end

function var_0_1.OnUseTicketDone(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.type

	IslandUseTicketCommand = var_1_10003

	if var_32_0 == var_1_10003.TYPES.APPOINT then
		local var_32_1 = arg_32_0.delegationTabList

		var_2.align(var_32_1, #arg_32_0.placeCommissionList)
	end

	return
end

function var_0_1.OnDelegationStartDone(arg_33_0)
	local var_33_0 = arg_33_0.delegationTabList

	var_1.align(var_33_0, #arg_33_0.placeCommissionList)

	return
end

function var_0_1.LoadPreconcenCharacter(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0

	arg_34_0.UnloadPreconcenCharacter(var_34_0)

	getProxy = var_2
	IslandProxy = var_34_0

	local var_34_1 = var_2(var_34_0)
	local var_34_2 = var_2.GetIsland(var_34_1)
	local var_34_3 = var_2.GetCharacterAgency(var_34_2)
	local var_34_4 = var_2.GetShipById(var_34_3, arg_34_1)
	local var_34_5 = arg_34_0.placeCommissionList[arg_34_0.selectedIdx]

	pg = var_5

	local var_34_6 = var_5.island_production_commission[var_34_5].birthplace
	local var_34_7 = arg_34_0
	local var_34_8 = arg_34_0.emitCore

	ISLAND_EVT = var_1_10009

	var_34_8(var_34_7, var_1_10009.LOAD_DELEGATE_PREVIEW_ROLE, var_34_4:GetModel(), var_34_6)

	return
end

function var_0_1.UnloadPreconcenCharacter(arg_35_0)
	local var_35_0 = arg_35_0
	local var_35_1 = arg_35_0.emitCore

	ISLAND_EVT = var_1_10003

	var_35_1(var_35_0, var_1_10003.UN_LOAD_DELEGATE_PREVIEW_ROLE)

	return
end

function var_0_1.UpdateMainAwardReward(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.awardDisplayPanel

	var_2.ExecuteAction(var_36_0, "ShowAwards", arg_36_1)

	return
end

return var_0_1
