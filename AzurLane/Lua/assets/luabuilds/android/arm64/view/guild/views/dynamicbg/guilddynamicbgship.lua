class = var_0_10000

local var_0_0 = var_0_10000("GuildDynamicBgShip")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0._go = arg_1_1.go
	tf = var_2
	arg_1_0._tf = var_2(arg_1_0._go)
	arg_1_0.parent = arg_1_0._tf.parent
	arg_1_0.path = arg_1_1.path
	arg_1_0.speed = 1
	arg_1_0.stepCnt = 0
	arg_1_0.scale = arg_1_0._tf.localScale.x
	arg_1_0.furnitures = arg_1_1.furnitures
	arg_1_0.interAction = nil
	GuildConst = var_2
	arg_1_0.interActionRatio = 16 / var_2.MAX_DISPLAY_MEMBER_SHIP
	arg_1_0.name = arg_1_1.name
	arg_1_0.isCommander = arg_1_1.isCommander
	arg_1_0.spineChar = arg_1_1.char

	arg_1_0:Init(arg_1_1)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0:SetPosition(arg_2_1.grid, true)

	local var_2_0 = arg_2_0._tf

	arg_2_0.nameTF = var_2.Find(var_2_0, "name")

	local var_2_1 = arg_2_0.nameTF

	Vector3 = var_1_10003
	var_2_1.localScale = var_1_10003(1 / arg_2_0.scale, 1 / arg_2_0.scale, 1)

	local var_2_2 = arg_2_0.nameTF

	Vector3 = var_3
	var_2_2.localPosition = var_3(0, 300, 0)
	setText = var_2_2

	var_2_2(arg_2_0.nameTF, arg_2_0.name)

	if arg_2_0.isCommander then
		local var_2_3 = arg_2_0._tf

		arg_2_0.tagTF = var_2.Find(var_2_3, "tag")

		local var_2_4 = arg_2_0.tagTF

		Vector3 = var_3
		var_2_4.localScale = var_3(1 / arg_2_0.scale, 1 / arg_2_0.scale, 1)

		local var_2_5 = arg_2_0.tagTF

		Vector3 = var_3
		var_2_5.localPosition = var_3(0, 380, 0)
	end

	if not arg_2_1.stand then
		arg_2_0:AddRandomMove()
	end

	return
end

function var_0_0.SetOnMoveCallBack(arg_3_0, arg_3_1)
	arg_3_0.callback = arg_3_1

	return
end

