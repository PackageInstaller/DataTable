local var_0_0 = class("AutoLoader")
local var_0_1 = false
local var_0_2 = false
local var_0_3 = import("view.util.RequestPackages.LoadPrefabRequestPackage")
local var_0_4 = import("view.util.RequestPackages.LoadReferenceRequestPackage")
local var_0_5 = import("view.util.RequestPackages.LoadLive2dRequestPackage")
local var_0_6 = import("view.util.RequestPackages.LoadBundleRequesetPackage")
local var_0_7 = import("view.util.RequestPackages.GetSpineRequestPackage")
local var_0_8 = import("view.util.RequestPackages.GetPrefabRequestPackage")
local var_0_9 = import("view.util.RequestPackages.GetSpriteRequestPackage")
local var_0_10 = import("view.util.RequestPackages.ReturnPrefabRequestPackage")
local var_0_11 = import("view.util.RequestPackages.ReturnSpineRequestPackage")
local var_0_12 = import("view.util.RequestPackages.UnloadBundleRequesetPackage")
local var_0_13 = import("view.util.RequestPackages.DestroyAtlasPoolRequestPackage")

var_0_0.PartLoading = bit.lshift(1, 0)
var_0_0.PartLoaded = bit.lshift(1, 1)

function var_0_0.Ctor(arg_1_0)
	arg_1_0._loadingRequest = {}
	arg_1_0._returnRequest = {}
	arg_1_0._instKeyDict = {}
	arg_1_0._keyInstDict = {}
	arg_1_0._groupDict = {}

	return
end

function var_0_0.GenerateUID4LoadingRequest(arg_2_0)
	local var_2_0 = arg_2_0._uidCounter or 0

	arg_2_0._uidCounter = var_2_0 + 1

	assert(arg_2_0._uidCounter ~= 0, "Error on Generating UID Too much times")

	return arg_2_0._uidCounter
end

