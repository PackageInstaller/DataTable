class = var_0_10000

local var_0_0 = "IdolPTPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

var_0_1.RefreshTime = 300

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.lableList = var_1.Find(var_1_0, "list")
	arg_1_0.lableItems = {}

	for iter_1_0 = 0, arg_1_0.lableList.childCount - 1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_1_1 = arg_1_0.lableItems
		local var_1_2 = arg_1_0.lableList

		var_1_10005(var_1_1, var_8.GetChild(var_1_2, iter_1_0))
	end

	local var_1_3 = arg_1_0.bg

	arg_1_0.linkBtn = var_1.Find(var_1_3, "btn_link")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	return (var_0_1.super.OnDataSetting(arg_2_0))
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.displayBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.SHOW_AWARD_WINDOW

		PtAwardWindow = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004, {
			type = arg_3_0.ptData.type,
			dropList = arg_3_0.ptData.dropList,
			targets = arg_3_0.ptData.targets,
			level = arg_3_0.ptData.level,
			count = arg_3_0.ptData.count,
			resId = arg_3_0.ptData.resId
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.battleBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.getBtn

	local function var_3_8()
		local var_6_0 = arg_3_0.ptData
		local var_6_1, var_6_2 = var_0.GetResProgress(var_6_0)
		local var_6_3 = arg_3_0
		local var_6_4 = var_2.emit

		ActivityMediator = var_2_10005

		local var_6_5 = var_2_10005.EVENT_PT_OPERATION
		local var_6_6 = {
			cmd = 1
		}
		local var_6_7 = arg_3_0.ptData

		var_6_6.activity_id = var_7.GetId(var_6_7)
		var_6_6.arg1 = var_6_2

		var_6_4(var_6_3, var_6_5, var_6_6)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.linkBtn, function()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_7_2 = var_2_10003.OPEN_LAYER

		Context = var_2_10004

		local var_7_3 = var_2_10004.New
		local var_7_4 = {}

		InstagramLayer = var_2_10007
		var_7_4.viewComponent = var_2_10007
		InstagramMediator = var_2_10007
		var_7_4.mediator = var_2_10007

		local var_7_5 = {}

		ActivityConst = var_2_10008
		var_7_5.id = var_2_10008.IDOL_INS_ID
		var_7_4.data = var_7_5

		var_7_1(var_7_0, var_7_2, var_7_3(var_7_4))

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	var_0_1.super.OnUpdateFlush(arg_8_0)

	if arg_8_0.linkAct and not var_1:isEnd() then
		local var_8_0 = {}

		math = var_3

		local var_8_1 = var_3.floor(#var_1.data1_list / 2)

		for iter_8_0 = 1, var_8_1 do
			local var_8_2

			if not var_8_0[var_1.data1_list[2 * iter_8_0 - 1]] then
				var_8_2 = 0
			end

			if not var_1.data1_list[2 * iter_8_0] then
				var_1_10010 = 0
			end

			var_8_0[var_8] = var_8_2 + var_1_10010
		end

		local var_8_3 = {}

		pairs = var_5

		for iter_8_1, iter_8_2 in var_5(var_8_0) do
			table = var_1_10010

			var_1_10010.insert(var_8_3, {
				name = iter_8_1,
				count = iter_8_2
			})
		end

		table = var_5

		var_5.sort(var_8_3, function(arg_9_0, arg_9_1)
			if arg_9_0.count == arg_9_1.count then
				return arg_9_0.name < arg_9_1.name
			else
				return arg_9_0.count > arg_9_1.count
			end

			return
		end)

		math = var_5

		local var_8_4 = var_5.min(#var_8_3, #arg_8_0.lableItems)

		for iter_8_3 = 1, var_8_4 do
			local var_8_5 = arg_8_0.lableItems[iter_8_3]

			setText = var_1_10011

			local var_8_6 = var_8_5
			local var_8_7 = var_8_5.Find(var_8_6, "name")
			local var_8_8 = "#"

			tostring = var_8_6
			ShipGroup = var_1_10017

			var_1_10011(var_8_7, var_8_8 .. var_8_6(var_1_10017.getDefaultShipNameByGroupID(var_8_3[iter_8_3].name)) .. "#")

			setText = var_1_10011

			var_1_10011(var_8_5:Find("Text"), arg_8_0:TransFormat(var_8_3[iter_8_3].count))
		end

		for iter_8_4 = var_8_4 + 1, #arg_8_0.lableItems do
			local var_8_9 = arg_8_0.lableItems[iter_8_4]

			setText = var_1_10011

			var_1_10011(var_8_9:Find("name"), "")

			setText = var_1_10011

			var_1_10011(var_8_9:Find("Text"), "0")
		end
	end

	arg_8_0:GetWorldRank(arg_8_0.RefreshTime)

	return
end

function var_0_1.TransFormat(arg_10_0, arg_10_1)
	tonumber = var_1_10002
	arg_10_1 = var_1_10002(arg_10_1) or 0
	math = var_2

	local var_10_0 = var_2.floor(arg_10_1 / 1000)
	local var_10_1 = arg_10_1 % 10

	if var_10_0 >= 1 then
		local var_10_2 = var_10_0
		local var_10_3

		if not (var_10_1 > 0) or not ("." .. var_10_1) then
			var_10_3 = ""
		end

		return var_10_2 .. var_10_3 .. "K"
	else
		return arg_10_1
	end

	return
end

function var_0_1.GetWorldRank(arg_11_0, arg_11_1)
	if arg_11_0.linkAct then
		var_1_10004 = arg_11_0.linkAct

		if var_2.isEnd(var_1_10004) then
			return
		end

		local var_11_0 = arg_11_0.linkAct.id

		pg = var_1_10003

		local var_11_1 = var_1_10003.TimeMgr.GetInstance()
		local var_11_2 = var_3.GetServerTime(var_11_1)

		getProxy = var_1_10004
		ActivityProxy = var_1_10006

		local var_11_3

		if not var_1_10004(var_1_10006).requestTime[var_11_0] then
			var_11_3 = 0
		end

		if arg_11_1 <= var_11_2 - var_11_3 then
			local var_11_4 = arg_11_0
			local var_11_5 = arg_11_0.emit

			ActivityMediator = var_1_10006

			var_11_5(var_11_4, var_1_10006.FETCH_INSTARGRAM, {
				activity_id = var_11_0
			})
		end

		return
	end
end

function var_0_1.NeedTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_12_0 = var_1_10000(var_1_10002)
	local var_12_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	if var_12_1(var_12_0, var_1_10003.IDOL_PT_ID) and not var_0:isEnd() then
		return var_0:readyToAchieve()
	end

	return
end

return var_0_1
