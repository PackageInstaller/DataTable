local var_0_0 = class("CourtYardFurnitureJob")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.poolMgr = arg_1_1
	arg_1_0.state = var_0_1
	arg_1_0.callback = arg_1_2
	arg_1_0.rollBacks = {}

	return
end

function var_0_0.IsWorking(arg_2_0)
	return arg_2_0.state == var_0_2
end

function var_0_0.InstantiateObj(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Object.Instantiate(arg_3_1, arg_3_2)

	table.insert(arg_3_0.rollBacks, var_3_0)

	return var_3_0
end

function var_0_0.CloneTplTo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = Object.Instantiate(arg_4_1, arg_4_2).transform

	if arg_4_3 then
		var_4_0.name = arg_4_3
	end

	return var_4_0
end

function var_0_0.Work(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_2.id

	if arg_5_1:IsExit() then
		arg_5_0:FinishWork(false)

		return
	end

	arg_5_0.state = var_0_2

	local var_5_0 = arg_5_1._tf

	arg_5_0.module = arg_5_1
	arg_5_0.rollBacks = {}

	if arg_5_2:IsSpine() then
		arg_5_0:LoadSpine(arg_5_1._tf, arg_5_2, function()
			if arg_5_1:IsExit() then
				arg_5_0:FinishWork(false)
			else
				arg_5_1:Init(var_5_0)
				arg_5_0:FinishWork(true)
			end

			return
		end, function()
			arg_5_1:OnIconLoaed()

			return
		end)
	else
		arg_5_0:Load(arg_5_1._tf, arg_5_2, function()
			if arg_5_1:IsExit() then
				arg_5_0:FinishWork(false)
			else
				arg_5_1:Init(var_5_0)
				arg_5_0:FinishWork(true)
			end

			return
		end, function()
			arg_5_1:OnIconLoaed()

			return
		end)
	end

	return
end

local function var_0_4(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	ResourceMgr.Inst:getAssetAsync("furnitrues/" .. arg_8_2:GetPicture(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_9_0)
		if arg_8_0:IsStop() or IsNil(arg_8_1) or IsNil(arg_9_0) then
			arg_8_0:OnStop()

			return
		end

		local var_9_0 = arg_8_0:InstantiateObj(arg_9_0, arg_8_1).transform

		var_9_0.name = "icon"

		var_9_0:SetSiblingIndex(1)

		var_9_0.anchorMin = var_9_0.pivot
		var_9_0.anchorMax = var_9_0.pivot

		arg_8_0:AdjustModel(arg_8_1, var_9_0.sizeDelta, var_9_0.pivot)
		arg_8_3()

		return
	end), true, true)

	return
end

local function var_0_5(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	for iter_10_0, iter_10_1 in pairs((arg_10_2:GetMaskNames())) do
		table.insert({}, function(arg_11_0)
			ResourceMgr.Inst:getAssetAsync("furnitrues/" .. iter_10_1, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_12_0)
				if arg_10_0:IsStop() or IsNil(arg_10_1) or IsNil(arg_12_0) then
					arg_10_0:OnStop()

					return
				end

				local var_12_0 = arg_10_0:InstantiateObj(arg_12_0, arg_10_1:Find("masks"))

				var_12_0.name = "icon_front_" .. iter_10_0
				var_12_0.transform.anchorMin = var_12_0.transform.pivot
				var_12_0.transform.anchorMax = var_12_0.transform.pivot

				var_12_0.transform:SetSiblingIndex(2)
				setActive(var_12_0, false)
				arg_11_0()

				return
			end), true, true)

			return
		end)
	end

	seriesAsync({}, arg_10_3)

	return
end

local function var_0_6(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0.poolMgr.root:Find("mask")

	for iter_13_0, iter_13_1 in pairs((arg_13_2:GetBodyMasks())) do
		local var_13_1 = arg_13_0:CloneTplTo(var_13_0, arg_13_1:Find("interaction"), "body_mask" .. iter_13_0)

		var_13_1.anchoredPosition = iter_13_1.offset
		var_13_1.sizeDelta = iter_13_1.size

		if iter_13_1.img then
			local var_13_2 = ResourceMgr.Inst:getAssetSync("furnitrues/" .. iter_13_1.img, "", true, true)

			var_13_1:GetComponent(typeof(Image)).sprite = var_13_2:GetComponent(typeof(Image)).sprite
		end
	end

	arg_13_3()

	return
end

local function var_0_7(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2:GetType() == Furniture.TYPE_ARCH then
		local var_14_0 = arg_14_2:GetArchMask()

		if not checkABExist("furnitrues/" .. var_14_0) then
			arg_14_3()

			return
		end

		ResourceMgr.Inst:getAssetAsync("furnitrues/" .. var_14_0, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_15_0)
			if arg_14_0:IsStop() or IsNil(arg_14_1) or IsNil(arg_15_0) then
				arg_14_0:OnStop()

				return
			end

			local var_15_0 = arg_14_0:InstantiateObj(arg_15_0, arg_14_1:Find("masks"))

			var_15_0.name = "icon_front_arch"
			var_15_0.transform.anchorMin = var_15_0.transform.pivot
			var_15_0.transform.anchorMax = var_15_0.transform.pivot

			arg_14_3()

			return
		end), true, true)
	else
		arg_14_3()
	end

	return
end

local function var_0_8(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	ResourceMgr.Inst:getAssetAsync("sfurniture/" .. arg_16_2:GetFirstSlot():GetName(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_17_0)
		if arg_16_0:IsStop() or IsNil(arg_16_1) or IsNil(arg_17_0) then
			arg_16_0:OnStop()

			return
		end

		local var_17_0 = arg_16_0:InstantiateObj(arg_17_0, arg_16_1)

		arg_16_0:AdjustModel(arg_16_1, var_17_0.transform.sizeDelta, var_17_0.transform.pivot)

		var_17_0.name = "spine_icon"
		var_17_0.transform.localPosition = Vector3(0, 0, 0)

		var_17_0.transform:SetSiblingIndex(1)
		arg_16_3()

		return
	end), true, true)

	return
end

local function var_0_9(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	for iter_18_0, iter_18_1 in ipairs((arg_18_2:GetMaskNames())) do
		table.insert({}, function(arg_19_0)
			ResourceMgr.Inst:getAssetAsync("sfurniture/" .. iter_18_1, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_20_0)
				if arg_18_0:IsStop() or IsNil(arg_18_1) or IsNil(arg_20_0) then
					arg_18_0:OnStop()

					return
				end

				local var_20_0 = arg_18_0:InstantiateObj(arg_20_0, arg_18_1:Find("masks"))

				var_20_0.name = "icon_front_" .. iter_18_0
				var_20_0.transform.localPosition = Vector3(0, 0, 0)

				setActive(var_20_0, false)
				arg_19_0()

				return
			end), true, true)

			return
		end)
	end

	seriesAsync({}, arg_18_3)

	return
