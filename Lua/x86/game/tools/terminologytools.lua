local var_0_0 = {
	TerminologyDefaultHandler = function(arg_1_0)
		if #arg_1_0 <= 0 then
			return
		end

		JumpTools.OpenPageByJump("terminology", {
			terminologyIdList = arg_1_0
		})
	end
}

function var_0_0.AddTerminologyHandler(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_3 == nil then
		arg_2_3 = var_0_0.TerminologyDefaultHandler
	end

	RichTextTools.AddEventClickHandler(arg_2_0, arg_2_1, arg_2_2, "terminology", function(arg_3_0)
		arg_2_3(var_0_0.MergeIdList(arg_3_0))
	end)
end

function var_0_0.MergeIdList(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		for iter_4_2 in string.gmatch(iter_4_1, "%d+") do
			table.insert(var_4_0, tonumber(iter_4_2))
		end
	end

	return var_4_0
end

function var_0_0.GetCfgTitle(arg_5_0)
	return GetI18NText(arg_5_0.word)
end

function var_0_0.GetCfgDescription(arg_6_0)
	return GetI18NText(arg_6_0.desc)
end

return var_0_0
