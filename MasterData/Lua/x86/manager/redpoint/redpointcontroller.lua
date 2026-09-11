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

function var_0_0:Init(arg_2_1)
	self._groupTipDic = {}
	self._parentTipDic = {}
	self._isRedPointActive = arg_2_1 or var_0_4

	self:InitData()
end

function var_0_0.InitData(arg_3_0)
	arg_3_0._tipDic = {}
	arg_3_0._UIKeyList = {}
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0._UIKeyList = {}
end

function var_0_0:GetKeyStyle(arg_5_1)
	return self.StyleKeyMap[arg_5_1] or RedPointStyle.NORMAL
end

function var_0_0:GetKeyStyleFlag(arg_6_1)
	return self.dirtyFlagIndex[self:GetKeyStyle(arg_6_1)] or 0
end

function var_0_0:ShowRed(arg_7_1, arg_7_2)
	if not arg_7_1.tProperty then
		-- block empty
	end

	if arg_7_1.display == nil then
		print("redpoint cant find parent transform")

		return
	end

	local var_7_1 = self:GetTipFlag(arg_7_2)

	if var_0_2.band(var_7_1, self.dirtyFlagIndex[RedPointStyle.SHOW_NEW_TAG]) > 0 then
		self:ChangeRedStyle(arg_7_1, RedPointStyle.SHOW_NEW_TAG, nil, arg_7_2)
	elseif var_0_2.band(var_7_1, self.dirtyFlagIndex[RedPointStyle.NORMAL]) > 0 then
		self:ChangeRedStyle(arg_7_1, RedPointStyle.NORMAL, nil, arg_7_2)
	else
		self:ChangeRedStyle(arg_7_1, RedPointStyle.None, nil, arg_7_2)
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