end

local function var_0_10(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_2:GetAnimatorMask()

	if var_21_0 then
		local var_21_1 = arg_21_0:CloneTplTo(arg_21_0.poolMgr.root:Find("mask"), arg_21_1:Find("interaction"), "animtor_mask")

		var_21_1.sizeDelta = var_21_0.size

		setAnchoredPosition(var_21_1, var_21_0.offset)
	end

	local var_21_2 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_2:GetAnimators()) do
		local var_21_3 = iter_21_1.key
		local var_21_4 = iter_21_1.value

		table.insert(var_21_2, function(arg_22_0)
			ResourceMgr.Inst:getAssetAsync("sfurniture/" .. var_21_4, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_23_0)
				if arg_21_0:IsStop() or IsNil(arg_21_1) or IsNil(arg_23_0) then
					arg_21_0:OnStop()

					return
				end

				local var_23_0 = arg_21_1:Find("interaction")
				local var_23_1 = var_21_0 and var_23_0:Find("animtor_mask") or var_23_0
				local var_23_2 = arg_21_0:InstantiateObj(arg_23_0, var_23_1)

				var_23_2.name = "Animator" .. var_21_3

				setActive(var_23_2, false)
				arg_22_0()

				return
			end), true, true)

			return
		end)
	end

	parallelAsync(var_21_2, arg_21_3)

	return
end

function var_0_0.Load(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	seriesAsync({
		function(arg_25_0)
			var_0_6(arg_24_0, arg_24_1.transform, arg_24_2, arg_25_0)

			return
		end,
		function(arg_26_0)
			var_0_4(arg_24_0, arg_24_1.transform, arg_24_2, function()
				arg_24_4()
				arg_26_0()

				return
			end)

			return
		end,
		function(arg_28_0)
			var_0_5(arg_24_0, arg_24_1.transform, arg_24_2, arg_28_0)

			return
		end,
		function(arg_29_0)
			var_0_7(arg_24_0, arg_24_1.transform, arg_24_2, arg_29_0)

			return
		end
	}, arg_24_3)

	return
end

function var_0_0.LoadSpine(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	arg_30_0.working = true

	seriesAsync({
		function(arg_31_0)
			var_0_6(arg_30_0, arg_30_1.transform, arg_30_2, arg_31_0)

			return
		end,
		function(arg_32_0)
			var_0_8(arg_30_0, arg_30_1, arg_30_2, function()
				arg_30_4()
				arg_32_0()

				return
			end)

			return
		end,
		function(arg_34_0)
			var_0_9(arg_30_0, arg_30_1, arg_30_2, arg_34_0)

			return
		end,
		function(arg_35_0)
			var_0_10(arg_30_0, arg_30_1, arg_30_2, arg_35_0)

			return
		end
	}, arg_30_3)

	return
end

function var_0_0.AdjustModel(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	arg_36_1.pivot = arg_36_3
	arg_36_1.sizeDelta = arg_36_2
	arg_36_1:Find("interaction").pivot = arg_36_3
	arg_36_1:Find("masks").pivot = arg_36_3

	local var_36_0 = arg_36_1:Find("childs")

	var_36_0.anchorMin = arg_36_3
	var_36_0.anchorMax = arg_36_3

	return
end

function var_0_0.FinishWork(arg_37_0, arg_37_1)
	if arg_37_1 then
		arg_37_0.rollBacks = {}
	else
		arg_37_0:RollBackLoaded()
	end

	arg_37_0.state = var_0_1

	if arg_37_0.callback then
		arg_37_0.callback()
	end

	arg_37_0.module = nil

	return
end

function var_0_0.RollBackLoaded(arg_38_0)
	for iter_38_0 = #arg_38_0.rollBacks, 1, -1 do
		if not IsNil(arg_38_0.rollBacks[iter_38_0]) then
			Object.Destroy(arg_38_0.rollBacks[iter_38_0])
		end
	end

	arg_38_0.rollBacks = {}

	return
end

function var_0_0.Stop(arg_39_0)
	arg_39_0.state = var_0_3
	arg_39_0.callback = nil

	return
end

function var_0_0.OnStop(arg_40_0)
	if arg_40_0.state ~= var_0_3 then
		arg_40_0:FinishWork(false)
	end

	return
end

function var_0_0.IsStop(arg_41_0)
	local var_41_0

	if arg_41_0.state ~= var_0_3 then
		var_41_0 = arg_41_0.module and arg_41_0.module:IsExit()

		if false then
			var_41_0 = false
		end
	else
		var_41_0 = true
	end

	return var_41_0
end

return var_0_0
