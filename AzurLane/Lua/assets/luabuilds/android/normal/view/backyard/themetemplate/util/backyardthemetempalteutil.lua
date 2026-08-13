class = var_0_10000

local var_0_0 = var_0_10000("BackYardThemeTempalteUtil")
local var_0_1 = false
local var_0_2 = true
local var_0_3 = 1920
local var_0_4 = 1080

var_0_0.TakeScale = 0.86
var_0_0.HideGos = {}
var_0_0.ScaleGos = {}
var_0_0.loader = {}

local var_0_5 = 7

var_0_0.caches = {}

local function var_0_6(...)
	if var_0_1 then
		print = var_0

		var_0(...)
	end

	return
end

local function var_0_7()
	Application = var_1_10000

	return var_1_10000.persistentDataPath .. "/screen_scratch"
end

local function var_0_8(arg_3_0)
	Application = var_1_10001

	return var_1_10001.persistentDataPath .. "/screen_scratch/" .. arg_3_0 .. ".png"
end

local function var_0_9(arg_4_0)
	return arg_4_0 .. ".png"
end

local function var_0_10(arg_5_0)
	PathMgr = var_1_10001

	if var_1_10001.FileExists(arg_5_0) then
		HashUtil = var_1

		return var_1.HashFile(arg_5_0)
	else
		return ""
	end

	return
end

local function var_0_11(arg_6_0, arg_6_1, arg_6_2)
	if not var_0_0.FileExists(arg_6_0) then
		arg_6_2()

		return
	end

	local var_6_0 = var_0_8(arg_6_0)
	local var_6_1 = var_0_9(arg_6_0)

	pg = var_5

	local var_6_2 = var_5.OSSMgr.GetInstance()

	var_5.GetTexture2D(var_6_2, var_6_1, var_6_0, false, var_0_3, var_0_4, function(arg_7_0, arg_7_1)
		if arg_7_0 and arg_7_1 then
			arg_6_2(arg_7_1)
		else
			arg_6_2()
		end

		return
	end)

	return
end

local function var_0_12(arg_8_0, arg_8_1, arg_8_2)
	if not var_0_2 then
		arg_8_2()

		return
	end

	local var_8_0 = var_0_8(arg_8_0)
	local var_8_1 = var_0_9(arg_8_0)

	pg = var_5

	local var_8_2 = var_5.OSSMgr.GetInstance()

	var_5.GetTexture2D(var_8_2, var_8_1, var_8_0, true, var_0_3, var_0_4, function(arg_9_0, arg_9_1)
		if arg_9_0 and arg_9_1 and arg_8_1 == var_0_10(var_8_0) then
			arg_8_2(arg_9_1)
		else
			arg_8_2()
		end

		return
	end)

	return
end

local function var_0_13(arg_10_0, arg_10_1)
	if not var_0_2 then
		arg_10_1()

		return
	end

	local var_10_0 = var_0_8(arg_10_0)
	local var_10_1 = var_0_9(arg_10_0)

	pg = var_4

	local var_10_2 = var_4.OSSMgr.GetInstance()

	var_4.DeleteObject(var_10_2, var_10_1, arg_10_1)

	return
end

local function var_0_14(arg_11_0, arg_11_1)
	if not var_0_2 then
		arg_11_1()

		return
	end

	local var_11_0 = var_0_8(arg_11_0)
	local var_11_1 = var_0_9(arg_11_0)

	pg = var_4

	local var_11_2 = var_4.OSSMgr.GetInstance()

	var_4.AsynUpdateLoad(var_11_2, var_11_1, var_11_0, arg_11_1)

	return
end

function var_0_0.FileExists(arg_12_0)
	local var_12_0 = var_0_8(arg_12_0)

	PathMgr = var_2

	return var_2.FileExists(var_12_0)
end

function var_0_0.TakePreview(arg_13_0, arg_13_1)
	var_0_0.TakePhoto(arg_13_0, arg_13_1)

	return
end

function var_0_0.TakeIcon(arg_14_0, arg_14_1)
	local var_14_0 = 426
	local var_14_1 = 320

	var_0_0.TakePhoto(arg_14_0, function(arg_15_0)
		if arg_15_0.width < var_14_0 or arg_15_0.height < var_14_1 then
			arg_14_1(arg_15_0)

			return
		end

		local var_15_0 = arg_15_0.width * 0.5 - var_14_0 * 0.5
		local var_15_1 = arg_15_0.height * 0.5 - var_14_1 * 0.5
		local var_15_2 = arg_15_0
		local var_15_3 = arg_15_0.GetPixels(var_15_2, var_15_0, var_15_1, var_14_0, var_14_1)

		UnityEngine = var_15_2

		local var_15_4 = var_15_2.Texture2D.New(var_14_0, var_14_1)

		var_4.SetPixels(var_15_4, var_15_3)
		var_4:Apply()
		arg_14_1(var_4)

		return
	end)

	return
end

function var_0_0.TakePhoto(arg_16_0, arg_16_1)
	BLHX = var_1_10002

	var_1_10002.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(arg_16_0, arg_16_1)

	return
