local var_0_0 = class("IslandMainBtnContainer")

var_0_0.SPECIAL_BTN = {
	season = "IslandMainSeasonBtn",
	technology = "IslandMainTechnologyBtn"
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0.event = arg_1_2
	arg_1_0.tpl = arg_1_0._tf:Find("tpl")

	setActive(arg_1_0.tpl, false)
	arg_1_0:InitBtns()

	return
end

function var_0_0.InitBtns(arg_2_0)
	arg_2_0.btns = {}
	arg_2_0.unlockIds = {}

	table.sort(pg.island_main_btns.get_id_list_by_main_type[1], CompareFuncs({
		function(arg_3_0)
			return pg.island_main_btns[arg_3_0].order
		end,
		function(arg_4_0)
			return arg_4_0
		end
	}))

	for iter_2_0, iter_2_1 in ipairs(pg.island_main_btns.get_id_list_by_main_type[1]) do
		table.insert(arg_2_0.unlockIds, pg.island_main_btns[iter_2_1].ability_id)

		local var_2_0 = pg.island_main_btns[iter_2_1].btn_name

		arg_2_0.btns[var_2_0] = var_0_0.SPECIAL_BTN[pg.island_main_btns[iter_2_1].btn_name] and _G[var_0_0.SPECIAL_BTN[var_2_0]].New(arg_2_0._tf:Find(var_2_0), arg_2_0.event, iter_2_1) or IslandMainBaseBtn.New(cloneTplTo(arg_2_0.tpl, arg_2_0._tf), arg_2_0.event, iter_2_1)

		arg_2_0.btns[var_2_0]:SetAsLastSibling()
	end

	arg_2_0:Flush()

	return
end

function var_0_0.OnTaskUpdate(arg_5_0)
	arg_5_0.btns.season:TipCheck()

	return
end

function var_0_0.OnUnlockSystem(arg_6_0, arg_6_1)
	if table.contains(arg_6_0.unlockIds, arg_6_1) then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.btns) do
			iter_6_1:UnlockCheck()
		end
	end

	return
end

function var_0_0.OnTrackTaskChange(arg_7_0)
	if arg_7_0.btns.map and arg_7_0.btns.map:IsUnlock() then
		arg_7_0.btns.map:TipCheck()
	end

	return
end

function var_0_0.OnFinishDelegation(arg_8_0)
	if arg_8_0.btns.technology and arg_8_0.btns.technology:IsUnlock() then
		arg_8_0.btns.technology:TipCheck()
		arg_8_0.btns.technology:StatusCheck()
	end

	return
end

function var_0_0.OnUnlockTechnology(arg_9_0)
	if arg_9_0.btns.technology and arg_9_0.btns.technology:IsUnlock() then
		arg_9_0.btns.technology:StatusCheck()
	end

	return
end

function var_0_0.Flush(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.btns) do
		iter_10_1:Flush()
	end

	return
end

function var_0_0.ActiveOrDisactive(arg_11_0, arg_11_1)
	setActive(arg_11_0._tf, arg_11_1)

	return
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.btns) do
		iter_12_1:Dispose()
	end

	arg_12_0.btns = nil

	return
end

return var_0_0