function var_0_0.GetPrefab(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_2 = arg_3_2 or ""

	arg_3_0:ClearRequest(arg_3_4)

	arg_3_4 = arg_3_4 or arg_3_0:GenerateUID4LoadingRequest()

	local var_3_0 = var_0_8.New(arg_3_1, arg_3_2, function(arg_4_0)
		arg_3_0._loadingRequest[arg_3_4] = nil
		arg_3_0._instKeyDict[arg_4_0] = arg_3_4
		arg_3_0._keyInstDict[arg_3_4] = arg_4_0
		arg_3_0._returnRequest[arg_3_4] = var_0_10.New(arg_3_1, arg_3_2, arg_4_0)

		if arg_3_3 then
			arg_3_3(arg_4_0)
		end

		return
	end)

	if var_0_1 then
		warning("AutoLoader Loading Path: " .. arg_3_1 .. " Name: " .. arg_3_2 .. " ;")
	end

	arg_3_0._loadingRequest[arg_3_4] = var_3_0

	var_3_0:Start()

	return arg_3_4
end

function var_0_0.GetPrefabBYStopLoading(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_2 = arg_5_2 or ""

	arg_5_0:ClearRequest(arg_5_4, var_0_0.PartLoading)

	arg_5_4 = arg_5_4 or arg_5_0:GenerateUID4LoadingRequest()

	local var_5_0 = var_0_8.New(arg_5_1, arg_5_2, function(arg_6_0)
		arg_5_0._loadingRequest[arg_5_4] = nil

		arg_5_0:ClearRequest(arg_5_4, var_0_0.PartLoaded)

		arg_5_0._instKeyDict[arg_6_0] = arg_5_4
		arg_5_0._keyInstDict[arg_5_4] = arg_6_0
		arg_5_0._returnRequest[arg_5_4] = var_0_10.New(arg_5_1, arg_5_2, arg_6_0)

		if arg_5_3 then
			arg_5_3(arg_6_0)
		end

		return
	end)

	if var_0_1 then
		warning("AutoLoader Loading Path: " .. arg_5_1 .. " Name: " .. arg_5_2 .. " ;")
	end

	arg_5_0._loadingRequest[arg_5_4] = var_5_0

	var_5_0:Start()

	return arg_5_4
end

function var_0_0.GetPrefabBYGroup(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_0:GetPrefab(arg_7_1, arg_7_2, arg_7_3)

	arg_7_0._groupDict[var_7_0] = arg_7_4

	return var_7_0
end

function var_0_0.ReturnPrefab(arg_8_0, arg_8_1)
	arg_8_0:ClearRequest(arg_8_0._instKeyDict[go(arg_8_1)])

	return
end

function var_0_0.ReturnGroup(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._groupDict) do
		if iter_9_1 == arg_9_1 then
			arg_9_0:ClearRequest(iter_9_0)
		end
	end

	return
end

function var_0_0.GetSpine(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not noEmptyStr(arg_10_1) then
		return
	end

	arg_10_1 = arg_10_1 or ""

	arg_10_0:ClearRequest(arg_10_3)

	arg_10_3 = arg_10_3 or arg_10_0:GenerateUID4LoadingRequest()

	local var_10_0 = var_0_7.New(arg_10_1, function(arg_11_0)
		arg_10_0._loadingRequest[arg_10_3] = nil
		arg_10_0._instKeyDict[arg_11_0] = arg_10_3
		arg_10_0._keyInstDict[arg_10_3] = arg_11_0
		arg_10_0._returnRequest[arg_10_3] = var_0_11.New(arg_10_1, arg_11_0)

		if arg_10_2 then
			arg_10_2(arg_11_0)
		end

		return
	end)

	if var_0_1 then
		warning("AutoLoader Loading Spine: " .. arg_10_1 .. " ;")
	end

	arg_10_0._loadingRequest[arg_10_3] = var_10_0

	var_10_0:Start()

	return arg_10_3
end

function var_0_0.ReturnSpine(arg_12_0, arg_12_1)
	arg_12_0:ClearRequest(arg_12_0._instKeyDict[go(arg_12_1)])

	return
end

function var_0_0.GetSprite(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_3:GetComponent(typeof(Image)).enabled = false

	return arg_13_0:GetSpriteQuiet(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
end

function var_0_0.GetSpriteQuiet(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_2 = arg_14_2 or ""

	local var_14_0 = tf(arg_14_3)

	arg_14_0:GetSpriteDirect(arg_14_1, arg_14_2, function(arg_15_0)
		local var_15_0 = arg_14_3:GetComponent(typeof(Image))

		var_15_0.enabled = true
		var_15_0.sprite = arg_15_0

		if arg_14_4 then
			var_15_0:SetNativeSize()
		end

		return
	end, var_14_0)

	return var_14_0
end

function var_0_0.GetSpriteDirect(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	arg_16_0:ClearRequest(arg_16_4)

	arg_16_4 = arg_16_4 or arg_16_0:GenerateUID4LoadingRequest()

	local var_16_0 = var_0_9.New(arg_16_1, arg_16_2, function(arg_17_0)
		arg_16_0._loadingRequest[arg_16_4] = nil

		if arg_16_3 then
			arg_16_3(arg_17_0)
		end

		return
	end)

	if var_0_1 then
		warning("AutoLoader Loading Atlas: " .. arg_16_1 .. " Name: " .. arg_16_2 .. " ;")
	end

	arg_16_0._loadingRequest[arg_16_4] = var_16_0

	var_16_0:Start()

	arg_16_0._returnRequest[arg_16_1] = var_0_13.New(arg_16_1)

	return arg_16_4
end

function var_0_0.GetOffSpriteRequest(arg_18_0, arg_18_1)
	arg_18_0:ClearRequest(arg_18_1)

	return
end

function var_0_0.LoadPrefab(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_2 = arg_19_2 or ""

	arg_19_0:ClearRequest(arg_19_4)

	arg_19_4 = arg_19_4 or arg_19_0:GenerateUID4LoadingRequest()

	local var_19_0 = var_0_3.New(arg_19_1, arg_19_2, function(arg_20_0)
		arg_19_0._loadingRequest[arg_19_4] = nil

		if arg_19_3 then
			arg_19_3(arg_20_0)
		end

		return
	end)

	if var_0_1 then
		warning("AutoLoader Loading Once Path: " .. arg_19_1 .. " Name: " .. arg_19_2 .. " ;")
	end

	arg_19_0._loadingRequest[arg_19_4] = var_19_0

	var_19_0:Start()

	return arg_19_4
end

function var_0_0.LoadLive2D(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_1, var_21_2 = HXSet.autoHxShift("live2d/", arg_21_1)

	arg_21_1 = var_21_2

	local var_21_3 = var_21_1 .. var_21_2

	arg_21_0:ClearRequest(arg_21_3)

	arg_21_3 = arg_21_3 or arg_21_0:GenerateUID4LoadingRequest()

	local var_21_4 = var_0_5.New(var_21_3, "", function(arg_22_0)
		arg_21_0._loadingRequest[arg_21_3] = nil

		if arg_21_2 then
			arg_21_2(arg_22_0)
		end

		return
	end)

	if var_0_1 then
		warning("AutoLoader Loading Live2D Once Path: " .. var_21_3 .. " Name: " .. arg_21_1 .. " ;")
	end

	arg_21_0._loadingRequest[arg_21_3] = var_21_4

	var_21_4:Start()

	return arg_21_3
end

function var_0_0.LoadSprite(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_3:GetComponent(typeof(Image))

	arg_23_3:GetComponent(typeof(Image)).enabled = false
	arg_23_2 = arg_23_2 or ""

	local var_23_1 = tf(arg_23_3)

	arg_23_0:ClearRequest(var_23_1)

	local var_23_2 = var_0_4.New(arg_23_1, arg_23_2, typeof(Sprite), function(arg_24_0)
		arg_23_0._loadingRequest[var_23_1] = nil
		var_23_0.enabled = true
		var_23_0.sprite = arg_24_0

		if arg_23_4 then
			var_23_0:SetNativeSize()
		end

		return
	end)

	if var_0_1 then
		warning("AutoLoader Loading Once Path: " .. arg_23_1 .. " Name: " .. arg_23_2 .. " ;")
	end

	arg_23_0._loadingRequest[var_23_1] = var_23_2

	var_23_2:Start()

	return var_23_1
end

function var_0_0.LoadReference(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	arg_25_2 = arg_25_2 or ""

	arg_25_0:ClearRequest(arg_25_5)

	arg_25_5 = arg_25_5 or arg_25_0:GenerateUID4LoadingRequest()

	local var_25_0 = var_0_4.New(arg_25_1, arg_25_2, arg_25_3, function(arg_26_0)
		arg_25_0._loadingRequest[arg_25_5] = nil

		if arg_25_4 then
			arg_25_4(arg_26_0)
		end

		return
	end)

	if var_0_1 then
		warning("AutoLoader Loading Once Path: " .. arg_25_1 .. " Name: " .. arg_25_2 .. " ;")
	end

	arg_25_0._loadingRequest[arg_25_5] = var_25_0

	var_25_0:Start()

	return arg_25_5
end

function var_0_0.DestroyAtlas(arg_27_0, arg_27_1)
	arg_27_0:ClearRequest(arg_27_1)

	return
end

function var_0_0.LoadBundle(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:GenerateUID4LoadingRequest()
	local var_28_1 = var_0_6.New(arg_28_1, function(arg_29_0)
		arg_28_0._loadingRequest[var_28_0] = nil
		arg_28_0._returnRequest[var_28_0] = var_0_12.New(arg_28_1)

		existCall(arg_28_2, arg_29_0)

		return
	end)

	if var_0_1 then
		warning("AutoLoader Loading Bundle: " .. arg_28_1 .. " ;")
	end

	arg_28_0._loadingRequest[var_28_0] = var_28_1

	var_28_1:Start()

	return var_28_0
end

function var_0_0.GetRequestPackage(arg_30_0, arg_30_1, arg_30_2)
	arg_30_2 = arg_30_2 or var_0_0.PartLoading + var_0_0.PartLoaded

	if bit.band(arg_30_2, var_0_0.PartLoading) > 0 then
		if not arg_30_0._loadingRequest[arg_30_1] then
			if bit.band(arg_30_2, var_0_0.PartLoaded) > 0 then
				return arg_30_0._returnRequest[arg_30_1] or nil
			end
		end
	end
end

function var_0_0.GetLoadingRP(arg_31_0, arg_31_1)
	return arg_31_0._loadingRequest[arg_31_1]
end

function var_0_0.ClearRequest(arg_32_0, arg_32_1, arg_32_2)
	if (not arg_32_2 or bit.band(arg_32_2, var_0_0.PartLoading) > 0) and arg_32_0._loadingRequest[arg_32_1] then
		if var_0_2 then
			warning("AutoLoader Unload loading Path: " .. arg_32_0._loadingRequest[arg_32_1].path .. " Name: " .. arg_32_0._loadingRequest[arg_32_1].name .. " ;")
		end

		arg_32_0._loadingRequest[arg_32_1]:Stop()

		arg_32_0._loadingRequest[arg_32_1] = nil
	end

	if not arg_32_2 or bit.band(arg_32_2, var_0_0.PartLoaded) > 0 then
		if arg_32_0._returnRequest[arg_32_1] then
			if var_0_2 then
				if isa(arg_32_0._returnRequest[arg_32_1], var_0_11) then
					warning("AutoLoader Unload Spine: " .. arg_32_0._returnRequest[arg_32_1].name .. " ;")
				elseif isa(arg_32_0._returnRequest[arg_32_1], var_0_13) then
					warning("AutoLoader Unload Atlas: " .. arg_32_0._returnRequest[arg_32_1].path .. " ;")
				elseif isa(arg_32_0._returnRequest[arg_32_1], var_0_12) then
					warning("AutoLoader Unload Bundle: " .. arg_32_0._returnRequest[arg_32_1].path .. " ;")
				elseif isa(arg_32_0._returnRequest[arg_32_1], var_0_10) then
					warning("AutoLoader Unload Path: " .. arg_32_0._returnRequest[arg_32_1].path .. " Name: " .. arg_32_0._returnRequest[arg_32_1].name .. " ;")
				else
					local var_32_1 = arg_32_0._returnRequest[arg_32_1].name or "NIL"

					var_32_0("Not Handle " .. arg_32_0._returnRequest[arg_32_1].__cname .. " " .. var_32_1)
				end
			end

			arg_32_0._returnRequest[arg_32_1]:Start()

			arg_32_0._returnRequest[arg_32_1] = nil
		end

		if arg_32_0._keyInstDict[arg_32_1] then
			arg_32_0._instKeyDict[arg_32_0._keyInstDict[arg_32_1]] = nil
			arg_32_0._keyInstDict[arg_32_1] = nil
		end
	end

	if arg_32_1 then
		arg_32_0._groupDict[arg_32_1] = nil
	end

	return
end

function var_0_0.ClearLoadingRequests(arg_33_0)
	for iter_33_0 in pairs(arg_33_0._loadingRequest) do
		arg_33_0:ClearRequest(iter_33_0)
	end

	table.clear(arg_33_0._loadingRequest)

	return
end

function var_0_0.ClearLoadedRequests(arg_34_0)
	for iter_34_0 in pairs(arg_34_0._returnRequest) do
		arg_34_0:ClearRequest(iter_34_0)
	end

	table.clear(arg_34_0._returnRequest)

	return
end

function var_0_0.ClearRequests(arg_35_0)
	arg_35_0:ClearLoadingRequests()
	arg_35_0:ClearLoadedRequests()
	table.clear(arg_35_0._instKeyDict)
	table.clear(arg_35_0._keyInstDict)

	return
end

function var_0_0.RegisterLoaded(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0._instKeyDict[arg_36_2] = arg_36_1
	arg_36_0._keyInstDict[arg_36_1] = arg_36_2
	arg_36_0._returnRequest[arg_36_1] = {
		Start = function()
			Destroy(arg_36_2)

			return
		end
	}

	return
end

function var_0_0.Clear(arg_38_0)
	arg_38_0:ClearRequests()

	return
end

return var_0_0
