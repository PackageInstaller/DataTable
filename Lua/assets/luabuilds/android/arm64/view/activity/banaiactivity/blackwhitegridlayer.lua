local var_0_0 = class("BlackWhiteGridLayer", import("...base.BaseUI"))
local var_0_1 = "create cell"
local var_0_2 = "reach turn cnt"
local var_0_3 = "cell type changed"
local var_0_4 = "cell check changed"
local var_0_5 = "highest score updated"
local var_0_6 = "destroy cells"
local var_0_7 = "cell tip"
local var_0_8 = "map init done"
local var_0_9 = 1
local var_0_10 = -1
local var_0_11 = {
	Color.New(1, 1, 1, 1),
	[-1] = Color.New(0.37, 0.37, 0.37, 1)
}
local var_0_12 = Color.New(0.9725490196078431, 0.6509803921568628, 0.8509803921568627, 1)
local var_0_13 = 5
local var_0_14 = 3
local var_0_15 = 5
local var_0_16 = pg.activity_event_blackwhite
local var_0_17

local function var_0_18()
	local function var_1_0(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = math.min(arg_2_1 + arg_2_4 - 1, arg_2_2 - 1)

		for iter_2_0 = arg_2_0, math.min(arg_2_0 + arg_2_4 - 1, arg_2_3 - 1) do
			for iter_2_1 = arg_2_1, var_2_0 do
				table.insert({}, Vector2(iter_2_0, iter_2_1))
			end
		end

		return {}
	end

	local function var_1_1(arg_3_0, arg_3_1)
		assert(#arg_3_0 ~= 0 and arg_3_1 <= #arg_3_0)

		local var_3_0 = {}

		while 0 < arg_3_1 do
			local var_3_1 = math.random(1, #arg_3_0)
			local var_3_2

			if not table.contains(var_3_0, var_3_1) then
				table.insert(var_3_0, var_3_1)

				var_3_2 = 0 + 1
			end
		end

		local var_3_3 = {}

		for iter_3_0 = 1, #arg_3_0 do
			table.insert(var_3_3, {
				arg_3_0[iter_3_0].x,
				arg_3_0[iter_3_0].y,
				table.contains(var_3_0, iter_3_0) and -1 or 1
			})
		end

		return var_3_3
	end

	;({}).RandomMap = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = {}

		for iter_4_0 = 0, arg_4_2 - 1, arg_4_3 do
			for iter_4_1 = 0, arg_4_1 - 1, arg_4_3 do
				_.each(var_1_1(var_1_0(iter_4_0, iter_4_1, arg_4_1, arg_4_2, arg_4_3), arg_4_4), function(arg_5_0)
					table.insert(var_4_0, arg_5_0)

					return
				end)
			end
		end

		return {}
	end
	;({}).Dispose = function(arg_6_0)
		return
	end

	return {}
end

local function var_0_19(arg_7_0, arg_7_1)
	({}).Get = function(arg_9_0)
		local var_9_0 = #arg_9_0.stack == 0 and instantiate(arg_9_0._go) or table.remove(arg_9_0.stack, 1)

		setActive(var_9_0, true)

		return var_9_0
	end
	;({}).Return = function(arg_10_0, arg_10_1)
		setActive(arg_10_1, false)

		if #arg_10_0.stack >= arg_10_0.maxCnt then
			Object.Destroy(arg_10_1)
		else
			table.insert(arg_10_0.stack, arg_10_1)
			setParent(arg_10_1, arg_10_0._root)
		end

		return
	end
	;({}).Dispose = function(arg_11_0)
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.stack) do
			Destroy(iter_11_1)
		end

		return
	end

	;(function(arg_8_0)
		arg_8_0._go = arg_7_0
		arg_8_0._root = arg_7_1
		arg_8_0.maxCnt = 20
		arg_8_0.stack = {}

		return
	end)({})

	return {}
end

local function var_0_20(arg_12_0)
	({}).Get = function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0.pools[arg_14_1]

		if not arg_14_0.pools[arg_14_1] then
			var_14_0 = var_0_19(arg_14_0[arg_14_1], arg_14_0.root)
			arg_14_0.pools[arg_14_1] = var_14_0
		end

		return var_14_0:Get()
	end
	;({}).Return = function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0.pools[arg_15_1] then
			arg_15_0.pools[arg_15_1]:Return(arg_15_2)
		else
			Destroy(arg_15_2)
		end

		return
	end
	;({}).Dispose = function(arg_16_0)
		for iter_16_0, iter_16_1 in pairs(arg_16_0.pools) do
			iter_16_1:Dispose()
		end

		return
	end

	;(function(arg_13_0)
		arg_13_0.root = arg_12_0
		arg_13_0.white = arg_12_0:Find("white")
		arg_13_0.black = arg_12_0:Find("black")
		arg_13_0.pools = {}

		return
	end)({})

	return {}
end

local function var_0_21(arg_17_0)
	({}).AddListener = function(arg_19_0, arg_19_1, arg_19_2)
		arg_19_0.events[arg_19_1] = arg_19_0.events[arg_19_1] or {}

		table.insert(arg_19_0.events[arg_19_1], arg_19_2)

		return
	end
	;({}).RemoveListener = function(arg_20_0, arg_20_1, arg_20_2)
		for iter_20_0 = #arg_20_0.events[arg_20_1], 1, -1 do
			if arg_20_0.events[arg_20_1][iter_20_0] == arg_20_2 then
				table.remove(arg_20_0.events[arg_20_1], iter_20_0)
			end
		end

		return
	end
	;({}).Notify = function(arg_21_0, arg_21_1, arg_21_2)
		assert(arg_21_0.events[arg_21_1], arg_21_1)

		for iter_21_0, iter_21_1 in ipairs(arg_21_0.events[arg_21_1]) do
			iter_21_1(arg_21_0.sender, arg_21_2)
		end

		return
	end

	;(function(arg_18_0)
		arg_18_0.events = {}
		arg_18_0.sender = arg_17_0

		return
	end)({})

	return {}
end

local function var_0_22(arg_22_0)
	({}).Reset = function(arg_24_0)
		arg_24_0.x = arg_24_0.initData.x
		arg_24_0.y = arg_24_0.initData.y
		arg_24_0.color = arg_24_0.initData.color
		arg_24_0.check = arg_24_0.initData.check

		arg_24_0:Notify(var_0_3, {
			type = arg_24_0.color
		})

		return
	end
	;({}).GetType = function(arg_25_0)
		return arg_25_0.color
	end
	;({}).GetPosition = function(arg_26_0)
		return Vector2(arg_26_0.x, arg_26_0.y)
	end
	;({}).OnAnimDone = function(arg_27_0)
		if arg_27_0.animCb then
			arg_27_0.animCb()
		end

		return
	end
	;({}).SetAnimDoneCallback = function(arg_28_0, arg_28_1)
		arg_28_0.animCb = arg_28_1

		return
	end
	;({}).Reverse = function(arg_29_0)
		if var_0_9 == arg_29_0.color then
			arg_29_0.color = var_0_10
		elseif var_0_10 == arg_29_0.color then
			arg_29_0.color = var_0_9
		end

		arg_29_0:Notify(var_0_3, {
			anim = true,
			type = arg_29_0.color
		})

		return
	end
	;({}).GetCellColorStr = function(arg_30_0)
		if var_0_9 == arg_30_0.color then
			return "white"
		elseif var_0_10 == arg_30_0.color then
			return "black"
		end

		return
	end
	;({}).ClearCheck = function(arg_31_0)
		arg_31_0.check = false

		arg_31_0:Notify(var_0_4, arg_31_0.check)

		return
	end
	;({}).Check = function(arg_32_0)
		arg_32_0.check = true

		arg_32_0:Notify(var_0_4, arg_32_0.check)

		return
	end
	;({}).IsSame = function(arg_33_0, arg_33_1)
		return arg_33_0.x == arg_33_1.x and arg_33_0.y == arg_33_1.y
	end
	;({}).GetScore = function(arg_34_0)
		if var_0_9 == arg_34_0.color then
			return 1
		elseif var_0_10 == arg_34_0.color then
			return -1
		end

		return 0
	end
	;({}).Serialize = function(arg_35_0)
		return string.format("{%d,%d,%d}", arg_35_0.x, arg_35_0.y, arg_35_0:GetType() == var_0_9 and 1 or -1)
	end
	;({}).Dispose = function(arg_36_0)
		return
	end

	;(function(arg_23_0)
		arg_23_0.x = arg_22_0.x
		arg_23_0.y = arg_22_0.y
		arg_23_0.color = arg_22_0.color
		arg_23_0.check = false
		arg_23_0.initData = {
			check = false,
			x = arg_23_0.x,
			y = arg_23_0.y,
			color = arg_23_0.color
		}

		return
	end)({})

	return setmetatable({}, {
		__index = var_0_21({})
	})
end

local function var_0_23(arg_37_0)
	({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).started = arg_37_0.started or false
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).UpdateData = function(arg_38_0, arg_38_1)
		arg_38_0.highestScore = arg_38_1.highestScore or 0
		arg_38_0.isUnlock = arg_38_1.isUnlock
		arg_38_0.isFinished = arg_38_1.isFinished

		return
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).Init = function(arg_39_0)
		arg_39_0.isInited = true
		arg_39_0.randomer = var_0_18()

		local var_39_0 = arg_39_0.maps

		if not arg_39_0.maps or #var_39_0 == 0 then
			var_39_0 = arg_39_0:GenRandomMap()
		end

		arg_39_0:CreatNewMap(var_39_0)
		arg_39_0:Notify(var_0_8)

		return
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).CreatNewMap = function(arg_40_0, arg_40_1)
		arg_40_0.cells = {}

		for iter_40_0, iter_40_1 in ipairs(arg_40_1) do
			local var_40_0 = arg_40_0:CreateCell(iter_40_1[1], iter_40_1[2], iter_40_1[3])

			table.insert(arg_40_0.cells, var_40_0)
			arg_40_0:Notify(var_0_1, var_40_0)
		end

		return
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).GenRandomMap = function(arg_41_0)
		return arg_41_0.randomer:RandomMap(var_0_16[arg_41_0.id].theme[1], var_0_16[arg_41_0.id].theme[2], var_0_14, var_0_15)
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).TriggerTip = function(arg_42_0)
		arg_42_0:Notify(var_0_7, arg_42_0.primaryCell)

		return
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).NeedTip = function(arg_43_0)
		return arg_43_0.primaryCell ~= nil
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).UpdateTurnCnt = function(arg_44_0, arg_44_1)
		arg_44_0.calcStep = arg_44_1

		arg_44_0:Notify(var_0_2, arg_44_0.calcStep)

		if arg_44_0.calcStep == 0 then
			local var_44_0 = arg_44_0:CalcScore()

			if var_44_0 > arg_44_0.highestScore then
				arg_44_0.highestScore = var_44_0

				if arg_44_0.isFinished then
					arg_44_0:Notify(var_0_5, var_44_0)
				end
			end

			arg_44_0.isFinished = true
		end

		return
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).CalcScore = function(arg_45_0)
		local var_45_0 = 0

		_.each(arg_45_0.cells, function(arg_46_0)
			var_45_0 = var_45_0 + arg_46_0:GetScore()

			return
		end)

		return 0
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).CreateCell = function(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		return var_0_22({
			x = arg_47_1,
			y = arg_47_2,
			color = arg_47_3
		})
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).GetCellByPosition = function(arg_48_0, arg_48_1)
		return _.detect(arg_48_0.cells, function(arg_49_0)
			return arg_49_0:IsSame(arg_48_1)
		end)
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).GetAroundCells = function(arg_50_0, arg_50_1)
		local var_50_0 = {}
		local var_50_1 = arg_50_1:GetPosition()

		_.each({
			Vector2(var_50_1.x + 1, var_50_1.y),
			Vector2(var_50_1.x - 1, var_50_1.y),
			Vector2(var_50_1.x, var_50_1.y - 1),
			Vector2(var_50_1.x, var_50_1.y + 1),
			Vector2(var_50_1.x - 1, var_50_1.y - 1),
			Vector2(var_50_1.x + 1, var_50_1.y + 1),
			Vector2(var_50_1.x + 1, var_50_1.y - 1),
			Vector2(var_50_1.x - 1, var_50_1.y + 1),
			Vector2(var_50_1.x, var_50_1.y)
		}, function(arg_51_0)
			local var_51_0 = arg_50_0:GetCellByPosition(arg_51_0)

			if var_51_0 then
				table.insert(var_50_0, var_51_0)
			end

			return
		end)

		return {}
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).inProcess = function(arg_52_0)
		return arg_52_0.started
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).Start = function(arg_53_0)
		arg_53_0.started = true

		return
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).Reverse = function(arg_54_0, arg_54_1)
		local var_54_0 = #arg_54_0.primaryCells
		local var_54_1 = 0

		_.each(arg_54_0.primaryCells, function(arg_55_0)
			arg_55_0:SetAnimDoneCallback(function()
				var_54_1 = var_54_1 + 1

				if var_54_1 == var_54_0 then
					arg_54_1()
				end

				arg_55_0:SetAnimDoneCallback(nil)

				return
			end)
			arg_55_0:Reverse()

			return
		end)

		return
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).Primary = function(arg_57_0, arg_57_1)
		if arg_57_0.isStartReverse then
			return
		end

		local function var_57_0()
			local var_58_0 = arg_57_0.primaryCells or {}

			_.each(var_58_0, function(arg_59_0)
				arg_59_0:ClearCheck()

				return
			end)

			return
		end

		if arg_57_0.primaryCells and arg_57_0.primaryCell and arg_57_1:IsSame(arg_57_0.primaryCell) then
			arg_57_0.isStartReverse = true

			arg_57_0:Reverse(function()
				var_57_0()

				arg_57_0.primaryCell = nil
				arg_57_0.primaryCells = nil

				arg_57_0:UpdateTurnCnt(arg_57_0.calcStep - 1)

				arg_57_0.isStartReverse = false

				return
			end)

			return
		end

		arg_57_0.primaryCell = arg_57_1

		var_57_0()

		arg_57_0.primaryCells = arg_57_0:GetAroundCells(arg_57_1)

		_.each(arg_57_0.primaryCells, function(arg_61_0)
			arg_61_0:Check()

			return
		end)

		return
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).ReStart = function(arg_62_0)
		arg_62_0:Notify(var_0_6)

		local var_62_0 = #var_0_16[arg_62_0.id].map == 0 and arg_62_0:GenRandomMap() or var_0_16[arg_62_0.id].map

		arg_62_0:CreatNewMap(var_62_0)
		arg_62_0:UpdateTurnCnt(arg_62_0.maxCount)

		arg_62_0.started = false

		return
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).Serialize = function(arg_63_0)
		if not arg_63_0.isInited then
			return ""
		end

		local var_63_0 = "{"

		_.each(arg_63_0.cells, function(arg_64_0)
			var_63_0 = var_63_0 .. arg_64_0:Serialize() .. ","

			return
		end)

		var_63_0 = var_63_0 .. "}#" .. arg_63_0.calcStep .. "#" .. (arg_63_0.started and "1" or "0")

		return var_63_0
	end
	;({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}).Dispose = function(arg_65_0)
		_.each(arg_65_0.cells, function(arg_66_0)
			arg_66_0:Dispose()

			return
		end)

		arg_65_0.started = false

		return
	end

	return setmetatable({
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}, {
		__index = var_0_21({
			id = arg_37_0.id,
			maxCount = arg_37_0.maxCount,
			calcStep = arg_37_0.calcStep,
			condition = arg_37_0.condition,
			maps = arg_37_0.maps
		})
	})