function var_0_0:ChangeRedStyle(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = arg_9_1.tProperty or {}

	if isNil(arg_9_1.display) then
		Debug.LogError("直接操作红点时出错<transform为空>,尝试显示Key\n(请检查transform为空,或者未解绑红点): " .. (arg_9_4 or "nil"))

		return
	end

	local var_9_1 = arg_9_1.display:Find("notice_img")
	local var_9_2

	if not var_9_1 then
		local var_9_3 = Asset.Load("Widget/System/Com_dynamic/notice_img")

		if var_9_3 == nil then
			print("redpoint cant find current CommonNotice prefab")

			return
		end

		var_9_1 = Object.Instantiate(var_9_3, arg_9_1.display)
		var_9_2 = var_9_1:GetComponent(typeof(UIRedPoint))
		var_9_1.name = "notice_img"
	else
		var_9_2 = var_9_1:GetComponent(typeof(UIRedPoint))
	end

	if var_9_2 then
		var_9_2:ShowRed(self.StyleCsharpMap[self:PreShowRed(var_9_0, arg_9_2)])
		var_9_2:SetDebugName(arg_9_4 or "NULL_KEY")

		local var_9_4 = var_9_0.scaleX
		local var_9_5 = var_9_0.scaleY

		if var_9_0.x and var_9_0.y then
			var_9_2:SetPosition(var_9_0.x, var_9_0.y)
		else
			if var_9_0.x then
				var_9_2:SetPositionAxis(var_9_0.x, 1)
			end

			if var_9_0.y then
				var_9_2:SetPositionAxis(var_9_0.y, 2)
			end
		end

		if var_9_4 and var_9_5 then
			var_9_2:SetScale(var_9_4, var_9_5)
		else
			if var_9_4 then
				var_9_2:SetScale(var_9_4, 1)
			end

			if var_9_5 then
				var_9_2:SetScale(var_9_5, 2)
			end
		end
	else
		Debug.LogError("是红点,但是没有绑定UIRePoint " .. arg_9_1.display.name)

		if arg_9_5 then
			var_9_1.gameObject:SetActive(true)
		else
			var_9_1.gameObject:SetActive(false)
		end
	end
end

function var_0_0:SetKeyStyle(arg_10_1, arg_10_2)
	self.StyleKeyMap[arg_10_1] = arg_10_2 or RedPointStyle.NORMAL
end

function var_0_0:setTip(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1

	if arg_11_3 and arg_11_3 ~= RedPointStyle.None and arg_11_3 ~= RedPointStyle.NORMAL then
		var_11_0 = string.format("%s_REDSTYLE_DECORATOR_%s", arg_11_1, arg_11_3)

		self:appendToGroup(arg_11_1, var_11_0, arg_11_3)
	end

	if arg_11_2 == (self._tipDic[var_11_0] == nil and 0 or self._tipDic[var_11_0]) then
		return
	end

	self._tipDic[var_11_0] = arg_11_2

	self:updateKey(var_11_0)
end

function var_0_0:getTipValue(arg_12_1)
	if not self._isRedPointActive(arg_12_1) then
		return 0
	end

	local var_12_0 = self._tipDic[arg_12_1] or 0

	if self._groupTipDic[arg_12_1] then
		for iter_12_0, iter_12_1 in pairs(self._groupTipDic[arg_12_1]) do
			var_12_0 = var_12_0 + self:getTipValue(iter_12_1)
		end
	end

	return var_12_0
end

function var_0_0:GetTipFlag(arg_13_1)
	if not self._isRedPointActive(arg_13_1) then
		return 0
	end

	local var_13_0 = 0

	if (self._tipDic[arg_13_1] or 0) > 0 then
		var_13_0 = self:GetKeyStyleFlag(arg_13_1)
	end

	if self._groupTipDic[arg_13_1] then
		for iter_13_0, iter_13_1 in pairs(self._groupTipDic[arg_13_1]) do
			var_13_0 = var_0_2.bor(var_13_0, self:GetTipFlag(iter_13_1))
		end
	end

	return var_13_0
end

function var_0_0:getchildKeys(arg_14_1)
	return self._groupTipDic[arg_14_1]
end

function var_0_0:getTipBoolean(arg_15_1)
	if not self._isRedPointActive(arg_15_1) then
		return false
	end

	if self._tipDic[arg_15_1] and self._tipDic[arg_15_1] > 0 then
		return true
	end

	if self._groupTipDic[arg_15_1] then
		for iter_15_0, iter_15_1 in pairs(self._groupTipDic[arg_15_1]) do
			if self:getTipBoolean(iter_15_1) == true then
				return true
			end
		end
	end

	return false
end

function var_0_0:addGroup(arg_16_1, arg_16_2, arg_16_3)
	if arg_16_3 == nil then
		arg_16_3 = false
	end

	if self._groupTipDic[arg_16_1] == nil then
		self._groupTipDic[arg_16_1] = arg_16_2

		for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
			self._parentTipDic[iter_16_1] = self._parentTipDic[iter_16_1] or {}

			table.insert(self._parentTipDic[iter_16_1], arg_16_1)
		end
	else
		if arg_16_3 == true then
			if arg_16_2 then
				for iter_16_2, iter_16_3 in ipairs(arg_16_2) do
					self._parentTipDic[iter_16_3] = self._parentTipDic[iter_16_3] or {}

					if self:IsInTable(self._parentTipDic[iter_16_3], arg_16_1) == true then
						table.remove(self._parentTipDic[iter_16_3], iter_16_2)
					end
				end
			end

			self._groupTipDic[arg_16_1] = {}
		end

		local var_16_0 = self._groupTipDic[arg_16_1]

		for iter_16_4, iter_16_5 in pairs(arg_16_2) do
			if self:IsInTable(var_16_0, iter_16_5) == false then
				table.insert(var_16_0, iter_16_5)
			end
		end

		for iter_16_6, iter_16_7 in ipairs(arg_16_2) do
			self._parentTipDic[iter_16_7] = self._parentTipDic[iter_16_7] or {}

			if self:IsInTable(self._parentTipDic[iter_16_7], arg_16_1) == false then
				table.insert(self._parentTipDic[iter_16_7], arg_16_1)
			end
		end
	end

	self:updateRedPoint(arg_16_1)
end

function var_0_0:appendToGroup(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = self._groupTipDic[arg_17_1] or {}

	self._groupTipDic[arg_17_1] = var_17_0

	if not self:IsInTable(var_17_0, arg_17_2) then
		table.insert(var_17_0, arg_17_2)

		self._parentTipDic[arg_17_2] = self._parentTipDic[arg_17_2] or {}

		table.insert(self._parentTipDic[arg_17_2], arg_17_1)

		if arg_17_3 then
			self:SetKeyStyle(arg_17_2, arg_17_3)
		end
	end
end

function var_0_0:delGroup(arg_18_1, arg_18_2)
	if self._groupTipDic[arg_18_1] == nil then
		return
	end

	local var_18_0 = self._groupTipDic[arg_18_1]

	for iter_18_0, iter_18_1 in pairs(arg_18_2) do
		if self:IsInTable(var_18_0, iter_18_1) then
			table.removebyvalue(var_18_0, iter_18_1)
		end
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_2) do
		self._parentTipDic[iter_18_3] = self._parentTipDic[iter_18_3] or {}

		if self:IsInTable(self._parentTipDic[iter_18_3], arg_18_1) then
			table.removebyvalue(self._parentTipDic[iter_18_3], iter_18_3)
		end
	end

	self:updateRedPoint(arg_18_1)
end

function var_0_0:updateKey(arg_19_1)
	self:updateRedPoint(arg_19_1)

	for iter_19_0, iter_19_1 in ipairs(self._parentTipDic[arg_19_1] or {}) do
		self:updateKey(iter_19_1)
	end

	manager.notify:Invoke(RED_POINT_UPDATE, arg_19_1)
end

function var_0_0:updateRedPoint(arg_20_1)
	if self._UIKeyList[arg_20_1] ~= nil then
		for iter_20_0, iter_20_1 in pairs(self._UIKeyList[arg_20_1]) do
			self:ShowRed(iter_20_1, arg_20_1)
		end
	end
end

function var_0_0:bindUIandKey(arg_21_1, arg_21_2, arg_21_3)
	if arg_21_1 == nil then
		Debug.LogError("红点绑定Key时出错<transform为空>: " .. arg_21_2)

		return
	end

	self:unbindUIandKey(arg_21_1)

	local var_21_0 = {}

	if self._UIKeyList[arg_21_2] == nil then
		table.insert(var_21_0, {
			display = arg_21_1,
			tProperty = arg_21_3
		})

		self._UIKeyList[arg_21_2] = var_21_0
	else
		table.insert(self._UIKeyList[arg_21_2], {
			display = arg_21_1,
			tProperty = arg_21_3
		})
	end

	self:updateRedPoint(arg_21_2)
end

function var_0_0:unbindUIandKey(arg_22_1, arg_22_2)
	if arg_22_1 == nil then
		return
	end

	if arg_22_2 then
		local var_22_0 = -1

		if self._UIKeyList[arg_22_2] then
			for iter_22_0, iter_22_1 in pairs(self._UIKeyList[arg_22_2]) do
				if iter_22_1.display == arg_22_1 then
					var_22_0 = iter_22_0

					break
				end
			end

			if var_22_0 ~= -1 then
				self:ShowRed(self._UIKeyList[arg_22_2][var_22_0], arg_22_2)
				table.remove(self._UIKeyList[arg_22_2], var_22_0)
			end
		else
			print("unbindUIandKey key is not exist! key = " .. arg_22_2)
		end
	else
		for iter_22_2, iter_22_3 in pairs(self._UIKeyList) do
			local var_22_1 = -1

			for iter_22_4, iter_22_5 in pairs(iter_22_3) do
				if iter_22_5.display == arg_22_1 then
					var_22_1 = iter_22_4

					break
				end
			end

			if var_22_1 ~= -1 then
				self:ShowRed(iter_22_3[var_22_1], arg_22_2)
				table.remove(iter_22_3, var_22_1)

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

function var_0_0:GetRedGraphWithKey(arg_24_1)
	if not arg_24_1 then
		return
	end

	local var_24_0 = {}

	self:FindRedRoot(arg_24_1, var_24_0)

	local var_24_1 = {}
	local var_24_2 = {}
	local var_24_3 = {}

	self:GetKeyGraph(var_24_0[1] or arg_24_1, {
		keysList = var_24_1,
		keysVis = var_24_3
	})

	for iter_24_0 = 1, #var_24_1 do
		table.insert(var_24_2, {})
	end

	for iter_24_1, iter_24_2 in ipairs(var_24_1) do
		if self._groupTipDic[iter_24_2.key] then
			for iter_24_3, iter_24_4 in pairs(self._groupTipDic[iter_24_2.key]) do
				table.insert(var_24_2[var_24_3[iter_24_2.key]], var_24_3[iter_24_4] - 1)
			end
		end
	end

	Debug.LogError("keysGraph如下: " .. table.toString(var_24_2))
	Debug.LogError("所有的Keys: " .. table.toString(var_24_1))

	return {
		rootIdx = 0,
		status = true,
		edges = var_24_2,
		nodes = var_24_1,
		selectNode = var_24_3[arg_24_1] - 1
	}
end

function var_0_0:FindRedRoot(arg_25_1, arg_25_2)
	if not self._parentTipDic[arg_25_1] or #self._parentTipDic[arg_25_1] == 0 then
		arg_25_2[arg_25_1] = true
	else
		for iter_25_0, iter_25_1 in ipairs(self._parentTipDic[arg_25_1]) do
			self:FindRedRoot(iter_25_1, arg_25_2)
		end
	end
end

function var_0_0:GetKeyGraph(arg_26_1, arg_26_2)
	if not arg_26_2.keysVis[arg_26_1] then
		table.insert(arg_26_2.keysList, {
			key = tostring(arg_26_1),
			value = self:getTipValue(arg_26_1)
		})

		arg_26_2.keysVis[arg_26_1] = #arg_26_2.keysList

		if self._groupTipDic[arg_26_1] then
			for iter_26_0, iter_26_1 in pairs(self._groupTipDic[arg_26_1]) do
				self:GetKeyGraph(iter_26_1, arg_26_2)
			end
		end
	end
end

function var_0_0:GetAllKey()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(self._groupTipDic) do
		table.insert(var_27_0, iter_27_0)
	end

	return var_27_0
end

return var_0_0
