local GuideUIFinder = class("GuideUIFinder")

function GuideUIFinder:Ctor(arg_1_1)
	self.queue = {}

	return
end

function GuideUIFinder:Search(arg_2_1)
	table.insert(self.queue, arg_2_1)

	if #self.queue == 1 then
		self:Start()
	end

	return
end

function GuideUIFinder:Start()
	if #self.queue <= 0 then
		return
	end

	local var_3_0 = self.queue[1]

	self:Clear()

	local function var_3_1()
		table.remove(self.queue, 1)
		self:Start()

		return
	end

	if (var_3_0.delay or 0) > 0 then
		self.delayTimer = Timer.New(function()
			self:AddSearchTimer(var_3_0, var_3_1)

			return
		end, var_3_0.delay)

		self.delayTimer:Start()
	else
		self:AddSearchTimer(var_3_0, var_3_1)
	end

	return
end

local function var_0_1(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0 = 0, arg_6_0.childCount - 1 do
		local var_6_1 = arg_6_0:GetChild(iter_6_0)
		local var_6_2 = var_6_1:GetComponent(typeof(LayoutElement))

		if not IsNil(var_6_1) and go(var_6_1).activeInHierarchy and (not var_6_2 or not var_6_2.ignoreLayout) then
			table.insert(var_6_0, var_6_1)
		end
	end

	return (arg_6_1 or nil) and (var_6_0[arg_6_1 + 1] or var_6_0[#var_6_0])
end

local function var_0_2(arg_7_0)
	local var_7_0 = arg_7_0.path

	if string.match(arg_7_0.path, "/CombatUI%(Clone%)/") then
		var_7_0 = string.gsub(var_7_0, "CombatUI%(Clone%)", "CombatUI" .. ys.Battle.BattleState.GetCombatSkinKey() .. "(Clone)")
	end

	local var_7_2 = GameObject.Find(var_7_0)

	if var_7_2 and arg_7_0.childIndex and arg_7_0.childIndex == "#" then
		return var_0_1(var_7_2.transform)
	elseif var_7_2 and arg_7_0.childIndex and arg_7_0.childIndex == 25 then
		return var_0_1(var_7_2.transform, 0)
	elseif var_7_2 and arg_7_0.childIndex and arg_7_0.childIndex >= 0 then
		return var_0_1(var_7_2.transform, arg_7_0.childIndex)
	elseif var_7_2 then
		return var_7_2.transform
	end

	return nil
end

local function var_0_3(arg_8_0)
	local var_8_0 = var_0_2(arg_8_0)

	if var_8_0 ~= nil then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.conditionData) do
			local var_8_1 = var_8_0:Find(iter_8_1)

			if var_8_1 then
				return var_8_1
			end
		end
	end

	return nil
end

local function var_0_4(arg_9_0)
	local var_9_0 = arg_9_0.conditionData and var_0_3(arg_9_0) or var_0_2(arg_9_0)

	if var_9_0 then
		return var_9_0
	end

	return nil
end

function GuideUIFinder:AddSearchTimer(arg_10_1, arg_10_2)
	local var_10_0 = 20

	self.timer = Timer.New(function()
		var_10_0 = var_10_0 - 1

		if var_10_0 <= 0 then
			self:Clear()
			arg_10_2()
			print("should exist ui node : " .. arg_10_1.path)
			arg_10_1.callback(nil)

			return
		end

		local var_11_0 = var_0_4(arg_10_1)

		if var_11_0 then
			self:Clear()
			arg_10_2()
			arg_10_1.callback(var_11_0)
		end

		return
	end, 0.5, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function GuideUIFinder:SearchWithoutDelay(arg_12_1)
	self:Clear()
	arg_12_1.callback((var_0_2(arg_12_1)))

	return
end

function GuideUIFinder:Clear()
	if self.delayTimer then
		self.delayTimer:Stop()

		self.delayTimer = nil
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

return GuideUIFinder