end

local function var_0_24(arg_67_0, arg_67_1)
	local var_67_0 = {}

	local function var_67_1(arg_68_0, arg_68_1, arg_68_2)
		if arg_68_2.anim then
			arg_68_0.dftAniEvent:SetEndEvent(function()
				arg_68_0.dftAniEvent:SetEndEvent(nil)
				arg_68_0.cell:OnAnimDone()

				return
			end)
			arg_68_0.animation:Stop()
			arg_68_0.animation:Play((arg_68_0:GetAnimationKey(arg_68_2.type)))
		else
			arg_68_0.img.color = var_0_11[arg_68_2.type]
		end

		return
	end

	;({}).onCellTypeChanged = function(arg_70_0, arg_70_1)
		var_67_1(var_67_0, arg_70_0, arg_70_1)

		return
	end

	local function var_67_2(arg_71_0, arg_71_1, arg_71_2)
		if arg_71_2 then
			arg_71_0.animation:Stop()
			arg_71_0.animation:Play("blink")
		else
			arg_71_0:ResetAlhpa()
			arg_71_0.animation:Stop("blink")
		end

		return
	end

	;({}).onCellCheckChanged = function(arg_72_0, arg_72_1)
		var_67_2(var_67_0, arg_72_0, arg_72_1)

		return
	end
	;({}).SetCheck = function(arg_74_0, arg_74_1)
		setActive(arg_74_0.checkTF, arg_74_1)

		return
	end
	;({}).GetSprite = function(arg_75_0)
		local var_75_0 = arg_75_0.cell.x
		local var_75_1 = arg_75_0.cell.y

		if arg_75_0.cell.x > arg_75_0.maxSpriteIndexX and arg_75_0.cell.x % arg_75_0.maxSpriteIndexX == 0 then
			var_75_0 = 0
		elseif var_75_0 > arg_75_0.maxSpriteIndexX then
			var_75_0 = arg_75_0.maxSpriteIndexX - arg_75_0.cell.x % arg_75_0.maxSpriteIndexX
		end

		if var_75_1 > arg_75_0.maxSpriteIndexY then
			var_75_1 = arg_75_0.maxSpriteIndexY - var_75_1 % (arg_75_0.maxSpriteIndexY + 1)
		end

		return var_0_17[var_75_0][var_75_1]
	end
	;({}).GetAnimationKey = function(arg_76_0, arg_76_1)
		local var_76_0 = ""

		if arg_76_1 == var_0_9 then
			var_76_0 = "b2w"
		elseif arg_76_1 == var_0_10 then
			var_76_0 = "w2b"
		end

		return var_76_0
	end
	;({}).SetScale = function(arg_77_0)
		arg_77_0.cellImage.localScale = Vector3(arg_77_0.cell.x / arg_77_0.maxSpriteIndexX > 1 and -1 or 1, arg_77_0.cell.y / arg_77_0.maxSpriteIndexY > 1 and -1 or 1, 1)

		setAnchoredPosition(arg_77_0.cellImage, Vector2(arg_77_0.cellImage.anchoredPosition.x * var_77_0, arg_77_0.cellImage.anchoredPosition.y * var_77_1))

		return
	end
	;({}).ResetAlhpa = function(arg_78_0)
		arg_78_0.img.color = Color.New(arg_78_0.img.color.r, arg_78_0.img.color.g, arg_78_0.img.color.b, 1)

		return
	end
	;({}).SetPosition = function(arg_79_0)
		local var_79_0 = arg_79_0.cell:GetPosition()

		go(arg_79_0._tf).name = var_79_0.x .. "_" .. var_79_0.y

		local var_79_1 = arg_79_0.width
		local var_79_2 = arg_79_0.height

		if var_79_0.x > arg_79_0.maxSpriteIndexX then
			var_79_1 = arg_79_0.width - arg_79_0.offsetX
		end

		if var_79_0.y > arg_79_0.maxSpriteIndexY then
			var_79_2 = arg_79_0.height - arg_79_0.offsetY
		end

		arg_79_0._tf.localPosition = Vector3(var_79_0.x * var_79_1, -(var_79_0.y * var_79_2), 0)

		if arg_79_0.cellImage.localScale.x == -1 and arg_79_0.cellImage.localScale.y == -1 then
			anchorMax = Vector2(1, 0)
			anchorMin = Vector2(1, 0)
		elseif arg_79_0.cellImage.localScale.x == 1 and arg_79_0.cellImage.localScale.y == -1 then
			anchorMax = Vector2(0, 0)
			anchorMin = Vector2(0, 0)
		elseif arg_79_0.cellImage.localScale.x == -1 and arg_79_0.cellImage.localScale.y == 1 then
			anchorMax = Vector2(1, 1)
			anchorMin = Vector2(1, 1)
		else
			anchorMax = Vector2(0, 1)
			anchorMin = Vector2(0, 1)
		end

		arg_79_0.cellImage.anchorMax = anchorMax
		arg_79_0.cellImage.anchorMin = anchorMin

		return
	end
	;({}).AddListener = function(arg_80_0)
		arg_80_0.cell:AddListener(var_0_3, arg_80_0.onCellTypeChanged)
		arg_80_0.cell:AddListener(var_0_4, arg_80_0.onCellCheckChanged)

		return
	end
	;({}).RemoveListener = function(arg_81_0)
		arg_81_0.cell:RemoveListener(var_0_3, arg_81_0.onCellTypeChanged)
		arg_81_0.cell:RemoveListener(var_0_4, arg_81_0.onCellCheckChanged)

		return
	end
	;({}).Dispose = function(arg_82_0)
		arg_82_0:ResetAlhpa()
		arg_82_0.animation:Stop()

		arg_82_0._tf.localPosition = Vector3(0, 0, 0)
		arg_82_0._tf.localScale = Vector3(1, 1, 1)
		arg_82_0.cellImage.localPosition = Vector3(0, 0, 0)
		arg_82_0.cellImage.localScale = Vector3(1, 1, 1)
		arg_82_0.img.sprite = nil
		arg_82_0.img.color = var_0_11[1]

		arg_82_0:RemoveListener()
		removeOnButton(arg_82_0._tf)
		setActive(arg_82_0.checkTF, false)

		return
	end

	;(function(arg_73_0)
		arg_73_0.maxSpriteIndexX = #var_0_17
		arg_73_0.maxSpriteIndexY = #var_0_17[#var_0_17]
		arg_73_0.cell = arg_67_1
		arg_73_0._tf = arg_67_0
		arg_73_0.cellImage = arg_73_0._tf:Find("image")
		arg_73_0.checkTF = arg_73_0.cellImage:Find("check")
		arg_73_0.dftAniEvent = arg_73_0.cellImage:GetComponent(typeof(DftAniEvent))
		arg_73_0.animation = arg_73_0.cellImage:GetComponent(typeof(Animation))

		arg_73_0.animation:Stop()

		arg_73_0.img = arg_73_0.cellImage:GetComponent(typeof(Image))
		arg_73_0.width = arg_73_0._tf.sizeDelta.x
		arg_73_0.height = arg_73_0._tf.sizeDelta.y
		arg_73_0.offsetX = 2
		arg_73_0.offsetY = 0

		arg_73_0:AddListener()

		arg_73_0.img.color = var_0_11[arg_73_0.cell:GetType()]
		arg_73_0.img.sprite = arg_73_0:GetSprite()

		arg_73_0.img:SetNativeSize()
		setAnchoredPosition(arg_73_0.cellImage, Vector2(arg_73_0.cellImage.sizeDelta.x / 2, -arg_73_0.cellImage.sizeDelta.y / 2))
		arg_73_0:SetScale()
		arg_73_0:SetPosition()

		return
	end)({})

	return {}
