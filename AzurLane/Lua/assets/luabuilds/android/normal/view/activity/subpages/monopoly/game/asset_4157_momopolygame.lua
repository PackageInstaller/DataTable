class = var_0_10000

local var_0_0 = var_0_10000("MonopolyGame")

pg = var_1

local var_0_1 = var_1.activity_event_monopoly_map

pg = var_0_10002

local var_0_2 = var_0_10002.activity_event_monopoly_event
local var_0_3 = 501041
local var_0_4 = 501041
local var_0_5 = 6
local var_0_6 = 5
local var_0_7 = {}

var_0_7.stateGold = "dafuweng_gold"
var_0_7.stateOil = "dafuweng_oil"
var_0_7.stateEvent = "dafuweng_event"
var_0_7.stateWalk = "dafuweng_walk"
var_0_7.stateStand = "dafuweng_stand"
var_0_7.stateJump = "dafuweng_jump"
var_0_7.stateRun = "dafuweng_run"
var_0_7.stateTouch = "dafuweng_touch"

local var_0_8

local function var_0_9()
	local var_1_0 = {
		onActionUpdated = function(arg_2_0, arg_2_1)
			return
		end
	}

	var_1_0.currState = nil

	function var_1_0.ChangeState(arg_3_0, arg_3_1, arg_3_2)
		arg_3_2 = arg_3_2 or function()
			return
		end

		if arg_3_0.currState == arg_3_1 then
			arg_3_2()
		end

		arg_3_0.currState = arg_3_1

		arg_3_0.onActionUpdated(arg_3_1, arg_3_2)

		return
	end

	function var_1_0.IsStandState(arg_5_0)
		return arg_5_0.currState == var_0_7.stateStand
	end

	return var_1_0
end