end

function var_0_0.SavePhoto(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_18_0)
			local var_18_0 = var_0_8(arg_17_0 .. "_icon")

			ScreenShooter = var_2

			var_2.SaveTextureToLocal(var_18_0, arg_17_2, true)
			arg_18_0()

			return
		end,
		function(arg_19_0)
			onNextTick = var_2_10001

			var_2_10001(arg_19_0)

			return
		end,
		function(arg_20_0)
			local var_20_0 = var_0_8(arg_17_0)

			ScreenShooter = var_2

			var_2.SaveTextureToLocal(var_20_0, arg_17_1, true)
			arg_20_0()

			return
		end
	}, function()
		if arg_17_3 then
			arg_17_3()
		end

		return
	end)

	return
end

local function var_0_15(arg_22_0)
	_ = var_1_10001

	return var_1_10001.detect(var_0_0.caches, function(arg_23_0)
		return arg_23_0.name == arg_22_0
	end)
end

local function var_0_16(arg_24_0, arg_24_1, arg_24_2)
	local function var_24_0(arg_25_0)
		if arg_25_0 then
			var_0_0.CheckCache()

			table = var_1

			var_1.insert(var_0_0.caches, {
				name = arg_24_0,
				asset = arg_25_0
			})
		end

		arg_24_2(arg_25_0)

		return
	end

	if not arg_24_1 or arg_24_1 == "" then
		var_24_0(nil)
	elseif var_0_0.FileExists(arg_24_0) and arg_24_1 == var_0_10(var_0_8(arg_24_0)) then
		var_0_11(arg_24_0, arg_24_1, var_24_0)
	else
		var_0_12(arg_24_0, arg_24_1, var_24_0)
	end

	return
end

function var_0_0.GetTexture(arg_26_0, arg_26_1, arg_26_2)
	if var_0_15(arg_26_0) then
		arg_26_2(var_3.asset)

		return
	end

	var_0_16(arg_26_0, arg_26_1, arg_26_2)

	return
end

function var_0_0.GetNonCacheTexture(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_1 or arg_27_1 == "" then
		arg_27_2(nil)
	elseif var_0_0.FileExists(arg_27_0) and arg_27_1 == var_0_10(var_0_8(arg_27_0)) then
		var_0_11(arg_27_0, arg_27_1, arg_27_2)
	else
		var_0_12(arg_27_0, arg_27_1, arg_27_2)
	end

	return
end

function var_0_0.UploadTexture(arg_28_0, arg_28_1)
	var_0_14(arg_28_0, arg_28_1)

	return
end

function var_0_0.DeleteTexture(arg_29_0, arg_29_1)
	var_0_13(arg_29_0, arg_29_1)

	return
end

function var_0_0.GetMd5(arg_30_0)
	local var_30_0 = var_0_8(arg_30_0)

	return var_0_10(var_30_0)
end

function var_0_0.GetIconMd5(arg_31_0)
	local var_31_0 = arg_31_0 .. "_icon"

	return var_0_0.GetMd5(var_31_0)
end

function var_0_0.CheckCache()
	if #var_0_0.caches >= var_0_5 then
		var_0_0.ClearCache(1)

		gcAll = var_0

		var_0(false)
	end

	return
end

function var_0_0.CheckSaveDirectory()
	local var_33_0 = var_0_7()

	System = var_1_10001

	if not var_1_10001.IO.Directory.Exists(var_33_0) then
		System = var_1

		var_1.IO.Directory.CreateDirectory(var_33_0)
	end

	return
end

function var_0_0.ClearCaches(arg_34_0)
	if not var_0_0.caches or #var_0_0.caches == 0 then
		return
	end

	ipairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0) do
		for iter_34_2 = #var_0_0.caches, 1, -1 do
			if var_0_0.caches[iter_34_2].name == iter_34_1 then
				local var_34_0 = var_0_0.ClearCache
				local var_34_1 = iter_34_2

				destroy = var_1_10013

				var_34_0(var_34_1, var_1_10013)
			end
		end
	end

	return
end

function var_0_0.ClearCache(arg_35_0, arg_35_1)
	table = var_1_10002

	local var_35_0 = var_1_10002.remove(var_0_0.caches, arg_35_0)

	if arg_35_1 then
		IsNil = var_3

		if not var_3(var_35_0.asset) then
			Object = var_3

			var_3.Destroy(var_35_0.asset)
		end
	end

	return
end

function var_0_0.ClearAllCacheAsyn()
	pairs = var_1_10000

	for iter_36_0, iter_36_1 in var_1_10000(var_0_0.caches) do
		IsNil = var_1_10005

		if not var_1_10005(iter_36_1.asset) then
			Object = var_1_10005

			var_1_10005.Destroy(iter_36_1.asset)
		end
	end

	local var_36_0 = var_0_0

	var_36_0.caches = {}
	gcAll = var_36_0

	var_36_0(false)

	return
end

function var_0_0.ClearAllCache()
	var_0_0.loader = {}

	var_0_0.ClearAllCacheAsyn()

	return
end

return var_0_0
