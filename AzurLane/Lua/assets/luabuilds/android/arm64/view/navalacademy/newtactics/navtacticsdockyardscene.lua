class = var_0_10000

local var_0_0 = "NavTacticsDockyardScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.ship.DockyardScene"))
local var_0_2 = 7

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.toggleTr = var_1.Find(var_1_0, "blur_panel/adapt/left_length/frame/toggle_nav")

	local var_1_1 = arg_1_0.toggleTr

	arg_1_0.toggleOnTr = var_1.Find(var_1_1, "on")

	local var_1_2 = arg_1_0.toggleTr

	arg_1_0.toggleOffTr = var_1.Find(var_1_2, "off")
	setActive = var_1

	var_1(arg_1_0.toggleTr, true)

	return
end

function var_0_1.didEnter(arg_2_0)
	var_0_1.super.didEnter(arg_2_0)

	local function var_2_0()
		local var_3_0 = arg_2_0.isShowRecent

		setActive = var_2_10001

		var_2_10001(arg_2_0.toggleOnTr, var_3_0)

		setActive = var_2_10001

		var_2_10001(arg_2_0.toggleOffTr, not var_3_0)

		return
	end

	arg_2_0.isShowRecent = false
	onButton = var_2

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.toggleTr

	local function var_2_3()
		local var_4_0 = arg_2_0

		if #var_0.CollectionRecentShips(var_4_0) <= 0 then
			pg = var_1

			local var_4_1 = var_1.TipsMgr.GetInstance()
			local var_4_2 = var_1.ShowTips

			i18n = var_2_10004

			var_4_2(var_4_1, var_2_10004("tactics_no_recent_ships"))

			return
		end

		arg_2_0.isShowRecent = not arg_2_0.isShowRecent
		var_0_1.ToggleOn = arg_2_0.isShowRecent

		var_2_0()

		local var_4_3 = arg_2_0

		var_1.OnRecentShips(var_4_3, var_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_2_1, var_2_2, var_2_3, var_1_10007)

	local var_2_4

	if var_0_1.ToggleOn and #arg_2_0:CollectionRecentShips() == 0 then
		var_2_4 = false
	end

	if var_2_4 then
		triggerButton = var_3

		var_3(arg_2_0.toggleTr)
	else
		local var_2_5 = arg_2_0:CollectionRecentShips()

		var_2_0()
		arg_2_0:OnRecentShips(var_2_5)
	end

	return
end

function var_0_1.GetCard(arg_5_0, arg_5_1)
	NavTacticsDockyardShipItem = var_1_10002

	return var_1_10002.New(arg_5_1, arg_5_0.contextData.hideTagFlags, arg_5_0.contextData.blockTagFlags)
end

function var_0_1.OnClickCard(arg_6_0, arg_6_1)
	if arg_6_1.shipVO then
		var_0_1.super.OnClickCard(arg_6_0, arg_6_1)
	end

	return
end

function var_0_1.onUpdateItem(arg_7_0, arg_7_1, arg_7_2)
	var_0_1.super.onUpdateItem(arg_7_0, arg_7_1, arg_7_2)

	if arg_7_0.isShowRecent and arg_7_1 + 1 <= var_0_2 then
		local var_7_0 = arg_7_0.scrollItems[arg_7_2]

		setActive = var_4

		var_4(var_7_0.recentTr, arg_7_0.shipVOs[arg_7_1 + 1])
	end

	return
end

function var_0_1.OnRecentShips(arg_8_0, arg_8_1)
	arg_8_0.recentShips = arg_8_1

	if #arg_8_0.recentShips > 0 then
		arg_8_0:filter()
	end

	return
end

function var_0_1.updateShipCount(arg_9_0, arg_9_1)
	if arg_9_0.isShowRecent and #arg_9_0.recentShips > 0 then
		for iter_9_0 = #arg_9_0.recentShips + 1, var_0_2 do
			table = var_1_10006

			var_1_10006.insert(arg_9_0.shipVOs, 1, false)
		end

		for iter_9_1 = #arg_9_0.recentShips, 1, -1 do
			local var_9_0 = arg_9_0.recentShips[iter_9_1]

			table = var_1_10007

			var_1_10007.insert(arg_9_0.shipVOs, 1, var_9_0)
		end

		var_0_1.super.updateShipCount(arg_9_0, arg_9_1)
	else
		var_0_1.super.updateShipCount(arg_9_0, arg_9_1)
	end

	return
end

function var_0_1.CollectionRecentShips(arg_10_0)
	local var_10_0 = {}

	getProxy = var_1_10002
	NavalAcademyProxy = var_1_10004

	local var_10_1 = var_1_10002(var_1_10004)

	for iter_10_0 = #var_2.GetRecentShips(var_10_1), 1, -1 do
		if #var_10_0 == var_0_2 then
			break
		end

		tonumber = var_7

		if var_7(var_2[iter_10_0]) > 0 and arg_10_0.shipVOsById[var_7] then
			table = var_8

			var_8.insert(var_10_0, arg_10_0.shipVOsById[var_7])
		end
	end

	return var_10_0
end

function var_0_1.willExit(arg_11_0)
	var_0_1.super.willExit(arg_11_0)

	setActive = var_1

	var_1(arg_11_0.toggleTr, false)

	return
end

return var_0_1
