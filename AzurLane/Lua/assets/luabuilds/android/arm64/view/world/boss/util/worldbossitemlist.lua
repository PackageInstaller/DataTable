local var_0_0 = class("WorldBossItemList")
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
	arg_1_0.trigger = arg_1_0.container:GetComponent(typeof(EventTriggerListener))
	arg_1_0.hrzOffset = (arg_1_0.tplHeight + arg_1_0.space) / math.tan((90 - arg_1_0.angle) * math.rad(1))
	arg_1_0.capacity = math.ceil(arg_1_0.container.parent.parent.rect.height / (arg_1_0.tplHeight + arg_1_0.space))

	for iter_1_0 = 1, arg_1_0.capacity do
		cloneTplTo(arg_1_0.tpl, arg_1_0.container, iter_1_0)
	end

	arg_1_0.OnSwitch = nil
	arg_1_0.OnRelease = nil

	setActive(arg_1_0.tpl, false)

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
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.tweens) do
		if LeanTween.isTweening(iter_3_1) then
			LeanTween.cancel(iter_3_1)
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
	arg_4_0.midIndex = math.ceil(arg_4_0.capacity * 0.5)
	arg_4_0.ranges = {
		math.huge,
		math.huge,
		arg_4_0.capacity - arg_4_0.midIndex + 1,
		arg_4_0.midIndex - 1
	}

	if arg_4_1 < arg_4_0.capacity then
		local var_4_0 = math.floor(arg_4_1 * 0.5) + 1

		arg_4_0.ranges[1] = arg_4_1 - var_4_0
		arg_4_0.ranges[2] = var_4_0
	end

	arg_4_0:InitList()

	return
end

function var_0_0.InitList(arg_5_0)
	for iter_5_0 = 1, arg_5_0.capacity do
		local var_5_0 = arg_5_0.container:GetChild(iter_5_0 - 1)

		var_5_0.localScale = Vector3.one

		var_5_0.gameObject:SetActive(true)
		table.insert(arg_5_0.childs, {
			index = -9999,
			tr = var_5_0
		})
	end

	arg_5_0.animTime = 0

	arg_5_0:Switch()

	local var_5_1 = arg_5_0.value - 1
	local var_5_2 = 1

	if arg_5_0.totalCnt < arg_5_0.capacity and arg_5_0.value > arg_5_0.ranges[2] then
		var_5_2 = -1
		var_5_1 = arg_5_0.totalCnt - arg_5_0.value + 1
	end

	for iter_5_1 = 1, var_5_1 do
		arg_5_0:Switch(var_5_2)
	end

	arg_5_0:Release()

	arg_5_0.animTime = 0.05

	return
end

function var_0_0.AddListener(arg_6_0)
	local var_6_0 = Vector2.zero
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

	arg_6_0.trigger:AddBeginDragFunc(function(arg_8_0, arg_8_1)
		if arg_6_0.animFlag then
			return
		end

		var_6_1, var_6_2 = 0, 0
		var_6_0 = arg_8_1.position
		var_6_3 = var_6_0.y
		var_6_4 = true

		return
	end)
	arg_6_0.trigger:AddDragFunc(function(arg_9_0, arg_9_1)
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

		if not var_6_5(arg_9_1.position.y - var_6_0.y) then
			var_6_4 = false

			return
		end

		local var_9_1 = math.abs(var_9_0 / arg_6_0.distance)

		if var_9_1 > var_6_2 then
			var_6_2 = var_9_1

			arg_6_0:Switch(var_9_0)
		end

		if var_9_1 < var_6_1 then
			var_6_1 = var_9_1

			arg_6_0:Switch(var_9_0)
		end

		var_6_3 = var_6_0.y

		return
	end)
	arg_6_0.trigger:AddDragEndFunc(function(arg_10_0, arg_10_1)
		if not var_6_4 then
			return
		end

		arg_6_0:Release()

		return
	end)

	return
end

