class = var_0_10000

local var_0_0 = "TownScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = {}

Vector2 = var_2
var_0_2[1] = var_2.New(111.3, 150)
Vector2 = var_2
var_0_2[2] = var_2.New(-235.9, 113.2)
Vector2 = var_2
var_0_2[3] = var_2.New(570, 424.5)
Vector2 = var_2
var_0_2[4] = var_2.New(-790.3, 569.9)
Vector2 = var_2
var_0_2[5] = var_2.New(-440.7, -26.8)
Vector2 = var_2
var_0_2[6] = var_2.New(-1206.2, 2)
Vector2 = var_2
var_0_2[7] = var_2.New(-705.8, -379)
Vector2 = var_2
var_0_2[8] = var_2.New(-1021.7, -153.9)
Vector2 = var_2
var_0_2[9] = var_2.New(-385.6, -479.7)
Vector2 = var_2
var_0_2[10] = var_2.New(367.1, -749)
Vector2 = var_2
var_0_2[11] = var_2.New(107.6, -684.9)
Vector2 = var_2
var_0_2[12] = var_2.New(338.7, 150)
var_0_1.RANDOM_POS = var_0_2
Vector2 = var_0_2
var_0_1.STATIC_POS = var_0_2.New(-440.7, -26.8)
var_0_1.SDScale = 0.5

function var_0_1.getUIName(arg_1_0)
	return "TownUI"
end

function var_0_1.SetActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	local var_2_0 = arg_2_0.activity

	arg_2_0.shipIds = var_2.GetShipIds(var_2_0)

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.mapTF = var_1.Find(var_3_0, "map")

	local var_3_1 = arg_3_0._tf

	arg_3_0.bgTFs = var_1.Find(var_3_1, "map/bg")

	local var_3_2 = arg_3_0._tf

	arg_3_0.slotTFs = var_1.Find(var_3_2, "map/content")

	local var_3_3 = arg_3_0._tf

	arg_3_0.slotTpl = var_1.Find(var_3_3, "map/content/tpl")
	setActive = var_1

	var_1(arg_3_0.slotTpl, false)

	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_1.Find(var_3_4, "ui")

	arg_3_0.topUI = var_1.Find(var_3_5, "top")

	local var_3_6 = arg_3_0.topUI
	local var_3_7 = var_2.Find(var_3_6, "gold/Text")
	local var_3_8 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_3_0.goldText = var_3_8(var_3_7, var_4(var_1_10005))
	TownInfoPage = var_2
	arg_3_0.infoPage = var_2.New(var_1, arg_3_0)

	local var_3_9 = arg_3_0.infoPage

	var_2.ExecuteAction(var_3_9, "Flush")

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.topUI
	local var_4_2 = var_3.Find(var_4_1, "back")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.onBackPressed(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.topUI
	local var_4_6 = var_3.Find(var_4_5, "help")

	local function var_4_7()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.town_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_5)

	onScroll = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.mapTF, function(arg_7_0)
		return
	end)

	local var_4_8 = arg_4_0.activity

	arg_4_0.timeCfg = var_1.getConfig(var_4_8, "config_client").endingtime
	arg_4_0.spineRoles = {}

	arg_4_0:UpdateShips()

	Timer = var_1
	arg_4_0.timer = var_1.New(function()
		local var_8_0 = arg_4_0

		var_0.OnUpdateTime(var_8_0)

		return
	end, 1, -1)

	local var_4_9 = arg_4_0.timer

	var_1.Start(var_4_9)
	arg_4_0:OnUpdateTime()

	seriesAsync = var_1

	var_1({
		function(arg_9_0)
			pg = var_2_10001

			local var_9_0 = var_2_10001.activity_town_level
			local var_9_1 = arg_4_0.activity

			if var_9_0[var_2.GetTownLevel(var_9_1)].unlock_story ~= "" then
				pg = var_2

				local var_9_2 = var_2.NewStoryMgr.GetInstance()

				if not var_2.IsPlayed(var_9_2, var_1) then
					pg = var_2

					local var_9_3 = var_2.NewStoryMgr.GetInstance()

					var_2.Play(var_9_3, var_1, arg_9_0)

					goto label_9_0
				end
			end

			arg_9_0()

			::label_9_0::

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_4_0.activity
			local var_10_1 = var_1.getConfig(var_10_0, "config_client").story[1][1]

			if (function()
				underscore = var_3_10000

				local var_11_0 = var_3_10000.all
				local var_11_1 = arg_4_0.activity

				return var_11_0(var_1.getConfig(var_11_1, "config_client").beforestory, function(arg_12_0)
					pg = var_4_10001

					local var_12_0 = var_4_10001.NewStoryMgr.GetInstance()

					return var_1.IsPlayed(var_12_0, arg_12_0[1])
				end)
			end)() then
				pg = var_3

				local var_10_2 = var_3.NewStoryMgr.GetInstance()

				if not var_3.IsPlayed(var_10_2, var_10_1) then
					pg = var_3

					local var_10_3 = var_3.NewStoryMgr.GetInstance()

					var_3.Play(var_10_3, var_10_1, arg_10_0)

					goto label_10_0
				end
			end

			arg_10_0()

			::label_10_0::

			return
		end,
		function(arg_13_0)
			pg = var_2_10001

			local var_13_0 = var_2_10001.NewStoryMgr.GetInstance()

			if not var_1.IsPlayed(var_13_0, "NG0046") then
				pg = var_1

				local var_13_1 = var_1.SystemGuideMgr.GetInstance()

				var_1.PlayByGuideId(var_13_1, "NG0046")
			end

			return
		end
	}, function()
		return
	end)

	local var_4_10 = arg_4_0.activity

	var_1.SetBubbleTipTag(var_4_10, true)

	return
