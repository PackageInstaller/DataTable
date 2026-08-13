class = var_0_10000

local var_0_0 = var_0_10000("WorldBossItemList")
local var_0_1 = 18
local var_0_2 = -15
local var_0_3 = 100

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.tpl = arg_1_2
	arg_1_0.container = arg_1_1
	arg_1_0.angle = var_0_1
	arg_1_0.space = var_0_2
	arg_1_0.distance = var_0_3
	arg_1_0.tplHeight = arg_1_0.tpl.rect.height

	local var_1_0 = arg_1_0.container
	local var_1_1 = var_3.GetComponent

	typeof = var_1_10006
	EventTriggerListener = var_1_10008
	arg_1_0.trigger = var_1_1(var_1_0, var_1_10006(var_1_10008))

	local var_1_2 = arg_1_0.tplHeight + arg_1_0.space

	math = var_4

	local var_1_3 = var_4.tan
	local var_1_4 = 90 - arg_1_0.angle

	math = var_1_10007
	arg_1_0.hrzOffset = var_1_2 / var_1_3(var_1_4 * var_1_10007.rad(1))
	math = var_3
	arg_1_0.capacity = var_3.ceil(arg_1_0.container.parent.parent.rect.height / (arg_1_0.tplHeight + arg_1_0.space))

	for iter_1_0 = 1, arg_1_0.capacity do
		cloneTplTo = var_7

		var_7(arg_1_0.tpl, arg_1_0.container, iter_1_0)
	end

	arg_1_0.OnSwitch = nil
	arg_1_0.OnRelease = nil
	setActive = var_3

	var_3(arg_1_0.tpl, false)

	arg_1_0.tweens = {}

	arg_1_0:AddListener()

	return
end

function var_0_0.Make(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.OnInit = arg_2_1
	arg_2_0.OnSwitch = arg_2_2
	arg_2_0.OnRelease = arg_2_3

	return
end

function var_0_0.ClearTweens(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0.tweens) do
		LeanTween = var_1_10006

		if var_1_10006.isTweening(iter_3_1) then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_3_1)
		end
	end

	arg_3_0.tweens = {}

	return
end

