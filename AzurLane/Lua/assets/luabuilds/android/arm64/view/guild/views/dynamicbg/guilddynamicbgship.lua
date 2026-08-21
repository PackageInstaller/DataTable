local var_0_0 = class("GuildDynamicBgShip")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0._go = arg_1_1.go
	arg_1_0._tf = tf(arg_1_0._go)
	arg_1_0.parent = arg_1_0._tf.parent
	arg_1_0.path = arg_1_1.path
	arg_1_0.speed = 1
	arg_1_0.stepCnt = 0
	arg_1_0.scale = arg_1_0._tf.localScale.x
	arg_1_0.furnitures = arg_1_1.furnitures
	arg_1_0.interAction = nil
	arg_1_0.interActionRatio = 16 / GuildConst.MAX_DISPLAY_MEMBER_SHIP
	arg_1_0.name = arg_1_1.name
	arg_1_0.isCommander = arg_1_1.isCommander
	arg_1_0.spineChar = arg_1_1.char

	arg_1_0:Init(arg_1_1)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0:SetPosition(arg_2_1.grid, true)

	arg_2_0.nameTF = arg_2_0._tf:Find("name")
	arg_2_0.nameTF.localScale = Vector3(1 / arg_2_0.scale, 1 / arg_2_0.scale, 1)
	arg_2_0.nameTF.localPosition = Vector3(0, 300, 0)

	setText(arg_2_0.nameTF, arg_2_0.name)

	if arg_2_0.isCommander then
		arg_2_0.tagTF = arg_2_0._tf:Find("tag")
		arg_2_0.tagTF.localScale = Vector3(1 / arg_2_0.scale, 1 / arg_2_0.scale, 1)
		arg_2_0.tagTF.localPosition = Vector3(0, 380, 0)
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
		arg_4_0.grid:UnlockAll()
	end

	arg_4_0.grid = arg_4_1

	if arg_4_2 then
		arg_4_0._tf.localPosition = arg_4_0.grid:GetCenterPosition()

		arg_4_0:SetAction("stand2")
	end

	if arg_4_0.callback then
		arg_4_0.callback()
	end

	return
end

function var_0_0.AddRandomMove(arg_5_0)
	arg_5_0.stepCnt = math.random(1, 10)
	arg_5_0.timer = Timer.New(function()
		arg_5_0.timer:Stop()

		arg_5_0.timer = nil

		arg_5_0:StartMove()

		return
	end, math.random(1, 8), 1)

	arg_5_0.timer:Start()

	return
end