local function var_0_10(arg_6_0)
	local var_6_0 = {
		onMove = function(arg_7_0, arg_7_1)
			return
		end,
		onJump = function(arg_8_0, arg_8_1)
			return
		end,
		onUpdatePos = function(arg_9_0)
			return
		end
	}

	Ship = var_2
	var_6_0.ship = var_2.New({
		configId = arg_6_0,
		skin_id = var_0_4
	})
	var_6_0.state = var_0_9()

	function var_6_0.Move(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		arg_10_2 = arg_10_2 or function()
			return
		end

		if #arg_10_1 == 0 then
			arg_10_2()

			return
		end

		local function var_10_0(arg_12_0)
			if arg_12_0 then
				local var_12_0 = arg_10_0.state

				var_1.ChangeState(var_12_0, var_0_7.stateWalk)
			else
				local var_12_1 = arg_10_0.state

				var_1.ChangeState(var_12_1, var_0_7.stateRun)
			end

			arg_10_0.onMove(arg_10_1, function()
				local var_13_0 = arg_10_0

				if var_0.GetAction(var_13_0, arg_10_1[#arg_10_1]) then
					local var_13_1 = arg_10_0.state

					var_1.ChangeState(var_13_1, var_0, function()
						local var_14_0 = arg_10_0.state

						var_0.ChangeState(var_14_0, var_0_7.stateStand)
						arg_10_2()

						return
					end)
				else
					local var_13_2 = arg_10_0.state

					var_1.ChangeState(var_13_2, var_0_7.stateStand)
					arg_10_2()
				end

				return
			end)

			return
		end

		if #arg_10_1 <= 3 and not arg_10_3 then
			arg_10_0:Jump(arg_10_1, arg_10_2)
		else
			var_10_0(arg_10_3)
		end

		return
	end

	function var_6_0.Jump(arg_15_0, arg_15_1, arg_15_2)
		arg_15_2 = arg_15_2 or function()
			return
		end

		if #arg_15_1 == 0 then
			arg_15_2()

			return
		end

		local var_15_0 = {}

		pairs = var_2_10004

		for iter_15_0, iter_15_1 in var_2_10004(arg_15_1) do
			table = var_2_10009

			var_2_10009.insert(var_15_0, function(arg_17_0)
				local var_17_0 = arg_15_0.state

				var_1.ChangeState(var_17_0, var_0_7.stateJump)
				arg_15_0.onJump(iter_15_1, function()
					local var_18_0 = arg_15_0.state

					var_0.ChangeState(var_18_0, var_0_7.stateStand)
					arg_17_0()

					return
				end)

				return
			end)
		end

		seriesAsync = var_4

		var_4(var_15_0, function()
			local var_19_0 = arg_15_0

			if var_0.GetAction(var_19_0, arg_15_1[#arg_15_1]) then
				local var_19_1 = arg_15_0.state

				var_1.ChangeState(var_19_1, var_0, function()
					local var_20_0 = arg_15_0.state

					var_0.ChangeState(var_20_0, var_0_7.stateStand)
					arg_15_2()

					return
				end)
			else
				local var_19_2 = arg_15_0.state

				var_1.ChangeState(var_19_2, var_0_7.stateStand)
				arg_15_2()
			end

			return
		end)

		return
	end

	function var_6_0.Touch(arg_21_0)
		local var_21_0 = arg_21_0.state

		if var_1.IsStandState(var_21_0) then
			local var_21_1 = arg_21_0.state

			var_1.ChangeState(var_21_1, var_0_7.stateTouch, function()
				local var_22_0 = arg_21_0.state

				var_0.ChangeState(var_22_0, var_0_7.stateStand)

				return
			end)
		end

		return
	end

	function var_6_0.GetAction(arg_23_0, arg_23_1)
		if arg_23_1.config.icon == "icon_1" then
			return var_0_7.stateEvent
		elseif var_2 == "icon_2" then
			return var_0_7.stateGold
		elseif var_2 == "icon_3" then
			-- block empty
		elseif var_2 == "icon_4" then
			return var_0_7.stateEvent
		elseif var_2 == "icon_5" then
			return var_0_7.stateOil
		elseif var_2 == "icon_6" then
			return var_0_7.stateEvent
		end

		return
	end

	function var_6_0.InitPos(arg_24_0, arg_24_1)
		arg_24_0:ChangePos(arg_24_1)

		local var_24_0 = arg_24_0.state

		var_2.ChangeState(var_24_0, var_0_7.stateStand)

		return
	end

	function var_6_0.ChangePos(arg_25_0, arg_25_1)
		assert = var_2_10002

		var_2_10002(arg_25_1)
		arg_25_0.onUpdatePos(arg_25_1)

		return
	end

	function var_6_0.Dispose(arg_26_0)
		arg_26_0.onMove = nil
		arg_26_0.onUpdatePos = nil

		return
	end

	return var_6_0
end

local function var_0_11(arg_27_0)
	return {
		id = arg_27_0,
		config = var_0_2[arg_27_0],
		ExistStory = function(arg_28_0)
			local var_28_0

			if arg_28_0.config.story then
				var_28_0 = arg_28_0.config.story ~= "0"
			end

			return var_28_0
		end,
		isEmpty = function(arg_29_0)
			return arg_29_0.config.story == "0" and arg_29_0.config.drop == 0 and #arg_29_0.config.effect == 0
		end,
		Dispose = function(arg_30_0)
			arg_30_0.config = nil

			return
		end
	}
end

local function var_0_12(arg_31_0)
	local var_31_0 = {}

	var_31_0.row, var_31_0.column = arg_31_0.pos[1], arg_31_0.pos[2]
	var_31_0.index = arg_31_0.index
	var_31_0.id = arg_31_0.id
	var_31_0.flag = arg_31_0.flag
	assert = var_2

	var_2(var_31_0.id)

	var_31_0.config = var_0_1[var_31_0.id]
	var_31_0.events = {}
	ipairs = var_2

	for iter_31_0, iter_31_1 in var_2(var_0_2.all) do
		table = var_1_10007

		if not var_1_10007.contains(var_31_0.events, iter_31_1) then
			table = var_1_10007

			var_1_10007.insert(var_31_0.events, var_0_11(iter_31_1))
		end
	end

	function var_31_0.GetEvent(arg_32_0, arg_32_1)
		ipairs = var_2_10002

		for iter_32_0, iter_32_1 in var_2_10002(arg_32_0.events) do
			if iter_32_1.id == arg_32_1 then
				return iter_32_1
			end
		end

		return
	end

	function var_31_0.SetNext(arg_33_0, arg_33_1)
		arg_33_0.next = arg_33_1

		return
	end

	function var_31_0.Dispose(arg_34_0)
		ipairs = var_2_10001

		for iter_34_0, iter_34_1 in var_2_10001(arg_34_0.events) do
			iter_34_1:Dispose()
		end

		return
	end

	return var_31_0
end

local function var_0_13(arg_35_0, arg_35_1)
	local var_35_0 = {
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}

	var_35_0.char = nil
	var_35_0.index = arg_35_1

	function var_35_0.onCreateCell(arg_36_0)
		return
	end

	function var_35_0.onCreateChar(arg_37_0)
		return
	end

	function var_35_0.Init(arg_38_0)
		local var_38_0 = 0

		for iter_38_0 = 0, var_35_0.ROW - 1 do
			local var_38_1 = var_35_0

			var_6.CeateCell(var_38_1, {
				var_38_0,
				iter_38_0
			}, 0)
		end

		local var_38_2 = var_35_0.ROW - 1

		for iter_38_1 = 1, var_35_0.COLUMN do
			local var_38_3 = var_35_0

			var_6.CeateCell(var_38_3, {
				iter_38_1,
				var_38_2
			}, #arg_38_0.path)
		end

		local var_38_4 = var_35_0.COLUMN + 1

		for iter_38_2 = var_35_0.ROW - 1, 0, -1 do
			local var_38_5 = var_35_0

			var_6.CeateCell(var_38_5, {
				var_38_4,
				iter_38_2
			}, #arg_38_0.path)
		end

		local var_38_6 = 0
		local var_38_7 = #arg_38_0.path - 1

		for iter_38_3 = var_35_0.COLUMN, 1, -1 do
			local var_38_8 = var_35_0

			var_7.CeateCell(var_38_8, {
				iter_38_3,
				var_38_6
			}, var_38_7)
		end

		arg_38_0:CreateChar(var_0_3)

		return
	end

	function var_35_0.CreateChar(arg_39_0, arg_39_1)
		arg_39_0.char = var_0_10(arg_39_1)

		arg_39_0.onCreateChar(arg_39_0.char)

		local var_39_0 = arg_39_0:GetCell(arg_39_0.index)
		local var_39_1 = arg_39_0.char

		var_3.InitPos(var_39_1, var_39_0)

		return
	end

	function var_35_0.CeateCell(arg_40_0, arg_40_1, arg_40_2)
		local var_40_0 = #arg_40_0.path
		local var_40_1 = var_0_12({
			pos = arg_40_1,
			index = var_40_0 + 1,
			id = arg_40_0.cellIds[var_40_0 + 1],
			flag = arg_40_2
		})
		local var_40_2

		if var_40_0 == 0 then
			var_40_1:SetNext(var_40_1)
		else
			var_40_2 = arg_40_0.path[var_40_0]

			local var_40_3 = arg_40_0.path[1]

			var_40_2:SetNext(var_40_1)
			var_40_1:SetNext(var_40_3)
		end

		table = var_40_2

		var_40_2.insert(arg_40_0.path, var_40_1)
		arg_40_0.onCreateCell(var_40_1)

		return
	end

	function var_35_0.GetPath(arg_41_0)
		return arg_41_0.path
	end

	function var_35_0.GetChar(arg_42_0)
		return arg_42_0.char
	end

	function var_35_0.GetPathCell(arg_43_0, arg_43_1)
		_ = var_2_10002

		return var_2_10002.map(arg_43_1, function(arg_44_0)
			return arg_43_0.path[arg_44_0]
		end)
	end

	function var_35_0.UpdateCharPos(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
		local var_45_0 = arg_45_0:GetPathCell(arg_45_1)
		local var_45_1 = arg_45_0.char

		var_5.Move(var_45_1, var_45_0, arg_45_2, arg_45_3)

		arg_45_0.index = arg_45_1[#arg_45_1]

		return
	end

	function var_35_0.GetCell(arg_46_0, arg_46_1)
		return arg_46_0.path[arg_46_1]
	end

	function var_35_0.GetPos(arg_47_0)
		return arg_47_0.index
	end

	function var_35_0.Dispose(arg_48_0)
		ipairs = var_2_10001

		for iter_48_0, iter_48_1 in var_2_10001(arg_48_0.path) do
			iter_48_1:Dispose()
		end

		local var_48_0 = arg_48_0.char

		var_1.Dispose(var_48_0)

		arg_48_0.onCreateCell = nil
		arg_48_0.onCreateChar = nil

		return
	end

	return var_35_0
end

local function var_0_14(arg_49_0, arg_49_1)
	local var_49_0 = {
		_tf = arg_49_0
	}
	local var_49_1 = arg_49_0
	local var_49_2 = arg_49_0.GetComponent

	typeof = var_1_10005
	Image = var_1_10006
	var_49_0._img = var_49_2(var_49_1, var_1_10005(var_1_10006))
	var_49_0.cell = arg_49_1
	Vector2 = var_3
	var_49_0.interval = var_3(0, 0)
	Vector2 = var_3
	var_49_0.startPos = var_3(0, 0)
	Vector2 = var_3
	var_49_0.offset = var_3(arg_49_0.rect.width * 0.5 + 2.5, arg_49_0.rect.height * 0.5 - 2)

	function var_49_0.GetGenPos(arg_50_0)
		local var_50_0 = arg_50_0.cell.column
		local var_50_1 = arg_50_0.cell.row
		local var_50_2 = arg_50_0.startPos.x + var_50_0 * arg_50_0.offset.x + var_50_1 * arg_50_0.offset.x
		local var_50_3 = arg_50_0.startPos.y + var_50_0 * arg_50_0.offset.y + var_50_1 * -arg_50_0.offset.y

		Vector3 = var_5

		return var_5(var_50_2, var_50_3, 0)
	end

	function var_49_0.UpdateStyle(arg_51_0)
		local var_51_0 = arg_51_0.cell

		GetSpriteFromAtlas = var_2_10002

		local var_51_1 = var_2_10002("ui/activityuipage/monopolycar_atlas", var_51_0.config.icon)

		arg_51_0._img.sprite = var_51_1

		local var_51_2 = arg_51_0._img

		var_3.SetNativeSize(var_51_2)

		return
	end

	function var_49_0.Dispose(arg_52_0)
		return
	end

	setAnchoredPosition = var_3

	var_3(arg_49_0, var_49_0:GetGenPos())

	local var_49_3 = var_49_0._tf

	var_3.SetSiblingIndex(var_49_3, arg_49_1.flag)

	return var_49_0
end

local function var_0_15(arg_53_0, arg_53_1)
	local var_53_0 = {
		_tf = arg_53_0
	}

	var_53_0.WalkSpeed = 1
	var_53_0.RunSpeed = 0.5
	var_53_0.jumpSpeed = 0.5
	var_53_0.char = arg_53_1

	local var_53_1 = arg_53_0
	local var_53_2 = arg_53_0.GetChild(var_53_1, 0)

	tf = var_53_1

	local var_53_3 = var_53_1(var_53_2)

	Vector3 = var_5
	var_53_3.localScale = var_5(0.5, 0.5, 0.5)
	var_53_0.SpineAnimUI = var_53_2:GetComponent("SpineAnimUI")
	GameObject = var_4

	local var_53_4 = var_4("mouseChild")

	tf = var_5

	local var_53_5 = var_5(var_53_4)
	local var_53_6 = var_5.SetParent

	tf = var_7

	var_53_6(var_53_5, var_7(var_53_2))

	tf = var_53_6

	local var_53_7 = var_53_6(var_53_4)

	Vector3 = var_6
	var_53_7.localPosition = var_6.zero
	setParent = var_53_7

	var_53_7(var_53_4, var_53_2)

	GetOrAddComponent = var_53_7

	local var_53_8 = var_53_7(var_53_4, "Image")

	Color = var_6
	var_53_8.color = var_6.New(0, 0, 0, 0)

	local var_53_9 = var_53_4
	local var_53_10 = var_53_4.GetComponent

	typeof = var_8
	RectTransform = var_9

	local var_53_11 = var_53_10(var_53_9, var_8(var_9))

	Vector2 = var_53_9
	var_53_11.sizeDelta = var_53_9(3, 3)
	Vector2 = var_7
	var_53_11.pivot = var_7(0.5, 0)
	Vector2 = var_7
	var_53_11.anchoredPosition = var_7(0, 0)
	onButton = var_7

	var_7(nil, var_53_4, function()
		local var_54_0 = var_53_0.char

		var_0.Touch(var_54_0)

		return
	end)

	function var_53_0.Action(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
		local var_55_0 = {}

		_ = var_2_10005

		var_2_10005.each(arg_55_1, function(arg_56_0)
			table = var_3_10001

			var_3_10001.insert(var_55_0, function(arg_57_0)
				local var_57_0 = arg_55_0

				var_1.UpdateScale(var_57_0, arg_56_0)

				local var_57_1 = arg_56_0
				local var_57_2 = var_1.GetGenPos(var_57_1)

				if arg_55_0._tf.localPosition == var_57_2 then
					arg_57_0()
				else
					LeanTween = var_2

					local var_57_3 = var_2.moveLocal

					go = var_3

					local var_57_4 = var_57_3(var_3(arg_55_0._tf), var_57_2, arg_55_3)
					local var_57_5 = var_2.setOnComplete

					System = var_4

					var_57_5(var_57_4, var_4.Action(function()
						arg_55_0.preCellTF = arg_56_0

						arg_57_0()

						return
					end))
				end

				return
			end)

			return
		end)

		seriesAsync = var_5

		var_5(var_55_0, function()
			if arg_55_2 then
				arg_55_2()
			end

			return
		end)

		return
	end

	function var_53_0.Move(arg_60_0, arg_60_1, arg_60_2)
		if #arg_60_1 > 3 then
			arg_60_0:Action(arg_60_1, arg_60_2, arg_60_0.RunSpeed)
		else
			arg_60_0:Action(arg_60_1, arg_60_2, arg_60_0.WalkSpeed)
		end

		return
	end

	function var_53_0.Jump(arg_61_0, arg_61_1, arg_61_2)
		arg_61_0:Action({
			arg_61_1
		}, function()
			arg_61_2()

			pg = var_0

			local var_62_0 = var_0.CriMgr.GetInstance()
			local var_62_1 = var_0.PlaySoundEffect_V3

			SFX_STEP_MONOPOLY = var_3_10002

			var_62_1(var_62_0, var_3_10002)

			return
		end, arg_61_0.jumpSpeed)

		return
	end

	function var_53_0.UpdatePos(arg_63_0, arg_63_1)
		arg_63_0.preCellTF = arg_63_1

		local var_63_0 = arg_63_1:GetGenPos()

		arg_63_0._tf.localPosition = var_63_0

		return
	end

	function var_53_0.UpdateScale(arg_64_0, arg_64_1)
		local var_64_0 = 1
		local var_64_1

		if not arg_64_0.preCellTF then
			var_64_1 = arg_64_1
		end

		arg_64_0.preCellTF = var_64_1

		local var_64_2 = arg_64_1.cell.row

		if not (arg_64_0.preCellTF.cell.row < var_64_2) then
			local var_64_3 = arg_64_1.cell.column

			if arg_64_0.preCellTF.cell.column < var_64_3 then
				var_64_0 = 1
			elseif arg_64_1.cell.row < arg_64_0.preCellTF.cell.row or arg_64_1.cell.column < arg_64_0.preCellTF.cell.column then
				var_64_0 = -1
			end

			local var_64_4 = arg_64_0._tf

			Vector3 = var_4
			var_64_4.localScale = var_4(var_64_0, 1, 1)

			return
		end
	end

	function var_53_0.ChangeAction(arg_65_0, arg_65_1, arg_65_2)
		local var_65_0 = arg_65_0.SpineAnimUI

		var_3.SetActionCallBack(var_65_0, nil)

		local var_65_1 = arg_65_0.SpineAnimUI

		var_3.SetAction(var_65_1, arg_65_1, 0)

		local var_65_2 = arg_65_0.SpineAnimUI

		var_3.SetActionCallBack(var_65_2, function(arg_66_0)
			if arg_66_0 == "finish" then
				local var_66_0 = arg_65_0.SpineAnimUI

				var_1.SetActionCallBack(var_66_0, nil)
				arg_65_2()
			end

			return
		end)

		return
	end

	function var_53_0.Dispose(arg_67_0)
		local var_67_0 = arg_67_0.SpineAnimUI

		var_1.SetActionCallBack(var_67_0, nil)

		arg_67_0.char.onMove = nil

		if arg_67_0.timer then
			local var_67_1 = arg_67_0.timer

			var_1.Stop(var_67_1)

			arg_67_0.timer = nil
		end

		return
	end

	return var_53_0
end

function var_0_0.SetUp(arg_68_0, arg_68_1, arg_68_2)
	arg_68_0.viewComponent = arg_68_1

	local var_68_0 = arg_68_0.viewComponent._tf

	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_68_0)

	arg_68_0._tf = var_68_0
	go = var_4
	arg_68_0._go = var_4(var_68_0)
	arg_68_0.models = {}
	parallelAsync = var_4

	var_4({
		function(arg_69_0)
			Ship = var_2_10001

			local var_69_0 = var_2_10001.New({
				configId = var_0_3,
				skin_id = var_0_4
			})
			local var_69_1 = var_1.getPrefab(var_69_0)

			PoolMgr = var_69_0

			local var_69_2 = var_69_0.GetInstance()

			var_3.GetSpineChar(var_69_2, var_69_1, true, function(arg_70_0)
				arg_68_0.models[var_0.configId] = arg_70_0

				arg_69_0()

				return
			end)

			return
		end,
		function(arg_71_0)
			onNextTick = var_2_10001

			var_2_10001(arg_71_0)

			return
		end
	}, function()
		local var_72_0 = arg_68_0

		var_0.setActivity(var_72_0, arg_68_2)

		local var_72_1 = arg_68_0

		var_0.init(var_72_1)

		local var_72_2 = arg_68_0

		var_0.didEnter(var_72_2)

		return
	end)

	return
end

function var_0_0.setActivity(arg_73_0, arg_73_1)
	arg_73_0.activity = arg_73_1

	local var_73_0 = arg_73_0.activity.data1
	local var_73_1 = arg_73_0.activity.data1_list[1]

	arg_73_0.useCount = arg_73_0.activity.data1_list[2]

	local var_73_2 = arg_73_0.activity.data1_list[3] - 1
	local var_73_3 = arg_73_0.activity.data2_list[1]
	local var_73_4 = arg_73_0.activity.data2_list[2]

	pg = var_1_10007

	local var_73_5 = var_1_10007.TimeMgr.GetInstance()
	local var_73_6 = var_7.GetServerTime(var_73_5)

	math = var_73_5

	local var_73_7 = var_73_5.ceil((var_73_6 - var_73_0) / 0)
	local var_73_8 = arg_73_0.activity
	local var_73_9 = var_73_7 * var_9.getDataConfig(var_73_8, "daily_time")

	arg_73_0.pos = arg_73_0.activity.data2
	arg_73_0.step = arg_73_0.activity.data3
	arg_73_0.effectId = arg_73_0.activity.data4
	arg_73_0.totalCnt = var_73_9 + var_73_1
	arg_73_0.leftCount = arg_73_0.totalCnt - arg_73_0.useCount
	arg_73_0.nextredPacketStep = arg_73_1:getDataConfig("reward_time") - arg_73_0.useCount % var_9
	arg_73_0.advanceTotalCnt = #arg_73_1:getDataConfig("reward")
	arg_73_0.isAdvanceRp = arg_73_0.advanceTotalCnt - var_73_4 > 0
	arg_73_0.leftAwardCnt = var_73_3 - var_73_4
	math = var_10

	local var_73_10 = var_10.max
	local var_73_11 = 0

	math = var_12
	arg_73_0.advanceRpCount = var_73_10(var_73_11, var_12.min(var_73_3, arg_73_0.advanceTotalCnt) - var_73_4)
	math = var_10

	local var_73_12 = var_10.max(0, var_73_3 - arg_73_0.advanceTotalCnt)

	math = var_11
	arg_73_0.commonRpCount = var_73_12 - var_11.max(0, var_73_4 - arg_73_0.advanceTotalCnt)
	arg_73_0.leftDropShipCnt = 10 - var_73_2

	return
end

function var_0_0.NetActivity(arg_74_0, arg_74_1)
	arg_74_0:setActivity(arg_74_1)
	arg_74_0:updateLeftCount()
	arg_74_0:updateNextRedPacketStep()

	return
end

function var_0_0.init(arg_75_0)
	arg_75_0:blockAllEvent(false)

	local var_75_0 = arg_75_0._tf

	arg_75_0.bg = var_1.Find(var_75_0, "AD")
	arg_75_0.mapCellTpl = arg_75_0:getTpl("mapCell", arg_75_0.bg)

	local var_75_1 = arg_75_0.bg

	arg_75_0.mapContainer = var_1.Find(var_75_1, "mapContainer")
	arg_75_0.charTpl = arg_75_0:getTpl("char", arg_75_0.bg)

	local var_75_2 = arg_75_0.bg

	arg_75_0.startBtn = var_1.Find(var_75_2, "start")

	local var_75_3 = arg_75_0.bg
	local var_75_4 = var_1.Find(var_75_3, "value")
	local var_75_5 = var_1.GetComponent

	typeof = var_3
	Image = var_4
	arg_75_0.valueImg = var_75_5(var_75_4, var_3(var_4))

	local var_75_6 = arg_75_0.bg
	local var_75_7 = var_1.Find(var_75_6, "leftcount")
	local var_75_8 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_75_0.leftcountLabel = var_75_8(var_75_7, var_3(var_4))

	local var_75_9 = arg_75_0.bg
	local var_75_10 = var_1.Find(var_75_9, "leftcount/Text")
	local var_75_11 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_75_0.leftCountTF = var_75_11(var_75_10, var_3(var_4))

	local var_75_12 = arg_75_0.bg
	local var_75_13 = var_1.Find(var_75_12, "nextRpStep/Text")
	local var_75_14 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_75_0.nextRedPacketStepTF = var_75_14(var_75_13, var_3(var_4))

	local var_75_15 = arg_75_0.bg

	arg_75_0.commonRp = var_1.Find(var_75_15, "rp")

	local var_75_16 = arg_75_0.commonRp
	local var_75_17 = var_1.GetComponent

	typeof = var_3
	Animator = var_4
	arg_75_0.commonAnim = var_75_17(var_75_16, var_3(var_4))

	local var_75_18 = arg_75_0.bg
	local var_75_19 = var_1.Find(var_75_18, "rp_text/Text")
	local var_75_20 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_75_0.commonRpCnt = var_75_20(var_75_19, var_3(var_4))

	local var_75_21 = arg_75_0._tf
	local var_75_22 = var_1.Find(var_75_21, "AD/drop_ship_text")
	local var_75_23 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_75_0.dropShipTxt = var_75_23(var_75_22, var_3(var_4))

	local var_75_24 = arg_75_0._tf

	arg_75_0.helpBtn = var_1.Find(var_75_24, "AD/help")

	local var_75_25 = arg_75_0._tf

	arg_75_0.anim = var_1.Find(var_75_25, "AD/anim")
	setActive = var_1

	var_1(arg_75_0.anim, false)

	local var_75_26 = arg_75_0.leftcountLabel

	i18n = var_2
	var_75_26.text = var_2("monopoly_left_count")

	local var_75_27 = arg_75_0._tf

	arg_75_0.advanceTag = var_1.Find(var_75_27, "AD/rp/sp")

	local var_75_28 = arg_75_0._tf

	arg_75_0.advanceLabel = var_1.Find(var_75_28, "AD/rp_text/sp")

	local var_75_29 = arg_75_0._tf

	arg_75_0.advancecLabel = var_1.Find(var_75_29, "AD/rp_text/label")

	local var_75_30 = arg_75_0._tf

	arg_75_0.advanceImage = var_1.Find(var_75_30, "AD/rp_text/sp_img")

	local var_75_31 = arg_75_0._tf
	local var_75_32 = var_1.Find(var_75_31, "AD/rp_text/sp_img/Text")
	local var_75_33 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_75_0.advanceTxt = var_75_33(var_75_32, var_3(var_4))

	return
end

function var_0_0.updateNextRedPacketStep(arg_76_0)
	arg_76_0.nextRedPacketStepTF.text = arg_76_0.nextredPacketStep

	return
end

function var_0_0.updateLeftCount(arg_77_0)
	arg_77_0.leftCountTF.text = arg_77_0.leftCount

	local var_77_0 = arg_77_0.commonAnim

	var_1.SetInteger(var_77_0, "count", arg_77_0.leftAwardCnt)

	arg_77_0.commonRpCnt.text = arg_77_0.commonRpCount

	return
end

function var_0_0.updateValue(arg_78_0, arg_78_1)
	if arg_78_1 ~= 0 then
		var_1_10002 = arg_78_0.valueImg
		GetSpriteFromAtlas = var_1_10003
		var_1_10002.sprite = var_1_10003("ui/activityuipage/monopoly_atlas", arg_78_1)
		var_1_10003 = arg_78_0.valueImg

		var_1_10002.SetNativeSize(var_1_10003)
	end

	setActive = var_1_10002
	go = var_1_10003

	var_1_10002(var_1_10003(arg_78_0.valueImg), arg_78_1 ~= 0)

	return
end

function var_0_0.didEnter(arg_79_0)
	setActive = var_1_10001

	var_1_10001(arg_79_0.startBtn, arg_79_0.leftCount > 0)
	arg_79_0:updateLeftCount()
	arg_79_0:updateValue(0)
	arg_79_0:updateNextRedPacketStep()

	local var_79_0 = arg_79_0.activity
	local var_79_1 = var_1.getDataConfig(var_79_0, "map")

	arg_79_0.mapVO = var_0_13(var_79_1, arg_79_0.pos)

	arg_79_0:createMap(arg_79_0.mapVO)

	local var_79_2 = arg_79_0.mapVO

	var_2.Init(var_79_2)
	arg_79_0:checkState()

	onButton = var_2

	local var_79_3 = arg_79_0
	local var_79_4 = arg_79_0.startBtn

	local function var_79_5()
		if arg_79_0.block then
			return
		end

		if arg_79_0.leftCount <= 0 then
			pg = var_0

			local var_80_0 = var_0.TipsMgr.GetInstance()
			local var_80_1 = var_0.ShowTips

			i18n = var_2_10002

			var_80_1(var_80_0, var_2_10002("common_count_noenough"))

			return
		end

		local var_80_2 = arg_79_0

		var_0.startAction(var_80_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_79_3, var_79_4, var_79_5, var_1_10006)

	onButton = var_2

	local var_79_6 = arg_79_0
	local var_79_7 = arg_79_0.commonRp

	local function var_79_8()
		if arg_79_0.leftAwardCnt > 0 then
			local var_81_0 = arg_79_0
			local var_81_1 = var_0.emit

			MonopolyPage = var_2_10002

			var_81_1(var_81_0, var_2_10002.ON_AWARD)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_79_6, var_79_7, var_79_8, var_1_10006)

	onButton = var_2

	local var_79_9 = arg_79_0
	local var_79_10 = arg_79_0.helpBtn

	local function var_79_11()
		pg = var_2_10000

		local var_82_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_82_1 = var_0.ShowMsgBox
		local var_82_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_82_2.type = var_2_10003
		pg = var_2_10003
		var_82_2.helps = var_2_10003.gametip.help_chunjie_monopoly.tip

		var_82_1(var_82_0, var_82_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_79_9, var_79_10, var_79_11, var_1_10006)

	return
end

function var_0_0.blockAllEvent(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0
	local var_83_1 = arg_83_0.emit

	ActivityMainScene = var_1_10004

	var_83_1(var_83_0, var_1_10004.LOCK_ACT_MAIN, arg_83_1)

	arg_83_0.block = arg_83_1

	return
end

function var_0_0.triggerEvent(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	local var_84_0 = arg_84_0.mapVO
	local var_84_1 = var_4.GetCell(var_84_0, arg_84_1)
	local var_84_2 = var_4.GetEvent(var_84_1, arg_84_2)

	local function var_84_3(arg_85_0, arg_85_1)
		if arg_85_0 and arg_85_0:ExistStory() then
			pg = var_2

			local var_85_0 = var_2.NewStoryMgr.GetInstance()

			var_2.Play(var_85_0, arg_85_0.config.story, arg_85_1, true, true)
		else
			arg_85_1()
		end

		return
	end

	local var_84_4 = {
		function(arg_86_0)
			var_84_3(var_84_2, arg_86_0)

			return
		end,
		function(arg_87_0)
			local var_87_0

			;(function()
				if var_84_2 then
					local var_88_0 = var_84_2

					if var_0.isEmpty(var_88_0) then
						arg_87_0()

						return
					end

					local var_88_1 = arg_84_0
					local var_88_2 = var_0.emit

					MonopolyPage = var_3_10002

					var_88_2(var_88_1, var_3_10002.ON_TRIGGER, arg_84_0.activity.id, function(arg_89_0, arg_89_1)
						if not arg_89_0 or #arg_89_0 == 0 then
							arg_87_0()

							return
						end

						local var_89_0 = arg_84_0.mapVO

						var_2.UpdateCharPos(var_89_0, arg_89_0, function()
							local var_90_0 = arg_89_0[#arg_89_0]
							local var_90_1 = arg_84_0.mapVO
							local var_90_2 = var_1.GetCell(var_90_1, var_90_0)

							var_84_2 = var_1.GetEvent(var_90_2, arg_89_1)

							var_84_3(var_84_2, var_0)

							return
						end, true)

						return
					end)

					return
				end
			end)()

			return
		end
	}

	seriesAsync = var_8

	var_8(var_84_4, arg_84_3)

	return
end

function var_0_0.checkState(arg_91_0)
	local var_91_0 = {}

	arg_91_0:blockAllEvent(true)

	local var_91_1 = arg_91_0

	if arg_91_0.getStrory(var_91_1) then
		table = var_91_1

		var_91_1.insert(var_91_0, function(arg_92_0)
			pg = var_2_10001

			local var_92_0 = var_2_10001.NewStoryMgr.GetInstance()

			var_1.Play(var_92_0, var_0, arg_92_0)

			return
		end)
	end

	if arg_91_0.effectId ~= 0 then
		table = var_3

		var_3.insert(var_91_0, function(arg_93_0)
			local var_93_0 = arg_91_0.mapVO
			local var_93_1 = var_1.GetPos(var_93_0)
			local var_93_2 = arg_91_0

			var_2.triggerEvent(var_93_2, var_93_1, arg_91_0.effectId, arg_93_0)

			return
		end)
	end

	if arg_91_0.step ~= 0 then
		table = var_3

		var_3.insert(var_91_0, function(arg_94_0)
			local var_94_0 = arg_91_0
			local var_94_1 = var_1.emit

			MonopolyPage = var_2_10003

			var_94_1(var_94_0, var_2_10003.ON_MOVE, arg_91_0.activity.id, function(arg_95_0, arg_95_1, arg_95_2)
				if not arg_95_1 or #arg_95_1 == 0 then
					arg_94_0()

					return
				end

				local var_95_0 = arg_91_0.mapVO

				var_3.UpdateCharPos(var_95_0, arg_95_1, function()
					local var_96_0 = arg_95_1[#arg_95_1]
					local var_96_1 = arg_91_0

					var_1.triggerEvent(var_96_1, var_96_0, arg_95_2, arg_94_0)

					return
				end)

				return
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_91_0, function()
		local var_97_0 = arg_91_0

		var_0.blockAllEvent(var_97_0, false)

		return
	end)

	return
end

function var_0_0.startAction(arg_98_0)
	local var_98_0 = arg_98_0.activity.id
	local var_98_1 = 0

	local function var_98_2(arg_99_0)
		if var_98_1 == 0 then
			arg_99_0()

			return
		end

		local var_99_0 = arg_98_0
		local var_99_1 = var_1.emit

		MonopolyPage = var_2_10003

		var_99_1(var_99_0, var_2_10003.ON_MOVE, var_98_0, function(arg_100_0, arg_100_1, arg_100_2)
			if not arg_100_1 or #arg_100_1 == 0 then
				arg_99_0()

				return
			end

			var_98_1 = arg_100_0

			local var_100_0 = arg_98_0.mapVO

			var_3.UpdateCharPos(var_100_0, arg_100_1, function()
				local var_101_0 = arg_100_1[#arg_100_1]
				local var_101_1 = arg_98_0

				var_1.triggerEvent(var_101_1, var_101_0, arg_100_2, arg_99_0)

				return
			end)

			return
		end)

		return
	end

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_102_0)
			setActive = var_2_10001

			var_2_10001(arg_98_0.startBtn, false)

			local var_102_0 = arg_98_0

			var_1.blockAllEvent(var_102_0, true)

			local var_102_1 = arg_98_0

			var_1.playerAnim(var_102_1, arg_102_0)

			return
		end,
		function(arg_103_0)
			local var_103_0 = arg_98_0
			local var_103_1 = var_1.emit

			MonopolyPage = var_2_10003

			var_103_1(var_103_0, var_2_10003.ON_START, var_98_0, function(arg_104_0)
				var_98_1 = arg_104_0

				local var_104_0 = arg_98_0

				var_1.updateValue(var_104_0, arg_104_0)
				arg_103_0()

				return
			end)

			return
		end,
		function(arg_105_0)
			var_98_2(arg_105_0)

			return
		end,
		function(arg_106_0)
			var_98_2(arg_106_0)

			return
		end,
		function(arg_107_0)
			local var_107_0 = arg_98_0

			if not var_1.getStrory(var_107_0) then
				arg_107_0()

				return
			end

			pg = var_107_0

			local var_107_1 = var_107_0.NewStoryMgr.GetInstance()

			var_2.Play(var_107_1, var_1, arg_107_0)

			return
		end
	}, function()
		local var_108_0 = arg_98_0

		var_0.updateValue(var_108_0, 0)

		local var_108_1 = arg_98_0

		var_0.blockAllEvent(var_108_1, false)

		setActive = var_0

		var_0(arg_98_0.startBtn, arg_98_0.leftCount > 0)

		return
	end)

	return
end

function var_0_0.getStrory(arg_109_0)
	local var_109_0 = arg_109_0.useCount
	local var_109_1 = arg_109_0.activity
	local var_109_2

	if not var_2.getDataConfig(var_109_1, "story") then
		var_109_2 = {}
	end

	_ = var_109_1

	if var_109_1.detect(var_109_2, function(arg_110_0)
		return arg_110_0[1] == var_109_0
	end) then
		return var_4[2]
	end

	return nil
end

function var_0_0.createMap(arg_111_0, arg_111_1)
	arg_111_0.cellTFs, arg_111_0.charCard = {}

	function arg_111_1.onCreateCell(arg_112_0)
		cloneTplTo = var_2_10001

		local var_112_0 = var_2_10001(arg_111_0.mapCellTpl, arg_111_0.mapContainer)
		local var_112_1 = var_0_14(var_112_0, arg_112_0)

		var_2.UpdateStyle(var_112_1)

		arg_111_0.cellTFs[arg_112_0.index] = var_2

		return
	end

	function arg_111_1.onCreateChar(arg_113_0)
		cloneTplTo = var_2_10001

		local var_113_0 = var_2_10001(arg_111_0.charTpl, arg_111_0.mapContainer)
		local var_113_1 = arg_111_0.models[arg_113_0.ship.configId]

		setParent = var_3

		var_3(var_113_1, var_113_0)

		arg_111_0.charCard = var_0_15(var_113_0, arg_113_0)

		function arg_113_0.onMove(arg_114_0, arg_114_1)
			_ = var_3_10002

			local var_114_0 = var_3_10002.map(arg_114_0, function(arg_115_0)
				return arg_111_0.cellTFs[arg_115_0.index]
			end)
			local var_114_1 = arg_111_0.charCard

			var_3.Move(var_114_1, var_114_0, arg_114_1)

			return
		end

		function arg_113_0.onUpdatePos(arg_116_0)
			local var_116_0 = arg_111_0.cellTFs[arg_116_0.index]
			local var_116_1 = arg_111_0.charCard

			var_2.UpdatePos(var_116_1, var_116_0)

			return
		end

		function arg_113_0.state.onActionUpdated(arg_117_0, arg_117_1)
			local var_117_0 = arg_111_0.charCard

			var_2.ChangeAction(var_117_0, arg_117_0, arg_117_1)

			return
		end

		function arg_113_0.onJump(arg_118_0, arg_118_1)
			local var_118_0 = arg_111_0.cellTFs[arg_118_0.index]
			local var_118_1 = arg_111_0.charCard

			var_3.Jump(var_118_1, var_118_0, arg_118_1)

			return
		end

		return
	end

	return
end

function var_0_0.playerAnim(arg_119_0, arg_119_1)
	setActive = var_1_10002

	var_1_10002(arg_119_0.anim, true)

	if arg_119_0.timer then
		local var_119_0 = arg_119_0.timer

		var_2.Stop(var_119_0)
	end

	Timer = var_2
	arg_119_0.timer = var_2.New(function()
		arg_119_1()

		setActive = var_0

		var_0(arg_119_0.anim, false)

		return
	end, 1.5, 1)

	local var_119_1 = arg_119_0.timer

	var_2.Start(var_119_1)

	return
end

function var_0_0.getTpl(arg_121_0, arg_121_1, arg_121_2)
	local var_121_0 = arg_121_2:Find(arg_121_1)

	var_3.SetParent(var_121_0, arg_121_0._tf, false)

	SetActive = var_4

	var_4(var_3, false)

	return var_3
end

function var_0_0.Destroy(arg_122_0)
	pairs = var_1_10001

	for iter_122_0, iter_122_1 in var_1_10001(arg_122_0.cellTFs) do
		iter_122_1:Dispose()
	end

	local var_122_0 = arg_122_0.charCard

	var_1.Dispose(var_122_0)

	local var_122_1 = arg_122_0.mapVO

	var_1.Dispose(var_122_1)

	arg_122_0.cellTFs = nil
	arg_122_0.charCard = nil
	arg_122_0.mapVO = nil

	if arg_122_0.timer then
		local var_122_2 = arg_122_0.timer

		var_1.Stop(var_122_2)

		arg_122_0.timer = nil
	end

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_122_0)

	return
end

function var_0_0.emit(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
	local var_123_0 = arg_123_0.viewComponent

	var_4.emit(var_123_0, arg_123_1, arg_123_2, arg_123_3)

	return
end

return var_0_0