function var_0_0.Align(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:ClearTweens()

	arg_4_0.childs = {}
	arg_4_0.padding = 0
	arg_4_0.animFlag = false
	arg_4_0.totalCnt = arg_4_1
	arg_4_0.index = 0
	arg_4_0.value = arg_4_2 and arg_4_2 or 0
	math = var_3
	arg_4_0.midIndex = var_3.ceil(arg_4_0.capacity * 0.5)

	local var_4_0 = {}

	math = var_1_10004
	var_4_0[1] = var_1_10004.huge
	math = var_4
	var_4_0[2] = var_4.huge
	var_4_0[3] = arg_4_0.capacity - arg_4_0.midIndex + 1
	var_4_0[4] = arg_4_0.midIndex - 1
	arg_4_0.ranges = var_4_0

	if arg_4_1 < arg_4_0.capacity then
		math = var_3

		local var_4_1 = var_3.floor(arg_4_1 * 0.5) + 1

		arg_4_0.ranges[1] = arg_4_1 - var_4_1
		arg_4_0.ranges[2] = var_4_1
	end

	arg_4_0:InitList()

	return
end

function var_0_0.InitList(arg_5_0)
	for iter_5_0 = 1, arg_5_0.capacity do
		local var_5_0 = arg_5_0.container
		local var_5_1 = var_5.GetChild(var_5_0, iter_5_0 - 1)

		Vector3 = var_1_10006
		var_5_1.localScale = var_1_10006.one

		local var_5_2 = var_5_1.gameObject

		var_1_10006.SetActive(var_5_2, true)

		table = var_1_10006

		var_1_10006.insert(arg_5_0.childs, {
			index = -9999,
			tr = var_5_1
		})
	end

	arg_5_0.animTime = 0

	arg_5_0:Switch()

	local var_5_3 = arg_5_0.value - 1
	local var_5_4 = 1

	if arg_5_0.totalCnt < arg_5_0.capacity and arg_5_0.value > arg_5_0.ranges[2] then
		var_5_3, var_5_4 = arg_5_0.totalCnt - arg_5_0.value + 1, -1
	end

	for iter_5_1 = 1, var_5_3 do
		arg_5_0:Switch(var_5_4)
	end

	arg_5_0:Release()

	arg_5_0.animTime = 0.05

	return
end

function var_0_0.AddListener(arg_6_0)
	Vector2 = var_1_10001

	local var_6_0 = var_1_10001.zero
	local var_6_1 = 0
	local var_6_2 = 0
	local var_6_3 = 0
	local var_6_4 = true

	local function var_6_5(arg_7_0)
		if arg_7_0 > 0 then
			return arg_6_0.index < arg_6_0.ranges[2] - 1
		else
			return arg_6_0.index > -arg_6_0.ranges[1]
		end

		return
	end

	local var_6_6 = arg_6_0.trigger

	var_7.AddBeginDragFunc(var_6_6, function(arg_8_0, arg_8_1)
		if arg_6_0.animFlag then
			return
		end

		var_6_1, var_6_2 = 0, 0
		var_6_0 = arg_8_1.position
		var_6_3 = var_6_0.y
		var_6_4 = true

		return
	end)

	local var_6_7 = arg_6_0.trigger

	var_7.AddDragFunc(var_6_7, function(arg_9_0, arg_9_1)
		if arg_6_0.animFlag then
			return
		end

		if var_6_3 > arg_9_1.position.y and var_6_1 ~= 0 then
			var_6_0, var_6_1 = arg_9_1.position, 0
		end

		if var_6_3 < arg_9_1.position.y and var_6_2 ~= 0 then
			var_6_0, var_6_2 = arg_9_1.position, 0
		end

		local var_9_0 = arg_9_1.position.y - var_6_0.y

		if not var_6_5(var_9_0) then
			var_6_4 = false

			return
		end

		math = var_3

		if var_3.abs(var_9_0 / arg_6_0.distance) > var_6_2 then
			var_6_2 = var_3

			local var_9_1 = arg_6_0

			var_4.Switch(var_9_1, var_9_0)
		end

		if var_3 < var_6_1 then
			var_6_1 = var_3

			local var_9_2 = arg_6_0

			var_4.Switch(var_9_2, var_9_0)
		end

		var_6_3 = var_6_0.y

		return
	end)

	local var_6_8 = arg_6_0.trigger

	var_7.AddDragEndFunc(var_6_8, function(arg_10_0, arg_10_1)
		if not var_6_4 then
			return
		end

		local var_10_0 = arg_6_0

		var_2.Release(var_10_0)

		return
	end)

	return
end

function var_0_0.RefreshChildPos(arg_11_0, arg_11_1)
	arg_11_0.animFlag, arg_11_0.padding = true, 0

	local var_11_0 = arg_11_0.midIndex

	for iter_11_0 = 1, #arg_11_0.childs do
		local var_11_1 = arg_11_0.childs[iter_11_0].tr

		IsNil = var_1_10008

		if not var_1_10008(var_11_1) then
			var_1_10008 = iter_11_0 - 1

			if iter_11_0 == var_11_0 or iter_11_0 == var_11_0 + 1 then
				local var_11_2 = arg_11_0.padding

				math = var_10
				arg_11_0.padding = var_11_2 + var_10.abs(arg_11_0.space) * 2
			end

			if arg_11_0.totalCnt == 0 then
				arg_11_0.padding = 0
			end

			local var_11_3 = arg_11_0.padding

			math = var_10

			local var_11_4 = var_10.tan
			local var_11_5 = 90 - arg_11_0.angle

			math = var_1_10013

			local var_11_6 = var_11_3 / var_11_4(var_11_5 * var_1_10013.rad(1))

			Vector3 = var_10

			local var_11_7 = var_10(-arg_11_0.hrzOffset * var_1_10008 - var_11_6, -1 * (arg_11_0.tplHeight + arg_11_0.space) * var_1_10008 - arg_11_0.padding, 0)
			local var_11_8

			if arg_11_1 and var_10.y < var_11_1.localPosition.y then
				Vector3 = var_11_8
				var_11_7 = var_11_8(arg_11_0.hrzOffset, arg_11_0.tplHeight + arg_11_0.space, 0)
			elseif not arg_11_1 then
				var_11_8 = var_10.y

				if var_11_1.localPosition.y < var_11_8 then
					Vector3 = var_11_8
					var_11_1.localPosition = var_11_8(arg_11_0.hrzOffset, arg_11_0.tplHeight + arg_11_0.space, 0)
				end
			end

			if iter_11_0 == var_11_0 or arg_11_0.animTime <= 0 then
				var_11_1:SetAsLastSibling()

				var_11_1.localPosition = var_10
			end

			table = var_11_8

			var_11_8.insert(arg_11_0.tweens, var_11_1.gameObject)

			LeanTween = var_12

			local var_11_9 = var_12.moveLocal(var_11_1.gameObject, var_11_7, arg_11_0.animTime)
			local var_11_10 = var_12.setOnComplete

			System = var_15

			var_11_10(var_11_9, var_15.Action(function()
				IsNil = var_2_10000

				if not var_2_10000(var_11_1) then
					var_11_1.localPosition = var_0
				end

				arg_11_0.animFlag = false

				return
			end))
		end
	end

	return
end

function var_0_0.Switch(arg_13_0, arg_13_1)
	if arg_13_1 then
		table = var_1_10002

		local var_13_0 = var_1_10002.remove(arg_13_0.childs, arg_13_1 > 0 and 1 or #arg_13_0.childs)

		table = var_1_10003

		local var_13_1 = var_1_10003.insert
		local var_13_2 = arg_13_0.childs
		local var_13_3

		if not (arg_13_1 > 0) or not (#arg_13_0.childs + 1) then
			var_13_3 = 1
		end

		var_13_1(var_13_2, var_13_3, var_13_0)

		arg_13_0.index = (arg_13_1 > 0 and 1 or -1) + arg_13_0.index
	end

	local var_13_4 = 0
	local var_13_5 = 0

	if arg_13_0.totalCnt < arg_13_0.capacity then
		math = var_4
		var_13_5 = var_4.min(arg_13_0.ranges[4] - arg_13_0.ranges[1] - arg_13_0.index, arg_13_0.ranges[4])
		math = var_4
		var_13_4 = var_4.min(arg_13_0.ranges[3] - arg_13_0.ranges[2] + arg_13_0.index, arg_13_0.ranges[3])
	end

	local var_13_6 = arg_13_0.index % arg_13_0.totalCnt

	ipairs = var_5

	for iter_13_0, iter_13_1 in var_5(arg_13_0.childs) do
		local var_13_7 = iter_13_1.index
		local var_13_8 = iter_13_0 - arg_13_0.midIndex

		if var_13_5 > 0 and iter_13_0 <= var_13_5 or var_13_4 > 0 and var_13_4 > arg_13_0.capacity - iter_13_0 then
			iter_13_1.index = -1
		else
			iter_13_1.index = (var_13_8 + var_13_6) % arg_13_0.totalCnt
		end

		if var_13_7 ~= iter_13_1.index and arg_13_0.OnInit then
			arg_13_0.OnInit(iter_13_1.tr, iter_13_1.index)
		end
	end

	arg_13_0:RefreshChildPos((arg_13_1 or 0) > 0)

	local var_13_9 = arg_13_0.childs[arg_13_0.midIndex]

	if arg_13_0.OnSwitch ~= nil then
		arg_13_0.OnSwitch(var_13_9.tr, var_13_9.index)
	end

	return
end

function var_0_0.SliceTo(arg_14_0, arg_14_1)
	if arg_14_0.animFlag then
		return
	end

	local var_14_0 = -1

	ipairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0.childs) do
		if iter_14_1.tr == arg_14_1 then
			var_14_0 = iter_14_0

			break
		end
	end

	if var_14_0 == -1 then
		return
	end

	local var_14_1 = var_14_0 - arg_14_0.midIndex

	Mathf = var_4

	local var_14_2 = var_4.Sign(var_14_1)
	local var_14_3 = {}
	local var_14_4 = 1

	math = iter_14_1

	for iter_14_2 = var_14_4, iter_14_1.abs(var_14_1) do
		table = var_1_10010

		var_1_10010.insert(var_14_3, function(arg_15_0)
			local var_15_0 = arg_14_0

			var_1.Switch(var_15_0, var_14_2)

			Timer = var_1

			local var_15_1 = var_1.New(arg_15_0, arg_14_0.animTime * 2, 1)

			var_1.Start(var_15_1)

			return
		end)
	end

	seriesAsync = var_14_4

	var_14_4(var_14_3, function()
		local var_16_0 = arg_14_0

		var_0.Release(var_16_0)

		return
	end)

	return
end

function var_0_0.Release(arg_17_0)
	local var_17_0 = arg_17_0.childs[arg_17_0.midIndex]

	if arg_17_0.OnRelease ~= nil then
		arg_17_0.OnRelease(var_17_0.tr, var_17_0.index)
	end

	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:ClearTweens()

	arg_18_0.OnSwitch = nil
	arg_18_0.OnRelease = nil
	arg_18_0.OnInit = nil

	return
end

return var_0_0
