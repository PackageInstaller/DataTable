local var_0_0 = class("PlayerVitaeDockyardScene", import("view.ship.DockyardScene"))

function var_0_0.SortShips(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(PlayerProxy):getRawData().characters
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		({})[iter_1_1] = #var_1_0 + 1 - iter_1_0
	end

	table.insert(arg_1_1, function(arg_2_0)
		local var_2_0 = var_1_1[arg_2_0.id] or 0

		return -var_2_0
	end)
	table.sort(arg_1_0.shipVOs, CompareFuncs(arg_1_1))

	return
end

function var_0_0.init(arg_3_0)
	var_0_0.super.init(arg_3_0)

	arg_3_0.selectedMarks = {}

	local var_3_0 = arg_3_0.contextData.selectedMarks or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1, var_3_2 = ShipPhantom.UnpackMark(iter_3_1)

		if var_3_2 == 0 then
			table.insert(arg_3_0.selectedIds, var_3_1)
		else
			table.insert(arg_3_0.selectedMarks, iter_3_1)
		end
	end

	arg_3_0.contextData.selectedMarks = nil

	setActive(arg_3_0.togglePhantom, true)

	return
end

function var_0_0.OnClickPhantom(arg_4_0, arg_4_1)
	if arg_4_1.phantomId == 0 then
		arg_4_0:selectShip(arg_4_1)
	else
		arg_4_0:selectPhantom(arg_4_1)
	end

	return
end

function var_0_0.selectPhantom(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetShipPhantomMark()
	local var_5_1 = false
	local var_5_2

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.selectedMarks) do
		if iter_5_1 == var_5_0 then
			var_5_1 = true
			var_5_2 = iter_5_0

			break
		end
	end

	if var_5_1 or arg_5_0.selectedMax == 1 and arg_5_0:GetSelectCount() > 0 then
		local var_5_3 = defaultValue(var_5_2, 1)
		local var_5_4, var_5_5 = arg_5_0.onCancelShip(getProxy(BayProxy):GetShipPhantom(arg_5_0.selectedMarks[var_5_3]), function()
			if not arg_5_0.exited then
				return
			end

			arg_5_0:selectPhantom(arg_5_1)

			return
		end, arg_5_0.selectedMarks)

		if not var_5_4 then
			if var_5_5 then
				pg.TipsMgr.GetInstance():ShowTips(var_5_5)
			end

			return
		end

		table.remove(arg_5_0.selectedMarks, var_5_3)
	end

	if not var_5_1 then
		local var_5_6, var_5_7 = arg_5_0.checkShip(arg_5_1, function()
			if arg_5_0.exited then
				return
			end

			arg_5_0:selectPhantom(arg_5_1)

			return
		end, arg_5_0.selectedMarks)

		if not var_5_6 then
			if var_5_7 then
				pg.TipsMgr.GetInstance():ShowTips(var_5_7)
			end

			return
		end

		if arg_5_0.selectedMax == 0 or arg_5_0:GetSelectCount() < arg_5_0.selectedMax then
			table.insert(arg_5_0.selectedMarks, var_5_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_dockyardScene_error_choiseRoleLess", arg_5_0.selectedMax))

			return
		end
	end

	arg_5_0:updateSelected()

	if arg_5_0.contextData.mode == var_0_0.MODE_DESTROY then
		arg_5_0:updateDestroyRes()
	elseif arg_5_0.contextData.mode == var_0_0.MODE_MOD then
		arg_5_0:updateModAttr()
	end

	arg_5_0:UpdateGuildViewEquipmentsBtn()

	return
end

function var_0_0.GetSelectCount(arg_8_0)
	return #arg_8_0.selectedIds + #arg_8_0.selectedMarks
end

function var_0_0.GetConfirmSelect(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.selectedIds) do
		table.insert({}, ShipPhantom.PackMark(iter_9_1, 0))
	end

	table.insertto({}, arg_9_0.selectedMarks)

	return {}
end

return var_0_0