end

local function var_0_25(arg_83_0, arg_83_1, arg_83_2)
	local var_83_0 = {
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}

	local function var_83_1(arg_87_0, arg_87_1, arg_87_2)
		local var_87_0 = arg_87_0:GetCellTpl(arg_87_2).transform

		setParent(var_87_0, arg_87_0.cellContainer)
		table.insert(arg_87_0.cells, (var_0_24(var_87_0, arg_87_2)))
		onButton(nil, var_87_0, function()
			if arg_87_0.tipCellView then
				arg_87_0.tipCellView:SetCheck(false)

				arg_87_0.tipCellView = nil
			end

			if arg_87_0.map.calcStep == 0 then
				arg_87_0:ResetMap()

				return
			end

			if not arg_87_0.map.primaryCell or arg_87_0.map.primaryCell and arg_87_0.map.primaryCell ~= arg_87_2 then
				arg_87_0:AddTipTimer()
			else
				arg_87_0:StopTipTimer()
			end

			arg_87_0.map:Primary(arg_87_2)

			return
		end, SFX_PANEL)

		return
	end

	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).onCellCreate = function(arg_89_0, arg_89_1)
		var_83_1(var_83_0, arg_89_0, arg_89_1)

		return
	end

	local function var_83_2(arg_90_0, arg_90_1, arg_90_2)
		arg_90_0.leftCountTxt.text = arg_90_2

		local var_90_0 = arg_90_0.map:CalcScore()

		if arg_90_2 == 0 then
			if not arg_90_0.map.isFinished then
				arg_90_0.onFirstFinished(arg_90_0.map.id, var_90_0)

				arg_90_0.highestScoreTxt.text = var_90_0
			end

			arg_90_0.onShowResult(arg_90_0.map.id, var_90_0, function()
				arg_90_0:Reset()

				return
			end)

			arg_90_0.currScoreTxt.text = "-"
		else
			arg_90_0.currScoreTxt.text = var_90_0
		end

		return
	end

	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).onTurnCntUpdated = function(arg_92_0, arg_92_1)
		var_83_2(var_83_0, arg_92_0, arg_92_1)

		return
	end

	local function var_83_3(arg_93_0, arg_93_1, arg_93_2)
		arg_93_0.highestScoreTxt.text = arg_93_2

		arg_93_0.onHighestScore(arg_93_0.map.id, arg_93_2)

		return
	end

	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).onHighestUpdated = function(arg_94_0, arg_94_1)
		var_83_3(var_83_0, arg_94_0, arg_94_1)

		return
	end

	local function var_83_4(arg_95_0, arg_95_1)
		for iter_95_0, iter_95_1 in ipairs(arg_95_0.cells) do
			iter_95_1:Dispose()
			arg_95_0.poolMgr:Return(iter_95_1.cell:GetType(), iter_95_1._tf.gameObject)
		end

		arg_95_0.cells = {}

		return
	end

	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).onDestoryCells = function(arg_96_0)
		var_83_4(var_83_0, arg_96_0)

		return
	end

	local function var_83_5(arg_97_0, arg_97_1, arg_97_2)
		local var_97_0 = _.detect(arg_97_0.cells, function(arg_98_0)
			return arg_98_0.cell:IsSame(arg_97_2)
		end)

		if var_97_0 then
			arg_97_0.tipCellView = var_97_0

			var_97_0:SetCheck(true)
		end

		return
	end

	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).onCellTip = function(arg_99_0, arg_99_1)
		var_83_5(var_83_0, arg_99_0, arg_99_1)

		return
	end

	local function var_83_6(arg_100_0, arg_100_1)
		arg_100_0.highestScoreTxt.text = arg_100_0.map.highestScore
		arg_100_0.leftCountTxt.text = arg_100_0.map.calcStep

		local var_100_0 = arg_100_0.map:CalcScore()
		local var_100_1 = arg_100_0:ShouldShowStartBg()

		arg_100_0.currScoreTxt.text = var_100_1 and "-" or var_100_0

		setActive(arg_100_0.startBg, var_100_1)
		onButton(nil, arg_100_0.startBg, function()
			if not arg_100_0.map.isUnlock then
				return
			end

			setActive(arg_100_0.startBg, false)
			arg_100_0:RecordStartBg()

			arg_100_0.currScoreTxt.text = var_100_0

			setActive(arg_100_0.cellContainer, true)
			arg_100_0.map:Start()

			return
		end)

		if not var_100_1 then
			setActive(arg_100_0.cellContainer, true)
		end

		return
	end

	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).onMapInitDone = function(arg_102_0)
		var_83_6(var_83_0, arg_102_0)

		return
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).Reset = function(arg_105_0)
		arg_105_0.map:ReStart()
		setActive(arg_105_0.startBg, true)
		setActive(arg_105_0.cellContainer, false)

		arg_105_0.currScoreTxt.text = "-"

		return
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).ResetMap = function(arg_106_0)
		if arg_106_0.map.calcStep == arg_106_0.map.maxCount then
			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("black_white_grid_reset"),
			onYes = function()
				arg_106_0:Reset()

				return
			end
		})

		return
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).AddTipTimer = function(arg_108_0)
		if arg_108_0.timer then
			arg_108_0.timer:Stop()
		end

		arg_108_0.timer = Timer.New(function()
			if arg_108_0.map:NeedTip() then
				arg_108_0.map:TriggerTip()
			end

			return
		end, var_0_13, 1)

		arg_108_0.timer:Start()

		return
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).StopTipTimer = function(arg_110_0)
		if arg_110_0.timer then
			arg_110_0.timer:Stop()

			arg_110_0.timer = nil
		end

		return
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).ShouldShowStartBg = function(arg_111_0)
		return not arg_111_0.map:inProcess()
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).RecordStartBg = function(arg_112_0)
		return
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).GetCellTpl = function(arg_113_0, arg_113_1)
		return arg_113_0.poolMgr:Get(arg_113_1:GetCellColorStr())
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).AddListener = function(arg_114_0)
		arg_114_0.map:AddListener(var_0_1, arg_114_0.onCellCreate)
		arg_114_0.map:AddListener(var_0_2, arg_114_0.onTurnCntUpdated)
		arg_114_0.map:AddListener(var_0_5, arg_114_0.onHighestUpdated)
		arg_114_0.map:AddListener(var_0_6, arg_114_0.onDestoryCells)
		arg_114_0.map:AddListener(var_0_7, arg_114_0.onCellTip)
		arg_114_0.map:AddListener(var_0_8, arg_114_0.onMapInitDone)

		return
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).RemoveListener = function(arg_115_0)
		arg_115_0.map:RemoveListener(var_0_1, arg_115_0.onCellCreate)
		arg_115_0.map:RemoveListener(var_0_2, arg_115_0.onTurnCntUpdated)
		arg_115_0.map:RemoveListener(var_0_5, arg_115_0.onHighestUpdated)
		arg_115_0.map:RemoveListener(var_0_6, arg_115_0.onDestoryCells)
		arg_115_0.map:RemoveListener(var_0_7, arg_115_0.onCellTip)
		arg_115_0.map:RemoveListener(var_0_8, arg_115_0.onMapInitDone)

		return
	end
	;({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}).Dispose = function(arg_116_0)
		arg_116_0.map:Dispose()
		removeOnButton(arg_116_0.restartBtn)
		arg_116_0:RemoveListener()
		var_83_4(arg_116_0, nil)
		arg_116_0:StopTipTimer()

		arg_116_0.tipCellView = nil

		return
	end

	;(function(arg_103_0)
		arg_103_0._tf = arg_83_0
		arg_103_0.cellWhite = arg_103_0._tf:Find("cell")
		arg_103_0.cellContainer = arg_103_0._tf:Find("container")
		arg_103_0.restartBtn = arg_103_0._tf:Find("restart")
		arg_103_0.leftCountTxt = arg_103_0._tf:Find("left_count"):GetComponent(typeof(Text))
		arg_103_0.highestScoreTxt = arg_103_0._tf:Find("highest"):GetComponent(typeof(Text))
		arg_103_0.currScoreTxt = arg_103_0._tf:Find("curr_score"):GetComponent(typeof(Text))
		arg_103_0.startBg = arg_103_0._tf:Find("start_bg")
		arg_103_0.startBgText = arg_103_0.startBg:Find("Text"):GetComponent(typeof(Text))
		arg_103_0.startLabel = arg_103_0.startBg:Find("Image")
		arg_103_0.map = arg_83_1
		arg_103_0.cells = {}

		arg_103_0:AddListener()

		arg_103_0.startBgText.text = arg_103_0.map.isUnlock and "" or arg_103_0.map.condition

		setActive(arg_103_0.startLabel, arg_103_0.map.isUnlock)
		setActive(arg_103_0.cellContainer, false)
		onButton(nil, arg_103_0.restartBtn, function()
			arg_103_0:ResetMap()

			return
		end, SFX_PANEL)

		return
	end)({
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	})

	return {
		poolMgr = arg_83_2,
		onFirstFinished = function(arg_84_0, arg_84_1)
			return
		end,
		onHighestScore = function(arg_85_0, arg_85_1)
			return
		end,
		onShowResult = function(arg_86_0, arg_86_1, arg_86_2)
			return
		end
	}
