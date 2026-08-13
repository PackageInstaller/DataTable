class = var_0_10000

local var_0_0 = "CommanderHomeBatchSelPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CommanderHomeBaseSelPage"))

function var_0_1.getUIName(arg_1_0)
	return "CatteryBatchSelPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "page/frame/scrollrect")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_1, "LScrollRect")

	local var_2_2 = arg_2_0._tf

	arg_2_0.okBtn = var_1.Find(var_2_2, "page/frame/ok_button")
	UIItemList = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "page/frame/list/content")
	local var_2_6 = arg_2_0._tf

	arg_2_0.uiList = var_2_3(var_2_5, var_3.Find(var_2_6, "page/frame/comanderTF"))

	local var_2_7 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_7, "page/close_btn")

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.okBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Filter(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Filter(arg_7_0)
	local var_7_0 = arg_7_0.home
	local var_7_1 = var_1.GetCatteries(var_7_0)
	local var_7_2 = {}

	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0.displayCatteries) do
		local var_7_3 = var_7_1[iter_7_0]

		var_1_10009 = var_8.ExistCommander(var_7_3)

		local var_7_4 = var_8:GetCommanderId()
		local var_7_5 = var_8

		if not var_8.IsLocked(var_7_5) and var_1_10009 and iter_7_1.commanderId == var_7_4 then
			-- block empty
		elseif not var_11 and not var_1_10009 and iter_7_1.commanderId == 0 then
			-- block empty
		else
			table = var_7_5

			var_7_5.insert(var_7_2, {
				pos = iter_7_0,
				id = iter_7_1.commanderId
			})
		end
	end

	local var_7_6 = {}

	ipairs = var_4

	for iter_7_2, iter_7_3 in var_4(var_7_2) do
		table = var_1_10009

		var_1_10009.insert(var_7_6, function(arg_8_0)
			local var_8_0 = arg_7_0
			local var_8_1 = var_1.emit

			CommanderHomeMediator = var_2_10003

			var_8_1(var_8_0, var_2_10003.ON_SEL_COMMANDER, iter_7_3.pos, iter_7_3.id, false, arg_8_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_7_6)

	return
end

function var_0_1.Update(arg_9_0, arg_9_1)
	arg_9_0:Show()

	arg_9_0.home = arg_9_1

	arg_9_0:InitList()
	var_0_1.super.Update(arg_9_0)
	arg_9_0:UpdateSelectedList()

	return
end

function var_0_1.Show(arg_10_0)
	var_0_1.super.Show(arg_10_0)

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.emit

	CommanderHomeLayer = var_1_10003

	var_10_1(var_10_0, var_1_10003.DESC_PAGE_OPEN)

	return
end

function var_0_1.InitList(arg_11_0)
	local var_11_0 = arg_11_0.home
	local var_11_1 = var_1.GetCatteries(var_11_0)

	arg_11_0.maxCnt = 0
	arg_11_0.displayCatteries = {}
	pairs = var_2

	for iter_11_0, iter_11_1 in var_2(var_11_1) do
		local var_11_2 = iter_11_1:GetState()
		local var_11_3 = iter_11_1
		local var_11_4 = iter_11_1.ExistCommander(var_11_3)

		Cattery = var_11_3

		local var_11_5 = var_11_2 == var_11_3.STATE_LOCK

		table = var_1_10010
		var_1_10010 = var_1_10010.insert

		local var_11_6 = arg_11_0.displayCatteries
		local var_11_7 = {
			isLock = var_11_5
		}
		local var_11_8

		if not var_11_4 or not iter_11_1:GetCommanderId() then
			var_11_8 = 0
		end

		var_11_7.commanderId = var_11_8

		var_1_10010(var_11_6, var_11_7)

		if not var_11_5 then
			arg_11_0.maxCnt = arg_11_0.maxCnt + 1
		end
	end

	local var_11_9 = arg_11_0.uiList

	var_2.make(var_11_9, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_11_0

			var_3.UpdateSelectedCard(var_12_0, arg_12_1 + 1, arg_12_2)
		end

		return
	end)

	return
end

function var_0_1.UpdateSelectedList(arg_13_0)
	local var_13_0 = arg_13_0.uiList

	var_1.align(var_13_0, #arg_13_0.displayCatteries)

	return
end

function var_0_1.UpdateSelectedCard(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.displayCatteries[arg_14_1].commanderId

	getProxy = var_1_10005
	CommanderProxy = var_1_10006

	local var_14_1 = var_1_10005(var_1_10006)

	if var_5.RawGetCommanderById(var_14_1, var_14_0) then
		CommanderCard = var_14_1

		local var_14_2 = var_14_1.New(arg_14_2)

		var_6.update(var_14_2, var_5)

		local var_14_3 = arg_14_0
		local var_14_4 = arg_14_0.CheckIncludeSelf(var_14_3, var_5.id)

		setActive = var_14_3
		var_1_10010 = arg_14_2

		var_14_3(arg_14_2.Find(var_1_10010, "info/home"), not var_14_4)
	end

	if not var_3.isLock then
		onButton = var_6

		local var_14_5 = arg_14_0
		local var_14_6 = arg_14_2

		local function var_14_7()
			if var_0 then
				var_0.commanderId = 0

				local var_15_0 = arg_14_0

				var_0.UpdateSelectedCard(var_15_0, arg_14_1, arg_14_2)

				local var_15_1 = arg_14_0

				var_0.UpdateCardSelected(var_15_1)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_6(var_14_5, var_14_6, var_14_7, var_1_10010)
	end

	setActive = var_6

	var_6(arg_14_2:Find("info"), var_5 ~= nil)

	setActive = var_6

	var_6(arg_14_2:Find("lock_b"), var_3.isLock)

	setActive = var_6

	var_6(arg_14_2:Find("empty_b"), var_5 == nil)

	setActive = var_6

	var_6(arg_14_2:Find("tip"), false)

	setActive = var_6

	var_6(arg_14_2:Find("up"), false)

	return
end

function var_0_1.CheckIncludeSelf(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.home
	local var_16_1 = var_2.GetCatteries(var_16_0)

	ipairs = var_16_0

	for iter_16_0, iter_16_1 in var_16_0(var_16_1) do
		if iter_16_1:GetCommanderId() == arg_16_1 then
			return false
		end
	end

	return true
end

function var_0_1.GetSelectedCommanderList(arg_17_0)
	local var_17_0 = {}

	ipairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.displayCatteries) do
		if not iter_17_1.isLock and iter_17_1.commanderId ~= 0 then
			table = var_7

			var_7.insert(var_17_0, iter_17_1.commanderId)
		end
	end

	return var_17_0
end

function var_0_1.GetEmptyPosIndex(arg_18_0)
	pairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.displayCatteries) do
		if not iter_18_1.isLock and iter_18_1.commanderId == 0 then
			return iter_18_0
		end
	end

	return -1
end

function var_0_1.OnUpdateItem(arg_19_0, arg_19_1, arg_19_2)
	var_0_1.super.OnUpdateItem(arg_19_0, arg_19_1, arg_19_2)

	local var_19_0 = arg_19_1 + 1
	local var_19_1 = arg_19_0.displays[var_19_0]
	local var_19_2

	if not arg_19_0.cards[arg_19_2].commanderVO or not var_5.commanderVO.id then
		var_19_2 = 0
	end

	local var_19_3 = arg_19_0
	local var_19_4 = arg_19_0.GetSelectedCommanderList(var_19_3)

	setActive = var_19_3

	local var_19_5 = var_5._tf
	local var_19_6 = var_9.Find(var_19_5, "sel_b")

	table = var_19_5

	var_19_3(var_19_6, var_19_5.contains(var_19_4, var_19_2))

	if var_19_2 > 0 then
		local var_19_7 = arg_19_0
		local var_19_8 = arg_19_0.CheckIncludeSelf(var_19_7, var_19_2)

		setActive = var_19_7

		local var_19_9 = var_5._tf

		var_19_7(var_10.Find(var_19_9, "info/home"), not var_19_8)
	end

	return
end

function var_0_1.OnSelected(arg_20_0, arg_20_1)
	if arg_20_0:GetEmptyPosIndex() <= 0 then
		pg = var_3

		local var_20_0 = var_3.TipsMgr.GetInstance()
		local var_20_1 = var_3.ShowTips

		i18n = var_1_10005

		var_20_1(var_20_0, var_1_10005("commander_selected_max", arg_20_0.maxCnt))

		return
	end

	if not arg_20_1.commanderVO then
		return
	end

	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_0.GetSelectedCommanderList(var_20_2)

	table = var_20_2

	local var_20_4

	if not var_20_2.contains(var_20_3, var_3.id) then
		var_20_4 = arg_20_0.displayCatteries[var_2]
		var_20_4.commanderId = var_3.id
	else
		ipairs = var_20_4

		for iter_20_0, iter_20_1 in var_20_4(arg_20_0.displayCatteries) do
			if iter_20_1.commanderId == var_3.id then
				arg_20_0.displayCatteries[iter_20_0].commanderId = 0

				break
			end
		end
	end

	arg_20_0:UpdateCardSelected()
	arg_20_0:UpdateSelectedList()

	return
end

function var_0_1.UpdateCardSelected(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.GetSelectedCommanderList(var_21_0)

	pairs = var_21_0

	for iter_21_0, iter_21_1 in var_21_0(arg_21_0.cards) do
		local var_21_2

		if not iter_21_1.commanderVO or not iter_21_1.commanderVO.id then
			var_21_2 = 0
		end

		setActive = var_1_10008

		local var_21_3 = iter_21_1._tf
		local var_21_4 = var_9.Find(var_21_3, "sel_b")

		table = var_21_3

		var_1_10008(var_21_4, var_21_3.contains(var_21_1, var_21_2))
	end

	return
end

function var_0_1.Hide(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.emit

	CommanderHomeLayer = var_1_10003

	var_22_1(var_22_0, var_1_10003.DESC_PAGE_CLOSE)
	var_0_1.super.Hide(arg_22_0)

	return
end

return var_0_1
