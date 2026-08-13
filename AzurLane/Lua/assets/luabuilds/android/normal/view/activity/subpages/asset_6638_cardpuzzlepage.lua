class = var_0_10000

local var_0_0 = "CardPuzzlePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.titleTF = var_1.Find(var_1_1, "title")

	local var_1_2 = arg_1_0.bg

	arg_1_0.progressTF = var_1.Find(var_1_2, "progress")

	local var_1_3 = arg_1_0.bg

	arg_1_0.descTF = var_1.Find(var_1_3, "desc")

	local var_1_4 = arg_1_0.bg

	arg_1_0.startBtn = var_1.Find(var_1_4, "start_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_5, "get_btn")

	local var_1_6 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_6, "got_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_7, "levels/tpl")

	local var_1_8 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_8, "levels")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.levelList = var_1.getConfig(var_2_0, "config_data")[1]

	local var_2_1 = arg_2_0.activity

	arg_2_0.awardList = var_1.getConfig(var_2_1, "config_data")[2]

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.uilist

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventInit then
			local var_4_0 = arg_3_0

			var_3.InitItem(var_4_0, arg_4_1, arg_4_2)
		else
			UIItemList = var_3

			if arg_4_0 == var_3.EventUpdate then
				local var_4_1 = arg_3_0

				var_3.UpdateItem(var_4_1, arg_4_1, arg_4_2)
			end
		end

		return
	end)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.startBtn

	local function var_3_3()
		if not arg_3_0.selectedId then
			return
		end

		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.GO_CARDPUZZLE_COMBAT, arg_3_0.selectedId)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_1, var_3_2, var_3_3, var_1_10005)

	arg_3_0.selectedId = arg_3_0:GetCurLevel()

	arg_3_0:UpdateLevelInfo()

	return
end

function var_0_1.InitItem(arg_6_0, arg_6_1, arg_6_2)
	GetImageSpriteFromAtlasAsync = var_1_10003

	var_1_10003("ui/activityuipage/cardpuzzlepage_atlas", arg_6_1 + 1, arg_6_2:Find("normal/num"), true)

	GetImageSpriteFromAtlasAsync = var_1_10003

	var_1_10003("ui/activityuipage/cardpuzzlepage_atlas", arg_6_1 + 1, arg_6_2:Find("selected/num"), true)

	return
end

function var_0_1.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1 + 1
	local var_7_1 = arg_7_0.levelList[var_7_0]

	setActive = var_1_10005

	var_1_10005(arg_7_2:Find("selected"), arg_7_0.selectedId == var_7_1)

	table = var_1_10005

	local var_7_2 = var_1_10005.contains(arg_7_0.finishList, var_7_1)

	setActive = var_6

	var_6(arg_7_2:Find("finish"), var_7_2)

	setActive = var_6

	var_6(arg_7_2:Find("normal"), not var_7_2 and arg_7_0.selectedId ~= var_7_1)

	onButton = var_6

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_2

	local function var_7_5()
		arg_7_0.selectedId = var_7_1

		local var_8_0 = arg_7_0.uilist

		var_0.align(var_8_0, #arg_7_0.levelList)

		local var_8_1 = arg_7_0

		var_0.UpdateLevelInfo(var_8_1)

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_7_3, var_7_4, var_7_5, var_1_10010)

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	local var_9_0 = arg_9_0.activity

	arg_9_0.gotList = var_1.getData1List(var_9_0)
	arg_9_0.finishList = arg_9_0.activity.data2_list

	local var_9_1 = arg_9_0.uilist

	var_1.align(var_9_1, #arg_9_0.levelList)

	if arg_9_0:CheckAward() then
		setActive = var_1

		var_1(arg_9_0.getBtn, true)

		onButton = var_1

		local var_9_2 = arg_9_0
		local var_9_3 = arg_9_0.getBtn

		local function var_9_4()
			local var_10_0 = arg_9_0
			local var_10_1 = var_0.emit

			ActivityMediator = var_2_10002

			local var_10_2 = var_2_10002.EVENT_OPERATION
			local var_10_3 = {
				cmd = 2,
				activity_id = arg_9_0.activity.id
			}
			local var_10_4 = arg_9_0

			var_10_3.arg1 = var_4.CheckAward(var_10_4)

			var_10_1(var_10_0, var_10_2, var_10_3)

			return
		end

		SFX_PANEL = var_1_10005

		var_1(var_9_2, var_9_3, var_9_4, var_1_10005)
	else
		setActive = var_1

		var_1(arg_9_0.getBtn, false)
	end

	setActive = var_1

	var_1(arg_9_0.gotBtn, #arg_9_0.gotList == #arg_9_0.awardList)

	setText = var_1

	local var_9_5 = arg_9_0.progressTF

	setColorStr = var_3

	var_1(var_9_5, var_3(#arg_9_0.finishList, "#C2FFF3") .. "/" .. #arg_9_0.levelList)
	arg_9_0:UpdateEveryDayTip()

	return
end

function var_0_1.CheckAward(arg_11_0)
	if #arg_11_0.gotList == #arg_11_0.awardList then
		return nil
	end

	local var_11_0 = #arg_11_0.finishList

	ipairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_0.awardList) do
		table = var_1_10007

		if not var_1_10007.contains(arg_11_0.gotList, iter_11_1[1]) and iter_11_1[1] <= var_11_0 then
			return iter_11_1[1]
		end
	end

	return nil
end

function var_0_1.UpdateLevelInfo(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.puzzle_combat_template[arg_12_0.selectedId]

	setText = var_2

	var_2(arg_12_0.titleTF, "·" .. var_12_0.name)

	setText = var_2

	var_2(arg_12_0.descTF, var_12_0.description)

	return
end

function var_0_1.GetCurLevel(arg_13_0)
	arg_13_0.finishList = arg_13_0.activity.data2_list
	ipairs = var_1

	for iter_13_0, iter_13_1 in var_1(arg_13_0.levelList) do
		table = var_1_10006

		if not var_1_10006.contains(arg_13_0.finishList, iter_13_1) then
			return iter_13_1, iter_13_0
		end
	end

	return arg_13_0.levelList[#arg_13_0.levelList], #arg_13_0.levelList
end

function var_0_1.UpdateEveryDayTip(arg_14_0)
	if #arg_14_0.gotList == #arg_14_0.awardList then
		return
	end

	if arg_14_0:CheckAward() then
		return
	end

	local var_14_0, var_14_1 = arg_14_0:GetCurLevel()
	local var_14_2 = arg_14_0.items
	local var_14_3 = var_3.GetChild(var_14_2, var_14_1 - 1)
	local var_14_4 = var_3.Find(var_14_3, "tip")

	getProxy = var_14_3
	PlayerProxy = var_5

	local var_14_5 = var_14_3(var_5)
	local var_14_6 = var_4.getData(var_14_5).id
	local var_14_7 = "DAY_TIP_"
	local var_14_8 = arg_14_0.activity.id
	local var_14_9 = "_"
	local var_14_10 = var_14_6
	local var_14_11 = "_"
	local var_14_12 = arg_14_0.activity
	local var_14_13 = var_14_7 .. var_14_8 .. var_14_9 .. var_14_10 .. var_14_11 .. var_10.getDayIndex(var_14_12)

	PlayerPrefs = var_14_8

	if var_14_8.GetInt(var_14_13) == 0 then
		setActive = var_6

		var_6(var_14_4, true)

		PlayerPrefs = var_6

		var_6.SetInt(var_14_13, 1)
	else
		setActive = var_6

		var_6(var_14_4, false)
	end

	return
end

return var_0_1