end

local function var_0_26(arg_117_0)
	({
		_tf = arg_117_0
	}).Show = function(arg_120_0, arg_120_1, arg_120_2)
		setActive(arg_120_0._tf, true)

		arg_120_0.scoreTxt.text = arg_120_1
		arg_120_0.cb = arg_120_2

		return
	end
	;({
		_tf = arg_117_0
	}).Hide = function(arg_121_0)
		if arg_121_0.cb then
			arg_121_0.cb()
		end

		setActive(arg_121_0._tf, false)

		arg_121_0.scoreTxt.text = ""
		arg_121_0.cb = nil

		return
	end
	;({
		_tf = arg_117_0
	}).Dispose = function(arg_122_0)
		arg_122_0:Hide()

		return
	end

	;(function(arg_118_0)
		setActive(arg_118_0._tf, false)

		arg_118_0.scoreTxt = arg_118_0._tf:Find("score/Text"):GetComponent(typeof(Text))

		onButton(nil, arg_118_0._tf, function()
			arg_118_0:Hide()

			return
		end, SFX_PANEL)

		return
	end)({
		_tf = arg_117_0
	})

	return {
		_tf = arg_117_0
	}
end

function var_0_0.getUIName(arg_123_0)
	return "BlackWhiteGridUI"
end

