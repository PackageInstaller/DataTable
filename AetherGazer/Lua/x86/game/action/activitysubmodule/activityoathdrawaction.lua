local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	ActivitySkinDrawData:Init()

	if var_0_1 then
		return
	end

	manager.net:Bind(68185, function(arg_2_0)
		ActivityOathDrawData:InitDrawData(arg_2_0)
	end)

	var_0_1 = true
end

function var_0_0.GetNowSkinKey(arg_3_0)
	return tostring(arg_3_0)
end

function var_0_0.InitRedPointKey(arg_4_0)
	if not arg_4_0 then
		return
	end

	local var_4_0 = RedPointConst.ACTIVITY_DRAW .. "_" .. arg_4_0

	manager.redPoint:addGroup(var_4_0, {
		RedPointConst.OATH_DRAW_NEW
	})

	if not getData("OathDrawNew", var_0_0.GetNowSkinKey(arg_4_0)) then
		manager.redPoint:setTip(RedPointConst.OATH_DRAW_NEW, 1, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.StartOneDraw(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		activity_id = arg_5_0,
		pool_id = arg_5_1,
		card_index = arg_5_2
	}
	local var_5_1 = ActivityOathDrawData:GetLastDrop(arg_5_0)

	manager.net:SendWithLoadingNew(68186, var_5_0, 68187, function(arg_6_0)
		var_0_0.OnFinisDraw(arg_6_0, var_5_0, var_5_1)
	end)
end

function var_0_0.OnClickStartDraw(arg_7_0, arg_7_1)
	ActivityOathDrawAction.StartOneDraw(arg_7_0, arg_7_1, 0)
end

function var_0_0.OnFinisDraw(arg_8_0, arg_8_1, arg_8_2)
	if isSuccess(arg_8_0.result) then
		local var_8_0 = {}
		local var_8_1 = arg_8_0.drop_list
		local var_8_2 = false

		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			table.insert(var_8_0, {
				openIndex = iter_8_1.card_index,
				dropID = iter_8_1.drop_id
			})

			if iter_8_1.drop_id == arg_8_2 then
				var_8_2 = true
			end
		end

		if not var_8_2 and arg_8_1.card_index > 0 then
			for iter_8_2, iter_8_3 in ipairs(var_8_1) do
				ActivityOathDrawData:RefreshData(arg_8_1.activity_id, iter_8_3.drop_id, iter_8_3.card_index)
			end
		end

		table.sort(var_8_0, function(arg_9_0, arg_9_1)
			return arg_9_0.openIndex < arg_9_1.openIndex
		end)
		manager.notify:Invoke(ACTIVITY_OATH_SKIN_DRAW_OPEN, var_8_0, var_8_2)
	else
		ShowTips(arg_8_0.result)
	end
end

return var_0_0
