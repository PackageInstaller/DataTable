class = var_0_10000

local var_0_0 = "IslandTechnologyPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTechnologyUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtTop = var_1.Find(var_2_0, "top")
	setText = var_1

	local var_2_1 = arg_2_0.rtTop
	local var_2_2 = var_3.Find(var_2_1, "title/Text")

	i18n = var_4

	var_1(var_2_2, var_4("island_technology_title"))

	local var_2_3 = arg_2_0._tf

	arg_2_0.centreToggleTF = var_1.Find(var_2_3, "adapt/types/1")

	local var_2_4 = arg_2_0.centreToggleTF

	arg_2_0.centreTipTF = var_1.Find(var_2_4, "tip")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "adapt/types/content")

	UIItemList = var_1_10002
	arg_2_0.typeUIList = var_1_10002.New(var_2_6, var_2_6:Find("tpl"))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "adapt/pages")

	arg_2_0.pages = {}
	setmetatable = var_3

	local var_2_9 = var_3({
		onItemClick = function(arg_3_0, arg_3_1)
			local var_3_0 = arg_2_0.detailPanel

			var_2.ExecuteAction(var_3_0, "Show", arg_3_0, arg_3_1)

			return
		end
	}, {
		__index = arg_2_0.contextData
	})
	local var_2_10 = arg_2_0.pages

	IslandTechBelong = var_5

	local var_2_11 = var_5.CENTRE

	IslandTechCentrePanel = var_6
	var_2_10[var_2_11] = var_6.New(var_2_8, arg_2_0.event, var_2_9)
	ipairs = var_2_10
	IslandTechBelong = var_6

	for iter_2_0, iter_2_1 in var_2_10(var_6.COMMON_SHOW_TYPES) do
		local var_2_12 = arg_2_0.pages

		IslandTechTreePanel = var_2_13

		local var_2_13 = var_2_13.New
		local var_2_14 = var_2_8
		local var_2_15 = arg_2_0.event

		setmetatable = var_1_10014
		var_2_12[iter_2_1] = var_2_13(var_2_14, var_2_15, var_1_10014({
			type = iter_2_1
		}, {
			__index = var_2_9
		}))
	end

	IslandTechQuickPanel = var_4

	local var_2_16 = var_4.New
	local var_2_17 = arg_2_0._tf
	local var_2_18 = arg_2_0.event

	setmetatable = iter_2_1
	arg_2_0.quickPanel = var_2_16(var_2_17, var_2_18, iter_2_1({
		onGetAwardDone = function(arg_4_0)
			local var_4_0 = arg_2_0
			local var_4_1 = var_1.OpenPage

			IslandTechAwardPage = var_2_10004

			var_4_1(var_4_0, var_2_10004, arg_4_0)

			return
		end
	}, {
		__index = arg_2_0.contextData
	}))

	local var_2_19 = arg_2_0.quickPanel

	var_4.RegisterView(var_2_19, arg_2_0.viewComponent)

	IslandTechDetailPanel = var_4

	local var_2_20 = var_4.New
	local var_2_21 = arg_2_0._tf
	local var_2_22 = arg_2_0.event

	setmetatable = var_8
	arg_2_0.detailPanel = var_2_20(var_2_21, var_2_22, var_8({
		onSelecteShip = function(arg_5_0)
			pg = var_2_10001

			local var_5_0 = var_2_10001.island_formula[arg_5_0].attribute

			pg = var_2_10002

			local var_5_1 = var_2_10002.island_formula[arg_5_0].stamina_cost
			local var_5_2 = arg_2_0
			local var_5_3 = var_3.OpenPage

			IslandShipSelectPage = var_2_10006

			local var_5_4 = {
				needWorkSpeed = true
			}

			IslandSelectShipCard = var_2_10008
			var_5_4.showType = var_2_10008.SHOW_TYPE.PlACE
			var_5_4.attrType = var_5_0

			function var_5_4.confirmFunc(arg_6_0)
				local var_6_0 = arg_2_0.detailPanel

				var_1.ExecuteAction(var_6_0, "OnShipSelected", arg_6_0[1])

				return
			end

			IslandProductConst = var_8
			var_5_4.placeId = var_8.TechnologyPlaceId
			var_5_4.energyCost = var_5_1

			var_5_3(var_5_2, var_2_10006, var_5_4)

			return
		end,
		onFinishImmd = function(arg_7_0)
			local var_7_0 = arg_2_0
			local var_7_1 = var_1.emit

			IslandMediator = var_2_10004

			var_7_1(var_7_0, var_2_10004.ON_FINISH_TECH_IMMD, arg_7_0, function()
				local var_8_0 = arg_2_0
				local var_8_1 = var_0.OpenPage

				IslandTechAwardPage = var_3_10003

				var_8_1(var_8_0, var_3_10003, arg_7_0)

				return
			end)

			return
		end,
		onGetAwardDone = function(arg_9_0)
			local var_9_0 = arg_2_0
			local var_9_1 = var_1.OpenPage

			IslandTechAwardPage = var_2_10004

			var_9_1(var_9_0, var_2_10004, arg_9_0)

			return
		end,
		openTicketPage = function(arg_10_0)
			local var_10_0 = arg_2_0
			local var_10_1 = var_1.OpenPage

			IslandTicketUsePage = var_2_10004
			IslandUseTicketCommand = var_2_10005

			var_10_1(var_10_0, var_2_10004, var_2_10005.TYPES.APPOINT, arg_10_0)

			return
		end,
		ShowMsgBox = function(arg_11_0, arg_11_1)
			local var_11_0 = arg_2_0

			var_2.ShowMsgBox(var_11_0, arg_11_1)

			return
		end
	}, {
		__index = arg_2_0.contextData
	}))

	local var_2_23 = arg_2_0.detailPanel

	var_4.RegisterView(var_2_23, arg_2_0.viewComponent)

	return