function var_0_0.SetPosition(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.exited then
		return
	end

	if arg_4_0.grid then
		local var_4_0 = arg_4_0.grid

		var_3.UnlockAll(var_4_0)
	end

	arg_4_0.grid = arg_4_1

	if arg_4_2 then
		local var_4_1 = arg_4_0.grid
		local var_4_2 = var_3.GetCenterPosition(var_4_1)

		arg_4_0._tf.localPosition = var_4_2

		arg_4_0:SetAction("stand2")
	end

	if arg_4_0.callback then
		arg_4_0.callback()
	end

	return
end

function var_0_0.AddRandomMove(arg_5_0)
	math = var_1_10001
	arg_5_0.stepCnt = var_1_10001.random(1, 10)
	math = var_1

	local var_5_0 = var_1.random(1, 8)

	Timer = var_1_10002
	arg_5_0.timer = var_1_10002.New(function()
		local var_6_0 = arg_5_0.timer

		var_0.Stop(var_6_0)

		arg_5_0.timer = nil

		local var_6_1 = arg_5_0

		var_0.StartMove(var_6_1)

		return
	end, var_5_0, 1)

	local var_5_1 = arg_5_0.timer

	var_2.Start(var_5_1)

	return
end

function var_0_0.IsCanWalkPonit(arg_7_0, arg_7_1)
	if not arg_7_0.path[arg_7_1.x] then
		return false
	end

	if arg_7_0.path[arg_7_1.x][arg_7_1.y] then
		return var_2:CanWalk()
	else
		return false
	end

	return
end

function var_0_0.GetMoveDir(arg_8_0, arg_8_1)
	if arg_8_1.position.x < arg_8_0.grid.position.x then
		return -1
	elseif arg_8_1.position.x > arg_8_0.grid.position.x then
		return 1
	end

	return arg_8_0._tf.localScale.x < 0 and -1 or 1
end

function var_0_0.StartMove(arg_9_0)
	local var_9_0 = arg_9_0.grid
	local var_9_1 = var_1.GetAroundGrids(var_9_0)

	_ = var_1_10002

	if not var_1_10002.select(var_9_1, function(arg_10_0)
		local var_10_0 = arg_9_0

		return var_1.IsCanWalkPonit(var_10_0, arg_10_0)
	end) or #var_2 == 0 then
		arg_9_0:AddRandomMove()
	else
		arg_9_0.stepCnt = arg_9_0.stepCnt - 1
		math = var_3

		local var_9_2 = var_2[var_3.random(1, #var_2)]
		local var_9_3 = arg_9_0.path[var_9_2.x][var_9_2.y]
		local var_9_4 = arg_9_0:GetMoveDir(var_9_3)

		arg_9_0:UpdateShipDir(var_9_4)
		arg_9_0:MoveToGrid(var_9_3)
	end

	return
end

function var_0_0.MoveToGrid(arg_11_0, arg_11_1)
	local function var_11_0()
		local var_12_0 = arg_11_0

		var_0.SetAction(var_12_0, "stand2")

		math = var_0

		local var_12_1 = var_0.random(3, 8)
		local var_12_2 = arg_11_0

		Timer = var_2
		var_12_2.idleTimer = var_2.New(function()
			local var_13_0 = arg_11_0.idleTimer

			var_0.Stop(var_13_0)

			arg_11_0.idleTimer = nil

			local var_13_1 = arg_11_0

			var_0.AddRandomMove(var_13_1)

			return
		end, var_12_1, 1)

		local var_12_3 = arg_11_0.idleTimer

		var_1.Start(var_12_3)

		return
	end

	local function var_11_1()
		if arg_11_0.stepCnt ~= 0 then
			local var_14_0 = arg_11_0

			var_0.StartMove(var_14_0)

			return
		end

		local var_14_1 = arg_11_0
		local var_14_2, var_14_3 = var_0.CanInterAction(var_14_1, arg_11_0.interActionRatio)

		if var_14_2 then
			local var_14_4 = arg_11_0

			var_2.MoveToFurniture(var_14_4, var_14_3)
		else
			var_11_0()
		end

		return
	end

	arg_11_0:MoveNext(arg_11_1, false, var_11_1)

	return
end

function var_0_0.MoveNext(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_2 and not arg_15_1:CanWalk() then
		return
	end

	if arg_15_0.exited then
		return
	end

	arg_15_1:Lock()
	arg_15_0:SetAction("walk")

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetMoveDir(var_15_0, arg_15_1)

	arg_15_0:UpdateShipDir(var_15_1)

	local var_15_2 = arg_15_1:GetCenterPosition()

	LeanTween = var_15_0

	local var_15_3 = var_15_0.moveLocal
	local var_15_4 = arg_15_0._go

	Vector3 = var_1_10009

	local var_15_5 = var_15_3(var_15_4, var_1_10009(var_15_2.x, var_15_2.y, 0), 1 / arg_15_0.speed)
	local var_15_6 = var_6.setOnComplete

	System = var_9

	var_15_6(var_15_5, var_9.Action(function()
		if arg_15_0.exited then
			return
		end

		local var_16_0 = arg_15_0

		var_0.SetPosition(var_16_0, arg_15_1)
		arg_15_3()

		return
	end))

	return
end

function var_0_0.MoveLeft(arg_17_0)
	local var_17_0 = arg_17_0.grid.position

	Vector2 = var_1_10002

	local var_17_1 = var_1_10002(var_17_0.x - 1, var_17_0.y)
	local var_17_2

	if arg_17_0.path[var_17_1.x] then
		var_17_2 = arg_17_0.path[var_17_1.x][var_17_1.y]
	end

	if var_17_2 then
		arg_17_0:MoveNext(var_17_2, false, function()
			local var_18_0 = arg_17_0

			var_0.SetAction(var_18_0, "stand2")

			return
		end)
	end

	return
end

function var_0_0.MoveRight(arg_19_0)
	local var_19_0 = arg_19_0.grid.position

	Vector2 = var_1_10002

	local var_19_1 = var_1_10002(var_19_0.x + 1, var_19_0.y)
	local var_19_2

	if arg_19_0.path[var_19_1.x] then
		var_19_2 = arg_19_0.path[var_19_1.x][var_19_1.y]
	end

	if var_19_2 then
		arg_19_0:MoveNext(var_19_2, false, function()
			local var_20_0 = arg_19_0

			var_0.SetAction(var_20_0, "stand2")

			return
		end)
	end

	return
end

function var_0_0.MoveDown(arg_21_0)
	local var_21_0 = arg_21_0.grid.position

	Vector2 = var_1_10002

	local var_21_1 = var_1_10002(var_21_0.x, var_21_0.y - 1)
	local var_21_2

	if arg_21_0.path[var_21_1.x] then
		var_21_2 = arg_21_0.path[var_21_1.x][var_21_1.y]
	end

	if var_21_2 then
		arg_21_0:MoveNext(var_21_2, false, function()
			local var_22_0 = arg_21_0

			var_0.SetAction(var_22_0, "stand2")

			return
		end)
	end

	return
end

function var_0_0.MoveUp(arg_23_0)
	local var_23_0 = arg_23_0.grid.position

	Vector2 = var_1_10002

	local var_23_1 = var_1_10002(var_23_0.x, var_23_0.y + 1)
	local var_23_2

	if arg_23_0.path[var_23_1.x] then
		var_23_2 = arg_23_0.path[var_23_1.x][var_23_1.y]
	end

	if var_23_2 then
		arg_23_0:MoveNext(var_23_2, false, function()
			local var_24_0 = arg_23_0

			var_0.SetAction(var_24_0, "stand2")

			return
		end)
	end

	return
end

function var_0_0.SetAction(arg_25_0, arg_25_1)
	if arg_25_0.actionName == arg_25_1 then
		return
	end

	arg_25_0.actionName = arg_25_1

	local var_25_0 = arg_25_0.spineChar

	var_2.SetAction(var_25_0, arg_25_1, 0)
	arg_25_0:NorDirByFather()

	return
end

function var_0_0.SetAsLastSibling(arg_26_0)
	local var_26_0 = arg_26_0._tf

	var_1.SetAsLastSibling(var_26_0)

	return
end

function var_0_0.MoveToFurniture(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1[1]
	local var_27_1 = arg_27_1[2]

	var_27_0:Lock()

	ipairs = var_4

	for iter_27_0, iter_27_1 in var_4(var_27_1) do
		local var_27_2 = arg_27_0.path[iter_27_1.x][iter_27_1.y]

		var_9.Lock(var_27_2)
	end

	arg_27_0:MoveByPath(var_27_1, function()
		local var_28_0 = arg_27_0

		var_0.InterActionFurniture(var_28_0, var_27_0)

		return
	end)

	return
end

function var_0_0.UpdateNameAndTagDir(arg_29_0, arg_29_1)
	local var_29_0 = 1 / arg_29_0.scale * arg_29_1

	if arg_29_0.nameTF then
		local var_29_1 = arg_29_0.nameTF

		Vector3 = var_1_10004
		var_29_1.localScale = var_1_10004(var_29_0, 1 / arg_29_0.scale, 1)
	end

	if arg_29_0.isCommander and arg_29_0.tagTF then
		local var_29_2 = arg_29_0.tagTF

		Vector3 = var_1_10004
		var_29_2.localScale = var_1_10004(var_29_0, 1 / arg_29_0.scale, 1)
	end

	return
end

function var_0_0.UpdateShipDir(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0._tf

	Vector3 = var_1_10003
	var_30_0.localScale = var_1_10003(arg_30_1 * arg_30_0.scale, arg_30_0.scale, arg_30_0.scale)

	arg_30_0:UpdateNameAndTagDir(arg_30_1)

	return
end

function var_0_0.NorDirByFather(arg_31_0)
	local var_31_0 = arg_31_0._tf.localScale.x < 0 and -1 or 1

	arg_31_0:UpdateNameAndTagDir(var_31_0)

	return
end

function var_0_0.InterActionFurniture(arg_32_0, arg_32_1)
	setParent = var_1_10002

	var_1_10002(arg_32_0._tf, arg_32_1._tf)

	local var_32_0 = arg_32_1:GetInteractionDir()

	arg_32_0:UpdateShipDir(var_32_0)

	local var_32_1 = arg_32_1:GetInterActionPos()

	arg_32_0._tf.anchoredPosition = var_32_1

	local var_32_2 = arg_32_1
	local var_32_3 = arg_32_1.GetInterActionMode(var_32_2)
	local var_32_4

	GuildDynamicFurniture = var_32_2

	if var_32_2.INTERACTION_MODE_SIT == var_32_3 then
		var_32_4 = "sit"
	end

	assert = var_6

	var_6(var_32_4)
	arg_32_0:SetAction(var_32_4)
	arg_32_0:UpdateShipDir(var_32_0)
	arg_32_0:CancelInterAction(arg_32_1)

	return
end

function var_0_0.CancelInterAction(arg_33_0, arg_33_1)
	math = var_1_10002

	local var_33_0 = var_1_10002.random(15, 30)

	Timer = var_1_10003
	arg_33_0.interActionTimer = var_1_10003.New(function()
		local var_34_0 = arg_33_0.interActionTimer

		var_0.Stop(var_34_0)

		arg_33_0.interActionTimer = nil

		local var_34_1 = arg_33_1

		var_0.Unlock(var_34_1)

		setParent = var_0

		var_0(arg_33_0._tf, arg_33_0.parent)

		assert = var_0

		var_0(arg_33_0.grid)

		local var_34_2 = arg_33_0

		var_0.SetPosition(var_34_2, arg_33_0.grid, true)

		local var_34_3 = arg_33_0

		var_0.NorDirByFather(var_34_3)

		local var_34_4 = arg_33_0

		var_0.AddRandomMove(var_34_4)

		return
	end, var_33_0, 1)

	local var_33_1 = arg_33_0.interActionTimer

	var_3.Start(var_33_1)

	return
end

function var_0_0.MoveByPath(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = {}

	ipairs = var_1_10004

	for iter_35_0, iter_35_1 in var_1_10004(arg_35_1) do
		table = var_1_10009

		var_1_10009.insert(var_35_0, function(arg_36_0)
			if arg_35_0.exited then
				return
			end

			local var_36_0 = arg_35_0.path[iter_35_1.x][iter_35_1.y]
			local var_36_1 = arg_35_0

			var_2.MoveNext(var_36_1, var_36_0, true, arg_36_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_35_0, arg_35_2)

	return
end

function var_0_0.SearchPoint(arg_37_0, arg_37_1, arg_37_2)
	local function var_37_0(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
		_ = var_2_10004

		if not var_2_10004.any(arg_38_0, function(arg_39_0)
			return arg_38_2 == arg_39_0.point
		end) then
			_ = var_4

			if var_4.any(arg_38_1, function(arg_40_0)
				return arg_38_2 == arg_40_0
			end) then
				return false
			end

			if arg_37_0.path[arg_38_2.x] then
				return arg_37_0.path[arg_38_2.x][arg_38_2.y] and var_4:CanWalk()
			end

			return false
		end
	end

	local function var_37_1(arg_41_0)
		local var_41_0 = {}

		table = var_2_10002

		local var_41_1 = var_2_10002.insert
		local var_41_2 = var_41_0

		Vector2 = var_2_10005

		var_41_1(var_41_2, var_2_10005(arg_41_0.x + 1, arg_41_0.y))

		table = var_41_1

		local var_41_3 = var_41_1.insert
		local var_41_4 = var_41_0

		Vector2 = var_5

		var_41_3(var_41_4, var_5(arg_41_0.x - 1, arg_41_0.y))

		table = var_41_3

		local var_41_5 = var_41_3.insert
		local var_41_6 = var_41_0

		Vector2 = var_5

		var_41_5(var_41_6, var_5(arg_41_0.x, arg_41_0.y + 1))

		table = var_41_5

		local var_41_7 = var_41_5.insert
		local var_41_8 = var_41_0

		Vector2 = var_5

		var_41_7(var_41_8, var_5(arg_41_0.x, arg_41_0.y - 1))

		return var_41_0
	end

	local function var_37_2(arg_42_0, arg_42_1, arg_42_2)
		math = var_2_10003

		local var_42_0 = var_2_10003.abs(arg_42_2.x - arg_42_0.x)

		math = var_2_10004

		local var_42_1 = var_42_0 + var_2_10004.abs(arg_42_2.y - arg_42_0.y)

		math = var_4

		local var_42_2 = var_4.abs(arg_42_2.x - arg_42_1.x)

		math = var_5

		return var_42_1 < var_42_2 + var_5.abs(arg_42_2.y - arg_42_1.y)
	end

	local var_37_3 = {}
	local var_37_4 = {}
	local var_37_5 = {}
	local var_37_6

	table = var_1_10010

	var_1_10010.insert(var_37_3, {
		parent = 0,
		point = arg_37_1
	})

	while #var_37_3 > 0 do
		table = var_10

		if var_10.remove(var_37_3, 1).point == arg_37_2 then
			var_37_6 = var_10

			break
		end

		table = var_12

		var_12.insert(var_37_4, var_11)

		ipairs = var_12

		for iter_37_0, iter_37_1 in var_12(var_37_1(var_11)) do
			if var_37_0(var_37_3, var_37_4, iter_37_1, arg_37_2) then
				table = var_17

				var_17.insert(var_37_3, {
					point = iter_37_1,
					parent = var_10
				})
			else
				if iter_37_1 == arg_37_2 then
					var_37_6 = var_10

					break
				end

				table = var_17

				var_17.insert(var_37_4, iter_37_1)
			end
		end

		table = var_12

		var_12.sort(var_37_3, function(arg_43_0, arg_43_1)
			return var_37_2(arg_43_0.point, arg_43_1.point, arg_37_2)
		end)
	end

	if var_37_6 then
		while var_37_6.parent ~= 0 do
			table = var_10

			var_10.insert(var_37_5, 1, var_37_6.point)

			var_37_6 = var_37_6.parent
		end
	end

	return var_37_5
end

function var_0_0.CanInterAction(arg_44_0, arg_44_1)
	math = var_1_10002

	if arg_44_1 < var_1_10002.random(1, 10000) then
		return false
	end

	local var_44_0 = {}

	ipairs = var_4

	for iter_44_0, iter_44_1 in var_4(arg_44_0.furnitures) do
		if not iter_44_1:BeLock() then
			table = var_9

			var_9.insert(var_44_0, iter_44_1)
		end
	end

	if #var_44_0 == 0 then
		return false
	end

	math = var_4

	local var_44_1 = var_44_0[var_4.random(1, #var_44_0)]
	local var_44_2 = var_5.GetOccupyGrid(var_44_1)
	local var_44_3 = 999999
	local var_44_4
	local var_44_5 = arg_44_0.grid.position

	ipairs = var_1_10010

	for iter_44_2, iter_44_3 in var_1_10010(var_44_2) do
		local var_44_6 = iter_44_3.position

		math = var_1_10016
		var_1_10016 = var_1_10016.abs(var_44_5.x - var_44_6.x)
		math = var_1_10017

		if var_1_10016 + var_1_10017.abs(var_44_5.y - var_44_6.y) < var_44_3 then
			var_44_3 = var_1_10016
			var_44_4 = var_44_6
		end
	end

	if not arg_44_0:SearchPoint(arg_44_0.grid.position, var_44_4) or #var_10 == 0 then
		return false
	end

	return true, {
		var_5,
		var_10
	}
end

function var_0_0.Dispose(arg_45_0)
	if arg_45_0.timer then
		local var_45_0 = arg_45_0.timer

		var_1.Stop(var_45_0)

		arg_45_0.timer = nil
	end

	if arg_45_0.idleTimer then
		local var_45_1 = arg_45_0.idleTimer

		var_1.Stop(var_45_1)

		arg_45_0.idleTimer = nil
	end

	if arg_45_0.interActionTimer then
		local var_45_2 = arg_45_0.interActionTimer

		var_1.Stop(var_45_2)

		arg_45_0.interActionTimer = nil
	end

	IsNil = var_1

	if not var_1(arg_45_0._go) then
		LeanTween = var_1

		if var_1.isTweening(arg_45_0._go) then
			LeanTween = var_1

			var_1.cancel(arg_45_0._go)
		end
	end

	if arg_45_0.spineChar then
		local var_45_3 = arg_45_0.spineChar

		var_1.Dispose(var_45_3)

		arg_45_0.spineChar = nil
	end

	Destroy = var_1

	var_1(arg_45_0.nameTF)

	if arg_45_0.isCommander then
		Destroy = var_1

		var_1(arg_45_0.tagTF)
	end

	arg_45_0.actionName = nil

	arg_45_0:SetOnMoveCallBack()

	arg_45_0.exited = true

	return
end

return var_0_0
