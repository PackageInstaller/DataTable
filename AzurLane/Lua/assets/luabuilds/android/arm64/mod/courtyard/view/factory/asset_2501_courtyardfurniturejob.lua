class = var_0_10000

local var_0_0 = var_0_10000("CourtYardFurnitureJob")
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
	Object = var_1_10003

	local var_3_0 = var_1_10003.Instantiate(arg_3_1, arg_3_2)

	table = var_1_10004

	var_1_10004.insert(arg_3_0.rollBacks, var_3_0)

	return var_3_0
end

function var_0_0.CloneTplTo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	Object = var_1_10004

	local var_4_0 = var_1_10004.Instantiate(arg_4_1, arg_4_2).transform

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

	local function var_5_1()
		local var_6_0 = arg_5_1

		if var_0.IsExit(var_6_0) then
			local var_6_1 = arg_5_0

			var_0.FinishWork(var_6_1, false)
		else
			local var_6_2 = arg_5_1

			var_0.Init(var_6_2, var_5_0)

			local var_6_3 = arg_5_0

			var_0.FinishWork(var_6_3, true)
		end

		return
	end

	local function var_5_2()
		local var_7_0 = arg_5_1

		var_0.OnIconLoaed(var_7_0)

		return
	end

	arg_5_0.rollBacks = {}

	if arg_5_2:IsSpine() then
		arg_5_0:LoadSpine(var_5_0, arg_5_2, var_5_1, var_5_2)
	else
		arg_5_0:Load(var_5_0, arg_5_2, var_5_1, var_5_2)
	end

	return
end