end

function var_0_1.OnInit(arg_12_0)
	onButton = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.rtTop
	local var_12_2 = var_4.Find(var_12_1, "title/help")

	local function var_12_3()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.ShowMsgBox
		local var_13_2 = {}

		IslandMsgBox = var_2_10004
		var_13_2.type = var_2_10004.TYPE_WHITOUT_BTN
		i18n = var_4
		var_13_2.content = var_4("island_helpbtn_technology")

		var_13_1(var_13_0, var_13_2)

		return
	end

	SFX_PANEL = var_12_1

	var_1_10001(var_12_0, var_12_2, var_12_3, var_12_1)

	onButton = var_1_10001

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_0.rtTop
	local var_12_6 = var_4.Find(var_12_5, "back")

	local function var_12_7()
		local var_14_0 = arg_12_0

		var_0.Hide(var_14_0)

		return
	end

	SFX_PANEL = var_12_5

	var_1_10001(var_12_4, var_12_6, var_12_7, var_12_5)

	onButton = var_1_10001

	local var_12_8 = arg_12_0
	local var_12_9 = arg_12_0.rtTop
	local var_12_10 = var_4.Find(var_12_9, "home")

	local function var_12_11()
		local var_15_0 = arg_12_0
		local var_15_1 = var_0.emit

		BaseUI = var_2_10003

		var_15_1(var_15_0, var_2_10003.ON_HOME)

		return
	end

	SFX_PANEL = var_12_9

	var_1_10001(var_12_8, var_12_10, var_12_11, var_12_9)

	onToggle = var_1_10001

	local var_12_12 = arg_12_0
	local var_12_13 = arg_12_0.centreToggleTF

	local function var_12_14(arg_16_0)
		if arg_16_0 then
			local var_16_0 = arg_12_0.curPage

			IslandTechBelong = var_2_10002

			if var_16_0 ~= var_2_10002.CENTRE then
				local var_16_1 = arg_12_0

				IslandTechBelong = var_2
				var_16_1.curPage = var_2.CENTRE

				local var_16_2 = arg_12_0

				var_1.SwitchPage(var_16_2)
			end
		end

		return
	end

	SFX_PANEL = var_12_9

	var_1_10001(var_12_12, var_12_13, var_12_14, var_12_9)

	IslandTechBelong = var_1_10001
	arg_12_0.commonTypes = var_1_10001.COMMON_SHOW_TYPES

	local var_12_15 = arg_12_0.typeUIList

	var_1.make(var_12_15, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventInit then
			local var_17_0 = arg_12_0

			var_3.InitTypeItem(var_17_0, arg_17_1, arg_17_2)
		else
			UIItemList = var_3

			if arg_17_0 == var_3.EventUpdate then
				local var_17_1 = arg_12_0

				var_3.UpdateTypeItem(var_17_1, arg_17_1, arg_17_2)
			end
		end

		return
	end)

	return