function var_0_0.preload(arg_124_0, arg_124_1)
	for iter_124_0 = 0, 4 do
		for iter_124_1 = 0, 2 do
			table.insert({}, iter_124_0 .. "_" .. iter_124_1)
		end
	end

	var_0_17 = {}

	AssetBundleHelper.LoadManyAssets("ui/blackwhitegrid_atlas", {}, nil, true, function(arg_125_0)
		for iter_125_0 = 0, 4 do
			var_0_17[iter_125_0] = {}

			for iter_125_1 = 0, 2 do
				var_0_17[iter_125_0][iter_125_1] = arg_125_0[iter_125_0 .. "_" .. iter_125_1]
			end
		end

		return
	end, true)

	arg_124_0.bgSprite = nil

	LoadSpriteAsync("clutter/blackwhite_bg", function(arg_126_0)
		arg_124_0.bgSprite = arg_126_0

		arg_124_1()

		return
	end)

	return
end

function var_0_0.setActivity(arg_127_0, arg_127_1)
	arg_127_0.activityVO = arg_127_1
	arg_127_0.passIds = arg_127_1.data1_list
	arg_127_0.scores = arg_127_1.data2_list

	arg_127_0:updateFur()

	return
end

function var_0_0.setPlayer(arg_128_0, arg_128_1)
	arg_128_0.player = arg_128_1

	return