end

function var_0_1.GetRandomPos(arg_15_0)
	local var_15_0 = {}

	for iter_15_0 = 1, #var_0_1.RANDOM_POS do
		table = var_1_10006

		var_1_10006.insert(var_15_0, iter_15_0)
	end

	shuffle = var_2

	var_2(var_15_0)

	local var_15_1 = {}

	for iter_15_1 = 1, 8 do
		table = var_1_10007

		var_1_10007.insert(var_15_1, var_0_1.RANDOM_POS[var_15_0[iter_15_1]])
	end

	return var_15_1
end

function var_0_1.OnUpdateTime(arg_16_0)
	arg_16_0:UpdateBg()
	arg_16_0:UpdateGold()
	arg_16_0:UpdateBubbles()

	local var_16_0 = arg_16_0.infoPage

	var_1.ExecuteAction(var_16_0, "OnUpdateTime")

	return
end

function var_0_1.GetBgName(arg_17_0, arg_17_1)
	pg = var_1_10002

	local var_17_0 = var_1_10002.TimeMgr.GetInstance()
	local var_17_1 = var_2.GetServerHour(var_17_0)

	ipairs = var_17_0

	for iter_17_0, iter_17_1 in var_17_0(arg_17_0.timeCfg) do
		if var_17_1 >= iter_17_1[1][1] and var_17_1 < var_8[2] then
			return iter_17_1[2]
		end
	end

	return "day"
end

function var_0_1.UpdateBg(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetBgName(var_18_0)

	eachChild = var_18_0

	var_18_0(arg_18_0.bgTFs, function(arg_19_0)
		setActive = var_2_10001

		var_2_10001(arg_19_0, arg_19_0.name == var_18_1)

		return
	end)

	return
end

function var_0_1.UpdateGold(arg_20_0)
	local var_20_0 = arg_20_0.activity

	arg_20_0.gold = var_1.GetTotalGold(var_20_0)

	local var_20_1 = arg_20_0.goldText

	TownActivity = var_20_0
	var_20_1.text = var_20_0.GoldToShow(arg_20_0.gold)

	return
end

function var_0_1.UpdateBubbles(arg_21_0)
	arg_21_0.bubblesPosList = {}
	ipairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0.shipIds) do
		if 0 < iter_21_1 then
			getProxy = var_6
			BayProxy = var_1_10007
			var_1_10007 = var_6(var_1_10007)

			if var_6.RawGetShipById(var_1_10007, iter_21_1) then
				var_1_10007 = arg_21_0.activity

				local var_21_0 = var_6.GetBubbleCntByPos(var_1_10007, iter_21_0)
				local var_21_1 = arg_21_0.slotTFs

				var_1_10007 = var_1_10007.Find(var_21_1, iter_21_0 .. "/bubble")
				setActive = var_21_1

				var_21_1(var_1_10007, var_21_0 > 0)

				if 0 < var_21_0 then
					table = var_8

					var_8.insert(arg_21_0.bubblesPosList, iter_21_0)

					eachChild = var_8

					var_8(var_1_10007, function(arg_22_0)
						setActive = var_2_10001

						local var_22_0 = arg_22_0

						tonumber = var_2_10003

						var_2_10001(var_22_0, var_2_10003(arg_22_0.name) == var_21_0)

						return
					end)
				end
			end
		end
	end

	return