end

function var_0_1.AddListeners(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.AddListener

	GAME = var_1_10004

	var_18_1(var_18_0, var_1_10004.ISLAND_UNLOCK_TECH_DONE, arg_18_0.Flush)

	local var_18_2 = arg_18_0
	local var_18_3 = arg_18_0.AddListener

	GAME = var_4

	var_18_3(var_18_2, var_4.ISLAND_START_DELEGATION_DONE, arg_18_0.Flush)

	local var_18_4 = arg_18_0
	local var_18_5 = arg_18_0.AddListener

	GAME = var_4

	var_18_5(var_18_4, var_4.ISLAND_FINISH_TECH_IMMD_DONE, arg_18_0.CheckAutoUnlock)

	local var_18_6 = arg_18_0
	local var_18_7 = arg_18_0.AddListener

	GAME = var_4

	var_18_7(var_18_6, var_4.ISLAND_FINISH_DELEGATION_DONE, arg_18_0.Flush)

	local var_18_8 = arg_18_0
	local var_18_9 = arg_18_0.AddListener

	GAME = var_4

	var_18_9(var_18_8, var_4.ISLAND_GET_DELEGATION_AWARD_DONE, arg_18_0.CheckAutoUnlock)

	return
end

function var_0_1.RemoveListeners(arg_19_0)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.RemoveListener

	GAME = var_1_10004

	var_19_1(var_19_0, var_1_10004.ISLAND_UNLOCK_TECH_DONE, arg_19_0.Flush)

	local var_19_2 = arg_19_0
	local var_19_3 = arg_19_0.RemoveListener

	GAME = var_4

	var_19_3(var_19_2, var_4.ISLAND_START_DELEGATION_DONE, arg_19_0.Flush)

	local var_19_4 = arg_19_0
	local var_19_5 = arg_19_0.RemoveListener

	GAME = var_4

	var_19_5(var_19_4, var_4.ISLAND_FINISH_TECH_IMMD_DONE, arg_19_0.CheckAutoUnlock)

	local var_19_6 = arg_19_0
	local var_19_7 = arg_19_0.RemoveListener

	GAME = var_4

	var_19_7(var_19_6, var_4.ISLAND_FINISH_DELEGATION_DONE, arg_19_0.Flush)

	local var_19_8 = arg_19_0
	local var_19_9 = arg_19_0.RemoveListener

	GAME = var_4

	var_19_9(var_19_8, var_4.ISLAND_GET_DELEGATION_AWARD_DONE, arg_19_0.CheckAutoUnlock)

	return
end

function var_0_1.InitTypeItem(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2.name = arg_20_0.commonTypes[arg_20_1 + 1]
	IslandTechBelong = var_4

	local var_20_0 = var_4.Names[var_3]

	setText = var_1_10005

	var_1_10005(arg_20_2:Find("unsel"), var_20_0)

	setText = var_1_10005

	var_1_10005(arg_20_2:Find("sel/content/Text"), var_20_0)

	LoadImageSpriteAsync = var_1_10005

	local var_20_1 = "island/islandtechnology/tech_type_"

	IslandTechBelong = var_8

	local var_20_2 = var_20_1 .. var_8.Fields[var_3]
	local var_20_3 = arg_20_2

	var_1_10005(var_20_2, arg_20_2.Find(var_20_3, "sel/content/Image"), true)

	onToggle = var_1_10005

	local var_20_4 = arg_20_0
	local var_20_5 = arg_20_2

	local function var_20_6(arg_21_0)
		if arg_21_0 and arg_20_0.curPage ~= var_0 then
			arg_20_0.curPage = var_0

			local var_21_0 = arg_20_0

			var_1.SwitchPage(var_21_0)
		end

		return
	end

	SFX_PANEL = var_20_3

	var_1_10005(var_20_4, var_20_5, var_20_6, var_20_3)

	return
end

function var_0_1.UpdateTypeItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.commonTypes[arg_22_1 + 1]

	setActive = var_4

	var_4(arg_22_2:Find("unsel/tip"), arg_22_0:IsReceiveByType(var_22_0))

	setActive = var_4

	var_4(arg_22_2:Find("sel/tip"), arg_22_0:IsReceiveByType(var_22_0))

	return
end

function var_0_1.IsReceiveByType(arg_23_0, arg_23_1)
	pairs = var_1_10002

	local var_23_0 = arg_23_0.techAgency

	for iter_23_0, iter_23_1 in var_1_10002(var_4.GetTechnologys(var_23_0)) do
		if iter_23_1:getConfig("tech_belong") == arg_23_1 then
			local var_23_1 = iter_23_1:GetStatus()

			IslandTechnology = var_1_10008

			if var_23_1 == var_1_10008.STATUS.RECEIVE then
				return true
			end
		end
	end

	return false
end

function var_0_1.FlushCentreTip(arg_24_0)
	setActive = var_1_10001

	local var_24_0 = arg_24_0.centreTipTF
	local var_24_1 = arg_24_0
	local var_24_2 = arg_24_0.IsReceiveByType

	IslandTechBelong = var_1_10007

	var_1_10001(var_24_0, var_24_2(var_24_1, var_1_10007.CENTRE))

	return
end

function var_0_1.SwitchPage(arg_25_0)
	pairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.pages) do
		if iter_25_0 == arg_25_0.curPage then
			iter_25_1:ExecuteAction("Show")
		else
			iter_25_1:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_1.OnShow(arg_26_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_26_0.centreToggleTF, true)

	local var_26_0 = arg_26_0.quickPanel

	var_1.ExecuteAction(var_26_0, "Show")
	arg_26_0:CheckAutoUnlock()

	return
end

function var_0_1.CheckAutoUnlock(arg_27_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_27_0 = var_1_10001(var_1_10003)
	local var_27_1 = var_1.GetIsland(var_27_0)
	local var_27_2 = var_1.GetTechnologyAgency(var_27_1)

	var_1.TryAutoUnlock(var_27_2, function()
		local var_28_0 = arg_27_0

		var_0.Flush(var_28_0)

		return
	end)

	return
end

function var_0_1.Flush(arg_29_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_29_0 = var_1_10001(var_1_10003)
	local var_29_1 = var_1.GetIsland(var_29_0)

	arg_29_0.techAgency = var_1.GetTechnologyAgency(var_29_1)

	local var_29_2 = arg_29_0.typeUIList

	var_1.align(var_29_2, #arg_29_0.commonTypes)
	arg_29_0:FlushCentreTip()

	local var_29_3 = arg_29_0.pages[arg_29_0.curPage]

	var_1.ExecuteAction(var_29_3, "Flush")

	local var_29_4 = arg_29_0.quickPanel

	var_1.ExecuteAction(var_29_4, "Flush")

	local var_29_5 = arg_29_0.detailPanel

	if var_1.isShowing(var_29_5) then
		local var_29_6 = arg_29_0.detailPanel

		var_1.ExecuteAction(var_29_6, "Flush")
	end

	return
end

function var_0_1.OnHide(arg_30_0)
	local var_30_0 = arg_30_0.quickPanel

	var_1.ExecuteAction(var_30_0, "Hide")

	local var_30_1 = arg_30_0.detailPanel

	var_1.ExecuteAction(var_30_1, "Hide")

	return
end

function var_0_1.OnDisable(arg_31_0)
	arg_31_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_32_0)
	if arg_32_0.quickPanel then
		local var_32_0 = arg_32_0.quickPanel

		var_1.Destroy(var_32_0)

		arg_32_0.quickPanel = nil
	end

	if arg_32_0.detailPanel then
		local var_32_1 = arg_32_0.detailPanel

		var_1.Destroy(var_32_1)

		arg_32_0.detailPanel = nil
	end

	pairs = var_1

	for iter_32_0, iter_32_1 in var_1(arg_32_0.pages) do
		if iter_32_1 then
			iter_32_1:Destroy()

			iter_32_1 = nil
		end
	end

	return
end

return var_0_1