end

function var_0_0.init(arg_129_0)
	arg_129_0.mapTF = arg_129_0._tf:Find("map")
	arg_129_0.backBtn = arg_129_0._tf:Find("back")
	arg_129_0.toggleTFs = arg_129_0._tf:Find("toggles")
	arg_129_0.poolMgr = var_0_20(arg_129_0.mapTF:Find("root"))
	arg_129_0.successMsgbox = var_0_26(arg_129_0._tf:Find("success_bg"))
	arg_129_0.failedMsgbox = var_0_26(arg_129_0._tf:Find("failed_bg"))
	arg_129_0.furGot = arg_129_0._tf:Find("fur/got")
	arg_129_0.helpBtn = arg_129_0._tf:Find("help")
	arg_129_0._tf:GetComponent(typeof(Image)).sprite = arg_129_0.bgSprite

	return
end

function var_0_0.didEnter(arg_130_0)
	onButton(arg_130_0, arg_130_0.backBtn, function()
		arg_130_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_PANEL)
	onButton(arg_130_0, arg_130_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.black_white_grid_notice.tip
		})

		return
	end, SFX_PANEL)

	arg_130_0.selecteds = {}

	local function var_130_0(arg_133_0)
		eachChild(arg_133_0, function(arg_134_0)
			if go(arg_134_0).name ~= "text" and go(arg_134_0).activeSelf then
				local var_134_0 = arg_134_0:GetComponent(typeof(Image))

				var_134_0.color = var_0_12

				table.insert(arg_130_0.selecteds, var_134_0)
			end

			return
		end)

		return
	end

	local function var_130_1()
		for iter_135_0, iter_135_1 in ipairs(arg_130_0.selecteds) do
			iter_135_1.color = Color.New(1, 1, 1, 1)
		end

		arg_130_0.selecteds = {}

		return
	end

	arg_130_0.btns = {}
	arg_130_0.maps = {}

	for iter_130_0, iter_130_1 in ipairs(arg_130_0.activityVO:getConfig("config_data")) do
		local var_130_2 = arg_130_0.toggleTFs:GetChild(iter_130_0 - 1)

		arg_130_0.maps[iter_130_1] = arg_130_0:GetMapVO(var_0_16[iter_130_1])

		onButton(arg_130_0, var_130_2, function()
			if arg_130_0.id == iter_130_1 then
				return
			end

			if arg_130_0.mapView and arg_130_0.mapView.map:inProcess() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("black_white_grid_switch_tip"))

				return
			end

			arg_130_0.id = iter_130_1

			arg_130_0:loadMap((arg_130_0:GetMapVO(var_0)))

			if #arg_130_0.selecteds > 0 then
				var_130_1()
			end

			var_130_0(var_130_2)

			return
		end, SFX_PANEL)

		arg_130_0.btns[iter_130_1] = var_130_2
	end

	local var_130_3 = arg_130_0:GetLastestUnlockMap()

	if var_130_3 then
		triggerButton(var_130_3)
	end

	arg_130_0:updateBtnsState()

	return