end

function var_0_1.UpdateShips(arg_23_0)
	arg_23_0:CleanSpines()

	Clone = var_1
	arg_23_0.randomPos = var_1(var_0_1.RANDOM_POS)
	ipairs = var_1

	for iter_23_0, iter_23_1 in var_1(arg_23_0.shipIds) do
		arg_23_0:UpdateShip(iter_23_0, iter_23_1)
	end

	arg_23_0:UpdateBubbles()

	return
end

function var_0_1.UpdateShip(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.slotTFs

	if var_3.Find(var_24_0, arg_24_1) then
		setActive = var_24_0

		var_24_0(var_24_3, false)
	end

	local var_24_1, var_24_2

	if 0 < arg_24_2 then
		getProxy = var_4
		BayProxy = var_24_1
		var_24_1 = var_4(var_24_1)
		var_24_2 = var_4.RawGetShipById(var_24_1, arg_24_2)
	else
		var_24_2 = false
	end

	if false then
		var_24_2 = true
	end

	if not var_24_2 then
		return
	end

	local var_24_3

	if not var_24_3 then
		cloneTplTo = var_24_1
		var_24_3 = var_24_1(arg_24_0.slotTpl, arg_24_0.slotTFs, arg_24_1)
	end

	local var_24_4 = arg_24_0.activity
	local var_24_5 = var_5.GetBubbleCntByPos(var_24_4, arg_24_1)

	if 0 < var_24_5 then
		table = var_24_6

		if var_24_6.contains(arg_24_0.randomPos, var_0_1.STATIC_POS) then
			setAnchoredPosition = var_24_6

			var_24_6(var_24_3, var_0_1.STATIC_POS)

			table = var_24_6

			var_24_6.removebyvalue(arg_24_0.randomPos, var_0_1.STATIC_POS)

			goto label_24_0
		end
	end

	local var_24_6 = arg_24_0.randomPos[#arg_24_0.randomPos]

	setAnchoredPosition = var_7

	var_7(var_24_3, var_24_6)

	table = var_7

	var_7.removebyvalue(arg_24_0.randomPos, var_24_6)

	::label_24_0::

	onButton = var_24_6

	local var_24_7 = arg_24_0
	local var_24_8 = var_24_3:Find("bubble")

	local function var_24_9()
		if not arg_24_0.bubblesPosList or #arg_24_0.bubblesPosList <= 0 then
			return
		end

		local var_25_0 = arg_24_0.activity

		if var_0.HasMaxGold(var_25_0) then
			pg = var_0

			local var_25_1 = var_0.MsgboxMgr.GetInstance()
			local var_25_2 = var_0.ShowMsgBox

			var_2_10002 = {}
			i18n = var_2_10003
			var_2_10002.content = var_2_10003("town_gold_tip")

			function var_2_10002.onYes()
				local var_26_0 = arg_24_0
				local var_26_1 = var_0.emit

				TownMediator = var_3_10002

				var_26_1(var_26_0, var_3_10002.CLICK_BUBBLE, arg_24_0.bubblesPosList)

				return
			end

			var_25_2(var_25_1, var_2_10002)
		else
			local var_25_3 = arg_24_0
			local var_25_4 = var_0.emit

			TownMediator = var_2_10002

			var_25_4(var_25_3, var_2_10002.CLICK_BUBBLE, arg_24_0.bubblesPosList)
		end

		return
	end

	SFX_PANEL = var_10

	var_24_6(var_24_7, var_24_8, var_24_9, var_10)

	SpineRole = var_24_6

	local var_24_10 = var_24_6.New()

	var_6.SetData(var_24_10, var_24_2:getPrefab())
	var_6:Load(function()
		local var_27_0 = var_0

		var_0.SetName(var_27_0, "model")

		local var_27_1 = var_0
		local var_27_2 = var_0.SetLocalScale

		Vector2 = var_2

		var_27_2(var_27_1, var_2.New(var_0_1.SDScale, var_0_1.SDScale))

		local var_27_3 = var_0
		local var_27_4 = var_0.SetSizeDelta

		Vector2 = var_2

		var_27_4(var_27_3, var_2.New(200, 500))

		local var_27_5 = var_0

		var_0.SetParent(var_27_5, var_24_3)

		local var_27_6 = var_0

		var_0.SetAction(var_27_6, "stand")

		go = var_0

		local var_27_7 = var_0.transform

		var_0.SetAsFirstSibling(var_27_7)

		setActive = var_0

		var_0(var_24_3, true)

		return
	end, true)

	arg_24_0.spineRoles[arg_24_1] = var_6

	return
end

function var_0_1.CleanSpines(arg_28_0)
	table = var_1_10001

	var_1_10001.Foreach(arg_28_0.spineRoles, function(arg_29_0, arg_29_1)
		arg_29_1:Dispose()

		return
	end)

	arg_28_0.spineRoles = {}

	return
end

function var_0_1.UpdateInfoPage(arg_30_0)
	local var_30_0 = arg_30_0.infoPage

	var_1.ExecuteAction(var_30_0, "SetActivity", arg_30_0.activity)

	local var_30_1 = arg_30_0.infoPage

	var_1.ExecuteAction(var_30_1, "Flush")

	return
end

function var_0_1.OnExpUpdate(arg_31_0)
	local var_31_0 = arg_31_0.infoPage

	var_1.ExecuteAction(var_31_0, "SetActivity", arg_31_0.activity)

	local var_31_1 = arg_31_0.infoPage

	var_1.ExecuteAction(var_31_1, "OnExpUpdate")

	return
end

function var_0_1.OnTownUpgrade(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.infoPage

	var_2.ExecuteAction(var_32_0, "OnTownUpgrade", arg_32_1)

	return
end

function var_0_1.OnPlaceUpgrade(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.infoPage

	var_2.ExecuteAction(var_33_0, "OnPlaceUpgrade", arg_33_1)

	return
end

function var_0_1.willExit(arg_34_0)
	local var_34_0 = arg_34_0.infoPage

	var_1.Destroy(var_34_0)

	arg_34_0.infoPage = nil

	if arg_34_0.timer then
		local var_34_1 = arg_34_0.timer

		var_1.Stop(var_34_1)

		arg_34_0.timer = nil
	end

	arg_34_0:CleanSpines()

	return
end

function var_0_1.ShowEntranceTip(arg_35_0)
	local var_35_1

	if not arg_35_0 then
		::label_35_0::

		getProxy = var_35_1
		ActivityProxy = var_1_10002

		local var_35_0 = var_35_1(var_1_10002)

		var_35_1 = var_35_1.getActivityByType
		ActivityConst = var_1_10003
		var_35_1 = var_35_1(var_35_0, var_1_10003.ACTIVITY_TYPE_TOWN)
	end

	if not var_35_1 or var_35_1:isEnd() then
		return false
	end

	local var_35_2

	if not var_0_1.ShowMainTip(var_35_1) then
		var_35_2 = var_35_1:ShowBubbleTip()
	end

	return var_35_2
end

function var_0_1.ShowMainTip(arg_36_0)
	local var_36_1

	if not arg_36_0 then
		::label_36_0::

		getProxy = var_36_1
		ActivityProxy = var_1_10002

		local var_36_0 = var_36_1(var_1_10002)

		var_36_1 = var_36_1.getActivityByType
		ActivityConst = var_1_10003
		var_36_1 = var_36_1(var_36_0, var_1_10003.ACTIVITY_TYPE_TOWN)
	end

	if not var_36_1 or var_36_1:isEnd() then
		return false
	end

	local var_36_2

	if not var_36_1:CanCostGold() then
		var_36_2 = var_36_1:HasEmptySlot()
	end

	return var_36_2
end

return var_0_1
