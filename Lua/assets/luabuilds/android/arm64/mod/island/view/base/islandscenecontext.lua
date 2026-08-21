local var_0_0 = class("IslandSceneContext")

function var_0_0.Ctor(arg_1_0, arg_1_1, ...)
	arg_1_0.class = arg_1_1
	arg_1_0.args = packEx(...)
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
	arg_4_0.__delRecordWhenClose = true

	return arg_4_0.__delRecordWhenClose
end

function var_0_0.GetOpenPrevWhenClose(arg_5_0)
	arg_5_0.__openPrevWhenClose = true

	return arg_5_0.__openPrevWhenClose
end

function var_0_0.AddSubPage(arg_6_0, arg_6_1, arg_6_2, arg_6_3, ...)
	local var_6_0 = _.detect(arg_6_0.subpages, function(arg_7_0)
		return arg_6_1.__cname == arg_7_0.class.__cname
	end)

	if var_6_0 then
		var_6_0.__visible = true

		return
	end

	local var_6_1 = IslandSceneContext.New(arg_6_1, ...)

	var_6_1:SetSubPageParentName(arg_6_3)
	var_6_1:SetLevel(arg_6_2)
	table.insert(arg_6_0.subpages, var_6_1)

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
