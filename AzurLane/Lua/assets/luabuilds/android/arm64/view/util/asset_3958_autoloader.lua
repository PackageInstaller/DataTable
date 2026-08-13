class = var_0_10000

local var_0_0 = var_0_10000("AutoLoader")
local var_0_1 = false
local var_0_2 = false

import = var_0_10003

local var_0_3 = var_0_10003("view.util.RequestPackages.LoadPrefabRequestPackage")

import = var_0_10004

local var_0_4 = var_0_10004("view.util.RequestPackages.LoadReferenceRequestPackage")

import = var_5

local var_0_5 = var_5("view.util.RequestPackages.LoadLive2dRequestPackage")

import = var_6

local var_0_6 = var_6("view.util.RequestPackages.LoadBundleRequesetPackage")

import = var_7

local var_0_7 = var_7("view.util.RequestPackages.GetSpineRequestPackage")

import = var_8

local var_0_8 = var_8("view.util.RequestPackages.GetPrefabRequestPackage")

import = var_9

local var_0_9 = var_9("view.util.RequestPackages.GetSpriteRequestPackage")

import = var_10

local var_0_10 = var_10("view.util.RequestPackages.ReturnPrefabRequestPackage")

import = var_11

local var_0_11 = var_11("view.util.RequestPackages.ReturnSpineRequestPackage")

import = var_12

local var_0_12 = var_12("view.util.RequestPackages.UnloadBundleRequesetPackage")

import = var_13

local var_0_13 = var_13("view.util.RequestPackages.DestroyAtlasPoolRequestPackage")

bit = var_14
var_0_0.PartLoading = var_14.lshift(1, 0)
bit = var_14
var_0_0.PartLoaded = var_14.lshift(1, 1)

function var_0_0.Ctor(arg_1_0)
	arg_1_0._loadingRequest = {}
	arg_1_0._returnRequest = {}
	arg_1_0._instKeyDict = {}
	arg_1_0._keyInstDict = {}
	arg_1_0._groupDict = {}

	return
end

function var_0_0.GenerateUID4LoadingRequest(arg_2_0)
	local var_2_0

	if not arg_2_0._uidCounter then
		var_2_0 = 0
	end

	arg_2_0._uidCounter = var_2_0 + 1
	assert = var_1

	var_1(arg_2_0._uidCounter ~= 0, "Error on Generating UID Too much times")

	return arg_2_0._uidCounter
end

