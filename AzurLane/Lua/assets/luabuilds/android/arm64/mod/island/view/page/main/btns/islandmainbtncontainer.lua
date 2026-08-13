class = var_0_10000

local var_0_0 = var_0_10000("IslandMainBtnContainer")

var_0_0.SPECIAL_BTN = {
	season = "IslandMainSeasonBtn",
	technology = "IslandMainTechnologyBtn"
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0.event = arg_1_2

	local var_1_0 = arg_1_0._tf

	arg_1_0.tpl = var_3.Find(var_1_0, "tpl")
	setActive = var_3

	var_3(arg_1_0.tpl, false)
	arg_1_0:InitBtns()

	return
end

function var_0_0.InitBtns(arg_2_0)
	arg_2_0.btns = {}
	arg_2_0.unlockIds = {}
	pg = var_1

	local var_2_0 = var_1.island_main_btns.get_id_list_by_main_type[1]

	table = var_1_10002

	local var_2_1 = var_1_10002.sort
	local var_2_2 = var_2_0

	CompareFuncs = var_1_10005

	var_2_1(var_2_2, var_1_10005({
		function(arg_3_0)
			pg = var_2_10001

			return var_2_10001.island_main_btns[arg_3_0].order
		end,
		function(arg_4_0)
			return arg_4_0
		end
	}))

	ipairs = var_2_1

	for iter_2_0, iter_2_1 in var_2_1(var_2_0) do
		pg = var_2_3

		local var_2_3 = var_2_3.island_main_btns[iter_2_1]

		table = var_2_4

		var_2_4.insert(arg_2_0.unlockIds, var_2_3.ability_id)

		local var_2_4 = var_2_3.btn_name
		local var_2_6

		if var_0_0.SPECIAL_BTN[var_2_4] then
			local var_2_5 = var_0_0.SPECIAL_BTN[var_2_4]

			var_2_6 = arg_2_0.btns
			_G = var_11

			local var_2_7 = var_11[var_2_5].New
			local var_2_8 = arg_2_0._tf

			var_2_6[var_2_4] = var_2_7(var_13.Find(var_2_8, var_2_4), arg_2_0.event, iter_2_1)
		else
			local var_2_9 = arg_2_0.btns

			IslandMainBaseBtn = var_2_6

			local var_2_10 = var_2_6.New

			cloneTplTo = var_1_10012
			var_2_9[var_2_4] = var_2_10(var_1_10012(arg_2_0.tpl, arg_2_0._tf), arg_2_0.event, iter_2_1)
		end

		local var_2_11 = arg_2_0.btns[var_2_4]

		var_9.SetAsLastSibling(var_2_11)
	end

	arg_2_0:Flush()

	return
end

function var_0_0.OnTaskUpdate(arg_5_0)
	local var_5_0 = arg_5_0.btns.season

	var_1.TipCheck(var_5_0)

	return
end

function var_0_0.OnUnlockSystem(arg_6_0, arg_6_1)
	table = var_1_10002

	if var_1_10002.contains(arg_6_0.unlockIds, arg_6_1) then
		pairs = var_2

		for iter_6_0, iter_6_1 in var_2(arg_6_0.btns) do
			iter_6_1:UnlockCheck()
		end
	end

	return
end

function var_0_0.OnTrackTaskChange(arg_7_0)
	if arg_7_0.btns.map and var_1:IsUnlock() then
		var_1:TipCheck()
	end

	return
end

function var_0_0.OnFinishDelegation(arg_8_0)
	if arg_8_0.btns.technology and var_1:IsUnlock() then
		var_1:TipCheck()
		var_1:StatusCheck()
	end

	return
end

function var_0_0.OnUnlockTechnology(arg_9_0)
	if arg_9_0.btns.technology and var_1:IsUnlock() then
		var_1:StatusCheck()
	end

	return
end

function var_0_0.Flush(arg_10_0)
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.btns) do
		iter_10_1:Flush()
	end

	return
end

function var_0_0.ActiveOrDisactive(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0._tf, arg_11_1)

	return
end

function var_0_0.Dispose(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.btns) do
		iter_12_1:Dispose()
	end

	arg_12_0.btns = nil

	return
end

return var_0_0
