local var_0_0 = {
	AddEventUpdateListener = function(arg_1_0, arg_1_1)
		arg_1_0:AddEventListUpdateListener(function(arg_2_0, arg_2_1)
			arg_1_1(arg_2_0:ToTable(), arg_2_1:ToTable())
		end)
	end
}

function var_0_0.AddAllEventClickHandler(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}

	var_0_0.AddEventUpdateListener(arg_3_1, function(arg_4_0, arg_4_1)
		var_3_0.names = arg_4_0
		var_3_0.args = arg_4_1
	end)

	if arg_3_2 == nil then
		arg_3_2 = arg_3_0:GetOrAddComponent(arg_3_1.gameObject, typeof(Button))
		arg_3_2.transition = UnityEngine.UI.Selectable.Transition.None
	end

	arg_3_0:AddBtnListener(arg_3_2, nil, function()
		if var_3_0.names == nil or var_3_0.args == nil then
			return
		end

		arg_3_3(var_3_0.names, var_3_0.args)
	end)
end

function var_0_0.AddEventClickHandler(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	var_0_0.AddAllEventClickHandler(arg_6_0, arg_6_1, arg_6_2, function(arg_7_0, arg_7_1)
		arg_6_4(var_0_0.FilterEvent(arg_7_0, arg_7_1, arg_6_3))
	end)
end

function var_0_0.FilterEvent(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		if iter_8_1 == arg_8_2 then
			table.insert(var_8_0, arg_8_1[iter_8_0])
		end
	end

	return var_8_0
end

function var_0_0.SetMixedTextWithImage(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in string.gmatch(arg_9_1, "<icon%s+name=([%w_]+)%s+sprite_path=([^%s>]+)/") do
		local var_9_0 = AtlasManager.GetSpriteWithoutAtlas(iter_9_1)

		arg_9_0:AddSprite(iter_9_0, var_9_0)
	end

	return arg_9_0
end

return var_0_0