local function var_0_4(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	ResourceMgr = var_1_10004

	local var_8_0 = var_1_10004.Inst
	local var_8_1 = var_4.getAssetAsync
	local var_8_2 = "furnitrues/"
	local var_8_3 = arg_8_2
	local var_8_4 = var_8_2 .. arg_8_2.GetPicture(var_8_3)
	local var_8_5 = ""

	typeof = var_1_10009
	GameObject = var_1_10011

	local var_8_6 = var_1_10009(var_1_10011)

	UnityEngine = var_8_3

	var_8_1(var_8_0, var_8_4, var_8_5, var_8_6, var_8_3.Events.UnityAction_UnityEngine_Object(function(arg_9_0)
		local var_9_0 = arg_8_0

		if not var_1.IsStop(var_9_0) then
			IsNil = var_1

			if not var_1(arg_8_1) then
				IsNil = var_1

				if var_1(arg_9_0) then
					local var_9_1 = arg_8_0

					var_1.OnStop(var_9_1)

					return
				end

				local var_9_2 = arg_8_0
				local var_9_3 = var_1.InstantiateObj(var_9_2, arg_9_0, arg_8_1).transform

				var_9_3.name = "icon"

				var_9_3:SetSiblingIndex(1)

				var_9_3.anchorMin = var_9_3.pivot
				var_9_3.anchorMax = var_9_3.pivot

				local var_9_4 = arg_8_0

				var_2.AdjustModel(var_9_4, arg_8_1, var_9_3.sizeDelta, var_9_3.pivot)
				arg_8_3()

				return
			end
		end
	end), true, true)

	return
end

local function var_0_5(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2
	local var_10_1 = arg_10_2.GetMaskNames(var_10_0)
	local var_10_2 = {}

	pairs = var_10_0

	for iter_10_0, iter_10_1 in var_10_0(var_10_1) do
		table = var_1_10011

		var_1_10011.insert(var_10_2, function(arg_11_0)
			ResourceMgr = var_2_10001

			local var_11_0 = var_2_10001.Inst
			local var_11_1 = var_1.getAssetAsync
			local var_11_2 = "furnitrues/" .. iter_10_1
			local var_11_3 = ""

			typeof = var_2_10006
			GameObject = var_2_10008

			local var_11_4 = var_2_10006(var_2_10008)

			UnityEngine = var_2_10007

			var_11_1(var_11_0, var_11_2, var_11_3, var_11_4, var_2_10007.Events.UnityAction_UnityEngine_Object(function(arg_12_0)
				local var_12_0 = arg_10_0

				if not var_1.IsStop(var_12_0) then
					IsNil = var_1

					if not var_1(arg_10_1) then
						IsNil = var_1

						if var_1(arg_12_0) then
							local var_12_1 = arg_10_0

							var_1.OnStop(var_12_1)

							return
						end

						local var_12_2 = arg_10_0
						local var_12_3 = var_1.InstantiateObj
						local var_12_4 = arg_12_0
						local var_12_5 = arg_10_1
						local var_12_6 = var_12_3(var_12_2, var_12_4, var_5.Find(var_12_5, "masks"))

						var_12_6.name = "icon_front_" .. iter_10_0
						var_12_6.transform.anchorMin = var_12_6.transform.pivot
						var_12_6.transform.anchorMax = var_12_6.transform.pivot

						local var_12_7 = var_12_6.transform

						var_2.SetSiblingIndex(var_12_7, 2)

						setActive = var_2

						var_2(var_12_6, false)
						arg_11_0()

						return
					end
				end
			end), true, true)

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_10_2, arg_10_3)

	return
end

local function var_0_6(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_2
	local var_13_1 = arg_13_2.GetBodyMasks(var_13_0)
	local var_13_2 = arg_13_0.poolMgr.root
	local var_13_3 = var_5.Find(var_13_2, "mask")

	pairs = var_13_0

	for iter_13_0, iter_13_1 in var_13_0(var_13_1) do
		local var_13_4 = arg_13_0:CloneTplTo(var_13_3, arg_13_1:Find("interaction"), "body_mask" .. iter_13_0)

		var_13_4.anchoredPosition = iter_13_1.offset
		var_13_4.sizeDelta = iter_13_1.size

		if iter_13_1.img then
			ResourceMgr = var_12

			local var_13_5 = var_12.Inst
			local var_13_6 = var_12.getAssetSync(var_13_5, "furnitrues/" .. iter_13_1.img, "", true, true)
			local var_13_7 = var_13_4
			local var_13_8 = var_13_4.GetComponent

			typeof = var_16
			Image = var_18

			local var_13_9 = var_13_8(var_13_7, var_16(var_18))
			local var_13_10 = var_13_6
			local var_13_11 = var_13_6.GetComponent

			typeof = var_17
			Image = var_1_10019
			var_13_9.sprite = var_13_11(var_13_10, var_17(var_1_10019)).sprite
		end
	end

	arg_13_3()

	return
end

local function var_0_7(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_2
	local var_14_1 = arg_14_2.GetType(var_14_0)

	Furniture = var_1_10005

	if var_14_1 == var_1_10005.TYPE_ARCH then
		local var_14_2 = arg_14_2:GetArchMask()

		checkABExist = var_14_0

		if not var_14_0("furnitrues/" .. var_14_2) then
			arg_14_3()

			return
		end

		ResourceMgr = var_6

		local var_14_3 = var_6.Inst
		local var_14_4 = var_6.getAssetAsync
		local var_14_5 = "furnitrues/" .. var_14_2
		local var_14_6 = ""

		typeof = var_1_10011
		GameObject = var_1_10013

		local var_14_7 = var_1_10011(var_1_10013)

		UnityEngine = var_1_10012

		var_14_4(var_14_3, var_14_5, var_14_6, var_14_7, var_1_10012.Events.UnityAction_UnityEngine_Object(function(arg_15_0)
			local var_15_0 = arg_14_0

			if not var_1.IsStop(var_15_0) then
				IsNil = var_1

				if not var_1(arg_14_1) then
					IsNil = var_1

					if var_1(arg_15_0) then
						local var_15_1 = arg_14_0

						var_1.OnStop(var_15_1)

						return
					end

					local var_15_2 = arg_14_0
					local var_15_3 = var_1.InstantiateObj
					local var_15_4 = arg_15_0
					local var_15_5 = arg_14_1
					local var_15_6 = var_15_3(var_15_2, var_15_4, var_5.Find(var_15_5, "masks"))

					var_15_6.name = "icon_front_arch"
					var_15_6.transform.anchorMin = var_15_6.transform.pivot
					var_15_6.transform.anchorMax = var_15_6.transform.pivot

					arg_14_3()

					return
				end
			end
		end), true, true)
	else
		arg_14_3()
	end

	return
end

local function var_0_8(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_2:GetFirstSlot()
	local var_16_1 = var_4.GetName(var_16_0)

	ResourceMgr = var_1_10005

	local var_16_2 = var_1_10005.Inst
	local var_16_3 = var_5.getAssetAsync
	local var_16_4 = "sfurniture/" .. var_16_1
	local var_16_5 = ""

	typeof = var_1_10010
	GameObject = var_1_10012

	local var_16_6 = var_1_10010(var_1_10012)

	UnityEngine = var_1_10011

	var_16_3(var_16_2, var_16_4, var_16_5, var_16_6, var_1_10011.Events.UnityAction_UnityEngine_Object(function(arg_17_0)
		local var_17_0 = arg_16_0

		if not var_1.IsStop(var_17_0) then
			IsNil = var_1

			if not var_1(arg_16_1) then
				IsNil = var_1

				if var_1(arg_17_0) then
					local var_17_1 = arg_16_0

					var_1.OnStop(var_17_1)

					return
				end

				local var_17_2 = arg_16_0
				local var_17_3 = var_1.InstantiateObj(var_17_2, arg_17_0, arg_16_1)
				local var_17_4 = arg_16_0

				var_2.AdjustModel(var_17_4, arg_16_1, var_17_3.transform.sizeDelta, var_17_3.transform.pivot)

				var_17_3.name = "spine_icon"

				local var_17_5 = var_17_3.transform

				Vector3 = var_17_2
				var_17_5.localPosition = var_17_2(0, 0, 0)

				local var_17_6 = var_17_3.transform

				var_2.SetSiblingIndex(var_17_6, 1)
				arg_16_3()

				return
			end
		end
	end), true, true)

	return
end

local function var_0_9(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_2
	local var_18_1 = arg_18_2.GetMaskNames(var_18_0)
	local var_18_2 = {}

	ipairs = var_18_0

	for iter_18_0, iter_18_1 in var_18_0(var_18_1) do
		table = var_1_10011

		var_1_10011.insert(var_18_2, function(arg_19_0)
			ResourceMgr = var_2_10001

			local var_19_0 = var_2_10001.Inst
			local var_19_1 = var_1.getAssetAsync
			local var_19_2 = "sfurniture/" .. iter_18_1
			local var_19_3 = ""

			typeof = var_2_10006
			GameObject = var_2_10008

			local var_19_4 = var_2_10006(var_2_10008)

			UnityEngine = var_2_10007

			var_19_1(var_19_0, var_19_2, var_19_3, var_19_4, var_2_10007.Events.UnityAction_UnityEngine_Object(function(arg_20_0)
				local var_20_0 = arg_18_0

				if not var_1.IsStop(var_20_0) then
					IsNil = var_1

					if not var_1(arg_18_1) then
						IsNil = var_1

						if var_1(arg_20_0) then
							local var_20_1 = arg_18_0

							var_1.OnStop(var_20_1)

							return
						end

						local var_20_2 = arg_18_0
						local var_20_3 = var_1.InstantiateObj
						local var_20_4 = arg_20_0
						local var_20_5 = arg_18_1
						local var_20_6 = var_20_3(var_20_2, var_20_4, var_5.Find(var_20_5, "masks"))

						var_20_6.name = "icon_front_" .. iter_18_0

						local var_20_7 = var_20_6.transform

						Vector3 = var_3
						var_20_7.localPosition = var_3(0, 0, 0)
						setActive = var_20_7

						var_20_7(var_20_6, false)
						arg_19_0()

						return
					end
				end
			end), true, true)

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_18_2, arg_18_3)

	return
end

local function var_0_10(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_2

	if arg_21_2.GetAnimatorMask(var_21_0) then
		local var_21_1 = arg_21_0.poolMgr.root
		local var_21_2 = var_5.Find(var_21_1, "mask")

		var_21_0 = arg_21_0:CloneTplTo(var_21_2, arg_21_1:Find("interaction"), "animtor_mask")
		var_21_0.sizeDelta = var_4.size
		setAnchoredPosition = var_7

		var_7(var_21_0, var_4.offset)
	end

	local var_21_3 = {}

	ipairs = var_21_0

	for iter_21_0, iter_21_1 in var_21_0(arg_21_2:GetAnimators()) do
		local var_21_4 = iter_21_1.key
		local var_21_5 = iter_21_1.value

		table = var_1_10013

		var_1_10013.insert(var_21_3, function(arg_22_0)
			ResourceMgr = var_2_10001

			local var_22_0 = var_2_10001.Inst
			local var_22_1 = var_1.getAssetAsync
			local var_22_2 = "sfurniture/" .. var_21_5
			local var_22_3 = ""

			typeof = var_2_10006
			GameObject = var_2_10008

			local var_22_4 = var_2_10006(var_2_10008)

			UnityEngine = var_2_10007

			var_22_1(var_22_0, var_22_2, var_22_3, var_22_4, var_2_10007.Events.UnityAction_UnityEngine_Object(function(arg_23_0)
				local var_23_0 = arg_21_0

				if not var_1.IsStop(var_23_0) then
					IsNil = var_1

					if not var_1(arg_21_1) then
						IsNil = var_1

						if var_1(arg_23_0) then
							local var_23_1 = arg_21_0

							var_1.OnStop(var_23_1)

							return
						end

						local var_23_2 = arg_21_1
						local var_23_3 = var_1.Find(var_23_2, "interaction")
						local var_23_4

						if not var_0 or not var_23_3:Find("animtor_mask") then
							var_23_4 = var_23_3
						end

						local var_23_5 = arg_21_0
						local var_23_6 = var_3.InstantiateObj(var_23_5, arg_23_0, var_23_4)

						var_23_6.name = "Animator" .. var_21_4
						setActive = var_4

						var_4(var_23_6, false)
						arg_22_0()

						return
					end
				end
			end), true, true)

			return
		end)
	end

	parallelAsync = var_6

	var_6(var_21_3, arg_21_3)

	return
end

function var_0_0.Load(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	seriesAsync = var_1_10005

	var_1_10005({
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
	seriesAsync = var_5

	var_5({
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
		local var_38_0 = arg_38_0.rollBacks[iter_38_0]

		IsNil = var_1_10006

		if not var_1_10006(var_38_0) then
			Object = var_1_10006

			var_1_10006.Destroy(var_38_0)
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
	if arg_41_0.state ~= var_0_3 then
		if arg_41_0.module then
			local var_41_0 = arg_41_0.module
			local var_41_1 = var_1.IsExit(var_41_0)
		end

		if false then
			var_41_1 = false
		end
	else
		var_41_1 = true
	end

	return var_41_1
end

return var_0_0
