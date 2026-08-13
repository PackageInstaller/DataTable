class = var_0_10000

local var_0_0 = "BlackWhiteGridLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))
local var_0_2 = "create cell"
local var_0_3 = "reach turn cnt"
local var_0_4 = "cell type changed"
local var_0_5 = "cell check changed"
local var_0_6 = "highest score updated"
local var_0_7 = "destroy cells"
local var_0_8 = "cell tip"
local var_0_9 = "map init done"
local var_0_10 = 1
local var_0_11 = -1
local var_0_12 = {}

Color = var_0_10012
var_0_12[1] = var_0_10012.New(1, 1, 1, 1)
Color = var_12

local var_0_13 = var_12.New(0.37, 0.37, 0.37, 1)

var_0_12[-1] = var_0_13
Color = var_0_13

local var_0_14 = var_0_13.New(0.9725490196078431, 0.6509803921568628, 0.8509803921568627, 1)
local var_0_15 = 5
local var_0_16 = 3
local var_0_17 = 5

pg = var_16

local var_0_18 = var_16.activity_event_blackwhite
local var_0_19

local function var_0_20()
	local var_1_0 = {}

	local function var_1_1(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = {}

		math = var_2_10006

		local var_2_1 = var_2_10006.min(arg_2_0 + arg_2_4 - 1, arg_2_3 - 1)

		math = var_2_10007

		local var_2_2 = var_2_10007.min(arg_2_1 + arg_2_4 - 1, arg_2_2 - 1)

		for iter_2_0 = arg_2_0, var_2_1 do
			for iter_2_1 = arg_2_1, var_2_2 do
				table = var_2_10016
				var_2_10016 = var_2_10016.insert

				local var_2_3 = var_2_0

				Vector2 = var_2_10019

				var_2_10016(var_2_3, var_2_10019(iter_2_0, iter_2_1))
			end
		end

		return var_2_0
	end

	local function var_1_2(arg_3_0, arg_3_1)
		assert = var_2_10002

		var_2_10002(#arg_3_0 ~= 0 and arg_3_1 <= #arg_3_0)

		local var_3_0 = {}
		local var_3_1 = 0

		while var_3_1 < arg_3_1 do
			math = var_3_2

			local var_3_2 = var_3_2.random(1, #arg_3_0)

			table = var_2_10005

			if not var_2_10005.contains(var_3_0, var_3_2) then
				table = var_2_10005

				var_2_10005.insert(var_3_0, var_3_2)

				var_3_1 = var_3_1 + 1
			end
		end

		local var_3_3 = {}

		for iter_3_0 = 1, #arg_3_0 do
			local var_3_4 = arg_3_0[iter_3_0]

			table = var_2_10010
			var_2_10010 = var_2_10010.contains(var_3_0, iter_3_0) and -1 or 1
			table = var_2_10011

			var_2_10011.insert(var_3_3, {
				var_3_4.x,
				var_3_4.y,
				var_2_10010
			})
		end

		return var_3_3
	end

	function var_1_0.RandomMap(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = {}

		for iter_4_0 = 0, arg_4_2 - 1, arg_4_3 do
			for iter_4_1 = 0, arg_4_1 - 1, arg_4_3 do
				local var_4_1 = var_1_1(iter_4_0, iter_4_1, arg_4_1, arg_4_2, arg_4_3)
				local var_4_2 = var_1_2(var_4_1, arg_4_4)

				_ = var_15

				var_15.each(var_4_2, function(arg_5_0)
					table = var_3_10001

					var_3_10001.insert(var_4_0, arg_5_0)

					return
				end)
			end
		end

		return var_4_0
	end

	function var_1_0.Dispose(arg_6_0)
		return
	end

	return var_1_0
end

local function var_0_21(arg_7_0, arg_7_1)
	local var_7_0 = {}

	local function var_7_1(arg_8_0)
		arg_8_0._go = arg_7_0
		arg_8_0._root = arg_7_1
		arg_8_0.maxCnt = 20
		arg_8_0.stack = {}

		return
	end

	function var_7_0.Get(arg_9_0)
		local var_9_0

		if #arg_9_0.stack == 0 then
			instantiate = var_2
			var_9_0 = var_2(arg_9_0._go)
		else
			table = var_2
			var_9_0 = var_2.remove(arg_9_0.stack, 1)
		end

		setActive = var_2

		var_2(var_9_0, true)

		return var_9_0
	end

	function var_7_0.Return(arg_10_0, arg_10_1)
		setActive = var_2_10002

		var_2_10002(arg_10_1, false)

		if #arg_10_0.stack >= arg_10_0.maxCnt then
			Object = var_2

			var_2.Destroy(arg_10_1)
		else
			table = var_2

			var_2.insert(arg_10_0.stack, arg_10_1)

			setParent = var_2

			var_2(arg_10_1, arg_10_0._root)
		end

		return
	end

	function var_7_0.Dispose(arg_11_0)
		ipairs = var_2_10001

		for iter_11_0, iter_11_1 in var_2_10001(arg_11_0.stack) do
			Destroy = var_2_10006

			var_2_10006(iter_11_1)
		end

		return
	end

	var_7_1(var_7_0)

	return var_7_0
end

local function var_0_22(arg_12_0)
	local var_12_0 = {}

	local function var_12_1(arg_13_0)
		arg_13_0.root = arg_12_0

		local var_13_0 = arg_12_0

		arg_13_0.white = var_1.Find(var_13_0, "white")

		local var_13_1 = arg_12_0

		arg_13_0.black = var_1.Find(var_13_1, "black")
		arg_13_0.pools = {}

		return
	end

	function var_12_0.Get(arg_14_0, arg_14_1)
		local var_14_0

		if not arg_14_0.pools[arg_14_1] then
			var_14_0 = var_0_21(arg_14_0[arg_14_1], arg_14_0.root)
			arg_14_0.pools[arg_14_1] = var_14_0
		end

		return var_14_0:Get()
	end

	function var_12_0.Return(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0.pools[arg_15_1] then
			var_3:Return(arg_15_2)
		else
			Destroy = var_2_10004

			var_2_10004(arg_15_2)
		end

		return
	end

	function var_12_0.Dispose(arg_16_0)
		pairs = var_2_10001

		for iter_16_0, iter_16_1 in var_2_10001(arg_16_0.pools) do
			iter_16_1:Dispose()
		end

		return
	end

	var_12_1(var_12_0)

	return var_12_0
end

local function var_0_23(arg_17_0)
	local var_17_0 = {}

	local function var_17_1(arg_18_0)
		arg_18_0.events = {}
		arg_18_0.sender = arg_17_0

		return
	end

	function var_17_0.AddListener(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0

		if not arg_19_0.events[arg_19_1] then
			var_19_0 = arg_19_0.events
			var_19_0[arg_19_1] = {}
		end

		table = var_19_0

		var_19_0.insert(arg_19_0.events[arg_19_1], arg_19_2)

		return
	end

	function var_17_0.RemoveListener(arg_20_0, arg_20_1, arg_20_2)
		for iter_20_0 = #arg_20_0.events[arg_20_1], 1, -1 do
			if var_3[iter_20_0] == arg_20_2 then
				table = var_8

				var_8.remove(var_3, iter_20_0)
			end
		end

		return
	end

	function var_17_0.Notify(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_21_0.events[arg_21_1]

		assert = var_2_10004

		var_2_10004(var_21_0, arg_21_1)

		ipairs = var_2_10004

		for iter_21_0, iter_21_1 in var_2_10004(var_21_0) do
			iter_21_1(arg_21_0.sender, arg_21_2)
		end

		return
	end

	var_17_1(var_17_0)

	return var_17_0
end

local function var_0_24(arg_22_0)
	local var_22_0 = {}

	local function var_22_1(arg_23_0)
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
	end

	function var_22_0.Reset(arg_24_0)
		arg_24_0.x = arg_24_0.initData.x
		arg_24_0.y = arg_24_0.initData.y
		arg_24_0.color = arg_24_0.initData.color
		arg_24_0.check = arg_24_0.initData.check

		arg_24_0:Notify(var_0_4, {
			type = arg_24_0.color
		})

		return
	end

	function var_22_0.GetType(arg_25_0)
		return arg_25_0.color
	end

	function var_22_0.GetPosition(arg_26_0)
		Vector2 = var_2_10001

		return var_2_10001(arg_26_0.x, arg_26_0.y)
	end

	function var_22_0.OnAnimDone(arg_27_0)
		if arg_27_0.animCb then
			arg_27_0.animCb()
		end

		return
	end

	function var_22_0.SetAnimDoneCallback(arg_28_0, arg_28_1)
		arg_28_0.animCb = arg_28_1

		return
	end

	function var_22_0.Reverse(arg_29_0)
		if var_0_10 == arg_29_0.color then
			arg_29_0.color = var_0_11
		elseif var_0_11 == arg_29_0.color then
			arg_29_0.color = var_0_10
		end

		arg_29_0:Notify(var_0_4, {
			anim = true,
			type = arg_29_0.color
		})

		return
	end

	function var_22_0.GetCellColorStr(arg_30_0)
		if var_0_10 == arg_30_0.color then
			return "white"
		elseif var_0_11 == arg_30_0.color then
			return "black"
		end

		return
	end

	function var_22_0.ClearCheck(arg_31_0)
		arg_31_0.check = false

		arg_31_0:Notify(var_0_5, arg_31_0.check)

		return
	end

	function var_22_0.Check(arg_32_0)
		arg_32_0.check = true

		arg_32_0:Notify(var_0_5, arg_32_0.check)

		return
	end

	function var_22_0.IsSame(arg_33_0, arg_33_1)
		return arg_33_0.x == arg_33_1.x and arg_33_0.y == arg_33_1.y
	end

	function var_22_0.GetScore(arg_34_0)
		if var_0_10 == arg_34_0.color then
			return 1
		elseif var_0_11 == arg_34_0.color then
			return -1
		end

		return 0
	end

	function var_22_0.Serialize(arg_35_0)
		local var_35_0 = arg_35_0:GetType() == var_0_10 and 1 or -1

		string = var_2

		return var_2.format("{%d,%d,%d}", arg_35_0.x, arg_35_0.y, var_35_0)
	end

	function var_22_0.Dispose(arg_36_0)
		return
	end

	var_22_1(var_22_0)

	setmetatable = var_3

	return var_3(var_22_0, {
		__index = var_0_23(var_22_0)
	})
end

local function var_0_25(arg_37_0)
	local var_37_0 = {
		id = arg_37_0.id,
		maxCount = arg_37_0.maxCount,
		calcStep = arg_37_0.calcStep,
		condition = arg_37_0.condition,
		maps = arg_37_0.maps
	}
	local var_37_1

	if not arg_37_0.started then
		var_37_1 = false
	end

	var_37_0.started = var_37_1

	function var_37_0.UpdateData(arg_38_0, arg_38_1)
		local var_38_0

		if not arg_38_1.highestScore then
			var_38_0 = 0
		end

		arg_38_0.highestScore = var_38_0
		arg_38_0.isUnlock = arg_38_1.isUnlock
		arg_38_0.isFinished = arg_38_1.isFinished

		return
	end

	function var_37_0.Init(arg_39_0)
		arg_39_0.isInited = true
		arg_39_0.randomer = var_0_20()

		local var_39_0

		if not arg_39_0.maps or #var_39_0 == 0 then
			var_39_0 = arg_39_0:GenRandomMap()
		end

		arg_39_0:CreatNewMap(var_39_0)
		arg_39_0:Notify(var_0_9)

		return
	end

	function var_37_0.CreatNewMap(arg_40_0, arg_40_1)
		arg_40_0.cells = {}
		ipairs = var_2

		for iter_40_0, iter_40_1 in var_2(arg_40_1) do
			local var_40_0 = arg_40_0:CreateCell(iter_40_1[1], iter_40_1[2], iter_40_1[3])

			table = var_2_10008

			var_2_10008.insert(arg_40_0.cells, var_40_0)
			arg_40_0:Notify(var_0_2, var_40_0)
		end

		return
	end

	function var_37_0.GenRandomMap(arg_41_0)
		local var_41_0 = var_0_18[arg_41_0.id].theme[1]
		local var_41_1 = var_2[2]
		local var_41_2 = arg_41_0.randomer

		return var_5.RandomMap(var_41_2, var_41_0, var_41_1, var_0_16, var_0_17)
	end

	function var_37_0.TriggerTip(arg_42_0)
		arg_42_0:Notify(var_0_8, arg_42_0.primaryCell)

		return
	end

	function var_37_0.NeedTip(arg_43_0)
		return arg_43_0.primaryCell ~= nil
	end

	function var_37_0.UpdateTurnCnt(arg_44_0, arg_44_1)
		arg_44_0.calcStep = arg_44_1

		arg_44_0:Notify(var_0_3, arg_44_0.calcStep)

		if arg_44_0.calcStep == 0 then
			if arg_44_0:CalcScore() > arg_44_0.highestScore then
				arg_44_0.highestScore = var_2

				if arg_44_0.isFinished then
					arg_44_0:Notify(var_0_6, var_2)
				end
			end

			arg_44_0.isFinished = true
		end

		return
	end

	function var_37_0.CalcScore(arg_45_0)
		local var_45_0 = 0

		_ = var_2_10002

		var_2_10002.each(arg_45_0.cells, function(arg_46_0)
			var_45_0 = var_45_0 + arg_46_0:GetScore()

			return
		end)

		return var_45_0
	end

	function var_37_0.CreateCell(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		return var_0_24({
			x = arg_47_1,
			y = arg_47_2,
			color = arg_47_3
		})
	end

	function var_37_0.GetCellByPosition(arg_48_0, arg_48_1)
		_ = var_2_10002

		return var_2_10002.detect(arg_48_0.cells, function(arg_49_0)
			return arg_49_0:IsSame(arg_48_1)
		end)
	end

	function var_37_0.GetAroundCells(arg_50_0, arg_50_1)
		local var_50_0 = {}
		local var_50_1 = arg_50_1
		local var_50_2 = arg_50_1.GetPosition(var_50_1)
		local var_50_3 = {}

		Vector2 = var_50_1
		var_50_3[1] = var_50_1(var_50_2.x + 1, var_50_2.y)
		Vector2 = var_5
		var_50_3[2] = var_5(var_50_2.x - 1, var_50_2.y)
		Vector2 = var_5
		var_50_3[3] = var_5(var_50_2.x, var_50_2.y - 1)
		Vector2 = var_5
		var_50_3[4] = var_5(var_50_2.x, var_50_2.y + 1)
		Vector2 = var_5
		var_50_3[5] = var_5(var_50_2.x - 1, var_50_2.y - 1)
		Vector2 = var_5
		var_50_3[6] = var_5(var_50_2.x + 1, var_50_2.y + 1)
		Vector2 = var_5
		var_50_3[7] = var_5(var_50_2.x + 1, var_50_2.y - 1)
		Vector2 = var_5
		var_50_3[8] = var_5(var_50_2.x - 1, var_50_2.y + 1)
		Vector2 = var_5
		var_50_3[9] = var_5(var_50_2.x, var_50_2.y)
		_ = var_5

		var_5.each(var_50_3, function(arg_51_0)
			local var_51_0 = arg_50_0

			if var_1.GetCellByPosition(var_51_0, arg_51_0) then
				table = var_3_10002

				var_3_10002.insert(var_50_0, var_1)
			end

			return
		end)

		return var_50_0
	end

	function var_37_0.inProcess(arg_52_0)
		return arg_52_0.started
	end

	function var_37_0.Start(arg_53_0)
		arg_53_0.started = true

		return
	end

	function var_37_0.Reverse(arg_54_0, arg_54_1)
		local var_54_0 = #arg_54_0.primaryCells
		local var_54_1 = 0

		_ = var_2_10004

		var_2_10004.each(arg_54_0.primaryCells, function(arg_55_0)
			arg_55_0:SetAnimDoneCallback(function()
				var_54_1 = var_54_1 + 1

				if var_54_1 == var_54_0 then
					arg_54_1()
				end

				local var_56_0 = arg_55_0

				var_0.SetAnimDoneCallback(var_56_0, nil)

				return
			end)
			arg_55_0:Reverse()

			return
		end)

		return
	end

	function var_37_0.Primary(arg_57_0, arg_57_1)
		if arg_57_0.isStartReverse then
			return
		end

		local function var_57_0()
			_ = var_3_10000

			local var_58_0 = var_3_10000.each
			local var_58_1

			if not arg_57_0.primaryCells then
				var_58_1 = {}
			end

			var_58_0(var_58_1, function(arg_59_0)
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

				local var_60_0 = arg_57_0

				var_0.UpdateTurnCnt(var_60_0, arg_57_0.calcStep - 1)

				arg_57_0.isStartReverse = false

				return
			end)

			return
		end

		arg_57_0.primaryCell = arg_57_1

		var_57_0()

		arg_57_0.primaryCells = arg_57_0:GetAroundCells(arg_57_1)
		_ = var_3

		var_3.each(arg_57_0.primaryCells, function(arg_61_0)
			arg_61_0:Check()

			return
		end)

		return
	end

	function var_37_0.ReStart(arg_62_0)
		arg_62_0:Notify(var_0_7)

		local var_62_0

		if #var_0_18[arg_62_0.id].map == 0 then
			var_62_0 = arg_62_0:GenRandomMap()
		else
			var_62_0 = var_0_18[arg_62_0.id].map
		end

		arg_62_0:CreatNewMap(var_62_0)
		arg_62_0:UpdateTurnCnt(arg_62_0.maxCount)

		arg_62_0.started = false

		return
	end

	function var_37_0.Serialize(arg_63_0)
		if not arg_63_0.isInited then
			return ""
		end

		local var_63_0 = "{"

		_ = var_2_10002

		var_2_10002.each(arg_63_0.cells, function(arg_64_0)
			var_63_0 = var_63_0 .. arg_64_0:Serialize() .. ","

			return
		end)

		return var_63_0 .. "}#" .. arg_63_0.calcStep .. "#" .. (arg_63_0.started and "1" or "0")
	end

	function var_37_0.Dispose(arg_65_0)
		_ = var_2_10001

		var_2_10001.each(arg_65_0.cells, function(arg_66_0)
			arg_66_0:Dispose()

			return
		end)

		arg_65_0.started = false

		return
	end

	setmetatable = var_2

	return var_2(var_37_0, {
		__index = var_0_23(var_37_0)
	})
end

local function var_0_26(arg_67_0, arg_67_1)
	local var_67_0 = {}

	local function var_67_1(arg_68_0, arg_68_1, arg_68_2)
		if arg_68_2.anim then
			local var_68_0 = arg_68_0.dftAniEvent

			var_3.SetEndEvent(var_68_0, function()
				local var_69_0 = arg_68_0.dftAniEvent

				var_0.SetEndEvent(var_69_0, nil)

				local var_69_1 = arg_68_0.cell

				var_0.OnAnimDone(var_69_1)

				return
			end)

			local var_68_1 = arg_68_0.animation

			var_3.Stop(var_68_1)

			local var_68_2 = arg_68_0:GetAnimationKey(arg_68_2.type)
			local var_68_3 = arg_68_0.animation

			var_4.Play(var_68_3, var_68_2)
		else
			local var_68_4 = var_0_12[arg_68_2.type]

			arg_68_0.img.color = var_68_4
		end

		return
	end

	function var_67_0.onCellTypeChanged(arg_70_0, arg_70_1)
		var_67_1(var_67_0, arg_70_0, arg_70_1)

		return
	end

	local function var_67_2(arg_71_0, arg_71_1, arg_71_2)
		if arg_71_2 then
			local var_71_0 = arg_71_0.animation

			var_3.Stop(var_71_0)

			local var_71_1 = arg_71_0.animation

			var_3.Play(var_71_1, "blink")
		else
			arg_71_0:ResetAlhpa()

			local var_71_2 = arg_71_0.animation

			var_3.Stop(var_71_2, "blink")
		end

		return
	end

	function var_67_0.onCellCheckChanged(arg_72_0, arg_72_1)
		var_67_2(var_67_0, arg_72_0, arg_72_1)

		return
	end

	local function var_67_3(arg_73_0)
		arg_73_0.maxSpriteIndexX = #var_0_19
		arg_73_0.maxSpriteIndexY = #var_0_19[#var_0_19]
		arg_73_0.cell = arg_67_1
		arg_73_0._tf = arg_67_0

		local var_73_0 = arg_73_0._tf

		arg_73_0.cellImage = var_1.Find(var_73_0, "image")

		local var_73_1 = arg_73_0.cellImage

		arg_73_0.checkTF = var_1.Find(var_73_1, "check")

		local var_73_2 = arg_73_0.cellImage
		local var_73_3 = var_1.GetComponent

		typeof = var_4
		DftAniEvent = var_2_10006
		arg_73_0.dftAniEvent = var_73_3(var_73_2, var_4(var_2_10006))

		local var_73_4 = arg_73_0.cellImage
		local var_73_5 = var_1.GetComponent

		typeof = var_4
		Animation = var_2_10006
		arg_73_0.animation = var_73_5(var_73_4, var_4(var_2_10006))

		local var_73_6 = arg_73_0.animation

		var_1.Stop(var_73_6)

		local var_73_7 = arg_73_0.cellImage
		local var_73_8 = var_1.GetComponent

		typeof = var_4
		Image = var_2_10006
		arg_73_0.img = var_73_8(var_73_7, var_4(var_2_10006))
		arg_73_0.width = arg_73_0._tf.sizeDelta.x
		arg_73_0.height = arg_73_0._tf.sizeDelta.y
		arg_73_0.offsetX = 2
		arg_73_0.offsetY = 0

		arg_73_0:AddListener()

		local var_73_9 = arg_73_0.img
		local var_73_10 = var_0_12
		local var_73_11 = arg_73_0.cell

		var_73_9.color = var_73_10[var_3.GetType(var_73_11)]

		local var_73_12 = arg_73_0.img
		local var_73_13 = arg_73_0

		var_73_12.sprite = arg_73_0.GetSprite(var_73_13)

		local var_73_14 = arg_73_0.img

		var_1.SetNativeSize(var_73_14)

		setAnchoredPosition = var_1

		local var_73_15 = arg_73_0.cellImage

		Vector2 = var_73_13

		var_1(var_73_15, var_73_13(arg_73_0.cellImage.sizeDelta.x / 2, -arg_73_0.cellImage.sizeDelta.y / 2))
		arg_73_0:SetScale()
		arg_73_0:SetPosition()

		return
	end

	function var_67_0.SetCheck(arg_74_0, arg_74_1)
		setActive = var_2_10002

		var_2_10002(arg_74_0.checkTF, arg_74_1)

		return
	end

	function var_67_0.GetSprite(arg_75_0)
		local var_75_0 = arg_75_0.cell.x
		local var_75_1 = var_1.y

		if var_75_0 > arg_75_0.maxSpriteIndexX and var_1.x % arg_75_0.maxSpriteIndexX == 0 then
			var_75_0 = 0
		elseif var_75_0 > arg_75_0.maxSpriteIndexX then
			var_75_0 = arg_75_0.maxSpriteIndexX - var_1.x % arg_75_0.maxSpriteIndexX
		end

		if var_75_1 > arg_75_0.maxSpriteIndexY then
			var_75_1 = arg_75_0.maxSpriteIndexY - var_75_1 % (arg_75_0.maxSpriteIndexY + 1)
		end

		return var_0_19[var_75_0][var_75_1]
	end

	function var_67_0.GetAnimationKey(arg_76_0, arg_76_1)
		local var_76_0 = ""

		if arg_76_1 == var_0_10 then
			var_76_0 = "b2w"
		elseif arg_76_1 == var_0_11 then
			var_76_0 = "w2b"
		end

		return var_76_0
	end

	function var_67_0.SetScale(arg_77_0)
		local var_77_0 = arg_77_0.cell.x / arg_77_0.maxSpriteIndexX > 1 and -1 or 1
		local var_77_1 = var_1.y / arg_77_0.maxSpriteIndexY > 1 and -1 or 1
		local var_77_2 = arg_77_0.cellImage

		Vector3 = var_2_10005
		var_77_2.localScale = var_2_10005(var_77_0, var_77_1, 1)

		local var_77_3 = arg_77_0.cellImage.anchoredPosition

		setAnchoredPosition = var_5

		local var_77_4 = arg_77_0.cellImage

		Vector2 = var_8

		var_5(var_77_4, var_8(var_77_3.x * var_77_0, var_77_3.y * var_77_1))

		return
	end

	function var_67_0.ResetAlhpa(arg_78_0)
		local var_78_0 = arg_78_0.img.color
		local var_78_1 = arg_78_0.img

		Color = var_2_10003
		var_78_1.color = var_2_10003.New(var_78_0.r, var_78_0.g, var_78_0.b, 1)

		return
	end

	function var_67_0.SetPosition(arg_79_0)
		local var_79_0 = arg_79_0.cell
		local var_79_1 = var_1.GetPosition(var_79_0)

		go = var_2_10002
		var_2_10002(arg_79_0._tf).name = var_79_1.x .. "_" .. var_79_1.y

		local var_79_2 = arg_79_0.width
		local var_79_3 = arg_79_0.height

		if var_79_1.x > arg_79_0.maxSpriteIndexX then
			var_79_2 = arg_79_0.width - arg_79_0.offsetX
		end

		if var_79_1.y > arg_79_0.maxSpriteIndexY then
			var_79_3 = arg_79_0.height - arg_79_0.offsetY
		end

		local var_79_4 = var_79_1.x * var_79_2
		local var_79_5 = var_79_1.y * var_79_3
		local var_79_6 = arg_79_0._tf

		Vector3 = var_2_10007
		var_79_6.localPosition = var_2_10007(var_79_4, -var_79_5, 0)

		local var_79_7 = arg_79_0.cellImage.localScale.x
		local var_79_8 = arg_79_0.cellImage.localScale.y

		if var_79_7 == -1 and var_79_8 == -1 then
			Vector2 = var_2_10008
			var_2_10008 = var_2_10008(1, 0)
			Vector2 = anchorMax
			var_2_10008 = var_2_10008(1, 0)
			var_2_10008 = anchorMin
		elseif var_79_7 == 1 and var_79_8 == -1 then
			Vector2 = var_2_10008
			var_2_10008 = var_2_10008(0, 0)
			Vector2 = anchorMax
			var_2_10008 = var_2_10008(0, 0)
			var_2_10008 = anchorMin
		elseif var_79_7 == -1 and var_79_8 == 1 then
			Vector2 = var_2_10008
			var_2_10008 = var_2_10008(1, 1)
			Vector2 = anchorMax
			var_2_10008 = var_2_10008(1, 1)
			var_2_10008 = anchorMin
		else
			Vector2 = var_2_10008

			local var_79_9 = var_2_10008(0, 1)

			Vector2 = anchorMax

			local var_79_10 = var_8(0, 1)
			local var_79_11 = anchorMin
		end

		local var_79_12 = arg_79_0.cellImage

		anchorMax = var_9
		var_79_12.anchorMax = var_9

		local var_79_13 = arg_79_0.cellImage

		anchorMin = var_9
		var_79_13.anchorMin = var_9

		return
	end

	function var_67_0.AddListener(arg_80_0)
		local var_80_0 = arg_80_0.cell

		var_1.AddListener(var_80_0, var_0_4, arg_80_0.onCellTypeChanged)

		local var_80_1 = arg_80_0.cell

		var_1.AddListener(var_80_1, var_0_5, arg_80_0.onCellCheckChanged)

		return
	end

	function var_67_0.RemoveListener(arg_81_0)
		local var_81_0 = arg_81_0.cell

		var_1.RemoveListener(var_81_0, var_0_4, arg_81_0.onCellTypeChanged)

		local var_81_1 = arg_81_0.cell

		var_1.RemoveListener(var_81_1, var_0_5, arg_81_0.onCellCheckChanged)

		return
	end

	function var_67_0.Dispose(arg_82_0)
		arg_82_0:ResetAlhpa()

		local var_82_0 = arg_82_0.animation

		var_1.Stop(var_82_0)

		local var_82_1 = arg_82_0._tf

		Vector3 = var_2_10002
		var_82_1.localPosition = var_2_10002(0, 0, 0)

		local var_82_2 = arg_82_0._tf

		Vector3 = var_2
		var_82_2.localScale = var_2(1, 1, 1)

		local var_82_3 = arg_82_0.cellImage

		Vector3 = var_2
		var_82_3.localPosition = var_2(0, 0, 0)

		local var_82_4 = arg_82_0.cellImage

		Vector3 = var_2
		var_82_4.localScale = var_2(1, 1, 1)
		arg_82_0.img.sprite = nil
		arg_82_0.img.color = var_0_12[1]

		arg_82_0:RemoveListener()

		removeOnButton = var_1

		var_1(arg_82_0._tf)

		setActive = var_1

		var_1(arg_82_0.checkTF, false)

		return
	end

	var_67_3(var_67_0)

	return var_67_0
end

local function var_0_27(arg_83_0, arg_83_1, arg_83_2)
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
		local var_87_0 = arg_87_0
		local var_87_1 = arg_87_0.GetCellTpl(var_87_0, arg_87_2).transform

		setParent = var_2_10004

		var_2_10004(var_87_1, arg_87_0.cellContainer)

		local var_87_2 = var_0_26(var_87_1, arg_87_2)

		table = var_87_0

		var_87_0.insert(arg_87_0.cells, var_87_2)

		onButton = var_5

		local var_87_3
		local var_87_4 = var_87_1

		local function var_87_5()
			if arg_87_0.tipCellView then
				local var_88_0 = arg_87_0.tipCellView

				var_0.SetCheck(var_88_0, false)

				arg_87_0.tipCellView = nil
			end

			if arg_87_0.map.calcStep == 0 then
				local var_88_1 = arg_87_0

				var_0.ResetMap(var_88_1)

				return
			end

			if not arg_87_0.map.primaryCell or arg_87_0.map.primaryCell and arg_87_0.map.primaryCell ~= arg_87_2 then
				local var_88_2 = arg_87_0

				var_0.AddTipTimer(var_88_2)
			else
				local var_88_3 = arg_87_0

				var_0.StopTipTimer(var_88_3)
			end

			local var_88_4 = arg_87_0.map

			var_0.Primary(var_88_4, arg_87_2)

			return
		end

		SFX_PANEL = var_2_10010

		var_5(var_87_3, var_87_4, var_87_5, var_2_10010)

		return
	end

	function var_83_0.onCellCreate(arg_89_0, arg_89_1)
		var_83_1(var_83_0, arg_89_0, arg_89_1)

		return
	end

	local function var_83_2(arg_90_0, arg_90_1, arg_90_2)
		arg_90_0.leftCountTxt.text = arg_90_2

		local var_90_0 = arg_90_0.map
		local var_90_1 = var_3.CalcScore(var_90_0)

		if arg_90_2 == 0 then
			if not arg_90_0.map.isFinished then
				arg_90_0.onFirstFinished(arg_90_0.map.id, var_90_1)

				arg_90_0.highestScoreTxt.text = var_90_1
			end

			arg_90_0.onShowResult(arg_90_0.map.id, var_90_1, function()
				local var_91_0 = arg_90_0

				var_0.Reset(var_91_0)

				return
			end)

			arg_90_0.currScoreTxt.text = "-"
		else
			arg_90_0.currScoreTxt.text = var_90_1
		end

		return
	end

	function var_83_0.onTurnCntUpdated(arg_92_0, arg_92_1)
		var_83_2(var_83_0, arg_92_0, arg_92_1)

		return
	end

	local function var_83_3(arg_93_0, arg_93_1, arg_93_2)
		arg_93_0.highestScoreTxt.text = arg_93_2

		arg_93_0.onHighestScore(arg_93_0.map.id, arg_93_2)

		return
	end

	function var_83_0.onHighestUpdated(arg_94_0, arg_94_1)
		var_83_3(var_83_0, arg_94_0, arg_94_1)

		return
	end

	local function var_83_4(arg_95_0, arg_95_1)
		ipairs = var_2_10002

		for iter_95_0, iter_95_1 in var_2_10002(arg_95_0.cells) do
			iter_95_1:Dispose()

			local var_95_0 = iter_95_1.cell
			local var_95_1 = var_7.GetType(var_95_0)
			local var_95_2 = arg_95_0.poolMgr

			var_8.Return(var_95_2, var_95_1, iter_95_1._tf.gameObject)
		end

		arg_95_0.cells = {}

		return
	end

	function var_83_0.onDestoryCells(arg_96_0)
		var_83_4(var_83_0, arg_96_0)

		return
	end

	local function var_83_5(arg_97_0, arg_97_1, arg_97_2)
		_ = var_2_10003

		if var_2_10003.detect(arg_97_0.cells, function(arg_98_0)
			local var_98_0 = arg_98_0.cell

			return var_1.IsSame(var_98_0, arg_97_2)
		end) then
			arg_97_0.tipCellView = var_3

			var_3:SetCheck(true)
		end

		return
	end

	function var_83_0.onCellTip(arg_99_0, arg_99_1)
		var_83_5(var_83_0, arg_99_0, arg_99_1)

		return
	end

	local function var_83_6(arg_100_0, arg_100_1)
		arg_100_0.highestScoreTxt.text = arg_100_0.map.highestScore
		arg_100_0.leftCountTxt.text = arg_100_0.map.calcStep

		local var_100_0 = arg_100_0.map
		local var_100_1 = var_2.CalcScore(var_100_0)
		local var_100_2 = arg_100_0:ShouldShowStartBg()
		local var_100_3 = arg_100_0.currScoreTxt

		var_100_3.text = var_100_2 and "-" or var_100_1
		setActive = var_100_3

		var_100_3(arg_100_0.startBg, var_100_2)

		onButton = var_100_3

		var_100_3(nil, arg_100_0.startBg, function()
			if not arg_100_0.map.isUnlock then
				return
			end

			setActive = var_0

			var_0(arg_100_0.startBg, false)

			local var_101_0 = arg_100_0

			var_0.RecordStartBg(var_101_0)

			local var_101_1 = arg_100_0.currScoreTxt

			var_101_1.text = var_100_1
			setActive = var_101_1

			var_101_1(arg_100_0.cellContainer, true)

			local var_101_2 = arg_100_0.map

			var_0.Start(var_101_2)

			return
		end)

		if not var_100_2 then
			setActive = var_100_3

			var_100_3(arg_100_0.cellContainer, true)
		end

		return
	end

	function var_83_0.onMapInitDone(arg_102_0)
		var_83_6(var_83_0, arg_102_0)

		return
	end

	local function var_83_7(arg_103_0)
		arg_103_0._tf = arg_83_0

		local var_103_0 = arg_103_0._tf

		arg_103_0.cellWhite = var_1.Find(var_103_0, "cell")

		local var_103_1 = arg_103_0._tf

		arg_103_0.cellContainer = var_1.Find(var_103_1, "container")

		local var_103_2 = arg_103_0._tf

		arg_103_0.restartBtn = var_1.Find(var_103_2, "restart")

		local var_103_3 = arg_103_0._tf
		local var_103_4 = var_1.Find(var_103_3, "left_count")
		local var_103_5 = var_1.GetComponent

		typeof = var_4
		Text = var_2_10006
		arg_103_0.leftCountTxt = var_103_5(var_103_4, var_4(var_2_10006))

		local var_103_6 = arg_103_0._tf
		local var_103_7 = var_1.Find(var_103_6, "highest")
		local var_103_8 = var_1.GetComponent

		typeof = var_4
		Text = var_2_10006
		arg_103_0.highestScoreTxt = var_103_8(var_103_7, var_4(var_2_10006))

		local var_103_9 = arg_103_0._tf
		local var_103_10 = var_1.Find(var_103_9, "curr_score")
		local var_103_11 = var_1.GetComponent

		typeof = var_4
		Text = var_2_10006
		arg_103_0.currScoreTxt = var_103_11(var_103_10, var_4(var_2_10006))

		local var_103_12 = arg_103_0._tf

		arg_103_0.startBg = var_1.Find(var_103_12, "start_bg")

		local var_103_13 = arg_103_0.startBg
		local var_103_14 = var_1.Find(var_103_13, "Text")
		local var_103_15 = var_1.GetComponent

		typeof = var_4
		Text = var_2_10006
		arg_103_0.startBgText = var_103_15(var_103_14, var_4(var_2_10006))

		local var_103_16 = arg_103_0.startBg

		arg_103_0.startLabel = var_1.Find(var_103_16, "Image")
		arg_103_0.map = arg_83_1
		arg_103_0.cells = {}

		arg_103_0:AddListener()

		local var_103_17 = arg_103_0.startBgText

		var_103_17.text = arg_103_0.map.isUnlock and "" or arg_103_0.map.condition
		setActive = var_103_17

		var_103_17(arg_103_0.startLabel, arg_103_0.map.isUnlock)

		setActive = var_103_17

		var_103_17(arg_103_0.cellContainer, false)

		onButton = var_103_17

		local var_103_18
		local var_103_19 = arg_103_0.restartBtn

		local function var_103_20()
			local var_104_0 = arg_103_0

			var_0.ResetMap(var_104_0)

			return
		end

		SFX_PANEL = var_2_10006

		var_103_17(var_103_18, var_103_19, var_103_20, var_2_10006)

		return
	end

	function var_83_0.Reset(arg_105_0)
		local var_105_0 = arg_105_0.map

		var_1.ReStart(var_105_0)

		setActive = var_1

		var_1(arg_105_0.startBg, true)

		setActive = var_1

		var_1(arg_105_0.cellContainer, false)

		arg_105_0.currScoreTxt.text = "-"

		return
	end

	function var_83_0.ResetMap(arg_106_0)
		if arg_106_0.map.calcStep == arg_106_0.map.maxCount then
			return
		end

		pg = var_1

		local var_106_0 = var_1.MsgboxMgr.GetInstance()
		local var_106_1 = var_1.ShowMsgBox
		local var_106_2 = {}

		i18n = var_2_10005
		var_106_2.content = var_2_10005("black_white_grid_reset")

		function var_106_2.onYes()
			local var_107_0 = arg_106_0

			var_0.Reset(var_107_0)

			return
		end

		var_106_1(var_106_0, var_106_2)

		return
	end

	function var_83_0.AddTipTimer(arg_108_0)
		if arg_108_0.timer then
			local var_108_0 = arg_108_0.timer

			var_1.Stop(var_108_0)
		end

		Timer = var_1
		arg_108_0.timer = var_1.New(function()
			local var_109_0 = arg_108_0.map

			if var_0.NeedTip(var_109_0) then
				local var_109_1 = arg_108_0.map

				var_0.TriggerTip(var_109_1)
			end

			return
		end, var_0_15, 1)

		local var_108_1 = arg_108_0.timer

		var_1.Start(var_108_1)

		return
	end

	function var_83_0.StopTipTimer(arg_110_0)
		if arg_110_0.timer then
			local var_110_0 = arg_110_0.timer

			var_1.Stop(var_110_0)

			arg_110_0.timer = nil
		end

		return
	end

	function var_83_0.ShouldShowStartBg(arg_111_0)
		local var_111_0 = arg_111_0.map

		return not var_1.inProcess(var_111_0)
	end

	function var_83_0.RecordStartBg(arg_112_0)
		return
	end

	function var_83_0.GetCellTpl(arg_113_0, arg_113_1)
		local var_113_0 = arg_113_0.poolMgr

		return var_2.Get(var_113_0, arg_113_1:GetCellColorStr())
	end

	function var_83_0.AddListener(arg_114_0)
		local var_114_0 = arg_114_0.map

		var_1.AddListener(var_114_0, var_0_2, arg_114_0.onCellCreate)

		local var_114_1 = arg_114_0.map

		var_1.AddListener(var_114_1, var_0_3, arg_114_0.onTurnCntUpdated)

		local var_114_2 = arg_114_0.map

		var_1.AddListener(var_114_2, var_0_6, arg_114_0.onHighestUpdated)

		local var_114_3 = arg_114_0.map

		var_1.AddListener(var_114_3, var_0_7, arg_114_0.onDestoryCells)

		local var_114_4 = arg_114_0.map

		var_1.AddListener(var_114_4, var_0_8, arg_114_0.onCellTip)

		local var_114_5 = arg_114_0.map

		var_1.AddListener(var_114_5, var_0_9, arg_114_0.onMapInitDone)

		return
	end

	function var_83_0.RemoveListener(arg_115_0)
		local var_115_0 = arg_115_0.map

		var_1.RemoveListener(var_115_0, var_0_2, arg_115_0.onCellCreate)

		local var_115_1 = arg_115_0.map

		var_1.RemoveListener(var_115_1, var_0_3, arg_115_0.onTurnCntUpdated)

		local var_115_2 = arg_115_0.map

		var_1.RemoveListener(var_115_2, var_0_6, arg_115_0.onHighestUpdated)

		local var_115_3 = arg_115_0.map

		var_1.RemoveListener(var_115_3, var_0_7, arg_115_0.onDestoryCells)

		local var_115_4 = arg_115_0.map

		var_1.RemoveListener(var_115_4, var_0_8, arg_115_0.onCellTip)

		local var_115_5 = arg_115_0.map

		var_1.RemoveListener(var_115_5, var_0_9, arg_115_0.onMapInitDone)

		return
	end

	function var_83_0.Dispose(arg_116_0)
		local var_116_0 = arg_116_0.map

		var_1.Dispose(var_116_0)

		removeOnButton = var_1

		var_1(arg_116_0.restartBtn)
		arg_116_0:RemoveListener()
		var_83_4(arg_116_0, nil)
		arg_116_0:StopTipTimer()

		arg_116_0.tipCellView = nil

		return
	end

	var_83_7(var_83_0)

	return var_83_0
end

local function var_0_28(arg_117_0)
	local var_117_0 = {
		_tf = arg_117_0
	}

	local function var_117_1(arg_118_0)
		setActive = var_2_10001

		var_2_10001(arg_118_0._tf, false)

		local var_118_0 = arg_118_0._tf
		local var_118_1 = var_1.Find(var_118_0, "score/Text")
		local var_118_2 = var_1.GetComponent

		typeof = var_4
		Text = var_2_10006
		arg_118_0.scoreTxt = var_118_2(var_118_1, var_4(var_2_10006))
		onButton = var_1

		local var_118_3
		local var_118_4 = arg_118_0._tf

		local function var_118_5()
			local var_119_0 = arg_118_0

			var_0.Hide(var_119_0)

			return
		end

		SFX_PANEL = var_2_10006

		var_1(var_118_3, var_118_4, var_118_5, var_2_10006)

		return
	end

	function var_117_0.Show(arg_120_0, arg_120_1, arg_120_2)
		setActive = var_2_10003

		var_2_10003(arg_120_0._tf, true)

		arg_120_0.scoreTxt.text = arg_120_1
		arg_120_0.cb = arg_120_2

		return
	end

	function var_117_0.Hide(arg_121_0)
		if arg_121_0.cb then
			arg_121_0.cb()
		end

		setActive = var_1

		var_1(arg_121_0._tf, false)

		arg_121_0.scoreTxt.text = ""
		arg_121_0.cb = nil

		return
	end

	function var_117_0.Dispose(arg_122_0)
		arg_122_0:Hide()

		return
	end

	var_117_1(var_117_0)

	return var_117_0
end

function var_0_1.getUIName(arg_123_0)
	return "BlackWhiteGridUI"
end

function var_0_1.preload(arg_124_0, arg_124_1)
	local var_124_0 = {}

	for iter_124_0 = 0, 4 do
		for iter_124_1 = 0, 2 do
			table = var_1_10011

			var_1_10011.insert(var_124_0, iter_124_0 .. "_" .. iter_124_1)
		end
	end

	var_0_19 = {}
	AssetBundleHelper = var_3

	var_3.LoadManyAssets("ui/blackwhitegrid_atlas", var_124_0, nil, true, function(arg_125_0)
		for iter_125_0 = 0, 4 do
			var_0_19[iter_125_0] = {}

			for iter_125_1 = 0, 2 do
				var_0_19[iter_125_0][iter_125_1] = arg_125_0[iter_125_0 .. "_" .. iter_125_1]
			end
		end

		return
	end, true)

	arg_124_0.bgSprite = nil
	LoadSpriteAsync = var_3

	var_3("clutter/blackwhite_bg", function(arg_126_0)
		arg_124_0.bgSprite = arg_126_0

		arg_124_1()

		return
	end)

	return
end

function var_0_1.setActivity(arg_127_0, arg_127_1)
	arg_127_0.activityVO = arg_127_1
	arg_127_0.passIds = arg_127_1.data1_list
	arg_127_0.scores = arg_127_1.data2_list

	arg_127_0:updateFur()

	return
end

function var_0_1.setPlayer(arg_128_0, arg_128_1)
	arg_128_0.player = arg_128_1

	return
end

function var_0_1.init(arg_129_0)
	local var_129_0 = arg_129_0._tf

	arg_129_0.mapTF = var_1.Find(var_129_0, "map")

	local var_129_1 = arg_129_0._tf

	arg_129_0.backBtn = var_1.Find(var_129_1, "back")

	local var_129_2 = arg_129_0._tf

	arg_129_0.toggleTFs = var_1.Find(var_129_2, "toggles")

	local var_129_3 = var_0_22
	local var_129_4 = arg_129_0.mapTF

	arg_129_0.poolMgr = var_129_3(var_3.Find(var_129_4, "root"))

	local var_129_5 = var_0_28
	local var_129_6 = arg_129_0._tf

	arg_129_0.successMsgbox = var_129_5(var_3.Find(var_129_6, "success_bg"))

	local var_129_7 = var_0_28
	local var_129_8 = arg_129_0._tf

	arg_129_0.failedMsgbox = var_129_7(var_3.Find(var_129_8, "failed_bg"))

	local var_129_9 = arg_129_0._tf

	arg_129_0.furGot = var_1.Find(var_129_9, "fur/got")

	local var_129_10 = arg_129_0._tf

	arg_129_0.helpBtn = var_1.Find(var_129_10, "help")

	local var_129_11 = arg_129_0._tf
	local var_129_12 = var_1.GetComponent

	typeof = var_4
	Image = var_6
	var_129_12(var_129_11, var_4(var_6)).sprite = arg_129_0.bgSprite

	return
end

function var_0_1.didEnter(arg_130_0)
	onButton = var_1_10001

	local var_130_0 = arg_130_0
	local var_130_1 = arg_130_0.backBtn

	local function var_130_2()
		local var_131_0 = arg_130_0

		var_0.emit(var_131_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_130_0, var_130_1, var_130_2, var_1_10006)

	onButton = var_1_10001

	local var_130_3 = arg_130_0
	local var_130_4 = arg_130_0.helpBtn

	local function var_130_5()
		pg = var_2_10000

		local var_132_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_132_1 = var_0.ShowMsgBox
		local var_132_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_132_2.type = var_2_10004
		pg = var_2_10004
		var_132_2.helps = var_2_10004.gametip.black_white_grid_notice.tip

		var_132_1(var_132_0, var_132_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_130_3, var_130_4, var_130_5, var_1_10006)

	local var_130_6 = arg_130_0.activityVO

	arg_130_0.selecteds = {}

	local function var_130_7(arg_133_0)
		eachChild = var_2_10001

		var_2_10001(arg_133_0, function(arg_134_0)
			go = var_3_10001

			if var_3_10001(arg_134_0).name ~= "text" then
				go = var_1

				if var_1(arg_134_0).activeSelf then
					local var_134_0 = arg_134_0
					local var_134_1 = arg_134_0.GetComponent

					typeof = var_3_10004
					Image = var_3_10006

					local var_134_2 = var_134_1(var_134_0, var_3_10004(var_3_10006))

					var_134_2.color = var_0_14
					table = var_2

					var_2.insert(arg_130_0.selecteds, var_134_2)
				end
			end

			return
		end)

		return
	end

	local function var_130_8()
		ipairs = var_2_10000

		for iter_135_0, iter_135_1 in var_2_10000(arg_130_0.selecteds) do
			Color = var_2_10005
			iter_135_1.color = var_2_10005.New(1, 1, 1, 1)
		end

		arg_130_0.selecteds = {}

		return
	end

	arg_130_0.btns = {}
	arg_130_0.maps = {}
	ipairs = var_4

	for iter_130_0, iter_130_1 in var_4(var_130_6:getConfig("config_data")) do
		local var_130_9 = var_0_18[iter_130_1]
		local var_130_10 = arg_130_0.toggleTFs
		local var_130_11 = var_10.GetChild(var_130_10, iter_130_0 - 1)
		local var_130_12 = arg_130_0.maps

		var_130_12[iter_130_1] = arg_130_0:GetMapVO(var_130_9)
		onButton = var_130_12

		local var_130_13 = arg_130_0
		local var_130_14 = var_130_11

		local function var_130_15()
			if arg_130_0.id == iter_130_1 then
				return
			end

			if arg_130_0.mapView then
				local var_136_0 = arg_130_0.mapView.map

				if var_0.inProcess(var_136_0) then
					pg = var_0

					local var_136_1 = var_0.TipsMgr.GetInstance()
					local var_136_2 = var_0.ShowTips

					i18n = var_2_10003

					var_136_2(var_136_1, var_2_10003("black_white_grid_switch_tip"))

					return
				end
			end

			arg_130_0.id = iter_130_1

			local var_136_3 = arg_130_0
			local var_136_4 = var_0.GetMapVO(var_136_3, var_130_9)
			local var_136_5 = arg_130_0

			var_1.loadMap(var_136_5, var_136_4)

			if #arg_130_0.selecteds > 0 then
				var_130_8()
			end

			var_130_7(var_130_11)

			return
		end

		SFX_PANEL = var_1_10016

		var_130_12(var_130_13, var_130_14, var_130_15, var_1_10016)

		arg_130_0.btns[iter_130_1] = var_130_11
	end

	if arg_130_0:GetLastestUnlockMap() then
		triggerButton = var_5

		var_5(var_4)
	end

	arg_130_0:updateBtnsState()

	return
end

function var_0_1.updateFur(arg_137_0)
	if arg_137_0.furGot then
		local var_137_0 = arg_137_0.activityVO
		local var_137_1 = var_1[#var_1.getConfig(var_137_0, "config_data") - 1]

		setActive = var_137_0

		local var_137_2 = arg_137_0.furGot

		table = var_1_10006

		var_137_0(var_137_2, var_1_10006.contains(arg_137_0.passIds, var_137_1))
	end

	return
end

function var_0_1.isUnlock(arg_138_0, arg_138_1)
	local var_138_0 = arg_138_1.unlock[1]
	local var_138_1 = arg_138_1.unlock[2]

	getProxy = var_1_10004
	ChapterProxy = var_1_10006

	local var_138_2 = var_1_10004(var_1_10006)
	local var_138_3

	if var_4.getChapterById(var_138_2, var_138_1) and var_4:isUnlock() then
		var_138_3 = var_4:isAllAchieve()
	end

	local var_138_4

	if var_138_0 ~= 0 then
		table = var_138_2
		var_138_4 = var_138_2.contains(arg_138_0.passIds, var_138_0)

		if false then
			var_138_4 = false
		end
	else
		var_138_4 = true
	end

	return var_138_3 and var_138_4
end

function var_0_1.GetLastestUnlockMap(arg_139_0)
	local var_139_0 = arg_139_0:GetMapIndex()

	if arg_139_0.btns[var_139_0] then
		return arg_139_0.btns[var_139_0]
	else
		local var_139_1
		local var_139_2 = 0

		pairs = var_1_10004

		for iter_139_0, iter_139_1 in var_1_10004(arg_139_0.btns) do
			var_139_2 = var_139_2 + 1

			if arg_139_0:isUnlock(var_0_18[iter_139_0]) or var_139_2 == 1 then
				var_139_1 = iter_139_1
			end
		end

		return var_139_1
	end

	return
end

function var_0_1.updateBtnsState(arg_140_0)
	pairs = var_1_10001

	for iter_140_0, iter_140_1 in var_1_10001(arg_140_0.btns) do
		table = var_1_10006
		var_1_10006 = var_1_10006.contains(arg_140_0.passIds, iter_140_0)

		local var_140_0 = arg_140_0:isUnlock(var_0_18[iter_140_0])

		setActive = var_8

		var_8(iter_140_1:Find("finished"), var_1_10006)

		setActive = var_8

		var_8(iter_140_1:Find("locked"), not var_140_0)

		setActive = var_8

		var_8(iter_140_1:Find("opening"), not var_1_10006 and var_140_0)
	end

	return
end

function var_0_1.GetMapVO(arg_141_0, arg_141_1)
	local var_141_0

	table = var_1_10003

	local var_141_1 = var_1_10003.indexof(arg_141_0.passIds, arg_141_1.id)

	table = var_1_10004

	local var_141_2 = var_1_10004.contains(arg_141_0.passIds, arg_141_1.id)
	local var_141_3

	if not var_141_1 or not arg_141_0.scores[var_141_1] then
		var_141_3 = 0
	end

	local var_141_4 = {
		highestScore = var_141_3,
		isFinished = var_141_2,
		isUnlock = arg_141_0:isUnlock(arg_141_1)
	}

	if arg_141_0.maps[arg_141_1.id] then
		local var_141_5 = arg_141_0.maps[arg_141_1.id]

		var_141_0.UpdateData(var_141_5, var_141_4)
	else
		local var_141_6, var_141_7, var_141_8 = arg_141_0:parseMap(arg_141_1)
		local var_141_9 = {
			id = arg_141_1.id,
			maps = var_141_6,
			calcStep = var_141_7,
			maxCount = arg_141_1.num,
			condition = arg_141_1.condition,
			started = var_141_8
		}
		local var_141_10 = var_0_25(var_141_9)

		var_141_0.UpdateData(var_141_10, var_141_4)
	end

	return var_141_0
end

function var_0_1.parseMap(arg_142_0, arg_142_1)
	PlayerPrefs = var_1_10002

	if not var_1_10002.GetString("BlackWhiteGridMapData-" .. arg_142_1.id .. "-" .. arg_142_0.player.id, "") or var_2 == "" then
		return arg_142_1.map, arg_142_1.num, false
	else
		local var_142_0 = var_2:split("#")

		loadstring = var_4

		local var_142_1 = var_4("return " .. var_142_0[1])()

		tonumber = var_6

		return var_142_1, var_6(var_142_0[2]), var_142_0[3] == "1"
	end

	return
end

function var_0_1.SaveMapsData(arg_143_0)
	local var_143_0 = arg_143_0.maps

	ipairs = var_1_10002

	for iter_143_0, iter_143_1 in var_1_10002(var_143_0) do
		if iter_143_1:Serialize() and var_7 ~= "" then
			PlayerPrefs = var_1_10008

			var_1_10008.SetString("BlackWhiteGridMapData-" .. iter_143_1.id .. "-" .. arg_143_0.player.id, var_7)
		end
	end

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.GetMapIndex(arg_144_0)
	PlayerPrefs = var_1_10001

	return (var_1_10001.GetInt("BlackWhiteGridMapIndex-" .. arg_144_0.player.id, 1))
end

function var_0_1.SaveMapIndex(arg_145_0)
	local var_145_0

	if not arg_145_0.id then
		var_145_0 = 1
	end

	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("BlackWhiteGridMapIndex-" .. arg_145_0.player.id, var_145_0)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.loadMap(arg_146_0, arg_146_1)
	if arg_146_0.mapView then
		local var_146_0 = arg_146_0.mapView

		var_2.Dispose(var_146_0)
	end

	arg_146_0.mapView = var_0_27(arg_146_0.mapTF, arg_146_1, arg_146_0.poolMgr)

	function arg_146_0.mapView.onFirstFinished(arg_147_0, arg_147_1)
		local var_147_0 = arg_146_0
		local var_147_1 = var_2.emit

		BlackWhiteGridMediator = var_2_10005

		var_147_1(var_147_0, var_2_10005.ON_FINISH, arg_147_0, arg_147_1)

		return
	end

	function arg_146_0.mapView.onHighestScore(arg_148_0, arg_148_1)
		local var_148_0 = arg_146_0
		local var_148_1 = var_2.emit

		BlackWhiteGridMediator = var_2_10005

		var_148_1(var_148_0, var_2_10005.ON_UPDATE_SCORE, arg_148_0, arg_148_1)

		return
	end

	function arg_146_0.mapView.onShowResult(arg_149_0, arg_149_1, arg_149_2)
		if arg_149_1 >= 0 then
			local var_149_0 = arg_146_0.successMsgbox

			var_3.Show(var_149_0, arg_149_1, arg_149_2)
		else
			local var_149_1 = arg_146_0.failedMsgbox

			var_3.Show(var_149_1, arg_149_1, arg_149_2)
		end

		return
	end

	arg_146_1:Init()

	return
end

function var_0_1.playStory(arg_150_0, arg_150_1)
	if var_0_18[arg_150_0.mapView.map.id].story and var_2 ~= "" then
		pg = var_3

		local var_150_0 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_150_0, var_2, arg_150_1, true, true)
	else
		arg_150_1()
	end

	return
end

function var_0_1.willExit(arg_151_0)
	arg_151_0:SaveMapsData()
	arg_151_0:SaveMapIndex()

	if arg_151_0.mapView then
		local var_151_0 = arg_151_0.mapView

		var_1.Dispose(var_151_0)
	end

	local var_151_1 = arg_151_0.successMsgbox

	var_1.Dispose(var_151_1)

	local var_151_2 = arg_151_0.failedMsgbox

	var_1.Dispose(var_151_2)

	local var_151_3 = arg_151_0.poolMgr

	var_1.Dispose(var_151_3)

	var_0_19 = nil

	return
end

return var_0_1