function var_0_0.GetPrefab(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_2 = arg_3_2 or ""

	arg_3_0:ClearRequest(arg_3_4)

	arg_3_4 = arg_3_4 or arg_3_0:GenerateUID4LoadingRequest()

	local var_3_0
	local var_3_1 = var_0_8.New(arg_3_1, arg_3_2, function(arg_4_0)
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
		warning = var_6

		var_6("AutoLoader Loading Path: " .. arg_3_1 .. " Name: " .. arg_3_2 .. " ;")
	end

	arg_3_0._loadingRequest[arg_3_4] = var_3_1

	var_3_1:Start()

	return arg_3_4
end

function var_0_0.GetPrefabBYStopLoading(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_2 = arg_5_2 or ""

	arg_5_0:ClearRequest(arg_5_4, var_0_0.PartLoading)

	arg_5_4 = arg_5_4 or arg_5_0:GenerateUID4LoadingRequest()

	local var_5_0
	local var_5_1 = var_0_8.New(arg_5_1, arg_5_2, function(arg_6_0)
		arg_5_0._loadingRequest[arg_5_4] = nil

		local var_6_0 = arg_5_0

		var_1.ClearRequest(var_6_0, arg_5_4, var_0_0.PartLoaded)

		arg_5_0._instKeyDict[arg_6_0] = arg_5_4
		arg_5_0._keyInstDict[arg_5_4] = arg_6_0
		arg_5_0._returnRequest[arg_5_4] = var_0_10.New(arg_5_1, arg_5_2, arg_6_0)

		if arg_5_3 then
			arg_5_3(arg_6_0)
		end

		return
	end)

	if var_0_1 then
		warning = var_6

		var_6("AutoLoader Loading Path: " .. arg_5_1 .. " Name: " .. arg_5_2 .. " ;")
	end

	arg_5_0._loadingRequest[arg_5_4] = var_5_1

	var_5_1:Start()

	return arg_5_4
end

function var_0_0.GetPrefabBYGroup(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_0:GetPrefab(arg_7_1, arg_7_2, arg_7_3)

	arg_7_0._groupDict[var_7_0] = arg_7_4

	return var_7_0
end

function var_0_0.ReturnPrefab(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.ClearRequest
	local var_8_2 = arg_8_0._instKeyDict

	go = var_1_10006

	var_8_1(var_8_0, var_8_2[var_1_10006(arg_8_1)])

	return
end

function var_0_0.ReturnGroup(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0._groupDict) do
		if iter_9_1 == arg_9_1 then
			arg_9_0:ClearRequest(iter_9_0)
		end
	end

	return
end

function var_0_0.GetSpine(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	noEmptyStr = var_1_10004

	if not var_1_10004(arg_10_1) then
		return
	end

	arg_10_1 = arg_10_1 or ""

	arg_10_0:ClearRequest(arg_10_3)

	arg_10_3 = arg_10_3 or arg_10_0:GenerateUID4LoadingRequest()

	local var_10_0
	local var_10_1 = var_0_7.New(arg_10_1, function(arg_11_0)
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
		warning = var_5

		var_5("AutoLoader Loading Spine: " .. arg_10_1 .. " ;")
	end

	arg_10_0._loadingRequest[arg_10_3] = var_10_1

	var_10_1:Start()

	return arg_10_3
end

function var_0_0.ReturnSpine(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.ClearRequest
	local var_12_2 = arg_12_0._instKeyDict

	go = var_1_10006

	var_12_1(var_12_0, var_12_2[var_1_10006(arg_12_1)])

	return
end

function var_0_0.GetSprite(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_3
	local var_13_1 = arg_13_3.GetComponent

	typeof = var_1_10008
	Image = var_1_10010
	var_13_1(var_13_0, var_1_10008(var_1_10010)).enabled = false

	return arg_13_0:GetSpriteQuiet(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
end

function var_0_0.GetSpriteQuiet(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_2 = arg_14_2 or ""
	tf = var_1_10005

	local var_14_0 = var_1_10005(arg_14_3)

	arg_14_0:GetSpriteDirect(arg_14_1, arg_14_2, function(arg_15_0)
		local var_15_0 = arg_14_3
		local var_15_1 = var_1.GetComponent

		typeof = var_2_10004
		Image = var_2_10006

		local var_15_2 = var_15_1(var_15_0, var_2_10004(var_2_10006))

		var_15_2.enabled = true
		var_15_2.sprite = arg_15_0

		if arg_14_4 then
			var_15_2:SetNativeSize()
		end

		return
	end, var_14_0)

	return var_14_0
end

function var_0_0.GetSpriteDirect(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	arg_16_0:ClearRequest(arg_16_4)

	arg_16_4 = arg_16_4 or arg_16_0:GenerateUID4LoadingRequest()

	local var_16_0
	local var_16_1 = var_0_9.New(arg_16_1, arg_16_2, function(arg_17_0)
		arg_16_0._loadingRequest[arg_16_4] = nil

		if arg_16_3 then
			arg_16_3(arg_17_0)
		end

		return
	end)

	if var_0_1 then
		warning = var_6

		var_6("AutoLoader Loading Atlas: " .. arg_16_1 .. " Name: " .. arg_16_2 .. " ;")
	end

	arg_16_0._loadingRequest[arg_16_4] = var_16_1

	var_16_1:Start()

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

	local var_19_0
	local var_19_1 = var_0_3.New(arg_19_1, arg_19_2, function(arg_20_0)
		arg_19_0._loadingRequest[arg_19_4] = nil

		if arg_19_3 then
			arg_19_3(arg_20_0)
		end

		return
	end)

	if var_0_1 then
		warning = var_6

		var_6("AutoLoader Loading Once Path: " .. arg_19_1 .. " Name: " .. arg_19_2 .. " ;")
	end

	arg_19_0._loadingRequest[arg_19_4] = var_19_1

	var_19_1:Start()

	return arg_19_4
end

function var_0_0.LoadLive2D(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0

	HXSet = var_1_10005

	local var_21_1, var_21_2 = var_1_10005.autoHxShift("live2d/", arg_21_1)

	arg_21_1 = var_21_2

	local var_21_3 = var_21_1 .. arg_21_1

	arg_21_0:ClearRequest(arg_21_3)

	arg_21_3 = arg_21_3 or arg_21_0:GenerateUID4LoadingRequest()

	local var_21_4
	local var_21_5 = var_0_5.New(var_21_3, "", function(arg_22_0)
		arg_21_0._loadingRequest[arg_21_3] = nil

		if arg_21_2 then
			arg_21_2(arg_22_0)
		end

		return
	end)

	if var_0_1 then
		warning = var_6

		var_6("AutoLoader Loading Live2D Once Path: " .. var_21_3 .. " Name: " .. arg_21_1 .. " ;")
	end

	arg_21_0._loadingRequest[arg_21_3] = var_21_5

	var_21_5:Start()

	return arg_21_3
end

function var_0_0.LoadSprite(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_3
	local var_23_1 = arg_23_3.GetComponent

	typeof = var_1_10008
	Image = var_1_10010

	local var_23_2 = var_23_1(var_23_0, var_1_10008(var_1_10010))

	var_23_2.enabled = false
	arg_23_2 = arg_23_2 or ""
	tf = var_6

	local var_23_3 = var_6(arg_23_3)

	arg_23_0:ClearRequest(var_23_3)

	local var_23_4
	local var_23_5 = var_0_4.New
	local var_23_6 = arg_23_1
	local var_23_7 = arg_23_2

	typeof = var_1_10012
	Sprite = var_1_10014

	local var_23_8 = var_23_5(var_23_6, var_23_7, var_1_10012(var_1_10014), function(arg_24_0)
		arg_23_0._loadingRequest[var_23_3] = nil
		var_23_2.enabled = true
		var_23_2.sprite = arg_24_0

		if arg_23_4 then
			local var_24_0 = var_23_2

			var_1.SetNativeSize(var_24_0)
		end

		return
	end)

	if var_0_1 then
		warning = var_8

		var_8("AutoLoader Loading Once Path: " .. arg_23_1 .. " Name: " .. arg_23_2 .. " ;")
	end

	arg_23_0._loadingRequest[var_23_3] = var_23_8

	var_23_8:Start()

	return var_23_3
end

function var_0_0.LoadReference(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	arg_25_2 = arg_25_2 or ""

	arg_25_0:ClearRequest(arg_25_5)

	arg_25_5 = arg_25_5 or arg_25_0:GenerateUID4LoadingRequest()

	local var_25_0
	local var_25_1 = var_0_4.New(arg_25_1, arg_25_2, arg_25_3, function(arg_26_0)
		arg_25_0._loadingRequest[arg_25_5] = nil

		if arg_25_4 then
			arg_25_4(arg_26_0)
		end

		return
	end)

	if var_0_1 then
		warning = var_7

		var_7("AutoLoader Loading Once Path: " .. arg_25_1 .. " Name: " .. arg_25_2 .. " ;")
	end

	arg_25_0._loadingRequest[arg_25_5] = var_25_1

	var_25_1:Start()

	return arg_25_5
end

function var_0_0.DestroyAtlas(arg_27_0, arg_27_1)
	arg_27_0:ClearRequest(arg_27_1)

	return
end

function var_0_0.LoadBundle(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:GenerateUID4LoadingRequest()
	local var_28_1
	local var_28_2 = var_0_6.New(arg_28_1, function(arg_29_0)
		arg_28_0._loadingRequest[var_28_0] = nil

		local var_29_0 = arg_28_0._returnRequest

		var_29_0[var_28_0] = var_0_12.New(arg_28_1)
		existCall = var_29_0

		var_29_0(arg_28_2, arg_29_0)

		return
	end)

	if var_0_1 then
		warning = var_5

		var_5("AutoLoader Loading Bundle: " .. arg_28_1 .. " ;")
	end

	arg_28_0._loadingRequest[var_28_0] = var_28_2

	var_28_2:Start()

	return var_28_0
end

function var_0_0.GetRequestPackage(arg_30_0, arg_30_1, arg_30_2)
	arg_30_2 = arg_30_2 or var_0_0.PartLoading + var_0_0.PartLoaded
	bit = var_1_10003

	local var_30_0

	if not (var_1_10003.band(arg_30_2, var_0_0.PartLoading) > 0) or not arg_30_0._loadingRequest[arg_30_1] then
		bit = var_30_0

		if not (var_30_0.band(arg_30_2, var_0_0.PartLoaded) > 0) or not arg_30_0._returnRequest[arg_30_1] then
			var_30_0 = nil
		end
	end

	return var_30_0
end

function var_0_0.GetLoadingRP(arg_31_0, arg_31_1)
	return arg_31_0._loadingRequest[arg_31_1]
end

function var_0_0.ClearRequest(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_2 then
		bit = var_1_10003
		var_1_10003 = var_1_10003.band(arg_32_2, var_0_0.PartLoading)

		if 0 < var_1_10003 then
			if arg_32_0._loadingRequest[arg_32_1] then
				if var_0_2 then
					var_1_10003 = arg_32_0._loadingRequest[arg_32_1]
					warning = var_1_10004

					var_1_10004("AutoLoader Unload loading Path: " .. var_1_10003.path .. " Name: " .. var_1_10003.name .. " ;")
				end

				local var_32_0 = arg_32_0._loadingRequest[arg_32_1]

				var_1_10003.Stop(var_32_0)

				var_1_10003 = arg_32_0._loadingRequest
				var_1_10003[arg_32_1] = nil
			end
		end

		if arg_32_2 then
			bit = var_1_10003

			local var_32_1 = var_1_10003.band(arg_32_2, var_0_0.PartLoaded)

			if 0 < var_32_1 then
				if arg_32_0._returnRequest[arg_32_1] then
					if var_0_2 then
						local var_32_2 = arg_32_0._returnRequest[arg_32_1]

						isa = var_1_10004

						if var_1_10004(var_32_2, var_0_11) then
							warning = var_4

							var_4("AutoLoader Unload Spine: " .. var_32_2.name .. " ;")
						else
							isa = var_4

							if var_4(var_32_2, var_0_13) then
								warning = var_4

								var_4("AutoLoader Unload Atlas: " .. var_32_2.path .. " ;")
							else
								isa = var_4

								if var_4(var_32_2, var_0_12) then
									warning = var_4

									var_4("AutoLoader Unload Bundle: " .. var_32_2.path .. " ;")
								else
									isa = var_4

									if var_4(var_32_2, var_0_10) then
										warning = var_4

										var_4("AutoLoader Unload Path: " .. var_32_2.path .. " Name: " .. var_32_2.name .. " ;")
									else
										warning = var_4

										local var_32_3 = "Not Handle "
										local var_32_4 = var_32_2.__cname
										local var_32_5 = " "
										local var_32_6

										if not var_32_2.name then
											var_32_6 = "NIL"
										end

										var_4(var_32_3 .. var_32_4 .. var_32_5 .. var_32_6)
									end
								end
							end
						end
					end

					local var_32_7 = arg_32_0._returnRequest[arg_32_1]

					var_3.Start(var_32_7)

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
	end
end

function var_0_0.ClearLoadingRequests(arg_33_0)
	pairs = var_1_10001

	for iter_33_0 in var_1_10001(arg_33_0._loadingRequest) do
		arg_33_0:ClearRequest(iter_33_0)
	end

	table = var_1

	var_1.clear(arg_33_0._loadingRequest)

	return
end

function var_0_0.ClearLoadedRequests(arg_34_0)
	pairs = var_1_10001

	for iter_34_0 in var_1_10001(arg_34_0._returnRequest) do
		arg_34_0:ClearRequest(iter_34_0)
	end

	table = var_1

	var_1.clear(arg_34_0._returnRequest)

	return
end

function var_0_0.ClearRequests(arg_35_0)
	arg_35_0:ClearLoadingRequests()
	arg_35_0:ClearLoadedRequests()

	table = var_1

	var_1.clear(arg_35_0._instKeyDict)

	table = var_1

	var_1.clear(arg_35_0._keyInstDict)

	return
end

function var_0_0.RegisterLoaded(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0._instKeyDict[arg_36_2] = arg_36_1
	arg_36_0._keyInstDict[arg_36_1] = arg_36_2

	local var_36_0 = {
		Start = function()
			Destroy = var_2_10000

			var_2_10000(arg_36_2)

			return
		end
	}

	arg_36_0._returnRequest[arg_36_1] = var_36_0

	return
end

function var_0_0.Clear(arg_38_0)
	arg_38_0:ClearRequests()

	return
end

return var_0_0
