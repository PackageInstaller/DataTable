class = var_0_10000

local var_0_0 = var_0_10000("IslandSceneContext")

function var_0_0.Ctor(arg_1_0, arg_1_1, ...)
	arg_1_0.class = arg_1_1
	packEx = var_1_10002
	arg_1_0.args = var_1_10002(...)
	arg_1_0.subpages = {}
	arg_1_0.__visible = true
	arg_1_0.__openPrevWhenClose = true
	arg_1_0.__delRecordWhenClose = true
	arg_1_0.level = -1

	return
end

function var_0_0.DisabelOpenPrevWhenClose(arg_2_0)
	arg_2_0.__openPrevWhenClose = false

	return
end

function var_0_0.DisabelDelRecordWhenClose(arg_3_0)
	arg_3_0.__delRecordWhenClose = false

	return
end

function var_0_0.GetDelRecordWhenClose(arg_4_0)
	local var_4_0 = arg_4_0.__delRecordWhenClose

	arg_4_0.__delRecordWhenClose = true

	return var_4_0
end

function var_0_0.GetOpenPrevWhenClose(arg_5_0)
	local var_5_0 = arg_5_0.__openPrevWhenClose

	arg_5_0.__openPrevWhenClose = true

	return var_5_0
end

function var_0_0.AddSubPage(arg_6_0, arg_6_1, arg_6_2, arg_6_3, ...)
	_ = var_1_10004

	if var_1_10004.detect(arg_6_0.subpages, function(arg_7_0)
		return arg_6_1.__cname == arg_7_0.class.__cname
	end) then
		var_4.__visible = true

		return
	end

	IslandSceneContext = var_5

	local var_6_0 = var_5.New(arg_6_1, ...)

	var_5.SetSubPageParentName(var_6_0, arg_6_3)
	var_5:SetLevel(arg_6_2)

	table = var_6

	var_6.insert(arg_6_0.subpages, var_5)

	return
end

function var_0_0.SetSubPageParentName(arg_8_0, arg_8_1)
	arg_8_0.parentName = arg_8_1

	return
end

function var_0_0.GetSubPageParentName(arg_9_0)
	return arg_9_0.parentName
end

function var_0_0.SetLevel(arg_10_0, arg_10_1)
	arg_10_0.level = arg_10_1

	return
end

function var_0_0.GetLevel(arg_11_0)
	return arg_11_0.level
end

function var_0_0.GetSubPages(arg_12_0)
	return arg_12_0.subpages
end

function var_0_0.GetData(arg_13_0)
	return arg_13_0.args
end

return var_0_0