function var_0_0.IsCanWalkPonit(arg_7_0, arg_7_1)
	if not arg_7_0.path[arg_7_1.x] then
		return false
	end

	if arg_7_0.path[arg_7_1.x][arg_7_1.y] then
		return var_7_0:CanWalk()
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
	local var_9_0 = _.select(arg_9_0.grid:GetAroundGrids(), function(arg_10_0)
		return arg_9_0:IsCanWalkPonit(arg_10_0)
	end)

	if not var_9_0 or #var_9_0 == 0 then
		arg_9_0:AddRandomMove()
	else
		arg_9_0.stepCnt = arg_9_0.stepCnt - 1

		local var_9_1 = var_9_0[math.random(1, #var_9_0)]

		arg_9_0:UpdateShipDir((arg_9_0:GetMoveDir(arg_9_0.path[var_9_1.x][var_9_1.y])))
		arg_9_0:MoveToGrid(arg_9_0.path[var_9_1.x][var_9_1.y])
	end

	return
end

function var_0_0.MoveToGrid(arg_11_0, arg_11_1)
	local function var_11_0()
		arg_11_0:SetAction("stand2")

		arg_11_0.idleTimer = Timer.New(function()
			arg_11_0.idleTimer:Stop()

			arg_11_0.idleTimer = nil

			arg_11_0:AddRandomMove()

			return
		end, math.random(3, 8), 1)

		arg_11_0.idleTimer:Start()

		return
	end

	arg_11_0:MoveNext(arg_11_1, false, function()
		if arg_11_0.stepCnt ~= 0 then
			arg_11_0:StartMove()

			return
		end

		local var_14_0, var_14_1 = arg_11_0:CanInterAction(arg_11_0.interActionRatio)

		if var_14_0 then
			arg_11_0:MoveToFurniture(var_14_1)
		else
			var_11_0()
		end

		return
	end)

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
	arg_15_0:UpdateShipDir((arg_15_0:GetMoveDir(arg_15_1)))

	local var_15_0 = arg_15_1:GetCenterPosition()

	LeanTween.moveLocal(arg_15_0._go, Vector3(var_15_0.x, var_15_0.y, 0), 1 / arg_15_0.speed):setOnComplete(System.Action(function()
		if arg_15_0.exited then
			return
		end

		arg_15_0:SetPosition(arg_15_1)
		arg_15_3()

		return
	end))

	return
end

function var_0_0.MoveLeft(arg_17_0)
	local var_17_0 = Vector2(arg_17_0.grid.position.x - 1, arg_17_0.grid.position.y)
	local var_17_1 = arg_17_0.path[var_17_0.x] and arg_17_0.path[var_17_0.x][var_17_0.y]

	if var_17_1 then
		arg_17_0:MoveNext(var_17_1, false, function()
			arg_17_0:SetAction("stand2")

			return
		end)
	end

	return
end

function var_0_0.MoveRight(arg_19_0)
	local var_19_0 = Vector2(arg_19_0.grid.position.x + 1, arg_19_0.grid.position.y)
	local var_19_1 = arg_19_0.path[var_19_0.x] and arg_19_0.path[var_19_0.x][var_19_0.y]

	if var_19_1 then
		arg_19_0:MoveNext(var_19_1, false, function()
			arg_19_0:SetAction("stand2")

			return
		end)
	end

	return
end

function var_0_0.MoveDown(arg_21_0)
	local var_21_0 = Vector2(arg_21_0.grid.position.x, arg_21_0.grid.position.y - 1)
	local var_21_1 = arg_21_0.path[var_21_0.x] and arg_21_0.path[var_21_0.x][var_21_0.y]

	if var_21_1 then
		arg_21_0:MoveNext(var_21_1, false, function()
			arg_21_0:SetAction("stand2")

			return
		end)
	end

	return
end

function var_0_0.MoveUp(arg_23_0)
	local var_23_0 = Vector2(arg_23_0.grid.position.x, arg_23_0.grid.position.y + 1)
	local var_23_1 = arg_23_0.path[var_23_0.x] and arg_23_0.path[var_23_0.x][var_23_0.y]

	if var_23_1 then
		arg_23_0:MoveNext(var_23_1, false, function()
			arg_23_0:SetAction("stand2")

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

	arg_25_0.spineChar:SetAction(arg_25_1, 0)
	arg_25_0:NorDirByFather()

	return
end

function var_0_0.SetAsLastSibling(arg_26_0)
	arg_26_0._tf:SetAsLastSibling()

	return
end

function var_0_0.MoveToFurniture(arg_27_0, arg_27_1)
	arg_27_1[1]:Lock()

	for iter_27_0, iter_27_1 in ipairs(arg_27_1[2]) do
		arg_27_0.path[iter_27_1.x][iter_27_1.y]:Lock()
	end

	arg_27_0:MoveByPath(arg_27_1[2], function()
		arg_27_0:InterActionFurniture(var_0)

		return
	end)

	return
end

function var_0_0.UpdateNameAndTagDir(arg_29_0, arg_29_1)
	if arg_29_0.nameTF then
		arg_29_0.nameTF.localScale = Vector3(1 / arg_29_0.scale * arg_29_1, 1 / arg_29_0.scale, 1)
	end

	if arg_29_0.isCommander and arg_29_0.tagTF then
		arg_29_0.tagTF.localScale = Vector3(1 / arg_29_0.scale * arg_29_1, 1 / arg_29_0.scale, 1)
	end

	return
end

function var_0_0.UpdateShipDir(arg_30_0, arg_30_1)
	arg_30_0._tf.localScale = Vector3(arg_30_1 * arg_30_0.scale, arg_30_0.scale, arg_30_0.scale)

	arg_30_0:UpdateNameAndTagDir(arg_30_1)

	return
end

function var_0_0.NorDirByFather(arg_31_0)
	arg_31_0:UpdateNameAndTagDir(arg_31_0._tf.localScale.x < 0 and -1 or 1)

	return
end

function var_0_0.InterActionFurniture(arg_32_0, arg_32_1)
	setParent(arg_32_0._tf, arg_32_1._tf)

	local var_32_0 = arg_32_1:GetInteractionDir()

	arg_32_0:UpdateShipDir(var_32_0)

	arg_32_0._tf.anchoredPosition = arg_32_1:GetInterActionPos()

	local var_32_1

	if GuildDynamicFurniture.INTERACTION_MODE_SIT == arg_32_1:GetInterActionMode() then
		var_32_1 = "sit"
	end

	assert(var_32_1)
	arg_32_0:SetAction(var_32_1)
	arg_32_0:UpdateShipDir(var_32_0)
	arg_32_0:CancelInterAction(arg_32_1)

	return
end

function var_0_0.CancelInterAction(arg_33_0, arg_33_1)
	arg_33_0.interActionTimer = Timer.New(function()
		arg_33_0.interActionTimer:Stop()

		arg_33_0.interActionTimer = nil

		arg_33_1:Unlock()
		setParent(arg_33_0._tf, arg_33_0.parent)
		assert(arg_33_0.grid)
		arg_33_0:SetPosition(arg_33_0.grid, true)
		arg_33_0:NorDirByFather()
		arg_33_0:AddRandomMove()

		return
	end, math.random(15, 30), 1)

	arg_33_0.interActionTimer:Start()

	return
end

function var_0_0.MoveByPath(arg_35_0, arg_35_1, arg_35_2)
	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		table.insert({}, function(arg_36_0)
			if arg_35_0.exited then
				return
			end

			arg_35_0:MoveNext(arg_35_0.path[iter_35_1.x][iter_35_1.y], true, arg_36_0)

			return
		end)
	end

	seriesAsync({}, arg_35_2)

	return
end

function var_0_0.SearchPoint(arg_37_0, arg_37_1, arg_37_2)
	local function var_37_0(arg_42_0, arg_42_1, arg_42_2)
		return math.abs(arg_42_2.x - arg_42_0.x) + math.abs(arg_42_2.y - arg_42_0.y) < math.abs(arg_42_2.x - arg_42_1.x) + math.abs(arg_42_2.y - arg_42_1.y)
	end

	local var_37_1

	table.insert({}, {
		parent = 0,
		point = arg_37_1
	})

	while #{} > 0 do
		local var_37_2 = table.remove({}, 1)

		if var_37_2.point == arg_37_2 then
			var_37_1 = var_37_2

			break
		end

		table.insert({}, var_37_2.point)

		for iter_37_0, iter_37_1 in ipairs((function(arg_41_0)
			table.insert({}, Vector2(arg_41_0.x + 1, arg_41_0.y))
			table.insert({}, Vector2(arg_41_0.x - 1, arg_41_0.y))
			table.insert({}, Vector2(arg_41_0.x, arg_41_0.y + 1))
			table.insert({}, Vector2(arg_41_0.x, arg_41_0.y - 1))

			return {}
		end)(var_37_2.point)) do
			if (function(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
				if _.any(arg_38_0, function(arg_39_0)
					return arg_38_2 == arg_39_0.point
				end) or _.any(arg_38_1, function(arg_40_0)
					return arg_38_2 == arg_40_0
				end) then
					return false
				end

				if arg_37_0.path[arg_38_2.x] then
					return arg_37_0.path[arg_38_2.x][arg_38_2.y] and arg_37_0.path[arg_38_2.x][arg_38_2.y]:CanWalk()
				end

				return false
			end)({}, {}, iter_37_1, arg_37_2) then
				table.insert({}, {
					point = iter_37_1,
					parent = var_37_2
				})
			else
				if iter_37_1 == arg_37_2 then
					var_37_1 = var_37_2

					break
				end

				table.insert({}, iter_37_1)
			end
		end

		table.sort({}, function(arg_43_0, arg_43_1)
			return var_37_0(arg_43_0.point, arg_43_1.point, arg_37_2)
		end)
	end

	if var_37_1 then
		while var_37_1.parent ~= 0 do
			table.insert({}, 1, var_37_1.point)

			var_37_1 = var_37_1.parent
		end
	end

	return {}
end

function var_0_0.CanInterAction(arg_44_0, arg_44_1)
	if arg_44_1 < math.random(1, 10000) then
		return false
	end

	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_0.furnitures) do
		if not iter_44_1:BeLock() then
			table.insert(var_44_0, iter_44_1)
		end
	end

	if #var_44_0 == 0 then
		return false
	end

	local var_44_1 = var_44_0[math.random(1, #var_44_0)]
	local var_44_2

	for iter_44_2, iter_44_3 in ipairs((var_44_1:GetOccupyGrid())) do
		local var_44_3 = math.abs(arg_44_0.grid.position.x - iter_44_3.position.x) + math.abs(arg_44_0.grid.position.y - iter_44_3.position.y)
		local var_44_4

		if var_44_3 < 999999 then
			var_44_4 = var_44_3
			var_44_2 = iter_44_3.position
		end
	end

	local var_44_5 = arg_44_0:SearchPoint(arg_44_0.grid.position, var_44_2)

	if not var_44_5 or #var_44_5 == 0 then
		return false
	end

	return true, {
		var_44_1,
		var_44_5
	}
end

function var_0_0.Dispose(arg_45_0)
	if arg_45_0.timer then
		arg_45_0.timer:Stop()

		arg_45_0.timer = nil
	end

	if arg_45_0.idleTimer then
		arg_45_0.idleTimer:Stop()

		arg_45_0.idleTimer = nil
	end

	if arg_45_0.interActionTimer then
		arg_45_0.interActionTimer:Stop()

		arg_45_0.interActionTimer = nil
	end

	if not IsNil(arg_45_0._go) and LeanTween.isTweening(arg_45_0._go) then
		LeanTween.cancel(arg_45_0._go)
	end

	if arg_45_0.spineChar then
		arg_45_0.spineChar:Dispose()

		arg_45_0.spineChar = nil
	end

	Destroy(arg_45_0.nameTF)

	if arg_45_0.isCommander then
		Destroy(arg_45_0.tagTF)
	end

	arg_45_0.actionName = nil

	arg_45_0:SetOnMoveCallBack()

	arg_45_0.exited = true

	return
end

return var_0_0