end

function var_0_0.updateFur(arg_137_0)
	if arg_137_0.furGot then
		local var_137_0 = arg_137_0.activityVO:getConfig("config_data")

		setActive(arg_137_0.furGot, table.contains(arg_137_0.passIds, var_137_0[#var_137_0 - 1]))
	end

	return
end

function var_0_0.isUnlock(arg_138_0, arg_138_1)
	local var_138_0 = getProxy(ChapterProxy):getChapterById(arg_138_1.unlock[2])
	local var_138_1 = var_138_0 and var_138_0:isUnlock() and var_138_0:isAllAchieve()
	local var_138_2 = arg_138_1.unlock[1] == 0 or table.contains(arg_138_0.passIds, arg_138_1.unlock[1])

	return var_138_1 and var_138_2
end

function var_0_0.GetLastestUnlockMap(arg_139_0)
	local var_139_0 = arg_139_0:GetMapIndex()

	if arg_139_0.btns[var_139_0] then
		return arg_139_0.btns[var_139_0]
	else
		local var_139_1
		local var_139_2 = 0

		for iter_139_0, iter_139_1 in pairs(arg_139_0.btns) do
			var_139_2 = var_139_2 + 1

			if arg_139_0:isUnlock(var_0_16[iter_139_0]) or var_139_2 == 1 then
				var_139_1 = iter_139_1
			end
		end

		return var_139_1
	end

	return
end

function var_0_0.updateBtnsState(arg_140_0)
	for iter_140_0, iter_140_1 in pairs(arg_140_0.btns) do
		local var_140_0 = table.contains(arg_140_0.passIds, iter_140_0)
		local var_140_1 = arg_140_0:isUnlock(var_0_16[iter_140_0])

		setActive(iter_140_1:Find("finished"), var_140_0)
		setActive(iter_140_1:Find("locked"), not var_140_1)
		setActive(iter_140_1:Find("opening"), not var_140_0 and var_140_1)
	end

	return
end

function var_0_0.GetMapVO(arg_141_0, arg_141_1)
	local var_141_0
	local var_141_1 = table.indexof(arg_141_0.passIds, arg_141_1.id)
	local var_141_2 = table.contains(arg_141_0.passIds, arg_141_1.id)

	if var_141_1 then
		local var_141_3 = arg_141_0.scores[var_141_1] or 0
		local var_141_4 = {
			highestScore = var_141_3,
			isFinished = var_141_2,
			isUnlock = arg_141_0:isUnlock(arg_141_1)
		}

		if arg_141_0.maps[arg_141_1.id] then
			var_141_0 = arg_141_0.maps[arg_141_1.id]

			arg_141_0.maps[arg_141_1.id]:UpdateData(var_141_4)
		else
			local var_141_5, var_141_6, var_141_7 = arg_141_0:parseMap(arg_141_1)

			var_141_0 = var_0_23({
				id = arg_141_1.id,
				maps = var_141_5,
				calcStep = var_141_6,
				maxCount = arg_141_1.num,
				condition = arg_141_1.condition,
				started = var_141_7
			})

			var_141_0:UpdateData(var_141_4)
		end

		return var_141_0
	end
end

function var_0_0.parseMap(arg_142_0, arg_142_1)
	local var_142_0 = PlayerPrefs.GetString("BlackWhiteGridMapData-" .. arg_142_1.id .. "-" .. arg_142_0.player.id, "")

	if not var_142_0 or var_142_0 == "" then
		return arg_142_1.map, arg_142_1.num, false
	else
		local var_142_1 = var_142_0:split("#")

		return loadstring("return " .. var_142_1[1])(), tonumber(var_142_1[2]), var_142_1[3] == "1"
	end

	return
end

function var_0_0.SaveMapsData(arg_143_0)
	for iter_143_0, iter_143_1 in ipairs(arg_143_0.maps) do
		local var_143_0 = iter_143_1:Serialize()

		if var_143_0 and var_143_0 ~= "" then
			PlayerPrefs.SetString("BlackWhiteGridMapData-" .. iter_143_1.id .. "-" .. arg_143_0.player.id, var_143_0)
		end
	end

	PlayerPrefs.Save()

	return
end

function var_0_0.GetMapIndex(arg_144_0)
	return (PlayerPrefs.GetInt("BlackWhiteGridMapIndex-" .. arg_144_0.player.id, 1))
end

function var_0_0.SaveMapIndex(arg_145_0)
	local var_145_0 = arg_145_0.id or 1

	PlayerPrefs.SetInt("BlackWhiteGridMapIndex-" .. arg_145_0.player.id, var_145_0)
	PlayerPrefs.Save()

	return
end

function var_0_0.loadMap(arg_146_0, arg_146_1)
	if arg_146_0.mapView then
		arg_146_0.mapView:Dispose()
	end

	arg_146_0.mapView = var_0_25(arg_146_0.mapTF, arg_146_1, arg_146_0.poolMgr)

	function arg_146_0.mapView.onFirstFinished(arg_147_0, arg_147_1)
		arg_146_0:emit(BlackWhiteGridMediator.ON_FINISH, arg_147_0, arg_147_1)

		return
	end

	function arg_146_0.mapView.onHighestScore(arg_148_0, arg_148_1)
		arg_146_0:emit(BlackWhiteGridMediator.ON_UPDATE_SCORE, arg_148_0, arg_148_1)

		return
	end

	function arg_146_0.mapView.onShowResult(arg_149_0, arg_149_1, arg_149_2)
		if arg_149_1 >= 0 then
			arg_146_0.successMsgbox:Show(arg_149_1, arg_149_2)
		else
			arg_146_0.failedMsgbox:Show(arg_149_1, arg_149_2)
		end

		return
	end

	arg_146_1:Init()

	return
end

function var_0_0.playStory(arg_150_0, arg_150_1)
	if var_0_16[arg_150_0.mapView.map.id].story and var_0_16[arg_150_0.mapView.map.id].story ~= "" then
		pg.NewStoryMgr.GetInstance():Play(var_0_16[arg_150_0.mapView.map.id].story, arg_150_1, true, true)
	else
		arg_150_1()
	end

	return
end

function var_0_0.willExit(arg_151_0)
	arg_151_0:SaveMapsData()
	arg_151_0:SaveMapIndex()

	if arg_151_0.mapView then
		arg_151_0.mapView:Dispose()
	end

	arg_151_0.successMsgbox:Dispose()
	arg_151_0.failedMsgbox:Dispose()
	arg_151_0.poolMgr:Dispose()

	var_0_17 = nil

	return
end

return var_0_0
