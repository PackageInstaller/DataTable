class = var_0_10000

local var_0_0 = "PlayerVitaeDockyardScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.ship.DockyardScene"))

function var_0_1.SortShips(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)
	local var_1_1 = var_2.getRawData(var_1_0).characters
	local var_1_2 = {}
	local var_1_3 = #var_1_1 + 1

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_1_1) do
		var_1_2[iter_1_1] = var_1_3 - iter_1_0
	end

	table = var_6

	var_6.insert(arg_1_1, function(arg_2_0)
		local var_2_0

		if not var_1_2[arg_2_0.id] then
			var_2_0 = 0
		end

		return -var_2_0
	end)

	table = var_6

	local var_1_4 = var_6.sort
	local var_1_5 = arg_1_0.shipVOs

	CompareFuncs = var_8

	var_1_4(var_1_5, var_8(arg_1_1))

	return
end

function var_0_1.init(arg_3_0)
	var_0_1.super.init(arg_3_0)

	arg_3_0.selectedMarks = {}
	ipairs = var_1

	local var_3_0

	if not arg_3_0.contextData.selectedMarks then
		var_3_0 = {}
	end

	for iter_3_0, iter_3_1 in var_1(var_3_0) do
		ShipPhantom = var_1_10006

		local var_3_1

		var_1_10006, var_3_1 = var_1_10006.UnpackMark(iter_3_1)

		if var_3_1 == 0 then
			table = var_1_10008

			var_1_10008.insert(arg_3_0.selectedIds, var_1_10006)
		else
			table = var_1_10008

			var_1_10008.insert(arg_3_0.selectedMarks, iter_3_1)
		end
	end

	local var_3_2 = arg_3_0.contextData

	var_3_2.selectedMarks = nil
	setActive = var_3_2

	var_3_2(arg_3_0.togglePhantom, true)

	return
end

function var_0_1.OnClickPhantom(arg_4_0, arg_4_1)
	if arg_4_1.phantomId == 0 then
		arg_4_0:selectShip(arg_4_1)
	else
		arg_4_0:selectPhantom(arg_4_1)
	end

	return
end

function var_0_1.selectPhantom(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetShipPhantomMark()
	local var_5_1 = false
	local var_5_2

	ipairs = var_1_10005

	for iter_5_0, iter_5_1 in var_1_10005(arg_5_0.selectedMarks) do
		if iter_5_1 == var_5_0 then
			var_5_1 = true
			var_5_2 = iter_5_0

			break
		end
	end

	if var_5_1 or arg_5_0.selectedMax == 1 and arg_5_0:GetSelectCount() > 0 then
		defaultValue = var_5

		local var_5_3 = var_5(var_5_2, 1)

		getProxy = var_5
		BayProxy = var_6

		local var_5_4 = var_5(var_6)
		local var_5_5 = var_5.GetShipPhantom(var_5_4, arg_5_0.selectedMarks[var_5_3])
		local var_5_6, var_5_7 = arg_5_0.onCancelShip(var_5_5, function()
			if not arg_5_0.exited then
				return
			end

			local var_6_0 = arg_5_0

			var_0.selectPhantom(var_6_0, arg_5_1)

			return
		end, arg_5_0.selectedMarks)

		if not var_5_6 then
			if var_5_7 then
				pg = var_8
				iter_5_1 = var_8.TipsMgr.GetInstance()

				var_8.ShowTips(iter_5_1, var_5_7)
			end

			return
		end

		table = var_8

		var_8.remove(arg_5_0.selectedMarks, var_5_3)
	end

	if not var_5_1 then
		local var_5_8, var_5_9 = arg_5_0.checkShip(arg_5_1, function()
			if arg_5_0.exited then
				return
			end

			local var_7_0 = arg_5_0

			var_0.selectPhantom(var_7_0, arg_5_1)

			return
		end, arg_5_0.selectedMarks)

		if not var_5_8 then
			if var_5_9 then
				pg = var_7

				local var_5_10 = var_7.TipsMgr.GetInstance()

				var_7.ShowTips(var_5_10, var_5_9)
			end

			return
		end

		if arg_5_0.selectedMax == 0 or arg_5_0:GetSelectCount() < arg_5_0.selectedMax then
			table = var_7

			var_7.insert(arg_5_0.selectedMarks, var_5_0)
		else
			pg = var_7

			local var_5_11 = var_7.TipsMgr.GetInstance()
			local var_5_12 = var_7.ShowTips

			i18n = iter_5_1

			var_5_12(var_5_11, iter_5_1("ship_dockyardScene_error_choiseRoleLess", arg_5_0.selectedMax))

			return
		end
	end

	arg_5_0:updateSelected()

	if arg_5_0.contextData.mode == var_0_1.MODE_DESTROY then
		arg_5_0:updateDestroyRes()
	elseif arg_5_0.contextData.mode == var_0_1.MODE_MOD then
		arg_5_0:updateModAttr()
	end

	arg_5_0:UpdateGuildViewEquipmentsBtn()

	return
end

function var_0_1.GetSelectCount(arg_8_0)
	return #arg_8_0.selectedIds + #arg_8_0.selectedMarks
end

function var_0_1.GetConfirmSelect(arg_9_0)
	local var_9_0 = {}

	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.selectedIds) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_9_1 = var_9_0

		ShipPhantom = var_1_10009

		var_1_10007(var_9_1, var_1_10009.PackMark(iter_9_1, 0))
	end

	table = var_2

	var_2.insertto(var_9_0, arg_9_0.selectedMarks)

	return var_9_0
end

return var_0_1
