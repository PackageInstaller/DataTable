local var_0_0 = {}
local var_0_1, var_0_2 = pcall(require, "bit")

if not var_0_1 then
	local var_0_3

	var_0_3, var_0_2 = pcall(require, "bit32")
end

var_0_0.dirtyFlagIndex = {
	[RedPointStyle.NORMAL] = var_0_2.lshift(1, 1),
	[RedPointStyle.SHOW_NEW_TAG] = var_0_2.lshift(1, 2)
}
var_0_0.StyleCsharpMap = {
	[RedPointStyle.None] = UIRedPointStyle.None,
	[RedPointStyle.NORMAL] = UIRedPointStyle.Normal,
	[RedPointStyle.SHOW_NEW_TAG] = UIRedPointStyle.New
}
var_0_0.StyleKeyMap = {}

local function var_0_4(arg_1_0)
	return true
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0._groupTipDic = {}
	arg_2_0._parentTipDic = {}
	arg_2_0._isRedPointActive = arg_2_1 or var_0_4

	arg_2_0:InitData()
end

function var_0_0.InitData(arg_3_0)
	arg_3_0._tipDic = {}
	arg_3_0._UIKeyList = {}
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0._UIKeyList = {}
end

function var_0_0.GetKeyStyle(arg_5_0, arg_5_1)
	return arg_5_0.StyleKeyMap[arg_5_1] or RedPointStyle.NORMAL
end