function var_0_0.RefreshChildPos(arg_11_0, arg_11_1)
	arg_11_0.animFlag, arg_11_0.padding = true, 0

	local var_11_0 = arg_11_0.midIndex

	for iter_11_0 = 1, #arg_11_0.childs do
		local var_11_1 = arg_11_0.childs[iter_11_0].tr

		if not IsNil(arg_11_0.childs[iter_11_0].tr) then
			local var_11_2 = iter_11_0 - 1

			if iter_11_0 == var_11_0 or iter_11_0 == var_11_0 + 1 then
				arg_11_0.padding = arg_11_0.padding + math.abs(arg_11_0.space) * 2
			end

			if arg_11_0.totalCnt == 0 then
				arg_11_0.padding = 0
			end

			local var_11_3 = Vector3(-arg_11_0.hrzOffset * var_11_2 - arg_11_0.padding / math.tan((90 - arg_11_0.angle) * math.rad(1)), -1 * (arg_11_0.tplHeight + arg_11_0.space) * var_11_2 - arg_11_0.padding, 0)
			local var_11_4 = var_11_3

			if arg_11_1 and var_11_3.y < var_11_1.localPosition.y then
				var_11_4 = Vector3(arg_11_0.hrzOffset, arg_11_0.tplHeight + arg_11_0.space, 0)
			elseif not arg_11_1 and var_11_3.y > var_11_1.localPosition.y then
				var_11_1.localPosition = Vector3(arg_11_0.hrzOffset, arg_11_0.tplHeight + arg_11_0.space, 0)
			end

			if iter_11_0 == var_11_0 or arg_11_0.animTime <= 0 then
				var_11_1:SetAsLastSibling()

				var_11_1.localPosition = var_11_3
			end

			table.insert(arg_11_0.tweens, var_11_1.gameObject)
			LeanTween.moveLocal(var_11_1.gameObject, var_11_4, arg_11_0.animTime):setOnComplete(System.Action(function()
				if not IsNil(var_11_1) then
					var_11_1.localPosition = var_11_3
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
		local var_13_0 = table.remove(arg_13_0.childs, arg_13_1 > 0 and 1 or #arg_13_0.childs)
		local var_13_2 = arg_13_0.childs

		if arg_13_1 > 0 then
			local var_13_3 = #arg_13_0.childs + 1 or 1

			var_13_1(var_13_2, var_13_3, var_13_0)

			arg_13_0.index = (arg_13_1 > 0 and 1 or -1) + arg_13_0.index

			local var_13_4 = 0
			local var_13_5 = 0

			if arg_13_0.totalCnt < arg_13_0.capacity then
				var_13_5 = math.min(arg_13_0.ranges[4] - arg_13_0.ranges[1] - arg_13_0.index, arg_13_0.ranges[4])
				var_13_4 = math.min(arg_13_0.ranges[3] - arg_13_0.ranges[2] + arg_13_0.index, arg_13_0.ranges[3])
			end

			local var_13_6 = arg_13_0.index % arg_13_0.totalCnt

			for iter_13_0, iter_13_1 in ipairs(arg_13_0.childs) do
				local var_13_7 = iter_13_1.index

				iter_13_1.index = (var_13_5 > 0 and iter_13_0 <= var_13_5 or var_13_4 > 0 and var_13_4 > arg_13_0.capacity - iter_13_0) and -1 or (iter_13_0 - arg_13_0.midIndex + var_13_6) % arg_13_0.totalCnt

				if var_13_7 ~= iter_13_1.index and arg_13_0.OnInit then
					arg_13_0.OnInit(iter_13_1.tr, iter_13_1.index)
				end
			end

			arg_13_0:RefreshChildPos((arg_13_1 or 0) > 0)

			if arg_13_0.OnSwitch ~= nil then
				arg_13_0.OnSwitch(arg_13_0.childs[arg_13_0.midIndex].tr, arg_13_0.childs[arg_13_0.midIndex].index)
			end

			return
		end
	end
end

function var_0_0.SliceTo(arg_14_0, arg_14_1)
	if arg_14_0.animFlag then
		return
	end

	local var_14_0 = -1

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.childs) do
		if iter_14_1.tr == arg_14_1 then
			var_14_0 = iter_14_0

			break
		end
	end

	local var_14_1

	if var_14_0 == -1 then
		do return end

		var_14_1 = Mathf.Sign(var_14_0 - arg_14_0.midIndex)
	end

	for iter_14_2 = 1, math.abs(var_14_0 - arg_14_0.midIndex) do
		table.insert({}, function(arg_15_0)
			arg_14_0:Switch(var_14_1)
			Timer.New(arg_15_0, arg_14_0.animTime * 2, 1):Start()

			return
		end)
	end

	seriesAsync({}, function()
		arg_14_0:Release()

		return
	end)

	return
end

function var_0_0.Release(arg_17_0)
	if arg_17_0.OnRelease ~= nil then
		arg_17_0.OnRelease(arg_17_0.childs[arg_17_0.midIndex].tr, arg_17_0.childs[arg_17_0.midIndex].index)
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
