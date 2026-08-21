local var_0_0 = class("NavTacticsDockyardScene", import("view.ship.DockyardScene"))
local var_0_1 = 7

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)

	arg_1_0.toggleTr = arg_1_0._tf:Find("blur_panel/adapt/left_length/frame/toggle_nav")
	arg_1_0.toggleOnTr = arg_1_0.toggleTr:Find("on")
	arg_1_0.toggleOffTr = arg_1_0.toggleTr:Find("off")

	setActive(arg_1_0.toggleTr, true)

	return
end

function var_0_0.didEnter(arg_2_0)
	var_0_0.super.didEnter(arg_2_0)

	local function var_2_0()
		setActive(arg_2_0.toggleOnTr, arg_2_0.isShowRecent)
		setActive(arg_2_0.toggleOffTr, not arg_2_0.isShowRecent)

		return
	end

	arg_2_0.isShowRecent = false

	onButton(arg_2_0, arg_2_0.toggleTr, function()
		local var_4_0 = arg_2_0:CollectionRecentShips()

		if #var_4_0 <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_recent_ships"))

			return
		end

		arg_2_0.isShowRecent = not arg_2_0.isShowRecent
		var_0_0.ToggleOn = arg_2_0.isShowRecent

		var_2_0()
		arg_2_0:OnRecentShips(var_4_0)

		return
	end, SFX_PANEL)

	local var_2_1 = var_0_0.ToggleOn

	if var_0_0.ToggleOn and #arg_2_0:CollectionRecentShips() == 0 then
		var_2_1 = false
	end

	if var_2_1 then
		triggerButton(arg_2_0.toggleTr)
	else
		local var_2_2 = arg_2_0:CollectionRecentShips()

		;(function()
			setActive(arg_2_0.toggleOnTr, arg_2_0.isShowRecent)
			setActive(arg_2_0.toggleOffTr, not arg_2_0.isShowRecent)

			return
		end)()
		arg_2_0:OnRecentShips(var_2_2)
	end

	return
end

function var_0_0.GetCard(arg_5_0, arg_5_1)
	return NavTacticsDockyardShipItem.New(arg_5_1, arg_5_0.contextData.hideTagFlags, arg_5_0.contextData.blockTagFlags)
end

function var_0_0.OnClickCard(arg_6_0, arg_6_1)
	if arg_6_1.shipVO then
		var_0_0.super.OnClickCard(arg_6_0, arg_6_1)
	end

	return
end

function var_0_0.onUpdateItem(arg_7_0, arg_7_1, arg_7_2)
	var_0_0.super.onUpdateItem(arg_7_0, arg_7_1, arg_7_2)

	if arg_7_0.isShowRecent and arg_7_1 + 1 <= var_0_1 then
		setActive(arg_7_0.scrollItems[arg_7_2].recentTr, arg_7_0.shipVOs[arg_7_1 + 1])
	end

	return
end

function var_0_0.OnRecentShips(arg_8_0, arg_8_1)
	arg_8_0.recentShips = arg_8_1

	if #arg_8_0.recentShips > 0 then
		arg_8_0:filter()
	end

	return
end

function var_0_0.updateShipCount(arg_9_0, arg_9_1)
	if arg_9_0.isShowRecent and #arg_9_0.recentShips > 0 then
		for iter_9_0 = #arg_9_0.recentShips + 1, var_0_1 do
			table.insert(arg_9_0.shipVOs, 1, false)
		end

		for iter_9_1 = #arg_9_0.recentShips, 1, -1 do
			table.insert(arg_9_0.shipVOs, 1, arg_9_0.recentShips[iter_9_1])
		end

		var_0_0.super.updateShipCount(arg_9_0, arg_9_1)
	else
		var_0_0.super.updateShipCount(arg_9_0, arg_9_1)
	end

	return
end

function var_0_0.CollectionRecentShips(arg_10_0)
	local var_10_0 = getProxy(NavalAcademyProxy):GetRecentShips()

	for iter_10_0 = #var_10_0, 1, -1 do
		if #{} == var_0_1 then
			break
		end

		local var_10_1 = tonumber(var_10_0[iter_10_0])

		if var_10_1 > 0 and arg_10_0.shipVOsById[var_10_1] then
			table.insert({}, arg_10_0.shipVOsById[var_10_1])
		end
	end

	return {}
end

function var_0_0.willExit(arg_11_0)
	var_0_0.super.willExit(arg_11_0)
	setActive(arg_11_0.toggleTr, false)

	return
end

return var_0_0