function var_0_0.GetKeyStyleFlag(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetKeyStyle(arg_6_1)

	return arg_6_0.dirtyFlagIndex[var_6_0] or 0
end

function var_0_0.ShowRed(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.display

	if not arg_7_1.tProperty then
		local var_7_1 = {}
	end

	if var_7_0 == nil then
		print("redpoint cant find parent transform")

		return
	end

	local var_7_2 = arg_7_0:GetTipFlag(arg_7_2)

	if var_0_2.band(var_7_2, arg_7_0.dirtyFlagIndex[RedPointStyle.SHOW_NEW_TAG]) > 0 then
		arg_7_0:ChangeRedStyle(arg_7_1, RedPointStyle.SHOW_NEW_TAG, nil, arg_7_2)
	elseif var_0_2.band(var_7_2, arg_7_0.dirtyFlagIndex[RedPointStyle.NORMAL]) > 0 then
		arg_7_0:ChangeRedStyle(arg_7_1, RedPointStyle.NORMAL, nil, arg_7_2)
	else
		arg_7_0:ChangeRedStyle(arg_7_1, RedPointStyle.None, nil, arg_7_2)
	end
end

function var_0_0.PreShowRed(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_2 then
		return RedPointStyle.None
	end

	if arg_8_1.banNew and arg_8_2 == RedPointStyle.SHOW_NEW_TAG then
		return RedPointStyle.NORMAL
	end

	return arg_8_2
end

function var_0_0.ChangeRedStyle(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = arg_9_1.display
	local var_9_1 = arg_9_1.tProperty or {}

	if isNil(var_9_0) then
		Debug.LogError("直接操作红点时出错<transform为空>,尝试显示Key\n(请检查transform为空,或者未解绑红点): " .. (arg_9_4 or "nil"))

		return
	end

	local var_9_2 = var_9_0:Find("notice_img")
	local var_9_3

	if not var_9_2 then
		local var_9_4 = Asset.Load("Widget/System/Com_dynamic/notice_img")

		if var_9_4 == nil then
			print("redpoint cant find current CommonNotice prefab")

			return
		end

		var_9_2 = Object.Instantiate(var_9_4, var_9_0)
		var_9_3 = var_9_2:GetComponent(typeof(UIRedPoint))
		var_9_2.name = "notice_img"
	else
		var_9_3 = var_9_2:GetComponent(typeof(UIRedPoint))
	end

	if var_9_3 then
		var_9_3:ShowRed(arg_9_0.StyleCsharpMap[arg_9_0:PreShowRed(var_9_1, arg_9_2)])
		var_9_3:SetDebugName(arg_9_4 or "NULL_KEY")

		local var_9_5 = var_9_1.x
		local var_9_6 = var_9_1.y
		local var_9_7 = var_9_1.scaleX
		local var_9_8 = var_9_1.scaleY

		if var_9_5 and var_9_6 then
			var_9_3:SetPosition(var_9_5, var_9_6)
		else
			if var_9_5 then
				var_9_3:SetPositionAxis(var_9_5, 1)
			end

			if var_9_6 then
				var_9_3:SetPositionAxis(var_9_6, 2)
			end
		end

		if var_9_7 and var_9_8 then
			var_9_3:SetScale(var_9_7, var_9_8)
		else
			if var_9_7 then
				var_9_3:SetScale(var_9_7, 1)
			end

			if var_9_8 then
				var_9_3:SetScale(var_9_8, 2)
			end
		end
	else
		Debug.LogError("是红点,但是没有绑定UIRePoint " .. var_9_0.name)

		if arg_9_5 then
			var_9_2.gameObject:SetActive(true)
		else
			var_9_2.gameObject:SetActive(false)
		end
	end
end

function var_0_0.SetKeyStyle(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.StyleKeyMap[arg_10_1] = arg_10_2 or RedPointStyle.NORMAL
end

function var_0_0.setTip(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1

	if arg_11_3 and arg_11_3 ~= RedPointStyle.None and arg_11_3 ~= RedPointStyle.NORMAL then
		var_11_0 = string.format("%s_REDSTYLE_DECORATOR_%s", arg_11_1, arg_11_3)

		arg_11_0:appendToGroup(arg_11_1, var_11_0, arg_11_3)
	end

	local var_11_1 = 0

	if arg_11_2 == (arg_11_0._tipDic[var_11_0] == nil and 0 or arg_11_0._tipDic[var_11_0]) then
		return
	end

	arg_11_0._tipDic[var_11_0] = arg_11_2

	arg_11_0:updateKey(var_11_0)
end

function var_0_0.getTipValue(arg_12_0, arg_12_1)
	if not arg_12_0._isRedPointActive(arg_12_1) then
		return 0
	end

	local var_12_0 = arg_12_0._tipDic[arg_12_1] or 0
	local var_12_1 = arg_12_0._groupTipDic[arg_12_1]

	if var_12_1 then
		for iter_12_0, iter_12_1 in pairs(var_12_1) do
			var_12_0 = var_12_0 + arg_12_0:getTipValue(iter_12_1)
		end
	end

	return var_12_0
end

function var_0_0.GetTipFlag(arg_13_0, arg_13_1)
	if not arg_13_0._isRedPointActive(arg_13_1) then
		return 0
	end

	local var_13_0 = arg_13_0._tipDic[arg_13_1] or 0
	local var_13_1 = 0

	if var_13_0 > 0 then
		var_13_1 = arg_13_0:GetKeyStyleFlag(arg_13_1)
	end

	local var_13_2 = arg_13_0._groupTipDic[arg_13_1]

	if var_13_2 then
		for iter_13_0, iter_13_1 in pairs(var_13_2) do
			var_13_1 = var_0_2.bor(var_13_1, arg_13_0:GetTipFlag(iter_13_1))
		end
	end

	return var_13_1
end

function var_0_0.getchildKeys(arg_14_0, arg_14_1)
	return arg_14_0._groupTipDic[arg_14_1]
end

function var_0_0.getTipBoolean(arg_15_0, arg_15_1)
	if not arg_15_0._isRedPointActive(arg_15_1) then
		return false
	end

	if arg_15_0._tipDic[arg_15_1] and arg_15_0._tipDic[arg_15_1] > 0 then
		return true
	end

	local var_15_0 = arg_15_0._groupTipDic[arg_15_1]

	if var_15_0 then
		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			if arg_15_0:getTipBoolean(iter_15_1) == true then
				return true
			end
		end
	end

	return false
end

function var_0_0.addGroup(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_3 == nil then
		arg_16_3 = false
	end

	if arg_16_0._groupTipDic[arg_16_1] == nil then
		arg_16_0._groupTipDic[arg_16_1] = arg_16_2

		for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
			arg_16_0._parentTipDic[iter_16_1] = arg_16_0._parentTipDic[iter_16_1] or {}

			table.insert(arg_16_0._parentTipDic[iter_16_1], arg_16_1)
		end
	else
		if arg_16_3 == true then
			if arg_16_2 then
				for iter_16_2, iter_16_3 in ipairs(arg_16_2) do
					arg_16_0._parentTipDic[iter_16_3] = arg_16_0._parentTipDic[iter_16_3] or {}

					if arg_16_0:IsInTable(arg_16_0._parentTipDic[iter_16_3], arg_16_1) == true then
						table.remove(arg_16_0._parentTipDic[iter_16_3], iter_16_2)
					end
				end
			end

			arg_16_0._groupTipDic[arg_16_1] = {}
		end

		local var_16_0 = arg_16_0._groupTipDic[arg_16_1]

		for iter_16_4, iter_16_5 in pairs(arg_16_2) do
			if arg_16_0:IsInTable(var_16_0, iter_16_5) == false then
				table.insert(var_16_0, iter_16_5)
			end
		end

		for iter_16_6, iter_16_7 in ipairs(arg_16_2) do
			arg_16_0._parentTipDic[iter_16_7] = arg_16_0._parentTipDic[iter_16_7] or {}

			if arg_16_0:IsInTable(arg_16_0._parentTipDic[iter_16_7], arg_16_1) == false then
				table.insert(arg_16_0._parentTipDic[iter_16_7], arg_16_1)
			end
		end
	end

	arg_16_0:updateRedPoint(arg_16_1)
end

function var_0_0.appendToGroup(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0._groupTipDic[arg_17_1] or {}

	arg_17_0._groupTipDic[arg_17_1] = var_17_0

	if not arg_17_0:IsInTable(var_17_0, arg_17_2) then
		table.insert(var_17_0, arg_17_2)

		arg_17_0._parentTipDic[arg_17_2] = arg_17_0._parentTipDic[arg_17_2] or {}

		table.insert(arg_17_0._parentTipDic[arg_17_2], arg_17_1)

		if arg_17_3 then
			arg_17_0:SetKeyStyle(arg_17_2, arg_17_3)
		end
	end
end

function var_0_0.delGroup(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._groupTipDic[arg_18_1] == nil then
		return
	end

	local var_18_0 = arg_18_0._groupTipDic[arg_18_1]

	for iter_18_0, iter_18_1 in pairs(arg_18_2) do
		if arg_18_0:IsInTable(var_18_0, iter_18_1) then
			table.removebyvalue(var_18_0, iter_18_1)
		end
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_2) do
		arg_18_0._parentTipDic[iter_18_3] = arg_18_0._parentTipDic[iter_18_3] or {}

		if arg_18_0:IsInTable(arg_18_0._parentTipDic[iter_18_3], arg_18_1) then
			table.removebyvalue(arg_18_0._parentTipDic[iter_18_3], iter_18_3)
		end
	end

	arg_18_0:updateRedPoint(arg_18_1)
end

function var_0_0.updateKey(arg_19_0, arg_19_1)
	arg_19_0:updateRedPoint(arg_19_1)

	local var_19_0 = arg_19_0._parentTipDic[arg_19_1] or {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		arg_19_0:updateKey(iter_19_1)
	end

	manager.notify:Invoke(RED_POINT_UPDATE, arg_19_1)
end

function var_0_0.updateRedPoint(arg_20_0, arg_20_1)
	if arg_20_0._UIKeyList[arg_20_1] ~= nil then
		local var_20_0 = arg_20_0._UIKeyList[arg_20_1]

		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			arg_20_0:ShowRed(iter_20_1, arg_20_1)
		end
	end
end

function var_0_0.bindUIandKey(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_1 == nil then
		Debug.LogError("红点绑定Key时出错<transform为空>: " .. arg_21_2)

		return
	end

	arg_21_0:unbindUIandKey(arg_21_1)

	local var_21_0 = {}

	if arg_21_0._UIKeyList[arg_21_2] == nil then
		table.insert(var_21_0, {
			display = arg_21_1,
			tProperty = arg_21_3
		})

		arg_21_0._UIKeyList[arg_21_2] = var_21_0
	else
		local var_21_1 = arg_21_0._UIKeyList[arg_21_2]

		table.insert(var_21_1, {
			display = arg_21_1,
			tProperty = arg_21_3
		})
	end

	arg_21_0:updateRedPoint(arg_21_2)
end

function var_0_0.unbindUIandKey(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 == nil then
		return
	end

	if arg_22_2 then
		local var_22_0 = -1
		local var_22_1 = arg_22_0._UIKeyList[arg_22_2]

		if var_22_1 then
			for iter_22_0, iter_22_1 in pairs(var_22_1) do
				if iter_22_1.display == arg_22_1 then
					var_22_0 = iter_22_0

					break
				end
			end

			if var_22_0 ~= -1 then
				arg_22_0:ShowRed(var_22_1[var_22_0], arg_22_2)
				table.remove(var_22_1, var_22_0)
			end
		else
			print("unbindUIandKey key is not exist! key = " .. arg_22_2)
		end
	else
		for iter_22_2, iter_22_3 in pairs(arg_22_0._UIKeyList) do
			local var_22_2 = -1

			for iter_22_4, iter_22_5 in pairs(iter_22_3) do
				if iter_22_5.display == arg_22_1 then
					var_22_2 = iter_22_4

					break
				end
			end

			if var_22_2 ~= -1 then
				arg_22_0:ShowRed(iter_22_3[var_22_2], arg_22_2)
				table.remove(iter_22_3, var_22_2)

				break
			end
		end
	end
end

function var_0_0.IsInTable(arg_23_0, arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if iter_23_1 == arg_23_2 then
			return true, iter_23_0
		end
	end

	return false
end

function var_0_0.GetRedGraphWithKey(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return
	end

	local var_24_0 = {}

	arg_24_0:FindRedRoot(arg_24_1, var_24_0)

	local var_24_1 = var_24_0[1] or arg_24_1
	local var_24_2 = {}
	local var_24_3 = {}
	local var_24_4 = {}

	arg_24_0:GetKeyGraph(var_24_1, {
		keysList = var_24_2,
		keysVis = var_24_4
	})

	local var_24_5 = #var_24_2

	for iter_24_0 = 1, var_24_5 do
		table.insert(var_24_3, {})
	end

	for iter_24_1, iter_24_2 in ipairs(var_24_2) do
		local var_24_6 = arg_24_0._groupTipDic[iter_24_2.key]

		if var_24_6 then
			for iter_24_3, iter_24_4 in pairs(var_24_6) do
				table.insert(var_24_3[var_24_4[iter_24_2.key]], var_24_4[iter_24_4] - 1)
			end
		end
	end

	Debug.LogError("keysGraph如下: " .. table.toString(var_24_3))
	Debug.LogError("所有的Keys: " .. table.toString(var_24_2))

	return {
		rootIdx = 0,
		status = true,
		edges = var_24_3,
		nodes = var_24_2,
		selectNode = var_24_4[arg_24_1] - 1
	}
end

function var_0_0.FindRedRoot(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1
	local var_25_1 = arg_25_0._parentTipDic[arg_25_1]

	if not var_25_1 or #var_25_1 == 0 then
		arg_25_2[arg_25_1] = true
	else
		for iter_25_0, iter_25_1 in ipairs(arg_25_0._parentTipDic[arg_25_1]) do
			arg_25_0:FindRedRoot(iter_25_1, arg_25_2)
		end
	end
end

function var_0_0.GetKeyGraph(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_2.keysVis[arg_26_1] then
		table.insert(arg_26_2.keysList, {
			key = tostring(arg_26_1),
			value = arg_26_0:getTipValue(arg_26_1)
		})

		arg_26_2.keysVis[arg_26_1] = #arg_26_2.keysList

		local var_26_0 = arg_26_0._groupTipDic[arg_26_1]

		if var_26_0 then
			for iter_26_0, iter_26_1 in pairs(var_26_0) do
				arg_26_0:GetKeyGraph(iter_26_1, arg_26_2)
			end
		end
	end
end

function var_0_0.GetAllKey(arg_27_0)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(arg_27_0._groupTipDic) do
		table.insert(var_27_0, iter_27_0)
	end

	return var_27_0
end

return var_0_0
